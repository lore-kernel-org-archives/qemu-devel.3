Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60659606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EymtuzYq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUBs-0008P5-0z; Thu, 29 Oct 2026 13:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xMUBR-00075h-AY
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:45:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xMUB8-0003ec-W4
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793295879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=25DYDXcMD/iWJVg3QIHdnliUTo8XcPDTsYISKZkdDV8=;
 b=EymtuzYq7uPpxeg+hcX0OB3JBjCRYUEE7dAgCsR1dVbOuAuwk2QKYgqpFwh6HEN9ukKD+o
 bQiUPFGvxbr9Lm45wXpUPjezk4KqDvHFNHMZu6+kncyl3jBqyERTsgEhvmGTf9JHmU1N8t
 d43sCNz0Q2zgLRsZVH+eNVzwQJ7ej7I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-Ra-GIO-1Pnmynene9lgcoA-1; Thu,
 29 Oct 2026 13:44:34 -0400
X-MC-Unique: Ra-GIO-1Pnmynene9lgcoA-1
X-Mimecast-MFC-AGG-ID: Ra-GIO-1Pnmynene9lgcoA_1793295872
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4063A180ABE9; Thu, 29 Oct 2026 17:44:32 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 265D118000A3; Thu, 29 Oct 2026 17:44:30 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 7/8] hw/usb/redirect-server: Stream interrupt IN
 endpoints
From: marcandre.lureau@redhat.com
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: kraxel@redhat.com, marcandre.lureau@redhat.com, junjie.cao@intel.com, 
 junjie.cao@linux.dev, =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Kane Chen <kane_chen@aspeedtech.com>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 Troy Lee <troy_lee@aspeedtech.com>
In-Reply-To: <20261028034140.367393-8-jamin_lin@aspeedtech.com>
References: <20261028034140.367393-1-jamin_lin@aspeedtech.com>
 <20261028034140.367393-8-jamin_lin@aspeedtech.com>
Date: Thu, 29 Oct 2026 21:44:07 +0400
Message-Id: <179329584773.3884549.4642213275302632142.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=10647;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=iZmY88w7AXfz2JZbvDFtYZN9IAl4F4VY80phWoYnvCg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq44XrbgphcnDBxVmUe45s8SA7kV7kt1e5geJBS
 W55ctqocWeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCauOF6wAKCRDa6OEJdZac
 5TV2D/0Q0ak006tZJQXn0bVG08CR5KW+qAXgRrti3F7ODt6BEMtiFGKMlXMhMxVK9HRbRidD4A9
 p4sHI54E5cdei+b2GGPTp24Cf2I9AeTAJqg+1w74hIvXOqH4TKeTkvR1XIVDsbu5kUm5H2vqZpQ
 8WF7ecEbprsKhbjiawL0PfUfbkn7mYPTMIo5B9NV2XqiCwOAIqGCYWRZwz5rogB/8eOc3VqWaf6
 n2lBcONOW8KcD548HX5t/KEloAXrNwQ7lNJZPfOZFGOGIolhcSPeghTwae9GcCb7feu/I2oSGMB
 p97qrSjfZA8VUVwT9O2jRp1P5TficpQrdTCAtlosAOFwyHPRCyT/i8XNvgXDwxuNwcMQV160oqZ
 jrabsKiJVCsCVSYBn8aIqTjF5JDOeDdS1ac0Gj8sIBDCZ+0Y2fUMC5AfwAa4ZXesF3kr5Inz5D2
 Bqbg7gu3UqXb1vwwz8+U/PWlzbNrcfRji+cOanRW6MZzZX3NKeMS6lNBe8WSVziXcPYawJzj9Dn
 MJC75KMS+IIuP8u+zJb+0W8P/sJQ7mEqXXzRlXvbuaP/kMWY3Lu+zHUbYGO2AuS8qa+AvCQo9Xi
 9iLxOK4j0dt4Z2y76sRUVREryDuw6Twumow0TzXS1g3pwCIOgLpLFTbiVVClfBAh8PC83R5etbQ
 5NYgFP1TqD0H/6Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> Interrupt IN is not a request and an answer in usbredir. The host asks
> once with start_interrupt_receiving. After that it expects a packet
> every time the device has data.
> 
> Park one IN packet on the device for each streaming endpoint. A device
> that answers USB_RET_ASYNC holds the packet and completes it when it
> has data. A device that answers USB_RET_NAK gives the packet back at
> once, so park a new one when the bus reports a wakeup on that endpoint.
> A slow timer parks one too, for a device that does not report a wakeup.
> A streamed request does not wait on the endpoint's list the way a host
> request does, because this timer already asks again.
> 
> Wait for the endpoint's bInterval before parking the next one. Some
> devices answer every time. Without the wait we would ask as fast as
> the main loop runs, and the guest would get no time.
> 
> On an error other than a stall the stream stays up, but back off to the
> slow timer. At a high speed bInterval of 125us an endpoint that keeps
> failing would otherwise send thousands of status messages a second.
> 
> Give every endpoint its own timer and bottom half. We ask each endpoint
> at its own rate. Drop the timer when the bottom half has already asked,
> so it does not fire for nothing.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Message-ID: <20261028034140.367393-8-jamin_lin@aspeedtech.com>
> ---
>  hw/usb/redirect-server.c | 298 ++++++++++++++++++++++++++++++++++++++-
>  hw/usb/trace-events      |   4 +
>  2 files changed, 298 insertions(+), 4 deletions(-)
>
> diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c
> index 7eeb08ecd7f1..fecb7119ddd4 100644
> --- a/hw/usb/redirect-server.c
> +++ b/hw/usb/redirect-server.c
> @@ -96,9 +96,13 @@ OBJECT_DECLARE_SIMPLE_TYPE(USBRedirServer, USB_REDIR_SERVER)
>   */
>  #define USBREDIR_SERVER_MAX_BULK (1 * MiB)
>  
> +/* Buffer size for an interrupt IN endpoint before its descriptor is seen. */
> +#define USBREDIR_SERVER_INTR_STREAM_DEFAULT_LEN 64
> +
>  #define USBREDIR_SERVER_CTRL 0
>  #define USBREDIR_SERVER_BULK 1
>  #define USBREDIR_SERVER_INTERRUPT 2
> +#define USBREDIR_SERVER_INTR_STREAM 3
>  
>  /* Which message answers the host when a control transfer ends. */
>  typedef enum {
> @@ -156,6 +160,15 @@ typedef struct USBRedirServerEp {
>      /* Asks again for a device that does not wake the endpoint. */
>      QEMUTimer *retry;
>  
> +    /*
> +     * Interrupt IN streaming. The timer asks the device again at the
> +     * endpoint's own rate, and more slowly after a NAK or an error.
> +     * The bottom half asks at once when the device says it has data.
> +     */
> +    QEMUTimer *stream_timer;
> +    QEMUBH *stream_bh;
> +    bool streaming;
> +
>      uint16_t max_packet;
>      uint8_t interval;
>      uint8_t iface;
> @@ -616,6 +629,97 @@ static void usbredir_server_interrupt_complete(USBRedirServer *s,
>                                      rp->data, len);
>  }
>  
> +/*
> + * How long to wait before asking the device again. bInterval means
> + * different things at different speeds: a number of frames at low and
> + * full speed, an exponent at high speed.
> + */
> +static int64_t usbredir_server_intr_stream_period_ns(USBRedirServer *s,
> +                                                     int ep_nr)
> +{
> +    int idx = usbredir_server_ep_index(ep_nr | USB_DIR_IN);
> +    USBDevice *device = usbredir_server_device(s);
> +    uint8_t interval = s->ep[idx].interval;
> +
> +    if (interval == 0) {
> +        interval = 1;
> +    }
> +
> +    if (device && device->speed == USB_SPEED_HIGH) {
> +        interval = MIN(interval, 16);
> +        return (1LL << (interval - 1)) * 125 * SCALE_US;
> +    }
> +
> +    return (int64_t)interval * SCALE_MS;
> +}
> +
> +/*
> + * The device answered a streamed request. Send the answer to the host, then
> + * ask again, because the host still wants more. Do not ask from here: the
> + * device may answer at once, and this function would call itself over and
> + * over. Arm the timer instead. It also waits for the endpoint's bInterval.
> + */
> +static void usbredir_server_intr_stream_complete(USBRedirServer *s,
> +                                                 USBRedirServerPkt *rp)
> +{
> +    struct usb_redir_interrupt_packet_header resp = rp->intr_hdr;
> +    struct usb_redir_interrupt_receiving_status_header st;
> +    int idx = usbredir_server_ep_index(resp.endpoint);
> +    int ep_nr = resp.endpoint & 0x0f;
> +    USBRedirServerEp *ep = &s->ep[idx];
> +    USBPacket *p = &rp->pkt;
> +    int actual = p->actual_length;
> +    bool retry = false;
> +    int64_t delay_ns;
> +
> +    trace_usbredir_server_intr_stream_complete(ep_nr, p->status, actual);
> +
> +    switch (p->status) {
> +    case USB_RET_SUCCESS:
> +        resp.status = usb_redir_success;
> +        resp.length = actual;
> +        usbredirparser_send_interrupt_packet(s->parser, 0, &resp,
> +                                             actual ? rp->data : NULL,
> +                                             actual);
> +        usbredirparser_do_write(s->parser);
> +        break;
> +    case USB_RET_NAK:
> +        /* no data yet; wait, unless the device wakes us first */
> +        retry = true;
> +        break;
> +    default:
> +        /*
> +         * The endpoint failed. There is no data, so send a status
> +         * message instead. The host gives it to its guest.
> +         *
> +         * redirect.c ends the stream only on a stall, so do the same
> +         * here. If we end it on any other error, the host still
> +         * thinks the stream runs, and it never asks again.
> +         */
> +        st.endpoint = resp.endpoint;
> +        st.status = usbredir_server_status(p->status);
> +        usbredirparser_send_interrupt_receiving_status(s->parser, 0, &st);
> +        usbredirparser_do_write(s->parser);
> +        if (p->status == USB_RET_STALL) {
> +            ep->streaming = false;
> +        } else {
> +            /* the stream stays up, but do not ask at the endpoint's rate */
> +            retry = true;
> +        }
> +        break;
> +    }
> +
> +    if (ep->streaming) {
> +        if (retry) {
> +            delay_ns = (int64_t)USBREDIR_SERVER_RETRY_MS * SCALE_MS;
> +        } else {
> +            delay_ns = usbredir_server_intr_stream_period_ns(s, ep_nr);
> +        }
> +        timer_mod(ep->stream_timer,
> +                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + delay_ns);
> +    }
> +}
> +
>  /*
>   * USB port ops
>   */
> @@ -688,6 +792,9 @@ static void usbredir_server_packet_complete(USBPort *port, USBPacket *p)
>      case USBREDIR_SERVER_INTERRUPT:
>          usbredir_server_interrupt_complete(s, rp);
>          break;
> +    case USBREDIR_SERVER_INTR_STREAM:
> +        usbredir_server_intr_stream_complete(s, rp);
> +        break;
>      default:
>          g_assert_not_reached();
>      }
> @@ -727,9 +834,11 @@ static USBRedirServerAsk usbredir_server_ask_device(USBRedirServer *s,
>  
>      /*
>       * Keep the request and send it again when the device wakes the
> -     * endpoint.
> +     * endpoint. A streamed request asks again by itself, with its own
> +     * timer.
>       */
> -    if (rp->pkt.status == USB_RET_NAK) {
> +    if (rp->pkt.status == USB_RET_NAK &&
> +        rp->type != USBREDIR_SERVER_INTR_STREAM) {
>          trace_usbredir_server_nak_park(rp->redir_id, rp->ep_idx);
>          QTAILQ_INSERT_HEAD(&ep->waiting, rp, waiting_link);
>          timer_mod(ep->retry, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> @@ -775,8 +884,18 @@ static void usbredir_server_wakeup_ep(USBBus *bus, USBEndpoint *ep,
>  {
>      USBRedirServer *s = container_of(bus, USBRedirServer, bus);
>      uint8_t addr = ep->nr | (ep->pid == USB_TOKEN_IN ? USB_DIR_IN : 0);
> +    int idx = usbredir_server_ep_index(addr);
>  
> -    usbredir_server_kick_ep(s, usbredir_server_ep_index(addr));
> +    /*
> +     * The device has data. A streaming interrupt IN endpoint may have
> +     * answered NAK. Ask now instead of waiting for the retry timer.
> +     */
> +    if (s->ep[idx].streaming) {
> +        qemu_bh_schedule(s->ep[idx].stream_bh);
> +    }
> +
> +    /* The host may also have a request stopped on this endpoint. */
> +    usbredir_server_kick_ep(s, idx);
>  }
>  
>  static USBBusOps usbredir_server_bus_ops = {
> @@ -830,6 +949,95 @@ static void usbredir_server_pkt_free(USBRedirServer *s, USBRedirServerPkt *rp)
>      g_free(rp);
>  }
>  
> +/*
> + * Interrupt IN streaming
> + */
> +
> +static bool usbredir_server_intr_stream_inflight(USBRedirServer *s, int ep_nr)
> +{
> +    USBRedirServerPkt *rp;
> +
> +    QTAILQ_FOREACH(rp, &s->inflight, inflight_link) {
> +        if (rp->type == USBREDIR_SERVER_INTR_STREAM &&
> +            (rp->intr_hdr.endpoint & 0x0f) == ep_nr) {
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +
> +/*
> + * Ask the device for data on @ep_nr and leave the request waiting. A device
> + * sends data only when asked. Do nothing if a request on @ep_nr is still
> + * unanswered.
> + */
> +static void usbredir_server_intr_stream_park(USBRedirServer *s, int ep_nr)
> +{
> +    USBDevice *device = usbredir_server_device(s);
> +    int idx = usbredir_server_ep_index(ep_nr | USB_DIR_IN);
> +    USBRedirServerPkt *rp;
> +    USBEndpoint *ep;
> +    int len;
> +
> +    /* No device to ask. */
> +    if (!device || !device->attached) {
> +        return;
> +    }
> +
> +    /* The host did not ask for this endpoint, or a request is unanswered. */
> +    if (!s->ep[idx].streaming ||
> +        usbredir_server_intr_stream_inflight(s, ep_nr)) {
> +        return;
> +    }
> +
> +    len = s->ep[idx].max_packet;
> +    if (len == 0) {
> +        len = USBREDIR_SERVER_INTR_STREAM_DEFAULT_LEN;
> +    }
> +    ep = usb_ep_get(device, USB_TOKEN_IN, ep_nr);
> +    rp = usbredir_server_pkt_alloc(len, idx);
> +    rp->type = USBREDIR_SERVER_INTR_STREAM;
> +    /* streamed data carries no host id */
> +    rp->redir_id = 0;

This puts a packet with id 0 on s->inflight, but
usbredir_server_cancel_data_packet() matches any inflight request by id.

A client cancel for a packet id == 0 can therefore hit this packet, send
a bogus cancelled interrupt packet. Skip USBREDIR_SERVER_INTR_STREAM in
the cancel lookup?

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


