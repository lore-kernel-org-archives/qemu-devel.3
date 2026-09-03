Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6677DC624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x25ab-0005lt-4R; Thu, 03 Sep 2026 07:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25aZ-0005lV-Ut; Thu, 03 Sep 2026 07:26:39 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25aY-0006k3-4z; Thu, 03 Sep 2026 07:26:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g32bTiW2dR2W2Yyo4aD1GZUiOMuURwmh2PNrmQf1ogksu1Ne5Q406Y1s4j3GdZr/nLGQvJDLnFRbzuK2cSU3ZPnRr8a/AJyty/PHfqA2NDcfSKU0MeBmKriL5ICeAW1COmlzf3keCUEZmn2Zv66sJsEWh4Jeg6eRISGRBl++aZXRoPJPBYjQwXvSXbAspvUdNaBiC8rlTmdEbhxkDPYIAKiBSzs4cQjbaAjOzpPsbDH/gdBMn5q6ZT8frDeUnxFl8cTwEWoEYE9uV+h5WC5g4wu27MGRXE5aQ2up8AcIYwl7r2a1DK70qMkA6cPfHsiCHphj50azgicMWp5+qbVCbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZR4Mjz48tSo4TuJBz765Fzw8es52vYe4v3Udzse/rSo=;
 b=ABwmNKobWKke2DqiuRc4LgdAUDTIV1A+08zUeFPawSxTzOxEvAIOLzwFhqslXFq+9HkuE/Oel5rw38hFsBTItdbZW0XWQ2Ka1Dy1QaQUVNcvZDTiZrCOwG1o1xgyiyOampBqIfBZp9IlN5eDRjbrwAyemF4y37Dk46itNEofLuyNNjyuTUPOacAi+c2r4n3MFiEnFr6KrFmIoze7jfzCxo0bsGMvqSiViivLRM3VN8DFPGXsVvGDfCyHhFzpjH+UBgsFrFGCTkE9dkHwI8VCCGsyqnm3VblC+6AK53n3QtniB0zOfa7SqHV2f4QodOZZDPjcJf9zAT/8Vh1zZ73i1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZR4Mjz48tSo4TuJBz765Fzw8es52vYe4v3Udzse/rSo=;
 b=aUBoBzYEkywqtf9/l/7+glXy38EDNTFw4YR6PD9av9TOGTX9KdxQ+XitfZnjZF5Zi7HyRBB5415vNeOBha8czJf7kFRmTQ4Y6WRtiF7LTjim3wbDKq1seeisw3lW58mJ+Z03iXGLTtHQNN6Sfa1U6DaGbp6BXHQlitgEiI9k5n58fNhQQQi+M2AXW3+3N89JXKz/JeMEYDVKwDI8kE7uTDlzGZx5Rjfsp3+3nFo72PWorTy4rsKIgpSUdUG+bYB3N253amxW/DQCf2JEHtFqz2pmPIdH6ybslmmfpYQnE26rcgfIXfmioFzpjyfQU2qql5qz4XFTmiVETFiL5qJ+lA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by OSNPR02MB8962.apcprd02.prod.outlook.com (2603:1096:604:45b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 11:26:28 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 11:26:27 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH 19/33] hw/arm: phytium: Select the Phytium E2000 PBR boot
 medium
Date: Thu,  3 Sep 2026 19:24:59 +0800
Message-ID: <20260903112532.3276678-20-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903112532.3276678-1-bin.meng@processmission.com>
References: <20260903112532.3276678-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::11) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|OSNPR02MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: 934f52c8-253d-431c-7042-08df09ae31f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: haSsvMUxLtnVXKcwne8k9ZvPJxcw99kgtqiyveF1pbXKjYU3Mgp4C/N3e2vGr9ZqmM072/M8QbLVJUHof8vcha5qrsnpIK+8m79JqeyJpDQSxQBr0FWgTZdbdSGtVtB6kdyXTJASMrxLLP4JDBqfdIHdAmg/2qIk1hqBLgduTZhHlLwr9qeTOuY1YWHq2l0JAC5KcJOsDqDXg4WXY4CrcVUes4Sxkz6sNR9Y7L/z5/bMuYYZNV5+Pdg2it70CZU4X1056fj5+1VAOLGvWmnPkYH/RtnS2xmtajYj911tuIvE0GhcgKjuoII8GqIW3UAk14+pOnzFxBL7ljER7QsyhHsyk/u66T4jQ1q8trc/eMw4D4FfczcmM4qub8CoF7c9GzQ+fLGm45v5h5GsfeSHCRCmWqoOlkodJ/nV/6iDt6kthZ8NZRjNiWMD3TrdHolue6lXuV2P26+JgSkkftBqC7in9HKqTpbyEWVCDUrIOm1ANCqd2j8rqlbSiuZ+TBtOFBavZfMmTsaWKvaVb6IPOIq6/Sx3w9Sra4Zwq8YK2+5nWKQcL9tkapOMQkoKHopJ9aczvhUM4RqzR2VTJ1CCckYOVLDg7VyX8DF3N1dwYtbN8mwOjp/njlkEswIwbsSdKIYIZwRjw3MJ5/pLaH3UgHXntWAJK0hZ+MYFxBHhrtA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rtZx/FQlN/hnbsx5B3NIB9qV8FC2AARhB5lFkA8zFyDMF0QlOe/OhVjqQidm?=
 =?us-ascii?Q?aad7cFr2tU10/z1mpEgXWwbtdeSKQBhrzIoNLiZyTodWpWoz2s2B1RwGJ5Ev?=
 =?us-ascii?Q?IQdX3EUfnYLr5PgZjqedv2sqd3KP83axh6dayfY1lMslx4fnwyPD0kuoOBiA?=
 =?us-ascii?Q?GKS9g9RscoSJMoQKRDssGlNEX5e/U6iKmP0wmuyhIYV1Ncd6Agmj5xHntj+C?=
 =?us-ascii?Q?zyWPUi7Od4QXzJAd8Ph5WKBxTm9vS2jrYm/B9t57SizvxZ8hBpLDE917VIEq?=
 =?us-ascii?Q?DDVZFjYAQvet0XRgy2Uk/63sTySDo0tboi9xT+TUO/iq5Ujv3Jdk/xmQ8g1I?=
 =?us-ascii?Q?bdsadEm89177YJP8nSBAsycOOPa/WZjJ7dXhwGzUyJYQ0q8CtWSnGxUN0gf3?=
 =?us-ascii?Q?xC4Cds7yzxZ0P56T/11qf8FnSgT80l8WSIIW3asGjXM4JjbTyDnzkY7/bhOf?=
 =?us-ascii?Q?jsAZEtKuVJsglRS0rSJ+KYeUdDbNmdxvNsF36nh4i1qIvHhSsTKQnYL9sVQR?=
 =?us-ascii?Q?kJV/8p7icPDEkI3z2907BuVsDHP5rKWGIj/M+pyp7RdvZ2xvfHMSJvRGYPjh?=
 =?us-ascii?Q?3c4gVaFTiOt4LqCDP2rSssWzK6UXyAxNnYYM58GEPEQxyzZVTR20/iGnSghl?=
 =?us-ascii?Q?RkJpPuFJFBnSf8++aByHnYxAKRFeiQIW5zhYstDEcNHK36S8dEqJ4RAUYSRk?=
 =?us-ascii?Q?YDHONyqQlmQmLj+9gBXSVtU9/QwE0VNDPLOD0gUr0JmR+11fp2XL9SkqvwnD?=
 =?us-ascii?Q?J6UsBNiEMvTzQNjcF9ihR2k2YIAI2DmUDMkOQTHNT6rzAGT8LrRwEVAaRM9e?=
 =?us-ascii?Q?hEo6hd6sP0/fK3IS6Ux23aYQGxKNcBMLiLX2RuhChAWOgKJtco3+XI69Zxb6?=
 =?us-ascii?Q?ceAYgr7JJT3FW9Z+2WtmmlhtND6Ok5leheXu/IpEYZVOii4RGLs8znpyKu+A?=
 =?us-ascii?Q?KTzd+1fq0gP8U+fpgCILTTzPR5kn7aNXkbAOm6TTgeZ6e39jeATQyjzn5AJe?=
 =?us-ascii?Q?FsuV6uakteutj3jhsYH/Oltr/NPXZwzaYoINt5RmXL4YoZAjdYklm5mp3WQU?=
 =?us-ascii?Q?XzXbFM7K06YCnIWWYmvnZSi2ClH//VQnt/Hvcva3IG9HWwNDtK7wvQLW54Gs?=
 =?us-ascii?Q?c9dGDE3lmwUTm4o4dSAFts6Q8h7xIXj9mbR8KY8U1B2DgTIbdNZTtI9SMDe5?=
 =?us-ascii?Q?CRZHG2903tcITg3mVGReWRPz0qc6i46HpEjaT0SQ102QlC7OiY1bwsUmKW4t?=
 =?us-ascii?Q?vQ04Hef913ww3Yt/JCXEl7tOqNxf1n0/2hYQPh0MIxUsDCCD61B+/vHhwWCB?=
 =?us-ascii?Q?RAufWEf4AjndxycZFvABeZKnEYpldLghNiroEF5OMzoMBI+l7VY8408DeaGQ?=
 =?us-ascii?Q?Uj8rp7GQgG+Q/DO1r6XjI2dcGzEWCfqYwIKFgO9QhJHccr1wVIqwAbti6wm5?=
 =?us-ascii?Q?56Srm+7uaxjgavP1BaGr9jKZkcnyy3Say8cJ+9oZTKVYAqp7Kn5L9ZwUxkjP?=
 =?us-ascii?Q?KjHL05eTLtT0s8k5PXhkolI5G0jsbYTjrN4f1YDB6I2LqRgCkDmOFUugy//Q?=
 =?us-ascii?Q?VMCZoU22KpCOvmNw87wLx6C5f8xnsDVka/bRNwNvYi8iwGIPnSI3uN/sykia?=
 =?us-ascii?Q?yadsvR8o7+lGFEFtHc1cwvlN4HhITt4tO9Q6JB9/kMagHvLvrlNdRSdHdiFv?=
 =?us-ascii?Q?Rt2kt2iQbVMAuUhL0oTC21RlNDgEja3afumnnt8hV2966SXPnLrsAAkba5OO?=
 =?us-ascii?Q?UawepzWWbsQg4WiiHdqlgbLUFXf99Qk=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 934f52c8-253d-431c-7042-08df09ae31f1
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:26:27.8935 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kBg3dH1S5rATHEpOUNz09y8iW2rvUbZmlk0AVrWZFPtggEd6oFkqJ1iPZQObMW1K3kjWOJ8CxgOO0oTJ0qN/9ewD/XtH3CuMY/EPIdAAPZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR02MB8962
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

Introduce an abstract E2000 machine class and keep the Phytium Pi
board strap fixed to SD0. Pass the selected backend and boot-mode
property to the PBR device so firmware-visible boot-media state is
owned by PBR rather than a user-settable machine option.

The class-level selection also provides the board-specific hook
required by a later E2000Q COMe machine without allowing either
board to change its physical boot strap.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/phytium_e2000.c | 84 +++++++++++++++++++++++++++++++-----------
 1 file changed, 62 insertions(+), 22 deletions(-)

diff --git a/hw/arm/phytium_e2000.c b/hw/arm/phytium_e2000.c
index 1f2642df13..fe362dd4bd 100644
--- a/hw/arm/phytium_e2000.c
+++ b/hw/arm/phytium_e2000.c
@@ -44,8 +44,12 @@
 #include "target/arm/cpu-qom.h"
 #include "target/arm/gtimer.h"
 
+#define TYPE_PHYTIUM_E2000_MACHINE \
+    MACHINE_TYPE_NAME("phytium-e2000-base")
+OBJECT_DECLARE_TYPE(PhytiumE2000State, PhytiumE2000MachineClass,
+                    PHYTIUM_E2000_MACHINE)
+
 #define TYPE_PHYTIUM_PI MACHINE_TYPE_NAME("phytium-pi")
-OBJECT_DECLARE_SIMPLE_TYPE(PhytiumE2000State, PHYTIUM_PI)
 
 #define PHYTIUM_E2000_NUM_CPUS        4
 #define PHYTIUM_E2000_NUM_IRQS        256
@@ -100,7 +104,7 @@ enum {
 };
 
 struct PhytiumE2000State {
-    MachineState parent;
+    MachineState parent_obj;
     struct arm_boot_info bootinfo;
     DeviceState *gic;
     DeviceState *qspi;
@@ -113,6 +117,13 @@ struct PhytiumE2000State {
     MemoryRegion ram_high;
 };
 
+struct PhytiumE2000MachineClass {
+    MachineClass parent_class;
+
+    const char *machine_name;
+    const char *pbr_boot_mode;
+};
+
 /*
  * Keep the physical addresses used by the vendor firmware even before every
  * device behind them is modeled. In particular, boot SRAM carries PBR/PBF
@@ -436,11 +447,16 @@ static void phytium_e2000_create_pcie(PhytiumE2000State *s)
     }
 }
 
-static void phytium_e2000_reject_legacy_firmware(MachineState *ms)
+static void phytium_e2000_reject_legacy_firmware(
+    MachineState *ms, PhytiumE2000MachineClass *pemc)
 {
     if (ms->firmware || drive_get(IF_PFLASH, 0, 0)) {
-        error_report("phytium-pi: -bios and pflash firmware are not "
-                     "supported; use an if=sd,index=0 image");
+        error_report("%s: -bios and pflash firmware are not supported; "
+                     "use an if=%s,index=0 image",
+                     pemc->machine_name,
+                     !strcmp(pemc->pbr_boot_mode,
+                             PHYTIUM_E2000_PBR_BOOT_MODE_QSPI) ?
+                         "mtd" : "sd");
         exit(1);
     }
 }
@@ -509,13 +525,17 @@ static void phytium_e2000_create_qspi(PhytiumE2000State *s)
 static bool phytium_e2000_create_pbr(PhytiumE2000State *s)
 {
     MachineState *ms = MACHINE(s);
+    PhytiumE2000MachineClass *pemc =
+        PHYTIUM_E2000_MACHINE_GET_CLASS(s);
     DeviceState *dev = qdev_new(TYPE_PHYTIUM_E2000_PBR);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     BlockBackend *boot_blk = NULL;
     uint64_t cpu_mpidrs[PHYTIUM_E2000_NUM_CPUS];
     int i;
 
-    if (!ms->kernel_filename) {
+    if (!ms->kernel_filename &&
+        !strcmp(pemc->pbr_boot_mode,
+                PHYTIUM_E2000_PBR_BOOT_MODE_SD0)) {
         boot_blk = phytium_e2000_sd_blk(0);
     }
 
@@ -523,8 +543,7 @@ static bool phytium_e2000_create_pbr(PhytiumE2000State *s)
         cpu_mpidrs[i] = phytium_e2000_cpu_mp_affinity(i);
     }
 
-    qdev_prop_set_string(dev, "boot-mode",
-                         PHYTIUM_E2000_PBR_BOOT_MODE_SD0);
+    qdev_prop_set_string(dev, "boot-mode", pemc->pbr_boot_mode);
     phytium_e2000_pbr_configure(PHYTIUM_E2000_PBR(dev), boot_blk,
                                 phytium_e2000_memmap[
                                     PHYTIUM_E2000_RAM].base,
@@ -735,19 +754,21 @@ static void phytium_e2000_create_cpus(PhytiumE2000State *s,
     }
 }
 
-static void phytium_pi_init(MachineState *ms)
+static void phytium_e2000_init(MachineState *ms)
 {
-    PhytiumE2000State *s = PHYTIUM_PI(ms);
+    PhytiumE2000State *s = PHYTIUM_E2000_MACHINE(ms);
+    PhytiumE2000MachineClass *pemc =
+        PHYTIUM_E2000_MACHINE_GET_CLASS(ms);
     bool firmware_loaded;
     int i;
 
     if (kvm_enabled()) {
-        error_report("phytium-pi: KVM is not supported");
+        error_report("%s: KVM is not supported", pemc->machine_name);
         exit(1);
     }
 
     if (ms->smp.cpus > PHYTIUM_E2000_NUM_CPUS) {
-        error_report("phytium-pi supports at most %d CPUs",
+        error_report("%s supports at most %d CPUs", pemc->machine_name,
                      PHYTIUM_E2000_NUM_CPUS);
         exit(1);
     }
@@ -755,11 +776,11 @@ static void phytium_pi_init(MachineState *ms)
     if (ms->ram_size >
         phytium_e2000_memmap[PHYTIUM_E2000_RAM].size +
         phytium_e2000_memmap[PHYTIUM_E2000_RAM_HIGH].size) {
-        error_report("phytium-pi supports at most 8 GiB RAM");
+        error_report("%s supports at most 8 GiB RAM", pemc->machine_name);
         exit(1);
     }
 
-    phytium_e2000_reject_legacy_firmware(ms);
+    phytium_e2000_reject_legacy_firmware(ms, pemc);
 
     phytium_e2000_create_ram(s);
     phytium_e2000_create_unimplemented();
@@ -822,7 +843,7 @@ static const CPUArchIdList *phytium_e2000_possible_cpu_arch_ids(MachineState *ms
     return ms->possible_cpus;
 }
 
-static void phytium_pi_class_init(ObjectClass *oc, const void *data)
+static void phytium_e2000_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     static const char * const valid_cpu_types[] = {
@@ -831,8 +852,7 @@ static void phytium_pi_class_init(ObjectClass *oc, const void *data)
         NULL,
     };
 
-    mc->init = phytium_pi_init;
-    mc->desc = "Phytium Pi board (Phytium E2000Q)";
+    mc->init = phytium_e2000_init;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("phytium-ftc664");
     mc->valid_cpu_types = valid_cpu_types;
     mc->max_cpus = PHYTIUM_E2000_NUM_CPUS;
@@ -844,22 +864,42 @@ static void phytium_pi_class_init(ObjectClass *oc, const void *data)
     mc->default_ram_size = 2 * GiB;
     mc->default_ram_id = "phytium-e2000.ram";
     mc->minimum_page_bits = 12;
-    mc->block_default_type = IF_SD;
     mc->no_cdrom = 1;
     mc->possible_cpu_arch_ids = phytium_e2000_possible_cpu_arch_ids;
 }
 
+static void phytium_pi_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    PhytiumE2000MachineClass *pemc =
+        PHYTIUM_E2000_MACHINE_CLASS(oc);
+
+    mc->desc = "Phytium Pi board (Phytium E2000Q)";
+    mc->block_default_type = IF_SD;
+    pemc->machine_name = "phytium-pi";
+    pemc->pbr_boot_mode = PHYTIUM_E2000_PBR_BOOT_MODE_SD0;
+}
+
+static const TypeInfo phytium_e2000_base_info = {
+    .name = TYPE_PHYTIUM_E2000_MACHINE,
+    .parent = TYPE_MACHINE,
+    .abstract = true,
+    .class_init = phytium_e2000_class_init,
+    .class_size = sizeof(PhytiumE2000MachineClass),
+    .instance_size = sizeof(PhytiumE2000State),
+};
+
 static const TypeInfo phytium_pi_info = {
     .name = TYPE_PHYTIUM_PI,
-    .parent = TYPE_MACHINE,
+    .parent = TYPE_PHYTIUM_E2000_MACHINE,
     .class_init = phytium_pi_class_init,
-    .instance_size = sizeof(PhytiumE2000State),
     .interfaces = aarch64_machine_interfaces,
 };
 
-static void phytium_pi_machine_init(void)
+static void phytium_e2000_machine_init(void)
 {
+    type_register_static(&phytium_e2000_base_info);
     type_register_static(&phytium_pi_info);
 }
 
-type_init(phytium_pi_machine_init);
+type_init(phytium_e2000_machine_init);
-- 
2.53.0


