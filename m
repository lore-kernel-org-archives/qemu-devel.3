Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B13CC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6QQ2-0003eS-KE; Mon, 13 May 2024 03:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPL-0002rY-91
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:39 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPJ-0001O3-13
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:39 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-41ff5e3dc3bso17921055e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715586455; x=1716191255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Snzaxs9GYAdAfilaaEFzVoEJKRW+Fg+Xd5Y1VwkG6O4=;
 b=nPShHEw6cgNL4C5djyZmMiKdOe1SQPyRfBuK75OT4Iz5h8eyr3x1LnJXnkRgLumnj8
 1fVgDoNyfUs90G2wcgMxS7tqHX/Shd7fkzeTAl4FeqI8r3syHq++Og3bbjTaoKjGXqdu
 cHVdGfag+ItgsuNAEXBRsREEwV/7t+4PHpTRQs6DqNXqrW+ICbiEcyBkwB4tg3dJcvIP
 Vu9clJq8tyZfE/p6pprSxnF58x5VfGEKxdjSelEYQfeZDDRtMnfdlsMNloHzIG5JpF6Z
 Gaw+cnstXCBB6vkHGzQ0hkyMsd3zz5ozsiFNUd/YBb6+vE404ZhxXFoQx36fqmo4gcjx
 ObwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715586455; x=1716191255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Snzaxs9GYAdAfilaaEFzVoEJKRW+Fg+Xd5Y1VwkG6O4=;
 b=InFAk7vW3n9bjsYtzHY+GY2ArkA+XqrQHh7XdOMetWJexTzXXHK3B0MkzU5yLW/t9b
 rPhqdanYFAFa7RbqVgQyfQVbB2PKkarnT8b2+x3wdarIFl119MKdtuI+RFFnr23mTwYJ
 TQVgcZLPG96/gR8NMibT2DJT2LAxlhi2IAUe3clyLCBMeCvwNGGmPftnKVtLS0S8vWzE
 goKcCgUyfswYNJNB03rc9RJb6xw7VyLww7uGEWUjDIqXOUlIkZfDdWGkipM4a486ZXSh
 hpiuFVZlAMdW47gADkks7OhVwgc35CpFz6s1QZ6vlWOyzxcFQK30gQJfB89IJllxNYhH
 xjdg==
X-Gm-Message-State: AOJu0YxH3kNrxHnAlE6O6zszHMkeUPUbY7ZFsHa5ZDjn1lgvgFTrTuou
 1XY/Y9ajNaZL3kcNrmx+0P55nb8OWH1dEE2PIhnHJkZAA2fVOSV3hV3n22cRFzINap4WHEnYt21
 ZJas=
X-Google-Smtp-Source: AGHT+IFiU8QG1tB8y2e3AXz5hmb5q0+4nZlXCPlcoRmVvNSTwANdj0WyfA3+5lS1TbeR4jOm6r4L3Q==
X-Received: by 2002:a05:600c:4703:b0:41b:85bf:f3a8 with SMTP id
 5b1f17b1804b1-41fead65a26mr61950935e9.35.1715586455592; 
 Mon, 13 May 2024 00:47:35 -0700 (PDT)
Received: from stoup.. (12.red-213-97-13.staticip.rima-tde.net. [213.97.13.12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9318sm148204765e9.30.2024.05.13.00.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:47:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 23/45] target/hppa: Use TCG_COND_TST* in do_unit_addsub
Date: Mon, 13 May 2024 09:46:55 +0200
Message-Id: <20240513074717.130949-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513074717.130949-1-richard.henderson@linaro.org>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
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
index 50cc6decd8..47f4b23d1b 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1419,8 +1419,8 @@ static void do_unit_addsub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
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


