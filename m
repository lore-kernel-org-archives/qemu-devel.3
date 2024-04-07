Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E454CD128A
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2024 15:16:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtUFd-00069V-5u; Sun, 07 Apr 2024 11:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patchwork-bot+netdevbpf@kernel.org>)
 id 1rtTqw-0002QM-Jz
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 10:50:38 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patchwork-bot+netdevbpf@kernel.org>)
 id 1rtTqu-0005iB-TQ
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 10:50:38 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 10BCF60C66;
 Sun,  7 Apr 2024 14:50:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2986C433C7;
 Sun,  7 Apr 2024 14:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1712501428;
 bh=3NpH5R0cVdwG55tWo4S05Y/2aK0dgTnsL65UnhXoKmw=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=HQxdpSnqvJ5ndkGtMSQhnuZ0GuF8iQMAe2Y/rdW8GsvVZCKrQ/O5oyW3IhtlkmN1/
 YWoPUnC2ADXX1/B1QTc0AsoIxZl/nidfGjBZqv+ZtZRfEVZ+mh567Da3zrqj53a5x+
 8sFakqJYd3nCa6+Dje+ae0H4ZVIfKe9JcqEG/XwxXq4/x7EOQNJ/dTpXGnOCC1HNjX
 hWjZ8e88JdjI1RuoIJkgK4MuzXX1bY3tFrSXk+cFDk8DIh43Q4ZgDsn94ROvUPuU6t
 0sOgvi/AUvkVgQuMIYRXHa8eJeuFLnkn0tKYJsS/Va94iQB7Qiis0J2ryb1D/cuVqr
 oqAvxBi3UDXVQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 92384D7E2B1; Sun,  7 Apr 2024 14:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] virtio_net: Do not send RSS key if it is not
 supported
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <171250142859.30136.10958803623122674552.git-patchwork-notify@kernel.org>
Date: Sun, 07 Apr 2024 14:50:28 +0000
References: <20240403154313.1331319-1-leitao@debian.org>
In-Reply-To: <20240403154313.1331319-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: hengqi@linux.alibaba.com, xuanzhuo@linux.alibaba.com, mst@redhat.com,
 jasowang@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@daynix.com, rbc@meta.com,
 riel@surriel.com, stable@vger.kernel.org, qemu-devel@nongnu.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=patchwork-bot+netdevbpf@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -94
X-Spam_score: -9.5
X-Spam_bar: ---------
X-Spam_report: (-9.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 07 Apr 2024 11:16:05 -0400
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

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  3 Apr 2024 08:43:12 -0700 you wrote:
> There is a bug when setting the RSS options in virtio_net that can break
> the whole machine, getting the kernel into an infinite loop.
> 
> Running the following command in any QEMU virtual machine with virtionet
> will reproduce this problem:
> 
>     # ethtool -X eth0  hfunc toeplitz
> 
> [...]

Here is the summary with links:
  - [net,v4] virtio_net: Do not send RSS key if it is not supported
    https://git.kernel.org/netdev/net/c/059a49aa2e25

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



