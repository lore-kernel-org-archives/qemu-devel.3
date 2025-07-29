Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A147BC87FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 11:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugiym-0004ec-M6; Tue, 29 Jul 2025 07:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugiyL-0004Cu-Bo
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 07:58:21 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugiyD-0006HO-Qv
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 07:58:20 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3b791736d12so395140f8f.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 04:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753790291; x=1754395091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k8b/30qkT0PhlffF6po8huOnkUUESaq/pyXWD4wq1m4=;
 b=E5mJhp0RfbCXKM5/fAx4n9OW83TEoTtnFZBPnBPEeqUf/QT6EAWY1fFGAQQCXC980l
 wvEHjSI7RLvmQB2TaZqw93BcwJ29t/Cy7Jo/uoduYD8qIJxSdKTXiRqt34yUV/5xXPkp
 biRS5nP5GygaIpTOqax6+dcZsikjNezA5YYN3TNmZo7OwfA9cmqQIn8Cc9RDfhKecb27
 PUvHJEgBYaag7zCDbWgOP60zxAgp+LaC2nYx4LfDBcXbxKbPv3Ni5PkWrdEBqRI+swBo
 fTFajeWHkyZFdw3hOrShm1NG5b+9FyEhIRVUiRkNQhrkl1Ir/YvQ10dmcvj0HzhWLEEY
 Dr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753790291; x=1754395091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k8b/30qkT0PhlffF6po8huOnkUUESaq/pyXWD4wq1m4=;
 b=ePrIng0sd28ZIlWCQTDuY3cCdjTLbAf2Pxv14a3CTTSBnYgUwJHPPC3OwCHegipkLJ
 WEV//3SX7G5aGLrNncWkswJRT9w0PcOGN7XQ5h4laEIskuMHXSCUjE85jYSHnGQRPOH5
 Jfz/1P3Nr5ItVSRKOswzwk6oEPmNfgFEfkKMaK/iALT9KhrspWzvtDpLiaA3el9O/jT7
 NxE6ZCfTdE1nvJZv/sfgzeIQEkk5NErUHoD73cn+lomG6sVZfDx4Fny91SX9Uam31LCO
 Mr5sHuykrPzTEkDumEe+3h7PyrXe6iI8T/DUaf8vAt8ivl10TxxFDc6yqMcOU+EeJnbg
 fqhA==
X-Gm-Message-State: AOJu0YwkVWRM9/6BB/rqpopt85MX7FcX4nXJKyZgU29qk2cQEnK5Y98O
 4fXGgJ0dBnaxtZPgWtWRUNTZPEJHZ79ZW5UeYdSB3Y6AOs5giLQlWP4I2zU75CVjEhKpFHE0M/1
 +RP40
X-Gm-Gg: ASbGncuw6RDLMt9GslUqsPYwQcDzSvRvyNJZS73z+t35IOeccfPG4CW2sOgcPsvND4C
 bq/t3UogVDhlpqS8heOOYrAmEC0O7HdtUEnXzmudMa4GVk2ySF0l4n/WMadmNesOOphi0uYLYqS
 RfJe6qz8nCvfFJtZMlKboJMkubs83wEX6CfalRtMCrb9ZnnyYFO/yg9gjS3sAEzUOHVVeZ1q2zX
 oqW0XqFwYI6UtukhEIh3wOsO7GNtZ+HJbOqFpHsBAfPCW0K5jOBXVO3iKl3bHJdqHJZ8Ff4cyBV
 mds/nezXX9DXtJk0XWfszhLWjRSnEpq8Z28GVtnrx79Xg6lu0GTn2rd9eYUfjX7Acn1VTeRrU1c
 vXnC3SutrFIXs+Vv3KMQRVk3Pnydaskn1BJgDirIR5kHOa3ebiT0iBfZyzN09jgFFp3tvGFJf
X-Google-Smtp-Source: AGHT+IGcv1zB5f8fyr3PmL4zyH3/+aoUb06DKEhJ3IPelxqaB9MU24/8gvnIk2TUSpIeIQx7V78MJA==
X-Received: by 2002:a5d:5f8e:0:b0:3a4:e480:b5df with SMTP id
 ffacd0b85a97d-3b7766808a4mr11794943f8f.44.1753790291289; 
 Tue, 29 Jul 2025 04:58:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4588e5df43fsm22744695e9.28.2025.07.29.04.58.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Jul 2025 04:58:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-stable@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 7/9] system/physmem: fix use-after-free with dispatch
Date: Tue, 29 Jul 2025 13:57:32 +0200
Message-ID: <20250729115735.33619-8-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250729115735.33619-1-philmd@linaro.org>
References: <20250729115735.33619-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

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

It's not the first problem around this area, and commit 0d58c660689 [1]
("softmmu: Use async_run_on_cpu in tcg_commit") already tried to
address it. It did a good job, but it seems that we found a specific
situation where it's not enough.

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

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3040
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Tested-by: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <20250724161142.2803091-1-pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
2.49.0


