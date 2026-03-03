Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A99BEC0487
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 10:01:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxMZ9-00066w-BR; Tue, 03 Mar 2026 05:01:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxMZ7-00061U-Bb
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 05:01:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxMZ4-0003O7-Um
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 05:01:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772532076;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IcLfc7NvE4QgdTgTr0yMNuo2AEifQaJfPzjZX6S4xR4=;
 b=ccpGbkTEEyxVtiT/wRTWUUIWC05xvHXRtAS9wZu2QJpIXQrcJg0bmAfswKIWEW1OwR/9DS
 ovymUO2xOQIM5tKblNrrERhn/x61oaierQEqZjMOoQzWqP9G3IN40WLKXhvnhEmTOdt3MC
 mlurZjaXGF+E4rxYD4G2Q0XFsFFVeZQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-Mqx3Zps9P3yaCNgp3CVdfg-1; Tue,
 03 Mar 2026 05:01:15 -0500
X-MC-Unique: Mqx3Zps9P3yaCNgp3CVdfg-1
X-Mimecast-MFC-AGG-ID: Mqx3Zps9P3yaCNgp3CVdfg_1772532074
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1284A1800464; Tue,  3 Mar 2026 10:01:14 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.185])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C2D581956053; Tue,  3 Mar 2026 10:01:11 +0000 (UTC)
Date: Tue, 3 Mar 2026 10:01:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Yodel Eldar <yodel.eldar@yodel.dev>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [RFC PATCH v2] configure: Use clang for sanitizer builds or
 disable Werror
Message-ID: <aaaxZKWz7NlJSD2I@redhat.com>
References: <20260303012054.484837-1-yodel.eldar@yodel.dev>
 <aaadd0B4kP9amEbz@redhat.com>
 <CAFEAcA_YMukxSh0YWsxADasT69BZ=BR1Q1NkGeGWzjXQoUifSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA_YMukxSh0YWsxADasT69BZ=BR1Q1NkGeGWzjXQoUifSg@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Mar 03, 2026 at 09:36:45AM +0000, Peter Maydell wrote:
> On Tue, 3 Mar 2026 at 08:41, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Mon, Mar 02, 2026 at 07:20:54PM -0600, Yodel Eldar wrote:
> > > From: Yodel Eldar <yodel.eldar@yodel.dev>
> > >
> > > Builds with --enable-{asan,tsan,safe-stack} fail under GCC, so use
> > > clang if available, otherwise disable the treatment of warnings as
> > > errors.
> > >
> > > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3006
> > > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > > Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
> > > ---
> > > Hi,
> > >
> > > The previous version only disabled Werror whenever `--skip-meson` wasn't
> > > used and the build occurred in a git repo, but this change should
> > > probably apply to all types of builds. So, let's use meson_option_add
> > > to globally disable Werror instead; IIUC (and according to my testing),
> > > this will override the value in config-meson.cross.new.
> > >
> > > I'm still not sure if we should be disabling Werror for ubsan, even
> > > though it's not currently breaking builds with GCC; please let me know
> > > what you think.
> > >
> > > Special thanks to Peter for looking into the cause of the reports around
> > > this, for sharing the findings, and suggesting approaches to resolve it.
> > > I couldn't pick one over the other, so I went with using clang when
> > > available with Werror disable as a fallback; please let me know if you
> > > think this is an XOR kind of policy decision.
> >
> > In the bug
> >
> > >
> > > Link to RFCv1:
> > > https://lore.kernel.org/qemu-devel/20260302210039.261325-1-yodel.eldar@yodel.dev/
> > >
> > > Link to mentioned discussion:
> > > https://lore.kernel.org/qemu-devel/CAFEAcA88hc4UsgpuPXBWpbeN0tW26159kPn7jx2J9erBA5DLBw@mail.gmail.com/
> > >
> > > v2:
> > > - Fix misnomer in commit message
> > > - Simplify condition by using the same variable for all sanitizers
> > > - Use meson_option_add to disable Werror
> > >
> > > Thanks,
> > > Yodel
> > > ---
> > >  configure | 18 ++++++++++++++++++
> > >  1 file changed, 18 insertions(+)
> > >
> > > diff --git a/configure b/configure
> > > index 5e114acea2..e457e8a17d 100755
> > > --- a/configure
> > > +++ b/configure
> > > @@ -762,6 +762,12 @@ for opt do
> > >    ;;
> > >    --wasm64-32bit-address-limit)
> > >    ;;
> > > +  --enable-asan) use_sanitizer="yes"
> > > +  ;;
> > > +  --enable-tsan) use_sanitizer="yes"
> > > +  ;;
> > > +  --enable-safe-stack) use_sanitizer="yes"
> > > +  ;;
> > >    # everything else has the same name in configure and meson
> > >    --*) meson_option_parse "$opt" "$optarg"
> > >    ;;
> > > @@ -771,6 +777,18 @@ for opt do
> > >    esac
> > >  done
> > >
> > > +if test "$use_sanitizer" = "yes"; then
> > > +    if has clang; then
> > > +        echo "Sanitizer requested: setting compiler suite to clang"
> > > +        cc=clang
> > > +        cxx=clang++
> > > +        host_cc=clang
> > > +    else
> > > +        echo "Sanitizer requested: disabling Werror for non-clang compilers"
> > > +        meson_option_add -Dwerror=false
> > > +    fi
> > > +fi
> >
> > GCC documents the possibility of false positives, but I would consider
> > that caveat to apply to CLang too. It may simply have different false
> > positives or at a lower rate.
> 
> I'm told that clang/LLVM doesn't have any "middle-end warnings", so
> it won't have the same problem that the sanitizers might change IR code
> in a way that results in a warning firing that didn't before. So I
> think this "sanitizers change warning behaviour" is specific to GCC.
> 
> > If using sanitizers, it is expected behaviour that there can be false
> > positives, and if the user doesn't want the build to break as a result
> > of that, then *the user* can choose to disable -Werror with the suitable
> > configure warnings.
> 
> It is expected *for GCC*. I don't think it's expected for LLVM/clang.

Oh, so you mean CLang errors from sanitizers are not influenced by
the use of -Werror ?

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


