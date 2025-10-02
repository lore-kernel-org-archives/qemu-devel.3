Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F75BCAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 07:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4DqO-0004Z8-0X; Thu, 02 Oct 2025 03:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v4DqI-0004Rd-Ie; Thu, 02 Oct 2025 03:35:12 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v4Dq6-0008Gl-MT; Thu, 02 Oct 2025 03:35:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHklVENJeQd2m3R65ErXRrowffHYNRnhP5A9KN1sfsH/0U8CEOXBh16j669tpYdkgbeoERWG/Q3bqskmDq2qcheIGJXLGCKu3ojnwTiQNJl4CRNvcbJEkAtaX0BU2VbzJaG+kg1yRlXC8fHasAoWnRMBFFi87d/CKLUsDlWP97s+qXL/6Yu4jzHjOup9Lc9p02qx2NyuUXsJVgJn4JlZoZdmY/X4ZBYlnCjK91FChsf4mGCwS39KzyOZkJM6Ac+CCwj1oYFE7IzTqfNXbXCPsVgLpqApclE+Ab8iHD55DxNDhmCV4nN98y41G7gs8YYImI0RO99s8qrttiuj64M9Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WptSizy55//3dhiOOO+WmBknzB0K6E5Km3B2KBaQFWw=;
 b=nH3MdZm8p8aGzhXJfl/s4wHuSakO/1/cx4ZNXpKep42lJI4oCH+JGNGwi2wgK+vgkyv3ovaEXMjR65qWP6KOzBzeWhHCn//AD0Sr66nzPHR7Pqyl6oUTP2yymKCoYzwaSezOdh2elj3FljQw5YdZdTS1uOK/P7ZA5PyQzuMbrKCODNENf44oLgWFnPTAHG081LGgP/X/3lgDaxnJFvLRLqEyC8bgJKkc3TueNFhrpBlHAkT7SPSwmuTgF3L0RO9e9/iWqw4ylXn2vmp+7or2G3yUpToXX/X6/4/o88DvlHkjH19ZmckRKjv2+uxVo4JvbwXk1q3gqpDH9MXnesEgEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WptSizy55//3dhiOOO+WmBknzB0K6E5Km3B2KBaQFWw=;
 b=NKDCHYbrLltkCZ3wbH8u9kR0oSpPoJzof5jD3bj3Dm7+Kmvi0wwN37aAxp6wF1OPoK43HxTCVuPNpi0aSXTr3Ri1SRwmsu/tV7zaINivTDAv43GHdYQ1IEa7dQhJguJrqH9c+gcQFM2w9h+CjxCwQ6RKdR/Ph4oba1L+n2ajYrc=
Received: from BY3PR04CA0030.namprd04.prod.outlook.com (2603:10b6:a03:217::35)
 by MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 07:34:34 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::b3) by BY3PR04CA0030.outlook.office365.com
 (2603:10b6:a03:217::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Thu,
 2 Oct 2025 07:34:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Thu, 2 Oct 2025 07:34:33 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 2 Oct
 2025 00:34:32 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 Oct
 2025 02:34:31 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Thu, 2 Oct 2025 00:34:30 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Vikram
 Garhwal" <vikram.garhwal@bytedance.com>
Subject: [PATCH v2 0/7] Register API leaks fixes
Date: Thu, 2 Oct 2025 09:34:09 +0200
Message-ID: <20251002073418.109375-1-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|MN0PR12MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cec2387-a7f1-49ec-0f71-08de01862170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/WsF/2+5+Dwd5g77xcYC5udehbO3vesHyfq2jbj0iScQojLumxKTK9QFStlU?=
 =?us-ascii?Q?B+GaYWeVn+QNl8m2OksSYOX8mjAYBTupeXR+rJ+Y+gWqIY7cQ3Evwijlzd7a?=
 =?us-ascii?Q?lDQ5J1dfuiafXi2tTGaTXdLrD8cI9q05B9gdsPR9a0ZFPOKX9NSkImtU8wzw?=
 =?us-ascii?Q?h0CpBbXDkco8278NuJqV1A7HcIygJEZt7PYiFPO1vgrVR0oxdnucA/kafRtb?=
 =?us-ascii?Q?ND3ZBn42wTMjxfLLsLGPATIdeevEDnZv22wPYZ+zHgWgsa/OEDqP8mSaV1XJ?=
 =?us-ascii?Q?aXxkUsl0YlwiNyQbbGT6xOIIRYDQjc3V7L27GE3M3LI7v7ejZq3W0wTqe0t3?=
 =?us-ascii?Q?Lb+BIIAKN6izYynN2Z5HBaV0CWMLRXIWUWqyOwMeGnjD6xbK8vn9C1GcR3ob?=
 =?us-ascii?Q?lUS/NEko6Q8e18tS7ynfFzmrNWzT62qe//NtfjS5v9OjtDLseAikAc7MyMlO?=
 =?us-ascii?Q?CEkJlqPFoZyvIWhxpx8jxYZG79pGKZ4ERiNxYCKZ56TjkgILTc7oM0R0BbBH?=
 =?us-ascii?Q?A6xU8tbw/aBk1SGfcwTXOgn3suSHCuGL6pexnz2Nvo8cebIFuvQ6w/PVy2xr?=
 =?us-ascii?Q?2KSflb0SLjtyFELCEr6bWOkBMIOiyZkPhzVEVDxE1lVzUL4BJiEqmPxmhG8r?=
 =?us-ascii?Q?6Dj9LxfX6OOqKQY69F1UhtKs/XQLGEnObGtsoL3NUAgWWWQWSR7y+nyusywd?=
 =?us-ascii?Q?BJhRoHD5nCBu9X9UtE1nAFiEXrzcpb+4mQjQFCpZJi0SzHtOcue2JnRo5aAR?=
 =?us-ascii?Q?SkvvlvmvGYnHPlkewOTWlLoWXi5gxbSIzvjB7EQI/2QG3NeTOnFx9bF0OUiy?=
 =?us-ascii?Q?TEtYAprhDi/+bVLJtG1EsjobtjIqpEQ0qQ/ozX8LjfHQh6KDSCOHPb9XzO+O?=
 =?us-ascii?Q?Gv6FhHJN6lDqC/M0FoFMlOYCqELTnWED9+g8PUVqKH2gMFGkstvn8l/EgPs1?=
 =?us-ascii?Q?VkjVQJkLU6+5n34PjRKHoGK2H2NSvDJKP0YMtsyFFXV+OTHAR5TkoG1Ve6DG?=
 =?us-ascii?Q?BNT/Fg96gsQr7+1xabwjD0ItYIAydZyMaSshUvY+o5hBXERNmzRNP0KhIFtH?=
 =?us-ascii?Q?CXZeZsBD7i22UP9XAIcVTxYEB9TTLADBcnBWJtgdbZTPszABSmstMzl9j60R?=
 =?us-ascii?Q?8V+u67FMHsJ8AL15Iabj2pneZUipFLRvDRVqeKb82+B9cCTzVO+UKSE+G3H8?=
 =?us-ascii?Q?nC430XCNr39vwK8MqWboNh6HPXM2Q87RD2DRgFhTg3xzUmC2El5ZZKoAtng+?=
 =?us-ascii?Q?loCq/XosuYEvYKY2mPKvvxZOrHO3Jo3K49zxNyfvs76zQL+NUUUaRUrG4Cri?=
 =?us-ascii?Q?JXxOo7nq00Jb8Au+Pk8SlXuKrsDhAd/SeB8gSIbzOLXZOvJMhMLeIxagdNoH?=
 =?us-ascii?Q?GA55a9PwcDg4oNt7OmZOIeEKNCdkmLCJk2UEy0aY9su9+pRrK5s/H4E7UwWt?=
 =?us-ascii?Q?DUqU3Gt1M1TRhwtdyh4ZvqJiquSyrIZ1lTR71p7DDc+G07C7wa9wF2aYka11?=
 =?us-ascii?Q?BTVHG39Ho/wfhNWgiuGL5omifAWyTv5JD3LMeLyq9uh6VnjMt1zEhJCxN5y2?=
 =?us-ascii?Q?r3/XHIAT8EWxzO4COIc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 07:34:33.0045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cec2387-a7f1-49ec-0f71-08de01862170
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5764
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=Luc.Michel@amd.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.518,
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

Based-on: 20250926070806.292065-1-luc.michel@amd.com ([PATCH v6 00/47] AMD Versal Gen 2 support)

v2:
  - Rebased, now applies cleanly. The conflict came from f9ce0848942490
    that was merged in the mean time.
    As discussed with Phil, this is still based on Versal 2 series to
    avoid having to rebase the later on this one, as it is basically
    ready to be merged. [Phil]

Hello,

This series addresses the memory leaks caused by the register API. The
first patches fix the API itself while the last ones take care of the
CANFD model.

The leaks in the register API were caused by:
   - the REGISTER device being initialized without being realized nor
     finalized. Those devices were not parented to anything and were
     not using the qdev API. So in the end I chose to drop the REGISTER
     object completely (patch 1).
   - Register API users not calling `register_finalize_block' on the
     RegisterInfoArray returned by `register_init_block'. Instead of
     fixing all the users, I chose to simplify the API by removing the
     need for this call. I turned the RegisterInfoArray struct into a QOM
     object and parented it to the device in `register_init_block'. This
     way it has its own finalize function that gets called when the
     parent device is finalized. This implies a small API change: the
     `register_finalize_block' function is removed (patch 2, 3, 4).

The CANFD model needed special care. It was rolling out its own version
of `register_init_block', including the discrepancies leading to the
memory leaks. This is because the register map of this device is
composed of main registers (from 0x0 to 0xec), followed by several banks
of multiple registers (Tx banks, filter banks, Txe banks, ...). The
register API is not suited for this kind of layout and the resulting
code to handle that is convoluted. However a simple decoding logic is
easily written for this, those registers having basically no side effect
upon access.

Patch 6 introduces this decoding logic for the banked registers, patch 7
removes the register API bits for those, keeping the one for the base
registers.

Note: this series is based on my Versal 2 series. It modifies the CRL
device during the register API refactoring. It can easily be rebased on
master if needed.

Thanks

Luc


Luc Michel (7):
  hw/core/register: remove the REGISTER device type
  hw/core/register: add the REGISTER_ARRAY type
  hw/core/register: remove the calls to `register_finalize_block'
  hw/core/register: remove the `register_finalize_block' function
  hw/net/can/xlnx-versal-canfd: remove unused include directives
  hw/net/can/xlnx-versal-canfd: refactor the banked registers logic
  hw/net/can/xlnx-versal-canfd: remove register API usage for banked
    regs

 include/hw/misc/xlnx-versal-crl.h      |   1 -
 include/hw/misc/xlnx-versal-xramc.h    |   1 -
 include/hw/misc/xlnx-zynqmp-apu-ctrl.h |   1 -
 include/hw/misc/xlnx-zynqmp-crf.h      |   1 -
 include/hw/net/xlnx-versal-canfd.h     |   8 -
 include/hw/nvram/xlnx-bbram.h          |   1 -
 include/hw/register.h                  |  25 +-
 hw/core/register.c                     |  36 +-
 hw/misc/xlnx-versal-crl.c              |  38 +--
 hw/misc/xlnx-versal-trng.c             |   1 -
 hw/misc/xlnx-versal-xramc.c            |  12 +-
 hw/misc/xlnx-zynqmp-apu-ctrl.c         |  12 +-
 hw/misc/xlnx-zynqmp-crf.c              |  12 +-
 hw/net/can/xlnx-versal-canfd.c         | 434 +++++++++----------------
 hw/nvram/xlnx-bbram.c                  |  13 +-
 hw/nvram/xlnx-versal-efuse-ctrl.c      |   1 -
 hw/nvram/xlnx-zynqmp-efuse.c           |   8 -
 17 files changed, 196 insertions(+), 409 deletions(-)

-- 
2.51.0


