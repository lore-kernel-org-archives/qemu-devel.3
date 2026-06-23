Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE93ACDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 02:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbqzX-0004iO-D2; Mon, 22 Jun 2026 22:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wbqzV-0004iC-Gn
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 22:35:57 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wbqzU-0006Pg-04
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 22:35:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHGl5xpiectOi1fYmjzkUu3LNdvElfxE0MlxT4ZFyTsvJN1VHKGjgimfDcpjlFMhF+2EKD1hfYIqZma7NoNSkyxWZU0/63WX6dz/o3t6M00yunFPpph9Vs8Vn49wZ6LhcIczvdNmymDwaYbjfHJOq1fqL6xP9sV8ctpD6grCvsmkdBrZWE48wW3/mDffkDvyNZmPl3WsjTzi/KphlZJZQzqFJ82u50hv2vDeoY1O36KTGB6lPAeInFhI86dNqoHawJYwxLcgDhohbWjOxRsEjTS7GrGiPbRd0iczfyZfCDPlJJh4ogEDu2p64KCVbfSEQ5Qe4NJiDCblHp+bpf5Ckw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsW+C+d3VjxHPKKBB45H2zerwO1GO0oco8TnEcRFEok=;
 b=NVN4m81csRZ4wbnPOHn3Z7U81lOYkfVuG5/YozqZIDL9ZQYS0EZEpUbsYFHf/P78Hxm1Q/OA9B0MC/Fp9bnpLCSaLAsHSTgUQrEHB4b92WURPBWNavNqrHW+IQT5ou0aMEo1d7gozMla18lTrc1f+sU0qvdoKzeGD3gk1ryjNsbaITVEhgZBTIqBi4lGN/1ETsWln0tAhtmj45cZgqP4UMzsnofjbOgCgBo5AvVqXDWRQmQ4JlolLu/9zMNVzUmlcrRmY5jdC/F6ZLHbFsVVMxa49UF6iYoeC7PNe0VfQCtdmt6b9NO+2MLdNMu0aXf4KYje6YRDaoFFLb9dZmjqQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsW+C+d3VjxHPKKBB45H2zerwO1GO0oco8TnEcRFEok=;
 b=mhc7K9ZM+LpXzMHGEcUiLWgQbvcl/y2ckFVivmdtnmoeU4iC/7QP8pU+HMJrfBgMAqMiXGdXQtterqZZq/hC4oGFoeqs++zLkdKwA8rFAORzhe1KznJiOwgK4dWfHAm4nT+p82gzBgdB7U0G/HHnUf+EJqDBbLsko9Nfdtt+v3cxPFGr87e3EuzLT3QJh1WkrC6PpVbizA/uAEOueoFySPkkZz8A3Ggqzlw8fnYWGmuTbxsLDjtAlC6h/sr/WSvDrlz+U68quOZEdIGh44qi412S7LTX+5f8/t3p3HKJIeOeDPdNGxy75ZgK5c4FdsdxcPHzYSnai/lQnWuHbDbouA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15)
 by MN0PR12MB6077.namprd12.prod.outlook.com (2603:10b6:208:3cb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 23 Jun
 2026 02:35:50 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 02:35:50 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v3 1/2] iommufd: Introduce handler for device ATS support
Date: Mon, 22 Jun 2026 19:35:39 -0700
Message-ID: <20260623023540.836825-2-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260623023540.836825-1-nathanc@nvidia.com>
References: <20260623023540.836825-1-nathanc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0220.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::15) To DM4PR12MB5390.namprd12.prod.outlook.com
 (2603:10b6:5:389::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5390:EE_|MN0PR12MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: b26fb7fe-26fb-4519-b1d6-08ded0d0238f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: xjhITS42oKQWZU2RiJCcBFhSz/9xLwnAOMPjGGjj6J7CxhR7uJrMp/i/6gMp5LX7w+iYpfYoYrxpFpDsvswkCv0JWtDx53EmEXEmw1gnf3UuWiTZi/yuCr0Lhj3ipJ+Mg1cEuSgg6R+vdqweTpToxmY0YmRI/dbV8XoCU/+0glfaCOxEZYHFTfq8lnfXnmv8akZJYp6UDfi7SEJoxihbTSWo5Z4UkzG8HRAOK4Q7sr/Lg7c5eJlPY/jv3ytzO9GCZmBQfKHgn1mfeRN3JxG2uF9prGKQO0yyp9FNxfr9B7/fZyACWQpHNPjQyxZPZrwIn+fju7Q1dzq56+SrLEuAbvaMjxv3DtYs1yzx5XuBWXnb6RsiHk1DOvAcy+zxKTanNB6UDMG77B/dRlP2TKGVbTZprtTNUhtEooTM2wg9+Q5bn+wf6+mxz2NAc98kRSNaBf7rX+JQIs0aMt497Tc09Ueg1FlWAD8LVnUjscpwDxNL0ig2Ah8jYhg9GlSxRlUZ9ppPsqrSSlD6BChFtOaFdlx8eUy7/dLvlGYz4sUNZKhihcWEWTLtpis/Dh/GfZpd15jyhdz3xRtu/Mq4m7f42MIJ3Jzb8pcSpAAQhmERXb2XeLEBE7d9kbPeD9W11zzS6L8bDU/wzjSWgiQLFqXHezYjmIHrQjxDcXWiCZi0Qnw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5390.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZU02NS9VRWVsR3ZrV3VkeXJHT1B4YWlpUUFCbjIxQjUvN2ZYV0FJZFhYZG9D?=
 =?utf-8?B?bG9qaCtCREN5OE9UalFMMWFKRGdWQzF0QVdzZW1uZlRBeldIdi9QbU5sdFUz?=
 =?utf-8?B?VDdSeTVOaXdRWlVicG5iYTE1TjEwa0RuL0pSUnd0L2dvSWhHWXFETzdFcGxX?=
 =?utf-8?B?Q0ZXMWcwa1hBV0xQdXR5T3VmbWMvbXBMS2FodkI5VGFxTFl2WnMzUzBYdnVF?=
 =?utf-8?B?SEVDZ0NjU3NtRDBybkVSb3FMY0ZTbW5XZ1ZHYk50dzJyMnQybmRlWVVwRExp?=
 =?utf-8?B?MitWb0x4Vm9lQklhYkh6dzVaUDU3Wk9KK2lyVGwyZzF2TysraUFTUmZVb1lT?=
 =?utf-8?B?dC92c1FMMEJZN2tScTdFOVhzVzA5Tk1WRHlkeWIzUEI1YU1tbng1WE1sZGJy?=
 =?utf-8?B?aEdKVXBTT2xFUkh5aTllYmJpVDU1VHBjc2NnZ1k3L05RVjZ2RFBsMnl2R0I4?=
 =?utf-8?B?VGorWjdMR2N4VUVMeHY2UGFrL29lT2xINzdPM016ZjNUZVUxWDdmVzJ0c3ov?=
 =?utf-8?B?S2FDT2taQW1SMjEvcSs0Z3djKzl4MmkrMm5aenRNSmNHK0JxOHVjcC9LY1Fa?=
 =?utf-8?B?VldCZ25CM0hIUGdkRzVJZEt1T0EvVjFIZ09ua3Y0Y1RLQ0NOZTdMS0ZvSVlN?=
 =?utf-8?B?VE9tbThoVG5Hd2FhdGpJU0FoTFBuOUJPVFBmZ2U3eWtEcmtQUS9KcktsU0ZO?=
 =?utf-8?B?UWh5NzhmSzhyQ1YvQUJVWVdDWjkrVVI1aXBnU0wwdlJiVFcxTitGczRlYzhR?=
 =?utf-8?B?WUt1dzRuVW9aemNPeFhNd285amJXN2NEYTNieE9qdVFqVVVYRmRDYUtZZWJ1?=
 =?utf-8?B?KzdBMytvRCtPMW9QMTdVbGdxRHk1OWVLay9UOUt1eU8rT0NVZHpyMWhpbk9l?=
 =?utf-8?B?MDlEY3hJd0FKdlJGZGtTVVNaSWJNQ0hxSk5NaFI2dmEzMlpMZVhoTU1nbmZ5?=
 =?utf-8?B?RC9TZ1dVYUl0ZWNtUFBCS1dUYVVvVFRadnBiQmFpR0g5WGpXMnpTNlBSenF6?=
 =?utf-8?B?TDl3NnNLOFpJNDRWbVhJSkh0dmZCeTJ6NnNGVVlxaUd3d0RGdGduMFhCSHJH?=
 =?utf-8?B?dDFKRVhyL2RncG9tZTBPVFo1R3NRRzVGZGhOa2RiQTB5YTdYWHFZaHBUMlBC?=
 =?utf-8?B?WkZFVmRudHV0azRrK3UxcWtSMHFHRW9vdHRLdERWa0toZ1p1VHJTNzNveFFq?=
 =?utf-8?B?c2IxWFRJbVZYUEUwakczWDlXV1BqR3U2Y2FJY1h5enZIM3ZVN1M2aFR5Z25W?=
 =?utf-8?B?akMxT2hmZUpIRGdnSGg5VERiUUZVVkYyVmludXBwNGFOMDNpWGtiTTNwZDVR?=
 =?utf-8?B?MjdZaFRzS2RtNmJjNHZRNUI5a21ldGxiNExvSFE2anJRSjcyOVB3a2x4V3NS?=
 =?utf-8?B?Y2dUcEdkOXFmd2NUaXZOUDY5MUN1SzIzcFpXTjRZOElNQmlNZ0lEcVNqNXNQ?=
 =?utf-8?B?b0g3YTlTTTVMdGc0eTBOa2NsNDlybTIwYnBKWFR4U1JoallYQndQS1FQR3JI?=
 =?utf-8?B?NHFSU2ljRytPTjEzWWh5bVJqY1J2VUtqTHRudUE2enhycDRWRzlXbkh6QzZz?=
 =?utf-8?B?dUhyTHZ0U3RNeTAxc1pHUkF6MnViT01CUkRYclhncTFrb0RKcDJSOGRuUldm?=
 =?utf-8?B?ZFkwVitER0dyb0dtUzdyZnBtMlFVT1VYdmFESjdnVUdzdmx2WXhaeUdkSXdR?=
 =?utf-8?B?a0puSW5BVzdzMWhYQXNyQXp1clU1MXdQQmgxd0N3V0pZalJXdGNQR0g5QmFa?=
 =?utf-8?B?SHN2ZVhxNmdlakF1TktsUEgrUTVRaWRreU5GaC9tMjdMR2piZGpBQUcwZ2Nx?=
 =?utf-8?B?V3Q2aHVCcWgzZWZYUEcrZWxVMC9Ed2pERW5NdldnVisvbWVjWUpFeHNLSGJp?=
 =?utf-8?B?NXdlcm5IUXozWnZ6cWxjU2FhUnNNSHNhdlN0ZkxZTVo2Q1V4eWFEVlhhT2pT?=
 =?utf-8?B?aVRNVFBRSy9aWi9sSDVZcGk5NmtZR1ZGN3o2NndNRE1JSE1TMnE1N0FWRFBU?=
 =?utf-8?B?YzJEZzkrQk0rTU9FREVEbzRmQW51NGd3enMzcFpocnpWdmFaUjlqcy9IUDAv?=
 =?utf-8?B?dlhRa2hkYm10VFcrWC9CV2drdzFXT3kyaE51UVVxaEcvdTRYWDhOSnJoc3hE?=
 =?utf-8?B?VVJGN2ZmanhXOWZHbjdrbEt3MXdncUt3K0hlZzBPQ0IvUGdLejlVbTBaUlBN?=
 =?utf-8?B?WUkvMkRrdStieGZlQ2FQMk1XSWlhT3FFd2MxNk9kcnFWWmdTWmMyNWZWVTJI?=
 =?utf-8?B?WFJhV2tlS0VobW04RXU5K3g2Qjg4dldJZkF1NDJhRkpoWkNWK0JWQU85STRj?=
 =?utf-8?B?NmNsVnd4L1EyNHgvZ0hTcmJ4bFdUbFVvSXMvc1lITE5hMUFSbjdMZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b26fb7fe-26fb-4519-b1d6-08ded0d0238f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 02:35:50.2447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FPACnySiDNY2xH33Czc+WZ3ByNI0Cs6XwYE0YWBoluNJ9Wr2ea+o4GUFEKv4YBfc0MXkZB2IUgzn7apajTAYWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6077
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=nathanc@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
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
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
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
index 09624cd652..4b40aaebe6 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -638,6 +638,13 @@ static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
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
@@ -660,6 +667,7 @@ static void hiod_iommufd_class_init(ObjectClass *oc, const void *data)
 
     hiodc->get_cap = hiod_iommufd_get_cap;
     hiodc->get_pasid_info = hiod_iommufd_get_pasid_info;
+    hiodc->support_ats = hiod_iommufd_support_ats;
 };
 
 static const TypeInfo types[] = {
-- 
2.43.0


