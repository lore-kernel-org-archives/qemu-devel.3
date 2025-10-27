Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E56FDCCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 12:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDM36-0000BN-3T; Mon, 27 Oct 2025 08:10:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vDM2h-0008T0-4r
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:09:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vDM2c-0001i3-V7
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761566973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VV2qfzYNGieh7fNYiQZAxOaOYJxsEqdQvrGy72p30uw=;
 b=RRTXJJUDdXZWUOSn11/BFFArnoreJn/R3j2WtMM9Xp2AN6fkvyQtly2xmOj1tpVqmRGaqf
 Q57E9tgHoUAC3hMVT8Kyd1PUXAE9ScpqK6JaQFhlWaMsEZfszM84qmMvQoJP7aVa94qOfC
 5Aota2Hak+RGIO7zGmJhglr3CqmtvHs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-4mEBJgWEMTaUmD7-iAJJeg-1; Mon,
 27 Oct 2025 08:09:30 -0400
X-MC-Unique: 4mEBJgWEMTaUmD7-iAJJeg-1
X-Mimecast-MFC-AGG-ID: 4mEBJgWEMTaUmD7-iAJJeg_1761566969
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4DE7D18007EB; Mon, 27 Oct 2025 12:09:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9578B1955F1B; Mon, 27 Oct 2025 12:09:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1092A21E6A27; Mon, 27 Oct 2025 13:09:26 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Cl=C3=A9ment?= Chigot <chigot@adacore.com>
Cc: Kevin Wolf <kwolf@redhat.com>,  qemu-devel@nongnu.org,
 hreitz@redhat.com,  qemu-block@nongnu.org
Subject: Re: [PATCH 5/5] vvfat: add support for "size" options
In-Reply-To: <CAJ307EjFXNyEwDTeXEwdc02PxBLHGENbPJCM+-v_6FRQ2VYEcw@mail.gmail.com>
 (=?utf-8?Q?=22Cl=C3=A9ment?= Chigot"'s message of "Fri, 24 Oct 2025
 11:23:00 +0200")
References: <20250903075721.77623-1-chigot@adacore.com>
 <20250903075721.77623-6-chigot@adacore.com>
 <aPqCJRNCjxcZ6jq5@redhat.com> <87ms5g3dnq.fsf@pond.sub.org>
 <CAJ307EjFXNyEwDTeXEwdc02PxBLHGENbPJCM+-v_6FRQ2VYEcw@mail.gmail.com>
Date: Mon, 27 Oct 2025 13:09:26 +0100
Message-ID: <87ms5cmtqh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> On Fri, Oct 24, 2025 at 10:35=E2=80=AFAM Markus Armbruster <armbru@redhat=
.com> wrote:
>>
>> Kevin Wolf <kwolf@redhat.com> writes:
>>
>> > Am 03.09.2025 um 09:57 hat Cl=C3=A9ment Chigot geschrieben:
>> >> This allows more flexibility to vvfat backend. The value for "Number =
of
>> >> Heads" and "Sectors per track" are based on SD specifications Part 2.
>>
>> This is too terse to remind me of how vvfat picks cylinders, heads, and
>> sectors before this patch, so I need to go dig through the source code.
>> I figure it depends on configuration parameters @floppy and @fat-type
>> like this:
>>
>>     floppy  fat-type    cyls heads secs   cyls*heads*secs*512
>>     false      12         64    16   63         31.5 MiB
>>     false      16       1024    16   63        504   MiB
>>     false      32       1024    16   63        504   MiB
>>     true       12         80     2   18       1440   KiB
>>     true       16         80     2   36       2880   KiB
>>     true       32         80     2   36       2880   KiB
>>
>> How exactly does the new parameter @size change this?
>
> My prime goal was to create a 256 Mib VVFAT disk. As you can see,
> today for hard-disks there are only two possibilities: 31.5 Mib or 504
> Mib. Hence, I've introduced the option `size=3Dxxx` to allow more
> granular choices.
> This option changes how cyls, heads and secs parameters are computed
> to be as closed as possible of its value.
>
> I did try to keep it simple. I could have introduced options to select
> cylinders, heads, etc. But I think "size=3Dxxx" would be more intuitive.
> There are also approximations made, as not all sizes can be reached. I
> didn't add errors or warnings for them. I'm fine adding them.

I don't have an opinion on whether we should support more sizes and/or
provide full control over CHS geometry.

>> >> Some limitations remains, the size parameter is recognized only when
>> >> "format=3Dvvfat" is passed. In particular, "format=3Draw,size=3Dxxx" =
is
>> >> keeping the previously hardcoded value: 504MB for FAT16 and 32 MB for
>> >> FAT12. FAT32 has not been adjusted and thus still default to 504MB.
>>
>> 31.5MiB unless I'm mistaken.
>
> True, I will fix it.
>
>> I'm not sure what you're trying to convey in this paragraph.  As far as
>> I can tell, you're adding a @size parameter to vvfat, so of course it
>> doesn't affect raw.
>
> Yes, but AFAICT, `if=3Dsd,format=3Draw` will result in vvfat backend being
> called. I didn't manage to make the new option work with
> `if=3Dsd,format=3Draw,size=3D256Mb`. Thus, when the "size" option is not
> provided, I keep the previous value (those for your above comment).
> Hence this paragraph to mostly warn people about the current
> limitation.

Are you talking about -drive?

Complete examples, please.

I'm confused about the connection between SD (from if=3Dsd here, and "SD
specification" above) and vvfat.  SD is a frontend.  vvfat is a backend.

[...]


