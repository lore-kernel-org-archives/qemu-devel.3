Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C17C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 15:53:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhX6O-0002BX-Ro; Tue, 05 Mar 2024 10:53:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rhX5o-0001n3-CU; Tue, 05 Mar 2024 10:52:37 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rhX5l-0007X6-8k; Tue, 05 Mar 2024 10:52:36 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tq0Lw2dv5z6J67f;
 Tue,  5 Mar 2024 23:47:36 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 27DA9140F92;
 Tue,  5 Mar 2024 23:52:20 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 5 Mar
 2024 15:52:19 +0000
Date: Tue, 5 Mar 2024 15:52:18 +0000
To: Thomas Huth <thuth@redhat.com>
CC: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 <qemu-trivial@nongnu.org>
Subject: Re: [PATCH 3/3] hw/mem/cxl_type3: Fix problem with g_steal_pointer()
Message-ID: <20240305155218.00000c00@Huawei.com>
In-Reply-To: <4f6e1748-a917-4b2b-847d-fbfe04a3e43e@redhat.com>
References: <20240304104406.59855-1-thuth@redhat.com>
 <20240304104406.59855-4-thuth@redhat.com>
 <20240304151037.00000f6c@Huawei.com>
 <4f6e1748-a917-4b2b-847d-fbfe04a3e43e@redhat.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Tue, 5 Mar 2024 08:27:52 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 04/03/2024 16.10, Jonathan Cameron wrote:
> > On Mon,  4 Mar 2024 11:44:06 +0100
> > Thomas Huth <thuth@redhat.com> wrote:
> >  =20
> >> When setting GLIB_VERSION_MAX_ALLOWED to GLIB_VERSION_2_58 or higher,
> >> glib adds type safety checks to the g_steal_pointer() macro. This
> >> triggers errors in the ct3_build_cdat_entries_for_mr() function which
> >> uses the g_steal_pointer() for type-casting from one pointer type to
> >> the other (which also looks quite weird since the local pointers have
> >> all been declared with g_autofree though they are never freed here).
> >> Fix it by using a proper typecast instead. For making this possible, we
> >> have to remove the QEMU_PACKED attribute from some structs since GCC
> >> otherwise complains that the source and destination pointer might
> >> have different alignment restrictions. Removing the QEMU_PACKED should
> >> be fine here since the structs are already naturally aligned. Anyway,
> >> add some QEMU_BUILD_BUG_ON() statements to make sure that we've got
> >> the right sizes (without padding in the structs). =20
> >=20
> > I missed these as well when getting rid of the false handling
> > of failure of g_new0 calls.
> >=20
> > Another alternative would be to point to the head structures rather
> > than the containing structure - would avoid need to cast.
> > That might be neater?  Should I think also remove the alignment
> > question? =20
>=20
> I gave it a try, but it does not help against the alignment issue, I stil=
l get:
>=20
> ../../devel/qemu/hw/mem/cxl_type3.c: In function=20
> =E2=80=98ct3_build_cdat_entries_for_mr=E2=80=99:
> ../../devel/qemu/hw/mem/cxl_type3.c:138:34: error: taking address of pack=
ed=20
> member of =E2=80=98struct CDATDsmas=E2=80=99 may result in an unaligned p=
ointer value=20
> [-Werror=3Daddress-of-packed-member]
>    138 |     cdat_table[CT3_CDAT_DSMAS] =3D &dsmas->header;
>        |                                  ^~~~~~~~~~~~~~
>=20
>  From my experience, it's better anyway to avoid __attribute__((packed)) =
on=20
> structures unless it is really really required. At least we should avoid =
it=20
> as good as possible as long as we still support running QEMU on Sparc hos=
ts=20
> (that don't support misaligned memory accesses), since otherwise you can =
end=20
> up with non-working code there, see e.g.:
>=20
>   https://www.mail-archive.com/qemu-devel@nongnu.org/msg439899.html
>=20
> or:
>=20
>   https://gitlab.com/qemu-project/qemu/-/commit/cb89b349074310ff9eb7ebe18a
>=20
> Thus I'd rather prefer to keep this patch as it is right now.
>=20
>   Thomas
Fair enough.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

>=20


