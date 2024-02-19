Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985CCC48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 21:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcAzS-0004BC-PU; Mon, 19 Feb 2024 16:15:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcAzR-0004B1-LW
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 16:15:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcAzP-0002iY-P9
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 16:15:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708377350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f1AEJxTCc6yrGaFkUBaRy+FKhiNCEUrwhxZAKx1lJJ8=;
 b=aMf+V1qVNTxqlaj3Ym+FIM68Byhw9zFfHSnX0m2pDQvDOM1nQ4gD+HKcQDY3xn+5kb5Rtt
 q2CsUBkFXSLFk3KhOBstGqMXg+ZmawjAwPu/ExzzKQcxeGSLc5nZAbSvb/jlgjEShccPrF
 hCjySLWqydBXid+3kv220d5NB8VLtmw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-pnrJpOsKOVi9teXxueKKyA-1; Mon,
 19 Feb 2024 16:15:48 -0500
X-MC-Unique: pnrJpOsKOVi9teXxueKKyA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B2603C0008C;
 Mon, 19 Feb 2024 21:15:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 07368111D3EF;
 Mon, 19 Feb 2024 21:15:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E75F021E6767; Mon, 19 Feb 2024 22:15:46 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,
 dlemoal@kernel.org,  Hanna Reitz <hreitz@redhat.com>,
 dmitry.fomichev@wdc.com,  qemu-block@nongnu.org,  Eric Blake
 <eblake@redhat.com>,  hare@suse.de,  Kevin Wolf <kwolf@redhat.com>,
 stefanha@redhat.com
Subject: Re: [PATCH v7 2/4] qcow2: add configurations for zoned format
 extension
In-Reply-To: <CAAAx-8KvZv=vfGB8+h73Nh=8DwsyD-nD_FjgGrgW2O+h66FdeA@mail.gmail.com>
 (Sam Li's message of "Mon, 19 Feb 2024 21:46:42 +0100")
References: <20240122184830.40094-1-faithilikerun@gmail.com>
 <20240122184830.40094-3-faithilikerun@gmail.com>
 <87plwsfyyv.fsf@pond.sub.org> <87edd8fyme.fsf@pond.sub.org>
 <CAAAx-8KAD1bygZsnCtkCYO=oNf7W2xnqGU+RD5Afsz8jcBUYhg@mail.gmail.com>
 <877cj0jz5u.fsf@pond.sub.org>
 <CAAAx-8JYR2r7BzWWVtcY9h8ZgNq1an4=eTCwBnDNe+HwbkgHeg@mail.gmail.com>
 <87a5nwh2h6.fsf@pond.sub.org>
 <CAAAx-8+Am5ehs6tyA64Vms713+34iq44yR6SvWr7CpHX_dq-MA@mail.gmail.com>
 <87o7ccfaok.fsf@pond.sub.org>
 <CAAAx-8KvZv=vfGB8+h73Nh=8DwsyD-nD_FjgGrgW2O+h66FdeA@mail.gmail.com>
Date: Mon, 19 Feb 2024 22:15:46 +0100
Message-ID: <871q98f94t.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Sam Li <faithilikerun@gmail.com> writes:

> Markus Armbruster <armbru@redhat.com> =E4=BA=8E2024=E5=B9=B42=E6=9C=8819=
=E6=97=A5=E5=91=A8=E4=B8=80 21:42=E5=86=99=E9=81=93=EF=BC=9A
>>
>> Sam Li <faithilikerun@gmail.com> writes:
>>
>> > Markus Armbruster <armbru@redhat.com> =E4=BA=8E2024=E5=B9=B42=E6=9C=88=
19=E6=97=A5=E5=91=A8=E4=B8=80 16:56=E5=86=99=E9=81=93=EF=BC=9A
>> >>
>> >> Sam Li <faithilikerun@gmail.com> writes:
>> >>
>> >> > Markus Armbruster <armbru@redhat.com> =E4=BA=8E2024=E5=B9=B42=E6=9C=
=8819=E6=97=A5=E5=91=A8=E4=B8=80 15:40=E5=86=99=E9=81=93=EF=BC=9A
>> >> >>
>> >> >> Sam Li <faithilikerun@gmail.com> writes:
>> >> >>
>> >> >> > Markus Armbruster <armbru@redhat.com> =E4=BA=8E2024=E5=B9=B42=E6=
=9C=8819=E6=97=A5=E5=91=A8=E4=B8=80 13:05=E5=86=99=E9=81=93=EF=BC=9A
>> >> >> >>
>> >> >> >> One more thing...
>> >> >> >>
>> >> >> >> Markus Armbruster <armbru@redhat.com> writes:
>> >> >> >>
>> >> >> >> > I apologize for the delayed review.
>> >> >> >
>> >> >> > No problems. Thanks for reviewing!
>> >> >> >
>> >> >> >> >
>> >> >> >> > Sam Li <faithilikerun@gmail.com> writes:
>> >> >> >> >
>> >> >> >> >> To configure the zoned format feature on the qcow2 driver, it
>> >> >> >> >> requires settings as: the device size, zone model, zone size,
>> >> >> >> >> zone capacity, number of conventional zones, limits on zone
>> >> >> >> >> resources (max append bytes, max open zones, and max_active_=
zones).
>> >> >> >> >>
>> >> >> >> >> To create a qcow2 image with zoned format feature, use comma=
nd like
>> >> >> >> >> this:
>> >> >> >> >> qemu-img create -f qcow2 zbc.qcow2 -o size=3D768M \
>> >> >> >> >> -o zone.size=3D64M -o zone.capacity=3D64M -o zone.convention=
al_zones=3D0 \
>> >> >> >> >> -o zone.max_append_bytes=3D4096 -o zone.max_open_zones=3D6 \
>> >> >> >> >> -o zone.max_active_zones=3D8 -o zone.mode=3Dhost-managed
>> >> >> >> >>
>> >> >> >> >> Signed-off-by: Sam Li <faithilikerun@gmail.com>
>> >> >> >> >
>> >> >> >> > [...]
>> >> >> >> >
>> >> >> >> >> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> >> >> >> >> index ca390c5700..e2e0ec21a5 100644
>> >> >> >> >> --- a/qapi/block-core.json
>> >> >> >> >> +++ b/qapi/block-core.json
>> >> >> >> >> @@ -5038,6 +5038,67 @@
>> >> >> >> >>  { 'enum': 'Qcow2CompressionType',
>> >> >> >> >>    'data': [ 'zlib', { 'name': 'zstd', 'if': 'CONFIG_ZSTD' }=
 ] }
>> >> >> >> >>
>> >> >> >> >> +##
>> >> >> >> >> +# @Qcow2ZoneModel:
>> >> >> >> >> +#
>> >> >> >> >> +# Zoned device model used in qcow2 image file
>> >> >> >> >> +#
>> >> >> >> >> +# @host-managed: The host-managed model only allows sequent=
ial write over the
>> >> >> >> >> +#     device zones.
>> >> >> >> >> +#
>> >> >> >> >> +# Since 8.2
>> >> >> >> >> +##
>> >> >> >> >> +{ 'enum': 'Qcow2ZoneModel',
>> >> >> >> >> +  'data': [ 'host-managed'] }
>> >> >> >> >> +
>> >> >> >> >> +##
>> >> >> >> >> +# @Qcow2ZoneHostManaged:
>> >> >> >> >> +#
>> >> >> >> >> +# The host-managed zone model.  It only allows sequential w=
rites.
>> >> >> >> >> +#
>> >> >> >> >> +# @size: Total number of bytes within zones.
>> >> >> >> >
>> >> >> >> > Default?
>> >> >> >
>> >> >> > It should be set by users. No default value provided. If it's un=
set
>> >> >> > then it is zero and an error will be returned.
>> >> >>
>> >> >> If the user must provide @size, why is it optional then?
>> >> >
>> >> > It is not optional when the zone model is host-managed. If it's
>> >> > non-zoned, then we don't care about zone info. I am not sure how to
>> >> > make it unoptional.
>> >>
>> >> We have:
>> >>
>> >>    blockdev-create argument @options of type BlockdevCreateOptions
>> >>
>> >>    BlockdevCreateOptions union branch @qcow2 of type
>> >>    BlockdevCreateOptionsQcow2, union tag member is @driver
>> >>
>> >>    BlockdevCreateOptionsQcow2 optional member @zone of type
>> >>    Qcow2ZoneCreateOptions, default not zoned
>> >>
>> >>    Qcow2ZoneCreateOptions union branch @host-managed of type
>> >>    Qcow2ZoneHostManaged, union tag member is @mode
>> >>
>> >>    Qcow2ZoneHostManaged optional member @size of type size.
>> >>
>> >> Making this member @size mandatory means we must specify it when
>> >> BlockdevCreateOptionsQcow2 member @zone is present and @zone's member
>> >> @mode is "host-managed".  Feels right to me.  Am I missing anything?
>> >
>> > That's right. And the checks when creating such an img can help do
>> > that. It's not specified in the .json file directly.
>>
>> What would break if we did specify it in the QAPI schema directly?
>
> Nothing I think. We can keep the current schema and add a default zone
> size like 131072.

I believe making the member mandatory makes a lot more sense.

I guess we can keep @capacity and @max-append-bytes keep optional *if*
we can come up with sensible defaults.

>> [...]


