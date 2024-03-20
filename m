Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C4FC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:48:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmrci-0007sk-FH; Wed, 20 Mar 2024 04:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrcg-0007pJ-NH
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:48:34 -0400
Received: from mail-dm6nam10on20620.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::620]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrce-0000WA-UN
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:48:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P05DoRmQbrZDpvwNzvPXNZ1KWhzKWcLvnmRmEHZY/zfKHpxFbduydRSvjeRGdWLtoMCmLptWESjCMk4vND3Cd54UvFd74g6MxWQZZ/6ZEF01WRz9Zms3lGDI4Huxxy8wzb6gg0f69hunpaCWWp9yTTG3Vt42g0VT3ruJ/IPRRiERjLa3kkzB/SMmwYglLacIypUH5JclAY7VEhlZHaZfQTu4XwKqZi6nNHgN7kZCMe7dNIG5NyFVg9WcEWDpgEkZezOOtdp+smEGQZwg1mvNuxWd5EaI4HX667FFLAZ+bZ3+N4PmGFDoSBgJys0SL38vwplqVeNh4GJSF7vvBj39Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mswT1AfKqBx1IghYuuHecyz+d8qtFC452e6jZy/oyFY=;
 b=H0jJ2nrUOkVTtLrYCncLQFlGsH4gS7vTq9DQWDJ0V4JHdV9dX/b0M7fXAAjxq2NqsIvz0uvy9xnbA+ibOEC0x8xaOwqZXyzibpx++m8DQDiFrToTy+S9Bsh/WdAQOeiXRJ4U2OLitoRVcMnE+14XQIao++kFrqYU3krP+b1ZLdQSAuTQwcH8vEUaiTmOIzsfgxV9HlqV1QPmt4XI7KHRX9PTaeeAq5sZ2ni+wD/Y7/Mz1ELAjVn7u+BnZ1mvVAjTDET4ryB6sFwa/m2Oeh0cI9WwtZErnpQkwATThBEpW5dTUtVyCq1hy5s9SSh5QcvpThNg0YX0dwivbHhgLx1YsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mswT1AfKqBx1IghYuuHecyz+d8qtFC452e6jZy/oyFY=;
 b=5sYaLpYI9rvvgmDag9vPr8XHeGd0t2dFtoSo11VWS1vI9odsChF2Y+xvdp+1gaAxYzqniKrertoWxO5NG/G+oVTBNnFwfHgQDN3Rr6DLYM9oVaeHImPoQjxoSPPXtggILswiyVtgjENIcKmuH9kUFxmQHb/RaKybvkV+DXr36zI=
Received: from MW4P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::17)
 by DM4PR12MB7743.namprd12.prod.outlook.com (2603:10b6:8:101::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Wed, 20 Mar
 2024 08:48:30 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:303:80:cafe::33) by MW4P223CA0012.outlook.office365.com
 (2603:10b6:303:80::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Wed, 20 Mar 2024 08:48:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 08:48:29 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 03:48:28 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta
 <pankaj.gupta@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Isaku Yamahata
 <isaku.yamahata@linux.intel.com>
Subject: [PATCH v3 28/49] i386/sev: Disable SMM for SNP
Date: Wed, 20 Mar 2024 03:39:24 -0500
Message-ID: <20240320083945.991426-29-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|DM4PR12MB7743:EE_
X-MS-Office365-Filtering-Correlation-Id: 7074f910-55a1-42c3-24cf-08dc48ba842a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M7X3ANZ/hqL5NmMRru7+R0p8KLFmnzwgtkLBfevs+xP/eh1GZro8vJ9paCEpX4aLc25sTi/CoNGkTuoxjesC8jOLKoI1/rZNjnVxPZZkO6QfkdPS+CMk8ewedo8QWpdlAzz5cAM8QBbvo+fWxsq/wDbeHoIF87/ZW5MbQTzJ57kCAp0P1+V1uF4g6TeD8NdcKv8ttzS6jN2bEsdEAnypnSZ9bAsFUUhPf/h2jsXPaFb3KErGNxGDspLdnwRsFTi62feZ7h2XVbsf7+xfS76qdeY9kNofPt/P8Yqji6EBnH7L37aa87OCZ1DK4gzlx0z6ApitzlDnattlBeQEuPszQBlEakl//5JG1YnZVwBTCykHdnvHH2/t18UOLM07NCfKr8eLH+S5rNz2pD0wU/XP43MEKWDlKD3IRp/xDrQdo4hj2Siqr9wXZv4aDtaQR1EJAPoNP2Mb1ZcYB76RsEPSZCPSA6dZexzUVZfNxsQ8O+3DB6co5nmuGpgwnWWi1LbIiU634+Kh7aJ2IfMrpniobPRAsX3OuKhoi8RhpzLjPRYsbasQ0ITDE88R3yj5WLKRWOXeXCt9JdEwviFVXSw4f+2iwqnmHqaTRS5DRAkv92GWkVbLtdIc3CE9eq9jYz80G8jaxEFohQWiCwcbAFCP5q0N13flpN1U0B2fi8CISgkeVwnC9gE2fKrdFh1MJE60TzNXh9+7jge8aKeEhoL7yyxT7NmoUr9wjLrG2KG9bSQMiJw6TpnNOmOuknWyvqsZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 08:48:29.6676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7074f910-55a1-42c3-24cf-08dc48ba842a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7743
Received-SPF: permerror client-ip=2a01:111:f400:7e88::620;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

SNP does not support SMM.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 target/i386/sev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index b06c796aae..134e8f7c22 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -881,6 +881,7 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 {
     SevCommonState *sev_common = SEV_COMMON(cgs);
     MachineState *ms = MACHINE(qdev_get_machine());
+    X86MachineState *x86ms = X86_MACHINE(ms);
     char *devname;
     int ret, fw_error, cmd;
     uint32_t ebx;
@@ -1003,6 +1004,13 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 
     if (sev_snp_enabled()) {
         ms->require_guest_memfd = true;
+
+        if (x86ms->smm == ON_OFF_AUTO_AUTO) {
+            x86ms->smm = ON_OFF_AUTO_OFF;
+        } else if (x86ms->smm == ON_OFF_AUTO_ON) {
+            error_report("SEV-SNP does not support SMM.");
+            goto err;
+        }
     }
 
     qemu_add_vm_change_state_handler(sev_vm_state_change, sev_common);
-- 
2.25.1


