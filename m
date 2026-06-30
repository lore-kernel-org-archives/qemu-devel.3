Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93BFC43327
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 13:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weYz2-00024Y-BQ; Tue, 30 Jun 2026 09:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1weYyq-00023K-J5; Tue, 30 Jun 2026 09:58:29 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1weYyo-00040A-3i; Tue, 30 Jun 2026 09:58:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQYDfaboSTrrPY29LleoI24DjLqSiSGMCfXLxSjjr130EWqq535Rc6JW4rzUYBZUZPNvyAdRreoYiHbuB7K+shcJ2YtUH6VRZj6cMj9cQTYEL8mA/JoWY7NYw8AOKUB/aRfwrbpfs5jfvMW6oOn/iC5+44UkyQPxyJ4PjMzRte83GvPu75p+cQpF24tEJMXcrLVlz7sNaZDhZBzZYnHARq/WSu85ukCjPT0gqkQdyxxVzUvjY73yR7NOZxaspAId24pv129+T1PrajlvjeC0DyKooqeeIw/VljOtgPPU0nkFPFa2V74pLpszBPa2g1y6Hgm5CkDqi83f2fvnomYVaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzD8q5BY2iG8pOglsmPmBqC/035+v+0KOfKNGaB4CBg=;
 b=ArdayxKns9MSpdwrjxX2aHblM7F9fsqpFGtoX6QMfmwQtKm3EQSy7E9ya0cWbIhsquz2yZrXhuOvWihFdDlm9Vv7z731bnQNw9BSq+Cns/5FqFzRifDDMFFlrW42roT4xYdSsx56VsVzNYxtbaXjpxy9EZVLTzCHCntPv0JZfiEUs3gEWSlM00LFoiHfKo00MQt5/5mdFD0NCrefx9Mf/C7HfpJOMDuf8B/7EY+C+rSv+rv163RNPsrzMp/1K+m3PldZcaUt2e/H7IGYVYswE6C9IWnKGHlNAtmyWNuBtLLP2Y+cTLE+3mF/WfsKp1LaEz94cS29FXDHzESfZjJx4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzD8q5BY2iG8pOglsmPmBqC/035+v+0KOfKNGaB4CBg=;
 b=unQK7VW73MR4L1FKcs1cDwMC3SG34Ze2vW5n/svAofjmFFkOMuJYviuk5AyXdqowzytGXW5F6wcdMVqH8QTd8+8320GyNgijcyNm8hk/1GEt3NqdlS9uXZ4Cu19YloPUEcKxcmQ5XQnPO3ygxmB9O99t4SXan7xmxBTP4HZhkPc2htw39fgzsghdEknWlmiHst9Zq7Vd9nT1TSFoD+INhFL8pyqVnyrkcFulUJL2ItBw5Zt6y1yhUA5K1vMtshUjP7SrioUvoUtY3emftc8kiyU8W9m1/CbAWdoQ889XYry9/preqRp5St0dso9N67BD+Ok+8v4EA21DbkxAbUXH8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYPPR02MB8959.apcprd02.prod.outlook.com (2603:1096:405:382::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 13:58:08 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 13:58:08 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH 06/10] hw/ssi: xilinx_spips: Fix dummy phase handling
Date: Tue, 30 Jun 2026 21:57:25 +0800
Message-Id: <20260630135729.466264-7-bin.meng@processmission.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630135729.466264-1-bin.meng@processmission.com>
References: <20260630135729.466264-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SE2P216CA0161.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2cb::15) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYPPR02MB8959:EE_
X-MS-Office365-Filtering-Correlation-Id: 024ac769-cf2c-4257-b37e-08ded6af9d79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|34096008|23010399003|3023799007|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: ba3HGOsj3c3PnepKSbsYeJfWqcuXccZQ8NqDsyHVqM76iLXm8lEszuk+4W6mwJDyR6ukOCc/rHI/OktXEfZ1U2GTXGSpt5DK9CTuAsAyuzNIiRh50NNsZI6emj7FGxt3URcUQQgfvbMM7jlfkbklseRkx9ueSqQQvJ9ikEkkaDR/qH8xbVGbhYpdl4Lf3zpuGUtGbfHuhUmsoSLO5YX+G+bw9aXzPtmOTRfR/cH+xM4meJE+9QWxMSVkjDQuQKSxfBY5PpgpiXLOqTAAr7hDJAJ4Rrqce3cCpIIAqeodkUdqR6OLDRCl+F/YovBj1B+W0aEn8z5vk1sc5nNF9mee3S69340r4BJOiHRuqV2Or7iTpZGPZJiDI+VHDquJWDgZHb+1uEK+ZGGCD27J9X9HFaJ/3dgV/h2Ugg1gPH1afZL7VEzAIobjBLF3J9BNlJPV2MRKgrC9RGG2H7Fr0IDYTqYl8ek3z29azTjASND4jWjVsGiZCpQCjxkkY+94rnpnP7pkXbbwYnXJMO2oOWvASLz2kMpoEg0uZ7wwNi5OcP3dqnXIP2GbDp9vmO7CR922MQbo9+mS+nKYU0lBBtLihTlX5Diiy/ClDCPI7VoKBVgxKGbWM7+jvkoZrWd9YzW6zPati53x6tJMIYEvT62TJ/YeXpyanJL6oxUUFPudA4M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(34096008)(23010399003)(3023799007)(6133799003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0doNjRZWUVUREo5ejVzQ1dWWTBRN3h0MjBjQlR4MTQrUFVYK0JFS1dhNlNm?=
 =?utf-8?B?N0xPdHBhTDVJVGREakhuUGY4L2pxN0h0aEdDSnY1Ykp0bSs3UDdJL0pZU2Y0?=
 =?utf-8?B?ZGt2c2RESkxLNksyYXAzTzEwc1M0Mk9rTjhPMXR3clRsL0FVckV4UWlIeTlm?=
 =?utf-8?B?MkxCYmZYQlQxTGt5S3VrNG9la3NzZTBQdlR2T3JjOUcxZm5EOUtwYXFrQnlK?=
 =?utf-8?B?STM2R2p0L0Q3Z3BCMTB6ellUNklYZzhEM0xxVTk4aE5HbC9QOWs1eXR2RUtP?=
 =?utf-8?B?VDgvR1dFVkFBN1NGYUxvT3ZnWTBwU1NzeGVaaGZkcXc5TlN6RFowbkVJaXdS?=
 =?utf-8?B?S1FpNkFYS3o0RVBDblo3VkhqUkhGRHpQeUsrR0FDQVhjRnk3NFliUkVHNlZV?=
 =?utf-8?B?bjRnU3B5OTg3ck5HelUvaVNHQlZ1UXhjNzFxNXdLdTE4M2huaTAwcSt4K1ZS?=
 =?utf-8?B?U1dCTWFjU0FvejhwaFhMUDdQVGFKUmJXREovR1pvS3hKYzJzVnJIdU1YbTdh?=
 =?utf-8?B?TjRueVRSeUo0TjJEcXpENG91bmZ4bWlWZUpQd0d0UnNMNHpNeTNwZXFIb0ll?=
 =?utf-8?B?R3JnclU5cmdQVHBHQ0pCK3cyZHc1Z2ZtUE9IekF0cEhqSHRtZkJkeTBBVlZh?=
 =?utf-8?B?ZmdRRnJZTFlkUXQrZWw0VkQ1a2FMbzFEU0NCRzRFQ2cwc1NxaXV6dUhnZVhl?=
 =?utf-8?B?aUp6bDlVRnJWWlJDOFNZbEJWanE2OGs2b2JYbHhMVThiWlE0YW9ZcHMvT0FL?=
 =?utf-8?B?K0Rtbm4wa2FuU2Y0d2JOcWhHSndGajJJc2pncGJlSUN6TytHRzRQdVRQYzFr?=
 =?utf-8?B?R0ZVWktPa2xWcFFiWU5JZm5KaVhjSW9IRlNwaDhEU2ZrbHdOb3RxVnBnTjJs?=
 =?utf-8?B?MVBYRUoyT2Y1ZlpvWHBSemtYK2FhYzZoZGFoNUxESFNnRk9YRk1ja2JrbXpO?=
 =?utf-8?B?OWtiUlRJRHZDYUp2L0IxZG5nSUU0U3FIck1uQjlOMUQ2SHd3Rmd6VzlnU3kr?=
 =?utf-8?B?SWdZQm1kdWtGUmhKbzdHV2VLRndWTDJuT2dGNmVOWWIwWTlqVDMrWkpIaUhY?=
 =?utf-8?B?NEZrY2JTeVBFME5sR1BkcXd5QnM3Qm1DK1NQVzc4NHJqZ2lzTjNOVlFjQzk5?=
 =?utf-8?B?ZEdacThoUVl6cUY5U3FibEdtWHJUWGRsK1RaQWwxamM0SHJBa2FWc0g5K2Ju?=
 =?utf-8?B?WE53aHdJanAwdGF2bVJtbmJsUjhNbHcyZ052T2hRYUpaTnpCVWpuZlphQkFB?=
 =?utf-8?B?ajlGYVlNS1hkM2Q3TXhYVnNFMmpiSXhFZWEwT0E1cFdXQmlOWnAxUVIxeUp1?=
 =?utf-8?B?bi9Nc3VpTEt1cjhxWE9tbTJYbUtKQSszbmU3UllZc0NDVjNuZFJPdG5WYWlr?=
 =?utf-8?B?RTUwVnF3Y3R5bkxBRHlpNkpkSHNtM3JmZ3BFNnhZb29HajF2T1poVGc2bU9P?=
 =?utf-8?B?S2g1dFR5VS9pUEFoY3NCMEZwalF3TWFlK2VvZ2cwdVlITXpqaGpkZjRKVVhQ?=
 =?utf-8?B?NlJUQ1BMUUVnOFhmdlhwR2hFWE1mYnVzaHFwd0VveGxtVGhkRXYzU1hQVXd2?=
 =?utf-8?B?eVkzUklwellPaGIzeUNzZ0d5dU5tclc1RXJOczROanl4TXdlTDNDZGlhVnR6?=
 =?utf-8?B?QmlHRWNHQmRuNVo1NkRYTVFCNGRneWZTSEprT1VOYzhDQ1lGVUFnbGI2NGNp?=
 =?utf-8?B?L3Y5K01zdHVETWpJemVWbnBQY1lUam80cHpIaWZodkN4YjJjUktpdEEvQit5?=
 =?utf-8?B?UzlueXJxMlRSeGFvTGZJRlJUK2daNDU2MkVTM0FwaU5OR0swcmxMZ3I3Q0JD?=
 =?utf-8?B?UUpUVld4OFdqVk9qVFBnUUdJSWFVeG56RWdwQ3hMYmZXYTEreWZmbThSMlBD?=
 =?utf-8?B?ei9JLzVFRnNkUTdVVitaOGFQb3VoN3k3YUtPVi9MTzFQMGdRZjdlOHJnL0po?=
 =?utf-8?B?WngvTk9iMlFWbVFiQTBMRGcvOS9CditVRnFPVnRWWmF5TVEzWm9RNUdqWVYw?=
 =?utf-8?B?WU4zNllWSWxYTGgybDNyb3hCN0IvVS9QY0JFaXBmUXcrVXdhYUtBcTJVc0hB?=
 =?utf-8?B?YlZEZjd4bGVNbzluTWpNYml2YjJCWWE4Y2JwOWRqT1JuNC9Idjc0Z2Iyd0Ra?=
 =?utf-8?B?S0ZqaFZoZUxRYnlxQWVXdTBpNXNONmtRTFRYMzFGaDhZNkRpTUtobFk0TnV5?=
 =?utf-8?B?eFhzZnBoaXhUeXY2VFNIelFzeHJoeFJQakdJOE5aQ1NJNzNOZ3pDMjRhRm5K?=
 =?utf-8?B?RlptS1d4OTE2SFBQT3VwVVlueEh2U1hvb0xaeTBUTGpYdUgwUnRKckNLRUh5?=
 =?utf-8?B?SzlIeEt3SkhzbWVLSEp1ajV2Mkw0VVg1TzZ2QklpN0FoZVFWc01hTFJxYk40?=
 =?utf-8?Q?Cyb5rkq+T2YTEKH0=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 024ac769-cf2c-4257-b37e-08ded6af9d79
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 13:58:08.4409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CumEsFOeyGyKHJLS2wPeek7fXSWTkDgpbqUfuSAnYnIOacdeo5W1iaXc+Rku0TVex7oXpzSnUjtEqCV5w1yvykEYdk+KmjhhulLhwnEh314=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR02MB8959
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=bin.meng@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The description of the genenic command fifo register says:

  When [receive, transmit, data_xfer] = [0,0,1], the [immediate_data]
  field represents the number of dummy cycle sent on the SPI interface.

[1] https://www.xilinx.com/support/documentation/user_guides/ug1085-zynq-ultrascale-trm.pdf
    table 24‐22, an example of Generic FIFO Contents for Quad I/O Read Command (EBh)

Fixes: ef06ca3946e2 ("xilinx_spips: Add support for RX discard and RX drain")
Fixes: c95997a39de6 ("xilinx_spips: Add support for the ZynqMP Generic QSPI")
Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 include/hw/ssi/xilinx_spips.h |   2 +-
 hw/ssi/xilinx_spips.c         | 120 ++++++++++++++++++++++++----------
 2 files changed, 88 insertions(+), 34 deletions(-)

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
diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index f6e717bc01..fa98dc2dd8 100644
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
@@ -484,7 +489,54 @@ static void xlnx_zynqmp_qspips_flush_fifo_g(XlnxZynqMPQSPIPS *s)
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
+                    uint8_t spi_mode = ARRAY_FIELD_EX32(s->regs, GQSPI_GF_SNAPSHOT, SPI_MODE);
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
+                        qemu_log_mask(LOG_GUEST_ERROR, "Unknown SPI MODE: 0x%x ", spi_mode);
+                    }
+                } else {
+                    s->regs[R_GQSPI_DATA_STS] = imm;
+                }
             }
         }
         /* Zero length transfer check */
@@ -550,7 +602,7 @@ static void xlnx_zynqmp_qspips_flush_fifo_g(XlnxZynqMPQSPIPS *s)
     }
 }
 
-static int xilinx_spips_num_dummies(XilinxQSPIPS *qs, uint8_t command)
+static int xilinx_spips_num_dummy_bytes(XilinxQSPIPS *qs, uint8_t command)
 {
     if (!qs) {
         /* The SPI device is not a QSPI device */
@@ -567,10 +619,11 @@ static int xilinx_spips_num_dummies(XilinxQSPIPS *qs, uint8_t command)
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
@@ -611,7 +664,6 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS *s)
         int i;
         uint8_t tx = 0;
         uint8_t tx_rx[MAX_NUM_BUSSES] = { 0 };
-        uint8_t dummy_cycles = 0;
         uint8_t addr_length;
 
         if (fifo8_is_empty(&s->tx_fifo)) {
@@ -631,26 +683,18 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS *s)
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
@@ -685,9 +729,9 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS *s)
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
@@ -697,14 +741,14 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS *s)
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
@@ -720,10 +764,10 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS *s)
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
@@ -1152,11 +1196,13 @@ static void lqspi_load_cache(void *opaque, hwaddr addr)
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
@@ -1170,10 +1216,10 @@ static void lqspi_load_cache(void *opaque, hwaddr addr)
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
@@ -1183,14 +1229,22 @@ static void lqspi_load_cache(void *opaque, hwaddr addr)
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
-- 
2.34.1


