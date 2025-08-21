Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D71CA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:19:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up50L-0003um-Pk; Thu, 21 Aug 2025 09:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4zC-0002UM-8h; Thu, 21 Aug 2025 09:05:46 -0400
Received: from mail-dm6nam04on20626.outbound.protection.outlook.com
 ([2a01:111:f403:2409::626]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4z5-0003GC-Ni; Thu, 21 Aug 2025 09:05:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sjNxlkyt566brMOmw+f4NwT7Q2Q/wr4wiyyWWxIClo/F1DRs671gA/0JSUl4Zn5Ns19ti3v9/sKMykKF+OUszDthxGFhITe6eoo56Cp35HFTR4tDZV09DiBa7W5yFoHYe+bJzAuY4Bdzw4JNSLcETps3TBuNkwSND8AsP3TVNJny5zoGtAR9r3o65Bx4gz7TXa/Gt5aazmeprqdJ0Kqe6xUzMR4sLX2s2bdR538U4ixjU7Ql/jb7xEfS+SYbWHfNYFLyiDtiS5jVxtwTvuv+NbNktKm2LefoyGIsRfLidt8Cic+ad1/Lo7Df/s6U4fHegGgMWkQXlnBdAmk5xbxPgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHK8ys2NHiMe5Y74ks2/3+TVAL4SbZHKA/dQxjpvi6s=;
 b=eNDUbYgMpvAdAGWy12MfZ55YSnseMSKL1LW87c6k+F06laqXIoXo5wW5KkJQPgQWyYyhjhCZHcCS1lxtctmcb0eH7A/noWfStkKBEMwWRXOF6HCR0W1Jh5aaD7I7KBO0FJK+q+kcuk4VUY/0eb2Ljt1yK6C+vHEVQpqFbyvTNF0kN++kBW0yYxVdBDyE8TiNrL6Z71c1Uv2ngGGnAqYSKhHKXoCaZO9O00iZb/taczxbVUTPgMHDjjoFJGBS9vapsDna15/umTMf3H+l03BZjSqTobDNRRioYgGhGPT1815qp/PJ3andWXK8t8zBAGS3aecuxMSJ9l4lSqOK5KNOOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHK8ys2NHiMe5Y74ks2/3+TVAL4SbZHKA/dQxjpvi6s=;
 b=3XN/kXDpDMvnFeoo/epGpoHB/fTNydTXp/zTs9kZaWgbWRkz5QcMNUM3wfVNE2PciyfD3DeDBGTYMcP9P7IKeMpAhZtv/rSs/AQtS1hpi2uXh5ffLWQ2TpBTcA/6gcay5ALjYiOJs46IifuwpZTesGqQP9h/fO/mKHcOV8/0wSU=
Received: from SJ0PR03CA0109.namprd03.prod.outlook.com (2603:10b6:a03:333::24)
 by DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.14; Thu, 21 Aug 2025 13:05:33 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::6e) by SJ0PR03CA0109.outlook.office365.com
 (2603:10b6:a03:333::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.15 via Frontend Transport; Thu,
 21 Aug 2025 13:05:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 13:05:30 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:05:28 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 08:05:27 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v3 45/47] docs/system/arm/xlnx-versal-virt: add a note about
 dumpdtb
Date: Thu, 21 Aug 2025 15:03:44 +0200
Message-ID: <20250821130354.125971-46-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821130354.125971-1-luc.michel@amd.com>
References: <20250821130354.125971-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|DS0PR12MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f3a713a-4d86-4f67-2ab0-08dde0b3684a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pv0Kczp+/RqJZ8N+7zuLxLDtGxzZ22Gi4UsYCvcRKVfBWo5I0QSnWCJQMiEB?=
 =?us-ascii?Q?TqHKpZ6M6em+NvJQ31nmnrZvLyuH51K9Esdq2+5A9Z58E/HaXQQgp4tYppSj?=
 =?us-ascii?Q?0OJhexDYKofgNiToOOaqgVSBvjBf5c4o3lWI1AGONqQyq64ExVa1l4V4KrIc?=
 =?us-ascii?Q?Manp2zrvBaSH8EWusp9UqTSiQ9MYZYpRcwHmpWbktTW2RH4frPTiXGikBA3w?=
 =?us-ascii?Q?bhFAfZDHeIFpqYm8p07D4Mxm10JxhmoZ4rvSbReyisQ0IPEd3XUJdeBMPH60?=
 =?us-ascii?Q?zFAOAuNwLIVVaOHUa8KJKJsFHTQjDO8jS5bpeF0kver4gEaOE/LJuEniYnn3?=
 =?us-ascii?Q?GXoou8Ovw/BEymLHznHvIqu7NAuOfKZuslDPiYOZREy7KUkhtvOxuTyQms8E?=
 =?us-ascii?Q?DBYe6OTjDEa+VCTMqJ+uz6qMlK+jbltt1lpHMt40ur+Wg79Vx2uAJUZVo4i2?=
 =?us-ascii?Q?DoriKudsJ+UMsDSspYGA+vfzttuYpVwf3WiKOt1wn7V2jAj56/+Lyq4/aJwg?=
 =?us-ascii?Q?AdJJ3lRupiZ+0RcWRLgy8FtFuY0C8gwzou8zpVYQHEQPtZOwy+8li0kEfGRF?=
 =?us-ascii?Q?eisWFz1uxOtklCmJVn9jYsS/y5JOgrTZ2QwDIjZrqDU5+eB7LFmW23ofxVhO?=
 =?us-ascii?Q?oiViBtCQu3/9sSJ4t0SDbvwK6qNNuE+mmAc6kpfJr+CZf18td0WDfLsw4+5i?=
 =?us-ascii?Q?lG0urX1q2E4GWBaONerfm5Th/pOBykWbZbY0bWum8OYGbji6/i6GwzEpt7fG?=
 =?us-ascii?Q?suRKnVvcEwmnD665VOtTb8gRXvgE4bTrCGth1lueRaKCW2z07DsFy6bG1gen?=
 =?us-ascii?Q?FYj0t5IFLkACMJSkZLw2e34E6wVYvarrtroxK/ur4dAEc8Wp4G/OyUH4Zx8y?=
 =?us-ascii?Q?w8ngY4KgWZeGVSUOFoGi2jQg+bD8XSS+trCm+oglFFTXO/c05J/nmE3TrATl?=
 =?us-ascii?Q?Su9E4amsJcsxiFETbEPLxDTj8SNOdHB0fsSFBMe2pGfuPmir4qEjaAw3t/rp?=
 =?us-ascii?Q?F8FVgAmGt0HPHsyaulQ4xxMkEzXn+5uCvq9a9jzJCJEPRh9+xrs3EUGulAnY?=
 =?us-ascii?Q?bxnhe8LvpbshIOdjPD1fKCQrIH5PVAy5dEHIuH733P7yfVc57cPQdyRDLOLC?=
 =?us-ascii?Q?y002R+kyif2svCs9keKTKcW1hkk370oHgXK+toq7hsMBn7wzr66NVmXaa2z1?=
 =?us-ascii?Q?bhnqX9u69mHwdaCAJM6gHSsZmSZCcxQ/OMt8R5J5KA6Pu7fkxiahJvDHY50w?=
 =?us-ascii?Q?TiB4EYFix6ab7h+S0XtA43OLhXqA08e/NX98DcwiGoEusSS3625y2vckb1ib?=
 =?us-ascii?Q?c7YbfbD8MHgQ7GbD5lRqHAh595cg6MqcUo0lQ6Iq38Fz+vEmArRTPlscqeJz?=
 =?us-ascii?Q?2j4aLyaFWe9bh8fmW5mdJunT6UPdZwScELo8Pl4faAkaLw+rQ+n9QY7pRBLv?=
 =?us-ascii?Q?Rdpk7Sx9msFzze5Gd0GQYDIKEVZWDWNCiFipKSXh2EbdCJKF02KjTuDgJj1I?=
 =?us-ascii?Q?l/wd4KWMZe69GEuGgBBBmp634XVYcxj1pnO3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:05:30.8590 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3a713a-4d86-4f67-2ab0-08dde0b3684a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6390
Received-SPF: permerror client-ip=2a01:111:f403:2409::626;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a note in the DTB section explaining how to dump the generated DTB
using the dumpdtb machine option.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 docs/system/arm/xlnx-versal-virt.rst | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/xlnx-versal-virt.rst b/docs/system/arm/xlnx-versal-virt.rst
index 94c8bacf61a..5d7fa18592b 100644
--- a/docs/system/arm/xlnx-versal-virt.rst
+++ b/docs/system/arm/xlnx-versal-virt.rst
@@ -63,11 +63,17 @@ Users can load firmware or boot-loaders with the ``-device loader`` options.
 
 When loading an OS, QEMU generates a DTB and selects an appropriate address
 where it gets loaded. This DTB will be passed to the kernel in register x0.
 
 If there's no ``-kernel`` option, we generate a DTB and place it at 0x1000
-for boot-loaders or firmware to pick it up.
+for boot-loaders or firmware to pick it up. To dump and observe the generated
+DTB, one can use the ``dumpdtb`` machine option:
+
+.. code-block:: bash
+
+  $ qemu-system-aarch64 -M amd-versal-virt,dumpdtb=example.dtb -m 2G
+
 
 If users want to provide their own DTB, they can use the ``-dtb`` option.
 These DTBs will have their memory nodes modified to match QEMU's
 selected ram_size option before they get passed to the kernel or FW.
 
-- 
2.50.1


