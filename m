Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DE4E9A04A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 13:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt4VM-0007Qe-K1; Thu, 19 Feb 2026 08:55:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Manali.Shukla@amd.com>)
 id 1vswp7-0006LV-Mv
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:43:38 -0500
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Manali.Shukla@amd.com>)
 id 1vswp5-0007hy-Qf
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:43:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOXiLBDxKeGKkluSoaKyjCOOtBoxEu2JarRCqQ3fqHYbQyFXm6kUsiTCx9JiIWedob2zxVc6oobmNOlzloWKy50RVsu+EHCC9jzzC9QD8+S/qdbovfff7SS+F0FjbM4lAJb0lWii3v0otR9Gkvwu7yCMIXghEhKYN3K6E6z7qF0FzeIIZQ6zjRwQVsCu9K0MO5685ZaN9FRY5sjg5TTpOzO9YErJixi09jLv8EfqwGq8OhrLhI3664U1ChwiIhOba36aeRtrzTbk1i9pGKcdcxvRuEX76XG5lYzo4QmD6fq/UdOeUB7kOfg4N4DyxAtfdA5ThXzRBy9K3KHsYLTOwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vvAlf8lDT64NokkIQI2gd6YP9174YisyjyktyfOdMM=;
 b=ERctthKmbnwuZwbtSaDz1uxUJR15HuvS3296poP9Ht6iL2Ohr+iYwdANFIZwsPQoUSxpJ+liQvrKB1OHz3TAfIKfGJJGOsqCm+NZAcHUM++TjATYupP4GwdJH1jhc6E5PmK5HcX1VXrr6j592MLyiWGaSl4ftbxbPlyhWxgcDZl3DBL8hdKqBBRgopvKuAQyxwp0opZUc/+fYWSxRtL2of0CHhJVLdOzq3Vo6gIsUT0FzHBNxatpiC1fgq1fznt8s8XukcXVn4dX3fj1vSYsILrfXP6hzERgW4oiF9BfjWKpnzLqH2mGYbz0kkdyGbMQKHt3dVzjT2hJkaQW0RqwAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vvAlf8lDT64NokkIQI2gd6YP9174YisyjyktyfOdMM=;
 b=CUTvPnmgHBjZPYwDpWMXpMM4IrzC/5a0CDMBzldGmtMp+UwrfmCNOKP1TewNHms+QiGiGjHaiB04XFKYul8oUx35h0xRIUssKFHr81r/g7dapcP/sn2mefTTKyc/W++loYcURQ3XPXxj7kR1ICeLCyS7vyicBz4YVfkmUr8mjpE=
Received: from SJ0PR13CA0002.namprd13.prod.outlook.com (2603:10b6:a03:2c0::7)
 by LV5PR12MB9777.namprd12.prod.outlook.com (2603:10b6:408:2b7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 05:43:31 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::42) by SJ0PR13CA0002.outlook.office365.com
 (2603:10b6:a03:2c0::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Thu,
 19 Feb 2026 05:43:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 05:43:30 +0000
Received: from brahmaputra.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Feb
 2026 23:43:25 -0600
From: Manali Shukla <manali.shukla@amd.com>
To: <qemu-devel@nongnu.org>
CC: Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 <kvm@vger.kernel.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Marcelo Tosatti" <mtosatti@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, "Paolo Bonzini" <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Richard Henderson <richard.henderson@linaro.org>, Naveen
 N Rao <naveen@kernel.org>, Nikunj Dadhaniya <nikunj@amd.com>,
 <manali.shukla@amd.com>
Subject: [PATCH v1 3/8] i386/apic: Add extended APIC helper functions
Date: Thu, 19 Feb 2026 05:42:02 +0000
Message-ID: <20260219054207.471303-4-manali.shukla@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219054207.471303-1-manali.shukla@amd.com>
References: <20260219054207.471303-1-manali.shukla@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|LV5PR12MB9777:EE_
X-MS-Office365-Filtering-Correlation-Id: abef04d8-e07b-4a4d-14a1-08de6f79cfcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|7416014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/rOfIq6ds6cfoNfy9M4KgUw8qKpVO9y3TFRjF8iWxzZETuI03e2tMqj/LAJg?=
 =?us-ascii?Q?ZtD1vzhXtrImNR3Cg0Ro7CQXxnIMPiYK4rZYpDwVPBL/+D+qKUMM/0w6ipZ6?=
 =?us-ascii?Q?r+by4UdcAGIcu+NUk3/nWajtH6XEcYMpJldtHciXV1LJfpqe2TujcZ0rrQ2B?=
 =?us-ascii?Q?4VO9Iei05xDR6s+cvnqx7T9cpQe1bkGqBrQeRDidHCIeqjuWDxkL5r4V5/Pj?=
 =?us-ascii?Q?AFwIRwqplmMM1WZcU9pCfbE8R7VePVpX3dd+UIeZBBrSlRBSojhiUoLisBnD?=
 =?us-ascii?Q?UUlT8smmNhH4+/26MnvqoO2sVPtXFojP8yjRgF19eWNGpifgSS0+OkPpkeJt?=
 =?us-ascii?Q?JJ6ECNL5Xhb9JsySoEVFWv/JrA1rHpGuaVHmq76NZjebnT7voNNp0RBTzBd7?=
 =?us-ascii?Q?BBrnmyZ1pBxxC2jYsMbJjiZHuTKx7T1wFXwh0/9Yil7YZudOcgjudPnAMJj9?=
 =?us-ascii?Q?U9Dh0zF/nYaLzltf+M59XimQv3vRbJFkY+M32gWU45YP0irU05xp6R2FYcgS?=
 =?us-ascii?Q?H9xXAKsAI9hk+KmHusQrjMU3Cy0m6jMQ6jv7pc3IEf3kFAHJD3GVr0cyZNRk?=
 =?us-ascii?Q?XoK1B+TlaKVuS8taTPqxfwtandpBDrfclv+bIGz5r6/+bmEw4Z/DrevGdHnb?=
 =?us-ascii?Q?BPiJqhtthGPk/oZWybCS7iqGXSjpzcxM5HR2U8yTUeqpg8g2svfxCuedqFoy?=
 =?us-ascii?Q?esTE75p1iKx19d3KzPjKgyKYLszeJ8eyAzrtySHGzJphZSFeS+Nzyq6hYCpm?=
 =?us-ascii?Q?obwm5XeEXVP9FVgDTIoETGMFMfrWr3SGhdbiZu4n+Po3Ljf0I7xGknYftpDG?=
 =?us-ascii?Q?bT3BjzP6+QL1Xeja2UXjcjQlMyshWfuhgbgRwvOiaj9O/uxhtNTd1DKsrHhW?=
 =?us-ascii?Q?Cthghe2dK87nAa9WhQGc+TeEGbv4w3xyUfduN6Y1YTKPEiJK/ye85cy554P4?=
 =?us-ascii?Q?CQ1In2hHRqqlne5w/yMTRgyS2ZcrnMaDQxZS9eKUPJA1s4VQhRRKx0bwWbH1?=
 =?us-ascii?Q?zMeOwjG3jiEnEBntu7m5AtIrtAsHHcMdDvGCfxyf/qPmvdBLLfSyCZSgjbts?=
 =?us-ascii?Q?0wdn9TxXIg7iId7UyMFIChf6P5Hv1MJkIlFRl53pHMeW1GIQ7V0LbLBVnhUs?=
 =?us-ascii?Q?exdi+qeU7TybZKuTfa2tJ/tmM3YT2kcr4H+70ZvcJttjzZe8Y3k8i7qP1NWG?=
 =?us-ascii?Q?/FmEJVNFRL+uHTHJSUln2x6NypXPfmGrd2MblATRiOfoD/644U7IVyj1824p?=
 =?us-ascii?Q?Ck1cvp762HG66qY1QPnt7+kQr2YE8cQQN5ALCBqCGBTcFhDJJB+JWtspGfKA?=
 =?us-ascii?Q?x3m0381nSDhBhl+QB2O2jiMgAhTSm2h318jxtcu4JunCugV+Xg47pBqldb8W?=
 =?us-ascii?Q?BvaAxxX0po1I92LlzLHJm1k95G9qZpJDP7UrUmZ6s4eUrRPG9uY8qqEQz0v0?=
 =?us-ascii?Q?zn0hX/39bB66jDPOc2Un7A/IImjUmuPckGaLnDzlFYpqyDtdXnoQi1yYvlWf?=
 =?us-ascii?Q?5YQJlcd9zjlBm8cISXEVGFcqOyv5pjXfmtul+6+m74O/AlkDNZCZP894eWZP?=
 =?us-ascii?Q?R+OY8lfapaO0fP4TeVEcDbDxD+yrYx9xG24mwFRKRJZulkS79r64s/CF8CBb?=
 =?us-ascii?Q?1FXWK4gb0HtccTi2pdQH/vYdGlvbiBxM+4WTv54dYAUp7qafa1vDTmnfyI33?=
 =?us-ascii?Q?tOCNgg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YNA+ABwMc43WrE05r0DFmbW1lxyyj7E4JLUDjFaB1iJ2e0i5fgAuW9Oo0nApJCZOytjMKW/1GvAO0M+kSf6bLwqK0Z96rWT20Emc+MN4XAHmI5wxXatp3syuY+m1aInQWq1AgPqWU7Pj6Ql6L/ZADaGuq0VTKuVim5TtvhNF3KnlpDBza8bRoKmMwMz5d8UwACx75Hr8Mqeqhf9IF3wyxw3FkV1yq4l/W60dfKyFEiahfvUo8emvkPiMN98gQDD5mCZim9/s/0kCnGzNQwpxARXBG7/aCfPqPvJ9n9UqU7YLrjFjHfrG+KPDQZYHMcxeR4rOfLVUN5oUdDZ+dZerILyp3WdY45N/+IJ6Zxh+wM1nvQzC9j8R+YK98RsLf/aEfMpQPvU44jOZ+LaeLJx1UZ4JKJkI+6ucVkbI0KVWR94a4tdYuzMfd/HFor5hSyce
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 05:43:30.0114 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abef04d8-e07b-4a4d-14a1-08de6f79cfcf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9777
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=Manali.Shukla@amd.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 19 Feb 2026 08:55:34 -0500
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

Add arch_has_extapic() helper function to check if a CPU supports
AMD's extended APIC feature. This will be used in subsequent patches
to conditionally enable extended APIC register handling.

Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 include/hw/i386/apic_internal.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/hw/i386/apic_internal.h b/include/hw/i386/apic_internal.h
index 429278da61..865b7ed567 100644
--- a/include/hw/i386/apic_internal.h
+++ b/include/hw/i386/apic_internal.h
@@ -212,6 +212,13 @@ void vapic_report_tpr_access(DeviceState *dev, CPUState *cpu, target_ulong ip,
 int apic_get_ppr(APICCommonState *s);
 uint32_t apic_get_current_count(APICCommonState *s);
 
+static inline bool arch_has_extapic(X86CPU *cpu)
+{
+    CPUX86State *env = &cpu->env;
+
+    return !!(env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_EXTAPIC);
+}
+
 static inline void apic_set_bit(uint32_t *tab, int index)
 {
     int i, mask;
-- 
2.43.0


