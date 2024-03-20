Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E2E4CD11DB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:46:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmraQ-0002P1-Lm; Wed, 20 Mar 2024 04:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmra1-0002ES-Lo
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:45:53 -0400
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2414::600]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrZz-00005g-Br
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:45:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OyqcTASDmTOY4hkTbHNP1NbfV4Zv6g1Dei62zVAaXOf/6AfAId5iY1OR+u7txAzzHZ6Yvu7r48420DyVE730eOMNRrAzE2fLuU1RsU2idCd167cCupoOkjKBa2YqZP8NjLtSNj362X1tR36ovzDO9pGpoQGhoUY5nWj34IZXTGHaNcR9o5v8u7NwYtCGpUbg4F1Z/glj8LngW3cHzAp4H7x0SQ2Y5xi23yv+uXV5mkNHt6u/iv9HklGOyZqHkQ6HjeP+DEBv56asPKqrtWRmew/IOwXKB6a7WBINpL7+U7t4yQi+e+Omx0LhdDrB6zBinIM7/fjhBM3oF8wdzZZDBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgqQeEk4/yxOnObN4oS7g1WBS8gHjZbQRquku8TOVwE=;
 b=nFlLxVJj4lAl3qXIHkMluT3h+2T2d7nJGjaNEGENY6SJY1QE7owhhh4aPxS7HSeD+NSCR7sGP1ELoPhv03f1syBRgs11r6Z6vpXygEG3mJ+4J1p43tUm3UqkAcv/PTWVXo6GM8RIIc4wz5CkBDQfq1+2Bej6hUWsFL5IH11QkFJ23yH3UE1EYD9XcTfRH7yD4LfsBF+g2VxMSG5gSMKPf4FhXWwtvOq2FGwE9xD7UyUVlUzw6R2tk8z2xV2L/Dpb09I8E2vvoOUyT/p35O45onfp6OsKQEQqM8WapVVnbUNfW6c/23L2ZEKdRxyaiixAU+wwmrzVpKiB/lA1LwueTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgqQeEk4/yxOnObN4oS7g1WBS8gHjZbQRquku8TOVwE=;
 b=FdoiOHtQpVhZ+3rv2dyhfoPPS8w3aUXBqKcx8oRhGo2cIL9PChQKW6im75qODpJLm6uLoDfT+qtaUA1sFfyoiJk6WxHmNW9wfm8bSNh4R4c5Tdwq/eJccgj1AZUboKFHT0ol939exUx7G5+uBWK8lFkyWAgqddluQ7AVS2YLVuw=
Received: from MW4PR03CA0289.namprd03.prod.outlook.com (2603:10b6:303:b5::24)
 by SJ2PR12MB8737.namprd12.prod.outlook.com (2603:10b6:a03:545::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Wed, 20 Mar
 2024 08:45:42 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:303:b5:cafe::57) by MW4PR03CA0289.outlook.office365.com
 (2603:10b6:303:b5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26 via Frontend
 Transport; Wed, 20 Mar 2024 08:45:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 08:45:41 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 03:45:40 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta
 <pankaj.gupta@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Isaku Yamahata
 <isaku.yamahata@linux.intel.com>
Subject: [PATCH v3 01/49] Revert "linux-headers hack" from sevinit2 base tree
Date: Wed, 20 Mar 2024 03:38:57 -0500
Message-ID: <20240320083945.991426-2-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|SJ2PR12MB8737:EE_
X-MS-Office365-Filtering-Correlation-Id: 34965a5c-78c1-4656-a00d-08dc48ba2009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nljCWTAUP942QdTqIU7DPmGgTGf0yTFFURTiG1bfK2oVFoc2Bls0+UC19aVQUjeL8eB02KHLIkV8leBqTJJ4e026IM9LZO5SHaqTxjTF7mw0U0ZvNARuUlp7aDGOSnyFhwcqHNB3XFrs3gFQC65QYx2zQvoN6G93Mgz3WRHfkkSi2snZ1/Mv0ZExG31lV2YvdtrfkZzuoXYUuZvzPjFSskH1zuQzi9N6xZAZqbXdOweAgKM28f6CGSbGoaoO6UGNPCFllAkBpt4LzIXfLIzKnLsFU+HlPe+0/1HnM69c4miy2jX/HC63wRiYx3XUVakeYn5mlQhj//Kd/PwBDOiCK/3uS6lko6wNwZMXfX17jqNtX2/AP38nWY32mQvDZAK5MWqfd5XOQvGAukeQofNPDVfA/lWM3TCIecONFyKGlf4Ja7IjMMuSl514Eqy14uKgYSrheDneRVpxuNxTTZ0hHIXZHJ/fSm+ax3V0wm4dBVSgaUKlIuAO6VnF/QGepfcKWcb3Ps52Y1Aao+qz26PM5sz9pqDkI86EM1gSwjos2JX0/BtceNN7OzguLNd0xZWZfyKDpFeKJ+TF46XUfhZ+zwQu0dyAo+ixVMso8kmZaTu8fHoDrZ8F00/gtwwIil7XVS4TSxEwIwWCMrE5mroFZ39pzaQle2kaUn0sGXoqtpYksNUxChSx0VJwTXMrmnGimpiOnp/kSTScRqPEuftsb1aSSPAL1ywHNgpsYkCJIPlVshWtArPOawAajCG8JsxD
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 08:45:41.6823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34965a5c-78c1-4656-a00d-08dc48ba2009
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8737
Received-SPF: permerror client-ip=2a01:111:f403:2414::600;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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

TODO: Either apply this in advance of sevinit2 patches, or drop this in
favor of a separate preceeding sync of 6.8 kvm-next.

A separate standalone linux-headers sync will be used instead.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 linux-headers/asm-x86/kvm.h | 8 --------
 linux-headers/linux/kvm.h   | 2 --
 2 files changed, 10 deletions(-)

diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index 8f58c32d37..003fb74534 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -562,13 +562,5 @@ struct kvm_pmu_event_filter {
 
 #define KVM_X86_DEFAULT_VM	0
 #define KVM_X86_SW_PROTECTED_VM	1
-#define KVM_X86_SEV_VM          2
-#define KVM_X86_SEV_ES_VM       3
-
-struct kvm_sev_init {
-        __u64 vmsa_features;
-        __u32 flags;
-        __u32 pad[9];
-};
 
 #endif /* _ASM_X86_KVM_H */
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 5fd84fd7d0..17839229b2 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -1865,8 +1865,6 @@ enum sev_cmd_id {
 	/* Guest Migration Extension */
 	KVM_SEV_SEND_CANCEL,
 
-	KVM_SEV_INIT2,
-
 	KVM_SEV_NR_MAX,
 };
 
-- 
2.25.1


