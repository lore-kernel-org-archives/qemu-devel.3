Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83919C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 13:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whSLi-0003kQ-Td; Wed, 08 Jul 2026 09:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1whSLh-0003jo-72
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 09:30:01 -0400
Received: from mail-japaneastazon11023096.outbound.protection.outlook.com
 ([52.101.127.96] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1whSLe-0003Za-JT
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 09:30:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COqjhKDO+Raj8I4HqyFpZA2tu+EpzOlD6pFl7WFrTz5zdLSDJ2eI9vMajCCC65d1v0itwIfZrwsIAToPrMRvWuJK1XJDAlMOSlxliJkw9ISUPQIIFVo7eXTKejoiuZQxRpavi8CYPsCENIbT2++UL5Lz3VcJb/IbTNktsB7re9nldB6tu7YCOteHGgKtE6wZ4ECWumxvg/yVGQ9YU9fZRUzD6n8q7uln2nsJt/mV7WJPualHgmxbmlyXdcFQt025oXgzVO8ylR3LmZXEk4ch81GVWu9EsOiym7L1u9crbUWtzoZZa74y2z6HFBYeb/nauTwnLy5NmgxKNPLssPtahw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wk5HUf9GN4QV5WQYvO8TQblRrbfjH8mKdSjGqvgEoo=;
 b=W6VAPovPaboaaDpIdAfWm0g1BLfsLBEootaOgh91rR6XAupK5Hg6SlonCeVfNXmbPQyS6hj9p4vHVcRSukoU3Tso0gIhDdfHyl25Wbxc2hmpimcOisThy6x42uzlFdRjnuHve2/gl21nxzB+YsGwTAAXZWHpgxlwgIdEV+UNHwbfU6O7gRiJds1kMb2sMBimpx2Ah2LTVtnX/atoDQyedOpyQFhr55F5vftntbSv18noc3BTjjBb7nRGUKAcvMavI624ySTg2Qp0jqzqZRrLFW9Fb/QyZse17+MiFckc0i2PnC/tAGWWmxG4BESEGZr4HiHZ2wKlDh4QQRey4tTzNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wk5HUf9GN4QV5WQYvO8TQblRrbfjH8mKdSjGqvgEoo=;
 b=jm/87EgYZwh8YRw9CNe8Num9FC6cZxDri6I1ITVrANJ7Vw6PbrB0bHF0h0NfBeM9aum+vXsxpnsjLzNb3J3EMFOdFnqB5VgPjzjwPmi4BiVrhzq1TNOzlC8r0hSLqm6fHmNKXC+n/C6Lxh6tlixrM1vfhF+OjbXogCGyedYYR5nCC9H/pTiaw7aPsJl+JDwyFum0Pv7QxUOMnk7MN3X3m0LONkdXSPIIj9SCTumYC2gqTIKMXNzplXFAXD1uz1qUbCxPoeO25JbMY41bQPs53ZfySVSfmXBqdZjf/fyoAHs7vH6Ao29FyKkmLk1cvcG77wyLUanG/SIzL1guzdD/ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by JH0PR02MB7512.apcprd02.prod.outlook.com (2603:1096:990:61::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 13:24:48 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0181.014; Wed, 8 Jul 2026
 13:24:48 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair@alistair23.me>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3] docs/devel: Document SSI dummy-cycle ownership
Date: Wed,  8 Jul 2026 21:24:31 +0800
Message-Id: <20260708132431.43869-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::11) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|JH0PR02MB7512:EE_
X-MS-Office365-Filtering-Correlation-Id: d004e2b0-71d3-4e19-6734-08dedcf4485e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|10070799003|1800799024|376014|366016|23010399003|18002099003|56012099006|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: mQmePP0lrfagNiqEnrGnJ216E3IgMZ11a5Wfcrdlt21XGRUd0R5psVnf7uvfK3hzDV59qN+zsb4eW23LAxelQKNy4L3bbgMCNLveOgUhoyvyHWvW9RtVirWZCqccPDYcwRN0IOojB4/06bHnlG5pwkxMtFTGuz85e0rQ7S14rjVrXBptz8o3rAe9fO8jstB/kF0+NEVmaXitzDogRm9nzOWtgEOGDNZRmWetiCEWs/fTiOMimyIs6sSLSf2q0TUpzPLO1XpZTKAVdTCzI9mLIfE1+Zv4XoUXa4RkhBYtuQrQ2SAwB5Ab+wCZg+NExR9+7zCCIhDKU6BgAqt0koMGEKkcDG11LjSBFyiAk7E9qib2SO6TG15Dm3/fZ+RdcfSqqKlKgRZDOgqcuE0a25dyP63Q7GY2gJ1m5qO6y15sC86nMYykmopruTFCg/ebtrblNIdcomP0W4Ictr95w8QoIy6bpiUIJiAwvRV9QGyEdMjK31phyVIexnlBaIdo2iPL4XlzLmB9lcXXafLS5uQD70U1HQ3rxaArhHXwnmHCr942Qs0gswOGRiKT2AJSPr6AOZP8opcEU6yQCBZnMPprE3QlrBDfqEvk3oPnFe/R8c23+7zA+2Meyq80p+NhVntDSRcLgIEAy+a5qA0zkNu2/UV5T9lEMXDgVoMO7gxjwfQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(10070799003)(1800799024)(376014)(366016)(23010399003)(18002099003)(56012099006)(3023799007)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnplNU8zQXZsVjFYNEhpUTBIaHd0c1hXK0ZzUGwrT2pUSGhIVVJHUkg3NUhW?=
 =?utf-8?B?VGdISmJBSkJ5Z3pFRHBrbGFBSE1EYitGbW1FZ0NNenAvQnVkTTN1Y1ZTTG5V?=
 =?utf-8?B?K3lWWW5oU1FTdDJzZFRHTlU2UU90ekJxTWdOSVdOb2hxVks4YklUcGt3R1Bo?=
 =?utf-8?B?TzhBNEJlVkdSajhvM2tjbnlUV0JnakZPWndiR3MzdXFMUWdyeFROcE9Lb0Rh?=
 =?utf-8?B?eHpOS2lHZVZ5R21DbnVVVXFtWXNvSnowdTRsSFpNR0hBdHFTRGVLT0lMcUU5?=
 =?utf-8?B?eVlFSmRpbUZMa0pVSDBXRWNEbDYrZnIwSnlqOUxGdHFXQS8vY1JuVkNmMk1X?=
 =?utf-8?B?dG1JYmFCaXdYUCtzQW1IRWVnYUlZeHcrcllERks0cVd3Q3AxaEI2TkxMTkRW?=
 =?utf-8?B?TlROUWZueE5PL3psYUoybnlvb2pQbmdvZnVIL1JoRjdoYUFoZCtMbFhxckEr?=
 =?utf-8?B?aklqTmtCaklTR2NaL25IWW1sWHBoNU8xY0YrSEFobGowVXBUNlFPQk1KVHdi?=
 =?utf-8?B?U1BjcXBGZEQyeTJoOWJSWjRCNysrSDJvbGp2dE9FUzRIaldleGJPRVZwL2lw?=
 =?utf-8?B?ajdCRDdjcVMvT3krZ1BrQ2ZBRHVkbnIwRksyUWJBM25zY3dJUk5RUG9vUU8w?=
 =?utf-8?B?MmpSQVgxaWo5alJ0ZGJYWWY3K0JSaXp6UHRsUEZkOERlOFJEaDZhaUZPaWJP?=
 =?utf-8?B?VjZjWUk3VHBieVkyUnNTUnFJa2hWeWNTOWFOeS85S24xaXZGTndBV3lkc2RQ?=
 =?utf-8?B?cDFNK0t5S2FyQk41MUUvVmlZaUx4QnNzUW1rVndaa2owaXVTT1REclZRR1Fq?=
 =?utf-8?B?QlpVMFNuU2RJV0svZi9xQmpzbWpBZ1pzN3FRbjZJbHM0T2Y5NTIveDFad2Ns?=
 =?utf-8?B?VkR0dC9Wb3NEOHY2dXFpK3k3UWVZY3d6eHNZdC9GWE9CYTczQksxSmhoM0FC?=
 =?utf-8?B?SGNlOStDdTVHdmpRZndzZC85YW9LMHpwRndZL2IzNWZRTlIyOVNrbWpuZ0xx?=
 =?utf-8?B?Y011Y2tHWEtGK1Q4Wi8yKytEMGVMeFY0aEd6SW8zM2tLVU1BY1U3WjlWTmtZ?=
 =?utf-8?B?eGZhbENCbGpCMm1qZ0FBVk8vSHhNSUh4T08zY0dlY045dWs1aEJmdVFNb0dC?=
 =?utf-8?B?dk4vWkMxQnNpTXdLQTduVDFyZ21sL2w4eXNDSkVSOW1wdUtWT0RSczNjZnFE?=
 =?utf-8?B?ajBYR1krb3pSTGdzU0ViOEtDU0JZdTdKMEcyb3oxM3lZRkRJYUxqVkJpekt0?=
 =?utf-8?B?ekkvdEVrQVNmMlRpMjhpcXVpZlFvRjlsMzNnS0QyV1h1dXNRL1h5WXNaUk5u?=
 =?utf-8?B?eC9Xd3R1SUYyU0lMQVFDcDBLWEhubFZpTHFtcmQ2K0tOckp1ajgxY2hER1VU?=
 =?utf-8?B?d2pDdXZGZ0UzdnE5VFF1aFo3V3FpcWtWa1lxMHBpVmF0RFJ6T2Y3WVNzd2FB?=
 =?utf-8?B?azB3clJDZkFmNGRoOUV2d0ZpWVUzTjR1VWxTaHE1U0V1QkRBMzFnZWJ3UE9N?=
 =?utf-8?B?dUxhdG9CQTBhSVUyV3REMFlyYWdSdnJxOWVhMklNMTBUS1pkdngyY013eGV4?=
 =?utf-8?B?SXRFMzFUdWZoaHo5RGJMWThsWnltTEpFYU1FMmxmOGdnRGJZRFkyd3ZRUm91?=
 =?utf-8?B?bjhORVVGbG00WWtWQjN6UVZBZnY1eFkwdHMvdnFIZk94UVJmZ2VrZGsybmVQ?=
 =?utf-8?B?bjhaTStqdSs4SUJIRmRLS0lmRkU5b3hHT2RNZG9RV1R5NUdYbkdOeXRNakpO?=
 =?utf-8?B?cHJ6SUlNWVVsZG5pa2lheHBaa0xsK0wzLzhidWNUWXUza2NnRjIyVlRFWTc2?=
 =?utf-8?B?NUs0VnBHb1k2VEFCcUpxbThMOW1Zd2tRU3l4UHlmeEpybTdLSWNnZDJ5WlBp?=
 =?utf-8?B?NjEzNDhTanI0QmhsLzdLanJXWFo5RjUrY2FFQndoSU4rcVk4V1ZjVkZaVys4?=
 =?utf-8?B?R1NZckhOeC8zSzlsdVF2VEppcFVrMXRVdmQxOU5DbDVWQXpQSWVjRUg4UWYy?=
 =?utf-8?B?Y0g4UEVLS1dDR0Iwd2R4dGJBbWJUTGFWT0dOcjV2Wjc3WEVMRDNURGIxRkM3?=
 =?utf-8?B?QlhGVDdSejJvU1dkbGFEdTEzMG5wbG41aHdOenN4aDA3ampTeHVuUzgzTm4y?=
 =?utf-8?B?SE1nYTByODNvekU0RjRJUHlZNlZZUjd4eHl0elN2Vk5NczFYeUFaeVRxQXpX?=
 =?utf-8?B?TTJ6S0RnSFFSWC9teTFTaS9BMXlGZms4aFlhcXVWTDQ5cjJ5RWY2TjhiZWxu?=
 =?utf-8?B?b0NwZElKRERQRnFTbndjREVoTEUwakh3TU93WEoyQkplM3NHNVNXZHdMNUJE?=
 =?utf-8?B?UVZ4VEk5TmxNMU1WUUVFbW8yTjJPS01sRldoTjk0d21uY09FRlJQaUNqMGE3?=
 =?utf-8?Q?Ad1LTYkajixbKkGM=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d004e2b0-71d3-4e19-6734-08dedcf4485e
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 13:24:48.0578 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywVZlP+lmqWy5jFMG7U4CfVJH28afElErYblXanCc5pryd7olVY5yPlLlRM/8jEzydQ7yex0lN97AceYxZVT9oYOmAn8HVzysMmZ+Bi4pHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB7512
Received-SPF: pass client-ip=52.101.127.96;
 envelope-from=bin.meng@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Document the boundary between SPI/SSI controller models and SPI flash
models when representing fast-read dummy cycles. It explains that
flash models own command semantics, while controllers own
hardware-generated dummy transfers and cycle-to-byte conversion.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

---

Changes in v3:
- add an entry in MAINTAINERS

 MAINTAINERS                    |   1 +
 docs/devel/index-internals.rst |   1 +
 docs/devel/ssi.rst             | 132 +++++++++++++++++++++++++++++++++
 3 files changed, 134 insertions(+)
 create mode 100644 docs/devel/ssi.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 6171cc7494..77ca6e6c31 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2347,6 +2347,7 @@ T: git https://github.com/bonzini/qemu.git scsi-next
 SSI
 M: Alistair Francis <alistair@alistair23.me>
 S: Maintained
+F: docs/devel/ssi.rst
 F: hw/ssi/*
 F: hw/block/m25p80*
 F: include/hw/ssi/ssi.h
diff --git a/docs/devel/index-internals.rst b/docs/devel/index-internals.rst
index b89bab9b30..a8f5e310df 100644
--- a/docs/devel/index-internals.rst
+++ b/docs/devel/index-internals.rst
@@ -20,6 +20,7 @@ Details about QEMU's various subsystems including how to add features to them.
    reset
    s390-cpu-topology
    s390-dasd-ipl
+   ssi
    tracing
    uefi-vars
    vfio-iommufd
diff --git a/docs/devel/ssi.rst b/docs/devel/ssi.rst
new file mode 100644
index 0000000000..864b5d9320
--- /dev/null
+++ b/docs/devel/ssi.rst
@@ -0,0 +1,132 @@
+================================
+SSI devices and SPI flash models
+================================
+
+QEMU's Synchronous Serial Interface (SSI) bus models the full-duplex transfer
+of words between a controller and one selected peripheral. Most SPI flash
+models, including ``m25p80``, are attached to controllers through this bus.
+
+This page documents the expected boundary between a controller model and a
+flash model for SPI fast-read dummy cycles. The boundary is important because
+many real controllers expose dummy-cycle configuration in registers, while the
+flash model observes only the byte stream delivered through ``ssi_transfer()``.
+
+SSI transfer granularity
+------------------------
+
+``ssi_transfer()`` transfers one SSI word. Flash models that implement common
+SPI NOR command streams usually consume one 8-bit word at a time:
+
+* command opcode;
+* address bytes;
+* optional mode or continuous-read bytes;
+* dummy bytes;
+* data bytes.
+
+The SSI core does not model individual clock edges or the number of active SPI
+data lines. If a real transaction has a dummy phase expressed in clock cycles,
+the device model that generates transfers on the SSI bus must represent that
+phase as a number of dummy byte transfers.
+
+Flash model responsibilities
+----------------------------
+
+A SPI flash model owns the command semantics for the flash device:
+
+* which opcodes are recognized;
+* how many address bytes are required;
+* whether a command has mode bytes;
+* how many dummy bytes must be consumed before data can be returned;
+* manufacturer-specific differences in fast-read command behavior.
+
+For the ``m25p80`` model, ``needed_bytes`` is a byte count. It must not store
+raw dummy cycles. When a flash datasheet describes the dummy phase in cycles,
+the flash model converts the cycles to bytes using the bus width used for the
+dummy phase::
+
+    dummy_bytes = DIV_ROUND_UP(dummy_cycles * dummy_bus_width, 8)
+
+For SPI NOR fast-read commands modeled by ``m25p80``, the dummy phase follows
+the address phase width. For example, output-only dual and quad read commands
+such as DOR and QOR use one line for command, address, and dummy phases, then
+use two or four lines only for the data phase. Dual I/O and Quad I/O commands
+such as DIOR and QIOR use the wider bus for both address and dummy phases.
+
+If the exact dummy phase cannot be represented as a whole number of SSI byte
+transfers, the model should round up and log the limitation instead of silently
+treating cycles as bytes.
+
+Controller model responsibilities
+---------------------------------
+
+A controller model owns the behavior of the controller hardware:
+
+* how guest-visible registers select command, address width, bus width, and
+  dummy-cycle count;
+* whether the guest supplies dummy bytes in a transmit FIFO;
+* whether the controller itself generates the dummy phase for a memory-mapped,
+  direct-read, or other automatic transfer mode;
+* how chip-select state changes around controller-generated transfers.
+
+When guest software writes dummy bytes into a transmit FIFO or manual transfer
+path, the controller should pass those bytes to ``ssi_transfer()`` like any
+other guest-provided byte. It should not add more dummy transfers on behalf of
+the flash.
+
+When hardware registers instruct the controller to generate a dummy phase, the
+controller must emit dummy byte transfers before data transfers reach the flash
+model. The controller should convert the configured cycle count using the bus
+width that the controller uses during the dummy phase. For example:
+
+* 8 dummy cycles on a single data line become 1 dummy byte;
+* 8 dummy cycles on two data lines become 2 dummy bytes;
+* 8 dummy cycles on four data lines become 4 dummy bytes.
+
+The controller should not duplicate flash-specific opcode tables merely to
+guess which commands need dummy cycles. In automatic modes the controller
+already has enough hardware configuration to know whether it must generate a
+dummy phase. In manual modes the guest-provided byte stream is authoritative.
+
+Avoiding double counting
+------------------------
+
+Exactly one side should generate each dummy byte transfer seen by the flash:
+
+* If the guest sends dummy bytes through the controller, the controller forwards
+  them and the flash consumes them.
+* If the guest programs a controller dummy-cycle register, the controller
+  converts those cycles to dummy byte transfers and the flash consumes them.
+* The flash may know that a command requires dummy bytes, but it does not create
+  transfers on the SSI bus.
+
+Do not implement controller-side snooping that watches manual-mode opcode
+streams and injects extra dummy transfers based on flash opcodes. That mixes
+flash command semantics into the controller and is fragile when flash models
+gain correct dummy-byte accounting.
+
+Examples in the tree
+--------------------
+
+The following models illustrate the boundary:
+
+* ``hw/block/m25p80.c`` keeps fast-read dummy requirements as byte counts in
+  ``needed_bytes``. Manufacturer-specific helpers convert datasheet dummy
+  cycles to the byte stream expected by the model.
+* ``hw/ssi/aspeed_smc.c`` generates dummy byte transfers for direct fast-read
+  mode from controller registers, but manual user-mode writes are forwarded as
+  guest-provided bytes.
+* ``hw/ssi/npcm7xx_fiu.c`` converts the direct-read dummy configuration to the
+  number of dummy byte transfers sent before reading data.
+
+Review checklist
+----------------
+
+When adding or changing a SPI flash controller or flash model, check:
+
+* Are dummy counts stored in byte units when they drive flash state machines?
+* If a hardware register stores cycles, is the conversion to bytes based on the
+  bus width of the dummy phase?
+* Are manual guest-provided dummy bytes forwarded without extra injection?
+* Are automatic controller-generated dummy phases modeled by the controller?
+* Is flash-specific opcode knowledge kept in the flash model rather than copied
+  into controller snooping paths?
-- 
2.34.1


