Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9902AC021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 10:04:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmVJJ-0005dr-8j; Mon, 24 Feb 2025 05:03:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tmVJF-0005cc-Iv
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 05:03:33 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tmVJA-00048a-Ir
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 05:03:33 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z1bp81GxLz6M4lc;
 Mon, 24 Feb 2025 18:00:32 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
 by mail.maildlp.com (Postfix) with ESMTPS id 9C706140AE5;
 Mon, 24 Feb 2025 18:03:15 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500005.china.huawei.com (7.182.85.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Feb 2025 11:03:15 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Mon, 24 Feb 2025 11:03:15 +0100
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "kevin.tian@intel.com"
 <kevin.tian@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "chao.p.peng@intel.com" <chao.p.peng@intel.com>
Subject: RE: [PATCH rfcv2 01/20] backends/iommufd: Add helpers for
 invalidating user-managed HWPT
Thread-Topic: [PATCH rfcv2 01/20] backends/iommufd: Add helpers for
 invalidating user-managed HWPT
Thread-Index: AQHbgqf742Ulx+fvuEu1j4r+mL1bx7NWPHpw
Date: Mon, 24 Feb 2025 10:03:15 +0000
Message-ID: <9c47c785082b4c6c8751164de6481c08@huawei.com>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <20250219082228.3303163-2-zhenzhong.duan@intel.com>
In-Reply-To: <20250219082228.3303163-2-zhenzhong.duan@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.203.177.241]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
From:  Shameerali Kolothum Thodi via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Zhenzhong,

> -----Original Message-----
> From: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Sent: Wednesday, February 19, 2025 8:22 AM
> To: qemu-devel@nongnu.org
> Cc: alex.williamson@redhat.com; clg@redhat.com; eric.auger@redhat.com;
> mst@redhat.com; jasowang@redhat.com; peterx@redhat.com;
> jgg@nvidia.com; nicolinc@nvidia.com; Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>; joao.m.martins@oracle.com;
> clement.mathieu--drif@eviden.com; kevin.tian@intel.com;
> yi.l.liu@intel.com; chao.p.peng@intel.com; Zhenzhong Duan
> <zhenzhong.duan@intel.com>
> Subject: [PATCH rfcv2 01/20] backends/iommufd: Add helpers for
> invalidating user-managed HWPT
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  include/system/iommufd.h |  3 +++
>  backends/iommufd.c       | 30 ++++++++++++++++++++++++++++++
>  backends/trace-events    |  1 +
>  3 files changed, 34 insertions(+)
>=20
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index cbab75bfbf..5d02e9d148 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -61,6 +61,9 @@ bool
> iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t
> hwpt_id,
>                                        uint64_t iova, ram_addr_t size,
>                                        uint64_t page_size, uint64_t *data=
,
>                                        Error **errp);
> +int iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t
> hwpt_id,
> +                                     uint32_t data_type, uint32_t entry_=
len,
> +                                     uint32_t *entry_num, void *data_ptr=
);
>=20
>  #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD
> TYPE_HOST_IOMMU_DEVICE "-iommufd"
>  #endif
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index d57da44755..fc32aad5cb 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -311,6 +311,36 @@ bool
> iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>      return true;
>  }
>=20
> +int iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t
> hwpt_id,

Nit: As per struct iommu_hwpt_invalidate documentation this can be an ID of
Nested HWPT or vIOMMU.  May be better to rename this just to id.

Thanks,
Shameer

