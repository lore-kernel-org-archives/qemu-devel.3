Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC77D711CA
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 10:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE4UU-00031n-KS; Thu, 21 Nov 2024 05:32:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tE4US-00031e-O5
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 05:32:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tE4UQ-0003gC-Ae
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 05:32:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732185165;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5IviSM9+lsfNGbB00+/HrBGg2POLKUp+2TI/sV2aVbw=;
 b=XHUAEGio0FOhoU9LktolXEAKiQ7VEBD6tC205WB3sEc3AauY2o/WzvcXqovFuiazyY7BV0
 +ZqRtXaYsDovmem0Jq1IfGtWYJ0Y4PFMFPlOvlE1uH3rvgwQ1o0u7W5aTkQ+qLTFER3SK8
 K4ObJiP4xnWYuuiNk9EQ7ROKV0Bes0c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-oFKQTERWPBy2QIjvvEDOIA-1; Thu,
 21 Nov 2024 05:32:42 -0500
X-MC-Unique: oFKQTERWPBy2QIjvvEDOIA-1
X-Mimecast-MFC-AGG-ID: oFKQTERWPBy2QIjvvEDOIA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BB5D1956048; Thu, 21 Nov 2024 10:32:41 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1FF0219560A3; Thu, 21 Nov 2024 10:32:36 +0000 (UTC)
Date: Thu, 21 Nov 2024 10:32:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 12/12] qom: Drop container_get()
Message-ID: <Zz8MQHXdBINd2x4O@redhat.com>
References: <20241120215703.3918445-1-peterx@redhat.com>
 <20241120215703.3918445-13-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241120215703.3918445-13-peterx@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Subject says drop container_get, actual commit does alot more.

Suggest splitting the conversion to (object/machine)_get_container,
from the dropping of container_get.

On Wed, Nov 20, 2024 at 04:57:03PM -0500, Peter Xu wrote:
> Now we should be ready to always create containers upfront, meanwhile we
> have explicit helpers to fetch either:
> 
>   - Root containers (object_get_container()), or
>   - Machine containers (machine_get_container()).
> 
> Change all rest container_get() users to use the explicit & fast version of
> container lookup helpers, finally remove container_get().
> 
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/qom/object.h  | 12 ------------
>  backends/cryptodev.c  |  4 ++--
>  chardev/char.c        |  2 +-
>  hw/core/gpio.c        |  3 +--
>  hw/core/qdev.c        |  3 +--
>  hw/core/sysbus.c      |  4 ++--
>  hw/i386/pc.c          |  4 ++--
>  qom/container.c       | 23 -----------------------
>  qom/object.c          |  2 +-
>  scsi/pr-manager.c     |  4 ++--
>  system/ioport.c       |  2 +-
>  system/memory.c       |  2 +-
>  system/qdev-monitor.c |  6 +++---
>  system/vl.c           |  3 +--
>  ui/dbus-chardev.c     |  2 +-
>  15 files changed, 19 insertions(+), 57 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 87b13f9681..c6e7a7fc08 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -2031,18 +2031,6 @@ int object_child_foreach(Object *obj, int (*fn)(Object *child, void *opaque),
>  int object_child_foreach_recursive(Object *obj,
>                                     int (*fn)(Object *child, void *opaque),
>                                     void *opaque);
> -/**
> - * container_get:
> - * @root: root of the #path, e.g., object_get_root()
> - * @path: path to the container
> - *
> - * Return a container object whose path is @path.  Create more containers
> - * along the path if necessary.
> - *
> - * Returns: the container object.
> - */
> -Object *container_get(Object *root, const char *path);
> -
>  
>  /**
>   * container_create:
> diff --git a/backends/cryptodev.c b/backends/cryptodev.c
> index d8bd2a1ae6..263de4913b 100644
> --- a/backends/cryptodev.c
> +++ b/backends/cryptodev.c
> @@ -97,7 +97,7 @@ static int qmp_query_cryptodev_foreach(Object *obj, void *data)
>  QCryptodevInfoList *qmp_query_cryptodev(Error **errp)
>  {
>      QCryptodevInfoList *list = NULL;
> -    Object *objs = container_get(object_get_root(), "/objects");
> +    Object *objs = object_get_container("objects");
>  
>      object_child_foreach(objs, qmp_query_cryptodev_foreach, &list);
>  
> @@ -557,7 +557,7 @@ static void cryptodev_backend_stats_cb(StatsResultList **result,
>      switch (target) {
>      case STATS_TARGET_CRYPTODEV:
>      {
> -        Object *objs = container_get(object_get_root(), "/objects");
> +        Object *objs = object_get_container("objects");
>          StatsArgs stats_args;
>          stats_args.result.stats = result;
>          stats_args.names = names;
> diff --git a/chardev/char.c b/chardev/char.c
> index a1722aa076..22fc5f7f76 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -48,7 +48,7 @@
>  
>  Object *get_chardevs_root(void)
>  {
> -    return container_get(object_get_root(), "/chardevs");
> +    return object_get_container("chardevs");
>  }
>  
>  static void chr_be_event(Chardev *s, QEMUChrEvent event)
> diff --git a/hw/core/gpio.c b/hw/core/gpio.c
> index 80d07a6ec9..6e32a8eec6 100644
> --- a/hw/core/gpio.c
> +++ b/hw/core/gpio.c
> @@ -121,8 +121,7 @@ void qdev_connect_gpio_out_named(DeviceState *dev, const char *name, int n,
>                                       name ? name : "unnamed-gpio-out", n);
>      if (input_pin && !OBJECT(input_pin)->parent) {
>          /* We need a name for object_property_set_link to work */
> -        object_property_add_child(container_get(qdev_get_machine(),
> -                                                "/unattached"),
> +        object_property_add_child(machine_get_container("unattached"),
>                                    "non-qdev-gpio[*]", OBJECT(input_pin));
>      }
>      object_property_set_link(OBJECT(dev), propname,
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 6cb4fe4691..8051961fe5 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -476,8 +476,7 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
>          if (!obj->parent) {
>              gchar *name = g_strdup_printf("device[%d]", unattached_count++);
>  
> -            object_property_add_child(container_get(qdev_get_machine(),
> -                                                    "/unattached"),
> +            object_property_add_child(machine_get_container("unattached"),
>                                        name, obj);
>              unattached_parent = true;
>              g_free(name);
> diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
> index e64d99c8ed..9355849ff0 100644
> --- a/hw/core/sysbus.c
> +++ b/hw/core/sysbus.c
> @@ -65,9 +65,9 @@ void foreach_dynamic_sysbus_device(FindSysbusDeviceFunc *func, void *opaque)
>      };
>  
>      /* Loop through all sysbus devices that were spawned outside the machine */
> -    container = container_get(qdev_get_machine(), "/peripheral");
> +    container = machine_get_container("peripheral");
>      find_sysbus_device(container, &find);
> -    container = container_get(qdev_get_machine(), "/peripheral-anon");
> +    container = machine_get_container("peripheral-anon");
>      find_sysbus_device(container, &find);
>  }
>  
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 317aaca25a..b8ec2506e1 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -460,7 +460,7 @@ static int check_fdc(Object *obj, void *opaque)
>  }
>  
>  static const char * const fdc_container_path[] = {
> -    "/unattached", "/peripheral", "/peripheral-anon"
> +    "unattached", "peripheral", "peripheral-anon"
>  };
>  
>  /*
> @@ -474,7 +474,7 @@ static ISADevice *pc_find_fdc0(void)
>      CheckFdcState state = { 0 };
>  
>      for (i = 0; i < ARRAY_SIZE(fdc_container_path); i++) {
> -        container = container_get(qdev_get_machine(), fdc_container_path[i]);
> +        container = machine_get_container(fdc_container_path[i]);
>          object_child_foreach(container, check_fdc, &state);
>      }
>  
> diff --git a/qom/container.c b/qom/container.c
> index da657754a4..5e36fb8773 100644
> --- a/qom/container.c
> +++ b/qom/container.c
> @@ -38,27 +38,4 @@ Object *container_create(Object *obj, const char *name)
>      return child;
>  }
>  
> -Object *container_get(Object *root, const char *path)
> -{
> -    Object *obj, *child;
> -    char **parts;
> -    int i;
> -
> -    parts = g_strsplit(path, "/", 0);
> -    assert(parts != NULL && parts[0] != NULL && !parts[0][0]);
> -    obj = root;
> -
> -    for (i = 1; parts[i] != NULL; i++, obj = child) {
> -        child = object_resolve_path_component(obj, parts[i]);
> -        if (!child) {
> -            child = container_create(obj, parts[i]);
> -        }
> -    }
> -
> -    g_strfreev(parts);
> -
> -    return obj;
> -}
> -
> -
>  type_init(container_register_types)
> diff --git a/qom/object.c b/qom/object.c
> index cf66803a6a..aeb04c483c 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1771,7 +1771,7 @@ Object *object_get_root(void)
>  
>  Object *object_get_objects_root(void)
>  {
> -    return container_get(object_get_root(), "/objects");
> +    return object_get_container("objects");
>  }
>  
>  Object *object_get_internal_root(void)
> diff --git a/scsi/pr-manager.c b/scsi/pr-manager.c
> index fb5fc29730..1977d99ce0 100644
> --- a/scsi/pr-manager.c
> +++ b/scsi/pr-manager.c
> @@ -21,7 +21,7 @@
>  #include "qemu/module.h"
>  #include "qapi/qapi-commands-block.h"
>  
> -#define PR_MANAGER_PATH     "/objects"
> +#define PR_MANAGER_PATH     "objects"
>  
>  typedef struct PRManagerData {
>      PRManager *pr_mgr;
> @@ -135,7 +135,7 @@ PRManagerInfoList *qmp_query_pr_managers(Error **errp)
>  {
>      PRManagerInfoList *head = NULL;
>      PRManagerInfoList **prev = &head;
> -    Object *container = container_get(object_get_root(), PR_MANAGER_PATH);
> +    Object *container = object_get_container(PR_MANAGER_PATH);
>  
>      object_child_foreach(container, query_one_pr_manager, &prev);
>      return head;
> diff --git a/system/ioport.c b/system/ioport.c
> index fd551d0375..55c2a75239 100644
> --- a/system/ioport.c
> +++ b/system/ioport.c
> @@ -258,7 +258,7 @@ static void portio_list_add_1(PortioList *piolist,
>      object_ref(&mrpio->mr);
>      object_unparent(OBJECT(&mrpio->mr));
>      if (!piolist->owner) {
> -        owner = container_get(qdev_get_machine(), "/unattached");
> +        owner = machine_get_container("unattached");
>      } else {
>          owner = piolist->owner;
>      }
> diff --git a/system/memory.c b/system/memory.c
> index 85f6834cb3..fba351b030 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -1238,7 +1238,7 @@ static void memory_region_do_init(MemoryRegion *mr,
>          char *name_array = g_strdup_printf("%s[*]", escaped_name);
>  
>          if (!owner) {
> -            owner = container_get(qdev_get_machine(), "/unattached");
> +            owner = machine_get_container("unattached");
>          }
>  
>          object_property_add_child(owner, name_array, OBJECT(mr));
> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> index 4c09b38ffb..4d46af2c8d 100644
> --- a/system/qdev-monitor.c
> +++ b/system/qdev-monitor.c
> @@ -348,7 +348,7 @@ static Object *qdev_get_peripheral(void)
>      static Object *dev;
>  
>      if (dev == NULL) {
> -        dev = container_get(qdev_get_machine(), "/peripheral");
> +        dev = machine_get_container("peripheral");
>      }
>  
>      return dev;
> @@ -359,7 +359,7 @@ static Object *qdev_get_peripheral_anon(void)
>      static Object *dev;
>  
>      if (dev == NULL) {
> -        dev = container_get(qdev_get_machine(), "/peripheral-anon");
> +        dev = machine_get_container("peripheral-anon");
>      }
>  
>      return dev;
> @@ -1085,7 +1085,7 @@ static GSList *qdev_build_hotpluggable_device_list(Object *peripheral)
>  static void peripheral_device_del_completion(ReadLineState *rs,
>                                               const char *str)
>  {
> -    Object *peripheral = container_get(qdev_get_machine(), "/peripheral");
> +    Object *peripheral = machine_get_container("peripheral");
>      GSList *list, *item;
>  
>      list = qdev_build_hotpluggable_device_list(peripheral);
> diff --git a/system/vl.c b/system/vl.c
> index 3bb8f2db9a..822f7ff656 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2120,8 +2120,7 @@ static void qemu_create_machine(QDict *qdict)
>      current_machine = MACHINE(object_new_with_class(OBJECT_CLASS(machine_class)));
>      object_property_add_child(object_get_root(), "machine",
>                                OBJECT(current_machine));
> -    object_property_add_child(container_get(OBJECT(current_machine),
> -                                            "/unattached"),
> +    object_property_add_child(machine_get_container("unattached"),
>                                "sysbus", OBJECT(sysbus_get_default()));
>  
>      if (machine_class->minimum_page_bits) {
> diff --git a/ui/dbus-chardev.c b/ui/dbus-chardev.c
> index 1d3a7122a1..bf061cbc93 100644
> --- a/ui/dbus-chardev.c
> +++ b/ui/dbus-chardev.c
> @@ -106,7 +106,7 @@ dbus_chardev_init(DBusDisplay *dpy)
>      dpy->notifier.notify = dbus_display_on_notify;
>      dbus_display_notifier_add(&dpy->notifier);
>  
> -    object_child_foreach(container_get(object_get_root(), "/chardevs"),
> +    object_child_foreach(object_get_container("chardevs"),
>                           dbus_display_chardev_foreach, dpy);
>  }
>  
> -- 
> 2.45.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


