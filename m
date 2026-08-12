Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1769C5AC67
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 01:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtxu8-00084J-Lf; Tue, 11 Aug 2026 21:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wtxu2-00082Q-NL; Tue, 11 Aug 2026 21:37:11 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wtxty-0001Wg-GA; Tue, 11 Aug 2026 21:37:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOY+CN7enV8qRC7oUJsdsTrvdkjQ2++pXQPHOAJyw7s1QZMUwiARNAi7AGTxzmpZ/PMarGTUNFBXqcSGcatFsmyWVkK6MmwHFQ3YowC60hVPYd6l0J5JJlQJ0Np6xaqSRVK8sa6HP64xzkXqDvjt6WJ7b+fmmDNXgyyOmxTiPQMPUDQpIqZyq2XYN8g32i0kZt0CVjice9nLSYQ0Df7yP8JBwpfA/FmOhvFUdNP/uhL79hQXsj5qBhO6K6inozkAbkYqMGKxd3XFbW/2SQWmJdI0hXT5suZqZwzyoyOH/5yHpAOSDssdBTlvwmhHJDqNmNbV6ijQwEahn1blMgha5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWAsiQg2s2kxjQd8l/dV8DcaDFqGoiMIUOQTqRlYK7s=;
 b=HfaTGUuChiElreq1yTr1WM/SzbsTqv7tk9XMtbAApDTtOeWPoOQMLm3K9tDGHbn5mMWrkKWrPL0mWWjbGq71vROKPw/xm3waAx3DxMonu2K6/nDvffM3irBdJ7r5yWCLly9Uxahr9iMbmoCX9xZBz9bZ7oZHF8U9WT/2orWfcErqtZHhSFiEGf74+FTu21FUIHRxewEMy3KKABKpwMSHSqQsfUZi5xp9D6MRUH7PiHfxziqueyOTOBoXYGHD+StCPWEW8CP8AQvEa7VbXfN6YpGURxPblh/+TSHVtOSeJnyIOo3SeIEyiMQWQhVxbyPzUzLM11HhcFRaIrI9cwLhQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWAsiQg2s2kxjQd8l/dV8DcaDFqGoiMIUOQTqRlYK7s=;
 b=fPdoD2WPZVgjPPOaFZPMvwaJjLwx+5TYXx7ClH5ch7j5lqONn4sliiJatYMQjXr+GUW0gNSFFvP7C/fHSYmzZALp8dWNd1vri7/xiGKkIXvgbNJtINV04UiqnGxJIjT65zRFv+xkJyqv8zki9sSAoJWfl17aWWKxWLSGgoOp02NcBFvMuHAmPHtEqsYOdBPlNgiwJKEMNyaGKN64u/f+sFsL8eR3weWow4WGEj/7Ki7/0UmNfkrrgi2IHUX0batebgwxzJDILaxq4voArWQQRcVUAKrVAoLafFbOUY6GnDXp5374cskZFzQrnr04tme9zhVR+QNKMeetWBuZW+uRRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KUXPR02MB9309.apcprd02.prod.outlook.com (2603:1096:d10:9f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 12 Aug
 2026 01:36:47 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 01:36:47 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH 01/10] hw/arm: fsl-imx6ul: Add SCU compatibility window
Date: Wed, 12 Aug 2026 09:36:04 +0800
Message-ID: <20260812013619.2134092-2-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812013619.2134092-1-bin.meng@processmission.com>
References: <20260812013619.2134092-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DU6P191CA0007.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::22) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|KUXPR02MB9309:EE_
X-MS-Office365-Filtering-Correlation-Id: ffe03f78-bc98-475a-262b-08def8122c9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|6133799003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: T/UgtuQyXpTWUTNHkrGrjp8CWfVHG5flnpPH1utoMpKM2jBRt/rqX2IlQMv7raAmzCf9fHWymOggNtDg90Q7cp4hb4P5ECwbbaYgNR+YioPW8IU8hGbeXSs3ugQnIp1bHRH5+Ks1JMCCOUF4ZCBjK2rvP9/0OlPzlrQaAeRBXBUfHse0fRbf6n+aDWU5cvofOJwJGvzkw1hJXB/Hje5pckwX9lI4Q9t1/Vw8VM05eWbTRRCFDoHBe2iVo4PRb5ezhPbn0N8OfCa8fXKxuB2NBhEM8lnJgve3ZiEmh957LJfieRrR4gcdQIARNSX98aUXGfRTpmMxo+1OJVhRidVskS6jfKe6gl5T5RW7N12HlUw1BrEMhARoXMk9MVwihHvjb7WaBANCl40/EZbk8xIUWTkNb+Tn1NH4jLKHNDQsjzGQYVmtwB91e+HM0S/COSvNJ+MPRMdnPmjD8ye9qvZ5eCmT6CSfiSR0+u2yzKjxFt3YWFmvbYvu4khTeTEgXAl2oUXswoZ14yFsc/tixbfdCwZah6EosKsI9a15ShOqzBuGjnijDFkzAA7XEJIjZYZSbP8HIHw+785OmVWrBAAggHXE2/OJ9v+FSeJcmd/rWPi5nBQA3rKuEsrdDzNXuDiPFzstWSSInXYcUyNMNQWN8Ty+D+iLWprn97JnXDzUirk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZhKjx8gkJ53nsjEsWfDEBOL6e9RlxEqXT/W571DcmHokNwt3O5v/R1dkKYwv?=
 =?us-ascii?Q?EX371r3V2n9bHX0JubcUN/42EtoACKnv0tr4fMqz8GuXjkuZICKxZNq0Mu03?=
 =?us-ascii?Q?TalDYAy1jkFkmRUExK7wtI4Z/xM4e7RX7t8YPkUauDUsHHrG/UJPd6Sq97VP?=
 =?us-ascii?Q?9vNcr8tQ2e6WorcWvpsoH4iWMdI57qYZsqfDk0s5VG2sYPCuURVF8+a8rWTG?=
 =?us-ascii?Q?p5n36Tf5V6S+/lxhAbFbIdDd7yIUisJVR0T1DpkGowmSiX3Bj9HK6INWbWK2?=
 =?us-ascii?Q?3e6pFCW7DyDXE7QSsHG8MLSm3yJold0Gj8dSPSf9Tuyt2X47Gok+m7KtLtmc?=
 =?us-ascii?Q?iFZ9BXA42mTRCk+4wdpbER89O32vR7O5ia7MiLEvZ/WRDfdWHzM4V8NSSc3N?=
 =?us-ascii?Q?zSFXC7mSpJ8Mhy0wzQyfz89MiQHKI8LujzjIDtYiUvdtQ/baGw6ouKRiPquW?=
 =?us-ascii?Q?COxcJwl3qucjoMqfRL+mKTzUXNXuTfclLS9qY452QOmiiqrT54V7KgyGIXRy?=
 =?us-ascii?Q?L3kTlIEjW2UQpIADfitGUWAuBsasyY0WfktLFudBxUd6ZGAedl9Jn7dqOxsT?=
 =?us-ascii?Q?6tjqqSg01xnEWCH8bz/sGuWiG6oyQ1ngphBlE/QcH44Px5TwKov9IU6xr+ai?=
 =?us-ascii?Q?SJPj85INdDDoXKoY642LKx7FQ/DqXjVhukUG1thnIWhCr9d6pcCKYOLNLPnt?=
 =?us-ascii?Q?3rE6+CB/13eIbt2Zi2DAeAOvf/7pOz+89SvUfD//lcWQdrSPTqBmGUwGe9uj?=
 =?us-ascii?Q?aZ9cQvYnMajZ5LGrlIs8heYxFP9l+GkwOiW/fwjq89vIC9LKpjSakDM+HOam?=
 =?us-ascii?Q?kOObNR326c16A/UDwnAuBJK+BaAbnPZBf7yqePt7B6j6i653ePmIsw8aXU33?=
 =?us-ascii?Q?Mm/sxqmMoVVUMeKIRWvLpIsMeT0YAQkgjsFklVkj/hVnzYtJOFgsVyoXKe+C?=
 =?us-ascii?Q?VrK//T3YPs1mmWFElceN+XADrr2CGbh2NT7piV+Sx3wWMXGwxvM5Ez9JhPY0?=
 =?us-ascii?Q?XSNyw1lqF7e3uc6YOUKHzyg7GCDEPEV9eP3EyoA0CJknjy0g0KuikJW17dW8?=
 =?us-ascii?Q?OgBNn6GoUHKy901xLj6xuPUdAgzzqiubLNpHpfQgY6ylw6yJIstKmPc4/+v1?=
 =?us-ascii?Q?5wjjiRZV1bCeDuO1oJr9phx1/VVbhTJqGEyayXON+3VwBqLTnTcKZNji93C7?=
 =?us-ascii?Q?KZSDjqp47JM6nYjFVhBrx7ZM5Lokts8atfFp/pK5Ja5Q433y1M/QnePfdXSA?=
 =?us-ascii?Q?p4KuX2C7B6Aqy4XMyIeRHcm0T1yjMwZulNMFL55CgMgMBVeiHZOKaYoPb41k?=
 =?us-ascii?Q?hNJ+NnZaV3BjRlWi06qJkx4ZOmi8L/4OOpim0Lrw0gMj7/g85rZMzIQPqu2K?=
 =?us-ascii?Q?wPEgPQFnC7RbNYOF9WxIeZZ+MovX7Ox24Fp86ATIsMWHteF7oKOQoH1xBC0U?=
 =?us-ascii?Q?W0++xgJyuWM4Isz44ZXU0rEfK2cziM78pcn+B/1vEBwHZ5zihy91e4OLaVjG?=
 =?us-ascii?Q?ctfcA1z+tWUzvkzvyE6BmLDN0NVv+En6TccFJbOPZjkDhr9B9ybIWR3hg0cq?=
 =?us-ascii?Q?u7rlhmeeXyReW2Qz2TE5aPOkt1ECooVy9lJQudvkZFdeRLTF+WEPuYKz7G9u?=
 =?us-ascii?Q?BXsuqXZc2Dvb8KC5f0xYseeWEV8JLLo2jT66hYSi9w2c2tnRa3NfO5vJCuDc?=
 =?us-ascii?Q?LuYaTP6G7KCIoZ5NoKKa/eGVlXZf1mlsAkazGrHR3c9czS6taHRoDMZO1lB4?=
 =?us-ascii?Q?A+OLRC3p6enXMWzGC0DOFIWFZrsex8E=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe03f78-bc98-475a-262b-08def8122c9b
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 01:36:47.5545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7pnRDixYblSMjlknJMVb6HkTYMYoYj3St4y429XPDCyOCf5RKkhR6VBi+X/A5U0HFc1J5ujQW3d+A+5vlKv2uKaz+XAmlwDKuTfRjMla/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR02MB9309
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

U-Boot's common i.MX6 CPU identification code reads the Cortex-A9
SCU configuration register at PERIPHBASE + 0x4 even on i.MX6UL.
The value is only used to distinguish Cortex-A9 i.MX6 variants.

Cortex-A7 reserves this address and reading it causes data abort.

The same U-Boot abort was discussed on qemu-arm in September 2024:
https://lists.gnu.org/archive/html/qemu-arm/2024-09/msg00072.html

Map only the four-byte configuration-register address as an
unimplemented device. Its zero read result gives U-Boot the
single-CPU encoding after the low two bits are masked, while
the remainder of the reserved Cortex-A7 page stays unmapped.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/fsl-imx6ul.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 1863558a0d..d6f662efe4 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -187,6 +187,15 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     sysbus_realize(SYS_BUS_DEVICE(mpcore), &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(mpcore), 0, FSL_IMX6UL_A7MPCORE_ADDR);
 
+    /*
+     * U-Boot's shared i.MX6 CPU identification code reads the
+     * Cortex-A9 SCU configuration register on i.MX6UL. Cortex-A7
+     * reserves this address, so provide only the compatibility word
+     * needed before the console is initialized.
+     */
+    create_unimplemented_device("a7mpcore-scu-compat",
+                                FSL_IMX6UL_A7MPCORE_ADDR + 0x4, 4);
+
     gic = mpcore;
     gicsbd = SYS_BUS_DEVICE(gic);
     cpu = DEVICE(&s->cpu);
-- 
2.53.0


