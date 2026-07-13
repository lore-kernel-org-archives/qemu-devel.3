Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3FBC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 18:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjLga-0002Jt-T0; Mon, 13 Jul 2026 14:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wjLgZ-0002Jl-R3
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 14:47:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wjLgX-0003JR-Ey
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 14:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783968439;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=mjhRDodkmWkvClauBbn2nqHfOdYpd+vtUuhIy5i7sl8=;
 b=BddNwqRorJleEIuWweG0HJvT0gKwyTWKkm3BNwvKazqH3Ck+NDEkHs9EdO4/mviH4eMHJy
 q6dOZnowumMmmNirTbapT78UsBNFWbLtLs8SMLQdfpbxm6c0FvsN4o298Ktpol0oSEPCHR
 oMOdZf/R1HNRSwO51F/uIWO20vB/eNk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-_QKDMgtwMTCFhO00pWW0PA-1; Mon,
 13 Jul 2026 14:47:15 -0400
X-MC-Unique: _QKDMgtwMTCFhO00pWW0PA-1
X-Mimecast-MFC-AGG-ID: _QKDMgtwMTCFhO00pWW0PA_1783968434
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 898851955D75; Mon, 13 Jul 2026 18:47:14 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.22])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C13BD1800348; Mon, 13 Jul 2026 18:47:12 +0000 (UTC)
Date: Mon, 13 Jul 2026 19:47:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <graf@amazon.com>, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 001/134] qom: Introduce object_new_child()
Message-ID: <alUyrS2ViWMswx82@redhat.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260711223707.42139-2-graf@amazon.com>
 <12d544b3-5c68-488a-91e5-ac64d1a27338@linaro.org>
 <CAFEAcA9wRhZPyiAym26DQWEyb2AS=QBpvRi9wBEJKsHEw+j0sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9wRhZPyiAym26DQWEyb2AS=QBpvRi9wBEJKsHEw+j0sQ@mail.gmail.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

On Mon, Jul 13, 2026 at 07:15:34PM +0100, Peter Maydell wrote:
> On Mon, 13 Jul 2026 at 17:50, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > On 7/11/26 15:34, Alexander Graf wrote:
> > > We already have two ways of creating a QOM object with a parent set
> > > from birth: object_initialize_child() for objects embedded in the
> > > parent struct, and object_new_with_props() for heap-allocated objects
> > > that also want a list of string properties applied.  What we do not
> > > have is the plain heap-allocated dual of object_initialize_child():
> > > create the object, add it as a child<> of a given parent under a given
> > > name, and hand the reference to the parent.
> > >
> > > Board and composite-device code that heap-allocates children today
> > > therefore either open-codes object_new()+object_property_add_child()
> > > +object_unref(), or skips the parenting step entirely and lets
> > > device_set_realized() dump the object into /machine/unattached.
> > >
> > > Add object_new_child(parent, id, typename) as that missing primitive.
> > > The reference created by object_new() is transferred to the parent's
> > > child<> property, so on return the sole reference is held by @parent
> > > and the caller does not need to unref.  Later patches build the qdev
> > > and per-bus creation helpers on top of this.
> > >
> > > Suggested-by: Markus Armbruster <armbru@redhat.com>
> > > Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
> > > Assisted-by: Kiro
> > > Signed-off-by: Alexander Graf <graf@amazon.com>
> > > ---
> > >   include/qom/object.h | 25 +++++++++++++++++++++++++
> > >   qom/object.c         | 13 +++++++++++++
> > >   2 files changed, 38 insertions(+)
> >
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> >
> > > +Object *object_new_child(Object *parent, const char *id,
> > > +                          const char *typename)
> > > +{
> > > +    Object *obj;
> > > +
> > > +    g_assert(parent);
> > > +    g_assert(id);
> >
> > Of course, typename can't be null either.
> 
> These asserts are of the "not very useful" kind, as well --
> if either of these are NULL we're going to crash pretty quickly,
> and then the debugger backtrace will point you at your programming
> error. Asserts are most useful when they turn non-obvious bugs
> into obvious bugs or turn "happens a long time later than when the
> problem is" bugs into "happens very close to when the problem is".
> bugs.

For the 'id', we ought to call  id_wellformed, and report an error
if it fails, which implies  an "Error **errp" arg for this method
too.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


