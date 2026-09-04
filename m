Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDC0C624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 10:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2R7C-0004GP-NR; Fri, 04 Sep 2026 06:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x2R7A-0004G9-Ru
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 06:25:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x2R79-0001ea-3E
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 06:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788517541;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WQxIZaPvzzr1UlWVAO7ucNi03kPgxiIq3E36EUol7N0=;
 b=UZBqsh6zlumescqml2CG0N8Bva/OiWRNiC0B9rUwQ7M1VnoLskPDhkvVOLOBkDRiMW98kx
 hPhfEQIlAFeR7eZgkHWgedSWlStDWVh8S5ZpUEtL5C9ZugMbXFU6IsFNsLWOc3W9zK0Jr5
 I7l53D13H+BXIal93xJteaSooSxE0is=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-BPzDg1AKMPC3JjF2Ra-xtA-1; Fri,
 04 Sep 2026 06:25:38 -0400
X-MC-Unique: BPzDg1AKMPC3JjF2Ra-xtA-1
X-Mimecast-MFC-AGG-ID: BPzDg1AKMPC3JjF2Ra-xtA_1788517536
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 26F41195411C; Fri,  4 Sep 2026 10:25:36 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 39D003000223; Fri,  4 Sep 2026 10:25:33 +0000 (UTC)
Date: Fri, 4 Sep 2026 11:25:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bin Meng <bin.meng@processmission.com>,
 QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Yonggang Luo <luoyonggang@gmail.com>, Anton Johansson <anjo@rev.ng>
Subject: Re: [PATCH 02/33] hw/arm: Add basic Phytium Pi machine
Message-ID: <apqcmqpJEEyc7wGx@redhat.com>
References: <20260903112532.3276678-1-bin.meng@processmission.com>
 <20260903112532.3276678-3-bin.meng@processmission.com>
 <0795176d-4580-4acc-a3cf-c40f8d221661@oss.qualcomm.com>
 <CAEUhbmW4h_-az5iBsztzy8Yuu06+WMjOYcrL51sW8VEgyAaSMw@mail.gmail.com>
 <881be57e-5496-41f2-af0b-e21087fa5e54@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <881be57e-5496-41f2-af0b-e21087fa5e54@oss.qualcomm.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

On Fri, Sep 04, 2026 at 12:15:26PM +0200, Philippe Mathieu-Daudé wrote:
> On 4/9/26 09:57, Bin Meng wrote:
> > Hi Philippe,
> > 
> > On Fri, Sep 4, 2026 at 12:56 AM Philippe Mathieu-Daudé
> > <philmd@oss.qualcomm.com> wrote:
> > > 
> > > On 3/9/26 13:24, Bin Meng wrote:
> > > > Add the base topology for the Phytium Pi board built around the
> > > > E2000Q SoC, with two FTC310 and two FTC664 CPUs, RAM, GICv3/ITS,
> > > > and PL011 UARTs.
> > > > 
> > > > Describe the CPUs as three non-uniform clusters matching the vendor
> > > > Linux device tree. Preserve the board CPU slot order so firmware
> > > > MPIDR 0x200 maps to QEMU CPU index 2.
> > > > 
> > > > Signed-off-by: Bin Meng <bin.meng@processmission.com>
> > > > ---
> > > > 
> > > >    hw/arm/Kconfig         |   8 +
> > > >    hw/arm/meson.build     |   1 +
> > > >    hw/arm/phytium_e2000.c | 406 +++++++++++++++++++++++++++++++++++++++++
> > > >    3 files changed, 415 insertions(+)
> > > >    create mode 100644 hw/arm/phytium_e2000.c
> 
> 
> > > > +static void phytium_pi_init(MachineState *ms)
> > > > +{
> > > > +    PhytiumE2000State *s = PHYTIUM_PI(ms);
> > > > +    int i;
> > > > +
> > > > +    if (kvm_enabled()) {
> > > > +        error_report("phytium-pi: KVM is not supported");
> > > 
> > > Why is it relevant?
> > 
> > This is because the machine relies on heterogeneous named
> > FTC310/FTC664 TCG CPU models and Arm KVM generally requires the host
> > CPU model. KVM is rejected explicitly instead of failing later during
> > vCPU initialization.

We have several other hardware accelerators for other platforms.
It is right to be checking KVM specifically, or should we have
general check that only passes for TCG/QTest ?

> Hmm OK. Cc'ing Pierrick to add to our list of things to think about for
> heterogenous emulation. I'd rather have this handled in a generic way,
> not per-machine. Hopefully TypeInfo::is_available will be sufficient
> to not expose the machine if KVM is not available. No need to think
> about that now.

We need to use QAPI MachineInfo / MachineClass to report to mgmt apps
whether a machine is capable of using hardware acceleration or not in
response to "query-machines".

Currently if a target supports HW accel, then apps assume that all
machines in that target can use acceleration. This was a convenient
short cut assumption, but this new machine suggests we can no make
do with that assumption, and need to explicitly report it per-machine.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


