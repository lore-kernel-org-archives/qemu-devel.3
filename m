Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD48C79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4aY3-0001xu-Ao; Thu, 10 Sep 2026 04:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1x4aY1-0001xm-Ey
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:54:21 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1x4aXx-0000ad-50
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:54:20 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1D2AA43454;
 Thu, 10 Sep 2026 08:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7D41F000FF;
 Thu, 10 Sep 2026 08:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789030455;
 bh=XcLXzHuP411xf0obHodUgjT2snTLb/DaktuvJcZr6QA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=FIqcTUvkqma4ko3Oa4jqTzFPykVgPPWTdWRC53b6EBQtvN6ocpbBbF566YrywaLMh
 7JhQ+KPXS4VtR7G5C0261G4OIAhFuinYjN1gLgowLIA0eR9FZgM++LbEDIME8RnHrD
 aDEGyGwcxBVCg4S+GXn+8ANmQRZj9zTJvSM49RpC3QzJXru+CrLYNssW6d+YdgQnZM
 Ozf77Pa6J4sXoncHL6N6j6FznwDE1b8ZngNti3lbJGKoqHWQdATFVg3SfFdGhppZvp
 HKIsj+NpziYLQcea4vi/j9VtUyQsKFP71aNW/TfI6mhxVLAztdMfmIs95fw76X/gqc
 TaCSZ9BFw4Y+w==
Message-ID: <eee90083-3962-4bf4-a7be-2e06e02e4e94@kernel.org>
Date: Thu, 10 Sep 2026 10:54:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/12] hostmem: Support fully shared guest memfd to
 back a VM
To: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 pankaj.gupta@amd.com, isaku.yamahata@intel.com, xiaoyao.li@intel.com,
 chao.p.peng@linux.intel.com, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20260908133151.836685-1-michael.roth@amd.com>
 <20260908133151.836685-9-michael.roth@amd.com>
From: David Hildenbrand <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20260908133151.836685-9-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=david@kernel.org;
 helo=sea.source.kernel.org
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
> From: Peter Xu <peterx@redhat.com>
> 
> Host backends supports guest-memfd now by detecting whether it's a
> confidential VM.  There's no way to choose it yet from the memory level to
> use it fully shared.  If we use guest-memfd, it so far always implies we
> need two layers of memory backends, while the guest-memfd only provides the
> private set of pages.
> 
> This patch introduces a way so that QEMU can consume guest memfd as the
> only source of memory to back the object (aka, fully shared).
> 
> To use the fully shared guest-memfd, one can add a memfd object with:
> 
>   -object memory-backend-memfd,guest-memfd=on,share=on
> 
> Note that share=on is required with fully shared guest_memfd.
> 
> PS: there's a trivial touch-up on fd<0 check, because the stub to create
> guest-memfd may return negative but not -1.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---

[...]

>  static bool
> @@ -47,11 +56,31 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>          goto have_fd;
>      }
>  
> -    fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
> -                           m->hugetlb, m->hugetlbsize, m->seal ?
> -                           F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL : 0,
> -                           errp);
> -    if (fd == -1) {
> +    if (m->guest_memfd) {
> +        /*
> +         * NOTE: guest-memfd ignores seal=on/off because it always
> +         * implicitly seals the FD by definition.
> +         */
> +        if (!backend->share) {
> +            error_setg(errp, "guest-memfd=on must be used with share=on");
> +            return false;
> +        } else if (m->hugetlb) {
> +            error_setg(errp, "guest-memfd=on doesn't support hugetlb=on yet");

There is a lot of uncertainty how guest_memfd would consume huge pages. So best
to drop the "yet" that implies how it would be consumed (and that it would be
called "hugetlb").


Apart from that LGTM

Reviewed-by: David Hildenbrand <david@kernel.org>
-- 
Cheers,

David


