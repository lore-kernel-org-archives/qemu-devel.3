Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE58C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmrXd-0006fO-2r; Wed, 20 Mar 2024 04:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrXb-0006el-NQ
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:43:19 -0400
Received: from mail-dm6nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2415::601]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrXa-0007lc-58
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:43:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YaPPnXpwCK7yrlwkGxsi1C/6KyndIEUHTTfavS/cWIr56AzUoKJlj/YEj8/sCIWNRZ5YJVR4yOO1/J1kW/8OTGF2xADG0LswV0myedNrjR/Syj0tPcLKb1aeNy5JICeVBj/pK+UeyWpO4nrR8FDZ0Dajcp7I5yxiv6D5LMDA8UFYQlbeLtI3tcqz199OD71oqmpFqMfrhNENUdyftGgF6yxG+7dGkd/NrJNEcdcqeCxVjpHzIdNLGJolHDdcDSXkRZTB5tKVG2kK69OOLsNR0YjvFXWTmNNNXFikrKB+k4u22u9upJ2hUvQ7qjZBITuS+1nc4sQwVYa0FXKRcKGerA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdJsnf8ZjFxuG5rUxrazZZnUDr2yfAdTa1Prf4P+9Gg=;
 b=Jxk+H1/gPg7F7sHiTaFPwNr7ZZO0xO/rgA5iWjNvV0ow/ONKAezeZvn+3DR0pIAUevlRXI+dvxmSzYyeCGcQzAdaq/A0XEMhJrZ/i4PeC6paP66nvshD4LNEA+XNAjuTzL1nlmxceMtnSelzAcozsWN4q3GGSCIDiQuIagbGAZLkhMcBjrX67mZ198mr6Ly3Wg18i1tRSXo5mRYF92dhcE0No2/tP6xRXm1QXry6kEbMLvlzwd32b1gserptZMo8qN/dEkADpTBoLvFQ5uCCvF0sHss1V2ZIC4wde6ud/9/+j86Xw4N06WygREif1PL/yZWmoyvYYytREimjc2JnsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdJsnf8ZjFxuG5rUxrazZZnUDr2yfAdTa1Prf4P+9Gg=;
 b=Oop3WKfukIYlPMtY5I8hPWFuHCKQhIaksxL6QcpIdU4RN3bKGrP2T2gSdgVV/BFFSnu/PIMpEP6wUM7p5PH12CFa+XJxWEqawpT542C03buR1fAinzp+jmLpQK85UeLQGrnNoQA5SzTKClZpHe+JOGRj5UmIBPIB6r0kgueFOu8=
Received: from SA1P222CA0092.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::12)
 by CY8PR12MB7755.namprd12.prod.outlook.com (2603:10b6:930:87::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Wed, 20 Mar
 2024 08:43:14 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:35e:cafe::98) by SA1P222CA0092.outlook.office365.com
 (2603:10b6:806:35e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Wed, 20 Mar 2024 08:43:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 08:43:14 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 03:43:13 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta
 <pankaj.gupta@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Isaku Yamahata
 <isaku.yamahata@linux.intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [PATCH v3 14/49] trace/kvm: Add trace for page convertion between
 shared and private
Date: Wed, 20 Mar 2024 03:39:10 -0500
Message-ID: <20240320083945.991426-15-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|CY8PR12MB7755:EE_
X-MS-Office365-Filtering-Correlation-Id: 96f3b1ab-6373-4b43-5f58-08dc48b9c81c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YBKiUQj36+hnlOG+liDVdzEv/eRgIjJSCysWLn4gVLBHaBldBGFRuBSjob4b75FGZSbZyYVhPOt/O8DXsUyj/zHdq9+LmS0MklHOBTmSPQBomCxFcT+gd2hdZjSS6MH+gIR3kSbDZx8dPgjEDGROTzRppbar43avi0cqfFQO6F+dNhxmk/EG7rqMP5Obk9I+9nztN9TLuyOC4yDUMGu2bXXdpc9N0Hj1J1ue6Be2R/2DOspE6+HXU1Rd8uM/+lbQMM8Z7cii99tRcvteqYr0ribV6tCOCh2IveyfXsLN2gEQ8Ge6SOwAKds1185Iq/7ykKpV7BBW17VRH0j/2a+NQN6QaP3/wTwyhnH1jyJuWMkX6HeQRdSQCJdXPSDaAhqU3uuSIjryteQsy5DhPweiEMvGqezT/Iqzt4+0Pyp/CT4rU0SDo3GLhQQUVLX65w5pG7PWKY7DyxXNaPPfsv6p++vJcIP6Cn6K2p4Hx5z6NOkFjBP293sgoN/90O9yhAGvTlAY0Dzdm4JxPflOx2Lb0hunQwx8KeAtuRJ+kWgHwbfHH7JdOABiK1f+W05309S5QleViQmzexOdwmu/MehI4Cy+jC27JQiiGE2GN7qBv+oTXlodd7pmMp/WiPNqlkLu7Zpj5z6OM7sKFxfFJKqzX3mVvbWZf5LG0Iogn8/6Tg9z3zLBRTMxlmHbD0zaCJOjPp6v0Mc6GCgQCHuAHiIUAfF/zplB0b4lwq4QFi4DJhXca3fg9e+8Lfb9rfFbL5+N
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 08:43:14.2438 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f3b1ab-6373-4b43-5f58-08dc48b9c81c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7755
Received-SPF: permerror client-ip=2a01:111:f403:2415::601;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c    | 2 ++
 accel/kvm/trace-events | 1 +
 2 files changed, 3 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index a9c19ab9a1..9a8b365a69 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2912,6 +2912,8 @@ static int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
     void *addr;
     int ret = -1;
 
+    trace_kvm_convert_memory(start, size, to_private ? "shared_to_private" : "private_to_shared");
+
     if (!QEMU_PTR_IS_ALIGNED(start, qemu_real_host_page_size()) ||
         !QEMU_PTR_IS_ALIGNED(size, qemu_real_host_page_size())) {
         return -1;
diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
index e8c52cb9e7..31175fed97 100644
--- a/accel/kvm/trace-events
+++ b/accel/kvm/trace-events
@@ -31,3 +31,4 @@ kvm_cpu_exec(void) ""
 kvm_interrupt_exit_request(void) ""
 kvm_io_window_exit(void) ""
 kvm_run_exit_system_event(int cpu_index, uint32_t event_type) "cpu_index %d, system_even_type %"PRIu32
+kvm_convert_memory(uint64_t start, uint64_t size, const char *msg) "start 0x%" PRIx64 " size 0x%" PRIx64 " %s"
-- 
2.25.1


