Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273A3C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 21:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubQVx-0007oH-7G; Mon, 14 Jul 2025 17:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubOzy-00070Q-Ow; Mon, 14 Jul 2025 15:38:03 -0400
Received: from mail-bn7nam10on2062a.outbound.protection.outlook.com
 ([2a01:111:f403:2009::62a]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubOzu-0001e4-HQ; Mon, 14 Jul 2025 15:38:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJyg0BeGFGk+aXRZ+nwz1AkTAypTtmivfYnO9K2g2CszU7q858CbhoowBdzd8XnFEH+Cua1L067rqOIYXMx50zN2yvSOeuoW0JL8+WUJqrrPW5ldQn/QVnE/z0zGdzl2JVLckixM+Li4E6lJKLwEXqgLki91e9Z1gYIOMfyaaSX+dVgWvLs1C3xXn5Im6ciSNGDcUrZwgUcXS19eG3dr+YHiZXfUI46H2rnmSSSyvljeycht/xT318qtM6rd8Rr49V7jm2YoQgLePi+tWMcq6C7n+bZW6oB5gi+xZAvtbBE3gPTWgoD7PwOtd/WyY4mnoUL6JsymuYxvujQjiPTJdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2f8+jdKDg9LRrJHe5F2knbU4HkCX4W03WlMDoJpZLQ=;
 b=YUtTy+NWOfyFMn+RsS3RLny2YJHVZU9NE11FBNzeXzpIa+Yoa7bEyOZdKg6jcGJEnICFC+EF9TuaQMcBwGw31PuhOu8iejfmZVnWI++/BF2/KZ/ykPVGPA63Z/BG53R2XGW+aJzaVE8U/63R93noq6IPxZavl1p9qBknjtKZDe7ihTzFuzNLQlrIR4s7x5e53GpZKoUIeQTOJEhbeKhfBSw1qo0y3r2+6kAnAJgLZf8X1QlUsrmOKpj0hn22szfE+WnwpoPpBa+8EBmKeZZzPBoYbjDand8tFTOwO8WZJ0sb1sOMNJ4gsRYewb6D9vSIx+1ibZde+BeElKlJ1BMYig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2f8+jdKDg9LRrJHe5F2knbU4HkCX4W03WlMDoJpZLQ=;
 b=LtN67tFFO5pQVD0F6ygeOswrktlxZ6MTcJi9UXQhrz/Qiv4rnPpuYW618YLoWm6Oc/JqLFUt0siACq9pD7N13ai4v6N1YcF3PLp4PwZwZ0+G8wZ1GYYRcT8Qgj2Nhq3Qcb9cvm43KcsuOgEhpy0LhTHlwyk5MxF73r+gFcH6VE49kd+/2RERijzwikFsKVWFZuYS7N18MrpoYfcLUAxIGQl6f6GEUWs6Xe94LiCO2eRgAs7le6H80cCVApYQWuJ1ru/4A8b9kpp0r7hf2IjKTfvCiwR5VPlUBk1L63SlkGxrZhgh3zxnt5e07GPW+hVQx2E1y0LQc6oQI/wl7HCZSA==
Received: from BN9PR03CA0983.namprd03.prod.outlook.com (2603:10b6:408:109::28)
 by CH2PR12MB4086.namprd12.prod.outlook.com (2603:10b6:610:7c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Mon, 14 Jul
 2025 19:37:49 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:109:cafe::a4) by BN9PR03CA0983.outlook.office365.com
 (2603:10b6:408:109::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.32 via Frontend Transport; Mon,
 14 Jul 2025 19:37:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 19:37:48 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Jul
 2025 12:37:32 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 14 Jul
 2025 12:37:32 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 14 Jul 2025 12:37:31 -0700
Date: Mon, 14 Jul 2025 12:37:30 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>,
 <shameerkolothum@gmail.com>
Subject: Re: [RFC PATCH v3 09/15] hw/arm/smmuv3-accel: Support nested STE
 install/uninstall support
Message-ID: <aHVcespdg9+nq1/H@Asurada-Nvidia>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-10-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250714155941.22176-10-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|CH2PR12MB4086:EE_
X-MS-Office365-Filtering-Correlation-Id: 620ad2f3-3f07-478d-70be-08ddc30dea1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sc6uBPB3xM8e9yhskaqz0KIp32DVW3/KiDeI3teMsU82gc3xW4U4LbW76gID?=
 =?us-ascii?Q?Of5La4TnXQXb+Tj+TEnvFqRgozyYBw1Cxh78RgmW6WsYeJ3AnCIHmeyHPqfX?=
 =?us-ascii?Q?qQHp8xbi1D+ZT0LBDRrgg73S4yWigx/hghU9/8Z5jcxHTnQvcDacKB+FwPBx?=
 =?us-ascii?Q?IOwIryzP61bWfLVnOuoIFOG8bZcZavQkL0EdHSqboACGc8YtWCOxDaxEJhSz?=
 =?us-ascii?Q?P5xZBKKb5ygOdtEI0thjpCHJg0srvRn9yqwtSxTKcnznMrO9Fhaik7+WVPQV?=
 =?us-ascii?Q?dCEfbJbYY1snKzr2M7MmUdYvmgSIs1mIFUqowSj5WwIXEGzflOXrcozfjNq6?=
 =?us-ascii?Q?ioBH9y5MWBTb5H6ykdn2FWV0oY0pauiY2K7NWDkLjgFv49nZgWMjBaTmknfH?=
 =?us-ascii?Q?pWtbdrxr1vKaeI1lvydFLTs+MkjhFSjuXpd471wdxSc7W9GgOvuB6Ok+aUwE?=
 =?us-ascii?Q?vg/pje+rg7xqXmxMahyiKTpBL/3Z2DkhFWYZFOsWIqVcEDap7R0w1Jfffa69?=
 =?us-ascii?Q?v2VZhQltRoOT2/8NwJxMrhz24T01r9moC9bM6F2fTfPeH1ywCFMWvFAt/ZDR?=
 =?us-ascii?Q?rQ3Lre2fbtE4HwXM2USiHZEb8Rl+6PZ2kNGfsX9voZt/LYCVjjhwEUPzE9HY?=
 =?us-ascii?Q?kIGTo1fhASjQggqyyag42szCDrZnrKvBQ5asQE1qgpkTUQ6q+xc3wsxNTf+1?=
 =?us-ascii?Q?lMIjLkwVoYbFypuPYHxNSOs6n4Larfgg7MekWk3gxujMI+UMcfNXHS4AA5fE?=
 =?us-ascii?Q?7+vkmWYkIybCxem4clEhqoLaJpmD3rqf8ftrQ/kWwWke+0V5gUzXMsWlmNev?=
 =?us-ascii?Q?aoYt2mRXey+Za8jR16GSjLAvqMZzzm1HztV4ZAFqy/lpcTdgZNGeAB5gdJks?=
 =?us-ascii?Q?k1hEUYgBPU9376Ee1G/6ozqI5z8eEZNGPS3HnoDSMS1m9vnDVwRY3bipQVNL?=
 =?us-ascii?Q?Y5b9QDIwoqL6WJtobb3e98gaE7hEu+fk5mwlg9RAC8LL022RNhHpAIKCCHVW?=
 =?us-ascii?Q?mZqvgErsuQbMRlQoXrT5qaNVfZfYUGX3fxsXSbZIP+HOxYblynja7aKvgJJ1?=
 =?us-ascii?Q?fX0pNQJz+ASizYvIrZpLcldx3k3Z0qDZUk9vmzZIYJ/QYw5vUh1OtkgaKk2e?=
 =?us-ascii?Q?fe01xgA011OVD41UFyych4J/82aVkcpWStaJoWwwx7kDxCYx2blwRMUwOOdl?=
 =?us-ascii?Q?VvTKVm1z7AaCpKetkOOwecXssEuBgXwsheE5KB9kuiACb2HKTHS6icWVvaFA?=
 =?us-ascii?Q?hMdYKtt72xznXszLmAOlZMe68ukanUJSG1V2TT4ghZ7es0bzlCGLMo1JqPnK?=
 =?us-ascii?Q?GLqtaUHcT1+KLw1AZYVROg3e8njBTbcC8xOb07S8zgFzgUmKk4QAfOZUyh8V?=
 =?us-ascii?Q?0UkBxqBTVhr2Cw9PI5+oASQoTnNy6cWhu1duVQ5n3j4vTRtEYtHFBu8w9fJj?=
 =?us-ascii?Q?RXsSlqWbwqjR9Y0WmehZ6eK45YQTWKj2xh0a6L2lld4AN/Kz06tzHBbOOB4l?=
 =?us-ascii?Q?AJm26iukRqwuQrCkAmVvWm1EufiwJT8qPPnG?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 19:37:48.4582 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 620ad2f3-3f07-478d-70be-08ddc30dea1f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4086
Received-SPF: permerror client-ip=2a01:111:f403:2009::62a;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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

On Mon, Jul 14, 2025 at 04:59:35PM +0100, Shameer Kolothum wrote:
> +static int
> +smmuv3_accel_dev_install_nested_ste(SMMUv3AccelDevice *accel_dev,
> +                                    uint32_t data_type, uint32_t data_len,
> +                                    void *data)
> +{
> +    SMMUViommu *viommu = accel_dev->viommu;
> +    SMMUS1Hwpt *s1_hwpt = accel_dev->s1_hwpt;
> +    HostIOMMUDeviceIOMMUFD *idev = accel_dev->idev;
> +    uint32_t flags = 0;
> +
> +    if (!idev || !viommu) {
> +        return -ENOENT;
> +    }
> +
> +    if (s1_hwpt) {
> +        smmuv3_accel_dev_uninstall_nested_ste(accel_dev, true);
> +    }
> +
> +    s1_hwpt = g_new0(SMMUS1Hwpt, 1);
> +    s1_hwpt->iommufd = idev->iommufd;
> +    iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
> +                               viommu->core.viommu_id, flags, data_type,
> +                               data_len, data, &s1_hwpt->hwpt_id, &error_abort);

Let's check the return value.

> +    host_iommu_device_iommufd_attach_hwpt(idev, s1_hwpt->hwpt_id, &error_abort);
> +    accel_dev->s1_hwpt = s1_hwpt;
> +    return 0;
> +}
> +
> +void smmuv3_accel_install_nested_ste(SMMUState *bs, SMMUDevice *sdev, int sid)
> +{
> +    SMMUv3AccelDevice *accel_dev;
> +    SMMUEventInfo event = {.type = SMMU_EVT_NONE, .sid = sid,
> +                           .inval_ste_allowed = true};
> +    struct iommu_hwpt_arm_smmuv3 nested_data = {};
> +    uint32_t config;
> +    STE ste;
> +    int ret;
> +
> +    if (!bs->accel) {
> +        return;
> +    }
> +
> +    accel_dev = container_of(sdev, SMMUv3AccelDevice, sdev);
> +    if (!accel_dev->viommu) {
> +        return;
> +    }
> +
> +    ret = smmu_find_ste(sdev->smmu, sid, &ste, &event);
> +    if (ret) {
> +        error_report("failed to find STE for sid 0x%x", sid);
> +        return;
> +    }
> +
> +    config = STE_CONFIG(&ste);
> +    if (!STE_VALID(&ste) || !STE_CFG_S1_ENABLED(config)) {
> +        smmuv3_accel_dev_uninstall_nested_ste(accel_dev, STE_CFG_ABORT(config));
> +        smmuv3_flush_config(sdev);
> +        return;
> +    }
> +
> +    nested_data.ste[0] = (uint64_t)ste.word[0] | (uint64_t)ste.word[1] << 32;
> +    nested_data.ste[1] = (uint64_t)ste.word[2] | (uint64_t)ste.word[3] << 32;
> +    /* V | CONFIG | S1FMT | S1CTXPTR | S1CDMAX */
> +    nested_data.ste[0] &= 0xf80fffffffffffffULL;
> +    /* S1DSS | S1CIR | S1COR | S1CSH | S1STALLD | EATS */
> +    nested_data.ste[1] &= 0x380000ffULL;

Likely we need to make sure that values here are little endians, in
alignment with the kernel uABI.

> +    ret = smmuv3_accel_dev_install_nested_ste(accel_dev,
> +                                              IOMMU_HWPT_DATA_ARM_SMMUV3,
> +                                              sizeof(nested_data),
> +                                              &nested_data);
> +    if (ret) {
> +        error_report("Unable to install nested STE=%16LX:%16LX, sid=0x%x,"
> +                      "ret=%d", nested_data.ste[1], nested_data.ste[0],
> +                      sid, ret);
> +    }
> +
> +    trace_smmuv3_accel_install_nested_ste(sid, nested_data.ste[1],
> +                                          nested_data.ste[0]);
> +}
> +
> +static void
> +smmuv3_accel_ste_range(gpointer key, gpointer value, gpointer user_data)
> +{
> +    SMMUDevice *sdev = (SMMUDevice *)key;
> +    uint32_t sid = smmu_get_sid(sdev);
> +    SMMUSIDRange *sid_range = (SMMUSIDRange *)user_data;
> +
> +    if (sid >= sid_range->start && sid <= sid_range->end) {
> +        SMMUv3State *s = sdev->smmu;
> +        SMMUState *bs = &s->smmu_state;

Can we use ARM_SMMU and ARM_SMMUV3 macros?

> +
> +        smmuv3_accel_install_nested_ste(bs, sdev, sid);
> +    }
> +}
> +
> +void
> +smmuv3_accel_install_nested_ste_range(SMMUState *bs, SMMUSIDRange *range)

Fits in one line.

>  typedef struct SMMUv3AccelDevice {
>      SMMUDevice  sdev;
>      AddressSpace as_sysmem;
>      HostIOMMUDeviceIOMMUFD *idev;
> +    SMMUS1Hwpt  *s1_hwpt;

No need of an extra space.

>      SMMUViommu *viommu;
>      QLIST_ENTRY(SMMUv3AccelDevice) next;
>  } SMMUv3AccelDevice;
> @@ -45,10 +51,21 @@ typedef struct SMMUv3AccelState {
>  
>  #if defined(CONFIG_ARM_SMMUV3) && defined(CONFIG_IOMMUFD)
>  void smmuv3_accel_init(SMMUv3State *s);
> +void smmuv3_accel_install_nested_ste(SMMUState *bs, SMMUDevice *sdev, int sid);
> +void smmuv3_accel_install_nested_ste_range(SMMUState *bs,
> +                                           SMMUSIDRange *range);

Fits in one line.

> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index b6b7399347..738061c6ad 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -547,6 +547,10 @@ typedef struct CD {
>      uint32_t word[16];
>  } CD;
>  
> +int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
> +                  SMMUEventInfo *event);

Ditto

> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 2f5a8157dd..c94bfe6564 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -630,8 +630,8 @@ bad_ste:
>   * Supports linear and 2-level stream table
>   * Return 0 on success, -EINVAL otherwise
>   */
> -static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
> -                         SMMUEventInfo *event)
> +int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
> +                  SMMUEventInfo *event)

Ditto

Thanks
Nicolin

