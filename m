Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E968C531F8
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 15:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmvDj-0004wt-PB; Thu, 23 Jul 2026 11:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvDG-0004Ez-7e; Thu, 23 Jul 2026 11:19:54 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvD9-00085x-NQ; Thu, 23 Jul 2026 11:19:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nd8/CdSoMFTR7Rx/UN9aLvTP/J7I7wvzzWacAogiR/SuTSoOzvGJXeDg8ZgBhM46HadBqbR8VjcgasEK/i/l2F2z+PE9bVcQepJ/U5gj5smtMo6hlPV+R2fzJUiHsh5fx2U2SEXJWLyIF2f7HJZg9KdvCbFFH3FyK6JM0SEF2wrJeYjcwLigQqt7LDKbUhcbn92EwZL30EMgpUpCmh2aclDHNek7FR9YCVT2UEEVaGZEVNPzRtgZ+NqNwhpMEDCFI6T8bglsgbM9ztPwnD89GkVZXQZi55cHK2wK8ixDDLdhecPYopChFUrZngTm2MngnJBGNlH/JxIrFUV1DpzYvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubmzn700Y1571Kajvg9ykUb1B05ivONiGbWqi0GDxIQ=;
 b=F0cKyeO0fk4UhWhk1dYubHdnXQfz6S9rnV53J5qDjOo0q+8WNn/4awExzcFgGG/ydVcyyyxUvfbwwUg8L/J/BgESXxk9cTQhpyE8kKd9eCNRWQMsJL6jf//6fQucle0vkiRCVYJL5MnQW3RUJeop0cibiLNuPDEJEq1yhMUCeCxjn+zru9hKXkyrBqAKWPQFWjb84z149FsDFIYTfrestXp4RlkXQtHr7T3JAMGKpdwxeZLoV9XO8KsMVmgQibNzjlRy9Ydn/1DBScKVZ/mYs4qWu5J0jM4zUrIXADkDTANf0Pvl6HCQpQGIaDpuIcWPQYjDHbJlo4c+7yuMnyOj4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubmzn700Y1571Kajvg9ykUb1B05ivONiGbWqi0GDxIQ=;
 b=GepqGX/CNLWmzSFqygi+isLD4JkTracRAnfzdrKJ7nJ0V8SOm0UuhSymiXDjvkK4YMjUnRajE0i+VqFNFLeI+l1eKTZx2Sl0w1glNrY2F/6OSa7p27qejUSnknmdjjTN1nQkqydmBfpyJu8b48AveiZZFqAAhgooY07/olnuhMY0ecaA1cPhbj/MUYO3vf/IbuxLEfJ0eOyLS8X3NzOPH59K02q3JDi/8L88ms7rTWmP53Cl6i6f6BrIoUHOa5HcFh4nVQ8NgMkYtNAxGqDtkV2AsNA5q43DNvwWx3nODAg2Et2c5dVHS9gqj1ByC4QkRu/u1gYGhC7ILuTzy/rGXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SEYPR02MB7097.apcprd02.prod.outlook.com (2603:1096:101:1a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 15:19:33 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 15:19:33 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor@kernel.org>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
Subject: [PATCH 15/26] hw/misc: pfsoc: Model PolarFire SoC serial number
 service
Date: Thu, 23 Jul 2026 23:18:42 +0800
Message-Id: <20260723151853.2143177-16-bin.meng@processmission.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723151853.2143177-1-bin.meng@processmission.com>
References: <20260723151853.2143177-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU0P306CA0037.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:29::8) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|SEYPR02MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: f38e5c02-edcf-4f54-3789-08dee8cdcc4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|376014|366016|23010399003|1800799024|6133799003|22082099003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: h67B/WMFLtmPh9K+HeYBPmRZDR12jlDkmPZlAlAjgnXlUFBGidUdeYFVFxv8wk9GbWCO40PiTjiAe3Q2Ib+1d6llxunixKMmtUm4PxGZok9oR+t1jRkvt9g29TgrOZ4uIE1hHxsg5PQtkqEyRlJH95wGUTnn7KhrYGfyH+Ln9t1wAQh8rEaZD0xrA2zW0xygBeTdyLM6f7Kp4KJdw+OKE2lGR+EF14spsJuSR63MYl/Kt23qLpxVQooJkg+chravqk3MXsq3etIbS8vdk13eGokn+HRVUXH+LloZhgDfdH6/fqGUGUJUwd7ZbuccHa+lK2Rga0TU78DIOJGbNkN6jx0IQAFkVKg3VSgWVZN505u1tl+h9EnSc/ATbdPrV2FcSKBOZqgtoLG2Tam+uJMfWnKNA5KanAv1WnnsOp3nBWSbqG6fh2oE9y4r8qEfgWDW+gRjVQooMgmOqo4LI3NmRHjYFEmuV6L5/b4vQYK/Hbhsr51TjxgZlNci58c+4XAoavtrTFZDBpO/YTajk7hP0jLhJlf+muXl2bxI8y10+XzaBd0suXQxFzYxJWswYJ92J+Ms7J85fdKrZ3Itw26f9VWA4fbvg1+mHhzOiUgSt9FhD8cQ+ZWvMmKq04w2cYkCHvy+Yqg/ACFyspDlSZ83WQOMWcIoMEjGa/HFvpZkKeM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(376014)(366016)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aldNaEgrN0dOcmVvUU9PbXFwN2pDZlFjZC9WLzBlZEhpRUxnbFNMWVRncHNu?=
 =?utf-8?B?TXhhYkdrbzg4bFJ0QWdKRmdRTGpiVDk2dDdFajh0WWlVdkJMQUtnUFdVby9y?=
 =?utf-8?B?ZkVQc25jVEdHQ2pqSURmcW1OQ3NhNG1aK1VhZnU1SHNMZWVJZjh1U0J6eTJp?=
 =?utf-8?B?cnFRS2lMNGRaNTkxdVdMZ3Q4Z240T3MrU1BPOHF1dzBtODNWeGdZM1FwTmM5?=
 =?utf-8?B?WFdIelRlV015SUc1aFhTSzJMM3NLZXUzZWJ6dzVmVklUMVJMb2tnQUQ1ZUpa?=
 =?utf-8?B?SjlmTEMwQ3o4aEh5U01lQ211OHJ3cFJHaUY1aEl4ZW5vR0NpWTZIYUJWc2NV?=
 =?utf-8?B?NUFTRDRiYytkMFZJRnJVS0VzejY4QUIwU3AvZXU2Tit0QktsYWRuK2VEVFFq?=
 =?utf-8?B?ekhTN0tYcjU4SmkzV1didlROUVVFaGp5NzByUklOYnRrdmZ1b0dZSUZPZ3JP?=
 =?utf-8?B?aFJLUElmZzZkMWRMTUpyeU1SbW9Zend3QkQzZEM3ZGx2VGV3d3dTMzFRYmFN?=
 =?utf-8?B?Yjd5SUZLVTBWelphTFl2VVZrNjhCNjdtTzZZa2xvd0lyWGN5QmdPdEtPZVRP?=
 =?utf-8?B?bmxPOUlNOURVVlJLdmhzbzM3RkFVRnRGaW9FYVJXZ01ZRU01MEZpOUlLTjlU?=
 =?utf-8?B?elNMNVhPaER4dytTS1hZbi9qeW9XNjg1M2UycUhmRkpTUGlvejloVHgwUkpK?=
 =?utf-8?B?TjZRTmc3dldBTURPR1pka0RMNHhhNmIrZW9TVFlLemE1MzFURXRpUnM1YThF?=
 =?utf-8?B?eWRUNkxTNWhuVm1mOGo3NkxQVDJGazVwTmMvUlN1L25nK3k4dWxNL2loWEpw?=
 =?utf-8?B?NThhSWJvMmMyeGxOcmRLekx2dEsvU1VLNHM5V0wyUWtkR0Z5emZ4TEphcy9x?=
 =?utf-8?B?M3phT1h0bTVicnhGVllTWnprRmtoVG9UU0g1bWlwOFRhSUo3TmRyc2gxK3I1?=
 =?utf-8?B?N001QzNaUlN0cFA4YkpiTE1lM2xwVW0vdTJ6Rzd2NFdBSDhDNHA5cHBxcDFt?=
 =?utf-8?B?OEhaTGdTYWtHM2RQRnVDTGs1Nnp4NFpDOHZPbzgxWERXR0tYNkJSSDFlTEla?=
 =?utf-8?B?M2x6SWZvY2ZnUjd4YkRvZXF3N0t3K0N0R04vTGJXOTNwQVduaVJEV0ZML0Q4?=
 =?utf-8?B?UUNma1d0OHQwV0RXdGIya3BsMkxvcit3aWVNSjVoMzA2UmZZNmRQY0pqb0lC?=
 =?utf-8?B?Zk5CbnlkVUM1MG1uWDJDbDEzLzV2WUZkRW90Yk85MXpDTXBRRVZVQXh2WHI3?=
 =?utf-8?B?RzVTenZUUVREQmt0M2lZb3h2REVnZ2F4OTBVcmZDZWhaWkJtT0JCUGpGV2hJ?=
 =?utf-8?B?NG5UeXN1d1lOMzVrTUJhSnQyclgremhGdlJJRkVSSFJCUG14R2pIWnhGYXdi?=
 =?utf-8?B?U0NuT2YyTVN4c2F3RG9BK2tIRHZ5bFhUN0E5M0tXalM5T2Z4aGxQV0JrRnJ2?=
 =?utf-8?B?Lyt1K1dhdWZ3b3JlNnpQNmNMMUxpWFJmRmd1Z2lGY3liV1Z5RmNvN2Y1OGRv?=
 =?utf-8?B?R3QwQjNaditXWWN5Ykl4K0tMbzRwUllWU0lRak95dVE3UjRUZjh3Z3F3ZG1o?=
 =?utf-8?B?WE90cXdTZHpMRmFEL01wS29wZVpsVlcwUkxOTzQ2SWFBRHljTEVmVGZObGxu?=
 =?utf-8?B?dnZ6WE9LWmFUdnBreUVUS1RyUHVIcXp6bTlCVURCZ3ZSME13Z0hZT3plYldB?=
 =?utf-8?B?VHU2YlZSdjZBWFkvU1NRQmpHcjVhVWlZSE1hUXpQanB4YU9KczVLRXBwUTg5?=
 =?utf-8?B?T0VKUDJvOHRtRUVMREhrTnRlcitiQ2FZY3ppSzJHT3FqSmdvTXJSWXE3TlRx?=
 =?utf-8?B?NFNBU0ZVd0xocklvUnY3TmlxOEQ1bmlJeG03RU5OcXZrcndGaEJzOTlNa1BV?=
 =?utf-8?B?SEJBQkJ1bGtXeVkwVDRxbnFhLzNsOC8zdDJQczNoekdmZ3dLSmVjSFNKK2dU?=
 =?utf-8?B?cHp4amk3UXljaDBWWEsyL1R1RXVrWVRpTEtsY3NDN3FsSnBIVC81aFJ3R1Fo?=
 =?utf-8?B?OTlwK2lJQXp6Q0s3NHB2YWxJQ2NOSCtaUStqVnoxUW4xbDVhV2FadXcyUXNa?=
 =?utf-8?B?Q2ZVbHlOMWFXUWxWTmhzY2dNQkFkdWFweHkvYm8wZklGSEhqVk9YY2RTbDZU?=
 =?utf-8?B?WFRDNStxOXptYlAybWx1WXdnNGo4ZFNMN3p5OG9BNDZJVHFJUkdyUklOYUd5?=
 =?utf-8?B?cDRMVFkvMXZsZnN4aE9vdTJCN2hub1Z4V25oOENDZzJ1TUxuT0ZzK2xxQkFF?=
 =?utf-8?B?TUR5bFFLU1pTR3BCa3RabjltYlFLczkwSndzRWNnRkdRdFR5Um1ETmNkbXE2?=
 =?utf-8?B?VTlVM09LQVZpRE4wU0l5UDdKUEtIeGQ0QXNFQkJFS3RFdFRFUTVMcEluZnVx?=
 =?utf-8?Q?tCmJL7pMCEK6C8K4=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f38e5c02-edcf-4f54-3789-08dee8cdcc4a
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 15:19:32.8793 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EEusJXxbRGKsiu1AM4LmTvJsAzxI5INtcfFhqOmwndHV1ly+2ajJJmoMViqD9sLFKi3u8eK9fBbraUiYRldqIQZ2gH6E5rFeFRa2HsMSfTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB7097
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=bin.meng@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

U-Boot requests the PolarFire SoC device serial number during board
late initialization. The IOSCB previously rejected every request, so
board setup could not complete.

Model the System Services control registers and byte-addressable
mailbox. Obtain the 128-bit serial number from an optional device
property, using a deterministic value when it is not configured.
Return an explicit failure for unsupported services and reset the new
runtime state with the rest of the device.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 include/hw/misc/mchp_pfsoc_ioscb.h |   6 ++
 hw/misc/mchp_pfsoc_ioscb.c         | 141 +++++++++++++++++++++++++----
 2 files changed, 130 insertions(+), 17 deletions(-)

diff --git a/include/hw/misc/mchp_pfsoc_ioscb.h b/include/hw/misc/mchp_pfsoc_ioscb.h
index 9687ea25b1..fd31427304 100644
--- a/include/hw/misc/mchp_pfsoc_ioscb.h
+++ b/include/hw/misc/mchp_pfsoc_ioscb.h
@@ -25,6 +25,8 @@
 
 #include "hw/core/sysbus.h"
 
+#define MCHP_PFSOC_IOSCB_MAILBOX_SIZE 0x1000
+
 typedef struct MchpPfSoCIoscbState {
     SysBusDevice parent;
     MemoryRegion container;
@@ -47,6 +49,10 @@ typedef struct MchpPfSoCIoscbState {
     MemoryRegion cfm_sgmii;
     MemoryRegion bc_sgmii;
     MemoryRegion io_calib_sgmii;
+    uint32_t services_cr;
+    uint32_t services_sr;
+    uint8_t mailbox_data[MCHP_PFSOC_IOSCB_MAILBOX_SIZE];
+    char *serial_number;
     qemu_irq irq;
 } MchpPfSoCIoscbState;
 
diff --git a/hw/misc/mchp_pfsoc_ioscb.c b/hw/misc/mchp_pfsoc_ioscb.c
index 09b702e520..7c82b55986 100644
--- a/hw/misc/mchp_pfsoc_ioscb.c
+++ b/hw/misc/mchp_pfsoc_ioscb.c
@@ -25,6 +25,7 @@
 #include "qemu/log.h"
 #include "qapi/error.h"
 #include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/sysbus.h"
 #include "hw/misc/mchp_pfsoc_ioscb.h"
 
@@ -37,6 +38,9 @@
 #define IOSCB_CCC_REG_SIZE          0x2000000
 #define IOSCB_CTRL_REG_SIZE         0x800
 #define IOSCB_QSPIXIP_REG_SIZE      0x200
+#define IOSCB_SERIAL_NUMBER_SIZE    16U
+#define IOSCB_DEFAULT_SERIAL_NUMBER "0123456789abcdef"
+#define IOSCB_PROP_SERIAL_NUMBER    "serial-number"
 
 
 /*
@@ -186,33 +190,71 @@ static const MemoryRegionOps mchp_pfsoc_io_calib_ddr_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-#define SERVICES_CR             0x50
-#define SERVICES_SR             0x54
-#define SERVICES_STATUS_SHIFT   16
+#define SERVICES_CR                         0x50
+#define SERVICES_CR_REQUEST                 BIT(0)
+#define SERVICES_CR_COMMAND_SHIFT           16
+#define SERVICES_CR_COMMAND_WIDTH           8
+#define SERVICES_CR_COMMAND_MASK            \
+        MAKE_64BIT_MASK(SERVICES_CR_COMMAND_SHIFT, SERVICES_CR_COMMAND_WIDTH)
+#define SERVICES_CR_MASK                    \
+        (SERVICES_CR_REQUEST | SERVICES_CR_COMMAND_MASK)
+#define SERVICES_SR                         0x54
+#define SERVICES_SR_STATUS_SHIFT            16
+#define SERVICES_COMMAND_SERIAL_NUMBER      0
+#define SERVICES_STATUS_SUCCESS             0
+#define SERVICES_STATUS_FAILED              1
+#define SERVICES_MAILBOX_RESPONSE_OFFSET    0
+
+static void services_cr_write(MchpPfSoCIoscbState *s, uint32_t value)
+{
+    uint32_t command;
+    uint32_t status = SERVICES_STATUS_FAILED;
+
+    if (device_is_in_reset(DEVICE(s)) ||
+        !(value & SERVICES_CR_REQUEST)) {
+        return;
+    }
+
+    /*
+     * System services complete synchronously in this model, so clear the
+     * request bit before exposing the response to the guest.
+     */
+    s->services_cr &= ~SERVICES_CR_REQUEST;
+
+    command = (value & SERVICES_CR_COMMAND_MASK) >>
+              SERVICES_CR_COMMAND_SHIFT;
+    if (command == SERVICES_COMMAND_SERIAL_NUMBER) {
+        /*
+         * The serial-number service returns a 128-bit response starting at
+         * the beginning of the mailbox.
+         */
+        memset(&s->mailbox_data[SERVICES_MAILBOX_RESPONSE_OFFSET], 0,
+               IOSCB_SERIAL_NUMBER_SIZE);
+        memcpy(&s->mailbox_data[SERVICES_MAILBOX_RESPONSE_OFFSET],
+               s->serial_number, strlen(s->serial_number));
+        status = SERVICES_STATUS_SUCCESS;
+    }
+
+    s->services_sr = status << SERVICES_SR_STATUS_SHIFT;
+    qemu_irq_raise(s->irq);
+}
 
 static uint64_t mchp_pfsoc_ctrl_read(void *opaque, hwaddr offset,
                                      unsigned size)
 {
-    uint32_t val = 0;
+    MchpPfSoCIoscbState *s = opaque;
 
     switch (offset) {
+    case SERVICES_CR:
+        return s->services_cr;
     case SERVICES_SR:
-        /*
-         * Although some services have no error codes, most do. All services
-         * that do implement errors, begin their error codes at 1. Treat all
-         * service requests as failures & return 1.
-         * See the "PolarFire® FPGA and PolarFire SoC FPGA System Services"
-         * user guide for more information on service error codes.
-         */
-        val = 1u << SERVICES_STATUS_SHIFT;
-        break;
+        return s->services_sr;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimplemented device read "
                       "(size %d, offset 0x%" HWADDR_PRIx ")\n",
                       __func__, size, offset);
+        return 0;
     }
-
-    return val;
 }
 
 static void mchp_pfsoc_ctrl_write(void *opaque, hwaddr offset,
@@ -222,13 +264,17 @@ static void mchp_pfsoc_ctrl_write(void *opaque, hwaddr offset,
 
     switch (offset) {
     case SERVICES_CR:
-        qemu_irq_raise(s->irq);
+        s->services_cr = value & SERVICES_CR_MASK;
+        services_cr_write(s, value);
+        break;
+    case SERVICES_SR:
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimplemented device write "
                       "(size %d, value 0x%" PRIx64
                       ", offset 0x%" HWADDR_PRIx ")\n",
                       __func__, size, value, offset);
+        break;
     }
 }
 
@@ -236,6 +282,55 @@ static const MemoryRegionOps mchp_pfsoc_ctrl_ops = {
     .read = mchp_pfsoc_ctrl_read,
     .write = mchp_pfsoc_ctrl_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = sizeof(uint32_t),
+        .max_access_size = sizeof(uint32_t),
+    },
+};
+
+/*
+ * The System Controller uses the mailbox as a byte-addressable shared buffer
+ * for service command payloads and responses.
+ */
+static uint64_t mchp_pfsoc_mailbox_read(void *opaque, hwaddr offset,
+                                        unsigned size)
+{
+    MchpPfSoCIoscbState *s = opaque;
+
+    return ldn_le_p(&s->mailbox_data[offset], size);
+}
+
+static void mchp_pfsoc_mailbox_write(void *opaque, hwaddr offset,
+                                     uint64_t value, unsigned size)
+{
+    MchpPfSoCIoscbState *s = opaque;
+
+    stn_le_p(&s->mailbox_data[offset], size, value);
+}
+
+static const MemoryRegionOps mchp_pfsoc_mailbox_ops = {
+    .read = mchp_pfsoc_mailbox_read,
+    .write = mchp_pfsoc_mailbox_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = sizeof(uint8_t),
+        .max_access_size = sizeof(uint32_t),
+    },
+};
+
+static void mchp_pfsoc_ioscb_reset(DeviceState *dev)
+{
+    MchpPfSoCIoscbState *s = MCHP_PFSOC_IOSCB(dev);
+
+    s->services_cr = 0;
+    s->services_sr = 0;
+    memset(s->mailbox_data, 0, sizeof(s->mailbox_data));
+    qemu_irq_lower(s->irq);
+}
+
+static const Property mchp_pfsoc_ioscb_properties[] = {
+    DEFINE_PROP_STRING(IOSCB_PROP_SERIAL_NUMBER,
+                       MchpPfSoCIoscbState, serial_number),
 };
 
 static void mchp_pfsoc_ioscb_realize(DeviceState *dev, Error **errp)
@@ -243,6 +338,16 @@ static void mchp_pfsoc_ioscb_realize(DeviceState *dev, Error **errp)
     MchpPfSoCIoscbState *s = MCHP_PFSOC_IOSCB(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
+    /* Use a deterministic identity when no serial number is configured */
+    if (!s->serial_number) {
+        s->serial_number = g_strdup(IOSCB_DEFAULT_SERIAL_NUMBER);
+    }
+    if (strlen(s->serial_number) > IOSCB_SERIAL_NUMBER_SIZE) {
+        error_setg(errp, "The serial number can't be longer than %u bytes",
+                   IOSCB_SERIAL_NUMBER_SIZE);
+        return;
+    }
+
     memory_region_init(&s->container, OBJECT(s),
                        "mchp.pfsoc.ioscb", IOSCB_WHOLE_REG_SIZE);
     sysbus_init_mmio(sbd, &s->container);
@@ -265,7 +370,7 @@ static void mchp_pfsoc_ioscb_realize(DeviceState *dev, Error **errp)
                           "mchp.pfsoc.ioscb.qspixip", IOSCB_QSPIXIP_REG_SIZE);
     memory_region_add_subregion(&s->container, IOSCB_QSPIXIP_BASE, &s->qspixip);
 
-    memory_region_init_io(&s->mailbox, OBJECT(s), &mchp_pfsoc_dummy_ops, s,
+    memory_region_init_io(&s->mailbox, OBJECT(s), &mchp_pfsoc_mailbox_ops, s,
                           "mchp.pfsoc.ioscb.mailbox", IOSCB_SUBMOD_REG_SIZE);
     memory_region_add_subregion(&s->container, IOSCB_MAILBOX_BASE, &s->mailbox);
 
@@ -343,6 +448,8 @@ static void mchp_pfsoc_ioscb_class_init(ObjectClass *klass, const void *data)
 
     dc->desc = "Microchip PolarFire SoC IOSCB modules";
     dc->realize = mchp_pfsoc_ioscb_realize;
+    device_class_set_legacy_reset(dc, mchp_pfsoc_ioscb_reset);
+    device_class_set_props(dc, mchp_pfsoc_ioscb_properties);
 }
 
 static const TypeInfo mchp_pfsoc_ioscb_info = {
-- 
2.34.1


