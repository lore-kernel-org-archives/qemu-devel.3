Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32053CCF2E3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:45:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xImjx-00042p-Jz; Mon, 19 Oct 2026 08:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xImjC-0003xp-P4
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:44:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xImjA-0003Pq-KB
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792413871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RfUSFJmBxuGSfG7eFu9XQ03IgfV4XCagYd4Bn2ozT3M=;
 b=OIr8otzUltLKUETbwKvRPIF0cW9DlEb92INJXakzsh42z5OknQgxxUTcs9JE/HAEGmATVT
 UufRjU/YwKx6u4B65oQBe2cEBqLDY1gNjCsPx6n7Kp7URkazKOdiBIDsiBTecoOpwybRPf
 PSdTNbtwFarIybrwHXsltDbIJ4VwsOg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-zxWsQA21PnWc0wnK6B2qMA-1; Mon,
 19 Oct 2026 12:44:29 +0000
X-MC-Unique: zxWsQA21PnWc0wnK6B2qMA-1
X-Mimecast-MFC-AGG-ID: zxWsQA21PnWc0wnK6B2qMA_1792413868
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A1DE1800644; Mon, 19 Oct 2026 12:44:28 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2BA3C30000E3; Mon, 19 Oct 2026 12:44:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 7/8] hw/usb/redirect-server: Stream interrupt IN
 endpoints
From: marcandre.lureau@redhat.com
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: junjie.cao@linux.dev, junjie.cao@intel.com, marcandre.lureau@redhat.com, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Kane Chen <kane_chen@aspeedtech.com>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 Troy Lee <troy_lee@aspeedtech.com>
In-Reply-To: <20261019092448.278079-8-jamin_lin@aspeedtech.com>
References: <20261019092448.278079-1-jamin_lin@aspeedtech.com>
 <20261019092448.278079-8-jamin_lin@aspeedtech.com>
Date: Mon, 19 Oct 2026 16:44:13 +0400
Message-Id: <179241385397.2501033.1379443947607439383.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7091;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=XGQjGNWMZ2aqHCVwBxyOSb9zimvkA/sUSgcqL0F/MXM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq1hCgQjj8n02rjtpQfb0BDo+3pVhTeu85q6km0
 RrUSuI/HjOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatYQoAAKCRDa6OEJdZac
 5U7DD/4miNWQ/G/W4uEVebHJqdtwWic6U37y61Q9wi2kZ0/cn3YUDwbTgeOZgG449Z14qcU52pu
 2cxqbjK9F7JjN7GECTpmTXrJT7eA4atltnSwejFMNeWm8gq8OOEvMgdVb5cwGOcQBQSkNVXB/YO
 wEReL3hz/lV9axcBaG5GqWP8g0vJReIsc6bq94ojLdsQHloNRk3im2xqAAJFWU1cQFYVDh7YK7d
 F3f3d3jka/w5686x50VF2rIz3BXplIQ0cCc6wAsMWi+RDCe7ZaZvaEwGyKiWHRBPQ7IE7rQiuhE
 uezEdRm+CEIRoEQNVTBdxTyCF4nPrzHKCUd7vCIzP1X5jBG4rTykYILvotINnBNSOFdhKox+ZY8
 VmPJHaruwUUuXE4QrntcR3oEsUZtzqMFYhwCT2QwQ7MFc/fc7r+Zyq7maBdwVWMizSSAe4d6CCX
 wnK6vntBqwChqADekIsBhk/csAEUCKDS9tx/ZKFUOflwmcIoFuzcZjHqqO7eIW8KUD+b/rZ6x/L
 Z2vIhgg8OhDfH/07MiE5jtVUOd0l175nK8F4wcvIifbvn51183d2XbBUSBgYPM+smFmzT7bdzvZ
 FP9OFn0FWsHx2/N8fsNMJc+8uM2iIzhzkcV41PZ3oOQol17cizd/CxPaw9GJWiKFPQVNlw6X9Fi
 W93WDxd53JD0KCg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> Message-ID: <20261019092448.278079-8-jamin_lin@aspeedtech.com>
>
> diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c
> index f81dbae2d0b2..6b2e65c1268e 100644
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
> @@ -120,6 +135,14 @@ typedef struct USBRedirServerPkt {
>      int type;
>  } USBRedirServerPkt;
>  
> +typedef struct USBRedirServerIntrStream {
> +    USBRedirServer *s;
> +    QEMUTimer *timer;
> +    bool started;
> +    QEMUBH *bh;
> +    uint8_t nr;
> +} USBRedirServerIntrStream;
> +
>  struct USBRedirServer {
>      SysBusDevice parent_obj;
>  
> @@ -140,6 +163,15 @@ struct USBRedirServer {
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
> @@ -580,6 +612,90 @@ static void usbredir_server_intr_complete(USBRedirServer *s,
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
> +            s->intr_stream[ep_nr].started = false;
> +        }
> +        break;
> +    }

Minor: for a persistent non-stall error (e.g. a usb-host device returning
ioerror), the stream stays started and the timer below re-arms at bInterval.
That sends an interrupt_receiving_status every period, 1000 messages a second
for a 1 ms endpoint, Would it make sense to back off with
USBREDIR_SERVER_INTR_RETRY_MS after an error, as is done for NAK?

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


