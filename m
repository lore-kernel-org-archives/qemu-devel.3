Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C67CCF2D6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xImjY-000403-Nq; Mon, 19 Oct 2026 08:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xImjA-0003xa-IN
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:44:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xImj8-0003PU-CQ
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792413869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ss8FVFCQmAm0Cw+ocJutoWL6B49vaiBKJgSsH0LPoc=;
 b=iRI9MMgXOZsZgl+/0d8pzlyLZGqrimWFG2su73ndHMkuvsz7naCkCzJqzJrgdulFu6ogyO
 rgmDLrZfWwyJvfiNPtqTyVEgFzLX/5AdIvoE4VPrvK+aTaikHm4tbNl6PYuYdFdkXcu3rK
 Q6379K/Lwn47Xuu6FM+Y9kW0pto3bT4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-73NfPFipPb-SKvzJ07GnZg-1; Mon,
 19 Oct 2026 12:44:26 +0000
X-MC-Unique: 73NfPFipPb-SKvzJ07GnZg-1
X-Mimecast-MFC-AGG-ID: 73NfPFipPb-SKvzJ07GnZg_1792413865
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D95318005A5; Mon, 19 Oct 2026 12:44:24 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4310A30000E3; Mon, 19 Oct 2026 12:44:22 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 6/8] hw/usb/redirect-server: Implement bulk and
 interrupt transfers
From: marcandre.lureau@redhat.com
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: junjie.cao@linux.dev, junjie.cao@intel.com, marcandre.lureau@redhat.com, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Kane Chen <kane_chen@aspeedtech.com>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 Troy Lee <troy_lee@aspeedtech.com>
In-Reply-To: <20261019092448.278079-7-jamin_lin@aspeedtech.com>
References: <20261019092448.278079-1-jamin_lin@aspeedtech.com>
 <20261019092448.278079-7-jamin_lin@aspeedtech.com>
Date: Mon, 19 Oct 2026 16:44:13 +0400
Message-Id: <179241385396.2501033.4549105551233498931.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7031;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=rU8fBr37w2TkDQMf9cg2GSBxaBAgt/LwGvabBe7CKcs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq1hCggEvWct1XRBT3zNAbVBTycSlDuJDc9GPqD
 5zVFdwtiz2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatYQoAAKCRDa6OEJdZac
 5cdjD/4g+G2jIxsjF8iTGVF3Xx/KcsynquS2Yp/AizBO+Qc/jLJZXdjwrkeviPFQhEun++pQwYx
 pV7d++hed7BmkUHZvHqJgK1vDru7sJk37i9J9zmWWPJW0Jk0vzDtW7L9H9UrChSnhn9XZAyLC09
 3F+cXWSq6L3i0WE0/0WKAfAhFwFJ43ZH1NnyfNNLaJnmSDwNmrdAs+z9xqszyNYi4VwsU3/ldhJ
 yqEeZC1EH1OG9qYaWLI1P4idv44rp6wYdOfsyN0shNRO5RlhVhpP0sFYSc5D34NWgyFFERk2OKx
 YvVm/RxFdZSW5YVN1bnJeHdEnQEmSC8xp/MT98Ab06CqMmc4bO4naDX+zjqwF2jdMPLCF3g0Utq
 gXdycHRMFfCGu2GG/O/NIwgEVSVnInyCLScCVAGgxWEAJYq6NzNv1XT1T2Ex2VuFJ80JcEWnNaA
 bpzZODj/g1ITDaRZlSakvtRGnM4vw4LzIf4smJeJ50zvnTg3iHOT4WDSn8FFQXnW9RTfnQpnNvp
 hRf7H8/BSm9HXjIvV1mWa1wkWdM29CNtiiUmm4YzbmBmI7AuxpI/FrlaZhbuMbrIKAJpmLdzCK6
 MN3PRNv/2fS1/A0EPexfImOU3SKS14fRaRwjIfvisXJqokK0yyHCP6/IytPD9cEEcWdWGurKM6l
 8d6eD4fy+8n8Z8w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

> Send bulk and interrupt packets to the device and return the result to
> the host. Each one is a request and an answer, so they reuse the packet
> tracking added for control transfers.
> 
> A bulk request carries a 32 bit length, so the host can ask us to
> allocate up to 4 GB. Refuse a request that big. Do not answer it with
> fewer bytes instead: the host counts the bytes it gets back, and it
> resets the device when some are missing.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Can you drop my reviewed-by, we are undergoing still significant changes. Thanks

> Message-ID: <20261019092448.278079-7-jamin_lin@aspeedtech.com>
>
> diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c
> index 29a9fbc94178..f81dbae2d0b2 100644
> --- a/hw/usb/redirect-server.c
> +++ b/hw/usb/redirect-server.c
> @@ -82,8 +82,16 @@ OBJECT_DECLARE_SIMPLE_TYPE(USBRedirServer, USB_REDIR_SERVER)
>  #define USBREDIR_SERVER_MAX_EP 32
>  #define USBREDIR_SERVER_EP_IN_BASE 16
>  
> +/*
> + * The bulk length field is 32 bits, so the host can ask for up to 4 GB.
> + * This is the largest transfer accepted.
> + */
> +#define USBREDIR_SERVER_MAX_BULK (1 * MiB)
> +
>  #define USBREDIR_SERVER_CTRL_SETUP 0
>  #define USBREDIR_SERVER_CTRL_STATUS 1
> +#define USBREDIR_SERVER_BULK 2
> +#define USBREDIR_SERVER_INTR 3
>  
>  /* Which message answers the host when a control transfer ends. */
>  typedef enum {
> @@ -96,7 +104,9 @@ typedef struct USBRedirServerPkt {
>      USBPacket pkt;
>  
>      /* Saved headers for the usbredir response */
> +    struct usb_redir_interrupt_packet_header intr_hdr;
>      struct usb_redir_control_packet_header ctrl_hdr;
> +    struct usb_redir_bulk_packet_header bulk_hdr;
>  
>      /*
>       * The IOV points here. IN data lands in it, OUT data is copied in.
> @@ -524,6 +534,52 @@ static void usbredir_server_ctrl_status_complete(USBRedirServer *s,
>      usbredir_server_send_ep_info(s);
>  }
>  
> +static void usbredir_server_bulk_complete(USBRedirServer *s,
> +                                          USBRedirServerPkt *rp)
> +{
> +    struct usb_redir_bulk_packet_header resp = rp->bulk_hdr;
> +    bool is_in = !!(rp->bulk_hdr.endpoint & USB_DIR_IN);
> +    int actual = rp->pkt.actual_length;
> +    int len;
> +
> +    resp.status = usbredir_server_status(rp->pkt.status);

A bulk IN that the device answers with USB_RET_NAK ends up here, since
submit_to_device() completes everything that is not USB_RET_ASYNC, and
usbredir_server_status() turns it into usb_redir_ioerror.

usbredirhost, the libusb backend, keeps the transfer pending until data
arrives. The server should do the same here: on NAK keep the packet on
the inflight list and submit it again from wakeup_endpoint, like the
interrupt stream in patch 7 does.

> +
> +    /* Only an IN transfer carries data back. */
> +    len = is_in ? actual : 0;
> +    resp.length = len;
> +    resp.length_high = len >> 16;
> +
> +    trace_usbredir_server_bulk_complete(rp->redir_id, resp.endpoint,
> +                                        resp.status, actual);
> +
> +    usbredirparser_send_bulk_packet(s->parser, rp->redir_id, &resp,
> +                                    len > 0 ? rp->data : NULL, len);
> +    usbredirparser_do_write(s->parser);
> +}
> +
> +static void usbredir_server_intr_complete(USBRedirServer *s,
> +                                          USBRedirServerPkt *rp)
> +{
> +    struct usb_redir_interrupt_packet_header resp = rp->intr_hdr;
> +    bool is_in = !!(rp->intr_hdr.endpoint & USB_DIR_IN);
> +    int actual = rp->pkt.actual_length;
> +    int len;
> +
> +    resp.status = usbredir_server_status(rp->pkt.status);
> +
> +    /* Only an IN transfer carries data back. */
> +    len = is_in ? actual : 0;
> +    resp.length = len;
> +
> +    trace_usbredir_server_intr_complete(rp->redir_id, resp.endpoint,
> +                                        resp.status, actual);
> +
> +    usbredirparser_send_interrupt_packet(s->parser, rp->redir_id, &resp,
> +                                         len > 0 ? rp->data : NULL,
> +                                         len);
> +    usbredirparser_do_write(s->parser);
> +}
> +
>  /*
>   * USB port ops
>   */
> @@ -600,6 +656,12 @@ static void usbredir_server_packet_complete(USBPort *port, USBPacket *p)
>      case USBREDIR_SERVER_CTRL_STATUS:
>          usbredir_server_ctrl_status_complete(s, rp);
>          break;
> +    case USBREDIR_SERVER_BULK:
> +        usbredir_server_bulk_complete(s, rp);
> +        break;
> +    case USBREDIR_SERVER_INTR:
> +        usbredir_server_intr_complete(s, rp);
> +        break;
>      }
>  
>      usbredir_server_pkt_free(rp);
> @@ -979,6 +1041,110 @@ static void usbredir_server_get_alt_setting(void *priv, uint64_t id,
>                                 USBREDIR_SERVER_REPLY_ALT);
>  }
>  
> +static void usbredir_server_bulk_packet(void *priv, uint64_t id,
> +    struct usb_redir_bulk_packet_header *hdr,
> +    uint8_t *data, int data_len)
> +{
> +    USBRedirServer *s = priv;
> +    USBDevice *device = usbredir_server_device(s);
> +    bool is_in = !!(hdr->endpoint & USB_DIR_IN);
> +    int pid = is_in ? USB_TOKEN_IN : USB_TOKEN_OUT;
> +    struct usb_redir_bulk_packet_header resp;
> +    int ep_nr = hdr->endpoint & 0x0f;
> +    USBRedirServerPkt *rp;
> +    USBEndpoint *ep;
> +    uint32_t len;
> +
> +    if (!s->host_connected || !device || !device->attached) {
> +        usbredirparser_free_packet_data(s->parser, data);
> +        return;
> +    }
> +
> +    /* IN: what the host asked for. OUT: what the host sent. */
> +    len = is_in ? (((uint32_t)hdr->length_high << 16) | hdr->length)
> +                : (uint32_t)data_len;
> +
> +    /*
> +     * Too big. Tell the host the transfer failed.
> +     * Do not send back less data instead. The host would see the
> +     * missing bytes as an error and reset the device.
> +     */
> +    if (len > USBREDIR_SERVER_MAX_BULK) {
> +        resp = *hdr;
> +        resp.status = usb_redir_inval;
> +        resp.length = 0;
> +        resp.length_high = 0;
> +
> +        trace_usbredir_server_bulk_too_big(id, hdr->endpoint, len);
> +        usbredirparser_send_bulk_packet(s->parser, id, &resp, NULL, 0);
> +        usbredirparser_do_write(s->parser);
> +        usbredirparser_free_packet_data(s->parser, data);
> +        return;
> +    }
> +
> +    ep = usb_ep_get(device, pid, ep_nr);

Nothing rejects ep_nr == 0. usb_ep_get() then returns the control endpoint and
usb_process_one() runs do_token_in()/do_token_out() on it, mixing a "bulk"
packet into ep0's setup state machine.  Same for
usbredir_server_interrupt_packet() below.

Answer usb_redir_inval for endpoint 0, as start_interrupt_receiving does in
patch 7?

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


