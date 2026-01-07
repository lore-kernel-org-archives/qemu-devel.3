Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A645CFD65E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 16:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdWS0-0001ff-7V; Wed, 07 Jan 2026 11:32:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdWRq-0001DT-Ub
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 11:31:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdWRn-0002jU-Vo
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 11:31:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767803506;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=/tt61r6RcnT6MglHsHAvo9Hs+UsIKoxr5LrnVDRl/UI=;
 b=UUg6LaakKahN6rUpiOLwUE2X/3hzHRhBJahwkwFeHBKAI8/rQT04rBCQdvafmS4rWl7a47
 eWLAXsKkTNE4bsh2CYtIwUA6i0COMqDehRZiew8g31xLgtEhWF3WpUQGTloJjhioPTh9Zl
 lVjO/4vA7gbRpGWKZiEe+DsmVkczwWY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-vCZ9aMBiP2y3u0PEkN1EZA-1; Wed,
 07 Jan 2026 11:31:42 -0500
X-MC-Unique: vCZ9aMBiP2y3u0PEkN1EZA-1
X-Mimecast-MFC-AGG-ID: vCZ9aMBiP2y3u0PEkN1EZA_1767803501
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C12AE1956071; Wed,  7 Jan 2026 16:31:40 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.169])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B7DC1955F24; Wed,  7 Jan 2026 16:31:36 +0000 (UTC)
Date: Wed, 7 Jan 2026 16:31:33 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Chandan Somani <csomani@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "open list:Stellaris" <qemu-arm@nongnu.org>
Subject: Re: [PATCH] qdev: Free property array on release
Message-ID: <aV6KZQOOU__dXBIz@redhat.com>
References: <20251222055009.1050567-1-csomani@redhat.com>
 <20260106203018.GE123256@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260106203018.GE123256@fedora>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jan 06, 2026 at 03:30:18PM -0500, Stefan Hajnoczi wrote:
> On Sun, Dec 21, 2025 at 09:50:05PM -0800, Chandan Somani wrote:
> > @@ -686,14 +684,16 @@ static void release_prop_array(Object *obj, const char *name, void *opaque)
> >      char *elem = *arrayptr;
> >      int i;
> >  
> > -    if (!prop->arrayinfo->release) {
> > -        return;
> > +    if (prop->arrayinfo->release) {
> > +        for (i = 0; i < *alenptr; i++) {
> > +            Property elem_prop = array_elem_prop(obj, prop, name, elem);
> > +            prop->arrayinfo->release(obj, NULL, &elem_prop);
> > +            elem += prop->arrayfieldsize;
> > +        }
> >      }
> >  
> > -    for (i = 0; i < *alenptr; i++) {
> > -        Property elem_prop = array_elem_prop(obj, prop, name, elem);
> > -        prop->arrayinfo->release(obj, NULL, &elem_prop);
> > -        elem += prop->arrayfieldsize;
> > +    if (*arrayptr) {
> > +        g_free(*arrayptr);
> >      }
> 
> Optional cleanup to protect against use-after-free and similar issues:
> 
> *arrayptr = NULL;

Even better use  "g_clear_pointer(arrayptr, g_free)" 

> *alenptr = 0;



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


