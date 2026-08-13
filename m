Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30257C5DF67
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 15:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuXhf-0008Jy-WE; Thu, 13 Aug 2026 11:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXhe-0008Jh-LJ; Thu, 13 Aug 2026 11:50:46 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXhd-0001rl-1j; Thu, 13 Aug 2026 11:50:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZhUmb0JTU8GK+HFPCFMp4xkNJGphb7QsImNjOCjpaIOcp7hvn+QggE3pyG2Y8MtOzgf1aP7GS7bbSHC5MDW5pNF58B1u0YyoAKMOpjTALxhy/MSo8cK0UMdzPObueG/DpRA0giRnOoQYPEj3/b0Rjg+lKDSaLYcUBOxeU0oBI+YVElUuLjOf1HuTKUYgxC14la3Az53UNwBPtpgEbA2e40nHg2FjJiD9Omgo7Hovap9rCIP6dhOH8gmi1lLXJ1vDbat4pkZBS7OVKkc37QdunDjyoihwm3uSPU7wcHNqtWLp3rSMRK4CpEL/+nk/8wW96SPKfGk2B33/0+3U9do0ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsM9Wh90YCp6eUyFBTCqh0vE6pmK/33x6JmUck9M5XM=;
 b=MdVzyn5xUSHGBP4VOkgGTpaRiV/NGYRVJCRJ/Eo14NslG/lxBjTfmnm7qKAWhPdf5BvltDBUZ3qWISzmlVY1+C+XCbAQ4LNGEqz+HG8PuFtAVtu7nzO3lPNjOchsvvl98K+Ez3N7g43PoyW++sRuHACRb+mKcxm3Ty1JNCh510SADYSiiNV4ruoOFKzzTbRpWYQkM8omdq6C6Rn4h3ffD6ETDhsWzCXHtBFt8jF0rHphm1ricvMsyfGw67ghi3w7Mcn7NY2vnwuTByMgVV7t2cM3rw2MdIevVBmsqIFQc5QkQehciXCVpoRp9IwA/lz/VoNkx/ERsbfTvdq0r7dspA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsM9Wh90YCp6eUyFBTCqh0vE6pmK/33x6JmUck9M5XM=;
 b=pHubNaYcfSo9NjEAvDZdq9erdNrsDx0IzwYfPrQq2aKD8DXHO341b8N+vE1KZFbITOlfARoVeDki42P7XFl2Y5u8TIVRZDEftq9IOWFOdaYa8uE6RXjL3/9BQ+ylMCe87Mf+43l7sO22q23NIBm/SPUkQiqferleLT8FAUqxAyjcfFg5Y9csjo9N0jIct/8v0uFlR3AFcsdvu8Y1Qrm/0eMBucnInJaHz/P65L53F5wec6ftNcEFEOVWmSLSu+6IJP6ejUeWENjlFMjpQEi35njWbvYHzGPbqdBV4wP3QAA1eFg6J+/l8rqN5Ha3D5fqOuV27PvhrrmEX0OpsrdPPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SI2PR02MB5490.apcprd02.prod.outlook.com (2603:1096:4:1a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 15:50:38 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 15:50:37 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH 10/20] hw/arm: kzm: Store boot info in the board state
Date: Thu, 13 Aug 2026 23:48:58 +0800
Message-ID: <20260813154918.996812-11-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813154918.996812-1-bin.meng@processmission.com>
References: <20260813154918.996812-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DU6P191CA0001.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::11) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|SI2PR02MB5490:EE_
X-MS-Office365-Filtering-Correlation-Id: 65cff6ad-ef45-45aa-45b5-08def9529eb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qgJSh/VhfRnSAg9jGYWcgLrDUUpPisa+ps/lM7buGHduCa4wq0c6HyVEhEq16hzmVCWUb/G9Pj2RAV56mUQrlnr+2Pn7wJokrcGdw9eDWiG2x/GSDOzqvjRErA84QtOXbnx0xmsLboVjerMj4tw9/GGRi1PreTgPzhWVd1ylFOBqxoEDo0w2bfJTTlZxIzQS3Ft2WcuAvpmYQaXkzXYNj3mIFty0DOobQGXfciZZk5lGg2xYolmwdsiZeunnu8lISRmzYHwuItd3gUa4w9/8AvuA4VdZ/85IBHNIIeIjEafs92U3erxHZyxLswF6Bo51oEwqJiCPylfyNTB3URKEuKIMVIbi8LJGSxkNf9tV4ox5ysli23U++bvTSArWLrCYjYtTOteBKfwsiReOgR6OHvdxlIOgy6iQVFuxaYsfUiAREcD/1hUjbfErBeyCEjt58yEsjwhNlSGI9LWFVK9M5GM+Y0JJMGvJHD0Bey2B9LCDe+RMFBMNVOL6ItQ4LI8rTHUf1fEX0gJIzK4aTVg+eI5aMA5lHJ9DFZznJc8UnjsoCzONkP31P4920vV4rCapw04964T7aYg1iN2OM4gXFoE67xJDYmBVfsUBipRxsIO12TxYvUpt6HTkEZojvPDjXAC2AGwCdMYW7msDa36Jm4tFQniJOKslJfwpvHWCjpc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?on1ZQipTeT9bw0vR4bb1baMWWpHRR3YyCTo0gX4TcVWasuy784Vv9h74AP06?=
 =?us-ascii?Q?YFdV/EYSRXV8mAtL7x3VHGpix5HMBcFwU6N9q48raVJsyXuIuKsXbBVfg32j?=
 =?us-ascii?Q?ttI4OW6HH0FmXENxU8eyuphPesxbBBkvptLgqJ0PAzTlucuaKK2V77AsjtkL?=
 =?us-ascii?Q?ANuM+1+O8PCpi2Emua7a52P6tTwgBPvvHzv+TE/49aDxzdI+jW+T5NsQu+si?=
 =?us-ascii?Q?0sQzcFUWFOlmNfCCW6yJJu/REDn9++N77xGhWEb54e/m4p+BPV0qyXS6n5b+?=
 =?us-ascii?Q?9Q9EC4VrgbcwYyKXtwHtmmZ/1Yft3cWa6ERkhXHMPctyyE1qUbQN19cg3Rm3?=
 =?us-ascii?Q?Q7F6hxHpwth5JhYLD5n5iObqANlmLY9txZ764hQIfzDf4UiIAW4JTEqrT8VU?=
 =?us-ascii?Q?OVJpNziDCVzTu7jxVKuyuD6QEatflDZiX/j+/WOBt52eVOdvycCS5kb5/jfk?=
 =?us-ascii?Q?KA6Elbr04TSRm/tXshOPKdjNmT493dkImFrcXPzqJpjlgYKzhpb4vKXACd4i?=
 =?us-ascii?Q?ADuL5O6DVUm333xXfm396qYAd3D8oTo2twPdhvrMnRSSAA/CsaNE37wJXGpN?=
 =?us-ascii?Q?zbQ6QIiX02wtDCES3VNSFujwRjcrmZXwyV559LuB572ERYoViKU341yBbeeM?=
 =?us-ascii?Q?J8QOM2gAT92JALAzzXrjTvphZfRPUtqcjNi28YdXhhgqQpSrDgXRApQQTK7n?=
 =?us-ascii?Q?Nw2urIWIEEl8xqRLZHrj97p0VHcyznYuoGtlLG/HqkfS6YHHTjMf0nFtM1DZ?=
 =?us-ascii?Q?jYqIDZ8DKQHm2qvFEiTwm15BAAD4kUh5OTrxashUI4HyhFeKRXDK+S2B1xmb?=
 =?us-ascii?Q?K7jV33uda657BgvIBE+67ncoRFRsi4URnquDg7IlHzAv90+VbpnEQVUXO1fm?=
 =?us-ascii?Q?ox11Obq/m5GONlRRw2bwsGyq2WIBZzdshO35X/X8J7pov9XQ6oyEvAtRr354?=
 =?us-ascii?Q?3XFPY4tKgtKPvGpjme/9p74OGW12wbuscCca8bA67+RUgciANkDYmTYiB8Cn?=
 =?us-ascii?Q?2Xnh58vZ9LS29ynjIbP8+Gt72CaNYUydcPP77LQsRYqQUDgvkC9owD5yGn96?=
 =?us-ascii?Q?rpTTJM3qhYKN7ocBtGOYT1qRd2BamQK4LYjVUhr2srfCGJkd3ZCX6xWr/AUx?=
 =?us-ascii?Q?+EMY0e01Wqyd/Ne+Px8DOzHecR98ZF8oblD1P2V7X69J6VnCLcVcKaF/Ze/e?=
 =?us-ascii?Q?spxwXdbXHjWSuJt52O53hFWMXLxHlZbHCq4DI0x0HNm6zBMOpBxutUe1zes6?=
 =?us-ascii?Q?JwFmFVby74D2jD43TR+ttdwkK5mLlT8rBi3mN/jhZA7z4xqDVBeXyler5LZC?=
 =?us-ascii?Q?W1LFO31Hz7rErCzxSJ/MvkN9rpym95klFH1ZiXddedg4UKS34kzUMvKLwtlW?=
 =?us-ascii?Q?NwBZUK7t/FlHaBc2pdJcKa0yvdBS2ryiZUFEzMRtN4LqYee5K4caCuodC9cA?=
 =?us-ascii?Q?Lle4fNeAK/Xd2dyrkeIWBpYRUKgezJEjhAZ09fLIt+U0p1yNgkgHwtamuQFR?=
 =?us-ascii?Q?79plEG5/HJH+UkNR++9I3lPRk8fmbYE3KUTMfhlvqk+m/m7UM13PeleNwwO4?=
 =?us-ascii?Q?+1HNAzxD55x6JyxvIDudULR55C8Fj5r+lKmouH5FY/OVMFvWhQIRnmrobkZN?=
 =?us-ascii?Q?ZJ/AzK4B1/NxKCjooirJmlIGJ5V1GJ3C7Z/eTN45VG+8yq7+aNoeZqUuq4MD?=
 =?us-ascii?Q?DGwCwJ4NO63ckNDabO233cmpoFINqcyD82gBNty6e4Rg6kf2FGX+6tWRBTnH?=
 =?us-ascii?Q?UE+oL7VSVfC3N4zLz5j3Le1tMG1bxek=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65cff6ad-ef45-45aa-45b5-08def9529eb4
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 15:50:37.9353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GYZVYA/Eb5IOlx+T/ZTcv8wP1Kz6W3LgzyhvVu8H5NDgPTXM38QEDtylMV/45nJxJF8Z8KAiMk+cDe5m4wN8eKa9DyvJ65OUq5b3Fi73q74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR02MB5490
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

arm_load_kernel() keeps a pointer to the boot info struct for the
lifetime of the VM, so the struct logically belongs to the machine
rather than to a file scoped static object.

The IMX31KZM struct is already allocated per machine instance, so
move the boot info there.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/kzm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index 168ecf35d0..55ab137519 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -54,17 +54,13 @@
 typedef struct IMX31KZM {
     FslIMX31State soc;
     MemoryRegion ram_alias;
+    struct arm_boot_info bootinfo;
 } IMX31KZM;
 
 #define KZM_RAM_ADDR            (FSL_IMX31_SDRAM0_ADDR)
 #define KZM_FPGA_ADDR           (FSL_IMX31_CS4_ADDR + 0x1040)
 #define KZM_LAN9118_ADDR        (FSL_IMX31_CS5_ADDR)
 
-static struct arm_boot_info kzm_binfo = {
-    .loader_start = KZM_RAM_ADDR,
-    .board_id = 1722,
-};
-
 static void kzm_init(MachineState *machine)
 {
     IMX31KZM *s = g_new0(IMX31KZM, 1);
@@ -125,10 +121,14 @@ static void kzm_init(MachineState *machine)
                        14745600, serial_hd(2), DEVICE_NATIVE_ENDIAN);
     }
 
-    kzm_binfo.ram_size = machine->ram_size;
+    s->bootinfo = (struct arm_boot_info) {
+        .loader_start = KZM_RAM_ADDR,
+        .board_id = 1722,
+        .ram_size = machine->ram_size,
+    };
 
     if (!qtest_enabled()) {
-        arm_load_kernel(&s->soc.cpu, machine, &kzm_binfo);
+        arm_load_kernel(&s->soc.cpu, machine, &s->bootinfo);
     }
 }
 
-- 
2.53.0


