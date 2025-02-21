Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57DBFC021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 18:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlYCl-0001bu-Eo; Fri, 21 Feb 2025 13:56:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1tlYCj-0001bk-Sv
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 13:56:53 -0500
Received: from tor.source.kernel.org ([2600:3c04::f03c:95ff:fe5e:7468])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1tlYCi-0002sr-1b
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 13:56:53 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 31747615B3;
 Fri, 21 Feb 2025 18:56:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261EFC4CED6;
 Fri, 21 Feb 2025 18:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1740164202;
 bh=JMeltP4JccM0RkmxzJfwJut6yFf1docnfwVekhVdV/o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fHJ1SslLe+NsDZHOC+2/tvpKuM9AwNLOoeeye+EzF3/DnMlYXuWAh6zQ5/68QI9Lg
 HBEhB46HXXKABppyKwDG3keTzh6loSlMBWt34TgZVCwkFaG3FgQ7IYxsfBWS+6TCpP
 B0uy6EnwUcA5597Sep60tun5cVMF9ZD+RoAE3y8rMGtl5bzGmEl3qm5VMM92pLUyWT
 U3U1OrB4v3cy3Hh8eW8F2s8LulgFdOhjzzvECFRaJLOtIE5iKu5B46VRR/dzDa7qa9
 KojjkOY/BKoz6LYvt/SfGVF9YUy80L4lgOEW+7rH0ZMoO90PLRdS858o1aqGWhY7ch
 DYjX/nmAZQ6JA==
Date: Fri, 21 Feb 2025 18:56:40 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Wei Liu <liuwe@linux.microsoft.com>, qemu-devel@nongnu.org,
 wei.liu@kernel.org, dirty@apple.com, rbolshakov@ddn.com,
 phil@philjordan.eu, jinankjain@linux.microsoft.com,
 liuwe@microsoft.com, muislam@microsoft.com,
 ziqiaozhou@microsoft.com, mukeshrathor@microsoft.com,
 magnuskulke@microsoft.com, prapal@microsoft.com,
 jpiotrowski@microsoft.com, deviv@microsoft.com
Subject: Re: [RFC PATCH v1 00/19] Factor out HVF's instruction emulator
Message-ID: <Z7jMaKYAi__dmwHG@liuwe-devbox-debian-v2>
References: <1740126987-8483-1-git-send-email-liuwe@linux.microsoft.com>
 <1cf2edfd-5cce-4b15-bc28-4dcde96767b5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cf2edfd-5cce-4b15-bc28-4dcde96767b5@redhat.com>
Received-SPF: pass client-ip=2600:3c04::f03c:95ff:fe5e:7468;
 envelope-from=wei.liu@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
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

On Fri, Feb 21, 2025 at 05:36:39PM +0100, Paolo Bonzini wrote:
> On 2/21/25 09:36, Wei Liu wrote:
> > This patch series attempts to make the instruction emulator in HVF a common
> > component for the i386 target. It removes HVF specific code by either using a
> > set of hooks or moving it to better locations. The new incoming MSHV
> > accelerator will implement the hooks, and where necessary, enhance the emulator
> > and / or add new hooks.
> 
> Good!
> 
> > This patch series is in RFC state. The patches have been lightly tested by
> > running a Linux VM on an Intel-based Mac.  We hope to get some feedback on the
> > overall approach, and let the community bikeshed a bit about names and
> > location.
> 
> For the bikeshedding my only suggestion is to replace mmio_buf with
> emu_mmio_buf, and replace x86-insn-emul, with just "emulate" or something
> like that.  That is, no need to repeat x86 inside the target/i386 directory,
> especially since the filenames also start with x86.
> 

No problem. We can make the changes in the next version.

> > First two patches fix issues in the existing code. They can be applied
> > regardless of the discussion around the overall approach.
> 
> These four can also be applied:
> 
>  target/i386/hvf: use x86_segment in x86_decode.c
>  target/i386/hvf: move and rename {load, store}_regs
>  target/i386/hvf: move and rename simulate_{rdmsr, wrmsr}
>  target/i386/hvf: drop some dead code
> 
> > The checkpatch script complains about a few things. Some are from the original
> > code I didn't touch. For the code I changed or moved, it complains that some
> > lines are long (>80). Seeing that the rule was not followed strictly in the old
> > code base, I held off fixing that class of issues. The other thing it complains
> > is there is no entry for the new directory in MAINTAINERS. We can fix these
> > issues if they are deemed important.
> 
> Yes, no problem.  The new directory thing is just a warning but I think you
> could add a new entry with both MSHV and HVF people on it.
> 

Okay, that works, too.

> > Please let us know what you think. The alternative is to duplicate the
> > instruction emulator code in the mshv accelerator. That looks to be a worse
> > option.
> Yes, definitely.

Thank you for the feedback.

Wei.

