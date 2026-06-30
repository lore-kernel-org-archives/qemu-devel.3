Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B2AC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 14:00:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weYz7-000268-71; Tue, 30 Jun 2026 09:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1weYys-00023w-SE; Tue, 30 Jun 2026 09:58:32 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1weYyq-0003om-Vu; Tue, 30 Jun 2026 09:58:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/blmQRDJkux9soLPvDFuKkbx49Fi+JxUOG7oZ+wBITKgZKHbhrKdJIHFzvSpmijYZE/x6eRbhFzvwDMsrXMmSSikTnKY8igrGA6qaJN60j4KYl+ji84kE5a6kkmjzFE1D90hHqeAMc7gUFhw4x1eXDJuARQzv39ZUggsaeHmFW4+07tHe4SVsu8FaDPsD7XD9tEQXxaC/CtFtvVU7GEVk4QkYL52N3HVhoRjGZ169bny2BpGwUNQUlZ+6GbX8mAq17MP8B51zR/WMIo2x2JHr3daFVMYboUGh/v0jyqLlCuruWJk3VLQvyG1wHR/cZdzcL5ePBqspppozcnlAE+rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbCj2tP2kDYscwQyGmkrxWJbt0IrvGxWtGBkGkl7Nak=;
 b=Y89y7IfFU9DdZT6s7BBiuGpb3C6JO3fnxzCR37J6fPoLsc/dmAu0kxTP9EW/8KrIqXEN8VhHcs125Ea5jZ4MnN65z7qjMAw1XbAWEsNJSUZWKWWGoMA7TzeAcpzTR+CWbUY+gNSFCoUPUA+VtQQ7B/76KNFFQwqNnye+8fJxoEkiRUbArz4Q89XntyQF+b4pmdM1vSVGJGFeIxbV/J1DaX6zfXIDschgjg/OvxrqR+HbsX5ozWXwcvih70e455ApOULwzmOKsVIWpHO37kKRX5TVDQJvljXxf81JL32TXwwCGZJHzgLwUKEk0G/IrP9ueNxWxlEJKRN13cX4a1t4xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbCj2tP2kDYscwQyGmkrxWJbt0IrvGxWtGBkGkl7Nak=;
 b=pY3iFfEY3HhiptLpHKkqfOjj8nzv1uEf/X/yw1j+vDT+NXcilSlccRB3JAaq983t9+lSPpOHLdP7HKQ8i7E9fGsnWjmQr7gjCAxHGO/iRm3pWHLwqTRFHDmVNtcEVl76mtuNrFrgCyWewJEqY+8rUaFGUw6RPFgvtCrnP7O5Tre2Fq9X2CDl2QLr9LzkMxifdEiesaHDRImG9JqO5Gec69JkP8kFHXmkBZEKGstmjriC+3kZphSX/AkGkwQ5rZEMy2dTXNtkSradfig/XqAdr/UrDMDp6KEw/vIuJJFlJY0PeNEDjUy5g49LQfry8ms8aAe+D2ecidO1GR21yFGFwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYPPR02MB8959.apcprd02.prod.outlook.com (2603:1096:405:382::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 13:58:17 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 13:58:17 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 qemu-arm@nongnu.org
Subject: [PATCH 09/10] Revert "aspeed/smc: snoop SPI transfers to fake dummy
 cycles"
Date: Tue, 30 Jun 2026 21:57:28 +0800
Message-Id: <20260630135729.466264-10-bin.meng@processmission.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630135729.466264-1-bin.meng@processmission.com>
References: <20260630135729.466264-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0161.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2cb::15) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYPPR02MB8959:EE_
X-MS-Office365-Filtering-Correlation-Id: 85935784-7f7a-404a-8d63-08ded6afa2a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|34096008|23010399003|7416014|5023799004|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: kARvLMFf7SKyw3OzGvD6Lc0OFJSWtG4QOWh3I6QdyeIMIFlZlrstBbxJVVXjwTOSX++Nyw9E5/+I+/nXD5MVVDFIfJ8ToBTPb9KcJZ0hBKFPiZaX8nQB3p2QznC4Kise+xX8SoTa5159wAuGrgnjVHcLStfT03Box6DHyoWw8Z5MjHOAmAzo0nojTNO+1F+LZIf38iPaeh+CmyDp3QgcB7cIO79pqwrcn1jU5DL6WfhEv5RAfzlKwC0dwQjWN1yPag5WDr4xVtUTgeq07mbkuCExk3UDfko6vy/+nISpuU1KhICRfn5rrfz32pgDMWVi6SCTDzTg/D/sivRA9l4mgX9Vr2G8D3IjKMQB5irGN5EMtePKWZv60xgq1l2epvxx+34f1HnWYIf7W1QIpXNrkpKOrPLvmESTrvkeQmI78LgU3VnaFVi8ELA/3QZ7Kfqum0RNZUlcnTOCCwSkEtC8kuclo2Td9rJYJbervMmn5L7BN+breBkgnx22xu63S/D64tDYaYZjljy5Tf5d9PyVPmqaVn1Bg+eFlnQ9wZUiMydCpbaH5YMr6KGGVibkpcTC34cFQxQzenw7Ue0l4Oa6C2+wz0J12Pd3sHJMLj0VEKmAn7/ihbQ+SGfYP729afpK1hyzVfSVFMlgTeNRFjw/Wu8RncrLe9NiqNFaHfi1v9Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(34096008)(23010399003)(7416014)(5023799004)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X1PXULAj1trvYLXNXRweJds0gFsMd4fq1FLuKdmF1rB9xBVLtktXHwWJBOIN?=
 =?us-ascii?Q?H4POin/1MDabAvLmgwq6AIhpYLgFlP+bB2xJulXd/QMKhW3SMbgUDqrYDPzU?=
 =?us-ascii?Q?BZUaEnrNyKJYjO+Zxghlj1Clu6kydizBId0ntvhNiHIJh+tSTsZdpQ/Tb3gd?=
 =?us-ascii?Q?HTqMKgXuqQmhEL4AP52O9yORcur8FtremHVrdhwVcJW8AIyG/8EbxcOLMUQH?=
 =?us-ascii?Q?87lVYr6+JeHeYY3TSXn2PYPwZ7fN3fLL2B0ElNT+kTRAsaIQ7pfPcK4rfp6J?=
 =?us-ascii?Q?0s3e/lPQKBlXoKbO36FZFeSqpju2AiAsW9Aw5sE7Kvfw1b3qzmswCukgyN/i?=
 =?us-ascii?Q?pb8BxQyltBrzTIokdJFYTCHp9drWtyw8Kg5+9ioVwMPYAGYN3/ONDV6UxPr/?=
 =?us-ascii?Q?sDwQA8xl8/te6Fren2mPAgegFWmSheaJ/ow+LM7I5JhDZ7vET42i4ytVf+uh?=
 =?us-ascii?Q?tc64Cl1mMz/kgk3Mii+mcGJoN75Xqw2Da9vW/nCQS7tcQWwQ8arvb/BAGuyG?=
 =?us-ascii?Q?R8THH2HqpW8mNUQEp0zLX/yiqdWZqGZn+0bdNYNuT1ZgL9+d/+StPbzVu14T?=
 =?us-ascii?Q?4xEbVRRZ43F35jsAxqtxMZMYLVaOEIE3Iqig8sGMPkC9nGHpoj2wK9DjRAkr?=
 =?us-ascii?Q?rDU/WZuDISECTINPh9Q/YsLe/lgwFbAN+SdrKeuYq+2IhwLxJVZ32Am1N004?=
 =?us-ascii?Q?q2BP92rjJuWymvY4zGf56iqqFGN7Y0kpOU+En5Vad+y2loaQugAPRLaWnCpZ?=
 =?us-ascii?Q?Zfab8xKDbZ46zHooXnIIjSetgPYjBML4Kjfb7Hb+YDnrZxCLeBCYajwQTzm0?=
 =?us-ascii?Q?d4jlfrGY9JkJS74mDEw+Bye5Zs7awpSDFkFCQtb0om8D5P0aZ0DMe2scFULk?=
 =?us-ascii?Q?nrQ1yhNx8xaPVxy8T7zeDSgaDtfFDpO+F6RSstQrOrDJrYaEFQil9vhbq5bK?=
 =?us-ascii?Q?0I5zG8CGhR+BdNUe6Bmxbu8KAGwnNrA4vvlfgYXq33Y5dgrjk+VloFElQw8E?=
 =?us-ascii?Q?tjdkzcih6mdILwNeFUIHT6JABOedK7RN37XEgT2cpio5b4XYdTdHDwTay/iR?=
 =?us-ascii?Q?L5QQEF3w6yPfzOQJhXYW15YMcGaGOmcTW5jY68s9nqKKsnit/gTq8Lh5ya6+?=
 =?us-ascii?Q?OW03Yx+GO1EmHNG3PC8EXh4vrN6hKSTBqntP2/vofBZEPrFqbeW75p/hxOP5?=
 =?us-ascii?Q?VuaiKSqDYz5GR55zQL/XLcr7Oq+AksTWmC3lfOF0HJSiQL2jhQia2szHZWe4?=
 =?us-ascii?Q?x1GRHhkEozSUTiIiEba8CWelOR9eWNqRFaBhChyr29zfHEpNfmNk5ccvz/1o?=
 =?us-ascii?Q?+BhSJiB1TAfppNqDIQ8L1tfxrDTHuErJVNDdUBxnVLCegUwQPWTxavDWS3qQ?=
 =?us-ascii?Q?yAGgAJa0WE9ckb8RQsbeufSJTwrgWNnPzv8QUswlGIZGzTEyDZB5qx/04BGY?=
 =?us-ascii?Q?fugZxZGgUFNrRCwX/dzTNgQoZMrQhGJDuMIXM3+9F/pgca4+Jm5Q3ABqI59t?=
 =?us-ascii?Q?x5nmMDfCj1agNmP9FOk3tnNv7t85AEv33p/zuM/UprLN4a9K1FXdEKda4zP8?=
 =?us-ascii?Q?u2MzSw6/gh4KBA/Q7rlTDCkl6yRgMIGfTN4LCqNQMLuw+7CFFGDKaQQDBwJ7?=
 =?us-ascii?Q?TBE0f00dhfTYjVEOeL/vg/Pi2e2xVnjCpmgtJZJSJBE1YYBUdLYf+H+5Oyr/?=
 =?us-ascii?Q?kck9Sc7u57rW7pi5xE3SsRSmxFasOpHiNxDXzdcdv739nJpGFCHy4R5MF8zg?=
 =?us-ascii?Q?/z+bInUHIjIh/lMlF0e2ag3uqiNON2c=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85935784-7f7a-404a-8d63-08ded6afa2a6
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 13:58:17.1370 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WBofoP4lO1ZeZ4uVObMfs2FOe2Ez1wqMG0mAyAKddAZpLYuI8uzwByF9ridSlHV+X555xGaO5I9zcqXhsqnMrWCSM1VISm7GJAVq1dDa1Mo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR02MB8959
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

This reverts commit f95c4bffdc4c53b29f89762cab4adc5a43f95daf.

The m25p80 model now accounts for fast-read dummy bytes in its
command decoder. In ASPEED SMC model user mode, guest software
already sends the complete byte stream, including any dummy
bytes needed by the flash. Hence the model should just forward
exactly the bytes supplied by the guest without the need of
decoding guest-supplied flash op codes to inject extra dummy
transfers.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 include/hw/ssi/aspeed_smc.h |   2 -
 hw/ssi/aspeed_smc.c         | 114 +-----------------------------------
 hw/ssi/trace-events         |   1 -
 3 files changed, 2 insertions(+), 115 deletions(-)

diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
index 76831422c6..a273365689 100644
--- a/include/hw/ssi/aspeed_smc.h
+++ b/include/hw/ssi/aspeed_smc.h
@@ -80,8 +80,6 @@ struct AspeedSMCState {
 
     AspeedSMCFlash flashes[ASPEED_SMC_CS_MAX];
 
-    uint8_t snoop_index;
-    uint8_t snoop_dummies;
     bool unselect;
 };
 
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index c2a732664b..287a46eef3 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -197,9 +197,6 @@
 /* Flash opcodes. */
 #define SPI_OP_READ       0x03    /* Read data bytes (low frequency) */
 
-#define SNOOP_OFF         0xFF
-#define SNOOP_START       0x0
-
 /*
  * Default segments mapping addresses and size for each peripheral per
  * controller. These can be changed when board is initialized with the
@@ -537,104 +534,6 @@ static MemTxResult aspeed_smc_flash_read(void *opaque, hwaddr addr,
     return MEMTX_OK;
 }
 
-/*
- * TODO (clg@kaod.org): stolen from xilinx_spips.c. Should move to a
- * common include header.
- */
-typedef enum {
-    READ = 0x3,         READ_4 = 0x13,
-    FAST_READ = 0xb,    FAST_READ_4 = 0x0c,
-    DOR = 0x3b,         DOR_4 = 0x3c,
-    QOR = 0x6b,         QOR_4 = 0x6c,
-    DIOR = 0xbb,        DIOR_4 = 0xbc,
-    QIOR = 0xeb,        QIOR_4 = 0xec,
-
-    PP = 0x2,           PP_4 = 0x12,
-    DPP = 0xa2,
-    QPP = 0x32,         QPP_4 = 0x34,
-} FlashCMD;
-
-static int aspeed_smc_num_dummies(uint8_t command)
-{
-    switch (command) { /* check for dummies */
-    case READ: /* no dummy bytes/cycles */
-    case PP:
-    case DPP:
-    case QPP:
-    case READ_4:
-    case PP_4:
-    case QPP_4:
-        return 0;
-    case FAST_READ:
-    case DOR:
-    case QOR:
-    case DOR_4:
-    case QOR_4:
-        return 1;
-    case DIOR:
-    case FAST_READ_4:
-    case DIOR_4:
-        return 2;
-    case QIOR:
-    case QIOR_4:
-        return 4;
-    default:
-        return -1;
-    }
-}
-
-static bool aspeed_smc_do_snoop(AspeedSMCFlash *fl,  uint64_t data,
-                                unsigned size)
-{
-    AspeedSMCState *s = fl->controller;
-    uint8_t addr_width = aspeed_smc_flash_addr_width(fl);
-
-    trace_aspeed_smc_do_snoop(fl->cs, s->snoop_index, s->snoop_dummies,
-                              (uint8_t) data & 0xff);
-
-    if (s->snoop_index == SNOOP_OFF) {
-        return false; /* Do nothing */
-
-    } else if (s->snoop_index == SNOOP_START) {
-        uint8_t cmd = data & 0xff;
-        int ndummies = aspeed_smc_num_dummies(cmd);
-
-        /*
-         * No dummy cycles are expected with the current command. Turn
-         * off snooping and let the transfer proceed normally.
-         */
-        if (ndummies <= 0) {
-            s->snoop_index = SNOOP_OFF;
-            return false;
-        }
-
-        s->snoop_dummies = ndummies * 8;
-
-    } else if (s->snoop_index >= addr_width + 1) {
-
-        /* The SPI transfer has reached the dummy cycles sequence */
-        for (; s->snoop_dummies; s->snoop_dummies--) {
-            ssi_transfer(s->spi, s->regs[R_DUMMY_DATA] & 0xff);
-        }
-
-        /* If no more dummy cycles are expected, turn off snooping */
-        if (!s->snoop_dummies) {
-            s->snoop_index = SNOOP_OFF;
-        } else {
-            s->snoop_index += size;
-        }
-
-        /*
-         * Dummy cycles have been faked already. Ignore the current
-         * SPI transfer
-         */
-        return true;
-    }
-
-    s->snoop_index += size;
-    return false;
-}
-
 static MemTxResult aspeed_smc_flash_write(void *opaque, hwaddr addr,
                                    uint64_t data, unsigned size, MemTxAttrs attrs)
 {
@@ -652,10 +551,6 @@ static MemTxResult aspeed_smc_flash_write(void *opaque, hwaddr addr,
 
     switch (aspeed_smc_flash_mode(fl)) {
     case CTRL_USERMODE:
-        if (aspeed_smc_do_snoop(fl, data, size)) {
-            break;
-        }
-
         for (i = 0; i < size; i++) {
             ssi_transfer(s->spi, (data >> (8 * i)) & 0xff);
         }
@@ -717,7 +612,6 @@ static void aspeed_smc_flash_update_ctrl(AspeedSMCFlash *fl, uint32_t value)
     s->regs[s->r_ctrl0 + fl->cs] = value;
 
     if (unselect != s->unselect) {
-        s->snoop_index = unselect ? SNOOP_OFF : SNOOP_START;
         aspeed_smc_flash_do_select(fl, unselect);
     }
 }
@@ -763,9 +657,6 @@ static void aspeed_smc_reset_hold(Object *obj, ResetType type)
         aspeed_smc_flash_set_segment_region(s, i,
                     asc->segment_to_reg(s, &asc->segments[i]));
     }
-
-    s->snoop_index = SNOOP_OFF;
-    s->snoop_dummies = 0;
 }
 
 static MemTxResult aspeed_smc_read(void *opaque, hwaddr addr, uint64_t *data,
@@ -1293,11 +1184,10 @@ static void aspeed_smc_realize(DeviceState *dev, Error **errp)
 static const VMStateDescription vmstate_aspeed_smc = {
     .name = "aspeed.smc",
     .version_id = 3,
-    .minimum_version_id = 2,
+    .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, AspeedSMCState, ASPEED_SMC_R_MAX),
-        VMSTATE_UINT8(snoop_index, AspeedSMCState),
-        VMSTATE_UINT8(snoop_dummies, AspeedSMCState),
+        VMSTATE_UNUSED_V(2, 2), /* was snoop_index/snoop_dummies */
         VMSTATE_BOOL_V(unselect, AspeedSMCState, 3),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/ssi/trace-events b/hw/ssi/trace-events
index 2f36cf96b8..b9d8648297 100644
--- a/hw/ssi/trace-events
+++ b/hw/ssi/trace-events
@@ -2,7 +2,6 @@
 
 aspeed_smc_flash_set_segment(int cs, uint64_t reg, uint64_t start, uint64_t end) "CS%d segreg=0x%"PRIx64" [ 0x%"PRIx64" - 0x%"PRIx64" ]"
 aspeed_smc_flash_read(int cs, uint64_t addr,  uint32_t size, uint64_t data, int mode) "CS%d @0x%" PRIx64 " size %u: 0x%" PRIx64" mode:%d"
-aspeed_smc_do_snoop(int cs, int index, int dummies, int data) "CS%d index:0x%x dummies:%d data:0x%x"
 aspeed_smc_flash_write(int cs, uint64_t addr,  uint32_t size, uint64_t data, int mode) "CS%d @0x%" PRIx64 " size %u: 0x%" PRIx64" mode:%d"
 aspeed_smc_read(uint64_t addr,  uint32_t size, uint64_t data) "@0x%" PRIx64 " size %u: 0x%" PRIx64
 aspeed_smc_dma_checksum(uint32_t addr, uint32_t data) "0x%08x: 0x%08x"
-- 
2.34.1


