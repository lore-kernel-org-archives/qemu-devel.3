Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D13EEB7EAC
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 10:10:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxjAk-0008Sq-IT; Wed, 04 Mar 2026 05:09:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxjAi-0008SD-L5
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 05:09:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxjAg-000746-DC
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 05:09:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772618977;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=B/6X5fTDGj0i/fZXZNYFYvBOTHM2Di5sqSD/Sm0ITXE=;
 b=i6xdbcqLM1B2Q5iGT6su5L+8RHTGstZzj/w6+qJCrBLL5KarEovhjGk8135z4zVQ7P1y7k
 XoJOjDh/YMrs3pcxnAFM7YW3rwiY/vY4tJMRTUj2sJPhAQa5L+snaWaZYgL4jwydAZD3h5
 iGcNHouJVdBV1kbu+El7plZkyCsm28Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-FPMe1sYBPA6ktGMynC3uOA-1; Wed,
 04 Mar 2026 05:09:33 -0500
X-MC-Unique: FPMe1sYBPA6ktGMynC3uOA-1
X-Mimecast-MFC-AGG-ID: FPMe1sYBPA6ktGMynC3uOA_1772618972
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8308D1956095; Wed,  4 Mar 2026 10:09:32 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.75])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F7BF1958DC2; Wed,  4 Mar 2026 10:09:29 +0000 (UTC)
Date: Wed, 4 Mar 2026 10:09:26 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yodel Eldar <yodel.eldar@yodel.dev>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC PATCH v2] configure: Use clang for sanitizer builds or
 disable Werror
Message-ID: <aagE1kDn1Y1Q8S5h@redhat.com>
References: <20260303012054.484837-1-yodel.eldar@yodel.dev>
 <f999293f-c424-497a-8bca-2634bcd68108@yodel.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f999293f-c424-497a-8bca-2634bcd68108@yodel.dev>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Tue, Mar 03, 2026 at 07:08:25PM -0600, Yodel Eldar wrote:
> +Daniel (thanks for your comments)
> 
> On 02/03/2026 19:20, Yodel Eldar wrote:
> > From: Yodel Eldar <yodel.eldar@yodel.dev>
> > 
> > Builds with --enable-{asan,tsan,safe-stack} fail under GCC, so use
> > clang if available, otherwise disable the treatment of warnings as
> > errors.
> > 
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3006
> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
> > ---
> > Hi,
> > 
> > The previous version only disabled Werror whenever `--skip-meson` wasn't
> > used and the build occurred in a git repo, but this change should
> > probably apply to all types of builds. So, let's use meson_option_add
> > to globally disable Werror instead; IIUC (and according to my testing),
> > this will override the value in config-meson.cross.new.
> > 
> > I'm still not sure if we should be disabling Werror for ubsan, even
> > though it's not currently breaking builds with GCC; please let me know
> > what you think.
> > 
> > Special thanks to Peter for looking into the cause of the reports around
> > this, for sharing the findings, and suggesting approaches to resolve it.
> > I couldn't pick one over the other, so I went with using clang when
> > available with Werror disable as a fallback; please let me know if you
> > think this is an XOR kind of policy decision.
> > 
> > Link to RFCv1:
> > https://lore.kernel.org/qemu-devel/20260302210039.261325-1-yodel.eldar@yodel.dev/
> > 
> > Link to mentioned discussion:
> > https://lore.kernel.org/qemu-devel/CAFEAcA88hc4UsgpuPXBWpbeN0tW26159kPn7jx2J9erBA5DLBw@mail.gmail.com/
> > 
> > v2:
> > - Fix misnomer in commit message
> > - Simplify condition by using the same variable for all sanitizers
> > - Use meson_option_add to disable Werror
> > 
> > Thanks,
> > Yodel
> > ---
> >   configure | 18 ++++++++++++++++++
> >   1 file changed, 18 insertions(+)
> > 
> > diff --git a/configure b/configure
> > index 5e114acea2..e457e8a17d 100755
> > --- a/configure
> > +++ b/configure
> > @@ -762,6 +762,12 @@ for opt do
> >     ;;
> >     --wasm64-32bit-address-limit)
> >     ;;
> > +  --enable-asan) use_sanitizer="yes"
> > +  ;;
> > +  --enable-tsan) use_sanitizer="yes"
> > +  ;;
> > +  --enable-safe-stack) use_sanitizer="yes"
> > +  ;;
> >     # everything else has the same name in configure and meson
> >     --*) meson_option_parse "$opt" "$optarg"
> >     ;;
> > @@ -771,6 +777,18 @@ for opt do
> >     esac
> >   done
> > +if test "$use_sanitizer" = "yes"; then
> > +    if has clang; then
> > +        echo "Sanitizer requested: setting compiler suite to clang"
> > +        cc=clang
> > +        cxx=clang++
> > +        host_cc=clang
> > +    else
> > +        echo "Sanitizer requested: disabling Werror for non-clang compilers"
> > +        meson_option_add -Dwerror=false
> > +    fi
> > +fi
> > +
> >   if ! test -e "$source_path/.git"
> >   then
> >       git_submodules_action="validate"
> 
> We could treat the rtl8139 as a one-off by carving out the
> offending code with a GCC pragma or finagling GCC into cooperation
> by substituting eth_payload_data with the expression assigned to it
> (thank you, Thomas and Daniel, respectively); indeed, AFAICT the
> rtl8139 is currently the only code that triggers the GCC bug
> (and is overdue for a refactor/cleanup), so it's tempting to go with
> either of these helpful suggestions; *however*, until the GCC team
> fixes their buggy pairing between sanitizer and -Werror
> (a pairing that they themselves disavow [1]), IMHO there's a
> significant risk of recurrence if we went with either option, and
> it's not clear to me whether reviewers will be able easily spot the
> next one before it's too late (post-acceptance).

There is a risk, but given that we've only got 1 example across
the QEMU codebase, I don't think I'd classify that as significant.
If we already had 10+ locations where it hit, then that would be
a different story

As long as the number of situations where we hit this in QEMU
remains low (say < 5), then I think a targetted use of Pragmas
to temp disable warnings is satisfactory to deal with it.

> I'm definitely onboard with Daniel's warning message in meson whenever
> the user: 1) explicitly opts for gcc/g++, 2) enables sanitizers, and 3)
> -Werror is enabled. At the risk of overengineering, though, what if we
> made it an error message instead, and gave users an escape hatch like
> `--force-werror-sanitizers` (name TBD)? I can see that being too much,
> but it may prevent some grief if they missed the warning, and the build
> breaks several minutes later. WDYT? It's not included in the diff below,
> but I'll gladly add it to v3 if there's interest; if not, I'll go with
> the warning message as suggested.
> 
> Thanks,
> Yodel
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Instrumentation-Options.html (Peter)
> [2] https://gitlab.com/qemu-project/qemu/-/blob/master/configure?ref_type=heads#L302-315
> 


> @@ -286,15 +292,25 @@ static="no"
>  # Preferred compiler:
>  #  ${CC} (if set)
>  #  ${cross_prefix}gcc (if cross-prefix specified)
> -#  system compiler
> +#  clang if sanitizer requested, otherwise system compiler
>  if test -z "${CC}${cross_prefix}"; then
> -  cc="cc"
> +  if test "$use_sanitizers" = "yes" && has clang; then
> +    cc=clang
> +    echo "Sanitizer requested: setting cc to clang"

I really don't want to see us changing compiler choice as a side
effect of enabling sanitizers.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


