Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB25C79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4aRJ-0007u6-3J; Thu, 10 Sep 2026 04:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1x4aRF-0007tp-UM
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:47:21 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1x4aRD-0007wB-Kg
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:47:21 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4DFF1600CB;
 Thu, 10 Sep 2026 08:47:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BDBF1F000FF;
 Thu, 10 Sep 2026 08:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789030038;
 bh=VdMLI8lFmokDlBLMnKec8hrsDimd/MSqXdeUeN1HIX0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=UMlQmNArIq1/3sUX7AF6uB9pc/WyFPIJ39lNGnnwc45lldZQEqWWNFVlnTBkdNCbU
 EZDHCQ2YEpNjS9CSCgPcaI3GKkXQLMWA6e7xxYBLjDU9x54Ec9UkIqmvq7qOFdM7L6
 8HI87FVPPGDvG+1NbYv/+QjnA1rGRXallZsbaEciqxpuNpiLsA9CfncNAyIS4MU2Ez
 KCccE39rGKFue4/QYKsFPLikJgbRx7Bka6qB7M8l+V4OPWc9RvGQDyZDDIQcU4jFZl
 KimIZMoy1K1dfFJrFmrtBFWVJDxyDDP2sOZXUe3VmBxpJtqgFrEnzPMeBiqvgNaOmA
 7274oqEzWz+0g==
Message-ID: <6ae82b3f-e4a8-49a6-bce0-5eaf6d05602f@kernel.org>
Date: Thu, 10 Sep 2026 10:47:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/12] kvm: Decouple memory attribute check from
 kvm_guest_memfd_supported
To: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 pankaj.gupta@amd.com, isaku.yamahata@intel.com, xiaoyao.li@intel.com,
 chao.p.peng@linux.intel.com, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20260908133151.836685-1-michael.roth@amd.com>
 <20260908133151.836685-2-michael.roth@amd.com>
From: David Hildenbrand <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20260908133151.836685-2-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=david@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/8/26 15:30, Michael Roth wrote:
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> 
> With the mmap support of guest memfd, KVM allows userspace to create
> guest memfd serving as normal non-private memory for X86 DEFAULT VM.
> However, KVM doesn't support private memory attribute for X86 DEFAULT
> VM.
> 
> Make kvm_guest_memfd_supported not rely on KVM_MEMORY_ATTRIBUTE_PRIVATE
> and check KVM_MEMORY_ATTRIBUTE_PRIVATE separately when the machine
> requires guest_memfd to serve as private memory.
> 
> This allows QEMU to create guest memfd with mmap to serve as the memory
> backend for X86 DEFAULT VM.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
Reviewed-by: David Hildenbrand <david@kernel.org>

-- 
Cheers,

David


