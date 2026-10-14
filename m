Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE142CC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 10:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGwG7-0002mW-AF; Wed, 14 Oct 2026 06:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGwG0-0002l6-JN
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 06:30:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGwFx-0007O6-Bh
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 06:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791973843;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ys3RrfEOY1JVyoz283GauGZNTRjHqQ6cBJS3SjWGjd8=;
 b=AoTINWa/muR9C73ssXSmkIgPcxAUCCJrVeYMCOfU8AF04qx2cVkTBvPrliqlxPTiq0fUYu
 S4f1aoloF1MgeFBotr4UyES93JMBAyjPi1en+KaUbk4o26RRgVSF4CaF2Gqs8jzDlefisQ
 m6JrULh1U7EAwxuLSckVanBge5Q4cAY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-93ILnDObMtmKp8PN4UuukQ-1; Wed,
 14 Oct 2026 10:30:39 +0000
X-MC-Unique: 93ILnDObMtmKp8PN4UuukQ-1
X-Mimecast-MFC-AGG-ID: 93ILnDObMtmKp8PN4UuukQ_1791973836
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 510E5180061E; Wed, 14 Oct 2026 10:30:35 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3BD33362; Wed, 14 Oct 2026 10:30:25 +0000 (UTC)
Date: Wed, 14 Oct 2026 11:30:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>, qemu-riscv@nongnu.org,
 Alexander Bulekov <alxndr@bu.edu>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-s390x@nongnu.org,
 Song Gao <17746591750@163.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Farman <farman@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Weiwei Li <liwei1518@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@kernel.org>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fam Zheng <fam@euphon.net>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-arm@nongnu.org,
 Chao Liu <chao.liu@processmission.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH 05/34] qapi: add missing Linux user-mode targets to
 EmuTarget
Message-ID: <as9ZvlmXQUwvm0vz@redhat.com>
References: <20261014093152.834-1-luoyonggang@gmail.com>
 <20261014093152.834-6-luoyonggang@gmail.com>
 <e09a64d3-7632-4f90-bd69-0c6097f8cd78@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e09a64d3-7632-4f90-bd69-0c6097f8cd78@oss.qualcomm.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Oct 14, 2026 at 12:24:57PM +0200, Philippe Mathieu-Daudé wrote:
> On 14/10/26 11:31, Yonggang Luo wrote:
> > This usermode targets:
> > aarch64_be
> > armeb
> > microblazeel
> > mipsn32
> > mipsn32el
> > ppc64le
> > sparc32plus
> > are not in machine.json
> > 
> > This is a prepare for directly using TARGET_ARCH_VARIANT latter.
> > 
> > Also get target-info.c to be compatible with future TARGET_ARCH_VARIANT only usage.
> > So that we can define TARGET_ARCH_VARIANT to target_name directly
> > 
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >   include/qemu/base-arch-defs.h | 13 +++++++++++++
> >   qapi/machine.json             | 25 +++++++++++++------------
> >   target-info.c                 | 26 +++++++++-----------------
> >   3 files changed, 35 insertions(+), 29 deletions(-)
> 
> 
> > diff --git a/qapi/machine.json b/qapi/machine.json
> > index 07fac4f0764..a3d6e08a847 100644
> > --- a/qapi/machine.json
> > +++ b/qapi/machine.json
> > @@ -15,11 +15,10 @@
> >   ##
> >   # @EmuTarget:
> > -#     The comprehensive enumeration of QEMU system emulation
> > -#     ("softmmu") targets.  Run "./configure --help" in the project
> > -#     root directory, and look for the \*-softmmu targets near the
> > -#     "--target-list" option.  The individual target constants are not
> > -#     documented here, for the time being.
> > +#     The comprehensive enumeration of QEMU system and user-mode
> > +#     emulation targets.  Run "./configure --help" in the project root
> > +#     directory, and look for the targets near the "--target-list"
> > +#     option.  Individual target constants are not documented here.
> >   #
> >   # @rx: since 5.0
> >   #
> > @@ -30,17 +29,19 @@
> >   # @hexagon: since 11.0
> >   #
> >   # .. note:: The resulting QMP strings can be appended to the
> > -#    "qemu-system-" prefix to produce the corresponding QEMU
> > -#    executable name.  This is true even for "qemu-system-x86_64".
> > +#    "qemu-system-" prefix for system emulation, or the "qemu-" prefix
> > +#    for user-mode emulation, to produce the corresponding executable
> > +#    name, where that target supports the respective emulation mode.
> >   #
> >   # Since: 3.0
> >   ##
> >   { 'enum' : 'EmuTarget',
> > -  'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'hexagon', 'hppa', 'i386',
> > -             'loongarch64', 'm68k', 'microblaze', 'mips', 'mips64',
> > -             'mips64el', 'mipsel', 'or1k', 'ppc',
> > -             'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
> > -             'sh4eb', 'sparc', 'sparc64', 'tricore',
> > +  'data' : [ 'aarch64', 'aarch64_be', 'alpha', 'arm', 'armeb', 'avr',
> > +             'hexagon', 'hppa', 'i386', 'loongarch64', 'm68k', 'microblaze',
> > +             'microblazeel', 'mips', 'mips64', 'mips64el', 'mipsel',
> > +             'mipsn32', 'mipsn32el', 'or1k', 'ppc', 'ppc64', 'ppc64le',
> > +             'riscv32', 'riscv64', 'rx', 's390x', 'sh4', 'sh4eb', 'sparc',
> > +             'sparc32plus', 'sparc64', 'tricore',
> >                'x86_64', 'xtensa', 'xtensaeb' ] }
> 
> 'machine.json' is for system binaries.
> 
> If we want to expose these QAPI types to the user binaries
> (I'm not sure we want...) then this declaration block should
> be moved in another {qapi}.json file. QAPI types are versioned,
> so we'd need some "  @aarch64_be   # Since v13.0" comments.
> 
> Anyway I doubt we want to alter EmuTarget, I'd rather let it
> die as a legacy field, and expose {arch, wordsize, endianness}
> to management layer if this is important to consume.

Libvirt uses query-target so we don't want that data to go away.
If we want to expose other data alongside the target name that's
fine.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


