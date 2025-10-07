Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37266CCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 06:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v60tS-0003jK-Gn; Tue, 07 Oct 2025 02:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1v60tR-0003iZ-3W
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 02:09:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1v60tP-00064V-FD
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 02:09:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759817386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w8IYKKBCxd4zknSaeSpWUy8oz0F7UunXAIvJf0fWR40=;
 b=RwugaeNSNcwNW5RBvQ4m7IYRICyD4IEjNNGePJie17FXHgOLbuN29/m0pucepM6YdRFvSv
 6BjuB4mUm+IekfHnuRuEz8Rwa36z5sOHNjl0fwGAbktHG7B/7Uyy2r1nuexq/ncZNmkILW
 ZJaZDpqv1tBk1v0f+gBwwF8/Ry3cOFo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-q7A829CsPrShzVYPns7-RA-1; Tue,
 07 Oct 2025 02:08:37 -0400
X-MC-Unique: q7A829CsPrShzVYPns7-RA-1
X-Mimecast-MFC-AGG-ID: q7A829CsPrShzVYPns7-RA_1759817316
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A3A319560B0; Tue,  7 Oct 2025 06:08:36 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.rmtau.csb (unknown [10.64.136.28])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 39BC618004D8; Tue,  7 Oct 2025 06:08:30 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, mchehab+huawei@kernel.org,
 Jonathan.Cameron@huawei.com, shan.gavin@gmail.com
Subject: [PATCH RESEND v2 2/3] kvm/arm/kvm: Introduce helper
 push_ghes_memory_errors()
Date: Tue,  7 Oct 2025 16:08:09 +1000
Message-ID: <20251007060810.258536-3-gshan@redhat.com>
In-Reply-To: <20251007060810.258536-1-gshan@redhat.com>
References: <20251007060810.258536-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 9a47ac9e3a..c5d5b3b16e 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2429,12 +2429,34 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
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
 
@@ -2443,7 +2465,6 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
         ram_addr = qemu_ram_addr_from_host(addr);
         if (ram_addr != RAM_ADDR_INVALID &&
             kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
-            addresses = g_array_new(false, false, sizeof(paddr));
             kvm_hwpoison_page_add(ram_addr);
             /*
              * If this is a BUS_MCEERR_AR, we know we have been called
@@ -2456,19 +2477,10 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
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
2.51.0


