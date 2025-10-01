Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58833CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3ySR-0004NX-RQ; Wed, 01 Oct 2025 11:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3ySM-0004HN-ES
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:09:26 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3yQO-0000rH-O0
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:09:26 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e2c3b6d4cso56538375e9.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 08:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759331234; x=1759936034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AoPTdg5MwxI4gUrOUKUWisdEEc5+5afMb5BWjaZNRgo=;
 b=ssUBkp0QeGEDnWPL6KPrBCD9w1eJOiMDYWR9p5u3R9v6/U+eMNp7hnpFO4dVhpNLB9
 ui+r38KglthQnSA+/LQPPCwcIU7ymQq8QV3k4o8GiJmoZa5l07tl5g53z7O4YnDFWqG7
 U0DPnQPwwcrxUCOucic3Kl+pjXzgJl1X97RAght4T8G6WtKzDLbl3airma8NemJvAA9R
 UrjkXoK6vmUstXQ2zyCk17lQnwPazDW1j8xlZQjowG8kX7U5MEdKvU6PxSyFPUhvr7DA
 7qwZo7bf9+88u7437HuwQy+l3CLtiTzmM52B9JAcauidovix6Et535LxymVDAibWhOO1
 B3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759331234; x=1759936034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AoPTdg5MwxI4gUrOUKUWisdEEc5+5afMb5BWjaZNRgo=;
 b=sENMJw5R+40/IgAzQAIzZACJ1hPYyQxorvU6BLgZocMtOwE0Ye3RrLAvWwzOGsa93J
 gbRFm9+EvTcAcDfID2dWHeFTj9bssEzh1pyiiHYx0P5+pB6sQLgjXIS4Om8PT9R+Yg8s
 A6eXDqWp7tyxDhq71k816CMCWVrR/Nn387ExuvjCb+N08ql6WE/5Ngdwd1z9NSYX5Ngs
 KPcMKhRze+vUNuqigwNle8h1Vt9g3zVMgnTM2Ffe1QkKMjNNavUMSK0ytLasGTS3uDN5
 O05iSNxRS6tbL+NhqjdX57liH6GIZ0EphmPjdtNWVbEjBwR84fyuzcyotaVA1u8r11jl
 qoYg==
X-Gm-Message-State: AOJu0YyI/qU3g2j1buwL+4C3xiYtUL94GfrJo1IQ5IutsPkdROqVjWUg
 53AbRUpcWnOioPDHtz1RY3KS3/jec2pf6qScPGDespCVx4zkVlnOeNvJq4rlp9+8QTc6mSpY8W2
 rG2PJOQtghw==
X-Gm-Gg: ASbGncvGldlIOusoHnPRTaeJ/QM4D1LYfDHw+uXW0QQcV4ZY0UrmCrUl+WpK4DrDNuT
 NKQP74NsmN7L3DE1CLlGAcQt7EcQ+gkc/LDskFc+NKQnDOSOWvmht/Wv5s9n95dSm/5Mvhxis9I
 O3zplXwr92hh1KOovooEc4NZlgsF2K+W19UpDoAXOCGNZIjxCiYiDiOnWkhWP6SbPuiAlM0pDaE
 YA9jHcdj4dJQ+YakmNh0oFqtg2hQ64QyNpYM0eEzoBO9Omaq/Z4odIN0Xpc1diOJrePIJBzHquG
 IGxyrQcoNwKUGz97udmwq8xcg0p/Wx/0iuWj8oBbaX8p9UJ4fEKGzUgzlaPPCro2j4dnfMJaKip
 J8rLDr9aY2mFNYHmWFkSmt3xDQeTjSxbDT1xTSRKQMg233IycbtN+ciHFx2zsYrZh+X2X7FRY7O
 9oOuKvpGQWpa2Xc192v3xF
X-Google-Smtp-Source: AGHT+IG4XxMj0/+XRjkxBKqGWeT9h7Y0BLEBnyZwHWXRoLQtC3MKtNYoHlq4F6Q4cvmSoGl7zqJatA==
X-Received: by 2002:a05:600c:6094:b0:45d:d88b:cca with SMTP id
 5b1f17b1804b1-46e6125cf67mr30505065e9.1.1759331233664; 
 Wed, 01 Oct 2025 08:07:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e611970easm25177495e9.2.2025.10.01.08.07.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 08:07:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH 20/22] hw/core/cpu: Remove @CPUState::as field
Date: Wed,  1 Oct 2025 17:05:25 +0200
Message-ID: <20251001150529.14122-21-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001150529.14122-1-philmd@linaro.org>
References: <20251001150529.14122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

All code now get the vcpu first address space using
cpu_get_address_space(). Nothing uses the CPUState::as
field anymore: remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h |  3 ---
 hw/core/cpu-common.c  |  1 -
 system/cpus.c         |  2 +-
 system/physmem.c      | 10 ----------
 4 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index c9f40c25392..0f7eda1a10d 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -443,8 +443,6 @@ struct qemu_work_item;
  * @cpu_ases: Pointer to array of CPUAddressSpaces (which define the
  *            AddressSpaces this CPU has)
  * @num_ases: number of CPUAddressSpaces in @cpu_ases
- * @as: Pointer to the first AddressSpace, for the convenience of targets which
- *      only have a single AddressSpace
  * @gdb_regs: Additional GDB registers.
  * @gdb_num_regs: Number of total registers accessible to GDB.
  * @gdb_num_g_regs: Number of registers in GDB 'g' packets.
@@ -517,7 +515,6 @@ struct CPUState {
     struct CPUAddressSpace *cpu_ases;
     int cpu_ases_count;
     int num_ases;
-    AddressSpace *as;
     MemoryRegion *memory;
 
     struct CPUJumpCache *tb_jmp_cache;
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 41a339903ca..e46863d9e1d 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -307,7 +307,6 @@ static void cpu_common_initfn(Object *obj)
 
     cpu->cpu_index = UNASSIGNED_CPU_INDEX;
     cpu->cluster_index = UNASSIGNED_CLUSTER_INDEX;
-    cpu->as = NULL;
     cpu->num_ases = 0;
     /* user-mode doesn't have configurable SMP topology */
     /* the default value is changed by qemu_init_vcpu() for system-mode */
diff --git a/system/cpus.c b/system/cpus.c
index aa7bfcf56e5..ecd025a611d 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -704,7 +704,7 @@ void qemu_init_vcpu(CPUState *cpu)
     cpu->stopped = true;
     cpu->random_seed = qemu_guest_random_seed_thread_part1();
 
-    if (!cpu->as) {
+    if (cpu->num_ases == 0) {
         /* If the target cpu hasn't set up any address spaces itself,
          * give it the default one.
          */
diff --git a/system/physmem.c b/system/physmem.c
index b245cd14d43..31286b3c13f 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -791,11 +791,6 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
     /* Target code should have set num_ases before calling us */
     assert(asidx < cpu->num_ases);
 
-    if (asidx == 0) {
-        /* address space 0 gets the convenience alias */
-        cpu->as = as;
-    }
-
     if (!cpu->cpu_ases) {
         cpu->cpu_ases = g_new0(CPUAddressSpace, cpu->num_ases);
         cpu->cpu_ases_count = cpu->num_ases;
@@ -827,11 +822,6 @@ void cpu_address_space_destroy(CPUState *cpu, int asidx)
     address_space_destroy(cpuas->as);
     g_free_rcu(cpuas->as, rcu);
 
-    if (asidx == 0) {
-        /* reset the convenience alias for address space 0 */
-        cpu->as = NULL;
-    }
-
     if (--cpu->cpu_ases_count == 0) {
         g_free(cpu->cpu_ases);
         cpu->cpu_ases = NULL;
-- 
2.51.0


