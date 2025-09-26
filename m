Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C45CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:20:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22dL-0002NK-Lm; Fri, 26 Sep 2025 03:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22b1-0007Ne-Cz; Fri, 26 Sep 2025 03:10:24 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22aY-0006mT-Jn; Fri, 26 Sep 2025 03:10:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JzSh1cUOVCWAeEGQUJMk/U+RODS0ZxofjIIpjI3JeCwkCR0Vf1Fo5u4saYBalItHj5goaJPko1/CqLUto+VLWY5ezZFdPKGFTJG/4bcU0JmmB1TR2QpWJwdQG1qV96i69i+ALxiieMQUr2ZXHJ1G6bETJHZrCo2zG8Ls9Urk4kaovJDOInky6oLHl4aMZjwrXrnAeGVse8a0WfAbCDR4VrA9t3vsn5hcZJCU1ESewD8Gq+XNJxpUJN6FsdejIEcvnrtMf1n4hTANSl64KE9uljM58xieM/xEkvjW8w7gXuiR7Xme8JoUGqfPTEyURVB737EYBd0m7Ab4lgm1LmEtDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTqI8zRoDEGcQ7tgJfUkMa5pKiluqBilyvnLXuDJivc=;
 b=aEPO+8h+1QGZ57EYx9SMZgKUGbfgeZmydZel9TRw4uL8DhZM5FRS0o57XUdaajPUrylWWUvmq1rE0FHHPilvgPlXwQkmo4L3yZ3zQo5XiqMROv9h3WgM5ttNv642sMpN3rbnCHYSFH9E/TLgFqvDySgWP0R8sjrfEd7ZIHjaEsuBfAXiu2lKHj8Zn7ZF9UfX8Mtb7pJJkMaw78yUdOXBDVKEwqKzXoLsC2D/XGUVI9XbUz6QEmsSzhr52XY/Svi+p+U+wjia6G6vzQAm74TaS+hNHIwW1vXmKkDQLhrWolHFd7MQBpTrEB5IkwatQUTYtSA1p+GPshEYPAiEnbzfHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTqI8zRoDEGcQ7tgJfUkMa5pKiluqBilyvnLXuDJivc=;
 b=mNppY+jNoabbQ2owT0Y6NTjhTPL5p7LcEvskRLxx/3rP9DoIazLe5IfpFMiH4+hFTmXZHdM2HqlElwEwOfg21gcRlExxghdc82hB9X/74PFdVLNJ4iDh8XWZ+ywaAJKZmdTD9ZPxtrmPhuhPElugKxuO0NJFV+6Z6kuDZUMu+lw=
Received: from PH7PR17CA0061.namprd17.prod.outlook.com (2603:10b6:510:325::11)
 by IA1PR12MB6386.namprd12.prod.outlook.com (2603:10b6:208:38a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Fri, 26 Sep
 2025 07:09:45 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::a2) by PH7PR17CA0061.outlook.office365.com
 (2603:10b6:510:325::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.10 via Frontend Transport; Fri,
 26 Sep 2025 07:09:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:09:44 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 26 Sep
 2025 00:09:33 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Sep
 2025 02:09:32 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:09:31 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v6 45/47] docs/system/arm/xlnx-versal-virt: add a note about
 dumpdtb
Date: Fri, 26 Sep 2025 09:08:03 +0200
Message-ID: <20250926070806.292065-46-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|IA1PR12MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: 1582bcd6-5409-4d07-93b7-08ddfccbab7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xDQPncZUC+0SiWy7h5lpQWnS+Fdhb/r+i+4jPrp0J2e201rcfvl9pVSd3WTY?=
 =?us-ascii?Q?EhpSK5WG5GyGTv84c9kZGd36VTbaa7q9XyB3U6DhZwQKg2MOesUENb9vaP8I?=
 =?us-ascii?Q?+fPVEyabmIOzjWDtt3gZKhLMXOSX+PMQ95+V1I4XarzisnjAJuMTozpu9qJ2?=
 =?us-ascii?Q?AQJdM43mHkhT0d2Hret15+SF+ddb9GvNK/7WR8U1mxgjN9mGWRmqBf/xAvAc?=
 =?us-ascii?Q?OTsiUklxv4VySrazbuuUg0R1zniJ5WSHhvDTfAHa4QGbUMtksnlp2vu/ZkMJ?=
 =?us-ascii?Q?OUVF3HfK3/qmJTotU+mo6m5hUQaw/BdsP7fNDaYLUz2zhYqADpDdL1faYdTB?=
 =?us-ascii?Q?T7h8sJvavdQcDXbR+ekfp7Rt4KmNWWDNCw0k9ZsNATxHY+R3clywOn5gbrCE?=
 =?us-ascii?Q?TcZpwXPq6r1KNGRRyIdt3TSQLFCPRJvvKT+whpBZbgmsiz0unxdDI5CTYEIy?=
 =?us-ascii?Q?rsnI2JbH8yeUnXjdAvfbbWTjGVtS9ESNc90Po82wXmFkMui34ibIhQLe9DI3?=
 =?us-ascii?Q?rJijFFzByJ49dpuiYrSgVFse4iDI0mYBJRyBMVvokos0rKtQ5kdpb9zzR9iT?=
 =?us-ascii?Q?GWH93nFgXWOgrUB36lcVghpyUgiaKxrwxYqMmfXqvGseICz5hGfBsliWDkFW?=
 =?us-ascii?Q?Ku4yjVGJESqUPRQ8+TOwAVSRkKj0fPRP1mpHlMRxfD7CPszxnBkH5nJA2GWW?=
 =?us-ascii?Q?3HmGqGMDUR+O1C8A6NTjbImgirgvJQBLTZEXqj0+1u0bov7TgD8sjI8Ken+M?=
 =?us-ascii?Q?qwtzlaNUrB1g+ManH7PAwRb77eusEcCeNUJ+fpjv9CBjeDxvPMCO6x2IlHW7?=
 =?us-ascii?Q?u8s0Ygy2/hL6XO7ht0VilzwhY2FhW/bt/nAdwWpSJ83WwDfJGN67fgHxqh+C?=
 =?us-ascii?Q?IuH+uHdbcOQh4icbIFdcy/H1Iy8eg7FxEyeXnb8TuY0tC7tFggTg0ZaABzd0?=
 =?us-ascii?Q?xpbiOfT//zod2AkL5+J6z9Qh81TgFMz+PwqiYB4HRYfNO9ZzqSn7zk064RF4?=
 =?us-ascii?Q?u7FKhoAaLM/0aPnCqAOsbq6m5eJ+e3hB02MNI9JW3SfzWXhucGnA7WCPg2q+?=
 =?us-ascii?Q?2mZ63NjJSWWU5NIkoOMd3nOKEcDSnfl1QxYL2c3eIYN8sD9s8brDUV3DX5za?=
 =?us-ascii?Q?2HR4zHaeldxPq+PtCXfiU1t/MO5LhUcN4RrrdSFz78kEGObUr8P12eRz2Gxa?=
 =?us-ascii?Q?+8C4BJZM0A/ONaZhyhzNz0xmcZoNAV4TUClwxgBlnJjwetvdly9yXd253YC3?=
 =?us-ascii?Q?cMNfGb+InJ5QVb/WhYDmy4wlAiIyG0z4cbgOql7Ckph5witsHxCuD3ZcFrbP?=
 =?us-ascii?Q?07j1ku9TX8mIjH2xCLZ1w/3QuP/r82gyDifSTtrQir8RmWrmIu7SmxBi55WO?=
 =?us-ascii?Q?1f61cG2b0zr7kM7+Mn0rvSDUNy30xcFET+l12TVrKVxMC7mgVTtayrxxSS0P?=
 =?us-ascii?Q?5urXFjp7MfhoK6Lh9qs9auhkdaHDPEtCElzMpGQ3Ih+LOzBeUX1R8hOnsLCd?=
 =?us-ascii?Q?RBEOCK5xAzB7KT8FhKQ5RMOAWnP8i+H+lf0d387kp8sq5zere8U8EMKCopf+?=
 =?us-ascii?Q?GkPwpQbAh1uuaiagcME=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:09:44.1096 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1582bcd6-5409-4d07-93b7-08ddfccbab7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6386
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=Luc.Michel@amd.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
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
2.51.0


