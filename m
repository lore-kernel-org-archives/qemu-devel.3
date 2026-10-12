Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C8BCA9ED2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGCr0-0008P7-Ej; Mon, 12 Oct 2026 06:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGCqh-0008KD-1B
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:01:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGCqf-0001bl-7W
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:01:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791799296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wo8vm21AFmmQbZ3ILHCtwVoLcOb0q0fy48xDKc+6am0=;
 b=H9AH/1WGV8XjGFueLQBcm4a8cVp0tO+ITYY+ZgSX4azyb8CulfBVZXQgrS9uBY1sB9Dn9f
 whz+34ZFcyQKQiQGIB3FXhDdk0TDnjbhFcK/BCZ9leaSFXQv6dv/L2Eb4Vla9ve9JDZ38p
 vx610UMgj2AyBiDrJb67ZyMpy20FRfc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-eIb9Zt6JMsaaa3zps9Ud0g-1; Mon,
 12 Oct 2026 10:01:32 +0000
X-MC-Unique: eIb9Zt6JMsaaa3zps9Ud0g-1
X-Mimecast-MFC-AGG-ID: eIb9Zt6JMsaaa3zps9Ud0g_1791799290
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 08AE618D653E; Mon, 12 Oct 2026 10:01:28 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 67E1C1800446; Mon, 12 Oct 2026 10:01:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 5/8] hw/usb/redirect-server: Implement control transfers
From: marcandre.lureau@redhat.com
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 Troy Lee <troy_lee@aspeedtech.com>
In-Reply-To: <20261012021634.2006424-6-jamin_lin@aspeedtech.com>
References: <20261012021634.2006424-1-jamin_lin@aspeedtech.com>
 <20261012021634.2006424-6-jamin_lin@aspeedtech.com>
Date: Mon, 12 Oct 2026 14:01:11 +0400
Message-Id: <179179927145.1642373.1827394110159975206.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6460;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=O1GcMCkY7bzaB+R7p50Nz42zoqh3ghVUk/uh9VXpPAE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzK/pFrKxcG0tn6t6ZaaiBDajb0j0U/GzcOANg
 vgi5wWi+riJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasyv6QAKCRDa6OEJdZac
 5WAsD/9OG2NSOERUOaDCAGkjLhB+6BEkPdzZyBZPKYnsRCNP9rHvqAxkdd5NxzpWOOYJRxHl00m
 61Sp7NNM6nuzVA66kTVLyN4KYdwfeLPuaOYX5Dh6zOBtobYaVY/kf7aE8X7FJlHtC9hCI+Vumb0
 LJdAbh93cjmgF81g8twKXkQ1DyRKJUj29G9cc4xyR5bLhVVw+EoNRx0rEdKBn2IhJ6dEaTUCryQ
 qNqYk/ikqpoJTZhXCy9ukCjKn6gPcHPIy6q+4waAev6VIdnJK3gSnkvl1JqKQ5moiF8VYDaVYJ0
 0wrdqUf7Bju24dpuOu3TbxoZtgYoNkit7SIQ2xL4dQPWuBXJ9sLbOMNS+ubnwYwxy3r8WA2vy91
 3zvCpzqmx1KfcQ9ZWOdlDjqGrQB7GzNcai4v0r+8duvQlUX+opqaLcs7OlOo8v92QTMBII28IHV
 TVjWP5RFTmPhC50+AeHLh1IHlVT6YeS6KWijQPuOxTr00m+Fp9O/SrQFv7/mcdWE4Sc6GniLtNG
 ZJgNJzYTgbnlieFe2TNXtKXwRyARmC9i6a9EQOtmVp5DT1ottDXhB8QLLAB1Ij+HJ1GOcuEYekH
 m6PgXiFIjbnMY5vX+iBAkOEvwKPaeQLgR0hDOHS9NgCY1xTSUyVCBOhNOew3SxgQtqs5bRRte5A
 JNBaIJgjO54bj0Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
> cancel a packet, we answer it and drop it.
> 
> usbredir has its own messages for set_configuration, get_configuration,
> set_alt_setting and get_alt_setting. Each one is a control transfer, so
> run it like one and send back the status message.
> 
> usbredir wants an ep_info message. It says what kind each endpoint is:
> bulk, interrupt or control. QEMU cannot tell us. It only knows after it
> has read the device's descriptors, and it never reads them for a device
> that just forwards transfers. So we read them ourselves: the
> configuration descriptor passes through us on its way to the host.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Message-ID: <20261012021634.2006424-6-jamin_lin@aspeedtech.com>
>
> diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c
> index 05ee0f38736e..22083394ab41 100644
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
> @@ -92,8 +129,23 @@ struct USBRedirServer {
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
> @@ -104,9 +156,98 @@ static USBDevice *usbredir_server_device(USBRedirServer *s)
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
> +    if (desc->bLength < 7) {
> +        return;
> +    }
> +
> +    addr = desc->u.endpoint.bEndpointAddress;
> +    ep_nr = addr & 0x0f;
> +    idx = (addr & USB_DIR_IN) ? ep_nr + USBREDIR_SERVER_EP_IN_BASE : ep_nr;
> +    if (ep_nr < 1 || idx >= USBREDIR_SERVER_MAX_EP) {
> +        return;
> +    }
> +
> +    s->ep_type[idx] = desc->u.endpoint.bmAttributes & 0x03;
> +    s->ep_max_packet[idx] = (desc->u.endpoint.wMaxPacketSize_hi << 8) |
> +                            desc->u.endpoint.wMaxPacketSize_lo;
> +    s->ep_interval[idx] = desc->u.endpoint.bInterval;
> +    s->ep_iface[idx] = iface;
> +}
> +
> +/*
> + * A device that only passes transfers through never gets its endpoint
> + * types filled in: they stay INVALID and there is nothing to put in
> + * ep_info. Take them from the configuration descriptor as it goes past.
> + * Without them the host sees type 255 and refuses to move data.
> + */
> +static void usbredir_server_snoop_config_desc(USBRedirServer *s,
> +                                              const uint8_t *data, int len)
> +{
> +    const USBDescriptor *desc;
> +    uint8_t iface = 0;
> +    int i = 0;
> +
> +    while (i + 2 <= len) {
> +        desc = (const USBDescriptor *)(data + i);
> +
> +        if (desc->bLength < 2 || i + desc->bLength > len) {
> +            break;
> +        }
> +
> +        if (desc->bDescriptorType == USB_DT_INTERFACE && desc->bLength >= 3) {
> +            iface = desc->u.interface.bInterfaceNumber;

This records the interface number but not bAlternateSetting. When the
config descriptor carries two alternates for the same interface, both
are walked and their endpoints overwrite each other in the ep tables.
After SET_INTERFACE selects alternate 0, ep_info may still describe the
endpoints of alternate 1.

You should be able to cache the config descriptor and re-parses it when the
active alternate changes at ctrl_status_complete(), when sending the new
send_ep_info().

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


