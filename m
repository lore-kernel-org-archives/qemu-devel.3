Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF53C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 16:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSga5-0008AG-3Z; Wed, 24 Jan 2024 11:58:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rSga1-00089r-JX
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 11:58:26 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rSgZz-0007rF-Di
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 11:58:25 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TKqnw3CR7z6J9jy;
 Thu, 25 Jan 2024 00:55:16 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id D70131400D3;
 Thu, 25 Jan 2024 00:58:16 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Jan
 2024 16:58:16 +0000
Date: Wed, 24 Jan 2024 16:58:15 +0000
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <ira.weiny@intel.com>, <dan.j.williams@intel.com>,
 <a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>, 
 <nifan@outlook.com>, <jim.harris@samsung.com>, "Fan Ni" <fan.ni@samsung.com>
Subject: Re: [PATCH v3 9/9] hw/mem/cxl_type3: Add dpa range validation for
 accesses to dc regions
Message-ID: <20240124165815.00007e46@Huawei.com>
In-Reply-To: <20231107180907.553451-10-nifan.cxl@gmail.com>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
 <20231107180907.553451-10-nifan.cxl@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue,  7 Nov 2023 10:07:13 -0800
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
>=20
> Not all dpa range in the dc regions is valid to access until an extent
DPA ... DC etc

> covering the range has been added. Add a bitmap for each region to
> record whether a dc block in the region has been backed by dc extent.
> For the bitmap, a bit in the bitmap represents a dc block. When a dc
> extent is added, all the bits of the blocks in the extent will be set,
> which will be cleared when the extent is released.
>=20
> Signed-off-by: Fan Ni <fan.ni@samsung.com>

Hi Fan, one query inline and a few comments.

Jonathan

>=20
> --
> JC changes:
> - Rebase on what will be next gitlab.com/jic23/qemu CXL staging tree.
> - Drop unnecessary handling of failed bitmap allocations. In common with
>   most QEMU allocations they fail hard anyway.
> - Use previously factored out cxl_find_region() helper
> - Minor editorial stuff in comments such as spec version references
>   according to the standard form I'm trying to push through the code.
> Picked up J=F8rgen's fix:
> https://lore.kernel.org/qemu-devel/d0d7ca1d-81bc-19b3-4904-d60046ded844@w=
dc.com/T/#u
> ---
>  hw/cxl/cxl-mailbox-utils.c  | 31 +++++++++------
>  hw/mem/cxl_type3.c          | 78 +++++++++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_device.h | 15 +++++--
>  3 files changed, 109 insertions(+), 15 deletions(-)
>=20
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 8e6a98753a..6be92fb5ba 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -1401,10 +1401,9 @@ CXLDCDRegion *cxl_find_dc_region(CXLType3Dev *ct3d=
, uint64_t dpa, uint64_t len)
>  }
> =20
>  void cxl_insert_extent_to_extent_list(CXLDCDExtentList *list,
> -                                             uint64_t dpa,
> -                                             uint64_t len,
> -                                             uint8_t *tag,
> -                                             uint16_t shared_seq)
> +                                      uint64_t dpa, uint64_t len,
> +                                      uint8_t *tag,
> +                                      uint16_t shared_seq)

avoid noisy whitespace changes like this.


> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 43cea3d818..4ec65a751a 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c

> +/*
> + * Check whether a DPA range [dpa, dpa + len) has been backed with DC ex=
tents.
> + * Used when validating read/write to dc regions
> + */
> +bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
> +                                  uint64_t len)
> +{
> +    CXLDCDRegion *region;
> +    uint64_t nbits;
> +    long nr;
> +
> +    region =3D cxl_find_dc_region(ct3d, dpa, len);
> +    if (!region) {
> +        return false;
> +    }
> +
> +    nr =3D (dpa - region->base) / region->block_size;
> +    nbits =3D DIV_ROUND_UP(len, region->block_size);
> +    return find_next_zero_bit(region->blk_bitmap, nr + nbits, nr) =3D=3D=
 nr + nbits;
I'm not sure how this works... Is it taking a size or an end point?

Linux equivalent takes size, so I'd expect

    return find_next_zero_bit(region->blk_bitmap, nbits, nr);
Perhaps a comment would avoid any future confusion on this.

> +}
> +
> +/*
> + * Mark the DPA range [dpa, dap + len) to be unbacked and inaccessible. =
This
> + * happens when a dc extent is return by the host.
> + */
> +void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
> +                                   uint64_t len)
> +{
> +    CXLDCDRegion *region;
> +    uint64_t nbits;
> +    long nr;
> +
> +    region =3D cxl_find_dc_region(ct3d, dpa, len);
> +    if (!region) {
> +        return;
> +    }
> +
> +    nr =3D (dpa - region->base) / region->block_size;
> +    nbits =3D len / region->block_size;
> +    bitmap_clear(region->blk_bitmap, nr, nbits);
> +}
> +


