Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE810D0C5F8
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 09:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Gyr-0006IO-8L; Fri, 25 Oct 2024 05:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t4Gyp-0006I7-Cq
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 05:51:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t4Gyn-0005O3-6e
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 05:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729849895;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=gfCI+jBoKgZoxOzjfirNXbWX+PJWDpumJDC27cv25gs=;
 b=HFQ/w2aOnx9A725aCp1qp+ZRLnOAkNO5DQXZun6uyfKDsNoMgbUBf9w8NlCDZH0N9Tths7
 GELfsaCXVhrP8yjxPTFKT4sDm9Hc+l/HsT7hae5n76FM1UugPWHwbsynubZlU0p2wtEIRJ
 D0REcUld/DlMAsAxHF+6gF15TcEg27M=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-bHhSfcOKP8OFtB9bwriiHw-1; Fri,
 25 Oct 2024 05:51:32 -0400
X-MC-Unique: bHhSfcOKP8OFtB9bwriiHw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 397851955E70; Fri, 25 Oct 2024 09:51:31 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.164])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C8653196BBC1; Fri, 25 Oct 2024 09:51:25 +0000 (UTC)
Date: Fri, 25 Oct 2024 10:51:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Igor Mammedov <imammedo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/4] qom: TYPE_SINGLETON interface
Message-ID: <ZxtqGQbd4Hq4APtm@redhat.com>
References: <20241024165627.1372621-1-peterx@redhat.com>
 <20241024165627.1372621-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241024165627.1372621-2-peterx@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Oct 24, 2024 at 12:56:24PM -0400, Peter Xu wrote:

Adding significant new functionality to QOM should really come
with a commit message explaining the rationale and the design
choices

> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/qom/object_interfaces.h | 47 +++++++++++++++++++++++++++++++++
>  qom/object.c                    |  3 +++
>  qom/object_interfaces.c         | 24 +++++++++++++++++
>  qom/qom-qmp-cmds.c              | 22 ++++++++++++---
>  system/qdev-monitor.c           |  7 +++++
>  5 files changed, 100 insertions(+), 3 deletions(-)

snip

> + * Singleton class describes the type of object classes that can only
> + * provide one instance for the whole lifecycle of QEMU.  It will fail the
> + * operation if one attemps to create more than one instance.
> + *
> + * One can fetch the single object using class's get_instance() callback if
> + * it was created before.  This can be useful for operations like QMP
> + * qom-list-properties, where dynamically creating an object might not be
> + * feasible.

snip

> +/**
> + * singleton_get_instance:
> + *
> + * @class: the class to fetch singleton instance
> + *
> + * Returns: the object* if the class is a singleton class and the singleton
> + *          object is created, NULL otherwise.
> + */
> +Object *singleton_get_instance(ObjectClass *class);

With this design, all code that uses a given type needs to know
whether or not it is intended to be a singleton. If some code
somewhere mistakenly calls 'object_new' instead of 'singleton_get_instance',
the singleton type  is no longer a singleton, except you handle this by
adding an assert in object_initialize_with_type.

This is still a bit of a loaded foot-gun IMHO, as we don't want random
code asserting.

> diff --git a/qom/object.c b/qom/object.c
> index 11424cf471..ded299ae1a 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -553,6 +553,9 @@ static void object_initialize_with_type(Object *obj, size_t size, TypeImpl *type
>      g_assert(type->abstract == false);
>      g_assert(size >= type->instance_size);
>  
> +    /* Singleton class can only create one object */
> +    g_assert(!singleton_get_instance(type->class));
> +
>      memset(obj, 0, type->instance_size);
>      obj->class = type->class;
>      object_ref(obj);

> diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
> index e91a235347..ecc1cf781c 100644
> --- a/qom/qom-qmp-cmds.c
> +++ b/qom/qom-qmp-cmds.c
> @@ -126,6 +126,7 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
>      ObjectProperty *prop;
>      ObjectPropertyIterator iter;
>      ObjectPropertyInfoList *prop_list = NULL;
> +    bool create;
>  
>      klass = module_object_class_by_name(typename);
>      if (klass == NULL) {
> @@ -141,7 +142,15 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
>          return NULL;
>      }
>  
> -    obj = object_new(typename);
> +    /* Avoid creating multiple instances if the class is a singleton */
> +    create = !object_class_is_singleton(klass) ||
> +        !singleton_get_instance(klass);
> +
> +    if (create) {
> +        obj = object_new(typename);
> +    } else {
> +        obj = singleton_get_instance(klass);
> +    }

This is the first foot-gun example.

I really strongly dislike that the design pattern forces us to
create code like this, as we can never be confident we've
correctly identified all the places which may call object_new
on a singleton...

> @@ -172,7 +181,9 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
>          QAPI_LIST_PREPEND(prop_list, info);
>      }
>  
> -    object_unref(obj);
> +    if (create) {
> +        object_unref(obj);
> +    }

...and this just compounds the ugliness.

> @@ -199,7 +210,12 @@ ObjectPropertyInfoList *qmp_qom_list_properties(const char *typename,
>          return NULL;
>      }
>  
> -    if (object_class_is_abstract(klass)) {
> +    /*
> +     * Abstract classes are not for instantiations, meanwhile avoid
> +     * creating temporary singleton objects because it can cause conflicts
> +     * if there's already one created.
> +     */

Another example of the foot-gun firing at random code

> +    if (object_class_is_abstract(klass) || object_class_is_singleton(klass)) {
>          object_class_property_iter_init(&iter, klass);
>      } else {
>          obj = object_new(typename);


With changes to QOM, I think it is generally informative to look at how
GLib has handled the problem, since the QOM design has heavily borrowed
from its GObject design.

In GObject, singletons are handled in a very differnt way. It has a
concept of a "constructor" function against the class, which is what is
responsible for allocating the object. By default the 'constructor' will
call g_new0, but a class which wishes to become a singleton will override
the 'constructor' function to allocate on first call, and return the
cached object on subsequent calls. This is illustrated here:

  https://gitlab.gnome.org/GNOME/glib/-/blob/main/gobject/gobject.h#L297

The key benefit of this is that everything can carry on calling
g_object_new() as before, as it will just "do the right thing"
in terms of allocation.

In QOM, we don't have a 'constructor' class function, we just directly
call g_malloc from object_new_with_type. This is because at the time,
we didn't see an immediate need for it. We could easily change that
though to introduce the concept of a 'constructor', which could
probably make singletons work without needing updates to existing code.



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


