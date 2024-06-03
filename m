Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBC5C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 14:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE90S-0007kC-I4; Mon, 03 Jun 2024 10:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sE90Q-0007jH-No
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 10:49:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sE90O-0000Iq-Nu
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 10:49:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717426187;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vFrVo2+pfmzooaugU2dNi9HdH5e9B8bIFc4BLXhDlUM=;
 b=EM+C2BjgcyqpPrkpGNhByHmQzSr6X0Owtp9zGao+Wv3oTw7UmZGXIzgqxjoxfEMJHqvs2t
 zB+rUzXfnJkRkWwdkXk8cYO2OFgejwvBNRIc+/iZhI+WfM9w9w4pa8Qgfz2lhrpgJYpVfF
 auNhV8xzRc+eA9ZExWKgnRbtkzd+JXw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-JLfrAcp4NUOOr0XPTRDu_A-1; Mon, 03 Jun 2024 10:49:44 -0400
X-MC-Unique: JLfrAcp4NUOOr0XPTRDu_A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34DE3101A54F;
 Mon,  3 Jun 2024 14:49:44 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D78B200D18B;
 Mon,  3 Jun 2024 14:49:43 +0000 (UTC)
Date: Mon, 3 Jun 2024 15:49:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH] io/channel-socket: Fix -fsanitize=undefined problem with
 latest Clang
Message-ID: <Zl3YBQQ5yWdQoH4y@redhat.com>
References: <20240529133106.1224866-1-thuth@redhat.com>
 <CAFEAcA8yOgGS8VdFRmJJKaUZe9Q=jDDh7itK6Q7vUH4TtEbFnw@mail.gmail.com>
 <Zl27orDnp8hOqgKo@redhat.com>
 <844ed2cb-9f91-439f-bd6a-73003acfdef1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <844ed2cb-9f91-439f-bd6a-73003acfdef1@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
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

On Mon, Jun 03, 2024 at 04:38:53PM +0200, Thomas Huth wrote:
> On 03/06/2024 14.48, Daniel P. Berrangé wrote:
> > On Wed, May 29, 2024 at 02:53:37PM +0100, Peter Maydell wrote:
> > > On Wed, 29 May 2024 at 14:32, Thomas Huth <thuth@redhat.com> wrote:
> > > > 
> > > > Casting function pointers from one type to another causes undefined
> > > > behavior errors when compiling with -fsanitize=undefined with Clang v18:
> > > > 
> > > >   $ QTEST_QEMU_BINARY=./qemu-system-mips64 tests/qtest/netdev-socket
> > > >   TAP version 13
> > > >   # random seed: R02S4424f4f460de783fdd3d72c5571d3adc
> > > >   1..10
> > > >   # Start of mips64 tests
> > > >   # Start of netdev tests
> > > >   # Start of stream tests
> > > >   # starting QEMU: exec ./qemu-system-mips64 -qtest unix:/tmp/qtest-1213196.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-1213196.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -nodefaults -M none -netdev stream,id=st0,addr.type=fd,addr.str=3 -accel qtest
> > > >   ../io/task.c:78:13: runtime error: call to function qapi_free_SocketAddress through pointer to incorrect function type 'void (*)(void *)'
> > > >   /tmp/qemu-sanitize/qapi/qapi-types-sockets.c:170: note: qapi_free_SocketAddress defined here
> > > >   SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../io/task.c:78:13
> > > 
> > > It's a pity the sanitizer error doesn't tell you the actual
> > > function type as well as the incorrect one it got cast to
> > > (especially since in this case the function and its declaration
> > > are both in generated code in the build tree not conveniently
> > > findable with 'git grep'.)
> > > 
> > > In this case the function being called is:
> > >   void qapi_free_SocketAddress(SocketAddress *obj)
> > > and it's cast to a GDestroyNotify, which is
> > >   typedef void            (*GDestroyNotify)       (gpointer       data);
> > > (and gpointer is void*)
> > > 
> > > and although you can pass a foo* to a function expecting void*,
> > > you can't treat a pointer to a function taking foo* as if it was
> > > a pointer to a function taking void*, just in case the compiler
> > > needs to do some clever trickery with the pointer value.
> > > 
> > > So the wrapper function looks like it doesn't do anything,
> > > but it's doing the permitted implicit-cast of the argument
> > 
> > 
> > I guess that's the letter of the law in C, but does that actually
> > matter in practice, historically ?
> > 
> > The use of "(GDestroyNotify)blah"  casts is standard practice
> > across any application using GLib, and even in QEMU this is
> > far from the only place that does such a cast:
> ...
> > I presume this means the rest of the code merely isn't exercised by the
> > CI job test case this is fixing, but if we're saying this needs fixing,
> > then we should be fixing all usage.
> 
> There are more spots discovered by the CI, I just didn't tackle them yet.
> 
> Another problem is e.g. the call_rcu macro from include/qemu/rcu.h...
> 
> > So overall, I'm not in favour of this patch unless there's a compelling
> > functional reason why just this 1 case is special and all the others
> > can be safely ignored.
> 
> We'd need to tackle them all. I thought it might be a good idea since we
> then could also switch to a more strict CFI mode (i.e. stop using
> -fsanitize-cfi-icall-generalize-pointers) ... but yes, looking at the amount
> of spots that need fixes, it feels like tilting at windmills.

We can't rely on the sanitizers to catch all cases where we're casting
functions, as we don't have good enough code coverage in tests to
identify all places that way.

Unless there's a warning flag we can use to get diagnosis of this
problem at compile time and then fix all reported issues, I won't have
any confidence in our ability to remove -fsanitize-cfi-icall-generalize-pointers
for CFI.

> Maybe best if we really just add -fno-sanitize=function to the CFLAGS when
> we're compiling with the sanitizer enabled.

That's my recommendation for the short term.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


