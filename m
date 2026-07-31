Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C48EC5516D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 05:58:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpgFe-0002hJ-Os; Fri, 31 Jul 2026 01:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <blduan@linux.alibaba.com>)
 id 1wpeM5-0005rD-T3; Thu, 30 Jul 2026 23:56:18 -0400
Received: from [115.124.30.110] (helo=out30-110.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <blduan@linux.alibaba.com>)
 id 1wpeM0-0002Hx-Dm; Thu, 30 Jul 2026 23:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1785470160; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=15tpbU1mysjnRBqCkIU57nhoO42MnKRFA/va3zirTrU=;
 b=VSmTtRMZvWR9SdOeFy5R0kDUZFi64Kkk3gbRKjnmVWmDlm5aXmbwzn2Jsn4xTNJ7boVb0cr3E5OTr6KGxH479L7cl0dvQ+kTOCGPi1I9jMzXGWPhaIQFDVVJgSast0g38EFZpJ4k3MwM6dTbrjxN0JiTThqxHwRxv3PrFK+8SaI=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045133197;
 MF=blduan@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0X86jwRu_1785469848; 
Received: from ea134-sw16.eng.xrvm.cn(mailfrom:blduan@linux.alibaba.com
 fp:SMTPD_---0X86jwRu_1785469848 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 31 Jul 2026 11:50:49 +0800
From: Baolong Duan <blduan@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair23@gmail.com, dbarboza@ventanamicro.com,
 cxx194832@alibaba-inc.com, zengxiangyi.zxy@alibaba-inc.com,
 Baolong Duan <blduan@linux.alibaba.com>
Subject: [RFC PATCH v1 04/17] accel/kvm: add kvm_gpa_to_userspace_addr()
Date: Fri, 31 Jul 2026 11:49:58 +0800
Message-Id: <20260731035011.4178103-5-blduan@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731035011.4178103-1-blduan@linux.alibaba.com>
References: <20260731035011.4178103-1-blduan@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.110 (deferred)
Received-SPF: pass client-ip=115.124.30.110;
 envelope-from=blduan@linux.alibaba.com;
 helo=out30-110.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 31 Jul 2026 01:57:32 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Translate a guest physical address into the host userspace address
backing it by walking the memory slots of the accelerator.

The RISC-V CoVE code needs this to tell the TSM which host memory holds
the guest images that have to be measured.

Signed-off-by: Baolong Duan <blduan@linux.alibaba.com>
---
 accel/kvm/kvm-all.c  | 21 +++++++++++++++++++++
 include/system/kvm.h | 18 ++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 83cbd120a8..005abb1c54 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -366,6 +366,27 @@ int kvm_physical_memory_addr_from_host(KVMState *s, void *ram,
     return ret;
 }
 
+void *kvm_gpa_to_userspace_addr(KVMState *s, hwaddr gpa)
+{
+    KVMMemoryListener *kml = &s->memory_listener;
+    void *result = NULL;
+    int i;
+    KVMSlot *mem;
+
+    kvm_slots_lock();
+    for (i = 0; i < kml->nr_slots_allocated; i++) {
+        mem = &kml->slots[i];
+        if (gpa >= mem->start_addr &&
+            gpa < mem->start_addr + mem->memory_size) {
+            result = mem->ram + (gpa - mem->start_addr);
+            break;
+        }
+    }
+    kvm_slots_unlock();
+
+    return result;
+}
+
 static int kvm_set_user_memory_region(KVMMemoryListener *kml, KVMSlot *slot, bool new)
 {
     KVMState *s = kvm_state;
diff --git a/include/system/kvm.h b/include/system/kvm.h
index 714b8c7b01..67a0b9f7ac 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -454,6 +454,24 @@ void kvm_set_sigmask_len(KVMState *s, unsigned int sigmask_len);
 int kvm_physical_memory_addr_from_host(KVMState *s, void *ram_addr,
                                        hwaddr *phys_addr);
 
+/**
+ * kvm_gpa_to_userspace_addr:
+ * @s: #KVMState
+ * @gpa: guest physical address
+ *
+ * Returns the host userspace address @gpa is backed by, or NULL if @gpa is
+ * not covered by any memory slot.
+ */
+#ifdef CONFIG_KVM
+void *kvm_gpa_to_userspace_addr(KVMState *s, hwaddr gpa);
+#else
+static inline void *kvm_gpa_to_userspace_addr(KVMState *s, hwaddr gpa)
+{
+    /* Without KVM there are no memory slots to look up. */
+    return NULL;
+}
+#endif
+
 #endif /* COMPILING_PER_TARGET */
 
 bool kvm_arch_supports_vmfd_change(void);
-- 
2.34.1


