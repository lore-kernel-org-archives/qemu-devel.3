Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB1B0C624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WaF-0004fs-CZ; Fri, 04 Sep 2026 12:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WZm-0004K3-DH; Fri, 04 Sep 2026 12:15:38 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WZk-0008SI-NP; Fri, 04 Sep 2026 12:15:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xUFiz63wmZ2PXizb4u28wlocAgtkdCnv9CNRjceEJbQiNE4hi1VTUxud11YIa4EpFwr8jVsv6o1c5EgVoMoVVVN/DUljEgehQAKByDbG0oTY3XlrbPzwmMaRmT33KFIvRavQoWu8gDVm0GBKGh4zmz38M/GRMXkgkz0EzzJV7hCI5MaA6O4gF7qgeU+5qOva52Cy05p/eoWXUBf/iN2DqouavYVgYP34ZvsG/dKkz73EUZDMEWJqrp1vhHE3iCkrTQlp3t2yUetE98Ci31ymZrTJS8+4Qz+zH/ZvIFZJ/BNLYudFlHNojs7rPzZhg/kFxKbfy2HD1t/eIMfUp7jnHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XpvD7mKOdYRs/Q2OK2NEFybYXmdYSKYZ7+80i7b94lE=;
 b=NLw+GD6SkuSH6t8bkpE9wmWiAZEK6fmPboqkgRKwsaJV29Y2Ve6PST+8tmRXZugADUKUw4kcF+mRlPOcF2ZVG2Bf2vTlG4aaTeehRLDY3vxoEl3zZil+gayoEVsXRV0WUxk6SuaOPcrObhjUZ0FGanLdsxK/eNDVBJ85zi/NYwrpaKrR6ioiAke84EVTzFrLqn8pY0eD6VibJtFe/sHVIdMy8sQnRU1VikHQU0oztW8Y14/9c4ZgjChwtIyuTcyfwjCgztwnZVPCkdfH9ok5xxefhf4KK++HP84GhW2DOql9OOFbckbepCDeCko2dnV/DH19jJKrIAxn3FWg/va4Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpvD7mKOdYRs/Q2OK2NEFybYXmdYSKYZ7+80i7b94lE=;
 b=d+QGElAF1ikWxIcgq0aeb3LAKeIoG8WCyqYf9hk7HH9mckVo+Ga0M1Yvx945GvO9I1242+0DtZKvh0nnxaA1wCqNkEqIyZG8H9dwcQD4L/mw/yXOf50sqyawCSVQSXA5DeSOL8Ljw1/ZxQqP4QthyVNkEqyJ1rfLRur6a/IJH38KiAVh1y6KA9pEfTgwH/oeQUYu7LFjkPqrOS48DVcnqTa24H1GYhzaS5y8wuVHkaDS5MQQb6G+0BNkN+cPZpiuw1plYO0MzbDzKL965QcIhGmjvWxVJ1iAe/zp+0GfzKuQAkM3pketRXoPgd04kgbjCB5C6woVWY3h571eAJ7NZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KU2PPFE04A6CE19.apcprd02.prod.outlook.com (2603:1096:d18::46b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 16:15:33 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 16:15:33 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org
Subject: [PATCH v2 09/10] docs/system/arm: Document MCIMX6UL-EVK Buildroot boot
Date: Sat,  5 Sep 2026 00:14:32 +0800
Message-ID: <20260904161438.3838261-10-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904161438.3838261-1-bin.meng@processmission.com>
References: <20260904161438.3838261-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PAZP264CA0120.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1ef::19) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|KU2PPFE04A6CE19:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bdd809c-3030-469b-a679-08df0a9fbf2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|22082099003|18002099003|56012099006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: VsvT/sf/ks3I31hFNtoAcmIR9tfy46LCw3UjeY3KL6tvBjfM7Ipds5p2LJJtuRpYn0lQ/BsZEm0a98SgpGpNiFQ9mXBdRMvx3y2ymvM3SB1jgpCuXHCsDhdCo++Is4Yh+Ok8nhZaJmFlipKsP9felcZXEQuz0GRqJOwY2fXt3h8I4oE2X8iyCh5S6v5Dq1rEEtn1Hn13tccuxgn/0CuPTGBEhIKR8RKwGLnqVQcGCZEmOfPNdRjahbK/TE4zSEoSceRyLrVgQoxcZ4/nOX4vfEqUev65MAEecp5/s9BlAfSrwAW1C1ZbjFGsNc3kIkAR5i4/RfiQHNvxuf4gZqWZ7KPXAdXlEKFfhRYB7akGHSzFkldTbXy4sZ/WlRnrp11E05jnYj5c9IN1loJYr2foXVtcEY8jqcUqHsUGdFGcdUn83bjl3JAYQmhdeDUnbhm5Z9A2mF+TvI4Zdu2AW1xtVaMTTTZKQGiyo8YgzL7tcswT6XPpVdJx2jMi8WBx1FfxYnOE1CJ6mkdOCdmUEL7xJzBAtrqHYWIGfSgioLlubEZlp+vKfJ+95UbpzqNiEgaDwlERQuRjRv55VtH02QC9L9g8QDAlwlHKfARsJFFi2ku4wq4IERPCchiEUTm9JGfByQmsp0PbFxr3QfvPei3VDV/5ftRlY6pp6kvGxisCb38=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(3023799007)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eOUDpHQbpgnuWtsh/UcpndTulHcOiJSDOMx6pi9QsuT1jl3LnZ9z8XjboZIx?=
 =?us-ascii?Q?oB9AVyKXz0QE/bZsZj3Gj2MEyTBHdfMVz1YMsGkSQSku49AXFpm/DkuLu4Gs?=
 =?us-ascii?Q?LzH+MqQUV08QMQcbJ4io1JkOHhC5oFZl2riRiZVd1SiCWSJhznWCT9aweaFU?=
 =?us-ascii?Q?9SJzsrIH8XJLMcnKkcwnF7ftL2vev0kjeM9obAJOPF0aoEtwnOmNdk+2pKuX?=
 =?us-ascii?Q?VAYmdKxyxyf8ky0j78RAAMQ6ZT96OCvuXHlJtmmAgdbXr/hA2xwmDHEo7OjP?=
 =?us-ascii?Q?KmdOx5fJCGviB2omyJgFNJnGO93kQiIt1+2GyBw5ia8+BnaSbCyZRZTzBYwP?=
 =?us-ascii?Q?bwEOh8rjakY9RqTztwYWr+GkDaiAF8oAoc0QSKZ7SMkgizRRb/OJL1mDAY3k?=
 =?us-ascii?Q?WEyFXzCPs/3qoJloJgcbCbxdhk3hTgf1CzlteC3eYzRyPGSere4aMPh6/bts?=
 =?us-ascii?Q?11KggUvC8XEsdNMlrFB2CNzxS0Cr9Zmkgn1n/O8b33CbVvEcsAh6i6xQ1FBL?=
 =?us-ascii?Q?KXEQWn0IQXsxNv6pfxmM/q+zfEueabfTrW0x9opz7ZGLZx2pGoTRmpbZXFLQ?=
 =?us-ascii?Q?gFHcSLVz0Hxasy+mjhu/u3Ap810WZimTqJ0atoL85Iu5nxYV7/8tPDFHrKNX?=
 =?us-ascii?Q?PDclgoNvSLL04voZS6Ojd4qYOn+cYnnnjfB+Yobd+mgQ8yjIxwwNfcoUGHpU?=
 =?us-ascii?Q?3QtARdihuntThziEGQvve2Mq0MeKTkFO6XiP0oYKzMSYmsSeoKfca/gRUSpH?=
 =?us-ascii?Q?pSkUkj3r3A/SeaetCDXkZkYb7FmdhN+OiSYs+fdXgNLf9iOYeMAha2FwfS5o?=
 =?us-ascii?Q?o6hqFnl3yb8gzM05UIxMmK/FsF2j5bdkwAS91+1H5t68ynyJML1ovu84YTxs?=
 =?us-ascii?Q?RFC8T1397Ih0KxcEkoj4D2nwbAzi4M85k4Pv1kaE3jF0HlUk9qW548ohitRf?=
 =?us-ascii?Q?Xpw7s5XrJjG1STAYOdYcwxEKDZGLgHDp9mB+OYfw/brnAlbHz/E22p3hljr4?=
 =?us-ascii?Q?mKp+VdXqFgy5wa3cKv9xJYcLL5U9dTT/tDN24QBwUdUZZ6qmImXaEkCeb8O1?=
 =?us-ascii?Q?7CpmDHVexUhJdxe9G7DI2oPISOn0xwsBhe2T/Fk+Ua5dE4zIYx8m6ijUg+vT?=
 =?us-ascii?Q?pMzhGia/OxS5nVN1ZAvDNbR6cTcU3UoI4Q0XlkRXhBtuFpwuqNSNRH1P0ckh?=
 =?us-ascii?Q?E8aKhI5SjOdyIKPE+b98RGsRtU50OQeGkWuBjd3VwAQcLVxozIov7Vf9jiVK?=
 =?us-ascii?Q?vC6l09PABU8hgBBt6J6pFqfhABEoCwP9iA6lbUSYmNpjmENi54Gjh6CZYnVR?=
 =?us-ascii?Q?U7RBdlwpaOIlJvIbKdjREO6alLOjRb89HJ/AZuLfb6gMzW0hjiFs7cc/neXO?=
 =?us-ascii?Q?/x+nnmz1lzZWvDv+azqaNdauwKYbb5b0nNR3mEKY7BnblLhMPY9aGg2RPW0i?=
 =?us-ascii?Q?FBHK4HY6j6tTfwiHStqS0PVwlIcXbyu2853dEnjP/ypbYrb8kDW+LSe9ADR6?=
 =?us-ascii?Q?QRsxyKoUXHiie2bK3Gs/8PHMvsgtkeBFos3e/339ImOzsPGYcZADgJMsOerr?=
 =?us-ascii?Q?jH5uKzU282YBC8lRZHi8m43y8aYMBWTcuTsOtp90fMVOLWTJn5Nvikj7Fqdd?=
 =?us-ascii?Q?1Jc4ZE3gQVkuuZlxflQXiYtckCEEmFzIepCAchZ3XXs1V+LIh4aUkUiEvNX0?=
 =?us-ascii?Q?0VhD9EA11jyqLu0uN9YqgVapfeZrC54jkloh5n7QiUA9ipVlku63I8lwSSTw?=
 =?us-ascii?Q?tJn7txRiLBOeUMvzTQLVo/p6wz2L6AQ=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bdd809c-3030-469b-a679-08df0a9fbf2a
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 16:15:33.3871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wzkeCSnEwd4awN+xK1H//uWopxKngMK5ltVInzjBYkqXi6rno8e9wo/irXYgfTA5949NxkinAXyjFL8QxBgXNe3yr05C3Ugzxar8dyeeTMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPFE04A6CE19
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

Provide verified instructions for U-Boot and direct Linux boot using
Buildroot images.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

(no changes since v1)

 docs/system/arm/mcimx6ul-evk.rst | 67 ++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/docs/system/arm/mcimx6ul-evk.rst b/docs/system/arm/mcimx6ul-evk.rst
index 8871138ab3..84331b734d 100644
--- a/docs/system/arm/mcimx6ul-evk.rst
+++ b/docs/system/arm/mcimx6ul-evk.rst
@@ -3,3 +3,70 @@ NXP MCIMX6UL-EVK (``mcimx6ul-evk``)
 
 The ``mcimx6ul-evk`` machine models the NXP i.MX6UltraLite Evaluation Kit
 MCIMX6UL-EVK development board. It has a single Cortex-A7 CPU.
+
+Booting Buildroot images
+------------------------
+
+Build the SD card image with the tested Buildroot version:
+
+.. code-block:: bash
+
+  $ git clone https://gitlab.com/buildroot.org/buildroot.git
+  $ cd buildroot
+  $ git checkout 2026.05
+  $ make imx6ulevk_defconfig
+  $ make
+
+The following examples use images generated by Buildroot::
+
+  IMAGES=/path/to/buildroot/output/images
+  QEMU_BUILD=/path/to/qemu/build
+
+The generated raw ``sdcard.img`` is about 84 MiB, which is not a capacity
+supported by QEMU's SD card model. Resize the image in place to 128 MiB::
+
+  "$QEMU_BUILD/qemu-img" resize -f raw "$IMAGES/sdcard.img" 128M
+
+This modifies the Buildroot output image; rebuilding the image restores its
+original size.
+
+The SD card must be attached to USDHC2 with ``index=1``. It is consequently
+named ``mmc1`` by U-Boot and ``mmcblk1`` by Linux. The first partition contains
+the kernel and device tree, while the second partition contains the root file
+system.
+
+U-Boot boot
+~~~~~~~~~~~
+
+The machine does not model the i.MX6UL Boot ROM or its SPL loading sequence.
+Load U-Boot proper at its linked address::
+
+.. code-block:: bash
+
+  "$QEMU_BUILD/qemu-system-arm" \
+      -M mcimx6ul-evk -m 512M \
+      -device loader,file="$IMAGES/u-boot.bin",addr=0x87800000,cpu-num=0 \
+      -drive file="$IMAGES/sdcard.img",if=sd,index=1,format=raw \
+      -nographic
+
+The default Buildroot U-Boot environment selects ``mmc1``, loads ``zImage``
+and ``imx6ul-14x14-evk.dtb`` from the first partition, and starts Linux with
+``/dev/mmcblk1p2`` as the root file system. A ``bad CRC`` warning while loading
+an uninitialized persistent U-Boot environment is expected; U-Boot continues
+with its compiled-in defaults.
+
+Direct Linux boot
+~~~~~~~~~~~~~~~~~
+
+QEMU can load the Buildroot kernel and device tree directly. The kernel then
+mounts the second SD card partition as its root file system::
+
+.. code-block:: bash
+
+  "$QEMU_BUILD/qemu-system-arm" \
+      -M mcimx6ul-evk -m 512M \
+      -kernel "$IMAGES/zImage" \
+      -dtb "$IMAGES/imx6ul-14x14-evk.dtb" \
+      -append "console=ttymxc0,115200 root=/dev/mmcblk1p2 rootwait rw" \
+      -drive file="$IMAGES/sdcard.img",if=sd,index=1,format=raw \
+      -nographic
-- 
2.53.0


