Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C615AC5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 10:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKDfX-0003kJ-Md; Wed, 28 May 2025 06:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKDfU-0003je-Ld
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:05:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKDfT-0007E9-1D
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748426750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pyumWieLSY7fqHWHrJAxx17qyJlbxZ6HzrKW4tcATRk=;
 b=Z8Oh+2V8w+USE4nG+5/ezG3wpV0SPEapxxUAAWQ2y3BawRE3xIFxVU7obFWBI1/vF6Ffoj
 FgXjimBEY91fY/i9qgcCB5mV0KT5yntrM37avedEFHXhOuZaADvdbZmf156I7hMnI/4Ykg
 7uTBl+oM7dE/xy1N1MJa4Kq0wAE8ygk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-xaFKIUk4MXmAguZUjMcaYQ-1; Wed,
 28 May 2025 06:05:46 -0400
X-MC-Unique: xaFKIUk4MXmAguZUjMcaYQ-1
X-Mimecast-MFC-AGG-ID: xaFKIUk4MXmAguZUjMcaYQ_1748426745
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4D42195608E; Wed, 28 May 2025 10:05:45 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.110])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5CE67180049D; Wed, 28 May 2025 10:05:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 11/27] hw/i386/pc: Remove PCMachineClass::broken_reserved_end
 field
Date: Wed, 28 May 2025 12:04:51 +0200
Message-ID: <20250528100507.313906-12-thuth@redhat.com>
In-Reply-To: <20250528100507.313906-1-thuth@redhat.com>
References: <20250528100507.313906-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) DKIMWL_WL_HIGH=-2.907, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The PCMachineClass::broken_reserved_end field was only used
by the pc-q35-2.4 and pc-i440fx-2.4 machines, which got removed.
Remove it and simplify pc_memory_init().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <20250512083948.39294-3-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/i386/pc.h |  1 -
 hw/i386/pc.c         | 13 +++++--------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 9563674e2da..f4a874b17fc 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -107,7 +107,6 @@ struct PCMachineClass {
     /* RAM / address space compat: */
     bool gigabyte_align;
     bool has_reserved_memory;
-    bool broken_reserved_end;
     bool enforce_amd_1tb_hole;
     bool isa_bios_alias;
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 70656157ca0..c8bb4a3ee47 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -999,14 +999,13 @@ void pc_memory_init(PCMachineState *pcms,
 
     if (machine->device_memory) {
         uint64_t *val = g_malloc(sizeof(*val));
-        uint64_t res_mem_end = machine->device_memory->base;
-
-        if (!pcmc->broken_reserved_end) {
-            res_mem_end += memory_region_size(&machine->device_memory->mr);
-        }
+        uint64_t res_mem_end;
 
         if (pcms->cxl_devices_state.is_enabled) {
             res_mem_end = cxl_resv_end;
+        } else {
+            res_mem_end = machine->device_memory->base
+                          + memory_region_size(&machine->device_memory->mr);
         }
         *val = cpu_to_le64(ROUND_UP(res_mem_end, 1 * GiB));
         fw_cfg_add_file(fw_cfg, "etc/reserved-memory-end", val, sizeof(*val));
@@ -1044,9 +1043,7 @@ uint64_t pc_pci_hole64_start(void)
         hole64_start = pc_get_cxl_range_end(pcms);
     } else if (pcmc->has_reserved_memory && (ms->ram_size < ms->maxram_size)) {
         pc_get_device_memory_range(pcms, &hole64_start, &size);
-        if (!pcmc->broken_reserved_end) {
-            hole64_start += size;
-        }
+        hole64_start += size;
     } else {
         hole64_start = pc_above_4g_end(pcms);
     }
-- 
2.49.0


