Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F03C25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 08:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGx5z-00067G-TT; Tue, 11 Jun 2024 04:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sGx5x-00066n-9b
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 04:43:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sGx5u-0006i3-51
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 04:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718095384;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=x+U7iNiKAT721w3Nqtv6tMGdBcz5Gb4cX/xbmOjQDTU=;
 b=Z5jbCKWc1ixme7MDH27JnlXrUMLyciPDYNrZ+j0uPjxIZCFBWw6job5XHyy+mB9l8vIFa7
 Hz5B5bpYbp4Hfbb44a0uieWp80fiIqt4uV7AJoD/knjWEwCoHksVrihtopReYkRvIX47vI
 x42Y8QT1s5mqrfLT9c5jX1ontOIFFI0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-kMuVG7-YNFaKKzVbSP9HEA-1; Tue,
 11 Jun 2024 04:43:00 -0400
X-MC-Unique: kMuVG7-YNFaKKzVbSP9HEA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF3D319560B1; Tue, 11 Jun 2024 08:42:58 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.73])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F7E719560AA; Tue, 11 Jun 2024 08:42:53 +0000 (UTC)
Date: Tue, 11 Jun 2024 09:42:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?B?QmVubsOp?= e <alex.bennee@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [RFC PATCH v1 0/6] Implement ARM PL011 in Rust
Message-ID: <ZmgOCjCEzj9IYwgV@redhat.com>
References: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
 <CAJSP0QU2Y_mNtYQtPbahnvj1eLLTu2Z-f4z-6VZgSSxqgVnPbQ@mail.gmail.com>
 <evsu7.aus3yo6r56i@linaro.org>
 <CAJSP0QWLe6yPDE3rPztx=oS0g+vKT9W3GykrNU0EQZcaW06sog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJSP0QWLe6yPDE3rPztx=oS0g+vKT9W3GykrNU0EQZcaW06sog@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

On Mon, Jun 10, 2024 at 04:47:33PM -0400, Stefan Hajnoczi wrote:
> On Mon, 10 Jun 2024 at 16:27, Manos Pitsidianakis
> <manos.pitsidianakis@linaro.org> wrote:
> >
> > On Mon, 10 Jun 2024 22:59, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > >> Should QEMU use third-party dependencies?
> > >> -----------------------------------------
> > >> [shouldqemuusethirdparty] Back to [TOC]
> > >>
> > >> In my personal opinion, if we need a dependency we need a strong
> > >> argument for it. A dependency needs a trusted upstream source, a QEMU
> > >> maintainer to make sure it us up-to-date in QEMU etc.
> > >>
> > >> We already fetch some projects with meson subprojects, so this is not a
> > >> new reality. Cargo allows you to define "locked" dependencies which is
> > >> the same as only fetching specific commits by SHA. No suspicious
> > >> tarballs, and no disappearing dependencies a la left-pad in npm.
> > >>
> > >> However, I believe it's worth considering vendoring every dependency by
> > >> default, if they prove to be few, for the sake of having a local QEMU
> > >> git clone buildable without network access.
> > >
> > >Do you mean vendoring by committing them to qemu.git or just the
> > >practice of running `cargo vendor` locally for users who decide they
> > >want to keep a copy of the dependencies?
> >
> >
> > Committing, with an option to opt-out. They are generally not big in
> > size. I am not of strong opinion on this one, I'm very open to
> > alternatives.
> 
> Fedora and Debian want Rust applications to use distro-packaged
> crates. No vendoring and no crates.io online access. It's a bit of a
> pain because Rust developers need to make sure their code works with
> whatever version of crates Fedora and Debian provide.

NB Fedora isn't actually that strict for Rust.  The "no vendoring"
policy is merely a "SHOULD", rather than a "MUST" requirement:

  https://docs.fedoraproject.org/en-US/packaging-guidelines/Rust/#_vendored_dependencies

which is a more pragmmatic approach to the real world packaging where
there's potentially 100's of deps in an application chain.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


