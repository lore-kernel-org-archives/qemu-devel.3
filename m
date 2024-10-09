Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9C3CF0454
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 11:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syUkK-0001HN-3w; Wed, 09 Oct 2024 07:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patchwork-bot+netdevbpf@kernel.org>)
 id 1syUkI-0001Gs-PG
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 07:20:46 -0400
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patchwork-bot+netdevbpf@kernel.org>)
 id 1syUkD-0003Jh-GB
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 07:20:46 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id B9BF6A43DF0;
 Wed,  9 Oct 2024 11:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0266BC4CEC5;
 Wed,  9 Oct 2024 11:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1728472836;
 bh=PO8I+wMbjxk9wJfkhxRi+SCshRAINl3eIBujy6ev3Ls=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=PeESnne9gUBTqt1NgQA+awNIHrQWQTICrFJrCONIO3tOGkbY/2LmnOhHfDZSYfTgR
 cph7avFYYMzp+p1RYXzh1ibKqxQOU1IJNokN8s/KhovSMS1GWpHXYlwMctZR9wchsL
 T8TIEEMKdnkygw0j70wYKL6ojUHV8zd99fDLP3EFGE3CN/nLNzZxciE51NVgXCmCsv
 3IDlMd41VXau/Kbj9+i+R53gKepIZpI88SszBWGmlTAY0HuLBAV8/tmjKqjjsA/ZTO
 6QxFNXZnjTElDshCgCE5B1Jb0NwpHjFPPG+dD3DQplF3yfE/UQ9USOoB/yyckfofv1
 yUJkB24Uq9/Rg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 70D3D3806644; Wed,  9 Oct 2024 11:20:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7] ptp: Add support for the AMZNC10C 'vmclock'
 device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <172847284000.1228916.8770974683503977940.git-patchwork-notify@kernel.org>
Date: Wed, 09 Oct 2024 11:20:40 +0000
References: <78969a39b51ec00e85551b752767be65f6794b46.camel@infradead.org>
In-Reply-To: <78969a39b51ec00e85551b752767be65f6794b46.camel@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: richardcochran@gmail.com, peter.hilber@opensynergy.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
 ridouxj@amazon.com, virtio-dev@lists.linux.dev, rluu@amazon.com,
 chashper@amazon.com, abuehaze@amazon.com, pabeni@redhat.com,
 christopher.s.hall@intel.com, jasowang@redhat.com, jstultz@google.com,
 mst@redhat.com, netdev@vger.kernel.org, sboyd@kernel.org, tglx@linutronix.de, 
 xuanzhuo@linux.alibaba.com, maz@kernel.org, mark.rutland@arm.com,
 daniel.lezcano@linaro.org, a.zummo@towertech.it,
 alexandre.belloni@bootlin.com, qemu-devel@nongnu.org, horms@kernel.org
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=patchwork-bot+netdevbpf@kernel.org; helo=nyc.source.kernel.org
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

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun, 06 Oct 2024 08:17:58 +0100 you wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The vmclock device addresses the problem of live migration with
> precision clocks. The tolerances of a hardware counter (e.g. TSC) are
> typically around ±50PPM. A guest will use NTP/PTP/PPS to discipline that
> counter against an external source of 'real' time, and track the precise
> frequency of the counter as it changes with environmental conditions.
> 
> [...]

Here is the summary with links:
  - [net-next,v7] ptp: Add support for the AMZNC10C 'vmclock' device
    https://git.kernel.org/netdev/net-next/c/205032724226

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



