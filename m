Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D309C77B7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 15:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU5Gj-000112-48; Tue, 24 Jun 2025 11:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uU5Gg-0000zO-9Y
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 11:09:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uU5Gc-0002tV-SD
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 11:09:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750777736;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VqYK4OjeejRXeqGXTJWvxHsA1oS5ATUKqrMzb+0YGi0=;
 b=QOJ3Q2UfLvWYUQCEgkEMZQ4LiCJq0+MET3uJ6Ben0ohVAjJvxJwAXpJUENLORjYTDm1P25
 spQFCGBj8b3aaTlQHmX2YHz3OYkgf+vGk8vAAMMDnJHQAuxROQ8FVjGRtrz4+OYPrXq7O5
 QvcffqxhgtU9iWzq2JD01+PnLxdjCTE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308-6aGN9xo2M0q0KgqGYTWdBg-1; Tue,
 24 Jun 2025 11:08:47 -0400
X-MC-Unique: 6aGN9xo2M0q0KgqGYTWdBg-1
X-Mimecast-MFC-AGG-ID: 6aGN9xo2M0q0KgqGYTWdBg_1750777726
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 46F551801211; Tue, 24 Jun 2025 15:08:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.64])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F094419560AF; Tue, 24 Jun 2025 15:08:42 +0000 (UTC)
Date: Tue, 24 Jun 2025 16:08:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Isaku Yamahata <isaku.yamahata@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>
Subject: Re: [PULL 24/24] i386/tdx: handle TDG.VP.VMCALL<GetQuote>
Message-ID: <aFq_dxjRriYSf9fV@redhat.com>
References: <20250620164053.579416-1-pbonzini@redhat.com>
 <20250620164053.579416-25-pbonzini@redhat.com>
 <b8171c39-6a92-4078-a59a-a63d7452e1e9@kaod.org>
 <4ffdb62b-8fe4-4b34-9efa-aecff7f8e77b@intel.com>
 <aFkKL-TQTcrBtXuK@redhat.com>
 <CAJSP0QUgirgNX71MwGgYbdDhVUrd3MWsetx66_+GsER8BfoSbg@mail.gmail.com>
 <aFlR6CTLRzSpS1fr@redhat.com>
 <CAJSP0QUVuXRK9nyXw=HcEV6Qi5HaE+TzVp1QOiGp7c7pX=Z=Hw@mail.gmail.com>
 <32c86014-8e28-4100-bb87-9072acdc01cb@kaod.org>
 <CAJSP0QXnXSBy9bDetUL4SEOxP=tLaGZZ+5qEQCp=SU3KDNmg5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJSP0QXnXSBy9bDetUL4SEOxP=tLaGZZ+5qEQCp=SU3KDNmg5A@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jun 24, 2025 at 11:03:19AM -0400, Stefan Hajnoczi wrote:
> On Mon, Jun 23, 2025 at 4:37 PM Cédric Le Goater <clg@kaod.org> wrote:
> >
> > On 6/23/25 20:57, Stefan Hajnoczi wrote:
> > > On Mon, Jun 23, 2025 at 9:09 AM Daniel P. Berrangé <berrange@redhat.com> wrote:
> > >>
> > >> On Mon, Jun 23, 2025 at 09:04:33AM -0400, Stefan Hajnoczi wrote:
> > >>> On Mon, Jun 23, 2025 at 4:04 AM Daniel P. Berrangé <berrange@redhat.com> wrote:
> > >>>>
> > >>>> On Mon, Jun 23, 2025 at 03:03:19PM +0800, Xiaoyao Li wrote:
> > >>>>> On 6/23/2025 2:43 PM, Cédric Le Goater wrote:
> > >>>>>> Hello,
> > >>>>>>
> > >>>>>> On 6/20/25 18:40, Paolo Bonzini wrote:
> > >>>>>>> From: Isaku Yamahata <isaku.yamahata@intel.com>
> > >>>>>>>
> > >>>>>>> Add property "quote-generation-socket" to tdx-guest, which is a property
> > >>>>>>> of type SocketAddress to specify Quote Generation Service(QGS).
> > >>>>>>>
> > >>>>>>> On request of GetQuote, it connects to the QGS socket, read request
> > >>>>>>> data from shared guest memory, send the request data to the QGS,
> > >>>>>>> and store the response into shared guest memory, at last notify
> > >>>>>>> TD guest by interrupt.
> > >>>>>>>
> > >>>>>>> command line example:
> > >>>>>>>     qemu-system-x86_64 \
> > >>>>>>>       -object '{"qom-type":"tdx-guest","id":"tdx0","quote-generation-
> > >>>>>>> socket":{"type":"unix", "path":"/var/run/tdx-qgs/qgs.socket"}}' \
> > >>>>>>>       -machine confidential-guest-support=tdx0
> > >>>>>>>
> > >>>>>>> Note, above example uses the unix socket. It can be other types,
> > >>>>>>> like vsock,
> > >>>>>>> which depends on the implementation of QGS.
> > >>>>>>>
> > >>>>>>> To avoid no response from QGS server, setup a timer for the transaction.
> > >>>>>>> If timeout, make it an error and interrupt guest. Define the threshold of
> > >>>>>>> time to 30s at present, maybe change to other value if not appropriate.
> > >>>>>>>
> > >>>>>>> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> > >>>>>>> Co-developed-by: Chenyi Qiang <chenyi.qiang@intel.com>
> > >>>>>>> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> > >>>>>>> Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > >>>>>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > >>>>>>> Tested-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > >>>>>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > >>>>>>> ---
> > >>>>>>>    qapi/qom.json                         |   8 +-
> > >>>>>>>    target/i386/kvm/tdx-quote-generator.h |  82 +++++++
> > >>>>>>>    target/i386/kvm/tdx.h                 |  10 +
> > >>>>>>>    target/i386/kvm/kvm.c                 |   3 +
> > >>>>>>>    target/i386/kvm/tdx-quote-generator.c | 300 ++++++++++++++++++++++++++
> > >>>>>>>    target/i386/kvm/tdx-stub.c            |   4 +
> > >>>>>>>    target/i386/kvm/tdx.c                 | 176 ++++++++++++++-
> > >>>>>>>    target/i386/kvm/meson.build           |   2 +-
> > >>>>>>>    8 files changed, 582 insertions(+), 3 deletions(-)
> > >>>>>>>    create mode 100644 target/i386/kvm/tdx-quote-generator.h
> > >>>>>>>    create mode 100644 target/i386/kvm/tdx-quote-generator.c
> > >>>>>>
> > >>>>>> These changes broke the build on 32-bit host.
> > >>>>>>
> > >>>>>> Could you please send a patch to avoid compiling TDX in such environment ?
> > >>>>>
> > >>>>> Paolo is on vacation.
> > >>>>>
> > >>>>> I would like to help, but I don't have 32-bit host environment on hand. Do
> > >>>>> you know how to set up such environment quickly? (I tried to set up within a
> > >>>>> 32-bit VM but the 32-bit OS is too old and I didn't get it work to install
> > >>>>> the required package for building QEMU)
> > >>>>
> > >>>> You should be able to use QEMU's docker containers to get yourself a
> > >>>> Debian i386 container, on a x86_64 host.
> > >>>
> > >>> The cross-i686-system (Debian) build CI job succeeded:
> > >>> https://gitlab.com/qemu-project/qemu/-/jobs/10423776600
> > >>>
> > >>> I wonder why the CI didn't catch the issue?
> > >>
> > >> It didn't build the x86_64 target:
> > >>
> > >>    --target-list-exclude="arm-softmmu i386-softmmu microblaze-softmmu mips-softmmu mipsel-softmmu mips64-softmmu ppc-softmmu riscv32-softmmu sh4-softmmu sparc-softmmu xtensa-softmmu $CROSS_SKIP_TARGETS"
> > >>
> > >> so in turn didn't build any TDX code
> > >
> > > Here are the targets that were built by the CI job:
> > >
> > >    target list : avr-softmmu m68k-softmmu microblazeel-softmmu
> > > or1k-softmmu rx-softmmu sh4eb-softmmu tricore-softmmu xtensaeb-softmmu
> > >
> > > 64-bit targets are not supported on 32-bit hosts since commit
> > > acce728cbc6c ("meson: Disallow 64-bit on 32-bit emulation"). I don't
> > > think the x86_64 target can be built on 32-bit hosts.
> > >
> > > But notice that i386-softmmu is missing from the target list. That
> > > could be why the CI job succeeded.
> > >
> > > Cédric: What were your ./configure options?
> >
> > Just :
> >
> >    --target-list=arm-softmmu,ppc-softmmu,i386-softmmu
> 
> cross-i686-tci builds i386-softmmu on debian-i686-cross with
> --disable-kvm, but the TDX code isn't compiled:
> https://gitlab.com/qemu-project/qemu/-/jobs/10440424393
> 
> A new CI job could be added to cover TDX on 32-bit hosts if you think
> it's worthwhile. Maybe it's a corner case and not worth spending CI
> cycles on?

We should not set any expectation of support for TDX on 32-bit host
or guest emulator. IMHO the only right answer here is to disable
build of TDX for anything other than x86_64-softmmu w/ KVM.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


