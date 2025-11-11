Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013FECCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 08:01:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIjIP-0002iE-Cy; Tue, 11 Nov 2025 03:00:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vIjIF-0002YZ-9t
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 03:00:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vIjIC-00007d-Rp
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 02:59:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762847995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=khMXxaKP8rySu6ePekF98pwdwuMxox2W3quzWJd+qeY=;
 b=Lv1VhWEeSk6LB4EanP+l8PE5ENrUwoXX1qxbkUnYU/soQ7iNplAZwCYW7sRlretz2NoKfA
 xZ9Adm1qlEFK2MOnyWLIRaHDfhFA4eXotYyZmYd8ZCi1lJN+4kDaipGbMqwELloIda6/1V
 BXbtQ4NJDS4HJ0UP5ZRh4r2aSvIs9Og=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-127-gZLj6ac6NIqKZTS_3NWR5w-1; Tue,
 11 Nov 2025 02:59:52 -0500
X-MC-Unique: gZLj6ac6NIqKZTS_3NWR5w-1
X-Mimecast-MFC-AGG-ID: gZLj6ac6NIqKZTS_3NWR5w_1762847991
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 07433195608A; Tue, 11 Nov 2025 07:59:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2648E30044E0; Tue, 11 Nov 2025 07:59:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 74AA021E6A27; Tue, 11 Nov 2025 08:59:47 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  =?utf-8?Q?Cl=C3=A9ment?= Chigot
 <chigot@adacore.com>,  qemu-block@nongnu.org,  qemu-devel@nongnu.org,
 hreitz@redhat.com,  eblake@redhat.com
Subject: Re: [PATCH v2 5/5] vvfat: add support for "fat-size" options
In-Reply-To: <aRIC1NZXQUxkR7iR@redhat.com> (Kevin Wolf's message of "Mon, 10
 Nov 2025 16:20:52 +0100")
References: <20251107145327.539481-1-chigot@adacore.com>
 <20251107145327.539481-6-chigot@adacore.com>
 <87zf8umbzh.fsf@pond.sub.org>
 <CAJ307EjObqJ6Pr5N+WrEffTr3pWOpRCKVVamZhCG9ZgwHczVYw@mail.gmail.com>
 <87bjlakpa5.fsf@pond.sub.org>
 <CAJ307EjZwiGj3N93Td9vA0JHyK0COZBXHqv-7cjpxxg+eKiisg@mail.gmail.com>
 <87o6paj96k.fsf@pond.sub.org> <aRIC1NZXQUxkR7iR@redhat.com>
Date: Tue, 11 Nov 2025 08:59:47 +0100
Message-ID: <87346lf18s.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Kevin Wolf <kwolf@redhat.com> writes:

> Am 10.11.2025 um 14:42 hat Markus Armbruster geschrieben:
>> Cl=C3=A9ment Chigot <chigot@adacore.com> writes:
>>=20
>> > On Mon, Nov 10, 2025 at 2:09=E2=80=AFPM Markus Armbruster <armbru@redh=
at.com> wrote:
>> >>
>> >> Cl=C3=A9ment Chigot <chigot@adacore.com> writes:
>> >>
>> >> > On Mon, Nov 10, 2025 at 11:13=E2=80=AFAM Markus Armbruster <armbru@=
redhat.com> wrote:
>> >> >>
>> >> >> Cl=C3=A9ment Chigot <chigot@adacore.com> writes:
>> >> >>
>> >> >> > This allows more flexibility to vvfat backend. The values of "Nu=
mber of
>> >> >> > Heads" and "Sectors per track" are based on SD specifications Pa=
rt 2.
>> >> >> >
>> >> >> > Due to the FAT architecture, not all sizes are reachable. Theref=
ore, it
>> >> >> > could be round up to the closest available size.
>> >> >> >
>> >> >> > FAT32 has not been adjusted and thus still default to 504 Mib.
>> >> >> >
>> >> >> > For floppy, only 1440 Kib and 2880 Kib are supported.
>> >> >> >
>> >> >> > Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
>> >> >>
>> >> >> [...]
>> >> >>
>> >> >> > diff --git a/qapi/block-core.json b/qapi/block-core.json
>> >> >> > index 8a479ba090..0bcb360320 100644
>> >> >> > --- a/qapi/block-core.json
>> >> >> > +++ b/qapi/block-core.json
>> >> >> > @@ -3478,11 +3478,17 @@
>> >> >> >  #     (default: true)
>> >> >> >  #     (since 10.2)
>> >> >> >  #
>> >> >> > +# @fat-size: size of the device in bytes.  Due to FAT underlying
>> >> >> > +#     architecture, this size can be rounded up to the closest =
valid
>> >> >> > +#     size.
>> >> >> > +#     (since 10.2)
>> >> >> > +#
>> >> >>
>> >> >> Can you explain again why you moved from @size to @fat-size?
>> >> >
>> >> > Just to be sure, you mean in the above comment, in the commit messa=
ge or both ?
>> >>
>> >> Just to me, because I'm not sure I like the change, but that may well=
 be
>> >> due to a lack of understanding of your reasons.
>> >
>> > Naming `fat-size` instead of `size` ensures the parameter is only
>> > recognized by the vvfat backend. In particular, it will be refused by
>> > the default raw format, avoiding confusion:
>> >  "-drive file=3Dfat:<path>,size=3D256M" results in a 504M FAT disk
>> > truncated to 256M, raw format being implicit.
>> >  "-drive file=3Dfat:<path>,fat-size=3D256M" is refused. "fat-size" is
>> > unsupported by raw format.
>>=20
>> I figure throwing in format=3Draw to make raw format explicit doesn't
>> change anything.  Correct?
>>=20
>> >  "-drive file=3Dfat:<path>,format=3Dvvfat,fat-size=3D256M" results in =
a 256M FAT disk.
>> >  "-drive file=3Dfat:<path>,format=3Dvvfat,size=3D256M" is refused. "si=
ze" is
>> > unsupported by vvfat format.
>>=20
>> If it was called @size, what behavior would we get?  Just two cases, I
>> think:
>>=20
>> 1. With raw format:
>>=20
>>     -drive file=3Dfat:<path>,size=3D256M
>
> You'd silently get a 504 MiB filesystem truncated to 256 MiB (i.e. a
> corrupted file system). It's quite easy to forget format=3Dvvfat, so
> something that initially looks like it might be working is not a great
> result for this user error.
>
>> 2. Without raw format:
>>=20
>>     -drive file=3Dfat:<path>,format=3Dvvfat,size=3D256M
>
> This does the thing that you actually want, a 256 MiB file system.
>
> I suggested to rename the vvfat option in v1 to make accidents at least
> a bit less likely.

Valid point.

The "raw" format's slicing feature has dangerous sharp edges.

I'm all for with giving users poweful tools, even if they're dangerous.
However, as we can see here, this one can interact badly with the
implicit use of "raw".  Adding the slicing feature to "raw" may have
been a mistake, and naming one of its configuration options "size"
definitely was a mistake.  Something like @slice-offset and @slize-size
would've been safer.

Anyway, the interface is set in stone now.

>                    I'm not completely sure if "fat-size" is the best
> name, though, as it sounds as if it referred to the FAT itself instead
> of the FAT filesystem. Maybe "fs-size"?

Better.  It's the size of the image, though, not the size of the
filesystem.  They are the same only if there's no MBR.


