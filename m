Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABACCCAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 13:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1PhD-0006zx-L7; Wed, 24 Sep 2025 09:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1v1PhB-0006zb-2M
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 09:38:09 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1v1Ph3-0004tV-Cj
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 09:38:08 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0264D60007;
 Wed, 24 Sep 2025 13:37:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FA5C4CEE7;
 Wed, 24 Sep 2025 13:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758721077;
 bh=E4ixhkY8HwW7iTS5Si12737ldgLwAXbST4HbN3m8JQ8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rlp71cpNyDWxFZcNHMebg7CHBETrkBT/z2q4nKtjHX0YD9Yo1DW7ERFJez3fkG1EQ
 hnBk4u6RYsLp65YY5FDei4pqUi8bBls5niTU+/ENorFrm3RJXZlEyv/xqiiUymlm8i
 qsU1xsFfnb+mtxl+WBawJY123Gad2gkrvB2tP3p/PBv2dhdouoY9Xcce4v2G3UmWt0
 sL4nLdLJY+0OvEnMDjEs6wRYrqxYbQFZCDUUlzUnkkVpUdZQyUH82ctW7IDlouhpPd
 zxaMgn2vFf1fBwVqN2rurNJ1zNuftf0AMvJsGsgkvWGOvTH8fFtRqp39+eFXNpb0Ra
 oH5RQzQZRP1hw==
Date: Wed, 24 Sep 2025 18:59:35 +0530
From: Naveen N Rao <naveen@kernel.org>
To: "Nikunj A. Dadhania" <nikunj@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, kvm@vger.kernel.org,
 "Daniel P. Berrange" <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>, 
 Michael Roth <michael.roth@amd.com>, Roy Hopkins <roy.hopkins@randomman.co.uk>
Subject: Re: [PATCH 8/8] target/i386: SEV: Add support for setting TSC
 frequency for Secure TSC
Message-ID: <swnray4zt34wzfyarg5np4ykfpxnwa6psaoghkis4wxxdi3ybx@mptfzf4633fs>
References: <cover.1758189463.git.naveen@kernel.org>
 <6a9b3e02d1a1eb903bd3e7c9596dfe00029de01e.1758189463.git.naveen@kernel.org>
 <412fce46-e143-4b71-b5ac-24f4f5ae230f@amd.com>
 <4f3f7b7d-f6bf-49de-8c3a-96876e298ad5@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f3f7b7d-f6bf-49de-8c3a-96876e298ad5@amd.com>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=naveen@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Sep 23, 2025 at 09:48:07AM +0530, Nikunj A. Dadhania wrote:
> 
> 
> On 9/20/2025 3:36 AM, Tom Lendacky wrote:
> > On 9/18/25 05:27, Naveen N Rao (AMD) wrote:

<snip>

> > 
> > And does KVM_SET_TSC_KHZ have to be called if "tsc-frequency" wasn't set?
> No, this is not required. This patch has changed a bit from my original version, we should have something like below: 
> 
> if (is_sev_feature_set(sev_common, SVM_SEV_FEAT_SECURE_TSC) && sev_snp_guest->stsc_khz) {
> ...
> }

Right, I suppose I relied on KVM using the default TSC frequency if the 
VMM does KVM_SET_TSC_KHZ with a TSC frequency of zero, which is totally 
unnecessary. I will update this.


Thanks,
Naveen


