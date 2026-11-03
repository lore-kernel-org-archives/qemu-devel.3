Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A631A606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 13:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VHe8noQI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOEze-0000JV-9p; Tue, 03 Nov 2026 08:56:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xOEzP-0000Fj-RQ
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 08:55:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xOEzL-0000Ek-E9
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 08:55:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793714133;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HkLAd4qQaoBYZVRD0j1kGkVYOIEsMDHpcx8amGDTFMA=;
 b=VHe8noQI3nVi3P98yKB4QaHfnbG6vaoZ/4rXz+fgPjTl8ZP/4U7ajMV4qx1rtwj91HSZQ2
 TiEyVBN6BZoDIWVZXr3xTta2ZemnR0nyQZzIS1Q4eDpwAnfjugm22IJkfaPi1cTxLh7D0j
 KhzUNzUp0byXiUsT2vGC/8CCmGUBjPQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-FkhH78s2NBeluyaD0FvwgA-1; Tue,
 03 Nov 2026 08:55:29 -0500
X-MC-Unique: FkhH78s2NBeluyaD0FvwgA-1
X-Mimecast-MFC-AGG-ID: FkhH78s2NBeluyaD0FvwgA_1793714124
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC4591955BC4; Tue,  3 Nov 2026 13:55:21 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82727195608C; Tue,  3 Nov 2026 13:55:10 +0000 (UTC)
Date: Tue, 3 Nov 2026 13:55:07 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Anthony PERARD <anthony@xenproject.org>,
 Felipe Balbi <balbi@kernel.org>, Aleksandar Rikalo <arikalo@gmail.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-ppc@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>,
 Weiwei Li <liwei1518@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?utf-8?Q?Cl=C3=A9ment?= Chigot <chigot@adacore.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chao Liu <chao.liu@processmission.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH 00/15] hw: expand DEFINE_MACHINE to explicit TypeInfo
 registration
Message-ID: <aunnuwhsx9ZOOXBX@redhat.com>
References: <20261030151539.1872-1-luoyonggang@gmail.com>
 <d1db54c6-b802-676a-7779-0c2c63f5f807@eik.bme.hu>
 <aa70e94c-d9a8-41c9-850f-7ded87f7f327@oss.qualcomm.com>
 <aumYOBw-nKQAWdYK@redhat.com>
 <CAE2XoE8Xwevk523OfB+GgwbRu0iVnyD4VNOx81rj7J7F5aq=OA@mail.gmail.com>
 <54851326-3627-2b86-57d6-c338ed4e4b50@eik.bme.hu>
 <CAE2XoE_P2mZAT8wZwzFsTqJTK8nxNSSqJRrOM2T-AJkQjwJHBw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2XoE_P2mZAT8wZwzFsTqJTK8nxNSSqJRrOM2T-AJkQjwJHBw@mail.gmail.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 09:48:44PM +0800, Yonggang Luo wrote:
> On Tue, Nov 3, 2026 at 9:23 PM BALATON Zoltan <balaton@eik.bme.hu> wrote:
> >
> > On Tue, 3 Nov 2026, Yonggang Luo wrote:
> > > On Tue, Nov 3, 2026 at 4:16 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> > >>
> > >> On Fri, Oct 30, 2026 at 05:51:44PM -0800, Pierrick Bouvier wrote:
> > >>> On 10/30/2026 4:09 PM, BALATON Zoltan wrote:
> > >>>> On Fri, 30 Oct 2026, Yonggang Luo wrote:
> > >>>>> DEFINE_MACHINE and DEFINE_MACHINE_EXTENDED hide the TypeInfo and the
> > >>>>> type_init
> > >>>>> function that calls type_register_static(). A later change needs to
> > >>>>> pass a
> > >>>>
> > >>>> That's the point of the macro to hide the boiler plate code.
> > >>>>
> > >>>>> target mask into that registration, and the macros have no parameter
> > >>>>> for it.
> > >>>>
> > >>>> Couldn't you just change the macros to take that parameter instead of
> > >>>> expanding it everywhere?
> > >>>>
> > >>>
> > >>> Problem of macros is that they don't have default parameters, so you
> > >>> need variants for everything:
> > >>>
> > >>> DEFINE_MACHINE
> > >>> DEFINE_MACHINE_EXTENDED
> > >>> DEFINE_MACHINE_WITH_INTERFACES
> > >>> DEFINE_MACHINE_WITH_INTERFACE_ARRAY
> > >>> and now would need a new variant, with variant for other existing ones.
> > >>>
> > >>> In the end, it's just simpler to remove this and add the boilerplate.
> > >>> It's written once and never modified, so using a macro just save typing
> > >>> those lines once.
> > >>
> > >> For each machine, it is only written once, but we add machines
> > >> over time, and every time a new machine is added the code style
> > >> is slightly different. We introduced all the variuos DEFINE_*
> > >> macros for QOM to better ensure consistent style and usage as
> > >> new code is added over time.
> > >
> > > I understand that the DEFINE_* macros are bloating because of this.
> > > Indeed currently the only two macros used are "DEFINE_MACHINE" and
> > > "DEFINE_MACHINE_EXTENDED"
> >
> > There are a few machines using some others but these are the most used.
> > That suggests maybe we should change the convenience wrappers to match
> > what machines need but DEFINE_MACHINE_EXTENDED is meant to be the one that
> > allows all parameters which should be rarely needed.
> >
> > > ; each time people want to add a new attribute, the macros is twiced.
> >
> > Not necessarily. The SECURE parameter did that to preserve previous
> > behaviour but if you add new parameter changing all callers (which is the
> > same as expanding the macro that would also change all callers) then it's
> > just a new parameter added not changing the number of DEFINE_MACHINE*
> > wrappers. Rearranging the wrappers to make DEFINE_MACHINE_EXTENDED used
> > less is an independent change.
> >
> > > And the usage of DEFINE_MACHINE_EXTENDED is rare and can be replaced
> > > with DEFINE_TYPES or TypeInfo
> > > and be more explicit. When we used as macro parameter, we need think
> >
> > But that defies the purpose of hiding the QOM boiler plate as much as
> > possible. New people are confused by QOM and it's easier for them to look
> > up documentation on the DEFINE_MACHINE* macros to see what parameter is
> > what and not care about how it's stored in QOM TypeInfo or what is that
> > at all.
> >
> > > what's that parameter means, and for
> > > TypeInfo, we can directly know what that member is about(because we
> > > are assigned with the member name).
> >
> > The parameter also has a name and documentation so it's not simpler to
> > look up TypeInfo than look at the macro definition or docs. In fact it's
> > harder to guess from TypeInfo as then you also need to get into QOM.
> >
> > > That's why I suggest keeping a single DEFINE_MACHINE, just like
> > > DEFINE_TYPES; as they are the most
> > > used macros(and simple enough), and won't suffer from changes much.
> >
> > That means exposing all the boiler plate for all machines other than the
> > simplest case. I think it would be better to keep DEFINE_MACHINE_EXTENDED
> > but maybe rethink the existing wrappers and drop unused ones and maybe add
> > new ones that reduce the usage of DEFINE_MACHINE_EXTENDED but still keep
> > the boiler plate hidden.
> 
> Thanks, I'll go this way, remove unused macros, and keep DEFINE_MACHINE_EXTENDED
> and extend both DEFINE_MACHINE_EXTENDED DEFINE_MACHINE supports
> "targets" or "arch_mask" parameter.

Given that we don't need to do general per-arch type filtering in
QOM, we could just move 'is_available' out of TypeInfo, and into the
MachineClass, so it is a regular class level property, which can be
set in the class_init methods, and thus avoid any changes to the
DEFINE_MACHINE macros.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


