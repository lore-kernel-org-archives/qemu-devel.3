Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4497BC021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 19:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlYL9-0003f9-U4; Fri, 21 Feb 2025 14:05:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liuwe@linux.microsoft.com>)
 id 1tlYL7-0003ef-OZ
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 14:05:33 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liuwe@linux.microsoft.com>) id 1tlYL5-0003jY-2V
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 14:05:33 -0500
Received: by linux.microsoft.com (Postfix, from userid 1031)
 id 825A1204E5BD; Fri, 21 Feb 2025 11:05:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 825A1204E5BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740164729;
 bh=IRBAU6rBWb+L5/tWaqNWBPBQYAg+ndBWcqtv3DOLKZ4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jKWR1Y/3fUN+M5KaOpeg5yzkg61kSYIA0hwo1P1/qCBNLE5T/FQFmI6R5DCvmXOCo
 n47itZzqNTENX7QRogz53sCaPOl0oiLQ4j2qc14NMLRPkzkXkx3ETUAh8u6DPBQTwf
 XcTcS9QBkPNtuZeKGwYt956Pv9JyOBzIxcfD9LHM=
Date: Fri, 21 Feb 2025 11:05:29 -0800
From: Wei Liu <liuwe@linux.microsoft.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Wei Liu <liuwe@linux.microsoft.com>, qemu-devel@nongnu.org,
 wei.liu@kernel.org, dirty@apple.com, rbolshakov@ddn.com,
 phil@philjordan.eu, jinankjain@linux.microsoft.com,
 liuwe@microsoft.com, muislam@microsoft.com,
 ziqiaozhou@microsoft.com, mukeshrathor@microsoft.com,
 magnuskulke@microsoft.com, prapal@microsoft.com,
 jpiotrowski@microsoft.com, deviv@microsoft.com
Subject: Re: [RFC PATCH v1 00/19] Factor out HVF's instruction emulator
Message-ID: <20250221190529.GA595@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1740126987-8483-1-git-send-email-liuwe@linux.microsoft.com>
 <CAFEAcA9pEajzzPidCJG3iZraH3FneKv=LGpidn+3cDhM_=XjfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9pEajzzPidCJG3iZraH3FneKv=LGpidn+3cDhM_=XjfQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=liuwe@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Fri, Feb 21, 2025 at 04:53:26PM +0000, Peter Maydell wrote:
> On Fri, 21 Feb 2025 at 14:02, Wei Liu <liuwe@linux.microsoft.com> wrote:
> >
> > Hi,
> >
> > Microsoft's Linux Systems Group developed a Linux driver for the Microsoft
> > Hypervisor (MSHV for short). The driver is being upstreamed. The first
> > supported VMM is Cloud Hypervisor. QEMU will be the second supported
> > VMM.
> >
> > The plan is to write an mshv accelerator in QEMU. The accelerator is still in
> > the works.
> >
> > MSHV doesn't emulate instructions. VMMs are supposed to bring their own
> > instruction emulator. The path we've chosen is to reuse what's already in QEMU.
> > The instruction emulator in HVF looks good for what we need.
> >
> > This patch series attempts to make the instruction emulator in HVF a common
> > component for the i386 target. It removes HVF specific code by either using a
> > set of hooks or moving it to better locations. The new incoming MSHV
> > accelerator will implement the hooks, and where necessary, enhance the emulator
> > and / or add new hooks.
> 
> If you want to make the hvf decoder more widely used you might want
> to look at this old patch to it that was never applied (issues in
> code review not addressed by the submitter):
> 
> https://lore.kernel.org/qemu-devel/CAFEAcA8yaBOD3KXc-DY94oqzC5wkCENPkePgVCybqR=9NmdQFQ@mail.gmail.com/
> 
> which is trying to fix a problem where an overlong string of
> prefix bytes causes the decoder to misbehave.
> 

Thanks for the information.

> (PS: if in the future you should ever find yourself wanting to do an
> equivalent "decode loads/stores the hypervisor doesn't handle"
> for Arm, use decodetree, not a hand-rolled decoder...)
> 

Noted. Yep, we have plans to add ARM64 support in the future.

Thanks,
Wei.

> thanks
> -- PMM

