Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6100CCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 15:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vITVM-0004jN-9L; Mon, 10 Nov 2025 10:08:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vITVJ-0004ey-Jq
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:08:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vITVH-0002fl-IU
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:08:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762787300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VWrb5kdo2qUwfjF2vh0re6nt5PDRqCzgFSuLOVf/8+M=;
 b=gi+yh6ekwHL3w5iRvJNjXIda99T/+D410QLtqB7zsj1sWTxaG4UpvgQ8PQJ2ppsTEr3+GV
 IXvIxlvpxgHj+YvxrsOY6CxnSxFXYm666D6khxyR8AwgfOvCcewb4bd671LbzBaXdwzC0I
 NHJELsfrvuUn41Pr/MYiSl1AGqe4gq4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-FHAs162iO2qGd-qfE59mNA-1; Mon,
 10 Nov 2025 10:08:17 -0500
X-MC-Unique: FHAs162iO2qGd-qfE59mNA-1
X-Mimecast-MFC-AGG-ID: FHAs162iO2qGd-qfE59mNA_1762787296
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38BA318001FE; Mon, 10 Nov 2025 15:08:16 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.209])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 545A330044E4; Mon, 10 Nov 2025 15:08:13 +0000 (UTC)
Date: Mon, 10 Nov 2025 16:08:10 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?iso-8859-1?Q?Cl=E9ment?= Chigot <chigot@adacore.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 eblake@redhat.com
Subject: Re: [PATCH v2 1/5] vvfat: introduce partitioned option
Message-ID: <aRH_2gcYOH31UB38@redhat.com>
References: <20251107145327.539481-1-chigot@adacore.com>
 <20251107145327.539481-2-chigot@adacore.com>
 <878qgenqum.fsf@pond.sub.org>
 <CAJ307Eg7x_rKb5qybgW3XxAKLP=1ds524gqgXettv2cZ8WTMww@mail.gmail.com>
 <757f66d0-625c-9d1b-5090-3d5210903173@eik.bme.hu>
 <87346mkos9.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87346mkos9.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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

Am 10.11.2025 um 14:20 hat Markus Armbruster geschrieben:
> BALATON Zoltan <balaton@eik.bme.hu> writes:
> 
> > On Mon, 10 Nov 2025, Clément Chigot wrote:
> >> On Mon, Nov 10, 2025 at 11:07 AM Markus Armbruster <armbru@redhat.com> wrote:
> >>>
> >>> Clément Chigot <chigot@adacore.com> writes:
> >>>
> >>>> This option tells whether a hard disk should be partitioned or not. It
> >>>> defaults to true and have the prime effect of preventing a master boot
> >>>> record (MBR) to be initialized.
> >>>>
> >>>> This is useful as some operating system (QNX, Rtems) don't
> >>>> recognized FAT mounted disks (especially SD cards) if a MBR is present.
> >>>>
> >>>> Signed-off-by: Clément Chigot <chigot@adacore.com>
> >>>
> >>> [...]
> >>>
> >>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
> >>>> index b82af74256..8a479ba090 100644
> >>>> --- a/qapi/block-core.json
> >>>> +++ b/qapi/block-core.json
> >>>> @@ -3464,8 +3464,8 @@
> >>>>  #
> >>>>  # @fat-type: FAT type: 12, 16 or 32
> >>>>  #
> >>>> -# @floppy: whether to export a floppy image (true) or partitioned hard
> >>>> -#     disk (false; default)
> >>>> +# @floppy: whether to export a floppy image (true) or hard disk
> >>>> +#     (false; default)
> >>>>  #
> >>>>  # @label: set the volume label, limited to 11 bytes.  FAT16 and FAT32
> >>>>  #     traditionally have some restrictions on labels, which are
> >>>> @@ -3474,11 +3474,15 @@
> >>>>  #
> >>>>  # @rw: whether to allow write operations (default: false)
> >>>>  #
> >>>> +# @partitioned: whether a hard disk will be partitioned
> >>>
> >>> How does "partitioned" combine with "floppy": true?
> >>>
> >>> Is it silently ignored?
> >>>
> >>> Is it an error if present?
> >>>
> >>> Is it an error if true?
> >>>
> >>> Does it add a partition table if true?
> >>>
> >>>> +#     (default: true)
> >>>
> >>> Hmm, this suggests it's silently ignored.
> >>>
> >>> Silently ignoring nonsensical configuration is usually a bad idea.
> >>
> >> True, but that would mean "unpartitioned" must always be passed when
> >> "floppy" is requested. That would make such command lines a bit more
> >> verbose, but otherwise I don't think there is any issue to that.
> >>
> >> Note that I didn't add "partition" as a keyword in the command line.
> >> Currently, it's either the default (thus partitioned) or
> >> "unpartitioned" being requested. Do you think it makes sense to add it
> >> as well, even if it's redundant ?
> >>
> >>>> +#     (since 10.2)
> >>>> +#
> >>>
> >>> Not sure I like "partitioned".  Is a disk with an MBR and a partition
> >>> table contraining a single partition partitioned?  Call it "mbr"?
> >>
> >> It used to be called "mbr/no-mbr" but Kevin suggested renaming it in
> >> V1. Honestly I'm fine with both options:
> >> - Technically, the option prevents MBR which has a side effect for
> >> preventing partition tables
> 
> Yes, because the partition table is part of the MBR.  I'd rather name
> the option after the entire thing it controls, not one of its parts.
> 
> >> - Even it has a single partition, I think it makes sense to call a
> >> disk "partitioned" as long as it has a partition table
> >>
> >> But I'm not that familiar with disk formats, etc. I'll let you decide
> >> with Kevin, which one you prefer.
> 
> Kevin is the maintainer, I just serve as advisor here.

I figured that the meaning of "partitioned" is easier to understand for
a casual user than having or not having an MBR ("I don't want to boot
from this disk, why would I care about a boot record?").

But if people think that "mbr" is better, that's fine with me.

The only thing I really didn't want is the negative "no-mbr" and the
double negation in "no-mbr=off" that comes with it.

> > I'd also vote for mbr or similar shorter name; unpartitioned is
> > awkward to type out in a command line. Maybe it can default to false
> > for floppy and true for disk to preserve current behaviour but allow
> > controlling it.
> 
> I'm not a fan of conditional defaults, but I think it's better than a
> nonsensical default that gets ignored.

I think in this case a conditional default makes sense, not only for
compatibility reasons. Hard disks almost always have a partition, floppy
disks with partitions are basically unheard of.

Kevin


