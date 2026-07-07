Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B479C43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 08:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh1Gn-0003jG-Gs; Tue, 07 Jul 2026 04:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wh1Gl-0003iJ-UI; Tue, 07 Jul 2026 04:35:07 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wh1Gj-0007zQ-VQ; Tue, 07 Jul 2026 04:35:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EfwXRZVvt+2qjGVAuUR1udgMiPD9+RQOqrsoEwVk6q+jFWCRh7wg1FlUfuHpik3Mnh/XjnL7ZRUjsy039BQpToPhaQ74xVtG69iZn+P5fEevqSWsv/G+PAErXuxwX3c6srylvT4SkTAtj8XKGeVuOgJWUumH+1jQlVGYdwLGswfFbzsrmPN7I77OIL5k1SGONGQCBep62pHmbfMrLh7xcTJZHzreBAS1KRpj6CP1XFRrL1nVS/B5Sm4a7sTFiX9L3N9K37EgvDs9MKWSJ2swpZq01kQm60JH0QuJJO39o7ebeB7rJipEo/owNZWBR+z6qP7kH0dmCxKa8+WGExLEBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4eZn2AaIpxQq8kwBCIXVYHlvb88gmPhGradzR16Ehs=;
 b=eiE61Pl2ppjJWEzPY2/YdsHWAb5S0fCrMzKsPHVHdEFihCwafBL3GqJJWYqeoLse6ZIwcqQ2d/YaMH8IVF7AbS5osl40wbotcCgPS3BX1o9iZuFyWuB/7ZCOlxTPjJqn+pO6ZGbGiwi6Uw045Vc8KV7n0tez+t8LcOo+1p2kK1HoUohnV1bK5VaJXZz7YY9OOTG4QkBub51smUvyo1Lx3MDnu1+VuIfBp8r4HXhRSODT57k8l4dI3Nulyz3r9nitL1NQVmA21uHGVoM/hl7rVM4a8x2q5dh8CvExOUpQMGxLX7L/yZHlosHzde1VHeIkMU9YxI51Zc9/44dKsW9puA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4eZn2AaIpxQq8kwBCIXVYHlvb88gmPhGradzR16Ehs=;
 b=ufOSvYr09JMYjVfLVYkTO1l0oHnkZKKF5alBTgFsrTq2E0fiIGG1EVteL24PPyvBqZumPQYnbhJfPiEziEii07v1O1gLOglD6dUgylmt4jFmf4fwo3LlSc96JAYQAe1tZaKz5yd9C6BQJu0vDJnqWEdKziXIM4c+RiHay33Kkb/GEuS9he7F+P/b50qAvz9uJR2sWOsV+gi5WYn28oo1I0YtBY+VsCFozoSKnqFigy4VGCqvfATchyVICEqqYnGUCxTHMxwv+LzM9J/NWyOe6WuAltyt/KqjrOub42B6Im7IReE2YbWLpSOkEvI/P+vmCkCqcYgvq8yDD//BKPZXSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SEYPR02MB5558.apcprd02.prod.outlook.com (2603:1096:101:53::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 08:34:54 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 08:34:54 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH v2 02/10] hw/block: m25p80: Fix dummy byte handling for
 Numonyx/Micron flash
Date: Tue,  7 Jul 2026 16:34:21 +0800
Message-ID: <20260707083431.219671-3-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707083431.219671-1-bin.meng@processmission.com>
References: <20260707083431.219671-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SE2P216CA0106.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c4::6) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|SEYPR02MB5558:EE_
X-MS-Office365-Filtering-Correlation-Id: 53b20c46-4b6f-490e-5f63-08dedc029ee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|366016|376014|1800799024|23010399003|3023799007|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 0vAYMn9joxBboRAZc6ivJmlUPVHJ62bCvhqcWn7SMc7dY15j3myBo6B88rESvF68Uvzs285jub5iYTFdpMs6AZKkJU1gjqVrqY64Fr0Kyc1Fpli00V61nppk2RtmuWlFxXmZmQcLw4JJl2+lSUZzTlKL5Wjo7b3I+e9N7VrU1sk42GKNnllysU1Ghlp1Y903oOqQrO22yFXkF3ke1okpox/YDtunPhoXLz6CFDKxmxQt9sDBjQWt8UCKy2y5xBDcP4zgzWW1EV6Sq1RY6Y4FhaoYCu4YWJToLC/2JxX7Qaf/KzbkGCuHzCJFIByif3I8vXSyGcr9BSuLUEHN/ApiNdv+q0fFRTNJGGpXshTxRSkMjojhZ2kSGxz8ytzo/hbpAYWQAzWAbr7XE8+z86EW5u36HOaAp8DWr7Y1POFQosdazH5XT3UN8PnTMAAxo2ZqDMETRbxAFL5puWvhJAbGcEHBOCAXzATKUFBQgwjv05uqsyRDL0Dc4wv3b8kAnGTKXACYmE0uIj/y7FyXvjj04wZyy7to2fn0yYNjNwxcu6sl+UQKg6aODHgWWO7t7T+aVvAuZhdhZEiIMovz9TjFjmMUdlpXLatKgTcGl8Zm5w8zR5Djr22+2CMZcEBt9pN5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(366016)(376014)(1800799024)(23010399003)(3023799007)(56012099006)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlpnMldlWWtrTUZtS05vUHRSWUZCUnZ6clJYSGhEUU8yRXpuWFhUVk8yZ1hw?=
 =?utf-8?B?Z0NGRlNGUHBuTXpvTytrQkIzUGRsV0l3dUdQbGNZVzBIU0JhaGVxZjF3bWVT?=
 =?utf-8?B?UEh2MFl2NGgwTzhHV2xhN0t3bVRPUXBiWnZjdW1YVFlnTUN0NjROKzBtM0F5?=
 =?utf-8?B?S1JYMS9zVW1RQXNQZFFYVFBGdHM5WXZaRDY2Qmt5Z1Yxbi9WWTZnV0JzM1Ez?=
 =?utf-8?B?RzNKM1lvcmt4ZE15T0twT3Y5aTVMTFpCQ3RsODFvSk1JdllEYm9lWXN5bkFV?=
 =?utf-8?B?dWllUXRUMkdqSkpHL0VDQzhEQ1F6RUo5bCtpREJSMThTOGlXbHVQY093dXpS?=
 =?utf-8?B?TDEvaEswa2ZWcklPbkduRDFodXZtWE0xdjNvV1MyVG5PNHpBYXlKMUxEU0tn?=
 =?utf-8?B?UnZyMjF2aWVNWm4xaHBpQytMcEx4YWlDcytiR1lIOTEzVnRIcGVHMDcrSHpF?=
 =?utf-8?B?TjFtelVkY3Y5U2luSllGQjhFNVE4SUNQcFV6OEVNMnF0dEx0UFNVZXZDUkVM?=
 =?utf-8?B?cDlBTGd0anVvOW5WcFErZHViaURyS2hKdG9wMFp5anZ6cDJwZWt1Rm1JSFV6?=
 =?utf-8?B?YjhuV2EycE5NeDZxaDRGeEE2c0lrWExuUURubFo3dEZmTnRkUEwxcFZFSVRo?=
 =?utf-8?B?dVhkS2NoMHVQaXgzZHl6NmlnaFJ1WHJiTWRGNHFmdEQwcVpKcmZXbktNRHAy?=
 =?utf-8?B?dXpLWXN5TWNTckdOOUE0ZTB1aEtZUjFkVTE0WW11eWY2TDNHOHFjZkFFZlND?=
 =?utf-8?B?NHRMSVljTjVKNHZ3NFA3VENlcjRTWWxCalh4ZkdiOExaVnlPNlR4MTdrRW5W?=
 =?utf-8?B?ekhFSzNrd3Z0ZnFPSjRxbkczQmhPOEZVY2Fsck1vZXJza0hFc3Z1WEhxODBa?=
 =?utf-8?B?RVRxOWxFMkVBZjFoeWVBMmhGdzdRQnA5OW1temRCVE8zVmpKaTJJaEl3Z2l1?=
 =?utf-8?B?OEpYYnNzVi9GdmMxL3pQV0k0aWQvdFMvS1lNV1lGbDdjQjNRaXduTHh6a0FN?=
 =?utf-8?B?Q0FEYnhla1lWT3FtMlBmVUxUOGRqNmdjZEZra1FneHNVRDZJbnh6Q2xZOURp?=
 =?utf-8?B?QU9QbkZCV1prWm1INXFTVENEZjRGUXNwN0RQMk5nV0RpWTMvVWhhTEVPUFRG?=
 =?utf-8?B?V0R0cnYxd01CTGxaZDhVaDZIbmNQMkQrNzlPRTBQWHZHVGp1WHYvQ2c0bFdD?=
 =?utf-8?B?cmg4ODRRS0JCNHM2elVieEF0WENjNTRQK09GY0pJdEdFNElWVHhORGlHVStP?=
 =?utf-8?B?cXFJWHZNVDlTalB1NFhLWG9hTE1ER0p0VlNpVlBSaHNyZGFuWWZQTm9hclA0?=
 =?utf-8?B?MmNoejllem5DWjVNMmFpenBianhRMVMwVFhDVHQ1Z0ZTMDdwaVN4RlR4Zkpw?=
 =?utf-8?B?eXFWT0dlcEJxbEE3OGhRc1RSa0xkM1hUK1h4YXRiTjA3YnRhZ01pbDJpbW8w?=
 =?utf-8?B?TjZteG1TMk5RSTRjOEhSRHNoTHVZL1l1SVUxQ3hWN0g4a1lubTNXeUpXSzVn?=
 =?utf-8?B?cHZzSk0xbllDdVhpbmVseVF0aDBQS093MWNzTWdHblZERGRjTXMwZWZwZTNC?=
 =?utf-8?B?QlpuZ1d1SnQ3UWUvRzR4eXdmQlgybCtQOHJPYlU0QVVYSUd1bXQ2eGFKSHBa?=
 =?utf-8?B?L3NwRExwQlE4ZVJLS3B4b0pneldmRHdZSnBPN1Z5T1FEdDVrYTIrMnRaMEJK?=
 =?utf-8?B?Z21BclVCMlhCeVdoTDVSVnZhTTRucUZPOU1wR3dtem5tdjhQekdHY2VOUDdz?=
 =?utf-8?B?c29ubERUTjJCS2I0NkFPSS9KVE94Vi9JNS85bWJ3aFlFUnY1cDl3THU0TitL?=
 =?utf-8?B?TUVWVVlxdEpSNmE5N29MaEJhaDYwa1luajB3Um51SG1haFdXWkxyQitLcDhs?=
 =?utf-8?B?aDBHN1BKM3QvUW1Va1FCQzMzMkJTWkFpeTh5M015dXBXVWQxUFh5dkpmWHRq?=
 =?utf-8?B?RnZNc09aaHFJMkdYNGNGclpjK05QcHNzMTB3bGs2SVVSanBESDk2NEpFMk04?=
 =?utf-8?B?aFQyOGRoMlhuc3lXckVwN1pBRE44TWhWbFJLK3VjeEs3aHBSUGU5QkZJQ2Zp?=
 =?utf-8?B?a3RjVXBEalVMeUtxMW5RUUhUNGk5UjNHMDk5STlxa01pcXdsTkNsVUZyYVR3?=
 =?utf-8?B?OHlyYldTYXh4TGxIeURRZCt1d3RIczNOelg5cWdRT3Z0ZHpwdDY5aThDM2FY?=
 =?utf-8?B?S25nV1RyK2YrYS9lb0pYM0U3WnZLclVSald0OUU3YkFvaDY0dkdCNCttM2pK?=
 =?utf-8?B?UklQRitySG4rV2VjL0ViMytHWXZmeTJXZlVXQ1JDRTE5ckVHeUVZOTZ0OW5J?=
 =?utf-8?B?UjNwbHJkNmtMalQxWnBvZ3dFY3ZadFhtSmtDWDVmS1Nqc1hiTmNKNVlWTHBI?=
 =?utf-8?Q?0awD3Sqv6vMxPKss=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b20c46-4b6f-490e-5f63-08dedc029ee9
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:34:54.8108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9BQ3U8xa8LJ3Al2pvcU23/c9jYYdEuNTPLSLgK9mE8UFJhSEC/aF9uhad72vObdmaBTqhCIuJ4utpEgjJQ/Vv8F+SfgNMeF11yTYmhs6lCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB5558
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=bin.meng@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Numonyx/Micron flashes [1] do not use one fixed dummy-phase width for all
fast-read commands. The volatile configuration register stores a number
of dummy clock cycles, and QEMU must convert that value to the number of
SSI bytes consumed by the flash model.

Keep the existing default: 10 dummy clocks in Quad I/O mode and 8 dummy
clocks otherwise. In Quad I/O and Dual I/O protocol modes, all command
phases are transferred on 4 or 2 lines, so the dummy clock count still
needs to be scaled by that bus width.

Standard SPI, also called extended SPI in the Micron datasheet, is more
subtle. Quad Output Fast Read (6Bh) and Dual Output Fast Read (3Bh) keep
the opcode and address phases on DQ0; their dummy phase is just a clock
gap before data is returned on four or two output lines. Do not scale the
dummy count for those output-only commands. Only Quad I/O Fast Read
(EBh) and Dual I/O Fast Read (BBh) transfer the address and dummy phases
on the 4-bit or 2-bit bus, so keep scaling those commands.

[1] https://docs.rs-online.com/cad7/0900766b8121bd3c.pdf

Fixes: 23af26856606 ("hw/block/m25p80: Fix Numonyx fast read dummy cycle count")
Signed-off-by: Bin Meng <bin.meng@processmission.com>
Tested-by: Cédric Le Goater <clg@redhat.com>

---

Changes in v2:
- change numonyx_extract_cfg_num_dummies() to numonyx_extract_cfg_dummy_bytes()
  to avoid confusion
- use assert() when the dummy bit count is not byte-aligned

 hw/block/m25p80.c | 55 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 13 deletions(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 59ecb32c0a..83d1ce1f95 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -971,28 +971,57 @@ static uint8_t numonyx_mode(Flash *s)
     }
 }
 
-static uint8_t numonyx_extract_cfg_num_dummies(Flash *s)
+static uint8_t numonyx_extract_cfg_dummy_bytes(Flash *s)
 {
-    uint8_t num_dummies;
+    uint8_t dummy_bits;
     uint8_t mode;
-    assert(get_man(s) == MAN_NUMONYX);
 
     mode = numonyx_mode(s);
-    num_dummies = extract32(s->volatile_cfg, 4, 4);
+    dummy_bits = extract32(s->volatile_cfg, 4, 4);
 
-    if (num_dummies == 0x0 || num_dummies == 0xf) {
+    /*
+     * The default nubmer of dummy cycles is only related to the SPI
+     * protocol mode. For QSPI it is 10, otherwise it is 8.
+     */
+    if (dummy_bits == 0x0 || dummy_bits == 0xf) {
+        dummy_bits = (mode == MODE_QIO) ? 10 : 8;
+    }
+
+    /*
+     * Convert the number of dummy cycles to bytes.
+     *
+     * In the Dual I/O and Quad I/O protocols, all command phases use 2 or 4
+     * lines. In standard/extended SPI mode the phase width depends on the
+     * command sequence: output-only fast reads keep the dummy clocks on the
+     * single address line, while input/output fast reads use the same 2-line
+     * or 4-line phase as the address.
+     */
+
+    if (mode == MODE_QIO) {
+        dummy_bits *= 4;
+    } else if (mode == MODE_DIO) {
+        dummy_bits *= 2;
+    } else {
         switch (s->cmd_in_progress) {
         case QIOR:
         case QIOR4:
-            num_dummies = 10;
+            dummy_bits *= 4;
             break;
-        default:
-            num_dummies = (mode == MODE_QIO) ? 10 : 8;
+        case DIOR:
+        case DIOR4:
+            dummy_bits *= 2;
             break;
-        }
+         }
     }
 
-    return num_dummies;
+    /*
+     * Assert that the dummy bit count is byte-aligned
+     * as SSI core can only consume whole dummy bytes.
+     */
+    assert(dummy_bits % 8 == 0);
+
+    /* return the number of dummy bytes */
+    return dummy_bits / 8;
 }
 
 static void decode_fast_read_cmd(Flash *s)
@@ -1007,7 +1036,7 @@ static void decode_fast_read_cmd(Flash *s)
         s->needed_bytes += 1;
         break;
     case MAN_NUMONYX:
-        s->needed_bytes += numonyx_extract_cfg_num_dummies(s);
+        s->needed_bytes += numonyx_extract_cfg_dummy_bytes(s);
         break;
     case MAN_MACRONIX:
         if (extract32(s->volatile_cfg, 6, 2) == 1) {
@@ -1059,7 +1088,7 @@ static void decode_dio_read_cmd(Flash *s)
                                     );
         break;
     case MAN_NUMONYX:
-        s->needed_bytes += numonyx_extract_cfg_num_dummies(s);
+        s->needed_bytes += numonyx_extract_cfg_dummy_bytes(s);
         break;
     case MAN_MACRONIX:
         switch (extract32(s->volatile_cfg, 6, 2)) {
@@ -1109,7 +1138,7 @@ static void decode_qio_read_cmd(Flash *s)
                                     );
         break;
     case MAN_NUMONYX:
-        s->needed_bytes += numonyx_extract_cfg_num_dummies(s);
+        s->needed_bytes += numonyx_extract_cfg_dummy_bytes(s);
         break;
     case MAN_MACRONIX:
         switch (extract32(s->volatile_cfg, 6, 2)) {
-- 
2.53.0


