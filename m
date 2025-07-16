Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F55EC83F27
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 07:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubwdH-0003Vu-8o; Wed, 16 Jul 2025 03:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ubwd2-0003Et-Bi; Wed, 16 Jul 2025 03:32:42 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ubwcz-0000W6-TB; Wed, 16 Jul 2025 03:32:36 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bhnmG5wNrz6M4hg;
 Wed, 16 Jul 2025 15:31:10 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id E3707140427;
 Wed, 16 Jul 2025 15:32:25 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Jul 2025 09:32:25 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Wed, 16 Jul 2025 09:32:25 +0200
To: Nicolin Chen <nicolinc@nvidia.com>, Jonathan Cameron
 <jonathan.cameron@huawei.com>
CC: Linuxarm <linuxarm@huawei.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "shameerkolothum@gmail.com"
 <shameerkolothum@gmail.com>
Subject: RE: [RFC PATCH v3 13/15] hw/arm/smmuv3: Forward invalidation commands
 to hw
Thread-Topic: [RFC PATCH v3 13/15] hw/arm/smmuv3: Forward invalidation
 commands to hw
Thread-Index: AQHb9OitTnudABMypEmVkuFeSKtFtbQy4ACAgABu3YCAAQ4dUA==
Date: Wed, 16 Jul 2025 07:32:25 +0000
Message-ID: <37d405ca24664462ab87935403d2fe04@huawei.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-14-shameerali.kolothum.thodi@huawei.com>
 <20250715114609.00004e4d@huawei.com> <aHaOcd5FKOjsWR/p@Asurada-Nvidia>
In-Reply-To: <aHaOcd5FKOjsWR/p@Asurada-Nvidia>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.203.177.241]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
From:  Shameerali Kolothum Thodi via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> -----Original Message-----
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, July 15, 2025 6:23 PM
> To: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>; Linuxarm
> <linuxarm@huawei.com>; qemu-arm@nongnu.org; qemu-
> devel@nongnu.org; eric.auger@redhat.com; peter.maydell@linaro.org;
> jgg@nvidia.com; ddutile@redhat.com; berrange@redhat.com;
> nathanc@nvidia.com; mochs@nvidia.com; smostafa@google.com;
> Wangzhou (B) <wangzhou1@hisilicon.com>; jiangkunkun
> <jiangkunkun@huawei.com>; zhangfei.gao@linaro.org;
> zhenzhong.duan@intel.com; shameerkolothum@gmail.com
> Subject: Re: [RFC PATCH v3 13/15] hw/arm/smmuv3: Forward invalidation
> commands to hw
>=20
> On Tue, Jul 15, 2025 at 11:46:09AM +0100, Jonathan Cameron wrote:
> > >      SMMUCmdError cmd_error =3D SMMU_CERROR_NONE;
> > >      SMMUQueue *q =3D &s->cmdq;
> > >      SMMUCommandType type =3D 0;
> > > +    SMMUCommandBatch batch =3D {};
> > > +    uint32_t ncmds;
> > >
> > >      if (!smmuv3_cmdq_enabled(s)) {
> > >          return 0;
> > >      }
> > > +
> > > +    ncmds =3D smmuv3_q_ncmds(q);
> > > +    batch.cmds =3D g_new0(Cmd, ncmds);
> > > +    batch.cons =3D g_new0(uint32_t, ncmds);
> >
> > Where is batch.ncmds set?  It is cleared but I'm missing it being set t=
o
> anything.
>=20
> smmuv3_accel_batch_cmd() internally sets that, every time it's
> invoked to add a new command in the batch.
>=20
> Shameer, let's add some comments explaining the batch function.

Yes. Will add.

>=20
> > > +
> >
> > > +    qemu_mutex_lock(&s->mutex);
> > > +    if (!cmd_error && batch.ncmds) {
> > > +        if (!smmuv3_accel_issue_cmd_batch(bs, &batch)) {
> > > +            if (batch.ncmds) {
> > > +                q->cons =3D batch.cons[batch.ncmds - 1];
> > > +            } else {
> > > +                q->cons =3D batch.cons[0]; /* FIXME: Check */
> > > +            }
> >
> > Totally non obvious that a return of false from the issue call means
> > illegal command type.  Maybe that will be obvious form comments
> > requested in previous patch review.
>=20
> That's a good point. Shameer, I think we need some fine-grinding
> here, validating the return value from the ioctl, for which the
> kernel will only return -EIO or -ETIMEOUT on failure, indicating
> either an SMMU_CERROR_ILL or an SMMU_CERROR_ATC_INV_SYNC.

Yeah. I was not sure on this. Also on setting current cons pointer in case =
IOCTL=20
return for some reason other than attempting the CMD. I will double check
this.
=20
Thanks,
Shameer

> > > +            qemu_log_mask(LOG_GUEST_ERROR, "Illegal command type:
> %d\n",
> > > +                          CMD_TYPE(&batch.cmds[batch.ncmds]));
> > > +            cmd_error =3D SMMU_CERROR_ILL;
>=20
> Thanks
> Nicolin

