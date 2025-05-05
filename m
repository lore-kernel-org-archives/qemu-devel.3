Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABDACC3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 14:05:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBwRp-00066f-Kz; Mon, 05 May 2025 10:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uBwRo-00066N-9a
 for qemu-devel@nongnu.org; Mon, 05 May 2025 10:05:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uBwRl-0007a6-VZ
 for qemu-devel@nongnu.org; Mon, 05 May 2025 10:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746453927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1rJ39vxzZRmvOCwTYpKrIl/TMIacZg7tD3r9dCZlvzg=;
 b=CCEd/Q1SMLoRy/mEM8uslbd4hprPqf3VrFX12eR/3uBPMLGf1HV0jcZ/EXw29XTEsvHrCD
 rJkpnwP31MufoZXntJ3dc3u7nGtyHlfHIAgJ6FDZr1CGZh9pNtbFDUFw8ymC6fkLGLjV8e
 tBf26hWPxBSqEHINDjZUYfJX7BRIbdo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-9BnsC-I0PHaqZq9iLxWcPg-1; Mon,
 05 May 2025 10:05:15 -0400
X-MC-Unique: 9BnsC-I0PHaqZq9iLxWcPg-1
X-Mimecast-MFC-AGG-ID: 9BnsC-I0PHaqZq9iLxWcPg_1746453897
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 641C819560BA; Mon,  5 May 2025 14:04:57 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.8])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC6E618001D7; Mon,  5 May 2025 14:04:52 +0000 (UTC)
Date: Mon, 5 May 2025 16:04:50 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 16/22] usb/msd: Split async packet tracking into data
 and csw
Message-ID: <aBjFgmMHmf3-zhiL@redhat.com>
References: <20250502033047.102465-1-npiggin@gmail.com>
 <20250502033047.102465-17-npiggin@gmail.com>
 <aBi3lUtOUgn6pzGs@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBi3lUtOUgn6pzGs@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 05.05.2025 um 15:05 hat Kevin Wolf geschrieben:
> Am 02.05.2025 um 05:30 hat Nicholas Piggin geschrieben:
> > The async packet handling logic has places that infer whether the
> > async packet is data or CSW, based on context. This is not wrong,
> > it just makes the logic easier to follow if they are categorised
> > when they are accepted.
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  include/hw/usb/msd.h |   5 +-
> >  hw/usb/dev-storage.c | 121 +++++++++++++++++++++++++++----------------
> >  2 files changed, 79 insertions(+), 47 deletions(-)
> > 
> > diff --git a/include/hw/usb/msd.h b/include/hw/usb/msd.h
> > index f9fd862b529..a40d15f5def 100644
> > --- a/include/hw/usb/msd.h
> > +++ b/include/hw/usb/msd.h
> > @@ -33,8 +33,11 @@ struct MSDState {
> >      struct usb_msd_csw csw;
> >      SCSIRequest *req;
> >      SCSIBus bus;
> > +
> >      /* For async completion.  */
> > -    USBPacket *packet;
> > +    USBPacket *data_packet;
> > +    USBPacket *csw_in_packet;
> 
> This makes the state more complex, because there is a rule here that
> isn't explicit in the code: At most one of data_packet or csw_in_packet
> can be set at the same time.
> 
> Both are quite similar, so most of the patch just duplicates things that
> are currently done for s->packet.
> 
> Wouldn't it make more sense to have one USBPacket pointer, but some
> state that explicitly tells us what we're waiting for, data or the
> status? I was thinking of a new bool at first, but on second thoughts,
> s->mode looks quite similar to what we need here.
> 
> What if we just introduce a new state in the s->mode state machine for
> "CSW read in progress" as opposed to USB_MSDM_CSW meaning "expecting the
> host to read the CSW next"? Then the cases for which you currently set
> s->csw_in_packet would instead transition to this new state, and
> usb_msd_command_complete() (which has the only real change in this
> patch) could just directly rely on s->mode.

After looking at the rest of the series, this is probably not what we
want either.

I think a big part of the problem why this device is hard to understand
is that it's too much centered around what the host does rather than
what the core logic of the device is. Which is really simple:

    while (!unrealizing) {
        cbw = read_in_packet();
        req = start_scsi_req();
        ret = wait_for_scsi_req(req);
        write_out_packet(status_to_csw(ret));
    }

This flow (which is really Figure 1 in Chapter 5 in the spec) is nowhere
to be seen in the code. Can we change things to look more like this?
Could be almost literally this if we make it coroutine based, or just
the callback based equivalent of it.

And then when we receive a packet, we just queue it as the next in or
out packet, and leave it to the main state machine/coroutine to make use
of the packet or wait for one if it's missing.

Kevin


