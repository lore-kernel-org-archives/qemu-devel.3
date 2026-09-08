Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A97C79FA1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:46:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tI6-00007X-Fs; Tue, 08 Sep 2026 06:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tI4-0008Tj-O8; Tue, 08 Sep 2026 06:43:00 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tI2-0006bO-V1; Tue, 08 Sep 2026 06:43:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5iz92lGY69Zj5qo54SEdTadgJwVSBprZcNFixLTbUDeiAUV9RZs2fZhYOeFPm7ewSntqgl29sJclvnIPuSUNg40c0J1nVd3uY6QBB8G91CEe+WsXPF4NUGad0k+mKphulkBzxW5gwPVcM7TS2roC0yqznp0iuKp72ylIYQq375GdnTgpjIKN8HlrmTNyplsz/rdbFph2vkxmPCdYsluXC8KBJgeu218emXMR8ipb3gcB4YmOj+vD8P8Bnc6IVqQzVkj7dqLM8MTu4CbIBLnVh3KokjJYM9QS2hjaE5D+Ar88+eGBN0douI/GkMU7L6u4EHobpJtrkFigtW2VC6oNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZzXwsG3xfbwnvYjjtNnFnN9bY8f8Js7zRi92rLSHOI=;
 b=ae6V7bB+zCCk8hRwNlITKdp2fJsWqT55fKGnG3TijzbPzoMtb3kFk7EzMlKztb6oVmP5zXDDRJ2y7BwulMpwzyxRUzgKuQ8lGpzHklvaxxHfDMQIlbKXosxEtWEU+SOAVy6li8/y527PM3ZA9kNnWmsrT5MpioMV6MZWwbEolVRdkG/OTNCHMR4h4D47pE22AzxljWtx12mSDnzXE6xVGfVu1uUDk6gmEPmHLdI6T1SJdeG3MBfb5b2x28uWehDYxvhG0ug7a0aPWNpP7EXQi2e6WZlLWOAuYlSa4CRr4FcQMuOgn7XW/OOmlqqAmkjVC1Q3fc8Y6b5Qm6brzwKf5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZzXwsG3xfbwnvYjjtNnFnN9bY8f8Js7zRi92rLSHOI=;
 b=o31pnmSVCWdPlOEX/+GdPqIbUbYhm3BikAqVtW8DAsq6Cj/4ElchUBR5pRx+3/10Wq4sUxN6udJkO2uOb630sGcztcTJBU/WU0/gfmloEgQzlYhaD8onQGKUsEfMZilReyqgzd0qqkR2BTQ3Ghps3P7Hp1VK0zlVcGbbiHtCe2FYusePU+py44CQp56khPBA9zr+MlTqyn7rp83mKemt7sxQLo+3KAUkZTbYC28fW0DNJgLvtOaYcNACEvtgcaeLrhXr6RS2Nsgj+4JphqIDLEu9OnSFcNyCzFtnzFXyVo7SljvMSA/tyeKOpAvkD+XVftdnOuqBHdDPDzr1+UJVnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com (2603:1096:301:78::7)
 by SEYPR02MB6579.apcprd02.prod.outlook.com (2603:1096:101:139::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 10:42:54 +0000
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616]) by PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 10:42:54 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH v2 23/32] hw/arm: phytium: Support Phytium E2000 direct Linux
 boot
Date: Tue,  8 Sep 2026 18:41:32 +0800
Message-ID: <20260908104159.1621764-24-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9e26f749-2c13-4917-4dd7-08df0d95efb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Znt/i1hB3tLC//SmnXYyzEvgdT9OsbZU7RPnyIm4pqafvQPJDK7gUcQidcV5aLFaxmRXxgPtSFWjuJOjTHbU7t938HXCfNi6TJzuGuT+fUL1XX9nRziQUnDFQGHHvHoKBSgPUwqniu7nsgxqM2iskQbCsXnO3JNjF+5vxuykCRqS9ZlXpzxhzkWY4hJHmVNPatVb1uPaeIKjHW05bIno7wt66+QwlL0PU5E69r6508JgoNVvOMC+idIFe6m6FsEVmAbv5eVElq5A4DPK9tiCNgo9iuasmCwKV8blYy7j8wzU6elgAJVw1vmri5rqY/KcPL3Q72j0ZD5WIZSGOI1lo/bNc4zRvVliv4MUUx4d67IKwOWJVdOidzQn3BMhXtWRyj57FD9bmVsFAIhf7v9VaMrawNQr1MALVz6JskLtvfTxzu+ISFt2HP72UIj3IsDwoa0iM7012ogKcyX9x2+HK5N+8fwmdRXY7dQupyLFCPpbs1ZGf4NUsW0WtNZK15G8uS7TlJgw9P+0MTRZe790LtgBczY5UZIIVAErCefkHI0UCXcqXwZidKAsrl3p3AC2Avzq+vql1OB8jcWZdt1JW6bw3WQ/Wo5g7/+UuoWyIolCxky7CwIsIf5x9DsQZGQW3OKs9ySwmKVe1SLKfpA6CJjzeu7cbiDgQ/ASxs9j3b0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PSAPR02MB4984.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cmJG0t1KaPd/13CLbTPADtu2O+qXXyenogVs1rY70/edXx61+zlSv412/FRe?=
 =?us-ascii?Q?1zmSBrkLXyWwUX9X+RoLet6GsgMjZd03A6CmXCPZuQwUlWUdybvzERdIsoUZ?=
 =?us-ascii?Q?N74RCCnekQgm3MLKaGK/Rjqkn0FuqBchT1+r0Dj0jh+GqYtqPtPx6RYMf7b5?=
 =?us-ascii?Q?g+iUHsUFYz2s1Ew/FdO5ZgGnh3GQi14wGWB4LzNEaLiQa4zwOEQINAnMwQZu?=
 =?us-ascii?Q?L5c8fGQl0RCPc83OdecyIOHk70jBamzRU28fV77PuHcLjQW/MHHv8KTRkocU?=
 =?us-ascii?Q?FamixYPxdS3kisKLidpr7y7pmW6/24bYH+zULkzDZpP2tTTa/4bAJ9bSCWd9?=
 =?us-ascii?Q?EnGoQ4BeWV99pvbHR2pBzZTUWz5YQp/itHGqAOQjBd/OxfIbmLfYfFMjo+JJ?=
 =?us-ascii?Q?66l9qWG8Pff7KP9wSrGmyvPHTagmiWUZHSB1A6Dw0ca9dLg4crqqIYnWfcCU?=
 =?us-ascii?Q?JodCRDuU26nIOgqNfU1x0FE4TTZZInHNxwgYMmoahPtUBcVb4zacjaMUw563?=
 =?us-ascii?Q?PgXGD/2CltXnp2vtn6+nHaB7GM2klJct2dA0kZ7rU+izdlc3UTTlzaWUgYAA?=
 =?us-ascii?Q?zchbDHdyng5rvojaYfL9ZeN2IOmQ6B3yI0DRHb78FyfPwKLEjkA+to32glOJ?=
 =?us-ascii?Q?y9vcZisilbsLPf/kbltDwR59fxfMCFyQapIAqHYxgf0FsvuaKYbIKaYvWWuD?=
 =?us-ascii?Q?PoQG6hwxBuectFJBuJwUSy48fhTIKLODXbUcEgTW0UbSqMyI4b/fnQ8UH6yk?=
 =?us-ascii?Q?DVTP1HRg8dki3YrR0WgGWSUuvnfwYMrftoqexNi9XUan1xrzWv85qGKKiS8J?=
 =?us-ascii?Q?U2FrkBoUV67on72iHHpgrK4MTz3MVaRGOeWkGPVOv4fELWd53VIol6qxXk/U?=
 =?us-ascii?Q?r+XfOKqY0/0sOkFHWT4rtGjWqlFuFK0QelzJsW7yCME07el7X6bIPVdeF9UM?=
 =?us-ascii?Q?uI+q4Y6JNqWDbTiqSXv6RCXelTpKHusqcaLRBK12AkcUIrvLUM1dVLm2lMhL?=
 =?us-ascii?Q?iS8Sx+aX4H+vup43Fw06qMWo1TrwvxMqxN7MOa0FQNFayc9a6rsohP1sd6J1?=
 =?us-ascii?Q?ysKBolMnhHA2PZ68dn4RtzpoTxTx0uEhcpUftOiht7D9/8XdpS86Zl9PPHx5?=
 =?us-ascii?Q?lK89fj4TFiKJqYXCPLp+IobHoMwbTSjsGNJ4Ueg7hmtXesmdlfkFIAoKT6SX?=
 =?us-ascii?Q?0uaVZQf3ByPscclDcadpv/B77xLLr1ZmRfH+MBHjH/jR2zqAWA8C4ADknVH/?=
 =?us-ascii?Q?KXcUXGGUVAwWpB/zMs8hNjplk2R3lAOUYnvCbNxR/TxDJIZDS8+MoGZFB5dw?=
 =?us-ascii?Q?jh6orTaO70zmR+/U4pMagFjBBmBa7jnHuK3Os0JDRYS8q+AMaR64QKayXDDZ?=
 =?us-ascii?Q?2a1INYIDOMA5zx+XlLau/2TImrD34jFUY/9rvDGw7Q0G0UWOFuz3Mvb4Mzgg?=
 =?us-ascii?Q?PG5VV1N6djAW3tYoHLu9niso+8SPXCbuRb7XuERBv2XyhNfJ5on1RdoOz7Jm?=
 =?us-ascii?Q?/TFhVqdz4YvxvRSXaEDqk74BfWsv63qG7Q0L5/UvwC/Ljw3ydsfZ29HDFBej?=
 =?us-ascii?Q?xEsmtd2j3XsJff+729dL2lU8k0ix6oHUzI83KiOGumDgL89lDm1PJqx7cBNN?=
 =?us-ascii?Q?mo7WuIdUn/N+0feJ5KxrfxgPgSboWkCMhbBtx3iJBgyJ6WDL07bxSR4bTHie?=
 =?us-ascii?Q?ENdcMojH5Gn7Fg4nUpDht7YEK220acQT1zB3qkNt2KZ5R12dBlfGHhJd/sWZ?=
 =?us-ascii?Q?ga1koyUHqYUQ09AiIohai7EFCcywyXc=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e26f749-2c13-4917-4dd7-08df0d95efb2
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4984.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 10:42:53.3426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0z9RCWJe+/+/7Zvt7Qkg60y/4/tRnf29Ozkwdvw2DHW+RfMaL98h66HSZGt52UYiQzbDCjOTpk6B2e61ooJGgIvT3xaib0I3gfJrkVXPTkE=
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

Allow the Phytium Pi machine to boot a Linux Image directly through
the generic Arm loader. Require the matching SDK phytiumpi_firefly.dtb
whenever -kernel is used.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v2:
- Pass the SoC-owned primary ARMCPU to the boot loader

 hw/arm/phytium_e2000_machine.c | 65 ++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/hw/arm/phytium_e2000_machine.c b/hw/arm/phytium_e2000_machine.c
index 0337795f2d..41bce8a64b 100644
--- a/hw/arm/phytium_e2000_machine.c
+++ b/hw/arm/phytium_e2000_machine.c
@@ -15,6 +15,7 @@
 #include "qapi/error.h"
 #include "system/address-spaces.h"
 #include "system/block-backend-global-state.h"
+#include "system/device_tree.h"
 #include "system/kvm.h"
 #include "exec/hwaddr.h"
 #include "hw/arm/boot.h"
@@ -44,6 +45,7 @@ struct PhytiumE2000MachineClass {
     MachineClass parent_class;
 
     const char *machine_name;
+    const char *direct_boot_dtb;
     const char *pbr_boot_mode;
 };
 
@@ -105,6 +107,61 @@ static void phytium_e2000_create_ram(PhytiumE2000MachineState *s)
         phytium_e2000_memmap[PHYTIUM_E2000_RAM_HIGH].base, &s->ram_high);
 }
 
+static void phytium_e2000_add_memory_node(void *fdt, hwaddr base,
+                                          uint64_t size)
+{
+    uint32_t acells;
+    uint32_t scells;
+    g_autofree char *name = g_strdup_printf("/memory@%" HWADDR_PRIx, base);
+
+    acells = qemu_fdt_getprop_cell(fdt, "/", "#address-cells",
+                                   NULL, &error_fatal);
+    scells = qemu_fdt_getprop_cell(fdt, "/", "#size-cells",
+                                   NULL, &error_fatal);
+
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "device_type", "memory");
+    qemu_fdt_setprop_sized_cells(fdt, name, "reg",
+                                 acells, base, scells, size);
+}
+
+static void phytium_e2000_modify_dtb(const struct arm_boot_info *info,
+                                     void *fdt)
+{
+    uint64_t low_size =
+        MIN(info->ram_size, phytium_e2000_memmap[PHYTIUM_E2000_RAM].size);
+    uint64_t high_size = info->ram_size - low_size;
+    g_auto(GStrv) memory_nodes = NULL;
+    Error *err = NULL;
+    int i;
+
+    if (!high_size) {
+        return;
+    }
+
+    /*
+     * arm_load_dtb() normally describes RAM as one range beginning at
+     * loader_start. E2000 RAM above 2 GiB is instead mapped at 0x2000000000,
+     * beyond the PCIe aperture. Replace the generic range so Linux never
+     * treats the intervening address-space hole as RAM.
+     */
+    memory_nodes = qemu_fdt_node_unit_path(fdt, "memory", &err);
+    if (err) {
+        error_report_err(err);
+        exit(1);
+    }
+    for (i = 0; memory_nodes[i]; i++) {
+        if (g_str_has_prefix(memory_nodes[i], "/memory")) {
+            qemu_fdt_nop_node(fdt, memory_nodes[i]);
+        }
+    }
+
+    phytium_e2000_add_memory_node(
+        fdt, phytium_e2000_memmap[PHYTIUM_E2000_RAM].base, low_size);
+    phytium_e2000_add_memory_node(
+        fdt, phytium_e2000_memmap[PHYTIUM_E2000_RAM_HIGH].base, high_size);
+}
+
 static void phytium_e2000_init(MachineState *ms)
 {
     PhytiumE2000MachineState *s = PHYTIUM_E2000_MACHINE(ms);
@@ -123,6 +180,12 @@ static void phytium_e2000_init(MachineState *ms)
         exit(1);
     }
 
+    if (ms->kernel_filename && !ms->dtb) {
+        error_report("%s: direct Linux boot requires the SDK %s via -dtb",
+                     pemc->machine_name, pemc->direct_boot_dtb);
+        exit(1);
+    }
+
     if (ms->smp.cpus > PHYTIUM_E2000_NUM_CPUS) {
         error_report("%s supports at most %d CPUs", pemc->machine_name,
                      PHYTIUM_E2000_NUM_CPUS);
@@ -159,6 +222,7 @@ static void phytium_e2000_init(MachineState *ms)
         phytium_e2000_memmap[PHYTIUM_E2000_RAM].base;
     s->bootinfo.psci_conduit = QEMU_PSCI_CONDUIT_SMC;
     s->bootinfo.firmware_loaded = firmware_loaded;
+    s->bootinfo.modify_dtb = phytium_e2000_modify_dtb;
     arm_load_kernel(phytium_e2000_soc_cpu(&s->soc, 0), ms, &s->bootinfo);
 }
 
@@ -224,6 +288,7 @@ static void phytium_pi_class_init(ObjectClass *oc, const void *data)
     mc->desc = "Phytium Pi board (Phytium E2000Q)";
     mc->block_default_type = IF_SD;
     pemc->machine_name = "phytium-pi";
+    pemc->direct_boot_dtb = "phytiumpi_firefly.dtb";
     pemc->pbr_boot_mode = PHYTIUM_E2000_PBR_BOOT_MODE_SD0;
 }
 
-- 
2.53.0


