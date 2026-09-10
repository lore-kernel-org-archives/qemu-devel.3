Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F40C79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4aKG-0006El-1P; Thu, 10 Sep 2026 04:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1x4aKD-0006DX-FF
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:40:05 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1x4aKB-0006gm-Pv
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:40:05 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 81769432E3;
 Thu, 10 Sep 2026 08:39:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF94F1F000FF;
 Thu, 10 Sep 2026 08:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789029594;
 bh=8ZzvbcSxNRDsf3l7+pjIOoJyVM0AyIUAO0RULKJ/ouc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=NFBGJ04I6z2tEmHNTB/l/FJRV3+pb3bM/kzsdFT0I700dyu8Nd9gd37cmsZp5nm4x
 HX4VJzJmbXe107/lmeNDWw6Hp9KrY1dMrKRuRSQnNviFrCQek10GNVS0UzznIRy283
 tJPR1c5yyazek5DU6S8bOGS6kfUI0P1lOLy1SJ2YfJtmiCT6RT4YI44Ymn7Mt2DkFw
 JtbhjK4f75+rPH0jOe1nXxpdTiHm10AAzV8IqH0+W6ysvFbYwcmUcl96CFIfnMt4P/
 j37CS+8MixCsCgCiWDjozc+aQaASp2/0C7iGMGffyegibx5fYqFmyLTjfraVDPBKc+
 gmzelTWBTpL1g==
Message-ID: <391885b2-6464-4656-9cda-8d05891849a8@kernel.org>
Date: Thu, 10 Sep 2026 10:39:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/19] system/memory: Re-use memory-backend-guest-memfd
 inode for private memory
To: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, berrange@redhat.com,
 armbru@redhat.com, pankaj.gupta@amd.com, isaku.yamahata@intel.com,
 xiaoyao.li@intel.com, chao.p.peng@linux.intel.com, ashish.kalra@amd.com,
 ackerleytng@google.com, lpieralisi@kernel.org
References: <20260908205236.838281-1-michael.roth@amd.com>
 <20260908205236.838281-9-michael.roth@amd.com>
From: David Hildenbrand <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20260908205236.838281-9-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=david@kernel.org; helo=sea.source.kernel.org
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

On 9/8/26 22:48, Michael Roth wrote:
> When convert-in-place=true, the guest_memfd instance created by
> memory-backend-memfd (when guest-memfd=on option is specified) should
> also be used internally for private memory.
> 
> Do this by dup()'ing the guest_memfd FD provided by the backend so the
> separate cleanup paths for shared vs. private FDs can be managed in the
> same way they are currently for convert-in-place=false (where shared
> memory must come from something other than guest_memfd).
> 
> Introduce a new RAM_GUEST_MEMFD_SHARED flag that can be used to
> limit this dup()'ing to specific backend types like
> memory-backend-memfd.
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>  backends/hostmem-memfd.c |  1 +
>  include/system/memory.h  |  3 +++
>  system/physmem.c         | 48 +++++++++++++++++++++++++++++++++++++---
>  3 files changed, 49 insertions(+), 3 deletions(-)
> 
> diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> index 6576331441..a9759e682b 100644
> --- a/backends/hostmem-memfd.c
> +++ b/backends/hostmem-memfd.c
> @@ -89,6 +89,7 @@ have_fd:
>      backend->aligned = true;
>      ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
>      ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
> +    ram_flags |= RAM_GUEST_MEMFD_SHARED;
>      ram_flags |= backend->guest_memfd_private ? RAM_GUEST_MEMFD_PRIVATE : 0;
>      return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend), name,
>                                            backend->size, ram_flags, fd, 0, errp);
> diff --git a/include/system/memory.h b/include/system/memory.h
> index 027ca81bd2..81616bfe39 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -274,6 +274,9 @@ typedef struct IOMMUTLBEvent {
>   */
>  #define RAM_PRIVATE (1 << 13)
>  
> +/* RAM can be shared that has kvm guest memfd backend */
> +#define RAM_GUEST_MEMFD_SHARED   (1 << 14)

Trying to understand the semantics, should that be SHAREABLE ?

-- 
Cheers,

David


