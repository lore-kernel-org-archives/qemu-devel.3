Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750D4CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 09:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGv1a-0007Ln-8x; Wed, 14 Oct 2026 05:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGv1T-0007Kb-Rf
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:11:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGv1R-0006ng-Sh
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791969096;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9gLbzwI1Lu/Zi+IvM5JoOC2uCiAW/lExdh5ZrKtaIQU=;
 b=PiobNQbmqLiipe5dc5UGMhmVQKqEfdxAoWqyxMcYzWGd5iMs/eXEeEv8A/z7NWzEI7965s
 dz9NqMvdTo2huMSH/+3IQq7U+hK3za0yxzpa78p7sR/6UVaOLvgWysRISLM+FLFR9EeYRO
 nDigAzAyDQut3Vd62OgWz389tF9qVUU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-xhSUhSVaMROanmTz1DBI_g-1; Wed,
 14 Oct 2026 09:11:33 +0000
X-MC-Unique: xhSUhSVaMROanmTz1DBI_g-1
X-Mimecast-MFC-AGG-ID: xhSUhSVaMROanmTz1DBI_g_1791969092
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71CA219560AB; Wed, 14 Oct 2026 09:11:32 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 39434195608E; Wed, 14 Oct 2026 09:11:31 +0000 (UTC)
Date: Wed, 14 Oct 2026 10:11:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] qom: deprecate use of instance level properties
Message-ID: <as9HQCmHipYncIpq@redhat.com>
References: <20261013120638.855671-1-berrange@redhat.com>
 <cd31fd3b-5b54-431e-971b-ee9a680a8c40@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd31fd3b-5b54-431e-971b-ee9a680a8c40@nutanix.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.0 on 127.0.0.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Wed, Oct 14, 2026 at 10:05:01AM +0100, Mark Cave-Ayland wrote:
> On 13/10/2026 13:06, Daniel P. Berrangé wrote:
> 
> > Add API docs to object_property_(add/try_add/del) to recommend
> > use of class properties instead.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   include/qom/object.h | 25 ++++++++++++++++++++++---
> >   1 file changed, 22 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/qom/object.h b/include/qom/object.h
> > index 4c0645817a5..d3fddb449f5 100644
> > --- a/include/qom/object.h
> > +++ b/include/qom/object.h
> > @@ -1171,6 +1171,16 @@ void object_unref(void *obj);
> >    * @opaque: an opaque pointer to pass to the callbacks for the property
> >    * @errp: pointer to error object
> >    *
> > + * Further use of this method is deprecated. Properties for an
> > + * object should be statically declared against the class, and
> > + * not be permitted to vary at runtime. Use the
> > + * object_class_property_add() method (and its variants) instead.
> > + *
> > + * If usage scenarios require differing subsets of properties
> > + * to be present, this should be handled by creating further
> > + * specialized subclasses instead of dynamically registering
> > + * properties against instances.
> > + *
> >    * Returns: The #ObjectProperty; this can be used to set the @resolve
> >    * callback for child and link properties.
> >    */
> > @@ -1183,9 +1193,6 @@ ObjectProperty *object_property_try_add(Object *obj, const char *name,
> >   /**
> >    * object_property_add:
> > - * Same as object_property_try_add() with @errp hardcoded to
> > - * &error_abort.
> > - *
> >    * @obj: the object to add a property to
> >    * @name: the name of the property.  This can contain any character except for
> >    *  a forward slash.  In general, you should use hyphens '-' instead of
> > @@ -1202,6 +1209,12 @@ ObjectProperty *object_property_try_add(Object *obj, const char *name,
> >    *   meant to allow a property to free its opaque upon object
> >    *   destruction.  This may be NULL.
> >    * @opaque: an opaque pointer to pass to the callbacks for the property
> > + *
> > + * Same as object_property_try_add() with @errp hardcoded to
> > + * &error_abort.
> > + *
> > + * Further use of this method is deprecated, see
> > + * object_property_try_add() for details.
> >    */
> >   ObjectProperty *object_property_add(Object *obj, const char *name,
> >                                       const char *type,
> > @@ -1210,6 +1223,12 @@ ObjectProperty *object_property_add(Object *obj, const char *name,
> >                                       ObjectPropertyRelease *release,
> >                                       void *opaque);
> > +/**
> > + * object_property_del:
> > + *
> > + * Further use of this method is deprecated, see
> > + * object_property_try_add() for details.
> > + */
> >   void object_property_del(Object *obj, const char *name);
> >   ObjectProperty *object_class_property_add(ObjectClass *klass, const char *name,
> 
> Looks good to me, and at least it means LLMs should pick up the recommended
> usage going forward. Do we also want to update checkpatch.pl to emit a
> warning if someone uses these legacy functions so that it gets flagged
> during local testing/CI too?

As long as we have piles of code still using the old instance level
APIs remaining to be converted, I think a checkpatch test will be
too annoying.

> Anyhow:
> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


