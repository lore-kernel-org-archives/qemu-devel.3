Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BAFC8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 10:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWYJ7-0005lH-7a; Tue, 01 Jul 2025 06:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uWYJ2-0005bP-NS; Tue, 01 Jul 2025 06:33:40 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uWYIx-0002OD-Gb; Tue, 01 Jul 2025 06:33:40 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-23636167b30so27519295ad.1; 
 Tue, 01 Jul 2025 03:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751366012; x=1751970812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YaRnx40pfqe2LWdyO+Phw71MFavCwwYSk+ZdTDx9hxA=;
 b=kiwd5gHoGdsLocZzEXP8oBANVFtQLEaDep9xrvypZMNUPGL+0B0/aUvZJsKOGjsjD8
 XDAg3gww7Yxj1MXMkZ5LnEFOSA14FX8iyThKceXyN0+CKbnjHE6pOyFYy6WsSlCc6Puz
 E9pKspG9Jw/S1MPCoGLkc3ATQRc39+K15lEc6hicn688p566LhDQ3TFURaajOI5gnMJi
 HgOudJ4LRt6cURtx7bSvJwIOetsI/sVYd400QQbcGwQk0mw3RkxW/oeH0h+jEADFVZpz
 YzH3yTKDAwIz24k5IKDh+6tRvn8KW0ev+I0OpJi1QpNCFvUKlfK5zwSvf5M3+2w/Gl8l
 7NzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751366012; x=1751970812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YaRnx40pfqe2LWdyO+Phw71MFavCwwYSk+ZdTDx9hxA=;
 b=ff59mpAyCsZVKxeBhgqT4WRQppNb+WOI9J6rBApDQSUEgXtIbYy64cbu/uW2r95Pv5
 lNQKWekjKKTjeFnMHb7G+A1xmp5yWYePINO/INjmer6yaJ+VR7oMpkHtpMJg5jYVvws1
 Dml6WZhH++yDhpG9o49kxTCrkOX89LYC8N9aVrgWOwVihZ4mhm/49ghE3o0d8crCvEEI
 jlSqdv7fIpT7h6MXFne6KwWK3P4EcYCTMah5K51mQQjPd87QucAQMRdxAoXMmsgViQux
 qMKUZ7nZL3lURKkF3w5PoH3VPDCtCQq09F4zP+lK3BXODIrxbIvQzxXso5s73tRze7OM
 DpOg==
X-Gm-Message-State: AOJu0YwAgxyGly6gB+clMS4nTndTjyi+cKha0zucnfktr89neD56vuIV
 Uqq3ByIBfIP/TN8MOOIhl10pUzG7YwCAJvyjJ9kJ85s6dvAmc4SRu2iwajJbyFojNIg=
X-Gm-Gg: ASbGnct/S1dlRJdMJwEsiZ5iEwGEiaN0DMTnx/hVfdo/2PWx8sV+k9kv2Zx66kWRfgn
 4FX9NHnPbBVq3S+8/F7K5/m7eSMD6B5FgsrwvphtH1edqL5Jld/KXetYwbLI7yRnB4AFHIawObs
 Gx+dzJ99KExvw2UuI8EQfw2/ncio5yPkVBZisq02yD3WhxcpcblVAde4vGyY0MDK11nLim7YfnM
 V2ZO+wtXdBq54Da2co4DIRzH2CV4i0He9Nu+EUekd4bF4s50+jv3AUY272ssjZxL+6EdFjIvuen
 +icEdGf2FR4mr/6r11mQ3Taa+LeJIqUZ6iPJqfjkUxIVPGKtnUplnanzFuRRl/heVY1HYiIOO7t
 tG5WIgqvvIErFJr56rz63EkDU/KqIROAvbYq1iL1FsoI=
X-Google-Smtp-Source: AGHT+IG3J3CPFENhldOUjXYuQsOculAHuS0R7o9ec7yY+KFAmQQi2I/TBYJ9I7GUVEUJyYONBDCjbg==
X-Received: by 2002:a17:903:1ac8:b0:235:225d:30a2 with SMTP id
 d9443c01a7336-23ac4664161mr255766415ad.48.1751366011834; 
 Tue, 01 Jul 2025 03:33:31 -0700 (PDT)
Received: from localhost (pa49-178-74-199.pa.nsw.optusnet.com.au.
 [49.178.74.199]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-23acb3acc00sm99523915ad.142.2025.07.01.03.33.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 03:33:31 -0700 (PDT)
From: William Kosasih <kosasihwilliam4@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 William Kosasih <kosasihwilliam4@gmail.com>
Subject: [PATCH v2 10/12] target/arm: Fix VST4 helper store alignment checks
Date: Tue,  1 Jul 2025 20:01:57 +0930
Message-ID: <20250701103159.62661-11-kosasihwilliam4@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250701103159.62661-1-kosasihwilliam4@gmail.com>
References: <20250701103159.62661-1-kosasihwilliam4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=kosasihwilliam4@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 target/arm/tcg/mve_helper.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 9e8ea04074..f16877ba45 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -595,6 +595,8 @@ DO_VLD2W(vld21w, 8, 12, 16, 20)
         uint16_t mask = mve_eci_mask(env);                              \
         static const uint8_t off[4] = { O1, O2, O3, O4 };               \
         uint32_t addr, data;                                            \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -606,7 +608,7 @@ DO_VLD2W(vld21w, 8, 12, 16, 20)
                 uint8_t *qd = (uint8_t *)aa32_vfp_qreg(env, qnidx + e); \
                 data = (data << 8) | qd[H1(off[beat])];                 \
             }                                                           \
-            cpu_stl_le_data_ra(env, addr, data, GETPC());               \
+            cpu_stl_mmu(env, addr, data, oi, GETPC());                  \
         }                                                               \
     }
 
@@ -620,6 +622,8 @@ DO_VLD2W(vld21w, 8, 12, 16, 20)
         uint32_t addr, data;                                            \
         int y; /* y counts 0 2 0 2 */                                   \
         uint16_t *qd;                                                   \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (beat = 0, y = 0; beat < 4; beat++, mask >>= 4, y ^= 2) {   \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -630,7 +634,7 @@ DO_VLD2W(vld21w, 8, 12, 16, 20)
             data = qd[H2(off[beat])];                                   \
             qd = (uint16_t *)aa32_vfp_qreg(env, qnidx + y + 1);         \
             data |= qd[H2(off[beat])] << 16;                            \
-            cpu_stl_le_data_ra(env, addr, data, GETPC());               \
+            cpu_stl_mmu(env, addr, data, oi, GETPC());                  \
         }                                                               \
     }
 
@@ -644,6 +648,8 @@ DO_VLD2W(vld21w, 8, 12, 16, 20)
         uint32_t addr, data;                                            \
         uint32_t *qd;                                                   \
         int y;                                                          \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -653,7 +659,7 @@ DO_VLD2W(vld21w, 8, 12, 16, 20)
             y = (beat + (O1 & 2)) & 3;                                  \
             qd = (uint32_t *)aa32_vfp_qreg(env, qnidx + y);             \
             data = qd[H4(off[beat] >> 2)];                              \
-            cpu_stl_le_data_ra(env, addr, data, GETPC());               \
+            cpu_stl_mmu(env, addr, data, oi, GETPC());                  \
         }                                                               \
     }
 
-- 
2.48.1


