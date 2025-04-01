Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73AAC36014
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 12:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzaO2-0004r6-9W; Tue, 01 Apr 2025 08:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tzaNR-0004i9-JC
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 08:06:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tzaNO-0006tK-DT
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 08:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743509148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LcbFe9E+Zvr5gitiMBvfLk8vaOihvpLNEVBt7hY8CoQ=;
 b=hfRIswxVA0yXHwVgcdBfUfiz2REAhVcWvE2oJJYAIabCGYJKN6T5AX/espXWGThVBKjP6r
 XDZDFOgYgv5f+r2JhBK/mdmDMfz5tAM9sAutdZ1DXFQY4RJJSgDD/00sBggduxPqMmgRL3
 qfrvxa3c4Fv6NrW94o2osOmlUOY8O7g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-ueXqpodGNRmqqxJH8jPsQQ-1; Tue,
 01 Apr 2025 08:05:46 -0400
X-MC-Unique: ueXqpodGNRmqqxJH8jPsQQ-1
X-Mimecast-MFC-AGG-ID: ueXqpodGNRmqqxJH8jPsQQ_1743509146
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8472D1801A00; Tue,  1 Apr 2025 12:05:45 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.48])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F04771955D81; Tue,  1 Apr 2025 12:05:42 +0000 (UTC)
Date: Tue, 1 Apr 2025 14:05:40 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 14/15] fuse: Implement multi-threading
Message-ID: <Z-vWlL1_P5UmK2Gl@redhat.com>
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160655.119407-13-hreitz@redhat.com>
 <87sen0fj1j.fsf@pond.sub.org>
 <23f3bdae-c48f-4b23-9f6f-389625617a35@redhat.com>
 <874izg81dt.fsf@pond.sub.org>
 <4c2b5ab0-23d9-4ad8-9549-0ee2a9551b26@redhat.com>
 <87tt7eu0nt.fsf@pond.sub.org>
 <cfad66d7-1ba1-440e-9a48-4d0c91eb5aa1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cfad66d7-1ba1-440e-9a48-4d0c91eb5aa1@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 27.03.2025 um 14:45 hat Hanna Czenczek geschrieben:
> On 27.03.25 13:18, Markus Armbruster wrote:
> > Hanna Czenczek <hreitz@redhat.com> writes:
> > 
> > > On 26.03.25 12:41, Markus Armbruster wrote:
> > > > Hanna Czenczek <hreitz@redhat.com> writes:
> > > > 
> > > > > On 26.03.25 06:38, Markus Armbruster wrote:
> > > > > > Hanna Czenczek <hreitz@redhat.com> writes:
> > > > > > 
> > > > > > > FUSE allows creating multiple request queues by "cloning" /dev/fuse FDs
> > > > > > > (via open("/dev/fuse") + ioctl(FUSE_DEV_IOC_CLONE)).
> > > > > > > 
> > > > > > > We can use this to implement multi-threading.
> > > > > > > 
> > > > > > > Note that the interface presented here differs from the multi-queue
> > > > > > > interface of virtio-blk: The latter maps virtqueues to iothreads, which
> > > > > > > allows processing multiple virtqueues in a single iothread.  The
> > > > > > > equivalent (processing multiple FDs in a single iothread) would not make
> > > > > > > sense for FUSE because those FDs are used in a round-robin fashion by
> > > > > > > the FUSE kernel driver.  Putting two of them into a single iothread will
> > > > > > > just create a bottleneck.
> > > > > > > 
> > > > > > > Therefore, all we need is an array of iothreads, and we will create one
> > > > > > > "queue" (FD) per thread.
> > > > > > [...]
> > > > > > 
> > > > > > > Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> > > > > > > ---
> > > > > > >   qapi/block-export.json |   8 +-
> > > > > > >   block/export/fuse.c    | 214 +++++++++++++++++++++++++++++++++--------
> > > > > > >   2 files changed, 179 insertions(+), 43 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/qapi/block-export.json b/qapi/block-export.json
> > > > > > > index c783e01a53..0bdd5992eb 100644
> > > > > > > --- a/qapi/block-export.json
> > > > > > > +++ b/qapi/block-export.json
> > > > > > > @@ -179,12 +179,18 @@
> > > > > > >   #     mount the export with allow_other, and if that fails, try again
> > > > > > >   #     without.  (since 6.1; default: auto)
> > > > > > >   #
> > > > > > > +# @iothreads: Enables multi-threading: Handle requests in each of the
> > > > > > > +#     given iothreads (instead of the block device's iothread, or the
> > > > > > > +#     export's "main" iothread).
> > > > > > When does "the block device's iothread" apply, and when "the export's
> > > > > > main iothread"?
> > > > > Depends on where you set the iothread option.
> > > > Assuming QMP users need to know (see right below), can we trust they
> > > > understand which one applies when?  If not, can we provide clues?
> > > I don’t understand what exactly you mean, but which one applies when has nothing to do with this option, but with the @iothread (and @fixed-iothread) option(s) on BlockExportOptions, which do document this.
> > Can you point me to the spot?
> 
> Sure: https://www.qemu.org/docs/master/interop/qemu-qmp-ref.html#object-QMP-block-export.BlockExportOptions
> (iothread and fixed-iothread)
> 
> > 
> > > > > > Is this something the QMP user needs to know?
> > > > > I think so, because e.g. if you set iothread on the device and the export, you’ll get a conflict.  But if you set it there and set this option, you won’t.  This option will just override the device/export option.
> > > > Do we think the doc comment sufficient for QMP users to figure this out?
> > > As for conflict, BlockExportOptions.iothread and BlockExportOptions.fixed-iothread do.
> > > 
> > > As for overriding, I do think so.  Do you not?  I’m always open to suggestions.
> > > 
> > > > If not, can we provide clues?
> > > > 
> > > > In particular, do we think they can go from an export failure to the
> > > > setting @iothreads here?  Perhaps the error message will guide them.
> > > > What is the message?
> > > I don’t understand what failure you mean.
> > You wrote "you'll get a conflict".  I assume this manifests as failure
> > of a QMP command (let's ignore CLI to keep things simple here).
> 
> If you set the @iothread option on both the (guest) device and the export
> (and also @fixed-iothread on the export), then you’ll get an error.  Nothing
> to do with this new @iothreads option here.
> 
> > Do we think ordinary users running into that failure can figure out they
> > can avoid it by setting @iothreads?
> 
> It shouldn’t affect the failure.  Setting @iothread on both device and
> export (with @fixed-iothread) will always cause an error, and should. 
> Setting this option is not supposed to “fix” that configuration error.
> 
> Theoretically, setting @iothreads here could make it so that
> BlockExportOptions.iothread (and/or fixed-iothread) is ignored, because that
> thread will no longer be used for export-issued I/O; but in practice,
> setting that option (BlockExportOptions.iothread) moves that export and the
> whole BDS tree behind it to that I/O thread, so if you haven’t specified an
> I/O thread on the guest device, the guest device will then use that thread. 
> So making @iothreads silently completely ignore BlockExportOptions.iothread
> may cause surprising behavior.
> 
> Maybe we could make setting @iothreads here and the generic
> BlockExportOptions.iothread at the same time an error.  That would save us
> the explanation here.

This raises the question if the better interface wouldn't be to change
the BlockExportOptions.iothread from 'str' to an alternate between 'str'
and ['str'], allowing the user to specify multiple iothreads in the
already existing related option without creating conflicting options.

In the long run, I would be surprised if FUSE remained the only export
supporting multiple iothreads. At least the virtio based ones
(vhost-user-blk and VDUSE) even have precedence in the virtio-blk device
itself, so while I don't know how much interest there is in actually
implementing it, in theory we know it makes sense.

Kevin


