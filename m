Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CA9C3DA41
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 16:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQrJ2-0006Xv-WB; Mon, 08 Jul 2024 12:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sQrJ1-0006Vo-7C
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 12:33:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sQrIv-00056x-Qz
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 12:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720456409;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=xi/RORaJtup4y0JQaoatG6EuvaPE+SuZE7eUqube6Kk=;
 b=LugnnCWgXWr8t8CpwNserPdh77xKb3vl1l/5fLfp2k25tmpbU66spsKOT54j4whQ20B09w
 j3rU1vI3OGOzcrFQkNgg/wRA4NuY0OZx5/zpBYllTbjXlSxsuqQdFHKoaglcP1AdofC3li
 +Jvlh0OS0nwYpZpbSvInOIpy4U06tU0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-OGGFO4DiOmCJxWJwSGIb6Q-1; Mon,
 08 Jul 2024 12:33:25 -0400
X-MC-Unique: OGGFO4DiOmCJxWJwSGIb6Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C5E219103CE; Mon,  8 Jul 2024 16:33:21 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9205A3000181; Mon,  8 Jul 2024 16:33:15 +0000 (UTC)
Date: Mon, 8 Jul 2024 17:33:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH v4 0/7] Add Rust support, implement ARM PL011
Message-ID: <ZowUyFX7zcK1FvuG@redhat.com>
References: <rust-pl011-rfc-v4.git.manos.pitsidianakis@linaro.org>
 <8dfd1047-436d-4157-83cb-9cad399544fe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8dfd1047-436d-4157-83cb-9cad399544fe@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Jul 08, 2024 at 06:26:22PM +0200, Paolo Bonzini wrote:
> On 7/4/24 14:15, Manos Pitsidianakis wrote:
> > Changes from v3->v4:
> > - Add rust-specific files to .gitattributes
> > - Added help text to scripts/cargo_wrapper.py arguments (thanks Stephan)
> > - Split bindings separate crate
> > - Add declarative macros for symbols exported to QEMU to said crate
> > - Lowered MSRV to 1.77.2
> > - Removed auto-download and install of bindgen-cli
> > - Fixed re-compilation of Rust objects in case they are missing from
> >    filesystem
> > - Fixed optimized builds by adding #[used] (thanks Pierrick for the help
> >    debugging this)
> 
> I think the largest issue is that I'd rather have a single cargo build using
> a virtual manifest, because my hunch is that it'd be the easiest path
> towards Kconfig integration.  But it's better to do this after merge, as the
> changes are pretty large.  It's also independent from any other changes
> targeted at removing unsafe code, so no need to hold back on merging.
> 
> Other comments I made that should however be addressed before merging, from
> most to least important:
> 
> - TODO comments when the code is doing potential undefined behavior
> 
> - module structure should IMO resemble the C part of the tree
> 
> - only generate bindings.rs.inc once
> 
> - a couple abstractions that I'd like to have now: a trait to store the CStr
> corresponding to the structs, and one to generate all-zero structs without
> having to type "unsafe { MaybeUninit::zeroed().assume_init() }"
> 
> - I pointed out a couple lints that are too broad and should be enabled
> per-file, even if right now it's basically all files that include them.
> 
> - add support for --cargo and CARGO environment variables (if my patch works
> without too much hassle)
> 
> - I'd like to use ctor instead of non-portable linker magic, and the cstr
> crate instead of CStr statics or c""
> 
> - please check if -Wl,--whole-archive can be replaced with link_whole:
> 
> - probably, until Rust is enabled by default we should treat dependencies as
> a moving target and not commit Cargo.lock files.  In the meanwhile we can
> discuss how to handle them.
> 
> And a few aesthetic changes on top of this.

This series is still missing changes to enable build on all targets
during CI, including cross-compiles, to prove that we're doing the
correct thing on all our targetted platforms. That's a must have
before considering it suitable for merge.

I also believe we should default to enabling rust toolchain by
default in configure, and require and explicit --without-rust
to disable it, *despite* it not technically being a mandatory
feature....yet.

This is to give users a clear message that Rust is likely to
become a fundamental part of QEMU, so they need to give feedback
if they hit any problems / have use cases we've not anticipated
that are problematic wrt Rust.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


