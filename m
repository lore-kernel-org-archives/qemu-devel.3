Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97178C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 15:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHl0t-0001pi-HG; Wed, 21 May 2025 11:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uHl0n-0001p4-I1
 for qemu-devel@nongnu.org; Wed, 21 May 2025 11:05:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uHl0k-0000qJ-L1
 for qemu-devel@nongnu.org; Wed, 21 May 2025 11:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747839933;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=egWAzlnUVNgyj13j7Ode8U1MPwVQBsuabG3iGPxaGWA=;
 b=eVjG0ytZFMmInhEYnZwNKhA8krslTnQe9oPwh1k4DbYN855opaWjwN97ynmcyAGBcFRY/H
 67OBJYcAcMNfqi1WwjjPUff9YVTBZYQfeW75UcZzcNKIF1iEn7lBOwgGMDcLdOWtSEsjdB
 za5w1TqBwcHEwjbANvrCAP7ux8le5YY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-Xu5UPlK5NHOFuIq3g_gQ1Q-1; Wed,
 21 May 2025 11:05:27 -0400
X-MC-Unique: Xu5UPlK5NHOFuIq3g_gQ1Q-1
X-Mimecast-MFC-AGG-ID: Xu5UPlK5NHOFuIq3g_gQ1Q_1747839926
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F7E1180045C; Wed, 21 May 2025 15:05:26 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.129])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D4B719560AD; Wed, 21 May 2025 15:05:24 +0000 (UTC)
Date: Wed, 21 May 2025 16:05:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, qemu-rust@nongnu.org
Subject: Re: [RFC PATCH 1/6] rust: add "bits", a custom bitflags implementation
Message-ID: <aC3rsAFcJgHtQw9-@redhat.com>
References: <20250521081845.496442-1-pbonzini@redhat.com>
 <20250521081845.496442-2-pbonzini@redhat.com>
 <aC2O0iNVZZMQUpjQ@redhat.com>
 <CAAjaMXbuCFh3pY+Q=u1r5vGVf_a1kveyoeVgSOEPa8zwRicj_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAjaMXbuCFh3pY+Q=u1r5vGVf_a1kveyoeVgSOEPa8zwRicj_A@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, May 21, 2025 at 12:23:02PM +0300, Manos Pitsidianakis wrote:
> On Wed, May 21, 2025 at 11:29 AM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Wed, May 21, 2025 at 10:18:40AM +0200, Paolo Bonzini wrote:
> > > One common thing that device emulation does is manipulate bitmasks, for example
> > > to check whether two bitmaps have common bits.  One example in the pl011 crate
> > > is the checks for pending interrupts, where an interrupt cause corresponds to
> > > at least one interrupt source from a fixed set.
> > >
> > > Unfortunately, this is one case where Rust *can* provide some kind of
> > > abstraction but it does so with a rather Perl-ish There Is More Way To
> > > Do It.  It is not something where a crate like "bilge" helps, because
> > > it only covers the packing of bits in a structure; operations like "are
> > > all bits of Y set in X" almost never make sense for bit-packed structs;
> > > you need something else, there are several crates that do it and of course
> > > we're going to roll our own.
> > >
> > > In particular I examined three:
> > >
> > > - bitmask (https://docs.rs/bitmask/0.5.0/bitmask/) does not support const
> > >   at all.  This is a showstopper because one of the ugly things in the
> > >   current pl011 code is the ugliness of code that defines interrupt masks
> > >   at compile time:
> > >
> > >     pub const E: Self = Self(Self::OE.0 | Self::BE.0 | Self::PE.0 | Self::FE.0);
> > >
> > >   or even worse:
> > >
> > >     const IRQMASK: [u32; 6] = [
> > >       Interrupt::E.0 | Interrupt::MS.0 | Interrupt::RT.0 | Interrupt::TX.0 | Interrupt::RX.0,
> > >       ...
> > >     }
> > >
> > >   You would have to use roughly the same code---"bitmask" only helps with
> > >   defining the struct.
> > >
> > > - bitmask_enum (https://docs.rs/bitmask-enum/2.2.5/bitmask_enum/) does not
> > >   have a good separation of "valid" and "invalid" bits, so for example "!x"
> > >   will invert all 16 bits if you choose u16 as the representation -- even if
> > >   you only defined 10 bits.  This makes it easier to introduce subtle bugs
> > >   in comparisons.
> > >
> > > - bitflags (https://docs.rs/bitflags/2.6.0/bitflags/) is generally the most
> > >   used such crate and is the one that I took most inspiration from with
> > >   respect to the syntax.  It's a pretty sophisticated implementation,
> > >   with a lot of bells and whistles such as an implementation of "Iter"
> > >   that returns the bits one at a time.
> > >
> > > The main thing that all of them lack, however, is a way to simplify the
> > > ugly definitions like the above.  "bitflags" includes const methods that
> > > perform AND/OR/XOR of masks (these are necessary because Rust operator
> > > overloading does not support const yet, and therefore overloaded operators
> > > cannot be used in the definition of a "static" variable), but they become
> > > even more verbose and unmanageable, like
> > >
> > >   Interrupt::E.union(Interrupt::MS).union(Interrupt::RT).union(Interrupt::TX).union(Interrupt::RX)
> > >
> > > This was the main reason to create "bits", which allows something like
> > >
> > >   bits!(Interrupt: E | MS | RT | TX | RX)
> > >
> > > and expands it 1) add "Interrupt::" in front of all identifiers 2) convert
> > > operators to the wordy const functions like "union".  It supports boolean
> > > operators "&", "|", "^", "!" and parentheses, with a relatively simple
> > > recursive descent parser that's implemented in qemu_api_macros.
> > >
> > > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > > ---
> > >  rust/Cargo.lock                  |   7 +
> > >  rust/Cargo.toml                  |   1 +
> > >  rust/bits/Cargo.toml             |  19 ++
> > >  rust/bits/meson.build            |  12 +
> > >  rust/bits/src/lib.rs             | 441 +++++++++++++++++++++++++++++++
> > >  rust/meson.build                 |   1 +
> > >  rust/qemu-api-macros/src/bits.rs | 227 ++++++++++++++++
> > >  rust/qemu-api-macros/src/lib.rs  |  12 +
> > >  8 files changed, 720 insertions(+)
> > >  create mode 100644 rust/bits/Cargo.toml
> > >  create mode 100644 rust/bits/meson.build
> > >  create mode 100644 rust/bits/src/lib.rs
> > >  create mode 100644 rust/qemu-api-macros/src/bits.rs
> >
> > > diff --git a/rust/bits/src/lib.rs b/rust/bits/src/lib.rs
> > > new file mode 100644
> > > index 00000000000..d80a6263f1e
> > > --- /dev/null
> > > +++ b/rust/bits/src/lib.rs
> > > @@ -0,0 +1,441 @@
> >
> > This (and other new .rs files) needs SPDX-License-Identifier
> 
> We should probably lint for this in .rs files.

Strengthened from a recommendation to a mandate in:

https://lists.nongnu.org/archive/html/qemu-devel/2025-05/msg04968.html


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


