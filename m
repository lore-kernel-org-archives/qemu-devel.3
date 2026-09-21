Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC56C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 10:18:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8b5d-0000wB-A4; Mon, 21 Sep 2026 06:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x8b5b-0000vv-LD
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 06:17:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x8b5Z-0002Jf-I9
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 06:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789985851;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/tycWr0iG6Lzkbgy/Qluuz5+Z26o4SRbm5I5LXz9k3o=;
 b=Yufr4Asf7ggn+471x83RnNMUTZPqmIQ/bZuXqdUbv/Lqzv1OQOYbKXwUZXoTxY/jSsS5vw
 6weXu7/Nqb33LKjx4Kq8syKdg/VaRrA9Bnm2s1WEW+4XarcnuIFMzksMaJmd8nQUeeDgIo
 GGo1FhYmrAa5D1gu4oAcRgQz4gtB07M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-TCkW6Sg8ObCMpri_m8tN_A-1; Mon,
 21 Sep 2026 06:17:27 -0400
X-MC-Unique: TCkW6Sg8ObCMpri_m8tN_A-1
X-Mimecast-MFC-AGG-ID: TCkW6Sg8ObCMpri_m8tN_A_1789985845
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B6DE195396E; Mon, 21 Sep 2026 10:17:25 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 54F7E1953943; Mon, 21 Sep 2026 10:17:22 +0000 (UTC)
Date: Mon, 21 Sep 2026 11:17:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Helge Deller <deller@gmx.de>,
 "Denis V. Lunev" <den@openvz.org>,
 Abizer Lokhandwala <abizerlokhandwalastd10@gmail.com>
Subject: Re: [PULL 2/7] hw/isa/pc87560: Add main isa code for NS 87560
 SuperIO chip
Message-ID: <arEEL2wVW1K3fapm@redhat.com>
References: <20260918163829.2917-1-deller@kernel.org>
 <20260918163829.2917-3-deller@kernel.org>
 <7f21b82c-9c3a-4075-84e4-e170c0b1accd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f21b82c-9c3a-4075-84e4-e170c0b1accd@oss.qualcomm.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
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

On Mon, Sep 21, 2026 at 11:51:43AM +0200, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 18/9/26 18:38, Helge Deller wrote:
> > From: Abizer Lokhandwala <abizerlokhandwalastd10@gmail.com>
> > 
> > Add emulation of the core components (PCI function 1 aka I/O
> > Peripherals) of the National Semiconductor SuperIO chip which was
> > commonly used in HP PA-RISC B- and C-class workstations. This includes
> > the PIC interrupt controller, the floppy controller, serial and parallel
> > ports.
> > 
> > Signed-off-by: Abizer Lokhandwala <abizerlokhandwalastd10@gmail.com>
> > Signed-off-by: Helge Deller <deller@gmx.de>
> > ---
> >   MAINTAINERS              |   2 +
> >   hw/isa/Kconfig           |  11 +
> >   hw/isa/pc87560.c         | 510 +++++++++++++++++++++++++++++++++++++++
> >   include/hw/isa/pc87560.h |  96 ++++++++
> >   4 files changed, 619 insertions(+)
> >   create mode 100644 hw/isa/pc87560.c
> >   create mode 100644 include/hw/isa/pc87560.h
> 
> 
> > diff --git a/hw/isa/pc87560.c b/hw/isa/pc87560.c
> > new file mode 100644
> > index 0000000000..c13c54deb2
> > --- /dev/null
> > +++ b/hw/isa/pc87560.c
> > @@ -0,0 +1,510 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> 
> Did we change the coding style to allow C++ comments?

We've got a bit of historical cruft using "//" with SPDX-License-Identifier
that might mislead people who are cribbing existnig code, but yes, we
should prefer '/* .... */' comments in C files.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


