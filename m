Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB4EC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 15:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE9zT-0007A2-K4; Mon, 03 Jun 2024 11:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sE9zR-000797-Rj
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 11:52:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sE9zP-0004tg-Ue
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 11:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717429969;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QPhepPed6BPfZz3r892CYndcuT+HzvbnuDO4yrjiiSA=;
 b=MPOto+ezZ7yKs1Q351Yqfp6l8Eqdge58Lo7RAyQi1tT+RL8r9Rmtmda+oaFYz3cP6bWnOC
 2X+DRp3xV48CHaCuSkOQYZ2drBSOWOW1W3oDi6NLJLi0PEb0dmfPUaROQCZGv4qHYVJhA5
 6hWDc/jYSphtSMcyNKMsXtz3RgamlbM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-hDAioJLxPcCBqFnWCgmnZg-1; Mon, 03 Jun 2024 11:52:46 -0400
X-MC-Unique: hDAioJLxPcCBqFnWCgmnZg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A0DE185A58C;
 Mon,  3 Jun 2024 15:52:45 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C9958287B;
 Mon,  3 Jun 2024 15:52:44 +0000 (UTC)
Date: Mon, 3 Jun 2024 16:52:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH] io/channel-socket: Fix -fsanitize=undefined problem with
 latest Clang
Message-ID: <Zl3myjbEdsiitiB-@redhat.com>
References: <20240529133106.1224866-1-thuth@redhat.com>
 <CAFEAcA8yOgGS8VdFRmJJKaUZe9Q=jDDh7itK6Q7vUH4TtEbFnw@mail.gmail.com>
 <Zl27orDnp8hOqgKo@redhat.com>
 <844ed2cb-9f91-439f-bd6a-73003acfdef1@redhat.com>
 <Zl3YBQQ5yWdQoH4y@redhat.com>
 <CAFEAcA_kkM6VgeVKxbSB_=UHOn0a6aFFUTUOeNP4otEoboYtvg@mail.gmail.com>
 <CAFEAcA_QPwi093sB3jSD9EcJ43q2vvZMHwJ58NWqWL2-4soo8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA_QPwi093sB3jSD9EcJ43q2vvZMHwJ58NWqWL2-4soo8Q@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Jun 03, 2024 at 04:12:34PM +0100, Peter Maydell wrote:
> On Mon, 3 Jun 2024 at 15:58, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Mon, 3 Jun 2024 at 15:49, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > We can't rely on the sanitizers to catch all cases where we're casting
> > > functions, as we don't have good enough code coverage in tests to
> > > identify all places that way.
> > >
> > > Unless there's a warning flag we can use to get diagnosis of this
> > > problem at compile time and then fix all reported issues, I won't have
> > > any confidence in our ability to remove -fsanitize-cfi-icall-generalize-pointers
> > > for CFI.
> >
> > You might think that -Wcast-function-type would detect them at compile
> > time, but that has two loopholes:
> >  1. void(*) (void)  matches everything
> >  2. any parameter of pointer type matches any other pointer type
> >
> > It seems to me rather inconsistent that the sanitizers do
> > not match up with the warning semantics here. I think I
> > would vote for raising that with the compiler folks --
> > either the sanitizer should be made looser so it matches
> > the -Wcast-function-type semantics, or else a new tighter
> > warning option that matches the sanitizer should be
> > provided. Ideally both, I think. But it's definitely silly
> > to have a runtime check that flags up things that the
> > compiler perfectly well could detect at compile time but
> > is choosing not to.
> 
> Slightly further investigation suggests clang 16 and later
> have -Wcast-function-type-strict for the "report all the
> same casts that the sanitizer does". gcc doesn't I think have
> that yet. I didn't spot any option in the sanitizer to
> loosen the set of things it considers mismatched function
> pointers.

I just tried that with

CC=clang ./configure --target-list=x86_64-softmmu --extra-cflags="-Wcast-function-type-strict"  --disable-werror

and it rather shows the futility of the task, picking one reoprted
warning that is repeated over & over in differnt contexts:

In file included from qapi/qapi-types-block-core.c:15:
qapi/qapi-types-block-core.h:3620:1: warning: cast from 'void (*)(DummyBlockCoreForceArrays *)' (aka 'void (*)(struct DummyBlockCoreForceArrays *)') to 'void (*)(void)' converts to incompatible function type [-Wcast-function-type-strict]
 3620 | G_DEFINE_AUTOPTR_CLEANUP_FUNC(DummyBlockCoreForceArrays, qapi_free_DummyBlockCoreForceArrays)
      | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/usr/include/glib-2.0/glib/gmacros.h:1372:3: note: expanded from macro 'G_DEFINE_AUTOPTR_CLEANUP_FUNC'
 1372 |   _GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS(TypeName, TypeName, func)
      |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/usr/include/glib-2.0/glib/gmacros.h:1364:57: note: expanded from macro '_GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS'
 1364 |     { if (*_q) g_queue_free_full (*_q, (GDestroyNotify) (void(*)(void)) cleanup); }                             \
      |                                                         ^~~~~~~~~~~~~~~~~~~~~~~


IOW, the GLib headers themselves have bad casts in macros which we
rely on.  So we'll never be cast safe until GLib changes its own
code...if it ever does.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


