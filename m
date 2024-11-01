Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF7F6E6B243
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 11:30:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6pqP-0007Fu-Vt; Fri, 01 Nov 2024 07:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t6pqK-0007F2-P2
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 07:29:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t6pqI-0006Xg-3k
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 07:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730460564;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mS0yXZLJYIiXaDSK8ovZQB8pm1Wza6pMwJb1SCDp7Sg=;
 b=WyCkYCKDjxJUnt1uMI6LfaMK9PTrhLg1JW2QKVBPr9hvNNOc50TKQM4OQhbk7Lj1E3c4v9
 6d2fTtr5GJZ4dGYwa1GpUP1FJkATbN63zP0nS2dZl0ziQF2oyEyCGlaLro000iMpxjxJ1X
 zhxNdSkI71K4han/QIskFQGLy/hdBI8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-AeT49RICO3uUtPVCl-4pgA-1; Fri,
 01 Nov 2024 07:29:23 -0400
X-MC-Unique: AeT49RICO3uUtPVCl-4pgA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F10319560A5
 for <qemu-devel@nongnu.org>; Fri,  1 Nov 2024 11:29:22 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.145])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3406D1956052; Fri,  1 Nov 2024 11:29:20 +0000 (UTC)
Date: Fri, 1 Nov 2024 11:29:17 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC 2/5] qom: allow failure of object_new_with_class
Message-ID: <ZyS7jQ1L2KAzVmdj@redhat.com>
References: <20241031155350.3240361-1-berrange@redhat.com>
 <20241031155350.3240361-3-berrange@redhat.com>
 <ZyPV9M2KGY5qsd9g@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZyPV9M2KGY5qsd9g@x1n>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Oct 31, 2024 at 03:09:40PM -0400, Peter Xu wrote:
> On Thu, Oct 31, 2024 at 03:53:47PM +0000, Daniel P. Berrangé wrote:
> > Since object_new_with_class() accepts a non-const parameter for
> > the class, callers should be prepared for failures from unexpected
> > input. Add an Error parameter for this and make callers check.
> > If the caller does not already have an Error parameter, it is
> > satisfactory to use &error_abort if the class parameter choice is
> > not driven by untrusted user input.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  accel/accel-user.c               |  3 ++-
> >  include/qom/object.h             |  9 +++++++--
> >  net/net.c                        | 10 ++++++----
> >  qom/object.c                     |  4 ++--
> >  system/vl.c                      |  6 ++++--
> >  target/i386/cpu-apic.c           |  8 +++++++-
> >  target/i386/cpu-sysemu.c         | 11 ++++++++---
> >  target/i386/cpu.c                |  4 ++--
> >  target/s390x/cpu_models_sysemu.c |  7 +++++--
> >  9 files changed, 43 insertions(+), 19 deletions(-)
> > 
> > diff --git a/accel/accel-user.c b/accel/accel-user.c
> > index 22b6a1a1a8..04ba4ab920 100644
> > --- a/accel/accel-user.c
> > +++ b/accel/accel-user.c
> > @@ -18,7 +18,8 @@ AccelState *current_accel(void)
> >          AccelClass *ac = accel_find("tcg");
> >  
> >          g_assert(ac != NULL);
> > -        accel = ACCEL(object_new_with_class(OBJECT_CLASS(ac)));
> > +        accel = ACCEL(object_new_with_class(OBJECT_CLASS(ac),
> > +                                            &error_abort));
> >      }
> >      return accel;
> >  }
> > diff --git a/include/qom/object.h b/include/qom/object.h
> > index 2af9854675..222c60e205 100644
> > --- a/include/qom/object.h
> > +++ b/include/qom/object.h
> > @@ -606,14 +606,19 @@ struct InterfaceClass
> >  /**
> >   * object_new_with_class:
> >   * @klass: The class to instantiate.
> > + * @errp: pointer to be filled with error details on failure
> >   *
> >   * This function will initialize a new object using heap allocated memory.
> >   * The returned object has a reference count of 1, and will be freed when
> >   * the last reference is dropped.
> >   *
> > - * Returns: The newly allocated and instantiated object.
> > + * If an instance of @klass is not permitted to be instantiated, an
> > + * error will be raised. This can happen if @klass is abstract.
> > + *
> > + * Returns: The newly allocated and instantiated object, or NULL
> > + * on error.
> >   */
> > -Object *object_new_with_class(ObjectClass *klass);
> > +Object *object_new_with_class(ObjectClass *klass, Error **errp);
> >  
> >  /**
> >   * object_new:
> > diff --git a/net/net.c b/net/net.c
> > index d9b23a8f8c..7fb5e966f3 100644
> > --- a/net/net.c
> > +++ b/net/net.c
> > @@ -944,11 +944,13 @@ GPtrArray *qemu_get_nic_models(const char *device_type)
> >               * create this property during instance_init, so we have to create
> >               * a temporary instance here to be able to check it.
> >               */
> > -            Object *obj = object_new_with_class(OBJECT_CLASS(dc));
> > -            if (object_property_find(obj, "netdev")) {
> > -                g_ptr_array_add(nic_models, (gpointer)name);
> > +            Object *obj = object_new_with_class(OBJECT_CLASS(dc), NULL);
> 
> One trivial comment: I kind of understand why NULL was chosen, but I don't
> think it's easily understandable on why it's better.
> 
> When object_new() can have side effect and might fail, logically it could
> be better that it asserts failure here when new NICs added (that can start
> to fail it here.. while we shouldn't have such now), instead of silently
> not showing up in the module list.  So at least we notify the net developer
> something might be off (while IIUC this function is trying to list all NIC
> modules QEMU supports).

This change is a mistake. This commit ought to be keeping failure
behaviour broadly the same, just pushing error handling up a level.
So from that POV, I should have used &error_abort here.

Any relaxation of error handling to be more graceful here ought
to be a separately justified commit.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


