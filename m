Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C81CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 07:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4DqL-0004XZ-L9; Thu, 02 Oct 2025 03:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v4DqJ-0004Ud-Ru; Thu, 02 Oct 2025 03:35:12 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v4Dq7-0008HY-PQ; Thu, 02 Oct 2025 03:35:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FaAhdJr9vSqUla3ybraVYIo87bM0TJyhGrFH+egdYkyobFzVChLGznsXOrgULbCCbVIy0xuIrOn3TCgBgjRbTNj/Cc/jwMF4A76U3mnjy4ZYxqqk0odXDaxCnanVvIE1IOmdbPJ/XDWmWl/cNRGdowPXAKQco9pI27wLdPTvlNAcrY3Ckzd9rXZ7Rv2nJ/aLincrtLo1QsSKA2P6j60uZNzYLyfZDX/kPobwjAw7nE30i4yhEWCF3vNsrFNcqpm0HiJ0TFBg9qjAsuScHB1uEeaREJrHjGdflD+onnvd43eqblFYYMngDp8/6ksgRtglP+ZQ9UNB6W7+PYzknmi60Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXbTPcsldJxYkVTTEZVZKQMUnB6EPCV/K0UMzHx550w=;
 b=lLdzqRWXWz0ByGsfMfcU8QAb5ANVadNzc67ZhLv6mTu2V1ml2M+8g0KIkvunUkilYFX0Z9sgv2KuL+xnQekaRq+8y12AbONnrjmnBB5PdUKDWY4kw5QV9welRit5EMdUq3oPfkw2ANwKaLCEnTpL1dVnSqL2JTVOH+N6lpv8m6gfkiU0F+P58m7mOjiTwOZXcABXt9JCIS/+DjxrOeQ9a27PFUGHpPAozgvZKKlEytHTrHCTFo86KJDtMDhJdI/cGtrLutEUe3i3MK/Zwoj/84Z+y7P/qlhvXRYtx/WX4Q8R0bRoVPQTiZFBKqav9hL6rxYyMyPc1+67GT44n0pg0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXbTPcsldJxYkVTTEZVZKQMUnB6EPCV/K0UMzHx550w=;
 b=OLaGS4YfGdLkmPCS9Gzg1yK0Fi3eVtVZuibZaDqPHLkWaSACrqC0Fa0F8gycUty0QAHMBN91LY+e85xYuTLE30Lp3cndXBrzPTX0fqCATI8GNv6vMO7mFINJzdl1ILMOg8mxA3CLs5vqhBip87dYwdKiu2Dbit604XW6595iy2Y=
Received: from MW4PR03CA0080.namprd03.prod.outlook.com (2603:10b6:303:b6::25)
 by SA3PR12MB7950.namprd12.prod.outlook.com (2603:10b6:806:31c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Thu, 2 Oct
 2025 07:34:42 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:303:b6:cafe::9f) by MW4PR03CA0080.outlook.office365.com
 (2603:10b6:303:b6::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.16 via Frontend Transport; Thu,
 2 Oct 2025 07:34:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Thu, 2 Oct 2025 07:34:41 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 2 Oct
 2025 00:34:41 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 Oct
 2025 02:34:40 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Thu, 2 Oct 2025 00:34:39 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Vikram
 Garhwal" <vikram.garhwal@bytedance.com>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: [PATCH v2 5/7] hw/net/can/xlnx-versal-canfd: remove unused include
 directives
Date: Thu, 2 Oct 2025 09:34:14 +0200
Message-ID: <20251002073418.109375-6-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002073418.109375-1-luc.michel@amd.com>
References: <20251002073418.109375-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|SA3PR12MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: 57b44f71-f833-4e2b-e867-08de018626a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sHdlxME7XJgH5W/GokBTTZVb6u2If9hzFUcBNmqD2UbOCzaZJZ2PqGO/1/yl?=
 =?us-ascii?Q?LGybxbUcXgvuTKqgLiF+pM+khLmgcoorGBTRtxbS0O4Yr1CGNT0EFUEKsXkY?=
 =?us-ascii?Q?b98K/R8SLWp06+3dSCkPm8KMAMfTRN2l5x1am5di8RB6/Ht9iAK2pUqQiwhg?=
 =?us-ascii?Q?pvbkdnsF5fW7nShxKAMqGxW4SY5upAuf1+V82q6WqTcw/fDGeBQhxDOgFIcH?=
 =?us-ascii?Q?ajEgIHFUgaUjQ9DyS/CF2jDFSZRM7e1xwhc8vK6LV6prFeppIyiJSwu92MkA?=
 =?us-ascii?Q?puvCwyZ4den+M9h7Cvvf8XCLRadNgkMFI8AaJ/FwhpVANIUy5Q27kERJeIwo?=
 =?us-ascii?Q?14n8jSIiL0QtaDDXGsyBVsRliNqayhjU9TRqTNOMmaX/6KjxZD2kwV+kFum6?=
 =?us-ascii?Q?wM659jhv2KztAA4ZiDn1KdRcSoKzHZ90JUBUOv9ONfcSX8CFcTKi1xykhbdB?=
 =?us-ascii?Q?VbNyFcvMif1/w1d42fjnoIoSHqxO2EBHBXdWBE/PsIgvpfIrreUHNkgWtElG?=
 =?us-ascii?Q?QIRVmVqZTD3zavoGdG98x0354ZAi+K6HnF1wOqjG3Ai6dG36bj4YMJFjvM7a?=
 =?us-ascii?Q?wHIR64KNpd21i7EiLKTaBNAQHYoL/JR3z29hhjb1taKa6gg8piTnKBDZ45qj?=
 =?us-ascii?Q?iHAwi9I4JQ5fEK+cpmzZZECIzOaprwi82FoqbVg5AMqaEUXgc/0K/nWRjK7n?=
 =?us-ascii?Q?vRKqtpnpsX+s0pYcMsaYR2xY9296vpS3VH7ctqnYluI0eSmIZAmap4hUy5su?=
 =?us-ascii?Q?lbn44pVMrvanx+/dr6/pEIezi2V+xPugABK1Jxv+FTJ2sXXV6fScJWhoaz7z?=
 =?us-ascii?Q?L5jmUnHb5ywX+8N4HYHXCJA8UasKPr7c7JiLYwg6GsyRE+lmPPsmnkoBr6ov?=
 =?us-ascii?Q?ZPZunugCxhNtmO8UZuDfpArZrMgROns5LIHftGFAvxkV44N5VYu66anMxto2?=
 =?us-ascii?Q?M7APEGQ5tD8iUVP4iJDeuRWBjd5qh49sGpwblUuU6gbwvMiSS68rL/n97umE?=
 =?us-ascii?Q?POGbnFNlOIyaEhVe9Jl7ffGLL3D1HLnBqzBZjJEoavrlWxman2BG+oGd4SW3?=
 =?us-ascii?Q?GgLsgjhQkrn5y1dJx39as0n6Z3MQMlwFS8GTLNpC6Ur2Rz20Rpsq3jZ8Tlkp?=
 =?us-ascii?Q?ofj90ON1WXQV2EXSGFHaaA8yVRwbIgPFXyE2d7g1MHXzjbzwI5Q77yA0Z34H?=
 =?us-ascii?Q?fLKfcpMgxq49P70ZQqIIvhmjWHkETLrE9m0Pn1gTvsTQXdDKr+9D/hxctmfk?=
 =?us-ascii?Q?ZhaQtwZfliIsHOtfy0nK7JaNbOwnfGTGfbs2N4IadNVbiiTWsC+gtHnPayW6?=
 =?us-ascii?Q?RccE2yKTXenXm2ISPh6HAiq02Qj+8BaP0JVwnagJQnGY7uR0j9kdAmvpFSTE?=
 =?us-ascii?Q?xuTebyKSeCn9YJkoz5YuI2xWy6BbTCBdbQLtsqZ+J4iaHU6iGldJUV6Z7/tX?=
 =?us-ascii?Q?hv3sWfUbHHFyNp0s24Pp+P78+5rhewSfsb+1VVDNEzsWW/sGn+rZrDWhk1mf?=
 =?us-ascii?Q?IAvINRxgMSVSiuGWOCoh7aJq2jjtIEqp/3jUR8LgN1aJz3iwkW0k7wfxtXbM?=
 =?us-ascii?Q?KoGBfiyxhL+MbA2rzMg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 07:34:41.7649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b44f71-f833-4e2b-e867-08de018626a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7950
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=Luc.Michel@amd.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.518,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001, TVD_SPACE_RATIO=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Drop unecessary include directives in xlnx-versal-canfd.c.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 hw/net/can/xlnx-versal-canfd.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index 3eb111949f8..343348660b5 100644
--- a/hw/net/can/xlnx-versal-canfd.c
+++ b/hw/net/can/xlnx-versal-canfd.c
@@ -33,16 +33,12 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "hw/irq.h"
 #include "hw/register.h"
 #include "qapi/error.h"
-#include "qemu/bitops.h"
 #include "qemu/log.h"
-#include "qemu/cutils.h"
-#include "qemu/event_notifier.h"
 #include "hw/qdev-properties.h"
-#include "qom/object_interfaces.h"
 #include "migration/vmstate.h"
 #include "hw/net/xlnx-versal-canfd.h"
 #include "trace.h"
 
 REG32(SOFTWARE_RESET_REGISTER, 0x0)
-- 
2.51.0


