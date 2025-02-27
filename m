Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F0DC19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:40:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnewn-0003Lj-KO; Thu, 27 Feb 2025 09:33:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <492a147d.AWQAAGXdcTUAAAAAAAAAA9cBm3sAAYKJZwAAAAAAAC5ATwBnwHd3@a3031119.bnc3.mailjet.com>)
 id 1tnewE-0001Tr-QY
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:32:36 -0500
Received: from o72.p38.mailjet.com ([185.250.237.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <492a147d.AWQAAGXdcTUAAAAAAAAAA9cBm3sAAYKJZwAAAAAAAC5ATwBnwHd3@a3031119.bnc3.mailjet.com>)
 id 1tnew8-0006Lf-QW
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:32:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; q=dns/txt;
 d=randomman.co.uk; i=roy.hopkins@randomman.co.uk; s=mailjet; x=1740673943;
 h=message-id:mime-version:from:from:to:to:subject:subject:date:date:list-unsubscribe:list-unsubscribe-post:
 cc:feedback-id:in-reply-to:references:x-csa-complaints:x-mj-mid:x-mj-smtpguid:
 x-report-abuse-to:content-type:content-transfer-encoding;
 bh=DVpozaxx/Uix4NnfQuB/nnLxENTtmruWdZuycPgN0XE=;
 b=Zm9fo3KU6nBRJS32rEvBSu4g8QsWfihSNxc7zSSLQHedpHDjc6CrigBX0
 Ef6b/jTT3j3cTqTt59ZllKFWsA8lNWv1wU1HTYXSo8NjJqV1KjqtO8J6PnvF
 3nqEx3WBhPgZpV5hg5Bbtp6ZiuHG7Ct2UD0f1/T0sHvaOGqohnw0gPLstO/R
 4cuPHjQ2cTeTAZT4ymSfaG948eKg0DC8yRWmdHU3IIzOn6v5FlP/XPFYuwNu
 w8DAaQ5qu7/5hC2UlVvqarABFWxWKuWxKk+x0HoqduSUYq1WA2aWmrM/XFnb
 V40shfC4mL9NLlJi7aDhZVscOHRnC5toYxFWysu8qozsQ==
Message-Id: <492a147d.AWQAAGXdcTUAAAAAAAAAA9cBm3sAAYKJZwAAAAAAAC5ATwBnwHd3@mailjet.com>
MIME-Version: 1.0
From: Roy Hopkins <roy.hopkins@randomman.co.uk>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 12/16] backends/confidential-guest-support: Add
 set_guest_policy() function
Date: Thu, 27 Feb 2025 14:29:30 +0000
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Cc: Roy Hopkins <roy.hopkins@randomman.co.uk>, Paolo Bonzini
 <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Alistair Francis
 <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>, David Hildenbrand
 <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Tom Lendacky
 <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, Ani Sinha
 <anisinha@redhat.com>, Joerg Roedel <jroedel@suse.com>
Feedback-Id: 42.3031119.2785883:MJ
In-Reply-To: <cover.1740663410.git.roy.hopkins@randomman.co.uk>
References: <cover.1740663410.git.roy.hopkins@randomman.co.uk>
X-CSA-Complaints: csa-complaints@eco.de
X-MJ-Mid: AWQAAGXdcTUAAAAAAAAAA9cBm3sAAYKJZwAAAAAAAC5ATwBnwHd3dyoWHjziS32LwwvBaok4yAAqgls
X-MJ-SMTPGUID: 1fb25099-b410-48e3-ad94-b6dd030ba534
X-REPORT-ABUSE-TO: Message sent by Mailjet please report to
 abuse@mailjet.com with a copy of the message
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.250.237.72;
 envelope-from=492a147d.AWQAAGXdcTUAAAAAAAAAA9cBm3sAAYKJZwAAAAAAAC5ATwBnwHd3@a3031119.bnc3.mailjet.com;
 helo=o72.p38.mailjet.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 backends/confidential-guest-support.c       | 12 ++++++++++++
 include/system/confidential-guest-support.h | 21 +++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
index ed1ff78b5c..0fe76444a4 100644
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
@@ -52,6 +63,7 @@ static void confidential_guest_support_class_init(ObjectClass *oc, void *data)
     ConfidentialGuestSupportClass *cgsc = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
     cgsc->check_support = check_support;
     cgsc->set_guest_state = set_guest_state;
+    cgsc->set_guest_policy = set_guest_policy;
     cgsc->get_mem_map_entry = get_mem_map_entry;
 }
 
diff --git a/include/system/confidential-guest-support.h b/include/system/confidential-guest-support.h
index b2cfd1f70c..dbf787a04b 100644
--- a/include/system/confidential-guest-support.h
+++ b/include/system/confidential-guest-support.h
@@ -61,6 +61,10 @@ typedef enum ConfidentialGuestPageType {
     CGS_PAGE_TYPE_REQUIRED_MEMORY,
 } ConfidentialGuestPageType;
 
+typedef enum ConfidentialGuestPolicyType {
+    GUEST_POLICY_SEV,
+} ConfidentialGuestPolicyType;
+
 struct ConfidentialGuestSupport {
     Object parent;
 
@@ -127,6 +131,23 @@ typedef struct ConfidentialGuestSupportClass {
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


