Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A245CCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 13:54:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vISLR-0007P7-Hb; Mon, 10 Nov 2025 08:54:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vISAJ-0005W2-NR
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 08:42:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vISAF-0004qq-EM
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 08:42:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762782153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YhdkDoDLzl3DkAisWS71XVkKLFe4gnNlS8xdwLFj87Y=;
 b=clgKMeffRlNNGDJEatWP3JKiaAZQnD/AWadEFJe4w28Cz18cOBKIUeTDbqCC0l9kCiaode
 k0qBCNZlvQqlTjSYBVvUDtfLkiMeFp5XJxsWvUUf6fKlTSefRObgjGMN2mBo5P6nnEFG+I
 JB9bfyLfliL7Bk5zTsUa4oaxYqru+zQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-gL0IHtNlMbGN22ugaF8lmA-1; Mon,
 10 Nov 2025 08:42:32 -0500
X-MC-Unique: gL0IHtNlMbGN22ugaF8lmA-1
X-Mimecast-MFC-AGG-ID: gL0IHtNlMbGN22ugaF8lmA_1762782151
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A45B1956094; Mon, 10 Nov 2025 13:42:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85F5E1800451; Mon, 10 Nov 2025 13:42:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CC7DD21E6A27; Mon, 10 Nov 2025 14:42:27 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Cl=C3=A9ment?= Chigot <chigot@adacore.com>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  kwolf@redhat.com,
 hreitz@redhat.com,  eblake@redhat.com
Subject: Re: [PATCH v2 5/5] vvfat: add support for "fat-size" options
In-Reply-To: <CAJ307EjZwiGj3N93Td9vA0JHyK0COZBXHqv-7cjpxxg+eKiisg@mail.gmail.com>
 (=?utf-8?Q?=22Cl=C3=A9ment?= Chigot"'s message of "Mon, 10 Nov 2025
 14:26:46 +0100")
References: <20251107145327.539481-1-chigot@adacore.com>
 <20251107145327.539481-6-chigot@adacore.com>
 <87zf8umbzh.fsf@pond.sub.org>
 <CAJ307EjObqJ6Pr5N+WrEffTr3pWOpRCKVVamZhCG9ZgwHczVYw@mail.gmail.com>
 <87bjlakpa5.fsf@pond.sub.org>
 <CAJ307EjZwiGj3N93Td9vA0JHyK0COZBXHqv-7cjpxxg+eKiisg@mail.gmail.com>
Date: Mon, 10 Nov 2025 14:42:27 +0100
Message-ID: <87o6paj96k.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

Cl=C3=A9ment Chigot <chigot@adacore.com> writes:

> On Mon, Nov 10, 2025 at 2:09=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> Cl=C3=A9ment Chigot <chigot@adacore.com> writes:
>>
>> > On Mon, Nov 10, 2025 at 11:13=E2=80=AFAM Markus Armbruster <armbru@red=
hat.com> wrote:
>> >>
>> >> Cl=C3=A9ment Chigot <chigot@adacore.com> writes:
>> >>
>> >> > This allows more flexibility to vvfat backend. The values of "Numbe=
r of
>> >> > Heads" and "Sectors per track" are based on SD specifications Part =
2.
>> >> >
>> >> > Due to the FAT architecture, not all sizes are reachable. Therefore=
, it
>> >> > could be round up to the closest available size.
>> >> >
>> >> > FAT32 has not been adjusted and thus still default to 504 Mib.
>> >> >
>> >> > For floppy, only 1440 Kib and 2880 Kib are supported.
>> >> >
>> >> > Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
>> >>
>> >> [...]
>> >>
>> >> > diff --git a/qapi/block-core.json b/qapi/block-core.json
>> >> > index 8a479ba090..0bcb360320 100644
>> >> > --- a/qapi/block-core.json
>> >> > +++ b/qapi/block-core.json
>> >> > @@ -3478,11 +3478,17 @@
>> >> >  #     (default: true)
>> >> >  #     (since 10.2)
>> >> >  #
>> >> > +# @fat-size: size of the device in bytes.  Due to FAT underlying
>> >> > +#     architecture, this size can be rounded up to the closest val=
id
>> >> > +#     size.
>> >> > +#     (since 10.2)
>> >> > +#
>> >>
>> >> Can you explain again why you moved from @size to @fat-size?
>> >
>> > Just to be sure, you mean in the above comment, in the commit message =
or both ?
>>
>> Just to me, because I'm not sure I like the change, but that may well be
>> due to a lack of understanding of your reasons.
>
> Naming `fat-size` instead of `size` ensures the parameter is only
> recognized by the vvfat backend. In particular, it will be refused by
> the default raw format, avoiding confusion:
>  "-drive file=3Dfat:<path>,size=3D256M" results in a 504M FAT disk
> truncated to 256M, raw format being implicit.
>  "-drive file=3Dfat:<path>,fat-size=3D256M" is refused. "fat-size" is
> unsupported by raw format.

I figure throwing in format=3Draw to make raw format explicit doesn't
change anything.  Correct?

>  "-drive file=3Dfat:<path>,format=3Dvvfat,fat-size=3D256M" results in a 2=
56M FAT disk.
>  "-drive file=3Dfat:<path>,format=3Dvvfat,size=3D256M" is refused. "size"=
 is
> unsupported by vvfat format.

If it was called @size, what behavior would we get?  Just two cases, I
think:

1. With raw format:

    -drive file=3Dfat:<path>,size=3D256M

2. Without raw format:

    -drive file=3Dfat:<path>,format=3Dvvfat,size=3D256M


