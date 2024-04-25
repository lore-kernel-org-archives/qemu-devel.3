Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2F3C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 00:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmY6-0008NP-EG; Wed, 24 Apr 2024 20:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXn-0008Fs-HW
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:57 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXi-0006GP-0m
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:53 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1e36b7e7dd2so3449915ad.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003248; x=1714608048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5Ih32sRQyB9qudN1/7n1buQ+bIDLJQ7QnMrQwjmCdFg=;
 b=LByFm94gTO3yFQwAES1rc9U7DRTooy5RXqh6JIrmb/oJ08tsjtqozf74PFmEazkcTX
 nyhsAMRds2bBValfgXs78l9XrwdyXdeeNoBGW+ImbY4SMrK5hEbP5cOEGdOJlc5banAG
 /d/saJviGG7i6NjrY84aFRg969qNUgYYu2WG3OnMoyX2FmyhpM203yUWjKEq9Yztt6fs
 pYRfn5QJXvgVbX7e0q6LK2y2paBa5yxicE79Z0Xc9KVP9RXbnC0bprbtyKUPpSQG9GOX
 Ve+8IFhEBhoIrbuTPA+o/wJLPPqAv8T6zu6RAI+i1w4o/hJfXV7/YMEj8GNztvcV7JCq
 haXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003248; x=1714608048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Ih32sRQyB9qudN1/7n1buQ+bIDLJQ7QnMrQwjmCdFg=;
 b=eJgne+AEcO/ZrwGI/682R6BB1pz7xkt63FyAU2TwDHQ8O3nZqNdJGdrQ0b8+Lhmz94
 d/YH68fz9epIWf/XUuralt7E9GuyBsV6zcixMqYpP3sfEscml6euTnvOIhilC0vLyhPZ
 8G5oFdDiBeLkEZXtaxk224XyevG1LC4ZgFC0kM3+nIh/SN/HYmK/RHzQnxnh7+DWTfWx
 8+lzJPPmf95a3O+lJO18S4Dy3uPZ9H6HEfGK4g41MHVrLinPr58OFqxG9ZzJtCP5Is9c
 kJIvRRaISwmIAa323qVceljYPn5ko6aI7gRHFs6lxW7IVEvV+956aL8mcuD4n3s2fPME
 nv8g==
X-Gm-Message-State: AOJu0YxQp9Ye3P8LVYMY/ZVzIsJt2qwbYMVfxHTpIfXPmK+1dx2sY+2r
 jMGoWMHT2PrFuv/moESlGqdUo4hsBi7ZE+xFKhJzuUob6trvBnqyWYcHIXwkEAcpWmPt1zAmQDi
 U
X-Google-Smtp-Source: AGHT+IEM1gacPa076skXo4PVxYkohorBSkHdeQxjDVLQucKOAkzGAi9UTQXz8YIPKz0PfJdvNBY9Pg==
X-Received: by 2002:a17:902:e54d:b0:1e2:6165:8086 with SMTP id
 n13-20020a170902e54d00b001e261658086mr5256569plf.61.1714003247778; 
 Wed, 24 Apr 2024 17:00:47 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001e604438791sm12465715plg.156.2024.04.24.17.00.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:00:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 23/45] target/hppa: Use TCG_COND_TST* in do_unit_addsub
Date: Wed, 24 Apr 2024 17:00:01 -0700
Message-Id: <20240425000023.1002026-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index de510fddb1..38697ddfbd 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1418,8 +1418,8 @@ static void do_unit_addsub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
             tcg_gen_shri_i64(cb, cb, 1);
         }
 
-        tcg_gen_andi_i64(cb, cb, test_cb);
-        cond = cond_make_ti(cf & 1 ? TCG_COND_EQ : TCG_COND_NE, cb, 0);
+        cond = cond_make_ti(cf & 1 ? TCG_COND_TSTEQ : TCG_COND_TSTNE,
+                            cb, test_cb);
     }
 
     if (is_tc) {
-- 
2.34.1


