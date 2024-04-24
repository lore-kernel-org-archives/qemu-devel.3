Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC75C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 12:11:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzbTH-0008W8-PC; Wed, 24 Apr 2024 08:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzbTG-0008VV-6X
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 08:11:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzbTE-0000SX-Fq
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 08:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713960687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iO254fgiRB13Jdm8pmVJEfSGgSzux/0GWLOQxhpRPok=;
 b=Twh5RaHmhe03npoixXNeNgO95cYpQoNeJgxejX2ysz7B+WcTZWTqV9HrX5PyjQzaCsLJnv
 M88GJcAQ084hgLDbzGotyYX6XMek4q/0zoiCjyA1HIAn3qnOE8lFhhpaqTAGGSMqNryDn2
 xpBiGxFoujZpSvaFcgJVW4iTCA0j1GI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-FOzNXeLeO1WGs0xAzDO90w-1; Wed,
 24 Apr 2024 08:11:22 -0400
X-MC-Unique: FOzNXeLeO1WGs0xAzDO90w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C575D1C0C654;
 Wed, 24 Apr 2024 12:11:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EB11EC684;
 Wed, 24 Apr 2024 12:11:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6A23D21E6680; Wed, 24 Apr 2024 14:11:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org,  raphael@enfabrica.net,  mst@redhat.com,
 kwolf@redhat.com,  hreitz@redhat.com,  pbonzini@redhat.com,
 berrange@redhat.com,  eduardo@habkost.net,  dave@treblig.org,
 eblake@redhat.com,  qemu-devel@nongnu.org,  yc-core@yandex-team.ru
Subject: Re: [PATCH v3 5/5] qapi: introduce CONFIG_READ event
In-Reply-To: <20240329183758.3360733-6-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 29 Mar 2024 21:37:58 +0300")
References: <20240329183758.3360733-1-vsementsov@yandex-team.ru>
 <20240329183758.3360733-6-vsementsov@yandex-team.ru>
Date: Wed, 24 Apr 2024 14:11:20 +0200
Message-ID: <87a5ljvu3b.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> Send a new event when guest reads virtio-pci config after
> virtio_notify_config() call.
>
> That's useful to check that guest fetched modified config, for example
> after resizing disk backend.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/virtio-pci.c |  9 +++++++++
>  include/monitor/qdev.h |  2 ++
>  monitor/monitor.c      |  1 +
>  qapi/qdev.json         | 33 +++++++++++++++++++++++++++++++++
>  stubs/qdev.c           |  6 ++++++
>  system/qdev-monitor.c  |  6 ++++++
>  6 files changed, 57 insertions(+)
>
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 92afbae71c..c0c158dae2 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -23,6 +23,7 @@
>  #include "hw/boards.h"
>  #include "hw/virtio/virtio.h"
>  #include "migration/qemu-file-types.h"
> +#include "monitor/qdev.h"
>  #include "hw/pci/pci.h"
>  #include "hw/pci/pci_bus.h"
>  #include "hw/qdev-properties.h"
> @@ -530,6 +531,10 @@ static uint64_t virtio_pci_config_read(void *opaque, hwaddr addr,
>      }
>      addr -= config;
>  
> +    if (vdev->generation > 0) {
> +        qdev_virtio_config_read_event(DEVICE(proxy));
> +    }
> +
>      switch (size) {
>      case 1:
>          val = virtio_config_readb(vdev, addr);
> @@ -1884,6 +1889,10 @@ static uint64_t virtio_pci_device_read(void *opaque, hwaddr addr,
>          return UINT64_MAX;
>      }
>  
> +    if (vdev->generation > 0) {
> +        qdev_virtio_config_read_event(DEVICE(proxy));
> +    }
> +
>      switch (size) {
>      case 1:
>          val = virtio_config_modern_readb(vdev, addr);
> diff --git a/include/monitor/qdev.h b/include/monitor/qdev.h
> index 1d57bf6577..fc9a834dca 100644
> --- a/include/monitor/qdev.h
> +++ b/include/monitor/qdev.h
> @@ -36,4 +36,6 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
>   */
>  const char *qdev_set_id(DeviceState *dev, char *id, Error **errp);
>  
> +void qdev_virtio_config_read_event(DeviceState *dev);
> +
>  #endif
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 01ede1babd..5b06146503 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -316,6 +316,7 @@ static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
>      [QAPI_EVENT_VSERPORT_CHANGE]   = { 1000 * SCALE_MS },
>      [QAPI_EVENT_MEMORY_DEVICE_SIZE_CHANGE] = { 1000 * SCALE_MS },
>      [QAPI_EVENT_HV_BALLOON_STATUS_REPORT] = { 1000 * SCALE_MS },
> +    [QAPI_EVENT_VIRTIO_CONFIG_READ] = { 300 * SCALE_MS },

All the other rate-limited events use 1s.  Why 0.3s for this one?

>  };
>  
>  /*
> diff --git a/qapi/qdev.json b/qapi/qdev.json
> index e8be79c3d5..29a4f47360 100644
> --- a/qapi/qdev.json
> +++ b/qapi/qdev.json
> @@ -182,3 +182,36 @@
>  { 'command': 'device-sync-config',
>    'features': [ 'unstable' ],
>    'data': {'id': 'str'} }
> +
> +##
> +# @VIRTIO_CONFIG_READ:
> +#
> +# Emitted whenever guest reads virtio device configuration after
> +# configuration change.

Is it emitted whenever the guest reads, or only when it reads after a
configuration change?

> +#
> +# The event may be used in pair with device-sync-config. It shows
> +# that guest has re-read updated configuration. It doesn't
> +# guarantee that guest successfully handled it and updated the
> +# view of the device for the user, but still it's a kind of
> +# success indicator.

The event is virtio-only.  device-sync-config isn't.  Why?

> +#
> +# @device: device name
> +#
> +# @path: device path
> +#
> +# Features:
> +#
> +# @unstable: The event is experimental.
> +#

Missing:

   # Note: This event is rate-limited.
   #

> +# Since: 9.1
> +#
> +# Example:
> +#
> +#     <- { "event": "VIRTIO_CONFIG_READ",
> +#          "data": { "device": "virtio-net-pci-0",
> +#                    "path": "/machine/peripheral/virtio-net-pci-0" },
> +#          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
> +##
> +{ 'event': 'VIRTIO_CONFIG_READ',
> +  'features': [ 'unstable' ],
> +  'data': { '*device': 'str', 'path': 'str' } }
> diff --git a/stubs/qdev.c b/stubs/qdev.c
> index 6869f6f90a..ab6c4afe0b 100644
> --- a/stubs/qdev.c
> +++ b/stubs/qdev.c
> @@ -26,3 +26,9 @@ void qapi_event_send_device_unplug_guest_error(const char *device,
>  {
>      /* Nothing to do. */
>  }
> +
> +void qapi_event_send_virtio_config_read(const char *device,
> +                                        const char *path)
> +{
> +    /* Nothing to do. */
> +}
> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> index cb35ea0b86..8a2ca77fde 100644
> --- a/system/qdev-monitor.c
> +++ b/system/qdev-monitor.c
> @@ -26,6 +26,7 @@
>  #include "sysemu/runstate.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-qdev.h"
> +#include "qapi/qapi-events-qdev.h"
>  #include "qapi/qmp/dispatch.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qerror.h"
> @@ -1206,3 +1207,8 @@ bool qmp_command_available(const QmpCommand *cmd, Error **errp)
>      }
>      return true;
>  }
> +
> +void qdev_virtio_config_read_event(DeviceState *dev)
> +{
> +    qapi_event_send_virtio_config_read(dev->id, dev->canonical_path);
> +}

Which configuration needs the stub?


