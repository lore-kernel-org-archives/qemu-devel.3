Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D29C43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 08:37:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh1Gt-0003mp-Pt; Tue, 07 Jul 2026 04:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wh1Gs-0003mA-Dr; Tue, 07 Jul 2026 04:35:14 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wh1Gp-0008Pe-Vd; Tue, 07 Jul 2026 04:35:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLNitmepztMzpEKfWZFiN84VQmyYIz5iUFNOEM3vmQ0q6JoJStpZdNAdlB3dCv7y/s+/IbPBc7YknZgKmmVssT7O/Qf/EKYgKYGODF4r0JJNRPztJqnMZl/AdjrKkXdVeqv/rE/AMwP4+kbsTXXP2hT9dPN4Cu3lhuxG8y+MkA8H9DD3OiIkGdLbcaEYmXnNHxWUcX6Aulmgv1sxFI+sOn/JPZWxsLhGWwF+smiaH5iEebR1SoQ7r9KypPqI+47DMxr3c4j82GoIDN2PZxt8bJKn5GmZjgNr2hB3p6YzmBxwivaL/TEbDqUWNUnzjiQCUanydONjODxynXpjaJmFpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UtGMxSUXZ2nHwDNNlC23QHAUZiwWQc0/Fivw6cmmUcI=;
 b=R5czDOb09mE1tIDys/rcZWQw0TeBPzvVRaRfn0v27A4TbHdF9xB46nqn3GEr7k6MKJ5qlHVUBRY7YzyJNWTfbZJtRSFOcR8nvR0JTJHMKmAsRUh3Oi9C/3Pcc2zndgzMyoX8EAowtDCGOsRjl5lHgP1tMQU6xejHzhmeCNpUeEYYev/HDBtIkuqMf7Iv4UJzYuwelvevKDQWEuCtC2fkPQWtWx6RX2FWY9m/rJxFK4yb6BXw2uLSNceBe16hQX3ov0TCYl0ih/D4emHetVUOU9iZCOUUFQbYLI5bOVG8Sy9LzToL159mKKCp3nf/WBfuqFhv4/0znvLjYdj2Y+doeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtGMxSUXZ2nHwDNNlC23QHAUZiwWQc0/Fivw6cmmUcI=;
 b=tyr2wpcBlOggoFoYcDqVhvLkma3yD+NBu3iqotkkHCNOHGlakW+kHDR+xr8MVEAZ7a901dOfiP8IBhhhOpj2D3j89GDX+iY6x4sAkap/H3iGPAAAL0zZv8iPQwHUzDY3XpCTprl/GUSW/Mq9Blzrr9Zof4g+FFG/xFVTARZttwi9xsOk3Bbbwap5n+ZYd9WOifttOqKxe9eGrAtvv3bcqnesqk7fi+Pp8TwJF42cDMPNbIHGcVTBWces6tfSJaW5sUXVC5TjlkSHe8Kqs2pfaBbls8uTBNBmiXjWn3QyoGeOho/8UGJl4kc9vJuVeg3Ei11sDz92vGKVuzwnKHuuxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TY1PPF1A8DB1DA4.apcprd02.prod.outlook.com (2603:1096:408::94b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 08:35:03 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 08:35:03 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v2 06/10] hw/ssi: xilinx_spips: Fix dummy phase handling
Date: Tue,  7 Jul 2026 16:34:25 +0800
Message-ID: <20260707083431.219671-7-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TY1PPF1A8DB1DA4:EE_
X-MS-Office365-Filtering-Correlation-Id: 442c2e8d-9fc2-4f97-f1c8-08dedc02a407
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|34096008|376014|1800799024|23010399003|6133799003|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JIU9VtPbsRbD+C9v99x78lSNidlHASBGPzMLMRiYi8BqwY7P/W7A1ApHDaIjDhWGdh1YKUL0micRM9WlNpvoYUqOsTReWDjGdZmdHMn+6cpE26wbuVINY91V5PlNsd5i0DdQeJzr8WQWUFHccqmkE7myFsa6BRhljp15DoHN+kV3yjgdX54FXmC7l1S1KkBo7Ed6kGMIb23RAP7zEJV/iA1sJf9F8OVlte5VMt2oeQ+M8u7rWKIzJlPSlEYQoX24Fm+zOefIheE2JQw8ZSUTWbmch3CBqUFOuJfW1m2tWCYKrQO+ybUHkZsxnb1WDRxUTzD8Uqb+9x5NmH6xExacv9h/QxA3Amf6FH8zIYYcrMTxCOspt0NhSFArLT7B4BJWf4bXT0XY17iacUm6Q+kIrvUBl8sp1rTcAaGrMt2snPT24yVjcVQNvEj7cfDv4JksruR+ZEPNIEtTSbFQTZKMMKrC6Wb3KJReuuXwJs9CVlRo19YTqv2i5txC3I63JkXAW32QedDDiArSvoS0/KN8+UE3+G3U6M15TDZjFtK1K7sEfQp5tsbm+xkWlCtIN+6vlpA0zaUCxeu0/AqkP43DiTLF4V+SOJLVrL76pbtwBdgoZuSi/I4iaLd0uB7ehocO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(34096008)(376014)(1800799024)(23010399003)(6133799003)(56012099006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elBRSFMzSjJLeE5RSFJkZGx3K2psZ3c4NEhzbUZoeGxaTEIxMEh1THFDNGxB?=
 =?utf-8?B?VG1ZbHA2K0IxeUpXNXJyV2JseFk3dkxCaXlEai94cHhVMkZWVlFXN28wMVF2?=
 =?utf-8?B?ZDRNVkVDeHc4Q3BUZXh5am9vdVQ3MVl2anp3cDBpN3F1WGFNSkN3S2Y1RVJF?=
 =?utf-8?B?Y0NCaGFnVUtVRFdsdHptYVBhVnJyNkQ5RWNyUThHU2JqOTdaV3kxdGhZUUg2?=
 =?utf-8?B?aVpTczllMU0xcW1xdnh5N1hPVk9uQXMreWR6U1lXTGlyWGk5L0dyMkFEY21Q?=
 =?utf-8?B?bW5HMk1YSCtmOUd6NVVjRU9WQ2tGdU9DWE5mcyt0S2x3SExISEwvV1dsKzJ4?=
 =?utf-8?B?cEFwT0ZyT1A3K3FkL1MyZGFEbU9ydnRDRDEvcysrNkhSRjNJd2RhcC9HT3hn?=
 =?utf-8?B?OW9RWHErYU41cVI3cWUrTE9KZmh4VWR3WmU1N0w3QU9DdUdSbFRXNUJoSGhj?=
 =?utf-8?B?MVVsNFQvZFF4cXdMT3RMMnlYTHJrK09GKy9MNkVWMDJmMTR6VHdhL0lHL0NZ?=
 =?utf-8?B?OXhGQjBUMGhBNXBUQXZwb242MUo1VXlESi9TUHhweXlOVmxBTFo5UXJHai9n?=
 =?utf-8?B?ellodEd6RWFRSVpYUUFWZVVmVDBPeVc5TjBlMzc5cXNIM0RMcTJLL1RYS1hh?=
 =?utf-8?B?N2RQeXluL2MvTDJPWERlMHBsTGJNR1kwdjlkUzR4c3FodnpZQVg3OWh6S2FK?=
 =?utf-8?B?bllKUGJBcGFhTUovSkU1MzJnc3V1YzNDelp0MUZEZlVmQ1JRRU9BVE04RTgx?=
 =?utf-8?B?UWJ5NmlVVkVQa1JQd01OZXJmWWRORzYxTFJwN0liWTdZaWc4ZUhKNjE0M015?=
 =?utf-8?B?ZUpPdmtNeUR6OTA1Szc1blNkWWFqSGlrU1l4NmZpZTk1SDBCdkJ5L3A5VW1B?=
 =?utf-8?B?cG4ydGF1TUkzdFg3NDZ5VHRjRDhscUdCQjJRTFd5eVJSY0JRYzhhSjFrYlhS?=
 =?utf-8?B?dTJSTnhQa04wWW1WeEVqOVppblgrYUhhRHVQUmhabmgrQWE2UTlXVmplUzlD?=
 =?utf-8?B?bVlIYjJmM0lLRjdGQWNmTmMxZ3hLTC9uc2JPWG1uWllaM1RFbE5xaSsrZk0w?=
 =?utf-8?B?T3dpYno5UDlxT1lJMzlhTlNjM3Nqck1lc2VYQ2R2TDBnaTB5Vk5UVWw0bXBJ?=
 =?utf-8?B?OUxIY2p5RU8zNnJZcnlpWDdoeUo4NllYSXV6L0diVDNrbENPY1FCRllrZ25L?=
 =?utf-8?B?VzZ1YkVyR2hwcCs1WFhwQlJ1L2Q4VE02SEo2aEgrQ2xyRmhkY1VSN3pDZis2?=
 =?utf-8?B?Q0xBbnhXdHdpRmpoek41MlZQOE9wdmVyV0dTLzhjMm1wdUczL1pqMDJsTXIz?=
 =?utf-8?B?Uk5VTnlyOXJUaWJsa2d4QWtFZnJYSS9PclIwb1pQYjY3NEtidlQ0SEJ4UWRI?=
 =?utf-8?B?REd6bFVmK1lwN1MrS2tCeTh0dkJmeHdINnRiREhGcitEMkx4RFJxRUdtK3lx?=
 =?utf-8?B?ZFZmS1RQa052WHkwYUd0ZHNXd0NBb2Q5Z0dSR1dKRExxQ3FIdDJKbENqWFFV?=
 =?utf-8?B?NS9uZHY3YSsydlViUGlhbHByWFJhSDczWGJMK2JFbi9uT3p6bEtTT2VFUzFX?=
 =?utf-8?B?UGRnN0gwd3hEajZGcERvcmRaRmJyejZmQkRicVBzOTcyNVAvYUlVTkJJQWJh?=
 =?utf-8?B?MXUvcS9DZlcxWCtxNUZoeGVKc1R1S3EwMDdzUGpVa0haQWc5cmh3Q0lBWGpP?=
 =?utf-8?B?OGhPTUsxNGRvSUFvdjM1aVcxTWI0UDN0MHBwbThDeHNLQjJBazRYOGNZVVpM?=
 =?utf-8?B?Q0gwc3NUdU53Z2F6dFhNRFFhalVOVG5sQjdlSUFTOWRCdDFRQWtTVEU4ejlZ?=
 =?utf-8?B?MnNPTHRPWW03djI0MzdyUW5oY01Uc0I4WGxMRXdSV1JGQWJxL0FWVFNNMFIz?=
 =?utf-8?B?b0RhMTJFdkc1MndRRkpoMEZUQXFPWEFjenBTemZKYjlVeHFKYzFDQU1OWURS?=
 =?utf-8?B?NW9CWkQzT1NrM1ZOa1pTL2xhRXEzRXprK3BmR3NjN0xrRUJTQ2JlZlV6M0l2?=
 =?utf-8?B?U0Zkd3NNSkpxcjg0d0k3bHJkN0F1YU9PbWRxTVhBL1B1VDRWb1krZFY1NFZE?=
 =?utf-8?B?SGJVdm9hQnZVQ2xQSndSV1k4N3UwZmUwUStVemNIM2p6ZlZFRVVFMEVadGEw?=
 =?utf-8?B?eVhnN2VrdkRBVlJJejUzNk9LdUhucklmNE9wNE12QVYxTXBTVEU3SkhLTVMv?=
 =?utf-8?B?dTJlNUU1L2VVZXpCNW1lN0c5V3Z6MWJCSEk4Q24xcU4vTXRDNGZkSVJPb2ov?=
 =?utf-8?B?VmhpMzlsdm50NXVHY1hrMXY0cmxZUkxSRWduYzZ5akpZNTQxNk9JckptYVNr?=
 =?utf-8?B?V2d0a2NBNHNGWTZMNXRTVm1WM091elllYzc3bXY1Zk5FZ2MwazFtNmxwVHJo?=
 =?utf-8?Q?P7R7j7WHHTUfLnc8=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 442c2e8d-9fc2-4f97-f1c8-08dedc02a407
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:35:03.6366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JMRzjPVqmv1RTHaid8t+q1RchZZUQjILn02LBm9HnZrj9E7Ny0fcAo7Bzyr/OSEbC3AQILxVGS+TdVUkThZdsRZ+CIif699MxyvODSxy8DI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF1A8DB1DA4
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=bin.meng@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The ZynqMP generic FIFO encodes dummy phases as a number of
dummy cycles. QEMU's SSI bus transfers whole bytes, so the
controller model must convert the programmed cycle count to the
number of SSI byte transfers needed for the selected SPI, dual SPI
or quad SPI mode.

The legacy Xilinx QSPI snoop paths had the opposite problem after
the m25p80 dummy handling was fixed. They still treated each dummy
byte queued through the FIFO as a request to generate several SSI
transfers based on the current link width. The flash model now
consumes dummy phases as byte counts, so the manual FIFO path should
forward one SSI transfer per dummy byte.

Update the Xilinx QSPI dummy accounting consistently for the generic
FIFO, manual FIFO and LQSPI direct-read paths. Also make the command
table report the dummy byte counts consumed by m25p80 for dual and
quad output reads, and account for the mode byte before LQSPI data
reads begin.

This matches the ZynqMP TRM (ug1085, v2.2 [1]) description of the
generic FIFO dummy cycle entry and keeps the controller side aligned
with the flash model's dummy byte ownership.

The description of the generic command fifo register says:

  When [receive, transmit, data_xfer] = [0,0,1], the [immediate_data]
  field represents the number of dummy cycle sent on the SPI interface.

[1] https://www.xilinx.com/support/documentation/user_guides/ug1085-zynq-ultrascale-trm.pdf
    table 24‐22, an example of Generic FIFO Contents for Quad I/O Read Command (EBh)

Fixes: ef06ca3946e2 ("xilinx_spips: Add support for RX discard and RX drain")
Fixes: c95997a39de6 ("xilinx_spips: Add support for the ZynqMP Generic QSPI")
Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v2:
- correct the typo in the commit message: genenic => generic

 hw/ssi/xilinx_spips.c         | 122 +++++++++++++++++++++++++---------
 include/hw/ssi/xilinx_spips.h |   2 +-
 2 files changed, 90 insertions(+), 34 deletions(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index f6e717bc01..62058fdb88 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -192,6 +192,10 @@
     FIELD(GQSPI_GF_SNAPSHOT, EXPONENT, 9, 1)
     FIELD(GQSPI_GF_SNAPSHOT, DATA_XFER, 8, 1)
     FIELD(GQSPI_GF_SNAPSHOT, IMMEDIATE_DATA, 0, 8)
+#define GQSPI_GF_MODE_SPI     1
+#define GQSPI_GF_MODE_DSPI    2
+#define GQSPI_GF_MODE_QSPI    3
+
 #define R_GQSPI_MOD_ID        (0x1fc / 4)
 #define R_GQSPI_MOD_ID_RESET  (0x10a0000)
 
@@ -237,7 +241,7 @@ static void xilinx_spips_update_cs(XilinxSPIPS *s, int field)
     }
     if (!(field & ((1 << (s->num_cs * s->num_busses)) - 1))) {
         s->snoop_state = SNOOP_CHECKING;
-        s->cmd_dummies = 0;
+        s->cmd_dummy_bytes = 0;
         s->link_state = 1;
         s->link_state_next = 1;
         s->link_state_next_when = 0;
@@ -382,7 +386,7 @@ static void xilinx_spips_reset(DeviceState *d)
     s->link_state_next = 1;
     s->link_state_next_when = 0;
     s->snoop_state = SNOOP_CHECKING;
-    s->cmd_dummies = 0;
+    s->cmd_dummy_bytes = 0;
     s->man_start_com = false;
     xilinx_spips_update_ixr(s);
     xilinx_spips_update_cs_lines(s);
@@ -457,6 +461,7 @@ static void xlnx_zynqmp_qspips_flush_fifo_g(XlnxZynqMPQSPIPS *s)
         int i;
 
         if (!s->regs[R_GQSPI_DATA_STS]) {
+            uint32_t prev_gf_snapshot = s->regs[R_GQSPI_GF_SNAPSHOT];
             uint8_t imm;
 
             s->regs[R_GQSPI_GF_SNAPSHOT] = fifo32_pop(&s->fifo_g);
@@ -484,7 +489,56 @@ static void xlnx_zynqmp_qspips_flush_fifo_g(XlnxZynqMPQSPIPS *s)
                 }
                 s->regs[R_GQSPI_DATA_STS] = 1ul << imm;
             } else {
-                s->regs[R_GQSPI_DATA_STS] = imm;
+                /*
+                 * When [receive, transmit, data_xfer] = [0,0,1], it represents
+                 * the number of dummy cycle sent on the SPI interface. We need
+                 * to convert the number of dummy cycles to bytes according to
+                 * the SPI mode being used.
+                 *
+                 * Ref: ug1085 v2.2 (December 2020) table 24‐22, an example of
+                 *      Generic FIFO Contents for Quad I/O Read Command (EBh)
+                 */
+                if (!ARRAY_FIELD_EX32(s->regs, GQSPI_GF_SNAPSHOT, TRANSMIT) &&
+                    !ARRAY_FIELD_EX32(s->regs, GQSPI_GF_SNAPSHOT, RECIEVE)) {
+                    uint8_t spi_mode = ARRAY_FIELD_EX32(s->regs, GQSPI_GF_SNAPSHOT,
+                                                        SPI_MODE);
+                    /*
+                     * Some ZynqMP GQSPI drivers, such as Linux, use the data
+                     * bus width in the dummy GENFIFO entry only to configure
+                     * the controller mode. The immediate value is already
+                     * the number of dummy cycles for the dummy phase, which
+                     * follows the address bus width. Reuse the previous TX
+                     * phase mode to convert cycles to SSI bytes.
+                     *
+                     * This does not make the model Linux-only. U-Boot emits
+                     * the dummy entry with op->dummy.buswidth, so the entry
+                     * mode already matches the dummy phase. Its opcode and
+                     * address phases are immediate entries, not DATA_XFER TX
+                     * entries, so the override below is not taken for U-Boot.
+                     */
+                    if (FIELD_EX32(prev_gf_snapshot, GQSPI_GF_SNAPSHOT,
+                                   DATA_XFER) &&
+                        FIELD_EX32(prev_gf_snapshot, GQSPI_GF_SNAPSHOT,
+                                   TRANSMIT) &&
+                        !FIELD_EX32(prev_gf_snapshot, GQSPI_GF_SNAPSHOT,
+                                    RECIEVE)) {
+                        spi_mode = FIELD_EX32(prev_gf_snapshot,
+                                              GQSPI_GF_SNAPSHOT, SPI_MODE);
+                    }
+
+                    if (spi_mode == GQSPI_GF_MODE_QSPI) {
+                        s->regs[R_GQSPI_DATA_STS] = ROUND_UP(imm * 4, 8) / 8;
+                    } else if (spi_mode == GQSPI_GF_MODE_DSPI) {
+                        s->regs[R_GQSPI_DATA_STS] = ROUND_UP(imm * 2, 8) / 8;
+                    } else if (spi_mode == GQSPI_GF_MODE_SPI) {
+                        s->regs[R_GQSPI_DATA_STS] = ROUND_UP(imm * 1, 8) / 8;
+                    } else {
+                        qemu_log_mask(LOG_GUEST_ERROR, "Unknown SPI MODE: 0x%x ",
+                                      spi_mode);
+                    }
+                } else {
+                    s->regs[R_GQSPI_DATA_STS] = imm;
+                }
             }
         }
         /* Zero length transfer check */
@@ -550,7 +604,7 @@ static void xlnx_zynqmp_qspips_flush_fifo_g(XlnxZynqMPQSPIPS *s)
     }
 }
 
-static int xilinx_spips_num_dummies(XilinxQSPIPS *qs, uint8_t command)
+static int xilinx_spips_num_dummy_bytes(XilinxQSPIPS *qs, uint8_t command)
 {
     if (!qs) {
         /* The SPI device is not a QSPI device */
@@ -567,10 +621,11 @@ static int xilinx_spips_num_dummies(XilinxQSPIPS *qs, uint8_t command)
     case QPP_4:
         return 0;
     case FAST_READ:
-    case DOR:
-    case QOR:
     case FAST_READ_4:
+        return 1;
+    case DOR:
     case DOR_4:
+    case QOR:
     case QOR_4:
         return 1;
     case DIOR:
@@ -611,7 +666,6 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS *s)
         int i;
         uint8_t tx = 0;
         uint8_t tx_rx[MAX_NUM_BUSSES] = { 0 };
-        uint8_t dummy_cycles = 0;
         uint8_t addr_length;
 
         if (fifo8_is_empty(&s->tx_fifo)) {
@@ -631,26 +685,18 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS *s)
                 tx_rx[i] = tx;
             }
         } else {
-            /*
-             * Extract a dummy byte and generate dummy cycles according to the
-             * link state
-             */
             tx = fifo8_pop(&s->tx_fifo);
-            dummy_cycles = 8 / s->link_state;
+            for (i = 0; i < num_effective_busses(s); ++i) {
+                tx_rx[i] = tx;
+            }
         }
 
         for (i = 0; i < num_effective_busses(s); ++i) {
             int bus = num_effective_busses(s) - 1 - i;
-            if (dummy_cycles) {
-                int d;
-                for (d = 0; d < dummy_cycles; ++d) {
-                    tx_rx[0] = ssi_transfer(s->spi[bus], (uint32_t)tx_rx[0]);
-                }
-            } else {
-                DB_PRINT_L(debug_level, "tx = %02x\n", tx_rx[i]);
-                tx_rx[i] = ssi_transfer(s->spi[bus], (uint32_t)tx_rx[i]);
-                DB_PRINT_L(debug_level, "rx = %02x\n", tx_rx[i]);
-            }
+
+            DB_PRINT_L(debug_level, "tx = %02x\n", tx_rx[i]);
+            tx_rx[i] = ssi_transfer(s->spi[bus], (uint32_t)tx_rx[i]);
+            DB_PRINT_L(debug_level, "rx = %02x\n", tx_rx[i]);
         }
 
         if (s->regs[R_CMND] & R_CMND_RXFIFO_DRAIN) {
@@ -685,9 +731,9 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS *s)
         switch (s->snoop_state) {
         case (SNOOP_CHECKING):
             /* Store the count of dummy bytes in the txfifo */
-            s->cmd_dummies = xilinx_spips_num_dummies(q, tx);
+            s->cmd_dummy_bytes = xilinx_spips_num_dummy_bytes(q, tx);
             addr_length = get_addr_length(s, tx);
-            if (s->cmd_dummies < 0) {
+            if (s->cmd_dummy_bytes < 0) {
                 s->snoop_state = SNOOP_NONE;
             } else {
                 s->snoop_state = SNOOP_ADDR + addr_length - 1;
@@ -697,14 +743,14 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS *s)
             case DOR:
             case DOR_4:
                 s->link_state_next = 2;
-                s->link_state_next_when = addr_length + s->cmd_dummies;
+                s->link_state_next_when = addr_length + s->cmd_dummy_bytes;
                 break;
             case QPP:
             case QPP_4:
             case QOR:
             case QOR_4:
                 s->link_state_next = 4;
-                s->link_state_next_when = addr_length + s->cmd_dummies;
+                s->link_state_next_when = addr_length + s->cmd_dummy_bytes;
                 break;
             case DIOR:
             case DIOR_4:
@@ -720,10 +766,10 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS *s)
             /*
              * Address has been transmitted, transmit dummy cycles now if needed
              */
-            if (s->cmd_dummies < 0) {
+            if (s->cmd_dummy_bytes < 0) {
                 s->snoop_state = SNOOP_NONE;
             } else {
-                s->snoop_state = s->cmd_dummies;
+                s->snoop_state = s->cmd_dummy_bytes;
             }
             break;
         case (SNOOP_STRIPING):
@@ -1152,11 +1198,13 @@ static void lqspi_load_cache(void *opaque, hwaddr addr)
     XilinxQSPIPS *q = opaque;
     XilinxSPIPS *s = opaque;
     int i;
+    int dummy_bytes;
     int flash_addr = ((addr & ~(LQSPI_CACHE_SIZE - 1))
                    / num_effective_busses(s));
     int peripheral = flash_addr >> LQSPI_ADDRESS_BITS;
     int cache_entry = 0;
     uint32_t u_page_save = s->regs[R_LQSPI_STS] & ~LQSPI_CFG_U_PAGE;
+    uint8_t command;
 
     if (addr < q->lqspi_cached_addr ||
             addr > q->lqspi_cached_addr + LQSPI_CACHE_SIZE - 4) {
@@ -1170,10 +1218,10 @@ static void lqspi_load_cache(void *opaque, hwaddr addr)
         fifo8_reset(&s->rx_fifo);
 
         /* instruction */
+        command = s->regs[R_LQSPI_CFG] & LQSPI_CFG_INST_CODE;
         DB_PRINT_L(0, "pushing read instruction: %02x\n",
-                   (unsigned)(uint8_t)(s->regs[R_LQSPI_CFG] &
-                                       LQSPI_CFG_INST_CODE));
-        fifo8_push(&s->tx_fifo, s->regs[R_LQSPI_CFG] & LQSPI_CFG_INST_CODE);
+                   (unsigned)command);
+        fifo8_push(&s->tx_fifo, command);
         /* read address */
         DB_PRINT_L(0, "pushing read address %06x\n", flash_addr);
         if (s->regs[R_LQSPI_CFG] & LQSPI_CFG_ADDR4) {
@@ -1183,14 +1231,22 @@ static void lqspi_load_cache(void *opaque, hwaddr addr)
         fifo8_push(&s->tx_fifo, (uint8_t)(flash_addr >> 8));
         fifo8_push(&s->tx_fifo, (uint8_t)flash_addr);
         /* mode bits */
+        dummy_bytes = xilinx_spips_num_dummy_bytes(q, command);
         if (s->regs[R_LQSPI_CFG] & LQSPI_CFG_MODE_EN) {
             fifo8_push(&s->tx_fifo, extract32(s->regs[R_LQSPI_CFG],
                                               LQSPI_CFG_MODE_SHIFT,
                                               LQSPI_CFG_MODE_WIDTH));
+            if (dummy_bytes > 0) {
+                dummy_bytes--;
+            }
+        }
+        if (dummy_bytes < 0) {
+            dummy_bytes = extract32(s->regs[R_LQSPI_CFG],
+                                    LQSPI_CFG_DUMMY_SHIFT,
+                                    LQSPI_CFG_DUMMY_WIDTH);
         }
         /* dummy bytes */
-        for (i = 0; i < (extract32(s->regs[R_LQSPI_CFG], LQSPI_CFG_DUMMY_SHIFT,
-                                   LQSPI_CFG_DUMMY_WIDTH)); ++i) {
+        for (i = 0; i < dummy_bytes; ++i) {
             DB_PRINT_L(0, "pushing dummy byte\n");
             fifo8_push(&s->tx_fifo, 0);
         }
diff --git a/include/hw/ssi/xilinx_spips.h b/include/hw/ssi/xilinx_spips.h
index c8f6c5053c..d1eefa4ba6 100644
--- a/include/hw/ssi/xilinx_spips.h
+++ b/include/hw/ssi/xilinx_spips.h
@@ -69,7 +69,7 @@ struct XilinxSPIPS {
     uint8_t num_busses;
 
     uint8_t snoop_state;
-    int cmd_dummies;
+    int cmd_dummy_bytes;
     uint8_t link_state;
     uint8_t link_state_next;
     uint8_t link_state_next_when;
-- 
2.53.0


