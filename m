Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EAF9C54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 09:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riASG-0002oh-1H; Thu, 07 Mar 2024 04:54:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1riASE-0002oH-Qx
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 04:54:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1riASC-0006qR-Aq
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 04:54:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709805259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uqvwOjAZx6JIVS3NS+bMga8z/gbkJvfaL82aMZKZtbc=;
 b=R6qRgwvylPuqBBRRnvz/cGpNbUXZ2fbhdn8MhcJj+L7VUj4LnKTxkpfSyyTu04q3hnyV6+
 AHqRrOIPeaYJ5cxUrl14Cnwah1tx2LgHA/RZnwbkoE8U5+kuM8uwVHv8tnaTBW6sRD0lj1
 3inpPkRDAbMaJTc9R33iBZdSXyWVh5g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-p9Ws7BexOw2WAhUnEBhIrw-1; Thu,
 07 Mar 2024 04:54:14 -0500
X-MC-Unique: p9Ws7BexOw2WAhUnEBhIrw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52E081C05EAD;
 Thu,  7 Mar 2024 09:54:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EF39F492BCD;
 Thu,  7 Mar 2024 09:54:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C682F21E6A24; Thu,  7 Mar 2024 10:54:12 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org,  raphael@enfabrica.net,  mst@redhat.com,
 kwolf@redhat.com,  hreitz@redhat.com,  pbonzini@redhat.com,
 berrange@redhat.com,  eduardo@habkost.net,  dave@treblig.org,
 eblake@redhat.com,  qemu-devel@nongnu.org,  yc-core@yandex-team.ru
Subject: Re: [PATCH v2 4/6] qapi: introduce device-sync-config
In-Reply-To: <20240301171143.809835-5-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 1 Mar 2024 20:11:41 +0300")
References: <20240301171143.809835-1-vsementsov@yandex-team.ru>
 <20240301171143.809835-5-vsementsov@yandex-team.ru>
Date: Thu, 07 Mar 2024 10:54:12 +0100
Message-ID: <87o7bqcqpn.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

> Add command to sync config from vhost-user backend to the device. It
> may be helpful when VHOST_USER_SLAVE_CONFIG_CHANGE_MSG failed or not
> triggered interrupt to the guest or just not available (not supported
> by vhost-user server).
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/block/vhost-user-blk.c | 27 ++++++++++++++++++++-------
>  hw/virtio/virtio-pci.c    |  9 +++++++++
>  include/hw/qdev-core.h    |  3 +++
>  qapi/qdev.json            | 17 +++++++++++++++++
>  system/qdev-monitor.c     | 23 +++++++++++++++++++++++
>  5 files changed, 72 insertions(+), 7 deletions(-)
>
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 9e6bbc6950..2f301f380c 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -88,27 +88,39 @@ static void vhost_user_blk_set_config(VirtIODevice *vdev, const uint8_t *config)
>      s->blkcfg.wce = blkcfg->wce;
>  }
>  
> +static int vhost_user_blk_sync_config(DeviceState *dev, Error **errp)
> +{
> +    int ret;
> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> +    VHostUserBlk *s = VHOST_USER_BLK(vdev);
> +
> +    ret = vhost_dev_get_config(&s->dev, (uint8_t *)&s->blkcfg,
> +                               vdev->config_len, errp);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    memcpy(vdev->config, &s->blkcfg, vdev->config_len);
> +    virtio_notify_config(vdev);
> +
> +    return 0;
> +}
> +
>  static int vhost_user_blk_handle_config_change(struct vhost_dev *dev)
>  {
>      int ret;
> -    VirtIODevice *vdev = dev->vdev;
> -    VHostUserBlk *s = VHOST_USER_BLK(dev->vdev);
>      Error *local_err = NULL;
>  
>      if (!dev->started) {
>          return 0;
>      }
>  
> -    ret = vhost_dev_get_config(dev, (uint8_t *)&s->blkcfg,
> -                               vdev->config_len, &local_err);
> +    ret = vhost_user_blk_sync_config(DEVICE(dev->vdev), &local_err);
>      if (ret < 0) {
>          error_report_err(local_err);
>          return ret;
>      }
>  
> -    memcpy(dev->vdev->config, &s->blkcfg, vdev->config_len);
> -    virtio_notify_config(dev->vdev);
> -
>      return 0;
>  }
>  
> @@ -576,6 +588,7 @@ static void vhost_user_blk_class_init(ObjectClass *klass, void *data)
>  
>      device_class_set_props(dc, vhost_user_blk_properties);
>      dc->vmsd = &vmstate_vhost_user_blk;
> +    dc->sync_config = vhost_user_blk_sync_config;
>      set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
>      vdc->realize = vhost_user_blk_device_realize;
>      vdc->unrealize = vhost_user_blk_device_unrealize;
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 1a7039fb0c..1197341a3c 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -2318,6 +2318,14 @@ static void virtio_pci_dc_realize(DeviceState *qdev, Error **errp)
>      vpciklass->parent_dc_realize(qdev, errp);
>  }
>  
> +static int virtio_pci_sync_config(DeviceState *dev, Error **errp)
> +{
> +    VirtIOPCIProxy *proxy = VIRTIO_PCI(dev);
> +    VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
> +
> +    return qdev_sync_config(DEVICE(vdev), errp);
> +}
> +
>  static void virtio_pci_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -2334,6 +2342,7 @@ static void virtio_pci_class_init(ObjectClass *klass, void *data)
>      device_class_set_parent_realize(dc, virtio_pci_dc_realize,
>                                      &vpciklass->parent_dc_realize);
>      rc->phases.hold = virtio_pci_bus_reset_hold;
> +    dc->sync_config = virtio_pci_sync_config;
>  }
>  
>  static const TypeInfo virtio_pci_info = {
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 9228e96c87..87135bdcdf 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -95,6 +95,7 @@ typedef void (*DeviceUnrealize)(DeviceState *dev);
>  typedef void (*DeviceReset)(DeviceState *dev);
>  typedef void (*BusRealize)(BusState *bus, Error **errp);
>  typedef void (*BusUnrealize)(BusState *bus);
> +typedef int (*DeviceSyncConfig)(DeviceState *dev, Error **errp);
>  
>  /**
>   * struct DeviceClass - The base class for all devices.
> @@ -162,6 +163,7 @@ struct DeviceClass {
>      DeviceReset reset;
>      DeviceRealize realize;
>      DeviceUnrealize unrealize;
> +    DeviceSyncConfig sync_config;
>  
>      /**
>       * @vmsd: device state serialisation description for
> @@ -546,6 +548,7 @@ bool qdev_hotplug_allowed(DeviceState *dev, Error **errp);
>   */
>  HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev);
>  void qdev_unplug(DeviceState *dev, Error **errp);
> +int qdev_sync_config(DeviceState *dev, Error **errp);
>  void qdev_simple_device_unplug_cb(HotplugHandler *hotplug_dev,
>                                    DeviceState *dev, Error **errp);
>  void qdev_machine_creation_done(void);
> diff --git a/qapi/qdev.json b/qapi/qdev.json
> index 32ffaee644..6ece164172 100644
> --- a/qapi/qdev.json
> +++ b/qapi/qdev.json
> @@ -162,3 +162,20 @@
>  ##
>  { 'event': 'DEVICE_UNPLUG_GUEST_ERROR',
>    'data': { '*device': 'str', 'path': 'str' } }
> +
> +##
> +# @device-sync-config:
> +#
> +# Synchronize config from backend to the guest.
> +#
> +# @id: the device's ID or QOM path
> +#
> +# Features:
> +#
> +# @unstable: The command is experimental.
> +#
> +# Since: 9.0
> +##

Even for an experimental command a bit more guidance on intended would
be good.

The commit message describes this as a "command to sync config from
vhost-user backend to the device".  Here, there's no mention of
vhost-user.

Could the command make sense for devices other than vhost-user?

> +{ 'command': 'device-sync-config',
> +  'features': [ 'unstable' ],
> +  'data': {'id': 'str'} }
> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> index cf7481e416..e3107a12d7 100644
> --- a/system/qdev-monitor.c
> +++ b/system/qdev-monitor.c
> @@ -968,6 +968,29 @@ void qmp_device_del(const char *id, Error **errp)
>      }
>  }
>  
> +int qdev_sync_config(DeviceState *dev, Error **errp)
> +{
> +    DeviceClass *dc = DEVICE_GET_CLASS(dev);
> +
> +    if (!dc->sync_config) {
> +        error_setg(errp, "device-sync-config is not supported for '%s'",
> +                   object_get_typename(OBJECT(dev)));
> +        return -ENOTSUP;
> +    }
> +
> +    return dc->sync_config(dev, errp);
> +}
> +
> +void qmp_device_sync_config(const char *id, Error **errp)
> +{
> +    DeviceState *dev = find_device_state(id, true, errp);
> +    if (!dev) {
> +        return;
> +    }
> +
> +    qdev_sync_config(dev, errp);
> +}
> +
>  void hmp_device_add(Monitor *mon, const QDict *qdict)
>  {
>      Error *err = NULL;


