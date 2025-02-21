Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 187FDC021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 14:55:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlUQG-0006HU-5H; Fri, 21 Feb 2025 09:54:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mochs@nvidia.com>)
 id 1tlUQ9-0006Go-H9; Fri, 21 Feb 2025 09:54:30 -0500
Received: from mail-mw2nam12on20613.outbound.protection.outlook.com
 ([2a01:111:f403:200a::613]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mochs@nvidia.com>)
 id 1tlUQ7-0000Q8-5e; Fri, 21 Feb 2025 09:54:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=stZPKeTwpVbqo7BTeWYvv3JPWyjsEaYVUvrVjCZIsWDsHAicMsSb1Pa/pykAxm21qTiSU8YV+h9vbLSqKih8D1+kFAaW8a+LTrom3dmz5czuEXD0ED2E6yCyuoEJnKHGTtkUdtuhdrFCwuPAoBsuJJS18uBMXLvswK34LP1lSIEASX5W4Jriy7lFKIwnKI5QfGppPU8TPS7fs4NUWw2zmTo3mrMfRP8pe9CSjP260dv3T0EvxKxnqTQ2/5boiMZEI7HzRn9In7MFk60N/tNnoJ43NWn1VHIYJA3WbMflybpIMOzC0mJFnAmdxi38mum2H9ymXmUVXMh/hAxFm218zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AeW5Gqc0GPYv8Ra7K6+N2ooIi8EMM72j+DzJ1MBdDGo=;
 b=XDyrtj2Z3Nzn7ysWCv8yXnq45E+Vj95WQfiEKfZeCm7L3BwqvJNnulMU7hcQbP6bsdw8tykXG0Z1rEE5OUj0I+3KRnyYT2zwbST8AVXB2ai7168DSk9rrFGUZe4n2eHl4oVV6BGI0le8sUUE8INJaBYJ+t/If1WzMDR9zABprVP1t5KumWMSBVRtFNKo0yQG7REenTxY6QxOht/KzEZn0PNGj2UCjQPWM0O4GQfhv7PtTeWatTcKsz2MCSiGnvd2n7HU6T/5QgKtkzYtjEcth8/NLWYvZS93W4FhzTtHg2nFjXfMTmO83WhT5lVbtTUMqwu23cyHJv8FdSTEEmM54w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AeW5Gqc0GPYv8Ra7K6+N2ooIi8EMM72j+DzJ1MBdDGo=;
 b=T6IYIeFPfIJaEkocKZl9KuWj4KDP09OoVcsmEET6kwZldezAxTh8mvkJWzfGLTSQiiZ6IkOa3lg4ptY+z3azdr5sjrVfxckxWsoFJSVbAyBKiRbPirtMTuAElM+nNegFC5iRDWiu7WnSjQ3SCOKvZDRKj1fdEKL16XyWGzNDz5Z0I3hSnBvuqREhh0VuQ0grq3HtHttJUKCvINNI/tVXwWoRa4yfsRWaVGLAXDKzkRVk+YcswVzKMQWY/u0hzNKkbFcF5Y/0DRdebG1MmyF1irOAO6Q2EUkFLYq64BhUMJjgZqVsTzc46kHL7FvcPpS5I5sT1uzqiwQxA3o17bP73g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8897.namprd12.prod.outlook.com (2603:10b6:303:24a::19)
 by MN0PR12MB6341.namprd12.prod.outlook.com (2603:10b6:208:3c2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 14:54:20 +0000
Received: from MW6PR12MB8897.namprd12.prod.outlook.com
 ([fe80::7c55:5a45:be80:e971]) by MW6PR12MB8897.namprd12.prod.outlook.com
 ([fe80::7c55:5a45:be80:e971%4]) with mapi id 15.20.8445.017; Fri, 21 Feb 2025
 14:54:20 +0000
From: "Matthew R. Ochs" <mochs@nvidia.com>
To: qemu-devel@nongnu.org, nicolinc@nvidia.com, nathanc@nvidia.com,
 peter.maydell@linaro.org
Cc: eric.auger@redhat.com, qemu-arm@nongnu.org,
 shameerali.kolothum.thodi@huawei.com, ddutile@redhat.com,
 ankita@nvidia.com, philmd@linaro.org, gshan@redhat.com
Subject: [PATCH v6] hw/arm/virt: Support larger highmem MMIO regions
Date: Fri, 21 Feb 2025 06:54:19 -0800
Message-ID: <20250221145419.1281890-1-mochs@nvidia.com>
X-Mailer: git-send-email 2.46.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0123.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::8) To MW6PR12MB8897.namprd12.prod.outlook.com
 (2603:10b6:303:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8897:EE_|MN0PR12MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: c05b0c6d-3b0a-4bfe-3f1e-08dd52879f4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z/khCg3gb5LoL8tdCYPueeO/TY6kzR/cflROjDeTDDq8J7N1AKWaCeKD7pBW?=
 =?us-ascii?Q?bCC4K9dkii3WrJE+QNUdweX/I/DFuujiMZmf3pNrqbmXSLLSuaUq0EHz0fcQ?=
 =?us-ascii?Q?8M25uQVuDh0OGrIU9OmSlb0TKftiREUY1SmhBc9XBLTx3yMrjVZQKy09j3hZ?=
 =?us-ascii?Q?25ZiFxcEhQ9iDuE875TxUwtu+58aQI06bG4Y+hm5mj7Pqr730Satft0Bs2Qb?=
 =?us-ascii?Q?t5PhcZrmCdVBloKlTHGnRS26pFHFNSafk2ixlOoVaWwjlLt3eSurrWy0NABe?=
 =?us-ascii?Q?d9oz8aZDlpZEXbwhIFLb2iv3v7fZspuCw4KfUbDsG+xf1kdEIvo0x0ACf1mR?=
 =?us-ascii?Q?bI4kGsBrINmxAT/IEblMaJwc7kQHS8lfmCWxiyxfLrRIwo/MYuETjSV8mWY5?=
 =?us-ascii?Q?wxmxAbK1i0paayUp+4tADItcJ110eK9LQ/sb/1cixtBbpzA80apX0jrDoN0Q?=
 =?us-ascii?Q?WJLb6oZ0O8VPJoBgHoPOcmIYIJ8PUeDCGT1OHccQJuG9KnSTbRzAAKS0+z7Y?=
 =?us-ascii?Q?H9C6WxcoURZ/xFsUIM3ML+95h39/s6tXtxmL/NS1AW4VOWuyVvSUVtvJBD87?=
 =?us-ascii?Q?LzAtT9TYCU33A5XfHd09FjhCtvQZAX2Y2zYl4gnfpoqz+hP54+kg0U/SID1s?=
 =?us-ascii?Q?1rURS4QWRYMXrisJkqoAOab135qgiqA5+YS4nHkWwxrLobBohq9VTbgC2RY6?=
 =?us-ascii?Q?E2x519hiDvkPuevm3sTBLmiAklAUxQZYFyxQ2MO3qqX+QCPwm2G6hJqfOX0w?=
 =?us-ascii?Q?9HLq1SwVN9eseDaMe2r3jVXomkWGpJtCEKVsqS5vz/Wob9zucjfwKNDe1xdw?=
 =?us-ascii?Q?v9uHxyRVzEaRjcAbU8K87hAGUewt6rntKEkaVmk9N2Ov9jQ3qBi3YCSFTtHQ?=
 =?us-ascii?Q?dh9nH9mCC7N0TL40Z/r+vyYDeA8tRqnDFRIQwapF8oyQU/Ms2uZU3jaCrMp7?=
 =?us-ascii?Q?0FtpjasXpZ4w0XCSlY4Juf3fd11maevRVaboL2plYSMdDOtm9fl/Dhizy6b1?=
 =?us-ascii?Q?vjhQJ0WLqARghZim4OQKndApIOOlYSBYzwlxjS2SQvvakq3UR0hidtcZdED6?=
 =?us-ascii?Q?plfTl9vyltISHVvW3+ADdFNKDIaO6WGwqvoC7bsqa+30FTUQEoW5v9cPKqax?=
 =?us-ascii?Q?Ms2jI/BuL0fQX2p+xStBaWa9ZzP944gyCYc6R6BB1TZwV5vTbcK7/DUKdY7Q?=
 =?us-ascii?Q?ccS0oQ4S7KE/seX9AlG5aSa7B6wV1m3MEL0YSJyjeQFkH9D90mXKw9cFRNDP?=
 =?us-ascii?Q?AMNaL4doY8MU6QFYSDinm2stmPWpm8Gu/1GZE5BdQhXkgfI09+sbw77j/PlY?=
 =?us-ascii?Q?Si25eIkK8PHgivUtpa8yw7W/e20VVNK7RZ1pmUoOLfjIYxaSuS8Te3L1tmqx?=
 =?us-ascii?Q?R2sQiSaZoURQhlxkSyXeSE8/6ABt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8897.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B/sFn0qM/hP4bc/6VA9Vu83mRYfVd+l2YGBH4VuqBZxc6YNowPzi3J0r/+N+?=
 =?us-ascii?Q?SzqBEpbFUIOfKEld1ntOfB0A3Cjz9/AVwhwPUxoW2qGkfNIJEMBbGz7Z16qk?=
 =?us-ascii?Q?oELQgySvdPTJd6EbhifkhHA3d7dSQZGTO5QqroDqT150Vlla61ZaV2nOTz+F?=
 =?us-ascii?Q?abwxokD5oppuktXC7eHt5cHfZ1Vb17GyS0xCJkwGlex6URJ16uFA1w72cTdf?=
 =?us-ascii?Q?DgQ1hQwGE5BUIHHvO9NELpIgNkx0A/V5XMMSUdTnyjUTBwrBLz8Rn25mgcr0?=
 =?us-ascii?Q?cZyn2qYcQcUc6F3E9UuLzzM0DJjAGJOk2sUQP3eTOO0WBoqDqy1uFWi5FN7l?=
 =?us-ascii?Q?jdtMLPXduD9AM/ZMGf8uTrkij6v0wi7sh+yk9tIOojdMgEauuWkQOnm9SM8F?=
 =?us-ascii?Q?BhkCg2Nt7O+sy+2b+HHTTNAPoko75RNa5ctwK7wNl0yX1uR/Xs9mpTl9X1SL?=
 =?us-ascii?Q?naLQT+nc0JdJ/ZePoTeeSN3paE7mLR7bARfp51xVBFkz25fwqi6vJXm2xNHI?=
 =?us-ascii?Q?o8wp182r10pnqHY1ZGkSVLrxTRKFTfcXjttNYNOdThu2sFZRd6F9tG+8XRoY?=
 =?us-ascii?Q?+k8eaZ1cSYodGyLoExJPaKWZkBz7lsCRiNMrRcr7DRGxgis2qsZhtGMpVInv?=
 =?us-ascii?Q?cUw6CLfz6VYIRVo7aUI7jLwRUas/IqeWcrBPEkhZ3zcrPdZ447BZFNnIR/IK?=
 =?us-ascii?Q?xSKNiYE+9nWvDs5xSCJNErLhrwJ9/iU9a2RtBMwMBM8MmuO0oyRI/EVRaXev?=
 =?us-ascii?Q?PmhHHq40CDdfj6vaGSjM3B4Y02ZPZOvyi7209Oae6pAoAkdBoMvg2Pm7xQnd?=
 =?us-ascii?Q?7bvZbSWbHIut9zu5xqndskS0zubX5UF8fH+BHB2ldTHHL13/iXguNxCeTzBi?=
 =?us-ascii?Q?onHVMAMkW16eKG9wSStZSZV41tgzSSTwTxWeIKlTy5so1PvWoYqsuCKyPzQJ?=
 =?us-ascii?Q?hMn/oexaalgTqTT6/9sfTNqyVbE5vM5Pzsu9ecEXGR5oNSMzE99TULtz/upR?=
 =?us-ascii?Q?YHoy2qzt7B/GLtOukIiw8PiELFUquArs8nMM6jgomvCBnWIlMiUwKjiTwyM9?=
 =?us-ascii?Q?piGw53LxloABFxTQMhfYC/G/btfFxQ5F6OntGCWDiIW24Eu5VFUW+S1gD81D?=
 =?us-ascii?Q?/RdIKa/jxIACCq08Y3DgMoI0jTRoT1ups0xM5ab+EncHlN6LoyQdZNyiomhb?=
 =?us-ascii?Q?BXBasac9oEG78+qJx4Do2sHjx4bMsJCzxgL4Jytt8vs9cWdp3lEoKnvGkk8W?=
 =?us-ascii?Q?j8XaFOMAAyNr3XWBkqhI3i6tspWG1KfCNaqFVjPF+kTY29v2akV4V5ZR2TTg?=
 =?us-ascii?Q?h8I2/dDz7qOZV4uCaAggvJnO86J2RGPs8jKgcuVaNQlNFcsmTJCXqa7IeQRf?=
 =?us-ascii?Q?4ZQ/fL3Y7EZjLE5lk2qhZxB/ywnEMAbjvwJ8R8dudkjrzlbMKR1sB/UXHSUI?=
 =?us-ascii?Q?QF+32kwINQBT4X5N0LcRadVoPf0hnM4xDTaRiyygJOpJOfPYhjf+WgUm0Rjc?=
 =?us-ascii?Q?DoE/OhYetzemjEQKoOVEEUqSKnVIAD6jspaz+BUmoe0OZ55QWQkkKJ7A/ab0?=
 =?us-ascii?Q?YdU/yzh4U8PVbbY7FuReon+n3o1EICGjgMlGbWt+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c05b0c6d-3b0a-4bfe-3f1e-08dd52879f4e
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 14:54:20.4696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c45yxaIzRym+7jGcB5JHo6sZcB0MgSgCfFmO+d91HDDbpUKO1shZ0DSSfGNiP8J32O7jT70G43vhgKv36uZobA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6341
Received-SPF: softfail client-ip=2a01:111:f403:200a::613;
 envelope-from=mochs@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
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

The MMIO region size required to support virtualized environments with
large PCI BAR regions can exceed the hardcoded limit configured in QEMU.
For example, a VM with multiple NVIDIA Grace-Hopper GPUs passed through
requires more MMIO memory than the amount provided by VIRT_HIGH_PCIE_MMIO
(currently 512GB). Instead of updating VIRT_HIGH_PCIE_MMIO, introduce a
new parameter, highmem-mmio-size, that specifies the MMIO size required
to support the VM configuration.

Example usage with 1TB MMIO region size:
	-machine virt,gic-version=3,highmem-mmio-size=1T

Signed-off-by: Matthew R. Ochs <mochs@nvidia.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
---
v6: - Fixed minor coding style nit
v5: - Removed hyphens from power of 2
    - Consistently use property name in all error messages
    - Use #defines for default high PCIE MMIO size
    - Use size_to_str() when printing size values
    - Add comment clarifying that highmem-mmio-size will
      update the corresponding value in extended_memmap
v4: - Added default size to highmem-mmio-size description
v3: - Updated highmem-mmio-size description
v2: - Add unit suffix to example in commit message
    - Use existing "high memory region" terminology
    - Resolve minor braces nit

 docs/system/arm/virt.rst |  4 ++++
 hw/arm/virt.c            | 52 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index 0c9c2ce0351c..adf446c0a295 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -144,6 +144,10 @@ highmem-mmio
   Set ``on``/``off`` to enable/disable the high memory region for PCI MMIO.
   The default is ``on``.
 
+highmem-mmio-size
+  Set the high memory region size for PCI MMIO. Must be a power of 2 and
+  greater than or equal to the default size (512G).
+
 gic-version
   Specify the version of the Generic Interrupt Controller (GIC) to provide.
   Valid values are:
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 4a5a9666e916..ee69081ef421 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -53,6 +53,7 @@
 #include "hw/loader.h"
 #include "qapi/error.h"
 #include "qemu/bitops.h"
+#include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "hw/pci-host/gpex.h"
@@ -192,6 +193,10 @@ static const MemMapEntry base_memmap[] = {
     [VIRT_MEM] =                { GiB, LEGACY_RAMLIMIT_BYTES },
 };
 
+/* Update the docs for highmem-mmio-size when changing this default */
+#define DEFAULT_HIGH_PCIE_MMIO_SIZE_GB 512
+#define DEFAULT_HIGH_PCIE_MMIO_SIZE (DEFAULT_HIGH_PCIE_MMIO_SIZE_GB * GiB)
+
 /*
  * Highmem IO Regions: This memory map is floating, located after the RAM.
  * Each MemMapEntry base (GPA) will be dynamically computed, depending on the
@@ -207,13 +212,16 @@ static const MemMapEntry base_memmap[] = {
  * PA space for one specific region is always reserved, even if the region
  * has been disabled or doesn't fit into the PA space. However, the PA space
  * for the region won't be reserved in these circumstances with compact layout.
+ *
+ * Note that the highmem-mmio-size property will update the high PCIE MMIO size
+ * field in this array.
  */
 static MemMapEntry extended_memmap[] = {
     /* Additional 64 MB redist region (can contain up to 512 redistributors) */
     [VIRT_HIGH_GIC_REDIST2] =   { 0x0, 64 * MiB },
     [VIRT_HIGH_PCIE_ECAM] =     { 0x0, 256 * MiB },
     /* Second PCIe window */
-    [VIRT_HIGH_PCIE_MMIO] =     { 0x0, 512 * GiB },
+    [VIRT_HIGH_PCIE_MMIO] =     { 0x0, DEFAULT_HIGH_PCIE_MMIO_SIZE },
 };
 
 static const int a15irqmap[] = {
@@ -2550,6 +2558,40 @@ static void virt_set_highmem_mmio(Object *obj, bool value, Error **errp)
     vms->highmem_mmio = value;
 }
 
+static void virt_get_highmem_mmio_size(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
+{
+    uint64_t size = extended_memmap[VIRT_HIGH_PCIE_MMIO].size;
+
+    visit_type_size(v, name, &size, errp);
+}
+
+static void virt_set_highmem_mmio_size(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
+{
+    uint64_t size;
+
+    if (!visit_type_size(v, name, &size, errp)) {
+        return;
+    }
+
+    if (!is_power_of_2(size)) {
+        error_setg(errp, "highmem-mmio-size is not a power of 2");
+        return;
+    }
+
+    if (size < DEFAULT_HIGH_PCIE_MMIO_SIZE) {
+        char *sz = size_to_str(DEFAULT_HIGH_PCIE_MMIO_SIZE);
+        error_setg(errp, "highmem-mmio-size cannot be set to a lower value "
+                         "than the default (%s)", sz);
+        g_free(sz);
+        return;
+    }
+
+    extended_memmap[VIRT_HIGH_PCIE_MMIO].size = size;
+}
 
 static bool virt_get_its(Object *obj, Error **errp)
 {
@@ -3207,6 +3249,14 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
                                           "Set on/off to enable/disable high "
                                           "memory region for PCI MMIO");
 
+    object_class_property_add(oc, "highmem-mmio-size", "size",
+                                   virt_get_highmem_mmio_size,
+                                   virt_set_highmem_mmio_size,
+                                   NULL, NULL);
+    object_class_property_set_description(oc, "highmem-mmio-size",
+                                          "Set the high memory region size "
+                                          "for PCI MMIO");
+
     object_class_property_add_str(oc, "gic-version", virt_get_gic_version,
                                   virt_set_gic_version);
     object_class_property_set_description(oc, "gic-version",
-- 
2.46.0


