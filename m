Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3053CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 11:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFsuW-0006sx-Ju; Mon, 03 Nov 2025 06:39:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFsuS-0006sH-Vp
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 06:39:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFsuN-0003Fy-P0
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 06:39:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762169970;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ijV0xPmPbUiyKABPTiMtHfTq4OCBxkm3DOmUHoZqyco=;
 b=F66HKPg+obejsbOzGRjfIWzFlax6RaWF0uTKhlWQcaaT9Lrn9MLDdlKauDFl56xUyfQZwQ
 YpoyKW059dIQ/RgQF9wXQ75ics4UTZT1s0ioSItsxHp0NZuwa9Xno4mnKLS0jQW+UjFtM+
 c8WnffNnfUhUVHW9AgB/pa4IVhhGHII=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-sbhruUlnPbG2cN2XB7egAg-1; Mon,
 03 Nov 2025 06:39:29 -0500
X-MC-Unique: sbhruUlnPbG2cN2XB7egAg-1
X-Mimecast-MFC-AGG-ID: sbhruUlnPbG2cN2XB7egAg_1762169968
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC78518089A6; Mon,  3 Nov 2025 11:39:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.202])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A9ED180057D; Mon,  3 Nov 2025 11:39:25 +0000 (UTC)
Date: Mon, 3 Nov 2025 11:39:21 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Bin Meng <bmeng@tinylab.org>
Subject: Re: [PATCH] net: pad packets to minimum length in
 qemu_receive_packet()
Message-ID: <aQiUaSSF4PyX6kXv@redhat.com>
References: <20251028160042.3321933-1-peter.maydell@linaro.org>
 <1a8ea87f-41b2-40a5-8511-df019b5833c5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a8ea87f-41b2-40a5-8511-df019b5833c5@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Nov 03, 2025 at 12:35:48PM +0100, Philippe Mathieu-Daudé wrote:
> On 28/10/25 17:00, Peter Maydell wrote:
> > In commits like 969e50b61a28 ("net: Pad short frames to minimum size
> > before sending from SLiRP/TAP") we switched away from requiring
> > network devices to handle short frames to instead having the net core
> > code do the padding of short frames out to the ETH_ZLEN minimum size.
> > We then dropped the code for handling short frames from the network
> > devices in a series of commits like 140eae9c8f7 ("hw/net: e1000:
> > Remove the logic of padding short frames in the receive path").
> > 
> > This missed one route where the device's receive code can still see a
> > short frame: if the device is in loopback mode and it transmits a
> > short frame via the qemu_receive_packet() function, this will be fed
> > back into its own receive code without being padded.
> > 
> > Add the padding logic to qemu_receive_packet().
> > 
> > This fixes a buffer overrun which can be triggered in the
> > e1000_receive_iov() logic via the loopback code path.
> > 
> > Other devices that use qemu_receive_packet() to implement loopback
> > are cadence_gem, dp8393x, lan9118, msf2-emac, pcnet, rtl8139
> > and sungem.
> > 
> > Cc: qemu-stable@nongnu.org
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3043
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > I think this is the right fix, but I'm not very familiar
> > with the net internals...
> > ---
> >   net/net.c | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> > 
> > diff --git a/net/net.c b/net/net.c
> > index 27e0d278071..8aefdb3424f 100644
> > --- a/net/net.c
> > +++ b/net/net.c
> > @@ -775,10 +775,20 @@ ssize_t qemu_send_packet(NetClientState *nc, const uint8_t *buf, int size)
> >   ssize_t qemu_receive_packet(NetClientState *nc, const uint8_t *buf, int size)
> >   {
> > +    uint8_t min_pkt[ETH_ZLEN];
> > +    size_t min_pktsz = sizeof(min_pkt);
> > +
> >       if (!qemu_can_receive_packet(nc)) {
> >           return 0;
> >       }
> > +    if (net_peer_needs_padding(nc)) {
> > +        if (eth_pad_short_frame(min_pkt, &min_pktsz, buf, size)) {
> > +            buf = min_pkt;
> > +            size = min_pktsz;
> > +        }
> > +    }
> > +
> >       return qemu_net_queue_receive(nc->incoming_queue, buf, size);
> >   }
> 
> Nitpicking, variables scope can be reduced:
> 
> -- >8 --
> @@ -777,5 +777,2 @@ ssize_t qemu_receive_packet(NetClientState *nc, const
> uint8_t *buf, int size)
>  {
> -    uint8_t min_pkt[ETH_ZLEN];
> -    size_t min_pktsz = sizeof(min_pkt);
> -
>      if (!qemu_can_receive_packet(nc)) {
> @@ -785,2 +782,5 @@ ssize_t qemu_receive_packet(NetClientState *nc, const
> uint8_t *buf, int size)
>      if (net_peer_needs_padding(nc)) {
> +        uint8_t min_pkt[ETH_ZLEN];
> +        size_t min_pktsz = sizeof(min_pkt);
> +
>          if (eth_pad_short_frame(min_pkt, &min_pktsz, buf, size)) {
> ---

That isn't desirable, as then 'buf' would be holding a stack pointer
that has gone out of scope when qemu_net_queue_receive is called.

> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


