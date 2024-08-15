Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B87C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 15:07:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sec4B-0008CX-So; Thu, 15 Aug 2024 11:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sec4A-00085a-7e
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 11:07:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sec3o-0002id-AG
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 11:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723734403;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jqHpAnMw0F+Vhqu50n7PycRT6hCvYh6HVrX37OXsHUc=;
 b=P4+n3g2V49rhgH45pIzrDNEM/Ii3Dr7zDebl1eOcYctTygdxO7uADY1pL0tC4eu3CD1/rS
 2zjO+vIU1mTMdElt+T3qQXhSLkwPOYAariCwRJgYDTVR/VIVgNFMFImKsun10LNqozTXOj
 kz6ucrHCG/nW5ey5oFvmRAB4AcV75uE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-260-9Y3gDyCrMCe6y9L-jMAKbg-1; Thu,
 15 Aug 2024 11:06:38 -0400
X-MC-Unique: 9Y3gDyCrMCe6y9L-jMAKbg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E180C18EA8AF; Thu, 15 Aug 2024 15:06:31 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.137])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 97EE1300070A; Thu, 15 Aug 2024 15:06:23 +0000 (UTC)
Date: Thu, 15 Aug 2024 16:06:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 ARM TCG CPUs <qemu-arm@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Junjie Mao <junjie.mao@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, rowan.hart@intel.com,
 Mads Ynddal <mads@ynddal.dk>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v7 6/7] rust: add crate to expose bindings and interfaces
Message-ID: <Zr4ZbOHR9Sc10YSX@redhat.com>
References: <20240815-rust-pl011-v7-0-975135e98831@linaro.org>
 <20240815-rust-pl011-v7-6-975135e98831@linaro.org>
 <9f6c96fd-bb0c-4014-bba1-70986f4bb384@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f6c96fd-bb0c-4014-bba1-70986f4bb384@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, Aug 15, 2024 at 04:01:17PM +0200, Philippe Mathieu-Daudé wrote:
> Hi Manos,
> 
> On 15/8/24 13:42, Manos Pitsidianakis wrote:
> > Add rust/qemu-api, which exposes rust-bindgen generated FFI bindings and
> > provides some declaration macros for symbols visible to the rest of
> > QEMU.
> > 
> > Co-authored-by: Junjie Mao <junjie.mao@intel.com>
> > Co-authored-by: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Junjie Mao <junjie.mao@intel.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > ---
> >   MAINTAINERS                       |   6 ++
> >   rust/meson.build                  |   9 +++
> >   rust/qemu-api/.gitignore          |   2 +
> >   rust/qemu-api/Cargo.lock          |   7 +++
> >   rust/qemu-api/Cargo.toml          |  23 +++++++
> >   rust/qemu-api/README.md           |  17 +++++
> >   rust/qemu-api/build.rs            |  13 ++++
> >   rust/qemu-api/meson.build         |  17 +++++
> >   rust/qemu-api/rustfmt.toml        |   1 +
> >   rust/qemu-api/src/bindings.rs     |   7 +++
> >   rust/qemu-api/src/definitions.rs  | 108 ++++++++++++++++++++++++++++++++
> >   rust/qemu-api/src/device_class.rs | 128 ++++++++++++++++++++++++++++++++++++++
> >   rust/qemu-api/src/lib.rs          | 100 +++++++++++++++++++++++++++++
> >   rust/qemu-api/src/tests.rs        |  48 ++++++++++++++
> >   rust/rustfmt.toml                 |   7 +++
> >   15 files changed, 493 insertions(+)

> > diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
> > new file mode 100644
> > index 0000000000..51260cbe42
> > --- /dev/null
> > +++ b/rust/qemu-api/Cargo.toml
> > @@ -0,0 +1,23 @@
> > +[package]
> > +name = "qemu_api"
> > +version = "0.1.0"
> > +edition = "2021"
> 
> > +license = "GPL-2.0 OR GPL-3.0-or-later"
> 
> in particular explaining the license choice.

Semantically this is an overly verbose way of saying
"GPL-2.0-or-later", so just simplify this.

> Should all rust code use it?

GPL-2.0-or-later is what we expect all new QEMU contributions to be
licensed as, regardless of language[1], so this looks desirable.

With regards,
Daniel

[1] unless they're derived from one of the few pieces of code under
    different terms
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


