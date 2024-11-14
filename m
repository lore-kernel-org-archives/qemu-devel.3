Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBEAD68B34
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcJ3-0005Ye-G1; Thu, 14 Nov 2024 11:02:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcI3-0004z8-Mr
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:51 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcHz-0002Di-O9
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:50 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7f3da2c2cb5so599530a12.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600104; x=1732204904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OAfTvQFTjKDkcAxt0Vto6R9Rpfvm8uCUUQSgIj7Y47Q=;
 b=IpdOpTmOclxCy1T6xFdK2s54qeIGfMEv+vgNHqFsC7Tp/x3jsHdno46cLLkxN8DWi2
 xUl8tjWXteO7qBqw4kWX2dww/7TwbK9EFThNRC+mdApAIgWXmlkKInNXbj886hL9y7XI
 YSFGNkeCe1FEqaKdCRUn6PxbaAeoRMixo7a4uQ389hn75C4uKpfHoJFiqjtxW8tpKcgb
 Uj+7YOHyHoYfUNf+JdAgvtCxzsz9RBxt2PlrL9A+5G80yDmfYG6eLQlBGfvTfsAcrh9T
 qOanoCPcAQjpQ2hkRNMvMXWy+7zNtTZBID2gJsUCawbWlQczp3puoDncbEax8OvG28ij
 jAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600104; x=1732204904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OAfTvQFTjKDkcAxt0Vto6R9Rpfvm8uCUUQSgIj7Y47Q=;
 b=bml73z9o+mvbU94PIUr4oXB7pnyZ2qWIKtMALgWRywTFqh3Hzw/xTCgSEF+GsWLeAV
 s0MpFRyC0AsR+W8hvvgBFAgGzPSeY+pWKgH2xSIjG+qqNV41Ilf//v/shNvmeNM8aDbq
 z74fiPFjZFV9CjFaR9NcTbGHE3OsCz17XxMGEI6YgGFJ0QAwcAjUFEFxfDoKZU/KmH/W
 kFn5uQvi4x46g+oFxxtdqVeuSVtaRGaK3YPjGgEOc+QcoEen27EbN+bLlYHvz3qSL+e7
 Tlr6LDdVID9amtM1zpqyUITyZxOk5/9pMe9gekad9upk2Qq2kMq0jjID0fz5I4A+B4/a
 MUQw==
X-Gm-Message-State: AOJu0YwjPggoKVoLTsmHrfNBNpdOF4HPB8oXNT4ft5MhHgV1VjL4trTA
 wC9oyPIfK+2Zu9sTzPmAEUpKhJMTvgApZAonjLU1x0Kt5jkNKFwzQsm/n4PmElVNPFwKEC9Z1nI
 f
X-Google-Smtp-Source: AGHT+IEOa93NnKnA/1J0YX+utX824qtojXl7jMeiG9CZxZM2GsxmTSwtBWUaN/IGBsyoQKPQ09eaHw==
X-Received: by 2002:a17:90b:4c06:b0:2e2:cd11:c9b with SMTP id
 98e67ed59e1d1-2e9b16eb849mr30900735a91.3.1731600104353; 
 Thu, 14 Nov 2024 08:01:44 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024ec723sm1484438a91.46.2024.11.14.08.01.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:01:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 16/54] accel/tcg: Pass full addr to victim_tlb_hit
Date: Thu, 14 Nov 2024 08:00:52 -0800
Message-ID: <20241114160131.48616-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

Do not mask the address to the page in these calls.
It is easy enough to use a different helper instead.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 7ecd327297..3aab72ea82 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1387,7 +1387,7 @@ static void io_failed(CPUState *cpu, CPUTLBEntryFull *full, vaddr addr,
 /* Return true if ADDR is present in the victim tlb, and has been copied
    back to the main tlb.  */
 static bool victim_tlb_hit(CPUState *cpu, size_t mmu_idx, size_t index,
-                           MMUAccessType access_type, vaddr page)
+                           MMUAccessType access_type, vaddr addr)
 {
     size_t vidx;
 
@@ -1395,7 +1395,7 @@ static bool victim_tlb_hit(CPUState *cpu, size_t mmu_idx, size_t index,
     for (vidx = 0; vidx < CPU_VTLB_SIZE; ++vidx) {
         CPUTLBEntry *vtlb = &cpu->neg.tlb.d[mmu_idx].vtable[vidx];
 
-        if (tlb_hit_page(tlb_read_idx(vtlb, access_type), page)) {
+        if (tlb_hit(tlb_read_idx(vtlb, access_type), addr)) {
             /* Found entry in victim tlb, swap tlb and iotlb.  */
             CPUTLBEntry tmptlb, *tlb = &cpu->neg.tlb.f[mmu_idx].table[index];
 
@@ -1448,13 +1448,12 @@ static int probe_access_internal(CPUState *cpu, vaddr addr,
     uintptr_t index = tlb_index(cpu, mmu_idx, addr);
     CPUTLBEntry *entry = tlb_entry(cpu, mmu_idx, addr);
     uint64_t tlb_addr = tlb_read_idx(entry, access_type);
-    vaddr page_addr = addr & TARGET_PAGE_MASK;
     int flags = TLB_FLAGS_MASK & ~TLB_FORCE_SLOW;
     bool force_mmio = check_mem_cbs && cpu_plugin_mem_cbs_enabled(cpu);
     CPUTLBEntryFull *full;
 
-    if (!tlb_hit_page(tlb_addr, page_addr)) {
-        if (!victim_tlb_hit(cpu, mmu_idx, index, access_type, page_addr)) {
+    if (!tlb_hit(tlb_addr, addr)) {
+        if (!victim_tlb_hit(cpu, mmu_idx, index, access_type, addr)) {
             if (!tlb_fill_align(cpu, addr, access_type, mmu_idx,
                                 0, fault_size, nonfault, retaddr)) {
                 /* Non-faulting page table read failed.  */
@@ -1734,8 +1733,7 @@ static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data, MemOp memop,
 
     /* If the TLB entry is for a different page, reload and try again.  */
     if (!tlb_hit(tlb_addr, addr)) {
-        if (!victim_tlb_hit(cpu, mmu_idx, index, access_type,
-                            addr & TARGET_PAGE_MASK)) {
+        if (!victim_tlb_hit(cpu, mmu_idx, index, access_type, addr)) {
             tlb_fill_align(cpu, addr, access_type, mmu_idx,
                            memop, data->size, false, ra);
             maybe_resized = true;
@@ -1914,8 +1912,7 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
     /* Check TLB entry and enforce page permissions.  */
     flags = TLB_FLAGS_MASK;
     if (!tlb_hit(tlb_addr_write(tlbe), addr)) {
-        if (!victim_tlb_hit(cpu, mmu_idx, index, MMU_DATA_STORE,
-                            addr & TARGET_PAGE_MASK)) {
+        if (!victim_tlb_hit(cpu, mmu_idx, index, MMU_DATA_STORE, addr)) {
             tlb_fill_align(cpu, addr, MMU_DATA_STORE, mmu_idx,
                            mop, size, false, retaddr);
             did_tlb_fill = true;
-- 
2.43.0


