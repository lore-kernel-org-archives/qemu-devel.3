Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165C7CAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0ek-0002Qg-Rk; Fri, 12 Sep 2025 06:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0d3-0007X2-Ku; Fri, 12 Sep 2025 06:03:50 -0400
Received: from mail-mw2nam12on20628.outbound.protection.outlook.com
 ([2a01:111:f403:200a::628]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cl-0001OK-6c; Fri, 12 Sep 2025 06:03:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxyVR6IzUnzBhAW0P8ZwUdvZU/BYaWKQhfQYj1Ot3ZzPuWJw+UjmawWJ/Np3y2O+Xgdy2oUCc5clccLKEnINOvfnvggenUgnh6XgOg/qC+F5kqm5AM8rzyDgTyKW1Xxs55dIumNo4b7eOyPmKISj+GzndM9RHWA5/YO+pi39isvsM9oDBze93wfadRccjN573ofGL+1n1++TODGPGgmXSM9w/WExZd6tAThr3wH+QY+O0bjABZaHGZRBoZK3GwLk6u9Nhl7f/J7IyBRGp7zIzobEE3Z7phBekWXpsOBcFZ+pm+hwlAKboifnF9OIKFYzGWqzFjFgmx5djNIK/wBtvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fk5gW7Ej6loUhsO6Ixi4opZvN4M2rrqbJnW9PH5/Ebo=;
 b=fHBoiPmESFPCcnmHW0I/+qG8lk1RNQddSGx2Op9VT2BN1swekvtNaG36sG2Sb76S7fuFRhy4ib8z/lVJMLg9NfpWttt+dTUs/YtGFbDpNWZaPrGIrmLOKqW3Nnh3r3k/2TPedQZNpn4iJXH/xgAYGpIc3jOXpN3Q5W363sBvCZLoytKIXfC1wx/fJgEoF1ocQsycOwze/wF194eb9V8Nf4hVFccdhz3Qc7gkezSRsVhYqWxeX/5T7llLs9ST7ssWkO+oCVSqCXUojEarLORISiL/F1rnnKt9GQ6aWqjkoeIYMXYo5ogHOe6qqa3arFFOYwdPRl7Fqc6dAVyE9aTuDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fk5gW7Ej6loUhsO6Ixi4opZvN4M2rrqbJnW9PH5/Ebo=;
 b=1eE/G576Pej9KJjIhTunEtmutbIxDpHN8e0lMMfDnNfimmK12114rt6rgPT6zMw+TNZLqZdr3RyooOMQnj0VfKHAr7pRkz4JCxUSxGcyOTCZ48+ggF8H5r5N+/UZqInCGjG5fhCETUQi0rrEhxNdL0Rc1w/ffr9PzG70pH+uung=
Received: from DS7P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::16) by
 SA1PR12MB8987.namprd12.prod.outlook.com (2603:10b6:806:386::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:03:13 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:8:1ca:cafe::a4) by DS7P220CA0011.outlook.office365.com
 (2603:10b6:8:1ca::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.18 via Frontend Transport; Fri,
 12 Sep 2025 10:03:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:03:13 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 03:02:25 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 03:02:25 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 12 Sep 2025 03:02:24 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v5 36/47] hw/misc/xlnx-versal-crl: add the versal2 version
Date: Fri, 12 Sep 2025 12:00:45 +0200
Message-ID: <20250912100059.103997-37-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250912100059.103997-1-luc.michel@amd.com>
References: <20250912100059.103997-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|SA1PR12MB8987:EE_
X-MS-Office365-Filtering-Correlation-Id: 013733b2-fc64-43b9-f06d-08ddf1e39639
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVEzV0tWOGZYa2xDZ3VudDdYT2kwOXNINC8rM3Q3bFV1bjRRV3pYVUs2Rzhy?=
 =?utf-8?B?WG9iZGlKeHNoRlFTVEF5bUhVeWQveXVQakpHQjFmMnZDLzhDZzhFejFCRk1V?=
 =?utf-8?B?bkZKZW1lVmRISGNuN3FlOEVwbzFrTVpBdXdiZTNZUkh1MkxDOVBDZWFBcWxz?=
 =?utf-8?B?d28rMG80cmFXZmNoZlhZMjZEdlM1Y2pJYXlGMVZIR044WkpYWCtaaXcxLzNN?=
 =?utf-8?B?M2ZmQXQ1RGlEajBYOFpVRU1KN2ZQYUVXZUVQdXNwMUxKaGgreVFKNmJVaW9O?=
 =?utf-8?B?VFNwNGRrRGxSZkplblFKZ2l2bUlZQ1FlRFNqRXp3eGYwQ1JlQzZDSWRnMk5s?=
 =?utf-8?B?SWpFRnhwRXdsc2U1MTZSK1B3MlYrQjNqa2w0N1NUTklpVzVlY0Z0dE1LMklz?=
 =?utf-8?B?aFluckVBVHpoRE1qTkdiRVRYbkFhZVZERDk0NEFQbUxHc3BlMDZWWEU1Nkwr?=
 =?utf-8?B?OE5oVFRsNmt6WFNHYnYvd3RETmZtNm5lR2pSSHp4OEh0MVVtZjc3SElkamZy?=
 =?utf-8?B?UHdoSzAraU9Jc29BSHJKVUNjRXZCM0IyaTI4bUhna2E2WjhGK2xlWGwwSUNE?=
 =?utf-8?B?c0I1bHVTdWFuMzBCVFVvTmtucGMrVmRLZW9zQnBCd1QydVk2Y09Nc0NwUGVX?=
 =?utf-8?B?TU5tN3R4QXF5MjAvV09jaG5ZV2NMNXQvOHlKWHBwOUhBWkV4TWQzZWtRRE9B?=
 =?utf-8?B?c0JUQnI0dHFiZEZwa0syRmZSVG1lU3hva252RDJsaDNFYm5YbG5XU0txVWtK?=
 =?utf-8?B?cjBXcXJuU1JVMWlOd3JvSFUwL0JTL2dKVzZpNGE3b2V2bHIzSGdzcUNjelV4?=
 =?utf-8?B?VFFjU0E3VG9BTmxsRnlLREQvNGZ4NXo2TEhOZ2Z6YmdTSEgzQmZMZlIvQ01O?=
 =?utf-8?B?S3BJQ2ZhWjdSVmRIRE12dFRJdDNuNVZUNDI4ay9ZRElYeDhCcDBaNHBKMXl2?=
 =?utf-8?B?OGt6cUpJWEE2NldIUFNDU0xYTGptL3FPTlNEYzY3TGFiVEZVbGx5eWQ3Ynhw?=
 =?utf-8?B?aWhkR1hhQjhnemFOTXdQYS9QM1JSNG9TVzdPNm1IdGd5NCtYRFZWUHpFZmZW?=
 =?utf-8?B?QWZEc1M2eS9FVUFZN0EweTg0T2N4T3phekpkTlVKR0JJRXBTalYwcjVTQnlr?=
 =?utf-8?B?NWVReVFqbzg2MTAwNlNBUFB1TGVuWlM4WTNMR3Q0b0NrMHJEWVJqVnZZUmtJ?=
 =?utf-8?B?bzlGVENVdG1Odm5TNVZicU9aUDNFWVNUSndkbDF1NTdsQ2ZaUU1aMWFxd2pS?=
 =?utf-8?B?ZGs3enRiYnhacHJGckJMUnExT2JrSUFuRXdiUjJ0WVJwcUQzRWM1SGNNMys5?=
 =?utf-8?B?eCtyWTJIaDZTeE03VlJUb0FTSVRuSFFsQWZicmgvdnNtV0dvaVc5eG9tQTh6?=
 =?utf-8?B?TzhOTFNWTm56OGtaSmt3MnNEY3ArK3g2K1hjNlRFSHljYW5vV3NBdWJLV2xJ?=
 =?utf-8?B?ajUvckViNjUxVkVBa3BJenBqQWdwWC9CbHVJTGFvaCtQYndTMTFxTGx5RFV3?=
 =?utf-8?B?MXI4eDN2YzZuR2lBaE8zZWY0OUF4MGFJVzhubkZKYWdOQzhOMlNwdWlxcEEv?=
 =?utf-8?B?WUtrNHkyYVVaMHhPR2NzYUxaMEI1WmVJUDhNTmh4bGlmSXFUeDFYK1VubTRS?=
 =?utf-8?B?RHFJZjB2bWYydG51YUsvRFBFY1ZpSTcrdHE3TVFNY3dOa09jTkFYekZOUmhr?=
 =?utf-8?B?clh3bVRSR1lyekJCcWNBNjg3RkszdGxiT2xsWnIxSTdEK1NPUzgveE5OK2hP?=
 =?utf-8?B?c0ZXenVOWFR1YldPN1FnUWFHcUQvM1pTVk4yNWNrWkZzWEVZMENEdVh2dUxR?=
 =?utf-8?B?Q2xRWkM4U25NQXRiRlVvTGxQNUZkQXpKeXoyYW5YVjlDUFE3cnZxQVNmOGdt?=
 =?utf-8?B?cHFhN1l2YkdBb3FGdWpnc2pZSXlkcEFRQ2hzcnZpT1Eyelo3QlJmUUtsWnpC?=
 =?utf-8?B?Wm9nSndMQmJsTlNWZFlsRGMwMVRFVDh5VDl2OEJDbGFwSU5YSDRoUFgyWGdH?=
 =?utf-8?B?RHZWa0dTblFNbTVQbjNmbTRqaWNQajYrUVFXSTE5Ynp0aW1tc05qbEZPTEJN?=
 =?utf-8?Q?h6V9MG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:03:13.5920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 013733b2-fc64-43b9-f06d-08ddf1e39639
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8987
Received-SPF: permerror client-ip=2a01:111:f403:200a::628;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Add the versal2 version of the CRL device. For the implemented part, it
is similar to the versal version but drives reset line of more devices.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/xlnx-versal-version.h |   1 +
 include/hw/misc/xlnx-versal-crl.h    | 329 ++++++++++++++++++++++
 hw/misc/xlnx-versal-crl.c            | 392 +++++++++++++++++++++++++++
 3 files changed, 722 insertions(+)

diff --git a/include/hw/arm/xlnx-versal-version.h b/include/hw/arm/xlnx-versal-version.h
index c4307d1304a..5b6b6e57a57 100644
--- a/include/hw/arm/xlnx-versal-version.h
+++ b/include/hw/arm/xlnx-versal-version.h
@@ -8,8 +8,9 @@
 #ifndef HW_ARM_XLNX_VERSAL_VERSION_H
 #define HW_ARM_XLNX_VERSAL_VERSION_H
 
 typedef enum VersalVersion {
     VERSAL_VER_VERSAL,
+    VERSAL_VER_VERSAL2,
 } VersalVersion;
 
 #endif
diff --git a/include/hw/misc/xlnx-versal-crl.h b/include/hw/misc/xlnx-versal-crl.h
index 7e50a95ad3c..f6b8694ebea 100644
--- a/include/hw/misc/xlnx-versal-crl.h
+++ b/include/hw/misc/xlnx-versal-crl.h
@@ -15,14 +15,16 @@
 #include "target/arm/cpu-qom.h"
 #include "hw/arm/xlnx-versal-version.h"
 
 #define TYPE_XLNX_VERSAL_CRL_BASE "xlnx-versal-crl-base"
 #define TYPE_XLNX_VERSAL_CRL "xlnx-versal-crl"
+#define TYPE_XLNX_VERSAL2_CRL "xlnx-versal2-crl"
 
 OBJECT_DECLARE_TYPE(XlnxVersalCRLBase, XlnxVersalCRLBaseClass,
                     XLNX_VERSAL_CRL_BASE)
 OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCRL, XLNX_VERSAL_CRL)
+OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersal2CRL, XLNX_VERSAL2_CRL)
 
 REG32(ERR_CTRL, 0x0)
     FIELD(ERR_CTRL, SLVERR_ENABLE, 0, 1)
 REG32(IR_STATUS, 0x4)
     FIELD(IR_STATUS, ADDR_DECODE_ERR, 0, 1)
@@ -218,10 +220,318 @@ REG32(PSM_RST_MODE, 0x370)
     FIELD(PSM_RST_MODE, WAKEUP, 2, 1)
     FIELD(PSM_RST_MODE, RST_MODE, 0, 2)
 
 #define CRL_R_MAX (R_PSM_RST_MODE + 1)
 
+REG32(VERSAL2_ERR_CTRL, 0x0)
+REG32(VERSAL2_WPROT, 0x1c)
+    FIELD(VERSAL2_WPROT, ACTIVE, 0, 1)
+REG32(VERSAL2_RPLL_CTRL, 0x40)
+    FIELD(VERSAL2_RPLL_CTRL, POST_SRC, 24, 3)
+    FIELD(VERSAL2_RPLL_CTRL, PRE_SRC, 20, 3)
+    FIELD(VERSAL2_RPLL_CTRL, CLKOUTDIV, 16, 2)
+    FIELD(VERSAL2_RPLL_CTRL, FBDIV, 8, 8)
+    FIELD(VERSAL2_RPLL_CTRL, BYPASS, 3, 1)
+    FIELD(VERSAL2_RPLL_CTRL, RESET, 0, 1)
+REG32(VERSAL2_RPLL_CFG, 0x44)
+    FIELD(VERSAL2_RPLL_CFG, LOCK_DLY, 25, 7)
+    FIELD(VERSAL2_RPLL_CFG, LOCK_CNT, 13, 10)
+    FIELD(VERSAL2_RPLL_CFG, LFHF, 10, 2)
+    FIELD(VERSAL2_RPLL_CFG, CP, 5, 4)
+    FIELD(VERSAL2_RPLL_CFG, RES, 0, 4)
+REG32(VERSAL2_FLXPLL_CTRL, 0x50)
+    FIELD(VERSAL2_FLXPLL_CTRL, POST_SRC, 24, 3)
+    FIELD(VERSAL2_FLXPLL_CTRL, PRE_SRC, 20, 3)
+    FIELD(VERSAL2_FLXPLL_CTRL, CLKOUTDIV, 16, 2)
+    FIELD(VERSAL2_FLXPLL_CTRL, FBDIV, 8, 8)
+    FIELD(VERSAL2_FLXPLL_CTRL, BYPASS, 3, 1)
+    FIELD(VERSAL2_FLXPLL_CTRL, RESET, 0, 1)
+REG32(VERSAL2_FLXPLL_CFG, 0x54)
+    FIELD(VERSAL2_FLXPLL_CFG, LOCK_DLY, 25, 7)
+    FIELD(VERSAL2_FLXPLL_CFG, LOCK_CNT, 13, 10)
+    FIELD(VERSAL2_FLXPLL_CFG, LFHF, 10, 2)
+    FIELD(VERSAL2_FLXPLL_CFG, CP, 5, 4)
+    FIELD(VERSAL2_FLXPLL_CFG, RES, 0, 4)
+REG32(VERSAL2_PLL_STATUS, 0x60)
+    FIELD(VERSAL2_PLL_STATUS, FLXPLL_STABLE, 3, 1)
+    FIELD(VERSAL2_PLL_STATUS, RPLL_STABLE, 2, 1)
+    FIELD(VERSAL2_PLL_STATUS, FLXPLL_LOCK, 1, 1)
+    FIELD(VERSAL2_PLL_STATUS, RPLL_LOCK, 0, 1)
+REG32(VERSAL2_RPLL_TO_XPD_CTRL, 0x100)
+    FIELD(VERSAL2_RPLL_TO_XPD_CTRL, DIVISOR0, 8, 10)
+REG32(VERSAL2_LPX_TOP_SWITCH_CTRL, 0x104)
+    FIELD(VERSAL2_LPX_TOP_SWITCH_CTRL, CLKACT_ADMA, 26, 1)
+    FIELD(VERSAL2_LPX_TOP_SWITCH_CTRL, CLKACT, 25, 1)
+    FIELD(VERSAL2_LPX_TOP_SWITCH_CTRL, DIVISOR0, 8, 10)
+    FIELD(VERSAL2_LPX_TOP_SWITCH_CTRL, SRCSEL, 0, 3)
+REG32(VERSAL2_LPX_LSBUS_CLK_CTRL, 0x108)
+    FIELD(VERSAL2_LPX_LSBUS_CLK_CTRL, CLKACT, 25, 1)
+    FIELD(VERSAL2_LPX_LSBUS_CLK_CTRL, DIVISOR0, 8, 10)
+    FIELD(VERSAL2_LPX_LSBUS_CLK_CTRL, SRCSEL, 0, 3)
+REG32(VERSAL2_RPU_CLK_CTRL, 0x10c)
+    FIELD(VERSAL2_RPU_CLK_CTRL, CLKACT, 25, 1)
+    FIELD(VERSAL2_RPU_CLK_CTRL, CLKACT_CLUSTERE, 24, 1)
+    FIELD(VERSAL2_RPU_CLK_CTRL, CLKACT_CLUSTERD, 23, 1)
+    FIELD(VERSAL2_RPU_CLK_CTRL, CLKACT_CLUSTERC, 22, 1)
+    FIELD(VERSAL2_RPU_CLK_CTRL, CLKACT_CLUSTERB, 21, 1)
+    FIELD(VERSAL2_RPU_CLK_CTRL, CLKACT_CLUSTERA, 20, 1)
+    FIELD(VERSAL2_RPU_CLK_CTRL, DIVISOR0, 8, 10)
+    FIELD(VERSAL2_RPU_CLK_CTRL, SRCSEL, 0, 3)
+REG32(VERSAL2_OCM_CLK_CTRL, 0x120)
+    FIELD(VERSAL2_OCM_CLK_CTRL, CLKACT_OCM3, 24, 1)
+    FIELD(VERSAL2_OCM_CLK_CTRL, CLKACT_OCM2, 23, 1)
+    FIELD(VERSAL2_OCM_CLK_CTRL, CLKACT_OCM1, 22, 1)
+    FIELD(VERSAL2_OCM_CLK_CTRL, CLKACT_OCM0, 21, 1)
+REG32(VERSAL2_IOU_SWITCH_CLK_CTRL, 0x124)
+    FIELD(VERSAL2_IOU_SWITCH_CLK_CTRL, CLKACT, 25, 1)
+    FIELD(VERSAL2_IOU_SWITCH_CLK_CTRL, DIVISOR0, 8, 10)
+    FIELD(VERSAL2_IOU_SWITCH_CLK_CTRL, SRCSEL, 0, 3)
+REG32(VERSAL2_GEM0_REF_CTRL, 0x128)
+    FIELD(VERSAL2_GEM0_REF_CTRL, CLKACT_RX, 27, 1)
+    FIELD(VERSAL2_GEM0_REF_CTRL, CLKACT_TX, 26, 1)
+    FIELD(VERSAL2_GEM0_REF_CTRL, CLKACT, 25, 1)
+    FIELD(VERSAL2_GEM0_REF_CTRL, DIVISOR0, 8, 10)
+    FIELD(VERSAL2_GEM0_REF_CTRL, SRCSEL, 0, 3)
+REG32(VERSAL2_GEM1_REF_CTRL, 0x12c)
+    FIELD(VERSAL2_GEM1_REF_CTRL, CLKACT_RX, 27, 1)
+    FIELD(VERSAL2_GEM1_REF_CTRL, CLKACT_TX, 26, 1)
+    FIELD(VERSAL2_GEM1_REF_CTRL, CLKACT, 25, 1)
+    FIELD(VERSAL2_GEM1_REF_CTRL, DIVISOR0, 8, 10)
+    FIELD(VERSAL2_GEM1_REF_CTRL, SRCSEL, 0, 3)
+REG32(VERSAL2_GEM_TSU_REF_CLK_CTRL, 0x130)
+    FIELD(VERSAL2_GEM_TSU_REF_CLK_CTRL, CLKACT, 25, 1)
+    FIELD(VERSAL2_GEM_TSU_REF_CLK_CTRL, DIVISOR0, 8, 10)
+    FIELD(VERSAL2_GEM_TSU_REF_CLK_CTRL, SRCSEL, 0, 3)
+REG32(VERSAL2_USB0_BUS_REF_CLK_CTRL, 0x134)
+    FIELD(VERSAL2_USB0_BUS_REF_CLK_CTRL, CLKACT, 25, 1)
+    FIELD(VERSAL2_USB0_BUS_REF_CLK_CTRL, DIVISOR0, 8, 10)
+    FIELD(VERSAL2_USB0_BUS_REF_CLK_CTRL, SRCSEL, 0, 3)
+REG32(VERSAL2_USB1_BUS_REF_CLK_CTRL, 0x138)
+    FIELD(VERSAL2_USB1_BUS_REF_CLK_CTRL, CLKACT, 25, 1)
+    FIELD(VERSAL2_USB1_BUS_REF_CLK_CTRL, DIVISOR0, 8, 10)
+    FIELD(VERSAL2_USB1_BUS_REF_CLK_CTRL, SRCSEL, 0, 3)
+REG32(VERSAL2_UART0_REF_CLK_CTRL, 0x13c)
+    FIELD(VERSAL2_UART0_REF_CLK_CTRL, CLKACT, 25, 1)
+    FIELD(VERSAL2_UART0_REF_CLK_CTRL, DIVISOR0, 8, 10)
+    FIELD(VERSAL2_UART0_REF_CLK_CTRL, SRCSEL, 0, 3)
+REG32(VERSAL2_UART1_REF_CLK_CTRL, 0x140)
+    FIELD(VERSAL2_UART1_REF_CLK_CTRL, CLKACT, 25, 1)
+    FIELD(VERSAL2_UART1_REF_CLK_CTRL, DIVISOR0, 8, 10)
+    FIELD(VERSAL2_UART1_REF_CLK_CTRL, SRCSEL, 0, 3)
+REG32(VERSAL2_SPI0_REF_CLK_CTRL, 0x144)
+    FIELD(VERSAL2_SPI0_REF_CLK_CTRL, CLKACT, 25, 1)
+    FIELD(VERSAL2_SPI0_REF_CLK_CTRL, DIVISOR0, 8, 10)
+    FIELD(VERSAL2_SPI0_REF_CLK_CTRL, SRCSEL, 0, 3)
+REG32(VERSAL2_SPI1_REF_CLK_CTRL, 0x148)
+    FIELD(VERSAL2_SPI1_REF_CLK_CTRL, CLKACT, 25, 1)
+    FIELD(VERSAL2_SPI1_REF_CLK_CTRL, DIVISOR0, 8, 10)
+    FIELD(VERSAL2_SPI1_REF_CLK_CTRL, SRCSEL, 0, 3)
+REG32(VERSAL2_CAN0_REF_2X_CTRL, 0x14c)
+    FIELD(VERSAL2_CAN0_REF_2X_CTRL, CLKACT, 25, 1)
+    FIELD(VERSAL2_CAN0_REF_2X_CTRL, DIVISOR0, 8, 10)
+    FIELD(VERSAL2_CAN0_REF_2X_CTRL, SRCSEL, 0, 3)
+REG32(VERSAL2_CAN1_REF_2X_CTRL, 0x150)
+    FIELD(VERSAL2_CAN1_REF_2X_CTRL, CLKACT, 25, 1)
+    FIELD(VERSAL2_CAN1_REF_2X_CTRL, DIVISOR0, 8, 10)
+    FIELD(VERSAL2_CAN1_REF_2X_CTRL, SRCSEL, 0, 3)
+REG32(VERSAL2_CAN2_REF_2X_CTRL, 0x154)
+    FIELD(VERSAL2_CAN2_REF_2X_CTRL, CLKACT, 25, 1)
+    FIELD(VERSAL2_CAN2_REF_2X_CTRL, DIVISOR0, 8, 10)
+    FIELD(VERSAL2_CAN2_REF_2X_CTRL, SRCSEL, 0, 3)
+REG32(VERSAL2_CAN3_REF_2X_CTRL, 0x158)
+    FIELD(VERSAL2_CAN3_REF_2X_CTRL, CLKACT, 25, 1)
+    FIELD(VERSAL2_CAN3_REF_2X_CTRL, DIVISOR0, 8, 10)
+    FIELD(VERSAL2_CAN3_REF_2X_CTRL, SRCSEL, 0, 3)
+REG32(VERSAL2_I3C0_REF_CTRL, 0x15c)
+    FIELD(VERSAL2_I3C0_REF_CTRL, CLKACT, 25, 1)
+    FIELD(VERSAL2_I3C0_REF_CTRL, DIVISOR0, 8, 10)
+    FIELD(VERSAL2_I3C0_REF_CTRL, SRCSEL, 0, 3)
+REG32(VERSAL2_I3C1_REF_CTRL, 0x160)
+    FIELD(VERSAL2_I3C1_REF_CTRL, CLKACT, 25, 1)
+    FIELD(VERSAL2_I3C1_REF_CTRL, DIVISOR0, 8, 10)
+    FIELD(VERSAL2_I3C1_REF_CTRL, SRCSEL, 0, 3)
+REG32(VERSAL2_I3C2_REF_CTRL, 0x164)
+    FIELD(VERSAL2_I3C2_REF_CTRL, CLKACT, 25, 1)
+    FIELD(VERSAL2_I3C2_REF_CTRL, DIVISOR0, 8, 10)
+    FIELD(VERSAL2_I3C2_REF_CTRL, SRCSEL, 0, 3)
+REG32(VERSAL2_I3C3_REF_CTRL, 0x168)
+    FIELD(VERSAL2_I3C3_REF_CTRL, CLKACT, 25, 1)
+    FIELD(VERSAL2_I3C3_REF_CTRL, DIVISOR0, 8, 10)
+    FIELD(VERSAL2_I3C3_REF_CTRL, SRCSEL, 0, 3)
+REG32(VERSAL2_I3C4_REF_CTRL, 0x16c)
+    FIELD(VERSAL2_I3C4_REF_CTRL, CLKACT, 25, 1)
+    FIELD(VERSAL2_I3C4_REF_CTRL, DIVISOR0, 8, 10)
+    FIELD(VERSAL2_I3C4_REF_CTRL, SRCSEL, 0, 3)
+REG32(VERSAL2_I3C5_REF_CTRL, 0x170)
+    FIELD(VERSAL2_I3C5_REF_CTRL, CLKACT, 25, 1)
+    FIELD(VERSAL2_I3C5_REF_CTRL, DIVISOR0, 8, 10)
+    FIELD(VERSAL2_I3C5_REF_CTRL, SRCSEL, 0, 3)
+REG32(VERSAL2_I3C6_REF_CTRL, 0x174)
+    FIELD(VERSAL2_I3C6_REF_CTRL, CLKACT, 25, 1)
+    FIELD(VERSAL2_I3C6_REF_CTRL, DIVISOR0, 8, 10)
+    FIELD(VERSAL2_I3C6_REF_CTRL, SRCSEL, 0, 3)
+REG32(VERSAL2_I3C7_REF_CTRL, 0x178)
+    FIELD(VERSAL2_I3C7_REF_CTRL, CLKACT, 25, 1)
+    FIELD(VERSAL2_I3C7_REF_CTRL, DIVISOR0, 8, 10)
+    FIELD(VERSAL2_I3C7_REF_CTRL, SRCSEL, 0, 3)
+REG32(VERSAL2_DBG_LPX_CTRL, 0x17c)
+    FIELD(VERSAL2_DBG_LPX_CTRL, CLKACT, 25, 1)
+    FIELD(VERSAL2_DBG_LPX_CTRL, DIVISOR0, 8, 10)
+    FIELD(VERSAL2_DBG_LPX_CTRL, SRCSEL, 0, 3)
+REG32(VERSAL2_TIMESTAMP_REF_CTRL, 0x180)
+    FIELD(VERSAL2_TIMESTAMP_REF_CTRL, CLKACT, 25, 1)
+    FIELD(VERSAL2_TIMESTAMP_REF_CTRL, DIVISOR0, 8, 10)
+    FIELD(VERSAL2_TIMESTAMP_REF_CTRL, SRCSEL, 0, 3)
+REG32(VERSAL2_SAFETY_CHK, 0x184)
+REG32(VERSAL2_ASU_CLK_CTRL, 0x188)
+    FIELD(VERSAL2_ASU_CLK_CTRL, DIVISOR0, 8, 10)
+    FIELD(VERSAL2_ASU_CLK_CTRL, SRCSEL, 0, 3)
+REG32(VERSAL2_DBG_TSTMP_CLK_CTRL, 0x18c)
+    FIELD(VERSAL2_DBG_TSTMP_CLK_CTRL, CLKACT, 25, 1)
+    FIELD(VERSAL2_DBG_TSTMP_CLK_CTRL, DIVISOR0, 8, 10)
+    FIELD(VERSAL2_DBG_TSTMP_CLK_CTRL, SRCSEL, 0, 3)
+REG32(VERSAL2_MMI_TOPSW_CLK_CTRL, 0x190)
+    FIELD(VERSAL2_MMI_TOPSW_CLK_CTRL, CLKACT, 25, 1)
+    FIELD(VERSAL2_MMI_TOPSW_CLK_CTRL, DIVISOR0, 8, 10)
+    FIELD(VERSAL2_MMI_TOPSW_CLK_CTRL, SRCSEL, 0, 3)
+REG32(VERSAL2_WWDT_PLL_CLK_CTRL, 0x194)
+    FIELD(VERSAL2_WWDT_PLL_CLK_CTRL, DIVISOR0, 8, 10)
+    FIELD(VERSAL2_WWDT_PLL_CLK_CTRL, SRCSEL, 0, 3)
+REG32(VERSAL2_RCLK_CTRL, 0x1a0)
+    FIELD(VERSAL2_RCLK_CTRL, CLKACT, 8, 6)
+    FIELD(VERSAL2_RCLK_CTRL, SELECT, 0, 6)
+REG32(VERSAL2_RST_RPU_A, 0x310)
+    FIELD(VERSAL2_RST_RPU_A, TOPRESET, 16, 1)
+    FIELD(VERSAL2_RST_RPU_A, CORE1_POR, 9, 1)
+    FIELD(VERSAL2_RST_RPU_A, CORE0_POR, 8, 1)
+    FIELD(VERSAL2_RST_RPU_A, CORE1_RESET, 1, 1)
+    FIELD(VERSAL2_RST_RPU_A, CORE0_RESET, 0, 1)
+REG32(VERSAL2_RST_RPU_B, 0x314)
+    FIELD(VERSAL2_RST_RPU_B, TOPRESET, 16, 1)
+    FIELD(VERSAL2_RST_RPU_B, CORE1_POR, 9, 1)
+    FIELD(VERSAL2_RST_RPU_B, CORE0_POR, 8, 1)
+    FIELD(VERSAL2_RST_RPU_B, CORE1_RESET, 1, 1)
+    FIELD(VERSAL2_RST_RPU_B, CORE0_RESET, 0, 1)
+REG32(VERSAL2_RST_RPU_C, 0x318)
+    FIELD(VERSAL2_RST_RPU_C, TOPRESET, 16, 1)
+    FIELD(VERSAL2_RST_RPU_C, CORE1_POR, 9, 1)
+    FIELD(VERSAL2_RST_RPU_C, CORE0_POR, 8, 1)
+    FIELD(VERSAL2_RST_RPU_C, CORE1_RESET, 1, 1)
+    FIELD(VERSAL2_RST_RPU_C, CORE0_RESET, 0, 1)
+REG32(VERSAL2_RST_RPU_D, 0x31c)
+    FIELD(VERSAL2_RST_RPU_D, TOPRESET, 16, 1)
+    FIELD(VERSAL2_RST_RPU_D, CORE1_POR, 9, 1)
+    FIELD(VERSAL2_RST_RPU_D, CORE0_POR, 8, 1)
+    FIELD(VERSAL2_RST_RPU_D, CORE1_RESET, 1, 1)
+    FIELD(VERSAL2_RST_RPU_D, CORE0_RESET, 0, 1)
+REG32(VERSAL2_RST_RPU_E, 0x320)
+    FIELD(VERSAL2_RST_RPU_E, TOPRESET, 16, 1)
+    FIELD(VERSAL2_RST_RPU_E, CORE1_POR, 9, 1)
+    FIELD(VERSAL2_RST_RPU_E, CORE0_POR, 8, 1)
+    FIELD(VERSAL2_RST_RPU_E, CORE1_RESET, 1, 1)
+    FIELD(VERSAL2_RST_RPU_E, CORE0_RESET, 0, 1)
+REG32(VERSAL2_RST_RPU_GD_0, 0x324)
+    FIELD(VERSAL2_RST_RPU_GD_0, RESET, 1, 1)
+    FIELD(VERSAL2_RST_RPU_GD_0, TOP_RESET, 0, 1)
+REG32(VERSAL2_RST_RPU_GD_1, 0x328)
+    FIELD(VERSAL2_RST_RPU_GD_1, RESET, 1, 1)
+    FIELD(VERSAL2_RST_RPU_GD_1, TOP_RESET, 0, 1)
+REG32(VERSAL2_RST_ASU_GD, 0x32c)
+    FIELD(VERSAL2_RST_ASU_GD, RESET, 1, 1)
+    FIELD(VERSAL2_RST_ASU_GD, TOP_RESET, 0, 1)
+REG32(VERSAL2_RST_ADMA, 0x334)
+    FIELD(VERSAL2_RST_ADMA, RESET, 0, 1)
+REG32(VERSAL2_RST_SDMA, 0x338)
+    FIELD(VERSAL2_RST_SDMA, RESET, 0, 1)
+REG32(VERSAL2_RST_GEM0, 0x33c)
+    FIELD(VERSAL2_RST_GEM0, RESET, 0, 1)
+REG32(VERSAL2_RST_GEM1, 0x340)
+    FIELD(VERSAL2_RST_GEM1, RESET, 0, 1)
+REG32(VERSAL2_RST_USB0, 0x348)
+    FIELD(VERSAL2_RST_USB0, RESET, 0, 1)
+REG32(VERSAL2_RST_USB1, 0x34c)
+    FIELD(VERSAL2_RST_USB1, RESET, 0, 1)
+REG32(VERSAL2_RST_UART0, 0x350)
+    FIELD(VERSAL2_RST_UART0, RESET, 0, 1)
+REG32(VERSAL2_RST_UART1, 0x354)
+    FIELD(VERSAL2_RST_UART1, RESET, 0, 1)
+REG32(VERSAL2_RST_SPI0, 0x358)
+    FIELD(VERSAL2_RST_SPI0, RESET, 0, 1)
+REG32(VERSAL2_RST_SPI1, 0x35c)
+    FIELD(VERSAL2_RST_SPI1, RESET, 0, 1)
+REG32(VERSAL2_RST_CAN0, 0x360)
+    FIELD(VERSAL2_RST_CAN0, RESET, 0, 1)
+REG32(VERSAL2_RST_CAN1, 0x364)
+    FIELD(VERSAL2_RST_CAN1, RESET, 0, 1)
+REG32(VERSAL2_RST_CAN2, 0x368)
+    FIELD(VERSAL2_RST_CAN2, RESET, 0, 1)
+REG32(VERSAL2_RST_CAN3, 0x36c)
+    FIELD(VERSAL2_RST_CAN3, RESET, 0, 1)
+REG32(VERSAL2_RST_I3C0, 0x374)
+    FIELD(VERSAL2_RST_I3C0, RESET, 0, 1)
+REG32(VERSAL2_RST_I3C1, 0x378)
+    FIELD(VERSAL2_RST_I3C1, RESET, 0, 1)
+REG32(VERSAL2_RST_I3C2, 0x37c)
+    FIELD(VERSAL2_RST_I3C2, RESET, 0, 1)
+REG32(VERSAL2_RST_I3C3, 0x380)
+    FIELD(VERSAL2_RST_I3C3, RESET, 0, 1)
+REG32(VERSAL2_RST_I3C4, 0x384)
+    FIELD(VERSAL2_RST_I3C4, RESET, 0, 1)
+REG32(VERSAL2_RST_I3C5, 0x388)
+    FIELD(VERSAL2_RST_I3C5, RESET, 0, 1)
+REG32(VERSAL2_RST_I3C6, 0x38c)
+    FIELD(VERSAL2_RST_I3C6, RESET, 0, 1)
+REG32(VERSAL2_RST_I3C7, 0x390)
+    FIELD(VERSAL2_RST_I3C7, RESET, 0, 1)
+REG32(VERSAL2_RST_DBG_LPX, 0x398)
+    FIELD(VERSAL2_RST_DBG_LPX, RESET_HSDP, 1, 1)
+    FIELD(VERSAL2_RST_DBG_LPX, RESET, 0, 1)
+REG32(VERSAL2_RST_GPIO, 0x39c)
+    FIELD(VERSAL2_RST_GPIO, RESET, 0, 1)
+REG32(VERSAL2_RST_TTC, 0x3a0)
+    FIELD(VERSAL2_RST_TTC, TTC7_RESET, 7, 1)
+    FIELD(VERSAL2_RST_TTC, TTC6_RESET, 6, 1)
+    FIELD(VERSAL2_RST_TTC, TTC5_RESET, 5, 1)
+    FIELD(VERSAL2_RST_TTC, TTC4_RESET, 4, 1)
+    FIELD(VERSAL2_RST_TTC, TTC3_RESET, 3, 1)
+    FIELD(VERSAL2_RST_TTC, TTC2_RESET, 2, 1)
+    FIELD(VERSAL2_RST_TTC, TTC1_RESET, 1, 1)
+    FIELD(VERSAL2_RST_TTC, TTC0_RESET, 0, 1)
+REG32(VERSAL2_RST_TIMESTAMP, 0x3a4)
+    FIELD(VERSAL2_RST_TIMESTAMP, RESET, 0, 1)
+REG32(VERSAL2_RST_SWDT0, 0x3a8)
+    FIELD(VERSAL2_RST_SWDT0, RESET, 0, 1)
+REG32(VERSAL2_RST_SWDT1, 0x3ac)
+    FIELD(VERSAL2_RST_SWDT1, RESET, 0, 1)
+REG32(VERSAL2_RST_SWDT2, 0x3b0)
+    FIELD(VERSAL2_RST_SWDT2, RESET, 0, 1)
+REG32(VERSAL2_RST_SWDT3, 0x3b4)
+    FIELD(VERSAL2_RST_SWDT3, RESET, 0, 1)
+REG32(VERSAL2_RST_SWDT4, 0x3b8)
+    FIELD(VERSAL2_RST_SWDT4, RESET, 0, 1)
+REG32(VERSAL2_RST_IPI, 0x3bc)
+    FIELD(VERSAL2_RST_IPI, RESET, 0, 1)
+REG32(VERSAL2_RST_SYSMON, 0x3c0)
+    FIELD(VERSAL2_RST_SYSMON, CFG_RST, 0, 1)
+REG32(VERSAL2_ASU_MB_RST_MODE, 0x3c4)
+    FIELD(VERSAL2_ASU_MB_RST_MODE, WAKEUP, 2, 1)
+    FIELD(VERSAL2_ASU_MB_RST_MODE, RST_MODE, 0, 2)
+REG32(VERSAL2_FPX_TOPSW_MUX_CTRL, 0x3c8)
+    FIELD(VERSAL2_FPX_TOPSW_MUX_CTRL, SELECT, 0, 1)
+REG32(VERSAL2_RST_FPX, 0x3d0)
+    FIELD(VERSAL2_RST_FPX, SRST, 1, 1)
+    FIELD(VERSAL2_RST_FPX, POR, 0, 1)
+REG32(VERSAL2_RST_MMI, 0x3d4)
+    FIELD(VERSAL2_RST_MMI, POR, 0, 1)
+REG32(VERSAL2_RST_OCM, 0x3d8)
+    FIELD(VERSAL2_RST_OCM, RESET_OCM3, 3, 1)
+    FIELD(VERSAL2_RST_OCM, RESET_OCM2, 2, 1)
+    FIELD(VERSAL2_RST_OCM, RESET_OCM1, 1, 1)
+    FIELD(VERSAL2_RST_OCM, RESET_OCM0, 0, 1)
+
+#define VERSAL2_CRL_R_MAX (R_VERSAL2_RST_OCM + 1)
+
 struct XlnxVersalCRLBase {
     SysBusDevice parent_obj;
 
     RegisterInfoArray *reg_array;
     uint32_t *regs;
@@ -247,15 +557,34 @@ struct XlnxVersalCRL {
 
     uint32_t regs[CRL_R_MAX];
     RegisterInfo regs_info[CRL_R_MAX];
 };
 
+struct XlnxVersal2CRL {
+    XlnxVersalCRLBase parent_obj;
+
+    struct {
+        DeviceState *rpu[10];
+        DeviceState *adma[8];
+        DeviceState *sdma[8];
+        DeviceState *uart[2];
+        DeviceState *gem[2];
+        DeviceState *usb[2];
+        DeviceState *can[4];
+    } cfg;
+
+    RegisterInfo regs_info[VERSAL2_CRL_R_MAX];
+    uint32_t regs[VERSAL2_CRL_R_MAX];
+};
+
 static inline const char *xlnx_versal_crl_class_name(VersalVersion ver)
 {
     switch (ver) {
     case VERSAL_VER_VERSAL:
         return TYPE_XLNX_VERSAL_CRL;
+    case VERSAL_VER_VERSAL2:
+        return TYPE_XLNX_VERSAL2_CRL;
     default:
         g_assert_not_reached();
     }
 }
 
diff --git a/hw/misc/xlnx-versal-crl.c b/hw/misc/xlnx-versal-crl.c
index 6225a92e0bd..10e6af002ba 100644
--- a/hw/misc/xlnx-versal-crl.c
+++ b/hw/misc/xlnx-versal-crl.c
@@ -81,10 +81,55 @@ static DeviceState **versal_decode_periph_rst(XlnxVersalCRLBase *s,
         return xvc->cfg.gem + idx;
 
     case A_RST_USB0:
         return xvc->cfg.usb;
 
+    default:
+        /* invalid or unimplemented */
+        g_assert_not_reached();
+    }
+}
+
+static DeviceState **versal2_decode_periph_rst(XlnxVersalCRLBase *s,
+                                               hwaddr addr, size_t *count)
+{
+    size_t idx;
+    XlnxVersal2CRL *xvc = XLNX_VERSAL2_CRL(s);
+
+    *count = 1;
+
+    switch (addr) {
+    case A_VERSAL2_RST_RPU_A ... A_VERSAL2_RST_RPU_E:
+        idx = (addr - A_VERSAL2_RST_RPU_A) / sizeof(uint32_t);
+        idx *= 2; /* two RPUs per RST_RPU_x registers */
+        return xvc->cfg.rpu + idx;
+
+    case A_VERSAL2_RST_ADMA:
+        /* A single register fans out to all DMA reset inputs */
+        *count = ARRAY_SIZE(xvc->cfg.adma);
+        return xvc->cfg.adma;
+
+    case A_VERSAL2_RST_SDMA:
+        *count = ARRAY_SIZE(xvc->cfg.sdma);
+        return xvc->cfg.sdma;
+
+    case A_VERSAL2_RST_UART0 ... A_VERSAL2_RST_UART1:
+        idx = (addr - A_VERSAL2_RST_UART0) / sizeof(uint32_t);
+        return xvc->cfg.uart + idx;
+
+    case A_VERSAL2_RST_GEM0 ... A_VERSAL2_RST_GEM1:
+        idx = (addr - A_VERSAL2_RST_GEM0) / sizeof(uint32_t);
+        return xvc->cfg.gem + idx;
+
+    case A_VERSAL2_RST_USB0 ... A_VERSAL2_RST_USB1:
+        idx = (addr - A_VERSAL2_RST_USB0) / sizeof(uint32_t);
+        return xvc->cfg.usb + idx;
+
+    case A_VERSAL2_RST_CAN0 ... A_VERSAL2_RST_CAN3:
+        idx = (addr - A_VERSAL2_RST_CAN0) / sizeof(uint32_t);
+        return xvc->cfg.can + idx;
+
     default:
         /* invalid or unimplemented */
         return NULL;
     }
 }
@@ -305,20 +350,270 @@ static const RegisterAccessInfo crl_regs_info[] = {
         .reset = 0x1,
         .rsvd = 0xf8,
     }
 };
 
+static const RegisterAccessInfo versal2_crl_regs_info[] = {
+    {   .name = "ERR_CTRL",  .addr = A_VERSAL2_ERR_CTRL,
+        .reset = 0x1,
+    },{ .name = "WPROT",  .addr = A_VERSAL2_WPROT,
+    },{ .name = "RPLL_CTRL",  .addr = A_VERSAL2_RPLL_CTRL,
+        .reset = 0x24809,
+        .rsvd = 0xf88c00f6,
+    },{ .name = "RPLL_CFG",  .addr = A_VERSAL2_RPLL_CFG,
+        .reset = 0x7e5dcc6c,
+        .rsvd = 0x1801210,
+    },{ .name = "FLXPLL_CTRL",  .addr = A_VERSAL2_FLXPLL_CTRL,
+        .reset = 0x24809,
+        .rsvd = 0xf88c00f6,
+    },{ .name = "FLXPLL_CFG",  .addr = A_VERSAL2_FLXPLL_CFG,
+        .reset = 0x7e5dcc6c,
+        .rsvd = 0x1801210,
+    },{ .name = "PLL_STATUS",  .addr = A_VERSAL2_PLL_STATUS,
+        .reset = 0xf,
+        .rsvd = 0xf0,
+        .ro = 0xf,
+    },{ .name = "RPLL_TO_XPD_CTRL",  .addr = A_VERSAL2_RPLL_TO_XPD_CTRL,
+        .reset = 0x2000100,
+        .rsvd = 0xfdfc00ff,
+    },{ .name = "LPX_TOP_SWITCH_CTRL",  .addr = A_VERSAL2_LPX_TOP_SWITCH_CTRL,
+        .reset = 0xe000300,
+        .rsvd = 0xf1fc00f8,
+    },{ .name = "LPX_LSBUS_CLK_CTRL",  .addr = A_VERSAL2_LPX_LSBUS_CLK_CTRL,
+        .reset = 0x2000800,
+        .rsvd = 0xfdfc00f8,
+    },{ .name = "RPU_CLK_CTRL",  .addr = A_VERSAL2_RPU_CLK_CTRL,
+        .reset = 0x3f00300,
+        .rsvd = 0xfc0c00f8,
+    },{ .name = "OCM_CLK_CTRL",  .addr = A_VERSAL2_OCM_CLK_CTRL,
+        .reset = 0x1e00000,
+        .rsvd = 0xfe1fffff,
+    },{ .name = "IOU_SWITCH_CLK_CTRL",  .addr = A_VERSAL2_IOU_SWITCH_CLK_CTRL,
+        .reset = 0x2000500,
+        .rsvd = 0xfdfc00f8,
+    },{ .name = "GEM0_REF_CTRL",  .addr = A_VERSAL2_GEM0_REF_CTRL,
+        .reset = 0xe000a00,
+        .rsvd = 0xf1fc00f8,
+    },{ .name = "GEM1_REF_CTRL",  .addr = A_VERSAL2_GEM1_REF_CTRL,
+        .reset = 0xe000a00,
+        .rsvd = 0xf1fc00f8,
+    },{ .name = "GEM_TSU_REF_CLK_CTRL",  .addr = A_VERSAL2_GEM_TSU_REF_CLK_CTRL,
+        .reset = 0x300,
+        .rsvd = 0xfdfc00f8,
+    },{ .name = "USB0_BUS_REF_CLK_CTRL",
+        .addr = A_VERSAL2_USB0_BUS_REF_CLK_CTRL,
+        .reset = 0x2001900,
+        .rsvd = 0xfdfc00f8,
+    },{ .name = "USB1_BUS_REF_CLK_CTRL",
+        .addr = A_VERSAL2_USB1_BUS_REF_CLK_CTRL,
+        .reset = 0x2001900,
+        .rsvd = 0xfdfc00f8,
+    },{ .name = "UART0_REF_CLK_CTRL",  .addr = A_VERSAL2_UART0_REF_CLK_CTRL,
+        .reset = 0xc00,
+        .rsvd = 0xfdfc00f8,
+    },{ .name = "UART1_REF_CLK_CTRL",  .addr = A_VERSAL2_UART1_REF_CLK_CTRL,
+        .reset = 0xc00,
+        .rsvd = 0xfdfc00f8,
+    },{ .name = "SPI0_REF_CLK_CTRL",  .addr = A_VERSAL2_SPI0_REF_CLK_CTRL,
+        .reset = 0x600,
+        .rsvd = 0xfdfc00f8,
+    },{ .name = "SPI1_REF_CLK_CTRL",  .addr = A_VERSAL2_SPI1_REF_CLK_CTRL,
+        .reset = 0x600,
+        .rsvd = 0xfdfc00f8,
+    },{ .name = "CAN0_REF_2X_CTRL",  .addr = A_VERSAL2_CAN0_REF_2X_CTRL,
+        .reset = 0xc00,
+        .rsvd = 0xfdfc00f8,
+    },{ .name = "CAN1_REF_2X_CTRL",  .addr = A_VERSAL2_CAN1_REF_2X_CTRL,
+        .reset = 0xc00,
+        .rsvd = 0xfdfc00f8,
+    },{ .name = "CAN2_REF_2X_CTRL",  .addr = A_VERSAL2_CAN2_REF_2X_CTRL,
+        .reset = 0xc00,
+        .rsvd = 0xfdfc00f8,
+    },{ .name = "CAN3_REF_2X_CTRL",  .addr = A_VERSAL2_CAN3_REF_2X_CTRL,
+        .reset = 0xc00,
+        .rsvd = 0xfdfc00f8,
+    },{ .name = "I3C0_REF_CTRL",  .addr = A_VERSAL2_I3C0_REF_CTRL,
+        .reset = 0x2000c00,
+        .rsvd = 0xfdfc00f8,
+    },{ .name = "I3C1_REF_CTRL",  .addr = A_VERSAL2_I3C1_REF_CTRL,
+        .reset = 0x2000c00,
+        .rsvd = 0xfdfc00f8,
+    },{ .name = "I3C2_REF_CTRL",  .addr = A_VERSAL2_I3C2_REF_CTRL,
+        .reset = 0x2000c00,
+        .rsvd = 0xfdfc00f8,
+    },{ .name = "I3C3_REF_CTRL",  .addr = A_VERSAL2_I3C3_REF_CTRL,
+        .reset = 0x2000c00,
+        .rsvd = 0xfdfc00f8,
+    },{ .name = "I3C4_REF_CTRL",  .addr = A_VERSAL2_I3C4_REF_CTRL,
+        .reset = 0x2000c00,
+        .rsvd = 0xfdfc00f8,
+    },{ .name = "I3C5_REF_CTRL",  .addr = A_VERSAL2_I3C5_REF_CTRL,
+        .reset = 0x2000c00,
+        .rsvd = 0xfdfc00f8,
+    },{ .name = "I3C6_REF_CTRL",  .addr = A_VERSAL2_I3C6_REF_CTRL,
+        .reset = 0x2000c00,
+        .rsvd = 0xfdfc00f8,
+    },{ .name = "I3C7_REF_CTRL",  .addr = A_VERSAL2_I3C7_REF_CTRL,
+        .reset = 0x2000c00,
+        .rsvd = 0xfdfc00f8,
+    },{ .name = "DBG_LPX_CTRL",  .addr = A_VERSAL2_DBG_LPX_CTRL,
+        .reset = 0x300,
+        .rsvd = 0xfdfc00f8,
+    },{ .name = "TIMESTAMP_REF_CTRL",  .addr = A_VERSAL2_TIMESTAMP_REF_CTRL,
+        .reset = 0x2000c00,
+        .rsvd = 0xfdfc00f8,
+    },{ .name = "SAFETY_CHK",  .addr = A_VERSAL2_SAFETY_CHK,
+    },{ .name = "ASU_CLK_CTRL",  .addr = A_VERSAL2_ASU_CLK_CTRL,
+        .reset = 0x2000f04,
+        .rsvd = 0xfdfc00f8,
+    },{ .name = "DBG_TSTMP_CLK_CTRL",  .addr = A_VERSAL2_DBG_TSTMP_CLK_CTRL,
+        .reset = 0x300,
+        .rsvd = 0xfdfc00f8,
+    },{ .name = "MMI_TOPSW_CLK_CTRL",  .addr = A_VERSAL2_MMI_TOPSW_CLK_CTRL,
+        .reset = 0x2000300,
+        .rsvd = 0xfdfc00f8,
+    },{ .name = "WWDT_PLL_CLK_CTRL",  .addr = A_VERSAL2_WWDT_PLL_CLK_CTRL,
+        .reset = 0xc00,
+        .rsvd = 0xfffc00f8,
+    },{ .name = "RCLK_CTRL",  .addr = A_VERSAL2_RCLK_CTRL,
+        .rsvd = 0xc040,
+    },{ .name = "RST_RPU_A",  .addr = A_VERSAL2_RST_RPU_A,
+        .reset = 0x10303,
+        .rsvd = 0xfffefcfc,
+        .pre_write = crl_rst_cpu_prew,
+    },{ .name = "RST_RPU_B",  .addr = A_VERSAL2_RST_RPU_B,
+        .reset = 0x10303,
+        .rsvd = 0xfffefcfc,
+        .pre_write = crl_rst_cpu_prew,
+    },{ .name = "RST_RPU_C",  .addr = A_VERSAL2_RST_RPU_C,
+        .reset = 0x10303,
+        .rsvd = 0xfffefcfc,
+        .pre_write = crl_rst_cpu_prew,
+    },{ .name = "RST_RPU_D",  .addr = A_VERSAL2_RST_RPU_D,
+        .reset = 0x10303,
+        .rsvd = 0xfffefcfc,
+        .pre_write = crl_rst_cpu_prew,
+    },{ .name = "RST_RPU_E",  .addr = A_VERSAL2_RST_RPU_E,
+        .reset = 0x10303,
+        .rsvd = 0xfffefcfc,
+        .pre_write = crl_rst_cpu_prew,
+    },{ .name = "RST_RPU_GD_0",  .addr = A_VERSAL2_RST_RPU_GD_0,
+        .reset = 0x3,
+    },{ .name = "RST_RPU_GD_1",  .addr = A_VERSAL2_RST_RPU_GD_1,
+        .reset = 0x3,
+    },{ .name = "RST_ASU_GD",  .addr = A_VERSAL2_RST_ASU_GD,
+        .reset = 0x3,
+    },{ .name = "RST_ADMA",  .addr = A_VERSAL2_RST_ADMA,
+        .reset = 0x1,
+        .pre_write = crl_rst_dev_prew,
+    },{ .name = "RST_SDMA",  .addr = A_VERSAL2_RST_SDMA,
+        .pre_write = crl_rst_dev_prew,
+        .reset = 0x1,
+    },{ .name = "RST_GEM0",  .addr = A_VERSAL2_RST_GEM0,
+        .reset = 0x1,
+        .pre_write = crl_rst_dev_prew,
+    },{ .name = "RST_GEM1",  .addr = A_VERSAL2_RST_GEM1,
+        .reset = 0x1,
+        .pre_write = crl_rst_dev_prew,
+    },{ .name = "RST_USB0",  .addr = A_VERSAL2_RST_USB0,
+        .reset = 0x1,
+        .pre_write = crl_rst_dev_prew,
+    },{ .name = "RST_USB1",  .addr = A_VERSAL2_RST_USB1,
+        .reset = 0x1,
+        .pre_write = crl_rst_dev_prew,
+    },{ .name = "RST_UART0",  .addr = A_VERSAL2_RST_UART0,
+        .reset = 0x1,
+        .pre_write = crl_rst_dev_prew,
+    },{ .name = "RST_UART1",  .addr = A_VERSAL2_RST_UART1,
+        .reset = 0x1,
+        .pre_write = crl_rst_dev_prew,
+    },{ .name = "RST_SPI0",  .addr = A_VERSAL2_RST_SPI0,
+        .reset = 0x1,
+    },{ .name = "RST_SPI1",  .addr = A_VERSAL2_RST_SPI1,
+        .reset = 0x1,
+    },{ .name = "RST_CAN0",  .addr = A_VERSAL2_RST_CAN0,
+        .reset = 0x1,
+        .pre_write = crl_rst_dev_prew,
+    },{ .name = "RST_CAN1",  .addr = A_VERSAL2_RST_CAN1,
+        .reset = 0x1,
+        .pre_write = crl_rst_dev_prew,
+    },{ .name = "RST_CAN2",  .addr = A_VERSAL2_RST_CAN2,
+        .reset = 0x1,
+        .pre_write = crl_rst_dev_prew,
+    },{ .name = "RST_CAN3",  .addr = A_VERSAL2_RST_CAN3,
+        .reset = 0x1,
+        .pre_write = crl_rst_dev_prew,
+    },{ .name = "RST_I3C0",  .addr = A_VERSAL2_RST_I3C0,
+        .reset = 0x1,
+    },{ .name = "RST_I3C1",  .addr = A_VERSAL2_RST_I3C1,
+        .reset = 0x1,
+    },{ .name = "RST_I3C2",  .addr = A_VERSAL2_RST_I3C2,
+        .reset = 0x1,
+    },{ .name = "RST_I3C3",  .addr = A_VERSAL2_RST_I3C3,
+        .reset = 0x1,
+    },{ .name = "RST_I3C4",  .addr = A_VERSAL2_RST_I3C4,
+        .reset = 0x1,
+    },{ .name = "RST_I3C5",  .addr = A_VERSAL2_RST_I3C5,
+        .reset = 0x1,
+    },{ .name = "RST_I3C6",  .addr = A_VERSAL2_RST_I3C6,
+        .reset = 0x1,
+    },{ .name = "RST_I3C7",  .addr = A_VERSAL2_RST_I3C7,
+        .reset = 0x1,
+    },{ .name = "RST_DBG_LPX",  .addr = A_VERSAL2_RST_DBG_LPX,
+        .reset = 0x3,
+        .rsvd = 0xfc,
+    },{ .name = "RST_GPIO",  .addr = A_VERSAL2_RST_GPIO,
+        .reset = 0x1,
+    },{ .name = "RST_TTC",  .addr = A_VERSAL2_RST_TTC,
+        .reset = 0xff,
+    },{ .name = "RST_TIMESTAMP",  .addr = A_VERSAL2_RST_TIMESTAMP,
+        .reset = 0x1,
+    },{ .name = "RST_SWDT0",  .addr = A_VERSAL2_RST_SWDT0,
+        .reset = 0x1,
+    },{ .name = "RST_SWDT1",  .addr = A_VERSAL2_RST_SWDT1,
+        .reset = 0x1,
+    },{ .name = "RST_SWDT2",  .addr = A_VERSAL2_RST_SWDT2,
+        .reset = 0x1,
+    },{ .name = "RST_SWDT3",  .addr = A_VERSAL2_RST_SWDT3,
+        .reset = 0x1,
+    },{ .name = "RST_SWDT4",  .addr = A_VERSAL2_RST_SWDT4,
+        .reset = 0x1,
+    },{ .name = "RST_IPI",  .addr = A_VERSAL2_RST_IPI,
+    },{ .name = "RST_SYSMON",  .addr = A_VERSAL2_RST_SYSMON,
+    },{ .name = "ASU_MB_RST_MODE",  .addr = A_VERSAL2_ASU_MB_RST_MODE,
+        .reset = 0x1,
+        .rsvd = 0xf8,
+    },{ .name = "FPX_TOPSW_MUX_CTRL",  .addr = A_VERSAL2_FPX_TOPSW_MUX_CTRL,
+        .reset = 0x1,
+    },{ .name = "RST_FPX",  .addr = A_VERSAL2_RST_FPX,
+        .reset = 0x3,
+    },{ .name = "RST_MMI",  .addr = A_VERSAL2_RST_MMI,
+        .reset = 0x1,
+    },{ .name = "RST_OCM",  .addr = A_VERSAL2_RST_OCM,
+    }
+};
+
 static void versal_crl_reset_enter(Object *obj, ResetType type)
 {
     XlnxVersalCRL *s = XLNX_VERSAL_CRL(obj);
     unsigned int i;
 
     for (i = 0; i < ARRAY_SIZE(s->regs_info); ++i) {
         register_reset(&s->regs_info[i]);
     }
 }
 
+static void versal2_crl_reset_enter(Object *obj, ResetType type)
+{
+    XlnxVersal2CRL *s = XLNX_VERSAL2_CRL(obj);
+    size_t i;
+
+    for (i = 0; i < VERSAL2_CRL_R_MAX; ++i) {
+        register_reset(&s->regs_info[i]);
+    }
+}
+
 static void versal_crl_reset_hold(Object *obj, ResetType type)
 {
     XlnxVersalCRL *s = XLNX_VERSAL_CRL(obj);
 
     crl_update_irq(s);
@@ -386,10 +681,77 @@ static void versal_crl_init(Object *obj)
                                  qdev_prop_allow_set_link_before_realize,
                                  OBJ_PROP_LINK_STRONG);
     }
 }
 
+static void versal2_crl_init(Object *obj)
+{
+    XlnxVersal2CRL *s = XLNX_VERSAL2_CRL(obj);
+    XlnxVersalCRLBase *xvcb = XLNX_VERSAL_CRL_BASE(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    size_t i;
+
+    xvcb->reg_array = register_init_block32(DEVICE(obj), versal2_crl_regs_info,
+                                            ARRAY_SIZE(versal2_crl_regs_info),
+                                            s->regs_info, s->regs,
+                                            &crl_ops,
+                                            XLNX_VERSAL_CRL_ERR_DEBUG,
+                                            VERSAL2_CRL_R_MAX * 4);
+    xvcb->regs = s->regs;
+
+    sysbus_init_mmio(sbd, &xvcb->reg_array->mem);
+
+    for (i = 0; i < ARRAY_SIZE(s->cfg.rpu); ++i) {
+        object_property_add_link(obj, "rpu[*]", TYPE_ARM_CPU,
+                                 (Object **)&s->cfg.rpu[i],
+                                 qdev_prop_allow_set_link_before_realize,
+                                 OBJ_PROP_LINK_STRONG);
+    }
+
+    for (i = 0; i < ARRAY_SIZE(s->cfg.adma); ++i) {
+        object_property_add_link(obj, "adma[*]", TYPE_DEVICE,
+                                 (Object **)&s->cfg.adma[i],
+                                 qdev_prop_allow_set_link_before_realize,
+                                 OBJ_PROP_LINK_STRONG);
+    }
+
+    for (i = 0; i < ARRAY_SIZE(s->cfg.sdma); ++i) {
+        object_property_add_link(obj, "sdma[*]", TYPE_DEVICE,
+                                 (Object **)&s->cfg.sdma[i],
+                                 qdev_prop_allow_set_link_before_realize,
+                                 OBJ_PROP_LINK_STRONG);
+    }
+
+    for (i = 0; i < ARRAY_SIZE(s->cfg.uart); ++i) {
+        object_property_add_link(obj, "uart[*]", TYPE_DEVICE,
+                                 (Object **)&s->cfg.uart[i],
+                                 qdev_prop_allow_set_link_before_realize,
+                                 OBJ_PROP_LINK_STRONG);
+    }
+
+    for (i = 0; i < ARRAY_SIZE(s->cfg.gem); ++i) {
+        object_property_add_link(obj, "gem[*]", TYPE_DEVICE,
+                                 (Object **)&s->cfg.gem[i],
+                                 qdev_prop_allow_set_link_before_realize,
+                                 OBJ_PROP_LINK_STRONG);
+    }
+
+    for (i = 0; i < ARRAY_SIZE(s->cfg.usb); ++i) {
+        object_property_add_link(obj, "usb[*]", TYPE_DEVICE,
+                                 (Object **)&s->cfg.usb[i],
+                                 qdev_prop_allow_set_link_before_realize,
+                                 OBJ_PROP_LINK_STRONG);
+    }
+
+    for (i = 0; i < ARRAY_SIZE(s->cfg.can); ++i) {
+        object_property_add_link(obj, "can[*]", TYPE_DEVICE,
+                                 (Object **)&s->cfg.can[i],
+                                 qdev_prop_allow_set_link_before_realize,
+                                 OBJ_PROP_LINK_STRONG);
+    }
+}
+
 static void crl_finalize(Object *obj)
 {
     XlnxVersalCRLBase *s = XLNX_VERSAL_CRL_BASE(obj);
     register_finalize_block(s->reg_array);
 }
@@ -402,10 +764,20 @@ static const VMStateDescription vmstate_versal_crl = {
         VMSTATE_UINT32_ARRAY(regs, XlnxVersalCRL, CRL_R_MAX),
         VMSTATE_END_OF_LIST(),
     }
 };
 
+static const VMStateDescription vmstate_versal2_crl = {
+    .name = TYPE_XLNX_VERSAL2_CRL,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, XlnxVersal2CRL, VERSAL2_CRL_R_MAX),
+        VMSTATE_END_OF_LIST(),
+    }
+};
+
 static void versal_crl_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     XlnxVersalCRLBaseClass *xvcc = XLNX_VERSAL_CRL_BASE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
@@ -414,10 +786,21 @@ static void versal_crl_class_init(ObjectClass *klass, const void *data)
     rc->phases.enter = versal_crl_reset_enter;
     rc->phases.hold = versal_crl_reset_hold;
     xvcc->decode_periph_rst = versal_decode_periph_rst;
 }
 
+static void versal2_crl_class_init(ObjectClass *klass, const void *data)
+{
+    XlnxVersalCRLBaseClass *xvcc = XLNX_VERSAL_CRL_BASE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->vmsd = &vmstate_versal2_crl;
+    rc->phases.enter = versal2_crl_reset_enter;
+    xvcc->decode_periph_rst = versal2_decode_periph_rst;
+}
+
 static const TypeInfo crl_base_info = {
     .name          = TYPE_XLNX_VERSAL_CRL_BASE,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(XlnxVersalCRLBase),
     .class_size    = sizeof(XlnxVersalCRLBaseClass),
@@ -431,12 +814,21 @@ static const TypeInfo versal_crl_info = {
     .instance_size = sizeof(XlnxVersalCRL),
     .instance_init = versal_crl_init,
     .class_init    = versal_crl_class_init,
 };
 
+static const TypeInfo versal2_crl_info = {
+    .name          = TYPE_XLNX_VERSAL2_CRL,
+    .parent        = TYPE_XLNX_VERSAL_CRL_BASE,
+    .instance_size = sizeof(XlnxVersal2CRL),
+    .instance_init = versal2_crl_init,
+    .class_init    = versal2_crl_class_init,
+};
+
 static void crl_register_types(void)
 {
     type_register_static(&crl_base_info);
     type_register_static(&versal_crl_info);
+    type_register_static(&versal2_crl_info);
 }
 
 type_init(crl_register_types)
-- 
2.50.1


