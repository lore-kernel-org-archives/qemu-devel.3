Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B63C25B7E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD1Hl-0000n5-8G; Fri, 31 May 2024 08:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sD1Hj-0000ma-OF
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:23:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sD1Hh-0007De-CZ
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717158179;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=sxRViaCgm9M7jIFrlEW6bG2tmZtmG+hUMkvZD5Y9Bvg=;
 b=ROfSxUzM9m8p93+7B8gcCm9HfD5UWUte9XMXImeR3QbsynI/PZiM5Rn7HSpFqIbYzGFSM0
 mycrkE0CkgSIQeQ3TVFwwtkZTIJIRe/x4HHzPobnslVep5nkplGR/Uf0yI/2dmdH5glo/i
 UbvoFaXNhVL+LmGSCZ+dmT6H/nWGRmQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-NjiBk-8rPMCVUHRKjkPKzg-1; Fri, 31 May 2024 08:22:56 -0400
X-MC-Unique: NjiBk-8rPMCVUHRKjkPKzg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 967D185A58C;
 Fri, 31 May 2024 12:22:55 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C1CE140C6EB7;
 Fri, 31 May 2024 12:22:53 +0000 (UTC)
Date: Fri, 31 May 2024 13:22:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Mads Ynddal <mads@ynddal.dk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?B?QmVubu+/vWU=?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC 1/6] scripts/simpletrace-rust: Add the basic cargo framework
Message-ID: <ZlnBGwk29Ds9FjUA@redhat.com>
References: <20240527081421.2258624-1-zhao1.liu@intel.com>
 <20240527081421.2258624-2-zhao1.liu@intel.com>
 <20240527200504.GB913874@fedora.redhat.com>
 <ZlWNk46MF5uNa+ZC@intel.com>
 <20240528141401.GB993828@fedora.redhat.com>
 <Zlc79ZhJavATdvSs@intel.com>
 <20240529184103.GD1203999@fedora.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240529184103.GD1203999@fedora.redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, May 29, 2024 at 02:41:03PM -0400, Stefan Hajnoczi wrote:
> On Wed, May 29, 2024 at 10:30:13PM +0800, Zhao Liu wrote:
> > Hi Stefan,
> > 
> > On Tue, May 28, 2024 at 10:14:01AM -0400, Stefan Hajnoczi wrote:
> > > Date: Tue, 28 May 2024 10:14:01 -0400
> > > From: Stefan Hajnoczi <stefanha@redhat.com>
> > > Subject: Re: [RFC 1/6] scripts/simpletrace-rust: Add the basic cargo
> > >  framework
> > > 
> > > On Tue, May 28, 2024 at 03:53:55PM +0800, Zhao Liu wrote:
> > > > Hi Stefan,
> > > > 
> > > > [snip]
> > > > 
> > > > > > diff --git a/scripts/simpletrace-rust/.rustfmt.toml b/scripts/simpletrace-rust/.rustfmt.toml
> > > > > > new file mode 100644
> > > > > > index 000000000000..97a97c24ebfb
> > > > > > --- /dev/null
> > > > > > +++ b/scripts/simpletrace-rust/.rustfmt.toml
> > > > > > @@ -0,0 +1,9 @@
> > > > > > +brace_style = "AlwaysNextLine"
> > > > > > +comment_width = 80
> > > > > > +edition = "2021"
> > > > > > +group_imports = "StdExternalCrate"
> > > > > > +imports_granularity = "item"
> > > > > > +max_width = 80
> > > > > > +use_field_init_shorthand = true
> > > > > > +use_try_shorthand = true
> > > > > > +wrap_comments = true
> > > > > 
> > > > > There should be QEMU-wide policy. That said, why is it necessary to customize rustfmt?
> > > > 
> > > > Indeed, but QEMU's style for Rust is currently undefined, so I'm trying
> > > > to add this to make it easier to check the style...I will separate it
> > > > out as a style policy proposal.
> > > 
> > > Why is a config file necessary? QEMU should use the default Rust style.
> > > 
> > 
> > There are some that may be overdone, but I think some basic may still
> > be necessary, like "comment_width = 80", "max_width = 80",
> > "wrap_comments". Is it necessary to specify the width? As C.
> 
> Let's agree to follow the Rust coding style from the start, then the
> problem is solved. My view is that deviating from the standard Rust
> coding style in order to make QEMU Rust code resemble QEMU C code is
> less helpful than following Rust conventions so our Rust code looks like
> Rust.

Agreed. The value of a language wide standard is undermined if apps
diverge from it.

All code style rules come down to bike shedding, and by simply adopting
the Rust community defaults, we avoid endless debates as to what style
is best, and stay aligned with the rest of the Rust community who mostly
won't override defaults for rustfmt.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


