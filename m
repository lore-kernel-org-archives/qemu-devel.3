Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B22CCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 15:22:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vITiT-0003uK-EC; Mon, 10 Nov 2025 10:22:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vIThe-0003Wx-P1
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:21:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vIThX-0004ti-M1
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:21:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762788061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3k+rLrnrlSkofEu1Jhi8CHWFopk0vbU9Y9WKrdnwfzM=;
 b=aNN0RC7VFAyz4Ir1KFaRxqIy5GqTxxYHACj/M7qnyqr9UvLUp8G/Tt0vbww9SZhEbS2GKZ
 lReMgb864VfqkxeW0aX9dEo6a0KnljL35TuG4Wi34C7oZYq/ucMdI3cHb05FKyJoX+FzbB
 ww5Ds18xrNWchvm7+M9mrDEzRQLwV4M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-s0GvmK4ENmahmVyPPCu8UQ-1; Mon,
 10 Nov 2025 10:20:58 -0500
X-MC-Unique: s0GvmK4ENmahmVyPPCu8UQ-1
X-Mimecast-MFC-AGG-ID: s0GvmK4ENmahmVyPPCu8UQ_1762788057
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8911F193E8B7; Mon, 10 Nov 2025 15:20:57 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.209])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 18F671800451; Mon, 10 Nov 2025 15:20:54 +0000 (UTC)
Date: Mon, 10 Nov 2025 16:20:52 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?iso-8859-1?Q?Cl=E9ment?= Chigot <chigot@adacore.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 eblake@redhat.com
Subject: Re: [PATCH v2 5/5] vvfat: add support for "fat-size" options
Message-ID: <aRIC1NZXQUxkR7iR@redhat.com>
References: <20251107145327.539481-1-chigot@adacore.com>
 <20251107145327.539481-6-chigot@adacore.com>
 <87zf8umbzh.fsf@pond.sub.org>
 <CAJ307EjObqJ6Pr5N+WrEffTr3pWOpRCKVVamZhCG9ZgwHczVYw@mail.gmail.com>
 <87bjlakpa5.fsf@pond.sub.org>
 <CAJ307EjZwiGj3N93Td9vA0JHyK0COZBXHqv-7cjpxxg+eKiisg@mail.gmail.com>
 <87o6paj96k.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o6paj96k.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Am 10.11.2025 um 14:42 hat Markus Armbruster geschrieben:
> Clément Chigot <chigot@adacore.com> writes:
> 
> > On Mon, Nov 10, 2025 at 2:09 PM Markus Armbruster <armbru@redhat.com> wrote:
> >>
> >> Clément Chigot <chigot@adacore.com> writes:
> >>
> >> > On Mon, Nov 10, 2025 at 11:13 AM Markus Armbruster <armbru@redhat.com> wrote:
> >> >>
> >> >> Clément Chigot <chigot@adacore.com> writes:
> >> >>
> >> >> > This allows more flexibility to vvfat backend. The values of "Number of
> >> >> > Heads" and "Sectors per track" are based on SD specifications Part 2.
> >> >> >
> >> >> > Due to the FAT architecture, not all sizes are reachable. Therefore, it
> >> >> > could be round up to the closest available size.
> >> >> >
> >> >> > FAT32 has not been adjusted and thus still default to 504 Mib.
> >> >> >
> >> >> > For floppy, only 1440 Kib and 2880 Kib are supported.
> >> >> >
> >> >> > Signed-off-by: Clément Chigot <chigot@adacore.com>
> >> >>
> >> >> [...]
> >> >>
> >> >> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> >> >> > index 8a479ba090..0bcb360320 100644
> >> >> > --- a/qapi/block-core.json
> >> >> > +++ b/qapi/block-core.json
> >> >> > @@ -3478,11 +3478,17 @@
> >> >> >  #     (default: true)
> >> >> >  #     (since 10.2)
> >> >> >  #
> >> >> > +# @fat-size: size of the device in bytes.  Due to FAT underlying
> >> >> > +#     architecture, this size can be rounded up to the closest valid
> >> >> > +#     size.
> >> >> > +#     (since 10.2)
> >> >> > +#
> >> >>
> >> >> Can you explain again why you moved from @size to @fat-size?
> >> >
> >> > Just to be sure, you mean in the above comment, in the commit message or both ?
> >>
> >> Just to me, because I'm not sure I like the change, but that may well be
> >> due to a lack of understanding of your reasons.
> >
> > Naming `fat-size` instead of `size` ensures the parameter is only
> > recognized by the vvfat backend. In particular, it will be refused by
> > the default raw format, avoiding confusion:
> >  "-drive file=fat:<path>,size=256M" results in a 504M FAT disk
> > truncated to 256M, raw format being implicit.
> >  "-drive file=fat:<path>,fat-size=256M" is refused. "fat-size" is
> > unsupported by raw format.
> 
> I figure throwing in format=raw to make raw format explicit doesn't
> change anything.  Correct?
> 
> >  "-drive file=fat:<path>,format=vvfat,fat-size=256M" results in a 256M FAT disk.
> >  "-drive file=fat:<path>,format=vvfat,size=256M" is refused. "size" is
> > unsupported by vvfat format.
> 
> If it was called @size, what behavior would we get?  Just two cases, I
> think:
> 
> 1. With raw format:
> 
>     -drive file=fat:<path>,size=256M

You'd silently get a 504 MiB filesystem truncated to 256 MiB (i.e. a
corrupted file system). It's quite easy to forget format=vvfat, so
something that initially looks like it might be working is not a great
result for this user error.

> 2. Without raw format:
> 
>     -drive file=fat:<path>,format=vvfat,size=256M

This does the thing that you actually want, a 256 MiB file system.

I suggested to rename the vvfat option in v1 to make accidents at least
a bit less likely. I'm not completely sure if "fat-size" is the best
name, though, as it sounds as if it referred to the FAT itself instead
of the FAT filesystem. Maybe "fs-size"?

Kevin


