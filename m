Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126E1CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 16:37:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZWmJ-0007vE-LN; Tue, 16 Jun 2026 12:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wZWmI-0007v0-Bb
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 12:36:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wZWmG-0008TE-Mu
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 12:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781627799;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NbTIElJsdwWAjs535rka+sJO2BsG6/LN1TVys26usyM=;
 b=gQ0q8/fqx5t17DpUhfpI9L+TjEfdnL6ovq9fNvKZPFJT8ztyFT+WyQnnxQiD28wHs4iFw6
 5+uhE6MQidgRVmSAg/h/cttrISbdZzQZh7Xx8VCGu+OwVIBLEo4mOTmPyjhKSdyx4cADcq
 rPNzOywHvuJn3ygN5ZwJmiBd+OQwueE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-LEx2kp0yPheTdkDu-ZhL3w-1; Tue,
 16 Jun 2026 12:36:35 -0400
X-MC-Unique: LEx2kp0yPheTdkDu-ZhL3w-1
X-Mimecast-MFC-AGG-ID: LEx2kp0yPheTdkDu-ZhL3w_1781627793
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3DADD19539A0; Tue, 16 Jun 2026 16:36:33 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.111])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1646F195419E; Tue, 16 Jun 2026 16:36:26 +0000 (UTC)
Date: Tue, 16 Jun 2026 17:36:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [RFC 5/7] system: add qemu_irq_new / qemu_irq_new_child /
 qemu_irq_new_array
Message-ID: <ajF7hxZP4a76yxxg@redhat.com>
References: <20260616155554.264412-1-berrange@redhat.com>
 <20260616155554.264412-6-berrange@redhat.com>
 <CAFEAcA9QUMgAz894D-jEx-Q8=Esi8fnhivAyKtekqHukEcuibQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA9QUMgAz894D-jEx-Q8=Esi8fnhivAyKtekqHukEcuibQ@mail.gmail.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

On Tue, Jun 16, 2026 at 05:22:05PM +0100, Peter Maydell wrote:
> On Tue, 16 Jun 2026 at 16:57, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > Prepare for the move to dynamically allocated IRQ objects by
> > introducing qemu_irq_new / qemu_irq_new_child / qemu_irq_new_array
> > functions which call through to object_new instead of object_initialize.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  hw/core/irq.c         | 35 ++++++++++++++++++++
> >  include/hw/core/irq.h | 75 ++++++++++++++++++++++++++++++++++++++++---
> >  2 files changed, 106 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/core/irq.c b/hw/core/irq.c
> > index 106805e241..e943c87b81 100644
> > --- a/hw/core/irq.c
> > +++ b/hw/core/irq.c
> > @@ -49,6 +49,13 @@ void qemu_init_irq(IRQState *irq, qemu_irq_handler handler, void *opaque,
> >      init_irq_fields(irq, handler, opaque, n);
> >  }
> >
> > +IRQState *qemu_irq_new(qemu_irq_handler handler, void *opaque, int n)
> > +{
> > +    IRQState *irq = IRQ(object_new(TYPE_IRQ));
> > +    init_irq_fields(irq, handler, opaque, n);
> > +    return irq;
> > +}
> 
> Isn't this the same as the existing qemu_allocate_irq() ?

Doh, I missed the very surprising naming pattern where "qemu_irq" is a
typedef of 'struct IRQState *'.

> (I have over the past few years occasionally been trying to get rid
> of existing uses of qemu_allocate_irq() and its cousin
> qemu_allocate_irqs(), because they are persistent sources of memory
> leaks. The function returns a pointer that the caller has to deal
> with and remember to free, whereas using e.g. qdev_init_gpio_*()
> makes the new irq objects children of the device they belong to,
> so they're automatically freed when the device is destroyed.
> qemu_init_irq_child() similarly.)

If we think it is best practice to mandate passing in a parent
object so that every IRQ  is gauranteed to be owned by the QOM
tree, that's fine with me.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


