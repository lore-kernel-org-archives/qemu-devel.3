Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC30CD98D7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 01:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXqwK-0002IE-1E; Thu, 11 Jun 2026 21:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wXqwI-0002Hm-3X
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 21:44:06 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wXqwG-0003ME-Lc
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 21:44:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQPvkMd4zIdEF4gQc/fQmqvJsHAbtp/L0d55c0r7a/5EwTcfm1+m8maDYIVjQYWA5KbUbd2hdC3mUmh/iLq2XgtPZ/9503JItifPs7Tc1COG4u8b34zQUmUXRAs3NcghZ8bHcuRuOVIZEuLRTNnmKKRj0kri1DkOqNFILQR/lJP1uDfgjH2bJeXkuV/EbvWmd8pX7vHiYlVzedNyzydSUlG7dDFvqEUM57fgec0+3nul9M9LNF5kggWj0q64SXp//8etkPw8NWZgYIMqYfeLRz0vNDaNqZpd/OfpgnbNStS/wqMh2RHRzAhQSMMvwrCKy0ZGc4NpIfnx5nktWS1Ruw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKryc+jsgfpIDiA5cPuqP51BVac8+RZwx4DSGCM7gIw=;
 b=aMrqiKWeiAy+oagudV/XvjMZfFbgDwA6g0ISabseHqHhaSlQJFSjU+e9KJFJS8uNxH+vYmzmYeQ49+BTYK9kgZ3Ne7qBWpb5nFoBLx7TSM8cfWubxrgRjggyb+Ui6ksYjn1vmzc/Xz3146KnTLTwWoe8OEVEeNjUwAJM4TPSC8hQX3w/QgmFOHUykmNvo/f1l+OdgROQhWtf1qGKMi2r6oUewd5CLZSwH0alqoxVJIrunlqf0GHKDTd4iQfuIOGEsSceVPGycr89Pc1L9//HIII94rVKlUXzZ2gTv60egxUtYboXp8uefUAFA5j5yXvr4vQowbA2Hpx/xeI6ptOEFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKryc+jsgfpIDiA5cPuqP51BVac8+RZwx4DSGCM7gIw=;
 b=EQQ3WfKSCiYPgqViyKQNM0RXHbeoee+zQd9Ezcadu6wrim6glsWHX0qAFcH/h8z+pYbbtvMfvnNgS98tpjiKklzF3s7fUFxYghOa979BI1RZgC0JjcqT0Yh57acdDSIGTOmewxMlONCdLVITF2mB6zYw5JIiiUUqXzs7ti7FpH/nVYFEL4gc1gg9FYRDc7CGpoDJNq78YZbRkBy5faVm2GsK0VCvzqxFMc093B7I0Sc5zxKymf+tzr2xTvDkoyjzoSVSoxzuXjlCjb624Ep5XLs8kHPzBHhky8l8AhwWkkeskSPypwg04rzZldAYiCmxeKwQOTpTiPDgRWn6lTLfBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5377.namprd12.prod.outlook.com (2603:10b6:208:31f::21)
 by DS4PR12MB9746.namprd12.prod.outlook.com (2603:10b6:8:2a4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 01:43:28 +0000
Received: from BL1PR12MB5377.namprd12.prod.outlook.com
 ([fe80::6432:69b9:5b85:d190]) by BL1PR12MB5377.namprd12.prod.outlook.com
 ([fe80::6432:69b9:5b85:d190%6]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 01:43:28 +0000
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
Subject: [PATCH 1/3] iommufd: Introduce handler for device ATS support
Date: Thu, 11 Jun 2026 18:43:20 -0700
Message-ID: <20260612014322.2918836-2-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612014322.2918836-1-nathanc@nvidia.com>
References: <20260612014322.2918836-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0277.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::12) To BL1PR12MB5377.namprd12.prod.outlook.com
 (2603:10b6:208:31f::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5377:EE_|DS4PR12MB9746:EE_
X-MS-Office365-Filtering-Correlation-Id: 21919394-c148-4cbc-8e92-08dec82400a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: xymWQj1RssprKOj+kRrc8e5Wgt6+skkMrd48tFKpIuy+nW0e8xJQ/w3UcY4it6n8tFIMmD05KVAB8PHgtDYZ+U+sNzX5JhtfxUYBnLf/juqF842xhKalat4Yjy2rMipir4kziLKZp+OjhcvjykkzeSlLF2nRGDjl81pqT3zX2JT50BJAqnUCvLlpWpYIX6XDkvoZkw7S8iAHWMF+d9HOk/B+4KivvWavrRa1sDfIUi0as9PGNhWzw8CRhcv6tesF3B1bSzrElcA7ZCHBPiB9B1to4nbzY573/gZNd65zk3jXW2Ua0bIkLR2GNR+MZ02yf/I5NOWxN0AAgmLqf7Yvy5y6fsu82vMAoh8Bz48ECd/i0y2SsEd7pWK+hJf/x3xHVwDR6oX/nFZ71H/0VXSn8O8CYVJ8sYXex5UdC9GAAaigrs3rqXx3tI+59FDdht0LzyIiADGuEvShdWbETTBlIQRjdAD0WV5UbOwi67JttphW7r80nNvZeheJsK53we8W3PEpumi5MmN5MgR1bHJsuBt3O54YnCpfZOzyjG1y8QQi/ZSZDkAReeIUr3J7F0tKABsocNpqcq3X8cSENmHUTfrZQgZh+4qKL3oBjH+7JkL+Hko1vGM2sTE0Hrtsngkk3enYa72ww8QvdassrVthdsk+37bVe+aaSlKKSfOBzuaLBfuLJz0RWDXNOo//eGck
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5377.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WZYTIGpX+9lwyXaPoVXalG9SC1+WIneCBsn/yowESoJSw/eFQw8fMSF6rT7g?=
 =?us-ascii?Q?Y7I7SusxZS6VvgCsohbUuGG6MNaTHLJGXeBowLmP/lRQSICJscEpgIdO2bh7?=
 =?us-ascii?Q?o+9IKRfjfSpbCPCnYFAR2FVhhEtK5DF3hGip56RHqvwVsK1ESGY1OWCHt+Km?=
 =?us-ascii?Q?pwZO2MCuakbIaXpzgAUwo2CTLGsv07YuG5X4rU1RZxYcUwTde4CkUlqiRTXn?=
 =?us-ascii?Q?HVKCsCzkx91B5xQJXYqni+emw9LpqDOl3m7F3BdrXr+AcCdxOkGjoNke7m9t?=
 =?us-ascii?Q?SJOo8v+OJWiPaiKVtN8HYisX2kRV5DZujBbqnSFQK+cOhnkvxoe8Z8IFnu0X?=
 =?us-ascii?Q?vKJBmkA4gzWCppYw8h3JMzC5ds1/yXb89nf9g7NepixZXbe179La5aa8OdhO?=
 =?us-ascii?Q?YEegwhaixyQtlKPtv2x/u4BWTLRYQyerRZfv6J+cpPHKn7QzxHfo2qG3qVvu?=
 =?us-ascii?Q?Nvx74vXkUs2yG/WlU2wqZ5BSc3jb9GnKcHEvZjVXSrNVx4A7s5kSihLv+i4g?=
 =?us-ascii?Q?OfSZOlnu4eA9Y14sYsmE1W/lFxg3u9BXRder4loCzvw5AUur1ScMoFKiV4uE?=
 =?us-ascii?Q?ThgpSCZMjrCB0wJUQ0Gqs/RTUNviMrL0MRmo9UOHboH42wBNNa6MJSoXw/0w?=
 =?us-ascii?Q?YOylVVM2+/wj8zOOe5nF4xYW9qf6dEpwEyDMk/Mr/nXLc2hbmKVJgbPfgMVs?=
 =?us-ascii?Q?gbNuQ6WR4XpxLPyQYb296FFiTrL+NRuwVxCeIxbBlfSGWaKkUeZRGd4TeZrH?=
 =?us-ascii?Q?T81WFoKFGkBEZsXFHHU1vpTb2EVShhzcR34DMH26xjGH9DkswWPrEdn1mcbc?=
 =?us-ascii?Q?6p3gCr7DnUMGxPy758b+8J2rCeAdhsYzLp0HEPmywa4LBVIVTvshkLYt+CWb?=
 =?us-ascii?Q?M9IUUg+Cv8Yy0KYkRHK1fYRAcTggIH4ObXutuy0P02A4uTXdXqzqcfczxMwy?=
 =?us-ascii?Q?tmZNq/Izru2Zd6/5aJaaTYMAhGZWjM1k3zXcJNfzqdmEPqpb/2pAxkLiN3KN?=
 =?us-ascii?Q?1pNkTwRWYvr+asslND9we6qK/L17CWS405leSbI+LPUSFjREU1r1/eScIyJ2?=
 =?us-ascii?Q?GSFTY46nOWDrr82tdC8s812yqI3sXG1iUuTRtflamaX4Xor3g5hW8jkmfmQq?=
 =?us-ascii?Q?9xSArsAF4KH2GjehvDu5FEtvumLJbzWg2WVRNn1VYt4HHTJ27fDEH+f50wKk?=
 =?us-ascii?Q?XXb4D/hVhRo3YHwsyE2FjTHrhNsxGGYu/pyyrMv9rbjAe7Ha/Agmr288sZl0?=
 =?us-ascii?Q?pFpV4BZpr6o1JOGScTnOeRSo+7h73k6ZxynoIe1z2ml7BEk49Md+16hGoZBW?=
 =?us-ascii?Q?2y3KD9vZoCfyL0thIKnwrA2lVSRpi9svyNABL0czcYnok8OM+EDmO07znidf?=
 =?us-ascii?Q?5L72Pv540+wsVFRwl14MxHf1z8Dr54vssZ5VfMrDcfbAdw1C3CeEp/3k+d2f?=
 =?us-ascii?Q?G7O/7c/nfKqmMhfVySO8dVhMGH+ngjJ8rHBIk3d4Ja8wp9tBjM98CH2BJXfx?=
 =?us-ascii?Q?nthesV17NT0mJp+962LzaU6c9GzstZkT25Y1w2MRMAzilt9U4Pp4wZgnbBn/?=
 =?us-ascii?Q?v462VWrtRQ4L9UUKpk4YWfAy45PAh7lGpYrHkmYohXI0QFkVHBS5UynBXOPL?=
 =?us-ascii?Q?fVvzXVoAUPehcU/jC1e4Oypt4d8nzWKCT+6ItONODswlOcllJH6d2zGfR8/g?=
 =?us-ascii?Q?eaP3wZOGZ4bXODI+kf1bYse34Wxs801jyUXPlVqtPvY0XCrSWNy2qvvzkSKQ?=
 =?us-ascii?Q?DhJFBjRVVg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21919394-c148-4cbc-8e92-08dec82400a1
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5377.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 01:43:28.9004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tVJHmmp9AqJV2Fve1E6CiJSlxGwcOzD5Y2iDMEogHQ1niLE9XpHj+SFheQ0RLdKVquVtbIDbKqP2W+P2mEtEJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9746
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
 include/system/host_iommu_device.h | 10 ++++++++++
 backends/iommufd.c                 |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
index f000301583..5615d6cb57 100644
--- a/include/system/host_iommu_device.h
+++ b/include/system/host_iommu_device.h
@@ -133,6 +133,16 @@ struct HostIOMMUDeviceClass {
      * Returns: true on success, false on failure.
      */
     bool (*get_pasid_info)(HostIOMMUDevice *hiod, PasidInfo *pasid_info);
+    /**
+     *  @support_ats: Return whether ATS is supported for the device
+     *  associated with @hiod host IOMMU device, checking if the
+     *  IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED capability bit is set.
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


