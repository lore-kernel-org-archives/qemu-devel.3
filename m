Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8129C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmrfk-0006Jo-7v; Wed, 20 Mar 2024 04:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrfi-0006C0-Ov
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:51:42 -0400
Received: from mail-dm6nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2417::601]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrfg-0001GG-WA
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:51:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMZ/RsEm7x4ckPUIdxvK2UblRe9KamxRW51XtpV9vhRRaXm7Z+kqrT84Pkbryxn82rCOQCMtxA7QLhM+SZ8b4sFIf2Udf6mfg3ZYCkXO5jNMnKGj3Tzf8BwBs+vGbzFFnR+y25wEEJrwqv845fe9HL8s+or9JzKLM1zfMRIxytzyuuDA6u9f0tjI200Y1C/+u/jaNrwGZILWLefZtvm6GyAJ+T2oA1xo/ZLNdPUwnWfn9GEunxunxenwSdJCp27gAGmd0frB4Ug8tAIMOdMgeenlpcxMRNNge4nYAotIlRgu9xL0uQt65ldLe62vxH08f5GZb8XiUmPYvnbcim1pxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6kmfHzK2uXH+lMgmIVS/y1u7KlHISwpecg5xaxKAvw=;
 b=jJQF7+ho8UNMHWLF63eDmXX0SXat4Gbowh/HnO3GKzjONZj4idM6etAlctwPOv8AqTxyvQESJeVrhjEOLYGykrxZbSsNaBj/D45aqaJoEaoNz1LOh94LBJzXsQLzRAmckttQ3SIdnzWW2PS+YiJr3Ba8y5SfhokBnvAoNEn5fVdyMo+8CMN/wZMm3BcDwwTWuHHqqVkJGoSts1DGe8enjfnDgGjSppwTHmnBUsw7jNBKhZXQnCySQQatzle3gBGN3xf1DZLogj8lybVa+akrI2MXVratw0yMF2Vd/QVHcZ96VU7098HjYhJwQa4kL5tSLApooYQLDOUrFHM+3dTUYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6kmfHzK2uXH+lMgmIVS/y1u7KlHISwpecg5xaxKAvw=;
 b=AbGtM8tda+w0Yzef6mQKo2efebfBf+PkqJE7c7tg7t364bubpm66ZyWt5FDsFhONTY6sYtiig9hGlDsLCAkTB6avshQHh0Sv8cwLkcGOp+8/GNLHBu6RQvnASmUcIlc0t9yVe2TOnzxC+aE60r2UIF7jgCwrG+UWpzUbYbljUC8=
Received: from BN9PR03CA0958.namprd03.prod.outlook.com (2603:10b6:408:108::33)
 by MN0PR12MB5834.namprd12.prod.outlook.com (2603:10b6:208:379::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Wed, 20 Mar
 2024 08:51:37 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:108:cafe::1f) by BN9PR03CA0958.outlook.office365.com
 (2603:10b6:408:108::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18 via Frontend
 Transport; Wed, 20 Mar 2024 08:51:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 08:51:37 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 03:51:37 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta
 <pankaj.gupta@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Isaku Yamahata
 <isaku.yamahata@linux.intel.com>
Subject: [PATCH v3 36/49] i386/sev: Add KVM_EXIT_VMGEXIT handling for Extended
 Guest Requests
Date: Wed, 20 Mar 2024 03:39:32 -0500
Message-ID: <20240320083945.991426-37-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240320083945.991426-1-michael.roth@amd.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|MN0PR12MB5834:EE_
X-MS-Office365-Filtering-Correlation-Id: 3673a406-fefb-4e6e-d940-08dc48baf42a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MPvyO/R0o94/OS0kiqrz3hX1dZVkLRFi1/ZRb92ohZ2LRtELTRsvGUEk2fBYkNEmDNF3kyfVSwNiV/HNSlJGmNoLI7DJ4JbnTctJFgfNPcHGitNpBmJ4o54LM/PGJhtYckmoFS0eJJ9i4/AZ3skEAVD+XivS9S6IkSs/vz9HieeX7odEp8/zi3XCX4/Tz2dFBbUdqAyjLlwZTDGGoWRiTvYgtafETsaho7a9KU9uhJhINqAZJ4Ph2El+w1dzn6PrKi606d6aILZLom86zpsVj1W9CIdGCRDY6cV+W/8hIvQAlo26ptwwcRge6H/Ly9d7Rz7991+f3CxRGnyQDy+XYjh8/YBpwaAU+8aP5NRyubuGNZ754n7Izy8Isrou2VrUt816IfjtZBA8ELLX54MMdTyKKDfTj0UnDmuvwTOIZHB4pMOBjyoFGrbttfbgAV7tdyMAqwMyy5ZRp+raqLWBMCqosRoWCsV5jPkIG2N9yRzHVuGuUj2ot/v8Bl/PCy0w/U0qxKjGdhPW3EifSOhn9fVUddxQ6vYcwwaNblLW5ye7f8m39FZqfNUPGookgiI2XNWaeOqQHChrVO8FGyH7LPCbqr9yDCoz3bwKbhvNbjavROWuEtlhXseoPE5/xTdFhRoExY8frr0tkngLPNQl1dLcqUVIwk0WLMTDkW8+ljpAB40fRmQYVTEtnJLlLSemCejfGxilLlxDrNWjB8xL387CI7fCJYabe986t0gHte1ZN1EdRET85KrPvJ6P+KUf
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 08:51:37.7021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3673a406-fefb-4e6e-d940-08dc48baf42a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5834
Received-SPF: permerror client-ip=2a01:111:f403:2417::601;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The GHCB specification[1] defines a VMGEXIT-based Guest Request
hypercall to allow an SNP guest to issue encrypted requests directly to
SNP firmware to do things like query the attestation report for the
guest. These are generally handled purely in the kernel.

In some some cases, it's useful for the host to be able to additionally
supply the certificate chain for the signing key that SNP firmware uses
to sign these attestation reports. To allow for, the GHCB specification
defines an Extended Guest Request where this certificate data can be
provided in a special format described in the GHCB spec. This
certificate data may be global or guest-specific depending on how the
guest was configured. Rather than providing interfaces to manage these
within the kernel, KVM handles this by forward the Extended Guest
Requests on to userspace so the certificate data can be provided in the
expected format.

Add a certs-path parameter to the sev-snp-guest object so that it can
be used to inject any certificate data into these Extended Guest
Requests.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 qapi/qom.json     |  7 +++-
 target/i386/sev.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index b25a3043da..7ba778af91 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -957,6 +957,10 @@
 #             SNP_LAUNCH_FINISH command in the SEV-SNP firmware ABI
 #             (default: all-zero)
 #
+# @certs-path: path to certificate data that can be passed to guests via
+#              SNP Extended Guest Requests. File should be in the format
+#              described in the GHCB specification. (default: none)
+#
 # Since: 7.2
 ##
 { 'struct': 'SevSnpGuestProperties',
@@ -967,7 +971,8 @@
             '*id-block': 'str',
             '*id-auth': 'str',
             '*auth-key-enabled': 'bool',
-            '*host-data': 'str' } }
+            '*host-data': 'str',
+            '*certs-path': 'str' } }
 
 ##
 # @ThreadContextProperties:
diff --git a/target/i386/sev.c b/target/i386/sev.c
index b54422b28e..3b4dbc63b1 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -96,6 +96,7 @@ struct SevSnpGuestState {
     char *id_block;
     char *id_auth;
     char *host_data;
+    char *certs_path;
 
     struct kvm_sev_snp_launch_start kvm_start_conf;
     struct kvm_sev_snp_launch_finish kvm_finish_conf;
@@ -1572,6 +1573,63 @@ static int kvm_handle_vmgexit_psc_msr_protocol(__u64 gpa, __u8 op, __u32 *psc_re
     return ret;
 }
 
+#define SNP_EXT_REQ_ERROR_INVALID_LEN   1
+#define SNP_EXT_REQ_ERROR_BUSY          2
+#define SNP_EXT_REQ_ERROR_GENERIC       (1 << 31)
+
+static int kvm_handle_vmgexit_ext_req(__u64 gpa, __u64 *npages, __u32 *vmm_ret)
+{
+    SevSnpGuestState *sev_snp_guest;
+    MemTxAttrs attrs = { 0 };
+    void *guest_buf;
+    hwaddr buf_sz;
+    gsize sz;
+    g_autofree gchar *contents = NULL;
+    GError *error = NULL;
+
+    *vmm_ret = SNP_EXT_REQ_ERROR_GENERIC;
+
+    if (!sev_snp_enabled()) {
+        return 0;
+    }
+
+    sev_snp_guest = SEV_SNP_GUEST(MACHINE(qdev_get_machine())->cgs);
+
+    if (!sev_snp_guest->certs_path) {
+        *vmm_ret = 0;
+        return 0;
+    }
+
+    if (!g_file_get_contents(sev_snp_guest->certs_path, &contents, &sz, &error)) {
+        error_report("SEV: Failed to read '%s' (%s)", sev_snp_guest->certs_path, error->message);
+        g_error_free(error);
+        return 0;
+    }
+
+    buf_sz = *npages * TARGET_PAGE_SIZE;
+
+    if (buf_sz < sz) {
+        *vmm_ret = SNP_EXT_REQ_ERROR_INVALID_LEN;
+        *npages = (sz + TARGET_PAGE_SIZE) / TARGET_PAGE_SIZE;
+        return 0;
+    }
+
+    guest_buf = address_space_map(&address_space_memory, gpa, &buf_sz, true, attrs);
+    if (buf_sz < sz) {
+        g_warning("unable to map entire shared buffer, mapped size %ld (expected %d)",
+                  buf_sz, GHCB_SHARED_BUF_SIZE);
+        goto out_unmap;
+    }
+
+    memcpy(guest_buf, contents, buf_sz);
+    *vmm_ret = 0;
+
+out_unmap:
+    address_space_unmap(&address_space_memory, guest_buf, buf_sz, true, buf_sz);
+
+    return 0;
+}
+
 int kvm_handle_vmgexit(struct kvm_run *run)
 {
     int ret;
@@ -1583,6 +1641,10 @@ int kvm_handle_vmgexit(struct kvm_run *run)
         ret = kvm_handle_vmgexit_psc_msr_protocol(run->vmgexit.psc_msr.gpa,
                                                   run->vmgexit.psc_msr.op,
                                                   &run->vmgexit.psc_msr.ret);
+    } else if (run->vmgexit.type == KVM_USER_VMGEXIT_EXT_GUEST_REQ) {
+        ret = kvm_handle_vmgexit_ext_req(run->vmgexit.ext_guest_req.data_gpa,
+                                         &run->vmgexit.ext_guest_req.data_npages,
+                                         &run->vmgexit.ext_guest_req.ret);
     } else {
         warn_report("KVM: unknown vmgexit type: %d", run->vmgexit.type);
         ret = -1;
@@ -1914,6 +1976,26 @@ sev_snp_guest_set_host_data(Object *obj, const char *value, Error **errp)
     memcpy(finish->host_data, blob, len);
 }
 
+static char *
+sev_snp_guest_get_certs_path(Object *obj, Error **errp)
+{
+    SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(obj);
+
+    return g_strdup(sev_snp_guest->certs_path);
+}
+
+static void
+sev_snp_guest_set_certs_path(Object *obj, const char *value, Error **errp)
+{
+    SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(obj);
+
+    if (sev_snp_guest->host_data) {
+        g_free(sev_snp_guest->host_data);
+    }
+
+    sev_snp_guest->certs_path = value ? g_strdup(value) : NULL;
+}
+
 static void
 sev_snp_guest_class_init(ObjectClass *oc, void *data)
 {
@@ -1935,6 +2017,9 @@ sev_snp_guest_class_init(ObjectClass *oc, void *data)
     object_class_property_add_str(oc, "host-data",
                                   sev_snp_guest_get_host_data,
                                   sev_snp_guest_set_host_data);
+    object_class_property_add_str(oc, "certs-path",
+                                  sev_snp_guest_get_certs_path,
+                                  sev_snp_guest_set_certs_path);
 }
 
 static void
-- 
2.25.1


