Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC1CCD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 13:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMPwe-0003Oq-Sv; Mon, 11 May 2026 08:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wMPwY-0003OU-4X
 for qemu-devel@nongnu.org; Mon, 11 May 2026 08:41:06 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wMPwW-0003rz-0m
 for qemu-devel@nongnu.org; Mon, 11 May 2026 08:41:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VA7Kgbq/J5xgvDbvAg3zA4c7RRAqcX9X/x9FGIlEfoWuQ3LAopu6fZ8nerQS9UrSOy0u/FYkq6MMGGNVhKPsE53jmoyJhazSZ4C1uVUvGqoAEGQBEfOM0Sy2HogsQPx4ZXyxz/j3jOAP0y2GHfsdnXArmTd1CuCm89FRh98qZsGkHMQ7Y/cdSy3k9shltgE/TabOLhTgRBdZDv5S+fQ2ciPlGr6StwvCCVMokQErhubJOTBvcujpzGIBm8aFcBSc+wVlW0BWIqdBp8FfdJPFDw4a8P/cFwGwx24icXnXa8BSa/dRBsUJ1Ev5ebNjR/LJG3r6BRGw95NJiNdNmedkcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5OwHnAWVM04WBVJ4uXYlg5PTUvN+OAwYYRVBlDS71I=;
 b=ys6U37y0OXQX8y3tKq3WHww1ZV+CSDQj71ms+hrIgfJmzSOWx2aGb92wvvpHgZ59uFvucycnPNuG91YhyFttoyppTNbs0dvAMmjX+S34iA93xdg3XXEKm9fRZ7msFODpFOgXmavLnp1N/yEt73nNKeviF/bwbxAFfa07/+yuD80G6OxNzQmcpvC3xnFcUAaWnjZ4Djl8KAZ/LAAKYFZYoaEHkTxAr3CA1jDB8qZV796wvSYZjaxe8rhKhaU6kquyl65c1igXWOxUIUQ5cnnBku4L7soX6PmCUuAqOwLlqsNWuS2HqXw8rkmEbWy3l8KGPdqAY2NeJlUhWv2TMmZxuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5OwHnAWVM04WBVJ4uXYlg5PTUvN+OAwYYRVBlDS71I=;
 b=bTDlAIJHOsxdAJyd80yYkdTJsdjvZy9nUwh70dDijlW08N6gsw0qC+rqJzwWNjwXDgoV9UBjn9hRRdOpeTbrxZ1RihofQd23Ni2LCmOP/0ESk9DgG4Ogzr4DCA94YHKvugH2lw4df1HOe5A42El66Nb9OE/4NtpUyoPAGWYHOP4=
Received: from SA1P222CA0122.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::17)
 by PH8PR12MB7025.namprd12.prod.outlook.com (2603:10b6:510:1bc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Mon, 11 May
 2026 12:40:58 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:3c5:cafe::5) by SA1P222CA0122.outlook.office365.com
 (2603:10b6:806:3c5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 12:40:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 12:40:58 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 11 May
 2026 07:40:54 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Alejandro Jimenez
 <alejandro.j.jimenez@oracle.com>, Ani Sinha <anisinha@redhat.com>, "Eduardo
 Habkost" <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, Sairaj Kodilkar
 <sarunkod@amd.com>, <qemu-devel@nongnu.org>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>
Subject: [PATCH 1/8] tests/acpi: x86: Allow IVRS acpi table changes
Date: Mon, 11 May 2026 18:09:30 +0530
Message-ID: <20260511123937.32743-2-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511123937.32743-1-sarunkod@amd.com>
References: <20260511123937.32743-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|PH8PR12MB7025:EE_
X-MS-Office365-Filtering-Correlation-Id: 17048ce6-ca85-43ef-5c49-08deaf5a8d2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|22082099003|18002099003|921020|11063799003;
X-Microsoft-Antispam-Message-Info: YMrzh1gBiZ9RTmSC0cxpKUQUWywW3pmAKGVjdUan2Mmd2H7whtRC8lt1qd0nhIaH2uF2R6ekDxa9ugP2k2az7ofZp4SMEPVgUd7XAyUho7D48/WfRk26RtBiuhrtrZ0t9TnCPrABW7+wTJmsBGmgBD0JV3k6LhuU8f+K61c41uNI2GFN5NH+3suCMQY8mlwa8Z2Qh+z3KI840QUnPUV6UzB6vRTwOPv7GR7CmN6ueSC9ZHmar6iiMheP17vzzgRzqEMVdDXTmH34YgJU2nyMm/0ezBHk/0XIPbxL/ek4cEFAlrcNUHOgGF42nT7FNTE7o8+xJtqbWuDCyq4voyr3adInTebb+h3HA6D3mUCoeW52GYjdlPuHlxIKkOF7wwUBw2g69pdkmN18m2ExHO5CePicB/fq26EZiSF31x0t/AwOz8Hxefk20/2HJBBDoiZ+DFrAU99sB5zsLDJz45eAOLhT51bRFr1cacThIclDRTTmSGw/0BwIi8PVw5TGRfwLhk06gqHAj+VA59DfRd9wQmXlxLzKDaFBlBn0O8FToIrORjAGISALYYF00Uuf1tQtG4NNDuUkcXQVrMyyqvJrJiFVSGSdJIzgzjghmQGvDWET2/xrMPgCOBZtJw+sXOZwLGww3uXTPJG3Qyr7X+xE+qmafiWKHsDaa66fb5jWJip2bAKsHLNOIxciA0f10DKTNrjAVhxqxvlOApE9OZrr5pHIKe+qelQH7f/T2W1DkJFfpr43jo2RYxkPHbg9yAqpSZ+gOQrdpIsV/ED9ZndlFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(22082099003)(18002099003)(921020)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5+oGDL7DUvMnqALhtym8YNaH5D17ywLVYOe8dD5W372jNUdoVtzAAtPWs+OAbcg1XKSvJ9F8TG2peVUAJUd11E5QAMGtlQ0nZuW63Y/DUcF2Kl5WnNO5h0SZBDLdi42yYkkTyEZ5YJ8BeohpOntdYQueBCFL8IPY8WyYByy7kJjDP4CjWSSpDqVGozY3eZDfvBWQOUKkeQiDHYe49z9sk5SWFdmQQka/XgZZ69TsPPuSFON2HEkxyF0cfAyCPvTbWVlR+BIKWSVPj3ZiwyyIMjx6Aq+Z/WMVkwRL+DK0GCi+SK/ncG18xhJuEokcSgi6A1CMpXv0gXr+7/6ESgLrTa/u7vwRI4xn2o9AhMqIll+/nQ35dV15Gwbdad782XMnUK1PI6uWQW7DUWjH4yW52sjNxADQyHO1LpOjS575ML7y3P7h/63jhpI5rRHEZOqd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 12:40:58.3480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17048ce6-ca85-43ef-5c49-08deaf5a8d2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7025
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=Sairaj.K@amd.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8bf4..33e998165591 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+tests/data/acpi/x86/q35/IVRS.ivrs
-- 
2.34.1


