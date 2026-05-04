Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB2EFF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 15:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJvZl-0000ti-PU; Mon, 04 May 2026 11:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wJvZj-0000t2-LG
 for qemu-devel@nongnu.org; Mon, 04 May 2026 11:51:15 -0400
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wJvZg-0006Az-Kq
 for qemu-devel@nongnu.org; Mon, 04 May 2026 11:51:15 -0400
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-50e5eb0fabaso49625411cf.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 08:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777909871; x=1778514671; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=w7OO8p8XwMeVoo5L8ThKJ1n1Yds1F1C9hBCM/UrsyCY=;
 b=ICosAELSFy+DAhZXJGHoQo8+3ph+QW6efclu6qO+6h5UYXM3ld+HXxRAGSmBJW5BT7
 LqgW9HIW6tLco2DmRB1r3vgl1OoVSKvTOmYZgVoObUeTzC7SS8fW1XyOMImZ2SWBChh/
 j4+VR+sdXQ5MwyWqcyrI+fBxwnm4aMsYu8MKHq+uO9DaF/UCAq5/eMp8scVfQWu1cBRP
 Vx2gAIvmEXvntnJHSl/SvYgE6Xz6CeU02hLrB0uJ7N//aXKGnpHb03EAYq4CtLy87Rfd
 QJdn7jcL5W5iISC06dXDnagRJFobn0PtWYV1T7kDpLjDMH+XshcGdDCZvC5HKuQ0Xjgq
 7lyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777909871; x=1778514671;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=w7OO8p8XwMeVoo5L8ThKJ1n1Yds1F1C9hBCM/UrsyCY=;
 b=eZ3VZgW1QvhIDt1Y4U20lX2NOoVPWRaDsqabaZ7s9xENYoiQRlA8Cz9nPpoIYhNdmI
 QGQ4HaO4b88Cs/2tBo3y6nMFnD319IYSCcv8OWfWVXmAPh8aBAX3JTgePfnpBLq9UB2h
 aQJXFWWO5DQl6jAKMdyBqvzXCuzU9Uh9eJWUv7ozAA244+Hi/dRMOdcXMk27Q2UvWKwY
 BTcdzLVtIPrH0qeYL1qXGHFEBZEC9wIUDH04Fsco60/lcB0ilbPZGeMygjYp/mMTJp/o
 BO/yQRbma93hbGwBdjGDu393K3d007Pyc7Qs+J9+1U2G351ylS89h3Nb0FKzrVfgMKT2
 jhag==
X-Gm-Message-State: AOJu0YxsQF8p7zWVfodNaLGGCpIbrlK5apmKBrYbUoiFrpKptHEhjqWT
 3/9N85WXDW9VjylnxTDMPMu9ZE0mEtt4JFeIX1cnecPj0Tu7y63C+Pyv
X-Gm-Gg: AeBDietDEJOkhb3AmUgkuavi7uGgifLYDBxr1b3pzcV2fljOgiwiSE+CkO29uORYJb3
 ge33q7w6EQ2HP8ejJlvRTyzJDqmpbW5DlU0IzOuUzyeaJguXkmUPwQX0+Bzw2+KqNrgMh8FxJw5
 HHUqyfpEInoSFo6pErBd1lAdnM2XAmNxyhZHwhzUx7Tykg1SRmHSDhicpZL/kArzc5c3ispVHHt
 el1R0tn2KzyHT9/Y+BqmfKeWpiCWBw8iTm9g4L7gNZT9nrycJbGp2YY2KSXJfQlaORRrRA+iVXm
 3aLGiNUxA7j0lFJn1FHk8CnmFX3IC/R6x+MlgJATUq9vBzcRK6jKCUHNhktG0xRHXj/NbxBjjwH
 c+LJxe+nswJUEKD0tZ/rAmd8tXl2FCWdeQ81L/ZxW7Q/nYgpAS0RCAIl+A9HMQ/eYVivMcNJ5T5
 DXzESTZEhZJE+eCzq5uvIxmxLKFRJvojtYdmIn4kixB56EMg8qQvA=
X-Received: by 2002:a05:622a:1791:b0:50e:6399:eed0 with SMTP id
 d75a77b69052e-5104bf428dfmr145808261cf.46.1777909871268; 
 Mon, 04 May 2026 08:51:11 -0700 (PDT)
Received: from [192.168.1.164] ([2600:1009:a021:c665:5296:905f:3e4a:eb90])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51040931552sm99599011cf.12.2026.05.04.08.51.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 08:51:10 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Mon, 04 May 2026 11:50:35 -0400
Subject: [PATCH v5 02/15] target/arm: add TCSO bitmasks to SCTLR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-feat-mte4-v5-2-232a648e63c6@gmail.com>
References: <20260504-feat-mte4-v5-0-232a648e63c6@gmail.com>
In-Reply-To: <20260504-feat-mte4-v5-0-232a648e63c6@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Gabriel Brookman <brookmangabriel@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777909867; l=3108;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=Hr6ldUvaVhbV5Q3m2e++qMNZ7Ztg5TNxADdFaQMSu2Y=;
 b=FEO+LvrHwlPxeLgVrBMIli3a/aw4g4mNK63fxcjijA7/j/rsiLH+r/kvLSQOck6XTMBWfo/rP
 Q6bpSEF8WWuBgtC3Li/TcZIZrMgWeJJ0IyuAsOy0i6S6PHfOnEvjyAU
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=brookmangabriel@gmail.com; helo=mail-qt1-x834.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

These are the bitmasks used to control the FEAT_MTE_STORE_ONLY feature.
They are now named and setting these fields of SCTLR is ignored if MTE
or MTE4 is disabled, as per convention.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h |  5 +++++
 target/arm/cpu.h          |  2 ++
 target/arm/helper.c       | 20 ++++++++++++++------
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index c1f2336055..4d130b4b2b 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1154,6 +1154,11 @@ static inline bool isar_feature_aa64_mteperm(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64PFR2, MTEPERM) >= 1;
 }
 
+static inline bool isar_feature_aa64_mte_store_only(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64PFR2, MTESTOREONLY) == 1;
+}
+
 static inline bool isar_feature_aa64_sme(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64PFR1, SME) != 0;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index be14a47c35..9010491235 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1478,6 +1478,8 @@ void pmu_init(ARMCPU *cpu);
 #define SCTLR_EnAS0   (1ULL << 55) /* FEAT_LS64_ACCDATA */
 #define SCTLR_EnALS   (1ULL << 56) /* FEAT_LS64 */
 #define SCTLR_EPAN    (1ULL << 57) /* FEAT_PAN3 */
+#define SCTLR_TCSO0   (1ULL << 58) /* FEAT_MTE_STORE_ONLY */
+#define SCTLR_TCSO    (1ULL << 59) /* FEAT_MTE_STORE_ONLY */
 #define SCTLR_EnTP2   (1ULL << 60) /* FEAT_SME */
 #define SCTLR_NMI     (1ULL << 61) /* FEAT_NMI */
 #define SCTLR_SPINTMASK (1ULL << 62) /* FEAT_NMI */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7e7677a584..ddf44f4306 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3274,12 +3274,20 @@ static void sctlr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     /* ??? Lots of these bits are not implemented.  */
 
-    if (ri->state == ARM_CP_STATE_AA64 && !cpu_isar_feature(aa64_mte, cpu)) {
-        if (ri->opc1 == 6) { /* SCTLR_EL3 */
-            value &= ~(SCTLR_ITFSB | SCTLR_TCF | SCTLR_ATA);
-        } else {
-            value &= ~(SCTLR_ITFSB | SCTLR_TCF0 | SCTLR_TCF |
-                       SCTLR_ATA0 | SCTLR_ATA);
+    if (ri->state == ARM_CP_STATE_AA64) {
+        if (!cpu_isar_feature(aa64_mte, cpu)) {
+            if (ri->opc1 == 6) { /* SCTLR_EL3 */
+                value &= ~(SCTLR_ITFSB | SCTLR_TCF | SCTLR_ATA | SCTLR_TCSO);
+            } else {
+                value &= ~(SCTLR_ITFSB | SCTLR_TCF0 | SCTLR_TCF |
+                           SCTLR_ATA0 | SCTLR_ATA | SCTLR_TCSO | SCTLR_TCSO0);
+            }
+        } else if (!cpu_isar_feature(aa64_mte_store_only, cpu)) { /* not mte4 */
+            if (ri->opc1 == 6) { /* SCTLR_EL3 */
+                value &= ~SCTLR_TCSO;
+            } else {
+                value &= ~(SCTLR_TCSO | SCTLR_TCSO0);
+            }
         }
     }
 

-- 
2.54.0


