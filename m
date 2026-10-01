Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263C5CA5FCE
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 19:39:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCMbu-0005cC-46; Thu, 01 Oct 2026 15:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xCMbr-0005bj-US
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 15:38:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xCMbq-0004LP-5n
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 15:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790883503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rDT2Rdq8znCutx4vr9yAF0EcigZ00vQSOtF0Mcd82wY=;
 b=FKFRHZPsWhGDvANVif+mwrWoTvuHB1w9M3WCBUm+bLjbnW7MOZPkHa+QbMqijQaumY5jBG
 Z6ETRB76OOpisoFRktfrigDvzNGfohffUJQaDlpgoVtPh4D2jtwMnvjl8Omvn1s7B1Qlxv
 H+Fmyjo0uyXH2GdvMvzLet9MwvbcZWU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-KG7g2nZ0Om6jajUHQE8eKg-1; Thu,
 01 Oct 2026 15:38:20 -0400
X-MC-Unique: KG7g2nZ0Om6jajUHQE8eKg-1
X-Mimecast-MFC-AGG-ID: KG7g2nZ0Om6jajUHQE8eKg_1790883499
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F8B51800613; Thu,  1 Oct 2026 19:38:19 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C73691800473; Thu,  1 Oct 2026 19:38:18 +0000 (UTC)
Date: Thu, 1 Oct 2026 15:38:17 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] hw/char/virtio-serial: return throttled descriptor on
 port close
Message-ID: <20261001193817.GA378684@shajnocz.csb>
References: <20260928152648.249959-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260928152648.249959-1-marcandre.lureau@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Sep 28, 2026 at 07:26:48PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> When the host chardev disconnects while the output queue is throttled,
> virtio_serial_close() calls discard_throttle_data() which detaches the
> in-flight element with virtqueue_detach_element(). This silently removes
> the descriptor without placing it on the used ring, so the guest never
> sees the write complete and the descriptor leaks.
> 
> Add return_throttle_data(), which pushes the element back via
> virtqueue_push() instead of detaching it, and call it from
> virtio_serial_close().

Thanks for fixing this!
> 
> Fixes: d4c19cdeeb2f ("virtio-serial: add missing virtio_detach_element() call")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/char/virtio-serial-bus.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> index 623e9f17a83e..008cad1b625c 100644
> --- a/hw/char/virtio-serial-bus.c
> +++ b/hw/char/virtio-serial-bus.c
> @@ -158,6 +158,20 @@ static void discard_throttle_data(VirtIOSerialPort *port)
>      }
>  }
>  
> +/*
> + * Return a partial element held back by throttling to the guest via
> + * the used ring, so the guest driver can reclaim the descriptor.
> + * Unlike discard_throttle_data() this must be used when the virtqueue
> + * stays live (port close) rather than being reset.
> + */
> +static void return_throttle_data(VirtIOSerialPort *port)
> +{
> +    if (port->elem) {
> +        virtqueue_push(port->ovq, port->elem, 0);

virtio_notify() is missing here. discard_vq_data() calls virtio_notify()
as long as the vq is set up, so in practice the guest will receive a
notification. However, this is a latent bug and the code isn't
performance-critical, so I suggest adding an explicit virtio_notify()
call to prevent future issues.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>


