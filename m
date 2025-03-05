Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF3BAC282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 16:50:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tprx9-0005X9-3e; Wed, 05 Mar 2025 11:50:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liuwe@linux.microsoft.com>)
 id 1tprx5-0005S7-Je
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:50:36 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liuwe@linux.microsoft.com>) id 1tprx3-0005cf-Kl
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:50:35 -0500
Received: by linux.microsoft.com (Postfix, from userid 1031)
 id E1BDF210EAE4; Wed,  5 Mar 2025 08:50:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E1BDF210EAE4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741193429;
 bh=HD2Q2eqBSr1Bd7VFPhpDWcZaGl1xY563UZIDx59DpZU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iA1sMgSOsEjeosxmcwM89UNmvxzGIJ1xSfVUJNDZriQ5HAeUJhqkyGijBAfAojElG
 40T+cO0psT0pqVrX3fz/rK2w0CJ9zBd49FDfbBiUizqxmnvPcmkcACmAubf35ot+V/
 LyejZRtqghxaRPQ3AH81kWKOHX2NvXIP4XzLtNuQ=
Date: Wed, 5 Mar 2025 08:50:29 -0800
From: Wei Liu <liuwe@linux.microsoft.com>
To: qemu-devel@nongnu.org, dirty@apple.com, rbolshakov@ddn.com,
 phil@philjordan.eu
Cc: wei.liu@kernel.org, dirty@apple.com, rbolshakov@ddn.com,
 phil@philjordan.eu, jinankjain@linux.microsoft.com,
 liuwe@microsoft.com, muislam@microsoft.com,
 ziqiaozhou@microsoft.com, mukeshrathor@microsoft.com,
 magnuskulke@microsoft.com, prapal@microsoft.com,
 jpiotrowski@microsoft.com, deviv@microsoft.com,
 Wei Liu <liuwe@linux.microsoft.com>
Subject: Re: [RFC PATCH v1 00/19] Factor out HVF's instruction emulator
Message-ID: <20250305165029.GA23337@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1740126987-8483-1-git-send-email-liuwe@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1740126987-8483-1-git-send-email-liuwe@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=liuwe@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Hi Cameron, Roman and Phil,

On Fri, Feb 21, 2025 at 12:36:08AM -0800, Wei Liu wrote:
> Hi,
> 
> Microsoft's Linux Systems Group developed a Linux driver for the Microsoft
> Hypervisor (MSHV for short). The driver is being upstreamed. The first
> supported VMM is Cloud Hypervisor. QEMU will be the second supported
> VMM.
> 
> The plan is to write an mshv accelerator in QEMU. The accelerator is still in
> the works.
> 
> MSHV doesn't emulate instructions. VMMs are supposed to bring their own
> instruction emulator. The path we've chosen is to reuse what's already in QEMU.
> The instruction emulator in HVF looks good for what we need.
> 
> This patch series attempts to make the instruction emulator in HVF a common
> component for the i386 target. It removes HVF specific code by either using a
> set of hooks or moving it to better locations. The new incoming MSHV
> accelerator will implement the hooks, and where necessary, enhance the emulator
> and / or add new hooks.
> 
> This patch series is in RFC state. The patches have been lightly tested by
> running a Linux VM on an Intel-based Mac.  We hope to get some feedback on the
> overall approach, and let the community bikeshed a bit about names and
> location.
> 
> First two patches fix issues in the existing code. They can be applied
> regardless of the discussion around the overall approach.
> 
> The checkpatch script complains about a few things. Some are from the original
> code I didn't touch. For the code I changed or moved, it complains that some
> lines are long (>80). Seeing that the rule was not followed strictly in the old
> code base, I held off fixing that class of issues. The other thing it complains
> is there is no entry for the new directory in MAINTAINERS. We can fix these
> issues if they are deemed important.
> 
> Please let us know what you think. The alternative is to duplicate the
> instruction emulator code in the mshv accelerator. That looks to be a worse
> option.
> 

As the maintainers of this code, do you have any comments on this?

I have addressed the comments from Paolo. I'm wondering if I should wait
for your input or just post another version.

Thanks,
Wei.

