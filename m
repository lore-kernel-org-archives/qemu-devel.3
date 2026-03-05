Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A85F30928
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 10:19:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy5n1-0001PL-K4; Thu, 05 Mar 2026 05:18:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vy5mz-0001Ow-G3
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:18:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vy5mx-0000cg-H1
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:18:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772705917;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=yaMvoyFzlrQY++8FQqVLLUCiFiVT/s0rP8hK7nW3iG0=;
 b=QtzbVu7Yi56EwTQe8Bmx4iV0kyMj+KSHV7hP346gfHHKpouIMHdSzGy/LS/+WvoZZ9qxyL
 C5RWuD6yzGRJPhj2S0EfO3Gekr5XFwelI8OQT2pPTT5gYNh3ONTKBz5G9v4vlWoOckUKzP
 cQptR81BE/P3e8rs8E5F2OgYWDKQqyM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-sxrMkAc6O7SCzJ0-1TOy6A-1; Thu,
 05 Mar 2026 05:18:33 -0500
X-MC-Unique: sxrMkAc6O7SCzJ0-1TOy6A-1
X-Mimecast-MFC-AGG-ID: sxrMkAc6O7SCzJ0-1TOy6A_1772705912
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 81F0A1800561; Thu,  5 Mar 2026 10:18:32 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.61])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D4861958DC5; Thu,  5 Mar 2026 10:18:29 +0000 (UTC)
Date: Thu, 5 Mar 2026 10:18:26 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yodel Eldar <yodel.eldar@yodel.dev>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC PATCH v2] configure: Use clang for sanitizer builds or
 disable Werror
Message-ID: <aalYcixE-EwlRZhA@redhat.com>
References: <20260303012054.484837-1-yodel.eldar@yodel.dev>
 <f999293f-c424-497a-8bca-2634bcd68108@yodel.dev>
 <8b2855dc-44eb-417f-8a18-f40b1036637a@redhat.com>
 <3a7617d2-ff9d-403c-9733-14f7c1b5ac3d@yodel.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3a7617d2-ff9d-403c-9733-14f7c1b5ac3d@yodel.dev>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
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

On Wed, Mar 04, 2026 at 05:14:47PM -0600, Yodel Eldar wrote:
> On 04/03/2026 01:38, Thomas Huth wrote:
> > On 04/03/2026 02.08, Yodel Eldar wrote:
> > > +Daniel (thanks for your comments)
> > > 
> > > On 02/03/2026 19:20, Yodel Eldar wrote:
> > > > From: Yodel Eldar <yodel.eldar@yodel.dev>
> > > > 
> > > > Builds with --enable-{asan,tsan,safe-stack} fail under GCC, so use
> > > > clang if available, otherwise disable the treatment of warnings as
> > > > errors.
> > > > 
> > > > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3006
> > > > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > > > Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
> > > > ---
> > > > Hi,
> > > > 
> > > > The previous version only disabled Werror whenever `--skip-meson` wasn't
> > > > used and the build occurred in a git repo, but this change should
> > > > probably apply to all types of builds. So, let's use meson_option_add
> > > > to globally disable Werror instead; IIUC (and according to my testing),
> > > > this will override the value in config-meson.cross.new.
> > > > 
> > > > I'm still not sure if we should be disabling Werror for ubsan, even
> > > > though it's not currently breaking builds with GCC; please let me know
> > > > what you think.
> > > > 
> > > > Special thanks to Peter for looking into the cause of the reports around
> > > > this, for sharing the findings, and suggesting approaches to resolve it.
> > > > I couldn't pick one over the other, so I went with using clang when
> > > > available with Werror disable as a fallback; please let me know if you
> > > > think this is an XOR kind of policy decision.
> > > > 
> > > > Link to RFCv1:
> > > > https://lore.kernel.org/qemu-devel/20260302210039.261325-1-
> > > > yodel.eldar@yodel.dev/
> > > > 
> > > > Link to mentioned discussion:
> > > > https://lore.kernel.org/qemu-devel/
> > > > CAFEAcA88hc4UsgpuPXBWpbeN0tW26159kPn7jx2J9erBA5DLBw@mail.gmail.com/

snip

> In that regard, Daniel's substitution method would fare better, but it
> doesn't prevent build breakage before they occur, it may only apply to
> stringop-overflow false positives (TBD), and it may come at the cost
> of code clarity or expressiveness.

This is not at all unique to the sanitizers option. Pretty much every
single major GCC release introduces new logic that triggers compiler
warnings in QEMU which break the build with -Werror, for both genuine
bugs and new false positives.

If you're using -Werror at all, you have to expect frequent breakage
in the future. We fix the genuine bugs and workaround the false
positives. We already have a number of examples of using
"#pragma GCC diagnostic push" for this purpose across the codebase.
I don't see a strong reason to treat this one sanitizers issue
differently from other false positives we address.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


