Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB852C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 03:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW6JI-0003Vs-NM; Mon, 22 Jul 2024 23:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW6JH-0003Pm-4a
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 23:35:31 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW6JF-0001za-8p
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 23:35:30 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3d9bcb47182so2979608b6e.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 20:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721705728; x=1722310528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LQzguNqg29abBGKUeSrC6IOQ1lzCyJlmW94ab8MjDZo=;
 b=wcnUPsoExxpvoiIYJY583a5bwQzgtXSE54eU8ndkmv/5H+vhHYyDqckAiWYUk6zaVQ
 5rYGFoNNZX16oMyMwu625Ydb6RGSLnNJR4VoP1KOD5vrD0eI0aLb9cfh2Y4o8ZS6d6Et
 OOylX99ERSJ9RjEMzKYh0tKqIM/vSSVwnfAFG9tJ6hKNlFcsDpVOopIyxH+LMhvWSK+l
 CE3RfQp2WTyhDLwOGN4uT0LOJkLMPDtAYc4tvwTkmqDlmwEdbdEiz0hvqW2mQ/uSavTz
 OC4Vvb9/ZzbECRP/SANU3XMn2obUp1qh3YIKvNlfEFJ7JHyZ41sD6KL/vGrWK3u75Lmr
 06Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721705728; x=1722310528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LQzguNqg29abBGKUeSrC6IOQ1lzCyJlmW94ab8MjDZo=;
 b=fSc8bu7hEY+mctBNt9Pj+XOmJUberTr6EqMfb8s5s5En6dsNDmRFsvalR+y/OLEZsN
 m7ej/jNYpv5l7gzhsRgT23VEJukclTsiMD/Vxt6rhiBkZ09ji1eSuZjinq9FQb3DNGIJ
 b9ivgNdy+DE9uN34n7Kc3ytBESx+2/r+aP34SVal5oz6oUPVfOQTu2LoqkWdj5TQtclu
 dLA8Ztcw6NqURmej2tRtvOlVdZ9rc4Bl/s0qLxMrvqKzSbozkWbeHUlg8MqUkwS4o/Ra
 6Lzg3u8ITCUFvyb9NmLW/upRQPfQe7TSh5FZ373GHJkRqOx+wKsOZjPPg9Oc9mK3Amfl
 5xvQ==
X-Gm-Message-State: AOJu0Yy1/DmQlTkLRRM1WI2TnMGs+3aIbk1s4rP3empv+ne9mK+pZfq7
 EtRtzdM+Ymp0v/gjKlv8iLKYClyTWRm0d87RLaaIfU5SNZ6U/dAG/HsofOsWf0XnuZkkIBWHurO
 shKGLQg==
X-Google-Smtp-Source: AGHT+IERWCpGPSUH4boHPNMrzuCxGv6Fu0/iiUrqA7MKU+Y29WjKhCTonB0SOHfQu+bs2yL+Fo/YeQ==
X-Received: by 2002:a05:6808:189e:b0:3d6:3000:9ab3 with SMTP id
 5614622812f47-3dae97dfbfdmr12513773b6e.40.1721705727691; 
 Mon, 22 Jul 2024 20:35:27 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70d2b96bfcasm2171380b3a.87.2024.07.22.20.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 20:35:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Max Chou <max.chou@sifive.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 12/12] target/riscv: Simplify probing in vext_ldff
Date: Tue, 23 Jul 2024 13:34:51 +1000
Message-ID: <20240723033451.546151-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240723033451.546151-1-richard.henderson@linaro.org>
References: <20240723033451.546151-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
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

The current pairing of tlb_vaddr_to_host with extra is either
inefficient (user-only, with page_check_range) or incorrect
(system, with probe_pages).

For proper non-fault behaviour, use probe_access_flags with
its nonfault parameter set to true.

Reviewed-by: Max Chou <max.chou@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/vector_helper.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 1b4d5a8e37..10a52ceb5b 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -474,7 +474,6 @@ vext_ldff(void *vd, void *v0, target_ulong base,
           vext_ldst_elem_fn *ldst_elem,
           uint32_t log2_esz, uintptr_t ra)
 {
-    void *host;
     uint32_t i, k, vl = 0;
     uint32_t nf = vext_nf(desc);
     uint32_t vm = vext_vm(desc);
@@ -493,27 +492,31 @@ vext_ldff(void *vd, void *v0, target_ulong base,
         }
         addr = adjust_addr(env, base + i * (nf << log2_esz));
         if (i == 0) {
+            /* Allow fault on first element. */
             probe_pages(env, addr, nf << log2_esz, ra, MMU_DATA_LOAD);
         } else {
-            /* if it triggers an exception, no need to check watchpoint */
             remain = nf << log2_esz;
             while (remain > 0) {
+                void *host;
+                int flags;
+
                 offset = -(addr | TARGET_PAGE_MASK);
-                host = tlb_vaddr_to_host(env, addr, MMU_DATA_LOAD, mmu_index);
-                if (host) {
-#ifdef CONFIG_USER_ONLY
-                    if (!page_check_range(addr, offset, PAGE_READ)) {
-                        vl = i;
-                        goto ProbeSuccess;
-                    }
-#else
-                    probe_pages(env, addr, offset, ra, MMU_DATA_LOAD);
-#endif
-                } else {
+
+                /* Probe nonfault on subsequent elements. */
+                flags = probe_access_flags(env, addr, offset, MMU_DATA_LOAD,
+                                           mmu_index, true, &host, 0);
+
+                /*
+                 * Stop if invalid (unmapped) or mmio (transaction may fail).
+                 * Do not stop if watchpoint, as the spec says that
+                 * first-fault should continue to access the same
+                 * elements regardless of any watchpoint.
+                 */
+                if (flags & ~TLB_WATCHPOINT) {
                     vl = i;
                     goto ProbeSuccess;
                 }
-                if (remain <=  offset) {
+                if (remain <= offset) {
                     break;
                 }
                 remain -= offset;
-- 
2.43.0


