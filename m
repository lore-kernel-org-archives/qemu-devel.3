Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42185E6C5EA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 02:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIIUM-00021C-73; Mon, 02 Dec 2024 21:18:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hongjian.fan@seagate.com>)
 id 1tIFEe-0001Lr-I6
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 17:49:44 -0500
Received: from esa.hc4959-67.iphmx.com ([139.138.35.140])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hongjian.fan@seagate.com>)
 id 1tIFEa-00013H-O7
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 17:49:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
 t=1733179780; x=1764715780;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=92ZViDS5K6CVrWTwExPbSW6thPxujHyMchapt0Se1Wo=;
 b=mhXB/TsT34z9jh7HCelbBsLiF2BfU5+Hek5vprSLoc7O72iZMVfpkMpD
 BKy7wTQiQQ0zJyonTwN9CKB8CWskV7sU9VDVZ73NqnThqBSYPC5fDD1LM
 jWtbtK7gL8ivTqHOZf6I84vBWF9HY9GGncwdOgouMZELGAuXOUFDinA5L k=;
X-CSE-ConnectionGUID: Gh4JIzezTVeFp65ZKLkIeg==
X-CSE-MsgGUID: Y51sAQBmQWSmm4R2bxB8gg==
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
 by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2024 14:49:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jAYpdNVKqZMRpu1SY8PEJuNSTyQCIlNDgIkYEazW+VZITJKG+918wB/ibE5X/FywoUZneV6QhEa7pAKAOBgYuLUBWk3gK5pSSD1byLBrRR3YUjoB4nIb4K9x77GK+gwoIqlc9m1I2U+Wh7ebbilnFmSc3j2SlPsHzZytrWd/uR9wP7i+XkNqB4/sJo3OkYcJmrmLqFf7SjyaalqDdZzVguyub/v83oKHhZ8WKXP36JL6eShShIuBwvCtHo6Twz8aouQqLsJAQ18twJ2Om0nrHEv9g6eyUsq9ICmX+t0x9banNwQzsC2kLkSDgsYIamgR9AZHOmNX8F90gPB5ZQHKoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0msWWMp6lNH/OVHvjwB1kEkRiWg3E4iezqN3tCtkZCA=;
 b=XU7TD1Rl/OeL5gm2w+I5UmDHhYxuhVhBoEgAsr3XCHkx6EMtHah9BLf4aY3eZHM+lc4+M6ws7tM8sZb/T9e/pKtZcNCOikNsqNCrRdnRvehWKI0nMIVqbKIMR3p7zKB2qULUcZFHCmNZNRG7+htNrde9Kkudth8/NL1xmTx5QadVT4LYMoHsCro1D3GqZJF4ZXii3fxjxLhtu3sFoPaie+yy4olubYSohWJfUCn194gsOZiyaexfaEwj5XXoX4khmZtf00iyJECUisswKwfsM2qO7/WTS+bwyguy3ApgEUcxehdx/lalbwGsKNyJIliQgR4ir1xRtKOYol1le+UCqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 134.204.222.53) smtp.rcpttodomain=nongnu.org smtp.mailfrom=seagate.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=seagate.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0msWWMp6lNH/OVHvjwB1kEkRiWg3E4iezqN3tCtkZCA=;
 b=YV6mQ5EMGBcMkTvhjIIfeHVrqLBnkMSv8ekAT5AmCQeneuFHT4hjtntPDpp8G8GcaOTKSA+gLSQhkS3wJNKtixSNvDacMfMKa6eIGYn8BAPQtvVsEmhRFtRODXGRuvmQC6TyA7aTDdqAfKNT7MuZeupMg+QRxyqDVuaW/iHNzlY=
Received: from SN7P222CA0024.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::20)
 by PH7PR20MB6085.namprd20.prod.outlook.com (2603:10b6:510:2be::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.8; Mon, 2 Dec
 2024 22:49:33 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:124:cafe::f3) by SN7P222CA0024.outlook.office365.com
 (2603:10b6:806:124::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Mon,
 2 Dec 2024 22:49:32 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 134.204.222.53) smtp.mailfrom=seagate.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from lcopzesaa002.seagate.com (134.204.222.53) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 22:49:31 +0000
X-CSE-ConnectionGUID: AIYHhiHkQUCrsekUAjX+Ng==
X-CSE-MsgGUID: 31dsjMnKTHmw+/tdrQsVHQ==
Received: from lcopiesaa002.seagate.com ([10.230.120.53])
 by lcopzesaa002.seagate.com with ESMTP; 02 Dec 2024 14:54:49 -0800
X-CSE-ConnectionGUID: DuqMBeEcSL+JlbCmCRv0AQ==
X-CSE-MsgGUID: klHG5o/WQrCvz1H1hIP7Hg==
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; d="scan'208";a="113320196"
STX-Internal-Mailhost: TRUE
Received: from mag-tester2.shk.minn.seagate.com ([10.52.21.5])
 by lcopiesaa002.seagate.com with ESMTP; 02 Dec 2024 14:48:52 -0800
From: Hongjian Fan <hongjian.fan@seagate.com>
To: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Cc: jonathan.cameron@huawei.com, fan.ni@samsung.com,
 Hongjian Fan <hongjian.fan@seagate.com>
Subject: [PATCH] hw/mem: support zero memory size CXL device
Date: Mon,  2 Dec 2024 17:03:11 -0600
Message-Id: <20241202230310.1531219-1-hongjian.fan@seagate.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|PH7PR20MB6085:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: af00faff-3a3c-41c9-9604-08dd13239634
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Cy/gNeRSWkT9O8TBa+w9pQkg7zi80ELqgHdC79Jh1/6/RIZ+5eL30dESNb3p?=
 =?us-ascii?Q?kYJDI8YqTqxpGg9jO0QTBhDLMOMZvXuh/hntDAYed3dpYYOiZCBgeyuKKFTm?=
 =?us-ascii?Q?nYR23pt9qmn6gXRHOPKNqEnhl6Tg4LeB627XOJXvKlCEDTvRqc8tQkQIuTPq?=
 =?us-ascii?Q?qRg/CM/Gds093CBEAas+vzwv/aNgLapeSXSLVcjQptUPQHfjKgYBwvP0Dgdy?=
 =?us-ascii?Q?oAJRyZOgAIrVcHwWRa+Ezv8oun5LZEW8IGE0Bz19xMdrNxUGou8wAvgk4SrU?=
 =?us-ascii?Q?QGNxvIS82d3xHGB91PeqTkOXm+e7+YlZxeSqPNGY2WRSZ/SU3LDmicL9FeaG?=
 =?us-ascii?Q?YqUKlvUeFGpKJXJZxQm9Ilp2NS+zlZLF8/xsJtStjVLw5rO7FZq2I7sVdF8v?=
 =?us-ascii?Q?XEdrAntNr4h5GiPVBIHHIZQeDx7N4JjeUMXHCiXX00hMV3XW7pkAqIsbEa0a?=
 =?us-ascii?Q?N/dPykdhFRt4DSiqDIgTOWFGLXwU+CGz+CXJqiYx5dDcMwVVXB+ZDuSuiXus?=
 =?us-ascii?Q?ZspNPL4nM78ekBELnbnUlETB+NcUInan0QJnT2uwn3R/OuXp6EXWJ2eZcnfL?=
 =?us-ascii?Q?q7Q28HI75dznEUjGZ/TLJComMDrUi6581dJyz0qMarLLeSOBij4DXkfY5COx?=
 =?us-ascii?Q?ZBRzCJxh7N/5bLr7f6tsi9tGfwNe51hlINV0bJJ81Mpx2ANm17yHZ1rvhj6/?=
 =?us-ascii?Q?uA1G+Qd7qsF/3j/PuWTCSwZhAemL9wnrVpJGjSM6tf1D+ZlYjBYKGMLc1SRt?=
 =?us-ascii?Q?FO+CgcDAekKHYGDmjzbmkMjIhi27cB/dt7aVoAT7hcgSQ4i7CdyoEpbDC3Nb?=
 =?us-ascii?Q?wN2S2m1F59EQM6pBPhdP7xlaJrOliUkkLHaSqD2XKEoI9PzlU1foakElpv/K?=
 =?us-ascii?Q?FywobFw+5NJdbehj9WSvreWhVmDpdFPGhMEMLMWBxVfWal1LNz8jcDAsZNlw?=
 =?us-ascii?Q?yEHLKWe6ABVbMeC9NXjUmFbZmBw4YExWvLIk/Jy+xv8fNHWhW7lbbFqL/gtf?=
 =?us-ascii?Q?yqHLOl2OiXZyOpmNoOcg/I0CCdC6fxJlX6cPbjkVskQM2cREJMxae8/nDq5J?=
 =?us-ascii?Q?osATCiOWCsrfj5ReEYcDQ6tqXLYIZO+Sj4QP2Hc3g5HfmGveNuN3BxQ1O4EQ?=
 =?us-ascii?Q?pHiild4DrC6l2JsL1NLoujg3f7eDpkmHhAYBoAGxyKFCNzh67IyZqVWkhx5y?=
 =?us-ascii?Q?65LzSrlLZJIQAVa884uur2c+Dm0sQdfqz2M9T34Th+nRXNdwIQfbCsTun0m2?=
 =?us-ascii?Q?QhOveXVc+UHbYyf5vFNnONwsLslOZgtV+1OMGqkYlGTyuqXybdHMCivEkfbw?=
 =?us-ascii?Q?FPULonwXtEefPnAj1pc2FrbIj1vQp83EPVz31xpSqiPPelxA57OKNGILAnUn?=
 =?us-ascii?Q?U+sMUkHlxdf6suK4C9QnTg9f/8VlaXoTDkEXBgbdjLhS2CvFOUDZ2CtZr5Ca?=
 =?us-ascii?Q?lpZTaLp/GHu/YfSCWZt6BSHuzJ8/djyX?=
X-Forefront-Antispam-Report: CIP:134.204.222.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:lcopzesaa002.seagate.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8y0jnoLWKGKW5vQMZf//ELIB0i7+d7BeShj8goYYaVVgRXZ1j2oO9VdUG/dDfiv5mRJh8O71rh/qCrv6+XJxoqYDJ5fyjUQRozpAzAlRPOFlA51JYCqjnRoC4Q7YD+ZzjFXLvQaPdRS9PpABo+qhOWnsGVuAzsBRZEr//JO7oKSwS9YWqMo1s7GKXRmU/PcCc7EQ+PpBJxQTFP+E7c5P968AQX6AoJYucVRDDN6yCBLTkXXi7LOGaZrFVN4wkOuXqmX0suiJ+FDKA0s4U1h4wQIqjRLKzb43xU5LyasgIXoHFyl3IjO/uvXDRTMpfPiqHki3JMNTIptGsZwAz0HlZaEyLWPSGcLaf4fLsTYerXc7jytw48zdT1b8Zm1Og6Z6QqEi2BCCP0gLLI7uevNix9VrANSS7UDmQIPeZNzyUsKDKvGMLqCCoNM8BpkJcGNO2wymbxD3LICvk5D+Npcdo8hMWpuCeb20BZVUmkuw6OQ5pmzsRjRNac/bce8uMAULwIdLGwxGeAD+ZNZL1Z11wctw2Gi4jqK9DgPCxraBn35/pBk9KR/HhjX/akkKP7KVfvtUjMwNYIWd3gFC71zSqrF4nup/QGfGEZPx8HL/WM2fCUP/4rm4IOPYhIAaRG7m
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 22:49:31.8477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af00faff-3a3c-41c9-9604-08dd13239634
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe; Ip=[134.204.222.53];
 Helo=[lcopzesaa002.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB6085
Received-SPF: pass client-ip=139.138.35.140;
 envelope-from=hongjian.fan@seagate.com; helo=esa.hc4959-67.iphmx.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 02 Dec 2024 21:18:07 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

According to CXL 3.1 specification, 8.1.3.8 DVSEC CXL Range Registers "A CXL.mem-capable device is permitted to report zero memory size."
This patch will allow a CXL type3 device to be initialized with zero memory size, when there is no memory device property provided ( neither volatile, persistent, nor dynamic region).

Signed-off-by: Hongjian Fan <hongjian.fan@seagate.com>
---
 hw/mem/cxl_type3.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 5cf754b38f..35caa186ca 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -159,7 +159,12 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
     int len = 0;
 
     if (!ct3d->hostpmem && !ct3d->hostvmem && !ct3d->dc.num_regions) {
-        return 0;
+        // zero memory size device. Build one entry with size 0
+        table = g_malloc0(CT3_CDAT_NUM_ENTRIES * sizeof(*table));
+        ct3_build_cdat_entries_for_mr(&(table[0]), dsmad_handle++,
+                                0, false, false, 0);
+        *cdat_table = g_steal_pointer(&table);
+        return CT3_CDAT_NUM_ENTRIES;
     }
 
     if (ct3d->hostvmem) {
@@ -712,8 +717,11 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
 
     if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem
         && !ct3d->dc.num_regions) {
-        error_setg(errp, "at least one memdev property must be set");
-        return false;
+        // no memdev property provided. Default to zero memory size device
+        ct3d->cxl_dstate.pmem_size = 0;
+        ct3d->cxl_dstate.vmem_size = 0;
+        ct3d->cxl_dstate.static_mem_size = 0;
+        return true;
     } else if (ct3d->hostmem && ct3d->hostpmem) {
         error_setg(errp, "[memdev] cannot be used with new "
                          "[persistent-memdev] property");
-- 
2.25.1


