Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9A2C79FAF
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tIC-0000Ig-FJ; Tue, 08 Sep 2026 06:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tI6-00008x-SK; Tue, 08 Sep 2026 06:43:02 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tI4-0006ZW-TZ; Tue, 08 Sep 2026 06:43:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JKFUnXMKU0PI+v4Y4pc2j84ZyyiAhLQWttXI5G+m29kSx+GgjH15OEZVWe/7Bzqp4c8Jp47bwfwtLeMcVIyVf77Vfc+62yqjee5wFYwP6EbwYKw79v0T16exBx24J9t4zBVjjko1ZEa9LiY/rt1mPecbErfnxP7lpXOx0YnoLgQK6XJfl1u4Wksc4hkcElKJkj2ZGQm2pzPLgswS3jKHxW5ERyQ41NE8+U+hElTHZSv/3HsOOP2QyoGg7QuOA+pe8r6G8v5cmXw5P9BFEPfK0NqcUd8TTlNjO4cLX7ghsnDT8hYkC15z4yg01d0/xP5eTTj7z0fMbFwuifUofHzk1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycfCcX8IcUj5flDoM8D2M/9AqBS3SYpytLEG6ChydW8=;
 b=w0+SE6tX4UIcoCaABU95TdbHEOebsyn0Lj8ETYDQ73/8OBh7ojaFLc4AredPjEKw9jk5S+9C8wrFVIfD/esNZ57A9MNlbOojEYM28QUpi56DOuj0qq2lUqMxir59pUGIOFIc5PsJGFgUPQZZ3qxSbwse0vYynq3UbIWzmws/iyC6quukmqYMi88YLgmP4Gwkzu4bdaxDcD1aGX37aHRP6nxIhQGPnKzA9as7cvh30z4ez1Q/ZLp9ls3quu4yh40fKTs/qYf6VBuiKUw3cd/tyTCDqPxd8LB9NngYeSvKszQLiBf91V9M6XLoiTmoOrAIsiuoyW9qz04bxmdReIxz+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycfCcX8IcUj5flDoM8D2M/9AqBS3SYpytLEG6ChydW8=;
 b=HFu8ehgF1iap+n140yROc4vrtmrT6k7of6VFCByt6E/Ax2Lz16WYFgifjnJhUrDGdD/DyNGQysYQ/ss83/XOUSSXjo7LJss6OBPXZGHAfXrANIvIS0Yo1ECzgxv5iew9bwQnuPXmLQStgxS400S4Y8jenNKbf322Vr5ZD+x1V9V7AYjl/t1+MEMZXUrNJ5iFzi1ZCTgtMRQGV1UVk/cuvR9cjokG496IbdLcu3UTW6vn4XzbpMb6jBRLp7SFxhox5NOU5n2RYPTSePRlvNM+1zm9JuZ9nEStQ/mr1K2E77b89Zt2+ixKuAIpyOrrkDkECn8d2je4T5x8QqAUGdI22A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com (2603:1096:301:78::7)
 by OSQPR02MB7928.apcprd02.prod.outlook.com (2603:1096:604:291::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 10:42:46 +0000
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616]) by PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 10:42:46 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH v2 18/32] hw/arm: phytium: Select the Phytium E2000 PBR boot
 medium
Date: Tue,  8 Sep 2026 18:41:27 +0800
Message-ID: <20260908104159.1621764-19-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: PSAPR02MB4984:EE_|OSQPR02MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: f7ce7c92-297a-4c7d-8cbd-08df0d95eb6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 8Aj/vSGIBk7onjOw0qVm6N8eun2sZ7vtSdzfrHWp6gYgIt1rygBLAHoV2lJt2HIKCB5eD6NPsxt7K0+vdBef6xyW+m0kpiZKO24ZURLinDFNnmj+n8Hvuaq67n4LZbXaN2N/TF5unKQm4kFx3vns8mVsaERzj8T7oLCICOakLGiQP6hxfhUrCsPubSjclduY/sjdrUca4xLyl4ua0ah9AC3Tw4yh1j/z5C08AD2q5RbjE3ZMYl3VJYijhWirWpS3Mm8nnkGKhHBrroQEd5Yn3QF3FcH5e4EJ4b0G5aPt/L281XW3nar3dTGRTvfOk90czd0Tv09eBbgq1ypZe27FuEsAl7xZHSsb7MyuIDHmfj7vyf5Bu55wv0akWHlLPH4Arx9wZMb02fNiuK1eZNuaKZ06zcZ1kEJxrWxYAqOn+mYXeKdP47/jfiNlrzclBNh9ULkyT5koZqHgXy5ANef9CwFqKP3aJ1/62grDItvITq/s7dXHboenha9v+grsWGub89wXVyFoAv5YaZq202lpkEkBZUevGS4vS+f7gi8eNuS4KYkfb06zikRMAzQWYwhap7KejvOSXFSxCsuuvs6fPGVY8G5lf9PMmwQAzs7oDU9RfI6dlbPC11Cwa42PeJWGADVtE8AcPBvOTiH+C2TmTKhzOH/sO4lN9Ttd068XGdM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PSAPR02MB4984.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sCb9nXwLGfyEswQOlpXrclOOOCLzfqiD+8x1ViRPcYe+oDukrphTCITHQtXC?=
 =?us-ascii?Q?IdwMSc0BWWO3lN7QRjQmLYIx0fHEIff3OrD2aHBU9MBfpiy/lYy57zak0s+p?=
 =?us-ascii?Q?Pqi+JuyA/C9UlHCzTYvSucD2XQfq8JdH1jRZuqrTkznbkugFiBmE8+Dry74Z?=
 =?us-ascii?Q?ossbvzCoYz90IiyDqKiX2voJpJfbkswTtxiF2EkjYdMhvvRwBunuLVOKdc6K?=
 =?us-ascii?Q?qXa3fa4juB5bL1fkWu8evsx53UYWc81/zMqH8odOKA33FXbLAX7EbxAcnO0/?=
 =?us-ascii?Q?krfTm8GRjzLNxxipulwh1VMAQ0sypqKqmCZTIYRI5uqionN7zgJMWTynugcs?=
 =?us-ascii?Q?QbfAftvnaAzRacixK9pTDDzGupgXcPjqdlQhuu4IIgEY1WEokmLgwyy1w+e1?=
 =?us-ascii?Q?9r9vUbchDHbcrbCxyl+XBD/cdIAbxKOYaKANDK4lbGdjB6s6V/Cl9NPdy47u?=
 =?us-ascii?Q?IkN2/wd9ABTzo/0wXB6WP2eIcoslFkAZ/s2lZEV05EVyYw9ncBPRyaYHI3Jc?=
 =?us-ascii?Q?mzN+xy0vFBIa5cEY9+mYI53s4UvLBiXOrWIZYECIYb3o3tpG6Dg/juv4VADW?=
 =?us-ascii?Q?uvpeYwVg9tPVNRq2wg6yEIPhIQ31Z+LApauB/iqGyTc+pU0zlKzbH7DLWVx2?=
 =?us-ascii?Q?TYGZMIN2EpdFaKs07J2REQstubJTfFOQ7C3a6FfAr7LV9DZlplzs930bcMzZ?=
 =?us-ascii?Q?xVcBazdWYk1aFa+0wGya7cqu/mqiEYS02vM+XPrna09Knkuoyf908l7wJQAR?=
 =?us-ascii?Q?nGy/Fow/qMsHZkCd9Y30Dy++YRIcSBlLeCe4ggKqA6Mbph9D9aMuc5Qokr8g?=
 =?us-ascii?Q?aNNl7blye6fhWx9Y3YpmE9lNytTvyCFrDsFcOimIB3/3Of6gDW3MMUswPcEE?=
 =?us-ascii?Q?U/CTyXh+cKVxAykBZqpVC1hM0HoxfoLAujiXwltlBHL1nZhIGFylfT2lZPnl?=
 =?us-ascii?Q?8GTbxcLpymacFHcApoJhode2Hc1/SWk2rXDG09Eh0yQH5RvglDHoa1AwzOSu?=
 =?us-ascii?Q?aLV28/PppLbN/ShuTTp4Vpfw++ZX1f1XQhae1J3VTpeArDM9rrmh07tF3gpN?=
 =?us-ascii?Q?s9TQIREsSyZXI0MMJwBPWwBoZ7kvOGSQpWzCcvCFhs+MZEB0dLIsX2wAeDJy?=
 =?us-ascii?Q?aOlcb50QGYLC4DacR7t8hC9yOTcfuTXDiN7D2Qi4fJ/AAMjT4YObRit6swk8?=
 =?us-ascii?Q?bFdcTW9oYnKlVklDxVtTc5Er+IYShGJskYyL5GLC8CxZC3SHG8zlkfNYmmlX?=
 =?us-ascii?Q?4ah97DzaOs3xavYiSdab1/ZoF7ZidzCJQGrApLnKKDz7MINJZ+IE7NcSBf+E?=
 =?us-ascii?Q?thLbn8+TfTolxXoLvQXuZFssNTULvNEKYsh3DXyCKu9R/Be1gNUv3cRj2ORO?=
 =?us-ascii?Q?VJDBTdt7W+XRTEkqbDAeliFYHtndGMNrfs9ShAUVcHx0y2/8ZSnUXh1tiPai?=
 =?us-ascii?Q?Q/V6k9rWE28WwWgjmnXo0BG5lbLXqMQHfWM6J9Z5YR4QsI05/vNZmCGYffTB?=
 =?us-ascii?Q?p78bzlnVEuj3ijp4a2heyQA5F4n+6sM6argAnMiH/RddFxGoMu9zIo3y08iZ?=
 =?us-ascii?Q?9ElDnigtoTtnYQ1BfGiyb6qyJiNfyLvHXK+owBeGe5Pbxm59P/W1qxzETDh4?=
 =?us-ascii?Q?j+Hr7O/7P89xPeuwaZ9XyoR4YkDRInEizIWUcrylcH/FXGrruIaHTIzHBxC5?=
 =?us-ascii?Q?hEUzEiWSq90gL8yJ9ADqFMjVN1TUI8Z04c+5//BNiZGMzmWZlWuWDMbCmP5/?=
 =?us-ascii?Q?Eo5hQ94txcpMPiDSk//BlPBglVvUxeo=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ce7c92-297a-4c7d-8cbd-08df0d95eb6d
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4984.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 10:42:46.1935 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGsQgY9cFb7Fg8Oylp4OclmZ17/L8/5PBfiodDjCkn4cLFTgwFkGxw0R19ownlPm2nc3Z2JJxuDQhpUGYwpoO0OMPYp6NlcKhCjdl0FltJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR02MB7928
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

Introduce an abstract E2000 machine class and keep the Phytium Pi
board strap fixed to SD0. Pass the selected backend and boot-mode
property to the PBR device so firmware-visible boot-media state is
owned by PBR rather than a user-settable machine option.

The class-level selection also provides the board-specific hook
required by a later E2000Q COMe machine without allowing either
board to change its physical boot strap.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v2:
- Keep board boot straps and media policy in the machine layer

 hw/arm/phytium_e2000_machine.c | 89 +++++++++++++++++++++++++---------
 1 file changed, 65 insertions(+), 24 deletions(-)

diff --git a/hw/arm/phytium_e2000_machine.c b/hw/arm/phytium_e2000_machine.c
index 3ab82c5fff..0337795f2d 100644
--- a/hw/arm/phytium_e2000_machine.c
+++ b/hw/arm/phytium_e2000_machine.c
@@ -24,10 +24,14 @@
 #include "qom/object.h"
 #include "target/arm/cpu-qom.h"
 
+#define TYPE_PHYTIUM_E2000_MACHINE \
+    MACHINE_TYPE_NAME("phytium-e2000-base")
+OBJECT_DECLARE_TYPE(PhytiumE2000MachineState, PhytiumE2000MachineClass,
+                    PHYTIUM_E2000_MACHINE)
+
 #define TYPE_PHYTIUM_PI MACHINE_TYPE_NAME("phytium-pi")
-OBJECT_DECLARE_SIMPLE_TYPE(PhytiumPiMachineState, PHYTIUM_PI)
 
-struct PhytiumPiMachineState {
+struct PhytiumE2000MachineState {
     MachineState parent_obj;
 
     struct arm_boot_info bootinfo;
@@ -36,6 +40,13 @@ struct PhytiumPiMachineState {
     MemoryRegion ram_high;
 };
 
+struct PhytiumE2000MachineClass {
+    MachineClass parent_class;
+
+    const char *machine_name;
+    const char *pbr_boot_mode;
+};
+
 static BlockBackend *phytium_e2000_sd_blk(int index)
 {
     DriveInfo *dinfo = drive_get(IF_SD, 0, index);
@@ -43,7 +54,7 @@ static BlockBackend *phytium_e2000_sd_blk(int index)
     return dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
 }
 
-static void phytium_e2000_attach_sd_cards(PhytiumPiMachineState *s)
+static void phytium_e2000_attach_sd_cards(PhytiumE2000MachineState *s)
 {
     int i;
 
@@ -53,16 +64,21 @@ static void phytium_e2000_attach_sd_cards(PhytiumPiMachineState *s)
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
 
-static void phytium_e2000_create_ram(PhytiumPiMachineState *s)
+static void phytium_e2000_create_ram(PhytiumE2000MachineState *s)
 {
     MachineState *ms = MACHINE(s);
     uint64_t low_size =
@@ -89,9 +105,11 @@ static void phytium_e2000_create_ram(PhytiumPiMachineState *s)
         phytium_e2000_memmap[PHYTIUM_E2000_RAM_HIGH].base, &s->ram_high);
 }
 
-static void phytium_pi_init(MachineState *ms)
+static void phytium_e2000_init(MachineState *ms)
 {
-    PhytiumPiMachineState *s = PHYTIUM_PI(ms);
+    PhytiumE2000MachineState *s = PHYTIUM_E2000_MACHINE(ms);
+    PhytiumE2000MachineClass *pemc =
+        PHYTIUM_E2000_MACHINE_GET_CLASS(ms);
     BlockBackend *boot_blk;
     bool firmware_loaded;
 
@@ -101,12 +119,12 @@ static void phytium_pi_init(MachineState *ms)
      * Phytium-specific system registers that KVM cannot provide.
      */
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
@@ -114,18 +132,22 @@ static void phytium_pi_init(MachineState *ms)
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
-    boot_blk = ms->kernel_filename ? NULL : phytium_e2000_sd_blk(0);
+    if (!ms->kernel_filename &&
+        !strcmp(pemc->pbr_boot_mode, PHYTIUM_E2000_PBR_BOOT_MODE_SD0)) {
+        boot_blk = phytium_e2000_sd_blk(0);
+    } else {
+        boot_blk = NULL;
+    }
 
     object_initialize_child(OBJECT(s), "soc", &s->soc,
                             TYPE_PHYTIUM_E2000_SOC);
-    phytium_e2000_soc_configure(&s->soc,
-                                PHYTIUM_E2000_PBR_BOOT_MODE_SD0,
+    phytium_e2000_soc_configure(&s->soc, pemc->pbr_boot_mode,
                                 boot_blk, ms->ram_size, ms->smp.cpus);
     sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
     phytium_e2000_attach_sd_cards(s);
@@ -169,7 +191,7 @@ static const CPUArchIdList *phytium_e2000_possible_cpu_arch_ids(
     return ms->possible_cpus;
 }
 
-static void phytium_pi_class_init(ObjectClass *oc, const void *data)
+static void phytium_e2000_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     static const char * const valid_cpu_types[] = {
@@ -177,8 +199,7 @@ static void phytium_pi_class_init(ObjectClass *oc, const void *data)
         NULL,
     };
 
-    mc->init = phytium_pi_init;
-    mc->desc = "Phytium Pi board (Phytium E2000Q)";
+    mc->init = phytium_e2000_init;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a72");
     mc->valid_cpu_types = valid_cpu_types;
     mc->max_cpus = PHYTIUM_E2000_NUM_CPUS;
@@ -190,21 +211,41 @@ static void phytium_pi_class_init(ObjectClass *oc, const void *data)
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
+    .instance_size = sizeof(PhytiumE2000MachineState),
+};
+
 static const TypeInfo phytium_pi_info = {
     .name = TYPE_PHYTIUM_PI,
-    .parent = TYPE_MACHINE,
+    .parent = TYPE_PHYTIUM_E2000_MACHINE,
     .class_init = phytium_pi_class_init,
-    .instance_size = sizeof(PhytiumPiMachineState),
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


