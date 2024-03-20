Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B74C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmri9-0002ZW-Gt; Wed, 20 Mar 2024 04:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmri8-0002XM-RH
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:54:12 -0400
Received: from mail-mw2nam10on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2412::600]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmri6-0001lC-Uv
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:54:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IvdUX1X9Sk+l9AmzX+dgav5yA2eQn8hpKnOBiKHiJo5b70JRBei4Xy8266pwflKp20MgRZpeWsp5EOKp/VUBHa8JJHZdWZzRUVBK5mHCOIWymuRyk2Zc8WzgQ2xs8cOVJS2VhiuVHGvfQZmxcPL9mbtRRVZ55oQgc4GhOcVYpVB/IJEoPh4t4M2V3O6qslIPEMFTtddGY5jX+wR3IvMhCHVS1spqisyUm/sJHhOzx8bzMHFM+JyfINel8DrzfuwhmRvn2UoBiN8+kG+Hfv2zeWiInj7T6v6kgGrr3BYpJnBzVyXaeIcbnB0zazi3tk0kwdWe4f6u9XLKVlxoIfrIYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvxwD5kwhSj5IdGp8kKYpvsxTiNI/x8OnjdWm8PBU3s=;
 b=h1Cxbigz2Imu5syq3wki2nN/EH/lY6VQLfFrjpxtluYAM1FCikGjkOrUUxQ/8Upxflyh6Y/Zd2/ogopLmKOR0UD51tXLXG/H5Z31Owbo7y4F8SwKCefZjQn1lMdlq4eiBPnSHVlnNM1RY9JuHZYkVu0kOpKN+dun+dtvuGRvkcJRM5+iYOuAkSWXN24aF9QJXOA8EOX1izpSJnhfzO+/aSs3MsEORy/7vUP6YbLx7QzBsA9ltQxcgNdX0bYZ8RwljvITlxEAz9daNYxiR95oVzEV1gCYMEpMoBVauYvV19kuMLk8HPA5oaSd6Ig/OiG07GyfyA9Gby9VKw28ObMa/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvxwD5kwhSj5IdGp8kKYpvsxTiNI/x8OnjdWm8PBU3s=;
 b=Dnjbqh2ivkPAfCCjM4y1fYpOg60ng0SAOpDOkxeXOuOO1TVm8Z3RZpOTcMNkFlmw6ltN4EbdF4zlZwjJO2VU8i0VJwCbBdiaE3FWTq33jhE68WSlba/4jvxeTAMwhZxMQlyj8bWzj58ZaQtawAwEhMgpxZMXpMKvdTYf731hezo=
Received: from BN9PR03CA0799.namprd03.prod.outlook.com (2603:10b6:408:13f::24)
 by PH8PR12MB7160.namprd12.prod.outlook.com (2603:10b6:510:228::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Wed, 20 Mar
 2024 08:54:04 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:13f:cafe::aa) by BN9PR03CA0799.outlook.office365.com
 (2603:10b6:408:13f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.37 via Frontend
 Transport; Wed, 20 Mar 2024 08:54:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 08:54:04 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 03:54:03 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta
 <pankaj.gupta@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Isaku Yamahata
 <isaku.yamahata@linux.intel.com>
Subject: [PATCH v3 42/49] i386/sev: Add support for SNP CPUID validation
Date: Wed, 20 Mar 2024 03:39:38 -0500
Message-ID: <20240320083945.991426-43-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|PH8PR12MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f7ce8e1-d022-498b-e829-08dc48bb4b95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cu+CuNi3mjP7xT1WKkZ3gPcmNhJ6ov6icitFitxov1kFlZTFiCUmnFPWNFR3ZreDnoyvfc4UEYVf8pEaN+LmWxFzph36unYkNVtHtgwCikvUgzzUh4AFFgnfJ5gERgLIPWCJUa6gl6oF5Nm5L/ZB3tH0FMibOx0wBrb4Wo4FDmde3bRw13CMhkO0X6fdzCikn0a7YMHF3JVGiBgG//qmyDaCFBLIKUkHgrIz9Xq4SkQK+TwDBNbMwNnNSQTHtG0vTXMuVf3Fdh95nJfrAN3MBzX7ZKVG1ev52eNxYJ0Gdb9RJb8SOBjFyqPN7DMQ5SKeTHitJSfjSOeLV0BKxVdLEsNhi8xrXOWzWfhsHSoGkrUuKRW3azRDx21u0Lpmb0INN2rPstQMMwpCB0jcf+Iy6hlVUi/gbgrGNw3yYx/j4vqG16YG60mfyOJgwqQ5hU88SM7hxOybmDc/4BTja/B2rJ6UkVY7ODMxa0immPgTloRMI8hWDWNErZeHKAXlwYWXsXf803iTbXYRcKxMALH9M+bmAN/sb8VA0inRiggSaAwnqPDnwHoR+zjShhXOJkoOaVsyrJXxalr+tcTXdC8vr3f6p/ZIBxtChmIeV9M1YwzorScxy+fCB8dPeiLj/C9z9IC+qirCQQYML6F9J5mgijJPQzggqa5ho4MnbFLcBKLdr4U42PGe7+/oSGvBBr7k6I0RT/V4vYQQhVoUPk21bawe6oWWmBDx/3aKAZOzo971yt3O/Mr5zXK3gd01krPg
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 08:54:04.3498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7ce8e1-d022-498b-e829-08dc48bb4b95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7160
Received-SPF: permerror client-ip=2a01:111:f403:2412::600;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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

SEV-SNP firmware allows a special guest page to be populated with a
table of guest CPUID values so that they can be validated through
firmware before being loaded into encrypted guest memory where they can
be used in place of hypervisor-provided values[1].

As part of SEV-SNP guest initialization, use this interface to validate
the CPUID entries reported by KVM_GET_CPUID2 prior to initial guest
start and populate the CPUID page reserved by OVMF with the resulting
encrypted data.

[1] SEV SNP Firmware ABI Specification, Rev. 0.8, 8.13.2.6

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 target/i386/sev.c | 159 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 158 insertions(+), 1 deletion(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 6c5166c729..db888afb53 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -191,6 +191,36 @@ static const char *const sev_fw_errlist[] = {
 
 #define SEV_FW_MAX_ERROR      ARRAY_SIZE(sev_fw_errlist)
 
+/* <linux/kvm.h> doesn't expose this, so re-use the max from kvm.c */
+#define KVM_MAX_CPUID_ENTRIES 100
+
+typedef struct KvmCpuidInfo {
+    struct kvm_cpuid2 cpuid;
+    struct kvm_cpuid_entry2 entries[KVM_MAX_CPUID_ENTRIES];
+} KvmCpuidInfo;
+
+#define SNP_CPUID_FUNCTION_MAXCOUNT 64
+#define SNP_CPUID_FUNCTION_UNKNOWN 0xFFFFFFFF
+
+typedef struct {
+    uint32_t eax_in;
+    uint32_t ecx_in;
+    uint64_t xcr0_in;
+    uint64_t xss_in;
+    uint32_t eax;
+    uint32_t ebx;
+    uint32_t ecx;
+    uint32_t edx;
+    uint64_t reserved;
+} __attribute__((packed)) SnpCpuidFunc;
+
+typedef struct {
+    uint32_t count;
+    uint32_t reserved1;
+    uint64_t reserved2;
+    SnpCpuidFunc entries[SNP_CPUID_FUNCTION_MAXCOUNT];
+} __attribute__((packed)) SnpCpuidInfo;
+
 static int
 sev_ioctl(int fd, int cmd, void *data, int *error)
 {
@@ -749,6 +779,34 @@ out:
     return ret;
 }
 
+static void
+sev_snp_cpuid_report_mismatches(SnpCpuidInfo *old,
+                                SnpCpuidInfo *new)
+{
+    size_t i;
+
+    if (old->count != new->count) {
+        error_report("SEV-SNP: CPUID validation failed due to count mismatch, provided: %d, expected: %d",
+                     old->count, new->count);
+    }
+
+    for (i = 0; i < old->count; i++) {
+        SnpCpuidFunc *old_func, *new_func;
+
+        old_func = &old->entries[i];
+        new_func = &new->entries[i];
+
+        if (memcmp(old_func, new_func, sizeof(SnpCpuidFunc))) {
+            error_report("SEV-SNP: CPUID validation failed for function 0x%x, index: 0x%x.\n"
+                         "provided: eax:0x%08x, ebx: 0x%08x, ecx: 0x%08x, edx: 0x%08x\n"
+                         "expected: eax:0x%08x, ebx: 0x%08x, ecx: 0x%08x, edx: 0x%08x",
+                         old_func->eax_in, old_func->ecx_in,
+                         old_func->eax, old_func->ebx, old_func->ecx, old_func->edx,
+                         new_func->eax, new_func->ebx, new_func->ecx, new_func->edx);
+        }
+    }
+}
+
 static const char *
 snp_page_type_to_str(int type)
 {
@@ -766,6 +824,7 @@ static int
 sev_snp_launch_update(SevSnpGuestState *sev_snp_guest, SevLaunchUpdateData *data)
 {
     int ret, fw_error;
+    SnpCpuidInfo snp_cpuid_info;
     struct kvm_sev_snp_launch_update update = {0};
 
     if (!data->hva || !data->len) {
@@ -774,6 +833,11 @@ sev_snp_launch_update(SevSnpGuestState *sev_snp_guest, SevLaunchUpdateData *data
         return 1;
     }
 
+    if (data->type == KVM_SEV_SNP_PAGE_TYPE_CPUID) {
+        /* Save a copy for comparison in case the LAUNCH_UPDATE fails */
+        memcpy(&snp_cpuid_info, data->hva, sizeof(snp_cpuid_info));
+    }
+
     update.uaddr = (__u64)(unsigned long)data->hva;
     update.gfn_start = data->gpa >> TARGET_PAGE_BITS;
     update.len = data->len;
@@ -798,6 +862,11 @@ sev_snp_launch_update(SevSnpGuestState *sev_snp_guest, SevLaunchUpdateData *data
     if (ret) {
         error_report("SNP_LAUNCH_UPDATE ret=%d fw_error=%d '%s'",
                      ret, fw_error, fw_error_to_str(fw_error));
+
+        if (data->type == KVM_SEV_SNP_PAGE_TYPE_CPUID) {
+            sev_snp_cpuid_report_mismatches(&snp_cpuid_info, data->hva);
+            error_report("SEV-SNP: failed update CPUID page");
+        }
     }
 
 out:
@@ -965,6 +1034,89 @@ snp_launch_update_data(uint64_t gpa, void *hva, uint32_t len, int type)
     return 0;
 }
 
+static int
+sev_snp_cpuid_info_fill(SnpCpuidInfo *snp_cpuid_info,
+                        const KvmCpuidInfo *kvm_cpuid_info)
+{
+    size_t i;
+
+    if (kvm_cpuid_info->cpuid.nent > SNP_CPUID_FUNCTION_MAXCOUNT) {
+        error_report("SEV-SNP: CPUID entry count (%d) exceeds max (%d)",
+                     kvm_cpuid_info->cpuid.nent, SNP_CPUID_FUNCTION_MAXCOUNT);
+        return -1;
+    }
+
+    memset(snp_cpuid_info, 0, sizeof(*snp_cpuid_info));
+
+    for (i = 0; i < kvm_cpuid_info->cpuid.nent; i++) {
+        const struct kvm_cpuid_entry2 *kvm_cpuid_entry;
+        SnpCpuidFunc *snp_cpuid_entry;
+
+        kvm_cpuid_entry = &kvm_cpuid_info->entries[i];
+        snp_cpuid_entry = &snp_cpuid_info->entries[i];
+
+        snp_cpuid_entry->eax_in = kvm_cpuid_entry->function;
+        if (kvm_cpuid_entry->flags == KVM_CPUID_FLAG_SIGNIFCANT_INDEX) {
+            snp_cpuid_entry->ecx_in = kvm_cpuid_entry->index;
+        }
+        snp_cpuid_entry->eax = kvm_cpuid_entry->eax;
+        snp_cpuid_entry->ebx = kvm_cpuid_entry->ebx;
+        snp_cpuid_entry->ecx = kvm_cpuid_entry->ecx;
+        snp_cpuid_entry->edx = kvm_cpuid_entry->edx;
+
+        /*
+         * Guest kernels will calculate EBX themselves using the 0xD
+         * subfunctions corresponding to the individual XSAVE areas, so only
+         * encode the base XSAVE size in the initial leaves, corresponding
+         * to the initial XCR0=1 state.
+         */
+        if (snp_cpuid_entry->eax_in == 0xD &&
+            (snp_cpuid_entry->ecx_in == 0x0 || snp_cpuid_entry->ecx_in == 0x1)) {
+            snp_cpuid_entry->ebx = 0x240;
+            snp_cpuid_entry->xcr0_in = 1;
+            snp_cpuid_entry->xss_in = 0;
+        }
+    }
+
+    snp_cpuid_info->count = i;
+
+    return 0;
+}
+
+static int
+snp_launch_update_cpuid(uint32_t cpuid_addr, void *hva, uint32_t cpuid_len)
+{
+    KvmCpuidInfo kvm_cpuid_info = {0};
+    SnpCpuidInfo snp_cpuid_info;
+    CPUState *cs = first_cpu;
+    int ret;
+    uint32_t i = 0;
+
+    assert(sizeof(snp_cpuid_info) <= cpuid_len);
+
+    /* get the cpuid list from KVM */
+    do {
+        kvm_cpuid_info.cpuid.nent = ++i;
+        ret = kvm_vcpu_ioctl(cs, KVM_GET_CPUID2, &kvm_cpuid_info);
+    } while (ret == -E2BIG);
+
+    if (ret) {
+        error_report("SEV-SNP: unable to query CPUID values for CPU: '%s'",
+                     strerror(-ret));
+        return 1;
+    }
+
+    ret = sev_snp_cpuid_info_fill(&snp_cpuid_info, &kvm_cpuid_info);
+    if (ret) {
+        error_report("SEV-SNP: failed to generate CPUID table information");
+        return 1;
+    }
+
+    memcpy(hva, &snp_cpuid_info, sizeof(snp_cpuid_info));
+
+    return snp_launch_update_data(cpuid_addr, hva, cpuid_len, KVM_SEV_SNP_PAGE_TYPE_CPUID);
+}
+
 static int
 snp_metadata_desc_to_page_type(int desc_type)
 {
@@ -1001,7 +1153,12 @@ snp_populate_metadata_pages(SevSnpGuestState *sev_snp, OvmfSevMetadata *metadata
             exit(1);
         }
 
-        ret = snp_launch_update_data(desc->base, hva, desc->len, type);
+        if (type == KVM_SEV_SNP_PAGE_TYPE_CPUID) {
+            ret = snp_launch_update_cpuid(desc->base, hva, desc->len);
+        } else {
+            ret = snp_launch_update_data(desc->base, hva, desc->len, type);
+        }
+
         if (ret) {
             error_report("%s: Failed to add metadata page gpa 0x%x+%x type %d\n",
                          __func__, desc->base, desc->len, desc->type);
-- 
2.25.1


