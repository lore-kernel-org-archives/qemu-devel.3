Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF833C47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 08:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUMns-0003CN-15; Mon, 29 Jan 2024 03:15:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1rUMnk-0003BM-JG; Mon, 29 Jan 2024 03:15:34 -0500
Received: from mail-bjschn02on2061e.outbound.protection.partner.outlook.cn
 ([2406:e500:4440:2::61e]
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1rUMnf-0007by-Uf; Mon, 29 Jan 2024 03:15:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqepDEcID2oV3/RGRRKW99FRmaxo3Td+Lqalwsa6P+wgL2RLyCV/xBGJGR6iXbczujt2wLoxO/6mr2GItm3wDz9hgGkaIxieamC1oXaKwIs1qn1FKRWu7VuJUbWWGjWBuirMPxNzJWz1hjJZoQUcn7kFJtR4rnvg2tmU+51RUUyviZrFOYw6U2eGzWJF3rZSDy+/REYVi/3YMj/x2bQhu/7piwI95bHQWSkiYKdE4/iaQCVkpfZAjdhuXMuXHna9dqMjHFEaghK5xutp401YvMSCuG3jlJxJPZjFrOv0q7AfuxwsnkgU/Q71woB9SfmPCqGq5QaO2wNIpQT3YZcbMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oR6oZhoEfVAJa/pd6hmVtB00Ch1tHWdIwMXgWaVHi4Y=;
 b=I00TGfGGubOIzaiJKhRLJEczm5DiAzwR+FzzAOyTeLfJvllLCUxodj0hijwvCQ1G2sVuP4agV+547q8oB7jGajUX+x6wTlo3Te1r8dhSl+SPiXn1/FCrNpjvOZeVUBYxgfrX5RTw0AnugtL11hDVTCS70xjLBLgBapuIoq9BnV1XTtnV5GLFKVczkQ7E9iMIjStlzO+6QAS/EoRIKqIIJ48xjJ5dR7GTn1xznpxALUlEleyuBSToUwq21TF5reRIYLm+LF+88DmwO1mFmaw/KJG/x1FiCX+CKrpLH3SHDCGhhUr8b9JxyDhiPiDTR6zYz104znunRrm4+XXIw/bwiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16) by BJSPR01MB0721.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 08:14:59 +0000
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 ([fe80::3862:65b4:c857:c4a6]) by
 BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn ([fe80::3862:65b4:c857:c4a6%4])
 with mapi id 15.20.7228.029; Mon, 29 Jan 2024 08:14:59 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 shannon.zhaosl@gmail.com, jeeheng.sia@starfivetech.com,
 peter.maydell@linaro.org, sunilvl@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: [RFC v1 3/3] hw/arm/virt-acpi-build.c: Enable CPU cache topology
Date: Mon, 29 Jan 2024 00:14:23 -0800
Message-Id: <20240129081423.116615-4-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129081423.116615-1-jeeheng.sia@starfivetech.com>
References: <20240129081423.116615-1-jeeheng.sia@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0017.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::26) To BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJSPR01MB0561:EE_|BJSPR01MB0721:EE_
X-MS-Office365-Filtering-Correlation-Id: cde75c6d-b413-469a-fbf1-08dc20a2625f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FgcTrCQT1eCOJGqCXzXidFrd37XqKAN6RKxCpNNK858YxvAVKnOVCGl/v3PQ3Aix7L8rL1iGn7V+J1skuotXB4J2SIiRB68ZU6PSVbtSPz4XvBPgV28Jm36qIc1o1yi5jLodhXMu22w7Ggxof3OI2UTXf+u5hKdXt5cCzhuvLiKEWCHWdNFeNh1R8QLl/8HSBbmUlNKX57qr23+zOnNYLM9DKwp5QFkowOt1Xv0YObdFWlMbweJFDibfMoEKsgwRhERvzq0BP8QmkcoyXlNY4KsBD+8QeAtZAJuPXFI4DmiduYmdofKuq36qTSBsqsbEAkt90rJZcIT8+M2adlKMrNYSoYROCur84hLSXT6JAIzdXtoXYLRY9H5maTku0bqgnf9NfzjfYJopB1MvJ0eNMIHBIAYDJq9Kno2mCWYXKsRqPEeT5E+WSF7m0fWaTWM+jxyGj82MWHb5hg6HgzBp0tzWlOq1W0ggfiWt707ev4/lUwtdWeORae0Y3dRJaa8DtCltpvQPllD+EwK23+/URXVSDHXIZSNPUjoqnBex98eoBCCgUYZosZ3Wgu7TJ16r
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(136003)(396003)(366004)(346002)(39830400003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(41320700001)(38100700002)(2906002)(36756003)(41300700001)(83380400001)(1076003)(2616005)(6666004)(26005)(40160700002)(508600001)(52116002)(40180700001)(66476007)(66556008)(66946007)(38350700005)(8676002)(8936002)(4326008)(86362001)(7416002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?51edytD3pZwKY2ezuGfw1ivCNC/WPfbagImVcZHjiKOveq0KFZKQt1RpEhEG?=
 =?us-ascii?Q?LK08qZfEUBTyCTW7RQWwcqRy2olSPIPKcs2LhHetU56dkZqGhIAB+p+IMxAY?=
 =?us-ascii?Q?Plj3Of75LqH+1Wh2Z03ebSau8LlVva1kiUdEuDSkwQA4dLlYVo+Iyazn8mIh?=
 =?us-ascii?Q?IDmQCjwDk9UNGK+Uwxhx/rR9zg7KNY0Ag5WnKSMAUHWuO+vJXXAHPguemNRP?=
 =?us-ascii?Q?xh+T+u/ifiNo4N/6XtyZw4ioYOW8C2L+5uqNL8MYqFttfH+w9BQInUzTT82Q?=
 =?us-ascii?Q?3m0mJD7PGOZdOGFH1xTEcqs6UAZNDykduzr7g+XxVYsicqUFT0PojXfhG25z?=
 =?us-ascii?Q?5bXVm/hWNRyldK43e4d0Ly32VQJobO+yqULyi4qUUfjRrja+XNEYE/b4791q?=
 =?us-ascii?Q?pOoGXrjQ2vxj+PXfMT4veqXM+U/CJa2je0D5dcKSUb/ste03kxFA4vXbctcL?=
 =?us-ascii?Q?GqAO6fZF+paYPcqrO5MH4q7XuhjUAhGJzAP+Yp5XyKNFEHaRNMHqKqMlY5OT?=
 =?us-ascii?Q?IKijfPqTHWuXkPbDprWo4if6omJUe2KdA/+Ggw4letgpryhbe+m6Fdi6XhUs?=
 =?us-ascii?Q?dcEUaKaGX3gQVgN1v444kiiC+Px8o81QKPB+eIHM1B+YXak0GOJliJAeV1PN?=
 =?us-ascii?Q?5PpXCOJmcAKIPd6rPdNUFkidy+av+SnBTo4zQsLWOG5QPOHu1nY6wBreal1F?=
 =?us-ascii?Q?VXGiQ+yZDHytLzyIB7Qz4oGwIAyKEFNrTzjwi5PnxaIa7jRNrf8zaUf2JOGt?=
 =?us-ascii?Q?FqQAkUPvvPuDWFQdJjacS9IY6MmSk6dlcttoEGpMkgeiCzlmMgbSjvd8fl22?=
 =?us-ascii?Q?8lQwGli4T4QP+9V5HP5EU3e30ifBuWtYMaN8K6HTLs839F7AXv09iQFPm+y3?=
 =?us-ascii?Q?VFyF9SCrUeWrYDDbvLSulRXC5E852DTvAyGRiazjWbbOk52jBelLUkf2xVZe?=
 =?us-ascii?Q?y9yy1Ukd0dx/g9oL385rv4bLiOcSj0OIK2qzwFpbExjk/KzuVhWzywi3wT9i?=
 =?us-ascii?Q?yZNvY5vTezKDme+Gre+ttUlupT1NGB3WrF2Wfe+d1Gheu+2+DnlUMZf6t8xX?=
 =?us-ascii?Q?eEkIUgXFdF3fG+bAkohUKLpWHXrrWXM4s7oqfNxlxUpefqZG3qVktb3qMcyi?=
 =?us-ascii?Q?hBOuW4k0cnMonf6X4CaIhFcZW+r8753hQSL+lFa4/deHDpBKYzPIIQpdZEWo?=
 =?us-ascii?Q?1vTqsXqe5kikIcehtytOGjCtU9luP5wN/yIYtPyqwSOhNStbFzYpnKnePSS4?=
 =?us-ascii?Q?yjQy5IzMRXrYRKHIRidKU4zJrGow4sbKjRs2Oanj7TGZjzDO5hMAX2U2YuvB?=
 =?us-ascii?Q?MFR8fviubWPRYe6Z6i3kyU1Xhnn1cx/KtzyYVelMzviL1PU9osvUXQqzVIt2?=
 =?us-ascii?Q?I/ul7xacvVRHBRH/KXmxi6AmbrC6WMMtJnaUXAjQ2w/4v2/i5BjqH3wfYN/R?=
 =?us-ascii?Q?Z+EAfq3YVV6YK+OlgaaGZGppmfNQEnR5q8vW9x/1MGhOcAY5+Z5Ntx4D+jpR?=
 =?us-ascii?Q?LXKnSjwdWp5OVTjSpBjFCUKRhLWiKiqUMpKzqsrafXwvONc8lzeTVMrOUOeU?=
 =?us-ascii?Q?LJtj88kE1k5yXcA0QBJO0qQNgvnW0pTUKfNBbxisesKVISm5ve1idH9LGJdr?=
 =?us-ascii?Q?Pw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cde75c6d-b413-469a-fbf1-08dc20a2625f
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 08:14:59.0720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RZlBnJB/xXTSDU51CdTDCMLS3v7ZoZCBsQPFWigTnmmCyfWoxYi2w3/EN+1RPFczRu9RDxElvMmCNHBO+WhvX8OsTI5EGDFVeGSOlhGa1ZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0721
Received-SPF: pass client-ip=2406:e500:4440:2::61e;
 envelope-from=jeeheng.sia@starfivetech.com;
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

Introduced a 3-layer cache for the ARM virtual machine.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
---
 hw/arm/virt-acpi-build.c | 44 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 17aeec7a6f..c57067cd63 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -426,6 +426,48 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     g_array_free(its_idmaps, true);
 }
 
+static void pptt_setup(GArray *table_data, BIOSLinker *linker, MachineState *ms,
+                       const char *oem_id, const char *oem_table_id)
+{
+    CPUCaches default_cache_info = {
+        .l1d_cache = &(CPUCacheInfo) {
+            .type = DATA_CACHE,
+            .size = 64 * KiB,
+            .line_size = 64,
+            .associativity = 4,
+            .sets = 256,
+            .attributes = 0x02,
+        },
+        .l1i_cache = &(CPUCacheInfo) {
+            .type = INSTRUCTION_CACHE,
+            .size = 64 * KiB,
+            .line_size = 64,
+            .associativity = 4,
+            .sets = 256,
+            .attributes = 0x04,
+        },
+        .l2_cache = &(CPUCacheInfo) {
+            .type = UNIFIED_CACHE,
+            .size = 2048 * KiB,
+            .line_size = 64,
+            .associativity = 8,
+            .sets = 4096,
+            .attributes = 0x0a,
+        },
+        .l3_cache = &(CPUCacheInfo) {
+            .type = UNIFIED_CACHE,
+            .size = 4096 * KiB,
+            .line_size = 64,
+            .associativity = 8,
+            .sets = 8192,
+            .attributes = 0x0a,
+        },
+    };
+
+    build_pptt(table_data, linker, ms, oem_id, oem_table_id,
+               &default_cache_info);
+}
+
 /*
  * Serial Port Console Redirection Table (SPCR)
  * Rev: 1.07
@@ -912,7 +954,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
 
     if (!vmc->no_cpu_topology) {
         acpi_add_table(table_offsets, tables_blob);
-        build_pptt(tables_blob, tables->linker, ms,
+        pptt_setup(tables_blob, tables->linker, ms,
                    vms->oem_id, vms->oem_table_id);
     }
 
-- 
2.34.1


