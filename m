Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E4ACED611
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 00:33:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syh74-0006Uq-4E; Wed, 09 Oct 2024 20:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuba@kernel.org>) id 1syh71-0006UV-MS
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 20:33:03 -0400
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuba@kernel.org>) id 1syh70-0005Nh-5o
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 20:33:03 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 0DEEAA4484C;
 Thu, 10 Oct 2024 00:32:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6633CC4CEC3;
 Thu, 10 Oct 2024 00:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1728520375;
 bh=QarAG9OsS0S7oXws7XJsQIFCQAcnaMCbtsh+DM35Fcw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=FGn0J00HfbQ3QOMVUqk1P7sFWmH62grr/Lc9+Ar39iMKi+ib9tL6BLhCpOB1ZxllE
 0MRu42N7V/iGB9cBbdJfiOwSrsdTdPn9NwUypq52PfjxzpFXlkEinsT7EEDfvrNRzb
 nXmCqlafauZ46G5rrpSPV+rUEZE82Ux0wGJWns13gCl7f/La5N026MaRT4hHcTFvfe
 tKxX77Y0gwrEKnMPMJYe6QSgQ1FOHg8/8C1cCfAuBbez7m+eCCrHicLjxZzIrFkuNb
 PVKAHtJnkdlmyu1fKMNRcxPyIZ5CmvG2vp3tw9AP0i1TQBMI9i3oJM27PgPVmhYMrT
 Km5smAzOMfAcQ==
Date: Wed, 9 Oct 2024 17:32:53 -0700
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
Message-ID: <20241009173253.5eb545db@kernel.org>
In-Reply-To: <78969a39b51ec00e85551b752767be65f6794b46.camel@infradead.org>
References: <78969a39b51ec00e85551b752767be65f6794b46.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=kuba@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, 06 Oct 2024 08:17:58 +0100 David Woodhouse wrote:
> +config PTP_1588_CLOCK_VMCLOCK
> +	tristate "Virtual machine PTP clock"
> +	depends on X86_TSC || ARM_ARCH_TIMER
> +	depends on PTP_1588_CLOCK && ACPI && ARCH_SUPPORTS_INT128
> +	default y

Why default to enabled? Linus will not be happy..

