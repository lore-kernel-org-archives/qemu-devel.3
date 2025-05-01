Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E62C3ABAA
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbLX-0000ls-3b; Thu, 01 May 2025 17:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLO-0000kw-J0
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:23 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLM-0001RD-SO
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:22 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3035858c687so1130342a91.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134479; x=1746739279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vMiZrybQhnZibTQU8LSA9SbCaiYLeYyCWt2XK5JV+b8=;
 b=ewPbu1PKbQlAJLKahOFvMxxPSESzZZFp/HeTfboqEaExa2V5Ub3Lhfjp6e+1B0KVoh
 C51MzH6v/8dK1ZmFZjRWz9HrZBW+er6misl6CqBML1e/0MvWS1qshpVmCSKVi/5FpZw0
 QkdDphTvZNZF4lvjVsscCFokTTpFZt+ACwFK4ymc1Gvh7mr+nsQKX+s+nIYBInV5l9Sh
 OzZMYV2it08MK0Bg4xHzSxw833atg7WPs+i4lifR7vSkMvYLFs+ezV8OKkMu9MNJMjfs
 6B9C9g6v9R8RCwJLxMrQLyL2QJ8if9K3VlwSO+8tEqPyBq07iNZQRDgD4lJpQCTLbYje
 QgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134479; x=1746739279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vMiZrybQhnZibTQU8LSA9SbCaiYLeYyCWt2XK5JV+b8=;
 b=V95okqvvXDsFGjRu/k8bN5ILZkLBvUun22QeUp20q1fb/7ymckZ35BCIxfAbxBk8KI
 WAbu11WPNo5DlnFImz4DeO4M4QzpuV4N4YVMaqJ1sqRq2EKwaMikGcF1sAJ+G0IFSqi4
 zXc65i5wJIryVnLhIA+7pSfg4aS8VLQMlAHbBI0YLkbMrRIjNiZfRNNjoR/8J36wQlUv
 7NLCn4pYZXljMewjEoA+aHirzvSHb2odYvy2SjjteBWVH2sZH8NXt42EK4JPLRjRF4ba
 3XnqyBVID6XxnQy/b/C9ml13kXgpnKmgKMUVy/FgIGMFUiD3+1EetVcnvX/vD2F9qmeC
 XuOg==
X-Gm-Message-State: AOJu0YwDURx5Q2Kqb8fzPjKYfMHYogSIOcFm4m4v7n8zVYvwzJafAtpx
 g1qud+PnRgiB6czowSQDwCM/OM08T25UVtYcZ7rO10pGLVj23oegTarPIUcPUS6p7vN0kYd3+aa
 8
X-Gm-Gg: ASbGncu4NiYvsj5ZDyXG61jbZJ+gt9UbVKncMI37qiocBVH2bND/3NTdIHBzneBg/g1
 ctEh2AMupUn7xB66oE0CWzYREDXq3ACYPpfDPC123eCpHJPbVaCYEhXbz5F/NrcGOirryOowxlA
 bjuA0jLyABmyzSaqezgZ8N6H6LReEIVQ3Skigh2zuZO75wzNXv7DwVduc3IqiobP3g6Tn1XyhVq
 Wj9/kilA0Zan7kqzI4toB+N0YcCRYt9ZLSBvfeW3Gxsi0HkiiRePheWWxdvasEWh5U3b5+cOO1w
 1pJQWrumQoi5Wa9+Bg5EjVXa418XNHJBq0YUQIdPVfo2aJA6xgcy6r4a/nniIi9UyPEz8lLjbrI
 CBTwpWwrSCA==
X-Google-Smtp-Source: AGHT+IE1BtjlHzp9t327YP79HF7tzk/uaVkQ8Jn4G+x+q70AZErzRs87pCFPCT3RJT3vLnIvC8xtDg==
X-Received: by 2002:a17:90a:dfcd:b0:2fe:b9be:216 with SMTP id
 98e67ed59e1d1-30a4e67cb68mr892205a91.31.1746134479480; 
 Thu, 01 May 2025 14:21:19 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a476267e0sm1384573a91.39.2025.05.01.14.21.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:21:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 06/59] accel/tcg: Add CPUState arg to
 tb_invalidate_phys_range_fast
Date: Thu,  1 May 2025 14:20:20 -0700
Message-ID: <20250501212113.2961531-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tb-internal.h | 5 ++---
 accel/tcg/cputlb.c      | 2 +-
 accel/tcg/tb-maint.c    | 4 ++--
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/tb-internal.h b/accel/tcg/tb-internal.h
index 1078de6c99..40439f03c3 100644
--- a/accel/tcg/tb-internal.h
+++ b/accel/tcg/tb-internal.h
@@ -45,9 +45,8 @@ void tb_unlock_pages(TranslationBlock *);
 #endif
 
 #ifdef CONFIG_SOFTMMU
-void tb_invalidate_phys_range_fast(ram_addr_t ram_addr,
-                                   unsigned size,
-                                   uintptr_t retaddr);
+void tb_invalidate_phys_range_fast(CPUState *cpu, ram_addr_t ram_addr,
+                                   unsigned size, uintptr_t retaddr);
 #endif /* CONFIG_SOFTMMU */
 
 bool tb_invalidate_phys_page_unwind(CPUState *cpu, tb_page_addr_t addr,
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index d9fb68d719..ed6de1e96e 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1340,7 +1340,7 @@ static void notdirty_write(CPUState *cpu, vaddr mem_vaddr, unsigned size,
     trace_memory_notdirty_write_access(mem_vaddr, ram_addr, size);
 
     if (!cpu_physical_memory_get_dirty_flag(ram_addr, DIRTY_MEMORY_CODE)) {
-        tb_invalidate_phys_range_fast(ram_addr, size, retaddr);
+        tb_invalidate_phys_range_fast(cpu, ram_addr, size, retaddr);
     }
 
     /*
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index c7600fc6ac..3837f2f633 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -1210,7 +1210,7 @@ void tb_invalidate_phys_range(CPUState *cpu, tb_page_addr_t start,
  * Called via softmmu_template.h when code areas are written to with
  * iothread mutex not held.
  */
-void tb_invalidate_phys_range_fast(ram_addr_t start,
+void tb_invalidate_phys_range_fast(CPUState *cpu, ram_addr_t start,
                                    unsigned len, uintptr_t ra)
 {
     PageDesc *p = page_find(start >> TARGET_PAGE_BITS);
@@ -1219,7 +1219,7 @@ void tb_invalidate_phys_range_fast(ram_addr_t start,
         ram_addr_t last = start + len - 1;
         struct page_collection *pages = page_collection_lock(start, last);
 
-        tb_invalidate_phys_page_range__locked(NULL, pages, p,
+        tb_invalidate_phys_page_range__locked(cpu, pages, p,
                                               start, last, ra);
         page_collection_unlock(pages);
     }
-- 
2.43.0


