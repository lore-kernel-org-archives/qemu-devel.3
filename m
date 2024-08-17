Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58896C52D7D
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2024 12:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfIPF-0002p9-OI; Sat, 17 Aug 2024 08:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sfIPD-0002nA-Mn
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 08:19:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sfIPB-0002b9-RF
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 08:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723897176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fQ5yCAHj0nTsqPSiGQ1UPc2bjPo6HehhjCLFAWU71oA=;
 b=es3mgfyhOtBmFJlWXU2mcBcTJ2p4km0N03GTiUO+nlofHRH8475E9W/mrs/PJxB4gIF+8x
 pzzlmoBqtS0r1MrsNEkxuFBr/68BpF/1X5UFa4Vjj5HGIP4f/1ZvFuddvcWXcWi+MS7nZ5
 CK1x1i5/x8yg1wE9u9K47GZp2qU8aKM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-WjFl7mWoOkSaD8E7wslFdQ-1; Sat, 17 Aug 2024 08:19:32 -0400
X-MC-Unique: WjFl7mWoOkSaD8E7wslFdQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a7a83f54fdeso241435966b.0
 for <qemu-devel@nongnu.org>; Sat, 17 Aug 2024 05:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723897171; x=1724501971;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fQ5yCAHj0nTsqPSiGQ1UPc2bjPo6HehhjCLFAWU71oA=;
 b=d9VCSlZw7HQ5Gvca5Z55GfI70WYB98A1vdophaM+fkwToDe/YcnqWGnlMIFeB1VF81
 nrFyKiDwsQ+ezQlhstCt1BNZCRRg/BJ8Oqn4iBsPvsKHnI/U4FXKJ+TjAYmkeXkYPGEQ
 PpXvfW31TjaiFIalv1KiBTyZfAmy/RwmTjytnAm7u1a2cR73czLDtTlijWQfTjyGuegB
 wymCUmgcZ78VJ5acehvLwstIvZrfI0tBD+Vb6GDftEwpuKuuCn6YOgpPvcB8D1vdGOGB
 +JpzSwjuuIU63urJC9nwMi3U8JQAdLD6Q1LbZu+B6yy2D10OPAOlUQh6KqaEMCouFHcE
 QGVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZTAlnkzwsYvCRcOb/H7+5wBrLtQnnkRT8QHWqNM3ZZvrAnu8eE5OGpJ3xh9CnKvU2LsG2TKV1F1GjcPriYkScf+rg3B4=
X-Gm-Message-State: AOJu0Yy1qYV8ZJu8zyelmhpYW/VvlMH92Z8ZMPDvKsUkIbfcrNZH4Xil
 BBhGFdr2FRPZZE+UWALBhDyv9GFpII24Hj0c4YA2m/c/JsLbUX4xZ5onPK6rhCnN3G7jTUMcSEZ
 E6KX8/3qY0MV8yrCavqA+HO94BdK3zDbr4g/ss4ByvfZPC8h/ZukL
X-Received: by 2002:a17:907:efca:b0:a7d:33f0:4d58 with SMTP id
 a640c23a62f3a-a83929d2e13mr431450866b.48.1723897171146; 
 Sat, 17 Aug 2024 05:19:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKEvgmnCqUgj5X6+J7NdJ60shncDMuEoJ+Vt5RQOlMlRJuhwO5A4+XR4qOCFPfQF/uj4b6gw==
X-Received: by 2002:a17:907:efca:b0:a7d:33f0:4d58 with SMTP id
 a640c23a62f3a-a83929d2e13mr431448066b.48.1723897170280; 
 Sat, 17 Aug 2024 05:19:30 -0700 (PDT)
Received: from redhat.com ([2a02:14f:179:a585:e32b:7b99:cc8e:265b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83838c6bc5sm395099766b.31.2024.08.17.05.19.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Aug 2024 05:19:29 -0700 (PDT)
Date: Sat, 17 Aug 2024 08:19:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Kamil =?utf-8?Q?Szcz=C4=99k?= <kamil@szczek.dev>
Cc: Bernhard Beschow <shentey@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH] hw/i386/pc: Warn about unsatisfied vmport deps
Message-ID: <20240817081845-mutt-send-email-mst@kernel.org>
References: <vsm1ly2eX009LRKgURcMp6qTYHWw1bZd3zg2GUbd4M90T91QvJRdKxiRS3rPl8PR96y2r890Am3Ajf4kQrwihn7-7hKBU9VicRPPtIRv_GI=@szczek.dev>
 <0D723368-3251-4D5E-A625-73169CBE3395@gmail.com>
 <qT_ps6medVHIOIF5hUE_tIMUtEdbHQw5wnhE2ZVauM1cpnfHXqnl9-hroGS-3due9uRtKlMR5RsREbzeIV_0Xp1-FM0w4UDFsvdo3PsIG6U=@szczek.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <qT_ps6medVHIOIF5hUE_tIMUtEdbHQw5wnhE2ZVauM1cpnfHXqnl9-hroGS-3due9uRtKlMR5RsREbzeIV_0Xp1-FM0w4UDFsvdo3PsIG6U=@szczek.dev>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Aug 17, 2024 at 08:49:05AM +0000, Kamil Szczęk wrote:
> On Friday, August 16th, 2024 at 15:14, Bernhard Beschow <shentey@gmail.com> wrote:
> 
> >
> > Am 14. August 2024 11:10:16 UTC schrieb "Kamil Szczęk" kamil@szczek.dev:
> >
> > > Since commit 4ccd5fe22feb95137d325f422016a6473541fe9f ('pc: add option
> > > to disable PS/2 mouse/keyboard'), the vmport will not be created unless
> > > the i8042 PS/2 controller is enabled. To not confuse users, let's add a
> > > warning if vmport was explicitly requested, but the i8042 controller is
> > > disabled. This also changes the behavior of vmport=auto to take i8042
> > > controller availability into account.
> > >
> > > Signed-off-by: Kamil Szczęk kamil@szczek.dev
> > > ---
> > > hw/i386/pc.c | 4 ++++
> > > hw/i386/pc_piix.c | 3 ++-
> > > hw/i386/pc_q35.c | 2 +-
> > > qemu-options.hx | 4 ++--
> > > 4 files changed, 9 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > > index c74931d577..5bd8dd0350 100644
> > > --- a/hw/i386/pc.c
> > > +++ b/hw/i386/pc.c
> > > @@ -1100,6 +1100,10 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl,
> > > }
> > >
> > > if (!create_i8042) {
> > > + if (!no_vmport) {
> > > + warn_report("vmport requires the i8042 controller to be enabled");
> > > + }
> > > +
> > > return;
> > > }
> > >
> > > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> > > index d9e69243b4..cf2e2e3e30 100644
> > > --- a/hw/i386/pc_piix.c
> > > +++ b/hw/i386/pc_piix.c
> > > @@ -312,7 +312,8 @@ static void pc_init1(MachineState *machine, const char *pci_type)
> > >
> > > assert(pcms->vmport != ON_OFF_AUTO__MAX);
> > > if (pcms->vmport == ON_OFF_AUTO_AUTO) {
> > > - pcms->vmport = xen_enabled() ? ON_OFF_AUTO_OFF : ON_OFF_AUTO_ON;
> > > + pcms->vmport = (xen_enabled() || !pcms->i8042_enabled)
> > > + ? ON_OFF_AUTO_OFF : ON_OFF_AUTO_ON;
> > > }
> >
> >
> > I think it makes sense to consolidate this handling into pc_basic_devices_init() before doing this change. Maybe just in front of the call to pc_superio_init()? The additional handling of xen_enabled() shouldn't hurt there for q35: Even though q35 doesn't (yet) support Xen there are already code paths where this check is done.
> 
> Makes sense technically, but since I'm new to the mailing list workflow I could use some help with logistics. I've already posted a v2 of this patch which was reviewed and accepted, should I wait for it to be pulled in and post a follow-up patch or post another revision of this patch?


I rebase with now issues - that's why it's a tag, easy to drop.
So feel free to post v3.

> >
> > > /* init basic PC hardware */
> > > diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> > > index 9d108b194e..6c112d804d 100644
> > > --- a/hw/i386/pc_q35.c
> > > +++ b/hw/i386/pc_q35.c
> > > @@ -278,7 +278,7 @@ static void pc_q35_init(MachineState *machine)
> > >
> > > assert(pcms->vmport != ON_OFF_AUTO__MAX);
> > > if (pcms->vmport == ON_OFF_AUTO_AUTO) {
> > > - pcms->vmport = ON_OFF_AUTO_ON;
> > > + pcms->vmport = pcms->i8042_enabled ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
> > > }
> > >
> > > /* init basic PC hardware */
> > > diff --git a/qemu-options.hx b/qemu-options.hx
> > > index cee0da2014..0bc780a669 100644
> > > --- a/qemu-options.hx
> > > +++ b/qemu-options.hx
> > > @@ -68,8 +68,8 @@ SRST
> > >
> > > `vmport=on|off|auto`
> > > Enables emulation of VMWare IO port, for vmmouse etc. auto says
> > > - to select the value based on accel. For accel=xen the default is
> > > - off otherwise the default is on.
> > > + to select the value based on accel and i8042. For accel=xen
> > > + and/or i8042=off the default is off otherwise the default is on.
> >
> >
> > I'd do s#and/or#or# for readability.
> >
> > Best regards,
> > Bernhard
> >
> > > `dump-guest-core=on|off`
> > > Include guest memory in a core dump. The default is on.


