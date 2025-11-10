Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C72CCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 15:30:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vITqJ-0007Xx-IG; Mon, 10 Nov 2025 10:30:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vITqH-0007UT-Fy
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:30:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vITqF-0006Yq-3G
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:30:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762788602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n1svojnP5/LMquXktHVp7DEt8zwIWS6hBbcC4qCW74Q=;
 b=EsPEvmLBo4A3L2FwT0AKGIhp/SgoTd8hMeyS2tKtzPbRkFylr8rUM/S2u4bbQuZZfEzUWH
 7h3mrVnuzOQQ4r3P1lOqLamsayGYnQaWNT+VT9qCUV5nWn1jAqeH4rqtfI3l1Bf6c+xrmf
 pzGUJZHMhyOm+4q81Pw2anrD4iZ3zAM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-tsF38l2PPWW84Bbog0pckQ-1; Mon,
 10 Nov 2025 10:29:57 -0500
X-MC-Unique: tsF38l2PPWW84Bbog0pckQ-1
X-Mimecast-MFC-AGG-ID: tsF38l2PPWW84Bbog0pckQ_1762788596
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF46319560A7; Mon, 10 Nov 2025 15:29:56 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.209])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7CAC195608E; Mon, 10 Nov 2025 15:29:54 +0000 (UTC)
Date: Mon, 10 Nov 2025 16:29:52 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?iso-8859-1?Q?Cl=E9ment?= Chigot <chigot@adacore.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 eblake@redhat.com
Subject: Re: [PATCH v2 2/5] vvfat: move fat_type check prior to size setup
Message-ID: <aRIE8ACbqWZ2MPdE@redhat.com>
References: <20251107145327.539481-1-chigot@adacore.com>
 <20251107145327.539481-3-chigot@adacore.com>
 <874ir2nqr9.fsf@pond.sub.org>
 <CAJ307Ej8oNXjOZt2fkBMjR6bKSf=C2M6ncFFLCfy=Wk6+KMhNQ@mail.gmail.com>
 <877bvykp3q.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877bvykp3q.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Am 10.11.2025 um 14:13 hat Markus Armbruster geschrieben:
> Clément Chigot <chigot@adacore.com> writes:
> 
> > On Mon, Nov 10, 2025 at 11:09 AM Markus Armbruster <armbru@redhat.com> wrote:
> >>
> >> Clément Chigot <chigot@adacore.com> writes:
> >>
> >> > This allows to handle the default FAT size in a single place and make the
> >> > following part taking care only about size parameters. It will be later
> >> > moved away in a specific function.
> >> >
> >> > The selection of floppy size was a bit unusual:
> >> >  - fat-type undefined: a FAT 12 2880 Kib disk (default)
> >> >  - fat-type=16: a FAT 16 2880 Kib disk
> >> >  - fat-type=12: a FAT 12 1440 Kib disk
> >> >
> >> > Now, that fat-type undefined means fat-type=12, it's no longer possible
> >> > to make that size distinction. Therefore, it's being changed for the
> >> > following:
> >> >  - fat-type=12: a FAT 12 1440 Kib disk (default)
> >> >  - fat-type=16: a FAT 16 2880 Kib dis
> >> >
> >> > This has been choosen for two reasons: keep fat-type=12 the default and
> >> > creates a more usual size for it: 1440 Kib.
> >> >
> >> > The possibility to create a FAT 12 2880 Kib floppy will be added back
> >> > later, through the fat-size parameter.
> >> >
> >> > Side note to mention that s->sectors_per_cluster assignments are
> >> > removed because they are overidden a few line further.
> >> >
> >> > Signed-off-by: Clément Chigot <chigot@adacore.com>
> >>
> >> Is this a user-visible change?
> >
> > Yes, just "floppy" will now result in a 1440 KiB instead of the
> > previous 2880 KiB. However, Kevin mentions in V1 that it would make
> > more sense and vvfat being known to be unstable, this would be fine.
> > FTR, here is the complete comment:
> >
> >> On Wed, Oct 29, 2025 at 5:06 PM Kevin Wolf <kwolf@redhat.com> wrote:
> >> > In general, our stance is that we can change defaults whenever we want
> >> > to, and if you don't want to be surprised by changing defaults, you need
> >> > to specify the option explicitly.
> 
> Hmm, where is this stance on defaults documented?  Question for Kevin,
> of course.

Probably nowhere. More importantly, I don't think a compatibility
promise that says otherwise is documented either. And we know that
defaults have changed before, and that libvirt tries to be as explicit
as possible to avoid being impacted by changed defaults.

Do you disagree? If so, is there any way to change defaults or do we
have to stick to the existing defaults forever? To me not specifying an
option means "just pick anything that makes sense", without any promise
that this stays the same across versions.

> >> >                                   What's a bit strange about the vvfat
> >> > interface is that the default actually represents a configuration that
> >> > can't even be expressed explicitly at the moment.
> 
> Awkward.
> 
> >> > So it is a special case in a way, but given that this is vvfat, which is
> >> > known to be unstable, not widely used outside of the occasional manual
> >> > use and not supported by libvirt, I'm willing to just make the change.
> 
> I'm fine to treat vvfat as unstable.  But it's not marked as such in the
> QAPI schema!  Is that a bug?  Again, for Kevin.

Maybe? Though the kind of unstable I think of with vvfat is more than
just API instability that the QAPI feature is about. vvfat is more a
dirty (and clever) hack that sometimes works and can be useful enough,
but if it breaks, you get to keep both pieces. Good for one-off uses on
your personal toy VM, but keep it far away from production. We never
seriously tried to get it to a properly supportable level.

(And yes, probably none of this is documented as clearly as it should
be.)

Kevin


