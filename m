Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 130C7C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 17:52:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2x4a-0002Zn-B9; Fri, 03 May 2024 13:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1s2x4Y-0002ZO-Mc
 for qemu-devel@nongnu.org; Fri, 03 May 2024 13:51:50 -0400
Received: from mail-bn7nam10on2081.outbound.protection.outlook.com
 ([40.107.92.81] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1s2x4V-0004rV-TT
 for qemu-devel@nongnu.org; Fri, 03 May 2024 13:51:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxoHpm24CDyYoPHSuAvopAwsITJOBpRGl+/JlTnDRhFRJBy22lgnhodiDGpKUlb2Y9vESJz/s7W06wSz7rrQRdVjCBBdAoRauDABTLhDph9b5X0sUY0cWirqlM9V4XbFmofNMruW4U6rvYUBR2GeUcqDydd0DeKQRqqL3avOdoYXBI7vtheSAc6zjWdcpwrX9qnYAM0A+DvFDT1SUVe9tSOn++x893FnHkgfJmOBFU8TkYL3cXl4ATYkO9p5/PdWEVhTI31LW9oTakyKdo/Ds0d859CpUDyWisYRrteyl4Lm29INidpg/S9ZNc/6wm6IKhjkjsxvMc0Uu7O++eLQzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5d8c3BUNWI6YM+KBIXZAjXB/fKIsH40a2voVO/UBTGw=;
 b=XXdt+wBQNvGMFcbmFMBiU8mjketwDpUC7hmPCXrWWn6T2SsAS5lPQ/mL/zi6QP03oWUy202XoapY4fCcY12myhBSUBz5VRNPIlQlUK7WgywIbEdcSzojTXy3Aemw7GPMC/wprG4LIn97JE5hLBZX27lppYU991sdg/u6kMnTv/XJJYJPwDD/SKyGXQCP/C/Nfyi+nk687gnnDdz+TsaUGF9ohYTEazCHKyvO0bLR6EQRWqaY0DQeikm1BbIIwMZ1RYvkwQGTrOj9ZDQwNpaAySXwx5RyrkEt10/tjbl4WvYS+ZW77GCiMCAi+wq8pm1bSSaXjQvovdVl4mZRBBaJjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5d8c3BUNWI6YM+KBIXZAjXB/fKIsH40a2voVO/UBTGw=;
 b=jqzp5b9XSFvZjdLRT4J7Ix+lxE4B5jh/IJfXCkcXCRZJv8lTDNAD49vc1zCWaFMjy9wMFPY0VV6M/RKkOr73h+UBVvRhufJnBXUBf5XAZRbx59HmdSPa4esKaN7/Bm+tzUeg+BVFVflKc0Q3LG1ijWTv7FXNtqN19MEbX/VesbI=
Received: from CYZPR05CA0038.namprd05.prod.outlook.com (2603:10b6:930:a3::29)
 by CH2PR12MB4229.namprd12.prod.outlook.com (2603:10b6:610:a5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 17:46:41 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:a3:cafe::8a) by CYZPR05CA0038.outlook.office365.com
 (2603:10b6:930:a3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.11 via Frontend
 Transport; Fri, 3 May 2024 17:46:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 3 May 2024 17:46:40 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 3 May
 2024 12:46:39 -0500
From: Babu Moger <babu.moger@amd.com>
To: <pbonzini@redhat.com>, <richard.henderson@linaro.org>
CC: <weijiang.yang@intel.com>, <philmd@linaro.org>, <dwmw@amazon.co.uk>,
 <paul@xen.org>, <joao.m.martins@oracle.com>, <qemu-devel@nongnu.org>,
 <mtosatti@redhat.com>, <kvm@vger.kernel.org>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <yang.zhong@intel.com>, <jing2.liu@intel.com>,
 <vkuznets@redhat.com>, <michael.roth@amd.com>, <wei.huang2@amd.com>,
 <berrange@redhat.com>, <babu.moger@amd.com>, <bdas@redhat.com>,
 <eduardo@habkost.net>
Subject: [PATCH v3] target/i386: Fix CPUID encoding of Fn8000001E_ECX
Date: Fri, 3 May 2024 12:46:30 -0500
Message-ID: <0ee4b0a8293188a53970a2b0e4f4ef713425055e.1714757834.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102231738.46553-1-babu.moger@amd.com>
References: <20240102231738.46553-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|CH2PR12MB4229:EE_
X-MS-Office365-Filtering-Correlation-Id: d41e6af1-9eab-45d7-3005-08dc6b98fd41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230031|376005|36860700004|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OMIVPcfaCPJ+2ZgLGCE/zcXHlyZuMyJt5P9I4rEeyOBDTZNqFGVOc431ltKM?=
 =?us-ascii?Q?OCtN1MlE15g5WqOdVcqyk8bVoeC2/+zrdhjjT5ajyoblRXD4+wK+c9HYukr1?=
 =?us-ascii?Q?t/oVPOSuua9QoDpKvpSCh7Fypt4/zcSxHXT3K9D6lmZkn14Ntzsp5jpbbw4j?=
 =?us-ascii?Q?ZOK98ot5bglCXAOpj5u5O0fAHTH2ySQx04ax68VEslM0A5I91cKkr1yvW7T7?=
 =?us-ascii?Q?ifuci8DsRPMnQJAhT4HIxZZr0McwzCl5e3h8nv1KnUhhoxo+Xf5eTkMdEey1?=
 =?us-ascii?Q?pyL5vHg0j/MF69c38fYIfGHVk38q9Byz+bJPiC1Hp8M8TcVdeUf+/YyVGe2y?=
 =?us-ascii?Q?MiLxrp9gbN3vcWtpb4lU3ek6JbM+GgXaznBS+MHjI1G0SG7tlwON3i089CVl?=
 =?us-ascii?Q?/Zaai19Iv4KpixEyNMUpynj/I5bs4V0epORsKu2estt4yWWEN7fiWKh0Xh5e?=
 =?us-ascii?Q?IWZhNfPBvKfaZXllRnHtAuA7YxJSDsiJOuZ1M87dIMA5ZO4iLZLhlzcPxxQC?=
 =?us-ascii?Q?8i2KyAYGTQQ0TSCylLO/m+fsPcU4dqN1/maWfZ3MZWSRA0YJr/l7FeNvogjO?=
 =?us-ascii?Q?n1J+VNjN+fp5HOTDNdmCBIT0AqsyrfU7pkUmiTiwYOM1FkmzjvX+jvhX3k+3?=
 =?us-ascii?Q?iDdVa743W8PwIEBItqEelhTRiAOReJKUBrirRLPIAaPhGFvUMbH82T98UGzU?=
 =?us-ascii?Q?wWBgetWw8xOza3T64ioFxmDEu+HhXca4w12AqWoT95TLhNj7kucMhEE39Wck?=
 =?us-ascii?Q?8kibaZcxzNy8SBJl8W0KOCAA01OIcWpuIUCbxZ+sb2Ej+UDVT97wNR6n6dxg?=
 =?us-ascii?Q?/R1nT4eyOyBEEigW7g/NgQjWJDKMfS3NVWjVI7maPda2t06a0kcofoTdhnQL?=
 =?us-ascii?Q?/ya/gqUrL0rD4JxMF37MA5sUUzmD9YHSICBGYZQlgDV+9pdpc2+NSq5CMX5G?=
 =?us-ascii?Q?cxfy748goId+/1kzq159yOmtyruKcF+Z4jj1AIl1IStAZxHgHzziVOGzNI3W?=
 =?us-ascii?Q?J8VqYaByljCdTga40t/uOgl/de4uVUdPpHrKAMQf4y3L6YY6pm70YARegfds?=
 =?us-ascii?Q?RvdXZQA2Oig5bT5gd9XgY88WPHAJL4VmOf+usW5xKGe2EpgxUpjtIkzDkMr4?=
 =?us-ascii?Q?noGlcISadnW9RHcWACNzwN3Ht6eoBVWdHLQUbue8tlZWU3yUu17P/QTdBil8?=
 =?us-ascii?Q?wILG3hYCUp8nG8/jyBLA9XNtsT4jkbYO9v5jtqP2DUUXACjIsCvq8DXg0ryA?=
 =?us-ascii?Q?n75d8qD2Kbq93zNXrmbYnDS18I5Q2CiAaFihz8zUUevuEXom3UNxkg0rmAgN?=
 =?us-ascii?Q?bE70+Hieet/EgpfvNP+MUltkK6T9CwZ2ElrThOfyWbSNXQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(7416005)(1800799015); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 17:46:40.6782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d41e6af1-9eab-45d7-3005-08dc6b98fd41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4229
Received-SPF: permerror client-ip=40.107.92.81;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

Observed the following failure while booting the SEV-SNP guest and the
guest fails to boot with the smp parameters:
"-smp 192,sockets=1,dies=12,cores=8,threads=2".

qemu-system-x86_64: sev_snp_launch_update: SNP_LAUNCH_UPDATE ret=-5 fw_error=22 'Invalid parameter'
qemu-system-x86_64: SEV-SNP: CPUID validation failed for function 0x8000001e, index: 0x0.
provided: eax:0x00000000, ebx: 0x00000100, ecx: 0x00000b00, edx: 0x00000000
expected: eax:0x00000000, ebx: 0x00000100, ecx: 0x00000300, edx: 0x00000000
qemu-system-x86_64: SEV-SNP: failed update CPUID page

Reason for the failure is due to overflowing of bits used for "Node per
processor" in CPUID Fn8000001E_ECX. This field's width is 3 bits wide and
can hold maximum value 0x7. With dies=12 (0xB), it overflows and spills
over into the reserved bits. In the case of SEV-SNP, this causes CPUID
enforcement failure and guest fails to boot.

The PPR documentation for CPUID_Fn8000001E_ECX [Node Identifiers]
=================================================================
Bits    Description
31:11   Reserved.

10:8    NodesPerProcessor: Node per processor. Read-only.
        ValidValues:
        Value   Description
        0h      1 node per processor.
        7h-1h   Reserved.

7:0     NodeId: Node ID. Read-only. Reset: Fixed,XXh.
=================================================================

As in the spec, the valid value for "node per processor" is 0 and rest
are reserved.

Looking back at the history of decoding of CPUID_Fn8000001E_ECX, noticed
that there were cases where "node per processor" can be more than 1. It
is valid only for pre-F17h (pre-EPYC) architectures. For EPYC or later
CPUs, the linux kernel does not use this information to build the L3
topology.

Also noted that the CPUID Function 0x8000001E_ECX is available only when
TOPOEXT feature is enabled. This feature is enabled only for EPYC(F17h)
or later processors. So, previous generation of processors do not not
enumerate 0x8000001E_ECX leaf.

There could be some corner cases where the older guests could enable the
TOPOEXT feature by running with -cpu host, in which case legacy guests
might notice the topology change. To address those cases introduced a
new CPU property "legacy-multi-node". It will be true for older machine
types to maintain compatibility. By default, it will be false, so new
decoding will be used going forward.

The documentation is taken from Preliminary Processor Programming
Reference (PPR) for AMD Family 19h Model 11h, Revision B1 Processors 55901
Rev 0.25 - Oct 6, 2022.

Cc: qemu-stable@nongnu.org
Fixes: 31ada106d891 ("Simplify CPUID_8000_001E for AMD")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v3:
  Rebased to the latest tree.
  Updated the pc_compat_9_0 for the new flag.

v2:
   https://lore.kernel.org/kvm/20240102231738.46553-1-babu.moger@amd.com/
   Rebased to the latest tree.
   Updated the pc_compat_8_2 for the new flag.
   Added the comment for new property legacy_multi_node.
   Added Reviwed-by from Zhao.

v1:
   https://lore.kernel.org/kvm/20231110170806.70962-1-babu.moger@amd.com/
---
 hw/i386/pc.c      |  1 +
 target/i386/cpu.c | 18 ++++++++++--------
 target/i386/cpu.h |  6 ++++++
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 08c7de416f..46235466d7 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -81,6 +81,7 @@
 GlobalProperty pc_compat_9_0[] = {
     { TYPE_X86_CPU, "guest-phys-bits", "0" },
     { "sev-guest", "legacy-vm-type", "true" },
+    { TYPE_X86_CPU, "legacy-multi-node", "on" },
 };
 const size_t pc_compat_9_0_len = G_N_ELEMENTS(pc_compat_9_0);
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index aa3b2d8391..ceb068027d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -398,12 +398,9 @@ static void encode_topo_cpuid8000001e(X86CPU *cpu, X86CPUTopoInfo *topo_info,
      * 31:11 Reserved.
      * 10:8 NodesPerProcessor: Node per processor. Read-only. Reset: XXXb.
      *      ValidValues:
-     *      Value Description
-     *      000b  1 node per processor.
-     *      001b  2 nodes per processor.
-     *      010b Reserved.
-     *      011b 4 nodes per processor.
-     *      111b-100b Reserved.
+     *      Value   Description
+     *      0h      1 node per processor.
+     *      7h-1h   Reserved.
      *  7:0 NodeId: Node ID. Read-only. Reset: XXh.
      *
      * NOTE: Hardware reserves 3 bits for number of nodes per processor.
@@ -412,8 +409,12 @@ static void encode_topo_cpuid8000001e(X86CPU *cpu, X86CPUTopoInfo *topo_info,
      * NodeId is combination of node and socket_id which is already decoded
      * in apic_id. Just use it by shifting.
      */
-    *ecx = ((topo_info->dies_per_pkg - 1) << 8) |
-           ((cpu->apic_id >> apicid_die_offset(topo_info)) & 0xFF);
+    if (cpu->legacy_multi_node) {
+        *ecx = ((topo_info->dies_per_pkg - 1) << 8) |
+               ((cpu->apic_id >> apicid_die_offset(topo_info)) & 0xFF);
+    } else {
+        *ecx = (cpu->apic_id >> apicid_pkg_offset(topo_info)) & 0xFF;
+    }
 
     *edx = 0;
 }
@@ -8073,6 +8074,7 @@ static Property x86_cpu_properties[] = {
      * own cache information (see x86_cpu_load_def()).
      */
     DEFINE_PROP_BOOL("legacy-cache", X86CPU, legacy_cache, true),
+    DEFINE_PROP_BOOL("legacy-multi-node", X86CPU, legacy_multi_node, false),
     DEFINE_PROP_BOOL("xen-vapic", X86CPU, xen_vapic, false),
 
     /*
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 565c7a98c3..1e0d2c915f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1994,6 +1994,12 @@ struct ArchCPU {
      */
     bool legacy_cache;
 
+    /* Compatibility bits for old machine types.
+     * If true decode the CPUID Function 0x8000001E_ECX to support multiple
+     * nodes per processor
+     */
+    bool legacy_multi_node;
+
     /* Compatibility bits for old machine types: */
     bool enable_cpuid_0xb;
 
-- 
2.34.1


