Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02728CAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 17:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyDNF-0001sG-Sj; Mon, 15 Sep 2025 13:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyDN5-0001pB-3L
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 13:52:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyDMw-0004Jy-AF
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 13:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757958713;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7W8RSfx7qzrFOUteMx8wFTlGaU156BaSbrVP0lVUNhc=;
 b=BGHv08fFT8gAh61Eu35LMq4x/VEv7/Hi33eZ1MpYpKPts5ZznmbrbS52zaHfbVmahA7ehU
 vahwKmKGwBuLXsuFZJcZLRsj86GhD+D3GuoRJMFbwauEHuqm6hn+LiQjh1Q/kaf1vC4I5t
 2iWEH08quqIJY9uCpFL5YQYI9y3cQe0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-wPWO72hnM3ajGEA8ge_j7A-1; Mon,
 15 Sep 2025 13:51:52 -0400
X-MC-Unique: wPWO72hnM3ajGEA8ge_j7A-1
X-Mimecast-MFC-AGG-ID: wPWO72hnM3ajGEA8ge_j7A_1757958711
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 034DE180034C; Mon, 15 Sep 2025 17:51:51 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F19C300021A; Mon, 15 Sep 2025 17:51:49 +0000 (UTC)
Date: Mon, 15 Sep 2025 18:51:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH 00/33] First Rust update for QEMU 10.2
Message-ID: <aMhSMXOiUFs4_9UH@redhat.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
 <CAFEAcA8WZ1Aa==LZv+roEHdaOzoMoX3aoeBbsM4gc3d_Yq=GTA@mail.gmail.com>
 <0c35eccb-890a-47d1-8c54-9945519f6164@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0c35eccb-890a-47d1-8c54-9945519f6164@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 15, 2025 at 04:27:47PM +0200, Paolo Bonzini wrote:
> On 9/11/25 12:04, Peter Maydell wrote:
> > On Mon, 8 Sept 2025 at 11:53, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > > 
> > > This includes:
> > > - bumping MSRV to 1.83.0 to support const_refs_to_static
> > > - Zhao's safe, builder-based implementation of migration callbacks
> > > - Manos's qdev properties macro.  While bit-based properties are
> > >    not yet supported, that's a small change overall.
> > > - the Rust crate split from Marc-André
> > > - adding proc macro aliases in individual crates, also from Marc-André
> > > 
> > > I'm still not convinced about having "bql" depend on "migration",
> > > but I am convinced by the crate split between "util" and "bql",
> > > so we can move the implementation of VMState from "bql" to
> > > "migration" later if needed.
> > > 
> > > For the purpose of getting this in as an easy-to-use base for future
> > > development, I'm disabling CI from Debian and Ubuntu.  The plan is:
> > > - that Debian will require trixie to enable Rust usage
> > > - that Ubuntu will backport 1.83 to its 22.04 and 24.04 versions
> > >    (https://bugs.launchpad.net/ubuntu/+source/rustc-1.83/+bug/2120318)
> > > - that Marc-André or someone else will add Rust to other CI jobs
> > 
> > How far into the future does moving to 1.83.0 push our
> > "we can enable rust and make it mandatory" point? I was
> > hoping we would be able to do that sometime soon but this
> > sounds like we're going to be still a long way out from that :-(
> Sorry for not seeing the question, the good news is that it doesn't push it
> by much, if at all.  Debian bookworm has even updated rustc-web last month
> to 1.85.0 (say thanks to Firefox), so the only remaining straggler is Ubuntu
> and they're working on it.
> 
> As far as technical blockers go, Marc-André has a couple fixes pending in
> Meson, and of course tracing support is still in flight.  But we could
> enable it for 10.2 in CI and 11.0 in configure.
> 
> The bad news is that enabling Rust by default is a bit like a point of no
> return and, in that respect, other factors may matter more than distro
> support:
> 
> * Community support: it's a lot of new code to deal with, and we're not
> Linux.

That is true, but we're already seeing alot of stuff that is directly
adjacent to QEMU that is written in Rust, with some overlaps amongst
contributors. Coconut SVSM, IGVM, Rust VMM, virtiofsd, libbkio, and
more besides.

So if we consider community as "open source virtualization devs" it
looks like there is a reasonable pool of talent with experience that
can cross-pollinate with QEMU.

> * What's the killer app: DMA support may take a bit longer, so right now
> Rust is limited to very simple devices for which memory safety is not a
> primary issue.  Could it be BQL-free interrupts, where even simpler devices
> like interrupt controllers could benefit from a more picky compiler?

I suggest we don't try to over-think this too much, as it'll become
a bit of a chicken and egg problem.

IMHO initial ideas for Rust usage will inevitable be fairly simple,
as that's part of the learning process for all of us, avoiding trying
to bite off too much too quickly. As a result, the initial work will
not look very compelling The more worthwhile and substantial things
will only arrive once use of Rust in QEMU has had time to marinate,
and at least some of them will be things we can't thing of ahead of
time.

   "if you build it, they will come"

Even if QEMU doesn't mandate Rust directly, Rust is already a part of
QEMU indirectly, so on the distro front the point of no return is
pretty much already here unless you want to cut out an increasing
number of interesting features.

eg we see ourselves integrating with libblkio, and igvm, both of which
we do via C shims around the Rust code. There are more of such things
to come - a Rust impl of the EDK vars storage is probable, there are
virtee crates for dealing with low level SEV pieces that have been
proposed before and seem interesting.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


