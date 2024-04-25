Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6445CC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 00:08:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmY5-0008MS-IM; Wed, 24 Apr 2024 20:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXk-0008Eb-BU
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:53 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXg-0006G5-5r
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:51 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1e50a04c317so2386515ad.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003247; x=1714608047; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EEr/CTx0m18MWffmgDo1fGRGoUzQVxqe+gQYA3aCxoc=;
 b=hCU4L4zzDPERd67/JeMoDYuuqpAyOGk5paakVXB5GyiN4Pf2LYAQLo+zVwgpYPmL2W
 /AZcNc1Gmej1XPW5AdH1nyxbXpqcisjMaG9Ha2hDPSeVnsp0wiuXHf6GRzZlFpqHj1ql
 tidTMb82t+TDAV0xke+vX+TbPvsJ28B390SK3oNAzThEa2F1G684otayXvvfvt8dL+6r
 BcLyVOZLsVOGGeqI+jGq1e4McWKfs9M5/tWjOjlBt9HmHAvzaO+x7DmvOmj2l/pCzy4o
 E/qYtmSFJv6MRHZ3wtJ3maIHL9Su9cBmyT8OhWFq9G7Rd2QQMtcZgI5UrPO6uJzWByZJ
 l8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003247; x=1714608047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EEr/CTx0m18MWffmgDo1fGRGoUzQVxqe+gQYA3aCxoc=;
 b=b4BF3uLN4y0k0OqAn71LCSYu/cU0rMADZkMCNPWoHYwuwUEJUvDxJ7ih/L07qlWC1M
 TRfdxUTiWBOcHeeaUZvVaL9CAQvvR6hfCTx3NYD3xCievWZ4ergzfkikzzggJpds9rK8
 IF/rB/RbjUobmOPQefs72VlKTQ/N82ZathZHDMw5YgYDMHBXlcEKvReaTGddRoK6biz5
 jpVn6YLs8Lsz1oFro29kD2DelLnb+D1sdlSB2U4vLARpydzqTAJmx64KOhFwHoi7TuxG
 Qd/ZBjUa+0SpcbiOz1Jl772V1eOFCpbUgpF6y2v5F4IC7W5yJBLjmVZefA4f/sTEfGy1
 7v+Q==
X-Gm-Message-State: AOJu0Ywsj3Xie/Sm+Ml2dTgoa5uVRdQk4mnZldWowfaaTgGwTJcxTbpx
 xANERSGkm/WmVghTr1hH+VGNBKlykaWHvNM09Jpb+crMv4fJCLqocXdh6bVhdgIwPm0EJKsDWvX
 M
X-Google-Smtp-Source: AGHT+IHyizM6jD3+G7LFzFYDe1GXeGXJIQXUnKsfkEKGGSU10wSsJzCsEdo2qHNhdxMo2GjD3/4k6A==
X-Received: by 2002:a17:902:d481:b0:1e3:e25c:fa5c with SMTP id
 c1-20020a170902d48100b001e3e25cfa5cmr4885437plg.67.1714003246850; 
 Wed, 24 Apr 2024 17:00:46 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001e604438791sm12465715plg.156.2024.04.24.17.00.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:00:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 22/45] target/hppa: Use TCG_COND_TST* in do_unit_zero_cond
Date: Wed, 24 Apr 2024 17:00:00 -0700
Message-Id: <20240425000023.1002026-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
 target/hppa/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 1e772bef4d..de510fddb1 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1004,9 +1004,8 @@ static DisasCond do_unit_zero_cond(unsigned cf, bool d, TCGv_i64 res)
     tmp = tcg_temp_new_i64();
     tcg_gen_subi_i64(tmp, res, ones);
     tcg_gen_andc_i64(tmp, tmp, res);
-    tcg_gen_andi_i64(tmp, tmp, sgns);
 
-    return cond_make_ti(cf & 1 ? TCG_COND_EQ : TCG_COND_NE, tmp, 0);
+    return cond_make_ti(cf & 1 ? TCG_COND_TSTEQ : TCG_COND_TSTNE, tmp, sgns);
 }
 
 static TCGv_i64 get_carry(DisasContext *ctx, bool d,
-- 
2.34.1


