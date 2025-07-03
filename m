Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B22EC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 15:04:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXLTj-0001Gz-0M; Thu, 03 Jul 2025 11:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@randomman.co.uk>)
 id 1uXLTV-0001BR-Ap
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 11:03:45 -0400
Received: from smtp-out-60.livemail.co.uk ([213.171.216.60]
 helo=dkim.livemail.co.uk)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@randomman.co.uk>)
 id 1uXLTQ-0001ui-Rn
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 11:03:42 -0400
Received: from smtp.livemail.co.uk (unknown [10.44.132.82])
 by dkim.livemail.co.uk (Postfix) with ESMTPS id A432AA0314;
 Thu,  3 Jul 2025 16:03:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=randomman.co.uk;
 s=livemail2; t=1751555018;
 bh=xccEvWMu5A4SRyZXo15tx/Eqbs6MGpdmLIwWtiEuYl8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oojXmRObORzhk7KN1jLTY87fRNCv0wycl6r2kQvm2j/205tywaxExpXUJuL76yHvQ
 EjpEbAM97Uqtt9GUQz4Sd1Zaw/HzzGR/r0ucsOxKoOVVjxpsxg74ovRWqKiQW1r8Ir
 1J3PzopgygyraQAC2tBLBcg0bu8aPJBPJ/F/86TU=
Received: from localhost.localdomain (unknown [145.40.191.116])
 (Authenticated sender: roy.hopkins@randomman.co.uk)
 by smtp.livemail.co.uk (Postfix) with ESMTPSA id 2307DC0968;
 Thu,  3 Jul 2025 16:03:34 +0100 (BST)
From: Roy Hopkins <roy.hopkins@randomman.co.uk>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@randomman.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 Gerd Hoffman <kraxel@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v9 02/16] backends/confidential-guest-support: Add functions
 to support IGVM
Date: Thu,  3 Jul 2025 16:03:10 +0100
Message-ID: <23e34a106da87427899f93178102e4a6ef50c966.1751554099.git.roy.hopkins@randomman.co.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1751554099.git.roy.hopkins@randomman.co.uk>
References: <cover.1751554099.git.roy.hopkins@randomman.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.171.216.60;
 envelope-from=roy.hopkins@randomman.co.uk; helo=dkim.livemail.co.uk
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

In preparation for supporting the processing of IGVM files to configure
guests, this adds a set of functions to ConfidentialGuestSupport
allowing configuration of secure virtual machines that can be
implemented for each supported isolation platform type such as Intel TDX
or AMD SEV-SNP. These functions will be called by IGVM processing code
in subsequent patches.

This commit provides a default implementation of the functions that
either perform no action or generate an error when they are called.
Targets that support ConfidentalGuestSupport should override these
implementations.

Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Gerd Hoffman <kraxel@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
---
 backends/confidential-guest-support.c       | 31 ++++++++++
 include/system/confidential-guest-support.h | 67 +++++++++++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
index 8ff7bfa857..c5bef1fbfa 100644
--- a/backends/confidential-guest-support.c
+++ b/backends/confidential-guest-support.c
@@ -14,15 +14,46 @@
 #include "qemu/osdep.h"
 
 #include "system/confidential-guest-support.h"
+#include "qapi/error.h"
 
 OBJECT_DEFINE_ABSTRACT_TYPE(ConfidentialGuestSupport,
                             confidential_guest_support,
                             CONFIDENTIAL_GUEST_SUPPORT,
                             OBJECT)
 
+static bool check_support(ConfidentialGuestPlatformType platform,
+                         uint16_t platform_version, uint8_t highest_vtl,
+                         uint64_t shared_gpa_boundary)
+{
+    /* Default: no support. */
+    return false;
+}
+
+static int set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
+                           ConfidentialGuestPageType memory_type,
+                           uint16_t cpu_index, Error **errp)
+{
+    error_setg(errp,
+               "Setting confidential guest state is not supported for this platform");
+    return -1;
+}
+
+static int get_mem_map_entry(int index, ConfidentialGuestMemoryMapEntry *entry,
+                             Error **errp)
+{
+    error_setg(
+        errp,
+        "Obtaining the confidential guest memory map is not supported for this platform");
+    return -1;
+}
+
 static void confidential_guest_support_class_init(ObjectClass *oc,
                                                   const void *data)
 {
+    ConfidentialGuestSupportClass *cgsc = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
+    cgsc->check_support = check_support;
+    cgsc->set_guest_state = set_guest_state;
+    cgsc->get_mem_map_entry = get_mem_map_entry;
 }
 
 static void confidential_guest_support_init(Object *obj)
diff --git a/include/system/confidential-guest-support.h b/include/system/confidential-guest-support.h
index ea46b50c56..79ecd21f42 100644
--- a/include/system/confidential-guest-support.h
+++ b/include/system/confidential-guest-support.h
@@ -19,6 +19,7 @@
 #define QEMU_CONFIDENTIAL_GUEST_SUPPORT_H
 
 #include "qom/object.h"
+#include "exec/hwaddr.h"
 
 #define TYPE_CONFIDENTIAL_GUEST_SUPPORT "confidential-guest-support"
 OBJECT_DECLARE_TYPE(ConfidentialGuestSupport,
@@ -26,6 +27,36 @@ OBJECT_DECLARE_TYPE(ConfidentialGuestSupport,
                     CONFIDENTIAL_GUEST_SUPPORT)
 
 
+typedef enum ConfidentialGuestPlatformType {
+    CGS_PLATFORM_SEV,
+    CGS_PLATFORM_SEV_ES,
+    CGS_PLATFORM_SEV_SNP,
+} ConfidentialGuestPlatformType;
+
+typedef enum ConfidentialGuestMemoryType {
+    CGS_MEM_RAM,
+    CGS_MEM_RESERVED,
+    CGS_MEM_ACPI,
+    CGS_MEM_NVS,
+    CGS_MEM_UNUSABLE,
+} ConfidentialGuestMemoryType;
+
+typedef struct ConfidentialGuestMemoryMapEntry {
+    uint64_t gpa;
+    uint64_t size;
+    ConfidentialGuestMemoryType type;
+} ConfidentialGuestMemoryMapEntry;
+
+typedef enum ConfidentialGuestPageType {
+    CGS_PAGE_TYPE_NORMAL,
+    CGS_PAGE_TYPE_VMSA,
+    CGS_PAGE_TYPE_ZERO,
+    CGS_PAGE_TYPE_UNMEASURED,
+    CGS_PAGE_TYPE_SECRETS,
+    CGS_PAGE_TYPE_CPUID,
+    CGS_PAGE_TYPE_REQUIRED_MEMORY,
+} ConfidentialGuestPageType;
+
 struct ConfidentialGuestSupport {
     Object parent;
 
@@ -64,6 +95,42 @@ typedef struct ConfidentialGuestSupportClass {
 
     int (*kvm_init)(ConfidentialGuestSupport *cgs, Error **errp);
     int (*kvm_reset)(ConfidentialGuestSupport *cgs, Error **errp);
+
+    /*
+     * Check to see if this confidential guest supports a particular
+     * platform or configuration.
+     *
+     * Return true if supported or false if not supported.
+     */
+    bool (*check_support)(ConfidentialGuestPlatformType platform,
+                         uint16_t platform_version, uint8_t highest_vtl,
+                         uint64_t shared_gpa_boundary);
+
+    /*
+     * Configure part of the state of a guest for a particular set of data, page
+     * type and gpa. This can be used for example to pre-populate and measure
+     * guest memory contents, define private ranges or set the initial CPU state
+     * for one or more CPUs.
+     *
+     * If memory_type is CGS_PAGE_TYPE_VMSA then ptr points to the initial CPU
+     * context for a virtual CPU. The format of the data depends on the type of
+     * confidential virtual machine. For example, for SEV-ES ptr will point to a
+     * vmcb_save_area structure that should be copied into guest memory at the
+     * address specified in gpa. The cpu_index parameter contains the index of
+     * the CPU the VMSA applies to.
+     */
+    int (*set_guest_state)(hwaddr gpa, uint8_t *ptr, uint64_t len,
+                           ConfidentialGuestPageType memory_type,
+                           uint16_t cpu_index, Error **errp);
+
+    /*
+     * Iterate the system memory map, getting the entry with the given index
+     * that can be populated into guest memory.
+     *
+     * Returns 0 for ok, 1 if the index is out of range and -1 on error.
+     */
+    int (*get_mem_map_entry)(int index, ConfidentialGuestMemoryMapEntry *entry,
+                             Error **errp);
 } ConfidentialGuestSupportClass;
 
 static inline int confidential_guest_kvm_init(ConfidentialGuestSupport *cgs,
-- 
2.43.0


