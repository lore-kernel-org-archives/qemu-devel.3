Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E42C4828F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 21:06:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWjgO-0006Rd-4n; Sun, 04 Feb 2024 16:05:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <j.granados@samsung.com>)
 id 1rWjgL-0006Os-9R
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:05:41 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <j.granados@samsung.com>)
 id 1rWjgI-0006ZV-BS
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:05:41 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20240204210528euoutp01f3d0a7a127f539df03606cc9d41dce4d~wxOC0f4D_2274722747euoutp01y;
 Sun,  4 Feb 2024 21:05:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20240204210528euoutp01f3d0a7a127f539df03606cc9d41dce4d~wxOC0f4D_2274722747euoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1707080728;
 bh=PazXnPOtn4VGM9aNtaeuVnKux77yDa9bjwgj1wTWalo=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=XJGvI1l6E0Ft4a8zy85oW1xavd8UBH47O4S3ptEQZ0ay8+OHEaGdA20Snwogj8E0v
 WF7gNiP9n3WZtL8Dd+S+E9g7bNLZcMVEbJjgr5pgnczblCMV6qd9H0xeyTD8SC+O7g
 Tmntit9JfErSnqPIcYkHI+XJVQWtaLxWeUz/d9Qs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20240204210527eucas1p2c3dcae4c62a405f85b6d3dcb312dc60d~wxOCUdFZb1758517585eucas1p28;
 Sun,  4 Feb 2024 21:05:27 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 22.D8.09814.71CFFB56; Sun,  4
 Feb 2024 21:05:27 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20240204210526eucas1p1d0812ae575dc28577afaee1224fd4f9b~wxOBpz4ep2535225352eucas1p1E;
 Sun,  4 Feb 2024 21:05:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240204210526eusmtrp198ce926de78579e951936ad631924e79~wxOBkYyrE1314513145eusmtrp1D;
 Sun,  4 Feb 2024 21:05:26 +0000 (GMT)
X-AuditID: cbfec7f4-727ff70000002656-ba-65bffc170bf0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id A3.E2.10702.61CFFB56; Sun,  4
 Feb 2024 21:05:26 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20240204210526eusmtip2386c474d056ea3c3e412bc1888af0ba2~wxOBX_BdU0699206992eusmtip2C;
 Sun,  4 Feb 2024 21:05:26 +0000 (GMT)
Received: from localhost (106.210.248.184) by CAMSVWEXC02.scsc.local
 (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Sun, 4 Feb 2024 21:05:25 +0000
Date: Sun, 4 Feb 2024 22:05:22 +0100
From: Joel Granados <j.granados@samsung.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>,
 <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <peterx@redhat.com>, <jasowang@redhat.com>, <mst@redhat.com>,
 <jgg@nvidia.com>, <nicolinc@nvidia.com>, <joao.m.martins@oracle.com>,
 <kevin.tian@intel.com>, <yi.y.sun@intel.com>, <chao.p.peng@intel.com>, Yi
 Sun <yi.y.sun@linux.intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
Subject: Re: [PATCH rfcv1 23/23] intel_iommu: modify x-scalable-mode to be
 string option
Message-ID: <20240204210522.ypkmf6edlepcwicf@joelS2.panther.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="blom46uwy3q7jgq5"
Content-Disposition: inline
In-Reply-To: <4b92ba16-5839-4c93-bd07-46e177de7d18@intel.com>
X-Originating-IP: [106.210.248.184]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
 CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WSfUxTVxjGPffe3n6YkttC1pNiwlbdR6RDmBJOsulqMFkzNNH9s9lIsFnv
 KAFabGHKFjeYG2MOZgshZDWFAtKClY+ND0FRTNmgDlwd69BVQDNKSAuKlQ/XWctaLmYm++/3
 Pu/znDxvcji40EKKOTmaQlqnUeZJSB7ROxx0vS4KDdLJ35S9iFbXKkhUarmKo7pQGwvN1TRj
 aHL8JWQdX8KQOzwAkHNuCUfN93vYyPe1E0dr//hZ6MrsDIkGe8Ms1D24ykYjlX0EOnetn43M
 wQkCGWsbSXTvKwo1eVxAFifvN02x5eU3hzF504APk09ODJDyuuuH5N6JLkxeeeoBKQ/Megj5
 4tU/yINcBe8tFZ2X8zGt27HnKE/t7mwFBcPSE0OuSlACnkpOAy4HUrtgfe0afhrwOEKqBcDf
 Wy4TzLAM4Hy7GY+6hNQSgHfd6c8SFyr8bMZkA/DXi6GNRMT0wHhrY9MNoD/4hIxGCGob7Jm9
 DaJMUlLoWphcfzaOSoA3+j3raZy6RMCep2YsuoilFLDFPL9u4lMyaD7TARgWwOvfe4ko49QJ
 ONZWGvFzIhwPbWFOVOZSu2G/1cJiqm6FJmsJzvBJ+Eu3B2O4hgcDUzkM74PfesvYDMdC/0j3
 Bm+Bo9UV690gVQ3gYPghmxnsAFpLVzZeehN+6fayoyUgtRe2VicyGANv3xcwNWNgVW8tzsh8
 WF4mZIKvQPv0AmEAW03PHWZ67jDTf4cxshRaLj8i/ycnQmvDPM7wbtjevkhYAPs8ENFF+vxs
 Wv+Ghj6epFfm64s02UkfavN/BJGPOxoeWe4DNn8gyQEwDnCAbZHwX532m0BMaLQaWhLHN8Re
 oYV8lbL4E1qnzdIV5dF6B4jnEBIR/2VVAi2kspWFdC5NF9C6Z1uMwxWXYMdb74j+/Lu4bqfF
 sE+lTVMDQUdLqjHl0rTx0+W95z8rXAj2rW3ZGSvptdhkRypjZDe88R/UfTTWiKcYYFu6jSAd
 2ty2w6q74ZDQOFQynXVA/MJiVsEPPn94nBvfrC7PFB+9yHry6s8sX65019mZldmm7R61YIfA
 qWPZveVV+8+8ffKdoYQVbslY59mM/XPBUz6d2iDre3hnJlk1Vpz2bmb6NdFjZ8MmReLBrsOO
 lap7Ew0dn3OPZdSPHgkYFYc6ftJiGc6AcvX9zbL5gAFvtNcrzAeOjWLW1Cnpo3OvJReF5lyQ
 rsmc9FS4Uzcbupy/3XrPlPn4uz0XSr9I09g3SQi9WpmyHdfplf8CNMAgQDMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRmVeSWpSXmKPExsVy+t/xe7pif/anGsxeqWPx7X8Pm0Xjgn3M
 FvP+rGW1eD51KZPFnUuKFssufWayuPJvD6PFieefmS2Wvt3KbvGy/QSzxf9fr1gt9j59zGax
 f9s/Vost+7+xWxzv3cFiseTATnaLuT+vsVhMnL6IzeJBq4DF4lvnGR1EPHbOusvu0XHhGJPH
 4j0vmTzuXNvD5jHvZKDHk2ubmTx6m9+xeXx8eovF4/2+q2wBnFF6NkX5pSWpChn5xSW2StGG
 FkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GV/vbGMrOKJT0bltM3MD42+lLkZO
 DgkBE4k1Pa/Yuxi5OIQEljJK7F/Vyg6RkJHY+OUqK4QtLPHnWhcbRNFHRolLb9cyQzhbGCX+
 7JvHDFLFIqAisfXpDUYQm01AR+L8mztgcREBeYmzO2+xgDQwC+xgkfj3uROsSFggSmLF3Ndg
 RbwCDhJz+9czQkxdySRx9eNPqISgxMmZT1hAbGaBMokLtx4BxTmAbGmJ5f84QMKcArYSO5ct
 gDpVWWLWsgZmCLtW4vPfZ4wTGIVnIZk0C8mkWQiTIMJaEjf+vWTCENaWWLbwNTOEbSuxbt17
 lgWM7KsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzECU8+2Yz+37GBc+eqj3iFGJg7GQ4wqQJ2P
 Nqy+wCjFkpefl6okwjtBeG+qEG9KYmVValF+fFFpTmrxIUZTYDBOZJYSTc4HJsW8knhDMwNT
 QxMzSwNTSzNjJXFez4KORCGB9MSS1OzU1ILUIpg+Jg5OqQamdOnj03bxSojbuJ580rWBM/2o
 cgKPv4SvWZBLZr/b5ivGe1Jsjl9YohJ7OPmhcrhk4a9j7OeeiKyRtvv5y+CTQMdrm/L7/tZb
 dJ89m7iqYqVJQqniumt2a1YePPha0llwbnja2jy3kP+Cx0LrQwrNv0+bf2TK5qOvf7VNmdNU
 Om3TlQw2iW9rVZ0Lbv4+/C3Sf9cZjevJ18KTTvyPL7bvC2N+uH0+87Z97vmSZzgPTm05uTJ5
 0bvZVzfueZDOUTfrzwqW+hehftvjLljd8MyYrHtIWC981oIXxh7rqt9ULnZmY73CfsMkQsgl
 /bOIxxbRaqepAltNVhbP3l42Q7HljMvcT+cmO7BtfsbHcXVSnRJLcUaioRZzUXEiAEW34FfS
 AwAA
X-CMS-MailID: 20240204210526eucas1p1d0812ae575dc28577afaee1224fd4f9b
X-Msg-Generator: CA
X-RootMTR: 20240131144013eucas1p22d46339ae42f54dd59c23e8b95502dda
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240131144013eucas1p22d46339ae42f54dd59c23e8b95502dda
References: <20240115103735.132209-1-zhenzhong.duan@intel.com>
 <20240115103735.132209-24-zhenzhong.duan@intel.com>
 <CGME20240131144013eucas1p22d46339ae42f54dd59c23e8b95502dda@eucas1p2.samsung.com>
 <20240131144011.onhavz2bl2ch7vkv@localhost>
 <4b92ba16-5839-4c93-bd07-46e177de7d18@intel.com>
Received-SPF: pass client-ip=210.118.77.11;
 envelope-from=j.granados@samsung.com; helo=mailout1.w1.samsung.com
X-Spam_score_int: -74
X-Spam_score: -7.5
X-Spam_bar: -------
X-Spam_report: (-7.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--blom46uwy3q7jgq5
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 11:24:18PM +0800, Yi Liu wrote:
> On 2024/1/31 22:40, Joel Granados wrote:
> > On Mon, Jan 15, 2024 at 06:37:35PM +0800, Zhenzhong Duan wrote:
> >> From: Yi Liu <yi.l.liu@intel.com>
> >>
> >> Intel VT-d 3.0 introduces scalable mode, and it has a bunch of capabil=
ities
> >> related to scalable mode translation, thus there are multiple combinat=
ions.
> >> While this vIOMMU implementation wants to simplify it for user by prov=
iding
> >> typical combinations. User could config it by "x-scalable-mode" option=
=2E The
> >> usage is as below:
> >>
> >> "-device intel-iommu,x-scalable-mode=3D["legacy"|"modern"|"off"]"
> >>
> >>   - "legacy": gives support for stage-2 page table
> >>   - "modern": gives support for stage-1 page table
> >>   - "off": no scalable mode support
> >>   -  if not configured, means no scalable mode support, if not proper
> >>      configured, will throw error
> >>
> >> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> >> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> >> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> >> ---
> >>   include/hw/i386/intel_iommu.h |  1 +
> >>   hw/i386/intel_iommu.c         | 25 +++++++++++++++++++++++--
> >>   2 files changed, 24 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iom=
mu.h
> >> index f3e75263b7..9cbd568171 100644
> >> --- a/include/hw/i386/intel_iommu.h
> >> +++ b/include/hw/i386/intel_iommu.h
> >> @@ -320,6 +320,7 @@ struct IntelIOMMUState {
> >>  =20
> >>       bool caching_mode;              /* RO - is cap CM enabled? */
> >>       bool scalable_mode;             /* RO - is Scalable Mode support=
ed? */
> >> +    char *scalable_mode_str;        /* RO - admin's Scalable Mode con=
fig */
> >>       bool scalable_modern;           /* RO - is modern SM supported? =
*/
> >>       bool snoop_control;             /* RO - is SNP filed supported? =
*/
> >>  =20
> >> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> >> index e418305f6e..b507112069 100644
> >> --- a/hw/i386/intel_iommu.c
> >> +++ b/hw/i386/intel_iommu.c
> >> @@ -5111,7 +5111,7 @@ static Property vtd_properties[] =3D {
> >>       DEFINE_PROP_UINT8("aw-bits", IntelIOMMUState, aw_bits,
> >>                         VTD_HOST_ADDRESS_WIDTH),
> >>       DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, =
FALSE),
> >> -    DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mod=
e, FALSE),
> >> +    DEFINE_PROP_STRING("x-scalable-mode", IntelIOMMUState, scalable_m=
ode_str),
> >>       DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control=
, false),
> >>       DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
> >>       DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
> >> @@ -6122,7 +6122,28 @@ static bool vtd_decide_config(IntelIOMMUState *=
s, Error **errp)
> >>           }
> >>       }
> >>  =20
> >> -    /* Currently only address widths supported are 39 and 48 bits */
> >> +    if (s->scalable_mode_str &&
> >> +        (strcmp(s->scalable_mode_str, "off") &&
> >> +         strcmp(s->scalable_mode_str, "modern") &&
> >> +         strcmp(s->scalable_mode_str, "legacy"))) {
> >> +        error_setg(errp, "Invalid x-scalable-mode config,"
> >> +                         "Please use \"modern\", \"legacy\" or \"off\=
"");
> >> +        return false;
> >> +    }
> >> +
> >> +    if (s->scalable_mode_str &&
> >> +        !strcmp(s->scalable_mode_str, "legacy")) {
> >> +        s->scalable_mode =3D true;
> >> +        s->scalable_modern =3D false;
> >> +    } else if (s->scalable_mode_str &&
> >> +        !strcmp(s->scalable_mode_str, "modern")) {
> >> +        s->scalable_mode =3D true;
> >> +        s->scalable_modern =3D true;
> >> +    } else {
> >> +        s->scalable_mode =3D false;
> >> +        s->scalable_modern =3D false;
> >> +    }
> >> +
> >>       if ((s->aw_bits !=3D VTD_HOST_AW_39BIT) &&
> >>           (s->aw_bits !=3D VTD_HOST_AW_48BIT) &&
> >>           !s->scalable_modern) {
> >> --=20
> >> 2.34.1
> >>
> >>
> >=20
> > I noticed that this patch changes quite a bit from the previous version
> > that you had. I Specifically noticed that you dropped VTD_ECAP_PRS from
> > intel_iommu_internal.h. I was under the impression that this set the
> > Page Request Servicves capability in the IOMMU effectively enabling PRI
> > in the iommu.
> >=20
> > Why did you remove it from your original patch?
>=20
> It is because this series does not cover the PRS support. It should come
> in a future series.

ok. Thx for getting back to me.

Best
>=20
> Regards,
> Yi Liu

--=20

Joel Granados

--blom46uwy3q7jgq5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmW//BAACgkQupfNUreW
QU+a7gwAlebvVhHVGke89oE8szAHzNmMvjRRfw3ABmlSq70+Y1rBc+YTknC4wdvW
U/RQ0UadnQQaiEsaqkgEHfBWjrUH8s8hQcR8GevjCD/t4JTrzC+ZVH5wQ8fB6+Qb
S4cxO++/Yh63cmY/IdUfGgHkhwi0ZgMUzZ8Ge5lG1Xp+shZKLVRJlOmC6Tawp9vZ
lTOVrndesPCyKliMO3FSRJ1hmwU9G+jLF4XiyuGoLYb5EwVF13u+crO/HiW2X/YS
UDcdnFaB5CNGXM/GjrCtHR3gIxoftmeDQpHXskvxW+qhA9tJaTqxwlaG90CYyiRO
6CaxTK+5WRI5Jg2fGYxJ2GBj2AKfVqIrq+nufWVgq/N7sJKd4eN+eDTrpeACMsaj
F+ralM/1o5Lm8JIDIiGC53Evtipm7CeD2ccCmREpPk8F8m+eZ25KLKd5Z8HtD1DO
Wb4V7fMzVaxb8dqkobfyVcki/PDFz7sNRD6MTolSmg2q8yUt9vwxrZhQe4mMp+oO
ADaqBaxm
=FODF
-----END PGP SIGNATURE-----

--blom46uwy3q7jgq5--

