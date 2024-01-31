Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062ABC47DB3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 14:40:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVBlS-0005ge-TL; Wed, 31 Jan 2024 09:40:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <j.granados@samsung.com>)
 id 1rVBlO-0005gU-Ot
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 09:40:30 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <j.granados@samsung.com>)
 id 1rVBlJ-0006fi-6j
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 09:40:30 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20240131144014euoutp01057253e0c73b190d5e66ff349351c9fa~vdYjgYQoM2688326883euoutp01n;
 Wed, 31 Jan 2024 14:40:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20240131144014euoutp01057253e0c73b190d5e66ff349351c9fa~vdYjgYQoM2688326883euoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1706712014;
 bh=BlUrJ3YqaKqOsnLRDxKuRw4TvN3kv/YRRFoORJp5/Wk=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=NZ4Z9Jdle+vzzN0sAy1mpiYSWiiTUQVzsWrNSqkwJHcWxf6cvQtbVeX3zs6Ce4vQk
 Xov1mVJ0EIELkpuWhjQlpd3LdL5q79Fl1rOJSU9uuSIyvXTZihF05NM74jPDzWvxbm
 6M/46dEVe8xocDW//ptRYbUNw1wjTYaiFZUVzMVw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20240131144014eucas1p1ad7255f60bfbf41a9805534d9ba2e7d5~vdYjQaXKu0566005660eucas1p1P;
 Wed, 31 Jan 2024 14:40:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id B2.87.09814.ECB5AB56; Wed, 31
 Jan 2024 14:40:14 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20240131144013eucas1p22d46339ae42f54dd59c23e8b95502dda~vdYitF1Qb1036210362eucas1p2O;
 Wed, 31 Jan 2024 14:40:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240131144013eusmtrp1d858491bb35eb920c2c951f759104621~vdYisKFt83049830498eusmtrp1V;
 Wed, 31 Jan 2024 14:40:13 +0000 (GMT)
X-AuditID: cbfec7f4-727ff70000002656-a4-65ba5bce1b47
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 1F.E7.09146.DCB5AB56; Wed, 31
 Jan 2024 14:40:13 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20240131144013eusmtip25f4d8dba4814ef7079dd220731c12b67~vdYiex-GI0713707137eusmtip2w;
 Wed, 31 Jan 2024 14:40:13 +0000 (GMT)
Received: from localhost (106.210.248.184) by CAMSVWEXC02.scsc.local
 (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 31 Jan 2024 14:40:12 +0000
Date: Wed, 31 Jan 2024 15:40:11 +0100
From: Joel Granados <j.granados@samsung.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
CC: <qemu-devel@nongnu.org>, <alex.williamson@redhat.com>, <clg@redhat.com>,
 <eric.auger@redhat.com>, <peterx@redhat.com>, <jasowang@redhat.com>,
 <mst@redhat.com>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <joao.m.martins@oracle.com>, <kevin.tian@intel.com>, <yi.l.liu@intel.com>,
 <yi.y.sun@intel.com>, <chao.p.peng@intel.com>, Yi Sun
 <yi.y.sun@linux.intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH rfcv1 23/23] intel_iommu: modify x-scalable-mode to be
 string option
Message-ID: <20240131144011.onhavz2bl2ch7vkv@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="r4sm46jbvbxg3w4f"
Content-Disposition: inline
In-Reply-To: <20240115103735.132209-24-zhenzhong.duan@intel.com>
X-Originating-IP: [106.210.248.184]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
 CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7djP87rnonelGjQ2cVp8+9/DZtG4YB+z
 xbw/a1ktnk9dymRx55KixbJLn5ksrvzbw2hx4vlnZoulb7eyW7xsP8Fs8f/XK1aLvU8fs1ns
 3/aP1WLL/m/sFsd7d7BYLDmwk91i7s9rLBYTpy9is3jQKmCx+NZ5RgcRj52z7rJ7dFw4xuSx
 eM9LJo871/awecw7Gejx5NpmJo/e5ndsHh+f3mLxeL/vKlsAZxSXTUpqTmZZapG+XQJXxp8p
 B9kKpmtUvFrWwNTA2KPQxcjJISFgItG+8DFLFyMXh5DACkaJfetvsIMkhAS+MEqc+ykAkfjM
 KLF+zX8WmI4Dh4+xQSSWM0p03tvEDFf14MpndghnK6PEy+8vmEBaWARUJf4vPQLWziagI3H+
 zR1mEFtEQFfi2+dpjCANzAKLWSR+r+gCaxAWiJJYMfc1WBGvgLlEz9237BC2oMTJmU/ABjEL
 VEg8OfUCqJkDyJaWWP6PAyTMKeAg8eX/aahTlSVmLWtghrBrJU5tucUEsktCYCaXRP+U+0wQ
 CReJNw+a2SFsYYlXx7dA2TISpyf3sEA0TGaU2P/vAzuEs5pRYlnjV6hua4mWK0/YQa6QEHCU
 WDlZG8Lkk7jxVhDiTj6JSdumM0OEeSU62oQgGtUkVt97wzKBUXkWks9mIflsFsJnEGEdiQW7
 P7FhCGtLLFv4mhnCtpVYt+49ywJG9lWM4qmlxbnpqcVGeanlesWJucWleel6yfm5mxiBKff0
 v+NfdjAuf/VR7xAjEwfjIUYVoOZHG1ZfYJRiycvPS1US4V0ptzNViDclsbIqtSg/vqg0J7X4
 EKM0B4uSOK9qinyqkEB6YklqdmpqQWoRTJaJg1OqgSndLbZJ4DTPURnvQ9Fcbvo7rSvdz/rf
 bglOWr7n2kubt+I/2tpVeLX366XMtOleePe3nIDjvKiln8x+7pz8fvPvKIOwvNWGD4M3r7vc
 ptUkWXGuevO+/qB/CflxZqr2PKJxaR7VIfO1ZMvVXVenl7CXb/zEx7/H4u8PUZX7MgKSV19b
 2XreLwqcwHihzWnOcs15BQ9PKJ/ikzE7bfpVqmvyST5jP+7dHxYah/0/fVrh8raMWTEFwmlz
 mtrSKy78zH48Zdsix/SPP2f07LWLFs2IFsupq087IXIpvjZGl7XlVFXFB/57koHbyxkZNvT8
 O8XYyn4k7NHdlmiHnkdnt29SeDb38J9nRsLvJ/CkKLEUZyQaajEXFScCAAo5tsc0BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHKsWRmVeSWpSXmKPExsVy+t/xe7pno3elGrxoV7L49r+HzaJxwT5m
 i3l/1rJaPJ+6lMniziVFi2WXPjNZXPm3h9HixPPPzBZL325lt3jZfoLZ4v+vV6wWe58+ZrPY
 v+0fq8WW/d/YLY737mCxWHJgJ7vF3J/XWCwmTl/EZvGgVcBi8a3zjA4iHjtn3WX36LhwjMlj
 8Z6XTB53ru1h85h3MtDjybXNTB69ze/YPD4+vcXi8X7fVbYAzig9m6L80pJUhYz84hJbpWhD
 CyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jFcN51gLpmpU/F4xm7GBsUuhi5GT
 Q0LAROLA4WNsXYxcHEICSxkl5u/ZzQiRkJHY+OUqK4QtLPHnWhdU0UdGiQ/bmpkhnK2MEqdb
 r7KDVLEIqEr8X3qEBcRmE9CROP/mDjOILSKgK/Ht8zRGkAZmgcUsEr9XdDGBJIQFoiRWzH0N
 VsQrYC7Rc/ct2CAhgRKJyafWsEPEBSVOznwCNpRZoEzif+c/oHoOIFtaYvk/DpAwp4CDxJf/
 p1kgLlWWmLWsgRnCrpX4/PcZ4wRG4VlIJs1CMmkWwiSIsJbEjX8vmTCEtSWWLXzNDGHbSqxb
 955lASP7KkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMDEs+3Yz807GOe9+qh3iJGJg/EQowpQ
 56MNqy8wSrHk5eelKonwrpTbmSrEm5JYWZValB9fVJqTWnyI0RQYihOZpUST84EpMa8k3tDM
 wNTQxMzSwNTSzFhJnNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1OqgWm7bhrrmoCQnUXvD1SpGH3y
 cjrDZrzowVZniWkrPs12Cbv/g+vivu6fK0NqDYPm++jJ7F7Hel3r3QbB7Ly2qc1yGk13ODbz
 vj4TFzGZVXKd1up1KiZB6xc9uPt+Rd7kDRzXAvuPbGI9wlxTHCdd+dlsyyI3f1v2Z4tMl3+W
 MjNcHPuuKoo3WXfHDP3QOJHgtt4DCvWRSTOl99y6cO3jbBG9GMk8xzvq6zXXWgfuOHuAl/fi
 p/cN974dUbmU/eqv6oSPO/werDJv/dStwZA26/8h7bW3j5sZLlkh/SKgJ0gg6Zv74o1vlleK
 cTz3Xz5li7qB4yXr6k3tCWXuGw7ILk2Y2Ri896HujyfNSsmrX3IosRRnJBpqMRcVJwIANIEX
 OtEDAAA=
X-CMS-MailID: 20240131144013eucas1p22d46339ae42f54dd59c23e8b95502dda
X-Msg-Generator: CA
X-RootMTR: 20240131144013eucas1p22d46339ae42f54dd59c23e8b95502dda
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240131144013eucas1p22d46339ae42f54dd59c23e8b95502dda
References: <20240115103735.132209-1-zhenzhong.duan@intel.com>
 <20240115103735.132209-24-zhenzhong.duan@intel.com>
 <CGME20240131144013eucas1p22d46339ae42f54dd59c23e8b95502dda@eucas1p2.samsung.com>
Received-SPF: pass client-ip=210.118.77.11;
 envelope-from=j.granados@samsung.com; helo=mailout1.w1.samsung.com
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--r4sm46jbvbxg3w4f
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 06:37:35PM +0800, Zhenzhong Duan wrote:
> From: Yi Liu <yi.l.liu@intel.com>
>=20
> Intel VT-d 3.0 introduces scalable mode, and it has a bunch of capabiliti=
es
> related to scalable mode translation, thus there are multiple combination=
s.
> While this vIOMMU implementation wants to simplify it for user by providi=
ng
> typical combinations. User could config it by "x-scalable-mode" option. T=
he
> usage is as below:
>=20
> "-device intel-iommu,x-scalable-mode=3D["legacy"|"modern"|"off"]"
>=20
>  - "legacy": gives support for stage-2 page table
>  - "modern": gives support for stage-1 page table
>  - "off": no scalable mode support
>  -  if not configured, means no scalable mode support, if not proper
>     configured, will throw error
>=20
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  include/hw/i386/intel_iommu.h |  1 +
>  hw/i386/intel_iommu.c         | 25 +++++++++++++++++++++++--
>  2 files changed, 24 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index f3e75263b7..9cbd568171 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -320,6 +320,7 @@ struct IntelIOMMUState {
> =20
>      bool caching_mode;              /* RO - is cap CM enabled? */
>      bool scalable_mode;             /* RO - is Scalable Mode supported? =
*/
> +    char *scalable_mode_str;        /* RO - admin's Scalable Mode config=
 */
>      bool scalable_modern;           /* RO - is modern SM supported? */
>      bool snoop_control;             /* RO - is SNP filed supported? */
> =20
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index e418305f6e..b507112069 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -5111,7 +5111,7 @@ static Property vtd_properties[] =3D {
>      DEFINE_PROP_UINT8("aw-bits", IntelIOMMUState, aw_bits,
>                        VTD_HOST_ADDRESS_WIDTH),
>      DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALS=
E),
> -    DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode, =
FALSE),
> +    DEFINE_PROP_STRING("x-scalable-mode", IntelIOMMUState, scalable_mode=
_str),
>      DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control, fa=
lse),
>      DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
>      DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
> @@ -6122,7 +6122,28 @@ static bool vtd_decide_config(IntelIOMMUState *s, =
Error **errp)
>          }
>      }
> =20
> -    /* Currently only address widths supported are 39 and 48 bits */
> +    if (s->scalable_mode_str &&
> +        (strcmp(s->scalable_mode_str, "off") &&
> +         strcmp(s->scalable_mode_str, "modern") &&
> +         strcmp(s->scalable_mode_str, "legacy"))) {
> +        error_setg(errp, "Invalid x-scalable-mode config,"
> +                         "Please use \"modern\", \"legacy\" or \"off\"");
> +        return false;
> +    }
> +
> +    if (s->scalable_mode_str &&
> +        !strcmp(s->scalable_mode_str, "legacy")) {
> +        s->scalable_mode =3D true;
> +        s->scalable_modern =3D false;
> +    } else if (s->scalable_mode_str &&
> +        !strcmp(s->scalable_mode_str, "modern")) {
> +        s->scalable_mode =3D true;
> +        s->scalable_modern =3D true;
> +    } else {
> +        s->scalable_mode =3D false;
> +        s->scalable_modern =3D false;
> +    }
> +
>      if ((s->aw_bits !=3D VTD_HOST_AW_39BIT) &&
>          (s->aw_bits !=3D VTD_HOST_AW_48BIT) &&
>          !s->scalable_modern) {
> --=20
> 2.34.1
>=20
>=20

I noticed that this patch changes quite a bit from the previous version
that you had. I Specifically noticed that you dropped VTD_ECAP_PRS from
intel_iommu_internal.h. I was under the impression that this set the
Page Request Servicves capability in the IOMMU effectively enabling PRI
in the iommu.

Why did you remove it from your original patch?

Thx in advance

Best

--=20

Joel Granados

--r4sm46jbvbxg3w4f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmW6W8kACgkQupfNUreW
QU+XjAv/Y329uJGczncF8A0B5m2oGHkYTnmQZm9dTSfg+ngu9dnHDp+dsVJn86Qg
lAOh5e89cRUWiqH3Q9uG9Ypy5AuBxiQFbpFeAxSC+JpRl58POXEdToEempK8P2gS
s99WDnIIyzrUVjjN6gFExxDpYDS0cyKTsCsvq3mEAjRteI/eZXeV5ma79d77kacm
uSBQLaCIKUylfwmAarJPGj06kHga6yaHL0FAug5LfGVn7dlBNAt4YcDN62x7BFU1
YNZvhuqyHuvRpHITMMoW0ryQr3WLTEb3H/ZQHcckoo9uYEYoPB5FMp7L2fvP1ob0
y9J+I70FpUGQJovjE8PhcnFmp8rWGHf5S2Gy4PY/Hdb+OYKE+f/tOevPxnDt+QFd
NqjdfSxXXvxDYZ98SSJjb8GrekhUjbDly417skCVu87zv2kKiFKkoFLfP+IY9cp0
B+MoXtJk0gGSgSSdyL9x/UXoeQ+INenH11YOHT26Qv63fShPkGfMoxPwES9y9ADA
fjNT4TQ6
=Q6Tb
-----END PGP SIGNATURE-----

--r4sm46jbvbxg3w4f--

