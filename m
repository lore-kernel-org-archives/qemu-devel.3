Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C824BC3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 14:16:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCfYC-0005uV-2t; Wed, 07 May 2025 10:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1uCfYA-0005sG-Bp; Wed, 07 May 2025 10:15:06 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1uCfY8-0001lU-Sj; Wed, 07 May 2025 10:15:06 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E15A75C5B0A;
 Wed,  7 May 2025 14:12:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F52C4CEE2;
 Wed,  7 May 2025 14:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746627300;
 bh=kjC8owSJbzDuKvUd5iBB03rp46mjqxf1yzEu+x7yIlQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ptp2ZS7W6NeV63hDzYvCkoMuXEd478EmjOG7UYcubpzgAWgIqQHWQFgdFzPz3SWZN
 KwM/wey18nKOIHSYHJZv5U0dOCKZ3iBsOCX50+5H5Luynj8pJdMmqKWtKKqiLwLTyb
 /bEbwO2RM50Cad0cA39c/VihiiIzWfDSoiVtka1VFyQbHmuvXJVqvbK2fuhTRq2ZEU
 fzCHyCYOkBdrk5eX/gjXyPMfgWR4XenyEEtNWt16luqup/LYlrIF2dJOZ3sd8G+xf5
 CUUSuNpDvZd917qktzN6xduIQ81EtmD5j4eU1OSM4cookX9qXkVXEQu5WARqEr4sOn
 VEbYn06TktfcQ==
Date: Wed, 7 May 2025 08:14:58 -0600
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-stable@nongnu.org,
 =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@stgraber.org>
Subject: Re: [PATCH] hw/nvme: fix nvme hotplugging
Message-ID: <aBtq4it04wpPSZkX@kbusch-mbp.dhcp.thefacebook.com>
References: <20250507-fix-non-hotpluggable-subsys-v1-1-667f224ebc0f@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507-fix-non-hotpluggable-subsys-v1-1-667f224ebc0f@samsung.com>
Received-SPF: pass client-ip=139.178.84.217; envelope-from=kbusch@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -84
X-Spam_score: -8.5
X-Spam_bar: --------
X-Spam_report: (-8.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Wed, May 07, 2025 at 09:30:55AM +0200, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Commit cd59f50ab017 caused a regression on nvme hotplugging for devices
> with an implicit nvm subsystem.
> 
> The nvme-subsys device was incorrectly left with being marked as
> non-hotpluggable. Fix this.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

