Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1AE606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 14:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eLLkG3qI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVrj6-00011Y-Ik; Tue, 24 Nov 2026 09:42:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xVrj0-0000z0-4K
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 09:42:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xVrix-0000FM-ML
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 09:42:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795531342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I84+bm69L5USxenkFMa1Z05vWlOwA5L5gDk7qyQFU/s=;
 b=eLLkG3qIdvl6KF9EBDvvqZS60ohKUgPjfNdUxBpPbUUKug74KzCNzElHX4xB5sc0xWKTgk
 fDcVaFdFOBCO3iKBf53RR6FrqFcUFgnywbC+IPVDdCXufjdU9dWILtbrKabm0yiJ4ASllF
 9epa0KYW6tKWjy5HyuAMHvSn99V2P+U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-ypWl7LQKP2-KBbrGOAEbog-1; Tue,
 24 Nov 2026 14:42:17 +0000
X-MC-Unique: ypWl7LQKP2-KBbrGOAEbog-1
X-Mimecast-MFC-AGG-ID: ypWl7LQKP2-KBbrGOAEbog_1795531336
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E4F1180255F; Tue, 24 Nov 2026 14:42:16 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.24])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 13E1C1801978; Tue, 24 Nov 2026 14:42:13 +0000 (UTC)
Date: Tue, 24 Nov 2026 15:42:11 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>, qemu-block@nongnu.org,
 stefanha@redhat.com, afaria@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/2] file-posix: Add 'accept-read-only-device' option
Message-ID: <awWiQ7TcMEnpubDx@redhat.com>
References: <20261029164522.103918-1-kwolf@redhat.com>
 <20261029164522.103918-2-kwolf@redhat.com>
 <au2qCGy-CttBaXoI@angien.pipo.sk> <87cxruh857.fsf@pond.sub.org>
 <awWD_4Y9xsYMKdS9@redhat.com> <87pkvue4ge.fsf@pond.sub.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pkvue4ge.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 24.11.2026 um 14:36 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > Am 24.11.2026 um 10:48 hat Markus Armbruster geschrieben:
> >> I almost missed this.  My apologies for the delay!
> >> 
> >> Peter Krempa <pkrempa@redhat.com> writes:
> >> 
> >> > CC'd Markus for QAPI generator input.
> >> >
> >> > On Thu, Oct 29, 2026 at 17:45:21 +0100, Kevin Wolf wrote:
> >> >> The host_device block driver refuses to open a block device read-write
> >> >> if the BLKROGET ioctl tells it that it's actually read-only. For such
> >> >> devices it's possible to open a read-write file descriptor, but any
> >> >> writes to the device would fail.
> >> >> 
> >> >> There are valid use cases for which this check gets in the way, as
> >> >> explained in the bug report:
> >> >> 
> >> >>     However, this behavior prevents a legitimate enterprise use case:
> >> >>     running VMs against storage replication target LUNs in a disaster
> >> >>     recovery configuration. Enterprise storage arrays (Dell Powermax,
> >> >>     Pure Storage) set the SCSI Write Protect bit on replication target
> >> >>     LUNs, causing the Linux kernel to mark them read-only via BLKROGET.
> >> >>     The VMs on the passive DR site need to start with these LUNs
> >> >>     attached - writes are expected to fail (the application middleware
> >> >>     knows it's on the passive side), and after a DR role swap the LUN
> >> >>     becomes writable and writes should succeed immediately without any
> >> >>     VM restart.
> >> >> 
> >> >> In order to allow such use cases in which a currently read-only device
> >> >> is deliberately opened read-write, add a new option to the host_device
> >> >> driver that allows the user to skip the check.
> >> >> 
> >> >> Buglink: https://redhat.atlassian.net/browse/RHEL-186136
> >> >> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> >> >> Reviewed-by: Eric Blake <eblake@redhat.com>
> >> >> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >> >> ---
> >> >>  qapi/block-core.json | 19 ++++++++++++++++++-
> >> >>  block/file-posix.c   | 23 ++++++++++++++++++++---
> >> >>  2 files changed, 38 insertions(+), 4 deletions(-)
> >> >> 
> >> >> diff --git a/qapi/block-core.json b/qapi/block-core.json
> >> >> index 741c8165c06..80272b878c5 100644
> >> >> --- a/qapi/block-core.json
> >> >> +++ b/qapi/block-core.json
> >> >> @@ -3390,6 +3390,23 @@
> >> >>    'features': [ { 'name': 'dynamic-auto-read-only',
> >> >>                    'if': 'CONFIG_POSIX' } ] }
> >> >>  
> >> >> +##
> >> >> +# @BlockdevOptionsHostDevice:
> >> >> +#     Driver specific block device options for the host_device
> >> >> +#     backend.
> >> >> +#
> >> >> +# @accept-read-only-device: allow opening a read-only device as
> >> >> +#     read-write.  If this is false, opening a host device read-write
> >> >> +#     requires on Linux that the BLKROGET ioctl considers the device
> >> >> +#     writable.  If it is true, this check is skipped.  (since: 11.2,
> >> >> +#     default: false)
> >> >> +#
> >> >> +# Since: 11.2
> >> >> +##
> >> >> +{ 'struct': 'BlockdevOptionsHostDevice',
> >> >> +  'base': 'BlockdevOptionsFile',
> >> >> +  'data': { '*accept-read-only-device': 'bool' } }
> >> >> +
> >> >>  ##
> >> >>  # @BlockdevOptionsNull:
> >> >>  #     Driver specific block device options for the null backend.
> >> >> @@ -4777,7 +4794,7 @@
> >> >>        'ftps':       'BlockdevOptionsCurlFtps',
> >> >>        'host_cdrom':  { 'type': 'BlockdevOptionsFile',
> >> >>                         'if': 'HAVE_HOST_BLOCK_DEVICE' },
> >> >> -      'host_device': { 'type': 'BlockdevOptionsFile',
> >> >> +      'host_device': { 'type': 'BlockdevOptionsHostDevice',
> >> >>                         'if': 'HAVE_HOST_BLOCK_DEVICE' },
> >> >>        'http':       'BlockdevOptionsCurlHttp',
> >> >>        'https':      'BlockdevOptionsCurlHttps',
> >> >
> >> > After the two hunks above the 'host_device' type in the resulting QMP
> >> > schema will no longer have the 'dynamic-auto-read-only' feature which it
> >> > had when it used 'BlockdevOptionsFile' directly rather than the
> >> > 'BlockdevOptionsHostDevice' type which 'inherits' from
> >> > 'BlockdevOptionsFile'.
> >> 
> >> Reproduced.
> >> 
> >> > Markus, after chatting with Kevin, we're not sure if it's intention that
> >> > features are not inherited in the above case, and thus the
> >> > 'dynamic-auto-read-only' feature would need to be propagated also to
> >> > 'BlockdevOptionsHostDevice' or it's a mistake in the generator.
> >> 
> >> The generator does what the programmer(s) intended it to do: 'base'
> >> splices in the members, and nothing else.  Further evidence of intent:
> >> the explanation of 'base' in docs/devel/qapi-code-gen.rst talks only
> >> about members.
> >> 
> >> Should it do more?
> >> 
> >> Kevin, did you expect the feature to be inherited?  Or did you simply
> >> not remember there's a feature, and therefore didn't think about what
> >> the generator might do with it?
> >
> > I simply didn't think of it, and when Peter pointed it out, I was unsure
> > what the behaviour really should be. I think inheriting would usually be
> > what you want, but maybe not always.
> >
> > I think we have two options to fix the regression: Either change the
> > QAPI generator to inherit features from 'base' (and avoid similar
> > problems in the future), or just manually duplicate the feature in the
> > schema for BlockdevOptionsHostDevice.
> >
> > Which one do you like better? I don't mind too much either way.
> 
> Let's duplicate manually at least for now.  We want a fix for 11.2, and
> it's last minute.  I don't want to mess with the generator this late in
> the freeze.  Manual duplication is simple and safe.
> 
> Bases with features are rare.  I can see three instances:
> 
>     Base                 of                         has feature
>     BlockdevOptionsFile  BlockdevOptionsHostDevice  dynamic-auto-read-only
>     SevCommonProperties  SevGuestProperties         confidential-guest-reset
>     SevCommonProperties  SevSnpGuestProperties      confidential-guest-reset
> 
> I'm reluctant to accept generator complexity for something as rare as
> this.

My concern is not about the existing cases, but rather the question if
we'll catch the fourth case when it is introduced (e.g. some field of a
struct used somewhere as a base is deprecated).

> On the other hand, all three need the feature duplicated, I think.

Yes, it looks like the feature in SevCommonProperties is invisible on
the external interface (which probably means that it isn't needed at
all).

> On the third hand, we can manually add features, but not remove them.
> So if we make the generator inherit them, we're stuck with them.
> 
> Would you like me to post patches?

That would be good, especially now that you found instances of the
problem outside the block layer.

Kevin


