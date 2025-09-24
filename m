Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1660CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 13:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1PXm-0001tE-Id; Wed, 24 Sep 2025 09:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1v1PXf-0001sV-OC
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 09:28:20 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1v1PXc-0003Bv-T9
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 09:28:19 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B220360097;
 Wed, 24 Sep 2025 13:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E320CC4CEE7;
 Wed, 24 Sep 2025 13:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758720477;
 bh=LkJeLqstneWF3zjIGHB5Imu+sWVXbsZul/NeRhwn7g8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RjWR1tWsnUZgvTWg9+jtByQYaQ922o5mWRroIPs1rpGaxZJWv/9KSHP6ViI4Spa28
 BCy3cFqdKvoZv/yJrkGeXl59kCsXvrESS3iyBCXkCagXjAE7BZtErUzhbRfXN0Jvoo
 kc7yqDTkCF1ImiCJtvvRwKturn3b6UhAm5UIxjg3rdN57bJ9Q+YGxUWQsRCXXYNUKI
 fxaRHviFKsFCPsKJXp5Pn1qCjOTx62Tz7kzJnChtObBBSq310zKBiCFdEAYJjf37Dw
 j76KU9B6/0bw0zU/zayC2AColABCte5zlTtC6hg9OcNc1cNi8ZGHiERVkfixwsy71w
 51EffP0VdfszA==
Date: Wed, 24 Sep 2025 18:52:37 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, kvm@vger.kernel.org,
 Nikunj A Dadhania <nikunj@amd.com>, 
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Zhao Liu <zhao1.liu@intel.com>, Michael Roth <michael.roth@amd.com>, 
 Roy Hopkins <roy.hopkins@randomman.co.uk>
Subject: Re: [PATCH 6/8] target/i386: SEV: Enable use of KVM_SEV_INIT2 for
 SEV-ES guests
Message-ID: <h5b6iurfiluiraavdi7ujcawh67f3qpsyh2qxnlmehamawzma3@p5zqx722khe7>
References: <cover.1758189463.git.naveen@kernel.org>
 <4d14083f34e3196a1ef179a958e30e800b5263fe.1758189463.git.naveen@kernel.org>
 <f97f66c5-d6f8-4a6e-91f1-4d3dac3c0816@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f97f66c5-d6f8-4a6e-91f1-4d3dac3c0816@amd.com>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=naveen@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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

On Fri, Sep 19, 2025 at 04:44:34PM -0500, Tom Lendacky wrote:
> On 9/18/25 05:27, Naveen N Rao (AMD) wrote:
> > Now that users can enable VMSA SEV features, update sev_init2_required()
> > to return true if any SEV features are requested. This enables qemu to
> > use KVM_SEV_INIT2 for SEV-ES guests when necessary.
> > 
> > Sample command-line:
> >   -machine q35,confidential-guest-support=sev0 \
> >   -object sev-guest,id=sev0,policy=0x5,cbitpos=51,reduced-phys-bits=1,debug-swap=on
> > 
> 
> Should this patch go before patch #5 from a bisect point of view? Because
> won't patch #5 fail because you still aren't using init2?

I put this patch after the base debug-swap support since it is not 
possible to exercize this code otherwise. But, as you rightly point out, 
this just means that patch 5/8 is buggy and that is not good from a 
bisect standpoint. I will move this before patch 5/8.

> 
> > Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
> > Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
> 
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

Thanks for the review,
- Naveen


