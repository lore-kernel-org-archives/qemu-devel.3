Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960FDC48297
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 17:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZZxR-0001YZ-Vc; Mon, 12 Feb 2024 12:19:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maz@kernel.org>)
 id 1rZZxM-0001Xh-PZ; Mon, 12 Feb 2024 12:19:00 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maz@kernel.org>)
 id 1rZZxL-0005fq-3Z; Mon, 12 Feb 2024 12:19:00 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 99E5560F9F;
 Mon, 12 Feb 2024 17:18:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A57C433C7;
 Mon, 12 Feb 2024 17:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707758325;
 bh=V9l0zQ5i8oB0x7537ZCInnxfHXbuws1rjzVUecT7Nes=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=UtpUGtq44Iu7WFGUxVR8Sc5TqXKOQkN8AIlAj8WK8/I/fv1hVjEhNS+o+wR+nKJ+L
 V/WTDdnKocyPCN5Xuqlruukuf3gNZx/zIDIKBh0yxy5L+kl/9aaPO6PY7xVZuZ9Cv1
 Jns5lacvKD90sVTY6MppI0FEpyFvAe5hCf6nHVf5HSMqp0TUGEu47G3Q1DIaki4bKS
 7TpexyyLeGzUXNN88Fah25UKk2nD90VxYxsFBvUsHRh43R6lKxlXrGBejPK1OyDBE5
 qjkoG9FUFIaHE0nPUvCqqTjGrRB8YLxx/7I+GdaSu3TVtluOxEBO35JJO/Id/oWm52
 qCfp08vdojZYA==
Received: from disco-boy.misterjones.org ([217.182.43.188] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1rZZx5-002Uv5-5s;
 Mon, 12 Feb 2024 17:18:43 +0000
MIME-Version: 1.0
Date: Mon, 12 Feb 2024 17:18:41 +0000
From: Marc Zyngier <maz@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, miguel.luis@oracle.com,
 haibo.xu@linaro.org, richard.henderson@linaro.org,
 gkulkarni@amperecomputing.com
Subject: Re: [RFC v2 0/5] ARM Nested Virt Support
In-Reply-To: <CAFEAcA_SFtmCCFBPwWjJF3uygdpdqoZuYLaQQP186fyQ+dJEHA@mail.gmail.com>
References: <20240209160039.677865-1-eric.auger@redhat.com>
 <CAFEAcA_SFtmCCFBPwWjJF3uygdpdqoZuYLaQQP186fyQ+dJEHA@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <d9da1d0ab970be3471187224241f3cee@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 217.182.43.188
X-SA-Exim-Rcpt-To: peter.maydell@linaro.org, eric.auger@redhat.com,
 eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 miguel.luis@oracle.com, haibo.xu@linaro.org, richard.henderson@linaro.org,
 gkulkarni@amperecomputing.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Received-SPF: pass client-ip=139.178.84.217; envelope-from=maz@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -78
X-Spam_score: -7.9
X-Spam_bar: -------
X-Spam_report: (-7.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 2024-02-09 18:57, Peter Maydell wrote:
> On Fri, 9 Feb 2024 at 16:00, Eric Auger <eric.auger@redhat.com> wrote:
>> 
>> This series adds ARM Nested Virtualization support in KVM mode.
>> This is a respin of previous contributions from Miguel [1] and Haibo 
>> [2].
>> 
>> This was tested with Marc's v11 [3] on Ampere HW with fedora L1 guest 
>> and
>> L2 guests booted without EDK2. However it does not work yet with
>> EDK2 but it looks unrelated to this qemu integration (host hard 
>> lockups).
>> 
>> The host needs to be booted with "kvm-arm.mode=nested" option and
>> qemu needs to be invoked with :
>> 
>> -machine virt,virtualization=on
>> 
>> There is a known issue with hosts supporting SVE. Kernel does not 
>> support both
>> SVE and NV2 and the current qemu integration has an issue with the
>> scratch_host_vcpu startup because both are enabled if exposed by the 
>> kernel.
>> This is independent on whether sve is disabled on the command line. 
>> Unfortunately
>> I lost access to the HW that expose that issue so I couldn't fix it in 
>> this
>> version.
> 
> You can probably repro that by running the whole setup under
> QEMU's FEAT_NV emulation, which will be able to give you a CPU
> with both FEAT_NV and SVE.
> 
> Personally I think that this is a kernel missing-feature that
> should really be fixed as part of getting the kernel patches
> upstreamed. There's no cause to force every userspace VMM to
> develop extra complications for this.

I don't plan to make NV visible to userspace before this is fixed.
Which may delay KVM NV by another year or five, but I don't think
anyone is really waiting for it anyway.

         M.
-- 
Jazz is not dead. It just smells funny...

