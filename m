Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345A2C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmrhU-0001OK-2f; Wed, 20 Mar 2024 04:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrhR-0001Jm-KF
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:53:29 -0400
Received: from mail-co1nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2416::600]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrhO-0001Yi-G6
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:53:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWNa5P+xgyzreRDexI8xtN+Q0pK+tNWL1UUo+HXRYWSpvfhyJ3YMYG3hiLhN8q/MsN8vX2ewdMHdKOX3twFU9SATSKfDs4RkQOiMrBsVbTTgoJyscGxh7ZhaUFl65HoLVGCHnavmvmsuEFr6/fVfRFQbaoP5UKbm/q07p2fvBNH2jOWJzi1Et8xiUY+dTuYAQuvYRAoVyIiM3ldvSvqCYMtghVZNxQMImfQD4uw2gU88A8o74MflQ+ctFy/XZJIT5jljaZbmPuIrScdUig0drTHrd7KeuLjmIIHSlNlca/o9i7MT28bdHrykwmie/DWAUv1+Q2vlHKn8x6IQhsK73w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HPNI8nosuhp2hAjQ29ghlD9VELMdvXFv27zQ4Doglc=;
 b=ZP6qz8O1mOa7Oz7pTCwqpvtGzUnDHHqvvFYZ9g5NIT0XBj32ua8xBKssnweBMzVABTo4DgsK9dsJw+DadUU0+onWmiILTw3l9mVtclCSycq/cJhvBxAyBoMumcPz8S1OeP98k4wkMtVWLMEo8dzpcpjC+N/u2oJGAZMHU1rlHvJbZZkIAVqObhjFC6l2FzvAC7ZVk4zycMZTnYt/GASpQmvJcXWPqmZfk+7HIzHiR+DRRusuOO/0n9RUl5bDryqpdU/y8LlyYDPgovOb7yPYoGOwytoTGHWuN2yKIKfE13lM2nIdFUU7O5UxQ5EWYD+ZIclODu62pzufDhvgHOxmLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HPNI8nosuhp2hAjQ29ghlD9VELMdvXFv27zQ4Doglc=;
 b=AX9R+dtymPCRZwExMyV8waZyRUEZEQidDCAFBC9rEX+ITCnX3d2Eex19Hw4WcD8+XfQlntoF4h1TYWibT6b4Ukiz/Su/adw+rdDjDDTR5FRNi4qdEm/5tjmisJBbabqjWS98mV4D6J44CCxk5RiB6KPvfocdpRfYq8ilMFifYKM=
Received: from BN8PR12CA0021.namprd12.prod.outlook.com (2603:10b6:408:60::34)
 by DM4PR12MB7647.namprd12.prod.outlook.com (2603:10b6:8:105::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.29; Wed, 20 Mar
 2024 08:53:22 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:60:cafe::78) by BN8PR12CA0021.outlook.office365.com
 (2603:10b6:408:60::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Wed, 20 Mar 2024 08:53:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 08:53:22 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 03:53:21 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta
 <pankaj.gupta@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Isaku Yamahata
 <isaku.yamahata@linux.intel.com>
Subject: [PATCH v3 03/49] scripts/update-linux-headers: Add bits.h to file
 imports
Date: Wed, 20 Mar 2024 03:38:59 -0500
Message-ID: <20240320083945.991426-4-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|DM4PR12MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: 15931be1-fd01-416d-2b45-08dc48bb32b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cSAWIcRwGZpNB6zHiLxxaggeaqJq8pY8j3uPHHW5SOTmjueHNrE8WVp7gS6XAESEcoon3QLMrpZzq0CPuvtf7Kyh3eveAQN0bq5kGg/tL4yVcwWEddc/oCtpAOVR5fNNniPoLt9DDLxMnjCU7XmZ2zk5HL8np2c9y81Jf3KgDVC2wnMHlh0G+H8/Y1BSHFCY288A2qNismpUjV74U+AKoVcoQLu9KJEhFrC4SP5jQanKLkUkkuPBAQ2SlQCD1+MB4GixhidNtvH00cT998zEk1F5UwRXFD3nbSIaI5de31DjMP+2eA5q5/etMBqfh9D4QMKDxVjMWCY7eIH1Sz3k5bVwg2WYTlfGvXs7WSRrtWvyFfGjzWmBRwwNgM2VBdlagURpTiJSonzO1GBx6KM1Wh0Fno9b3WLdXRoKiLzX/b1ogBzGTiNVuqVsvbje6LbuTpnXnaHNwcGI+VtASNZPLG3DKxsreJieGF/M6+z3m4nOrPX5Hue7IRVme1M6v/K9E5bnaDag1jmJrvO2IYB2fRhUAvqV6y83UN4I+ghDmQsKDJCj8eBQeozJAszOyXOYCPRXHeZSGzOlQsZ7WBgsmgtDZqJA3JzAcNFvmC24qrF8jfv33Za0eulXHaWman8R7TfktC0hs0ONDj1ysZvGRf001SBr75FRULLQ6HMBHKOd6/A9NKAtuj6q754QKUX++67U+ythvcFizqcT8ILBqadXvwXl0Qz8LGEgw2RJ7eNf6ieuvedWXUAQZmSbpz7j
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 08:53:22.6313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15931be1-fd01-416d-2b45-08dc48bb32b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7647
Received-SPF: permerror client-ip=2a01:111:f403:2416::600;
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

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 scripts/update-linux-headers.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 579b03dc82..b992ed7b15 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -168,7 +168,7 @@ rm -rf "$output/linux-headers/linux"
 mkdir -p "$output/linux-headers/linux"
 for header in const.h stddef.h kvm.h vfio.h vfio_ccw.h vfio_zdev.h vhost.h \
               psci.h psp-sev.h userfaultfd.h memfd.h mman.h nvme_ioctl.h \
-              vduse.h iommufd.h; do
+              vduse.h iommufd.h bits.h; do
     cp "$tmpdir/include/linux/$header" "$output/linux-headers/linux"
 done
 
-- 
2.25.1


