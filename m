Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA235CCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 12:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJAQz-0000Y5-4I; Wed, 12 Nov 2025 07:58:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vJ9yf-0000j4-P0
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 07:29:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vJ9yc-0005eM-QG
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 07:29:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762950570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xpzpb6IL2uF0SKnJ5KNKUpb4zHYen66jHpsBN/CbHOw=;
 b=ENj8CqTQulEShAYJPIWzflFwj+RsULx79cdoOh0y6rT/Dc2E9ditHpwChh5FGRtAUXGDeV
 g95GVciTqY4kHQOJqmaq69ktp08bWoz+vUGFKtC600aAmY/pbqg3faR0+JkklJhSynDn0A
 FzVU6WZnZCUk8ctPiTslQ8fUXHMu5mg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-df0m1b7XMmiifnmfZ64VFA-1; Wed,
 12 Nov 2025 07:29:24 -0500
X-MC-Unique: df0m1b7XMmiifnmfZ64VFA-1
X-Mimecast-MFC-AGG-ID: df0m1b7XMmiifnmfZ64VFA_1762950564
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 93313180049F; Wed, 12 Nov 2025 12:29:23 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.98])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94D0119560A2; Wed, 12 Nov 2025 12:29:20 +0000 (UTC)
Date: Wed, 12 Nov 2025 13:29:17 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: =?iso-8859-1?Q?Cl=E9ment?= Chigot <chigot@adacore.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, hreitz@redhat.com, eblake@redhat.com
Subject: Re: [PATCH v2 5/5] vvfat: add support for "fat-size" options
Message-ID: <aRR9nVYWRWS0cOXs@redhat.com>
References: <20251107145327.539481-6-chigot@adacore.com>
 <87zf8umbzh.fsf@pond.sub.org>
 <CAJ307EjObqJ6Pr5N+WrEffTr3pWOpRCKVVamZhCG9ZgwHczVYw@mail.gmail.com>
 <87bjlakpa5.fsf@pond.sub.org>
 <CAJ307EjZwiGj3N93Td9vA0JHyK0COZBXHqv-7cjpxxg+eKiisg@mail.gmail.com>
 <87o6paj96k.fsf@pond.sub.org> <aRIC1NZXQUxkR7iR@redhat.com>
 <f301fcab-a7d6-1d89-aa56-52397f0d940a@eik.bme.hu>
 <aRITWJo6R_oG9t7R@redhat.com>
 <CAJ307Ej66N2y-NjD=bs5R5ADjTaf=2Lv=510U+uQKuemJcNLgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ307Ej66N2y-NjD=bs5R5ADjTaf=2Lv=510U+uQKuemJcNLgg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Am 12.11.2025 um 10:50 hat Clément Chigot geschrieben:
> On Mon, Nov 10, 2025 at 5:31 PM Kevin Wolf <kwolf@redhat.com> wrote:
> >
> > Am 10.11.2025 um 16:36 hat BALATON Zoltan geschrieben:
> > > On Mon, 10 Nov 2025, Kevin Wolf wrote:
> > > > Am 10.11.2025 um 14:42 hat Markus Armbruster geschrieben:
> > > > > Clément Chigot <chigot@adacore.com> writes:
> > > > >
> > > > > > On Mon, Nov 10, 2025 at 2:09 PM Markus Armbruster <armbru@redhat.com> wrote:
> > > > > > >
> > > > > > > Clément Chigot <chigot@adacore.com> writes:
> > > > > > >
> > > > > > > > On Mon, Nov 10, 2025 at 11:13 AM Markus Armbruster <armbru@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > Clément Chigot <chigot@adacore.com> writes:
> > > > > > > > >
> > > > > > > > > > This allows more flexibility to vvfat backend. The values of "Number of
> > > > > > > > > > Heads" and "Sectors per track" are based on SD specifications Part 2.
> > > > > > > > > >
> > > > > > > > > > Due to the FAT architecture, not all sizes are reachable. Therefore, it
> > > > > > > > > > could be round up to the closest available size.
> > > > > > > > > >
> > > > > > > > > > FAT32 has not been adjusted and thus still default to 504 Mib.
> > > > > > > > > >
> > > > > > > > > > For floppy, only 1440 Kib and 2880 Kib are supported.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Clément Chigot <chigot@adacore.com>
> > > > > > > > >
> > > > > > > > > [...]
> > > > > > > > >
> > > > > > > > > > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > > > > > > > > > index 8a479ba090..0bcb360320 100644
> > > > > > > > > > --- a/qapi/block-core.json
> > > > > > > > > > +++ b/qapi/block-core.json
> > > > > > > > > > @@ -3478,11 +3478,17 @@
> > > > > > > > > >  #     (default: true)
> > > > > > > > > >  #     (since 10.2)
> > > > > > > > > >  #
> > > > > > > > > > +# @fat-size: size of the device in bytes.  Due to FAT underlying
> > > > > > > > > > +#     architecture, this size can be rounded up to the closest valid
> > > > > > > > > > +#     size.
> > > > > > > > > > +#     (since 10.2)
> > > > > > > > > > +#
> > > > > > > > >
> > > > > > > > > Can you explain again why you moved from @size to @fat-size?
> > > > > > > >
> > > > > > > > Just to be sure, you mean in the above comment, in the commit message or both ?
> > > > > > >
> > > > > > > Just to me, because I'm not sure I like the change, but that may well be
> > > > > > > due to a lack of understanding of your reasons.
> > > > > >
> > > > > > Naming `fat-size` instead of `size` ensures the parameter is only
> > > > > > recognized by the vvfat backend. In particular, it will be refused by
> > > > > > the default raw format, avoiding confusion:
> > > > > >  "-drive file=fat:<path>,size=256M" results in a 504M FAT disk
> > > > > > truncated to 256M, raw format being implicit.
> > > > > >  "-drive file=fat:<path>,fat-size=256M" is refused. "fat-size" is
> > > > > > unsupported by raw format.
> > > > >
> > > > > I figure throwing in format=raw to make raw format explicit doesn't
> > > > > change anything.  Correct?
> > > > >
> > > > > >  "-drive file=fat:<path>,format=vvfat,fat-size=256M" results in a 256M FAT disk.
> > > > > >  "-drive file=fat:<path>,format=vvfat,size=256M" is refused. "size" is
> > > > > > unsupported by vvfat format.
> > > > >
> > > > > If it was called @size, what behavior would we get?  Just two cases, I
> > > > > think:
> > > > >
> > > > > 1. With raw format:
> > > > >
> > > > >     -drive file=fat:<path>,size=256M
> > > >
> > > > You'd silently get a 504 MiB filesystem truncated to 256 MiB (i.e. a
> > > > corrupted file system). It's quite easy to forget format=vvfat, so
> > > > something that initially looks like it might be working is not a great
> > > > result for this user error.
> > >
> > > Why doesn't file=fat: imply format=vvfat? For what is the fat: part in
> > > file then?
> >
> > -drive is built pretty much on the assumption that you have an image
> > format that runs on top of a protocol. Format probing probes the image
> > format, not the protocol, while prefixes like fat: (or nbd:, http: etc.)
> > specify the protocol.
> >
> > So if you don't specify the format, we first open the protocol level
> > (which is vvfat) and then probing will detect that over this protocol,
> > we access a raw image. So it's mostly like saying format=raw.
> >
> > I think that format=<protocol driver> works is really more accidental,
> > but we can't change it now (and probably also don't want to). It results
> > in opening only the protocol layer and not stacking any format driver on
> > top of it.
> >
> > Options that you specify in -drive generally go to the top layer. So the
> > consequence in our case is that with format=vvfat, the option goes to
> > vvfat, but with format=raw (or unspecified format), it goes to the raw
> > forma driver.
> >
> > > I currently recommend using:
> > >
> > > -drive if=none,id=ufat,format=raw,file=fat:rw:/dir/to/export
> > > -device usb-storage,drive=ufat
> > >
> > > to my users which I got from somewhere but don't remember where and it
> > > seems to work but maybe not the best way to specify this.
> >
> > It's fine, and I might use the same one myself (though you should be
> > aware that fat:rw: is risky, it's full of bugs).
> >
> > But if you add an option like size=64M, it goes to the raw driver, which
> > will take whatever image you access on the protocol level and truncate
> > it at 64 MiB.
> >
> > If you want to give the size option on the vvfat level (and create a
> > filesystem that is actually only 64 MiB instead of truncating a larger
> > one), then obviously format=vvfat allows you to do that because then
> > there is no raw format layer to begin with. Or if you do have the raw
> > format layer, you can access options of the protocol layer by prefixing
> > "file.". So format=raw,file.size=64M would still pass the size option to
> > vvfat.
> 
> How is `file.size` working ? I've tried a similar syntax for other
> vvfat options (e.g `file.floppy` or the new `file.partitioned`) but
> those have no effect. Is this because there are fetched within the
> "filename"
> Wondering because I'mn ot a fan of the new ":unpartitioned:", I've
> added in patch 1. If it can simply be replaced by
> `format=raw,file.partitioned=false` or
> `format=vvfat,partitioned=false`. I think that would be far enough for
> its purpose.

Yes, I think it's because vvfat_parse_filename() overwrites them
unconditionally while getting the options from the filename.

Kevin


