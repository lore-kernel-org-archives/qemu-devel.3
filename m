Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99FBCCF9E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 13:39:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCI01-0007Ul-0e; Fri, 24 Oct 2025 09:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vCHzz-0007Tw-38
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 09:38:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vCHzv-00087d-Nj
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 09:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761313105;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7z2hCgKzlURpD7Qwpoh4JYNqLO1hqpH85h6cTdAOI8g=;
 b=HwCK9K5nNlO18WejdKT3EdAlUJYrudM9TLXttZIxio0nJTLxQdtRXRhBdOKN6p7x1bQuO6
 oz3257UiWmY+94AJ7ugpFVs2avNOykt9NMykKdCuFys8RIzQaltb9rUrLpIcTCefFg4MVP
 RFc7C/qcxlfJII9jrMWZwCmhvddXIL0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-PCDj6jcqNuuvndpjyKMKFg-1; Fri,
 24 Oct 2025 09:38:23 -0400
X-MC-Unique: PCDj6jcqNuuvndpjyKMKFg-1
X-Mimecast-MFC-AGG-ID: PCDj6jcqNuuvndpjyKMKFg_1761313102
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87255180060D; Fri, 24 Oct 2025 13:38:22 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2B60180057D; Fri, 24 Oct 2025 13:38:19 +0000 (UTC)
Date: Fri, 24 Oct 2025 14:38:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 11/32] qom: report & filter on security status in
 qom-list-types
Message-ID: <aPuBSEqfjYNLOclQ@redhat.com>
References: <20250926140144.1998694-1-berrange@redhat.com>
 <20250926140144.1998694-12-berrange@redhat.com>
 <87a51h9964.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a51h9964.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 23, 2025 at 12:58:27PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > This adds:
> >
> >  * a new boolean 'secure' field to the type info returned by
> >    qom-list-types, which will be set if the type provides a
> >    security boundary
> >
> >  * a new boolean 'secure' parameter to the arguments of
> >    qom-list-types, which can be used to filter types based
> >    on their security status
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> I was about to ask for this feature in reply to PATCH 2 when I found
> this patch.  Consider moving it right after PATCH 2, or
> forward-referencing it in PATCH 2's commit message.
> 
> > ---
> >  qapi/qom.json      | 10 ++++++++--
> >  qom/qom-qmp-cmds.c | 30 ++++++++++++++++++++++++------
> >  2 files changed, 32 insertions(+), 8 deletions(-)
> >
> > diff --git a/qapi/qom.json b/qapi/qom.json
> > index 830cb2ffe7..3e5e7e6f6f 100644
> > --- a/qapi/qom.json
> > +++ b/qapi/qom.json
> > @@ -210,12 +210,15 @@
> >  # @abstract: the type is abstract and can't be directly instantiated.
> >  #     Omitted if false.  (since 2.10)
> >  #
> > +# @secure: the type provides a security boundary.
> > +#     Omitted if false.  (since 10.2)
> 
> Please wrap like this:
> 
>    # @secure: the type provides a security boundary.  Omitted if false.
>    #     (since 10.2)
> 
> > +#
> >  # @parent: Name of parent type, if any (since 2.10)
> >  #
> >  # Since: 1.1
> >  ##
> >  { 'struct': 'ObjectTypeInfo',
> > -  'data': { 'name': 'str', '*abstract': 'bool', '*parent': 'str' } }
> > +  'data': { 'name': 'str', '*abstract': 'bool', '*parent': 'str', '*secure': 'bool' } }
> 
> Long line.  I think it's time to put each member on its own line.
> 
> >  
> >  ##
> >  # @qom-list-types:
> > @@ -227,12 +230,15 @@
> >  #
> >  # @abstract: if true, include abstract types in the results
> >  #
> > +# @secure: if set, filter to only include types with matching security status
> > +#     (since 10.2)
> 
> Hmm.
> 
>                 absent          false           true
>     @abstract   only concrete   only concrete   all
>     @secure     all             only insecure   only secure     (I think)
> 
> The difference is grating.  Any ideas?

I considered the current handling of @abstract to be flawed,
because there are three possible data sets you might want,
and the behaviour of @abstract only lets you query two of
the three - requires a second call to qom-list-types to
get the union of abstract and non-abstract.

Ideally we would fix @abstract but we can't do that without
back-compatibility fallout.

To avoid changing the default behaviour of qom-list-types
we need @secure==absent to return 'all', so that pretty
much forces us down this route of different behaviours
for @abstract vs @secure, unless we deprecate @abstract
and invent something completely new.


> >  ObjectTypeInfoList *qmp_qom_list_types(const char *implements,
> >                                         bool has_abstract,
> >                                         bool abstract,
> > +                                       bool has_secure,
> > +                                       bool secure,
> >                                         Error **errp)
> >  {
> > -    ObjectTypeInfoList *ret = NULL;
> > +    ObjectTypeInfoData data = {
> > +        .list = NULL,
> > +        .has_secure = has_secure,
> > +        .secure = secure,
> > +    };
> >  
> >      module_load_qom_all();
> > -    object_class_foreach(qom_list_types_tramp, implements, abstract, &ret);
> > +    object_class_foreach(qom_list_types_tramp, implements, abstract, &data);
> >  
> > -    return ret;
> > +    return data.list;
> >  }
> >  
> >  ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
> 
> This fuses a change of how the list value is built with the addition of
> a new list element member.  I'd prefer them separate.

Sure, will change.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


