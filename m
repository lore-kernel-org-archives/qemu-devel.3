Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCC2C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:45:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmrZq-0001TI-UA; Wed, 20 Mar 2024 04:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrZh-0001DM-US
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:45:29 -0400
Received: from mail-co1nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2416::601]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrZc-0008Kv-Go
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:45:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J11K8/FYWFcjaa8DWWxykkw7maywhNRDTvcIEt0TP+HWe5uaV00MZ3b3xxedYLOrtBDE+hJ8CH1+Vcuo6YIUIo64ZkGyfgG+Nw4UwZdkU2QKD+EJipg2rUhf1Q5bjKM3T6tkGXaeL4oJm3+Kog6b5jrmK2A5BUX1lHyen9JWSBAIC/n/4rlSQb3o6+Re1Pn7xpzW0pQhe9PJdNzYgReyNtuH851wtdCJ9qN1bCGXqshRAc8wX7Lp+S3DP4TEjl0xOfuurAZ/PRg3Osq1SsANyQ6VI3K7wJ2NBq1ndRBbSRHu8e2iJYqy4s1Ac4EMrL1AOBogpL0HIgZTVHNK6IbGNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxUlZfCZKFxzZ51lHY8et/IBOA6GjxRKwAqzIFVFHmw=;
 b=GFO9/cB6yKf2Tuo99Uyyfk9U0+URilzrrvf7F109grbFnfR7J7CWWgKNpvPEgTTAfh4AI3+/UtHAWO0w+geRLDI+ZiM9Nc+obr8QC9Q6ASjkEr1AbNpdeWQA8Bb330ra4JSFoW7ypiXh9PVdN7eu3pD/vVROg2l79jEH3PiIazSZJZEx9W0ZcY/wn+2lDht+d0uTHe2pSV3/nLbY8xlH5c4q7kICz4G0A/LNs0R9x3lLsNFonKsAFkpgv2XKfYtchbNaoS1RQVyzR+XCajMuwVxVf3N9zKbmAwKzby7Oe/BWRz2cUEhOUD/toaJ52H7xfbQ0OveUi+VqCVPfcuhISQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxUlZfCZKFxzZ51lHY8et/IBOA6GjxRKwAqzIFVFHmw=;
 b=xmOXEMb7HW7vdGQopYJUtVx2ojDOfHTI74spD7lLL0tPfOIfo1T4ik5fO4A7qmwv7ck9h0sz/2wvS5DhMeN5XI7e6elB6e6qoUvSJRlCuz9G+o9yY6t/VkWD6oyLR6lldnCF0cdaoTCymjEaxfr21nEVHlx+bdV1u5zP3EwaYDc=
Received: from BY3PR05CA0056.namprd05.prod.outlook.com (2603:10b6:a03:39b::31)
 by SA0PR12MB7464.namprd12.prod.outlook.com (2603:10b6:806:24b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Wed, 20 Mar
 2024 08:45:21 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:39b:cafe::a6) by BY3PR05CA0056.outlook.office365.com
 (2603:10b6:a03:39b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Wed, 20 Mar 2024 08:45:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 08:45:21 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 03:45:19 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta
 <pankaj.gupta@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Isaku Yamahata
 <isaku.yamahata@linux.intel.com>
Subject: [PATCH v3 20/49] trace/kvm: Add trace for KVM_EXIT_MEMORY_FAULT
Date: Wed, 20 Mar 2024 03:39:16 -0500
Message-ID: <20240320083945.991426-21-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|SA0PR12MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: aaab97b4-14ac-4150-5487-08dc48ba13c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r7/iU8P5DmtqFbofk+jDMUWSk7tzJOLjQsMwOOYTBxL+rNd4/hjs1QFoiQJQKLISDY+2hiB9JqTtQdy7y4aYTUR3RnaxusETrHiSd7D5oN6/xMXKWBfJ18VZKoAtsc72ki7tgr4rYHoyPaNvgr9YRZrFMSUbafFT3BCSWvqexxkf0z4ObODScs5XHm/B1038cArQh45rwA7H/22EggyTNkaG9IucjEewsfAs9DS4kbhxUemUA8jENcyM2WPCQyeiazqSEq8orBGgx4Gdv595YNvpJsv1agFz5L+ugRRv0tt8yS6zXXvaBuIirIm5281dd8VJ7SR9xXqj6Hguw1rZ3SrgZDycOAC96DiPRmubVjClBeXi43sOJmBcBl8LtoA2IPT+Q6Yq5nwKcmuHK4IBoeA3vYfnEof/KSAWh3X3t44aRdAmF8C96io9YC3RjTvZfu6SG6ZShA5fFw3U7MdaeIgq7/+h3pK+QS7eYuxc7rTyGmbcKUxsaSIjxS3n1kRFyytdlTDrZaJKeYc1wwlmZwo5oWL2WwMJbvuhVsH/h5FNswLje1ue6LnaZYB94JtJolfWI9uf+ieS6x89tf+2suSjrNhilX48RtHElMya07DaCFHQM1VdetlQX1sU281ww79I/WWZEJUkiyvQUfqvfaChtqOPBpXPZCOlsgLuVVCllNCkY06OYBhACjxC63lEkk9i/6P+rHlROADia7S/eRQ/wtCM1uI0J78IMTLAlBvpEdXYeePDVLS9b1m72S0W
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 08:45:21.0956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aaab97b4-14ac-4150-5487-08dc48ba13c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7464
Received-SPF: permerror client-ip=2a01:111:f403:2416::601;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c    | 3 +++
 accel/kvm/trace-events | 1 +
 2 files changed, 4 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 6ae03c880f..b5872fdc07 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3145,6 +3145,9 @@ int kvm_cpu_exec(CPUState *cpu)
             }
             break;
         case KVM_EXIT_MEMORY_FAULT:
+            trace_kvm_memory_fault(run->memory_fault.gpa,
+                                   run->memory_fault.size,
+                                   run->memory_fault.flags);
             if (run->memory_fault.flags & ~KVM_MEMORY_EXIT_FLAG_PRIVATE) {
                 error_report("KVM_EXIT_MEMORY_FAULT: Unknown flag 0x%" PRIx64,
                              (uint64_t)run->memory_fault.flags);
diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
index 31175fed97..681ccb667d 100644
--- a/accel/kvm/trace-events
+++ b/accel/kvm/trace-events
@@ -32,3 +32,4 @@ kvm_interrupt_exit_request(void) ""
 kvm_io_window_exit(void) ""
 kvm_run_exit_system_event(int cpu_index, uint32_t event_type) "cpu_index %d, system_even_type %"PRIu32
 kvm_convert_memory(uint64_t start, uint64_t size, const char *msg) "start 0x%" PRIx64 " size 0x%" PRIx64 " %s"
+kvm_memory_fault(uint64_t start, uint64_t size, uint64_t flags) "start 0x%" PRIx64 " size 0x%" PRIx64 " flags 0x%" PRIx64
-- 
2.25.1


