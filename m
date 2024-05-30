Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B358C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 11:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCdmF-0005u6-UL; Thu, 30 May 2024 07:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sCdmE-0005tS-8k
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:16:58 -0400
Received: from mail-co1nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2416::601]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sCdmB-0001Qi-5B
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:16:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnI3RY/7vkROxHND0obO27yBl58Tj4AcEB07H++B+X+oNS0LQaNiqvh4/pUGjcb+PYi0aia5CY32/NJMzuHPTccNJAhEJyYxr4in2iNV4MxSznaXJMrlv0EW5klhDiiUlDxHqkPSTVrGq7PL4DW0q4rqbjYEcAwWJtVYPvpuu1QGPM4VkcXRma7xMUYa6gCdn6ZDhRL9BdF5iH58Ps+IBgW5YBL1T6WW74QM8PdcTuAj4lW/yhoDZ0EGtaS8TWpLRvD1QvEHodgQ3cZQgFRQVZsU/KUXznxU9/5jipUv+AAy3do5p5XA9l7DhSerQOrODAPMVkfpWr4TeiIAPd3oCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJ6SNAB/eiJuKzZ1KSTGlcuvPgGATe/M/aAx9u1UViQ=;
 b=lVyQT7mI87DvLfKVMJjv8fZt6HDyUnIdZSqfa+kXgN3FipUVsT9VkuvtIZmPrdUukUNC3h3p/qEJpBw90D8+p128L8fcPd/f8hD0R+2LtdLP0cw1WgpBZDxXZbfXqLH48b23iprT5DbRb0dvvTLbXvOa1TvbyIdDNXuknIY8HwmDNMu4bonQJaSYIUAD4MzM0NHh4b1IGsBvwTIviAjCHXoM3ByrWWLsoX9sLOvArOuafwBWWnt+/29ZFV2ETJVn0NIRDmYgLD/U5OXFKNDcbvkdDDUpuvML6fDr7HCdkHFq2cuL0TBtZJSne7AbhSu324J5TFtjP1BbkzoL6AmkAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJ6SNAB/eiJuKzZ1KSTGlcuvPgGATe/M/aAx9u1UViQ=;
 b=dg8k5c5pjkLNZNI+lts3UtPRZpjAKhfMHBWorRuBsMC/+xy/BG72SxRIV83ohPufMlkR1Ou0d0M42Sc2HMppXEMwovcWfNDLvbCVXlO101sUMGxDjgZikwIbDSelZ3lApj6ZycrMLZIre35m0ZSdexNwSQqkNdrlenIu6h0K4YI=
Received: from BN1PR14CA0026.namprd14.prod.outlook.com (2603:10b6:408:e3::31)
 by IA1PR12MB7493.namprd12.prod.outlook.com (2603:10b6:208:41b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 11:16:51 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:e3:cafe::d2) by BN1PR14CA0026.outlook.office365.com
 (2603:10b6:408:e3::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.18 via Frontend
 Transport; Thu, 30 May 2024 11:16:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 11:16:51 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 May
 2024 06:16:51 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 May
 2024 06:16:50 -0500
Received: from pankaj-M75q.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 30 May 2024 06:16:50 -0500
From: Pankaj Gupta <pankaj.gupta@amd.com>
To: <qemu-devel@nongnu.org>
CC: <brijesh.singh@amd.com>, <dovmurik@linux.ibm.com>, <armbru@redhat.com>,
 <michael.roth@amd.com>, <xiaoyao.li@intel.com>, <pbonzini@redhat.com>,
 <thomas.lendacky@amd.com>, <isaku.yamahata@intel.com>, <berrange@redhat.com>, 
 <kvm@vger.kernel.org>, <anisinha@redhat.com>, <pankaj.gupta@amd.com>
Subject: [PATCH v4 10/31] i386/sev: Add snp_kvm_init() override for SNP class
Date: Thu, 30 May 2024 06:16:22 -0500
Message-ID: <20240530111643.1091816-11-pankaj.gupta@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240530111643.1091816-1-pankaj.gupta@amd.com>
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|IA1PR12MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: 426e4472-446d-49aa-5223-08dc809a0148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|82310400017|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zRvVRdKhKf7Lsvk7azx2AfQ9B8veGJnjLQLesAViWCtxZ/V+1NtQ8sb1jc1M?=
 =?us-ascii?Q?lsZ01gNtpjq8SEHRLhcnYMzzEEsE6lNNXAguSoqXKMMOuu6r2dMF6x04RYVG?=
 =?us-ascii?Q?4GvepaxiE2kizKaNljUijv4aMO0tGdjfA+5wZzqsn2Hy5gvl8/ZDMGJo0NuT?=
 =?us-ascii?Q?GLQsdrk+Hvj3PUbXsKfOXz3OaiaXHaTsGReVg9A3OtOBsCKdynY9O/YWTRpw?=
 =?us-ascii?Q?2sc1kiZwF9ZZjYNKvNt+0vtgOBcamuK3RMyQcFu1MbHAn5DPCebZWO6JcsWL?=
 =?us-ascii?Q?zt2pvSqrimSZEUIwrgJA1wOc5A+PQJcONk8Ab6UbyYH1gKwPDg79F3/sjGVE?=
 =?us-ascii?Q?yrSlE/OlAtYzrQKM89t6H8mIqFakMFSIPZMH/kEzXz4Vp2dydy2QLynhBTXp?=
 =?us-ascii?Q?Jbzm7l3L615FdWjcJ9Oq44Z4jYB8EhZeBZemLPI0OwawoT0LZmmMsr0w+Sik?=
 =?us-ascii?Q?6Kk8GTWyzwcidOgmFu2ZNdi8duls0eN97jGHW1zVs/xojiCqF8yFD5C8Ssk5?=
 =?us-ascii?Q?Bsh4UwZKxSzh+Riph0vCGXpV+EzJkmrswDQ/iphFsMxo2k7TxVWT1ZTfkPmL?=
 =?us-ascii?Q?NE0kHAUca8h93bZU5GOh9CEsxC0BJKWR3iZiRPIvEiTIwe4XtEDJ8ufmfgnz?=
 =?us-ascii?Q?7BeTRd6Xw1ld3kjjkWJoukohXp0epUAS2K5Imq70XW6tXpFxrWzQn6x7/19+?=
 =?us-ascii?Q?Yr3qbu4VcYjBC8WQdrvZMBFkq9E47qYNRkPzCVkKzf//AlAkbk6+1XwjxwFZ?=
 =?us-ascii?Q?uk8j3sdyo3dcrAEIYFqBNb18LuiETLulvIYeHP2OkfWENiRHSpJHrBQemS5I?=
 =?us-ascii?Q?cXawYqC4CHhxJ4O2NolmCcjKQy3wPa14ZwfYJSJjVjI7U9tVe6QZ5Lnfabxg?=
 =?us-ascii?Q?07/rCftkdeTgSAk54Q52VZpgUPJrheaa5HPajxARa8MGa7HWaVRLhjLk4OqT?=
 =?us-ascii?Q?ggpejHQ5OMstdD2v3TkBhyk/h68hUK6pa52BEN3Xr8Bw57LMX2b3TAmznYHf?=
 =?us-ascii?Q?RcEubc3sQgOD+sYGQlD07cBDpZOfu2T212vXq6NG6PWCBRcbgSsWWQfaU6oT?=
 =?us-ascii?Q?x1wBhmFiqZTxEDFqC7pOhX1pnm8jZyuT7u0W5PIagkO6+YAjLHbw7KJJ9xGb?=
 =?us-ascii?Q?PLiotWMP9GW6Z9+uhIyIw7fBfGFfGU1mJymhCV3qZ2dD6XImd6pumiSHTo6b?=
 =?us-ascii?Q?VKh4W1QoNW52vToPrpr1v6paGko+Kj0QMqO0WEM7CfFRJn8hThS9Xr7cX0+0?=
 =?us-ascii?Q?qWVzW2OS6rq+LWoMOOZcMTY9HVpFojWz6uCrUCJZSrAMT8R7onPHxwbRsCU4?=
 =?us-ascii?Q?rVBOk4zJ7sbV88HTCxn7LmBfbapRvLujP9ZTP9EHlIrHq3RWXJ6OUp9R0b8D?=
 =?us-ascii?Q?7f8GKAwri2HbYIfYPrZPWmHOC5aP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400017)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 11:16:51.4134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 426e4472-446d-49aa-5223-08dc809a0148
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7493
Received-SPF: permerror client-ip=2a01:111:f403:2416::601;
 envelope-from=Pankaj.Gupta@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
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

SNP does not support SMM and requires guest_memfd for
private guest memory, so add SNP specific kvm_init()
functionality in snp_kvm_init() class method.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Co-developed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
---
 target/i386/sev.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 2a9a77a2d9..56c1cce8e7 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -893,12 +893,12 @@ out:
 
 static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 {
-    SevCommonState *sev_common = SEV_COMMON(cgs);
     char *devname;
     int ret, fw_error, cmd;
     uint32_t ebx;
     uint32_t host_cbitpos;
     struct sev_user_data_status status = {};
+    SevCommonState *sev_common = SEV_COMMON(cgs);
     SevCommonStateClass *klass = SEV_COMMON_GET_CLASS(cgs);
 
     sev_common->state = SEV_STATE_UNINIT;
@@ -1038,6 +1038,23 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     return 0;
 }
 
+static int sev_snp_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    X86MachineState *x86ms = X86_MACHINE(ms);
+
+    if (x86ms->smm == ON_OFF_AUTO_AUTO) {
+        x86ms->smm = ON_OFF_AUTO_OFF;
+    } else if (x86ms->smm == ON_OFF_AUTO_ON) {
+        error_setg(errp, "SEV-SNP does not support SMM.");
+        ram_block_discard_disable(false);
+        return -1;
+    }
+    ms->require_guest_memfd = true;
+
+    return 0;
+}
+
 int
 sev_encrypt_flash(uint8_t *ptr, uint64_t len, Error **errp)
 {
@@ -1761,6 +1778,10 @@ sev_snp_guest_set_host_data(Object *obj, const char *value, Error **errp)
 static void
 sev_snp_guest_class_init(ObjectClass *oc, void *data)
 {
+    SevCommonStateClass *klass = SEV_COMMON_CLASS(oc);
+
+    klass->kvm_init = sev_snp_kvm_init;
+
     object_class_property_add(oc, "policy", "uint64",
                               sev_snp_guest_get_policy,
                               sev_snp_guest_set_policy, NULL, NULL);
-- 
2.34.1


