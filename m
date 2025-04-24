Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BBDC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 19:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u81vM-0007Ag-F0; Thu, 24 Apr 2025 15:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u81vI-00079p-Bg
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 15:07:48 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u81vG-0004Cj-E6
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 15:07:48 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-73bf1cef6ceso1519748b3a.0
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 12:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745521665; x=1746126465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ny25QXvMDBLGMzcEJl/d1aROYpeK1AxdmkeiYircacg=;
 b=HalwJ74ASzk/gme2smNor2i7cSqnULjQjJ07aFSp6wAHXONX69OvIya7xE/Ij11TQX
 swmWCpK0OxK7EHwb7wGg9aEi+PFiyfGGeFtMJ1Si3mZaVWuwLvG8+RmJnMHkwbpXui5L
 Ou3pA389V+ar5GAXpedmW3BQvIUcdVwKUJcyrvtMOXVSI0MXG41FFq5gzjwnggwK7y9g
 49YO0mT/PxZZ0wbA78WxG+y6r/JviVwXrEGtkIbCR2Dxl2ATx4Wtpi93Lo257iYVhj8g
 jod89VtBVRl4PVdK+Q3hCtQNuCwl/qDvhkOYtX1f92CGtU5xAzYyoWJsX5rmNZQjt6Of
 aKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745521665; x=1746126465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ny25QXvMDBLGMzcEJl/d1aROYpeK1AxdmkeiYircacg=;
 b=avpvQZq60vtXxUs8noW0nwnIhyv7mHO9AMKs1Y82PJhj+nFzwfVGVyjvyWB7bVC5Zt
 SQpQWOqAs/+ATXX4QmplsYHhxjPG7JETB6UDTQ0rKWq9nWQYZljMWE6EfWK2Kksxm8q4
 gxeks62Q6dBEAN83OWl8onSRoVxv5Wfq7sjA/6tt2q7WNGikq2d+Lhu8JVMR4vknBdGD
 QSNjLRT6ckV3rWKytKqcjEAEJwpr8Nwbt1YzjXRpeWIU46aFSack6EIVeVs4121acrZA
 HbZiRMn30Mlp/N3qyQemlYkBBCVJsHh3QMhOHTbwZbMTHJ3dscQ7fwMrE3IhBmTeQ1L8
 PyIg==
X-Gm-Message-State: AOJu0YyRGi5zreneRMzMzAMTJX7yPwCE0IMsDW0FmDA7/x56VJ/c7jqW
 wChYo2jVns84VNctPP+hhaPOspzPD0kPzpuBSt7Mb6voqRjLEqQEvgLhGRnj+ZSv4XBriL7I2sc
 F
X-Gm-Gg: ASbGncvTSQseVdKjREThZyL9mBHcY59hkhGWH0OVnznhs0hT4F7xppTr4rVX5EHiBSe
 pp6pCah2dWJp7WLAT2TYIkLk9D5BRiRQf368dbihwGhoKJHQbgJ3BH6ipvkHvwG5au1mWgtNt6d
 v2o08nrFTCbnunKLg5oe02GLfoftfhkk19R8IlgeMW4hEdMNIMsfBntabxsDEJwqMxW0WryGN8j
 LKoOjxt68ce5CYj1CLjskX+ehBlgikvSlRG37+LkRVbZVVty+SHkTK93bMDqg4L5ttiJt4PIBna
 JrbXbVh6SEYY0ySea4iEQhxXugzOWtG2iNOnXFaJ5SDJg4dzbHstNe9vHS4GyAGuZ20vPKuVwUI
 =
X-Google-Smtp-Source: AGHT+IH7LJnRMAok29SPeys/GAZQujI51jaNbTUFvMYGHxnZHSIo2rK+w+oZ8hwnblJoyFX2XFu/FA==
X-Received: by 2002:a05:6a00:4ace:b0:73e:2340:4b07 with SMTP id
 d2e1a72fcca58-73e330dbe07mr1025737b3a.18.1745521664696; 
 Thu, 24 Apr 2025 12:07:44 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e259134d5sm1846463b3a.19.2025.04.24.12.07.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 12:07:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: git@xen0n.name
Subject: [PATCH 2/2] tcg/loongarch64: Improve constraints for TCG_CT_CONST_VCMP
Date: Thu, 24 Apr 2025 12:07:41 -0700
Message-ID: <20250424190741.738515-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424190741.738515-1-richard.henderson@linaro.org>
References: <20250424190741.738515-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Use the TCGCond given to tcg_target_const_match to exactly match
the supported constant.  Adjust the code generation to assume this
has been done -- recall that encode_*_insn contain assertions that
the constants are valid.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 38 ++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 740b7c264d..879f66f255 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -213,8 +213,18 @@ static bool tcg_target_const_match(int64_t val, int ct,
     }
     if (ct & (TCG_CT_CONST_VCMP | TCG_CT_CONST_VADD)) {
         int64_t vec_val = sextract64(val, 0, 8 << vece);
-        if ((ct & TCG_CT_CONST_VCMP) && -0x10 <= vec_val && vec_val <= 0x1f) {
-            return true;
+        if (ct & TCG_CT_CONST_VCMP) {
+            switch (cond) {
+            case TCG_COND_EQ:
+            case TCG_COND_LE:
+            case TCG_COND_LT:
+                return -0x10 <= vec_val && vec_val <= 0x0f;
+            case TCG_COND_LEU:
+            case TCG_COND_LTU:
+                return 0x00 <= vec_val && vec_val <= 0x1f;
+            default:
+                return false;
+            }
         }
         if ((ct & TCG_CT_CONST_VADD) && -0x1f <= vec_val && vec_val <= 0x1f) {
             return true;
@@ -2029,28 +2039,22 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                  * Try vseqi/vslei/vslti
                  */
                 int64_t value = sextract64(a2, 0, 8 << vece);
-                if ((cond == TCG_COND_EQ ||
-                     cond == TCG_COND_LE ||
-                     cond == TCG_COND_LT) &&
-                    (-0x10 <= value && value <= 0x0f)) {
+                switch (cond) {
+                case TCG_COND_EQ:
+                case TCG_COND_LE:
+                case TCG_COND_LT:
                     insn = cmp_vec_imm_insn[cond][lasx][vece];
                     tcg_out32(s, encode_vdvjsk5_insn(insn, a0, a1, value));
                     break;
-                } else if ((cond == TCG_COND_LEU ||
-                            cond == TCG_COND_LTU) &&
-                           (0x00 <= value && value <= 0x1f)) {
+                case TCG_COND_LEU:
+                case TCG_COND_LTU:
                     insn = cmp_vec_imm_insn[cond][lasx][vece];
                     tcg_out32(s, encode_vdvjuk5_insn(insn, a0, a1, value));
                     break;
+                default:
+                    g_assert_not_reached();
                 }
-
-                /*
-                 * Fallback to:
-                 * dupi_vec temp, a2
-                 * cmp_vec a0, a1, temp, cond
-                 */
-                tcg_out_dupi_vec(s, type, vece, TCG_VEC_TMP0, a2);
-                a2 = TCG_VEC_TMP0;
+                break;
             }
 
             insn = cmp_vec_insn[cond][lasx][vece];
-- 
2.43.0


