Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCE4E7717D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 01:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLXzq-0007lR-4p; Wed, 11 Dec 2024 20:28:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patchwork-bot+linux-riscv@kernel.org>)
 id 1tLVGQ-0006wV-Lb
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 17:33:02 -0500
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patchwork-bot+linux-riscv@kernel.org>)
 id 1tLVGO-0005ge-Nu
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 17:33:02 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 3B2BAA41D7A;
 Wed, 11 Dec 2024 22:30:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF38C4CEDD;
 Wed, 11 Dec 2024 22:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733956370;
 bh=HsV2hgf0fbYGgHmLxzKHUU+rPda90YFsJKEFrTRZGjc=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=vOONck9QSCmGFAHL/+qROtp77YjI5J4I/SNx0ir3wUFq4T7bxTbb2voI8ut/Ww9hs
 umsbLAHyc22326U3EC8FWHJ3RCF4ulGvVPT8unOrZjZcpbnYzq8lhQ8KZU/C75OtUl
 TO35ohplFrGjkcnKUJpkMytFDmtP45NC6yfOPGcqz1mXjqA+0VDaJ219FdT3oRfhjQ
 +iTuIQURyuJN/K99Xa7QwlpMG5dyEGecunWyNHIBydjo4JIfHZWyknpdRE7t11ztmj
 /DFlKfV5HP6jQUF0INgFoLP6GW3gvNPKM3C4afp9/wcwEriIMhkxgMsNY64t5aAjCO
 +zJCDNgxMnL1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 710F2380A965; Wed, 11 Dec 2024 22:33:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] firmware: Switch back to struct platform_driver::remove()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: <173395638610.1729195.7835904976463124425.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 22:33:06 +0000
References: <36974feb6035201d53384557259ec72fe311053b.1731397962.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <36974feb6035201d53384557259ec72fe311053b.1731397962.git.u.kleine-koenig@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=3Cu=2Ekleine-koenig=40baylibre=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-riscv@lists.infradead.org, sudeep.holla@arm.com,
 cristian.marussi@arm.com, tzungbi@kernel.org, briannorris@chromium.org,
 jwerner@chromium.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, conor.dooley@microchip.com,
 daire.mcnamara@microchip.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, somlo@cmu.edu, mst@redhat.com,
 florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 dinguyen@kernel.org, michal.simek@amd.com, gregkh@linuxfoundation.org,
 wahrenst@gmx.net, laurent.pinchart@ideasonboard.com,
 jay.buddhabhatti@amd.com, ronak.jain@amd.com, radhey.shyam.pandey@amd.com,
 praveen.teja.kundanala@amd.com, arm-scmi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 chrome-platform@lists.linux.dev, imx@lists.linux.dev,
 linux-mediatek@lists.infradead.org, qemu-devel@nongnu.org,
 linux-rpi-kernel@lists.infradead.org
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=patchwork-bot+linux-riscv@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 11 Dec 2024 20:28:04 -0500
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

This patch was applied to riscv/linux.git (fixes)
by Greg Kroah-Hartman <gregkh@linuxfoundation.org>:

On Tue, 12 Nov 2024 09:35:20 +0100 you wrote:
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
> 
> Convert all platform drivers below drivers/firmware to use .remove(),
> with the eventual goal to drop struct platform_driver::remove_new(). As
> .remove() and .remove_new() have the same prototypes, conversion is done
> by just changing the structure member name in the driver initializer.
> 
> [...]

Here is the summary with links:
  - firmware: Switch back to struct platform_driver::remove()
    https://git.kernel.org/riscv/c/5770e9f237b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



