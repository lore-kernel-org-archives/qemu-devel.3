Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24815C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 16:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXMOo-0003QL-1J; Thu, 03 Jul 2025 12:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@randomman.co.uk>)
 id 1uXMOm-0003Q9-0V
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:02:56 -0400
Received: from smtp-out-60.livemail.co.uk ([213.171.216.60]
 helo=dkim.livemail.co.uk)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@randomman.co.uk>)
 id 1uXMOk-0004FG-4q
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:02:55 -0400
Received: from smtp.livemail.co.uk (unknown [10.44.132.82])
 by dkim.livemail.co.uk (Postfix) with ESMTPS id CCA0240140;
 Thu,  3 Jul 2025 17:02:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=randomman.co.uk;
 s=livemail2; t=1751558571;
 bh=kf2NzQpGqsvElw9O300yk+DDc2EBxP/5S82yiDV/Bvk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=V5f7PrTxV1kYWO0c3H8ABnx0hilWccdKfqIJLFyJp8CU7KBhX81VvRZRFYaA5bPXx
 WcgpEqcTvzB5CoFvPMjaBNt0/l8lhLkDmCaiVOml9yH8HruzWjWiJYG+vKTe4p9yeN
 yPH6kA4wtPwooglDQaf1uT+cciAe2eAkmDDgivwg=
Received: from localhost.localdomain (unknown [145.40.191.116])
 (Authenticated sender: roy.hopkins@randomman.co.uk)
 by smtp.livemail.co.uk (Postfix) with ESMTPSA id 5BF1BC0291;
 Thu,  3 Jul 2025 17:02:47 +0100 (BST)
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
Subject: [PATCH v9 12/16] backends/confidential-guest-support: Add
 set_guest_policy() function
Date: Thu,  3 Jul 2025 17:02:20 +0100
Message-ID: <d3888a2eb170c8d8c85a1c4b7e99accf3a15589c.1751554099.git.roy.hopkins@randomman.co.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1751554099.git.roy.hopkins@randomman.co.uk>
References: <cover.1751554099.git.roy.hopkins@randomman.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

For confidential guests a policy can be provided that defines the
security level, debug status, expected launch measurement and other
parameters that define the configuration of the confidential platform.

This commit adds a new function named set_guest_policy() that can be
implemented by each confidential platform, such as AMD SEV to set the
policy. This will allow configuration of the policy from a
multi-platform resource such as an IGVM file without the IGVM processor
requiring specific implementation details for each platform.

Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Gerd Hoffman <kraxel@redhat.com>
---
 backends/confidential-guest-support.c       | 12 ++++++++++++
 include/system/confidential-guest-support.h | 21 +++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
index c5bef1fbfa..156dd15e66 100644
--- a/backends/confidential-guest-support.c
+++ b/backends/confidential-guest-support.c
@@ -38,6 +38,17 @@ static int set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
     return -1;
 }
 
+static int set_guest_policy(ConfidentialGuestPolicyType policy_type,
+                            uint64_t policy,
+                            void *policy_data1, uint32_t policy_data1_size,
+                            void *policy_data2, uint32_t policy_data2_size,
+                            Error **errp)
+{
+    error_setg(errp,
+               "Setting confidential guest policy is not supported for this platform");
+    return -1;
+}
+
 static int get_mem_map_entry(int index, ConfidentialGuestMemoryMapEntry *entry,
                              Error **errp)
 {
@@ -53,6 +64,7 @@ static void confidential_guest_support_class_init(ObjectClass *oc,
     ConfidentialGuestSupportClass *cgsc = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
     cgsc->check_support = check_support;
     cgsc->set_guest_state = set_guest_state;
+    cgsc->set_guest_policy = set_guest_policy;
     cgsc->get_mem_map_entry = get_mem_map_entry;
 }
 
diff --git a/include/system/confidential-guest-support.h b/include/system/confidential-guest-support.h
index 79ecd21f42..0cc8b26e64 100644
--- a/include/system/confidential-guest-support.h
+++ b/include/system/confidential-guest-support.h
@@ -57,6 +57,10 @@ typedef enum ConfidentialGuestPageType {
     CGS_PAGE_TYPE_REQUIRED_MEMORY,
 } ConfidentialGuestPageType;
 
+typedef enum ConfidentialGuestPolicyType {
+    GUEST_POLICY_SEV,
+} ConfidentialGuestPolicyType;
+
 struct ConfidentialGuestSupport {
     Object parent;
 
@@ -123,6 +127,23 @@ typedef struct ConfidentialGuestSupportClass {
                            ConfidentialGuestPageType memory_type,
                            uint16_t cpu_index, Error **errp);
 
+    /*
+     * Set the guest policy. The policy can be used to configure the
+     * confidential platform, such as if debug is enabled or not and can contain
+     * information about expected launch measurements, signed verification of
+     * guest configuration and other platform data.
+     *
+     * The format of the policy data is specific to each platform. For example,
+     * SEV-SNP uses a policy bitfield in the 'policy' argument and provides an
+     * ID block and ID authentication in the 'policy_data' parameters. The type
+     * of policy data is identified by the 'policy_type' argument.
+     */
+    int (*set_guest_policy)(ConfidentialGuestPolicyType policy_type,
+                            uint64_t policy,
+                            void *policy_data1, uint32_t policy_data1_size,
+                            void *policy_data2, uint32_t policy_data2_size,
+                            Error **errp);
+
     /*
      * Iterate the system memory map, getting the entry with the given index
      * that can be populated into guest memory.
-- 
2.43.0


