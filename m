Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E90D149C3
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 16:22:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4N4q-0005P9-MG; Fri, 25 Oct 2024 12:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t4N4o-0005Lo-Tm
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:22:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t4N4m-0007SW-TZ
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729873331;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9IK5MdwLxt+WDydlG/hJ+zWYOCsnXfluWZs6oSV5wgY=;
 b=U4JVwct70+HrLFZRTV38yS/MXV860NgMu/V5irf4iAm2PQ+F1SGorQiQm4yWEMbh6mdIQU
 LOm4IddcZutasL8W+WN9wp2UNXffhqBu0dnzKgBHc6sjfyai7CvshGifIEHvlP/ubcQuIJ
 2PlOdWG0oTMY9SxCC4xupeJ5e9Citjs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-7__6GOYpPWinOwT27g9sYg-1; Fri,
 25 Oct 2024 12:22:10 -0400
X-MC-Unique: 7__6GOYpPWinOwT27g9sYg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0465B1955EA5; Fri, 25 Oct 2024 16:22:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.164])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2497D300018D; Fri, 25 Oct 2024 16:22:03 +0000 (UTC)
Date: Fri, 25 Oct 2024 17:22:01 +0100
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
Message-ID: <ZxvFqYASUdSNtlr6@redhat.com>
References: <20241024165627.1372621-1-peterx@redhat.com>
 <20241024165627.1372621-2-peterx@redhat.com>
 <ZxtqGQbd4Hq4APtm@redhat.com> <ZxvEfrj5B59J5HHj@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZxvEfrj5B59J5HHj@x1n>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
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

On Fri, Oct 25, 2024 at 12:17:02PM -0400, Peter Xu wrote:
> On Fri, Oct 25, 2024 at 10:51:21AM +0100, Daniel P. Berrangé wrote:
> > > diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
> > > index e91a235347..ecc1cf781c 100644
> > > --- a/qom/qom-qmp-cmds.c
> > > +++ b/qom/qom-qmp-cmds.c
> > > @@ -126,6 +126,7 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
> > >      ObjectProperty *prop;
> > >      ObjectPropertyIterator iter;
> > >      ObjectPropertyInfoList *prop_list = NULL;
> > > +    bool create;
> > >  
> > >      klass = module_object_class_by_name(typename);
> > >      if (klass == NULL) {
> > > @@ -141,7 +142,15 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
> > >          return NULL;
> > >      }
> > >  
> > > -    obj = object_new(typename);
> > > +    /* Avoid creating multiple instances if the class is a singleton */
> > > +    create = !object_class_is_singleton(klass) ||
> > > +        !singleton_get_instance(klass);
> > > +
> > > +    if (create) {
> > > +        obj = object_new(typename);
> > > +    } else {
> > > +        obj = singleton_get_instance(klass);
> > > +    }
> > 
> > This is the first foot-gun example.
> > 
> > I really strongly dislike that the design pattern forces us to
> > create code like this, as we can never be confident we've
> > correctly identified all the places which may call object_new
> > on a singleton...
> 
> Yeah I agree it's not pretty, IMHO it's a trade-off comparing to glib's,
> I'll comment below for that.
> 
> Meanwhile I hope there should be very limited places in QEMU to randomly
> create "any" object on the fly.. so far only qom/device-list-properties
> that I see.

There's -object/-device CLI, and their corresponding object_add
/ device_add commands.

They are not relevant for the migration object, but you're adding
this feature to QOM, so we have to take them into account. If anyone
defines another Object or Device class as a singleton, we will have
quite a few places where we can trigger the assert. This is especially
bad if we trigger it from anything in QMP as that kills a running
guest.

> 
> I think glib's implementation is not thread safe on its own... consider two
> threads invoke g_object_new() on the singleton without proper locking.  I
> am guessing it could be relevant to glib's heavy event model.

I've not checked the full code path, to see if they have a serialization
point somewhere it the g_object_new call chain, but yes, it is a valid
concern that would need to be resolved.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


