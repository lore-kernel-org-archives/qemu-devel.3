Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D10C02198
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 04:04:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfWdj-0008HR-Hx; Tue, 04 Feb 2025 23:03:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfWdg-0008Gh-EN
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 23:03:48 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfWde-000790-AR
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 23:03:48 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21f0c4275a1so17820275ad.2
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 20:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738728224; x=1739333024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ux/KtpTlSf39OaNdOQLkmTJ9/3Lg0YbAwExs8GYlciw=;
 b=rze1huqdtdKjw6G/P+bcamLB+bRH+RdbXfMFZg0D/fX8b/HP1L4t82gP8uSfaqWnDF
 w+Zy+RvsOk2t3TkKIZHWWo2zNbii8antqFC79YbzfXvst2TO7m3Upflm6XehdtABsVGI
 dwvRwMiyG1AGnn3jqTA4z+iUJ3nK+Kta5yuKkLyZRDh/me4xypkckYCdFVfg/Uh+7VEt
 +QS4smT3gr5cfL3mTdWAQ9lmyDhxc2drSyNjJRVyKzCjpAnCdmcH4jLN+xRP99vgAzdj
 GGYRJ+njYIy0scrnVKxa28xwS+k+PXHafFAF2zADaeqw41AeG0sT5K+pyx5dlCHXVfIP
 Q7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738728224; x=1739333024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ux/KtpTlSf39OaNdOQLkmTJ9/3Lg0YbAwExs8GYlciw=;
 b=VRWFgP7kBNDgqsVhDBitGMcGkPYqKKV1IK6PyVBxflY0HfGcGP9O6gUKWKTKCESKY5
 5FHdfwy0wvt8A0nuyKYMlMvj7om7CIoNlM5OdZxYbUMWzpZsYV6VR+F0JcyzuJVTVmNV
 Rr8qJ377eZVPKq5GoxkfpdIV899vV73mc+xMiyprber0q2qTzZEao+OFfxccSGQXQWcV
 OCFzaOoOK9m1Bfbx7g1qeoIW89FBNj3QenHDcVMOL8CpCsn5l4+GmiUF2in478qQYIiQ
 JPjcB+Zh97aaC/Mp2xCh4s/4w7VyEPWPDtT88gswQucbA6ytq7aICVP3xRit7GNULBIu
 bbGQ==
X-Gm-Message-State: AOJu0YyvMDcTPVmi1/yrDGL17SY9E7EGR4keI5zMSCU88QNYB+SpnBY0
 dkzbHlYi/BzSBFkfGtVWkpRkrcVbY7a1CKojIED6kVSKCQ4P5u4kHt44H7QjLgnIvDLFu/PEdVE
 M
X-Gm-Gg: ASbGncvzdYIygQZklO4TK1Zm9It0iwUZRmiJVTd8jd1mtShYS3khcIP8M5OEybTHdh4
 CVeDLSky2GWl4+yIkbO/A2gDS6hfpVxKI388IvvzlgCKZW6B22fsuaYDmvutWOQzyKhw3EIfUoH
 J0QE0yg124xTLvg+Gx0BgGQT5HH26CJVQXJo7i0b3ETAWqIGQRn1yGZsM23DX7LENEsyPPyepqV
 q1blfuja6Iu8on1eiISAdfL+rg80s5Oxf4nvmhULmqmrz1QPsW0bCG8UoeqwNS/Cx6xmBCNfyN/
 rYt8+Omnrhp1e/FPej2BBDzoMib/mogqS0KDIEfucrk4X2E=
X-Google-Smtp-Source: AGHT+IE9MNOXDoH3mElMEF/U4QLRMPD2YNlrBvbt7WshT06IkjR4Kq8/fY8SRyVdjVnqFrUuqm2cxQ==
X-Received: by 2002:a17:902:da8c:b0:216:2426:7668 with SMTP id
 d9443c01a7336-21f17e4c840mr21103285ad.13.1738728224460; 
 Tue, 04 Feb 2025 20:03:44 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f054eb89esm22380325ad.79.2025.02.04.20.03.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 20:03:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/11] tcg: Drop support for two address registers in gen_ldst
Date: Tue,  4 Feb 2025 20:03:31 -0800
Message-ID: <20250205040341.2056361-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205040341.2056361-1-richard.henderson@linaro.org>
References: <20250205040341.2056361-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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
 tcg/tcg-op-ldst.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 77271e0193..c3e9bf992a 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -91,25 +91,11 @@ static MemOp tcg_canonicalize_memop(MemOp op, bool is64, bool st)
 static void gen_ldst(TCGOpcode opc, TCGType type, TCGTemp *vl, TCGTemp *vh,
                      TCGTemp *addr, MemOpIdx oi)
 {
-    if (TCG_TARGET_REG_BITS == 64 || tcg_ctx->addr_type == TCG_TYPE_I32) {
-        if (vh) {
-            tcg_gen_op4(opc, type, temp_arg(vl), temp_arg(vh),
-                        temp_arg(addr), oi);
-        } else {
-            tcg_gen_op3(opc, type, temp_arg(vl), temp_arg(addr), oi);
-        }
+    assert(tcg_ctx->addr_type <= TCG_TYPE_REG);
+    if (vh) {
+        tcg_gen_op4(opc, type, temp_arg(vl), temp_arg(vh), temp_arg(addr), oi);
     } else {
-        /* See TCGV_LOW/HIGH. */
-        TCGTemp *al = addr + HOST_BIG_ENDIAN;
-        TCGTemp *ah = addr + !HOST_BIG_ENDIAN;
-
-        if (vh) {
-            tcg_gen_op5(opc, type, temp_arg(vl), temp_arg(vh),
-                        temp_arg(al), temp_arg(ah), oi);
-        } else {
-            tcg_gen_op4(opc, type, temp_arg(vl),
-                        temp_arg(al), temp_arg(ah), oi);
-        }
+        tcg_gen_op3(opc, type, temp_arg(vl), temp_arg(addr), oi);
     }
 }
 
-- 
2.43.0


