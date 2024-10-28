Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC2BD33998
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 16:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5SMe-0007Aj-VP; Mon, 28 Oct 2024 12:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuba@kernel.org>) id 1t5SMc-0007AL-Vf
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 12:13:07 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuba@kernel.org>) id 1t5SMb-0006RZ-8h
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 12:13:06 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 33E935C5D58;
 Mon, 28 Oct 2024 16:12:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1B6C4CEC3;
 Mon, 28 Oct 2024 16:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1730131979;
 bh=xuzSVIC+24hcvUH3Uu6IJyxDoI8NF9z/u0YhE9kqbOY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=C0q+lkSKR1cXdmfA70QriKxNHoGAVcH+ZKCc+Zox4ygDHb48qTdn8VuHT2A4+o5V2
 zoili6j4ZeZdYddsbvCBmzv4/WQgpSj7kTlw06ahaK4hCP3zTRP9o3R85+DvpU2GYF
 JOfOD4cd4nqkmkIlo1feNr7WS5I7Lq9w9Ag0huIfm0H86flbsmELoeR1CWqpKwnAA6
 NYQH1pJbxeuWuW0ou07d6MW7v+ovxkDt0VgRA/OeSEyVzpisDjPRrKkn0IRURMLEiE
 huG9vkW7i5jsybC0co+F32KJLuGZov4R0mWfhQFuXfe18nE4zlmADox5tRHMwhBpHw
 r+wobvKfES9+g==
Date: Mon, 28 Oct 2024 09:12:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Richard Cochran <richardcochran@gmail.com>, Peter Hilber
 <peter.hilber@opensynergy.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-rtc@vger.kernel.org, "Ridoux, Julien" <ridouxj@amazon.com>,
 virtio-dev@lists.linux.dev, "Luu, Ryan" <rluu@amazon.com>, "Chashper,
 David" <chashper@amazon.com>, "Mohamed Abuelfotoh, Hazem"
 <abuehaze@amazon.com>, Paolo Abeni <pabeni@redhat.com>, "Christopher S .
 Hall" <christopher.s.hall@intel.com>, Jason Wang <jasowang@redhat.com>,
 John Stultz <jstultz@google.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Marc Zyngier
 <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, qemu-devel
 <qemu-devel@nongnu.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v7] ptp: Add support for the AMZNC10C 'vmclock'
 device
Message-ID: <20241028091256.1b0752b4@kernel.org>
In-Reply-To: <c1eb33ffd66d45af77dea58db8bdca3dcd2468c4.camel@infradead.org>
References: <78969a39b51ec00e85551b752767be65f6794b46.camel@infradead.org>
 <20241009173253.5eb545db@kernel.org>
 <c20d5f27c9106f3cb49e2d8467ade680f0092f91.camel@infradead.org>
 <20241014131238.405c1e58@kernel.org>
 <c1eb33ffd66d45af77dea58db8bdca3dcd2468c4.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=kuba@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, 19 Oct 2024 18:49:24 +0100 David Woodhouse wrote:
> > Yes please and thank you! We gotta straighten it out before 
> > the merge window.  
> 
> Hm, as I (finally) come to do that, I realise that many of the others
> defined in drivers/ptp/Kconfig are also 'default y'. Which is only
> really 'default PTP_1588_CLOCK' in practice since they all depend on
> that.

AFAICT nothing defaulted to enabled since 2017, so I'd chalk it up
to us getting better at catching mistakes over time.

> Most importantly, PTP_1588_CLOCK_KVM is 'default y'. And that one is
> fundamentally broken (at least in the presence of live migration if
> guests care about their clock suddenly being wrong) which is why it's
> being superseded by the new VMCLOCK thing. We absolutely don't want to
> leave the _KVM one enabled by default and not its _VMCLOCK replacement.

You can default to .._CLOCK_KVM, and provide the explanation in
the commit message and Kconfig help.
Or if you feel strongly even make CLOCK_KVM depend on the new one?

> Please advise... I suspect the best answer is to leave it as it is? 

I'd really rather not. Linus has complained to us about Kconfig symbols
appearing / getting enabled by default multiple times in the past.

Sorry for the delay, vacation time.

