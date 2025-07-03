Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C80B7C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 08:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXFkk-0003Fd-O5; Thu, 03 Jul 2025 04:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uXFkc-00033n-JB; Thu, 03 Jul 2025 04:57:05 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uXFkZ-0008F2-Nb; Thu, 03 Jul 2025 04:57:01 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22c33677183so67889105ad.2; 
 Thu, 03 Jul 2025 01:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751533017; x=1752137817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b7zaRZf5bnnSsSyEzbbs1xqvJInRW9QsQLxNL2OOGn4=;
 b=EW6Jb6tof40kKUhrXHXqgaT2441iwE39I7LT+1Q5s/ac/FxjhLMTTZCXZ6wmx/8eh2
 oPk5LZxeP7LOY1mMt/lRkM6xZgbPxeedDX2S7qwNaP+3uCcZomdXbeO1Vvhm0trq3XI4
 Tiltw+qG+XuN5T8cZPBJrQbtFgnmMlRBkvd5/Htyd5kU6quicisuyEUbmeVaEl42BcP4
 usSDdD5X12XJ7uh03FkI5shYiNH1P2FNQbDOqUsaIuKoGOzfDEy0LvP5MXD0Sl+92JGD
 D1ueB/P3WxW3XpyLVa2muAoHrhZWf4Tn7bSuHEHdv2tv9EIAqV2CTIoYdffw7xH8lPiv
 12wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751533017; x=1752137817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b7zaRZf5bnnSsSyEzbbs1xqvJInRW9QsQLxNL2OOGn4=;
 b=CeIeoV04B+JL5Oe/h+sKSdAWUazYPnqAe/ud0EJMT9KiKSkjHXLeOXyUnRoxVk3Whn
 NJLAbd5P6x/r6Y+12yK7fnk6a8+wT6LIsZQKrKOe1HH0lZTHaseGvuJ/dvlpnnjSeusZ
 7FxWln4i5n61wa26V9Id5qKllDjUBaCmsiPk/vEupPYC/9aQ2iCzmETpTf5hE+f8Accj
 4+ESNRIAHql1wrHsQIbQxh+8bqErGhnObriBj0ZFitCvwNlgL8Cq0dJhKWItXK8/svt+
 dboCDkcfF8lvsJAfztuGzyZWfv2m7/7siHMRGtDTqGyh/VafqFLZ883MKp+pAEmu3bfE
 bFOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGvGlSbXLFoUWkLvhw+B65ku3ELFAP9BzrQe4wS6AJvqVIe9O1AOqN2v0bG5olOqF17u0lwXAMYw==@nongnu.org
X-Gm-Message-State: AOJu0YwhncmELB/MzjEZKPcEWTJlV5XPxbfIM/LluNSYHL8AxXnmqoi9
 AB9hXi2SCExYcnI1UYYlFKT5nylOTOOwnTr5/5Yikc/g6iELNm5S/2oCSQEtxug9cXM=
X-Gm-Gg: ASbGnctVas/5CTQdbeeqc7filaO1IDX5nZrvrUHgeIfH+nMM5wPm9oPObpyIt0FtLJ7
 1AyeA74ZxYTAC+LZ+5YUbemPwJ2oEif3zbeFK9WERUejt8OCPxlEJxFM2rDcB8n5N6ZFb5EEBnz
 4W3Dcpl5IlYmIqXyrfz2lzHQcBPQ4TN1cV0H1NP3aM82ghIRWr0rP7FNqtFklnlyEeBqvw4zRsy
 pBXK61tO8nUCLAbJHO51GlNBN45mkVaPemvgsRkdWglc7dg0Sn2OvraT8ucvK0Zni/0dVN5aZsH
 CxwBQ+upCtedwHPBgw+OuIcewyPZEGuN66J0ve/y12PwKEvfvrvyYLYxTXVPwgE+Tr/PKW6/4Y2
 agQ0JCMX8oU0oFbkOLXex3MTQWt0I4PUa94yj3YjXfZI=
X-Google-Smtp-Source: AGHT+IF1YYK+ZcCQPqld796dIS7GQZoWSC91zw+gnf3FZSLwG6YZMNUN0hwV7bxjfZ65SjwsXNzFWg==
X-Received: by 2002:a17:903:2f4b:b0:234:c22:c612 with SMTP id
 d9443c01a7336-23c79819a3emr40017035ad.43.1751533017483; 
 Thu, 03 Jul 2025 01:56:57 -0700 (PDT)
Received: from localhost (pa49-178-74-199.pa.nsw.optusnet.com.au.
 [49.178.74.199]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-23acb39ba8esm156083505ad.129.2025.07.03.01.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 01:56:57 -0700 (PDT)
From: William Kosasih <kosasihwilliam4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 William Kosasih <kosasihwilliam4@gmail.com>
Subject: [PATCH v4 09/11] target/arm: Fix VLD2 helper load alignment checks
Date: Thu,  3 Jul 2025 18:26:02 +0930
Message-ID: <20250703085604.154449-10-kosasihwilliam4@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250703085604.154449-1-kosasihwilliam4@gmail.com>
References: <20250703085604.154449-1-kosasihwilliam4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=kosasihwilliam4@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This patch adds alignment checks in the load operations in the VLD2
instruction.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/mve_helper.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 7069910db4..7473dfad2d 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -495,13 +495,15 @@ DO_VLD4W(vld43w, 6, 7, 8, 9)
         static const uint8_t off[4] = { O1, O2, O3, O4 };               \
         uint32_t addr, data;                                            \
         uint8_t *qd;                                                    \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
                 continue;                                               \
             }                                                           \
             addr = base + off[beat] * 2;                                \
-            data = cpu_ldl_le_data_ra(env, addr, GETPC());              \
+            data = cpu_ldl_mmu(env, addr, oi, GETPC());                 \
             for (e = 0; e < 4; e++, data >>= 8) {                       \
                 qd = (uint8_t *)aa32_vfp_qreg(env, qnidx + (e & 1));    \
                 qd[H1(off[beat] + (e >> 1))] = data;                    \
@@ -519,13 +521,15 @@ DO_VLD4W(vld43w, 6, 7, 8, 9)
         uint32_t addr, data;                                            \
         int e;                                                          \
         uint16_t *qd;                                                   \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
                 continue;                                               \
             }                                                           \
             addr = base + off[beat] * 4;                                \
-            data = cpu_ldl_le_data_ra(env, addr, GETPC());              \
+            data = cpu_ldl_mmu(env, addr, oi, GETPC());                 \
             for (e = 0; e < 2; e++, data >>= 16) {                      \
                 qd = (uint16_t *)aa32_vfp_qreg(env, qnidx + e);         \
                 qd[H2(off[beat])] = data;                               \
@@ -542,13 +546,15 @@ DO_VLD4W(vld43w, 6, 7, 8, 9)
         static const uint8_t off[4] = { O1, O2, O3, O4 };               \
         uint32_t addr, data;                                            \
         uint32_t *qd;                                                   \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
                 continue;                                               \
             }                                                           \
             addr = base + off[beat];                                    \
-            data = cpu_ldl_le_data_ra(env, addr, GETPC());              \
+            data = cpu_ldl_mmu(env, addr, oi, GETPC());                 \
             qd = (uint32_t *)aa32_vfp_qreg(env, qnidx + (beat & 1));    \
             qd[H4(off[beat] >> 3)] = data;                              \
         }                                                               \
-- 
2.48.1


