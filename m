Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F210C54E58
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 02:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rimam-0004HA-Jv; Fri, 08 Mar 2024 21:37:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rimak-0004FJ-HQ
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 21:37:42 -0500
Received: from out-184.mta1.migadu.com ([95.215.58.184])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rimah-0005OT-4W
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 21:37:42 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1709951856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SHS5X+1zWiQc/yiIZPjW+gVtxCeSbG1iEW2UMZXfVYI=;
 b=Lm0AejwdL1gVoWMSiMFN/4xUoC1/SJulWRaK6UAQOA9FTsM/Jl+yEPbHwlD79LDfRjKXe5
 uqvjRN3d2Rs/i/lCxx+AId07yVIbmE1YoSWz7CZvRmGnIGUPfNHUs+sL5r1ZK3RvO5+s9N
 c/OTkhh1rduG4YDVC3J84XYQOUYnRQU=
Date: Sat, 09 Mar 2024 02:37:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: hao.xiang@linux.dev
Message-ID: <28e2ade8ee733b3dc602a78bde47e2df43960706@linux.dev>
TLS-Required: No
Subject: Re: [External] Re: [PATCH v4 2/7] migration/multifd: Implement zero
 page transmission on the multifd thread.
To: peterx@redhat.com
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 farosas@suse.de, eblake@redhat.com, armbru@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, jdenemar@redhat.com, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, qemu-devel@nongnu.org
In-Reply-To: <CAAYibXi0xjpwayO1u8P4skjpeOuUteyuRmrhFHmjFwoRF2JWJg@mail.gmail.com>
References: <20240301022829.3390548-1-hao.xiang@bytedance.com>
 <20240301022829.3390548-3-hao.xiang@bytedance.com>
 <ZeV1TrOvERHN_LOo@x1n>
 <CAAYibXi0xjpwayO1u8P4skjpeOuUteyuRmrhFHmjFwoRF2JWJg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=95.215.58.184; envelope-from=hao.xiang@linux.dev;
 helo=out-184.mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

>=20
>=20On Sun, Mar 3, 2024 at 11:16 PM Peter Xu <peterx@redhat.com> wrote:
>=20
>=20>=20
>=20> On Fri, Mar 01, 2024 at 02:28:24AM +0000, Hao Xiang wrote:
> >=20
>=20>  -GlobalProperty hw_compat_8_2[] =3D {};
> >=20
>=20>  +GlobalProperty hw_compat_8_2[] =3D {
> >=20
>=20>  + { "migration", "zero-page-detection", "legacy"},
> >=20
>=20>  +};
> >=20
>=20>  I hope we can make it for 9.0, then this (and many rest places) ca=
n be kept
> >=20
>=20>  as-is. Let's see.. soft-freeze is March 12th.
> >=20
>=20>  One thing to mention is I just sent a pull which has mapped-ram fe=
ature
> >=20
>=20>  merged. You may need a rebase onto that, and hopefully mapped-ram =
can also
> >=20
>=20>  use your feature too within the same patch when you repost.
> >=20
>=20>  https://lore.kernel.org/all/20240229153017.2221-1-farosas@suse.de/
> >=20
>=20>  That rebase may or may not need much caution, I apologize for that=
:
> >=20
>=20>  mapped-ram as a feature was discussed 1+ years, so it was a plan t=
o merge
> >=20
>=20>  it (actually still partly of it) into QEMU 9.0.

Let's see if we can catch that.

> >=20
>=20>  [...]
> >=20
>=20>  +static bool multifd_zero_page(void)
> >=20
>=20>  multifd_zero_page_enabled()?

Changed.

> >=20
>=20>  +{
> >=20
>=20>  + return migrate_zero_page_detection() =3D=3D ZERO_PAGE_DETECTION_=
MULTIFD;
> >=20
>=20>  +}
> >=20
>=20>  +
> >=20
>=20>  +static void swap_page_offset(ram_addr_t *pages_offset, int a, int=
 b)
> >=20
>=20>  +{
> >=20
>=20>  + ram_addr_t temp;
> >=20
>=20>  +
> >=20
>=20>  + if (a =3D=3D b) {
> >=20
>=20>  + return;
> >=20
>=20>  + }
> >=20
>=20>  +
> >=20
>=20>  + temp =3D pages_offset[a];
> >=20
>=20>  + pages_offset[a] =3D pages_offset[b];
> >=20
>=20>  + pages_offset[b] =3D temp;
> >=20
>=20>  +}
> >=20
>=20>  +
> >=20
>=20>  +/**
> >=20
>=20>  + * multifd_send_zero_page_check: Perform zero page detection on a=
ll pages.
> >=20
>=20>  + *
> >=20
>=20>  + * Sorts normal pages before zero pages in p->pages->offset and u=
pdates
> >=20
>=20>  + * p->pages->normal_num.
> >=20
>=20>  + *
> >=20
>=20>  + * @param p A pointer to the send params.
> >=20
>=20>  Nit: the majority of doc style in QEMU (it seems to me) is:
> >=20
>=20>  @p: pointer to @MultiFDSendParams.
> >=20
>=20>  + */
> >=20
>=20>  +void multifd_send_zero_page_check(MultiFDSendParams *p)
> >=20
>=20>  multifd_send_zero_page_detect()?
> >=20
>=20>  This patch used "check" on both sides, but neither of them is a pu=
re check
> >=20
>=20>  to me. For the other side, maybe multifd_recv_zero_page_process()?=
 As
> >=20
>=20>  that one applies the zero pages.


Renamed.

> >=20
>=20>  +{
> >=20
>=20>  + MultiFDPages_t *pages =3D p->pages;
> >=20
>=20>  + RAMBlock *rb =3D pages->block;
> >=20
>=20>  + int i =3D 0;
> >=20
>=20>  + int j =3D pages->num - 1;
> >=20
>=20>  +
> >=20
>=20>  + /*
> >=20
>=20>  + * QEMU older than 9.0 don't understand zero page
> >=20
>=20>  + * on multifd channel. This switch is required to
> >=20
>=20>  + * maintain backward compatibility.
> >=20
>=20>  + */
> >=20
>=20>  IMHO we can drop this comment; it is not accurate as the user can =
disable
> >=20
>=20>  it explicitly through the parameter, then it may not always about =
compatibility.

Dropped.

> >=20
> >  + if (multifd_zero_page()) {
> >=20
>=20>  Shouldn't this be "!multifd_zero_page_enabled()"?

Thanks for catching this! My bad. Fixed.

> >=20
>=20>  + pages->normal_num =3D pages->num;
> >=20
>=20>  + return;
> >=20
>=20>  + }
> >=20
>=20>  The rest looks all sane.
> >=20
>=20>  Thanks,
> >=20
>=20>  --
> >=20
>=20>  Peter Xu
> >
>

