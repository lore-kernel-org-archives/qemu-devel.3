Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC3BC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjDz-0008I3-G2; Fri, 04 Jul 2025 12:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjDy-0008G9-8P
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:18 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjDw-00066G-Dt
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:17 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a6f2c6715fso1023986f8f.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646315; x=1752251115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TpA2K+wcSCgal+tzmOLuAAQKvE/cMwuvlQchQyQQauw=;
 b=sH5Ph5LIBDDb+RfSBLvVESCfG86HlwMQ7/w/kNWyHwQK9nFdyFm1SE29o7m7TIOSza
 gYt2kLpLskw7pz+txXUY9YpHgj2+JYYeGQ5ih+DxWoKkm5A9NSoWO6DjSamoNrGQHcZY
 4ix9C3gs8X81o/7CqwbTCzS4dPNVKPpJ88PWg5rNZBhtB1pCOZFQe4HH2t8X+FqF/gcb
 GMhaSPwhASGsbmPEU7/+ZmKPJggaR7AcQHlPmA1Y0EP7PJFi2Doer1rygI+InhBZ/RKr
 HC6H7aM2ogjQYHIYRiapPIcqFZw9NSfawSMKrXGIRrtsmKk9OG/1GrK/nCKKJ1BcxQJy
 c49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646315; x=1752251115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TpA2K+wcSCgal+tzmOLuAAQKvE/cMwuvlQchQyQQauw=;
 b=NHz5ytSF4EI5xhaB7mNwSEHLP13P7bMotpVbO3mFtoLfnBQdEpp1daVPcWPxebabR3
 9SU6VzitMeKTS+A90+ljRjBywxmQ+iM7PQ+HCHnb8lREyhaRWelOZSaZzRNHZqZYH5YI
 03lAXkouW+WeCvt66EBGTwLA+iUpehW0h0DDWuLfsJ5s1FSHL5CJJbni9JEwfkHjKLMC
 AM5GNtNN0hg4YuWMROi4Zzu3jDjZCfRMdAcUjR+d4S0x7ZVuqJWDmj0aNdsL7VMUmrzw
 UNf2fU3fjvgj4tnZUfuQS8u3y7oQW4qKCa85aMsKMNZMqgmrQXUZ2pfUmP952AIcbprv
 zGiQ==
X-Gm-Message-State: AOJu0YwstlYlH9zLR7PY9vG3MOH7ALKcRQubL1SVwXXB0ud8I7D85N+8
 CJn1gc2kzyqw3iYmyIkUnrrE3KKRuaLc2uT/U7W/fm56LDZ8pkYpRD7ipMtUpGlfLPFtZB+hFJh
 pb1/x
X-Gm-Gg: ASbGnctC0CEk6VO/A2sDElEMIlhHbMUTpwKmlqIH33g818I/600PVULzD8J8fky2Irk
 kJbMNC70YrQ3F4CC8754XUaMycgR1J743/4OKapcD3S8pfmBVmcSY3qlC3+u6OEn6QhvUI4XHxM
 LTouoGp40JpT2V70AMpdtHlaYy/WDFw+IWhfuP7CFxzWxwv3rQ4XCrY08YY8QMEiKSUjtH4ciSx
 LgIbGpnUNFJmWhZ0/3+b2MIagp9gtMysk5HkQf+oafbcGffa1oE77ap8C05g6Og7WJdt7AZhJdf
 Cxh8KWczc87rZom1JunTcaJzjX8b49XSHznJiSl3LHoo+69EJhdwr/HY2azHQG4n0UYJ
X-Google-Smtp-Source: AGHT+IHNWBH34opzcx/yOxpS0zhtDSiFdwrVaZLdNJCnSHSAefKI9qGGl4Sv3NA8cwfUf0JylcPDvg==
X-Received: by 2002:a05:6000:1788:b0:3a4:ef00:a78c with SMTP id
 ffacd0b85a97d-3b49703630fmr2701795f8f.55.1751646314692; 
 Fri, 04 Jul 2025 09:25:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 012/119] target/arm: Fix VST2 helper store alignment checks
Date: Fri,  4 Jul 2025 17:23:12 +0100
Message-ID: <20250704162501.249138-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

From: William Kosasih <kosasihwilliam4@gmail.com>

This patch adds alignment checks in the store operations in the VST2
instruction.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250703085604.154449-12-kosasihwilliam4@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/mve_helper.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 5273411389d..42bb3b979b5 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -669,6 +669,8 @@ DO_VST4W(vst43w, 6, 7, 8, 9)
         static const uint8_t off[4] = { O1, O2, O3, O4 };               \
         uint32_t addr, data;                                            \
         uint8_t *qd;                                                    \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -680,7 +682,7 @@ DO_VST4W(vst43w, 6, 7, 8, 9)
                 qd = (uint8_t *)aa32_vfp_qreg(env, qnidx + (e & 1));    \
                 data = (data << 8) | qd[H1(off[beat] + (e >> 1))];      \
             }                                                           \
-            cpu_stl_le_data_ra(env, addr, data, GETPC());               \
+            cpu_stl_mmu(env, addr, data, oi, GETPC());                  \
         }                                                               \
     }
 
@@ -694,6 +696,8 @@ DO_VST4W(vst43w, 6, 7, 8, 9)
         uint32_t addr, data;                                            \
         int e;                                                          \
         uint16_t *qd;                                                   \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -705,7 +709,7 @@ DO_VST4W(vst43w, 6, 7, 8, 9)
                 qd = (uint16_t *)aa32_vfp_qreg(env, qnidx + e);         \
                 data = (data << 16) | qd[H2(off[beat])];                \
             }                                                           \
-            cpu_stl_le_data_ra(env, addr, data, GETPC());               \
+            cpu_stl_mmu(env, addr, data, oi, GETPC());                  \
         }                                                               \
     }
 
@@ -718,6 +722,8 @@ DO_VST4W(vst43w, 6, 7, 8, 9)
         static const uint8_t off[4] = { O1, O2, O3, O4 };               \
         uint32_t addr, data;                                            \
         uint32_t *qd;                                                   \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -726,7 +732,7 @@ DO_VST4W(vst43w, 6, 7, 8, 9)
             addr = base + off[beat];                                    \
             qd = (uint32_t *)aa32_vfp_qreg(env, qnidx + (beat & 1));    \
             data = qd[H4(off[beat] >> 3)];                              \
-            cpu_stl_le_data_ra(env, addr, data, GETPC());               \
+            cpu_stl_mmu(env, addr, data, oi, GETPC());                  \
         }                                                               \
     }
 
-- 
2.43.0


