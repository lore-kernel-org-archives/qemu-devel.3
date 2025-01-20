Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A90AC02182
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 22:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZzo0-0006wx-80; Mon, 20 Jan 2025 16:59:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Huibo.Wang@amd.com>)
 id 1tZzOA-0005TI-Hc
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 16:32:55 -0500
Received: from mail-mw2nam12on20624.outbound.protection.outlook.com
 ([2a01:111:f403:200a::624]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Huibo.Wang@amd.com>)
 id 1tZzO7-0000VS-JV
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 16:32:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RV4z9Rsy9kU4/5FZbezbxUQbP3Jkd/tzt74Qip8VcPsRCMLuhzb9rciTsG0Tsd8TqsEgPCA6N8hIXNJxi1bLqH6o99GAE0yTys3L4ArvDmeaIshV5Swign46j2bUvnUW25dUUW0HLAdrfUlsZPyf/58VSwFVNlLQOSJKI9z88bhYQjTKGyoKS8gIQppWR86SOf9b83uMXqNYvVQVLEt/9AQT/ZG18J6/rcIBFS7kcg+5UFKllNHFJnVMdNDHT0p3s25rs3dlknAp9GquWZT+6HD6NA0I/wu1jpzSwDALdTnD37ag+4vtUMJeox6wv374RLGELRscZi7zEe4VHKYIjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/XzutmjbG2MQehXVtd/A2a7ID5Ty2sQzRUpFCpAmJQ=;
 b=tDMl0R6/157hdSgHqWdWCaktLweWsMWqF24J0Iu7Ja1g5vaurrSSE6+ipCQapmc25w0I1FnuABSdGJmpvslE1o7Zoq/wp5RjXmklKYay005bYPrWRN7CMPO6+16+4bUXAQ5sXbbu95ge1UaZeEtK8KUEzKsHPKcyBvbtuOWFBH4L3RPkFJcCz0mpNqpdnm7gOxTXmMtsjCIOPHVn+AemyOqwQng4yMXcuNNF+S4TR+IC5XRRuGTlIX3ubvK1bu2NOy85EH2Z4SHdbZoRUITd12TBidwtDKEn2MMijTvY1YVe/MxMLngbEPSqQrOThvprM2AuywdT7PnATMatgQbOIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/XzutmjbG2MQehXVtd/A2a7ID5Ty2sQzRUpFCpAmJQ=;
 b=UdDs25lEjPhXOjdasgeybnRRkORKlWXvsuSF/eSEAjUjq5W5078zUBpj3W7IdkRRjBJb4TVaVLRRBDMqn/UyzGLTsa+Iw82JaZpnCK/395uy2MTEl4vzxzrqK9d4bDZYgufdfVkPhv48wernU6PhYaIB98QegJv62JWDb7NNdkQ=
Received: from BL1PR13CA0266.namprd13.prod.outlook.com (2603:10b6:208:2ba::31)
 by DS0PR12MB8765.namprd12.prod.outlook.com (2603:10b6:8:14e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 21:32:42 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:208:2ba:cafe::12) by BL1PR13CA0266.outlook.office365.com
 (2603:10b6:208:2ba::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.15 via Frontend Transport; Mon,
 20 Jan 2025 21:32:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Mon, 20 Jan 2025 21:32:41 +0000
Received: from ruby-9130host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 20 Jan
 2025 15:32:40 -0600
From: Melody Wang <huibo.wang@amd.com>
To: <qemu-devel@nongnu.org>
CC: Tom Lendacky <thomas.lendacky@amd.com>, Paolo Bonzini
 <pbonzini@redhat.com>, <eduardo@habkost.net>, <berrange@redhat.com>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <jroedel@suse.com>,
 <michael.roth@amd.com>, Melody Wang <huibo.wang@amd.com>
Subject: [RFC PATCH v2 3/3] i386/sev: Add KVM_EXIT_SNP_REQ_CERTS support for
 certificate-fetching
Date: Mon, 20 Jan 2025 21:31:16 +0000
Message-ID: <20250120213116.521519-4-huibo.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250120213116.521519-1-huibo.wang@amd.com>
References: <20250120213116.521519-1-huibo.wang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|DS0PR12MB8765:EE_
X-MS-Office365-Filtering-Correlation-Id: 93435eb1-dd43-4980-a086-08dd3999f889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SCtXbXhud3FCQzQvMHo2YjNKa3dCUDl0VmtxVDkrSWZEeXJYVEF3a2o5ZXpS?=
 =?utf-8?B?SWNPUlRzUStKR0VURGdRTi9hUDROeU1IcnduNnBSWElybG5rOXZJaWM3OXFu?=
 =?utf-8?B?MFVTUG5IVGkyR2R4OG5UMEM3NzVERmwzR1hiTm5vYnZVamFjVUJodlMzQkgx?=
 =?utf-8?B?aDBSMzdrL3VuUHZkYmM2VjYwUWl5blFCYTZtczZYSzA3MGhESnBZeTlBM0pl?=
 =?utf-8?B?S003ZUE5dDJyaThUZW9uczIzQmExU3JyNmQ5MzVreWwyZ2pib2ZBRHA3eFBD?=
 =?utf-8?B?SlQydHVJSERoKzYwK1JkNUl4clArdUJwblVYRlgxWEoyb0s1S0ViTWcvcDNS?=
 =?utf-8?B?ZmRwckNJY2RLd1N2SXIzUU5FL2ptU0E4SHc0MnNyUm5rWlNqc1l0SEphL0Np?=
 =?utf-8?B?QXJCZElLV0h0TFc2cjFVYWVBVjVaNEpDUm1HOGkxVEt6bGRvbEpTUXAxWnQz?=
 =?utf-8?B?WXcyTHJ4TGNQMkZyY1NjdzVMVCtvRmFtNWVIM280Y0t5aWVzZUVpbWg5WUZH?=
 =?utf-8?B?K2FjZmNPczh4a1E5L2dzZXk2ellCMUVod1piOHFVNnh6Ry9GeXJScVN3ZkVD?=
 =?utf-8?B?RzdyNUF1K2JSVTJpekE5ZUQ5cDZyVE5oVUV5VWpFa1diMFozSUJ1YVB1bTV4?=
 =?utf-8?B?ODFnNStXMmdCUWdmSnZwSHVVNjdVWmM2MEZpOWpMYTFJbFJQeFd0bW1NRWxo?=
 =?utf-8?B?N1pwMmo1RGZraWs0YUF6YkVFdnppZ0FIVDhrTlBtM0toaTVodjd2VFlMdDVO?=
 =?utf-8?B?NGhqRUROVmdlVUhLcC9qUHpxblJiRHVoODNwYzJyekt3NW0vMHRuSXIvcmFK?=
 =?utf-8?B?YldKL0RnY2lIS1ZwYWxZdVpPdmJWeUJsUGVpVzBqeGRLVlhlS21kaVdnaEVD?=
 =?utf-8?B?R3FkTHRhbnRscWZZUStQSEtKU0x6UjNMRzREV3hUZkhoV1BjN1JMeWh4K2l6?=
 =?utf-8?B?U2UwRVQrU3AzRk9vaEVHU1hEM1oyNHdTdm5KOEZ3Wno1S2diTkVObmQ3WDBp?=
 =?utf-8?B?VlpHQXFsOEVmTEVhWW91eXZjMEVOa2JVU2FBbzhYd2pvMFd3NHB2bFR3Rkd1?=
 =?utf-8?B?dXFHUGtqUnBlbTgxcnlYTTROamFPV0ZTWU5OcU9XU1h3RU1qQ1ZHQjUydGl1?=
 =?utf-8?B?WnNMYjlYZC9RYW5tckpUdSt1QjZsVFRwNUJLVnRtTStkck94UUxyUE1JR1Vj?=
 =?utf-8?B?UFU0QlhpaUpuVEJabDEvanQ1Y0lONUJUNkVUL0tGZUpoV05OT0FJdUNvK0h0?=
 =?utf-8?B?U0g1RDZaenZjZkp1RE9BYXh5VG5JQ09CeXVyNm5ibTV1WEVxVDk4MkxWcHd2?=
 =?utf-8?B?ci9abnh1Q2t1VDFnVVNIM0NsNHc0UUN6SzBES1NTdnJOREdkbU9xa1Ayei9y?=
 =?utf-8?B?cW1lSHBtMnBPUEV4UWtyV2Q5c2N6enZCNzMyalNhbHdxSFZtZG5rbnJHL2FP?=
 =?utf-8?B?SjROZTFDbW55LzRUdUxJdUlHUERMRGhVaTRSSms4cEwwdUJFTDhkUzNKSFZZ?=
 =?utf-8?B?VzVzWGhYZ1lhMGthWTkyc05rU2M2NFFMN0x2UkIwRWhyUy9kaERXV3hUUmJi?=
 =?utf-8?B?L3gzeTNNbHd5M2ppbGFZZWNlWTR1Nmx3VGNkek8zc3RKRDFUUDFFcm0wUlFV?=
 =?utf-8?B?UEJkdG5IeGFEQ2JNMXNpWFNPWFZYUklQdWpSSkNxeXN2Tkg0aFZLRjlFMk50?=
 =?utf-8?B?M2pWYnlWcFJWdGhlY0xiMmlJMmRVamZEdFNtNWNSQktXbDlFNEZwdVpxcTBT?=
 =?utf-8?B?SzJxVnZLUFpiWHkwUVlxRmxEb0pwMGM0aFJOeFdYSjJyVkVnRUhla3ZZZUQy?=
 =?utf-8?B?NnBnWXpRbFRDVmJETlFXekx6WUhWK1RlMkE3d0FiRksvNmw3OFoyMTR1MmVK?=
 =?utf-8?B?M2NuUUo2K04xSllONnZibEdDNGlrUWYrWXdGai9zSUZzcXM0aGx3YkRtWHZW?=
 =?utf-8?Q?MkAtNqEOVOoA0Xg7R2UIOOTs5UF9wM6a?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 21:32:41.8245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93435eb1-dd43-4980-a086-08dd3999f889
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8765
Received-SPF: permerror client-ip=2a01:111:f403:200a::624;
 envelope-from=Huibo.Wang@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 20 Jan 2025 16:59:27 -0500
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

From: Michael Roth <michael.roth@amd.com>

The GHCB specification[1] defines a VMGEXIT-based Guest Request
hypercall to allow an SNP guest to issue encrypted requests directly to
SNP firmware to do things like query the attestation report for the
guest. These are generally handled purely in the kernel.

In some some cases, it's useful for the host to be able to additionally
supply the certificate chain for the signing key that SNP firmware uses
to sign these attestation reports. To allow for this, the GHCB
specification defines an Extended Guest Request where this certificate
data can be provided in a special format described in the GHCB spec.
This certificate data may be global or guest-specific depending on how
the guest was configured. Rather than providing interfaces to manage
these within the kernel, KVM provides a new KVM_EXIT_SNP_REQ_CERTS exit
to request the certificate contents from userspace. Implement support
for that in QEMU.

To synchronize delivery of the certificates to the guest in a way where
they will not be rendered invalid by updates to SNP firmware or
attestation singing/endorsement keys by management tools outside the
purview of QEMU, it is expected by users of KVM_EXIT_SNP_REQ_CERTS to
obtain a shared/read lock on the certificate file prior to delivering
them back to KVM. Only after this will the attestation report be
retrieved from firmware and bundled with the certificate data, so QEMU
must continue to hold the file lock until KVM confirms that the
attestation report has been retrieved/bundled. This confirmation is done
by way of the kvm_immediate_exit callback infrastructure that was
introduced in a previous patch.

[1] "Guest Hypervisor Communication Block (GHCB) Standardization",
    https://www.amd.com/en/developer/sev.html

  [Melody: Add a while(1) loop using the libvirt example with fstat and
  stat for the locking certificate blob code in open_certs_locked() to
  fix the recreation race problem suggested by Daniel P. Berrangé. And
  fix the json format and filename suggested by Markus Armbruster.]

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Melody Wang <huibo.wang@amd.com>
---
 qapi/qom.json                 |  21 ++-
 target/i386/kvm/kvm.c         |  10 ++
 target/i386/sev-system-stub.c |   5 +
 target/i386/sev.c             | 277 ++++++++++++++++++++++++++++++++++
 target/i386/sev.h             |   2 +-
 5 files changed, 313 insertions(+), 2 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 28ce24cd8d..c6f9ad5d45 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1034,6 +1034,23 @@
 #     firmware.  Set this to true to disable the use of VCEK.
 #     (default: false) (since: 9.1)
 #
+# @certs-filename: Certificate data that can be passed to guests via
+#     SNP Extended Guest Requests. File should be in the format
+#     described in the GHCB specification. (default: none)
+#     (since: 10.0)
+#
+# @certs-timeout: Maximum time in milliseconds to wait to obtain a read lock
+#     on the certificate file specified by @certs-filename. This is
+#     not a cumulative value and only affects how long QEMU waits
+#     before returning execution to the vCPU and informing the guest
+#     of the timeout, so the guest can still continue retrying for
+#     as long as it likes (which will be about 60 seconds for linux
+#     guests at the time of this writing). If the guest-side timeout
+#     is insufficient, set this higher to allow more time to fetch the
+#     certificate. If the guest-side timeout is sufficient, set this
+#     lower to reduce the likelihood of soft lockups in the guest.
+#     (default: 100) (since: 10.0)
+#
 # Since: 9.1
 ##
 { 'struct': 'SevSnpGuestProperties',
@@ -1045,7 +1062,9 @@
             '*id-auth': 'str',
             '*author-key-enabled': 'bool',
             '*host-data': 'str',
-            '*vcek-disabled': 'bool' } }
+            '*vcek-disabled': 'bool',
+            '*certs-filename': 'str',
+            '*certs-timeout': 'uint32' } }
 
 ##
 # @ThreadContextProperties:
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 2f66e63b88..5df272d3d9 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6122,6 +6122,16 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
 #endif
     case KVM_EXIT_HYPERCALL:
         ret = kvm_handle_hypercall(run);
+        break;
+    case KVM_EXIT_SNP_REQ_CERTS:
+        if (!sev_snp_enabled()) {
+            error_report("KVM: Encountered a certificate request exit for a "
+                         "non-SEV-SNP guest.");
+            ret = -1;
+        } else {
+            ret = kvm_handle_snp_req_certs(cs, run);
+        }
+
         break;
     default:
         fprintf(stderr, "KVM: unknown exit reason %d\n", run->exit_reason);
diff --git a/target/i386/sev-system-stub.c b/target/i386/sev-system-stub.c
index d5bf886e79..685c56f62c 100644
--- a/target/i386/sev-system-stub.c
+++ b/target/i386/sev-system-stub.c
@@ -71,3 +71,8 @@ void hmp_info_sev(Monitor *mon, const QDict *qdict)
 void pc_system_parse_sev_metadata(uint8_t *flash_ptr, size_t flash_size)
 {
 }
+
+int kvm_handle_snp_req_certs(CPUState *cpu, struct kvm_run *run)
+{
+    g_assert_not_reached();
+}
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 0e1dbb6959..b29dbc1b90 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -157,6 +157,9 @@ struct SevSnpGuestState {
     char *id_auth_base64;
     uint8_t *id_auth;
     char *host_data;
+    char *certs_filename;
+    int certs_fd;
+    uint32_t certs_timeout;
 
     struct kvm_sev_snp_launch_start kvm_start_conf;
     struct kvm_sev_snp_launch_finish kvm_finish_conf;
@@ -1355,6 +1358,243 @@ sev_snp_launch_finish(SevCommonState *sev_common)
     }
 }
 
+static int open_certs_locked(SevSnpGuestState *sev_snp_guest)
+{
+    int fd, ret;
+
+    if (sev_snp_guest->certs_fd != -1) {
+        return 0;
+    }
+
+    while (1) {
+        struct stat a, b;
+        fd = qemu_open(sev_snp_guest->certs_filename, O_RDONLY, NULL);
+        if (fd == -1) {
+            error_report("Unable to open certificate blob %s, ret %d",
+                    sev_snp_guest->certs_filename, fd);
+            return fd;
+        }
+
+        ret = fstat(fd, &b);
+        if (ret < 0) {
+            error_report("Unable to check status of certficate blob %s, ret %d",
+                    sev_snp_guest->certs_filename, ret);
+            goto out_close;
+        }
+
+        ret = qemu_lock_fd(fd, 0, 0, false);
+        if (ret == -EAGAIN || ret == -EACCES) {
+            error_report("Unable to lock certificate blob %s, ret %d",
+                    sev_snp_guest->certs_filename, ret);
+            ret = -EAGAIN;
+            goto out_close;
+        } else if (ret) {
+            goto out_close;
+        }
+
+        if (stat(sev_snp_guest->certs_filename, &a) < 0) {
+            error_report("certficate blob %s disappeared",
+                    sev_snp_guest->certs_filename);
+            close(fd);
+            continue;
+        }
+
+        if (a.st_ino == b.st_ino) {
+            break;
+        } else {
+            error_report("certificate blob %s was recreated",
+                    sev_snp_guest->certs_filename);
+            close(fd);
+            continue;
+        }
+    }
+
+    sev_snp_guest->certs_fd = fd;
+    return 0;
+out_close:
+    close(fd);
+    return ret;
+}
+
+static void close_certs(SevSnpGuestState *sev_snp_guest)
+{
+    if (sev_snp_guest->certs_fd == -1) {
+        return;
+    }
+
+    qemu_unlock_fd(sev_snp_guest->certs_fd, 0, 0);
+    close(sev_snp_guest->certs_fd);
+    sev_snp_guest->certs_fd = -1;
+}
+
+static ssize_t get_certs_size(SevSnpGuestState *sev_snp_guest)
+{
+    ssize_t size;
+
+    size = lseek(sev_snp_guest->certs_fd, 0, SEEK_END);
+
+    if (size < 0)
+        return -errno;
+
+    return size;
+}
+
+static int read_certs(SevSnpGuestState *sev_snp_guest, void *buf, size_t buf_len)
+{
+    ssize_t n, len = 0;
+
+    n = lseek(sev_snp_guest->certs_fd, 0, SEEK_SET);
+    if (n) {
+        return n;
+    }
+
+    while ((n = read(sev_snp_guest->certs_fd, buf, buf_len)) != 0) {
+        if (n < 0) {
+            if (errno == EINTR) {
+                continue;
+            } else {
+                len = -errno;
+                break;
+            }
+        }
+        len += n;
+    }
+
+    return len;
+}
+
+static void snp_release_certs_lock(void *opaque)
+{
+    SevSnpGuestState *sev_snp_guest = opaque;
+
+    close_certs(sev_snp_guest);
+}
+
+static void certs_timeout(void *opaque)
+{
+    bool *timed_out = opaque;
+
+    *timed_out = true;
+}
+
+int kvm_handle_snp_req_certs(CPUState *cpu, struct kvm_run *run)
+{
+    struct kvm_exit_snp_req_certs *req_certs = &run->snp_req_certs;
+    g_autofree gchar *contents = NULL;
+    SevSnpGuestState *sev_snp_guest;
+    MemTxAttrs attrs = { 0 };
+    bool timed_out = false;
+    QEMUTimer *timer;
+    uint32_t npages;
+    void *guest_buf;
+    hwaddr buf_sz;
+    hwaddr gpa;
+    int ret;
+
+    req_certs->ret = EIO;
+
+    if (!sev_snp_enabled()) {
+        return -EIO;
+    }
+
+    gpa = req_certs->gfn << TARGET_PAGE_BITS;
+    npages = req_certs->npages;
+
+    sev_snp_guest = SEV_SNP_GUEST(MACHINE(qdev_get_machine())->cgs);
+    if (!sev_snp_guest->certs_filename) {
+        req_certs->ret = 0;
+        return 0;
+    }
+
+    /*
+     * -EAGAIN from open_certs_locked() indicates that a lock could not be
+     * obtained on the certificate file. It would be possible to set
+     * req_certs->ret = EAGAIN to immediately inform the requesting vCPU of
+     * this condition so that it can retry again later, however, linux guests
+     * are currently hard-limited to a 60 second timeout, at which point they
+     * will assume misbehavior and refuse to continue issuing attestation
+     * requests from that point forward.
+     *
+     * Allowing for this guest timeout to be configured in some way that will
+     * be easier to coordinate with on the QEMU side will make that approach
+     * more viable, but until then just busy-wait on the QEMU side, which
+     * allows more flexibility in how long QEMU can wait for things like SNP
+     * firmware updates/etc. which may be holding an exclusive lock on the
+     * certificate.
+     *
+     * The down-side to doing things this way is that too long of a busy-wait
+     * will result in soft-lockups in the guest, but the guest will otherwise
+     * continue normally afterward.
+     *
+     * If the QEMU-side timeout is reached, then just go ahead and indicate
+     * EAGAIN to the guest, at which point the above-mentioned guest-side
+     * timeout will trigger if QEMU's timeout exceeds that of the guest. But
+     * that's better than killing the vCPU, which is the only viable
+     * alternative at that point.
+     */
+    timer = timer_new_ms(QEMU_CLOCK_REALTIME, certs_timeout, &timed_out);
+    timer_mod(timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) +
+                     sev_snp_guest->certs_timeout);
+
+    do {
+        ret = open_certs_locked(sev_snp_guest);
+        g_usleep(1000);
+    } while (ret == -EAGAIN && !timed_out);
+
+    timer_del(timer);
+
+    if (ret) {
+        if (timed_out) {
+            req_certs->ret = EAGAIN;
+            return 0;
+        }
+
+        /*
+         * It's a bit ambiguous when to propagate a generic error to the guest
+         * rather than simply letting QEMU crash. The general methodology here
+         * is to let QEMU crash if there is a misconfiguration issue that the
+         * guest has absolutely no potential role in, but to otherwise notify
+         * the guest if there is some remote possibility that the issue is
+         * related to something on the guest side.
+         */
+        return ret;
+    }
+
+    buf_sz = npages * TARGET_PAGE_SIZE;
+    if (buf_sz < get_certs_size(sev_snp_guest)) {
+        req_certs->ret = ENOSPC;
+        req_certs->npages =
+            (get_certs_size(sev_snp_guest) + TARGET_PAGE_SIZE) / TARGET_PAGE_SIZE;
+        close_certs(sev_snp_guest);
+        goto out;
+    }
+
+    guest_buf = address_space_map(&address_space_memory, gpa, &buf_sz, true, attrs);
+    if (buf_sz < npages * TARGET_PAGE_SIZE) {
+        error_report_once("Unable to map entire guest buffer, mapped size %ld (expected %ld)",
+                          buf_sz, get_certs_size(sev_snp_guest));
+        close_certs(sev_snp_guest);
+        goto out_unmap;
+    }
+
+    ret = read_certs(sev_snp_guest, guest_buf, buf_sz);
+    if (ret < 0) {
+        error_report_once("Unable to read certificate data into guest buffer, ret %d",
+                          ret);
+        close_certs(sev_snp_guest);
+        goto out_unmap;
+
+    }
+
+    req_certs->ret = 0;
+
+    add_immediate_exit_callback(cpu, snp_release_certs_lock, sev_snp_guest);
+out_unmap:
+    address_space_unmap(&address_space_memory, guest_buf, buf_sz, true, buf_sz);
+
+out:
+    return ret;
+}
 
 static void
 sev_vm_state_change(void *opaque, bool running, RunState state)
@@ -1594,6 +1834,7 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 
 static int sev_snp_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 {
+    SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(cgs);
     MachineState *ms = MACHINE(qdev_get_machine());
     X86MachineState *x86ms = X86_MACHINE(ms);
 
@@ -1604,6 +1845,13 @@ static int sev_snp_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         return -1;
     }
 
+    if (sev_snp_guest->certs_filename &&
+        kvm_vm_enable_cap(kvm_state, KVM_CAP_EXIT_SNP_REQ_CERTS, 0, 1)) {
+        error_setg(errp, "Failed to enable support for SEV-SNP "
+                         "certificate-fetching requests.");
+        return -1;
+    }
+
     return 0;
 }
 
@@ -2393,6 +2641,26 @@ sev_snp_guest_set_host_data(Object *obj, const char *value, Error **errp)
     memcpy(finish->host_data, blob, len);
 }
 
+static char *
+sev_snp_guest_get_certs_filename(Object *obj, Error **errp)
+{
+    SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(obj);
+
+    return g_strdup(sev_snp_guest->certs_filename);
+}
+
+static void
+sev_snp_guest_set_certs_filename(Object *obj, const char *value, Error **errp)
+{
+    SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(obj);
+
+    if (sev_snp_guest->certs_filename) {
+        g_free(sev_snp_guest->certs_filename);
+    }
+
+    sev_snp_guest->certs_filename = value ? g_strdup(value) : NULL;
+}
+
 static void
 sev_snp_guest_class_init(ObjectClass *oc, void *data)
 {
@@ -2428,6 +2696,9 @@ sev_snp_guest_class_init(ObjectClass *oc, void *data)
     object_class_property_add_str(oc, "host-data",
                                   sev_snp_guest_get_host_data,
                                   sev_snp_guest_set_host_data);
+    object_class_property_add_str(oc, "certs-filename",
+                                  sev_snp_guest_get_certs_filename,
+                                  sev_snp_guest_set_certs_filename);
 }
 
 static void
@@ -2440,6 +2711,12 @@ sev_snp_guest_instance_init(Object *obj)
 
     /* default init/start/finish params for kvm */
     sev_snp_guest->kvm_start_conf.policy = DEFAULT_SEV_SNP_POLICY;
+
+    sev_snp_guest->certs_fd = -1;
+    sev_snp_guest->certs_timeout = 100;
+    object_property_add_uint32_ptr(obj, "certs-timeout",
+                                   &sev_snp_guest->certs_timeout,
+                                   OBJ_PROP_FLAG_READWRITE);
 }
 
 /* guest info specific to sev-snp */
diff --git a/target/i386/sev.h b/target/i386/sev.h
index 373669eaac..c85c585d9d 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -70,5 +70,5 @@ void pc_system_parse_sev_metadata(uint8_t *flash_ptr, size_t flash_size);
 
 uint32_t sev_get_cbit_position(void);
 uint32_t sev_get_reduced_phys_bits(void);
-
+int kvm_handle_snp_req_certs(CPUState *cpu, struct kvm_run *run);
 #endif
-- 
2.34.1


