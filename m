Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91841C3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 13:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBvXH-0005AY-9p; Mon, 05 May 2025 09:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uBvXF-0005AC-1s
 for qemu-devel@nongnu.org; Mon, 05 May 2025 09:07:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uBvXD-00023A-0a
 for qemu-devel@nongnu.org; Mon, 05 May 2025 09:07:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746450421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F3z1fAYDGayz0/0nozHwUc8pL0fC3X0C2tDZuUGybuc=;
 b=dT8NIXaeULO+HrCwdBSxuFcvhdtZjbG6XAxAlryQE0NBRrUC3Qg5fx/KyLfLYjyC5zp/Ap
 CDelouNeaj1BmQ8v+o9zdlCeMnDZ45Y4MXsfURjM+2TLFRTgQfykdphwPFJZ83EGH9GQjj
 C9egmspBR8H67KBZu2HfFGeS9Tmbn5w=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-487-pdKI2fZLMLWkLxCQTFcZmw-1; Mon,
 05 May 2025 09:05:34 -0400
X-MC-Unique: pdKI2fZLMLWkLxCQTFcZmw-1
X-Mimecast-MFC-AGG-ID: pdKI2fZLMLWkLxCQTFcZmw_1746450332
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C1A31955DCD; Mon,  5 May 2025 13:05:32 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.8])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 232171800360; Mon,  5 May 2025 13:05:27 +0000 (UTC)
Date: Mon, 5 May 2025 15:05:25 +0200
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
Message-ID: <aBi3lUtOUgn6pzGs@redhat.com>
References: <20250502033047.102465-1-npiggin@gmail.com>
 <20250502033047.102465-17-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502033047.102465-17-npiggin@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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

Am 02.05.2025 um 05:30 hat Nicholas Piggin geschrieben:
> The async packet handling logic has places that infer whether the
> async packet is data or CSW, based on context. This is not wrong,
> it just makes the logic easier to follow if they are categorised
> when they are accepted.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  include/hw/usb/msd.h |   5 +-
>  hw/usb/dev-storage.c | 121 +++++++++++++++++++++++++++----------------
>  2 files changed, 79 insertions(+), 47 deletions(-)
> 
> diff --git a/include/hw/usb/msd.h b/include/hw/usb/msd.h
> index f9fd862b529..a40d15f5def 100644
> --- a/include/hw/usb/msd.h
> +++ b/include/hw/usb/msd.h
> @@ -33,8 +33,11 @@ struct MSDState {
>      struct usb_msd_csw csw;
>      SCSIRequest *req;
>      SCSIBus bus;
> +
>      /* For async completion.  */
> -    USBPacket *packet;
> +    USBPacket *data_packet;
> +    USBPacket *csw_in_packet;

This makes the state more complex, because there is a rule here that
isn't explicit in the code: At most one of data_packet or csw_in_packet
can be set at the same time.

Both are quite similar, so most of the patch just duplicates things that
are currently done for s->packet.

Wouldn't it make more sense to have one USBPacket pointer, but some
state that explicitly tells us what we're waiting for, data or the
status? I was thinking of a new bool at first, but on second thoughts,
s->mode looks quite similar to what we need here.

What if we just introduce a new state in the s->mode state machine for
"CSW read in progress" as opposed to USB_MSDM_CSW meaning "expecting the
host to read the CSW next"? Then the cases for which you currently set
s->csw_in_packet would instead transition to this new state, and
usb_msd_command_complete() (which has the only real change in this
patch) could just directly rely on s->mode.

> @@ -395,11 +420,15 @@ static void usb_msd_cancel_io(USBDevice *dev, USBPacket *p)
>  {
>      MSDState *s = USB_STORAGE_DEV(dev);
>  
> -    assert(s->packet == p);
> -    s->packet = NULL;
> -
> -    if (s->req) {
> -        scsi_req_cancel(s->req);
> +    if (p == s->data_packet) {
> +        s->data_packet = NULL;
> +        if (s->req) {
> +            scsi_req_cancel(s->req);
> +        }
> +    } else if (p == s->csw_in_packet) {
> +        s->csw_in_packet = NULL;
> +    } else {
> +        g_assert_not_reached();
>      }
>  }

I think scsi_req_cancel() is required even in csw_in_packet case.
Whether someone already asked for the result doesn't change the state of
the in-flight SCSI request, so we shouldn't try to cancel it in one
case, but not in the other.

Kevin


