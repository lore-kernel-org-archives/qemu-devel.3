Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE01C83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 16:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueyZA-0007RD-Gk; Thu, 24 Jul 2025 12:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ueyY0-0005Lr-1U
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 12:11:58 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ueyXw-0005HD-Ei
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 12:11:55 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2353a2bc210so11861835ad.2
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 09:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753373510; x=1753978310; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mCaLPkN3ohgTzVMHrTi60qnm+SLpGkWz5fE/sVOTQYs=;
 b=fiDSV3cpcaU0OrRv3Xuuq8bMWTCrTvvShULyF18NtoYDgrtQkwW0q7hEPeqUmXkDQM
 KO67TXUzdFFpZ1doCC/HQF9aSNYydSVdSdFXe/dDFMD4Qky5jrDibUl02OQZQmUwrgvC
 JWyDwHJ3VcjzJDKEXRJKiGUuV5C+6VQmT3HJntIhtBO+tyV/LQ7jjxVADnXtizpZCud5
 W+1/KN1g0DiweDi/0co3gSG0v62L8TqhHXkUlZPtw+lQk31/Aijv8umTQA0q6O8tHZK9
 XUgDC+NIqWfsVCUAR/2ajVbxnJp+S4DLYrSTft4uOp2lbonhvBAKYSxgDRgIhIEuSEo4
 JacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753373510; x=1753978310;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mCaLPkN3ohgTzVMHrTi60qnm+SLpGkWz5fE/sVOTQYs=;
 b=B1JPKy09zjNdeP8JzbvGraK934GeXnoHSfY65DZ9VM/p2b6ZgV8rNeJ4Z4ZYhVZq1q
 fLWPs7ILyp9BDtX/y4nLqHUS9vbn7ARz76h96o3MPU9ZPnOe8/N6QqQ+eR2O49UJiAuU
 Da2mUoVKxMypQl/HB85SHGbOetOgioipEmCvHugJ3Aa3UI2njKwzjhySk16nQIookYiz
 05a2fxl1Qnv6Xi4c+X40Ga1YQ7rqTs4vjGAQ9G75tZhvug0TjePR23NqM6dyFehamnnG
 DittVXVK+HlGg8/zY5xPVnm4a2b4FO147+y1hmoYjNpf0kCeNMNH2RsGjKaV8+M/fC1J
 fZhQ==
X-Gm-Message-State: AOJu0YxtHFr2h6t4kBZTERVdpfFiBZoDrfGzoGxnV4usHNO4khBVKTjU
 BhlvgQLzGuPd761NOkyrtRYX5gotJvUKk5BV9/9bAP+gDUcJ+ZmA2KiVIwPulgjOt9x26HutxwD
 mU3zR
X-Gm-Gg: ASbGncvkPPVUJk5fr+evYfSM8bjduZxLifewq4G1BrEVXeg0tD2C7Y0iDjUjgU3hbj7
 d8qV49JucKYuDt0idu7f5pJir1sAgGV9/OIbTcQjZEx/1p9N76ihv+sgznrlM4X74Rht+aEy0rW
 TYrIg7K9wJ+Ej18V2D+k1heXnIfCB58jXTcbXLP6p/pkk/CdNF9TbMELfmTa1Cb7PTsXBU+ZseD
 3qaczpA/NpFyw1f3A5Mu+uYK7r8/W5GRQcxmEEje/eOpdTj1hXe9q4vF7wquXeJhL8cMO4icfxl
 5fbsjeZGMIFbQ4cA2fCe6U1/0o4AH2+J3ol0BhwYqu61wuIYKftaXkubFuRoAmFab7xEcKAIOJr
 WRppYfi2vsEDkBnFxj8EOEEQgdFj8iWSZ
X-Google-Smtp-Source: AGHT+IHR9XpcPyw4JMiCf/4RCt/MNJUEg2DhLFAgJva98oIlJVg3fzHkuaZ0GlRWKLOVz0HWb3JnPw==
X-Received: by 2002:a17:902:c409:b0:234:c8f6:1b05 with SMTP id
 d9443c01a7336-23f9824cb15mr88565665ad.52.1753373509897; 
 Thu, 24 Jul 2025 09:11:49 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fa48f03e3sm18835925ad.156.2025.07.24.09.11.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 09:11:49 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] system/physmem: fix use-after-free with dispatch
Date: Thu, 24 Jul 2025 09:11:42 -0700
Message-ID: <20250724161142.2803091-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

A use-after-free bug was reported when booting a Linux kernel during the
pci setup phase. It's quite hard to reproduce (needs smp, and favored by
having several pci devices with BAR and specific Linux config, which
is Debian default one in this case).

After investigation (see the associated bug ticket), it appears that,
under specific conditions, we might access a cached AddressSpaceDispatch
that was reclaimed by RCU thread meanwhile.
In the Linux boot scenario, during the pci phase, memory region are
destroyed/recreated, resulting in exposition of the bug.

The core of the issue is that we cache the dispatch associated to
current cpu in cpu->cpu_ases[asidx].memory_dispatch. It is updated with
tcg_commit, which runs asynchronously on a given cpu.
At some point, we leave the rcu critial section, and the RCU thread
starts reclaiming it, but tcg_commit is not yet invoked, resulting in
the use-after-free.

It's not the first problem around this area, and this patch [1] already
tried to address it. It did a good job, but it seems that we found a
specific situation where it's not enough.

This patch takes a simple approach: remove the cached value creating the
issue, and make sure we always get the current mapping for address
space, using address_space_to_dispatch(cpu->cpu_ases[asidx].as).
It's equivalent to qatomic_rcu_read(&as->current_map)->dispatch;
This is not really costly, we just need two dereferences,
including one atomic (rcu) read, which is negligible considering we are
already on mmu slow path anyway.

Note that tcg_commit is still needed, as it's taking care of flushing
TLB, removing previously mapped entries.

Another solution would be to cache directly values under the dispatch
(dispatch themselves are not ref counted), keep an active reference on
associated memory section, and release it when appropriate (tricky).
Given the time already spent debugging this area now and previously, I
strongly prefer eliminating the root of the issue, instead of adding
more complexity for a hypothetical performance gain. RCU is precisely
used to ensure good performance when reading data, so caching is not as
beneficial as it might seem IMHO.

[1] https://gitlab.com/qemu-project/qemu/-/commit/0d58c660689f6da1e3feff8a997014003d928b3b

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3040
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 system/physmem.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 130c148ffb5..e5dd760e0bc 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -165,13 +165,11 @@ static bool ram_is_cpr_compatible(RAMBlock *rb);
  * CPUAddressSpace: all the information a CPU needs about an AddressSpace
  * @cpu: the CPU whose AddressSpace this is
  * @as: the AddressSpace itself
- * @memory_dispatch: its dispatch pointer (cached, RCU protected)
  * @tcg_as_listener: listener for tracking changes to the AddressSpace
  */
 typedef struct CPUAddressSpace {
     CPUState *cpu;
     AddressSpace *as;
-    struct AddressSpaceDispatch *memory_dispatch;
     MemoryListener tcg_as_listener;
 } CPUAddressSpace;
 
@@ -692,7 +690,7 @@ address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr orig_addr,
     IOMMUTLBEntry iotlb;
     int iommu_idx;
     hwaddr addr = orig_addr;
-    AddressSpaceDispatch *d = cpu->cpu_ases[asidx].memory_dispatch;
+    AddressSpaceDispatch *d = address_space_to_dispatch(cpu->cpu_ases[asidx].as);
 
     for (;;) {
         section = address_space_translate_internal(d, addr, &addr, plen, false);
@@ -753,7 +751,7 @@ MemoryRegionSection *iotlb_to_section(CPUState *cpu,
 {
     int asidx = cpu_asidx_from_attrs(cpu, attrs);
     CPUAddressSpace *cpuas = &cpu->cpu_ases[asidx];
-    AddressSpaceDispatch *d = cpuas->memory_dispatch;
+    AddressSpaceDispatch *d = address_space_to_dispatch(cpuas->as);
     int section_index = index & ~TARGET_PAGE_MASK;
     MemoryRegionSection *ret;
 
@@ -2780,9 +2778,6 @@ static void tcg_log_global_after_sync(MemoryListener *listener)
 
 static void tcg_commit_cpu(CPUState *cpu, run_on_cpu_data data)
 {
-    CPUAddressSpace *cpuas = data.host_ptr;
-
-    cpuas->memory_dispatch = address_space_to_dispatch(cpuas->as);
     tlb_flush(cpu);
 }
 
@@ -2798,11 +2793,7 @@ static void tcg_commit(MemoryListener *listener)
     cpu = cpuas->cpu;
 
     /*
-     * Defer changes to as->memory_dispatch until the cpu is quiescent.
-     * Otherwise we race between (1) other cpu threads and (2) ongoing
-     * i/o for the current cpu thread, with data cached by mmu_lookup().
-     *
-     * In addition, queueing the work function will kick the cpu back to
+     * Queueing the work function will kick the cpu back to
      * the main loop, which will end the RCU critical section and reclaim
      * the memory data structures.
      *
-- 
2.47.2


