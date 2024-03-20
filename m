Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7986DC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmrgm-00009M-CE; Wed, 20 Mar 2024 04:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrgk-00008b-EV
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:52:46 -0400
Received: from mail-co1nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2416::601]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrgi-0001RY-U1
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:52:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+fjLeXVVV8jEnz+Y1Q/OMNNzffmtQTRk6G6BJbO8zU3T+gvQAilqRtxJN845MfWqZt+k7al/NA6/u+qUy6ovupzN034AEKaTMTeaA0X3yPRg05eSVbGrRSB7Qoq3sp9iTUpQpSZW9QGJpdJ4Lf4T6F3cL/3NIT6s8bHvWlVHLtYGUnDgG+okTjwf9T0HHqi/tdvMoqmKNk9lK6o2esHD15RRWuHEHJxe0y7mxP5ctJMZ++Iy+FKLj0ksMeKHOGE0tQ6i7KfcmXJstfaHgMRkuizGXLaD1JRYtV2WhYKi7JMve6uW7/0Ce48Exa7YS06Vlj7fW1yzbY2ZL/f+2uQEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5sFgg2keTwg82pvAJk1aZ1yzKgIfDd8vGO2ZlrZ5EU=;
 b=dzO8PA1snGXuFWpELC1fAf8MRijgetrI4bMLQhg4khfuun18GduLHl8cCHA4w7dUe+APt9H8hl7OUPi1uOwgiHfZZterrdQrXJfUlKSaCAExrDB1F4ev0gBghyuIWoFcVVcMYQtnv++EgeERLY320YsW93denpvqFu+HU18AnVOpr+nRizSXO1IdcJgzYbXZ6RE0X+00klI2PY2h6n/2djc4zZUbntKmGk4jih+snvoQmBOD2566iw9eiDGkXmLu1q9szWMQSFS/uJGZ3Rsmeeq2lSZyQ2SJvhDo5syCA19AduZFkwdta5nnoAeHBP3ypfYIGGYacqTvzNaci9+sbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5sFgg2keTwg82pvAJk1aZ1yzKgIfDd8vGO2ZlrZ5EU=;
 b=i5IbIviPMDfNN2PcWndpn4u/NIt0aOBBQZcWykKjIC+Imd9bq0zEwLZp5myqFgPtt7hsTjM8ZlDzmeZhSEIhAzJochJ19DupvMOpJ4t6gBALGRQ64ktIu+mV22amMFqoru0T2U4CD4atqXW9AXv4RYD02TTbdbf2egD+abjsk98=
Received: from BN8PR12CA0028.namprd12.prod.outlook.com (2603:10b6:408:60::41)
 by MN0PR12MB5858.namprd12.prod.outlook.com (2603:10b6:208:379::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Wed, 20 Mar
 2024 08:52:41 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:60:cafe::40) by BN8PR12CA0028.outlook.office365.com
 (2603:10b6:408:60::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Wed, 20 Mar 2024 08:52:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 08:52:41 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 03:52:40 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta
 <pankaj.gupta@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Isaku Yamahata
 <isaku.yamahata@linux.intel.com>
Subject: [PATCH v3 39/49] i386/sev: Set CPU state to protected once SNP guest
 payload is finalized
Date: Wed, 20 Mar 2024 03:39:35 -0500
Message-ID: <20240320083945.991426-40-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|MN0PR12MB5858:EE_
X-MS-Office365-Filtering-Correlation-Id: 667dd3d2-0b93-4e37-f67f-08dc48bb1a02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n4Wuq03sN4zKfmofXU9eEMpqz1oPHQYXDBc/ZWe2+LyruV6YEWaxHi3o/L/Wj1DrRNPJGTOWDLpXi1WRvBRlKKTG0nvZHBtGBe/RD2el7Jro3sfM65B+EiNR5kfCrffbfYUcngAI67qYyAMaUUPCjwPyzDhkhftt+MLPA/UuMpRXJ5rqFH1IqMunpjp53B2tmVQhe6Z0mtQuR4AwHAhWrhS7WCQHD/OPiTj7TzvcQqHQmCE45BLDyWHq3WXU9/m0WXW/QHGYgINVDO8evKN18P51hx5PGtLIk5U1ML7fm4zR+Z8tYRlyQimb3U8/L7hj8DgfK4qLtw9rY5bAJkuv8mzApII7nNVkX3PtarYj+BeUDHJaGYRetMl8BpwvAcInlhQZM9ugBKa0qMMZcnvFIFdRxFkKE3n18wmBw8FKA8YLZjC9eYOORJ4fpjZbugwtzDrewoqXmKkBUnaCgxrou+M7clQxVEYroYtlSEzeHH26AeijrJmM6/HD0fdr+C0Njme3EUH0meA71mPkQc2gLeOxw++R2S1iFapd0VlxIztlZgJPGypK8WNDnyxekO2lSoMXs8o+tlTbvyJOMK7OhtikaO53ghYJElsGGWi8XM1N+9d5qFlpl5Wp70aUzHMzoSd88WIzHu9ZUO1NPkKWBKn8Siy2ypgoU/LQVhZJBnbSKJj4+1wMCrw4i1tG2mPR/snmvgvhYKQoPe/LZvPZnsDGzocfbo1HuDaFCJTNovoVN8Eh8jA5x6bvsSvV+W3b
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 08:52:41.1785 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 667dd3d2-0b93-4e37-f67f-08dc48bb1a02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5858
Received-SPF: permerror client-ip=2a01:111:f403:2416::601;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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

Once KVM_SNP_LAUNCH_FINISH is called the vCPU state is copied into the
vCPU's VMSA page and measured/encrypted. Any attempt to read/write CPU
state afterward will only be acting on the initial data and so are
effectively no-ops.

Set the vCPU state to protected at this point so that QEMU don't
continue trying to re-sync vCPU data during guest runtime.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 target/i386/sev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 4155342e72..4d862eef78 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -975,6 +975,7 @@ sev_snp_launch_finish(SevSnpGuestState *sev_snp)
         exit(1);
     }
 
+    kvm_mark_guest_state_protected();
     sev_set_guest_state(SEV_COMMON(sev_snp), SEV_STATE_RUNNING);
 
     /* add migration blocker */
-- 
2.25.1


