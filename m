Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD4BC52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 10:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scMPl-0007rD-Nf; Fri, 09 Aug 2024 06:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1scMPj-0007kN-C0
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 06:00:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1scMPh-0003sl-9C
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 06:00:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723197600;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=408B7Rgl2doHbjup/9Fd6YOYEhE0YB1FzGa1vPpC/UQ=;
 b=BSG70lNSaHyMVG/+nmaEUUsgqjMjhX4PsXohGmawbV+bpMFyaAzpm1fzaZB0GaFBcyuXwN
 YM03r9Lefu0bcGZOrbNK6TAbUWij6a0N/yb9kCBLAGWlrazjU3pnMzyYdFqotmZFIcNDgN
 44NJVAeC61If4AaekcDQE0iMS8g8HdQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-wa1lcUNjMRGQUSYK-MkcKw-1; Fri,
 09 Aug 2024 05:59:56 -0400
X-MC-Unique: wa1lcUNjMRGQUSYK-MkcKw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 424381944B29; Fri,  9 Aug 2024 09:59:54 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.27])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3332419560A3; Fri,  9 Aug 2024 09:59:48 +0000 (UTC)
Date: Fri, 9 Aug 2024 10:59:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Octavian Purdila <tavip@google.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, stefanst@google.com,
 alex.bennee@linaro.org, thuth@redhat.com, peter.maydell@linaro.org,
 marcandre.lureau@redhat.com, alistair@alistair23.me,
 crosa@redhat.com, bleal@redhat.com
Subject: Re: [RFC PATCH 03/23] scripts: add script to generate C header files
 from SVD XML files
Message-ID: <ZrXokj7du0YgRHpz@redhat.com>
References: <20240805201719.2345596-1-tavip@google.com>
 <20240805201719.2345596-4-tavip@google.com>
 <CAFn=p-abeXP+dUtp_gwH3dcD5DT-sTAFg=udVugrzcU1r8fXpA@mail.gmail.com>
 <CAGWr4cQL_LMWmEUdoPprRSp2k=CkQ0UJp5Q45qbAtUvvE6fDHg@mail.gmail.com>
 <9080f7e5-a40d-4cbd-a734-74578dd27894@linaro.org>
 <CABgObfY1hGKhBjwjDeKSSd5uxbe8Lc5=hVL6psB0NLbnX1bJ0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfY1hGKhBjwjDeKSSd5uxbe8Lc5=hVL6psB0NLbnX1bJ0g@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Aug 09, 2024 at 11:42:38AM +0200, Paolo Bonzini wrote:
> On Fri, Aug 9, 2024 at 11:30 AM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
> >
> > On 9/8/24 00:30, Octavian Purdila wrote:
> > > On Thu, Aug 8, 2024 at 2:56 PM John Snow <jsnow@redhat.com> wrote:
> >
> >
> > >>> diff --git a/configure b/configure
> > >>> index 5ad1674ca5..811bfa5d54 100755
> > >>> --- a/configure
> > >>> +++ b/configure
> > >>> @@ -956,7 +956,7 @@ mkvenv="$python ${source_path}/python/scripts/mkvenv.py"
> > >>>   # Finish preparing the virtual environment using vendored .whl files
> > >>>
> > >>>   $mkvenv ensuregroup --dir "${source_path}/python/wheels" \
> > >>> -     ${source_path}/pythondeps.toml meson || exit 1
> > >>> +     ${source_path}/pythondeps.toml meson svd-gen-header || exit 1
> > >>
> > >
> > > Hi John,
> > >
> > > Thanks for reviewing!
> > >
> > >>
> > >> I haven't read the rest of this series; I'm chiming in solely from the build/python maintainer angle. Do we *always* need pysvd, no matter how QEMU was configured? Adding it to the meson line here is a very big hammer.
> > >>
> > >
> > > I think the minimum we can do is to install it only if CONFIG_ARM is
> > > enabled. That might change in the future if the models we create with
> > > pysvd are enabled for other architectures.
> >
> > Similarly on how we manage libfdt, you can have meson defines
> > SVDGEN as:
> >
> >    config_host_data.set('CONFIG_SVDGEN', svd_gen_header.found())
> >
> > Then declare SVDGEN in Kconfig.host, and finally use in the Kconfigs:
> 
> That would force people to install pysvd on the host, which is a pity
> for such a small and little-known library.  We have used submodules
> in the past for much larger and common dependencies, for example
> capstone.

As mentioned elsewhere in thsi threads, IMHO we shoud not be running
this generator during the build at all. It should be run once to
create the headers needed for a particular device & the output committed
to QEMU. There after any changes to the header (if any) need reviewing
to ensure they don't imply an impact on guest ABI. This avoids having
the 8.6 MB XML file in QEMU git too, as well as the pysvd dep on the
host. Only the very rare times when we create a new device would need
to have the pysvd code & XML.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


