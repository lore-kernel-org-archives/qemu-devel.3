Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58391C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 09:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJUub-0004Dt-AV; Tue, 18 Jun 2024 05:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sJUuZ-0004DZ-Qb
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 05:13:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sJUuX-00014B-Py
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 05:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718702031;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1H6lE8KDibPeGH8jYhuoxR4LSDKFNZRT91yudZ5bMXI=;
 b=Z+4MZjNrZjqF1t4p7IdgC5XWEih6BnKaaw80vwUamIY+HN5BGT+faGpNybJKYdBKBktL2T
 NE+vWUY5PZAkGP26+1FnXmQz6FobYlkaLx2iILzODZXlE7pessH0YrrpcQfvFbaRal6ObA
 TE4ua1P7OpNnyyLtUoUamR3Q5keifXk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-gaKHXr7jM9CZCOlj2QDNMA-1; Tue,
 18 Jun 2024 05:13:48 -0400
X-MC-Unique: gaKHXr7jM9CZCOlj2QDNMA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77518195609F; Tue, 18 Jun 2024 09:13:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.57])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77AEE19560B2; Tue, 18 Jun 2024 09:13:41 +0000 (UTC)
Date: Tue, 18 Jun 2024 10:13:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?B?QmVubsOp?= e <alex.bennee@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [RFC PATCH v2 3/5] rust: add PL011 device model
Message-ID: <ZnFPwinlmxpgH3mV@redhat.com>
References: <ezjl0.qx0tmsp6d6t@linaro.org>
 <CABgObfbGwKc0RYBcDPzNkE8HOSouFj4D15Oh7TuiKOC+D7raaA@mail.gmail.com>
 <ZmqcFf0xB9m4WkA3@redhat.com>
 <CABgObfb4+FSsadFTVg6Dc1zehQV2Vei2_kSRd5CfxsGBLPN6Eg@mail.gmail.com>
 <Zmq47yQV-sQ0hGMy@redhat.com>
 <CABgObfYaxBxc8GS3=YU=EwNLEihEoD4ikZ595P4m_KTZCAAaBw@mail.gmail.com>
 <f26b0.f15017t08v16@linaro.org>
 <CABgObfaYUCU0Tj-jj66n8AaxOpqXFKcQA-E6G0W6q3MjjwQkiQ@mail.gmail.com>
 <f7vmg.s9przvzs9y9y@linaro.org>
 <CABgObfayPDfcrFJ5ckFFms_raD25ARFEvLNhP1qLmda_rjrLfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfayPDfcrFJ5ckFFms_raD25ARFEvLNhP1qLmda_rjrLfg@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
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

On Mon, Jun 17, 2024 at 01:32:54PM +0200, Paolo Bonzini wrote:
> Il lun 17 giu 2024, 10:59 Manos Pitsidianakis <
> manos.pitsidianakis@linaro.org> ha scritto:
> 
> > >qdev_define_type!(c"test-device", TestDevice);
> > >impl ObjectImpl for TestDevice {}
> > >impl DeviceImpl for TestDevice {}
> > >
> > >fn main() {
> > >    let d = TestDevice::new();
> > >    d.cold_reset();
> > >}
> > >
> > >Of course the code makes no sense but it's a start.
> >
> > Let's not rush into making interfaces without the need for them arising
> > first. It's easy to wander off into bikeshedding territory; case in
> > point, there has been little discussion on the code of this RFC and much
> > more focus on hypotheticals.
> >
> 
> I see your point but I think it's important to understand the road ahead of
> us.
> 
> Knowing that we can build and maintain a usable (does not have to be
> perfect) interface to QOM is important, and in fact it's already useful for
> the pl011 device's chardev. It's also important to play with more advanced
> usage of the language to ascertain what features of the language will be
> useful; for example, my current implementation uses generic associated
> types which are not available on Debian Bookworm—it should be easy to
> remove them but if I am wrong that's also a data point, and an important
> one.
> 
> Don't get me wrong: *for this first device* only, it makes a lot of sense
> to have a very C-ish implementation. It lets us sort out the build system
> integration, tackle idiomatic bindings one piece at a time, and is easier
> to review than Marc-André's approach of building the whole QAPI bindings.
> But at the same time, I don't consider a C-ish device better just because
> it's written in Rust: as things stand your code has all the disadvantages
> of C and all the disadvantages of Rust. What makes it (extremely) valuable
> is that your code can lead us along the path towards reaping the advantages
> of Rust.

I wonder if starting with a device implementation is perhaps the
wrong idea, in terms of a practical yet simple first step.

As devices go, the pl011 device is simple, but compared to other
QOM impls in QEMU, devices are still relatively complex things,
especially if we want to write against safe abstraction.

How about we go simpler still, and focus on one of the object
backends. For example, the RNG backend interface is practically
the most trivial QOM impl we can do in QEMU. It has one virtual
method that needs to be implemented, which is passed a callback
to receive entropy, and one native method to call to indicate
completion.

Providing a safe Rust abstraction for implementing an RNG
backend looks like a much quicker proposition that a safe
abstraction for implementing a device. The various RNG impls
have a few places where they touch other QEMU code (rng-builtin
uses qemu_bh, rng-egd lightly touches chardev APIs, rng-random
touches main loop FD handlers). Each of those things though, are
small & useful API problems to look it solving.

If we did this I think we would not have to give a "free pass"
for a hackish C-like first Rust impl. We would have something
designed well from day 1, showing small, but tangible benefits,
with a path to incrementally broadening the effort.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


