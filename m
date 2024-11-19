Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D00D62060
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 10:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDL5B-0004vX-Qk; Tue, 19 Nov 2024 05:03:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tDL58-0004v6-L1
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 05:03:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tDL55-00073x-Sh
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 05:03:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732010614;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=+2WfRg8Dh13SOa3rwlqa6ItDiMr6SUZcHXcYex2L5Hk=;
 b=UjxO5bthXaq7Ac8yeuBt8xfm9pO9J59VJLx9dObIjDt0rotcvyB3wMV2UFI3rxd6Z3V7ma
 SRbslsl6N9rFnPgcsL4XtPZtplAzPnEFu5x+0p0qSuY0yh1GC1uEi4eeRujS9T0xuv+c0i
 b2T4NonGEcd/TKJGs4gI9dtJSmbImsk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-389-jTw4AIadOzirXuGeupyBbg-1; Tue,
 19 Nov 2024 05:03:30 -0500
X-MC-Unique: jTw4AIadOzirXuGeupyBbg-1
X-Mimecast-MFC-AGG-ID: jTw4AIadOzirXuGeupyBbg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9402919560AF; Tue, 19 Nov 2024 10:03:29 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.110])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3FBCE1956086; Tue, 19 Nov 2024 10:03:25 +0000 (UTC)
Date: Tue, 19 Nov 2024 10:03:22 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 5/5] qom: Make container_get() strict to always walk or
 return container
Message-ID: <ZzxianGKK71p0yA1@redhat.com>
References: <20241118221330.3480246-1-peterx@redhat.com>
 <20241118221330.3480246-6-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241118221330.3480246-6-peterx@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Mon, Nov 18, 2024 at 05:13:30PM -0500, Peter Xu wrote:
> When used incorrectly, container_get() can silently create containers even
> if the caller may not intend to do so.  Add a rich document describing the
> helper, as container_get() should only be used in path lookups.
> 
> Add one object_dynamic_cast() check to make sure whatever objects the
> helper walks will be a container object (including the one to be returned).
> It is a programming error otherwise, hence assert that.
> 
> It may make container_get() tiny slower than before, but the hope is the
> change is neglictable, as object_class_dynamic_cast() has a fast path just
> for similar leaf use case.
> 
> Link: https://lore.kernel.org/r/87pln6ds8q.fsf@pond.sub.org
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  qom/container.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/qom/container.c b/qom/container.c
> index cfec92a944..ff6e35f837 100644
> --- a/qom/container.c
> +++ b/qom/container.c
> @@ -24,6 +24,20 @@ static void container_register_types(void)
>      type_register_static(&container_info);
>  }
>  
> +/**
> + * container_get(): Get the container object under specific path
> + *
> + * @root: The root path object to start walking from.  When starting from
> + *        root, one can pass in object_get_root().
> + * @path: The sub-path to lookup, must be an non-empty string starts with "/".
> + *
> + * Returns: The container object specified by @path.
> + *
> + * NOTE: the function may impplicitly create internal containers when the
> + * whole path is not yet created.  It's the caller's responsibility to make
> + * sure the path specified is always used as object containers, rather than
> + * any other type of objects.
> + */

The docs are a welcome addition, but at the same time the docs won't get
read most of the time.

With this in mind, IMHO, it is a conceptually *terrible* design for us to
have a method called "get" which magically *creates* stuff as a side-effect
of its calling. We'd be well served by fixing that design problem.

If I look in the code at what calls we have to container_get, and more
specifically what "path" values we pass, there are not actually that many:

  /objects
  /chardevs
  /unattached
  /machine
  /peripheral
  /peripheral-anon
  /backend
  /dr-connector
  

Ignoring the last one, those other 7 containers are things we expect
to exist in *every* system emulator.

Second, every single one of them is a single level deep. IOW, the for()
loop in container_get is effectively pointless.

We can fix this by having a single method:

 void container_create_builtin(Object *root)

which creates the 7 built-in standard containers we expect
everywhere, with open coded object_new + add_child calls. 

Then all current users of container_get() can switch over
to object_resolve_path, and container_get() can be eliminated.

The 'dr-connector' creation can just be open-coded using
object_new() in the spapr code.

>  Object *container_get(Object *root, const char *path)
>  {
>      Object *obj, *child;
> @@ -31,6 +45,7 @@ Object *container_get(Object *root, const char *path)
>      int i;
>  
>      parts = g_strsplit(path, "/", 0);
> +    /* "path" must be an non-empty string starting with "/" */
>      assert(parts != NULL && parts[0] != NULL && !parts[0][0]);
>      obj = root;
>  
> @@ -40,6 +55,12 @@ Object *container_get(Object *root, const char *path)
>              child = object_new(TYPE_CONTAINER);
>              object_property_add_child(obj, parts[i], child);
>              object_unref(child);
> +        } else {
> +            /*
> +             * Each object within the path must be a container object
> +             * itself, including the object to be returned.
> +             */
> +            assert(object_dynamic_cast(child, TYPE_CONTAINER));
>          }
>      }
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


