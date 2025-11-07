Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1983ECCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 08:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHHUW-0006PX-Mq; Fri, 07 Nov 2025 03:06:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vHHUV-0006P3-40
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 03:06:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vHHUS-0001W0-Tt
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 03:06:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762502796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OMPTlux4GQiWlk+tfespG8VCNX1mSidRe58c2R+4YT4=;
 b=dTbHLUSYG3edXbyDHTfelvEFiL2TPxkjglNXtU5/hZIZ1krdo/N+wvM+d+Xv3gxF3JQuWw
 REUzQUm/GsSEt0Ta1tRC1XHV3IevA5meckYDx+2huJRodyjnlckrWnpwfNFV8PGOKGuENX
 3q/7fXJR5MiveDgQ2RP2CUW/F+Tu/DQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-I0jSD1kRPuyqVurHKGmO8g-1; Fri,
 07 Nov 2025 03:06:32 -0500
X-MC-Unique: I0jSD1kRPuyqVurHKGmO8g-1
X-Mimecast-MFC-AGG-ID: I0jSD1kRPuyqVurHKGmO8g_1762502791
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5140C1800673; Fri,  7 Nov 2025 08:06:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B2C7D19560A7; Fri,  7 Nov 2025 08:06:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 24C9F21E6A27; Fri, 07 Nov 2025 09:06:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: =?utf-8?Q?Cl=C3=A9ment?= Chigot <chigot@adacore.com>,
 qemu-devel@nongnu.org, hreitz@redhat.com,  qemu-block@nongnu.org
Subject: Re: [PATCH 5/5] vvfat: add support for "size" options
In-Reply-To: <aQsafmFOrfEmOc0M@redhat.com> (Kevin Wolf's message of "Wed, 5
 Nov 2025 10:35:58 +0100")
References: <20250903075721.77623-1-chigot@adacore.com>
 <20250903075721.77623-6-chigot@adacore.com>
 <aPqCJRNCjxcZ6jq5@redhat.com> <874ir9ot1a.fsf@pond.sub.org>
 <aQsafmFOrfEmOc0M@redhat.com>
Date: Fri, 07 Nov 2025 09:06:28 +0100
Message-ID: <875xbme06z.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
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

> Am 05.11.2025 um 08:08 hat Markus Armbruster geschrieben:
>> Kevin Wolf <kwolf@redhat.com> writes:
>>=20
>> [...]
>>=20
>> > To me it looks a bit like what we really want is an enum for floppy
>> > sizes (though is there any real reason why we have only those two?), b=
ut
>> > an arbitrary size for hard disks.
>> >
>> > Without the enum, obviously, users could specify 1440k and that would =
do
>> > the right thing. Maybe special casing whatever 1.44M and 2.88M result
>> > in and translating them into 1440k and 2880k could be more justifiable
>> > than special casing 1M and 2M, but it would still be ugly.
>> >
>> > Markus, do you have any advice how this should be represented in QAPI?
>>=20
>> Still want answers here?
>
> Yes, I'm still not sure how we could best represent both hard disk and
> floppy sizes in vvfat in a way that isn't completely counterintuitive
> for users, that also isn't just arbitrary magic and that works on the
> command line.
>
> Unless the need for different sizes has gone away, but I don't think we
> found any other solution for the problem that would not require a
> configurable disk/file system size?

Let me recap the problem.  Please correct my misunderstandings, if any.

Hard disks can have almost arbitrary sizes.  Almost, because it still
needs to be a multiple of the block size.

Floppy disks have one of a small set of well-known sizes.

I vaguely recall that we generally derive the device's actual size from
the backend's size.

Some devices reject certain sizes.  For instance, SD cards require a
power of 2.

Most devices seem to accept anything.  I can create an IDE, SCSI, or
floppy disk backed by a raw image of one byte.  I have no idea how it
would behave.

As is, the vvfat backend can only do certain sizes, configurable with
parameters @floppy and @fat-type.  They work for floppies, but not for
SD cards, since they're not powers of two.

Instead of deriving size and CHS from @floppy and @fat-type, Cl=C3=A9ment
proposes to specify the size (and derive fat-type and CHS[*]?).

In QMP, we specify the size in bytes.  This is fine regardless of size;
management applications don't mind sending things like "size": 1474560.

In HMP and the command line, big byte sizes are inconvenient.  That's
why we support suffixes there.  size=3D256M is a fine way to pick an SD
card's size.

The size suffixes seem inconvenient for floppies, though.  For instance,
2 heads * 80 tracks * 18 sectors * 512 bytes =3D 1474560 bytes =3D 1440
KiBytes, but size=3D1.44M does not work: 1.44 MiBytes =3D 1509949.44 Bytes.
However, size=3D1440K does.

This leads me to suggest to simply stick to numeric size, and use
appropriate suffixes.  These are obvious enough for anything but
floppies.  So advise users "use K for floppies"[**].

If this isn't good enough, I can help you explore fancier parts of QAPI,
such as alternate types.




[*] I guess we could support specifying an optional fat-type in addition
to size, and derive only CHS then.

[**] Even for a hypothetical floppy with an odd number of 512 byte
sectors: .5K works, because .5 * 1024 is an integer.


