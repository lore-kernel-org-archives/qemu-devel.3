Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF95C79FAD
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tIH-0000QJ-Eh; Tue, 08 Sep 2026 06:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tIE-0000Ly-0x; Tue, 08 Sep 2026 06:43:10 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tIC-0006bO-AG; Tue, 08 Sep 2026 06:43:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRyIw3prlc31ABHicuOcPJe7oBBmfQsB/uGjnhfjKZuczLkJ0akoHnOWSdZ7xqwusZZFIH7K9QsVSyu2CjETGr5mMD3TtK/Pyxug07T62Cr7VD+cLzI6aeBPc59Dx6M/2yqcPLDh9MNeEYM9hXeLzvK3yNsuLahJm2BxtOdop9N+cTfh0XNUuxTdk6Vglxr6aawWvF4m3Fs3ADnGuMoEMXm4EMK9OPP44ILWx1btFqvGpxvIJ5pcjxnkiMuljVqZWD44rr+JJUMI0ka1M2XLyXfgbLto9jC+1FwqiTzwGiTRJ6MviOriibRFDkK0D8hthZ3+Fs2fw1WXUYRdd9vrwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kILLdSQmAgvokAlhI3gBL70d5IwS5gwCPheh8lg7VY0=;
 b=UY4tI/gXqAKYIhHMLlrwe2Jj3vW68eWT4baI3uaeO3NfwnEm5qZaemm8Legcilo/2GbuAK1IIsDGOW/9uYBPcjiXgIfE8hlkd5YnLnXZaLKYrRqFVRBXy6wQ4rZxvMr5Fudi4bSHoiyp8WtGCPEXhZRJ+gEQT7DH0WGLTR2e0K6aGBSJGaEQV9F9OVqdaVmFFjFbvcwnmetvb5ZJmRf5ULcafvcPWaHl/u8clMsT7V2cGAxFDXss8CzgkAhQ22jOLzPnb3JtvAUmo5REoUanlKu6BDXrrMdYGmqj8co9L00Wbn6zMCKT5xLy+kSZ58xawgoBlciF1nEgPydc4Zw0rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kILLdSQmAgvokAlhI3gBL70d5IwS5gwCPheh8lg7VY0=;
 b=ADl5oI7A0tMI9OnkyA7aqhiAdfqZ0T5YPI9T8fKz43kDwnV7hpbdQr/xYvGc3zz1IEUA9ueQQYY5Y1b2FbAk1hojuO+PHAq24wFQbsyr6pch506ns/b/sY+3n1+ivvZNPOVgMcuaP+wO7+MencS3DFqehHpt7HrJ8EOmUkN3iVQeh9kHgokjV/dA4fR5p3OvJlzg4WmUKFi8/2D5w9YXvzChRH61YZS6IAAWqVLtsCg5fx5bCtwl5sppkY9SlIq3o4xNqY7AUh7kZ5S94PPbOfwQoezgs2nwodhKzOyyk9rtv7TvVNnUsO9oNRASBk1uXwY3dB6ywj13aSe7vg0NIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com (2603:1096:301:78::7)
 by SEYPR02MB6579.apcprd02.prod.outlook.com (2603:1096:101:139::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 10:42:57 +0000
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616]) by PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 10:42:57 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v2 26/32] hw/arm: phytium: Connect the Phytium E2000Q COMe
 QSPI flash
Date: Tue,  8 Sep 2026 18:41:35 +0800
Message-ID: <20260908104159.1621764-27-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908104159.1621764-1-bin.meng@processmission.com>
References: <20260908104159.1621764-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0041.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::15) To PSAPR02MB4984.apcprd02.prod.outlook.com
 (2603:1096:301:78::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR02MB4984:EE_|SEYPR02MB6579:EE_
X-MS-Office365-Filtering-Correlation-Id: c950d3aa-a3ae-40ca-4798-08df0d95f25c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|6133799003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: HBDg8wgPTxMtfei32ANx62Py/Awjaud1UiLj/tsg+ih+cL+3cScCQVPcSj6pEhNsuJd5lPFUMB31EJSDoSwuLGI9Ey/WtYQwQ0nnxYnX8RXHYxUP2phGqgFcDlPvTScHQ7HNWnXuPfBDLUjIEL11IOrhO7vU3vDMbmuthi6f97WcODuZ4CdEwsBNFQA4CkUVjfr/6XHpSG4tnPY4q78KRidi13ve1mA9W0Pb7Jgycc8oYgsBife350fa17kPuHOZd44KErhq+/WzDZkm3CkFfmycA2I/C3A8ZTTS0AHzgyV29xW6nW7eY48iUxyy/6hGAYYvafnxcvaZsG12WhDyWUVNqbRppRtx0uFsbvc1scVBvdcUtDrmnZ4Z6PDoSWjy2wgwgRLmKwioDAMLFDBmyTXjKv7EPuM0EvxQ5seP0ApMjusAG5+b5iDD786p0QNB7DuvmCc2eSWQLadl00vjQVDfHzAVMl4qgol6uYCPgdbt+1EjRr69VRZahHNkayKEIw7BE6qnTgNZmmEoDttge5LP9O3HqzrVm6ySQZI56phln89Kyizj4zRmrVGJc02u+5tWtJidJQcCvtOq9cedLGmVl0YRcO/v/zsZSKG7ylVRYpMQrJc3wKBsITVdoZSnqluFKq0sA3uIy/Dc00x7ulFIf7tpid8OqQVyL9latCk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PSAPR02MB4984.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m6Pq+6kl/NdgaoI3Jvo/RB5nczbUHRyD6GJuC3BN0qcAMcqoea3bXdV5HeW3?=
 =?us-ascii?Q?u9hi2TzU0NWZSPHu7I7C2P4CFw255xumonKpQ4B5hW4/4QgJoq8gRXQfmwDU?=
 =?us-ascii?Q?tXr1Z5aBg3cxDkdIQRqDWjF38LhFSiqUF3GcK9cU379wvKtU5Sgvsfb8lRRd?=
 =?us-ascii?Q?QamkRINkozlQJQXzFrMIAMJ8NuayZdKLp3aU5MKfjBcCP6bJQG3+Xoy5U/LB?=
 =?us-ascii?Q?9F9BIWGsIduWExkX9MZuxegVIWeE8LuoVz+jAjfjqWtdx5AKsMaR7a+qQ8jq?=
 =?us-ascii?Q?UNE/UVFl+NHFAXsQMbs7Eh/BQtFonjke6LpfKtDWPrkt3ffn5qsqW2UaSjbz?=
 =?us-ascii?Q?WcqgA/3qUZ7pUgoLA9/2afNPXn5BCx3yRVESes6FeVVgjDwVA+wiJHWULsdJ?=
 =?us-ascii?Q?3OjCllagaDA8PzemE7LGQoArso+WneiP/NFSfcIugQ2Es2aAV2m16fPC8Me5?=
 =?us-ascii?Q?nCdsjMQe1RcehoMSd2UFPpK81oLD7xZsque/kTniqjUnltEoZI1T4UENSqzC?=
 =?us-ascii?Q?TDI4VDip3eOLS/KExf60IC3TQFt4FISU9kWfO5CPaYkx8018hNZ6cuA7N7aF?=
 =?us-ascii?Q?j3Sli5SX5ECYuGJfe1yjDn+dUOCFk6MpDTEPBV8JbtaHq7vvJeeMOcCjokr9?=
 =?us-ascii?Q?NeC65fFwmXnDU2mA45wN1HQs67HQf7qoBHmwwwz5MHOxy1JSUQ6RE60aRtrd?=
 =?us-ascii?Q?1ulRjtwHTbkgC01Ur8uMc6oEBMpqCw+LsiVWg00KUT2+4LQHwG5KN/Fn16Tl?=
 =?us-ascii?Q?XMpz0iNL+HFf6CKDssuUdwR0JrupsYnbCSGOHSUK3s0VR3sbrkL4m9mR98E5?=
 =?us-ascii?Q?2qyE11Tkm9uZmreU7LvmeUE39rflbvIdOth+udUksGZBmNm+oprcA1oWTNRY?=
 =?us-ascii?Q?UfZI4CILqUgSqiZuwND7/MxnTRnuN9Ou7e9nSZdIk8bMfa++mpKXxiQfa+9+?=
 =?us-ascii?Q?emdNtdin8QCWi8FYuxUgUhX4xNu6f4tyK6fllUiFy8GjWZFbXJqxd7vS5w+6?=
 =?us-ascii?Q?+EuJlG2ydwXL5vMQLXT0GcKr3kbsKH6t9B+EFyptPno6gMGjTDzPIzrnB6V4?=
 =?us-ascii?Q?lAsyCUmQoz9vU1OoNHrxr1d/YkHlWJzTCTH4g2Iq3ReT5s6YrMro4LsHXv+n?=
 =?us-ascii?Q?WedWs07k+wIVFeN0Rvhmltw9pc3XtL2nSXr7prtOuMojA7Bt+Ifpv3+vrKUr?=
 =?us-ascii?Q?3TiTzk8XE9qM96BGISVUIqYPanYPKhjuKym0zEfaP6YVYCx94jcxuYeG/kBa?=
 =?us-ascii?Q?6LT0La5O48LHIZdkYVwGf+GVefYq1H1TympBxvzggk2N2E+ntG3vLvhtyW7g?=
 =?us-ascii?Q?FOs8w0vFxB4opGdYr/Tl/GUR945C6ik+ljjyeU7ld+FQ0Zf/EkpY4LHu1hxV?=
 =?us-ascii?Q?Z3By+gqULA2GmYWFTgkZew6UA4Em/W91XcigyJKghKWpVBCFFpeynLHsBm1T?=
 =?us-ascii?Q?1EbFwX9POa6IsubNeXPse9La6HkTwNTHSfKvzL8P3MbSSCYWVT7DRXSkD+4O?=
 =?us-ascii?Q?scYEcpIMKZbX2/L6Q5CUMgF7CLkfbSU5GBdy9lPqeccyYf6w2UeNLNZAOznk?=
 =?us-ascii?Q?JpMevSsB+MN4CSAWb9xJ4sYU4PxUkqDGXucC/GeDaniTkizuYolICTfZ8tx6?=
 =?us-ascii?Q?FJ8aWcrKD9jrjaPMLH8gVsY7dOS4MA2hRA3/VUE810RZV91oIiNt5PL31Af6?=
 =?us-ascii?Q?0sduSh3vTOeMC3Wryeglsh6BBro2UVEVYUS+k91TOXAclIYR6hgW6NxhzLMy?=
 =?us-ascii?Q?uWvA8JMQ4Ht841uJDm8jxxWyUz6Tc9M=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c950d3aa-a3ae-40ca-4798-08df0d95f25c
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4984.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 10:42:57.8024 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e9aSFnurSyrvXGOPPyzb7wQoGIeU1rs8P0zCLADh40XdB9/5Xm0SjxKih7a2INdXmomWcdG9UhVjOXqYubdqAAgvthn8GPyls9JGzoz9P/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB6579
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

Attach the board GD25Q128 to QSPI0 chip select zero and expose an
MTD backend for COMe firmware storage.

Describe the flash model in the COMe machine class so the shared
E2000 SoC still instantiates QSPI0 while Phytium Pi does not acquire
a board-level SPI flash.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v2:
- Keep QSPI flash ownership in the COMe machine
- Pass the board flash backend into the E2000 SoC
- Use the typed QSPI child through generic qdev interfaces

 include/hw/arm/phytium_e2000.h |  2 ++
 hw/arm/phytium_e2000.c         | 13 +++++++++++++
 hw/arm/phytium_e2000_machine.c | 33 +++++++++++++++++++++++++++++----
 hw/arm/Kconfig                 |  1 +
 4 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/include/hw/arm/phytium_e2000.h b/include/hw/arm/phytium_e2000.h
index ee645ce530..baf9edd261 100644
--- a/include/hw/arm/phytium_e2000.h
+++ b/include/hw/arm/phytium_e2000.h
@@ -105,5 +105,7 @@ bool phytium_e2000_soc_firmware_loaded(PhytiumE2000SoCState *s);
 void phytium_e2000_soc_attach_sd_card(PhytiumE2000SoCState *s,
                                       unsigned int index,
                                       BlockBackend *blk);
+void phytium_e2000_soc_attach_qspi_flash(PhytiumE2000SoCState *s,
+                                         DeviceState *flash);
 
 #endif
diff --git a/hw/arm/phytium_e2000.c b/hw/arm/phytium_e2000.c
index 33617e793a..4ded28814e 100644
--- a/hw/arm/phytium_e2000.c
+++ b/hw/arm/phytium_e2000.c
@@ -32,6 +32,7 @@
 #include "hw/pci-host/gpex.h"
 #include "hw/sd/sd.h"
 #include "hw/ssi/phytium_qspi.h"
+#include "hw/ssi/ssi.h"
 #include "hw/usb/xhci.h"
 #include "net/net.h"
 #include "qobject/qlist.h"
@@ -802,6 +803,18 @@ void phytium_e2000_soc_attach_sd_card(PhytiumE2000SoCState *s,
     qdev_realize_and_unref(card, bus, &error_fatal);
 }
 
+void phytium_e2000_soc_attach_qspi_flash(PhytiumE2000SoCState *s,
+                                         DeviceState *flash)
+{
+    qemu_irq flash_cs;
+
+    qdev_realize_and_unref(flash,
+                           qdev_get_child_bus(DEVICE(s->qspi), "spi"),
+                           &error_fatal);
+    flash_cs = qdev_get_gpio_in_named(flash, SSI_GPIO_CS, 0);
+    qdev_connect_gpio_out_named(DEVICE(s->qspi), "cs", 0, flash_cs);
+}
+
 static void phytium_e2000_soc_realize(DeviceState *dev, Error **errp)
 {
     PhytiumE2000SoCState *s = PHYTIUM_E2000_SOC(dev);
diff --git a/hw/arm/phytium_e2000_machine.c b/hw/arm/phytium_e2000_machine.c
index c1944cb986..5ca2922e91 100644
--- a/hw/arm/phytium_e2000_machine.c
+++ b/hw/arm/phytium_e2000_machine.c
@@ -22,6 +22,7 @@
 #include "hw/arm/bsa.h"
 #include "hw/arm/phytium_e2000.h"
 #include "hw/core/boards.h"
+#include "hw/core/qdev-properties.h"
 #include "qom/object.h"
 #include "target/arm/cpu-qom.h"
 
@@ -48,11 +49,13 @@ struct PhytiumE2000MachineClass {
     const char *machine_name;
     const char *direct_boot_dtb;
     const char *pbr_boot_mode;
+    const char *qspi_flash_model;
 };
 
-static BlockBackend *phytium_e2000_sd_blk(int index)
+static BlockBackend *phytium_e2000_drive_blk(BlockInterfaceType type,
+                                             int index)
 {
-    DriveInfo *dinfo = drive_get(IF_SD, 0, index);
+    DriveInfo *dinfo = drive_get(type, 0, index);
 
     return dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
 }
@@ -63,10 +66,24 @@ static void phytium_e2000_attach_sd_cards(PhytiumE2000MachineState *s)
 
     for (i = 0; i < PHYTIUM_E2000_NUM_MCIS; i++) {
         phytium_e2000_soc_attach_sd_card(
-            &s->soc, i, phytium_e2000_sd_blk(i));
+            &s->soc, i, phytium_e2000_drive_blk(IF_SD, i));
     }
 }
 
+static void phytium_e2000_attach_qspi_flash(
+    PhytiumE2000MachineState *s, const char *model)
+{
+    DeviceState *flash = qdev_new(model);
+    DriveInfo *dinfo = drive_get(IF_MTD, 0, 0);
+
+    object_property_add_child(OBJECT(s), "qspi-flash", OBJECT(flash));
+    if (dinfo) {
+        qdev_prop_set_drive_err(flash, "drive", blk_by_legacy_dinfo(dinfo),
+                                &error_fatal);
+    }
+    phytium_e2000_soc_attach_qspi_flash(&s->soc, flash);
+}
+
 static void phytium_e2000_reject_legacy_firmware(
     MachineState *ms, PhytiumE2000MachineClass *pemc)
 {
@@ -204,7 +221,11 @@ static void phytium_e2000_init(MachineState *ms)
     phytium_e2000_create_ram(s);
     if (!ms->kernel_filename &&
         !strcmp(pemc->pbr_boot_mode, PHYTIUM_E2000_PBR_BOOT_MODE_SD0)) {
-        boot_blk = phytium_e2000_sd_blk(0);
+        boot_blk = phytium_e2000_drive_blk(IF_SD, 0);
+    } else if (!ms->kernel_filename &&
+               !strcmp(pemc->pbr_boot_mode,
+                       PHYTIUM_E2000_PBR_BOOT_MODE_QSPI)) {
+        boot_blk = phytium_e2000_drive_blk(IF_MTD, 0);
     } else {
         boot_blk = NULL;
     }
@@ -215,6 +236,9 @@ static void phytium_e2000_init(MachineState *ms)
                                 boot_blk, ms->ram_size, ms->smp.cpus);
     sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
     phytium_e2000_attach_sd_cards(s);
+    if (pemc->qspi_flash_model) {
+        phytium_e2000_attach_qspi_flash(s, pemc->qspi_flash_model);
+    }
 
     firmware_loaded = phytium_e2000_soc_firmware_loaded(&s->soc);
     s->bootinfo.ram_size = ms->ram_size;
@@ -303,6 +327,7 @@ static void phytium_e2000_come_class_init(ObjectClass *oc, const void *data)
     pemc->machine_name = "phytium-e2000-come";
     pemc->direct_boot_dtb = "e2000q-come-board.dtb";
     pemc->pbr_boot_mode = PHYTIUM_E2000_PBR_BOOT_MODE_QSPI;
+    pemc->qspi_flash_model = "gd25q128";
 }
 
 static const TypeInfo phytium_e2000_base_info = {
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 39a7f77611..988e8e0327 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -140,6 +140,7 @@ config PHYTIUM_E2000
     select PHYTIUM_E2000_QSPI
     select PL011
     select SD
+    select SSI_M25P80
     select UNIMP
     select USB_XHCI_SYSBUS
 
-- 
2.53.0


