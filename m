Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F47EC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 12:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rx3xM-0001Zt-Rt; Wed, 17 Apr 2024 08:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rx3xK-0001ZZ-Hi
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 08:00:02 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rx3xH-00055A-Ef
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 08:00:02 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VKKD05Wb7z6H6mb;
 Wed, 17 Apr 2024 19:57:52 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id A0CE41406AC;
 Wed, 17 Apr 2024 19:59:52 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 17 Apr
 2024 12:59:52 +0100
Date: Wed, 17 Apr 2024 12:59:51 +0100
To: fan <nifan.cxl@gmail.com>
CC: Gregory Price <gregory.price@memverge.com>, <qemu-devel@nongnu.org>,
 <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
 <dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
 <nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
 <Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v6 10/12] hw/mem/cxl_type3: Add dpa range validation for
 accesses to DC regions
Message-ID: <20240417125951.00001db1@Huawei.com>
In-Reply-To: <Zh6pNVIZFMQadmOm@debian>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
 <20240325190339.696686-11-nifan.cxl@gmail.com>
 <Zhm7ssKVGdGlR9Iq@memverge.com> <Zh1lk8FWmf0oI7RM@debian>
 <20240416160056.0000325c@Huawei.com> <Zh6pNVIZFMQadmOm@debian>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
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
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 16 Apr 2024 09:37:09 -0700
fan <nifan.cxl@gmail.com> wrote:

> On Tue, Apr 16, 2024 at 04:00:56PM +0100, Jonathan Cameron wrote:
> > On Mon, 15 Apr 2024 10:37:00 -0700
> > fan <nifan.cxl@gmail.com> wrote:
> >  =20
> > > On Fri, Apr 12, 2024 at 06:54:42PM -0400, Gregory Price wrote: =20
> > > > On Mon, Mar 25, 2024 at 12:02:28PM -0700, nifan.cxl@gmail.com wrote=
:   =20
> > > > > From: Fan Ni <fan.ni@samsung.com>
> > > > >=20
> > > > > All dpa ranges in the DC regions are invalid to access until an e=
xtent
> > > > > covering the range has been added. Add a bitmap for each region to
> > > > > record whether a DC block in the region has been backed by DC ext=
ent.
> > > > > For the bitmap, a bit in the bitmap represents a DC block. When a=
 DC
> > > > > extent is added, all the bits of the blocks in the extent will be=
 set,
> > > > > which will be cleared when the extent is released.
> > > > >=20
> > > > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > > > > ---
> > > > >  hw/cxl/cxl-mailbox-utils.c  |  6 +++
> > > > >  hw/mem/cxl_type3.c          | 76 +++++++++++++++++++++++++++++++=
++++++
> > > > >  include/hw/cxl/cxl_device.h |  7 ++++
> > > > >  3 files changed, 89 insertions(+)
> > > > >=20
> > > > > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-util=
s.c
> > > > > index 7094e007b9..a0d2239176 100644
> > > > > --- a/hw/cxl/cxl-mailbox-utils.c
> > > > > +++ b/hw/cxl/cxl-mailbox-utils.c
> > > > > @@ -1620,6 +1620,7 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(c=
onst struct cxl_cmd *cmd,
> > > > > =20
> > > > >          cxl_insert_extent_to_extent_list(extent_list, dpa, len, =
NULL, 0);
> > > > >          ct3d->dc.total_extent_count +=3D 1;
> > > > > +        ct3_set_region_block_backed(ct3d, dpa, len);
> > > > > =20
> > > > >          ent =3D QTAILQ_FIRST(&ct3d->dc.extents_pending);
> > > > >          cxl_remove_extent_from_extent_list(&ct3d->dc.extents_pen=
ding, ent);   =20
> > > >=20
> > > > while looking at the MHD code, we had decided to "reserve" the bloc=
ks in
> > > > the bitmap in the call to `qmp_cxl_process_dynamic_capacity` in ord=
er to
> > > > prevent a potential double-allocation (basically we need to sanity =
check
> > > > that two hosts aren't reserving the region PRIOR to the host being
> > > > notified).
> > > >=20
> > > > I did not see any checks in the `qmp_cxl_process_dynamic_capacity` =
path
> > > > to prevent pending extents from being double-allocated.  Is this an
> > > > explicit choice?
> > > >=20
> > > > I can see, for example, why you may want to allow the following in =
the
> > > > pending list: [Add X, Remove X, Add X].  I just want to know if thi=
s is
> > > > intentional or not. If not, you may consider adding a pending check
> > > > during the sanity check phase of `qmp_cxl_process_dynamic_capacity`
> > > >=20
> > > > ~Gregory   =20
> > >=20
> > > First, for remove request, pending list is not involved. See cxl r3.1,
> > > 9.13.3.3. Pending basically means "pending to add".=20
> > > So for the above example, in the pending list, you can see [Add x, ad=
d x] if the
> > > event is not processed in time.
> > > Second, from the spec, I cannot find any text saying we cannot issue
> > > another add extent X if it is still pending. =20
> >=20
> > I think there is text saying that the capacity is not released for reuse
> > by the device until it receives a response from the host.   Whilst
> > it's not explicit on offers to the same host, I'm not sure that matters.
> > So I don't think it is suppose to queue multiple extents... =20
>=20
> Are you suggesting we add a check here to reject the second add when the
> first one is still pending?

Yes.  The capacity is not back with the device to reissue.
On an MH-MLD/SLD we'd need to prevent it being added (not shared) to multip=
le hosts,
this is kind of the temporal equivalent of that.

>=20
> Currently, we do not allow releasing an extent when it is still pending,
> which aligns with the case you mentioned above "not release for reuse", I
> think.
> Can the second add mean a retry instead of reuse?=20
No - or at least the device should not be doing that.  The FM might try
again, but only once it knows try 1 failed. For reasons of this aligning
with MHD case where you definitely can't offer it to more than one host,
I think we should not do it.  Whether we should put any effort into blocking
it is a different question.  User error :)

Note, the host must not remove a log entry until it has dealt with it
(sent a response) so there is no obvious reason to bother with a retry.
Maybe a booting host would reject all offered extents (because it's not rea=
dy
for them yet), but then I'd want the FM to explicitly decide to tell the de=
vice
to offer gain.

Whilst this is a custom interface, the equivalent FM API does say.

"The command, with selection policy Enable Shared Access, shall also fail w=
ith Invalid
Input under the following conditions:
=E2=80=A2 When the specified region is not Sharable
=E2=80=A2 When the tagged capacity is already mapped to any Host ID via a n=
on-Sharable
region
=E2=80=A2 When the tagged capacity cannot be added to the requested region =
due to deviceimposed
restrictions
=E2=80=A2 When the same tagged capacity is currently accessible by the same=
 LD"

Little fuzzy because of the whole pending vs 'mapped / accessible' wording =
but
I think intent is you can't send again until first one is dealt with.

Jonathan

>=20
> Fan
>=20
> >=20
> >  =20
> > > From the kernel side, if the first one is accepted, the second one wi=
ll
> > > get rejected, and there is no issue there.
> > > If the first is reject for some reason, the second one can get
> > > accepted or rejected and do not need to worry about the first one.
> > >=20
> > >=20
> > > Fan
> > >  =20
> >  =20


