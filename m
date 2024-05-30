Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA96C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 11:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCdmL-0005yk-Oj; Thu, 30 May 2024 07:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sCdmJ-0005wA-6e
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:17:03 -0400
Received: from mail-dm6nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2415::601]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sCdmD-0001Qw-Dt
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:17:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htMEP7GVG1NHX069QoTwyXA79Oaj64/Sjghw7buP0i5Xa7GjdX6tTcqb+y+VEmHsWXWUseEqe9YkpbDQVSV8aHpT1P5bALrPcJIM+rssRqIhqTn9xzL6jAqx8e7wAKBEtgChe0hvVV8FxZOlUC9asBOD94YVOy5kB9tSzUsL5TO5xZW48R39bQlL6yeYQ+Tb4rK2s2i4yatHOsX34mC6Bl4eT4ibQgd2veJ7hvnpkgA/zjbUtOaNfZ9zAb9qXlOYsInE3lsDE8Dh130qlUzy1i40uRxp55lgPwOPJ9UZkhEZqgwLah6WMKmzHdFlPKKIoOm15Zm8QI/iGq/WICG9EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8S2vaPBh5th5l3Et1gtUJG79iJKaMlNF4hxcHHq+8o=;
 b=ibZUFv2ibvDi9F9YtEVjN6vORbCEWlFxg9De8nq8IaV/g2OGsLXG2v5kbfy6Qcfx70KwyzwwoZIZ8ksyym1Sr6G95HPw731qrHg0lIB5ALb9bta5pPJ0xB+TFf5FSs3twjgnOlGH0L1Aw4gP3v2/7G/ECG0W37avPFXUIv+VwoUJ1+ga2VL4DCtL3tRasZuhRMiSCIzsm1DM1WTrG4ospuKD6LbH0+62oa4c+eqYnTplUZBUrDqeWYOK1/G7py9gVj0yLKNoqUkp2ak43xXwFTkBjqEO1O1XwxFKzjBGQD4JVrDyoyo8g/aYKBwPjQTIsSZXZTmexj9i+oc1wK8zDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8S2vaPBh5th5l3Et1gtUJG79iJKaMlNF4hxcHHq+8o=;
 b=LHM4H884Ryr+37Nm3yp1PEsU2dMW4RMiQzOb/2N45KEDxd3XuLm+MeyvJN2HmtRcUfUDvo3gT9P0SaV/ffiLv252fnh0N9l1Fc3iDwANwqQ5QyQ0RjgeU6sSYyMDaRwv6FF6q7U3QYcPGb2xZR/yRaR3hywgP0RMEG94bMsLhkk=
Received: from BL1PR13CA0098.namprd13.prod.outlook.com (2603:10b6:208:2b9::13)
 by DM4PR12MB7501.namprd12.prod.outlook.com (2603:10b6:8:113::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Thu, 30 May
 2024 11:16:52 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:208:2b9:cafe::58) by BL1PR13CA0098.outlook.office365.com
 (2603:10b6:208:2b9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22 via Frontend
 Transport; Thu, 30 May 2024 11:16:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 11:16:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 May
 2024 06:16:52 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 May
 2024 06:16:52 -0500
Received: from pankaj-M75q.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 30 May 2024 06:16:51 -0500
From: Pankaj Gupta <pankaj.gupta@amd.com>
To: <qemu-devel@nongnu.org>
CC: <brijesh.singh@amd.com>, <dovmurik@linux.ibm.com>, <armbru@redhat.com>,
 <michael.roth@amd.com>, <xiaoyao.li@intel.com>, <pbonzini@redhat.com>,
 <thomas.lendacky@amd.com>, <isaku.yamahata@intel.com>, <berrange@redhat.com>, 
 <kvm@vger.kernel.org>, <anisinha@redhat.com>, <pankaj.gupta@amd.com>
Subject: [PATCH v4 12/31] i386/sev: Don't return launch measurements for
 SEV-SNP guests
Date: Thu, 30 May 2024 06:16:24 -0500
Message-ID: <20240530111643.1091816-13-pankaj.gupta@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240530111643.1091816-1-pankaj.gupta@amd.com>
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|DM4PR12MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: 5047e8d4-ba08-4444-3f6b-08dc809a0209
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rFrZXlhhUFMoR9zEcfqrNzdfPw8tu34mlzWbyklJRag8PwUTS4gqViOzmzBq?=
 =?us-ascii?Q?Y1ezlSiy1TJwwVs/mAnC9F+u2Bdc+2okAjPzMaHYMNrH5rpgTJlPXHUtvIll?=
 =?us-ascii?Q?r5sJzdW29a2az1sn7Vn4GU+nkvygs+a6fFk1YQI3UPoEhalSKOrd0dw4l97P?=
 =?us-ascii?Q?feFt3VFX/VYayut6+OBHJRu3eGGagLPkD0EEicMG5G7fORWVTh2MqvsYtjcK?=
 =?us-ascii?Q?2x5SW3gDAq2ikjqI89dYMb8J66CnyHFB3OYh6cOHUf3hrdMPd/G67iXqhtOe?=
 =?us-ascii?Q?lDj8CxJGLv0InTtlhkcCYCPMo7PxGLYtLjEqs3CAqnmP18wY/Xhw8sptQwd1?=
 =?us-ascii?Q?2q6r1+md8ZFS7C3Ukuah5R9XdRGH5vOMCaMZV5ukD/jgQfxr3gm/R36djQnz?=
 =?us-ascii?Q?2QbSmdNUGqhRu+bFkvZ4rSqzCvwxCbCbuxrUBlYNokMXhKwm/hFBpi8zA4ci?=
 =?us-ascii?Q?pPvToutuHXR0K1Pp3kWanEVjJpo8zY4kfx2ckIflWmmYPhqxXv3I75g5VfBZ?=
 =?us-ascii?Q?KjWUCvt+Itke/4SROOLZqBsG7PM4NhWlubDDUdW0JcQIF4vDf0jdUZB1f0LA?=
 =?us-ascii?Q?lZ3Y9Wbjj7uYdXHhliFBApMdZ+gj207Oxw/KzhtD276ePUf3sYWGpWnov9/S?=
 =?us-ascii?Q?GcILajzaCUUb8U0Y1/GowMjIXm8pAKmtKMsFB4KMKSR1zo1LyYHJKcxUDo7Z?=
 =?us-ascii?Q?v93Aoyebz/dyanaGtEDic94xaLdB8ZCSVP8oIlwIVmPs4lu9y3P/C4zvpwQg?=
 =?us-ascii?Q?4Zljf2/8EL45MB3eWxo5YndRSMG+zTVmRIY/Oqv2HNt5YQq1BD1bPphNV/D8?=
 =?us-ascii?Q?AZ3v+NGeW3eCh5RuowVcpeIKUVZKtbR1Fkt75HK9icNJqgSFApAoV6isGmrr?=
 =?us-ascii?Q?1eBMM7J/p+3K95n5K3KYIxiMd/fvUF4gUQe0rNToiA0rg8h3BVjUXL4AhlE1?=
 =?us-ascii?Q?9fpZuQFH4XJCAupF3G/NyAxQM+8PD68MS29qwhwSiMe3XWdA+hvzQA3KXOs6?=
 =?us-ascii?Q?deg8Q71wCDOhpvw6uqlQa2UUltkVUdKNgpdtWCW94TmnChbBb2nZ+Y+1b5Am?=
 =?us-ascii?Q?Mxpqcm8I9NecEhvN7DqC6fpFka9EVmIW2dJzpvvzSZHHpcwOO6IldL3+2IBD?=
 =?us-ascii?Q?LoRCUmDfGzrkk2riI6zNMXevOlWyre7Lnhtv2D/iemAQ68Rl8gdK2LxZ+Oq0?=
 =?us-ascii?Q?2gGPVZRnTiezNS5WqooMnu/eQ4SmZUEgykJyIl+N/vtGm2Dk3+jp1ts/ZqA1?=
 =?us-ascii?Q?WuEYmwu/VtXjRnfpsoYm81JPzn0S4V2Gt2laWFHYKMoM6FdNBSWy0hef7DH/?=
 =?us-ascii?Q?97P74o4Xa0/qK0i33djAU91S36O1g6MhAX982B8hYZgT8smhOPos2iqA9t4Z?=
 =?us-ascii?Q?rNuKCcCV2bT4Jp/E95ZUbvqhzSwI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 11:16:52.6934 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5047e8d4-ba08-4444-3f6b-08dc809a0209
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7501
Received-SPF: permerror client-ip=2a01:111:f403:2415::601;
 envelope-from=Pankaj.Gupta@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Michael Roth <michael.roth@amd.com>

For SEV-SNP guests, launch measurement is queried from within the guest
during attestation, so don't attempt to return it as part of
query-sev-launch-measure.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
---
 target/i386/sev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 56c1cce8e7..458ff5040d 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -803,7 +803,9 @@ sev_launch_get_measure(Notifier *notifier, void *unused)
 
 static char *sev_get_launch_measurement(void)
 {
-    SevGuestState *sev_guest = SEV_GUEST(MACHINE(qdev_get_machine())->cgs);
+    ConfidentialGuestSupport *cgs = MACHINE(qdev_get_machine())->cgs;
+    SevGuestState *sev_guest =
+        (SevGuestState *)object_dynamic_cast(OBJECT(cgs), TYPE_SEV_GUEST);
 
     if (sev_guest &&
         SEV_COMMON(sev_guest)->state >= SEV_STATE_LAUNCH_SECRET) {
-- 
2.34.1


