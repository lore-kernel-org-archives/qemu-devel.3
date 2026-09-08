Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9702FC79FA1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:43:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tHh-00080f-VN; Tue, 08 Sep 2026 06:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tHg-00080B-0A; Tue, 08 Sep 2026 06:42:36 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tHb-0006YC-6b; Tue, 08 Sep 2026 06:42:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9+UecPGgzsD8GwsWpR+llwlqqhX0IYnPK1MTHW+CUfNQ3ZFK4fBAS5mbbzGFBEYIEOqs5sqxPmjOAtwd2c1lw5BydFQHLYjHSMSLWSJCGJRlw07i8loDny4YHO9pDpcoRQTsxb9PKbqEJMCZjY13y6LG3Xp+wa+DRuc3bWpUO40Tb3pBt60ELCkvI8DxUZHh46hTvM3rZyDnmiBqYgXSH5CKuFkxxkB/wNDmIl/FPil+vNcecsaxjhhRGCG6uYMtqUIw3znQUP3/PqRg3MCckz5lvSHEOCYhsr6IWxTr+Nxk2NzeQYQwvCH/Zw86+Ny/NVf1Yw73Z3UY0RqgqkZsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zt00ISGLPkB3FtSifCD9ANeU+hxoODzCR8bjrt1wFho=;
 b=RzYzliXh2Ov8Mgt15fpdhNr0gnV9nH3uUVT+peCXBDZT8G7Rr/IbI0yK6cHDaBFX42g9R8IPptVZ7Zz1JfK5VGZBSlFmA0o90WdlMhwTLtB2jCEOZgYnuyHQIsTVX+LpDDLyXmedl5IumVpZTHFa01Uu4IYoRPDgGg0n8qmIqxGQeiys0XtmE47MpC37meFCQQeVefL6CEJamrdqfvgDUk171VD7CXiKO7i9Xs9uM0XEUgtmPxVDnW5JdCmYJyG0DPFMRaF3s0BE/u2QEuiPKHkDdayGu5QdBhj0Tcue64EJuy9LSYu5BCD7LwymK2ePgLmHUGu8xKN7CqlrBUf/PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zt00ISGLPkB3FtSifCD9ANeU+hxoODzCR8bjrt1wFho=;
 b=KLH8QhpdyNvZNDVXESsk1gvqw6n+1bG+k8kOss3Klf49roy/XAYvjUVquQ/67uhhqDpf81Hn7SazMSdc4jydG8rol3sm/m/NdP7BKKJWt2HEwrXLblptlG0mRDxegmubFPkCzkrpt8YQZ3VCZ+43jEKLdzfcdeVN8TujNfnag/2BCX1nedxd56nnNRqISMKWTSba9lAlziDMmb4IjpHg2DsVmLd7KOT3W9RGFugDZSahw4aGhwzQAdnQVV8yWrt+mMVoNhoOUrlRv5HZQv5f1G2ergeB3Dd3oRx7zsIx8H6jfX31t1Zb7qCCktQv9i83qSvn4rhLx8ZelEXU29Z5Iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com (2603:1096:301:78::7)
 by OSQPR02MB7928.apcprd02.prod.outlook.com (2603:1096:604:291::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 10:42:23 +0000
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616]) by PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 10:42:23 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-block@nongnu.org
Subject: [PATCH v2 03/32] hw/sd: Add Synopsys DesignWare MCI controller
Date: Tue,  8 Sep 2026 18:41:12 +0800
Message-ID: <20260908104159.1621764-4-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908104159.1621764-1-bin.meng@processmission.com>
References: <20260908104159.1621764-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4P301CA0041.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::15) To PSAPR02MB4984.apcprd02.prod.outlook.com
 (2603:1096:301:78::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR02MB4984:EE_|OSQPR02MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: 63318aed-e7b5-423f-f703-08df0d95ddd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: xtt1NvXof6ixRg9cvLA5H2k/lY5f/+rTq3X0LFJJmumIJDqb+u95orFF36uOoftE8RNJQXEhrHWmSdcgOl/309hhco87Uhf/3lSvz516PJt8MxybTz9vrQr0JiPqxQ9e79MVp3KeMlZx1btrvziEUGRmkQL/1jAOR9dpf5r4op3LUJ+m6la/4aE7a5pEmxb4LT18t9d2cVljIK+aIoD1s0NSu7VgHHVDEvWu00pVWwKFCCecybjwGssUO9ngr1/QQueMQwoEtivjPcjUCoUS3Y99V8zdkzZpeVzrRO7rx7oT/RNklVpXqHecG99aCbuDHiUkYQfu3HnyxB3/SI6DNklZNhBkBYZoZTmn7dHAKlSwmPg+7zxME14Scszh/dJy25v9HSWOihlU3h3qUszrkxrucWf8nsibxCIVOkQkemr6mZhg1+5CF20j+aK5P5+oTNfUe5HJzXJJWAbkNWGbPpw8szP1YmbbFDCaEZIHOmb1qzPuD/uPzuAkhvxpqk79zzY+NftB/Yq8XALs1VFvbq4pizZAM93+HlUx5vCF04gpg0xAoWvVM6ser9LTAO8cnIrYJ4EgMzKWzzcoVAPEeOK2/VxfywoFHeuKj1o47/TcZqOgXdMvp0cRDWc2z1WvKZvznoqdM+Tmr6HvxEYd3lwSx7TplMPy0G11T+iR4wU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PSAPR02MB4984.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHU5b29xVnAwN081RDJzbjdSZjVsUVJmRGlscDJzb3JsU1RoNnlSWXBMclRj?=
 =?utf-8?B?bUk3ZDJqbGU5ZExmSTNaNjJyUkhlaGVCd2RaWlZqaWNsa1Z6RzZ2Rm56RUR2?=
 =?utf-8?B?VHh1WGdXRjFWTzArUUh2bkRxSHR3OTlVWEhiS2VnblQwaXNjbFdCV29PNHVW?=
 =?utf-8?B?N1pKVGFwNDEvSTBDNTVZU2VWelB5a09tdDA1RFprS3pWU1d3NWlISlpRNTlz?=
 =?utf-8?B?V3gyZWtCQ2x3SU9mVklmRkttTHRkRlhDa1JtTlNkRzlBbmFmdXo1VklXeTI4?=
 =?utf-8?B?ZGFLNGtPS1crWUtKNFRsVFNJZ3d4c1hqUHhlUnBZdnFSL3pDOHZOOTlWUzlP?=
 =?utf-8?B?VURSWkNiWUNhTUppQkVhVFp3WXdyQk5ZV0MwZHpQSTNxRVNmb25VbDVHSzJr?=
 =?utf-8?B?R1R0T3V0c0ZFUVNXSXVlTEFVYmNZcGpWQ01jTWw5SHRuM0pYM2NyRTVRNjR1?=
 =?utf-8?B?bjFQNG9pYkJmUjQrWVFRUjRGNjFDMjhNanFsRWJCSGErdFh1dlZRVDIyUVNT?=
 =?utf-8?B?RVA3UDVBaU5qcHR0N0E3RTdJK1dTWllRV3Z5YnliM3JOWVNXTTh4L3NtcHhZ?=
 =?utf-8?B?THZzYlBhZEZSM2hacnZ5dDRubWhMWFNqNE84MU9scE1mK3lkbVh2dFFQeFp4?=
 =?utf-8?B?bmtOdWRXZnJSdDF4TjNlRHh6NHBNamY4TUtFTUJ5RE9KZHB1WVpBajRETVdL?=
 =?utf-8?B?TVBmL3cyS2FJS2Z2c2ZBSlBrcG5pQm04engza1Nkdmg5d0NQZGkvUHNnc0Fs?=
 =?utf-8?B?ZUhkNU94QXJudnlnamR3Ymd2MExqVmo0STMzN1dLemV0NXNRVjlRMFEwMit2?=
 =?utf-8?B?aHpMUFBHK0FsMWVaTXlNL3lJYTRFenFSMXc3M1Rva0IxMDEwSW1kQ2VrZU5K?=
 =?utf-8?B?L2J4bzdiRk4zUTVpMUVmWHpoalN1bmUreHJhOXprMDNDMlpEUTlHMWdtZGtZ?=
 =?utf-8?B?OHpEalFRZi9KV0hsb2ZyVnVLSUsvTzNWVlhnOG1iZnRxTjE1YTRaZXVzalRz?=
 =?utf-8?B?M3RCUlBqR0ZHd1dhUFpWaURsMDRPZ2pGTE5DMDFYWkhaQUE0SDNZTUNDQ3h6?=
 =?utf-8?B?T1I2d3ZHbE9UdzhRTlhwblIvRGlTMnRpRWNCV1ljemNKUWhmMzVCbEozZ0Rq?=
 =?utf-8?B?NXdabllCSXRqeC9iTUh4cVV6ZWwyaFNwcXFTQk9pRHpXNWdSaGVTMnVjVkQv?=
 =?utf-8?B?dWJXeEdENjBEblYwbnoxTHN6dmdKR2lzelhPRExrUEd1Y1BrcXFmRDA1U0kx?=
 =?utf-8?B?eTFGQkVHZWRuQjNTcjQwRG1MNkNha3JmbEc2bE9FSU5vMXF5NkZaLytad2Mz?=
 =?utf-8?B?dWhTVHM4ZXdQZGVJSyswOVdyZW1MR3NEOXlrMnVWL2NUTVY5TStIVEVzNC9E?=
 =?utf-8?B?VVB2VWtmZ1RPdndxUHF4MitFREE1bURWUzdJeVZoZXhSS2VxRGdzeHFna3hJ?=
 =?utf-8?B?M1dtMUd0QlcrVWNwZDFYakxxbFpaMWVSZUFYL090WDhlRlNOa2o2VURhdDhB?=
 =?utf-8?B?MEt0Tis3UThlb2dzR25QMGRCM3pnMktqOE95SVlKbG9EaGw0VkdQWHZFaTVE?=
 =?utf-8?B?UUZIZ3RnNVFJV21XbnhUc1F3ejZyd21lNVdQYlZ3OGF2SmUyTzcrNFpNQXcx?=
 =?utf-8?B?Q0lJN1Jjdjh4YlF3aCtORU1naWhRZzV3MytvQTMybnlWKzFDZW5DM0JQUUNQ?=
 =?utf-8?B?MDRIWGlMejNacmZIWTJxWkNuYitrd0k3bzllUEtWMVAwK1NiUzh2VC9Dek4v?=
 =?utf-8?B?S0dqcy8xSmtBejhwZGtjSXRON2NkL252dnQzQnY0U0ZwSEF2MDEvNDJHeVpu?=
 =?utf-8?B?Z2M3VFdGUEY2SlJTcXZQSk1PMmJqTXFxTWpxNVJNaTZkSTNiM09sWU5ld1J2?=
 =?utf-8?B?eGdVKzF5eEMrdEpJM1pRWWF6TzdMaUJKYnV0eExoRWZNK1cwUW1DZkxIYmgy?=
 =?utf-8?B?S01Lek5Ma1ZYWGk1M2NsdnBQWWdqeGlmZkl0bW42UWdsMmhheUQycmcxNmxi?=
 =?utf-8?B?RVh3Q3JSUUxIYnI2UElHQXZ1VUo5Z3B1YXQyWElXd1dqaDU5cVNwRHlRVlRR?=
 =?utf-8?B?ZEhXeFBBb2hDTmljTFAvYkY2TlFKRHkyL0ZqOXFDNjRZUU92S3hRWGVqN2t2?=
 =?utf-8?B?RDdMTVVsMzErNzhnVHlzR1FmZk5zWFlNWm9wVTRDc1llQ05ZS0wreEFXM0xa?=
 =?utf-8?B?SXdIcXF5QUR6czBwZEJ0MUk1cUJ0QzlrQjhza052S0FPa0xFYnpURFZHc2hW?=
 =?utf-8?B?dDBsbk5XZFNTQTJpdGFDQXhUeXUrbkZ6R0J6L2hCNXk2a2dOK1c2S1ZPU01S?=
 =?utf-8?B?Q2RWZ3IxOFBWend0SjFHVXBMOWQ2T1E5WFFzQ3lxdWpxVWl5OVNJdXRTbUQ5?=
 =?utf-8?Q?PVas88/aHikhQzNk=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63318aed-e7b5-423f-f703-08df0d95ddd7
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4984.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 10:42:23.5863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wzQAFqbAJph1fHlRk+M1sNnPWdhT2J7OHzKNfzHK7hXnA12czuTUjtrSBU5iFtqKHEZuA+v/80HAMOBRnTHX9WR7rHhwOcNCvdNcJ16+uNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR02MB7928
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

The Synopsys DesignWare Mobile Storage Host predates SDHCI and uses
a distinct MCI programming interface. It is integrated by Samsung
Exynos, Rockchip, HiSilicon, and Altera/Intel SoCFPGA platforms,
among others.

Add a reusable controller model based on the DesignWare Mobile Storage
Host 2.40a databook. Cover command and response handling, PIO FIFO
aliases, reset and interrupt semantics, card state, and the standard
32-bit internal descriptor DMA engine. Also support the later 64-bit
descriptor layout used by vendor variants.

Expose class hooks and immutable configuration fields so vendor
extensions can reuse the common implementation. Keep the 4 KiB MMIO
aperture while limiting register backing and migration state to 96
words; the FIFO window is maintained separately.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v2:
- Reduce register backing and migration state from 1024 to 96 words

 MAINTAINERS            |    2 +
 include/hw/sd/dw_mci.h |   75 +++
 hw/sd/dw_mci.c         | 1382 ++++++++++++++++++++++++++++++++++++++++
 hw/sd/Kconfig          |    5 +
 hw/sd/meson.build      |    1 +
 5 files changed, 1465 insertions(+)
 create mode 100644 include/hw/sd/dw_mci.h
 create mode 100644 hw/sd/dw_mci.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7183babd6a..705a541b69 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2413,8 +2413,10 @@ M: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 M: Bin Meng <bmeng.cn@gmail.com>
 L: qemu-block@nongnu.org
 S: Odd Fixes
+F: include/hw/sd/dw_mci.h
 F: include/hw/sd/sd*
 F: hw/sd/core.c
+F: hw/sd/dw_mci.c
 F: hw/sd/sd*
 F: hw/sd/ssi-sd.c
 F: tests/qtest/fuzz-sdcard-test.c
diff --git a/include/hw/sd/dw_mci.h b/include/hw/sd/dw_mci.h
new file mode 100644
index 0000000000..3d011f2592
--- /dev/null
+++ b/include/hw/sd/dw_mci.h
@@ -0,0 +1,75 @@
+/*
+ * Synopsys DesignWare Multimedia Card Interface
+ *
+ * Copyright (c) 2026 Process Mission
+ *
+ * Author:
+ *   Bin Meng <bin.meng@processmission.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_SD_DW_MCI_H
+#define HW_SD_DW_MCI_H
+
+#include "hw/core/register.h"
+#include "hw/core/sysbus.h"
+#include "hw/sd/sd.h"
+#include "qom/object.h"
+
+#define TYPE_DW_MCI "dw-mci"
+OBJECT_DECLARE_TYPE(DwMciState, DwMciClass, DW_MCI)
+
+#define DW_MCI_MMIO_SIZE      0x1000
+/* Covers modeled and vendor registers without backing the full aperture */
+#define DW_MCI_REG_COUNT      96
+#define DW_MCI_FIFO_MAX_WORDS 2048
+#define DW_MCI_FIFO_MAX_BYTES (DW_MCI_FIFO_MAX_WORDS * sizeof(uint32_t))
+
+struct DwMciState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    SDBus sdbus;
+    qemu_irq irq;
+
+    uint32_t regs[DW_MCI_REG_COUNT];
+    RegisterInfo regs_info[DW_MCI_REG_COUNT];
+
+    uint8_t fifo[DW_MCI_FIFO_MAX_BYTES];
+    uint32_t fifo_head;
+    uint32_t fifo_len;
+    uint32_t transfer_remaining;
+    uint64_t idmac_desc_addr;
+    bool transfer_active;
+    bool transfer_write;
+    bool transfer_send_stop;
+    bool idmac_suspended;
+    bool idmac_fatal;
+    bool card_inserted;
+    bool card_readonly;
+
+    uint32_t verid;
+    uint32_t hcon;
+    uint32_t data_offset;
+    uint32_t fifo_depth;
+};
+
+struct DwMciClass {
+    SysBusDeviceClass parent_class;
+
+    uint32_t verid;
+    uint32_t hcon;
+    uint32_t data_offset;
+    uint32_t fifo_depth;
+
+    bool (*vendor_read)(DwMciState *s, hwaddr offset, uint64_t *value,
+                        unsigned size);
+    bool (*vendor_write)(DwMciState *s, hwaddr offset, uint64_t value,
+                         unsigned size);
+    void (*vendor_reset)(DwMciState *s);
+};
+
+SDBus *dw_mci_get_bus(DwMciState *s);
+
+#endif
diff --git a/hw/sd/dw_mci.c b/hw/sd/dw_mci.c
new file mode 100644
index 0000000000..245435f43e
--- /dev/null
+++ b/hw/sd/dw_mci.c
@@ -0,0 +1,1382 @@
+/*
+ * Synopsys DesignWare Multimedia Card Interface
+ *
+ * Copyright (c) 2026 Process Mission
+ *
+ * Author:
+ *   Bin Meng <bin.meng@processmission.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sd/dw_mci.h"
+
+#include "hw/core/irq.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "qemu/bswap.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "system/address-spaces.h"
+#include "system/dma.h"
+
+REG32(CTRL, 0x000)
+    FIELD(CTRL, RESET, 0, 1)
+    FIELD(CTRL, FIFO_RESET, 1, 1)
+    FIELD(CTRL, DMA_RESET, 2, 1)
+    FIELD(CTRL, INT_ENABLE, 4, 1)
+    FIELD(CTRL, DMA_ENABLE, 5, 1)
+    FIELD(CTRL, USE_IDMAC, 25, 1)
+REG32(PWREN, 0x004)
+REG32(CLKDIV, 0x008)
+REG32(CLKSRC, 0x00c)
+REG32(CLKENA, 0x010)
+REG32(TMOUT, 0x014)
+REG32(CTYPE, 0x018)
+REG32(BLKSIZ, 0x01c)
+REG32(BYTCNT, 0x020)
+REG32(INTMASK, 0x024)
+REG32(CMDARG, 0x028)
+REG32(CMD, 0x02c)
+    FIELD(CMD, INDEX, 0, 6)
+    FIELD(CMD, RESP_EXP, 6, 1)
+    FIELD(CMD, RESP_LONG, 7, 1)
+    FIELD(CMD, RESP_CRC, 8, 1)
+    FIELD(CMD, DAT_EXP, 9, 1)
+    FIELD(CMD, DAT_WR, 10, 1)
+    FIELD(CMD, SEND_STOP, 12, 1)
+    FIELD(CMD, STOP, 14, 1)
+    FIELD(CMD, UPD_CLK, 21, 1)
+    FIELD(CMD, START, 31, 1)
+REG32(RESP0, 0x030)
+REG32(RESP1, 0x034)
+REG32(RESP2, 0x038)
+REG32(RESP3, 0x03c)
+REG32(MINTSTS, 0x040)
+REG32(RINTSTS, 0x044)
+REG32(STATUS, 0x048)
+    FIELD(STATUS, FIFO_RX_WMARK, 0, 1)
+    FIELD(STATUS, FIFO_TX_WMARK, 1, 1)
+    FIELD(STATUS, FIFO_EMPTY, 2, 1)
+    FIELD(STATUS, FIFO_FULL, 3, 1)
+    FIELD(STATUS, BUSY, 9, 1)
+    FIELD(STATUS, RESPONSE_INDEX, 11, 6)
+    FIELD(STATUS, FIFO_COUNT, 17, 13)
+REG32(FIFOTH, 0x04c)
+    FIELD(FIFOTH, TX_WMARK, 0, 12)
+    FIELD(FIFOTH, RX_WMARK, 16, 12)
+    FIELD(FIFOTH, MSIZE, 28, 3)
+REG32(CDETECT, 0x050)
+REG32(WRTPRT, 0x054)
+REG32(GPIO, 0x058)
+REG32(TCBCNT, 0x05c)
+REG32(TBBCNT, 0x060)
+REG32(DEBNCE, 0x064)
+REG32(USRID, 0x068)
+REG32(VERID, 0x06c)
+REG32(HCON, 0x070)
+    FIELD(HCON, CARD_TYPE, 0, 1)
+    FIELD(HCON, NUM_CARDS, 1, 5)
+    FIELD(HCON, HBUS_TYPE, 6, 1)
+    FIELD(HCON, HDATA_WIDTH, 7, 3)
+    FIELD(HCON, HADDR_WIDTH, 10, 6)
+    FIELD(HCON, TRANS_MODE, 16, 2)
+    FIELD(HCON, FIFO_RAM_INSIDE, 21, 1)
+    FIELD(HCON, HOLD_REG, 22, 1)
+    /* Later revisions use bit 27 to advertise 64-bit IDMAC addresses */
+    FIELD(HCON, ADDR_CONFIG, 27, 1)
+REG32(UHS_REG, 0x074)
+REG32(RST_N, 0x078)
+REG32(BMOD, 0x080)
+    FIELD(BMOD, SWRESET, 0, 1)
+    FIELD(BMOD, FIXED_BURST, 1, 1)
+    FIELD(BMOD, DSL, 2, 5)
+    FIELD(BMOD, ENABLE, 7, 1)
+    FIELD(BMOD, PBL, 8, 3)
+REG32(PLDMND, 0x084)
+REG32(IDMAC_088, 0x088)
+REG32(IDMAC_08C, 0x08c)
+REG32(IDMAC_090, 0x090)
+REG32(IDMAC_094, 0x094)
+REG32(IDMAC_098, 0x098)
+REG32(IDMAC_09C, 0x09c)
+REG32(IDMAC_0A0, 0x0a0)
+REG32(IDMAC_0A4, 0x0a4)
+REG32(CDTHRCTL, 0x100)
+REG32(BACK_END_POWER, 0x104)
+REG32(UHS_REG_EXT, 0x108)
+REG32(DDR_REG, 0x10c)
+REG32(ENABLE_SHIFT, 0x110)
+
+#define DW_MCI_INT_CD               BIT(0)
+#define DW_MCI_INT_RESP_ERR         BIT(1)
+#define DW_MCI_INT_CMD_DONE         BIT(2)
+#define DW_MCI_INT_DATA_OVER        BIT(3)
+#define DW_MCI_INT_TXDR             BIT(4)
+#define DW_MCI_INT_RXDR             BIT(5)
+#define DW_MCI_INT_RCRC             BIT(6)
+#define DW_MCI_INT_DCRC             BIT(7)
+#define DW_MCI_INT_RTO              BIT(8)
+#define DW_MCI_INT_DRTO             BIT(9)
+#define DW_MCI_INT_HTO              BIT(10)
+#define DW_MCI_INT_FRUN             BIT(11)
+#define DW_MCI_INT_HLE              BIT(12)
+#define DW_MCI_INT_SBE              BIT(13)
+#define DW_MCI_INT_ACD              BIT(14)
+#define DW_MCI_INT_EBE              BIT(15)
+
+#define DW_MCI_IDSTS_TI             BIT(0)
+#define DW_MCI_IDSTS_RI             BIT(1)
+#define DW_MCI_IDSTS_FBE            BIT(2)
+#define DW_MCI_IDSTS_DU             BIT(4)
+#define DW_MCI_IDSTS_CES            BIT(5)
+#define DW_MCI_IDSTS_NI             BIT(8)
+#define DW_MCI_IDSTS_AI             BIT(9)
+#define DW_MCI_IDSTS_NORMAL         (DW_MCI_IDSTS_TI | DW_MCI_IDSTS_RI)
+#define DW_MCI_IDSTS_ABNORMAL       (DW_MCI_IDSTS_FBE | DW_MCI_IDSTS_DU | \
+                                     DW_MCI_IDSTS_CES)
+#define DW_MCI_IDSTS_MASK           (DW_MCI_IDSTS_TI | DW_MCI_IDSTS_RI | \
+                                     DW_MCI_IDSTS_FBE | DW_MCI_IDSTS_DU | \
+                                     DW_MCI_IDSTS_CES | DW_MCI_IDSTS_NI | \
+                                     DW_MCI_IDSTS_AI)
+
+#define DW_MCI_IDMAC_DIC            BIT(1)
+#define DW_MCI_IDMAC_LD             BIT(2)
+#define DW_MCI_IDMAC_FS             BIT(3)
+#define DW_MCI_IDMAC_CH             BIT(4)
+#define DW_MCI_IDMAC_ER             BIT(5)
+#define DW_MCI_IDMAC_CES            BIT(30)
+#define DW_MCI_IDMAC_OWN            BIT(31)
+#define DW_MCI_IDMAC_SIZE_MASK      0x1fff
+#define DW_MCI_IDMAC_SIZE2_SHIFT    13
+#define DW_MCI_IDMAC_MAX_DESCS      4096
+#define DW_MCI_DMA_CHUNK_SIZE       1024
+
+#define DW_MCI_IDMAC_FSM_IDLE       0
+#define DW_MCI_IDMAC_FSM_SUSPEND    1
+
+#define TYPE_DW_MCI_BUS "dw-mci-bus"
+
+typedef struct DwMciIdmac32 {
+    uint32_t control;
+    uint32_t sizes;
+    uint32_t buffer;
+    uint32_t next;
+} DwMciIdmac32;
+
+typedef struct DwMciIdmac64 {
+    uint32_t control;
+    uint32_t reserved0;
+    uint32_t sizes;
+    uint32_t reserved1;
+    uint32_t buffer_lo;
+    uint32_t buffer_hi;
+    uint32_t next_lo;
+    uint32_t next_hi;
+} DwMciIdmac64;
+
+typedef struct DwMciDescriptor {
+    uint32_t control;
+    uint32_t size[2];
+    uint64_t buffer[2];
+    uint64_t next;
+} DwMciDescriptor;
+
+static bool dw_mci_run_idmac(DwMciState *s);
+
+static bool dw_mci_is_64bit(DwMciState *s)
+{
+    return s->hcon & R_HCON_ADDR_CONFIG_MASK;
+}
+
+/*
+ * The 64-bit layout inserts DBADDRU at 0x8c, shifting IDSTS and IDINTEN one
+ * register higher than their locations in the legacy layout.
+ */
+static unsigned dw_mci_idsts_reg(DwMciState *s)
+{
+    return dw_mci_is_64bit(s) ? R_IDMAC_090 : R_IDMAC_08C;
+}
+
+static unsigned dw_mci_idinten_reg(DwMciState *s)
+{
+    return dw_mci_is_64bit(s) ? R_IDMAC_094 : R_IDMAC_090;
+}
+
+static uint32_t dw_mci_host_bus_bytes(DwMciState *s)
+{
+    unsigned width = FIELD_EX32(s->hcon, HCON, HDATA_WIDTH);
+
+    return width <= 2 ? 2U << width : sizeof(uint32_t);
+}
+
+static void dw_mci_set_idmac_fsm(DwMciState *s, uint32_t state)
+{
+    unsigned idsts = dw_mci_idsts_reg(s);
+
+    s->regs[idsts] = deposit32(s->regs[idsts], 13, 4, state);
+}
+
+static uint64_t dw_mci_descriptor_base(DwMciState *s)
+{
+    uint64_t address = s->regs[R_IDMAC_088];
+
+    if (dw_mci_is_64bit(s)) {
+        address |= (uint64_t)s->regs[R_IDMAC_08C] << 32;
+    }
+    return address;
+}
+
+static uint32_t dw_mci_fifo_capacity(DwMciState *s)
+{
+    return MIN(s->fifo_depth, (uint32_t)DW_MCI_FIFO_MAX_WORDS) * 4;
+}
+
+static void dw_mci_fifo_reset(DwMciState *s)
+{
+    s->fifo_head = 0;
+    s->fifo_len = 0;
+    memset(s->fifo, 0, sizeof(s->fifo));
+}
+
+static void dw_mci_fifo_push(DwMciState *s, const uint8_t *data,
+                             uint32_t length)
+{
+    uint32_t capacity = dw_mci_fifo_capacity(s);
+    uint32_t tail = (s->fifo_head + s->fifo_len) % capacity;
+
+    while (length--) {
+        s->fifo[tail] = *data++;
+        tail = (tail + 1) % capacity;
+        s->fifo_len++;
+    }
+}
+
+static void dw_mci_fifo_pop(DwMciState *s, uint8_t *data, uint32_t length)
+{
+    uint32_t capacity = dw_mci_fifo_capacity(s);
+
+    while (length--) {
+        *data++ = s->fifo[s->fifo_head];
+        s->fifo_head = (s->fifo_head + 1) % capacity;
+        s->fifo_len--;
+    }
+    if (!s->fifo_len) {
+        s->fifo_head = 0;
+    }
+}
+
+static void dw_mci_update_irq(DwMciState *s)
+{
+    uint32_t core = s->regs[R_RINTSTS] & s->regs[R_INTMASK];
+    uint32_t idsts = s->regs[dw_mci_idsts_reg(s)];
+    uint32_t idinten = s->regs[dw_mci_idinten_reg(s)];
+    bool core_irq = (s->regs[R_CTRL] & R_CTRL_INT_ENABLE_MASK) && core;
+    bool idmac_irq = ((idsts & DW_MCI_IDSTS_NI) &&
+                      (idinten & DW_MCI_IDSTS_NI)) ||
+                     ((idsts & DW_MCI_IDSTS_AI) &&
+                      (idinten & DW_MCI_IDSTS_AI));
+
+    /* The top-level interrupt is the logical OR of the BIU and IDMAC lines */
+    qemu_set_irq(s->irq, core_irq || idmac_irq);
+}
+
+static void dw_mci_set_idmac_status(DwMciState *s, uint32_t status)
+{
+    unsigned idsts = dw_mci_idsts_reg(s);
+    uint32_t idinten = s->regs[dw_mci_idinten_reg(s)];
+
+    s->regs[idsts] |= status;
+
+    /*
+     * NIS and AIS are sticky summary events, not aliases of the individual
+     * status bits.  The databook requires both the member interrupt and its
+     * group interrupt to be enabled before the summary is raised.
+     */
+    if ((status & DW_MCI_IDSTS_NORMAL & idinten) &&
+        (idinten & DW_MCI_IDSTS_NI)) {
+        s->regs[idsts] |= DW_MCI_IDSTS_NI;
+    }
+    if ((status & DW_MCI_IDSTS_ABNORMAL & idinten) &&
+        (idinten & DW_MCI_IDSTS_AI)) {
+        s->regs[idsts] |= DW_MCI_IDSTS_AI;
+    }
+}
+
+static void dw_mci_update_fifo_interrupts(DwMciState *s)
+{
+    uint32_t fifo_words = DIV_ROUND_UP(s->fifo_len, sizeof(uint32_t));
+    uint32_t tx_wmark = FIELD_EX32(s->regs[R_FIFOTH], FIFOTH, TX_WMARK);
+    uint32_t rx_wmark = FIELD_EX32(s->regs[R_FIFOTH], FIFOTH, RX_WMARK);
+
+    if (!s->transfer_active) {
+        s->regs[R_RINTSTS] &= ~(DW_MCI_INT_RXDR | DW_MCI_INT_TXDR);
+    } else if (s->transfer_write) {
+        if (fifo_words <= tx_wmark) {
+            s->regs[R_RINTSTS] |= DW_MCI_INT_TXDR;
+        } else {
+            s->regs[R_RINTSTS] &= ~DW_MCI_INT_TXDR;
+        }
+        s->regs[R_RINTSTS] &= ~DW_MCI_INT_RXDR;
+    } else {
+        if (fifo_words > rx_wmark) {
+            s->regs[R_RINTSTS] |= DW_MCI_INT_RXDR;
+        } else {
+            s->regs[R_RINTSTS] &= ~DW_MCI_INT_RXDR;
+        }
+        s->regs[R_RINTSTS] &= ~DW_MCI_INT_TXDR;
+    }
+    dw_mci_update_irq(s);
+}
+
+static void dw_mci_send_auto_stop(DwMciState *s)
+{
+    SDRequest request = { .cmd = 12, .arg = 0 };
+    uint8_t response[16];
+    size_t response_len;
+
+    if (!s->transfer_send_stop) {
+        return;
+    }
+    s->transfer_send_stop = false;
+    response_len = sdbus_do_command(&s->sdbus, &request, response,
+                                    sizeof(response));
+    if (response_len == sizeof(uint32_t)) {
+        /* Auto-stop preserves the preceding response in RESP0 */
+        s->regs[R_RESP1] = ldl_be_p(response);
+        s->regs[R_STATUS] = FIELD_DP32(s->regs[R_STATUS], STATUS,
+                                       RESPONSE_INDEX, request.cmd);
+    }
+    s->regs[R_RINTSTS] |= DW_MCI_INT_ACD;
+}
+
+static void dw_mci_complete_data(DwMciState *s)
+{
+    dw_mci_send_auto_stop(s);
+    s->regs[R_RINTSTS] |= DW_MCI_INT_DATA_OVER;
+    s->transfer_active = false;
+    s->transfer_remaining = 0;
+    dw_mci_update_fifo_interrupts(s);
+}
+
+static void dw_mci_set_data_error(DwMciState *s)
+{
+    s->regs[R_RINTSTS] |= DW_MCI_INT_DRTO;
+    s->transfer_active = false;
+    dw_mci_update_fifo_interrupts(s);
+}
+
+static void dw_mci_refill_fifo(DwMciState *s)
+{
+    uint8_t buffer[DW_MCI_DMA_CHUNK_SIZE];
+    uint32_t capacity = dw_mci_fifo_capacity(s);
+
+    while (s->transfer_active && !s->transfer_write &&
+           s->transfer_remaining && s->fifo_len < capacity) {
+        uint32_t length = MIN((uint32_t)sizeof(buffer),
+                              s->transfer_remaining);
+
+        length = MIN(length, capacity - s->fifo_len);
+        sdbus_read_data(&s->sdbus, buffer, length);
+        dw_mci_fifo_push(s, buffer, length);
+        s->transfer_remaining -= length;
+        s->regs[R_TCBCNT] += length;
+    }
+    if (!s->transfer_remaining) {
+        /*
+         * DATA_OVER follows completion at the card side. Keep the transfer
+         * active until the guest drains prefetched data so FIFO status still
+         * describes the readable bytes.
+         */
+        s->regs[R_RINTSTS] |= DW_MCI_INT_DATA_OVER;
+    }
+    dw_mci_update_fifo_interrupts(s);
+}
+
+static void dw_mci_store_response(DwMciState *s, const uint8_t *response,
+                                  size_t length)
+{
+    s->regs[R_RESP0] = 0;
+    s->regs[R_RESP1] = 0;
+    s->regs[R_RESP2] = 0;
+    s->regs[R_RESP3] = 0;
+
+    if (length == 4) {
+        s->regs[R_RESP0] = ldl_be_p(response);
+    } else if (length == 16) {
+        /*
+         * SDBus returns a long response most-significant word first, while
+         * the controller exposes its least-significant word in RESP0.
+         */
+        s->regs[R_RESP0] = ldl_be_p(response + 12);
+        s->regs[R_RESP1] = ldl_be_p(response + 8);
+        s->regs[R_RESP2] = ldl_be_p(response + 4);
+        s->regs[R_RESP3] = ldl_be_p(response);
+    }
+}
+
+static bool dw_mci_idmac_armed(DwMciState *s)
+{
+    return (s->regs[R_CTRL] & R_CTRL_USE_IDMAC_MASK) &&
+           (s->regs[R_BMOD] & R_BMOD_ENABLE_MASK) &&
+           FIELD_EX32(s->hcon, HCON, TRANS_MODE) == 0 &&
+           !s->idmac_fatal;
+}
+
+static bool dw_mci_send_command(DwMciState *s, uint32_t command)
+{
+    SDRequest request = { 0 };
+    uint8_t response[16];
+    bool response_expected = command & R_CMD_RESP_EXP_MASK;
+    bool long_response = command & R_CMD_RESP_LONG_MASK;
+    size_t response_len;
+
+    s->regs[R_CMD] = command & ~R_CMD_START_MASK;
+
+    if (command & R_CMD_UPD_CLK_MASK) {
+        /* No card command is sent, so the CIU must not raise Command Done */
+        return true;
+    }
+
+    if (!sdbus_get_inserted(&s->sdbus) && response_expected) {
+        s->regs[R_RINTSTS] |= DW_MCI_INT_CMD_DONE | DW_MCI_INT_RTO;
+        dw_mci_update_irq(s);
+        return false;
+    }
+
+    request.cmd = FIELD_EX32(command, CMD, INDEX);
+    request.arg = s->regs[R_CMDARG];
+    response_len = sdbus_do_command(&s->sdbus, &request, response,
+                                    sizeof(response));
+
+    if (response_expected &&
+        ((!long_response && response_len != 4) ||
+         (long_response && response_len != 16))) {
+        s->regs[R_RINTSTS] |= DW_MCI_INT_CMD_DONE | DW_MCI_INT_RTO;
+        dw_mci_update_irq(s);
+        return false;
+    }
+    if (response_expected) {
+        dw_mci_store_response(s, response, response_len);
+        s->regs[R_STATUS] = FIELD_DP32(s->regs[R_STATUS], STATUS,
+                                       RESPONSE_INDEX, request.cmd);
+    }
+
+    s->regs[R_RINTSTS] |= DW_MCI_INT_CMD_DONE;
+
+    if (command & R_CMD_STOP_MASK) {
+        s->transfer_active = false;
+        s->transfer_remaining = 0;
+        s->transfer_send_stop = false;
+        dw_mci_update_fifo_interrupts(s);
+        return true;
+    }
+
+    if (command & R_CMD_DAT_EXP_MASK) {
+        if (!sdbus_get_inserted(&s->sdbus) || !s->regs[R_BYTCNT]) {
+            dw_mci_set_data_error(s);
+            return false;
+        }
+        dw_mci_fifo_reset(s);
+        s->regs[R_TCBCNT] = 0;
+        s->regs[R_TBBCNT] = 0;
+        s->transfer_remaining = s->regs[R_BYTCNT];
+        s->transfer_active = true;
+        s->transfer_write = command & R_CMD_DAT_WR_MASK;
+        s->transfer_send_stop = command & R_CMD_SEND_STOP_MASK;
+        s->idmac_desc_addr = dw_mci_descriptor_base(s);
+        s->idmac_suspended = false;
+        dw_mci_set_idmac_fsm(s, DW_MCI_IDMAC_FSM_IDLE);
+
+        if (dw_mci_idmac_armed(s)) {
+            dw_mci_run_idmac(s);
+        } else if (s->transfer_write) {
+            dw_mci_update_fifo_interrupts(s);
+        } else {
+            dw_mci_refill_fifo(s);
+        }
+    }
+
+    dw_mci_update_irq(s);
+    return true;
+}
+
+static void dw_mci_set_current_descriptor(DwMciState *s,
+                                          uint64_t descriptor,
+                                          uint64_t buffer)
+{
+    if (dw_mci_is_64bit(s)) {
+        s->regs[R_IDMAC_098] = descriptor;
+        s->regs[R_IDMAC_09C] = descriptor >> 32;
+        s->regs[R_IDMAC_0A0] = buffer;
+        s->regs[R_IDMAC_0A4] = buffer >> 32;
+    } else {
+        s->regs[R_IDMAC_094] = descriptor;
+        s->regs[R_IDMAC_098] = buffer;
+    }
+}
+
+static bool dw_mci_read_descriptor32(uint64_t address,
+                                     DwMciDescriptor *result)
+{
+    DwMciIdmac32 descriptor;
+    MemTxResult tx_result;
+
+    tx_result = dma_memory_read(&address_space_memory, address, &descriptor,
+                                sizeof(descriptor), MEMTXATTRS_UNSPECIFIED);
+    if (tx_result != MEMTX_OK) {
+        return false;
+    }
+
+    result->control = le32_to_cpu(descriptor.control);
+    result->size[0] = le32_to_cpu(descriptor.sizes) &
+                      DW_MCI_IDMAC_SIZE_MASK;
+    result->size[1] = (le32_to_cpu(descriptor.sizes) >>
+                       DW_MCI_IDMAC_SIZE2_SHIFT) & DW_MCI_IDMAC_SIZE_MASK;
+    result->buffer[0] = le32_to_cpu(descriptor.buffer);
+    result->buffer[1] = le32_to_cpu(descriptor.next);
+    result->next = result->buffer[1];
+    return true;
+}
+
+static bool dw_mci_read_descriptor64(uint64_t address,
+                                     DwMciDescriptor *result)
+{
+    DwMciIdmac64 descriptor;
+    MemTxResult tx_result;
+
+    tx_result = dma_memory_read(&address_space_memory, address, &descriptor,
+                                sizeof(descriptor), MEMTXATTRS_UNSPECIFIED);
+    if (tx_result != MEMTX_OK) {
+        return false;
+    }
+
+    result->control = le32_to_cpu(descriptor.control);
+    result->size[0] = le32_to_cpu(descriptor.sizes) &
+                      DW_MCI_IDMAC_SIZE_MASK;
+    result->size[1] = 0;
+    result->buffer[0] = le32_to_cpu(descriptor.buffer_lo) |
+                        (uint64_t)le32_to_cpu(descriptor.buffer_hi) << 32;
+    result->buffer[1] = 0;
+    result->next = le32_to_cpu(descriptor.next_lo) |
+                   (uint64_t)le32_to_cpu(descriptor.next_hi) << 32;
+    return true;
+}
+
+static bool dw_mci_write_descriptor_control(uint64_t address,
+                                            uint32_t control)
+{
+    uint32_t value = cpu_to_le32(control);
+
+    return dma_memory_write(&address_space_memory, address, &value,
+                            sizeof(value), MEMTXATTRS_UNSPECIFIED) == MEMTX_OK;
+}
+
+static bool dw_mci_transfer_buffer(DwMciState *s, uint64_t address,
+                                   uint32_t length)
+{
+    uint8_t buffer[DW_MCI_DMA_CHUNK_SIZE];
+
+    while (length) {
+        uint32_t chunk = MIN(length, (uint32_t)sizeof(buffer));
+        MemTxResult result;
+
+        if (s->transfer_write) {
+            result = dma_memory_read(&address_space_memory, address, buffer,
+                                     chunk, MEMTXATTRS_UNSPECIFIED);
+            if (result != MEMTX_OK) {
+                return false;
+            }
+            sdbus_write_data(&s->sdbus, buffer, chunk);
+        } else {
+            sdbus_read_data(&s->sdbus, buffer, chunk);
+            result = dma_memory_write(&address_space_memory, address, buffer,
+                                      chunk, MEMTXATTRS_UNSPECIFIED);
+            if (result != MEMTX_OK) {
+                return false;
+            }
+        }
+
+        address += chunk;
+        length -= chunk;
+        s->transfer_remaining -= chunk;
+        s->regs[R_TCBCNT] += chunk;
+        s->regs[R_TBBCNT] += chunk;
+    }
+    return true;
+}
+
+static void dw_mci_suspend_idmac(DwMciState *s)
+{
+    s->idmac_suspended = true;
+    dw_mci_set_idmac_fsm(s, DW_MCI_IDMAC_FSM_SUSPEND);
+    dw_mci_set_idmac_status(s, DW_MCI_IDSTS_DU);
+    dw_mci_update_irq(s);
+}
+
+static void dw_mci_fatal_idmac_error(DwMciState *s)
+{
+    s->idmac_fatal = true;
+    s->idmac_suspended = false;
+    s->transfer_active = false;
+    dw_mci_set_idmac_fsm(s, DW_MCI_IDMAC_FSM_IDLE);
+    dw_mci_set_idmac_status(s, DW_MCI_IDSTS_FBE);
+    dw_mci_update_fifo_interrupts(s);
+}
+
+static uint64_t dw_mci_next_descriptor(DwMciState *s,
+                                       const DwMciDescriptor *descriptor,
+                                       uint64_t current,
+                                       uint32_t descriptor_size)
+{
+    if (descriptor->control & DW_MCI_IDMAC_CH) {
+        return descriptor->next &
+               ~(uint64_t)(dw_mci_host_bus_bytes(s) - 1);
+    }
+    if (descriptor->control & DW_MCI_IDMAC_ER) {
+        return dw_mci_descriptor_base(s);
+    }
+
+    /* DSL is expressed in host-bus-width units, not bytes */
+    return current + descriptor_size +
+           FIELD_EX32(s->regs[R_BMOD], BMOD, DSL) *
+           dw_mci_host_bus_bytes(s);
+}
+
+static bool dw_mci_run_idmac(DwMciState *s)
+{
+    uint32_t descriptor_size = dw_mci_is_64bit(s) ?
+                               sizeof(DwMciIdmac64) :
+                               sizeof(DwMciIdmac32);
+    unsigned int count = 0;
+
+    if (!s->transfer_active || !dw_mci_idmac_armed(s)) {
+        return false;
+    }
+    if (!s->idmac_desc_addr) {
+        s->idmac_desc_addr = dw_mci_descriptor_base(s);
+    }
+    if (!s->idmac_desc_addr) {
+        dw_mci_suspend_idmac(s);
+        return false;
+    }
+
+    /*
+     * Bound descriptor traversal so a cyclic guest chain cannot monopolize
+     * the vCPU. Exhaustion follows the descriptor-unavailable suspend path
+     * below, allowing the guest to recover through PLDMND.
+     */
+    while (s->transfer_remaining && count++ < DW_MCI_IDMAC_MAX_DESCS) {
+        DwMciDescriptor descriptor = { 0 };
+        uint64_t descriptor_address = s->idmac_desc_addr;
+        bool read_ok;
+        unsigned int i;
+
+        dw_mci_set_current_descriptor(s, descriptor_address, 0);
+        if (dw_mci_is_64bit(s)) {
+            read_ok = dw_mci_read_descriptor64(descriptor_address,
+                                               &descriptor);
+        } else {
+            read_ok = dw_mci_read_descriptor32(descriptor_address,
+                                               &descriptor);
+        }
+        if (!read_ok) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: failed to read IDMAC descriptor at "
+                          "0x%" PRIx64 "\n",
+                          TYPE_DW_MCI, descriptor_address);
+            dw_mci_fatal_idmac_error(s);
+            return false;
+        }
+        if (!(descriptor.control & DW_MCI_IDMAC_OWN)) {
+            dw_mci_suspend_idmac(s);
+            return false;
+        }
+
+        for (i = 0; i < ARRAY_SIZE(descriptor.buffer) &&
+                    s->transfer_remaining; i++) {
+            uint64_t buffer_address;
+            uint32_t length = MIN(descriptor.size[i],
+                                  s->transfer_remaining);
+
+            /* DES3 is a next-descriptor pointer in chained mode */
+            if (i == 1 && (descriptor.control & DW_MCI_IDMAC_CH)) {
+                break;
+            }
+            if (!length) {
+                continue;
+            }
+            buffer_address = descriptor.buffer[i] &
+                             ~(uint64_t)(dw_mci_host_bus_bytes(s) - 1);
+            dw_mci_set_current_descriptor(s, descriptor_address,
+                                          buffer_address);
+            if (!dw_mci_transfer_buffer(s, buffer_address, length)) {
+                dw_mci_fatal_idmac_error(s);
+                return false;
+            }
+        }
+
+        descriptor.control &= ~DW_MCI_IDMAC_OWN;
+        if (!dw_mci_write_descriptor_control(descriptor_address,
+                                             descriptor.control)) {
+            dw_mci_fatal_idmac_error(s);
+            return false;
+        }
+
+        if (!(descriptor.control & DW_MCI_IDMAC_DIC)) {
+            dw_mci_set_idmac_status(s, s->transfer_write ?
+                                    DW_MCI_IDSTS_TI : DW_MCI_IDSTS_RI);
+        }
+
+        if (!s->transfer_remaining) {
+            break;
+        }
+        if (descriptor.control & DW_MCI_IDMAC_LD) {
+            dw_mci_suspend_idmac(s);
+            return false;
+        }
+
+        s->idmac_desc_addr = dw_mci_next_descriptor(s, &descriptor,
+                                                    descriptor_address,
+                                                    descriptor_size);
+        if (!s->idmac_desc_addr) {
+            dw_mci_suspend_idmac(s);
+            return false;
+        }
+    }
+
+    if (s->transfer_remaining) {
+        dw_mci_suspend_idmac(s);
+        return false;
+    }
+
+    s->idmac_suspended = false;
+    dw_mci_set_idmac_fsm(s, DW_MCI_IDMAC_FSM_IDLE);
+    dw_mci_complete_data(s);
+    dw_mci_update_irq(s);
+    return true;
+}
+
+static uint64_t dw_mci_read_data(DwMciState *s, unsigned size)
+{
+    uint8_t buffer[sizeof(uint64_t)] = { 0 };
+    uint32_t length;
+
+    if (!s->transfer_active || s->transfer_write) {
+        return 0;
+    }
+    if (!s->fifo_len && s->transfer_remaining) {
+        dw_mci_refill_fifo(s);
+    }
+
+    length = MIN((uint32_t)size, s->fifo_len);
+    if (length) {
+        dw_mci_fifo_pop(s, buffer, length);
+        s->regs[R_TBBCNT] += length;
+    }
+    if (s->transfer_remaining) {
+        dw_mci_refill_fifo(s);
+    }
+    if (!s->transfer_remaining && !s->fifo_len) {
+        dw_mci_complete_data(s);
+    } else {
+        dw_mci_update_fifo_interrupts(s);
+    }
+    return ldn_le_p(buffer, size);
+}
+
+static void dw_mci_write_data(DwMciState *s, uint64_t value, unsigned size)
+{
+    uint8_t buffer[sizeof(uint64_t)] = { 0 };
+    uint32_t length;
+
+    if (!s->transfer_active || !s->transfer_write) {
+        return;
+    }
+
+    /*
+     * The functional model consumes PIO writes synchronously through SDBus.
+     * Its FIFO therefore remains empty and TXDR continues to advertise room.
+     */
+    length = MIN((uint32_t)size, s->transfer_remaining);
+    stn_le_p(buffer, size, value);
+    sdbus_write_data(&s->sdbus, buffer, length);
+    s->transfer_remaining -= length;
+    s->regs[R_TCBCNT] += length;
+    s->regs[R_TBBCNT] += length;
+
+    if (!s->transfer_remaining) {
+        dw_mci_complete_data(s);
+    } else {
+        dw_mci_update_fifo_interrupts(s);
+    }
+}
+
+static bool dw_mci_idmac_offset(hwaddr offset)
+{
+    return offset >= A_IDMAC_088 && offset <= A_IDMAC_0A4 &&
+           !(offset & 3);
+}
+
+static uint64_t dw_mci_read_idmac_register(DwMciState *s, hwaddr offset)
+{
+    unsigned reg = offset / sizeof(uint32_t);
+
+    if (!dw_mci_is_64bit(s) && offset > A_IDMAC_098) {
+        return 0;
+    }
+    return s->regs[reg];
+}
+
+static void dw_mci_write_idmac_register(DwMciState *s, hwaddr offset,
+                                        uint32_t value)
+{
+    unsigned reg = offset / sizeof(uint32_t);
+    unsigned idsts = dw_mci_idsts_reg(s);
+    unsigned idinten = dw_mci_idinten_reg(s);
+
+    if (reg == idsts) {
+        s->regs[reg] &= ~(value & DW_MCI_IDSTS_MASK);
+    } else if (reg == idinten) {
+        s->regs[reg] = value & DW_MCI_IDSTS_MASK;
+    } else if (offset == A_IDMAC_088) {
+        s->regs[reg] = value & ~(dw_mci_host_bus_bytes(s) - 1);
+    } else if (dw_mci_is_64bit(s) && offset == A_IDMAC_08C) {
+        s->regs[reg] = value;
+    }
+    dw_mci_update_irq(s);
+}
+
+static void dw_mci_reset_idmac(DwMciState *s)
+{
+    s->regs[R_BMOD] = 0;
+    s->regs[R_IDMAC_088] = 0;
+    if (dw_mci_is_64bit(s)) {
+        s->regs[R_IDMAC_08C] = 0;
+        s->regs[R_IDMAC_090] = 0;
+        s->regs[R_IDMAC_094] = 0;
+        s->regs[R_IDMAC_098] = 0;
+        s->regs[R_IDMAC_09C] = 0;
+        s->regs[R_IDMAC_0A0] = 0;
+        s->regs[R_IDMAC_0A4] = 0;
+    } else {
+        s->regs[R_IDMAC_08C] = 0;
+        s->regs[R_IDMAC_090] = 0;
+        s->regs[R_IDMAC_094] = 0;
+        s->regs[R_IDMAC_098] = 0;
+    }
+    s->idmac_desc_addr = 0;
+    s->idmac_suspended = false;
+    s->idmac_fatal = false;
+}
+
+static uint64_t dw_mci_ctrl_pre_write(RegisterInfo *reg, uint64_t value)
+{
+    DwMciState *s = DW_MCI(reg->opaque);
+
+    if (value & R_CTRL_RESET_MASK) {
+        /*
+         * CTRL.controller_reset only resets the BIU/CIU interface and its
+         * state machines.  In particular, it must not clear registers, FIFO
+         * contents, interrupt state, or the IDMAC CSR block.
+         */
+        s->transfer_active = false;
+        s->transfer_remaining = 0;
+        s->transfer_send_stop = false;
+        value &= ~(BIT(6) | BIT(7) | BIT(8));
+    }
+    if (value & R_CTRL_FIFO_RESET_MASK) {
+        dw_mci_fifo_reset(s);
+    }
+    /* CTRL.dma_reset belongs to the external DMA handshake, not IDMAC */
+    return value & ~(R_CTRL_RESET_MASK | R_CTRL_FIFO_RESET_MASK |
+                     R_CTRL_DMA_RESET_MASK);
+}
+
+static void dw_mci_ctrl_post_write(RegisterInfo *reg, uint64_t value)
+{
+    DwMciState *s = DW_MCI(reg->opaque);
+
+    dw_mci_update_irq(s);
+}
+
+static void dw_mci_pwren_post_write(RegisterInfo *reg, uint64_t value)
+{
+    DwMciState *s = DW_MCI(reg->opaque);
+
+    if (value & 1) {
+        sdbus_set_voltage(&s->sdbus, SD_VOLTAGE_3_3V);
+    }
+}
+
+static uint64_t dw_mci_cmd_pre_write(RegisterInfo *reg, uint64_t value)
+{
+    DwMciState *s = DW_MCI(reg->opaque);
+    uint32_t command = value;
+
+    if (command & R_CMD_START_MASK) {
+        dw_mci_send_command(s, command);
+    }
+    return command & ~R_CMD_START_MASK;
+}
+
+static void dw_mci_status_post_write(RegisterInfo *reg, uint64_t value)
+{
+    DwMciState *s = DW_MCI(reg->opaque);
+
+    dw_mci_update_fifo_interrupts(s);
+}
+
+static uint64_t dw_mci_mintsts_post_read(RegisterInfo *reg, uint64_t value)
+{
+    DwMciState *s = DW_MCI(reg->opaque);
+
+    return s->regs[R_RINTSTS] & s->regs[R_INTMASK];
+}
+
+static uint64_t dw_mci_status_post_read(RegisterInfo *reg, uint64_t value)
+{
+    DwMciState *s = DW_MCI(reg->opaque);
+    uint32_t capacity = dw_mci_fifo_capacity(s);
+    uint32_t fifo_words = DIV_ROUND_UP(s->fifo_len, sizeof(uint32_t));
+    uint32_t tx_wmark = FIELD_EX32(s->regs[R_FIFOTH], FIFOTH, TX_WMARK);
+    uint32_t rx_wmark = FIELD_EX32(s->regs[R_FIFOTH], FIFOTH, RX_WMARK);
+    uint32_t status = s->regs[R_STATUS] & R_STATUS_RESPONSE_INDEX_MASK;
+
+    status = FIELD_DP32(status, STATUS, FIFO_COUNT, fifo_words);
+    if (!s->fifo_len) {
+        status |= R_STATUS_FIFO_EMPTY_MASK;
+    }
+    if (s->fifo_len >= capacity) {
+        status |= R_STATUS_FIFO_FULL_MASK;
+    }
+    if (fifo_words > rx_wmark) {
+        status |= R_STATUS_FIFO_RX_WMARK_MASK;
+    }
+    if (fifo_words <= tx_wmark) {
+        status |= R_STATUS_FIFO_TX_WMARK_MASK;
+    }
+    if (s->transfer_active) {
+        status |= R_STATUS_BUSY_MASK;
+    }
+    return status;
+}
+
+static uint64_t dw_mci_cdetect_post_read(RegisterInfo *reg, uint64_t value)
+{
+    DwMciState *s = DW_MCI(reg->opaque);
+
+    return sdbus_get_inserted(&s->sdbus) ? 0 : 1;
+}
+
+static uint64_t dw_mci_wrtprt_post_read(RegisterInfo *reg, uint64_t value)
+{
+    DwMciState *s = DW_MCI(reg->opaque);
+
+    return sdbus_get_readonly(&s->sdbus) ? 1 : 0;
+}
+
+static uint64_t dw_mci_verid_post_read(RegisterInfo *reg, uint64_t value)
+{
+    DwMciState *s = DW_MCI(reg->opaque);
+
+    return s->verid;
+}
+
+static uint64_t dw_mci_hcon_post_read(RegisterInfo *reg, uint64_t value)
+{
+    DwMciState *s = DW_MCI(reg->opaque);
+
+    return s->hcon;
+}
+
+static uint64_t dw_mci_bmod_pre_write(RegisterInfo *reg, uint64_t value)
+{
+    DwMciState *s = DW_MCI(reg->opaque);
+
+    if (value & R_BMOD_SWRESET_MASK) {
+        uint32_t pbl = FIELD_EX32(s->regs[R_FIFOTH], FIFOTH, MSIZE);
+
+        dw_mci_reset_idmac(s);
+        /* The read-only PBL mirror is not reset with the IDMAC state */
+        s->regs[R_BMOD] = FIELD_DP32(0, BMOD, PBL, pbl);
+        return s->regs[R_BMOD];
+    }
+
+    /* PBL is a read-only mirror of FIFOTH.MSIZE */
+    return FIELD_DP32(value, BMOD, PBL,
+                      FIELD_EX32(s->regs[R_FIFOTH], FIFOTH, MSIZE));
+}
+
+static void dw_mci_bmod_post_write(RegisterInfo *reg, uint64_t value)
+{
+    DwMciState *s = DW_MCI(reg->opaque);
+
+    if (s->transfer_active && dw_mci_idmac_armed(s)) {
+        dw_mci_run_idmac(s);
+    }
+    dw_mci_update_irq(s);
+}
+
+static void dw_mci_pldmnd_post_write(RegisterInfo *reg, uint64_t value)
+{
+    DwMciState *s = DW_MCI(reg->opaque);
+
+    /* Any write, including zero, releases the descriptor-suspend state */
+    if (s->idmac_suspended && s->transfer_active &&
+        dw_mci_idmac_armed(s)) {
+        s->idmac_suspended = false;
+        dw_mci_set_idmac_fsm(s, DW_MCI_IDMAC_FSM_IDLE);
+        dw_mci_run_idmac(s);
+    }
+}
+
+static uint64_t dw_mci_pldmnd_post_read(RegisterInfo *reg, uint64_t value)
+{
+    return 0;
+}
+
+static void dw_mci_fifoth_post_write(RegisterInfo *reg, uint64_t value)
+{
+    DwMciState *s = DW_MCI(reg->opaque);
+
+    s->regs[R_BMOD] = FIELD_DP32(s->regs[R_BMOD], BMOD, PBL,
+                                 FIELD_EX32(value, FIFOTH, MSIZE));
+    dw_mci_update_fifo_interrupts(s);
+}
+
+static void dw_mci_uhs_post_write(RegisterInfo *reg, uint64_t value)
+{
+    DwMciState *s = DW_MCI(reg->opaque);
+
+    sdbus_set_voltage(&s->sdbus, value & BIT(0) ?
+                      SD_VOLTAGE_1_8V : SD_VOLTAGE_3_3V);
+}
+
+static const RegisterAccessInfo dw_mci_regs_info[] = {
+    { .name = "CTRL", .addr = A_CTRL, .reset = BIT(24),
+      .pre_write = dw_mci_ctrl_pre_write,
+      .post_write = dw_mci_ctrl_post_write },
+    { .name = "PWREN", .addr = A_PWREN, .ro = UINT32_MAX ^ BIT(0),
+      .post_write = dw_mci_pwren_post_write },
+    { .name = "CLKDIV", .addr = A_CLKDIV, .ro = 0xffffff00 },
+    { .name = "CLKSRC", .addr = A_CLKSRC, .ro = 0xfffffffc },
+    { .name = "CLKENA", .addr = A_CLKENA,
+      .ro = UINT32_MAX ^ (BIT(0) | BIT(16)) },
+    { .name = "TMOUT", .addr = A_TMOUT, .reset = 0xffffff40 },
+    { .name = "CTYPE", .addr = A_CTYPE,
+      .ro = UINT32_MAX ^ (BIT(0) | BIT(16)) },
+    { .name = "BLKSIZ", .addr = A_BLKSIZ, .reset = 0x200,
+      .ro = 0xffff0000 },
+    { .name = "BYTCNT", .addr = A_BYTCNT, .reset = 0x200 },
+    { .name = "INTMASK", .addr = A_INTMASK,
+      .post_write = dw_mci_ctrl_post_write },
+    { .name = "CMDARG", .addr = A_CMDARG },
+    { .name = "CMD", .addr = A_CMD,
+      .pre_write = dw_mci_cmd_pre_write },
+    { .name = "RESP0", .addr = A_RESP0, .ro = UINT32_MAX },
+    { .name = "RESP1", .addr = A_RESP1, .ro = UINT32_MAX },
+    { .name = "RESP2", .addr = A_RESP2, .ro = UINT32_MAX },
+    { .name = "RESP3", .addr = A_RESP3, .ro = UINT32_MAX },
+    { .name = "MINTSTS", .addr = A_MINTSTS, .ro = UINT32_MAX,
+      .post_read = dw_mci_mintsts_post_read },
+    { .name = "RINTSTS", .addr = A_RINTSTS, .w1c = UINT32_MAX,
+      .post_write = dw_mci_status_post_write },
+    { .name = "STATUS", .addr = A_STATUS, .ro = UINT32_MAX,
+      .reset = R_STATUS_FIFO_EMPTY_MASK | R_STATUS_FIFO_TX_WMARK_MASK,
+      .post_read = dw_mci_status_post_read },
+    { .name = "FIFOTH", .addr = A_FIFOTH,
+      .ro = 0x8000f000,
+      .post_write = dw_mci_fifoth_post_write },
+    { .name = "CDETECT", .addr = A_CDETECT, .ro = UINT32_MAX,
+      .post_read = dw_mci_cdetect_post_read },
+    { .name = "WRTPRT", .addr = A_WRTPRT, .ro = UINT32_MAX,
+      .post_read = dw_mci_wrtprt_post_read },
+    { .name = "GPIO", .addr = A_GPIO,
+      .ro = 0xff0000ff },
+    { .name = "TCBCNT", .addr = A_TCBCNT, .ro = UINT32_MAX },
+    { .name = "TBBCNT", .addr = A_TBBCNT, .ro = UINT32_MAX },
+    { .name = "DEBNCE", .addr = A_DEBNCE, .reset = 0x00ffffff,
+      .ro = 0xff000000 },
+    { .name = "USRID", .addr = A_USRID },
+    { .name = "VERID", .addr = A_VERID, .ro = UINT32_MAX,
+      .post_read = dw_mci_verid_post_read },
+    { .name = "HCON", .addr = A_HCON, .ro = UINT32_MAX,
+      .post_read = dw_mci_hcon_post_read },
+    { .name = "UHS_REG", .addr = A_UHS_REG,
+      .ro = UINT32_MAX ^ (BIT(0) | BIT(16)),
+      .post_write = dw_mci_uhs_post_write },
+    { .name = "RST_N", .addr = A_RST_N,
+      .ro = UINT32_MAX ^ BIT(0) },
+    { .name = "BMOD", .addr = A_BMOD, .ro = 0xffffff00,
+      .pre_write = dw_mci_bmod_pre_write,
+      .post_write = dw_mci_bmod_post_write },
+    { .name = "PLDMND", .addr = A_PLDMND,
+      .post_write = dw_mci_pldmnd_post_write,
+      .post_read = dw_mci_pldmnd_post_read },
+    { .name = "CDTHRCTL", .addr = A_CDTHRCTL,
+      .ro = 0xf000fffe },
+    { .name = "BACK_END_POWER", .addr = A_BACK_END_POWER,
+      .ro = UINT32_MAX ^ BIT(0) },
+    { .name = "UHS_REG_EXT", .addr = A_UHS_REG_EXT },
+    { .name = "DDR_REG", .addr = A_DDR_REG },
+    { .name = "ENABLE_SHIFT", .addr = A_ENABLE_SHIFT },
+};
+
+static bool dw_mci_fifo_offset(DwMciState *s, hwaddr offset)
+{
+    return offset >= s->data_offset && offset < DW_MCI_MMIO_SIZE;
+}
+
+static uint64_t dw_mci_read(void *opaque, hwaddr offset, unsigned size)
+{
+    RegisterInfoArray *reg_array = opaque;
+    DwMciState *s = DW_MCI(register_array_get_owner(reg_array));
+    DwMciClass *dmc = DW_MCI_GET_CLASS(s);
+    uint64_t value;
+
+    if (dmc->vendor_read && dmc->vendor_read(s, offset, &value, size)) {
+        return value;
+    }
+    if (dw_mci_fifo_offset(s, offset)) {
+        if (s->regs[R_CTRL] & R_CTRL_USE_IDMAC_MASK) {
+            return 0;
+        }
+        return dw_mci_read_data(s, size);
+    }
+    if (dw_mci_idmac_offset(offset)) {
+        return size == 4 ? dw_mci_read_idmac_register(s, offset) : 0;
+    }
+    if (size != 4) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid %u-byte access at 0x%" HWADDR_PRIx "\n",
+                      TYPE_DW_MCI, size, offset);
+        return 0;
+    }
+    return register_read_memory(opaque, offset, size);
+}
+
+static void dw_mci_write(void *opaque, hwaddr offset, uint64_t value,
+                         unsigned size)
+{
+    RegisterInfoArray *reg_array = opaque;
+    DwMciState *s = DW_MCI(register_array_get_owner(reg_array));
+    DwMciClass *dmc = DW_MCI_GET_CLASS(s);
+
+    if (dmc->vendor_write &&
+        dmc->vendor_write(s, offset, value, size)) {
+        return;
+    }
+    if (dw_mci_fifo_offset(s, offset)) {
+        if (!(s->regs[R_CTRL] & R_CTRL_USE_IDMAC_MASK)) {
+            dw_mci_write_data(s, value, size);
+        }
+        return;
+    }
+    if (dw_mci_idmac_offset(offset)) {
+        if (size == 4) {
+            dw_mci_write_idmac_register(s, offset, value);
+        }
+        return;
+    }
+    if (size != 4) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid %u-byte access at 0x%" HWADDR_PRIx "\n",
+                      TYPE_DW_MCI, size, offset);
+        return;
+    }
+    register_write_memory(opaque, offset, value, size);
+}
+
+static const MemoryRegionOps dw_mci_ops = {
+    .read = dw_mci_read,
+    .write = dw_mci_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+        .unaligned = false,
+    },
+};
+
+static void dw_mci_set_inserted(DeviceState *dev, bool inserted)
+{
+    DwMciState *s = DW_MCI(dev);
+
+    if (s->card_inserted == inserted) {
+        return;
+    }
+    s->card_inserted = inserted;
+    s->regs[R_RINTSTS] |= DW_MCI_INT_CD;
+    dw_mci_update_irq(s);
+}
+
+static void dw_mci_set_readonly(DeviceState *dev, bool readonly)
+{
+    DwMciState *s = DW_MCI(dev);
+
+    s->card_readonly = readonly;
+}
+
+static void dw_mci_bus_class_init(ObjectClass *klass, const void *data)
+{
+    SDBusClass *sbc = SD_BUS_CLASS(klass);
+
+    sbc->set_inserted = dw_mci_set_inserted;
+    sbc->set_readonly = dw_mci_set_readonly;
+}
+
+static void dw_mci_reset(DeviceState *dev)
+{
+    DwMciState *s = DW_MCI(dev);
+    DwMciClass *dmc = DW_MCI_GET_CLASS(s);
+    int i;
+
+    s->transfer_active = false;
+    s->transfer_write = false;
+    s->transfer_send_stop = false;
+    s->transfer_remaining = 0;
+    s->idmac_desc_addr = 0;
+    s->idmac_suspended = false;
+    s->idmac_fatal = false;
+    dw_mci_fifo_reset(s);
+    memset(s->regs, 0, sizeof(s->regs));
+
+    for (i = 0; i < ARRAY_SIZE(s->regs_info); i++) {
+        register_reset(&s->regs_info[i]);
+    }
+    s->regs[R_FIFOTH] = FIELD_DP32(0, FIFOTH, RX_WMARK,
+                                   s->fifo_depth - 1);
+    s->regs[R_RST_N] = 1;
+    if (dmc->vendor_reset) {
+        dmc->vendor_reset(s);
+    }
+    s->card_inserted = sdbus_get_inserted(&s->sdbus);
+    s->card_readonly = sdbus_get_readonly(&s->sdbus);
+    sdbus_set_voltage(&s->sdbus, SD_VOLTAGE_3_3V);
+    dw_mci_update_irq(s);
+}
+
+static void dw_mci_realize(DeviceState *dev, Error **errp)
+{
+    DwMciState *s = DW_MCI(dev);
+
+    if (!s->fifo_depth || s->fifo_depth > DW_MCI_FIFO_MAX_WORDS) {
+        error_setg(errp, "invalid DW MCI FIFO depth %u", s->fifo_depth);
+        return;
+    }
+    if ((s->data_offset != 0x100 && s->data_offset != 0x200) ||
+        s->data_offset >= DW_MCI_MMIO_SIZE) {
+        error_setg(errp, "invalid DW MCI DATA offset 0x%x",
+                   s->data_offset);
+    }
+}
+
+static int dw_mci_post_load(void *opaque, int version_id)
+{
+    DwMciState *s = opaque;
+    uint32_t capacity = dw_mci_fifo_capacity(s);
+
+    if (s->fifo_head >= capacity || s->fifo_len > capacity) {
+        return -EINVAL;
+    }
+    dw_mci_update_fifo_interrupts(s);
+    return 0;
+}
+
+static const VMStateDescription dw_mci_vmsd = {
+    .name = TYPE_DW_MCI,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = dw_mci_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, DwMciState, DW_MCI_REG_COUNT),
+        VMSTATE_UINT8_ARRAY(fifo, DwMciState, DW_MCI_FIFO_MAX_BYTES),
+        VMSTATE_UINT32(fifo_head, DwMciState),
+        VMSTATE_UINT32(fifo_len, DwMciState),
+        VMSTATE_UINT32(transfer_remaining, DwMciState),
+        VMSTATE_UINT64(idmac_desc_addr, DwMciState),
+        VMSTATE_BOOL(transfer_active, DwMciState),
+        VMSTATE_BOOL(transfer_write, DwMciState),
+        VMSTATE_BOOL(transfer_send_stop, DwMciState),
+        VMSTATE_BOOL(idmac_suspended, DwMciState),
+        VMSTATE_BOOL(idmac_fatal, DwMciState),
+        VMSTATE_BOOL(card_inserted, DwMciState),
+        VMSTATE_BOOL(card_readonly, DwMciState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void dw_mci_init(Object *obj)
+{
+    DwMciState *s = DW_MCI(obj);
+    DwMciClass *dmc = DW_MCI_GET_CLASS(s);
+    RegisterInfoArray *reg_array;
+
+    s->verid = dmc->verid;
+    s->hcon = dmc->hcon;
+    s->data_offset = dmc->data_offset;
+    s->fifo_depth = dmc->fifo_depth;
+
+    qbus_init(&s->sdbus, sizeof(s->sdbus), TYPE_DW_MCI_BUS,
+              DEVICE(obj), "sd-bus");
+    memory_region_init(&s->iomem, obj, TYPE_DW_MCI, DW_MCI_MMIO_SIZE);
+    reg_array = register_init_block32(DEVICE(obj), dw_mci_regs_info,
+                                      ARRAY_SIZE(dw_mci_regs_info),
+                                      s->regs_info, s->regs,
+                                      &dw_mci_ops, false,
+                                      DW_MCI_MMIO_SIZE);
+    memory_region_add_subregion(&s->iomem, 0, &reg_array->mem);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
+}
+
+static void dw_mci_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    DwMciClass *dmc = DW_MCI_CLASS(klass);
+
+    dmc->verid = 0x5342240a;
+    dmc->hcon = FIELD_DP32(0, HCON, CARD_TYPE, 1);
+    dmc->hcon = FIELD_DP32(dmc->hcon, HCON, HBUS_TYPE, 1);
+    dmc->hcon = FIELD_DP32(dmc->hcon, HCON, HDATA_WIDTH, 1);
+    dmc->hcon = FIELD_DP32(dmc->hcon, HCON, HADDR_WIDTH, 9);
+    dmc->hcon = FIELD_DP32(dmc->hcon, HCON, FIFO_RAM_INSIDE, 1);
+    dmc->data_offset = 0x200;
+    dmc->fifo_depth = 256;
+
+    dc->realize = dw_mci_realize;
+    dc->vmsd = &dw_mci_vmsd;
+    device_class_set_legacy_reset(dc, dw_mci_reset);
+}
+
+SDBus *dw_mci_get_bus(DwMciState *s)
+{
+    return &s->sdbus;
+}
+
+static const TypeInfo dw_mci_info = {
+    .name = TYPE_DW_MCI,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(DwMciState),
+    .instance_init = dw_mci_init,
+    .class_size = sizeof(DwMciClass),
+    .class_init = dw_mci_class_init,
+};
+
+static const TypeInfo dw_mci_bus_info = {
+    .name = TYPE_DW_MCI_BUS,
+    .parent = TYPE_SD_BUS,
+    .instance_size = sizeof(SDBus),
+    .class_size = sizeof(SDBusClass),
+    .class_init = dw_mci_bus_class_init,
+};
+
+static void dw_mci_register_types(void)
+{
+    type_register_static(&dw_mci_bus_info);
+    type_register_static(&dw_mci_info);
+}
+
+type_init(dw_mci_register_types)
diff --git a/hw/sd/Kconfig b/hw/sd/Kconfig
index c69bf24f8d..dc3ebefa52 100644
--- a/hw/sd/Kconfig
+++ b/hw/sd/Kconfig
@@ -10,6 +10,11 @@ config SSI_SD
 config SD
     bool
 
+config DW_MCI
+    bool
+    select REGISTER
+    select SD
+
 config SDHCI
     bool
     select SD
diff --git a/hw/sd/meson.build b/hw/sd/meson.build
index ebf09e30a4..d7b97cdca4 100644
--- a/hw/sd/meson.build
+++ b/hw/sd/meson.build
@@ -1,5 +1,6 @@
 system_ss.add(when: 'CONFIG_PL181', if_true: files('pl181.c'))
 system_ss.add(when: 'CONFIG_SD', if_true: files('sd.c', 'core.c'))
+system_ss.add(when: 'CONFIG_DW_MCI', if_true: files('dw_mci.c'))
 system_ss.add(when: 'CONFIG_SDHCI', if_true: files('sdhci.c'))
 system_ss.add(when: 'CONFIG_SDHCI_PCI', if_true: files('sdhci-pci.c'))
 system_ss.add(when: 'CONFIG_SSI_SD', if_true: files('ssi-sd.c'))
-- 
2.53.0


