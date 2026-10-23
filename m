Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352DD606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 20:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKLdf-0000QZ-1w; Fri, 23 Oct 2026 16:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1xKLdB-0008Qf-04
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 16:12:50 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1xKLd9-0006uV-7v
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 16:12:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBe/wqtJpVWDfiDoCAsLjLkWaupSknTqfVOqMr62KbPKJHw6epAQC1dq5TG97pXULGoOhrfXM6wba6+C7pluAoXCl67X01imoVBTjFgIHuDSjCF6xj5IW0GeKDtrO8JqE9hO6ZZFJ9cXaseKaEb19F6GEd4+vc+pvJIBucUhuhHO1Erw1W6RHGZk3d5Uaj7a7g3gugVdEZB3i8JtTVParY4GjiiTKrcpgtE8dyaxztXLbgE29X7MiIoGzcI4IcaraPBit3RzJC+MQ9BZx04Phs/Q32QGSwIhAvuQrCla8QXH4IrLczrnVWMTbYGRSRb65ZU2IXmXQsu3XAJSaBcosg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDvII9zdUJNZpi7RQxUXelr3gVzq4Sc2PM8UwN2UZhU=;
 b=buncZp07cBK2Dpqq6npYLMBCSqfCRUC282Iw0qigy/CBJqe9JbguF6sMi66zcbAQkdIVXvqR/lV1SlEbylE8oRFRECE09XyAbcv06isLRKn/FDtbTMUoIqUb7qwlL0mKSMUJlaKQe9bzy8FtZZ2oFBriLO2bD1FlAr/fSGT9KWv5kB6JDP8ZPi0TKN+qHQvlSrq6fJfrc/yP+atjRfpjgtZXg+qey3MN09S9geMXRVrthPo1DKYbMCXSSh9GDtfpJwo2dsOry9Hh6y6qgtha3ZM/YOV1CBZzkWaa6/RJHAtEy0ZiDFAbEh5A7L8ul6xSChjZYxBz+ANaIf6v5z79vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=linumiz.com; dmarc=pass action=none header.from=linumiz.com;
 dkim=pass header.d=linumiz.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=linumiz.com;
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com (2603:1096:405:3c::9)
 by SE3PR06MB9019.apcprd06.prod.outlook.com (2603:1096:101:31f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.2; Fri, 23 Oct
 2026 20:12:27 +0000
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01]) by TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01%4]) with mapi id 15.21.0569.002; Fri, 23 Oct 2026
 20:12:27 +0000
From: Parthiban Nallathambi <parthiban@linumiz.com>
Date: Sat, 24 Oct 2026 01:42:01 +0530
Subject: [PATCH v2 7/9] hw/tricore: wire peripherals into tc27x SoC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-dev-ifx-tricore-upstream-rebase-minimal-v2-7-c722e4ca5661@linumiz.com>
References: <20261024-dev-ifx-tricore-upstream-rebase-minimal-v2-0-c722e4ca5661@linumiz.com>
In-Reply-To: <20261024-dev-ifx-tricore-upstream-rebase-minimal-v2-0-c722e4ca5661@linumiz.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Saravanan Sekar <saravanan@linumiz.com>, 
 Dineshkumar Selvaraj <Dineshkumar.Selvaraj@infineon.com>, 
 Christoph Seitz <christoph.seitz@infineon.com>, 
 Sivashanmugam Natarajan <Sivashanmugam.Natarajan@infineon.com>, 
 Parthiban Nallathambi <parthiban@linumiz.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792786334; l=4582;
 i=parthiban@linumiz.com; s=20241125; h=from:subject:message-id;
 bh=TIBFm5w0s/Ii2OSltZjgWdBIJdSYEZjeI4s+MmDfjO8=;
 b=KGk66NZRyLZwuIXNi/otofVRNX7P1XwAdTh8OhICAWtHEgYffSJq1lYTpF6fzlZdVZMN5F6ZL
 COjRDNPRwicAcgparytYYG+X+fae/CIy7JfSzRN11Ljf44ecRErM6Ss
X-Developer-Key: i=parthiban@linumiz.com; a=ed25519;
 pk=PrcMZ/nwnHbeXNFUFUS833wF3DAX4hziDHEbBp1eNb8=
X-ClientProxiedBy: MA5P287CA0172.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::16) To TYZPR06MB6935.apcprd06.prod.outlook.com
 (2603:1096:405:3c::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6935:EE_|SE3PR06MB9019:EE_
X-MS-Office365-Filtering-Correlation-Id: f014e375-5055-40ce-cb2e-08df3141f594
X-LD-Processed: 808466aa-232a-41f4-ac23-289e3a6840d4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|23010399003|376014|38350700014|261021123027099003|261009223027099003|261021121427099003|10067099003|22082099003|56012099006|18002099003|261022105027099003|3023799007;
X-Microsoft-Antispam-Message-Info: mQenj1kX6CHJbugn/NLdmOweubNaxIVKZfVMkK/4toFDs1YxBHGPhyww53P5u1dSyf5gkCMB3rMgRPJznfRYCF0Kw7ShLJazo5a5ZI4L9BWIxMRQ3dDMrFtwQrg4rFTVB1DcIkFDX2ol2WBvzfEr2dDwmQQEO7joaLYMEJ7LbRoMshGtUZyl6fMAAMYCDb6mMX7RqGnnOhM205TXdbwj6+EObGFyeHNz7yUtlmd7+omgL5kp4QQpSlwPwBY6KBAPtXjYOi6Q/0KHJyVozNuN92fGFqpzDJmWe9F9fxfsr+q7as6VTu4J4P9Nrcb796gIQmAvH+7Da25uiuim7wH0eaI+o0B5rdq67y1nMJI+rGidzeNRQqJrkgpHVnPgebdkWGe06GhqOwrw1XpZdMpMigCp+6OBCrRtaRMY5nZH4bQ3jNDNwrw84NAzJG2VDMxLEb6dc8FW3OxN99KhjcrHl2Qt5G907mf3TA9+K6BRlI21IhG45Mb7EQJKo1d+ZgsRo28CEcusuIjYZpMQehoc6TZjjLKVmtf6jQTJdkmFUtDkT3xQ3FV504IBUbgQqNFQR1EnYQ6rcMXyTMSyE58Yw32Qa6icoS5nlTYU4leljrRTDEfojh+fFFka00SIK4OifvQF2al8O6Qpz0zqtTZFHwxQT3Oo4JxPav5qUIivFX5jyiWXpli5nw/QSiaiA4ALUZXE7DIcoza0LdunEmqF/7nQwT70ytwYLyozemtOcmU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB6935.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(23010399003)(376014)(38350700014)(261021123027099003)(261009223027099003)(261021121427099003)(10067099003)(22082099003)(56012099006)(18002099003)(261022105027099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlVqdTI4Sy83bFJveEp0M1pmMzFtRi9CWTdFQnFsM3JjMHV3SDBxOE00YTBj?=
 =?utf-8?B?RW9FQnhGQVlYT2pBT0xpWUFlcWh2aEJ1dzFkNWFlaUJoTFhYdEl0dmVpSytQ?=
 =?utf-8?B?Z0FWWmJyUEViVmdzakhWbGlxU2czV2NselFQb1VVbkZxN1BKZWs4TWN4RnJv?=
 =?utf-8?B?SzRMdmtrQWcrY3pKc0JBM1pveXJQN2pxM2ZJMzlKR1lsRWJoaDRyelJQVUFN?=
 =?utf-8?B?eFExQVRhS3NuQWVZdkZGQ2J3bytGVEQ5cXVzNWh4ZVJBQk1JMnJSa3pIcUh6?=
 =?utf-8?B?elV1bDNOR1RTWVdsZnIrSzl0ZGMwU2h2WTM5WVlzNVVQcGdhSSsxSi9xU1hu?=
 =?utf-8?B?SW9RS2EwRHpJdHlEVC9uNjUvMXlIL0tobnZGa2tYWXhBcERLQW1OUnlqbjF5?=
 =?utf-8?B?c21oU2FYNDVXeW0vSjk4RHV6MXhuV1p4TDNIaTMwaHRjNnc5ZEVtQnVrMlRk?=
 =?utf-8?B?ODBHcE9ueUxLVGZBMnk0RHl4NlR6YnFhWTR3K1ZmRUsybE9hSWwzaGhscmtI?=
 =?utf-8?B?UkczNDZYd3VvTGQ2UGZ2K0M2bnFyNXMvenl2V2QySFJQZnNOWm1rSzVQM3JT?=
 =?utf-8?B?QXdDek9UMjRYT1JIODVzYUhoLzVaZ1N2Y3hzWDhPSFQ1YTRzUzZ1WFFUYmhH?=
 =?utf-8?B?dXZwdDRad2wxL0oxL1I2eVAvUVdaWk5wTG1SSEcrdkcrd2Uxb0lycVJnajNi?=
 =?utf-8?B?dzVBK244a0pYaUVsT0dPaFZyZFJib0pxbUZmOUZCOVprWDJKM01iWS9kRjlD?=
 =?utf-8?B?Tis1OW5weHQ5aktZWGdhNkZBYitmY3p5eUJEK0szRVJXelpHZUhPR2tGWHh4?=
 =?utf-8?B?VlNNU3AwWTRPeG5VMkJ3WGgvTlZXZTQzTlU4dkpENkVSRm9RRHFtaVpkVUQ2?=
 =?utf-8?B?TnR3TktuVTYza2syL3o2eW40cjdkWEordVhkdzNqd3B3MWlTYVhjUTVLNnBx?=
 =?utf-8?B?Z1FjRng1aTBid0crWmJVZjAxNFBCbDRPL2w1YmV5eGs0Rm80eDdXM0lxaThF?=
 =?utf-8?B?bG93TnNWN1JOZ1F6TWJraFlwT25vSzVNbUkwQWoxMndLdk9ZeFVkbksvL1oz?=
 =?utf-8?B?K0VsQzBJblE0bEdsYWlVczBaTlFSTUhMdE5GMWFtaUdQaDdsVUdpSURaNWQ3?=
 =?utf-8?B?U2tMbVA0aEo3YVFEMlBOUVpiTCtCaXp2d0xWcUhNL2xxbDZIa1RCYll2alVk?=
 =?utf-8?B?dzhDOTVUVHRtNk1PT0NuMmwxNzVndW1LMXl1QTMvZ2lLcEt2Z3ZxQ2xWS3da?=
 =?utf-8?B?VXVjOTVqaUYyWHNXbW9zdnh4cXlUN1hJQ000ZUp1cGJqRFQzSzVsVTl0ZllJ?=
 =?utf-8?B?RG5uMHQzeFZiWmp2MUlLZjMxVS8xRExESjdDT0E3bW5YdWI5NWFobDVORDl0?=
 =?utf-8?B?aVl0VzA2VG5rMGk1Lys2RDNoQXNNOGplYTFMK1FJeFdGK2NWMUxRTVpsVDRj?=
 =?utf-8?B?UTA4Y2VKRE5lQUtzN1c1cXNzemJYY0dtT2pMMC9jSUFPdHlNZmhuTzlyNHRy?=
 =?utf-8?B?STE1Wm0wMVVtQlQ3Z3hTVXY4aWdVUjZmdy9HQjZSZDVxSzc1dmRkR3FEYUFS?=
 =?utf-8?B?N1RBVXZxYURvVGp6VTZFS0NoZ2F0c3pMbkJnN2FlUmd6bXl3MGdya2EyWlcr?=
 =?utf-8?B?aWxoamlqbElxbU5KN291cUNVVVNVYllINkx2T2NsUGUwYm1QQkprM2Q0QS9X?=
 =?utf-8?B?ZGFrRVI2QzBETFZiRnU5WDZDNUxrN3lJMEsxb1JRUWFnUFRrOXhuNTcrUkda?=
 =?utf-8?B?Q3FnVDQwNm8wTVl5YyttTVhoSkxwaHZPTHVtR25KK3IweXRQdytSSStqbTRa?=
 =?utf-8?B?bzdoam5FQWhzMVdqelV2dVU1YXViK1lmYXJsdmp3NHJhakliRUlkTGdNeUM4?=
 =?utf-8?B?U3RDcUhxSkxpaHFCQlN1Sjh5Tk55dFpzZTlNWVZGSTIwZzJpYnU3b2JxbUVS?=
 =?utf-8?B?czhPRmRRaFVJUi92QnVZNmZDNXpxN2hRUUI3dDA0NDJkOEVLUXM4MmtvbWVD?=
 =?utf-8?B?TXJ4OEVCU1Z6eHFxdWExZHk5dDhWeXNxdHFZYmJhYTdhclNHcndGcjladnRZ?=
 =?utf-8?B?QUJIUkI0NjRFeUIvN3BpTU5SU2J1VEJYY1VjdXFkYUNTQVF1VUcrUlNUWFA3?=
 =?utf-8?B?RXhpM1V1S3RyblpnRFo1UWNncmN6RlBUK2tvL0xKaGgvTDlhVVl0YzBtY0tN?=
 =?utf-8?B?Z1k0UC9LSW40Ry9JWVBBWWVrQTc5VVBjY3B6Y2xHMVNTcnBKUlFsb21MbVJq?=
 =?utf-8?B?TnQyNVQyWGh1RWVycW9LSWVMWE5QWVJ3OFh0MFZkNFNzQUJaVWJud21XZzZt?=
 =?utf-8?B?UC81anlIZ0tCejBFYmQ5NHcwMXpwa2RNUFBnNEN6SnNVN0FkbHozdz09?=
X-OriginatorOrg: linumiz.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f014e375-5055-40ce-cb2e-08df3141f594
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6935.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 20:12:27.3837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 808466aa-232a-41f4-ac23-289e3a6840d4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+Flc0VJKObWTG+MPZJ8JWim4O3pp/vVx5+e7dEnCKVJsgrPtDMMQ+Za967o45kcIcqgWzTwghRxv8xkXHVSDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB9019
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=parthiban@linumiz.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Map STM, ASCLIN and SCU into the tc27x SoC at their hardware
addresses.  ASCLIN0 gets serial_hd(0).

Peripheral IRQ lines are left unconnected; the interrupt router
and CPU interrupt delivery follow in a separate series.

Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
---
 hw/tricore/Kconfig             |  3 +++
 hw/tricore/tc27x_soc.c         | 32 ++++++++++++++++++++++++++++++++
 include/hw/tricore/tc27x_soc.h |  9 +++++++++
 3 files changed, 44 insertions(+)

diff --git a/hw/tricore/Kconfig b/hw/tricore/Kconfig
index decf7c31d5..9e312495e5 100644
--- a/hw/tricore/Kconfig
+++ b/hw/tricore/Kconfig
@@ -11,6 +11,9 @@ config TRIBOARD
 
 config TC27X_SOC
     bool
+    select TRICORE_ASCLIN
+    select TRICORE_SCU
+    select TRICORE_STM
 
 config TRICORE_SCU
     bool
diff --git a/hw/tricore/tc27x_soc.c b/hw/tricore/tc27x_soc.c
index 5b1b07cee1..352a6cf0f7 100644
--- a/hw/tricore/tc27x_soc.c
+++ b/hw/tricore/tc27x_soc.c
@@ -20,10 +20,13 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "hw/core/clock.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/core/sysbus.h"
 #include "hw/core/loader.h"
 #include "qemu/units.h"
 #include "hw/misc/unimp.h"
+#include "system/system.h"
 
 #include "hw/tricore/tc27x_soc.h"
 #include "hw/tricore/triboard.h"
@@ -61,6 +64,9 @@ const MemmapEntry tc27x_soc_memmap[] = {
     [TC27XD_EMEM_U]    = { 0xBF000000,                  0x0 },
     [TC27XD_PSPRX]     = { 0xC0000000,                  0x0 },
     [TC27XD_DSPRX]     = { 0xD0000000,                  0x0 },
+    [TC27XD_STM0]      = { 0xF0000000,                  0x0 },
+    [TC27XD_ASCLIN0]   = { 0xF0000600,                  0x0 },
+    [TC27XD_SCU]       = { 0xF0036000,                  0x0 },
 };
 
 /*
@@ -182,6 +188,8 @@ static void tc27x_soc_init_memory_mapping(DeviceState *dev_soc)
 static void tc27x_soc_realize(DeviceState *dev_soc, Error **errp)
 {
     TC27XSoCState *s = TC27X_SOC(dev_soc);
+    TC27XSoCClass *sc = TC27X_SOC_GET_CLASS(s);
+    Clock *fstm;
     Error *err = NULL;
 
     qdev_realize(DEVICE(&s->cpu), NULL, &err);
@@ -191,6 +199,27 @@ static void tc27x_soc_realize(DeviceState *dev_soc, Error **errp)
     }
 
     tc27x_soc_init_memory_mapping(dev_soc);
+
+    /* STM clock: 50 MHz (fSTM derived from fSPB) */
+    fstm = clock_new(OBJECT(dev_soc), "fstm");
+    clock_set_hz(fstm, 50000000);
+    qdev_connect_clock_in(DEVICE(&s->stm), "fstm", fstm);
+
+    /* Connect ASCLIN to first serial device */
+    qdev_prop_set_chr(DEVICE(&s->asclin), "chardev", serial_hd(0));
+
+    /* Realize peripherals */
+    sysbus_realize(SYS_BUS_DEVICE(&s->stm), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&s->asclin), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&s->scu), &error_fatal);
+
+    /* Map peripheral MMIO regions */
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->stm), 0,
+                    sc->memmap[TC27XD_STM0].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->asclin), 0,
+                    sc->memmap[TC27XD_ASCLIN0].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->scu), 0,
+                    sc->memmap[TC27XD_SCU].base);
 }
 
 static void tc27x_soc_init(Object *obj)
@@ -199,6 +228,9 @@ static void tc27x_soc_init(Object *obj)
     TC27XSoCClass *sc = TC27X_SOC_GET_CLASS(s);
 
     object_initialize_child(obj, "tc27x", &s->cpu, sc->cpu_type);
+    object_initialize_child(obj, "stm", &s->stm, TYPE_TRICORE_STM);
+    object_initialize_child(obj, "asclin", &s->asclin, TYPE_TRICORE_ASCLIN);
+    object_initialize_child(obj, "scu", &s->scu, TYPE_TRICORE_SCU);
 }
 
 static void tc27x_soc_class_init(ObjectClass *klass, const void *data)
diff --git a/include/hw/tricore/tc27x_soc.h b/include/hw/tricore/tc27x_soc.h
index 2d2bdca3fd..6ff80d45ac 100644
--- a/include/hw/tricore/tc27x_soc.h
+++ b/include/hw/tricore/tc27x_soc.h
@@ -22,6 +22,9 @@
 #define TC27X_SOC_H
 
 #include "hw/core/sysbus.h"
+#include "hw/char/tricore_asclin.h"
+#include "hw/timer/tricore_stm.h"
+#include "hw/tricore/tricore_scu.h"
 #include "target/tricore/cpu.h"
 #include "qom/object.h"
 
@@ -65,6 +68,9 @@ typedef struct TC27XSoCState {
 
     /*< public >*/
     TriCoreCPU cpu;
+    TriCoreSTMState stm;
+    TriCoreASCLINState asclin;
+    TriCoreSCUState scu;
 
     MemoryRegion dsprX;
     MemoryRegion psprX;
@@ -124,6 +130,9 @@ enum {
     TC27XD_EMEM_U,
     TC27XD_PSPRX,
     TC27XD_DSPRX,
+    TC27XD_STM0,
+    TC27XD_ASCLIN0,
+    TC27XD_SCU,
 };
 
 #endif

-- 
2.47.3


