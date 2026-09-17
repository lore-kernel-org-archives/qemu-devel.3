Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E8AC982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x77JZ-0002jX-M5; Thu, 17 Sep 2026 04:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77JM-0002gu-LH
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:17:41 -0400
Received: from mail-oo2-x2b.google.com ([2607:f8b0:4864:31::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77JJ-0001wp-Mc
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:17:39 -0400
Received: by mail-oo2-x2b.google.com with SMTP id
 006d021491bc7-6b1ae721872so239684eaf.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 01:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789633056; x=1790237856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e/w7C4dSwVMM3Ty27Ml+nDpKvw7B5NXYFCxZ6yf9jxw=;
 b=x0Cx8J5PJAO4iNuoq+g1dt6H+cPecPIKa85vBdLk5bEDRq4jyHoS3/PJq9fDFhf4cx
 rZ2VPbVp+3g5K+2yoipSp7Xnioxv99W8wPiDuhWISqKMK6Hor6HzKFr4SGCpBmKppUcW
 q1ROQBG92ljP+JzLFyFvTFKG8nmAvhZKmBi1ITUCVOQmT2b8aHTLZw83h0wOQUxjc3tN
 u1fd7+6LA2dWYPrxb+Tv6MyyK+bHF30BD40Nc3QRgxPUfjwkK/tlRCs5rFAIyO3qgL6t
 pIa2yNlHEbgsKOXlozoyOfHueWaReP2OSJ0W7961gaq0w10/sgqN80MdYYnfF0XRVNnb
 5qVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789633056; x=1790237856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=e/w7C4dSwVMM3Ty27Ml+nDpKvw7B5NXYFCxZ6yf9jxw=;
 b=Qkv4SEBxvzJoz4ZsmAi9Oj7YBCwnybsxk0HL4KKjFosXxlkRISU9EcR/k5MoY2efl0
 TUsHvev97pdse35xgWUXYlrSZI7w/SAOxFDF8Mkrwqwy3yvAd9L3RvFkGYukSNj/TnPL
 sdievXWFvuLZV6I9EUq/CoZAq2gdVPZ81HuxzogwG74W5WMDeEdJDfoSKPGPX5MUYxw6
 r+Tb32h7mYdbO5f4uGkjHp1tocA8IR2ujHunN3UQP8uEGZUXI+Ill/2Kzacd27AJD0cY
 zU3KsNvdAHLTlZ/0MU+CnUNHvrtcoDT5SHfNS29KxL9WDFaWfe2zh9IrLC6WL1ar6emh
 dpIg==
X-Gm-Message-State: AFuF++mG8tYthzXOLNlQHCUJxBZKvo81IpT1CkkQwD1/CeWSzUuKCvgn
 6t+pHFOHovkRqe735IwAAYZLN9rKJmmOMvWMj0BVkc7EAB+HanIsndi2ujKUmIUEJJckjnwrHSd
 YEV3MWTw=
X-Gm-Gg: AYBFou1lGI5i90OEkODfpkDzzDA2gG047c41twFBkRgXF0jF+cNIq2MnaT1ywOc/EhF
 PVdf0wDoVvIyKCxzaJgfpU4eySJRgBwtTQXgFUDldGV8X+CpuDRH7HMpbL8SKv8uhpAdmwVStii
 zK8YSv6BElwICI57qdqKp0Y7GwrZ9CICiWxtIYBNhZAa4Wx6bSigObpyMDJfpK6Z3V1KiIdIGqR
 rjYHyHw+1HU56wYLpt7grHzqo6pVae9Y2DEKn1GheAO+f/LxbDbvtBb3VTsRYo6gppPalJCMti9
 bcURYvWgw8pDT2xlhfOudUljNpn2zxPiW9QakiejyMwmKPrhuDkxb6pJL+eumIuyRwDt6debd6E
 +byebH0fjI4bsEW1AOahJGahM8ScA9y6tC3Sj60+sIfklAa0xRWyanZhOZgdO/YBkaxNIAMOdBK
 AFSDYQSXxzfimlHRZjK2cxbtBTc98lmXhTrxXdQCNrNZUHklcTv81rbIZdJMITqpMNrifrdfM3A
 SM3OVs=
X-Received: by 2002:a05:6820:4cc9:b0:6be:dc4:13ea with SMTP id
 006d021491bc7-6c7d3ee58f0mr5520331eaf.50.1789633056538; 
 Thu, 17 Sep 2026 01:17:36 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c1943f4bcsm127638eec.21.2026.09.17.01.17.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 01:17:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PATCH v2 16/16] tcg/s390x: Implement INDEX_op_lea
Date: Wed, 16 Sep 2026 22:17:16 -1000
Message-ID: <20260917081716.946668-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917081716.946668-1-richard.henderson@linaro.org>
References: <20260917081716.946668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/s390x/tcg-target-has.h |  5 +++--
 tcg/s390x/tcg-target.c.inc | 13 ++++++++++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index 58e3afe5266..33a3b72318e 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -77,7 +77,8 @@ tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
 }
 #define TCG_TARGET_sextract_valid  tcg_target_sextract_valid
 
-#define TCG_TARGET_lea_sh_valid(type, sh)          0
-#define TCG_TARGET_lea_imm_valid(type, imm)        0
+#define TCG_TARGET_lea_sh_valid(type, sh)          ((sh) == 0)
+#define TCG_TARGET_lea_imm_valid(type, imm)        \
+    ((imm) >= -0x80000 && (imm) < 0x80000)
 
 #endif
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 2fd7012d047..db3b2fc3c92 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -3187,8 +3187,19 @@ static const TCGOutOpStore outop_st = {
     .out_r = tcg_out_st,
 };
 
+static void tgen_lea(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                     TCGReg a2, unsigned sh, tcg_target_long imm)
+{
+    if (imm >= 0 && imm < 0x1000) {
+        tcg_out_insn(s, RX, LA, a0, a1, a2, imm);
+    } else {
+        tcg_out_insn(s, RXY, LAY, a0, a1, a2, imm);
+    }
+}
+
 static const TCGOutOpLea outop_lea = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out = tgen_lea,
 };
 
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
-- 
2.53.0


