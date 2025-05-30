Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6112FC3ABB2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtxR-0003VP-1N; Fri, 30 May 2025 03:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtwa-00029u-99
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtwY-0006xS-0z
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kM+Uqzrg6CsjANhD+NLptDhZgNxBcAj170NDbmnTAFY=;
 b=Kvo74HqGsMaZbjn48j9FcfaiNZ1U6z57HKQRx/KRux7aVGlYtZ5czkg7aANdtE/omLeqKk
 JA5KOZNnOO7qnATU5qUXQO1ebw8d/l4x39459lKEEIPxJiDrir4bpRkona4XWxhm2AQNqk
 +HJJPbovaPG0LS5lcarKkVTYSWRXKtQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-oxueP_PUMlerlW59aUPINQ-1; Fri, 30 May 2025 03:14:16 -0400
X-MC-Unique: oxueP_PUMlerlW59aUPINQ-1
X-Mimecast-MFC-AGG-ID: oxueP_PUMlerlW59aUPINQ_1748589255
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ad556f5f1a9so128180666b.3
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:14:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589254; x=1749194054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kM+Uqzrg6CsjANhD+NLptDhZgNxBcAj170NDbmnTAFY=;
 b=IyKFP9OTzkjK5TUPA3+HoxhRZLxkJQ2/n2ESVqVTtZKsoF6SZWKi3t7yIq0dVI3ft7
 f/eWJphHpugu3thPNbHL7f5uLr1PyNB12UCjyOYUh/f5VTENI2I4iFKDDbCPZpdyHh0j
 ePDCdCYp62Qe7MJ42/eCZ1F86NdPaM/WqLUhDUi2/xPqsTpftflnM6SCu/plEFH7jxQV
 mvOAVayOwQSwSFtXJ29210fq0VKX9xO/BP/dxsW3JYeLJ0r1OQfMuNP+9/nvb+2qPFfQ
 fTAuf5qsMhjHBkU9Dt958ZHL02JlKo9xNHrJe5KfzH/WT4fL2o9RjG4IRfJVNE+UYoKz
 d7GA==
X-Gm-Message-State: AOJu0Yx1T4+4+vQHi1lFfXm3MFfWuXUq5rHh8e5ut94Or+UyJLKJ40ZC
 aPxBrS1RgvYYEkRNlujvolZ0yQrXdVZCtWVfkClcl+26i4MnYsqTVhCTObSQcJ19OCjTJbrK6sn
 zGAVZ/alUGNJr+E2vfpdPgAi7kc/x/YlqDgoex8DuKBE3GwekMsxeRWPvzHsdNn7vaLC+FTPuSl
 AVcW0sTkEDPsFTIVZi2yMMTuBnXVn+89fGJy9JTGF5
X-Gm-Gg: ASbGnctuENQWSdoOiyJY5waa1lAkTNlPJUimTajuf1rZdLLMciTJchlZ7FkTOWqqUFs
 6lx+4F4rQZmK79w3CEDQaDhd5m8c58Wm0aOjK5QUeJDyTd5K7V/jJPzic0TuO8V34Xy8UFy24fe
 JdM+6f4raxAN2qj71cU1J9KjvwoG329MQ95engD+bBVe+kf/h6+8u0b7FICYQ8TgXYaEGns1eFf
 P7P033Z/0cnK44HD3jV0eMt6bQYgumYtcvGUbbzWEVrwQ29yk1T6IRuYfDF3cMttWFYUzyTWfgn
 1FarvR4DJHIIig==
X-Received: by 2002:a17:907:7f89:b0:ad8:89f8:3f66 with SMTP id
 a640c23a62f3a-adb3228d803mr210221066b.21.1748589253993; 
 Fri, 30 May 2025 00:14:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEf0imaox/m4B9O0OoDOlTi8wQUw/G32fmoNYstLV1iJxlkLvnh9R36kY3gYTh/5lSLoPwwQw==
X-Received: by 2002:a17:907:7f89:b0:ad8:89f8:3f66 with SMTP id
 a640c23a62f3a-adb3228d803mr210219066b.21.1748589253532; 
 Fri, 30 May 2025 00:14:13 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d84e75fsm274611166b.81.2025.05.30.00.14.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:14:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 33/77] i386/tdx: Track RAM entries for TDX VM
Date: Fri, 30 May 2025 09:12:03 +0200
Message-ID: <20250530071250.2050910-34-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

The RAM of TDX VM can be classified into two types:

 - TDX_RAM_UNACCEPTED: default type of TDX memory, which needs to be
   accepted by TDX guest before it can be used and will be all-zeros
   after being accepted.

 - TDX_RAM_ADDED: the RAM that is ADD'ed to TD guest before running, and
   can be used directly. E.g., TD HOB and TEMP MEM that needed by TDVF.

Maintain TdxRamEntries[] which grabs the initial RAM info from e820 table
and mark each RAM range as default type TDX_RAM_UNACCEPTED.

Then turn the range of TD HOB and TEMP MEM to TDX_RAM_ADDED since these
ranges will be ADD'ed before TD runs and no need to be accepted runtime.

The TdxRamEntries[] are later used to setup the memory TD resource HOB
that passes memory info from QEMU to TDVF.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-22-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.h |  14 ++++++
 target/i386/kvm/tdx.c | 109 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 123 insertions(+)

diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
index 28a03c2a7b8..36a7400e748 100644
--- a/target/i386/kvm/tdx.h
+++ b/target/i386/kvm/tdx.h
@@ -20,6 +20,17 @@ typedef struct TdxGuestClass {
 /* TDX requires bus frequency 25MHz */
 #define TDX_APIC_BUS_CYCLES_NS 40
 
+enum TdxRamType {
+    TDX_RAM_UNACCEPTED,
+    TDX_RAM_ADDED,
+};
+
+typedef struct TdxRamEntry {
+    uint64_t address;
+    uint64_t length;
+    enum TdxRamType type;
+} TdxRamEntry;
+
 typedef struct TdxGuest {
     X86ConfidentialGuest parent_obj;
 
@@ -34,6 +45,9 @@ typedef struct TdxGuest {
 
     MemoryRegion *tdvf_mr;
     TdxFirmware tdvf;
+
+    uint32_t nr_ram_entries;
+    TdxRamEntry *ram_entries;
 } TdxGuest;
 
 #ifdef CONFIG_TDX
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index bfdae4f1c0c..e06f5d0bd43 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -18,6 +18,7 @@
 #include "crypto/hash.h"
 #include "system/system.h"
 
+#include "hw/i386/e820_memory_layout.h"
 #include "hw/i386/tdvf.h"
 #include "hw/i386/x86.h"
 #include "kvm_i386.h"
@@ -146,11 +147,110 @@ void tdx_set_tdvf_region(MemoryRegion *tdvf_mr)
     tdx_guest->tdvf_mr = tdvf_mr;
 }
 
+static void tdx_add_ram_entry(uint64_t address, uint64_t length,
+                              enum TdxRamType type)
+{
+    uint32_t nr_entries = tdx_guest->nr_ram_entries;
+    tdx_guest->ram_entries = g_renew(TdxRamEntry, tdx_guest->ram_entries,
+                                     nr_entries + 1);
+
+    tdx_guest->ram_entries[nr_entries].address = address;
+    tdx_guest->ram_entries[nr_entries].length = length;
+    tdx_guest->ram_entries[nr_entries].type = type;
+    tdx_guest->nr_ram_entries++;
+}
+
+static int tdx_accept_ram_range(uint64_t address, uint64_t length)
+{
+    uint64_t head_start, tail_start, head_length, tail_length;
+    uint64_t tmp_address, tmp_length;
+    TdxRamEntry *e;
+    int i = 0;
+
+    do {
+        if (i == tdx_guest->nr_ram_entries) {
+            return -1;
+        }
+
+        e = &tdx_guest->ram_entries[i++];
+    } while (address + length <= e->address || address >= e->address + e->length);
+
+    /*
+     * The to-be-accepted ram range must be fully contained by one
+     * RAM entry.
+     */
+    if (e->address > address ||
+        e->address + e->length < address + length) {
+        return -1;
+    }
+
+    if (e->type == TDX_RAM_ADDED) {
+        return 0;
+    }
+
+    tmp_address = e->address;
+    tmp_length = e->length;
+
+    e->address = address;
+    e->length = length;
+    e->type = TDX_RAM_ADDED;
+
+    head_length = address - tmp_address;
+    if (head_length > 0) {
+        head_start = tmp_address;
+        tdx_add_ram_entry(head_start, head_length, TDX_RAM_UNACCEPTED);
+    }
+
+    tail_start = address + length;
+    if (tail_start < tmp_address + tmp_length) {
+        tail_length = tmp_address + tmp_length - tail_start;
+        tdx_add_ram_entry(tail_start, tail_length, TDX_RAM_UNACCEPTED);
+    }
+
+    return 0;
+}
+
+static int tdx_ram_entry_compare(const void *lhs_, const void* rhs_)
+{
+    const TdxRamEntry *lhs = lhs_;
+    const TdxRamEntry *rhs = rhs_;
+
+    if (lhs->address == rhs->address) {
+        return 0;
+    }
+    if (le64_to_cpu(lhs->address) > le64_to_cpu(rhs->address)) {
+        return 1;
+    }
+    return -1;
+}
+
+static void tdx_init_ram_entries(void)
+{
+    unsigned i, j, nr_e820_entries;
+
+    nr_e820_entries = e820_get_table(NULL);
+    tdx_guest->ram_entries = g_new(TdxRamEntry, nr_e820_entries);
+
+    for (i = 0, j = 0; i < nr_e820_entries; i++) {
+        uint64_t addr, len;
+
+        if (e820_get_entry(i, E820_RAM, &addr, &len)) {
+            tdx_guest->ram_entries[j].address = addr;
+            tdx_guest->ram_entries[j].length = len;
+            tdx_guest->ram_entries[j].type = TDX_RAM_UNACCEPTED;
+            j++;
+        }
+    }
+    tdx_guest->nr_ram_entries = j;
+}
+
 static void tdx_finalize_vm(Notifier *notifier, void *unused)
 {
     TdxFirmware *tdvf = &tdx_guest->tdvf;
     TdxFirmwareEntry *entry;
 
+    tdx_init_ram_entries();
+
     for_each_tdx_fw_entry(tdvf, entry) {
         switch (entry->type) {
         case TDVF_SECTION_TYPE_BFV:
@@ -166,12 +266,21 @@ static void tdx_finalize_vm(Notifier *notifier, void *unused)
                              entry->type);
                 exit(1);
             }
+            if (tdx_accept_ram_range(entry->address, entry->size)) {
+                error_report("Failed to accept memory for TDVF section %d",
+                             entry->type);
+                qemu_ram_munmap(-1, entry->mem_ptr, entry->size);
+                exit(1);
+            }
             break;
         default:
             error_report("Unsupported TDVF section %d", entry->type);
             exit(1);
         }
     }
+
+    qsort(tdx_guest->ram_entries, tdx_guest->nr_ram_entries,
+          sizeof(TdxRamEntry), &tdx_ram_entry_compare);
 }
 
 static Notifier tdx_machine_done_notify = {
-- 
2.49.0


