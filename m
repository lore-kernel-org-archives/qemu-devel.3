Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D701CD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 13:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSaTi-0001uK-Ct; Thu, 28 May 2026 09:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@protonic.nl>) id 1wSUgx-0007la-Ou
 for qemu-devel@nongnu.org; Thu, 28 May 2026 02:58:07 -0400
Received: from smtp28.bhosted.nl ([2a02:9e0:8000::40])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@protonic.nl>) id 1wSUgv-0006iV-97
 for qemu-devel@nongnu.org; Thu, 28 May 2026 02:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonic.nl; s=202111;
 h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
 message-id:subject:cc:to:from:date:from;
 bh=dMkXZt73+dmsCO76lZDfKzhW+pTC9F2GeIZkDN4ijtE=;
 b=IMd0SWO17mr85B5W7+A4sJ9fI11XaMfxA2Rstx978fUKuskAZYu1VjaCoRkGW89FW27uRL+Af7Wco
 pxSjYn2j25mabST/5KIwDWwV9lsF6Lp2XoYGWXjolnlb0xnmYCNjWAF+uH/ybhCa0UEgJ+zk9OC9Ox
 sppu/gCJcGriAfQY51KZg2QOtStoinMd/D5gkVInb6O93KXDwRh+GkEWeiUgogg9rFpKtsXrlqwh2c
 xF0DIQs2mRGU4/icCwdJ1UC5owf8SCKIsUuBBcC1l0esxQBUiFOy7eq/EeUUsAbu46eemeCNkZZUOd
 f13lTD88532xJG3FaHqx/4OedIIoQ3w==
X-MSG-ID: 8e8991c4-5a62-11f1-9d12-0050568164d1
Date: Thu, 28 May 2026 08:57:56 +0200
From: David Jander <david@protonic.nl>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Andrei VOLKOV <andrey.volkov@munic.io>, Pavel Pisa <pisa@fel.cvut.cz>,
 Bernhard Beschow <shentey@gmail.com>, =?UTF-8?B?TWF0ecOhxaE=?= Bobek
 <matyas.bobek@gmail.com>, Matyas Bobek <bobekmat@fel.cvut.cz>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Oliver Hartkopp
 <socketcan@hartkopp.net>, Nikita Ostrenkov <n.ostrenkov@gmail.com>, "Daniel
 P. Berrange" <berrange@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, linux-can@vger.kernel.org, Sascha Hauer
 <s.hauer@pengutronix.de>
Subject: Re: [PATCH v3 0/7] hw/arm/sabrelite: Add FlexCAN support
Message-ID: <20260528085756.322eb221@erd003.prtnl>
In-Reply-To: <20260527-durable-festive-millipede-f6e2b9-mkl@pengutronix.de>
References: <cover.1777571962.git.matyas.bobek@gmail.com>
 <CAFEAcA95RcGhhN8ZqVeOgRyhRqSar23EnJhCjVgKBwoqXBJwjw@mail.gmail.com>
 <08A7BC6B-7019-45C4-B581-0A26AD3AA554@gmail.com>
 <202605271738.21722.pisa@fel.cvut.cz>
 <20260527-fast-unbiased-flamingo-5c5cbe-mkl@pengutronix.de>
 <07cc057c-61b3-4744-96fa-1d792989cb4c@munic.io>
 <20260527-durable-festive-millipede-f6e2b9-mkl@pengutronix.de>
Organization: Protonic Holland
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:9e0:8000::40; envelope-from=david@protonic.nl;
 helo=smtp28.bhosted.nl
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 28 May 2026 09:08:48 -0400
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 27 May 2026 20:38:10 +0200
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 27.05.2026 18:25:37, Andrei VOLKOV wrote:
> > As the original author, I have no objection to reusing (my part of) the
> > header under GPL-2.0-or-later. The reason it was not done that way in
> > 2005/2006 is simple: only GPLv2 existed at the time.
> >
> > All the more so since, as already noted, the code in question is essentially
> > a direct transcription of offsets and bit-fields from the Freescale/NXP
> > datasheets, which leaves very little room for a meaningful copyright claim
> > in the first place.
> >
> > Personally, I would prefer that this code not be rewritten and be kept as
> > is, to avoid introducing subtle bugs in QEMU later on.
> > That said, @Sascha and @David may have a different opinion.
> >
> > PS: andrey.volkov@munic.io is my correct current work address, but I would
> > prefer to use my personal one for this discussion.  
> 
> I've added David on Cc and given them a short overview of this
> discussion and linked this thread.
> 
> I'll agree to re-license the register definitions of the flexcan driver
> to GPL-2.0-or-later. I'll poke Sasha tomorrow.

I have no objections for this part to be used under GPL-2.0-or-later.

Best regards,

-- 
David Jander


