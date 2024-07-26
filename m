Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02FFC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 16:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXO1w-0004ec-QW; Fri, 26 Jul 2024 12:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sXO1u-0004dO-2r
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 12:42:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sXO1s-0004wC-4g
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 12:42:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722012169;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jSLq9mXWbxSlzwtjxIuN9eakWh9iVLVwWwm2qnOfpKk=;
 b=CnsSXm/ILwSNOwtgfXM/wCgTkw6qQe1iwpV7rTrb8OHEVCBcfSsuYxtGC1i000plAxYNNr
 VaVetxrnJbt4Mfrpm/SyzXOGt8RsmynbRr4O7otSxp6XxP94TVgfHGzCmU9u9QMgbFNyVS
 vbMFhSv8U6WGhLtfkuqrwy/s1fzbPUc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-260-4RtUA3oGN16DTgc8Ny_jcg-1; Fri,
 26 Jul 2024 12:42:45 -0400
X-MC-Unique: 4RtUA3oGN16DTgc8Ny_jcg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73A6B1955D4A; Fri, 26 Jul 2024 16:42:44 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.32])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3D6419560AE; Fri, 26 Jul 2024 16:42:40 +0000 (UTC)
Date: Fri, 26 Jul 2024 17:42:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 1/2] qom/object, qdev: move globals functions to
 object.c
Message-ID: <ZqPR_dFL5O6IFHlk@redhat.com>
References: <20240703204149.1957136-1-dbarboza@ventanamicro.com>
 <20240703204149.1957136-2-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240703204149.1957136-2-dbarboza@ventanamicro.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

CC: Markus since he's had opinions on stuff related to -global  in
the past.

On Wed, Jul 03, 2024 at 05:41:48PM -0300, Daniel Henrique Barboza wrote:
> Next patch will add Accel globals support. This means that globals won't be
> qdev exclusive logic since it'll have to deal with TYPE_ACCEL objects.
> 
> Move all globals related functions and declarations to object.c. Each
> function is renamed from 'qdev_' to 'object_':
> 
> - qdev_prop_register_global() is now object_prop_register_global()
> - qdev_find_global_prop() is now object_find_global_prop()
> - qdev_prop_check_globals() is now object_prop_check_globals()
> - qdev_prop_set_globals() is now object_prop_set_globals()
> 
> For object_prop_set_globals() an additional change was made: the function
> was hardwired to be used with DeviceState, where dev->hotplugged is checked
> to determine if object_apply_global_props() will receive a NULL or an
> &error_fatal errp. The function now receives an Object and an errp, and
> logic using dev->hotplugged is moved to its caller (device_post_init()).
> 
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  hw/core/cpu-common.c                |  2 +-
>  hw/core/qdev-properties-system.c    |  2 +-
>  hw/core/qdev-properties.c           | 71 -----------------------------
>  hw/core/qdev.c                      |  2 +-
>  include/hw/qdev-core.h              | 27 -----------
>  include/hw/qdev-properties.h        |  5 --
>  include/qom/object.h                | 34 ++++++++++++++
>  qom/object.c                        | 70 ++++++++++++++++++++++++++++
>  system/vl.c                         |  6 +--
>  target/i386/cpu.c                   |  2 +-
>  target/sparc/cpu.c                  |  2 +-
>  tests/unit/test-qdev-global-props.c |  4 +-
>  12 files changed, 114 insertions(+), 113 deletions(-)
> 
> diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
> index f131cde2c0..794b18f7c5 100644
> --- a/hw/core/cpu-common.c
> +++ b/hw/core/cpu-common.c
> @@ -182,7 +182,7 @@ static void cpu_common_parse_features(const char *typename, char *features,
>              prop->driver = typename;
>              prop->property = g_strdup(featurestr);
>              prop->value = g_strdup(val);
> -            qdev_prop_register_global(prop);
> +            object_prop_register_global(prop);
>          } else {
>              error_setg(errp, "Expected key=value format, found %s.",
>                         featurestr);
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
> index f13350b4fb..5d30ee6257 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -41,7 +41,7 @@ static bool check_prop_still_unset(Object *obj, const char *name,
>                                     const void *old_val, const char *new_val,
>                                     bool allow_override, Error **errp)
>  {
> -    const GlobalProperty *prop = qdev_find_global_prop(obj, name);
> +    const GlobalProperty *prop = object_find_global_prop(obj, name);
>  
>      if (!old_val || (!prop && allow_override)) {
>          return true;
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 86a583574d..9cba33c311 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -855,77 +855,6 @@ void qdev_prop_set_array(DeviceState *dev, const char *name, QList *values)
>      qobject_unref(values);
>  }
>  
> -static GPtrArray *global_props(void)
> -{
> -    static GPtrArray *gp;
> -
> -    if (!gp) {
> -        gp = g_ptr_array_new();
> -    }
> -
> -    return gp;
> -}
> -
> -void qdev_prop_register_global(GlobalProperty *prop)
> -{
> -    g_ptr_array_add(global_props(), prop);
> -}
> -
> -const GlobalProperty *qdev_find_global_prop(Object *obj,
> -                                            const char *name)
> -{
> -    GPtrArray *props = global_props();
> -    const GlobalProperty *p;
> -    int i;
> -
> -    for (i = 0; i < props->len; i++) {
> -        p = g_ptr_array_index(props, i);
> -        if (object_dynamic_cast(obj, p->driver)
> -            && !strcmp(p->property, name)) {
> -            return p;
> -        }
> -    }
> -    return NULL;
> -}
> -
> -int qdev_prop_check_globals(void)
> -{
> -    int i, ret = 0;
> -
> -    for (i = 0; i < global_props()->len; i++) {
> -        GlobalProperty *prop;
> -        ObjectClass *oc;
> -        DeviceClass *dc;
> -
> -        prop = g_ptr_array_index(global_props(), i);
> -        if (prop->used) {
> -            continue;
> -        }
> -        oc = object_class_by_name(prop->driver);
> -        oc = object_class_dynamic_cast(oc, TYPE_DEVICE);
> -        if (!oc) {
> -            warn_report("global %s.%s has invalid class name",
> -                        prop->driver, prop->property);
> -            ret = 1;
> -            continue;
> -        }
> -        dc = DEVICE_CLASS(oc);
> -        if (!dc->hotpluggable && !prop->used) {
> -            warn_report("global %s.%s=%s not used",
> -                        prop->driver, prop->property, prop->value);
> -            ret = 1;
> -            continue;
> -        }
> -    }
> -    return ret;
> -}
> -
> -void qdev_prop_set_globals(DeviceState *dev)
> -{
> -    object_apply_global_props(OBJECT(dev), global_props(),
> -                              dev->hotplugged ? NULL : &error_fatal);
> -}
> -
>  /* --- 64bit unsigned int 'size' type --- */
>  
>  static void get_size(Object *obj, Visitor *v, const char *name, void *opaque,
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index f3a996f57d..894372b776 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -673,7 +673,7 @@ static void device_post_init(Object *obj)
>       * precedence.
>       */
>      object_apply_compat_props(obj);
> -    qdev_prop_set_globals(DEVICE(obj));
> +    object_prop_set_globals(obj, DEVICE(obj)->hotplugged ? NULL : &error_fatal);
>  }

This is pretty awkward :-(

If we're generalizing this global properties concept, then we want
object_prop_set_globals to be called from the Object base class
code. We can't do that given this need to check the 'hotplugged'
property.

That check, however, is total insanity. Pre-existing problem,
not your fault.

I imagine the rationale is that we don't want to kill QEMU
if setting a global fails, and we're in middle of device_add
on a running VM.

Throwing away errors though is unacceptable IMHO. device_add
can report errors and we should be propagating them. Likewise
for object_add, or any object HMP command creating QOM types.

The trouble is that we're about 4-5 levels deep in a call
chain that lacks "Error **errp".

The root problem is that none of object_new, object_new_with_class
and object_new_with_type have a "Error *errp" parameter.

object_new_with_props and object_new_with_propv both *do* have
a "Error *errp" parameter, but then they call into object_new_with_type
and can't get errors back from that.

IMHO we need to fix this inability to report errors from object
construction. It will certainly be a painful refactoring job,
but I think its neccessary in order to support global props
without this horrible hack checking the "hotpluggable" flag.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


