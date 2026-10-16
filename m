Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6945CCA48B
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:26:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHeCe-0006WY-3y; Fri, 16 Oct 2026 05:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jaminlin1207@gmail.com>)
 id 1xHeCZ-0006TR-Ry
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:26:12 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jaminlin1207@gmail.com>)
 id 1xHeCV-0004rq-OA
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:26:11 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3ab4178ee33so3707562a91.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 02:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792142766; x=1792747566; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EwigZGu3tAE19Vhs6EDw9RLRhXRop5tOLPTVtxfVins=;
 b=EDJxjDVKGJpSZG+UjquiAWa4gasIAiIwURjkIeiWK36JjCNnhtnE/x6Jqd+ZDUFF22
 CdhOyCq+hH2VESsWZt89v0yS0aM7TLl8i3Kn7+/t2mVCKzOhY0csRUYp8/Tq6uozvJhW
 JhkGXr4pjvPmoNSZp6ao5BknX5n5XRnzKhuD0vEtmS+zlUGUqhMU3xqpTJSb/Wv47hAf
 qp5StFcQH2cboitQif54UZQ6y0zQPvF2x7bsVpzfFu0GKf5Vy0BwLdNlmBuHfETTKoNn
 uOXldGmfLBDCnFqR+aI8WpEX1swiHZslKT3FHGP0blzgqyq+h+S1aoMdadBNZTMixLDo
 Iz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792142766; x=1792747566;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EwigZGu3tAE19Vhs6EDw9RLRhXRop5tOLPTVtxfVins=;
 b=FZHj5Vi7ZIwENZvLn79kr2CHkywiWUyvgY5CjVhYYo6i6HT6tYwf2Jl/qlJgwlEWIA
 bbE21eUEt7PHDgN0+wa01pF0YDSaBObx5fXhLQHBJB8HFzBkNF7z+ZfTIHRxzJfolzO5
 22Ir640LmMULvlOpGtbXhhguieGWdvUhjCpEeOXg6ThEvTGdpVbWrxr1pX6iXBNEX9sJ
 VPzgavfZnPZHbHIfrxBhMCjGoAGy/MdRlf0JTfh/V8eORMrP9jt2AzjqQ0v47TGC08em
 pDTVXb6nU7heKNSLEBtkO2MmVueZodF6HtVvgg7QhM+cUBJq93uqinYXxyV37KbxiFhh
 07pQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx0TQOzGPS+lmNqcxwq+XfswT8UmapLEubNtrfiFPRAM5u/CaHv9o4x+yd5zx8MrzVElyAzsPjfB8z8@nongnu.org
X-Gm-Message-State: AFq9FYIJedWv9mUObmDSdFcvjEnz5V3YQVetnyffwYsVQ/uVtQYCRIxJ
 qJMPWmTxB8o0sJyGSwYIKQCzwag9gfCBhxglRlvSdGC9/0vBY6uBxjBP
X-Gm-Gg: AYBFou3IBSHpITUNAPOk58k3PCJxSEpdbSPbxKp1ppJcrqUptOXiyabq6BwtIsurqYH
 dgKgxdHQQjVG1iE65yzxqXC3jqRXviopeBR7nHCaQfXl1qV2q9B/YiK2j40q4JqUpZgnpvsFaV6
 VYmFlSHvvxy0QLd1ADvIiCZq9r8GRsw2bykSXap8QGLzCC9aIznXRgtr0l/JeGuaSz3+IsTjx6/
 isOYzHE7n1XVNfJPWM0hn0jFX9GwaMGsiyH3U+VHsWcTiYn0uOnM18XOd42RRYkSLLAL1ZfSzOo
 vp0DzVi788V6FPAqLKkvRCXvxfecrsCHeerwdRl2kd6xeRbCPuv+pgG3xfXo87ajwdnZyF2CrpJ
 gDf+2M+4GMwXTPihWH3rc6f5EJWiDGgjmjEdodSogB25aU/UBg/pkbo/7poesNdINmRLBe5j+Y1
 z2CnjmtJ3EmvLRKiTLG9m2qyVjLuq76gAYgjwD+GsFOcS9u5p2ILuscCKas5blpRmiX/17h8Gpk
 udHSjofQSnvvlk=
X-Received: by 2002:a17:90b:224c:b0:3ab:b64:5893 with SMTP id
 98e67ed59e1d1-3ab3ac5ecc6mr19366423a91.53.1792142765341; 
 Fri, 16 Oct 2026 02:26:05 -0700 (PDT)
Received: from JaminLin-PC.aspeed.com ([118.99.183.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac94748c6csm8514277a91.10.2026.10.16.02.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 02:26:04 -0700 (PDT)
Date: Fri, 16 Oct 2026 17:26:00 +0800
From: Jamin Lin <jaminlin1207@gmail.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Troy Lee <troy_lee@aspeedtech.com>
Subject: Re: [PATCH v5 5/8] hw/usb/redirect-server: Implement control transfers
Message-ID: <atHtqNfqlFLPIMLA@JaminLin-PC.aspeed.com>
References: <20261015093417.573063-1-jamin_lin@aspeedtech.com>
 <20261015093417.573063-6-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261015093417.573063-6-jamin_lin@aspeedtech.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=jaminlin1207@gmail.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, Oct 15, 2026 at 09:34:23AM +0000, Jamin Lin wrote:
> The host sends a control_packet. Turn it into the SETUP, DATA and
> STATUS tokens the QEMU USB core wants, run them on the device, and
> send the answer back.
> 
> The device may answer later, so we have to remember the packets we
> sent. Each one stays on a list until it comes back. We drop the whole
> list on a bus reset or a chardev close. When the host asks us to
> cancel a packet, we answer it and drop it.
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
> ---
>  hw/usb/redirect-server.c | 752 ++++++++++++++++++++++++++++++++++++++-
>  hw/usb/trace-events      |   9 +
>  2 files changed, 760 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c
> index 05ee0f3873..a8647b5efc 100644
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
> @@ -183,11 +571,42 @@ static void usbredir_server_port_wakeup(USBPort *port)
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
> @@ -197,6 +616,54 @@ static USBPortOps usbredir_server_port_ops = {
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
> @@ -312,9 +779,199 @@ static void usbredir_server_reset(void *priv)
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
> +
> +        /* Data stage: send the bytes that came with the request. */
> +        if (data_len > 0) {
> +            memcpy(rp->data, data, data_len);
> +            qemu_iovec_init(&rp->pkt.iov, 1);
> +            usb_packet_setup(&rp->pkt, USB_TOKEN_OUT, ep_out,
> +                             0, s->next_id++, false, false);
> +            usb_packet_addbuf(&rp->pkt, rp->data, data_len);
> +            /* The core copies our bytes into device->data_buf. */
> +            usb_handle_packet(device, &rp->pkt);
> +            usb_packet_cleanup(&rp->pkt);
> +        }
> +
> +        /* Status stage: the device does the work here, so wait for it. */
> +        rp->type = USBREDIR_SERVER_CTRL_STATUS;
> +        qemu_iovec_init(&rp->pkt.iov, 1);
> +        usb_packet_setup(&rp->pkt, USB_TOKEN_IN, ep_in,
> +                         0, s->next_id++, false, false);
> +        /* async; the answer comes in usbredir_server_ctrl_status_complete() */
> +        usbredir_server_submit_to_device(s, rp);
> +    }
> +}
> +
> +static void usbredir_server_control_packet(void *priv, uint64_t id,
> +    struct usb_redir_control_packet_header *hdr,
> +    uint8_t *data, int data_len)
> +{
> +    usbredir_server_do_control(priv, id, hdr, data, data_len,
> +                               USBREDIR_SERVER_REPLY_CONTROL);
> +}
> +
> +static void usbredir_server_set_configuration(void *priv, uint64_t id,
> +    struct usb_redir_set_configuration_header *hdr)
> +{
> +    struct usb_redir_control_packet_header ctrl = {
> +        .endpoint = 0,
> +        .request = USB_REQ_SET_CONFIGURATION,
> +        /* Host->Device, Standard, Device */
> +        .requesttype = 0x00,
> +        .status = 0,
> +        .value = hdr->configuration,
> +        .index = 0,
> +        .length = 0,
> +    };
> +    USBRedirServer *s = priv;
> +
> +    /* The host gets a configuration_status when the device answers. */
> +    usbredir_server_do_control(s, id, &ctrl, NULL, 0,
> +                               USBREDIR_SERVER_REPLY_CONFIG);
> +}
> +
> +static void usbredir_server_get_configuration(void *priv, uint64_t id)
> +{
> +    struct usb_redir_control_packet_header ctrl = {
> +        .endpoint = 0,
> +        .request = USB_REQ_GET_CONFIGURATION,
> +        /* Device->Host, Standard, Device */
> +        .requesttype = 0x80,
> +        .status = 0,
> +        .value = 0,
> +        .index = 0,
> +        .length = 1,
> +    };
> +    USBRedirServer *s = priv;
> +
> +    /* The host gets a configuration_status when the device answers. */
> +    usbredir_server_do_control(s, id, &ctrl, NULL, 0,
> +                               USBREDIR_SERVER_REPLY_CONFIG);
> +}
> +
> +static void usbredir_server_set_alt_setting(void *priv, uint64_t id,
> +    struct usb_redir_set_alt_setting_header *hdr)
> +{
> +    struct usb_redir_control_packet_header ctrl = {
> +        .endpoint = 0,
> +        .request = USB_REQ_SET_INTERFACE,
> +        /* Host->Device, Standard, Interface */
> +        .requesttype = 0x01,
> +        .status = 0,
> +        .value = hdr->alt,
> +        .index = hdr->interface,
> +        .length = 0,
> +    };
> +    USBRedirServer *s = priv;
> +
> +    /* The host gets an alt_setting_status when the device answers. */
> +    usbredir_server_do_control(s, id, &ctrl, NULL, 0,
> +                               USBREDIR_SERVER_REPLY_ALT);
> +}
> +
> +static void usbredir_server_get_alt_setting(void *priv, uint64_t id,
> +    struct usb_redir_get_alt_setting_header *hdr)
> +{
> +    struct usb_redir_control_packet_header ctrl = {
> +        .endpoint = 0,
> +        .request = USB_REQ_GET_INTERFACE,
> +        /* Device->Host, Standard, Interface */
> +        .requesttype = 0x81,
> +        .status = 0,
> +        .value = 0,
> +        .index = hdr->interface,
> +        .length = 1,
> +    };
> +    USBRedirServer *s = priv;
> +
> +    /* The host gets an alt_setting_status when the device answers. */
> +    usbredir_server_do_control(s, id, &ctrl, NULL, 0,
> +                               USBREDIR_SERVER_REPLY_ALT);
> +}
> +
>  static void usbredir_server_filter_reject(void *priv)
>  {
>      trace_usbredir_server_filter_reject();
> @@ -338,6 +995,84 @@ static void usbredir_server_interface_info(void *priv,
>      /* The host should not send this to a device. Nothing to do. */
>  }
>  
> +static void usbredir_server_cancel_data_packet(void *priv, uint64_t id)
> +{
> +    struct usb_redir_control_packet_header resp = {
> +        .endpoint = 0,
> +        .status = usb_redir_cancelled,
> +        .length = 0,
> +    };
> +    USBRedirServer *s = priv;
> +    USBRedirServerPkt *rp;
> +
> +    /*
> +     * The host has put this id in its cancelled queue and waits for one
> +     * answer carrying it. The device may have answered already, so the
> +     * request may no longer be on our list. Answer in both cases: the
> +     * host reuses ids, and a leftover entry would eat a later answer.
> +     */
> +    QTAILQ_FOREACH(rp, &s->inflight, next) {
> +        if (rp->redir_id == id) {
> +            trace_usbredir_server_cancel(id, true);
> +            usbredir_server_send_cancelled(s, rp);
> +            usbredir_server_drop_pkt(s, rp);
> +            return;
> +        }
> +    }
> +
> +    /*
> +     * Already finished, so we no longer know what kind of transfer it
> +     * was. The host retires the entry on the id alone, and its control
> +     * handler ignores the endpoint field, so a control packet always
> +     * works.
> +     */
> +    trace_usbredir_server_cancel(id, false);
> +    usbredirparser_send_control_packet(s->parser, id, &resp, NULL, 0);
> +    usbredirparser_do_write(s->parser);
> +}
> +
> +/*
> + * Cancelled and in-flight packets
> + */
> +
> +/*
> + * Every request must get one answer carrying its id, even an aborted one.
> + * A dropped id stays in the host's cancelled queue. The host reuses ids,
> + * so a later answer would be thrown away as a stale one.
> + */
> +static void usbredir_server_send_cancelled(USBRedirServer *s,
> +                                           USBRedirServerPkt *rp)
> +{
> +    struct usb_redir_control_packet_header ctrl;
> +
> +    switch (rp->type) {
> +    case USBREDIR_SERVER_CTRL_SETUP:
> +    case USBREDIR_SERVER_CTRL_STATUS:
> +        ctrl = rp->ctrl_hdr;
> +        ctrl.status = usb_redir_cancelled;
> +        ctrl.length = 0;
> +        usbredirparser_send_control_packet(s->parser, rp->redir_id,
> +                                           &ctrl, NULL, 0);
> +        break;
> +    default:
> +        return;
> +    }
> +    usbredirparser_do_write(s->parser);
> +}
> +
> +static void usbredir_server_stop_transfers(USBRedirServer *s)
> +{
> +    USBRedirServerPkt *rp;
> +
> +    /*
> +     * No "cancelled" response here. This runs on a bus reset, a detach or
> +     * a closed chardev, and the host has dropped its own queues already.
> +     */
> +    while ((rp = QTAILQ_FIRST(&s->inflight)) != NULL) {
> +        usbredir_server_drop_pkt(s, rp);
> +    }
> +}
> +
>  /*
>   * Parser setup and teardown
>   */
> @@ -360,13 +1095,19 @@ static void usbredir_server_create_parser(USBRedirServer *s)
>      /* Callbacks for messages the remote host sends to us */
>      s->parser->hello_func = usbredir_server_hello;
>      s->parser->reset_func = usbredir_server_reset;
> +    s->parser->control_packet_func = usbredir_server_control_packet;
> +    s->parser->set_configuration_func = usbredir_server_set_configuration;
>  
>      /* The parser calls these directly, so they must not be NULL. */
> +    s->parser->get_configuration_func = usbredir_server_get_configuration;
> +    s->parser->set_alt_setting_func = usbredir_server_set_alt_setting;
> +    s->parser->get_alt_setting_func = usbredir_server_get_alt_setting;
>      s->parser->filter_reject_func = usbredir_server_filter_reject;
>      s->parser->filter_filter_func = usbredir_server_filter_filter;
>      s->parser->device_disconnect_ack_func =
>          usbredir_server_device_disconnect_ack;
>      s->parser->interface_info_func = usbredir_server_interface_info;
> +    s->parser->cancel_data_packet_func = usbredir_server_cancel_data_packet;
>  
>      /* Capabilities: 64-bit IDs, connect_device_version, ep_info sizes */
>      usbredirparser_caps_set_cap(caps, usb_redir_cap_connect_device_version);
> @@ -398,6 +1139,8 @@ static void usbredir_server_destroy_parser(USBRedirServer *s)
>  
>      g_clear_handle_id(&s->watch, g_source_remove);
>  
> +    usbredir_server_stop_transfers(s);
> +
>      if (s->parser) {
>          usbredirparser_destroy(s->parser);
>          s->parser = NULL;
> @@ -486,6 +1229,11 @@ static void usbredir_server_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> +    QTAILQ_INIT(&s->inflight);
> +    s->config_descs = g_hash_table_new_full(g_direct_hash, g_direct_equal,
> +                                            NULL, g_free);
> +    memset(s->ep_type, USB_ENDPOINT_XFER_INVALID, sizeof(s->ep_type));
> +
>      /* One port: usbredir carries a single device. */
>      usb_bus_new(&s->bus, sizeof(s->bus), &usbredir_server_bus_ops, dev);
>      s->bus.no_auto_hub = true;
> @@ -510,6 +1258,8 @@ static void usbredir_server_unrealize(DeviceState *dev)
>      qemu_chr_fe_deinit(&s->cs, true);
>      usbredir_server_destroy_parser(s);
>  
> +    g_clear_pointer(&s->config_descs, g_hash_table_destroy);
> +
>      if (s->chardev_close_bh) {
>          qemu_bh_delete(s->chardev_close_bh);
>          s->chardev_close_bh = NULL;
> diff --git a/hw/usb/trace-events b/hw/usb/trace-events
> index 2cc6a244b9..0ed20838b2 100644
> --- a/hw/usb/trace-events
> +++ b/hw/usb/trace-events
> @@ -406,3 +406,12 @@ usbredir_server_announce(uint8_t speed) "device_connect speed %u"
>  usbredir_server_disconnect(void) "device_disconnect sent"
>  usbredir_server_bus_reset(bool attached) "bus reset, attached %d"
>  usbredir_server_filter_reject(void) "host rejected our device"
> +usbredir_server_cancel(uint64_t id, bool found) "id %" PRIu64 " still in flight %d"
> +usbredir_server_ep_info(unsigned idx, uint8_t type, uint16_t mps, uint8_t interval, uint8_t iface) "ep_info[%u] type %u mps %u interval %u iface %u"
> +usbredir_server_config_not_found(uint8_t value, unsigned have) "no descriptor for configuration %u, we have %u"
> +usbredir_server_bad_descriptor(int offset, uint8_t length, uint8_t type) "descriptor at byte %d is too short: bLength %u, type %u"
> +usbredir_server_descriptor_overrun(int offset, uint8_t length, int total) "descriptor at byte %d runs past the end: bLength %u, total %d"
> +usbredir_server_endpoint_dropped(uint8_t address) "endpoint 0x%02x does not fit our tables"
> +usbredir_server_control(uint64_t id, uint8_t requesttype, uint8_t request, uint16_t value, uint16_t index, uint16_t length) "id %" PRIu64 " type 0x%02x request 0x%02x value 0x%04x index 0x%04x length %u"
> +usbredir_server_ctrl_setup_complete(uint64_t id, int status, int actual) "id %" PRIu64 " status %d actual %d"
> +usbredir_server_ctrl_status_complete(uint64_t id, int status) "id %" PRIu64 " status %d"
> -- 
> 2.43.0
> 
Reviewed-by: Jamin Lin <jaminlin1207@gmail.com>

