Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06266CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 08:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHdCj-0000h2-BL; Fri, 16 Oct 2026 04:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xHdCh-0000gc-9o
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 04:22:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xHdCe-0007Mz-A4
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 04:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792138930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eJDRrBggAhwrnbxgOTEo7uFjS5x4fyav/IKctZDGF5U=;
 b=XQzA5p3NcADBkBuhHRsUscKZgiW6oMPvdry4lkQHOAivjbcezr1iTSxIP0nFDkrY5uh9US
 JI4AhBl9fMyEjFqw93/gicIaFDPgPrRAF17slZNng7O6YWzmH/aqCib4Ma1oWAVNzyywNk
 iXXOmmrFl1W9uF+SnSOlfJWeghDbuNA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-uY-6rLoXMR2cE1jLRDdGAw-1; Fri,
 16 Oct 2026 08:22:06 +0000
X-MC-Unique: uY-6rLoXMR2cE1jLRDdGAw-1
X-Mimecast-MFC-AGG-ID: uY-6rLoXMR2cE1jLRDdGAw_1792138924
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 70DB91955F0F; Fri, 16 Oct 2026 08:22:03 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6C9B21956043; Fri, 16 Oct 2026 08:22:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 7/8] hw/usb/redirect-server: Stream interrupt IN
 endpoints
From: marcandre.lureau@redhat.com
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: marcandre.lureau@redhat.com, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 Troy Lee <troy_lee@aspeedtech.com>
In-Reply-To: <20261015093417.573063-8-jamin_lin@aspeedtech.com>
References: <20261015093417.573063-1-jamin_lin@aspeedtech.com>
 <20261015093417.573063-8-jamin_lin@aspeedtech.com>
Date: Fri, 16 Oct 2026 12:21:35 +0400
Message-Id: <179213889552.772140.17702169257193957989.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=16604;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=+Bxz1F0yi4RNkF5Ksxpxbfz8Cy374oVLH2SsXYC/488=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq0d6muAZPYTLFM8D3cBys8cs4wGRgC+q+GaibD
 xRDS4vNseCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatHepgAKCRDa6OEJdZac
 5UmyEACCJLoEJp3Rzhg2b3AY/P2+kDVYbsTIt0zdtv8yFQW2v1ixrFo8kF2ZVvhESWmAtsTAH44
 JtTyyMumKZLEhArzwc6TBR1uqcB/r/g2eRhbeyRzHJ3ggCy6qFEJpVR7WqF8emb6MgPklROVCoN
 s8EOkFFgnk1CLcEhahN7/XWyBeGVVrxNIL+mlyyEIdRY4HemVNEpVlQ8FvCiZLjE3oPgLFG4KkF
 FmPE+/svCaTGgqn0pWsZDYyhDgj9aG13d1XGkhOjRzmPpjIFmmohbrcJqpK78R+xeoqY6sRqugr
 jBcu7h47P6H07vVBN5kvlOwa8XFIBspyrBGMf828Ejdqqb2f7CfyZ9VQRTdvVJzyp8qROdHdBBz
 QIuWZu2tBfBjZIrgLgrzmbQoYYt+KdDpo1lEu/s0FEVrNdm5nl3y2jHFdBMIUJYvzHb5OchV8GL
 Vf7P9mpdGlIBk90UtqnuP/py5E8vzZ5GXfz8FLjqt03vtBKiGNETXKVgGlLnanWP8qN5K8Fsnr1
 hE0zXN75bBCFkkqao4hWCVR2guT3/M4z/Ocue3j7ET5OnKKeFZsNQBlJ13sUQAtIIe/0pIogSK4
 C3LOwzgro77aiUJ3BcgXCdyIndjaLM+o8UQe1jZr15O81L2grBoOJxFyQqI4KcXCZDIfEu0e3Wg
 FgU4AQY7g6Z6jxg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> Interrupt IN is not a request and an answer in usbredir. The host asks
> once with start_interrupt_receiving. After that it expects a packet
> every time the device has data.
> 
> Park one IN packet on the device for each streaming endpoint. A device
> that answers USB_RET_ASYNC holds the packet and completes it when it
> has data. A device that answers USB_RET_NAK gives the packet back at
> once, so park a new one when the bus reports a wakeup on that endpoint.
> A slow timer parks one too, for a device that does not report a wakeup.
> 
> Wait for the endpoint's bInterval before parking the next one. Some
> devices answer every time. Without the wait we would ask as fast as
> the main loop runs, and the guest would get no time.
> 
> Give every endpoint its own timer and bottom half. We ask each endpoint
> at its own rate.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Message-ID: <20261015093417.573063-8-jamin_lin@aspeedtech.com>
>
> diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c
> index bf5286b64996..149435bf9d3d 100644
> --- a/hw/usb/redirect-server.c
> +++ b/hw/usb/redirect-server.c
> @@ -56,6 +56,7 @@
>  #include "qemu/main-loop.h"
>  #include "qemu/module.h"
>  #include "migration/vmstate.h"
> +#include "qemu/timer.h"
>  #include "qemu/cutils.h"
>  #include "hw/core/sysbus.h"
>  #include "hw/usb/usb.h"
> @@ -82,16 +83,30 @@ OBJECT_DECLARE_SIMPLE_TYPE(USBRedirServer, USB_REDIR_SERVER)
>  #define USBREDIR_SERVER_MAX_EP 32
>  #define USBREDIR_SERVER_EP_IN_BASE 16
>  
> +/* An endpoint number is 4 bits, so 0 to 15. */
> +#define USBREDIR_SERVER_MAX_EP_NR 16
> +
>  /*
>   * The bulk length field is 32 bits, so the host can ask for up to 4 GB.
>   * This is the largest transfer accepted.
>   */
>  #define USBREDIR_SERVER_MAX_BULK (1 * MiB)
>  
> +/* Buffer size for an interrupt IN endpoint before its descriptor is seen. */
> +#define USBREDIR_SERVER_INTR_DEFAULT_LEN 64
> +
> +/*
> + * Ask again this often after an endpoint answered NAK. Most devices wake
> + * the bus when data arrives, and then the next ask happens at once. This
> + * timer is for the devices that do not wake the bus.
> + */
> +#define USBREDIR_SERVER_INTR_RETRY_MS 1000
> +
>  #define USBREDIR_SERVER_CTRL_SETUP 0
>  #define USBREDIR_SERVER_CTRL_STATUS 1
>  #define USBREDIR_SERVER_BULK 2
>  #define USBREDIR_SERVER_INTR 3
> +#define USBREDIR_SERVER_INTR_STREAM 4
>  
>  /* Which message answers the host when a control transfer ends. */
>  typedef enum {
> @@ -120,6 +135,13 @@ typedef struct USBRedirServerPkt {
>      int type;
>  } USBRedirServerPkt;
>  
> +typedef struct USBRedirServerIntrStream {
> +    QEMUTimer *timer;
> +    bool started;
> +    QEMUBH *bh;
> +    uint8_t nr;
> +} USBRedirServerIntrStream;
> +
>  struct USBRedirServer {
>      SysBusDevice parent_obj;
>  
> @@ -140,6 +162,15 @@ struct USBRedirServer {
>      bool host_connected;
>      bool device_announced;
>  
> +    /*
> +     * Interrupt IN streaming, indexed by endpoint number. Every endpoint
> +     * has its own timer and bottom half, because every one wants to be
> +     * asked at its own rate. The timer asks the device again, after the
> +     * endpoint's interval or after a NAK. The bottom half asks at once
> +     * when the device says it has data.
> +     */
> +    USBRedirServerIntrStream intr_stream[USBREDIR_SERVER_MAX_EP_NR];
> +
>      /* In-flight packet tracking */
>      QTAILQ_HEAD(, USBRedirServerPkt) inflight;
>      uint64_t next_id;
> @@ -580,6 +611,86 @@ static void usbredir_server_intr_complete(USBRedirServer *s,
>      usbredirparser_do_write(s->parser);
>  }
>  
> +/*
> + * How long to wait before asking the device again. bInterval means
> + * different things at different speeds: a number of frames at low and
> + * full speed, an exponent at high speed.
> + */
> +static int64_t usbredir_server_intr_period_ns(USBRedirServer *s, int ep_nr)
> +{
> +    uint8_t interval = s->ep_interval[ep_nr + USBREDIR_SERVER_EP_IN_BASE];
> +    USBDevice *device = usbredir_server_device(s);
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
> + * The device answered a parked request. Send the answer to the host, then
> + * ask again, because the host still wants more. Do not ask from here: the
> + * device may answer at once, and this function would call itself over and
> + * over. Arm the timer instead. It also waits for the endpoint's bInterval.
> + */
> +static void usbredir_server_intr_stream_complete(USBRedirServer *s,
> +                                                 USBRedirServerPkt *rp)
> +{
> +    struct usb_redir_interrupt_packet_header resp = rp->intr_hdr;
> +    struct usb_redir_interrupt_receiving_status_header st;
> +    int ep_nr = resp.endpoint & 0x0f;
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
> +        /* nothing to report yet; ask again shortly */
> +        retry = true;
> +        break;
> +    default:
> +        /*
> +         * The endpoint stalled or failed. There is no data to send, so
> +         * send a status message. The host keeps that status and gives it
> +         * to its guest. On a stall the host also ends the stream, so end
> +         * it here too. A later request from the guest starts a new one.
> +         */
> +        st.endpoint = resp.endpoint;
> +        st.status = usbredir_server_status(p->status);
> +        usbredirparser_send_interrupt_receiving_status(s->parser, 0, &st);
> +        usbredirparser_do_write(s->parser);
> +        s->intr_stream[ep_nr].started = false;

redirect.c (usbredir_interrupt_receiving_status) only clears interrupt_started
on usb_redir_stall. For babble or ioerror it stores the error, returns it to its
guest once, and keeps interrupt_started set, so it will not send
start_interrupt_receiving again (usbredir_handle_interrupt_in_data only starts
when !interrupt_started). Since started is cleared here for every status, a
babble or an ioerror leaves the stream dead on the client side.

Only end the stream on USB_RET_STALL and keep streaming/parking (with the period
delay) for the other errors?

In theory, emulated devices shouldn't reach this condition. But nothing prevents
a usb-host being exported too.

> +        break;
> +    }
> +
> +    if (s->intr_stream[ep_nr].started) {
> +        if (retry) {
> +            delay_ns = (int64_t)USBREDIR_SERVER_INTR_RETRY_MS * SCALE_MS;
> +        } else {
> +            delay_ns = usbredir_server_intr_period_ns(s, ep_nr);
> +        }
> +        timer_mod(s->intr_stream[ep_nr].timer,
> +                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + delay_ns);
> +    }
> +}
> +
>  /*
>   * USB port ops
>   */
> @@ -658,6 +769,9 @@ static void usbredir_server_packet_complete(USBPort *port, USBPacket *p)
>      case USBREDIR_SERVER_INTR:
>          usbredir_server_intr_complete(s, rp);
>          break;
> +    case USBREDIR_SERVER_INTR_STREAM:
> +        usbredir_server_intr_stream_complete(s, rp);
> +        break;
>      }
>  
>      usbredir_server_pkt_free(rp);
> @@ -675,7 +789,25 @@ static USBPortOps usbredir_server_port_ops = {
>   * USB bus ops
>   */
>  
> +static void usbredir_server_wakeup_ep(USBBus *bus, USBEndpoint *ep,
> +                                      unsigned int stream)
> +{
> +    USBRedirServer *s = container_of(bus, USBRedirServer, bus);
> +    int ep_nr = ep->nr;
> +
> +    /*
> +     * The device has data. A streaming interrupt IN endpoint may have
> +     * answered NAK. Ask now instead of waiting for the retry timer.
> +     * Every other transfer already has its request on the device.
> +     */
> +    if (ep->pid == USB_TOKEN_IN && ep_nr < USBREDIR_SERVER_MAX_EP_NR &&
> +        s->intr_stream[ep_nr].started) {
> +        qemu_bh_schedule(s->intr_stream[ep_nr].bh);
> +    }
> +}
> +
>  static USBBusOps usbredir_server_bus_ops = {
> +    .wakeup_endpoint = usbredir_server_wakeup_ep,
>  };
>  
>  /*
> @@ -726,6 +858,89 @@ static void usbredir_server_drop_pkt(USBRedirServer *s,
>      usbredir_server_pkt_free(rp);
>  }
>  
> +/*
> + * Interrupt IN streaming
> + */
> +
> +static bool usbredir_server_intr_inflight(USBRedirServer *s, int ep_nr)
> +{
> +    USBRedirServerPkt *rp;
> +
> +    QTAILQ_FOREACH(rp, &s->inflight, next) {
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
> +static void usbredir_server_intr_park(USBRedirServer *s, int ep_nr)
> +{
> +    USBDevice *device = usbredir_server_device(s);
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
> +    if (!s->intr_stream[ep_nr].started ||
> +        usbredir_server_intr_inflight(s, ep_nr)) {
> +        return;
> +    }
> +
> +    len = s->ep_max_packet[ep_nr + USBREDIR_SERVER_EP_IN_BASE];
> +    if (len == 0) {
> +        len = USBREDIR_SERVER_INTR_DEFAULT_LEN;
> +    }
> +    ep = usb_ep_get(device, USB_TOKEN_IN, ep_nr);
> +    rp = usbredir_server_pkt_alloc(len);
> +    rp->type = USBREDIR_SERVER_INTR_STREAM;
> +    /* streamed data carries no host id */
> +    rp->redir_id = 0;
> +    rp->intr_hdr.endpoint = ep_nr | USB_DIR_IN;
> +
> +    usb_packet_setup(&rp->pkt, USB_TOKEN_IN, ep, 0, s->next_id++,
> +                     false, false);
> +    usb_packet_addbuf(&rp->pkt, rp->data, len);
> +
> +    trace_usbredir_server_intr_park(ep_nr, len);
> +    usbredir_server_submit_to_device(s, rp);
> +}
> +
> +/* BH and timer callback: ask again on one streaming endpoint. */
> +static void usbredir_server_intr_kick(void *opaque)
> +{
> +    USBRedirServerIntrStream *st = opaque;
> +    USBRedirServer *s = container_of(st - st->nr, USBRedirServer,
> +                                     intr_stream[0]);

Pointer arithmetic on the array element to get back to intr_stream[0] works but
is not obvious. Storing USBRedirServer *s in USBRedirServerIntrStream makes this
simply "st->s".

> +
> +    usbredir_server_intr_park(s, st->nr);
> +}
> +
> +static void usbredir_server_intr_cancel(USBRedirServer *s, int ep_nr)
> +{
> +    USBRedirServerPkt *tmp;
> +    USBRedirServerPkt *rp;
> +
> +    QTAILQ_FOREACH_SAFE(rp, &s->inflight, next, tmp) {
> +        if (rp->type != USBREDIR_SERVER_INTR_STREAM ||
> +            (rp->intr_hdr.endpoint & 0x0f) != ep_nr) {
> +            continue;
> +        }
> +        usbredir_server_drop_pkt(s, rp);
> +    }
> +}
> +
>  /*
>   * usbredirparser I/O and logging callbacks
>   */
> @@ -1156,6 +1371,58 @@ static void usbredir_server_interface_info(void *priv,
>      /* The host should not send this to a device. Nothing to do. */
>  }
>  
> +/*
> + * The host asks to stream an interrupt IN endpoint. Send the receiving
> + * status first. Without that status the host throws the interrupt
> + * packet away. Then ask the device once.
> + */
> +static void usbredir_server_start_interrupt_receiving(void *priv,
> +    uint64_t id, struct usb_redir_start_interrupt_receiving_header *hdr)
> +{
> +    struct usb_redir_interrupt_receiving_status_header st = {
> +        .endpoint = hdr->endpoint,
> +        .status = usb_redir_success,
> +    };
> +    USBRedirServer *s = priv;
> +    USBDevice *device = usbredir_server_device(s);
> +    int ep_nr = hdr->endpoint & 0x0f;
> +
> +    /*
> +     * Endpoint 0 is control and an OUT endpoint never streams. There also
> +     * has to be a host to send to and a device to ask.
> +     */
> +    if (ep_nr == 0 || !(hdr->endpoint & USB_DIR_IN) ||
> +        !s->host_connected || !device || !device->attached) {
> +        st.status = usb_redir_ioerror;
> +    } else {
> +        s->intr_stream[ep_nr].started = true;
> +    }
> +
> +    trace_usbredir_server_intr_start(hdr->endpoint, st.status);
> +    usbredirparser_send_interrupt_receiving_status(s->parser, id, &st);
> +    usbredirparser_do_write(s->parser);
> +
> +    if (st.status == usb_redir_success) {
> +        usbredir_server_intr_park(s, ep_nr);
> +    }
> +}
> +
> +static void usbredir_server_stop_interrupt_receiving(void *priv, uint64_t id,
> +    struct usb_redir_stop_interrupt_receiving_header *hdr)
> +{
> +    int ep_nr = hdr->endpoint & 0x0f;
> +    USBRedirServer *s = priv;
> +
> +    /* Endpoint 0 is control, and an OUT endpoint never streams. */
> +    if (ep_nr == 0 || !(hdr->endpoint & USB_DIR_IN)) {
> +        return;
> +    }
> +
> +    trace_usbredir_server_intr_stop(hdr->endpoint);
> +    s->intr_stream[ep_nr].started = false;
> +    usbredir_server_intr_cancel(s, ep_nr);

stop_transfers() cancels the BH and deletes the timer, but this path
does not. It is harmless today because intr_park() checks started, but
timer_del()/qemu_bh_cancel() here would keep both paths consistent.

> +}
> +
>  static void usbredir_server_alloc_bulk_streams(void *priv, uint64_t id,
>      struct usb_redir_alloc_bulk_streams_header *hdr)
>  {
> @@ -1259,6 +1526,17 @@ static void usbredir_server_send_cancelled(USBRedirServer *s,
>  static void usbredir_server_stop_transfers(USBRedirServer *s)
>  {
>      USBRedirServerPkt *rp;
> +    int i;
> +
> +    for (i = 0; i < USBREDIR_SERVER_MAX_EP_NR; i++) {
> +        s->intr_stream[i].started = false;
> +        if (s->intr_stream[i].bh) {
> +            qemu_bh_cancel(s->intr_stream[i].bh);
> +        }
> +        if (s->intr_stream[i].timer) {
> +            timer_del(s->intr_stream[i].timer);
> +        }
> +    }
>  
>      /*
>       * No "cancelled" response here. This runs on a bus reset, a detach or
> @@ -1305,6 +1583,10 @@ static void usbredir_server_create_parser(USBRedirServer *s)
>      s->parser->device_disconnect_ack_func =
>          usbredir_server_device_disconnect_ack;
>      s->parser->interface_info_func = usbredir_server_interface_info;
> +    s->parser->start_interrupt_receiving_func =
> +        usbredir_server_start_interrupt_receiving;
> +    s->parser->stop_interrupt_receiving_func =
> +        usbredir_server_stop_interrupt_receiving;
>      s->parser->alloc_bulk_streams_func = usbredir_server_alloc_bulk_streams;
>      s->parser->cancel_data_packet_func = usbredir_server_cancel_data_packet;
>      s->parser->start_bulk_receiving_func =
> @@ -1425,6 +1707,8 @@ static void usbredir_server_chardev_event(void *opaque,
>  static void usbredir_server_realize(DeviceState *dev, Error **errp)
>  {
>      USBRedirServer *s = USB_REDIR_SERVER(dev);
> +    USBRedirServerIntrStream *st;
> +    int i;
>  
>      if (!qemu_chr_fe_backend_connected(&s->cs)) {
>          error_setg(errp,
> @@ -1444,6 +1728,14 @@ static void usbredir_server_realize(DeviceState *dev, Error **errp)
>                        USB_SPEED_MASK_LOW | USB_SPEED_MASK_FULL |
>                        USB_SPEED_MASK_HIGH);
>  
> +    for (i = 0; i < USBREDIR_SERVER_MAX_EP_NR; i++) {
> +        st = &s->intr_stream[i];

Endpoint 0 never streams (start_interrupt_receiving rejects it), so
the timer/BH for slot 0 are never used. Could start the loops at 1.

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


