Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F6BCCFA18
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 07:44:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIj2R-0002Mq-Hy; Tue, 11 Nov 2025 02:43:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vIj2P-0002JJ-83
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 02:43:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vIj2N-0005sb-Ie
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 02:43:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762847014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kn+uPIo+fXfvkXVA00Z+HGdj2mK8aMjFPIAB7ZovXZg=;
 b=iTo3p0iG1qeOd57/34TVoSv9TxJQ3QDDUVvOzf31n8HxijXwLHdII4eNr5C4GLNgOE73LW
 iDTKeHlI4onbrRapc1ll5vdcteJ/Nf+19AKk39bzCLxeH9Nwtav0zb1cF0FOfOqUkYDHvf
 Ag7ACt8cjkFIhm42Mpb4jhq+2ARBV+M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-Rt0ld-PjOmqyJgaFLI3pzw-1; Tue,
 11 Nov 2025 02:43:31 -0500
X-MC-Unique: Rt0ld-PjOmqyJgaFLI3pzw-1
X-Mimecast-MFC-AGG-ID: Rt0ld-PjOmqyJgaFLI3pzw_1762847010
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 43B361800650; Tue, 11 Nov 2025 07:43:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92F541800451; Tue, 11 Nov 2025 07:43:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E8A3621E6A27; Tue, 11 Nov 2025 08:43:26 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>,  =?utf-8?Q?Cl=C3=A9ment?= Chigot
 <chigot@adacore.com>,  qemu-block@nongnu.org,  qemu-devel@nongnu.org,
 hreitz@redhat.com,  eblake@redhat.com
Subject: Re: [PATCH v2 1/5] vvfat: introduce partitioned option
In-Reply-To: <aRH_2gcYOH31UB38@redhat.com> (Kevin Wolf's message of "Mon, 10
 Nov 2025 16:08:10 +0100")
References: <20251107145327.539481-1-chigot@adacore.com>
 <20251107145327.539481-2-chigot@adacore.com>
 <878qgenqum.fsf@pond.sub.org>
 <CAJ307Eg7x_rKb5qybgW3XxAKLP=1ds524gqgXettv2cZ8WTMww@mail.gmail.com>
 <757f66d0-625c-9d1b-5090-3d5210903173@eik.bme.hu>
 <87346mkos9.fsf@pond.sub.org> <aRH_2gcYOH31UB38@redhat.com>
Date: Tue, 11 Nov 2025 08:43:26 +0100
Message-ID: <87ecq5f201.fsf@pond.sub.org>
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

Kevin Wolf <kwolf@redhat.com> writes:

> Am 10.11.2025 um 14:20 hat Markus Armbruster geschrieben:
>> BALATON Zoltan <balaton@eik.bme.hu> writes:
>>=20
>> > On Mon, 10 Nov 2025, Cl=C3=A9ment Chigot wrote:
>> >> On Mon, Nov 10, 2025 at 11:07=E2=80=AFAM Markus Armbruster <armbru@re=
dhat.com> wrote:
>> >>>
>> >>> Cl=C3=A9ment Chigot <chigot@adacore.com> writes:
>> >>>
>> >>>> This option tells whether a hard disk should be partitioned or not.=
 It
>> >>>> defaults to true and have the prime effect of preventing a master b=
oot
>> >>>> record (MBR) to be initialized.
>> >>>>
>> >>>> This is useful as some operating system (QNX, Rtems) don't
>> >>>> recognized FAT mounted disks (especially SD cards) if a MBR is pres=
ent.
>> >>>>
>> >>>> Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>

[...]

>> >>> Not sure I like "partitioned".  Is a disk with an MBR and a partition
>> >>> table contraining a single partition partitioned?  Call it "mbr"?
>> >>
>> >> It used to be called "mbr/no-mbr" but Kevin suggested renaming it in
>> >> V1. Honestly I'm fine with both options:
>> >> - Technically, the option prevents MBR which has a side effect for
>> >> preventing partition tables
>>=20
>> Yes, because the partition table is part of the MBR.  I'd rather name
>> the option after the entire thing it controls, not one of its parts.
>>=20
>> >> - Even it has a single partition, I think it makes sense to call a
>> >> disk "partitioned" as long as it has a partition table
>> >>
>> >> But I'm not that familiar with disk formats, etc. I'll let you decide
>> >> with Kevin, which one you prefer.
>>=20
>> Kevin is the maintainer, I just serve as advisor here.
>
> I figured that the meaning of "partitioned" is easier to understand for
> a casual user than having or not having an MBR ("I don't want to boot
> from this disk, why would I care about a boot record?").

Fair point.

Possible counter-points:

* The default is almost always right for the casual user.  The
  exception, as far as I understand, is certain guest OSes refuse to
  play ball with certain devices when they have an MBR.

* The configuration interface isn't exactly casual-user-friendly to
  begin with.  @fat-type, what's that, and why do I care?  @floppy,
  what's that, and why do I care?

Anyway, you decide.

> But if people think that "mbr" is better, that's fine with me.
>
> The only thing I really didn't want is the negative "no-mbr" and the
> double negation in "no-mbr=3Doff" that comes with it.

Yes, negative names should definitely be avoided for boolean options.

[...]


