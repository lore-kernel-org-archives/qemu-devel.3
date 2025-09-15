Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E494DCAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 14:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyAAH-0004EE-FW; Mon, 15 Sep 2025 10:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1uyAAE-0004Cr-Bt
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 10:26:42 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1uyA9z-0000MK-8W
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 10:26:41 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1342543A90;
 Mon, 15 Sep 2025 14:26:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A429C4CEF1;
 Mon, 15 Sep 2025 14:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1757946377;
 bh=a0FP0D99H9vBGZzMmTJ9lETyLW7JGGn8jb+atITB0Ao=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Q3j+uDnp4Z76D+OQNW00cAYSqZFdvsEeYFohEe8Tq7tD/viod9aCe3s72dUa+knuY
 R7nujGSSfy1MCapi7aDbg+MJ0xe2bNY7yI/2ylsqQPzL5MBpSaZxVDkIb7T/Q7bRGF
 vAOLrdabh+LzARzAmAFIIPAli7WH7u7qnu4F+Jw2tyFJHxf2e7BHPvRL0sj6UAQ0SI
 0M0hfDxAtyCvfzCDyfwq4hu7ZAly2uW/yn11M39x7932CwM1KPkrXl32B/a+P+ZzUb
 ufqrYRdI9iYB8fzK3jKMVOHwjGyR+mnTRemxh8ubHQH++CmBeW8dxrh0al/jgnx8xK
 OAJgW9zTNsGrg==
Date: Mon, 15 Sep 2025 19:55:47 +0530
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
Subject: Re: [RFC PATCH 3/7] target/i386: SEV: Add support for enabling
 debug-swap SEV feature
Message-ID: <abrl6m327yzcjhkk6wircecgq6ryven6uakifzwzbndgcpnxcg@n3tk7cevpmpc>
References: <cover.1757589490.git.naveen@kernel.org>
 <0a77cf472bc36fee7c1be78fc7d6d514d22bca9a.1757589490.git.naveen@kernel.org>
 <98064a4a-41d7-4071-893e-4cced0afb66a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98064a4a-41d7-4071-893e-4cced0afb66a@amd.com>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=naveen@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Sep 12, 2025 at 08:50:28AM -0500, Tom Lendacky wrote:
> On 9/11/25 06:54, Naveen N Rao (AMD) wrote:
> > Add support for enabling debug-swap VMSA SEV feature in SEV-ES and
> > SEV-SNP guests through a new "debug-swap" boolean property on SEV guest
> > objects. Though the boolean property is available for plain SEV guests,
> > check_sev_features() will reject setting this for plain SEV guests.
> > 
> > Add helpers for setting and querying the VMSA SEV features so that they
> > can be re-used for subsequent VMSA SEV features, and convert the
> > existing SVM_SEV_FEAT_SNP_ACTIVE definition to use the BIT() macro for
> > consistency with the new feature flag.
> > 
> > Sample command-line:
> >   -machine q35,confidential-guest-support=sev0 \
> >   -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1,debug-swap=on
> > 
> > Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
> 
> Should you convert the setting/checking of SVM_SEV_FEAT_SNP_ACTIVE in the
> first patch (and wherever else it might be used), too?
> 
> If you do, then it would split this into two patches, one that adds the
> helpers and converts existing accesses to sev_features and then the new
> debug_swap parameter.

Sure, I'll do that.

Thanks,
Naveen


