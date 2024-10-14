Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB39D1813A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 20:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0RQy-00059U-H0; Mon, 14 Oct 2024 16:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuba@kernel.org>) id 1t0RQr-000596-Vs
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 16:12:48 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuba@kernel.org>) id 1t0RQp-00029S-Pc
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 16:12:45 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 1F7385C5BB5;
 Mon, 14 Oct 2024 20:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2ED4C4CEC3;
 Mon, 14 Oct 2024 20:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1728936760;
 bh=ZTBxdRUCQr80BBF8O7VYgUYSjhbIYghb8AV3U3WUn/o=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=l4xDbyNFEt5AbgSRRn6USSqmX4KqbacdsJnmKr1iUXlZc1hV+G0tPUz4bLCpYhrU7
 1BMbEuAzxNfPY5HZGTq27URh+n5VJQzOtXE8F/ArHmPO7Ou0nb1hRLM7QgX4rA1mZX
 +4WQHPIw3WKobqtPu13Gspjw8UOssLPxFXSpgSXtuUxoNAkgPTKp9rI+FvTPEFgKo/
 5t862vqDQuUfEMXaPyafwXPIhNAOpVsTdkPNSiA1wkib4U/fSIaItErgNbKNbUQEwN
 YilCTnDOxiI/0ehc/aBqZvVKjefh2pUgSyerPStonPQJ6dJ8hs+BnIterzf75wLWfD
 gS1zONSrqmJqQ==
Date: Mon, 14 Oct 2024 13:12:37 -0700
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
Message-ID: <20241014131238.405c1e58@kernel.org>
In-Reply-To: <c20d5f27c9106f3cb49e2d8467ade680f0092f91.camel@infradead.org>
References: <78969a39b51ec00e85551b752767be65f6794b46.camel@infradead.org>
 <20241009173253.5eb545db@kernel.org>
 <c20d5f27c9106f3cb49e2d8467ade680f0092f91.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=kuba@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.076,
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

On Mon, 14 Oct 2024 08:25:35 +0100 David Woodhouse wrote:
> On Wed, 2024-10-09 at 17:32 -0700, Jakub Kicinski wrote:
> > On Sun, 06 Oct 2024 08:17:58 +0100 David Woodhouse wrote: =20
> > > +config PTP_1588_CLOCK_VMCLOCK
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tristate "Virtual machine =
PTP clock"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on X86_TSC || ARM_=
ARCH_TIMER
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on PTP_1588_CLOCK =
&& ACPI && ARCH_SUPPORTS_INT128
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default y =20
> >=20
> > Why default to enabled? Linus will not be happy.. =20
>=20
> Want an incremental patch to change that?

Yes please and thank you! We gotta straighten it out before=20
the merge window.

