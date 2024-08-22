Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE90C52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 11:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh6KT-0005XC-3D; Thu, 22 Aug 2024 07:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horms@kernel.org>) id 1sh6KO-0005WA-SG
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 07:50:09 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horms@kernel.org>) id 1sh6KL-0007Od-AY
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 07:50:08 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 643F461231;
 Thu, 22 Aug 2024 11:49:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C597C32782;
 Thu, 22 Aug 2024 11:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1724327395;
 bh=Dt4LFrbNnXt5IZdzzmCGwGIQswW/M/ytO2I8SZAYO2k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iOffhufbh+OB6mKyaAl/rLeZHOr1Z1boFD8T3qeWC6ZAHyUeZoJInBFPSHpnKDphg
 wHbxTpD1Py+lmvdiCRHhssuSYRZic5RSnq6IIY8u3fRxAu9emOdnV1q1HuT1cNeXZb
 vswlvoDOWx2TqKmcBQT0q0GNYdq5KlfQIcUE4s0ib5ZzJGuxK5sUAsciKHp52yuFqY
 WQxNRWKMTjleOk9KbFlmU444hnywblUsCrHBHuVTce0IMwkVvnH0FF4KO+MTnzSJCu
 B+Qr4TFYcZZl8GWr/Cmkw5WyeIUwQMOvIoMrVEHspAtORoIyqFlI82+0xfokZK3+dE
 N6rckoG/TIEmg==
Date: Thu, 22 Aug 2024 12:49:48 +0100
From: Simon Horman <horms@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 Peter Hilber <peter.hilber@opensynergy.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
 "Ridoux, Julien" <ridouxj@amazon.com>, virtio-dev@lists.linux.dev,
 "Luu, Ryan" <rluu@amazon.com>, "Chashper, David" <chashper@amazon.com>,
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
 "Christopher S . Hall" <christopher.s.hall@intel.com>,
 Jason Wang <jasowang@redhat.com>, John Stultz <jstultz@google.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH v4] ptp: Add vDSO-style vmclock support
Message-ID: <20240822114948.GM2164@kernel.org>
References: <410bbef9771ef8aa51704994a70d5965e367e2ce.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <410bbef9771ef8aa51704994a70d5965e367e2ce.camel@infradead.org>
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=horms@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Aug 21, 2024 at 10:50:47PM +0100, David Woodhouse wrote:

...

> diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c

...

> +#define VMCLOCK_FIELD_PRESENT(_c, _f)			  \
> +	(_c)->size >= (offsetof(struct vmclock_abi, _f) + \
> +		       sizeof((_c)->_f))
> +

...

> +static int vmclock_probe(struct platform_device *pdev)

...

> +	/* If there is valid clock information, register a PTP clock */
> +	if (VMCLOCK_FIELD_PRESENT(st->clk, time_frac_sec)) {

Hi David,

Sorry to be always the one with the nit-pick.
Sparse complains about the line above, I believe because the
type of st->clk->size is __le32.

.../ptp_vmclock.c:562:13: warning: restricted __le32 degrades to integer

> +		/* Can return a silent NULL, or an error. */
> +		st->ptp_clock = vmclock_ptp_register(dev, st);
> +		if (IS_ERR(st->ptp_clock)) {
> +			ret = PTR_ERR(st->ptp_clock);
> +			st->ptp_clock = NULL;
> +			vmclock_remove(pdev);
> +			goto out;
> +		}
> +	}

...


