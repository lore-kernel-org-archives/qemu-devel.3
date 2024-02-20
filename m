Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E9FC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 09:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcMcv-0000Ew-Pr; Tue, 20 Feb 2024 04:41:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcMcu-0000Dx-BP
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 04:41:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcMcs-0008Bd-Ay
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 04:41:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708422081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GoYgYdgWWT/rJFB3aEn2jIfS+g6huycDtVnCpwKHaBM=;
 b=T4VEsJ07eWU6GfiLdrV4k5QTUPZdH/uR6E6FvvOpakWNfZhGhRmd78jc+QenCqiuG0/cY4
 bobV6hTJ/zsTiq1+nQySeG0hmYf3caH6/BBUQl/8FY70RwQi/KcD+rNiQs1v+kkJ4EUrva
 kxfoH/3C5oyPw6Ad+as9P9cb3VFKFUQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-k1K37WYkM8mAbxHQHLAf5w-1; Tue,
 20 Feb 2024 04:41:17 -0500
X-MC-Unique: k1K37WYkM8mAbxHQHLAf5w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0EB6285F985;
 Tue, 20 Feb 2024 09:41:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E42E1C060AF;
 Tue, 20 Feb 2024 09:41:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 79A2521E66C8; Tue, 20 Feb 2024 10:41:15 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Yong Huang <yong.huang@smartx.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,  Daniel P
 . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Hanna
 Reitz <hreitz@redhat.com>,  Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v4 2/7] qapi: Make parameter 'file' optional for
 BlockdevCreateOptionsLUKS
In-Reply-To: <CAK9dgmaD_3vbOvv9cFzPq-BzQ7xejB-McaD8C9v4Wt_0xnF9kw@mail.gmail.com>
 (Yong Huang's message of "Tue, 20 Feb 2024 17:13:46 +0800")
References: <cover.1706586786.git.yong.huang@smartx.com>
 <af7253711254128efbc37b25fb5c47b851367ce7.1706586786.git.yong.huang@smartx.com>
 <87zfvwjzzd.fsf@pond.sub.org>
 <CAK9dgmY0rExYg+hfTY_okNvTTArZdn60jsWjCABgbbAG6XZiDw@mail.gmail.com>
 <87wmqzcy5h.fsf@pond.sub.org>
 <CAK9dgmaD_3vbOvv9cFzPq-BzQ7xejB-McaD8C9v4Wt_0xnF9kw@mail.gmail.com>
Date: Tue, 20 Feb 2024 10:41:15 +0100
Message-ID: <87edd7cw1w.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

Yong Huang <yong.huang@smartx.com> writes:

> On Tue, Feb 20, 2024 at 4:56=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
>
>> Yong Huang <yong.huang@smartx.com> writes:
>>
>> > On Tue, Feb 20, 2024 at 2:31=E2=80=AFPM Markus Armbruster <armbru@redh=
at.com>
>> wrote:
>> >
>> >> yong.huang@smartx.com writes:
>> >>
>> >> > From: Hyman Huang <yong.huang@smartx.com>
>> >> >
>> >> > To support detached LUKS header creation, make the existing 'file'
>> >> > field in BlockdevCreateOptionsLUKS optional.
>> >> >
>> >> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
>> >> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> >>
>> >> [...]
>> >>
>> >> > diff --git a/qapi/block-core.json b/qapi/block-core.json
>> >> > index ae604c6019..69a88d613d 100644
>> >> > --- a/qapi/block-core.json
>> >> > +++ b/qapi/block-core.json
>> >> > @@ -4957,7 +4957,8 @@
>> >> >  #
>> >> >  # Driver specific image creation options for LUKS.
>> >> >  #
>> >> > -# @file: Node to create the image format on
>> >> > +# @file: Node to create the image format on, mandatory except when
>> >> > +#        'preallocation' is not requested
>> >>
>> >> You mean when @preallocation is "off"?
>> >>
>> >> Cases:
>> >>
>> >> 1. @file is mandatory
>> >>
>> >
>> > When @preallocation is specified to PREALLOC_MODE_ON, file
>> > is mandatory because preallocation aims to act on payload data that
>> > @file holds.
>> >
>> >
>> >> 2. @file is optional and present
>> >>
>> >
>> > When @preallocation is not specified or equals to PREALLOC_MODE_OFF,
>> > @file if optional.
>> > If @file present=EF=BC=8Cthere are two cases:
>> > 1. @header is absent,  the creation process degenerate to the origin a=
ction.
>> > 2. @header is present,  the creation process would trunk the payload d=
ata
>> > image that @file holds and do the LUKS formatting on the image that
>> > @header refers;
>> >
>> >
>> >>
>> >> 3. @file is optional and absent
>> >>
>> >
>> > When @preallocation is not specified or equals to PREALLOC_MODE_OFF,
>> > @file if optional.
>> > If @file is absent, do the LUKS formatting only.
>> > Note that Either the parameter 'header' or 'file' must be specified.
>> >
>> > Here's my interpretation; do let me know if any of the points are off =
or
>> > need to be refactored.
>> >
>> >
>> >>
>> >> Ignorant question: behavior in each case?
>>
>> Thanks!  Would it make sense to work the above into the documentation?
>>
>
> You mean adding the above interpretation to the following patch?
>
> https://patchew.org/QEMU/c2049499aa05758b4cf18dcec942694ed454a980.1708358=
310.git.yong.huang@smartx.com/

To the doc comments.

The doc comments are the source code for the "QEMU QMP Reference
Manual".  That manual should fully explain what the QMP commands do.

Information on how to best use the commands, or an introduction to
concepts behind the commands can also be useful, but is often a bad fit
for a *reference* manual.  We can put it elsewhere then.

Makes sense?


