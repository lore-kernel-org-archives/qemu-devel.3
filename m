Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21724D1D478
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 15:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdrvN-0007M7-2e; Thu, 08 Jan 2026 10:27:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdrvL-0007Lr-01
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:27:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdrvJ-0006m0-C5
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:27:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767886060;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fZ136qR++A81Z/l2i0a5iNWWybBYz7B5WJ5N14ilHyI=;
 b=iiva22GEvYJewa67KBB/qZoAobogIrqv4BtnuqUsm0qmUxZKvtICSj5UUBhINW+qVi9iIc
 bQOWU5NjJyI8on/RakFDz6jmFiUFavcJBakiT2h/GI7W8fRZDxrNllkTml5ObAp34imiP/
 1/SJxIDf68jlDz3ahtzOE/l4wI0ujyM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422-b0hN_5KMNQO69LQ6kF-Urw-1; Thu,
 08 Jan 2026 10:27:38 -0500
X-MC-Unique: b0hN_5KMNQO69LQ6kF-Urw-1
X-Mimecast-MFC-AGG-ID: b0hN_5KMNQO69LQ6kF-Urw_1767886057
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 515391955DC7; Thu,  8 Jan 2026 15:27:37 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5508C180066A; Thu,  8 Jan 2026 15:27:35 +0000 (UTC)
Date: Thu, 8 Jan 2026 15:27:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] meson: disable libatomic with GCC >= 16
Message-ID: <aV_M5KbihAMR48zn@redhat.com>
References: <20260108141407.2151817-1-berrange@redhat.com>
 <56548949-8afd-4bcc-b539-bfb1a28c3987@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56548949-8afd-4bcc-b539-bfb1a28c3987@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jan 08, 2026 at 04:15:38PM +0100, Paolo Bonzini wrote:
> On 1/8/26 15:14, Daniel P. Berrangé wrote:
> > Historically it was required to ask for libatomic explicitly with
> > -latomic, but with GCC >= 16 apps will get linked to libatomic
> > whether they ask for it or not.
> > 
> > This invalidates QEMU's check for atomic op support for int128
> > which explicitly does NOT want to use the libatomic impl. As a
> > result with GCC >= 16, QEMU is now getting linked to libatomic
> > and is activating CONFIG_ATOMIC128. This in turn exposes a bug
> > in GCC's libatomic.a static buld which is incompatible with the
> > use of -static-pie leading to build failures like:
> > 
> >      /usr/bin/ld: /usr/lib/gcc/x86_64-redhat-linux/16/libatomic.a(cas_16_.o): relocation R_X86_64_32 against hidden symbol `libat_compare_exchange_16_i1' can not be used when making a PIE object
> >      /usr/bin/ld: failed to set dynamic section sizes: bad value
> > collect2: error: ld returned 1 exit status
> > 
> > The newly introduced -fno-link-libatomic flag can be used to
> > disable the new automatic linking of libatomic. Setting this in
> > qemu_isa_flags early on ensures that the check for CONFIG_ATOMIC128
> > still works correctly.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   meson.build | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> > 
> > diff --git a/meson.build b/meson.build
> > index db87358d62..56df08c10e 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -445,6 +445,15 @@ if host_arch in ['i386', 'x86_64']
> >     endif
> >   endif
> > +# GCC >= 16 automatically tries to link libatomic for all programs.
> > +#
> > +# QEMU explicitly does NOT want to use libatomic for int128 types.
> > +#
> > +# Later checks assume we won't get atomic ops for int128 without
> > +# explicitly asking for -latomic, so we must disable GCC's new
> > +# automatic linking with the new -fno-link-libatomic flag
> > +qemu_isa_flags += cc.get_supported_arguments('-fno-link-libatomic')
> > +
> >   qemu_common_flags = qemu_isa_flags + qemu_common_flags
> >   if get_option('prefer_static')
> 
> Great. :/  Is there a bug reported for the -static-pie issue?

GCC maintainers tell me that -static-pie is unsupported for anything
except libgcc.a / libstdc++.a:

  https://bugzilla.redhat.com/show_bug.cgi?id=2427891#c10


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


