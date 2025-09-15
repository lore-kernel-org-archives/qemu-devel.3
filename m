Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF2ACAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 14:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyAAF-0004D3-3N; Mon, 15 Sep 2025 10:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1uyAAB-00046a-GU
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 10:26:40 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1uyA9w-0000Io-0j
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 10:26:39 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8C6204332C;
 Mon, 15 Sep 2025 14:26:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC1EC4CEF9;
 Mon, 15 Sep 2025 14:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1757946364;
 bh=24dqys0fGPAuHsnHo+RJdsFLUXemxSGL8lu7wQtIaI4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=B7blHXjdIACd7YFT1d9V8xTcigIY6QrcPoZCzUaLmMJycVz0e9yklmad6qvaX8xQw
 0xPm4kDZXgUGbypK4/PcOZEcEIwqzH9cPIrUUYtTvqws/KRBkwj6ygts2p7+tAVScj
 cxrLOC+VZN6FL3W4gW4Aa3mlkrGxQJR+xLREAQWsYfbEm3VotZqHfI1E228OzkdhaW
 2xSQO6VtP9k/TdyDWzD8sPebnxaQLpRsFAdL6aDZlevnoIjDLen7TzbFIKMiwKDnyA
 dtNpQ3cmLq8QsU3qWiywNQgfliymDVdqLlHlzayR/cR5N0ASsbEcZLJHG3O96FYLbF
 SGSqpS3RMc/MQ==
Date: Mon, 15 Sep 2025 19:49:48 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Sean Christopherson <seanjc@google.com>, qemu-devel <qemu-devel@nongnu.org>,
 kvm@vger.kernel.org, "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Nikunj A Dadhania <nikunj@amd.com>, Michael Roth <michael.roth@amd.com>, 
 Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
 Roy Hopkins <roy.hopkins@randomman.co.uk>
Subject: Re: [RFC PATCH 1/7] target/i386: SEV: Consolidate SEV feature
 validation to common init path
Message-ID: <p4ynaokjw42oafnmsmbmkxm52fo2mstf5padafddnqie4jnggv@wrntlc3sev7d>
References: <cover.1757589490.git.naveen@kernel.org>
 <bd64baf06e483cf8df0f7b0f98cf5ad3dd5bff80.1757589490.git.naveen@kernel.org>
 <dd3672b6-5ee4-470f-9b61-f7ddef8bec72@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd3672b6-5ee4-470f-9b61-f7ddef8bec72@amd.com>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=naveen@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Tom,

On Fri, Sep 12, 2025 at 08:39:09AM -0500, Tom Lendacky wrote:
> On 9/11/25 06:54, Naveen N Rao (AMD) wrote:
> > Currently, check_sev_features() is called in multiple places when
> > processing IGVM files: both when processing the initial VMSA SEV
> > features from IGVM, as well as when validating the full contents of the
> > VMSA. Move this to a single point in sev_common_kvm_init() to simplify
> > the flow, as well as to re-use this function when VMSA SEV features are
> > being set without using IGVM files.
> > 
> > Since check_sev_features() relies on SVM_SEV_FEAT_SNP_ACTIVE being set
> > in VMSA SEV features depending on the guest type, set this flag by
> > default when creating SEV-SNP guests. When using IGVM files, this field
> > is anyway over-written so that validation in check_sev_features() is
> > still relevant.
> 
> There seem to be multiple things going on in this patch and I wonder if it
> would be best to split it up into separate smaller patches.
> 
> You have setting of SVM_SEV_FEAT_SNP_ACTIVE in sev_features, you have a
> new check for sev_features being set when using an IGVM file and you have
> the consolidation.

Sure, I started with the premise of unifying the call to 
check_sev_features() which necessitated the other changes. I will move 
those as pre-req patches.

Thanks for the review,
- Naveen


