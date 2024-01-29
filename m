Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB53C47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 10:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUP4t-0003uz-3B; Mon, 29 Jan 2024 05:41:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1rUP4g-0003tW-B6; Mon, 29 Jan 2024 05:41:10 -0500
Received: from mail-bjschn02on20616.outbound.protection.partner.outlook.cn
 ([2406:e500:4440:2::616]
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1rUP4b-0005iY-VD; Mon, 29 Jan 2024 05:41:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7lkFXGz2f8if15b43IYd5Sdo6uQHq/nFTBxp9e57P57EKr0GY/IvPpxMFLwvkgt9teepDg3T67s86ebnq1kdJtrLBCTe+ZIJ4GfRejiedcH2EvvAioMNNp4EvJCDN4Z8kfRMCnt+ejV0cfYdftFxnyFUXKyiUnimAoptTGMk2FqwNbXar0o5nG+IIrIFGldoTyQWxQb1NS+g1EDLDFtUJUiCGocxDP/be8bPY2MdOiJoAd15QExwByYXqYRGfHI+ZUUm+IAY2lt+QUa+ahJwPZ8bb25/x6VzYMZ5qoojFgWGo1ifxjje0QB447rFDMm6nWAEd9324Zb8IQg2dfKBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTJ9z/rUCQdzDzaM/9BLMV9T2TYb3xX1aBdWqLV/BfA=;
 b=Ma+lUNZpOg3Y6D6x1AKINzmAbld8xcHsbch/skvXwD51m8A+7biI6atod5w5C3ukW8F5OJ9NvldDsM29VrpxhkuDueD6SEYCYx/xHTXmqOBgs049JlLlMuJWi+GPCubQKe8EsndexpdlHBCETSpFMJCyIkYLrqPTO71M5itooadFUHe95U53G75wjUjU76gRYqMML4B+3ePFNgMAnvVPC8Jt4b8anTLwJ8UsL62rTvCgBW7JIFhkX81InLGbuGvw5amPm1W2Lw6665J+zTwV/PwTLBk7mkBBlm+41NcTYynV0oVhaB+8DTTeROyYxfXMQSW3kirJ6QeiEq6qzIOP2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16) by BJSPR01MB0594.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 10:40:55 +0000
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 ([fe80::3862:65b4:c857:c4a6]) by
 BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn ([fe80::3862:65b4:c857:c4a6%4])
 with mapi id 15.20.7228.029; Mon, 29 Jan 2024 10:40:55 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 shannon.zhaosl@gmail.com, jeeheng.sia@starfivetech.com,
 peter.maydell@linaro.org, sunilvl@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: [RESEND RFC 0/3] Add cache structure table creation for PPTT table
Date: Mon, 29 Jan 2024 02:40:36 -0800
Message-Id: <20240129104039.117671-1-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0004.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::16) To BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJSPR01MB0561:EE_|BJSPR01MB0594:EE_
X-MS-Office365-Filtering-Correlation-Id: 0482e16a-0072-4b82-0e8e-08dc20b6c596
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3dpYZAlLbbTLwRT+uN72QM66tOdPa9LuSLnZzSHfTflnG12EuUf/NN8SnnIMSnIVoTDXUKXZjlR0KFHCnMt0GLzeoNOci7i+eqraT3B43xReVn8sHMKiAxMy5eTVQb1miCEnkguiIkNY430XR+cQyl2OT0nIzf0YI0dtL+pvlHSnxCQrVLnpFE61WdN6Ql0vGP5kVc/+dc1u8XshbNcs4bvSmg7j/81KqIm1B+tXElqW3m2V1MF12NecF5ehnp7RaDHwkYUdAb5On1sFyQ2YEpUzgBpGJ6G122sIt7PjWxGeM/DLMfBtT1M+PmGgKEf+aiAmD+SVQlPfUy5kqT3zquZ5njeuoJDnpr6hGyAkHAAPW4vlkWamWDmFtLQzkN/UQdwc5Kdpfhr/fyN+CoN1dsOw7c2TA3cJ2QPfJXYH+Yxhlq1X0pXwkSavz2zZtY2325rYcwqGBplRhq0x07/SNIfUvMJPpBMdrIcymb7uoQFU3POLFwTO9yW7FnxJ9WvJMQJcKKO9x3XQ359IUtnqYjF0j0HkaSBZvBOZW393xG6ic7pAbhfj96eSVi4HXynV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(366004)(136003)(346002)(396003)(39830400003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(38350700005)(41320700001)(2616005)(2906002)(52116002)(5660300002)(6666004)(7416002)(66946007)(66556008)(4326008)(26005)(1076003)(66476007)(8676002)(8936002)(38100700002)(83380400001)(508600001)(41300700001)(40180700001)(86362001)(40160700002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?enFi5yextkANZgsQVSkpa2VNQ1REPP6dBLKL0vDL3bCFSwsv3VGN7WVN9zhQ?=
 =?us-ascii?Q?KlD9dE3i5zAqsOvKyzFFffhKMyXQg9PO07xS7nzFK1eOI0nyFU10fS7p7a75?=
 =?us-ascii?Q?2oRUSMoni6fEpnEsEvYajRJsAcpxpaPfmeBhr182pw7tWJmGZsvBHhN8SYRL?=
 =?us-ascii?Q?jjpT6s9WODFaOxnq5oAg3Zc0jydZss5Pbpf+uhJUnJ0NNVXd4AXhDaZkmkYm?=
 =?us-ascii?Q?8pR+GsWAHQ43eu24UD2oMIDNqv7u15YreCuWXMlBRZYHbYQTvZEVtpIsTbyP?=
 =?us-ascii?Q?Nb1bvJOhrzj71Ur34hNsvfV0oJtv38UFsGiiCK7xO8DSBP3qigrnvoRWmHMi?=
 =?us-ascii?Q?7A+HPbov1U0uERXUvKd+fSfscPZUZwQ+2/vCS5xajOn6AVcZ7/ItpqjnciON?=
 =?us-ascii?Q?6aH6+cS8LyeGJ0CLh6Wqqg/xtLW6do/SQVU7SjLR/IAgnt4Za0gsSsjHfg9w?=
 =?us-ascii?Q?rpqFl4ZEVbVioKdv8/aEPTEMy+SobWQhQShXqlqdwd77J6Gdx6pacdsNTQRA?=
 =?us-ascii?Q?6Syxi9sJVmy3B/gZ3cuptnn69nEh/LgBreFdH55FP9bZDOvgG83d8k3A6VgO?=
 =?us-ascii?Q?zpU0/bC4JGc0D/vCdE0Q8BU31oPUQt22c4DIFQR+JwuNvK1vAd+7tpL/5Huw?=
 =?us-ascii?Q?sxbRosIPV+OIOTmJHtWjpUB0mkeieYo9TUpKCiYjZq6Swa5w4KCoah3xD6qs?=
 =?us-ascii?Q?sRt6fa9++BUaWmITufI/1oiKTcoxPeLB9R02Vbq1ZunyTplhbul3k3yaPD5h?=
 =?us-ascii?Q?7KOBw9YsBzpoXgjEJCMhfdR8pyliSpDV+icmI4LC+Be8DwvQDWU7i6RMBj+Q?=
 =?us-ascii?Q?UUAIK5nbpMwclBGp5andtRXcfjrJN/sq2BZh6sBWPRQ0VLfMObHiEbISr7bk?=
 =?us-ascii?Q?NC30IR2XavtCElBr7/3uVeI+JYqTXsNLUfnwkCsIRjavSkxUjtMhX/HAAmMg?=
 =?us-ascii?Q?EyDZiWW2AZNrCNAPv/RpkUx7Q83BkbJs0Rqu8L/CxmloD2yajPTparC7zekz?=
 =?us-ascii?Q?SbK/U1gvqa5M2wnK2yUfvAX0J0aQDWvyUJFoOhdb7gYnJC/7ox3R6Ya6dQp8?=
 =?us-ascii?Q?lzRH+uprgJiH4qnzSI5+zqPT1xR0vK1kZgtIPUKCJ8rFWUp5qWWzasEO2/In?=
 =?us-ascii?Q?GvYI8qB+1HBtGSeA6hRVsiRZKGYvYOgIAHXVT5NhTejuN6ggjxMXLmMrauUd?=
 =?us-ascii?Q?kYFkOAyQlv0qsPdj15s6nITM2x0hPIsnqPoBz4YuGOlD1BIFZQHjQz8OY+ve?=
 =?us-ascii?Q?9A3lEcaGUBR+hTpQnamLgJvSMLee5RpY4FdJPl8AGyfzxX6vFCd4Sg3oFBX3?=
 =?us-ascii?Q?2Gjarr6D5aYo+lWKBzhlyktG4TAeG6CYPsmgf8CA1YPT9zmnkZQEFih6KH/Y?=
 =?us-ascii?Q?Gpqg1bywX+E/YV5qcuJyTTFj1sRMK8NUMiYnKNG+ubkri846hKZW1D1cBbPe?=
 =?us-ascii?Q?VIETS2teD4GEbxO3ER5VpAbF+vQ51VK36VnP04QFU4mdoFlHXPvqlDzBaofs?=
 =?us-ascii?Q?EnPYhEwVSwArxzRmgiG+tN13HWjfCbRFb7WinSfuJDLVfOAiGoS0xAEjN1G6?=
 =?us-ascii?Q?COP9sV7XgYj+iqbI7vafBSbdD+Y+8oEm4VO7WuEIag7FU7P76qOwVGMg4evQ?=
 =?us-ascii?Q?dQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0482e16a-0072-4b82-0e8e-08dc20b6c596
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 10:40:55.4051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V5LyUSgnjM+H+Ca4SuNIoNFRvtumwrYFbPpU2QWOX0a4PznUcs5bzAzocq43IYLDtQx76Eai1wmpUqwG5rN0zwk6aI/sjkxCJY915M1BF2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0594
Received-SPF: pass client-ip=2406:e500:4440:2::616;
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


