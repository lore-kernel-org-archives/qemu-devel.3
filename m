Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3398C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 08:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXFkl-0003Ix-Kl; Thu, 03 Jul 2025 04:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uXFkg-00038M-U9; Thu, 03 Jul 2025 04:57:08 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uXFkf-0008GH-1Z; Thu, 03 Jul 2025 04:57:06 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-74af4af04fdso580193b3a.1; 
 Thu, 03 Jul 2025 01:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751533022; x=1752137822; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iyFUAaglgtudCcm/+GaLUiopNJBnEFOWo2eTOT6yB94=;
 b=e8VDtZbuK3J8i1UDixoDdWwNAS1UKJjzZqLhTOwCFesXRtK9ueDgthkUTh+sg+GhUg
 brcvh+2tu6073O3wBbT1RoICNwWY/hTuiuWVX/lYAoxbEfR7wcZW1/VP6adWTmZcEbVh
 AGgi4aGTb0goYYgHF0kp8eC0UwzxzHjRiQrcFeJdUAYybv8dmTHoyZA+giYb1sEJRRL1
 MCxSm+IGp09RHiiT77226ybf68FHLpb9zieNouehoHTJGM175/UU53FXhmwLK2HFnEGr
 rSV5qkZkcCTHqT6Y0NlBxoKxn+1tnJNRK+HswoDvkwTNdTM13Yzb143Ytu4S54+Ig9UH
 9xAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751533022; x=1752137822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iyFUAaglgtudCcm/+GaLUiopNJBnEFOWo2eTOT6yB94=;
 b=Ke8K0DUdPSou9HheaqQJkXFbqBzRK0YylV/EkZUSTxuzJL7Wy50UlGkoLmspoTmr41
 6mavKnU7dTATzQYlCrZnV77htOJCsD95j8MSErWkXZTt9znaJMx4Ii511F9sntnJKP47
 fJwki1M/d48OqKb4af0K9/bGBcSzLjD9EI+iTmK60iN9j6rRKT8HJNgbxCRqViGUphZr
 pO/T/BsxDXpbf/pupB0QnMue9mrj3OcSIvhGe1jJKYo+QH5BSAe1Vvm5MZuBsrGyHkdj
 BPT8fEjvg5VKeCF1chO1aqj7EIz1V1Pb+JOHso6qcaVHr4XN8yTA0jWwnLKsVt6wtqos
 HQ0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVH7uZQkuOEkolY4k5nmHbjnjHR5K6ZfmvqMq3pcKjI+TnlJu6ORNayupMIvAJ1l33LB35Ljn3ifQ==@nongnu.org
X-Gm-Message-State: AOJu0YxKdr03ic29qKkfNxj7uHO8BNqoGTGk9d6TBs/96v3CBv3D53l6
 a/A6NK20FaTN3vQqRyfQ2n+fZpYDuu0/njqZCQtwqQYnMxL67aXWY+5ZK89jaJNK6GU=
X-Gm-Gg: ASbGncstC5Oifm57euXZgmSHywtsSQHOaf0XE7vBHVaqnI48gmjiuhrrvoe7dcqVuVS
 OB5RviOl0eGaQSwOob3EWQAFLPIKUbyO6YHjZehY4vgE2Sd6GkGmgNaZUP9XbXlTHf4CrwNbsWz
 FDj7tELk6IuVhhIKya1PaIWj58w+ljmtTSLBbopIC3x1ByeK4msCAYUaEnf+uHDIzCbxwTAkudT
 3orwhJ15DEpLWzR+XuegQBP+5awllG/JrZYwrChObsY/z4Puj+VSWJMxEHrECHz3wuLZMfYt5UG
 4tTHdlHhiVDN0t05LU3vAYftOxilShOKEFKoG9P2EmjJIBjlBgGVtLfN28nIR2EK2NUDUxow7/I
 8ZxzLze3Y7SG6fx5OoZd1PC9uU0twen2ZRrFfkbv+ftY=
X-Google-Smtp-Source: AGHT+IGVqC6rlaJoZsXBTHg2cNBDmewf6YP15GdCmVNKi4cnHH8ZLlI2921i/sWg9w8IpyMUWaeiwA==
X-Received: by 2002:a05:6a21:999e:b0:1f3:3547:f21b with SMTP id
 adf61e73a8af0-22487aa74b0mr2219578637.5.1751533022148; 
 Thu, 03 Jul 2025 01:57:02 -0700 (PDT)
Received: from localhost (pa49-178-74-199.pa.nsw.optusnet.com.au.
 [49.178.74.199]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-74af55c6c67sm16731730b3a.110.2025.07.03.01.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 01:57:01 -0700 (PDT)
From: William Kosasih <kosasihwilliam4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 William Kosasih <kosasihwilliam4@gmail.com>
Subject: [PATCH v4 10/11] target/arm: Fix VST4 helper store alignment checks
Date: Thu,  3 Jul 2025 18:26:03 +0930
Message-ID: <20250703085604.154449-11-kosasihwilliam4@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250703085604.154449-1-kosasihwilliam4@gmail.com>
References: <20250703085604.154449-1-kosasihwilliam4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=kosasihwilliam4@gmail.com; helo=mail-pf1-x42d.google.com
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

This patch adds alignment checks in the store operations in the VST4
instruction.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/mve_helper.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 7473dfad2d..5273411389 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -577,6 +577,8 @@ DO_VLD2W(vld21w, 8, 12, 16, 20)
         uint16_t mask = mve_eci_mask(env);                              \
         static const uint8_t off[4] = { O1, O2, O3, O4 };               \
         uint32_t addr, data;                                            \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -588,7 +590,7 @@ DO_VLD2W(vld21w, 8, 12, 16, 20)
                 uint8_t *qd = (uint8_t *)aa32_vfp_qreg(env, qnidx + e); \
                 data = (data << 8) | qd[H1(off[beat])];                 \
             }                                                           \
-            cpu_stl_le_data_ra(env, addr, data, GETPC());               \
+            cpu_stl_mmu(env, addr, data, oi, GETPC());                  \
         }                                                               \
     }
 
@@ -602,6 +604,8 @@ DO_VLD2W(vld21w, 8, 12, 16, 20)
         uint32_t addr, data;                                            \
         int y; /* y counts 0 2 0 2 */                                   \
         uint16_t *qd;                                                   \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (beat = 0, y = 0; beat < 4; beat++, mask >>= 4, y ^= 2) {   \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -612,7 +616,7 @@ DO_VLD2W(vld21w, 8, 12, 16, 20)
             data = qd[H2(off[beat])];                                   \
             qd = (uint16_t *)aa32_vfp_qreg(env, qnidx + y + 1);         \
             data |= qd[H2(off[beat])] << 16;                            \
-            cpu_stl_le_data_ra(env, addr, data, GETPC());               \
+            cpu_stl_mmu(env, addr, data, oi, GETPC());                  \
         }                                                               \
     }
 
@@ -626,6 +630,8 @@ DO_VLD2W(vld21w, 8, 12, 16, 20)
         uint32_t addr, data;                                            \
         uint32_t *qd;                                                   \
         int y;                                                          \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -635,7 +641,7 @@ DO_VLD2W(vld21w, 8, 12, 16, 20)
             y = (beat + (O1 & 2)) & 3;                                  \
             qd = (uint32_t *)aa32_vfp_qreg(env, qnidx + y);             \
             data = qd[H4(off[beat] >> 2)];                              \
-            cpu_stl_le_data_ra(env, addr, data, GETPC());               \
+            cpu_stl_mmu(env, addr, data, oi, GETPC());                  \
         }                                                               \
     }
 
-- 
2.48.1


