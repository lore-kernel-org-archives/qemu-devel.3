Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81020C27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 08:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGaT2-0003oO-Hz; Mon, 10 Jun 2024 04:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sGaT0-0003ns-9f
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 04:33:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sGaSx-000341-TF
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 04:33:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718008402;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aH1EbHv2ccOesspHPr5h9DBuT4XvBXNIaeNt9TbwvqM=;
 b=YXl6pBNkVaY40kUAeQ9+MDYUDv8oSAfGyswOJFWzIbPeICGknVYTfm2tBZKSxGhJREalcY
 FOpHbKgsW5lSk6vU6IBJt/mTqfw9BAxEH+B0TjV5UVBIJDEZoPiZNkFRr8QAICa7wX4d4w
 n/c6tIGPkpwEXQxYK61D9dB30sEU4IE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-7eCbzr4uO8e7q4PqBOEnrg-1; Mon,
 10 Jun 2024 04:33:21 -0400
X-MC-Unique: 7eCbzr4uO8e7q4PqBOEnrg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4C0F1C05129;
 Mon, 10 Jun 2024 08:33:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA7DB1121337;
 Mon, 10 Jun 2024 08:33:17 +0000 (UTC)
Date: Mon, 10 Jun 2024 09:33:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Don Porter <porter@cs.unc.edu>, Eric Blake <eblake@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] hw/usb: Introduce x-query-usbhost QMP command
Message-ID: <Zma6S1bHmE4oGKhX@redhat.com>
References: <20240610063848.51027-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240610063848.51027-1-philmd@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Jun 10, 2024 at 08:38:47AM +0200, Philippe Mathieu-Daudé wrote:
> This is a counterpart to the HMP "info usbhost" command. It is being
> added with an "x-" prefix because this QMP command is intended as an
> adhoc debugging tool and will thus not be modelled in QAPI as fully
> structured data, nor will it have long term guaranteed stability.
> The existing HMP command is rewritten to call the QMP command.

'info usb' host is one of the problem scenarios i mentioned in

https://lore.kernel.org/qemu-devel/20211028155457.967291-1-berrange@redhat.com/

Its HMP impl is within a dynamically loadable module. So if you
run it initially you'll get

(qemu) info usbhost
Command "info usbhost" is not available.


but if you have a usb host on the cli:

(qemu) info usbhost
  Bus 3, Addr 6, Port 8, Speed 480 Mb/s
    Class ef: USB device 04f2:b74f
  Bus 3, Addr 11, Port 7.3, Speed 1.5 Mb/s
  ...snip...


Anyway, the end result is that this patch fails to link when modules
are enabled:

cc -m64 @qemu-system-x86_64.rsp
/usr/bin/ld: libqemuutil.a.p/meson-generated_.._qapi_qapi-commands-machine.c.o: in function `qmp_marshal_x_query_usbhost':
/var/home/berrange/src/virt/qemu/build/qapi/qapi-commands-machine.c:1514: undefined reference to `qmp_x_query_usbhost'


IMHO the solution to this is to refactor the cdoe to split
hw/usb/host-libusb.c into two parts.

One part provides the monitor API impls, and some callbacks
for feeding data to them. The other part provides the actual
impl, and registers the callbacks needed by the monitor cmd.

> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  qapi/machine.json          | 18 ++++++++++++++++++
>  include/hw/usb.h           |  3 ---
>  hw/usb/bus-stub.c          |  7 ++++++-
>  hw/usb/host-libusb.c       | 38 +++++++++++++++++++++++++-------------
>  tests/qtest/qmp-cmd-test.c |  3 +++
>  5 files changed, 52 insertions(+), 17 deletions(-)
> 
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 1283d14493..1b428f29d4 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1813,6 +1813,24 @@
>    'returns': 'HumanReadableText',
>    'features': [ 'unstable' ] }
>  
> +##
> +# @x-query-usbhost:
> +#
> +# Query information on host USB devices
> +#
> +# Features:
> +#
> +# @unstable: This command is meant for debugging.
> +#
> +# Returns: Host USB device information
> +#
> +# Since: 9.1
> +##
> +{ 'command': 'x-query-usbhost',
> +  'returns': 'HumanReadableText',
> +  'features': [ 'unstable' ],
> +  'if': 'CONFIG_USB_LIBUSB' }
> +
>  ##
>  # @SmbiosEntryPointType:
>  #
> diff --git a/include/hw/usb.h b/include/hw/usb.h
> index d46d96779a..c0b34af518 100644
> --- a/include/hw/usb.h
> +++ b/include/hw/usb.h
> @@ -465,9 +465,6 @@ void usb_device_reset(USBDevice *dev);
>  void usb_wakeup(USBEndpoint *ep, unsigned int stream);
>  void usb_generic_async_ctrl_complete(USBDevice *s, USBPacket *p);
>  
> -/* usb-linux.c */
> -void hmp_info_usbhost(Monitor *mon, const QDict *qdict);
> -
>  /* usb ports of the VM */
>  
>  #define VM_USB_HUB_SIZE 8
> diff --git a/hw/usb/bus-stub.c b/hw/usb/bus-stub.c
> index fcabe8429e..948429bb33 100644
> --- a/hw/usb/bus-stub.c
> +++ b/hw/usb/bus-stub.c
> @@ -11,7 +11,6 @@
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-machine.h"
>  #include "sysemu/sysemu.h"
> -#include "monitor/monitor.h"
>  #include "hw/usb.h"
>  
>  USBDevice *usbdevice_create(const char *driver)
> @@ -26,3 +25,9 @@ HumanReadableText *qmp_x_query_usb(Error **errp)
>      error_setg(errp, "Support for USB devices not built-in");
>      return NULL;
>  }
> +
> +HumanReadableText *qmp_x_query_usbhost(Error **errp)
> +{
> +    error_setg(errp, "Support for USB devices not built-in");
> +    return NULL;
> +}
> diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
> index 80122b4125..5781d7fa7c 100644
> --- a/hw/usb/host-libusb.c
> +++ b/hw/usb/host-libusb.c
> @@ -46,6 +46,8 @@
>  #endif
>  
>  #include "qapi/error.h"
> +#include "qapi/qapi-commands-machine.h"
> +#include "qapi/type-helpers.h"
>  #include "migration/vmstate.h"
>  #include "monitor/monitor.h"
>  #include "qemu/error-report.h"
> @@ -1816,7 +1818,7 @@ module_kconfig(USB);
>  static void usb_host_register_types(void)
>  {
>      type_register_static(&usb_host_dev_info);
> -    monitor_register_hmp("usbhost", true, hmp_info_usbhost);
> +    monitor_register_hmp_info_hrt("usbhost", qmp_x_query_usbhost);
>  }
>  
>  type_init(usb_host_register_types)
> @@ -1921,18 +1923,25 @@ static void usb_host_auto_check(void *unused)
>      timer_mod(usb_auto_timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + 2000);
>  }
>  
> -void hmp_info_usbhost(Monitor *mon, const QDict *qdict)
> +HumanReadableText *qmp_x_query_usbhost(Error **errp)
>  {
> +    g_autoptr(GString) buf = g_string_new("");
>      libusb_device **devs = NULL;
>      struct libusb_device_descriptor ddesc;
>      char port[16];
>      int i, n;
>  
>      if (usb_host_init() != 0) {
> -        return;
> +        error_setg(errp, "Failed to init libusb");
> +        return NULL;
>      }
>  
>      n = libusb_get_device_list(ctx, &devs);
> +    if (!n) {
> +        error_setg(errp, "No host USB device");
> +        return NULL;
> +    }
> +
>      for (i = 0; i < n; i++) {
>          if (libusb_get_device_descriptor(devs[i], &ddesc) != 0) {
>              continue;
> @@ -1941,14 +1950,15 @@ void hmp_info_usbhost(Monitor *mon, const QDict *qdict)
>              continue;
>          }
>          usb_host_get_port(devs[i], port, sizeof(port));
> -        monitor_printf(mon, "  Bus %d, Addr %d, Port %s, Speed %s Mb/s\n",
> -                       libusb_get_bus_number(devs[i]),
> -                       libusb_get_device_address(devs[i]),
> -                       port,
> -                       speed_name[libusb_get_device_speed(devs[i])]);
> -        monitor_printf(mon, "    Class %02x:", ddesc.bDeviceClass);
> -        monitor_printf(mon, " USB device %04x:%04x",
> -                       ddesc.idVendor, ddesc.idProduct);
> +        g_string_append_printf(buf,
> +                               "  Bus %d, Addr %d, Port %s, Speed %s Mb/s\n",
> +                               libusb_get_bus_number(devs[i]),
> +                               libusb_get_device_address(devs[i]),
> +                               port,
> +                               speed_name[libusb_get_device_speed(devs[i])]);
> +        g_string_append_printf(buf, "    Class %02x:", ddesc.bDeviceClass);
> +        g_string_append_printf(buf, " USB device %04x:%04x",
> +                               ddesc.idVendor, ddesc.idProduct);
>          if (ddesc.iProduct) {
>              libusb_device_handle *handle;
>              if (libusb_open(devs[i], &handle) == 0) {
> @@ -1957,10 +1967,12 @@ void hmp_info_usbhost(Monitor *mon, const QDict *qdict)
>                                                     ddesc.iProduct,
>                                                     name, sizeof(name));
>                  libusb_close(handle);
> -                monitor_printf(mon, ", %s", name);
> +                g_string_append_printf(buf, ", %s", name);
>              }
>          }
> -        monitor_printf(mon, "\n");
> +        g_string_append_c(buf, '\n');
>      }
>      libusb_free_device_list(devs, 1);
> +
> +    return human_readable_text_from_str(buf);
>  }
> diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
> index 2c15f60958..731d3c6c59 100644
> --- a/tests/qtest/qmp-cmd-test.c
> +++ b/tests/qtest/qmp-cmd-test.c
> @@ -49,6 +49,9 @@ static int query_error_class(const char *cmd)
>          { "query-vm-generation-id", ERROR_CLASS_GENERIC_ERROR },
>          /* Only valid with a USB bus added */
>          { "x-query-usb", ERROR_CLASS_GENERIC_ERROR },
> +#ifdef CONFIG_USB_LIBUSB
> +        { "x-query-usbhost", ERROR_CLASS_GENERIC_ERROR },
> +#endif
>          /* Only valid with accel=tcg */
>          { "x-query-jit", ERROR_CLASS_GENERIC_ERROR },
>          { "x-query-opcount", ERROR_CLASS_GENERIC_ERROR },
> -- 
> 2.41.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


