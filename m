Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39ACDD3399B
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 16:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5SSF-0000uu-CA; Mon, 28 Oct 2024 12:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+f257fec23c2a4eabf337+7736+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1t5SSD-0000uR-DP
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 12:18:53 -0400
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+f257fec23c2a4eabf337+7736+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1t5SSB-0006uO-D0
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 12:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
 :MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=C8mX4PXEjoqXMUGgb5Mn9KAI5YZMFTWUiBiXo2pQxEU=; b=CSixJc9KbGoYLDfMbDpJHLrYeW
 aeqSc6UBpwLif9DvpVrg/Kg9xn2TRK3rAuUoDII7dSly1eXME5mL2ZMwuFA+twED1xRHK5Xyj8jE3
 PB1J6eq1bxEYglvPRauXsodP5jp+wcoUCpULXLVnsekUjdTUXxyfzI12GHSHVxQDctVyEjUmYlyjC
 a7BWHea/obZJrLtPXkdC6Daj+AEl52k1zVOzqV8U11nC4JNIrUbzjZkGZrdpp2aSMheR9OJnXRUE2
 NMXhOoN5ws6i7ZrvSC3bUOBf+5jdQBKOtrFCVUHooMo0YpdQEy/v/H2uPF/O6t7WAU9GABJvcqCVp
 XZjdmJaA==;
Received: from [78.133.40.109] (helo=[127.0.0.1])
 by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
 id 1t5SRi-00000009hqM-19H1; Mon, 28 Oct 2024 16:18:22 +0000
Date: Mon, 28 Oct 2024 17:17:14 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Jakub Kicinski <kuba@kernel.org>
CC: Richard Cochran <richardcochran@gmail.com>,
 Peter Hilber <peter.hilber@opensynergy.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-rtc@vger.kernel.org, "Ridoux, Julien" <ridouxj@amazon.com>,
 virtio-dev@lists.linux.dev, "Luu, Ryan" <rluu@amazon.com>,
 "Chashper, David" <chashper@amazon.com>,
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
 Paolo Abeni <pabeni@redhat.com>,
 "Christopher S . Hall" <christopher.s.hall@intel.com>,
 Jason Wang <jasowang@redhat.com>, John Stultz <jstultz@google.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 qemu-devel <qemu-devel@nongnu.org>, Simon Horman <horms@kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net-next_v7=5D_ptp=3A_Add_supp?=
 =?US-ASCII?Q?ort_for_the_AMZNC10C_=27vmclock=27_device?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20241028091256.1b0752b4@kernel.org>
References: <78969a39b51ec00e85551b752767be65f6794b46.camel@infradead.org>
 <20241009173253.5eb545db@kernel.org>
 <c20d5f27c9106f3cb49e2d8467ade680f0092f91.camel@infradead.org>
 <20241014131238.405c1e58@kernel.org>
 <c1eb33ffd66d45af77dea58db8bdca3dcd2468c4.camel@infradead.org>
 <20241028091256.1b0752b4@kernel.org>
Message-ID: <5077F160-52F0-4E76-B2B9-F0EA9DA76FB4@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+f257fec23c2a4eabf337+7736+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 28 October 2024 17:12:56 CET, Jakub Kicinski <kuba@kernel=2Eorg> wrote:
>On Sat, 19 Oct 2024 18:49:24 +0100 David Woodhouse wrote:
>> > Yes please and thank you! We gotta straighten it out before=20
>> > the merge window=2E =20
>>=20
>> Hm, as I (finally) come to do that, I realise that many of the others
>> defined in drivers/ptp/Kconfig are also 'default y'=2E Which is only
>> really 'default PTP_1588_CLOCK' in practice since they all depend on
>> that=2E
>
>AFAICT nothing defaulted to enabled since 2017, so I'd chalk it up
>to us getting better at catching mistakes over time=2E
>
>> Most importantly, PTP_1588_CLOCK_KVM is 'default y'=2E And that one is
>> fundamentally broken (at least in the presence of live migration if
>> guests care about their clock suddenly being wrong) which is why it's
>> being superseded by the new VMCLOCK thing=2E We absolutely don't want t=
o
>> leave the _KVM one enabled by default and not its _VMCLOCK replacement=
=2E
>
>You can default to =2E=2E_CLOCK_KVM, and provide the explanation in
>the commit message and Kconfig help=2E

That works for me=2E But now it's my vacation time so it'll be at least Th=
ursday before I can do that=2E I'll offer a preemptive Acked-by: David Wood=
house <dwmw@amazon=2Eco=2Euk> to anyone who beats me to it :)


