Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA63C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 19:13:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHTOw-0005R6-4x; Wed, 12 Jun 2024 15:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1sHTOu-0005Qy-Nr
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 15:12:53 -0400
Received: from mail-co1nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2416::601]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1sHTOq-00035k-OH
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 15:12:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZgRtYvcZbcs/4UElVEYRKMn2eRD5TuoHw8qjO2138rK8uKd8QmF5zIgaoKCkeoVvT2b3bQTcRADDSVKSeMpX8L8429c/bkj0In7ZFXN9Eby94p3WRmnKy1kja8L8yz5BGr1BI7Nm2/qLY1wYKxmMMoz+dGG5P/L5+nbN+/dl8BRaIQmO2x4DdSRDE9HevObBY1pt3jkFJcl3YatyK8MvAvCSjLAfM7xLgud57cptIgrYnkyDOayJvb0QSixruQOMc0cX7+i+u4UCHcld7cbFUs23MIqabl5r8C+dag1tVeYE4m/M9W4k6oFjmcv487KSzSk6A4yRhHNxUfN7CoDwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldQ7tdc/hx5FIhbeFo0Ik1F9+l691o6Tm7Tc+hZMZHA=;
 b=Qx/97uD+Xc3+AmOvEbIBeQeJ2PvoNyRynx2VlxATZFhwVLw87IdHP52vSUHL1Q/2QnlgZrO3ernrKAZZtT/wGozBVh2IsBH7Zd9HRxKdJxAocD3UcCtYCGTcUf2MVuiTbpw9kAWCF8tqUuXPXuTASMDsbvfmeoH3WylBIEmG/eJoATm3VT1MFqFW1OFSKBQRaFXHO+303er4MFUQHr1jw8m/K6q0a2Ru8bCkWBCUIudZgBZUaV9R3qxcsn24dYJUkHMgBy+QPb4XDc6Lk2CqtLVwz31kn1vJzb0EhYYjoB+O21CaRoWyb/WCn1Wd4LBKmYK3uSTeiv/7rOKyAdr8fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldQ7tdc/hx5FIhbeFo0Ik1F9+l691o6Tm7Tc+hZMZHA=;
 b=PD414hw0A1xUXfmMfi0ITs/dkXlQeGeV/OpYqoiv7ANw44IpCqKTpOpU+J6wuKuGHBpOopH06rPHiV9D3dvnDZNXzQfnP3lABX/ifXKa5Y0r5uodFqeViDHfa0QXzu1givrs8FEm0SjCXbDH4wowHzCHNsqE+bUesx7sNGcG0VM=
Received: from BYAPR05CA0071.namprd05.prod.outlook.com (2603:10b6:a03:74::48)
 by PH7PR12MB6907.namprd12.prod.outlook.com (2603:10b6:510:1b9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 19:12:41 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a03:74:cafe::1d) by BYAPR05CA0071.outlook.office365.com
 (2603:10b6:a03:74::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20 via Frontend
 Transport; Wed, 12 Jun 2024 19:12:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 12 Jun 2024 19:12:41 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Jun
 2024 14:12:39 -0500
From: Babu Moger <babu.moger@amd.com>
To: <pbonzini@redhat.com>
CC: <qemu-devel@nongnu.org>, <babu.moger@amd.com>, <kvm@vger.kernel.org>
Subject: [PATCH 2/4] i386/cpu: Add PerfMonV2 feature bit
Date: Wed, 12 Jun 2024 14:12:18 -0500
Message-ID: <6f83528b78d31eb2543aa09966e1d9bcfd7ec8a2.1718218999.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718218999.git.babu.moger@amd.com>
References: <cover.1718218999.git.babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|PH7PR12MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 69d75e5a-1d1f-414d-14a5-08dc8b13a1e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230034|36860700007|376008|1800799018|82310400020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bXJYwTfqAmEboHzI9C9nHGZgu72cMrLYhdcXOK6mctrxtWC/dKVX4wzQXB4Q?=
 =?us-ascii?Q?TnAachef2T/SwPQk3At0rnRy7Mxv+m/jH9+YuaJ66FpliVHIez2g8C1OmDF6?=
 =?us-ascii?Q?yQb4P58scRCnaL0adeKogI4DsWqBSMd9JmIYxAxonYLZf9eu6qoVS/I+HFSF?=
 =?us-ascii?Q?zY1+6weknsWpvSNYsGj7zRsGN+DZsxTuR3G3VeaTAPrpaUtiQmZp6SSGTRRQ?=
 =?us-ascii?Q?iIXDepVXSUdqvBXbag62+R3YP4K9f1SwTjA2rm/Kvsbfn2eOcYP2v+sF9J+C?=
 =?us-ascii?Q?qNl2IbrE+2dNv/dUNYRIPTf7McPkdZUDXodMyY6uUPTwNo5CUoLIKruf3cw5?=
 =?us-ascii?Q?lWF5GpCkWoypSC9f6vTiirb/1+aQ7Jd6y3aUQAx1fhsTngEBwAxwjddXfJ0t?=
 =?us-ascii?Q?x7vOam77nq1UVebZH0FIZkBOM41+0AS3eUIT7hYBVDI3FzkG2j/Sm2gQH623?=
 =?us-ascii?Q?GrItWXKMxlAQifAda/U/E4ojwzvYeXBpFfc+tcLzQvFEdDQxs61ZfghB/dRM?=
 =?us-ascii?Q?ox1putB0ZZy1OEWAoxadP5V30Hqfg51sKHhJL8PmDXxHGGvpTossEiEvgyT0?=
 =?us-ascii?Q?VwwXqUqKoIRVLdw2a3F/40/oeYBQYjSck3plVorJbILLa233hjfv9g9Rkf8A?=
 =?us-ascii?Q?dUDQB152FFAHoUed0mJC5hOJt9vPjijXyVZIASnaIrod+8pLAYfS1t6lSp8Q?=
 =?us-ascii?Q?ZuOrji/RmHkQhpg5AL0X8WK9TaHAUoySXPQsrRxngQHAHKZ209OQuFLS5rtK?=
 =?us-ascii?Q?/E1PZz4DB7Spkux8TK5vaj16ODYTBdPcnAvSUL08IWIFhLHjEFbfdKG8aFTU?=
 =?us-ascii?Q?J+4+a+8sgJ0ewX57MQsGAe67A8C/GFg0+daBJr4D8Ama51FRbSxwc6stH/er?=
 =?us-ascii?Q?YVcG/NFCgh1RgWdzqdQbT7Jjk8WTcxU7+bmdqRRZXNnc3WIifTtx8nF2cY1X?=
 =?us-ascii?Q?jy9663jZzbffBYl9kCOHll5hWAoAb7b0UQQUHQSgsvxe6sNY2a1xLnNkDQif?=
 =?us-ascii?Q?CvZ0yNBsaTeCRtFkIcVgIM9YTDMCAMcUUki3Ae1jGv67qS9ZGEg5Nz1Kag5A?=
 =?us-ascii?Q?B+r8LjkuS/0ONVuYH8H6LfHpaqbgVpdZ04LtMFZeWblGfKsROKqoT/hzRE2c?=
 =?us-ascii?Q?3RatT/vRK8YnjnViizaeWCZlSvrFv/D4PZyiONmKsokhiGYHUskkK2AQiiGp?=
 =?us-ascii?Q?UxWicvVdnKi9CrzloOXUWfc7IKAz1NNAiE0aaRgKVZ4j+6e22n248XUMIOKB?=
 =?us-ascii?Q?/U9s/QCIdRGUV1dzNMpmKnPh3r0MCXe3FyAuxWQPclSf/P8I5pHDDXi534KI?=
 =?us-ascii?Q?B/QL4BxOlX0zfm0BqjFusI9WaHCgIJNAzHSvoiBvzLmJkfbMI1YGBrS6alTH?=
 =?us-ascii?Q?q95hBXYqt4LgyeQzuJtFmRC2HaHNw+2uPD3pvIzebgXw3I6Sfw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230034)(36860700007)(376008)(1800799018)(82310400020); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 19:12:41.2943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d75e5a-1d1f-414d-14a5-08dc8b13a1e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6907
Received-SPF: permerror client-ip=2a01:111:f403:2416::601;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

From: Sandipan Das <sandipan.das@amd.com>

CPUID leaf 0x80000022, i.e. ExtPerfMonAndDbg, advertises new performance
monitoring features for AMD processors. Bit 0 of EAX indicates support
for Performance Monitoring Version 2 (PerfMonV2) features. If found to
be set during PMU initialization, the EBX bits can be used to determine
the number of available counters for different PMUs. It also denotes the
availability of global control and status registers.

Add the required CPUID feature word and feature bit to allow guests to
make use of the PerfMonV2 features.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 target/i386/cpu.c | 26 ++++++++++++++++++++++++++
 target/i386/cpu.h |  4 ++++
 2 files changed, 30 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 86a90b1405..7f1837cdc9 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1228,6 +1228,22 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .tcg_features = 0,
         .unmigratable_flags = 0,
     },
+    [FEAT_8000_0022_EAX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            "perfmon-v2", NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .cpuid = { .eax = 0x80000022, .reg = R_EAX, },
+        .tcg_features = 0,
+        .unmigratable_flags = 0,
+    },
     [FEAT_XSAVE] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
@@ -6998,6 +7014,16 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *edx = 0;
         }
         break;
+    case 0x80000022:
+        *eax = *ebx = *ecx = *edx = 0;
+        /* AMD Extended Performance Monitoring and Debug */
+        if (kvm_enabled() && cpu->enable_pmu &&
+            (env->features[FEAT_8000_0022_EAX] & CPUID_8000_0022_EAX_PERFMON_V2)) {
+            *eax = CPUID_8000_0022_EAX_PERFMON_V2;
+            *ebx = kvm_arch_get_supported_cpuid(cs->kvm_state, index, count,
+                                                R_EBX) & 0xf;
+        }
+        break;
     case 0xC0000000:
         *eax = env->cpuid_xlevel2;
         *ebx = 0;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index ba7f740392..03378da8fa 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -611,6 +611,7 @@ typedef enum FeatureWord {
     FEAT_8000_0007_EDX, /* CPUID[8000_0007].EDX */
     FEAT_8000_0008_EBX, /* CPUID[8000_0008].EBX */
     FEAT_8000_0021_EAX, /* CPUID[8000_0021].EAX */
+    FEAT_8000_0022_EAX, /* CPUID[8000_0022].EAX */
     FEAT_C000_0001_EDX, /* CPUID[C000_0001].EDX */
     FEAT_KVM,           /* CPUID[4000_0001].EAX (KVM_CPUID_FEATURES) */
     FEAT_KVM_HINTS,     /* CPUID[4000_0001].EDX */
@@ -986,6 +987,9 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 /* Automatic IBRS */
 #define CPUID_8000_0021_EAX_AUTO_IBRS   (1U << 8)
 
+/* Performance Monitoring Version 2 */
+#define CPUID_8000_0022_EAX_PERFMON_V2  (1U << 0)
+
 #define CPUID_XSAVE_XSAVEOPT   (1U << 0)
 #define CPUID_XSAVE_XSAVEC     (1U << 1)
 #define CPUID_XSAVE_XGETBV1    (1U << 2)
-- 
2.34.1


