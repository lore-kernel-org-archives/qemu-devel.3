Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE80C47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 08:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUMnG-00034m-N1; Mon, 29 Jan 2024 03:15:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1rUMnD-00034O-Q1; Mon, 29 Jan 2024 03:14:59 -0500
Received: from mail-bjschn02on2061e.outbound.protection.partner.outlook.cn
 ([2406:e500:4440:2::61e]
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1rUMnA-0007by-Dk; Mon, 29 Jan 2024 03:14:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0LPCNWFKB4ApvMef993yT0YUQFDTYGWYdtJy8UYLPos/KPd/LOz2KVmxkplro1Exy2sl4eXsJl7WnS7MrmEjUPgYFD2r1ZVua9sWO3P8PszMKVb3eE2fYxFWcN9YvPTCVrbB0rmBTBXk8erHxCi6fydWV+nt1+qhCCSH2/9Ug8PYnIR2RKMce95WoVZCs7lZNw2K62GLWk87jSqNzKlJDfEPftEDJrKhRLnMZBw6HsAZ1Nre6lISxz50xwDothBcOwYyNzIvhohJGcagBPpnux0yuhCMoLOuM5G8J/6OR42RYCXwd0EpLsuMxwfklGmmo7kF3KGUZHHQtvQ2WvlaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTJ9z/rUCQdzDzaM/9BLMV9T2TYb3xX1aBdWqLV/BfA=;
 b=AZrECy0oREXCqF/lnRgecA97YaeyVJNYQHuWfe/6y1L8xPTFsJ4yZIm424DIWsLVTH+8lDdUOFlbgMzqGX+R6+syCapiImFeOJUQtr3pztcR9ZQZGGZK4rxQpK7GDuqSvuoTuOGVqH+z/gpkffGxCwurWYWwMYBYD2ExoXBl85fI6l2409YJMpL2N63yoVrgCAhi9tSE/ZkUbjKXjj2eRM+CxfHBhQswiABg/6qv5NifuC5BmJv4358NqwuufUvCt4eK4L6b7NNVMHfe7/2l/fPs/kMUgt9LBi/3kuEB96ehIg67ebkc9W0Ts27H5Dn67JMHuLfgmGpVopXpqQbnNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16) by BJSPR01MB0721.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 08:14:40 +0000
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 ([fe80::3862:65b4:c857:c4a6]) by
 BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn ([fe80::3862:65b4:c857:c4a6%4])
 with mapi id 15.20.7228.029; Mon, 29 Jan 2024 08:14:40 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 shannon.zhaosl@gmail.com, jeeheng.sia@starfivetech.com,
 peter.maydell@linaro.org, sunilvl@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: [RFC v1 0/3] Add cache structure table creation for PPTT table
Date: Mon, 29 Jan 2024 00:14:20 -0800
Message-Id: <20240129081423.116615-1-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0017.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::26) To BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJSPR01MB0561:EE_|BJSPR01MB0721:EE_
X-MS-Office365-Filtering-Correlation-Id: 05db3130-a1fa-4db0-4407-08dc20a25708
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ECzprLRy3E6rQnSst03ewTcub9Y3B9Nfe7h0tCTcHtD/6rxuIamKbXHbmF+DMu8OI2jxvadiUpt91sF+6aHim2Rx3xTA8sTR9BBbdGbxeXzkI3v5LvYjpMsCrpwGiEj/SMKw4sEJyrx8VtvWuGp+uUD0nnBabbX3SPLmljktPp35lDkVgg/73gBrACwG4BOwUkw2LigSiZ1qGgm5uUmulrlrozbhnonDpB/RMaFFQi2ifa1nH9/jpwtH82ORyAGNkDrWhk9ATz+xEZXDoXcCg8S7oTLuH2NkfslZZVmCcotK1XFmWp9Y4mF1a6uEiSR4CRWszhsA7XgZbmp+C9AoqvpqYt38igHx0GAP+X6IiEDrAh7OaUT7WHnEfDsOWAwibH7BHQQxKvk+cMxCeoDGu1LjsZVBX5hedoUK4fZ0jDYP2eDjSKJ7bwFZ2GxqCbDTCsF3HXZrAfTu73cZoUOLl1LvRyjQrJ0zNC8MrVETK9Nn8EgLODeoGVHkt8BhDrmj0SzJE2v/H1lnwnPIoVa6FuqpNHwUui8iRqLZO0b9H1HtmHZlzmvRfwShDzT8bInV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(136003)(396003)(366004)(346002)(39830400003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(41320700001)(38100700002)(2906002)(36756003)(41300700001)(83380400001)(1076003)(2616005)(6666004)(26005)(40160700002)(508600001)(52116002)(40180700001)(66476007)(66556008)(66946007)(38350700005)(8676002)(8936002)(4326008)(86362001)(7416002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jN9T8Legni+HfeBL4zzIkidjDr3KXtyDEYrrJT+HqEsKISn9LttpJwAz1LKH?=
 =?us-ascii?Q?nVHOeERW+T3QNIRLy2LR+RbmiQoAYjQVRdYA78SufjZ3IYBRAiY/4ae9TMRO?=
 =?us-ascii?Q?Ut8M8ZeWlInDGhc4BLPz+Y/zppjdrvVcJ6/bQyjnQQZdQitTW1XKuz2mfUf5?=
 =?us-ascii?Q?ACNu/JDLAd8afyeB07CW8xZIV/DPGK40ZbS5na9NFCE35PQEoWTLf3pbU9sl?=
 =?us-ascii?Q?vMPYNV6VfGo5BxB1LSZrhKqWZnEpIRSKucTcrOPeU8H3QNIcTp6O/hIpjV8U?=
 =?us-ascii?Q?JyT0sKQ8Rv8zA2wthMpUF4ZklcpxTZdlw181zA6ib4+vSc1yonTAunnGtP1C?=
 =?us-ascii?Q?YEOcp7KgiCqS+BX3CXksCuLAJtLA1RGrvRBsnAnj4tP2yCCkcxL1hmzxfZdn?=
 =?us-ascii?Q?LavbCeDTfJTzCQUL5PIAj/duelbgzwAf3OTtyTvOIQHy6tDTbs9GVXMCil/E?=
 =?us-ascii?Q?hv2sKjaIMWL9op/XOvHtTtugqMTjSYMSNScdBIQtITmF/WXOSGexByh6uG7c?=
 =?us-ascii?Q?i23/zFmZXdbe9VOAi/HJ77i90N/DRcnuAadza0YGKW/kWWwbwkxRhEqmwnsY?=
 =?us-ascii?Q?nh4pZXcpSDl8kq+CQOTnb6gEFrXs8TKCm+4HVzRvWzLTCm9uS+6GOhW4Jzc6?=
 =?us-ascii?Q?ywCmYMnMTcxYszFQyWmzm4Xa0QvOfgKerFM2mcYq2AR2AvUZAfGPh2IezOzR?=
 =?us-ascii?Q?KRa5avVsTvmMQe97+c+9EA3zJ6fXamrtEcxVFcKRzxP5h5FoMlpVsMLYDAIh?=
 =?us-ascii?Q?r3mILxtxtF0qIWGQzpFtKBAMFYhXgqZzVkoi8+YXoyrC/kfo3fMw6SL5OKne?=
 =?us-ascii?Q?m34wxIVvwZ59Uii2JffzI5sr46hDnKvdBXzaKpDgFKa+N63VgLk4RNx7WAms?=
 =?us-ascii?Q?yTfTFtXLeaeFVlN9Fd403xq3n2CG0Y1k2eFZeqarbzZ1lv/+JvnBYI4fzCcR?=
 =?us-ascii?Q?MV7eZiALFqlcU4xBm3K1k5+prb1PBtqueuMBHOZp8cUFc1lOr4NgLLGu2TfO?=
 =?us-ascii?Q?2BAKAtXxaMhbRcFiUMlvfb2pkaLbjAud+pc/FpW6JjqNdJXJHw2XfhKgKMnJ?=
 =?us-ascii?Q?cZpg46uoI20REEC00ToBgG7q2WAaHJHYhnJzT6pFQquaiVgaqwddplEe3fpx?=
 =?us-ascii?Q?vfflumUb92QGgVXZc8gF2RwONhn9lgcPoDQLPmFOLWoPZVzEZsTQHhtbu0C0?=
 =?us-ascii?Q?KjcdzqHyKJ9lmrXvy7/1Qm6SpytrIMmg760cdcTmP8LKWgXHrhovY1Ju5Fc9?=
 =?us-ascii?Q?t15YnUcfdXmadmOX7RjKfIuqUyHbpOq37GzMHPT8JDjOg11/OkDFVyEwfFxP?=
 =?us-ascii?Q?nNAZjfgCJlqnGpag9LWqpj3H+1LyyqefNgrN2m9uPvNhd9J+Tz/u153b7tww?=
 =?us-ascii?Q?1qX/K8k+KLBfy7CtPQEeFXEhMOc5Bm4yXJaMVZ8SDAR9tU2RL1bhmHzvqpDD?=
 =?us-ascii?Q?eBc4cSyHk+JBoTzewUH0PpVYcbXn0xmT7MRjea7Rp75Xyd60+cCoE3hUxxSO?=
 =?us-ascii?Q?4ak951M4ndoiS6VNJJfOJ7UOYQgQ5V45n0yKrg5hIpGqvsU4gOd53TV9XnbO?=
 =?us-ascii?Q?AXBbIEEg2f0/5B757N+HdWMKXUnq8sfoafeQHJtRuGgGyFyCTSE/xG03S1Vp?=
 =?us-ascii?Q?cw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05db3130-a1fa-4db0-4407-08dc20a25708
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 08:14:40.0340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 782QfwqkJui1dEAEtE9XWZZlh8f4y+DmkI2E98PfpVbtd9oUNr03D5iHk96mwuLhM2eWFmlJEdjb2ZKl2qNN6HjX65V7ayRRjVz/tijPnlk=
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

This patch series adds cache structure table generation for the Processor
Properties Topology Table (PPTT) to describe cache hierarchy information
for ACPI guests. Both ARM and RISC-V virtual machines benefit from these
enhancement.

A 3-level cache topology is employed here, referring to the type 1 cache
structure according to ACPI spec v6.3. The L1 cache and L2 cache are
private resources for the core, while the L3 cache is the private
resource for the cluster.

In the absence of cluster values in the QEMU command, a 2-layer cache is
expected. The default cache value should be passed in from the
architecture code.

Examples:
3-layer: -smp 4,sockets=1,clusters=2,cores=2,threads=1
2-layer: -smp 4,sockets=1,cores=2,threads=2

Sia Jee Heng (3):
  hw/acpi/aml-build: Add cache structure table creation for PPTT table
  hw/riscv/virt-acpi-build.c: Generate PPTT table
  hw/arm/virt-acpi-build.c: Enable CPU cache topology

 hw/acpi/aml-build.c         | 65 ++++++++++++++++++++++++++++++++++---
 hw/arm/virt-acpi-build.c    | 44 ++++++++++++++++++++++++-
 hw/riscv/virt-acpi-build.c  | 49 +++++++++++++++++++++++++++-
 hw/riscv/virt.c             |  1 +
 include/hw/acpi/aml-build.h | 26 ++++++++++++++-
 5 files changed, 177 insertions(+), 8 deletions(-)


base-commit: 7a1dc45af581d2b643cdbf33c01fd96271616fbd
-- 
2.34.1


