Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEACCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 08:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0cJZ-00008t-AS; Mon, 22 Sep 2025 04:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v0cJT-00008U-Fu
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 04:54:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v0cJM-0008Em-F9
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 04:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758531249;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ODUBDcDRgIeMKbTzvzw7Tn/qGv+nAQy598Dt18ysOIg=;
 b=I38zY4/OaATH4/7MnzWmABer9LBiwzHeNT9zmU6maf13RQnDyg0NqJxEpzycJ46zojpMrd
 +k3ngowY/hL79P9jZ6n1H6oU2QqoOM/etrh/+JM9YiVtdPQp8Foqu1On1+1KfogzKHdcXo
 vbsEq5fA6E681Amo0i8a6nu0DhRFgVg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-bNLs28NDN3OGc5tOwfE_tA-1; Mon,
 22 Sep 2025 04:53:59 -0400
X-MC-Unique: bNLs28NDN3OGc5tOwfE_tA-1
X-Mimecast-MFC-AGG-ID: bNLs28NDN3OGc5tOwfE_tA_1758531236
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 521AB1800284; Mon, 22 Sep 2025 08:53:56 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.69])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BBB251800446; Mon, 22 Sep 2025 08:53:50 +0000 (UTC)
Date: Mon, 22 Sep 2025 09:53:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
 Szymon Lukasz <noh4hss@gmail.com>
Subject: Re: [PATCH RFC v5 08/12] virtio-serial-bus: add terminal resize
 messages
Message-ID: <aNEOlnPRKQlVfCRD@redhat.com>
References: <20250921-console-resize-v5-0-89e3c6727060@gmail.com>
 <20250921-console-resize-v5-8-89e3c6727060@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250921-console-resize-v5-8-89e3c6727060@gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Sun, Sep 21, 2025 at 01:45:38AM +0200, Filip Hejsek wrote:
> From: Szymon Lukasz <noh4hss@gmail.com>
> 
> Implement the part of the virtio spec that allows to notify the virtio
> driver about terminal resizes. The virtio spec contains two methods to
> achieve that:
> 
> For legacy drivers, we have only one port and we put the terminal size
> in the config space and inject the config changed interrupt.
> 
> For multiport devices, we use the control virtqueue to send a packet
> containing the terminal size. Note that old versions of the Linux kernel
> used an incorrect order for the fields (rows then cols instead of cols
> then rows), until it was fixed by commit 5326ab737a47278dbd16ed3ee7380b26c7056ddd.
> 
> As a result, when using a Linux kernel older than 6.15, the number of rows
> and columns will be swapped.

That kernel patch is being reverted:

  https://lore.kernel.org/lkml/20250918110946-mutt-send-email-mst@kernel.org/

so this patch needs to use the historical ordering.

That revert needs to go into linux -stable trees, and any recent distro
that has picked up the recent swapped ordering in their kernels.

> 
> Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
> [Filip: swap rows/cols, console-size affects multiport too,
>         size config always updated, use use_multiport, move trace call]
> Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> ---
>  hw/char/trace-events              |  1 +
>  hw/char/virtio-serial-bus.c       | 51 +++++++++++++++++++++++++++++++++++++--
>  hw/core/machine.c                 |  4 ++-
>  include/hw/virtio/virtio-serial.h |  5 ++++
>  4 files changed, 58 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/char/trace-events b/hw/char/trace-events
> index 05a33036c12070242c2b193c19011839d623bec4..9a975ab1e2a525a9391d0f0a85ddbe80aa6361fc 100644
> --- a/hw/char/trace-events
> +++ b/hw/char/trace-events
> @@ -11,6 +11,7 @@ serial_update_parameters(uint64_t baudrate, char parity, int data_bits, int stop
>  
>  # virtio-serial-bus.c
>  virtio_serial_send_control_event(unsigned int port, uint16_t event, uint16_t value) "port %u, event %u, value %u"
> +virtio_serial_send_console_resize(unsigned int port, uint16_t cols, uint16_t rows) "port %u, cols %u, rows %u"
>  virtio_serial_throttle_port(unsigned int port, bool throttle) "port %u, throttle %d"
>  virtio_serial_handle_control_message(uint16_t event, uint16_t value) "event %u, value %u"
>  virtio_serial_handle_control_message_port(unsigned int port) "port %u"
> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> index 673c50f0be08ef9b7142c16eaf8e6e31c7a00ca5..30e3ec73a1733449b2505f231a3d2b3516ae4b4e 100644
> --- a/hw/char/virtio-serial-bus.c
> +++ b/hw/char/virtio-serial-bus.c
> @@ -260,6 +260,51 @@ static size_t send_control_event(VirtIOSerial *vser, uint32_t port_id,
>      return send_control_msg(vser, &cpkt, sizeof(cpkt));
>  }
>  
> +/*
> + * This struct should be added to the Linux kernel uapi headers
> + * and later imported to standard-headers/linux/virtio_console.h
> + */
> +struct virtio_console_resize {
> +    __virtio16 cols;
> +    __virtio16 rows;
> +};
> +
> +void virtio_serial_send_console_resize(VirtIOSerialPort *port,
> +                                       uint16_t cols, uint16_t rows)
> +{
> +    VirtIOSerial *vser = port->vser;
> +    VirtIODevice *vdev = VIRTIO_DEVICE(vser);
> +
> +    if (!virtio_has_feature(vser->host_features, VIRTIO_CONSOLE_F_SIZE)) {
> +        return;
> +    }
> +
> +    trace_virtio_serial_send_console_resize(port->id, cols, rows);
> +
> +    if (port->id == 0) {
> +        vser->port0_cols = cols;
> +        vser->port0_rows = rows;
> +        if (!use_multiport(vser) &&
> +            virtio_vdev_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE)) {
> +            virtio_notify_config(vdev);
> +        }
> +    }
> +
> +    if (use_multiport(vser)) {
> +        struct {
> +            struct virtio_console_control control;
> +            struct virtio_console_resize resize;
> +        } buffer;
> +
> +        virtio_stl_p(vdev, &buffer.control.id, port->id);
> +        virtio_stw_p(vdev, &buffer.control.event, VIRTIO_CONSOLE_RESIZE);
> +        virtio_stw_p(vdev, &buffer.resize.cols, cols);
> +        virtio_stw_p(vdev, &buffer.resize.rows, rows);
> +
> +        send_control_msg(vser, &buffer, sizeof(buffer));
> +    }
> +}
> +
>  /* Functions for use inside qemu to open and read from/write to ports */
>  int virtio_serial_open(VirtIOSerialPort *port)
>  {
> @@ -571,8 +616,8 @@ static void get_config(VirtIODevice *vdev, uint8_t *config_data)
>      struct virtio_console_config *config =
>          (struct virtio_console_config *)config_data;
>  
> -    config->cols = 0;
> -    config->rows = 0;
> +    config->cols = virtio_tswap16(vdev, vser->port0_cols);
> +    config->rows = virtio_tswap16(vdev, vser->port0_rows);
>      config->max_nr_ports = virtio_tswap32(vdev,
>                                            vser->serial.max_virtserial_ports);
>  }
> @@ -1158,6 +1203,8 @@ static const Property virtio_serial_properties[] = {
>                                                    31),
>      DEFINE_PROP_BIT64("emergency-write", VirtIOSerial, host_features,
>                        VIRTIO_CONSOLE_F_EMERG_WRITE, true),
> +    DEFINE_PROP_BIT64("console-size", VirtIOSerial, host_features,
> +                      VIRTIO_CONSOLE_F_SIZE, true),
>  };
>  
>  static void virtio_serial_class_init(ObjectClass *klass, const void *data)
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 38c949c4f2ce4a117cbfca62f56919711ce392b4..74a747ec6578c958b35e1f9712e5dbed7bca72e8 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -37,7 +37,9 @@
>  #include "hw/virtio/virtio-iommu.h"
>  #include "audio/audio.h"
>  
> -GlobalProperty hw_compat_10_1[] = {};
> +GlobalProperty hw_compat_10_1[] = {
> +    { "virtio-serial-device", "console-size", "off" },
> +};
>  const size_t hw_compat_10_1_len = G_N_ELEMENTS(hw_compat_10_1);
>  
>  GlobalProperty hw_compat_10_0[] = {
> diff --git a/include/hw/virtio/virtio-serial.h b/include/hw/virtio/virtio-serial.h
> index d87c62eab7a270809daf47f932a73dd1fa3d5a6e..81efa853f804a52866890a9ec2c71bfbcabca4a0 100644
> --- a/include/hw/virtio/virtio-serial.h
> +++ b/include/hw/virtio/virtio-serial.h
> @@ -187,6 +187,8 @@ struct VirtIOSerial {
>      virtio_serial_conf serial;
>  
>      uint64_t host_features;
> +
> +    uint16_t port0_cols, port0_rows;
>  };
>  
>  /* Interface to the virtio-serial bus */
> @@ -221,6 +223,9 @@ size_t virtio_serial_guest_ready(VirtIOSerialPort *port);
>   */
>  void virtio_serial_throttle_port(VirtIOSerialPort *port, bool throttle);
>  
> +void virtio_serial_send_console_resize(VirtIOSerialPort *port,
> +                                       uint16_t cols, uint16_t rows);
> +
>  #define TYPE_VIRTIO_SERIAL "virtio-serial-device"
>  OBJECT_DECLARE_SIMPLE_TYPE(VirtIOSerial, VIRTIO_SERIAL)
>  
> 
> -- 
> 2.51.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


