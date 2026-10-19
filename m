Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 865D8CCF2E4
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xImjS-0003zX-CF; Mon, 19 Oct 2026 08:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xImjA-0003xZ-I3
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:44:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xImj6-0003P9-Rs
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792413864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FDVOPWHiYultAj2ah4ZL2r2UsnFkpU9dALL+wUoJ9tE=;
 b=KOn355ALDxDziOeMXVGs/O2mkHromJCgmx0MMinobweI0GPQDuOD7p7ASXUibP+baYxObV
 IGWvSO0ybf8g8S5XkxFFS2CdpXieJ8wvZUpKXTx+7DCBAUnQLZgmGJ/u+al9O0GFnmgHPU
 meeru9eg6nh5aGsHTdY+b81UOe2XvwQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-NKsqUiUvNJedA9AqYAHS5g-1; Mon,
 19 Oct 2026 12:44:23 +0000
X-MC-Unique: NKsqUiUvNJedA9AqYAHS5g-1
X-Mimecast-MFC-AGG-ID: NKsqUiUvNJedA9AqYAHS5g_1792413861
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF54D1955E77; Mon, 19 Oct 2026 12:44:20 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3843430000E7; Mon, 19 Oct 2026 12:44:18 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 5/8] hw/usb/redirect-server: Implement control transfers
From: marcandre.lureau@redhat.com
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: junjie.cao@linux.dev, junjie.cao@intel.com, marcandre.lureau@redhat.com, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Kane Chen <kane_chen@aspeedtech.com>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 Troy Lee <troy_lee@aspeedtech.com>
In-Reply-To: <20261019092448.278079-6-jamin_lin@aspeedtech.com>
References: <20261019092448.278079-1-jamin_lin@aspeedtech.com>
 <20261019092448.278079-6-jamin_lin@aspeedtech.com>
Date: Mon, 19 Oct 2026 16:44:13 +0400
Message-Id: <179241385396.2501033.7624905752281596186.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=26072;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=cAzRiiyBx9CvePkbCLm4xLp8J64oN/8HvfKJLijBRhU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq1hCflX6RlQKf+cpCRJ2+F+/2JaMbYCpVAkV/Y
 GIJ4uWeCNGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatYQnwAKCRDa6OEJdZac
 5X2xEACXXqdQVfu0QmSi5fO0AARulRhQsZVhufTZDzJJU3/2pYREZ86w7X7IcAorljAnmU8pFV2
 c4g8SUi1l9swxXa/xGH67zG9mutMCJyL/MBKVIHULsulNE2fQquqmQhVDUHi5p4sXFZVqzvIXHf
 9WEdGRL5tbYhp1VilCLImJRJrSYrMfxcyN2bwSx+GG0UyYpXA9tDdPjg7oh9RJHi63zr6+GtDh4
 ChEUgHyuy0Or0emQv06GS38JeupAoCUfODg7GUBhHQIHpEdTqvN+9U3BnDbybxPI2kN2oA9AiZq
 bCCVSHXJ6WvJU48Hij2Ov+Cv3eTwNQqRe5lpSzZv513wk6iwJwu9aJk2MRp6johSTbvx6Q1mbC/
 HGY75zL79nesjwwR4vU1glz5uIW98bq5+qh1oX2UstWzv18dFl7mNNQV4P6+kuHhXABBuIdCBDy
 Xu7/A9HK7AeN1LISCh/uPi7cgESSsjsaEl6s7MNctGPPyYseayujoHYdDJoFy4VgO3lFn8Ng1s4
 U04aNHGO6FFYtLCCUOR+fHy4rz0lozZcgFeoVFkyEvmSs5NQFHokyhV/g9eOc2mrqrdCO/zDixp
 j5PoaXEhBEWLDWrQHxW6ydqSsiw6LxAFnUGFZgeK/dlFqiFL4FmYtif9SVuSy/9Y91g8a3ESSrP
 jDJio9T4b2r8v7g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
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

> The host sends a control_packet. Turn it into the SETUP, DATA and
> STATUS tokens the QEMU USB core wants, run them on the device, and
> send the answer back.
> 
> The device may answer later, so we have to remember the packets we
> sent. Each one stays on a list until it comes back. We drop the whole
> list on a bus reset or a chardev close. When the host asks us to
> cancel a packet, we answer it and drop it. If it is no longer on the
> list we already answered it, so we send nothing.
> 
> usbredir has its own messages for set_configuration, get_configuration,
> set_alt_setting and get_alt_setting. Each one is a control transfer, so
> run it like one and send back the status message.
> 
> usbredir wants an ep_info message. It says what kind each endpoint is,
> how big its packets are and which interface it belongs to. QEMU cannot
> tell us. It only knows after it has read the device's descriptors, and
> it never reads them for a device that just forwards transfers. So we
> read them ourselves: the configuration descriptor passes through us on
> its way to the host.
> 
> A device can offer several configurations, and an interface several
> alternate settings, each with its own endpoints. Keep every
> configuration descriptor, build the table from the one the host
> selected, and send a fresh ep_info when that selection changes, so
> ep_info never describes an endpoint that is not there.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Can you drop my reviewed-by, we are undergoing still significant changes. Thanks

> Message-ID: <20261019092448.278079-6-jamin_lin@aspeedtech.com>
>
> diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c
> index dc4bb533837e..29a9fbc94178 100644
> --- a/hw/usb/redirect-server.c
> +++ b/hw/usb/redirect-server.c
> @@ -63,9 +63,11 @@
>  #include "qom/object.h"
>  
>  #include <usbredirparser.h>
> +#include <usbredirproto.h>
>  
>  #include "hw/core/qdev-properties.h"
>  #include "hw/core/qdev-properties-system.h"
> +#include "desc.h"
>  #include "trace.h"
>  
>  #define TYPE_USB_REDIR_SERVER "x-usb-redir-server"
> @@ -73,6 +75,41 @@ OBJECT_DECLARE_SIMPLE_TYPE(USBRedirServer, USB_REDIR_SERVER)
>  
>  #define USBREDIR_SERVER_VERSION "qemu " TYPE_USB_REDIR_SERVER " " QEMU_VERSION
>  
> +/*
> + * The usbredir ep_info message has one slot per endpoint and direction.
> + * Index 0-15 are the OUT endpoints, 16-31 the IN ones.
> + */
> +#define USBREDIR_SERVER_MAX_EP 32
> +#define USBREDIR_SERVER_EP_IN_BASE 16
> +
> +#define USBREDIR_SERVER_CTRL_SETUP 0
> +#define USBREDIR_SERVER_CTRL_STATUS 1
> +
> +/* Which message answers the host when a control transfer ends. */
> +typedef enum {
> +    USBREDIR_SERVER_REPLY_CONTROL,
> +    USBREDIR_SERVER_REPLY_CONFIG,
> +    USBREDIR_SERVER_REPLY_ALT,
> +} USBRedirServerReply;
> +
> +typedef struct USBRedirServerPkt {
> +    USBPacket pkt;
> +
> +    /* Saved headers for the usbredir response */
> +    struct usb_redir_control_packet_header ctrl_hdr;
> +
> +    /*
> +     * The IOV points here. IN data lands in it, OUT data is copied in.
> +     * Allocated and freed with the packet; data_size is how big it is.
> +     */
> +    uint8_t *data;
> +    int data_size;
> +    QTAILQ_ENTRY(USBRedirServerPkt) next;
> +    USBRedirServerReply reply;
> +    uint64_t redir_id;
> +    int type;
> +} USBRedirServerPkt;
> +
>  struct USBRedirServer {
>      SysBusDevice parent_obj;
>  
> @@ -92,8 +129,27 @@ struct USBRedirServer {
>      guint watch;
>      bool host_connected;
>      bool device_announced;
> +
> +    /* In-flight packet tracking */
> +    QTAILQ_HEAD(, USBRedirServerPkt) inflight;
> +    uint64_t next_id;
> +
> +    /* Endpoint tables for the usbredir ep_info message. */
> +    uint8_t ep_type[USBREDIR_SERVER_MAX_EP];
> +    uint16_t ep_max_packet[USBREDIR_SERVER_MAX_EP];
> +    uint8_t ep_interval[USBREDIR_SERVER_MAX_EP];
> +    uint8_t ep_iface[USBREDIR_SERVER_MAX_EP];
> +
> +    uint8_t alt_setting[USB_MAX_INTERFACES];
> +    GHashTable *config_descs;
> +    uint8_t config_value;
>  };
>  
> +static void usbredir_server_pkt_free(USBRedirServerPkt *rp);
> +static void usbredir_server_stop_transfers(USBRedirServer *s);
> +static void usbredir_server_send_cancelled(USBRedirServer *s,
> +                                           USBRedirServerPkt *rp);
> +
>  /*
>   * The device is whatever USBDevice the user plugged into our port with
>   * "-device <device>,bus=<id>.0". NULL until then.
> @@ -104,9 +160,171 @@ static USBDevice *usbredir_server_device(USBRedirServer *s)
>  }
>  
>  /*
> - * Device announcement
> + * Descriptor snooping and device announcement
>   */
>  
> +static void usbredir_server_record_endpoint(USBRedirServer *s,
> +                                            const USBDescriptor *desc,
> +                                            uint8_t iface)
> +{
> +    uint8_t addr;
> +    int ep_nr;
> +    int idx;
> +
> +    addr = desc->u.endpoint.bEndpointAddress;
> +    ep_nr = addr & 0x0f;
> +    idx = (addr & USB_DIR_IN) ? ep_nr + USBREDIR_SERVER_EP_IN_BASE : ep_nr;
> +    if (ep_nr < 1 || idx >= USBREDIR_SERVER_MAX_EP) {
> +        trace_usbredir_server_endpoint_dropped(addr);
> +        return;
> +    }
> +
> +    s->ep_type[idx] = desc->u.endpoint.bmAttributes & 0x03;
> +    s->ep_max_packet[idx] = (desc->u.endpoint.wMaxPacketSize_hi << 8) |
> +                            desc->u.endpoint.wMaxPacketSize_lo;
> +    s->ep_interval[idx] = desc->u.endpoint.bInterval;
> +    s->ep_iface[idx] = iface;
> +
> +    /*
> +     * bInterval says how often to poll this endpoint. Pass on what the
> +     * descriptor said, but never 0 for an interrupt or isochronous
> +     * endpoint: redirect.c throws the whole device away when it sees 0,
> +     * so store 1 instead.
> +     */
> +    if (s->ep_interval[idx] == 0 &&
> +        (s->ep_type[idx] == USB_ENDPOINT_XFER_INT ||
> +         s->ep_type[idx] == USB_ENDPOINT_XFER_ISOC)) {
> +        s->ep_interval[idx] = 1;
> +    }
> +}
> +
> +static void usbredir_server_save_config_desc(USBRedirServer *s,
> +                                             const uint8_t *data, int len)
> +{
> +    const USBDescriptor *conf = (const USBDescriptor *)data;
> +    uint16_t total;
> +
> +    if (len < 4) {
> +        return;
> +    }
> +    total = lduw_le_p(data + 2);
> +
> +    /*
> +     * The host reads this twice. The first read is a few bytes, just to
> +     * learn the length from wTotalLength. The second read has the whole
> +     * descriptor.
> +     *
> +     * A configuration descriptor is 9 bytes, so a shorter one is broken.
> +     */
> +    if (total < 9 || len < total) {
> +        return;
> +    }
> +
> +    g_hash_table_insert(s->config_descs,
> +                        GUINT_TO_POINTER(conf->u.config.bConfigurationValue),
> +                        g_memdup2(data, total));
> +}
> +
> +/*
> + * Some devices only forward transfers. They never read their own
> + * descriptors, so the USB core leaves their endpoint types at
> + * USB_ENDPOINT_XFER_INVALID. Sending that in ep_info does not work: the
> + * host sees type 255 and will not move data. So read the configuration
> + * descriptor and fill the tables here.
> + *
> + * Only what the host selected counts. A device can offer several
> + * configurations, and an interface several alternate settings. The
> + * endpoints of the ones not chosen are not there.
> + */
> +static void usbredir_server_build_ep_tables(USBRedirServer *s)
> +{
> +    const USBDescriptor *desc;
> +    const uint8_t *config;
> +    bool active = false;
> +    uint8_t iface = 0;
> +    uint8_t alt;
> +    int i = 0;
> +    int total;
> +
> +    memset(s->ep_type, USB_ENDPOINT_XFER_INVALID, sizeof(s->ep_type));
> +    memset(s->ep_max_packet, 0, sizeof(s->ep_max_packet));
> +    memset(s->ep_interval, 0, sizeof(s->ep_interval));
> +    memset(s->ep_iface, 0, sizeof(s->ep_iface));
> +
> +    config = g_hash_table_lookup(s->config_descs,
> +                                 GUINT_TO_POINTER(s->config_value));
> +    if (!config) {
> +        trace_usbredir_server_config_not_found(
> +            s->config_value, g_hash_table_size(s->config_descs));
> +        return;
> +    }
> +    total = lduw_le_p(config + 2);
> +
> +    while (i + 2 <= total) {
> +        desc = (const USBDescriptor *)(config + i);
> +
> +        if (desc->bLength < 2) {
> +            trace_usbredir_server_bad_descriptor(i, desc->bLength,
> +                                                 desc->bDescriptorType);
> +            break;
> +        }
> +        if (i + desc->bLength > total) {
> +            trace_usbredir_server_descriptor_overrun(i, desc->bLength, total);
> +            break;
> +        }
> +
> +        switch (desc->bDescriptorType) {
> +        case USB_DT_INTERFACE:
> +            if (desc->bLength < 9) {
> +                trace_usbredir_server_bad_descriptor(i, desc->bLength,
> +                                                     desc->bDescriptorType);
> +                break;
> +            }
> +            iface = desc->u.interface.bInterfaceNumber;
> +            alt = desc->u.interface.bAlternateSetting;
> +            active = iface < USB_MAX_INTERFACES &&
> +                     alt == s->alt_setting[iface];
> +            break;
> +        case USB_DT_ENDPOINT:
> +            if (desc->bLength < 7) {
> +                trace_usbredir_server_bad_descriptor(i, desc->bLength,
> +                                                     desc->bDescriptorType);
> +                break;
> +            }
> +            if (active) {
> +                usbredir_server_record_endpoint(s, desc, iface);
> +            }
> +            break;
> +        }
> +
> +        i += desc->bLength;
> +    }
> +}
> +
> +static void usbredir_server_send_ep_info(USBRedirServer *s)
> +{
> +    struct usb_redir_ep_info_header ep_info = {};
> +    int i;
> +
> +    usbredir_server_build_ep_tables(s);
> +
> +    for (i = 0; i < USBREDIR_SERVER_MAX_EP; i++) {
> +        ep_info.type[i] = s->ep_type[i];
> +        ep_info.max_packet_size[i] = s->ep_max_packet[i];
> +        ep_info.interface[i] = s->ep_iface[i];
> +        ep_info.interval[i] = s->ep_interval[i];
> +        if (s->ep_type[i] != USB_ENDPOINT_XFER_INVALID) {
> +            trace_usbredir_server_ep_info(i, ep_info.type[i],
> +                                          ep_info.max_packet_size[i],
> +                                          ep_info.interval[i],
> +                                          ep_info.interface[i]);
> +        }
> +    }
> +
> +    usbredirparser_send_ep_info(s->parser, &ep_info);
> +    usbredirparser_do_write(s->parser);
> +}
> +
>  static uint8_t usbredir_server_speed(USBDevice *device)
>  {
>      switch (device->speed) {
> @@ -145,6 +363,165 @@ static void usbredir_server_announce_device(USBRedirServer *s)
>      trace_usbredir_server_announce(conn.speed);
>      usbredirparser_send_device_connect(s->parser, &conn);
>      usbredirparser_do_write(s->parser);
> +
> +    usbredir_server_send_ep_info(s);
> +}
> +
> +/*
> + * Packet completion
> + */
> +
> +static uint8_t usbredir_server_status(int status)
> +{
> +    switch (status) {
> +    case USB_RET_SUCCESS:
> +        return usb_redir_success;
> +    case USB_RET_STALL:
> +        return usb_redir_stall;
> +    case USB_RET_BABBLE:
> +        return usb_redir_babble;
> +    default:
> +        return usb_redir_ioerror;
> +    }
> +}
> +
> +/*
> + * The device answered the setup token of an IN control request. What it
> + * wants to send is now in device->data_buf, so run the data and status
> + * stages and pass the answer to the host.
> + *
> + * Each stage reuses rp->pkt, and usb_packet_setup() asserts iov->iov is
> + * not NULL, so call qemu_iovec_init() before every stage.
> + */
> +static void usbredir_server_ctrl_setup_complete(USBRedirServer *s,
> +                                                USBRedirServerPkt *rp)
> +{
> +    struct usb_redir_control_packet_header resp = rp->ctrl_hdr;
> +    struct usb_redir_configuration_status_header cfg = {};
> +    struct usb_redir_alt_setting_status_header alt = {
> +        .interface = rp->ctrl_hdr.index,
> +    };
> +    USBDevice *device = usbredir_server_device(s);
> +    USBEndpoint *ep_out = usb_ep_get(device, USB_TOKEN_OUT, 0);
> +    USBEndpoint *ep_in = usb_ep_get(device, USB_TOKEN_IN, 0);
> +    uint8_t status = usbredir_server_status(rp->pkt.status);
> +    int actual = 0;
> +
> +    if (rp->pkt.status == USB_RET_SUCCESS) {
> +        /* Data stage: the core copies device->data_buf into our buffer. */
> +        qemu_iovec_init(&rp->pkt.iov, 1);
> +        usb_packet_setup(&rp->pkt, USB_TOKEN_IN, ep_in,
> +                         0, s->next_id++, false, false);
> +        usb_packet_addbuf(&rp->pkt, rp->data, rp->data_size);
> +        usb_handle_packet(device, &rp->pkt);
> +        actual = rp->pkt.actual_length;
> +        usb_packet_cleanup(&rp->pkt);
> +
> +        /* Status stage: tell the device we got it. Its EP0 goes idle. */
> +        qemu_iovec_init(&rp->pkt.iov, 1);
> +        usb_packet_setup(&rp->pkt, USB_TOKEN_OUT, ep_out,
> +                         0, s->next_id++, false, false);
> +        usb_handle_packet(device, &rp->pkt);
> +        usb_packet_cleanup(&rp->pkt);
> +
> +        if (rp->ctrl_hdr.request == USB_REQ_GET_DESCRIPTOR &&
> +            (rp->ctrl_hdr.value >> 8) == USB_DT_CONFIG && actual > 0) {
> +            usbredir_server_save_config_desc(s, rp->data, actual);
> +        }
> +    }
> +
> +    trace_usbredir_server_ctrl_setup_complete(rp->redir_id, status,
> +                                              actual);
> +
> +    switch (rp->reply) {
> +    case USBREDIR_SERVER_REPLY_CONTROL:
> +        resp.status = status;
> +        resp.length = actual;
> +        usbredirparser_send_control_packet(s->parser, rp->redir_id, &resp,
> +                                           actual > 0 ? rp->data : NULL,
> +                                           actual);
> +        break;
> +    case USBREDIR_SERVER_REPLY_CONFIG:
> +        cfg.status = status;
> +        cfg.configuration = actual > 0 ? rp->data[0] : 0;
> +        usbredirparser_send_configuration_status(s->parser, rp->redir_id,
> +                                                 &cfg);
> +        break;
> +    case USBREDIR_SERVER_REPLY_ALT:
> +        alt.status = status;
> +        alt.alt = actual > 0 ? rp->data[0] : 0;
> +        usbredirparser_send_alt_setting_status(s->parser, rp->redir_id,
> +                                               &alt);
> +        break;
> +    }
> +    usbredirparser_do_write(s->parser);
> +}
> +
> +/*
> + * The status stage of an OUT control request finished, so the device is
> + * done. Tell the host how it went, with whichever message it is waiting
> + * for.
> + */
> +static void usbredir_server_ctrl_status_complete(USBRedirServer *s,
> +                                                 USBRedirServerPkt *rp)
> +{
> +    struct usb_redir_control_packet_header resp = rp->ctrl_hdr;
> +    uint8_t status = usbredir_server_status(rp->pkt.status);
> +    struct usb_redir_configuration_status_header cfg = {
> +        .configuration = rp->ctrl_hdr.value,
> +    };
> +    struct usb_redir_alt_setting_status_header alt = {
> +        .interface = rp->ctrl_hdr.index,
> +        .alt = rp->ctrl_hdr.value,
> +    };
> +
> +    trace_usbredir_server_ctrl_status_complete(rp->redir_id, status);
> +
> +    switch (rp->reply) {
> +    case USBREDIR_SERVER_REPLY_CONTROL:
> +        resp.status = status;
> +        resp.length = 0;
> +        usbredirparser_send_control_packet(s->parser, rp->redir_id,
> +                                           &resp, NULL, 0);
> +        break;
> +    case USBREDIR_SERVER_REPLY_CONFIG:
> +        cfg.status = status;
> +        usbredirparser_send_configuration_status(s->parser, rp->redir_id,
> +                                                 &cfg);
> +        break;
> +    case USBREDIR_SERVER_REPLY_ALT:
> +        alt.status = status;
> +        usbredirparser_send_alt_setting_status(s->parser, rp->redir_id,
> +                                               &alt);
> +        break;
> +    }
> +    usbredirparser_do_write(s->parser);
> +
> +    if (status != usb_redir_success) {
> +        return;
> +    }
> +
> +    /*
> +     * Two requests change which endpoints exist. SET_CONFIGURATION picks
> +     * a configuration, SET_INTERFACE picks an alternate setting. Record
> +     * what the host chose, then send a fresh ep_info.
> +     */
> +    switch ((rp->ctrl_hdr.requesttype << 8) | rp->ctrl_hdr.request) {
> +    case DeviceOutRequest | USB_REQ_SET_CONFIGURATION:
> +        /* A new configuration puts every interface back on alternate 0. */
> +        s->config_value = rp->ctrl_hdr.value;
> +        memset(s->alt_setting, 0, sizeof(s->alt_setting));
> +        break;
> +    case InterfaceOutRequest | USB_REQ_SET_INTERFACE:
> +        if (rp->ctrl_hdr.index < USB_MAX_INTERFACES) {
> +            s->alt_setting[rp->ctrl_hdr.index] = rp->ctrl_hdr.value;
> +        }
> +        break;
> +    default:
> +        return;
> +    }
> +
> +    usbredir_server_send_ep_info(s);
>  }
>  
>  /*
> @@ -165,12 +542,23 @@ static void usbredir_server_port_detach(USBPort *port)
>  
>      trace_usbredir_server_detach(s->device_announced);
>  
> +    usbredir_server_stop_transfers(s);
> +
>      if (s->host_connected && s->parser && s->device_announced) {
>          trace_usbredir_server_disconnect();
>          usbredirparser_send_device_disconnect(s->parser);
>          usbredirparser_do_write(s->parser);
>      }
>      s->device_announced = false;
> +
> +    /* Clear the endpoint tables: they belong to the device that is leaving. */
> +    memset(s->ep_type, USB_ENDPOINT_XFER_INVALID, sizeof(s->ep_type));
> +    memset(s->ep_max_packet, 0, sizeof(s->ep_max_packet));
> +    memset(s->ep_interval, 0, sizeof(s->ep_interval));
> +    memset(s->ep_iface, 0, sizeof(s->ep_iface));
> +    memset(s->alt_setting, 0, sizeof(s->alt_setting));
> +    g_hash_table_remove_all(s->config_descs);
> +    s->config_value = 0;
>  }
>  
>  static void usbredir_server_port_child_detach(USBPort *port, USBDevice *child)
> @@ -183,11 +571,46 @@ static void usbredir_server_port_wakeup(USBPort *port)
>      /* We do not pass remote wakeup to the host. Nothing to do. */
>  }
>  
> +/*
> + * The core calls this for a packet the device answered with
> + * USB_RET_ASYNC. usbredir_server_submit_to_device() calls it for the rest.
> + */
> +static void usbredir_server_packet_complete(USBPort *port, USBPacket *p)
> +{
> +    USBRedirServer *s = port->opaque;
> +    USBRedirServerPkt *rp = container_of(p, USBRedirServerPkt, pkt);
> +    USBDevice *device = usbredir_server_device(s);
> +
> +    if (p->status == USB_RET_REMOVE_FROM_QUEUE) {
> +        usb_cancel_packet(p);
> +    }
> +
> +    QTAILQ_REMOVE(&s->inflight, rp, next);
> +    usb_packet_cleanup(&rp->pkt);
> +
> +    if (!s->parser || !device) {
> +        usbredir_server_pkt_free(rp);
> +        return;
> +    }
> +
> +    switch (rp->type) {
> +    case USBREDIR_SERVER_CTRL_SETUP:
> +        usbredir_server_ctrl_setup_complete(s, rp);
> +        break;
> +    case USBREDIR_SERVER_CTRL_STATUS:
> +        usbredir_server_ctrl_status_complete(s, rp);
> +        break;
> +    }
> +
> +    usbredir_server_pkt_free(rp);
> +}
> +
>  static USBPortOps usbredir_server_port_ops = {
>      .attach = usbredir_server_port_attach,
>      .detach = usbredir_server_port_detach,
>      .child_detach = usbredir_server_port_child_detach,
>      .wakeup = usbredir_server_port_wakeup,
> +    .complete = usbredir_server_packet_complete,
>  };
>  
>  /*
> @@ -197,6 +620,54 @@ static USBPortOps usbredir_server_port_ops = {
>  static USBBusOps usbredir_server_bus_ops = {
>  };
>  
> +/*
> + * Submit a packet to the device. The core only calls our completion
> + * callback when the device answers USB_RET_ASYNC, so call it here for
> + * the rest.
> + */
> +static void usbredir_server_submit_to_device(USBRedirServer *s,
> +                                             USBRedirServerPkt *rp)
> +{
> +    QTAILQ_INSERT_TAIL(&s->inflight, rp, next);
> +    usb_handle_packet(usbredir_server_device(s), &rp->pkt);
> +    if (rp->pkt.status != USB_RET_ASYNC) {
> +        usbredir_server_packet_complete(&s->port, &rp->pkt);
> +    }
> +}
> +
> +static USBRedirServerPkt *usbredir_server_pkt_alloc(int size)
> +{
> +    USBRedirServerPkt *rp = g_new0(USBRedirServerPkt, 1);
> +
> +    qemu_iovec_init(&rp->pkt.iov, 1);
> +    rp->data = g_malloc0(size);
> +    rp->data_size = size;
> +    return rp;
> +}
> +
> +static void usbredir_server_pkt_free(USBRedirServerPkt *rp)
> +{
> +    g_free(rp->data);
> +    g_free(rp);
> +}
> +
> +/*
> + * Take @rp off the list and free it. Do not use usb_packet_complete():
> + * it calls back into usbredir_server_packet_complete(), which would
> + * remove the entry a second time and free it. usb_cancel_packet() only
> + * tells the device to let go.
> + */
> +static void usbredir_server_drop_pkt(USBRedirServer *s,
> +                                     USBRedirServerPkt *rp)
> +{
> +    QTAILQ_REMOVE(&s->inflight, rp, next);
> +    if (usb_packet_is_inflight(&rp->pkt)) {
> +        usb_cancel_packet(&rp->pkt);
> +    }
> +    usb_packet_cleanup(&rp->pkt);
> +    usbredir_server_pkt_free(rp);
> +}
> +
>  /*
>   * usbredirparser I/O and logging callbacks
>   */
> @@ -312,9 +783,202 @@ static void usbredir_server_reset(void *priv)
>      USBDevice *device = usbredir_server_device(s);
>  
>      trace_usbredir_server_bus_reset(device && device->attached);
> +    if (!device || !device->attached) {
> +        return;
> +    }
> +
> +    usbredir_server_stop_transfers(s);
>      usb_device_reset(device);
>  }
>  
> +/*
> + * Run one control transfer on the device. @reply says which message
> + * answers the host when the transfer finishes.
> + */
> +static void usbredir_server_do_control(USBRedirServer *s, uint64_t id,
> +    struct usb_redir_control_packet_header *hdr,
> +    uint8_t *data, int data_len, USBRedirServerReply reply)
> +{
> +    USBDevice *device = usbredir_server_device(s);
> +    USBRedirServerPkt *rp;
> +    USBEndpoint *ep_out;
> +    USBEndpoint *ep_in;
> +    USBEndpoint *ep0;
> +    bool is_in;
> +    int size;
> +
> +    if (!s->host_connected || !device || !device->attached) {
> +        return;
> +    }
> +
> +    trace_usbredir_server_control(id, hdr->requesttype, hdr->request,
> +                                  hdr->value, hdr->index, hdr->length);
> +
> +    is_in = !!(hdr->requesttype & USB_DIR_IN);
> +
> +    ep0 = usb_ep_get(device, USB_TOKEN_SETUP, 0);
> +
> +    /* Room for the setup bytes and for the data of either direction. */
> +    size = MAX(hdr->length, data_len);
> +    size = MAX(size, (int)sizeof(device->setup_buf));
> +
> +    rp = usbredir_server_pkt_alloc(size);
> +    rp->redir_id = id;
> +    rp->reply = reply;
> +    rp->ctrl_hdr = *hdr;
> +
> +    /*
> +     * Build the raw 8-byte SETUP packet in rp->data. The IN path
> +     * overwrites it later with the answer from the device.
> +     */
> +    rp->data[0] = hdr->requesttype;
> +    rp->data[1] = hdr->request;
> +    rp->data[2] = hdr->value & 0xff;
> +    rp->data[3] = (hdr->value >> 8) & 0xff;
> +    rp->data[4] = hdr->index & 0xff;
> +    rp->data[5] = (hdr->index >> 8) & 0xff;
> +    rp->data[6] = hdr->length & 0xff;
> +    rp->data[7] = (hdr->length >> 8) & 0xff;
> +
> +    if (is_in) {
> +        /*
> +         * An IN request. The device starts the work on the setup token
> +         * and may take its time, so send the token and pick the rest up
> +         * in usbredir_server_ctrl_setup_complete().
> +         */
> +        rp->type = USBREDIR_SERVER_CTRL_SETUP;
> +        usb_packet_setup(&rp->pkt, USB_TOKEN_SETUP, ep0,
> +                         0, s->next_id++, false, false);
> +        usb_packet_addbuf(&rp->pkt, rp->data, sizeof(device->setup_buf));
> +        usbredir_server_submit_to_device(s, rp);
> +    } else {
> +        /*
> +         * An OUT request. The device only stores the setup bytes now and
> +         * does the work on the status stage, so run the first two stages
> +         * here and wait on the last one.
> +         */
> +        ep_in = usb_ep_get(device, USB_TOKEN_IN, 0);
> +        ep_out = usb_ep_get(device, USB_TOKEN_OUT, 0);
> +
> +        /* Setup stage: hand the device the 8 setup bytes. */
> +        usb_packet_setup(&rp->pkt, USB_TOKEN_SETUP, ep0,
> +                         0, s->next_id++, false, false);
> +        usb_packet_addbuf(&rp->pkt, rp->data, sizeof(device->setup_buf));
> +        usb_handle_packet(device, &rp->pkt);
> +        usb_packet_cleanup(&rp->pkt);

This assumes ep0's queue is empty. If an earlier control transfer is still async
on ep0 (usb-host answers USB_RET_ASYNC for control requests),
usb_handle_packet() takes the usb_queue_one() branch, leaves the packet QUEUED,
and usb_packet_cleanup() aborts on !usb_packet_is_inflight().

The same applies to the data and status stages run from
usbredir_server_ctrl_setup_complete()

The server could keep at most one control transfer on the device, and queue the
others locally?

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


