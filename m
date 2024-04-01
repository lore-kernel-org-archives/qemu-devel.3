Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE13CD1288
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 18:45:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrMeP-0008Bq-FP; Mon, 01 Apr 2024 14:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rrMeN-0008BW-Pj
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 14:44:55 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rrMeI-0006EM-VB
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 14:44:55 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V7fzX6Rcwz6K5WY;
 Tue,  2 Apr 2024 02:43:36 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id AEB1A1400D9;
 Tue,  2 Apr 2024 02:44:47 +0800 (CST)
Received: from localhost (10.48.156.172) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 1 Apr
 2024 19:44:47 +0100
Date: Mon, 1 Apr 2024 19:44:44 +0100
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Fan Ni <fan.ni@samsung.com>, "Michael
 S . Tsirkin" <mst@redhat.com>, <linux-cxl@vger.kernel.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 3/4] hw/cxl/mbox: replace sanitize_running() with
 cxl_dev_media_disabled()
Message-ID: <20240401194444.00001db0@Huawei.com>
In-Reply-To: <CAB=+i9QrmMMazcNvEhuwTNF+UZMHPQE=yT=RE+MJCUQO+QY27A@mail.gmail.com>
References: <20231222090051.3265307-1-42.hyeyoo@gmail.com>
 <20231222090051.3265307-4-42.hyeyoo@gmail.com>
 <20240109175358.00007c48@Huawei.com>
 <CAB=+i9QrmMMazcNvEhuwTNF+UZMHPQE=yT=RE+MJCUQO+QY27A@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.48.156.172]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Sun, 21 Jan 2024 21:50:00 -0500
Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:

> On Tue, Jan 9, 2024 at 12:54=E2=80=AFPM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Fri, 22 Dec 2023 18:00:50 +0900
> > Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> > =20
> > > The spec states that reads/writes should have no effect and a part of
> > > commands should be ignored when the media is disabled, not when the
> > > sanitize command is running.qq
> > >
> > > Introduce cxl_dev_media_disabled() to check if the media is disabled =
and
> > > replace sanitize_running() with it.
> > >
> > > Make sure that the media has been correctly disabled during sanitation
> > > by adding an assert to __toggle_media(). Now, enabling when already
> > > enabled or vice versa results in an assert() failure.
> > >
> > > Suggested-by: Davidlohr Bueso <dave@stgolabs.net>
> > > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com> =20
> >
> > This applies to
> >
> > hw/cxl: Add get scan media capabilities cmd support.
> >
> > Should I just squash it with that patch in my tree?
> > For now I'm holding it immediately on top of that, but I'm not keen to
> > send messy code upstream unless there is a good reason to retain the
> > history. =20
>=20
> Oh, while the diff looks like the patch touches scan_media_running(), it'=
s not.
>=20
> The proper Fixes: tag will be:
> Fixes: d77176724422 ("hw/cxl: Add support for device sanitation")
>=20
> > If you are doing this sort of fix series in future, please call out
> > what they fix explicitly.  Can't use fixes tags as the commit ids
> > are unstable, but can mention the patch to make my life easier! =20
>=20
> Okay, next time I will either add the Fixes tag or add a comment on
> what it fixes.
>=20
> By the way I guess your latest, public branch is still cxl-2023-11-02, ri=
ght?
> https://gitlab.com/jic23/qemu/-/tree/cxl-2023-11-02
>=20
> I assume you adjusted my v2 series, but please let me know if you prefer
> sending v3 against your latest tree.
>=20
> Thanks,
> Hyeonggon

Side note, in it's current form this breaks the switch-cci support in upstr=
eam
QEMU.  I've finally gotten back to getting ready to look at MMPT support and
ran into a crash as a result.  Needs protection with checked object_dynamic=
_cast()
to make sure we have a type3 device.  I'll update the patch in my tree.

Thanks,

Jonathan

>=20


