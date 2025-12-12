Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED81D59D7B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 17:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU7M2-0007d1-IA; Fri, 12 Dec 2025 12:54:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vU7M0-0007cO-Ss
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 12:54:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vU7Lz-0002eC-44
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 12:54:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765562094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jrhzLRlBRdOEZd181IXwQTXDHBkbNUVxD70Iu2VrgfU=;
 b=DE0zs7LYnM3m0A7ap6qiP9qKlk27onO+ABZv8rgy4iXuBxTh2tONV09wcm6piM+q4lTfdJ
 h4DbX7oj0Zc7YlEGe5NCaV7BUSqdFE38ialzpKz7nPz8w33vCT7O9VZ411TNgzrCF2GGYO
 JsLDKiOf9I5P45UBb8n3qlw6ZBJe4xs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-sXwEDTEFOSqvqnGdBDbbMw-1; Fri, 12 Dec 2025 12:54:52 -0500
X-MC-Unique: sXwEDTEFOSqvqnGdBDbbMw-1
X-Mimecast-MFC-AGG-ID: sXwEDTEFOSqvqnGdBDbbMw_1765562092
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4ee25cd2da3so25438041cf.2
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 09:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765562092; x=1766166892; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jrhzLRlBRdOEZd181IXwQTXDHBkbNUVxD70Iu2VrgfU=;
 b=hRaeNZiKm8GaMXBHaymRnnrizBhfu+OgmjrYXP9/jK+mXtdME/L0wEwvEvTiVsoeUL
 WAxypuRzsZQbFjZLbdi+4ag1BHqxgPgok6HtaqbAqVNZUT5NKImycfBb7JKEK1limnfE
 grSM8RsCkjHWpZC5tPt9E+PRMA7mLhY0991ZyWJ68dWOwHXlKePGy9JS/Mr6yC0U9wH/
 8E30+Sp4arAyUP1rvc2BrT07iWX3x6rV1RF0pqXw6D0Jn+obtxnheJEle/iMWsdh+qnd
 qNTDC8HGO/bJji+Y6WVL/wB111gXlCxsHrwu1Ym+j6RpQsrUP23cLwHzow1gmXhMUKZt
 AkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765562092; x=1766166892;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jrhzLRlBRdOEZd181IXwQTXDHBkbNUVxD70Iu2VrgfU=;
 b=G3x7oeQ9409MbvSBzHnGcI6dhJoqxg8FRr75STCsze8BlGWyHTz3wXQqD75GxdvHjW
 LOpyzTatlauOtrbk/orVUyYNQfxMqwQU8ynfVTjnJET4/2SAcWIFEfpEMPHdct8s9AAw
 BLv+MWwEb3cFru2j+KtePcjniqDHvsFVYLR3pLEi25dsU8v7bWpHovJE5/TUwCNmzDh2
 6VrxA3+18nozUeqVlcewZ/kS7mEJSkYsiceAJuQ6lkLHoJiqdjtgl+vhyKnIONjXNTPL
 ol0T3bOQUKtqLZsO+pbFascseGpVP8mLvQWt+gp/tkURbQPLoH3kS43cZfO92W96rTIY
 91ag==
X-Gm-Message-State: AOJu0Yz3z8S5bsamitkZVDW73wOT0EYlm7ps6WJVZXzG1DVuEC3wWJyJ
 wGU5rs1Z1gOnTqupVASu0L4Hw5sArQpLH4iBRCD58fdRfrsyVG5Jt0H0/DVgOkrVw5aA7XrA3mW
 N2pggqtAXBAXRIq1uigbATEVxYkNXRExZALz9mDjvRnhG/A+BpYBjYolT
X-Gm-Gg: AY/fxX7NQ+DZvR4H/6m+HCv7ipAZ8EdIl8Z2wnMCa0pXXfkD7J5kjXRSpAgKj5wxJrL
 1zILDZ2l4AF07aUhatg5/UR+hv/qm8hjN/OT+KcuQyNR/MI1Bn444WMcSwkfWXzWoW+oeEEIIoq
 ALndFGodLJRYoU6a/P75bpxLiuMjxRvK5sQwKr9r1zE75S5waPAmkTrmMKS2k7NTbLJw1N4RNA4
 g/eNr6Mjiokf55pZEITOXA8PRSy3eUeBeFmGvC4MZcRhtEhktRSQT3MSDEge0zOhghUnKczPK2J
 1KJ+IVnqPguEyOHKH3kx6Xv9P3G3aJqrXUimZDaB5nD2E84d35G38GIntdOkYE6naj89sNybL/S
 i+pY=
X-Received: by 2002:a05:622a:5e11:b0:4ed:df09:a6a6 with SMTP id
 d75a77b69052e-4f1d04b1dffmr40259891cf.25.1765562092111; 
 Fri, 12 Dec 2025 09:54:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGn4hy3NV91mCL+QTRAascmkv5UQ+KycvTdQm/8QiIX0+MQ5wmxoO4yBc/biQaYgLPvbEymug==
X-Received: by 2002:a05:622a:5e11:b0:4ed:df09:a6a6 with SMTP id
 d75a77b69052e-4f1d04b1dffmr40259441cf.25.1765562091620; 
 Fri, 12 Dec 2025 09:54:51 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f1bd5bc349sm47500021cf.11.2025.12.12.09.54.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 09:54:51 -0800 (PST)
Date: Fri, 12 Dec 2025 12:54:49 -0500
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Juraj Marcin <jmarcin@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH RFC 00/10] QOM: Introduce OBJECT_COMPAT class
Message-ID: <aTxW6YGvHpKh5QKr@x1.local>
References: <20251209162857.857593-1-peterx@redhat.com>
 <a3b5e158-adae-4c66-89f9-7f0af26c63da@rsg.ci.i.u-tokyo.ac.jp>
 <aTrp9o3d8pAapahL@x1.local>
 <f900753b-b94f-47cd-8ebb-c82e7bae7b72@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f900753b-b94f-47cd-8ebb-c82e7bae7b72@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Dec 12, 2025 at 02:38:09PM +0900, Akihiko Odaki wrote:
> On 2025/12/12 0:57, Peter Xu wrote:
> > On Fri, Dec 12, 2025 at 12:28:21AM +0900, Akihiko Odaki wrote:
> > > I'm actually less sure if the first half makes sense than the second half.
> > > 
> > > Exporting Property from QDEV did make me think it may be polluting the
> > > codebase with QDEV-specifics, but its motivation (creating properties
> > > without defining accessors) is clear and it meets its requirement.
> > > 
> > > The motivation is less concrete for the first half. It says the current code
> > > is explicit, but it is a relative term. I'm not sure if specifying
> > > TYPE_OBJECT_COMPAT is less explicit (or more implicit) than calling
> > > object_apply_compat_props(). Also, having a class for compat props but not
> > > for global props makes the decision look arbitrary. It is nice to have some
> > > clarification on these.
> > 
> > Thanks for the comments, Akihiko.  I can explain.
> > 
> > I explicitly only included object_apply_compat_props() in the current
> > OBJECT_COMPAT class (rather than set_globals()) is almost two-fold:
> > 
> >    - Inclusion of qdev_prop_set_globals() makes the 1st half start to depend
> >      on the 2nd half, that I don't see it strictly necessary.  E.g., one
> >      immediate motivation of me looking at this problem is Vladimir's series
> >      on virtio-net/tap [1].
> > 
> >      That series should only need patch 1-6 of this series as minimum to
> >      enable machine compat properties for TAP (after QOMify, if that makes
> >      sense on its own).
> 
> It is possible to have another type that inherits TYPE_OBJECT_COMPAT and
> does the second half.

There's really not much user.  Especially if you're suggesting to not
introduce OBJECT_COMPAT, then I'd not consider that for now.

> 
> > 
> >    - qdev_prop_set_globals() itself has a trivial dependency currently
> >      against qdev hotpluggable or not:
> > 
> >      object_apply_global_props(OBJECT(dev), global_props(),
> >                                dev->hotplugged ? NULL : &error_fatal);
> > 
> >      There's way to decouple that I guess, however I just don't see it
> >      necessary yet.  The only real user will be migration object, which
> >      doesn't need to depend on this anyway, as long as Property APIs can be
> >      exported.
> 
> Theoretically, there may also be a call of object_apply_compat_props() that
> has some dependency on its state in the future, but such a future concern
> should be treated later; I'll focus on existing callers of
> object_apply_compat_props() and global_props() in the following discussion
> too.
> 
> > 
> > Do you think we should keep open-code object_apply_compat_props() instead?
> 
> Yes, that's my conclusion so far, but please see below for the explanation:
> 
> > 
> > In reality, that also works for me at least on figuring out the current
> > problem [1], and if Property API exported I can also open code it for
> > migration object.  It's just that IMHO it's cleaner we have the light class
> > to do this (so as to avoid providng post_init() hooks all over the places).
> 
> Avoiding providing post_init() hooks is a nice concrete explanation of the
> goal.
> 
> That said, the migration object provides post_init() hooks anyway, so the
> question will be if avoiding post_init() hooks will simplify the existing
> callers of object_apply_compat_props().
> 
> Looking into the codebase, there are four users of
> object_apply_compat_props(); hostmem, qdev, accel, and sev. Only hostmem and
> qdev call object_apply_compat_props() in their post_init() hooks, and qdev
> needs the hook anyway for the same reason the migration object does.
> 
> So there is only one post_init() hook added for object_apply_compat_props():
> host_memory_backend_post_init(). And even this can be simplified; since
> object_apply_compat_props() and the hook has the same signature, hostmem can
> simply do:
> 
> .instance_post_init = object_apply_compat_props,
> 
> ... and drop host_memory_backend_post_init().
> 
> This is much simpler than adding the object-compat type, so probably it's
> too early to add the type.

Yes, this looks also good enough for now.

When looking at this problem, my real goal was not OBJECT_COMPAT, but
allowing TYPE_OBJECT to opt-in with machine compat properties, then I found
these users.  I was expecting a new class would help, and maybe that should
at some point become the standard for backends.  Then device backends can
do the same as frontend on inheriting machine properties.

As long as we can reach a consensus providing that feature to TYPE_OBJECT
one way or another, it'll be good enough.

I'll wait a while to see whether others have further inputs.

Thanks,

-- 
Peter Xu


