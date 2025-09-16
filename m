Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C55CAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 14:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyWcN-0007RH-Gb; Tue, 16 Sep 2025 10:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWab-0005y7-02
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:25 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWaT-0008NR-Pv
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:24 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-24457f581aeso55563405ad.0
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 07:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758032582; x=1758637382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iFvrkXppk9qW3dQaIUV7du/mSWSAFGQyLCbJPSszGi0=;
 b=ohax2Rt6HfKUrn8WG4X3m38AO+JFqe5yl2w6a016T+LDQ7oTZ6PTu360TzBrwqRXZG
 cgiynJHsVeco8jWrXs1g9dvf0o3j13E5jm5hlXXva9dK2TR5LYEHHYdW4FmkxtgaiKVd
 oR1W7tZzRj7H6xW9rp1UTEylSSXZDrBZSCmfIkA0NUggSEy05pPtqEwRHqOnagKiNSXa
 jp/dbrR/NF8IkWZz8N291g3iNmx/C/cLHbM/QwGbI5sFPM0/IFH6uFJXizA5SLAdDR3E
 89a+006JKVcCsAnr/k1tp/vFa9NrzcBShJFeAeRcqA6A9EsOfvB3K31DakrNUNjaCe4x
 Owtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758032582; x=1758637382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iFvrkXppk9qW3dQaIUV7du/mSWSAFGQyLCbJPSszGi0=;
 b=oeDsF7EHg6cHJS7mflbXArJ9J26MXFUEcLYBJNGcbWpd2HWzVHPF76nBTeutvyt86F
 tefWTVipNB/aULPc/MA5AFAGOfx5RnszNUi19elboXqzQ04235JRilKSf8fsTuRvoV7N
 lEc3v+QvvLCWmVTX0I6FzYvpWETz2EPx8MFzovsBBzPGaHI4RnT027HnmiOcyKVXZsM7
 U5tCJobo1NiZNOobOShH/WPDFvvZpm8qrN6uF9U/ElvPbeR3DzdeZgtfKT/Tl3zLMHb8
 5BAwPUNul6Xx36+j85LujF69/WfmKNrfXci8F2OdrVYvgh2SXan4EFZBBuNVFCGhR5/v
 462g==
X-Gm-Message-State: AOJu0Yyq9wZVGtUchao0AsCNSYkIf3vOmOnZQB9NULzyGSDplUguN38l
 l4/WB7vJ68vINp9M6MNLRNl4i5qIkRdXcnqXF5Aq/folCgqIZUL8j9dRXVXsmsgEBlqF5WnxyfC
 QG+FE
X-Gm-Gg: ASbGncvHs1pKVGKQwWFEhoLPBQb100QSfuPbIrWBLPYwNe12jhaHxLfNqg4YYee0YJV
 g3MG/GFkUf1B8zh/r0zRdkmHa4IACd9DwpSbdVsVDCv9XM6xNyLluzdxqiCXaMuheOJuO5pwPBM
 yb7rzVm9yjjLwwd72XXhyZD4xePCVpcoeo/yMV8uTF80ANXN9WuUDT2Vq9LEY0xIFdIV+fZflzB
 4w7eKJRtEp693o9N7dvOByOwLrpON9pMfGCeH6OfoSpqMlmmffXX+j1GWME2lUCWHXyANIjXnZd
 StU/jM/7WLs/or/HRFgRDeIMJHuDGBkAef54MLrmd+QrfZsuhSPIDOWoQBZN063vmL72kKT2zmg
 rwupEn8WAipQoyo+UMYKXqvcItUJb
X-Google-Smtp-Source: AGHT+IETPo01soMbT7PfDX618eaXGP3wwZ6+IeqFVDMBk3dznVd9SPlYZYu/Vk+THaw6tnB/li8UvA==
X-Received: by 2002:a17:903:8c3:b0:260:c48c:3fba with SMTP id
 d9443c01a7336-260c48c4123mr148767645ad.47.1758032582027; 
 Tue, 16 Sep 2025 07:23:02 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2651d2df15esm73459905ad.45.2025.09.16.07.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 07:23:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v2 28/36] target/arm: Move alias setting for wildcards
Date: Tue, 16 Sep 2025 07:22:29 -0700
Message-ID: <20250916142238.664316-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916142238.664316-1-richard.henderson@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Move this test from add_cpreg_to_hashtable to
define_one_arm_cp_reg_with_opaque, where we can also
simplify it based on the loop variables.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index da3dd073d3..9156cc72ae 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7503,20 +7503,12 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, ARMCPRegInfo *r,
     }
 
     /*
-     * By convention, for wildcarded registers only the first
-     * entry is used for migration; the others are marked as
-     * ALIAS so we don't try to transfer the register
-     * multiple times. Special registers (ie NOP/WFI) are
-     * never migratable and not even raw-accessible.
+     * Special registers (ie NOP/WFI) are never migratable and
+     * are not even raw-accessible.
      */
     if (r->type & ARM_CP_SPECIAL_MASK) {
         r->type |= ARM_CP_NO_RAW;
     }
-    if (((r->crm == CP_ANY) && crm != 0) ||
-        ((r->opc1 == CP_ANY) && opc1 != 0) ||
-        ((r->opc2 == CP_ANY) && opc2 != 0)) {
-        r->type |= ARM_CP_ALIAS | ARM_CP_NO_GDB;
-    }
 
     /*
      * Update fields to match the instantiation, overwiting wildcards
@@ -7819,6 +7811,16 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
                 ARMCPRegInfo *r2 = alloc_cpreg(r, NULL);
                 ARMCPRegInfo *r3;
 
+                /*
+                 * By convention for wildcarded registers, only the first
+                 * entry is used for migration; the others are marked as
+                 * ALIAS so we don't try to transfer the register
+                 * multiple times.
+                 */
+                if (crm != crmmin || opc1 != opc1min || opc2 != opc2min) {
+                    r2->type |= ARM_CP_ALIAS | ARM_CP_NO_GDB;
+                }
+
                 switch (r->state) {
                 case ARM_CP_STATE_AA32:
                     add_cpreg_to_hashtable_aa32(cpu, r2, cp, crm, opc1, opc2);
-- 
2.43.0


