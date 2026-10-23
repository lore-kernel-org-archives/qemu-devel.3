Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274AD606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 20:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKLdU-00007l-EP; Fri, 23 Oct 2026 16:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1xKLd3-0008Pb-01
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 16:12:41 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1xKLd0-0006uV-FB
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 16:12:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G8jzh+uK89/A8KKkWkh3NU6OVpn4vSiIn+QNZ2P45Lz+Knco0w5tZ0+LoyVxLTzaXaDGL2CTnm7asJTLz/UEfrz+Dg/nbc9fICYaqvBVmOWPq+9Wq3wJVIARoZhX3iVL0wz4L4qeaAIhAMJL4BRxR4fhtoR2m7Ja0lWlVMbGObRT9JbyLKnVuy7avMiF1Ldrf2FtThsda2tZHASK49FdmMvT3BU8KZ1MsBsQNM9E8lNj1KjDBeAO1tKMfar9lj0chiBiO/lkP6vZoh6Dp1GxBptb0UT9Hbdh27aFwzKU5yjZ43gljYuM0d5ryjbHd986rQ3FlCiC+0W/Nh3dxbJZtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtK/Ke6BGmIFGwVOnHAfj9tfGFY1mH+O+sRt1JSHUvo=;
 b=RrI1Bt/sI0SG6WrFrwwhLJJct5D+1/cEdFrkSdyMELLshaZzWKyWtkEc5RtkI2AVxnz5Qzq8aRT4eo7kwRx4Ch5YELwGbx2BIaRUoYNu9RicS/fSAyVyKvzPts6Deycj/TsAqS2kiawI48Ob7Ee+cKBi5X+zJrgpQ1djZ9E7OKk8GqvomVpRCXzceTACaznjoJhC7OlSMYRfgA9WyVP/18Re6dEkILkkKC4WQkzRxYurLGlIiCMYK6P36k8hAxa6EHTIm2gyYuELkxlhbl4ukZ6lzgSApH66FYhdKlk88FJfoZBKEatJnykbO0q3f8Dsi6+M3z+VmmIzubwxnV+tWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=linumiz.com; dmarc=pass action=none header.from=linumiz.com;
 dkim=pass header.d=linumiz.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=linumiz.com;
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com (2603:1096:405:3c::9)
 by SE3PR06MB9019.apcprd06.prod.outlook.com (2603:1096:101:31f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.2; Fri, 23 Oct
 2026 20:12:22 +0000
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01]) by TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01%4]) with mapi id 15.21.0569.002; Fri, 23 Oct 2026
 20:12:22 +0000
From: Parthiban Nallathambi <parthiban@linumiz.com>
Date: Sat, 24 Oct 2026 01:41:58 +0530
Subject: [PATCH v2 4/9] hw/char: add TriCore ASCLIN UART controller
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-dev-ifx-tricore-upstream-rebase-minimal-v2-4-c722e4ca5661@linumiz.com>
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
 Parthiban Nallathambi <parthiban@linumiz.com>, 
 David Brenken <david.brenken@efs-auto.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792786334; l=19306;
 i=parthiban@linumiz.com; s=20241125; h=from:subject:message-id;
 bh=oHtMhMpFzB4haa1xvByIoAaP0CMpyK12JAxcimCT7l8=;
 b=lhOxmy4SmohhVSyjPKleUmYtAq9oVtKI6cvRiZCL9m7cWr0FNNkYAbOK6mvJWSAKqxuTxZOVc
 cu/EoftMn7yCAa9FTe9CiaptOMIp9Er9OC5aKEWoQ/vHiCOsNJeuTyu
X-Developer-Key: i=parthiban@linumiz.com; a=ed25519;
 pk=PrcMZ/nwnHbeXNFUFUS833wF3DAX4hziDHEbBp1eNb8=
X-ClientProxiedBy: MA5P287CA0172.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::16) To TYZPR06MB6935.apcprd06.prod.outlook.com
 (2603:1096:405:3c::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6935:EE_|SE3PR06MB9019:EE_
X-MS-Office365-Filtering-Correlation-Id: 95472c79-d731-4172-4c16-08df3141f2ab
X-LD-Processed: 808466aa-232a-41f4-ac23-289e3a6840d4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|23010399003|376014|38350700014|261021123027099003|261009223027099003|260925021311599003|260925021911599003|260925022911599003|261021121427099003|10067099003|22082099003|56012099006|18002099003|6133799003|261022105027099003|3023799007|261022075727099003;
X-Microsoft-Antispam-Message-Info: /K6Vg6sBL/tN0z05agYqKHq/WEx3yu6Zxlu34wAnR/pndkmsK+7iQAmcCDNX82+rCsqVftgkVh6Fg/yOta9T3GQmCbBU0oEW9NxVYHSaic0Du5h726uUMagEgIvZ5vaFDBtO0oZhVgOVRnQ2qJAoKhqVc4anYyiif6sRB07DyezNW0Dxwrc7YViHdoeKEnttMoOUFsNN94naFZ9nlG0prCleB52M4R5qj7mhi44cEeVlwiwbfzdjskN7/cnUO3CjRl0+SoJGK0jMftqwscIXCoPpU2DEwVuZqbkM3J2jOZzfMS/xSdVNrp2TdYPXwpwE9Mqbisnxx6wrRX59f4UM/4HMAze5yPEJOxDTbNQud2irEmoBOPnOJmnpzNoMBg9qtpXMJkVpyMTnUYlgvQ1DZTbpUBPO8zaEWmW6uLS5z6VEFIq84eE+wNw/DCgj/45C0WBPKBcmMUt8g7fujo2sp1DFRrx8o5Cpy4ACsR4gcZ1C9tV+sHXdDY5a94XCQeAAXvSTPx+6l2wS7kEYJtWWA5Q2UIjGTvMPpSB6ydRF435FKnEkyx/gVUqwALBba5FwQ/Wq5LSTiPnKi4WaYfD0BwJu3KUmDPZGuADalGiQEvjVQxxTPl8vZvXaOvqRRAMlzK7wauMz7zOGcnoB6i81Ogp1OKhyIKM+5tjX1iLtSZ4IITOQiNCzy+gXMT61A/CiY1prAS6eiNiG9BaVkxSazuhuEtPxRzfQQ+YycgyUeTM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB6935.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(23010399003)(376014)(38350700014)(261021123027099003)(261009223027099003)(260925021311599003)(260925021911599003)(260925022911599003)(261021121427099003)(10067099003)(22082099003)(56012099006)(18002099003)(6133799003)(261022105027099003)(3023799007)(261022075727099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWZpUlFIMVkwZERpSkwyRWR6U1dQMW40L2xBbDlrSkt1QzZDb0xHODJ6Y05m?=
 =?utf-8?B?OHM0VzZIVmZ0blJZNWt2QWNKZkJndlN6NU1yeno4d0ZYSHExNWZETzljdUUx?=
 =?utf-8?B?TUNDbmphZVI4dHA3ZWI0dENINThzZmd5d2w2bXFOb3N5MnRwc0pkaXRCOENj?=
 =?utf-8?B?T1BGVXRYQUZiVUxDcytqWWxXSU5zWE5BaHhsWWRQV3N3N2grVDFwNytrUWlS?=
 =?utf-8?B?Y0RvWldLVXMxaGRoVVEyYy9keGQ3YkN2Z2hraTdTSy83N2dQYUQvb3EyY2dX?=
 =?utf-8?B?ZUppb0hQZkRseVkxRXRuNHVvVXRzWk5kUjlwK3kzVjhkOE1rSGhCdjRNUDFw?=
 =?utf-8?B?NFRVc1ljUC8wUTJiVVBDMXFOTHV5TlJidG1OaSt1S3Rtc2hjbDJrY1dQalZv?=
 =?utf-8?B?YnNxakk4Z1ZyRVY5dW4wOXVuOTRabWcvTjQ4R04xYTZ4dzJtVDNvUWsrYThG?=
 =?utf-8?B?UUE2VDlZTGoxMWF3THB6N1BTRGNSSlhqN09zemlNb2JvZWpKci9Ja1JCWXNG?=
 =?utf-8?B?Q2x3MndzK1dnbEVqWHBFVFRBUVJ1T0lsd2k1VldnVnRWakRsUGV0b3VqVW5o?=
 =?utf-8?B?UXJMNlZaN0NvSWRianF5anRod0Y1Qms5WGdZalNjVmdpRG5NaTdZbDVKVmNB?=
 =?utf-8?B?c2VwRzk1VnhJTTFsUURsQjBhMjFwZVFKaVdscmxSeEZZcjVNZk5WYS81K1dt?=
 =?utf-8?B?Z1Y1d2hvTDk4OXpVa0R1N2JtK09hVDE5U0lrSEtqa0VQQ0FwTGJna05IRVV5?=
 =?utf-8?B?K09BZzRVc1NkWE8xdTZUeGp3akZwaVVNZFJ6dGpFMGZaTWtBNmNXV2lUbDd3?=
 =?utf-8?B?SXFZa0RISE5Yc0JLTkJmdDBTTzNkRWR5QTJxWkNOM3E0aG1lL0JZREFjS1U0?=
 =?utf-8?B?UlUvb2REaDc4WWZtdkd0dHZ2TDM5MHp6NWFMZDZBaVhvWkpGVFFHSUtHNTZR?=
 =?utf-8?B?RjdTWVpXNVp0RUhZaHZmYVBmdFFLZjc4VCtaOWtUSGl2c0ZlU3hlS0NFMmdX?=
 =?utf-8?B?NGpHUTZkUk1Ca2dwZ2xkM3l2bWpXeVRHMWNXcXFGY3BhWGZacjJMNU9SV0ZU?=
 =?utf-8?B?c2ZkMjQxYmdOckRhMmgwY0pBTWVnMWlBRlpaM3NiOUJ0cWdXWmROUGFxS2Jt?=
 =?utf-8?B?RzdkV1VXZmlXc1BSQmJGOVJ3UTJmUFN1ZGhLVUs0RG4xNjVNOGMxRVZLRmF6?=
 =?utf-8?B?ZGhCNWlTQTdVaGJvSStSdHZDUWszL0l1YmlsdWdKcnAyOEtScHZrckxzZFU2?=
 =?utf-8?B?ZzR3TlU2V1BsaEFNK3M1UWFMS3R4Z2laNHZ2US96M0IvbkVMNWEwUEFQZ0ox?=
 =?utf-8?B?bGtwUXFSaGdhckhteDRkeTJGelkxWTlkL1VKcFJZdkxESzRNcGFvTDF6L0FP?=
 =?utf-8?B?UWpwTWR2SkdzT2E0WlhoZmNGQWMwVmZpaHJRNUF1NnJhS1FFVjFwQ0dCZUY0?=
 =?utf-8?B?V0hYMFJDTXVNSW93UUVDeXU2LzV3dyszMktHbTViMU5INVZWYUJvU2Q2Vm53?=
 =?utf-8?B?Z1dOR0t0bisvYlBjUisxcURIL29zR2tYUkVTQ2pIVERrT2hESTZWaXVGQzZU?=
 =?utf-8?B?UCttbzIxOXQ1dlVJc2hlcXNXTTkrY1RXYnduUWlHTUJxMytET2VDMlRJLy9n?=
 =?utf-8?B?V3FZZHFiRVExQzhMRk9sZ1NKUWJRSkpLZ3hXOEhGcGhweCtKRHlsbzVxU2tE?=
 =?utf-8?B?bWhZaCtqaEZ0VUpacnlUWGRPcklvTll4VllhSnhrVUZtNWMrWnF5VkpudEhX?=
 =?utf-8?B?U3ovME55V0lMVEFNUFFYMFVVU0ozQkh6aEpCakJWR0hsMGxjUWxWb2I1YmhY?=
 =?utf-8?B?bDEvbTNHencwUzlXMWZ3M3RSZ0xkRXltMXZlek9NN25ieWtRd2g5U2Jab1Jl?=
 =?utf-8?B?RGNITmI2SzJRcUk2bmk1RFBWL2FGN2VVMHErdWlLclpEQUc5aGpVQ2JsV2lI?=
 =?utf-8?B?TDhuaDlrZWRiWlNJajc5SEdxSll1K0RQQXhQbU9YaDR2eGY3RUE1eEFFcWJi?=
 =?utf-8?B?MFNHQ3VWeEtxNm9JWk44aWNEQmRrV2Z5eFVJQ3NjamFjbmZ3bkdQMFBVV1Jv?=
 =?utf-8?B?SGNyS2orYzNkcE9GR0o3Y3M2WTZIbzZTbmNESnFya1RsSVJ2ajBCRkdlc0R2?=
 =?utf-8?B?SE1hdXBJa09PZ2g4Sk1DVXdvQzllVVlueXlkZ0Z5MGt3eUtTY1l1NjJCWW9r?=
 =?utf-8?B?bTFyM2kvb2dtYkJ4Sm1CRXQwVjI3VVVEaHB2Q1NJRHhMZC9zclJrRnhlbmZk?=
 =?utf-8?B?eEZXMDl1MkdjZ1VHa0pJbGZDaWZQNDBLTzRRV2pxUEdJano0cnViZDVpY09z?=
 =?utf-8?B?K3F2YXdaQW1ONWYzajlrSG9FWGV5dUJtZVZteGZJSmt2OUNpZEtkZz09?=
X-OriginatorOrg: linumiz.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95472c79-d731-4172-4c16-08df3141f2ab
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6935.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 20:12:22.5433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 808466aa-232a-41f4-ac23-289e3a6840d4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5nQBiOXVUf5/tBTJrks0+SFLUttHOOXCuKvsmA/R7N29WghJe7Rky9RdlvdloabkFt8WDC+1OFETz3pabaVCbQ==
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

Model the ASCLIN in UART mode.  TX writes go to the chardev
backend, RX fills a ring buffer.  FLAGS tracks FIFO status and
three sysbus IRQ lines (TX, RX, ERR) are pulsed on flag edges.

Originally-by: David Brenken <david.brenken@efs-auto.de>
Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
---
 MAINTAINERS                      |   2 +
 hw/char/Kconfig                  |   3 +
 hw/char/meson.build              |   1 +
 hw/char/tricore_asclin.c         | 537 +++++++++++++++++++++++++++++++++++++++
 include/hw/char/tricore_asclin.h |  41 +++
 5 files changed, 584 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d9209f043f..5f985ad4e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -478,6 +478,8 @@ S: Orphan
 F: target/tricore/
 F: hw/tricore/
 F: include/hw/tricore/
+F: hw/char/tricore_asclin.c
+F: include/hw/char/tricore_asclin.h
 F: tests/docker/dockerfiles/debian-tricore-cross.docker
 F: tests/tcg/tricore/
 
diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index 7040040641..11eca70181 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -99,3 +99,6 @@ config IP_OCTAL_232
 config DW8250
     bool
     select SERIAL_MM
+
+config TRICORE_ASCLIN
+    bool
diff --git a/hw/char/meson.build b/hw/char/meson.build
index b2250ee6ae..97025d933b 100644
--- a/hw/char/meson.build
+++ b/hw/char/meson.build
@@ -35,6 +35,7 @@ system_ss.add(when: 'CONFIG_SIFIVE_UART', if_true: files('sifive_uart.c'))
 system_ss.add(when: 'CONFIG_SH_SCI', if_true: files('sh_serial.c'))
 system_ss.add(when: 'CONFIG_STM32F2XX_USART', if_true: files('stm32f2xx_usart.c'))
 system_ss.add(when: 'CONFIG_STM32L4X5_USART', if_true: files('stm32l4x5_usart.c'))
+system_ss.add(when: 'CONFIG_TRICORE_ASCLIN', if_true: files('tricore_asclin.c'))
 system_ss.add(when: 'CONFIG_MCHP_PFSOC_MMUART', if_true: files('mchp_pfsoc_mmuart.c'))
 system_ss.add(when: 'CONFIG_HTIF', if_true: files('riscv_htif.c'))
 system_ss.add(when: 'CONFIG_GOLDFISH_TTY', if_true: files('goldfish_tty.c'))
diff --git a/hw/char/tricore_asclin.c b/hw/char/tricore_asclin.c
new file mode 100644
index 0000000000..0142756cc9
--- /dev/null
+++ b/hw/char/tricore_asclin.c
@@ -0,0 +1,537 @@
+/*
+ * TriCore ASCLIN (Asynchronous/Synchronous Interface) UART controller
+ *
+ * Copyright (c) 2017 David Brenken <david.brenken@efs-auto.de>
+ * Copyright (c) 2024 Siemens AG
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/irq.h"
+#include "hw/core/registerfields.h"
+#include "chardev/char-fe.h"
+#include "chardev/char-serial.h"
+#include "migration/vmstate.h"
+#include "hw/char/tricore_asclin.h"
+#include "hw/core/qdev-properties-system.h"
+
+/*
+ * Register offsets (byte address / 4) for TC3x ASCLIN.
+ * Each register occupies one 4-byte slot from 0x00 to 0x50.
+ */
+enum {
+    R_CLC = 0,
+    R_IOCR,
+    R_ID,
+    R_TXFIFOCON,
+    R_RXFIFOCON,
+    R_BITCON,
+    R_FRAMECON,
+    R_DATCON,
+    R_BRG,
+    R_BRD,
+    R_LINCON,
+    R_LINBTIMER,
+    R_LINHTIMER,
+    R_FLAGS,
+    R_FLAGSSET,
+    R_FLAGSCLEAR,
+    R_FLAGSENABLE,
+    R_TXDATA,
+    R_RXDATA,
+    R_CSR,
+    R_RXDATAD,
+};
+
+/* FLAGS register bits */
+#define ASCLIN_FLAGS_TH     (1u << 0)
+#define ASCLIN_FLAGS_TR     (1u << 1)
+#define ASCLIN_FLAGS_RH     (1u << 2)
+#define ASCLIN_FLAGS_RR     (1u << 3)
+#define ASCLIN_FLAGS_FED    (1u << 5)
+#define ASCLIN_FLAGS_RED    (1u << 6)
+#define ASCLIN_FLAGS_PE     (1u << 16)
+#define ASCLIN_FLAGS_TC     (1u << 17)
+#define ASCLIN_FLAGS_FE     (1u << 18)
+#define ASCLIN_FLAGS_HT     (1u << 19)
+#define ASCLIN_FLAGS_RT     (1u << 20)
+#define ASCLIN_FLAGS_BD     (1u << 21)
+#define ASCLIN_FLAGS_LP     (1u << 22)
+#define ASCLIN_FLAGS_LA     (1u << 23)
+#define ASCLIN_FLAGS_LC     (1u << 24)
+#define ASCLIN_FLAGS_CE     (1u << 25)
+#define ASCLIN_FLAGS_RFO    (1u << 26)
+#define ASCLIN_FLAGS_RFU    (1u << 27)
+#define ASCLIN_FLAGS_RFL    (1u << 28)
+#define ASCLIN_FLAGS_TFO    (1u << 30)
+#define ASCLIN_FLAGS_TFL    (1u << 31)
+
+/* RXFIFOCON bits */
+#define ASCLIN_RXFIFOCON_FLUSH  0x1
+#define ASCLIN_RXFIFOCON_ENI    0x2
+
+/* TXFIFOCON.INW: bytes written to the Tx FIFO per bus write */
+#define ASCLIN_TXFIFOCON_INW_SHIFT  6
+#define ASCLIN_TXFIFOCON_INW_MASK   (0x3u << ASCLIN_TXFIFOCON_INW_SHIFT)
+
+/* Interrupt line grouping masks */
+#define ASCLIN_TX_INT_MASK  (ASCLIN_FLAGS_TH | ASCLIN_FLAGS_TR | \
+                             ASCLIN_FLAGS_TFL)
+#define ASCLIN_RX_INT_MASK  (ASCLIN_FLAGS_RH | ASCLIN_FLAGS_RR | \
+                             ASCLIN_FLAGS_RFL)
+#define ASCLIN_ERR_INT_MASK (ASCLIN_FLAGS_FED | ASCLIN_FLAGS_RED | \
+                             ASCLIN_FLAGS_PE  | ASCLIN_FLAGS_TC  | \
+                             ASCLIN_FLAGS_FE  | ASCLIN_FLAGS_HT  | \
+                             ASCLIN_FLAGS_RT  | ASCLIN_FLAGS_BD  | \
+                             ASCLIN_FLAGS_LP  | ASCLIN_FLAGS_LA  | \
+                             ASCLIN_FLAGS_LC  | ASCLIN_FLAGS_CE  | \
+                             ASCLIN_FLAGS_RFO | ASCLIN_FLAGS_RFU | \
+                             ASCLIN_FLAGS_TFO)
+
+/* FIFO depth and FILL field position in TX/RXFIFOCON */
+#define ASCLIN_HW_FIFO_DEPTH    16
+#define ASCLIN_FILL_SHIFT       16
+#define ASCLIN_FILL_MASK        (0x1fu << ASCLIN_FILL_SHIFT)
+
+static void asclin_rx_buf_reset(TriCoreASCLINState *s)
+{
+    memset(s->rxbuf, 0, ASCLIN_RX_BUF_SIZE);
+    s->rx_rdidx = 0;
+    s->rx_wridx = 0;
+}
+
+static uint32_t asclin_rx_buf_used(TriCoreASCLINState *s)
+{
+    return ((s->rx_wridx + ASCLIN_RX_BUF_SIZE) - s->rx_rdidx)
+           % ASCLIN_RX_BUF_SIZE;
+}
+
+static uint32_t asclin_rx_buf_free(TriCoreASCLINState *s)
+{
+    return (ASCLIN_RX_BUF_SIZE - 1) - asclin_rx_buf_used(s);
+}
+
+/*
+ * Pulse the appropriate IRQ line for each flag bit that is both
+ * set and enabled.  The TriCore interrupt router is edge-triggered.
+ */
+static void asclin_pulse_irq(TriCoreASCLINState *s, uint32_t pulse_mask)
+{
+    uint32_t fired = pulse_mask & s->regs[R_FLAGSENABLE];
+
+    if (fired & ASCLIN_TX_INT_MASK) {
+        qemu_irq_pulse(s->irq_tx);
+    }
+    if (fired & ASCLIN_RX_INT_MASK) {
+        qemu_irq_pulse(s->irq_rx);
+    }
+    if (fired & ASCLIN_ERR_INT_MASK) {
+        qemu_irq_pulse(s->irq_err);
+    }
+}
+
+static unsigned asclin_tx_inlet_bytes(TriCoreASCLINState *s)
+{
+    static const uint8_t inw_bytes[] = { 0, 1, 2, 4 };
+
+    return inw_bytes[(s->regs[R_TXFIFOCON] & ASCLIN_TXFIFOCON_INW_MASK) >>
+                     ASCLIN_TXFIFOCON_INW_SHIFT];
+}
+
+/*
+ * Watch callback: retries TX when the chardev was previously busy.
+ */
+static gboolean asclin_tx_watch(void *do_not_use, GIOCondition cond,
+                                void *opaque)
+{
+    TriCoreASCLINState *s = TRICORE_ASCLIN(opaque);
+    int ret;
+
+    s->watch_tag = 0;
+
+    ret = qemu_chr_fe_write_all(&s->chr, (uint8_t *)&s->txbuf,
+                                asclin_tx_inlet_bytes(s));
+    if (ret <= 0) {
+        s->watch_tag = qemu_chr_fe_add_watch(&s->chr,
+                                             G_IO_OUT | G_IO_HUP,
+                                             asclin_tx_watch, s);
+        if (!s->watch_tag) {
+            goto drained;
+        }
+        return G_SOURCE_REMOVE;
+    }
+
+drained:
+    qatomic_or(&s->regs[R_FLAGS], ASCLIN_FLAGS_TFL | ASCLIN_FLAGS_TC);
+    asclin_pulse_irq(s, ASCLIN_FLAGS_TFL | ASCLIN_FLAGS_TC);
+    return G_SOURCE_REMOVE;
+}
+
+/*
+ * Transmit TXFIFOCON.INW bytes immediately.  Re-asserts TFL and TC flags
+ * so that interrupt-driven drivers can continue filling the FIFO.
+ */
+static void asclin_txdata_write(TriCoreASCLINState *s, uint32_t value)
+{
+    unsigned len = asclin_tx_inlet_bytes(s);
+    int ret;
+
+    if (!len) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: TXFIFOCON.INW is 0, data dropped\n", __func__);
+        return;
+    }
+
+    s->txbuf = cpu_to_le32(value);
+    ret = qemu_chr_fe_write_all(&s->chr, (uint8_t *)&s->txbuf, len);
+    if (ret <= 0) {
+        s->watch_tag = qemu_chr_fe_add_watch(&s->chr,
+                                             G_IO_OUT | G_IO_HUP,
+                                             asclin_tx_watch, s);
+        if (!s->watch_tag) {
+            goto drained;
+        }
+        return;
+    }
+
+drained:
+    qatomic_or(&s->regs[R_FLAGS], ASCLIN_FLAGS_TFL | ASCLIN_FLAGS_TC);
+    asclin_pulse_irq(s, ASCLIN_FLAGS_TFL | ASCLIN_FLAGS_TC);
+}
+
+static void asclin_txfifocon_write(TriCoreASCLINState *s, uint32_t value)
+{
+    /* FILL field is read-only hardware status */
+    s->regs[R_TXFIFOCON] = value & ~(ASCLIN_FILL_MASK | ASCLIN_RXFIFOCON_FLUSH);
+}
+
+static uint32_t asclin_txfifocon_read(TriCoreASCLINState *s)
+{
+    /* Instant-TX model: FILL always reads as 0 */
+    return s->regs[R_TXFIFOCON] & ~ASCLIN_FILL_MASK;
+}
+
+static void asclin_rxfifocon_write(TriCoreASCLINState *s, uint32_t value)
+{
+    s->regs[R_RXFIFOCON] = value & ~(ASCLIN_FILL_MASK | ASCLIN_RXFIFOCON_FLUSH);
+
+    if (value & ASCLIN_RXFIFOCON_FLUSH) {
+        asclin_rx_buf_reset(s);
+    }
+    if (value & ASCLIN_RXFIFOCON_ENI) {
+        qemu_chr_fe_accept_input(&s->chr);
+    }
+}
+
+static uint32_t asclin_rxfifocon_read(TriCoreASCLINState *s)
+{
+    uint32_t used = asclin_rx_buf_used(s);
+    uint32_t fill = MIN(used, ASCLIN_HW_FIFO_DEPTH);
+
+    return (s->regs[R_RXFIFOCON] & ~ASCLIN_FILL_MASK) |
+           (fill << ASCLIN_FILL_SHIFT);
+}
+
+static uint32_t asclin_rxdata_read(TriCoreASCLINState *s, bool peek)
+{
+    uint32_t r;
+
+    if (s->rx_rdidx == s->rx_wridx) {
+        return 0;
+    }
+
+    r = s->rxbuf[s->rx_rdidx];
+    if (!peek) {
+        s->rx_rdidx = (s->rx_rdidx + 1) % ASCLIN_RX_BUF_SIZE;
+    }
+    return r;
+}
+
+static uint32_t asclin_csr_read(TriCoreASCLINState *s)
+{
+    uint32_t csr = s->regs[R_CSR];
+
+    /* CLKSEL valid: set CON bit (bit 31) when a clock is selected */
+    if (csr & 0x1f) {
+        csr |= (1u << 31);
+    }
+    return csr;
+}
+
+static void asclin_flagsset_write(TriCoreASCLINState *s, uint32_t value)
+{
+    qatomic_or(&s->regs[R_FLAGS], value);
+    asclin_pulse_irq(s, value);
+}
+
+static void asclin_flagsclear_write(TriCoreASCLINState *s, uint32_t value)
+{
+    qatomic_and(&s->regs[R_FLAGS], ~value);
+}
+
+/*
+ * FLAGSENABLE write: newly-enabled bits whose FLAGS is already set
+ * must produce a rising edge on the corresponding interrupt line.
+ */
+static void asclin_flagsenable_write(TriCoreASCLINState *s, uint32_t value)
+{
+    uint32_t old_en = s->regs[R_FLAGSENABLE];
+    uint32_t newly_enabled = value & ~old_en;
+
+    s->regs[R_FLAGSENABLE] = value;
+    asclin_pulse_irq(s, newly_enabled & s->regs[R_FLAGS]);
+}
+
+static uint32_t asclin_reg_read(TriCoreASCLINState *s, hwaddr offset)
+{
+    hwaddr reg = offset >> 2;
+
+    switch (reg) {
+    case R_CLC:
+    case R_IOCR:
+    case R_ID:
+    case R_BITCON:
+    case R_FRAMECON:
+    case R_DATCON:
+    case R_BRG:
+    case R_BRD:
+    case R_LINCON:
+    case R_LINBTIMER:
+    case R_LINHTIMER:
+    case R_FLAGS:
+    case R_FLAGSENABLE:
+        return s->regs[reg];
+    case R_TXFIFOCON:
+        return asclin_txfifocon_read(s);
+    case R_RXFIFOCON:
+        return asclin_rxfifocon_read(s);
+    case R_FLAGSSET:
+    case R_FLAGSCLEAR:
+        return 0;
+    case R_TXDATA:
+        return 0;
+    case R_RXDATA:
+        return asclin_rxdata_read(s, false);
+    case R_CSR:
+        return asclin_csr_read(s);
+    case R_RXDATAD:
+        return asclin_rxdata_read(s, true);
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: read from unknown offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+        return 0;
+    }
+}
+
+static uint64_t asclin_read(void *opaque, hwaddr offset, unsigned size)
+{
+    TriCoreASCLINState *s = opaque;
+
+    return extract32(asclin_reg_read(s, offset), (offset & 3) * 8, size * 8);
+}
+
+static void asclin_write(void *opaque, hwaddr offset, uint64_t value,
+                         unsigned size)
+{
+    TriCoreASCLINState *s = opaque;
+    hwaddr reg = offset >> 2;
+    unsigned shift = (offset & 3) * 8;
+    uint32_t val;
+
+    /*
+     * 8/16-bit writes: merge into the stored register, except for the
+     * write-only action registers where unwritten bytes must stay 0.
+     */
+    if (reg >= ASCLIN_R_MAX || reg == R_FLAGSSET || reg == R_FLAGSCLEAR ||
+        reg == R_TXDATA) {
+        val = value << shift;
+    } else {
+        val = deposit32(s->regs[reg], shift, size * 8, value);
+    }
+
+    switch (reg) {
+    case R_CLC:
+    case R_IOCR:
+    case R_ID:
+    case R_BITCON:
+    case R_FRAMECON:
+    case R_DATCON:
+    case R_BRG:
+    case R_BRD:
+    case R_LINCON:
+    case R_LINBTIMER:
+    case R_LINHTIMER:
+        s->regs[reg] = val;
+        break;
+    case R_TXFIFOCON:
+        asclin_txfifocon_write(s, val);
+        break;
+    case R_RXFIFOCON:
+        asclin_rxfifocon_write(s, val);
+        break;
+    case R_FLAGS:
+        /* read-only hardware status */
+        break;
+    case R_FLAGSSET:
+        asclin_flagsset_write(s, val);
+        break;
+    case R_FLAGSCLEAR:
+        asclin_flagsclear_write(s, val);
+        break;
+    case R_FLAGSENABLE:
+        asclin_flagsenable_write(s, val);
+        break;
+    case R_TXDATA:
+        asclin_txdata_write(s, val);
+        break;
+    case R_RXDATA:
+    case R_RXDATAD:
+        /* read-only */
+        break;
+    case R_CSR:
+        s->regs[R_CSR] = val;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: write to unknown offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps asclin_ops = {
+    .read = asclin_read,
+    .write = asclin_write,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void asclin_uart_rx(void *opaque, const uint8_t *buf, int size)
+{
+    TriCoreASCLINState *s = opaque;
+
+    while (size > 0) {
+        if (asclin_rx_buf_free(s) == 0) {
+            qatomic_or(&s->regs[R_FLAGS], ASCLIN_FLAGS_RFO);
+            asclin_pulse_irq(s, ASCLIN_FLAGS_RFO);
+            break;
+        }
+        s->rxbuf[s->rx_wridx] = *buf++;
+        s->rx_wridx = (s->rx_wridx + 1) % ASCLIN_RX_BUF_SIZE;
+        size--;
+    }
+
+    if (s->rx_rdidx != s->rx_wridx) {
+        qatomic_or(&s->regs[R_FLAGS], ASCLIN_FLAGS_RFL);
+        asclin_pulse_irq(s, ASCLIN_FLAGS_RFL);
+    }
+}
+
+static int asclin_uart_can_rx(void *opaque)
+{
+    TriCoreASCLINState *s = TRICORE_ASCLIN(opaque);
+
+    if ((s->regs[R_RXFIFOCON] & ASCLIN_RXFIFOCON_ENI) &&
+        asclin_rx_buf_free(s) > 0) {
+        return 1;
+    }
+    return 0;
+}
+
+static void asclin_uart_reset_hold(Object *obj, ResetType type)
+{
+    TriCoreASCLINState *s = TRICORE_ASCLIN(obj);
+    int i;
+
+    for (i = 0; i < ASCLIN_R_MAX; i++) {
+        s->regs[i] = 0;
+    }
+    asclin_rx_buf_reset(s);
+}
+
+static void asclin_uart_realize(DeviceState *dev, Error **errp)
+{
+    TriCoreASCLINState *s = TRICORE_ASCLIN(dev);
+
+    qemu_chr_fe_set_handlers(&s->chr, asclin_uart_can_rx,
+                             asclin_uart_rx, NULL,
+                             NULL, s, NULL, true);
+}
+
+static void asclin_uart_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    TriCoreASCLINState *s = TRICORE_ASCLIN(obj);
+
+    memory_region_init_io(&s->iomem, obj, &asclin_ops, s,
+                          TYPE_TRICORE_ASCLIN, 0x100);
+    sysbus_init_mmio(sbd, &s->iomem);
+    sysbus_init_irq(sbd, &s->irq_rx);
+    sysbus_init_irq(sbd, &s->irq_tx);
+    sysbus_init_irq(sbd, &s->irq_err);
+}
+
+static int asclin_uart_post_load(void *opaque, int version_id)
+{
+    TriCoreASCLINState *s = TRICORE_ASCLIN(opaque);
+
+    if (s->regs[R_FLAGS] & ASCLIN_FLAGS_TFL) {
+        s->watch_tag = qemu_chr_fe_add_watch(&s->chr,
+                                             G_IO_OUT | G_IO_HUP,
+                                             asclin_tx_watch, s);
+    }
+    return 0;
+}
+
+static const VMStateDescription vmstate_asclin_uart = {
+    .name = TYPE_TRICORE_ASCLIN,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = asclin_uart_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, TriCoreASCLINState, ASCLIN_R_MAX),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const Property asclin_uart_properties[] = {
+    DEFINE_PROP_CHR("chardev", TriCoreASCLINState, chr),
+};
+
+static void asclin_uart_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->realize = asclin_uart_realize;
+    rc->phases.hold = asclin_uart_reset_hold;
+    dc->vmsd = &vmstate_asclin_uart;
+    device_class_set_props(dc, asclin_uart_properties);
+}
+
+static const TypeInfo asclin_uart_info = {
+    .name = TYPE_TRICORE_ASCLIN,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(TriCoreASCLINState),
+    .instance_init = asclin_uart_init,
+    .class_init = asclin_uart_class_init,
+};
+
+static void asclin_uart_register_types(void)
+{
+    type_register_static(&asclin_uart_info);
+}
+
+type_init(asclin_uart_register_types)
diff --git a/include/hw/char/tricore_asclin.h b/include/hw/char/tricore_asclin.h
new file mode 100644
index 0000000000..50642fd0f8
--- /dev/null
+++ b/include/hw/char/tricore_asclin.h
@@ -0,0 +1,41 @@
+/*
+ * TriCore ASCLIN (Asynchronous/Synchronous Interface) UART controller
+ *
+ * Copyright (c) 2017 David Brenken <david.brenken@efs-auto.de>
+ * Copyright (c) 2024 Siemens AG
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_TRICORE_ASCLIN_H
+#define HW_TRICORE_ASCLIN_H
+
+#include "chardev/char-fe.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define ASCLIN_R_MAX        21
+#define ASCLIN_RX_BUF_SIZE  8192
+
+#define TYPE_TRICORE_ASCLIN "tricore_asclin"
+OBJECT_DECLARE_SIMPLE_TYPE(TriCoreASCLINState, TRICORE_ASCLIN)
+
+struct TriCoreASCLINState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    CharFrontend chr;
+    qemu_irq irq_rx;
+    qemu_irq irq_tx;
+    qemu_irq irq_err;
+
+    guint watch_tag;
+    uint32_t regs[ASCLIN_R_MAX];
+    uint32_t txbuf;
+
+    uint8_t rxbuf[ASCLIN_RX_BUF_SIZE];
+    uint32_t rx_wridx;
+    uint32_t rx_rdidx;
+};
+
+#endif

-- 
2.47.3


