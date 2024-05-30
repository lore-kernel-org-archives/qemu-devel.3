Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2D1C27C44
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 11:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCdmM-0005yr-02; Thu, 30 May 2024 07:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sCdmH-0005v9-Mb
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:17:01 -0400
Received: from mail-sn1nam02on2060d.outbound.protection.outlook.com
 ([2a01:111:f400:7ea9::60d]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sCdmD-0001Qv-Fg
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:17:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmOdtJt2gRyCeg2vfp4TTZB4sgev4CkAzFJx63V3IWjVvgDHRvkIdp0oNPZxPA1/eGO03w7BGKZY463V0VUvJdlCHJOnrpoi+R8jwMroyUngq7OtvOE87IQc4TFfCrK6XEnNeEZKP8Cekvo9xEkZFykXHMBlUIyt/EUwrDQilmH0gtVHhDI81T+OAuVTa5f5zT3NbbijUtg56MHOcWM5A2yviI6LV5Ml+p2VQ+9j2SnMaREvjDTyo1mR4bNgenAJZuP2Sby4hmxsEroWQEvgsFShtExtNwLwTXRJVkDVY161VtYcdFkUP3sTTduHxevhOcrA37Y5k4jxrkfA1plLzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPt2T6cryWo9KjhitSay5ciELP8aw3+zeHDLWWGJf2A=;
 b=dyxfglWpHJPzHg50hHES/aL8UdTwMW5Udcz6hlGHi/VbRVnayYn7yIrf7a0joE1TvQIcV5Pr3/y4ah6lAJaK/Y9pxyrrlYl7UVkboS+/0kTeN9qn+mR4wBBrPM19PSn/ozJ/gNRPDP3jNRtDr7zmAgoysRRoquOzECV44E94Yw85xA9AnGdjCRimh5t0Hc+J5WST07mg90joalW4AY0EG2NZmZLytgI6Pnfcumi8Qor+8NDsn7TpIbSRmb1Q1pABvoeIZsdLt09zdieOgud+ZeTEvOFdQmJWf86FIWN4bFYzpMgtPwLqEMEm2V1suQDLv0hUimwLmLxM6NK4sScNfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPt2T6cryWo9KjhitSay5ciELP8aw3+zeHDLWWGJf2A=;
 b=V/zkpIDVw0/MgSn5Z6d8H5L1J50UElIqECdrhQ6Ch5DQpJrlDBJ4FXKNRrjY4AINKu40TKwliqx+0vaUcKm2C7292laXT+SPLPjxq9FImmaIcDmkSsLhWcBC7VQypWQh1RE84I9GEpI79of1csjEpPJ7wn0SJR+BxFbkQ7jffWQ=
Received: from BL1PR13CA0112.namprd13.prod.outlook.com (2603:10b6:208:2b9::27)
 by SJ2PR12MB8009.namprd12.prod.outlook.com (2603:10b6:a03:4c7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.33; Thu, 30 May
 2024 11:16:53 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:208:2b9:cafe::ac) by BL1PR13CA0112.outlook.office365.com
 (2603:10b6:208:2b9::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.20 via Frontend
 Transport; Thu, 30 May 2024 11:16:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 11:16:53 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 May
 2024 06:16:52 -0500
Received: from pankaj-M75q.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 30 May 2024 06:16:52 -0500
From: Pankaj Gupta <pankaj.gupta@amd.com>
To: <qemu-devel@nongnu.org>
CC: <brijesh.singh@amd.com>, <dovmurik@linux.ibm.com>, <armbru@redhat.com>,
 <michael.roth@amd.com>, <xiaoyao.li@intel.com>, <pbonzini@redhat.com>,
 <thomas.lendacky@amd.com>, <isaku.yamahata@intel.com>, <berrange@redhat.com>, 
 <kvm@vger.kernel.org>, <anisinha@redhat.com>, <pankaj.gupta@amd.com>
Subject: [PATCH v4 13/31] i386/sev: Add a class method to determine KVM VM
 type for SNP guests
Date: Thu, 30 May 2024 06:16:25 -0500
Message-ID: <20240530111643.1091816-14-pankaj.gupta@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240530111643.1091816-1-pankaj.gupta@amd.com>
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: pankaj.gupta@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|SJ2PR12MB8009:EE_
X-MS-Office365-Filtering-Correlation-Id: f4bf1467-3181-4306-1595-08dc809a0240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LP/HBjsh9aYyauFMNmFy4uLVEgmc3/S/imfQxSCt7xCQ1wxBU6SRQMfOj7lc?=
 =?us-ascii?Q?isXhMMO6ppmvq6FxbYYJ5Vv+j68Xyu1npu9SrDOJPNJhDPOuHK6zd0e5GfZZ?=
 =?us-ascii?Q?pZPPcj4rp0wZ16Lb+0HKadk9ihpRTn0nWr0KNC1fGV+EuKLZ17MEJhEoWxSt?=
 =?us-ascii?Q?gqs6GPPZj/kpGDefwE4c5t+Y6RuKQpcx20zuj5HvrmUPe53emnJ2FkwMi6a0?=
 =?us-ascii?Q?7eQvNtxvNPwxtXdXNNGBRDhxR90vwezDmVTHGbhgorjVJNBYeKPV2HvXrV4U?=
 =?us-ascii?Q?TVrmmDX1w7c/cLcuip0oDzcQl5VBpbHyQgTLwpf03E9cuHgFlIm1y1Izmztc?=
 =?us-ascii?Q?utnH9hX+Y0Uf2fKm1LlVEGj/7LnPRJSOW6UdqNVNsyF3aDHqOGxdQRKGoXh7?=
 =?us-ascii?Q?KvFEB2tS74/ob6+gIP+82HTndUXARyZt7+Y0D2haNYR9CLpTS726ADoh02Qu?=
 =?us-ascii?Q?JtD1y+lQZtB8gt2aQfBcdkjBYfzMC9MCFhP7CczYvUUaTdSa4h6CZgdEAC15?=
 =?us-ascii?Q?nVHW+bndkKkkBhpySwOQXre2hMRwB9ySEWV/dQB4GDFlJNxN+A0S9bAD/NuT?=
 =?us-ascii?Q?48lM6H2mvEVRAf8BWzpoLGc9Ebuup+x37EvLF5WwhIPNCndyiq75kd57fDpI?=
 =?us-ascii?Q?6ZSbLMxIZw+AQJNR43KZPcaS5M40WvNrOoCXuQbqFOfB2ZK95ZQcfhbxbn5R?=
 =?us-ascii?Q?1aa4xDdeeR1B/WY+9gEwwfcTdIFArMxyChtqv5tTYQ9265o9rw+1wX32PO4F?=
 =?us-ascii?Q?ysNNkz0Wy7Q8oJx0WW04qeDPwciVu2Tcfp32P+f84j+OUZM19BCUrMp7eTF1?=
 =?us-ascii?Q?V4IpfoqfCyUSHq0hMYHElZyDeQc0bL4wo8d1FWTwUUsgiGjvnx/DQeV9PNT1?=
 =?us-ascii?Q?XJFZW1e7ZBOZgyiMzfodQB2T1qSoJEd/9QED9MXL0p5pn4IT8TRTSVnceHbl?=
 =?us-ascii?Q?Q5ODIxwzGlt3doQPhsAPPP63lrrwVKK7aB0rMAeT0SddiL9sLYB0zulaZuQX?=
 =?us-ascii?Q?+dBd9sgncJ+eBDaTN2oyE9M/j0NYnFRDAu9z8k+oYEdyBjzWWkuSQ0YhNxdI?=
 =?us-ascii?Q?FI2jysxtSOiZzJ3ssy/rd8TC6For/qujV9L2lKsMy5K2oAQLf2lOIULroUjE?=
 =?us-ascii?Q?XWwwSYCHNjB+sgqwwgjiItAzsGQPe9IR/HQE5es7kbauvpL3UsvFHS17KEDv?=
 =?us-ascii?Q?tmkdp0xGJ5Dd1TtwvTWLMcG9ueYXMAC4dToTqMQCap2jwTIjTpFWnV5tNqfm?=
 =?us-ascii?Q?tycMJ9zGb74fZAp+QClbU39nvfBS2cbHz+8r1IcekhwyKYfP8j49MnM0M1+f?=
 =?us-ascii?Q?L81dyfSYOWTjTiUxjU3M8ynPNv8yVhYY4WTwf1SsHTD13Mii0sZTpHR8AVEH?=
 =?us-ascii?Q?ui5CPno=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 11:16:53.0372 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4bf1467-3181-4306-1595-08dc809a0240
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8009
Received-SPF: permerror client-ip=2a01:111:f400:7ea9::60d;
 envelope-from=Pankaj.Gupta@amd.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
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

SEV guests can use either KVM_X86_DEFAULT_VM, KVM_X86_SEV_VM,
or KVM_X86_SEV_ES_VM depending on the configuration and what
the host kernel supports. SNP guests on the other hand can only
ever use KVM_X86_SNP_VM, so split determination of VM type out
into a separate class method that can be set accordingly for
sev-guest vs. sev-snp-guest objects and add handling for SNP.

Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
---
 target/i386/sev.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 458ff5040d..8ca486f5d2 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -100,6 +100,9 @@ struct SevGuestState {
 
 struct SevGuestStateClass {
     SevCommonStateClass parent_class;
+
+    /* public */
+    int (*kvm_type)(X86ConfidentialGuest *cg);
 };
 
 struct SevSnpGuestState {
@@ -117,6 +120,9 @@ struct SevSnpGuestState {
 
 struct SevSnpGuestStateClass {
     SevCommonStateClass parent_class;
+
+    /* public */
+    int (*kvm_type)(X86ConfidentialGuest *cg);
 };
 
 #define DEFAULT_GUEST_POLICY    0x1 /* disable debug */
@@ -893,6 +899,11 @@ out:
     return sev_common->kvm_type;
 }
 
+static int sev_snp_kvm_type(X86ConfidentialGuest *cg)
+{
+    return KVM_X86_SNP_VM;
+}
+
 static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 {
     char *devname;
@@ -902,6 +913,8 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     struct sev_user_data_status status = {};
     SevCommonState *sev_common = SEV_COMMON(cgs);
     SevCommonStateClass *klass = SEV_COMMON_GET_CLASS(cgs);
+    X86ConfidentialGuestClass *x86_klass =
+                               X86_CONFIDENTIAL_GUEST_GET_CLASS(cgs);
 
     sev_common->state = SEV_STATE_UNINIT;
 
@@ -972,7 +985,7 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     }
 
     trace_kvm_sev_init();
-    if (sev_kvm_type(X86_CONFIDENTIAL_GUEST(sev_common)) == KVM_X86_DEFAULT_VM) {
+    if (x86_klass->kvm_type(X86_CONFIDENTIAL_GUEST(sev_common)) == KVM_X86_DEFAULT_VM) {
         cmd = sev_es_enabled() ? KVM_SEV_ES_INIT : KVM_SEV_INIT;
 
         ret = sev_ioctl(sev_common->sev_fd, cmd, NULL, &fw_error);
@@ -1451,10 +1464,8 @@ static void
 sev_common_class_init(ObjectClass *oc, void *data)
 {
     ConfidentialGuestSupportClass *klass = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
-    X86ConfidentialGuestClass *x86_klass = X86_CONFIDENTIAL_GUEST_CLASS(oc);
 
     klass->kvm_init = sev_common_kvm_init;
-    x86_klass->kvm_type = sev_kvm_type;
 
     object_class_property_add_str(oc, "sev-device",
                                   sev_common_get_sev_device,
@@ -1539,10 +1550,12 @@ static void
 sev_guest_class_init(ObjectClass *oc, void *data)
 {
     SevCommonStateClass *klass = SEV_COMMON_CLASS(oc);
+    X86ConfidentialGuestClass *x86_klass = X86_CONFIDENTIAL_GUEST_CLASS(oc);
 
     klass->launch_start = sev_launch_start;
     klass->launch_finish = sev_launch_finish;
     klass->kvm_init = sev_kvm_init;
+    x86_klass->kvm_type = sev_kvm_type;
 
     object_class_property_add_str(oc, "dh-cert-file",
                                   sev_guest_get_dh_cert_file,
@@ -1781,8 +1794,10 @@ static void
 sev_snp_guest_class_init(ObjectClass *oc, void *data)
 {
     SevCommonStateClass *klass = SEV_COMMON_CLASS(oc);
+    X86ConfidentialGuestClass *x86_klass = X86_CONFIDENTIAL_GUEST_CLASS(oc);
 
     klass->kvm_init = sev_snp_kvm_init;
+    x86_klass->kvm_type = sev_snp_kvm_type;
 
     object_class_property_add(oc, "policy", "uint64",
                               sev_snp_guest_get_policy,
-- 
2.34.1


