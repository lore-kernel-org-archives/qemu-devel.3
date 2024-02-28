Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A9BC5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 12:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIoI-0007pI-Jz; Wed, 28 Feb 2024 07:13:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hrak1529@gmail.com>)
 id 1rfF1Z-0000ce-VB
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 03:10:46 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hrak1529@gmail.com>)
 id 1rfF1Q-0001Ey-FU
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 03:10:44 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-29ae4c7da02so1117083a91.2
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 00:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709107833; x=1709712633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=bsaU8JD9jxD/cGGe3poa35jZsZ40xIaHJJ2cPGHgjLE=;
 b=kEFOemvIZyVsM+GMEwMWEXt17Jlrb7BGA6T+Ynl64bpUrpnJkgtlj3bD2WMFTBw5et
 DJ3tm9Vh59MlseTXQmuzez5ph6j3JCGA5HlLSDGHKcFQsMOXS2XblK3+i01kIPQD2Olv
 Pw90xFIT5Bxn9S0mInppBlhu+cO0ck94kpSzgG0Zuh0A3q8rFmGdEfjnoNFlrDlH/SlN
 3MYeKos9UB7Vzab1WApY6Oh6JJ3t9XdeugBpWM3VHrnuf4ZwM3SQ7p0ylykRGqpO/yqI
 DdzijLgEi4kOSJiS2WvuANcRGS+z1GnYUVRa3Fewzo8XkV9G44mL0IOEJwIjukyHtsFv
 LK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709107833; x=1709712633;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bsaU8JD9jxD/cGGe3poa35jZsZ40xIaHJJ2cPGHgjLE=;
 b=jrTE2A/1hcySK9KZPf7Syu5cQL1FFucE/NRS4LmXeG2apBXnaOhCHrwxzSoR79TEGg
 W4S5HhuYxJIZYsWfBwVd7IdRMSJvrInzDAkHJkvO+mLhf5uOTdrwJAntrONq9KvRIRPt
 q5eoV3y2FCU4UJOn31s5S2e9z5//ofCZpnmSiBMaDNzlvEo8RSHJDmowBo6AR1DXftEq
 GoZrLyUs18+szIbTGeJ2DIw2MwnndBEvQPXPk5rd4R/mUpZEGGi40OZuwnwTdnLxTlRR
 51gOfgCfJrTCZxQhHlhKdWhTPQCSLlOsK8i405Yv+yKdJVXJG4LytXNPEOf3nXhKEuhf
 civg==
X-Gm-Message-State: AOJu0YynkqArkIk2HTtJVnsWyjRfJnyOlekIjcfhY8MShU77VcA1DAaC
 5Zg2g351HzfsSLEctJDO2Hl79R7xop41lgwAhJk+H71nyiHSreDUbISzAezq
X-Google-Smtp-Source: AGHT+IFF9Fir0UebcEWIHYKiQPGHnCtK4ZOIGuVfhH5LT4Raym+EhKOiGL5zvSekbPUSWuT6h071Wg==
X-Received: by 2002:a17:90b:4f84:b0:29a:f9ad:a096 with SMTP id
 qe4-20020a17090b4f8400b0029af9ada096mr200830pjb.35.1709107832623; 
 Wed, 28 Feb 2024 00:10:32 -0800 (PST)
Received: from tpp14s.i.sslab.ics.keio.ac.jp (sslab-relay.ics.keio.ac.jp.
 [131.113.126.173]) by smtp.gmail.com with ESMTPSA id
 pq1-20020a17090b3d8100b0029a9eebf941sm918345pjb.11.2024.02.28.00.10.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 00:10:32 -0800 (PST)
From: Hiroaki Yamamoto <hrak1529@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/riscv: Fix privilege mode of G-stage translation for
 debugging
Date: Wed, 28 Feb 2024 17:10:28 +0900
Message-ID: <20240228081028.35081-1-hrak1529@gmail.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=hrak1529@gmail.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 28 Feb 2024 07:12:21 -0500
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

G-stage translation should be considered to be user-level access in riscv_cpu_get_phys_page_debug(), as already done in riscv_cpu_tlb_fill().

This fixes a bug that prevents gdb from reading memory while the VM is running in VS-mode.

Signed-off-by: Hiroaki Yamamoto <hrak1529@gmail.com>
---
 target/riscv/cpu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index d462d95ee1..6e13069da7 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1212,7 +1212,7 @@ hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 
     if (env->virt_enabled) {
         if (get_physical_address(env, &phys_addr, &prot, phys_addr, NULL,
-                                 0, mmu_idx, false, true, true)) {
+                                 0, MMUIdx_U, false, true, true)) {
             return -1;
         }
     }
-- 
2.43.2


