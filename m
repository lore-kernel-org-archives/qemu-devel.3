Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E141CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xES9V-0000g8-SN; Wed, 07 Oct 2026 09:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xERzS-0005zV-03
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 09:47:34 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xERzO-0003xG-CD
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 09:47:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9FVv83/RQUsciOGdHmGYk+yUkeKxVWyLMJFsHGt9kHE8OILWn5o5MRQhzCPBlk8B2WbH7lLOkHb+zYx59dsAt7CLND1s9eYo1CEAC6TSTLHIFhlVbmS8To66FBXWstMyf6QQS4ZZ7s/yiXy5stQbMb1FOTKMznsLm4TRC0XyW3CqFeBwlnVn1C8mwXS6PioJO5Q3mC+D9JSPTHDQFMRhz6/OuNptI2b68CTpLvgu8GmlERejxC/A0FlzIhnME1bDUlGhY3YwIjFbowke0oybIlGIfx291VT/Vd/23VAZ6DjLgASpo0zuF0FbcjgTo/z/MWol2E2XA8SJq0jjQtX+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djdy3ap9zZZofMHXTK9YbhJE/+NG1SGUcCOO763Htlc=;
 b=UYxUOGitiFuiMCTTVBm0DVT3buhDxTjA7tCx1RPeOuV0cUqCcZRZK7y4OyTknE/gG6n/TvRk3VSq+4Q7wpf0czYxkjcQD9u5V5Ga+dmLIrcfmw12aeNMgrTjw2158JNJ/Pvo7hy6vcxf4kvykEw8TkZ6whJkB9dFXTYvAXWjavO12GJocMWRLyfHKNjhJzPbWmgGLmpU49Ayg+Aj1mcE8bf4TwAvcWZlloL+KrCowpJVuRJnbw/QC1v38bVGl3mm8PrLiqdA3eN6JmOvDmgKCNey7b/Hw/JfmWS4zDgg1q3164Mb4N3/jIKXG+DCcd6TXOjcu83o8XOYeDasjsfEeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djdy3ap9zZZofMHXTK9YbhJE/+NG1SGUcCOO763Htlc=;
 b=kitZRLbKcFzSXZ3rb5Ma18t8HQyjZ93WhWpzFXSGO87WwRPGSR1NJX3L0gY4zOdtESlMrHA4NZ4Po+3PuZKyzYxqkpjr1ZqwYhftcy/2zIFBMcVFJa2qWVVsEmqzDOLnTV3LikEozUObsQB8GJTO3c1TXurynUMBUJ0C1uqn4ek=
Received: from MW4PR04CA0055.namprd04.prod.outlook.com (2603:10b6:303:6a::30)
 by DS0PR12MB8788.namprd12.prod.outlook.com (2603:10b6:8:14f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 7 Oct
 2026 13:47:14 +0000
Received: from BY1PEPF000264B3.namprd02.prod.outlook.com
 (2603:10b6:303:6a:cafe::a2) by MW4PR04CA0055.outlook.office365.com
 (2603:10b6:303:6a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 13:47:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B3.mail.protection.outlook.com (10.167.242.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 13:47:13 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 08:47:12 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <xiaoyao.li@intel.com>,
 <chao.p.peng@linux.intel.com>, <david@kernel.org>, <ashish.kalra@amd.com>,
 <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v3 18/19] i386/sev: Add sev-snp-guest parameter to enable
 in-place conversion
Date: Wed, 7 Oct 2026 08:41:42 -0500
Message-ID: <20261007134323.1606088-19-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007134323.1606088-1-michael.roth@amd.com>
References: <20261007134323.1606088-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B3:EE_|DS0PR12MB8788:EE_
X-MS-Office365-Filtering-Correlation-Id: d5a022e3-7976-4708-7237-08df24797e63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|7416014|82310400026|23010399003|376014|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5NAT8F5ezOCLWkui8HVwjecdtmFTx2WgXaLaT/nqc2xs3HywNUY7w9R/GeAD0LbXQjX4n0FDenefLAjGysSkQOhLg0O2C/j5T0ozGw7S3dxApudwH+81vgejPP8NKEpWNqS/TbVcqOaa5dmfJYEniEzSzVMByytD6j8rbc1+dHwwcl4s1rjupeW0uTf3ET+YZ/sCVRxC/DSgmMW//alWHpsDoPAUa14KS1PMNRdnejMXN9aZQmTnVKdr8PJh4em++i+M09BM6HCOtGZwc3NWwpcJpm0hXUZfyx1Y78Uta10r5fy90INFjWRvpxCby61aU1Jur6xAwqqAuTfZXR1ilqwP3A1O+O7SYr00X6ZhdkZp/UjZbI9dpLq0VdTy9mFfnkWjR/2macb/Wp0xYHmMclBrXx2YDCx3xjgG1ndj85wuxzBlcvGpoc9ZWyUBVIPD8F75ohQiShQs3U64Rlw5sPF10Y6Wn01M5CtvwCXt2wL4axFN98/iBJWe8XSwG0dIrmPnUbUjBNtIsbcv8fEN0OjVRfg0klHB6R+FN5WAyDiW7WtM0NrX7HSTJW+PGCXx2lt5MXNvIvqFzhn8S8xLaFKaVvoxX7gMmS+4xcl6BiSSLqAe8QIEKkiRqNAzbrPWNaDOXKTbo/J4rLxxCYhtuaPY+JFWKM4mjivlFL4o4PCMGIvhlUlm86zG0f94Y0zvL/iKuSEr+85BMY1maJOCpA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(7416014)(82310400026)(23010399003)(376014)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8+u/Wuzzg2JqQ2Tan070ObRT1eEnOLsOEbsn3NDXdkRerBvlbrsq8XKga4t0E8NrtIaPJO5urveMLx5TTLtO5j7ohpLrygLQmh1eIl3TgFynCeJ46qp3teydrvvGDsPMmJezM/uDSInYW6BQhDatwwT5x4cnJnVjoJN+U5UiXl23/N3kK/tagWKZW6iv67Jl1Hok6iOjy/IQfO8S5Uybv1ORenTyjjNoGyDJZd25Mp8hrRE6uSbQclgsdLm4CCsuKJvzM/WjACUdSFck2iips1rzmebAaXm5OwpG4sdP7tXr6J1Pg3MLHQHc8vmCF9X23jfT9j5eY+9Wyff7MgXlFskW0BQEKncFbamfhnn8BMggItIuETNHk+rVVaDTkUfo+6H/hgyN2eIc/kL9/oVNI2Y5BTG2V/bkMM7Y9H5810nMKp0TLdwwmkhIsYa1PZ/0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 13:47:13.8982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a022e3-7976-4708-7237-08df24797e63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF000264B3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8788
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=Michael.Roth@amd.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The sev-snp-guest object is currently used to provide confidential guest
by using guest_memfd for private GPA ranges, and for shared GPA ranges
the normal memory backend is used, i.e. "out-of-place" conversion
between shared/private.

Now that "in-place" conversion support is available in QEMU, add a
parameter to select between these 2 modes of utilizing guest_memfd (it
cannot be enabled transparently due to noticeable differences in
behavior (e.g. memory usage accounting and lack of hugetlb support for
shared GPA ranges) that userspace needs to be aware of when selecting
the mode).

Note that the actual capability checks for in-place conversion support
in the host kernel will happen later in kvm_arch_init().

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 qapi/qom.json     |  8 +++++++-
 target/i386/sev.c | 17 +++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 49f222796a..84166c2457 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1099,6 +1099,11 @@
 # @tsc-frequency: set secure TSC frequency.  Only valid if Secure TSC
 #     is enabled (default: zero) (since 11.1)
 #
+# @convert-in-place: If true, the same physical pages are reused
+#     when memory is converted between shared and private states.
+#     If false (default), separate allocations are used depending
+#     on whether the page is private or shared.  (since 11.2)
+#
 # Since: 9.1
 ##
 { 'struct': 'SevSnpGuestProperties',
@@ -1112,7 +1117,8 @@
             '*host-data': 'str',
             '*vcek-disabled': 'bool',
             '*secure-tsc': 'bool',
-            '*tsc-frequency': 'uint32' } }
+            '*tsc-frequency': 'uint32',
+            '*convert-in-place': 'bool'} }
 
 ##
 # @TdxGuestProperties:
diff --git a/target/i386/sev.c b/target/i386/sev.c
index e15e23c78d..e77ca12fc7 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -3270,6 +3270,20 @@ sev_snp_guest_set_tsc_frequency(Object *obj, Visitor *v, const char *name,
     SEV_SNP_GUEST(obj)->tsc_khz = value / 1000;
 }
 
+static bool
+sev_snp_guest_get_convert_in_place(Object *obj, Error **errp)
+{
+    return CONFIDENTIAL_GUEST_SUPPORT(obj)->convert_in_place;
+}
+
+static void
+sev_snp_guest_set_convert_in_place(Object *obj, bool value, Error **errp)
+{
+    ConfidentialGuestSupport *cgs = CONFIDENTIAL_GUEST_SUPPORT(obj);
+
+    cgs->convert_in_place = value;
+}
+
 static void
 sev_snp_guest_class_init(ObjectClass *oc, const void *data)
 {
@@ -3311,6 +3325,9 @@ sev_snp_guest_class_init(ObjectClass *oc, const void *data)
     object_class_property_add(oc, "tsc-frequency", "uint32",
                               sev_snp_guest_get_tsc_frequency,
                               sev_snp_guest_set_tsc_frequency, NULL, NULL);
+    object_class_property_add_bool(oc, "convert-in-place",
+                                   sev_snp_guest_get_convert_in_place,
+                                   sev_snp_guest_set_convert_in_place);
 }
 
 static void
-- 
2.43.0


