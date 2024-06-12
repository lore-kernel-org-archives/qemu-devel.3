Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A629FC27C7B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 11:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHM6N-0007pQ-Eb; Wed, 12 Jun 2024 07:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHM6J-0007ol-Mt
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 07:25:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHM6H-00071u-Ep
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 07:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718191508;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=oJpK17ekPHy/08AgdBkFlqxStkcVYvPDXzQ7uyyl7Xw=;
 b=HBzTA+4noVFUmJp1/XRCCFg6PGVCD/pqwp/dIosVbYA30GIL7iuf5+jbK8iq9gnApnYslR
 q07b78dnovxiREXzfqJH9yOEW3m6oDwOh0j95rXUxXQ74wqFwpU8HZFE1FPP9zVYYsKy8p
 V+nhY2jwwhNXP8Wd7EUVe+K0mnQlRds=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-HLTSDRGLMJaIem5wJs7y4Q-1; Wed,
 12 Jun 2024 07:25:05 -0400
X-MC-Unique: HLTSDRGLMJaIem5wJs7y4Q-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C9B41955E74; Wed, 12 Jun 2024 11:25:02 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.115])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD7931956053; Wed, 12 Jun 2024 11:24:59 +0000 (UTC)
Date: Wed, 12 Jun 2024 12:24:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v3 1/4] qom: allow to mark objects as deprecated or not
 secure.
Message-ID: <ZmmFiJY4gBTk8kKk@redhat.com>
References: <20240606143010.1318226-1-kraxel@redhat.com>
 <20240606143010.1318226-2-kraxel@redhat.com>
 <8734pifmgv.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8734pifmgv.fsf@pond.sub.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, Jun 12, 2024 at 01:07:44PM +0200, Markus Armbruster wrote:
> Gerd Hoffmann <kraxel@redhat.com> writes:
> 
> > Add flags to ObjectClass for objects which are deprecated or not secure.
> > Add 'deprecated' and 'not-secure' bools to ObjectTypeInfo, report in
> > 'qom-list-types'.  Print the flags when listing devices via '-device
> > help'.
> >
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  include/qom/object.h  | 3 +++
> >  qom/qom-qmp-cmds.c    | 8 ++++++++
> >  system/qdev-monitor.c | 8 ++++++++
> >  qapi/qom.json         | 8 +++++++-
> >  4 files changed, 26 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/qom/object.h b/include/qom/object.h
> > index 13d3a655ddf9..419bd9a4b219 100644
> > --- a/include/qom/object.h
> > +++ b/include/qom/object.h
> > @@ -136,6 +136,9 @@ struct ObjectClass
> >      ObjectUnparent *unparent;
> >  
> >      GHashTable *properties;
> > +
> > +    bool deprecated;
> > +    bool not_secure;
> >  };
> 
> Ignorant question: should this be in struct TypeImpl instead?
> 
> >  
> >  /**
> > diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
> > index e91a2353472a..325ff0ba2a25 100644
> > --- a/qom/qom-qmp-cmds.c
> > +++ b/qom/qom-qmp-cmds.c
> > @@ -101,6 +101,14 @@ static void qom_list_types_tramp(ObjectClass *klass, void *data)
> >      if (parent) {
> >          info->parent = g_strdup(object_class_get_name(parent));
> >      }
> > +    if (klass->deprecated) {
> > +        info->has_deprecated = true;
> > +        info->deprecated = true;
> > +    }
> > +    if (klass->not_secure) {
> > +        info->has_not_secure = true;
> > +        info->not_secure = true;
> > +    }
> >  
> >      QAPI_LIST_PREPEND(*pret, info);
> >  }
> > diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> > index 6af6ef7d667f..effdc95d21d3 100644
> > --- a/system/qdev-monitor.c
> > +++ b/system/qdev-monitor.c
> > @@ -144,6 +144,8 @@ static bool qdev_class_has_alias(DeviceClass *dc)
> >  
> >  static void qdev_print_devinfo(DeviceClass *dc)
> >  {
> > +    ObjectClass *klass = OBJECT_CLASS(dc);
> > +
> >      qemu_printf("name \"%s\"", object_class_get_name(OBJECT_CLASS(dc)));
> >      if (dc->bus_type) {
> >          qemu_printf(", bus %s", dc->bus_type);
> > @@ -157,6 +159,12 @@ static void qdev_print_devinfo(DeviceClass *dc)
> >      if (!dc->user_creatable) {
> >          qemu_printf(", no-user");
> >      }
> > +    if (klass->deprecated) {
> > +        qemu_printf(", deprecated");
> > +    }
> > +    if (klass->not_secure) {
> > +        qemu_printf(", not-secure");
> > +    }
> >      qemu_printf("\n");
> >  }
> >  
> > diff --git a/qapi/qom.json b/qapi/qom.json
> > index 8bd299265e39..3f20d4c6413b 100644
> > --- a/qapi/qom.json
> > +++ b/qapi/qom.json
> > @@ -163,10 +163,16 @@
> >  #
> >  # @parent: Name of parent type, if any (since 2.10)
> >  #
> > +# @deprecated: the type is deprecated (since 9.1)
> > +#
> > +# @not-secure: the type (typically a device) is not considered
> > +#     a security boundary (since 9.1)
> 
> What does this mean?  Does it mean "do not add an instance of this
> device the guest unless you trust the guest"?

Essentially yes. This ties to our security doc where we declare
we won't consider non-virtualization use cases as being security
bugs (CVEs) as large parts of QEMU haven't been designed to
provide a guest security boundary

  https://www.qemu.org/docs/master/system/security.html


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


