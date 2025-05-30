Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2633C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtx5-0002sZ-Mm; Fri, 30 May 2025 03:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtwg-0002Eq-ND
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtwf-0006yC-5a
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y2yZPFE2x7MAbiDB9fX5abOpoo6aCi+feBOYXevYx+0=;
 b=QPgGq180WCpx9BRu5kLu1FzilbSStl1uu+sFseI04LQl2MONVZvUMyqSpwFvODuXk4PmcL
 i61yY2TWOngUvZrX6xCWdlCkve93lprcM5Nsj/G1GZy3o7Y8OjRr3NpLeR6qX8TP9XFoTB
 FpS0oFdoAI+zHDOXQ/ZqMc+vrXWpc7c=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-VxT98QgjMRGA1kvNG7iKUw-1; Fri, 30 May 2025 03:14:23 -0400
X-MC-Unique: VxT98QgjMRGA1kvNG7iKUw-1
X-Mimecast-MFC-AGG-ID: VxT98QgjMRGA1kvNG7iKUw_1748589262
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ad56a52edc5so177904866b.0
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589261; x=1749194061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y2yZPFE2x7MAbiDB9fX5abOpoo6aCi+feBOYXevYx+0=;
 b=w3FCOab44Bd3nuWe/4vlPPPf57IxXpsqOr7hChbWsf5SE8PqySvp6XLghk+DfRywQv
 PlVoTvgmOXQF1+crvRorvdy0dEG9iaxabXcnbV8zuQtL14p1JEJ1S/VP5nAqMCF8fhbV
 2Q35+AG4Y5fJYolIpFpwO2XwK+qnX0Xb9BAlUAPqrmzFStn0FE3iCj70uhfvPne5+Eox
 JUKSfwiFmSwAATQeAdpZ7Mx2GcxW8aRCw49LxjCURmQoiBL12NMkx2Di3q3Y0Yf5IF/6
 ZqzzhklqHiLlYyTpIKFlt55jK7H06wvkRf33Alg5kSjtalM+lJSsYvtTSdOC+QKrcgNh
 TAgA==
X-Gm-Message-State: AOJu0YznBQocAFgJCya1W/tfI+rM3/4PvgD+lzk4ZPKnAzNH1vxE9ec6
 8epywfAuIM3uaBRtuMF+ZRzPgQrO3Nk5qb3AGsaITaqNRSQMMeIH8zvL8d/iXqbn0UB+Yhel92U
 Mwv7abzkWl9y/pvQewn7v9Ei3nQ2KYdTGreNuTwnOkucBDwBJ30GyoWvnqnH1c780GlGpVgt5XW
 5E/OkGTVHvPQCneg3/eEcEtgbG+Ve1Jc7RNzWEkmjB
X-Gm-Gg: ASbGnctNJcWSz+egm+doBRku5ILn9U+JBZ0yGvI/ewKV+CycjtaXypzfqo9UzKPTnzZ
 UrNCXUqZtDbSD90Fd/c/aOgZ17DauVgqAlPu+JIUbMr6aR4Njs29GhIe2XBzMg20grRrCybi58J
 VHuuYHmo9rQ+/DcGS5xxAw3/QIOjVFSlWRIYS8jpFX70mykR4bc+ur98QRuBuasJPbitsB1mLPV
 vh4IMwyYAwvqGNa9y8Iflbq4qYys6xv3OggvWKENr43IUESu2rTL+iMwBsIIxqHZIZoD1cyWDQ/
 joGbWXtE7avG8g==
X-Received: by 2002:a17:907:6ea2:b0:ad5:45d6:5fd5 with SMTP id
 a640c23a62f3a-adb322a35c9mr192377966b.30.1748589261473; 
 Fri, 30 May 2025 00:14:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMCcYKn1as2ZS6p06BoIA0jGjYQex16RpfvKNmVkWpT7Azb+aw9b3mGwWAQCD4sz/9PWB0zQ==
X-Received: by 2002:a17:907:6ea2:b0:ad5:45d6:5fd5 with SMTP id
 a640c23a62f3a-adb322a35c9mr192375566b.30.1748589261066; 
 Fri, 30 May 2025 00:14:21 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adb2c842b9fsm180561666b.143.2025.05.30.00.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:14:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Isaku Yamahata <isaku.yamahata@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 36/77] i386/tdx: Add TDVF memory via KVM_TDX_INIT_MEM_REGION
Date: Fri, 30 May 2025 09:12:06 +0200
Message-ID: <20250530071250.2050910-37-pbonzini@redhat.com>
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

From: Isaku Yamahata <isaku.yamahata@intel.com>

TDVF firmware (CODE and VARS) needs to be copied to TD's private
memory via KVM_TDX_INIT_MEM_REGION, as well as TD HOB and TEMP memory.

If the TDVF section has TDVF_SECTION_ATTRIBUTES_MR_EXTEND set in the
flag, calling KVM_TDX_EXTEND_MEMORY to extend the measurement.

After populating the TDVF memory, the original image located in shared
ramblock can be discarded.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-25-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index e20ffee9550..43529a9e0ed 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -17,6 +17,7 @@
 #include "qom/object_interfaces.h"
 #include "crypto/hash.h"
 #include "system/system.h"
+#include "system/ramblock.h"
 
 #include "hw/i386/e820_memory_layout.h"
 #include "hw/i386/tdvf.h"
@@ -262,6 +263,9 @@ static void tdx_finalize_vm(Notifier *notifier, void *unused)
 {
     TdxFirmware *tdvf = &tdx_guest->tdvf;
     TdxFirmwareEntry *entry;
+    RAMBlock *ram_block;
+    Error *local_err = NULL;
+    int r;
 
     tdx_init_ram_entries();
 
@@ -297,6 +301,44 @@ static void tdx_finalize_vm(Notifier *notifier, void *unused)
           sizeof(TdxRamEntry), &tdx_ram_entry_compare);
 
     tdvf_hob_create(tdx_guest, tdx_get_hob_entry(tdx_guest));
+
+    for_each_tdx_fw_entry(tdvf, entry) {
+        struct kvm_tdx_init_mem_region region;
+        uint32_t flags;
+
+        region = (struct kvm_tdx_init_mem_region) {
+            .source_addr = (uint64_t)entry->mem_ptr,
+            .gpa = entry->address,
+            .nr_pages = entry->size >> 12,
+        };
+
+        flags = entry->attributes & TDVF_SECTION_ATTRIBUTES_MR_EXTEND ?
+                KVM_TDX_MEASURE_MEMORY_REGION : 0;
+
+        do {
+            error_free(local_err);
+            local_err = NULL;
+            r = tdx_vcpu_ioctl(first_cpu, KVM_TDX_INIT_MEM_REGION, flags,
+                               &region, &local_err);
+        } while (r == -EAGAIN || r == -EINTR);
+        if (r < 0) {
+            error_report_err(local_err);
+            exit(1);
+        }
+
+        if (entry->type == TDVF_SECTION_TYPE_TD_HOB ||
+            entry->type == TDVF_SECTION_TYPE_TEMP_MEM) {
+            qemu_ram_munmap(-1, entry->mem_ptr, entry->size);
+            entry->mem_ptr = NULL;
+        }
+    }
+
+    /*
+     * TDVF image has been copied into private region above via
+     * KVM_MEMORY_MAPPING. It becomes useless.
+     */
+    ram_block = tdx_guest->tdvf_mr->ram_block;
+    ram_block_discard_range(ram_block, 0, ram_block->max_length);
 }
 
 static Notifier tdx_machine_done_notify = {
-- 
2.49.0


