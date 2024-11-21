Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A7CD78788
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 16:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE9sp-00086x-Qd; Thu, 21 Nov 2024 11:18:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tE9so-00086p-Ud
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 11:18:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tE9sm-0000Te-HV
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 11:18:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732205892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uyUfNem2He+uAF6rY3d+bjo2GzUi5h5iaU0eH6cqmyI=;
 b=JQybBG+A577eRoPdumhijWFatOKoJ/y4HUUpj4JLxZqA8RzfewnO/pXgrJBNlbBmWAwxhq
 wwlDOWwQ0+aObL/5Tl3JsSa4GBxIaAGCWWSGXnGVZlTLIJS+Via3l7u0S37IlPt3cLc3Vp
 IUhQy0se5AnpBqJqRAhPwDV1gdq/OMk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-2c8mnebhMS210VUt6EyeJA-1; Thu, 21 Nov 2024 11:18:09 -0500
X-MC-Unique: 2c8mnebhMS210VUt6EyeJA-1
X-Mimecast-MFC-AGG-ID: 2c8mnebhMS210VUt6EyeJA
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6d41020511cso13941226d6.2
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 08:18:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732205889; x=1732810689;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uyUfNem2He+uAF6rY3d+bjo2GzUi5h5iaU0eH6cqmyI=;
 b=VeKFzXaUti1PAe5elqd5hRlb53IUeszd+IdZcqhleu21lP/ZTzMXVNp8ZD16QbVr0z
 odtwITphFfP2pdmRnC2w4K0xgDAlJt+qK7woI5z4qwQRRyTrQhalzychZH3hjRInYQ2r
 gld5KnzPHzTmcfyIbULjZEJWmimcu9u0YJE/28wXm71efm7qCRZ3hW7AEM5Hvb/ZM/rG
 /YcNPWXBPsGFmT2WWJUg3vcClLUpkP45LvUh45sxBVFHkRa+3kcLrE50SzI96AcH3hmE
 bp6g/yIYVjAzpie9Br+AQc66jS33WwxC49o4mBQIgsHAvEgDkP4MSjTLXcS+1aC8n7jY
 9G9g==
X-Gm-Message-State: AOJu0Yx9BtOgwrFGSXluulIn82NSApXDfeKVHc0RYhcbk6SfzSjIdASs
 c+tNZygmmDQJ/Q5t1agDdWm81SYmCtIBrkFVDkkC3IuLiEkHAY8pi7g8hv3vtUVzR8ZHda6Epjn
 HZe+yMo2wjSlPtyzBpC9P6lHFw8whm/3jtociphd3o2ozBqtHcYUS
X-Gm-Gg: ASbGnctOuxRucZkzy2WYBF8pH+CxLad7ebEnA+/F/Lurr+r4YHpcrrJzLh1f/3EXPiy
 u7cbIwrIn/JWLLDl/EhRwLLO9eigYFGCXMYWME6AxKne0l/cgS46RTo2CwTJP363lPuhL4RfDD8
 x+gh/vn9qSk9LRZfWzJhVkC/N01vl9XRJ7AVsni3UptbN+b3H+XxYfcausLnLbZ06z/1wvheM9T
 hlr0jalLUsKUDyPLifuAtUWHcc1T6wSPlw738LuuRSsJYdsdfOrLgg7/kDxNqaPaX6iFPgG1kgu
 NkDwio0kIhM=
X-Received: by 2002:a05:6214:20ea:b0:6d3:9da1:d416 with SMTP id
 6a1803df08f44-6d4377a2831mr91156526d6.20.1732205888993; 
 Thu, 21 Nov 2024 08:18:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFf+w5bhvR2f5gZmPx5EFMbBySM95Ln/nevqMeQe8DgvMmJ+Fk18vrcs06Ma4xtQZKvVi2bw==
X-Received: by 2002:a05:6214:20ea:b0:6d3:9da1:d416 with SMTP id
 6a1803df08f44-6d4377a2831mr91156096d6.20.1732205888653; 
 Thu, 21 Nov 2024 08:18:08 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d43812ab06sm25216696d6.96.2024.11.21.08.18.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 08:18:08 -0800 (PST)
Date: Thu, 21 Nov 2024 11:18:05 -0500
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 02/12] qom: New container_create()
Message-ID: <Zz9dPefajA8aOtAN@x1n>
References: <20241120215703.3918445-1-peterx@redhat.com>
 <20241120215703.3918445-3-peterx@redhat.com>
 <87ttc0iuz7.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ttc0iuz7.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Nov 21, 2024 at 02:20:44PM +0100, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > To move towards explicit creations of containers, starting that by
> > providing a helper for creating container objects.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/qom/object.h | 12 ++++++++++++
> >  qom/container.c      | 18 +++++++++++++++---
> >  2 files changed, 27 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/qom/object.h b/include/qom/object.h
> > index 3ba370ce9b..41ef53241e 100644
> > --- a/include/qom/object.h
> > +++ b/include/qom/object.h
> > @@ -2033,6 +2033,18 @@ int object_child_foreach_recursive(Object *obj,
> >   */
> >  Object *container_get(Object *root, const char *path);
> >  
> > +
> > +/**
> > + * container_create:
> > + * @root: root of the object to create the new container
> > + * @name: name of the new container
> 
> Is this the name of the property of @root to hold the new container?
> Peeking ahead to the implementation... yes.
> 
> > + *
> > + * Create a container object under @root with @name.
> > + *
> > + * Returns: the newly created container object.
> > + */
> > +Object *container_create(Object *root, const char *name);
> 
> No function in this file is named like FOO_create().  Hmm.
> 
> Compare:
> 
>    /**
>     * object_property_try_add_child:
>     * @obj: the object to add a property to
>     * @name: the name of the property
>     * @child: the child object
>     * @errp: pointer to error object
>     *
>     * Child properties form the composition tree.  All objects need to be a child
>     * of another object.  Objects can only be a child of one object.
>     *
>     * There is no way for a child to determine what its parent is.  It is not
>     * a bidirectional relationship.  This is by design.
> 
> Aside: this is nonsense.  While you're not supposed to simply use
> obj->parent (it's documented as private), you can still get the child's
> canonical path with object_get_canonical_path(), split off its last
> component to get the parent's canonical path, then use
> object_resolve_path() to get the parent.
> 
>     *
>     * The value of a child property as a C string will be the child object's
>     * canonical path. It can be retrieved using object_property_get_str().
>     * The child object itself can be retrieved using object_property_get_link().
>     *
>     * Returns: The newly added property on success, or %NULL on failure.
>     */
> 
> What about
> 
>    /**
>     * object_property_add_new_container:
>     * @obj: the parent object
>     * @name: the name of the parent object's property to add
>     *
>     * Add a newly created container object to a parent object.
>     *
>     * Returns: the newly created container object.  Its reference count
>     * is 1, and the reference is owned by the parent object.
>     */

Sure, this may indeed align better with the rest function names.

> 
> > +
> >  /**
> >   * object_property_help:
> >   * @name: the name of the property
> > diff --git a/qom/container.c b/qom/container.c
> > index cfec92a944..da657754a4 100644
> > --- a/qom/container.c
> > +++ b/qom/container.c
> > @@ -24,6 +24,20 @@ static void container_register_types(void)
> >      type_register_static(&container_info);
> >  }
> >  
> > +Object *container_create(Object *obj, const char *name)
> > +{
> > +    Object *child = object_new(TYPE_CONTAINER);
> > +
> > +    object_property_add_child(obj, name, child);
> > +    /*
> > +     * Simplify the caller by always drop the refcount directly here, as
> > +     * containers are normally never destroyed after created anyway.
> > +     */
> > +    object_unref(child);
> 
> Do we still need the comment if we document the reference count in the
> function comment?

Probably not.  I'll drop this comment while taking above suggestion.

Thanks,

-- 
Peter Xu


