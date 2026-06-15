Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 596CECD98E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZEFc-0003ut-3w; Mon, 15 Jun 2026 16:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wZEFa-0003uf-Cc
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:49:42 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wZEFY-0005Aj-QS
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:49:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=djHGZTWXm4kT0raezpR9+diYhVhNIz5NmaN2fhO1/797cmCyD7B9qKj/07VbY//hvT3ea4DsviX1K4z3782OFtA9GtBUr86N4KtXCSpgc1S+pzoHdodqlFKbOaNaw3qWTZfcPn3R/npnYDuelJbfBmNCpdB6+Bd3utbS6JxfWWym4aJWpTWNYF4hKam88Xia4afu8sKvwmM/o+13p45jjlx909WY4E/AalUC8E0mo7LMQOHEUrJukiKBeNA7BlN8uzFomLhz4kWLTLCQaraI/n32nL4g8ACPrIdG4dKkjiNUZ0PXPXuSWEC5PV9E17WfmXfdtx8JrXCmaPZq6hAdrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+frQh2NW5cQvuE/XvBHJmeGXCpBoTNmBDFpVa7b+Dk=;
 b=bXZWHsTG0qqZtqQ0lKJd6qZNMlelIMW/rPd4Mvl4s2WHhLNX+qCzrp9emQZKFOn/iwXONNJZ562XqmYrGTV1IeAe9bUt5tOOZ4R3vNpUpb7J9RcArPjk+tgF/38a1P+R9uOP2JN5IeD/MY62nfM7HpPVGOQoAqoqfRva+Aqay6R3ctdZwMh28bH4Ndpl2/mcn2cMaDVRH3c9Ynjks/FZMjvYveTi0e7uv3a5b0+ByPUIC1vcrLJFgAnB5wdZt25Fp3zGUwAsdQUtycudo0udYmGd/3QybvZKm2bH8Dj4jtfzdPm74Yw4EvwEvsN9xkq01lyfWfmnuUNpbuZugmqClA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+frQh2NW5cQvuE/XvBHJmeGXCpBoTNmBDFpVa7b+Dk=;
 b=Kxnh9nEpMJt41eE8Z+NbYuosrkpKebUJqXsNbs9WWpSyNw776xyhWWF4fp3lcMiGu9sfZUV4OhsuuRA9Zyutrz6YTlvoCRGc2m9spEP7qszk1GUJfKrMYMbZmzNuk6DA3wsfhDsg9ybKIqwv8VQB162PIFR6Rc8l1fCFkpPN4Fc5tu9vvE/1lAYXWmo4dPY7QIumwEwlnvuq5cRIys6ckcqWr74m6KaMNsTnMliChkMlpA7sj0xNow0WbNWhtJD7ctkJkLzC4enNDIob62991Z8FoEZzysViuvlTouRm4gJOYwaZZopbqyrG4idxJ4EZTOg0dkjgRfqWGJcQAb+f1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15)
 by PH7PR12MB5807.namprd12.prod.outlook.com (2603:10b6:510:1d3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 20:49:00 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 20:49:00 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v2 1/3] iommufd: Introduce handler for device ATS support
Date: Mon, 15 Jun 2026 13:48:47 -0700
Message-ID: <20260615204849.3659647-2-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615204849.3659647-1-nathanc@nvidia.com>
References: <20260615204849.3659647-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0110.namprd03.prod.outlook.com
 (2603:10b6:a03:333::25) To DM4PR12MB5390.namprd12.prod.outlook.com
 (2603:10b6:5:389::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5390:EE_|PH7PR12MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: 83918dae-553f-40cc-d940-08decb1f86ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 86q3AxQqTbI/YTj4pYr1jgQgma2TUSyWbK41D4Y2jgj6DFKA5KJkx+bx86JGQY6mMhAF3leUDbmh8uvfPfYCbmI7G0yBC0CZo2afX3PBcxgH1fOr/KmeIvs7H1DOmSn91OrkPZFENDAit4859hYpvt81u6yWMRR3tVE2nn56d98Hsknm8+Ni+Bof1RARhQYbcc7Ro6m9kjK6jSG1wL95iMEqrNkoenwY97nrdP4C67M56EflF/FdihExUmypCvo7BhY4FJGR3GZHXdI74jHk5tCl7lbAAkYZeprXtag1Vo7ZDq3+yOvfmZqyB40/w3Gj+jtDGPpPHQJFna38lRSZoMJSCDLkhzQCgfXh0Md0ofNWKn0DVEw15T+MkIsLH5QcihjadYWp2vOET375apWUS0Qng7g9bF29IrHyThNgAuXs2e6w5vrkmqPNt8ZpXI3sHvvns5wownZeScpIJAqxpEkLRb3zmnld9z+WYcps0Ju0fX6+5GfSrydtjbkwHAw0s+0ZmqnrxzGX+QFDjTH7v8bkISQIKjmCkf8RY7yYGt7zWpHLBD7yai51pcnJ+jCQ5HWJpcy62TshFNo7+LOi3LDlyqZB/iAPfuOPqKh4e4uXz/CngEXTaLU9zCDWT1SgU79aw9D7BZgl8MNoW7czZ37V8yfazAzQY11BK3whaUofSQk3LoZWGLwiK1Horlow
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5390.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q6ZwlTiqVibtpknN8Y+wf1UskS+8oi+D5wEbvFG+aiYakJ9UZfrMYoOH7hY7?=
 =?us-ascii?Q?22RGcGRftaqcwgDLaIBOgKg4mdsQwXeQEZi1uUgq6f2RRWaPsWfEaEhKQtxV?=
 =?us-ascii?Q?JnXSABWEXZy8XjZuh9h5M9QGvf0IG0IRE3xl0IUxwP4fcmd+WqQjZxvjhJyM?=
 =?us-ascii?Q?GcH2IDyNbAuH7Ogmx/BMreTUkhUA6dZtiXPSj4BESPHTR+wuGZX19257qkrg?=
 =?us-ascii?Q?Q8N37jEynHr3nJ6xcxDNUMZFOxX/FcpdTTHTz65vRCH8TpkWl1bW+smaUiU2?=
 =?us-ascii?Q?82jF0QWotjAcR9k981b8LA7Tkts8JXww/XRLOoGitY6BghoQ7yhnJLqnTQzw?=
 =?us-ascii?Q?5SYf75ZqhhMi8F6sGieM+ZBpMH8IRByWfRXeDf1CA9DnxDxGIQVVtOTWmQXG?=
 =?us-ascii?Q?lm6qMuorNiTyGtLzu3RwWqbVJabBGSt6bUXXtPcgMntjnHCFW+NMf98NyIDd?=
 =?us-ascii?Q?DGgDNZemHK7CmaQBeBt4KFGAKr11l2Z2UTvxivnq6UpjuAiOjBdOp3ZxSwSI?=
 =?us-ascii?Q?erfl/YxSLNRdO09hl4TXCUVN2QhG1MDHIT9rWyfQypZIViEzasJxk6H6NIC/?=
 =?us-ascii?Q?RM9/BHnJ57Ynn58jSWhrJbrH8dN412n+L0vP2Kmbs6ssQ7+6Dl8UGfKzz6Cp?=
 =?us-ascii?Q?xgSkdJzKh5BlFNhLyLMEyEAMcgAsm9H7q8H6uHR+IFTaJhfD1Ug1BuAiQxx7?=
 =?us-ascii?Q?/HAY06q8UdPUvODXzL/rtoCSEvjmr8WlQCe7HGVtFdNcvlOAudx/zNQrYuJ9?=
 =?us-ascii?Q?Q+RBYOZX5O9xG2ooTPkTICDVLPdXA0T3h2W645sPEOemL6HXMnyTgxDqV+VV?=
 =?us-ascii?Q?QxkgWw001HpTJ5G2hXm+mYFHQMmZw9uOqT3YBNP541s8KAC/DhF4lLrFbNTp?=
 =?us-ascii?Q?lV3uCa+j/KNlmaSsc3MzNtccM5fVjamKOU0hzRuKfNwK9uzjIQbxxlcp7xog?=
 =?us-ascii?Q?vSNXNtjUa6itsW+gdwFOajd9GLaUHOU9oMatcRGgOhB6vAcUL9QbGq5zrZsz?=
 =?us-ascii?Q?S2eaNkMXcA9LVXe47i3xLzmNDZzcHjM/Vpv2OZLqoLXa/ervEcPZcvdJX2xG?=
 =?us-ascii?Q?pArKNl1U6w3AnCX5wn+ps+CoZ8lIRk9jl/nDlsbjksP21U1Tj4dvUZWR7Kuu?=
 =?us-ascii?Q?ka3+qldowrqJsD6BsrVqh0YKc7AXMBnwjKhB5I1hYa6jfeSFNC477EeyW51y?=
 =?us-ascii?Q?sPxroBKUIRWS13uRmJROog7zMcC72y6RhVVawTKSWnUzMc37oi5j7gTJktcQ?=
 =?us-ascii?Q?nbr5h/m6Nz5WQRKvJTsp/LjdxaEE5u4swZHBzdTUeovPgq4ytcQR23JZTeuS?=
 =?us-ascii?Q?i8h0SLAuTryf1pg0XMtSvZuTsJbifoxMiQXDvC9KGiVvvcEOo71HsYsYYysw?=
 =?us-ascii?Q?MHlJDvro8OxpSNx2YU2+O5uP1JTP/AVnk5NDiABYELSbIg+9KQN20pyKKrGZ?=
 =?us-ascii?Q?ChuclEQKvqWaRnRd1UXNN2sUqFWO4OJoyPOgeIfH2bg5xNqKsdjgPRS3AKsI?=
 =?us-ascii?Q?STvTl6KMyY4iwWgI6tdMovKKnVCwFLgnOo7QAYX352L2G14cUKJevJ3ZxCdM?=
 =?us-ascii?Q?rufJYQzaxcBR/5ARSpL+sqFu7EBZaY0+qopg2M6S0ldwI9o+sH6k72D+gbc/?=
 =?us-ascii?Q?2BcOuVcQ0o5YMZESwyE/sUDUmVvy3JoOEZXJWcpvo8wUqTuMN7zLNrv1Sg+q?=
 =?us-ascii?Q?am3RW6dnXB6myP2W9xlmY9Vr7ViHbbaojAVUc9ZGhJyql7/WZ81fpYEAorMN?=
 =?us-ascii?Q?man1Urz5tw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83918dae-553f-40cc-d940-08decb1f86ee
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 20:49:00.2427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eak46xY3VUQb1ChHTvahB9nV2lQW3t2MQv2TTP8fbTd4o5N/cs17F2JeM9tjgi/linD44WR07twQtTjnbuOUSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5807
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=nathanc@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Nathan Chen <nathanc@nvidia.com>

Introduce a support_ats() handler that returns whether ATS is supported
for a device associated with a host IOMMU device, checking if the
IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED capability bit is set.

Implement this handler in a new function for iommufd.

Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 include/system/host_iommu_device.h | 9 +++++++++
 backends/iommufd.c                 | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
index f000301583..2cb5365340 100644
--- a/include/system/host_iommu_device.h
+++ b/include/system/host_iommu_device.h
@@ -133,6 +133,15 @@ struct HostIOMMUDeviceClass {
      * Returns: true on success, false on failure.
      */
     bool (*get_pasid_info)(HostIOMMUDevice *hiod, PasidInfo *pasid_info);
+    /**
+     *  @support_ats: Returns true if ATS can be used by the device,
+     *  false if the host IOMMU reports it is unavailable.
+     *
+     *  @hiod: handle to the host IOMMU device
+     *
+     *  Returns: true if ATS is supported, false otherwise
+     */
+    bool (*support_ats)(HostIOMMUDevice *hiod);
 };
 
 /*
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 410b044370..7cc6767b4b 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -573,6 +573,13 @@ static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
     }
 }
 
+static bool hiod_iommufd_support_ats(HostIOMMUDevice *hiod)
+{
+    HostIOMMUDeviceCaps *caps = &hiod->caps;
+
+    return !(caps->hw_caps & IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED);
+}
+
 static bool hiod_iommufd_get_pasid_info(HostIOMMUDevice *hiod,
                                         PasidInfo *pasid_info)
 {
@@ -595,6 +602,7 @@ static void hiod_iommufd_class_init(ObjectClass *oc, const void *data)
 
     hiodc->get_cap = hiod_iommufd_get_cap;
     hiodc->get_pasid_info = hiod_iommufd_get_pasid_info;
+    hiodc->support_ats = hiod_iommufd_support_ats;
 };
 
 static const TypeInfo types[] = {
-- 
2.43.0


