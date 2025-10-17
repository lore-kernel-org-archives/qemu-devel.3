Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56500CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 16:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9nAd-0005W1-LE; Fri, 17 Oct 2025 12:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v9nAX-0005SK-82; Fri, 17 Oct 2025 12:19:05 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v9nAN-0007ch-6i; Fri, 17 Oct 2025 12:19:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g21YLjlUGizBLQmTf2JlHjeNRaT4emCGbUCyNd5wOein+M2SUnqYa8rqyjb9scexl5LZkxh7ttCH5VRHZrCG0z9pjbtahSZj8OtFKsHl9idXCsI10A4MPW3ti1mrwB2TBuFmZqSs/HSq7U043s6tLg1u8/L34DXXIwHfrV7Nhk+ff/0wpkfZiL2I59M/O4Ai0oYRJGrsntNcofOW1W5evZyhAuRdUIhFovvoYumGlk7mUca9gqCBZVau/UQsPTa+uWBLD9+knU/ShGYuHB5aE1BkD5J05lohToHEfBN7TEcVOh6LoPrk4KBO5SKrTdvGsc+9IO3UJ3AMZl0rLoI3DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/oFRoaoQdW8U6S+Zn09mD+BfqtR3c0el0VvEJj+XdpQ=;
 b=jahYbAQ5ZZ7YdyCHEn0ZnRpi4pLIBFNSadXkkNZa/tD9gqI2LRRIbc/A6V046gRdB2JzaXvHJ9/VhQ3qQ00uLWJ3wMhu5FrCoOYrFLCY+vE5uunir+GQjoo91+sbE94qlAZvCSvYzwJjwi3QXB3pfaF+RsI0OtKUsaYPMEBeJKgFW9qCMdxS/cTC/7cZ6v9PmeJBxy7jvMK+HmgADrchCO+UxrI+hONTESwl5uYVLiBYUcpA0ajwBEdM69aVD68oZML3PGxZtR/lufwNhW4sYNQeuuDKrILq7vig6yfl3h117N9zbujg+qxj1subDJMcSk2Qz1YJXl/L6HiaA9tvDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oFRoaoQdW8U6S+Zn09mD+BfqtR3c0el0VvEJj+XdpQ=;
 b=YoJ44qdAXATDjBv16O6lbm3xnSwCi+VPGlVQ9o9nXOUkY+gtsdtZOECIwUwiCfMGCV6DONFimsSudPhYJfyn3ygldZdEveQS6gPDadZZNlmisKqoa00y3viBVlK3ge9UogZkwJHNUK1HHpNtUhw93GLUtvfOuJOBcpRAKMyZAS4=
Received: from PH7PR17CA0031.namprd17.prod.outlook.com (2603:10b6:510:323::14)
 by MW6PR12MB9018.namprd12.prod.outlook.com (2603:10b6:303:241::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Fri, 17 Oct
 2025 16:18:31 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:510:323:cafe::6b) by PH7PR17CA0031.outlook.office365.com
 (2603:10b6:510:323::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Fri,
 17 Oct 2025 16:18:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 16:18:30 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 17 Oct
 2025 09:18:30 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Oct
 2025 11:18:30 -0500
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Fri, 17 Oct 2025 09:18:28 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v3 0/6] Register API leaks fixes
Date: Fri, 17 Oct 2025 18:17:59 +0200
Message-ID: <20251017161809.235740-1-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|MW6PR12MB9018:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a1a43b0-5dff-4dfd-c9b3-08de0d98d016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FoHHUkBar33aLzGo6Jgl+Wc4KOLTg6sGRa3c/gLRGVIDpwsoBBDN9SP1C3uC?=
 =?us-ascii?Q?xlWG4G8H6qL5n6QG3i/yDognzUXAf08Ny+Xbd7V5u1HddfQH62R9vB0a6m/8?=
 =?us-ascii?Q?5ze10leo+NB7hrGz6cF6QK3aDUGw9tJoqkL20tZvl53AjMrWzUDRgCYade3t?=
 =?us-ascii?Q?wGblHNdeiBYDU782VypgNnuiC47eKyDStvKfRNOV9vKEiJmMxJMmeQkKXxwb?=
 =?us-ascii?Q?TK3nX4W2JxqAVMYS4Yp4irM79dWI3c8cCqJuswTKiWq55tY6cDd17iCO49Z3?=
 =?us-ascii?Q?LDqCr6QwTUs5uTkhrjEfPE8rgXIGVpzy17skb63oV+LL9n1s45FBBydlFXpf?=
 =?us-ascii?Q?dxRhlaZWOe5WylRj1L34GoMqGepF6lY/tW3WrD0i1enH15Y30WcGjMBdXZwM?=
 =?us-ascii?Q?sCcasWNNnKOmNhkHwZTrXqPMliuKokUaSKryxh/c0l5tCp0yfsRTbnW++Xz7?=
 =?us-ascii?Q?P7jxPlg5Xh1bRgeFt1VHl0rEzCLjgXaXpwy3srg11w0X1Ju8v8xSounIC3FX?=
 =?us-ascii?Q?NLSn42h9Ch8fOiPbbwwJpp5IEoJ2RQ2BaIpQT9DvYICY3gUH223nEvvBV0Nk?=
 =?us-ascii?Q?jeM+idEFNpUiK8u/GeFMu/xCcEMcneE3qCfErRLGLNB4jZviKAil+jwBQoy4?=
 =?us-ascii?Q?KwPUfuwr/2BUI/yFlfE+2E7kY32o+31cS/ozxSICD/Ii3Gy4UUp45Hb5z/uz?=
 =?us-ascii?Q?x3N4inRtb1dCcCeDWmEsKZ+8aw8Nd7tzQ2rFIlbdiIt9KkSAr12/M8W83EX8?=
 =?us-ascii?Q?CqTRDVWoWi3UlbFAyzTFAGA/x+0vP8z6JyHdm87vxVVEymGjOJOgdQ8PSbW1?=
 =?us-ascii?Q?lh8dh7+g/y8si+Lcs0ZKLIiN+nnM/a94vXh9ZvsJ5uQxmV/ird9VEIAYoQuI?=
 =?us-ascii?Q?nQIkFisWHKsLMETISPawfj3BuMXaHfR7PzbPHYwHhr9bk0ZjwACOYnb+7yl6?=
 =?us-ascii?Q?GInY9u55EWcQc61Zelux/HncgHRNppx0XXXPFSzmmuuuJ3PGYvVGxP0nOpnZ?=
 =?us-ascii?Q?X9Z1oToaY1mqZ9oRr8iVxwpbRRfSTqa6vy6KemgjtyJPXSU1psM1XrHjbsH9?=
 =?us-ascii?Q?Fu/GG8bNtqBbYFT8hnUqDcx/b+ks8gliwJvZx83Ppv32l1pnRHRZ72ab+aFX?=
 =?us-ascii?Q?iB58RKuJWmy8MYY6O5bkpYj3htu0fwqPlgQblZtxx3C7t3YNEGvO0zsUBRiy?=
 =?us-ascii?Q?8C7d2PyAR2W5S/Dyxj0atpn/Z1xkR7JzF45EVkBOcaNyfrvJoRx949E+eBL/?=
 =?us-ascii?Q?o97HMR5jbROb6CueZidTJ1kuFy64de+zQ8XVGXHhk7fs4U9Dbfq/tpbHljnJ?=
 =?us-ascii?Q?+d4/3VmUxYZMAHcsyuZmLRotZV3dIVmNXYF+UGP2fSrZE9Sl+z7z7mJUEpoQ?=
 =?us-ascii?Q?e/zlavSlbBRtMklDEB+B5DrGzFVR06HibJDmThyvDcxjYMCs0Aqr6FZGisWg?=
 =?us-ascii?Q?4ohfC2gkqq6SnM/My8wANnVF9A/08XDyxuBVuM99SZatPCf7ghZqZT9TH/ZH?=
 =?us-ascii?Q?5Ij7/Gm4JkNoCb+kGEYaE6juNFxhszZ7VRk6+AulPxdCa9YquUdI7vw/lG14?=
 =?us-ascii?Q?9n15cC16Sad+xkahXcI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 16:18:30.9665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1a43b0-5dff-4dfd-c9b3-08de0d98d016
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9018
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=Luc.Michel@amd.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
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

v3:
  - Rebased on master
  - Fixed compilation issues in intermediate patches [Phil]
  - Parent the memory region in the REGISTER_ARRAY object to the
    REGISTER_ARRAY object itself instead of the REGISTER_ARRAY owner.
    This ensure correct finalizing order and fixes the use-after-free
    encountered by Phil [Phil]

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

Thanks

Luc

Luc Michel (6):
  hw/core/register: remove the REGISTER device type
  hw/core/register: add the REGISTER_ARRAY type
  hw/core/register: remove the calls to `register_finalize_block'
  hw/core/register: remove the `register_finalize_block' function
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
 hw/core/register.c                     |  38 +--
 hw/misc/xlnx-versal-crl.c              |  38 +--
 hw/misc/xlnx-versal-trng.c             |   1 -
 hw/misc/xlnx-versal-xramc.c            |  12 +-
 hw/misc/xlnx-zynqmp-apu-ctrl.c         |  12 +-
 hw/misc/xlnx-zynqmp-crf.c              |  12 +-
 hw/net/can/xlnx-versal-canfd.c         | 430 +++++++++----------------
 hw/nvram/xlnx-bbram.c                  |  13 +-
 hw/nvram/xlnx-versal-efuse-ctrl.c      |   1 -
 hw/nvram/xlnx-zynqmp-efuse.c           |   8 -
 17 files changed, 197 insertions(+), 406 deletions(-)

-- 
2.51.0


