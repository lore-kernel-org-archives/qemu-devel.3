Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF18C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjE1-0008JN-S7; Fri, 04 Jul 2025 12:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjDw-0008DE-8U
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:16 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjDu-00065Q-F1
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:16 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-450cfb79177so6456235e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646313; x=1752251113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LybgX1UB+nJfhl1l61Dt6MY1K3LDNnbZ9wsxzeVq3jk=;
 b=sZ9cuAAnule10J5Zb15OiWQw1MBvFKtUDMkq6wuajswLERyZbB8EA1ovqH4PJhh2RE
 NmofBqKsVTVzVdF9A04CT9z2i9mYnGpJjprl95ZKMqqG3CTtjxXwdefPFSHipU8KuByO
 qbowoRi4Q/LJC9AAbhsteXdICEkANN9b78/RcD5oDmR8CIgvO/3leyf5FCBiooUPAp51
 KiZTKvwnYJIrc40TiL03AlqM0mqOKfY6A/tvMFib8TYmhJZHNf06jbgHR6WyaDZvNODp
 sXdNwC+d7lYIO8ZBv7lPGIiUZoMwgCvMVF6Z8gWaBKHVJbiAzG+TbnKLeJZEzBZL6bDg
 MgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646313; x=1752251113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LybgX1UB+nJfhl1l61Dt6MY1K3LDNnbZ9wsxzeVq3jk=;
 b=YF+F1zvX06k6aZhr0kiMsXN/cLLcbE661qsa1/aDFgXPTZlOXoOPkx5AmCopR8p6hT
 BId9gkEIjJRcJ2eyQUa9jxYOyxH3i0gJZy4anBkJZH9rc8g2ntVqKUibpP9k/uu7NkFW
 XdNqate4iGSVq4aTuX6pOioqHRIVtZGPsjz+SI3y/cPr80SgUgg7cuS4QlLt5eNoJ0H1
 jR5J9WHVCiXF9ZouboeALYmVWcEdKf9WCFsIyrDaHUlhuZ/bQZIeBYZ/38Rq85AbTYpr
 z3wvEBpGzPWBFSZL2o9RcjcnUlLlx0zG0sfwR0BYSyig+PIJN9FrK8pBoSPvO15w9SM/
 Jj2w==
X-Gm-Message-State: AOJu0YxKDXsdA5BwtDX40rY3OHC2E6msL/7V79oRJm+upuAsmP/x9OVV
 QhWuh5GUG08oWWC4HL+gOSuKfsAI4/vFRdHYb9wrnjHDK9I9U0H9KN/c184xxIr/wIT2mv7e6GC
 WFiO3
X-Gm-Gg: ASbGncuD22+Dg3o35nbXAMT+gAtL1czjG6+GG7rmSH0TDrBKurmZhqHKcnObEusBVln
 d1ZYDs+GYoRZ0g6v8mvzOm+n+tktnc2td00x9b02k6MxK7TYzfr69lMadkZfvn4Vbrjot4BJD4L
 UrCCSVmzY9wh4D/A6M9yqAvo2Pe2qimfYUAg/PEDzfeRkyv0wAXc3W0eBQxiP17C40vfo+k2uDu
 hNcMGlqNsqZv7j7NfDw2dxyLR9gSJ0JZYUwlJ+Q0RYVUrhoP3+egK0JQzA+mgM6seTxW6FESi5U
 npSHuJ/HGQ/mTunz307u2Dp9Q9UO2RwFYfB7gmAJ5dvgcDKOK73yT2OiniiEbdLJ8XzE
X-Google-Smtp-Source: AGHT+IE/axgYSuYWoNtPjwvgWbJfZ4yJftEs1iBnff07S2Y2r9uGon5gRSWG8ccedH5BDLc46i8oPw==
X-Received: by 2002:a05:600c:8209:b0:450:d37d:7c with SMTP id
 5b1f17b1804b1-454b315e413mr27022975e9.21.1751646312990; 
 Fri, 04 Jul 2025 09:25:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 010/119] target/arm: Fix VLD2 helper load alignment checks
Date: Fri,  4 Jul 2025 17:23:10 +0100
Message-ID: <20250704162501.249138-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

This patch adds alignment checks in the load operations in the VLD2
instruction.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250703085604.154449-10-kosasihwilliam4@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/mve_helper.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 7069910db4a..7473dfad2d2 100644
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
2.43.0


