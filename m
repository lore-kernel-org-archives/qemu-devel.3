Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FFCC3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 10:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKDcI-00082W-Go; Wed, 28 May 2025 06:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1uKDaz-0007a6-4l
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:01:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1uKDav-0006Ru-GU
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748426468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GK3hRc9GBMOqhjsdAbUrX1Yr4I1KvmG37SPK6bbu+FM=;
 b=K2B0iNRybCMqGettSbc8rD9z4cZ7TRuNayEQnb7Cg8MPxIf4/cV0NXqCP+ZmPdWGq3jU3L
 RjlLNEOPaP0k3JBYQAHq8sNIK+06hnPyI7wYFchWNFEIed+xGOeJScQ7DCRvnS6yBV3+px
 A2FsKRAaa1BefRKDpx3XUKmfOnZt9QY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-LSt9u0TQMPOiqRG5txazQw-1; Wed,
 28 May 2025 06:01:04 -0400
X-MC-Unique: LSt9u0TQMPOiqRG5txazQw-1
X-Mimecast-MFC-AGG-ID: LSt9u0TQMPOiqRG5txazQw_1748426461
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0FC0C1945114; Wed, 28 May 2025 10:01:01 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.rmtau.csb (unknown [10.64.136.65])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A55E619560AF; Wed, 28 May 2025 10:00:55 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com,
 mchehab+huawei@kernel.org, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v2 2/3] kvm/arm/kvm: Introduce helper push_ghes_memory_errors()
Date: Wed, 28 May 2025 20:00:32 +1000
Message-ID: <20250528100033.159576-3-gshan@redhat.com>
In-Reply-To: <20250528100033.159576-1-gshan@redhat.com>
References: <20250528100033.159576-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
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

Introduce helper push_ghes_memory_errors(), which sends ACPI GHES memory
errors, injects SEA exception or aborts on errors. This function will
be extended to support multiple ACPI GHES memory errors in the next
path.

No functional changes intended.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 target/arm/kvm.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 97c1bce692..e31fcde797 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2333,12 +2333,34 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
     return ret;
 }
 
+static void push_ghes_memory_errors(CPUState *c, AcpiGhesState *ags,
+                                    uint64_t paddr)
+{
+    GArray *addresses = g_array_new(false, false, sizeof(paddr));
+    int ret;
+
+    kvm_cpu_synchronize_state(c);
+    g_array_append_vals(addresses, &paddr, 1);
+    ret = acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC, addresses);
+    if (ret) {
+        goto error;
+    }
+
+    kvm_inject_arm_sea(c);
+
+    g_array_free(addresses, true);
+
+    return;
+error:
+    error_report("failed to record the error");
+    abort();
+}
+
 void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
 {
     ram_addr_t ram_addr;
     hwaddr paddr;
     AcpiGhesState *ags;
-    GArray *addresses;
 
     assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
 
@@ -2347,7 +2369,6 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
         ram_addr = qemu_ram_addr_from_host(addr);
         if (ram_addr != RAM_ADDR_INVALID &&
             kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
-            addresses = g_array_new(false, false, sizeof(paddr));
             kvm_hwpoison_page_add(ram_addr);
             /*
              * If this is a BUS_MCEERR_AR, we know we have been called
@@ -2360,19 +2381,10 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
              * later from the main thread, so doing the injection of
              * the error would be more complicated.
              */
-            g_array_append_vals(addresses, &paddr, 1);
             if (code == BUS_MCEERR_AR) {
-                kvm_cpu_synchronize_state(c);
-                if (!acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC,
-                                             addresses)) {
-                    kvm_inject_arm_sea(c);
-                } else {
-                    error_report("failed to record the error");
-                    abort();
-                }
+                push_ghes_memory_errors(c, ags, paddr);
             }
 
-            g_array_free(addresses, true);
             return;
         }
         if (code == BUS_MCEERR_AO) {
-- 
2.49.0


