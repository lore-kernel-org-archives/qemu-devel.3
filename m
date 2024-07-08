Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4904FC3DA42
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 13:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQoLl-00022A-Lp; Mon, 08 Jul 2024 09:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horms@kernel.org>) id 1sQkV0-0001U7-B8
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 05:17:34 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horms@kernel.org>) id 1sQkUu-0003kH-V7
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 05:17:30 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 02EAE60B37;
 Mon,  8 Jul 2024 09:17:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF410C116B1;
 Mon,  8 Jul 2024 09:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1720430235;
 bh=7movIOln5FthDg/xi31aDehlhJhJvIbc2LrM9jeDAKw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pYukOoa+4ATZ673jdHLmqVqq2lPB1o/rLAjEWyDzlNY838hgsSalPSWBfzjpbM+Ok
 adhXPZbu/lnuYk/banGIPjNBokQP/JsRXWe3waHfWkXljGAQ88vWukbk5ErdUSAMJo
 1qOzG2GSH7AMPT45SzOdhGnw2EBcgXwFW8LUcr7B3vvM5RmB9Kf2I50kYgqv2UTLAs
 0iu6/4BaQ6Wg5hX5or08u57apD+rdEvP00CvpVPpuW32vD3nvpZwcTGAjW9EXBp9Ld
 9ql+qgQZjTkr/Hwu/zZwodbzTtmjMTlseJnHNj5FCs98g7ZLiMtzFUJayHCP5RQCJI
 b9e7UEHJDAdFA==
Date: Mon, 8 Jul 2024 10:17:08 +0100
From: Simon Horman <horms@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Peter Hilber <peter.hilber@opensynergy.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
 "Ridoux, Julien" <ridouxj@amazon.com>, virtio-dev@lists.linux.dev,
 "Luu, Ryan" <rluu@amazon.com>, "Chashper, David" <chashper@amazon.com>,
 "Christopher S. Hall" <christopher.s.hall@intel.com>,
 Jason Wang <jasowang@redhat.com>, John Stultz <jstultz@google.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Richard Cochran <richardcochran@gmail.com>,
 Stephen Boyd <sboyd@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [RFC PATCH v3] ptp: Add vDSO-style vmclock support
Message-ID: <20240708091708.GJ1481495@kernel.org>
References: <830699d1fa8aaf3de1fa9ded54228d0811b5aab8.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <830699d1fa8aaf3de1fa9ded54228d0811b5aab8.camel@infradead.org>
Received-SPF: pass client-ip=139.178.84.217; envelope-from=horms@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 08 Jul 2024 09:24:12 -0400
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

On Sat, Jul 06, 2024 at 04:14:39PM +0100, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The vmclock "device" provides a shared memory region with precision clock
> information. By using shared memory, it is safe across Live Migration.
> 
> Like the KVM PTP clock, this can convert TSC-based cross timestamps into
> KVM clock values. Unlike the KVM PTP clock, it does so only when such is
> actually helpful.
> 
> The memory region of the device is also exposed to userspace so it can be
> read or memory mapped by application which need reliable notification of
> clock disruptions.
> 
> The shared memory structure is intended to be adopted into the nascent
> virtio-rtc specification (since one might consider a virtio-rtc
> specification that doesn't fix the live migration problem to be not fit
> for purpose). It can also be presented via a simple ACPI device.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

...

> diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c

...

> +	/* If there is valid clock information, register a PTP clock */
> +	if (st->cs_id) {
> +		st->ptp_clock_info = ptp_vmclock_info;
> +		strncpy(st->ptp_clock_info.name, st->name, sizeof(st->ptp_clock_info.name));

Hi David,

As per my comment on v2, although it is harmless in this case,
it would be nicer to use strscpy() here and avoid fortification warnings.


...


