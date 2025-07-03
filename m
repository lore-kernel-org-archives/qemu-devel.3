Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFA9C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 08:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXFkt-0003gT-SQ; Thu, 03 Jul 2025 04:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uXFkn-0003TU-4T; Thu, 03 Jul 2025 04:57:13 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uXFkk-0008HL-Dg; Thu, 03 Jul 2025 04:57:12 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-742c7a52e97so7473886b3a.3; 
 Thu, 03 Jul 2025 01:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751533027; x=1752137827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TdpPRtQvmGX5FMXgJZ9zxoWkisAb+D1p74rPq+2zohI=;
 b=XekqtNL6GOgCFT5wR45UNgAccRX7OceNTYfxrW1p9ql5x0DJ/me2R++0GWZmXHN5wa
 IxvjOEE1Sbhhp3gxVHe1ARafjhjs03D/lWfrA7NX69/jEcKiO/RhgZNZv84GrVbjgngI
 YxArWbNcpK7gKElOPj9QR7MhT+KmGDmwNgXwAKMmtw7ZZCpz385xcerr7CYv//yt0Xj0
 AJmtWoDpb0hV0G8mZldURI8KXlzoPd3R3ZaX6AE0uWRiCD/rlUNeA/sl7gw9dhsx3A2O
 7avRDTEbhpzBrtKtL1zn/h0qKJO+RO1hCBVxrnR5tz/yibP7yUU2IL42C2VupADQJi8D
 jJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751533027; x=1752137827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TdpPRtQvmGX5FMXgJZ9zxoWkisAb+D1p74rPq+2zohI=;
 b=R6+kmSu6xlFmY/hq2onzwXVK3DzJk8D5EZWAWKNGxPa/QKfLQM8ssz4gVzOFf24mWv
 sp+KPYA04zpumjihdY0eWIx1KicPtuUK2/ZoI90/5z3fVrymky/DzggLHFbVgm+naixh
 piYCkSmnm8hC1j5XtH/SZNUgzyIVdXY20NA1sOL1IPjmWQUIRSragjRbaN35oF+eBAjq
 XWNSWD0C7NCL6hV5nWNgr/rOuSIzeNizAWUmuaH8AMEdBZpw5smIxtGwIz7e451th9UA
 2NdX4JrG497hq+9IEV143lIDLsG5+4bIm+GLI+SY6OPvqBWsjo+1vlViZlS44coecC6U
 X7vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8GLzZGm8I+tbMsPrm8FjRRQmdz/kCc6AsR8xPY+YQ1TsoljJsHl2JVsMm+2TlQNGTUs5ZglLnJw==@nongnu.org
X-Gm-Message-State: AOJu0YxZZI/kq0SN+L7QpvQbXf1C2WjCkMTyrImkwsX7YMATddgo6mkX
 PQgy42nrK+yNZAEWnCnn9Me3Su53gecFZyXlAEq8V/Pi1OTR7EHz5kJ41YJ7qErPulk=
X-Gm-Gg: ASbGnctdg2ecKqKV7Zatbx15l10f6XfrtsjHqvkiSF6V+mHyqE4obsRS1235sR9xoXk
 1CYy2g1TpxEkFAtRC8ZkHdsyjIjxjhku9jHJ417AuWYLlKHuLDtIYDmZSoTLZg0xx5biHkcjhYA
 B355LHIpX/bZPxpQHBWQt6UtN5/iqpW49Ngjoh+o0Gu9YsQBfXwkWCtJfw1Mwu3hS76/ye5SuUV
 mPKHMmJvj/cjeFmILmHJuy6bgsy60sgN0OkFDktdO+5tzScRJ0mlJ+7edkCmQlJujRum15xpDf9
 7V0wDt8lIsUEmSxsLcsauX/Qoc/vdnZeZIMuzsNsQ/Gg74O1i9HsVTZ1QyYIOxB991DoWokSxMr
 Epdxb28r1p/Yx5SRbZbU2EojB+MbZyeNI3EGg2nCRatE=
X-Google-Smtp-Source: AGHT+IFbX7YcSUfog4QzLnbphQVSoqksthcJcJ548UG/PpRApEA+r8WSBFSqaCQ1O8QPkEnpFKQ58Q==
X-Received: by 2002:a05:6a00:228f:b0:749:bc7:1577 with SMTP id
 d2e1a72fcca58-74c99830bb7mr2772559b3a.9.1751533027005; 
 Thu, 03 Jul 2025 01:57:07 -0700 (PDT)
Received: from localhost (pa49-178-74-199.pa.nsw.optusnet.com.au.
 [49.178.74.199]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-74af557790dsm16476366b3a.100.2025.07.03.01.57.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 01:57:06 -0700 (PDT)
From: William Kosasih <kosasihwilliam4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 William Kosasih <kosasihwilliam4@gmail.com>
Subject: [PATCH v4 11/11] target/arm: Fix VST2 helper store alignment checks
Date: Thu,  3 Jul 2025 18:26:04 +0930
Message-ID: <20250703085604.154449-12-kosasihwilliam4@gmail.com>
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

This patch adds alignment checks in the store operations in the VST2
instruction.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/mve_helper.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 5273411389..42bb3b979b 100644
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
2.48.1


