Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1495A606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 22:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d+c+c4LQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xX4nI-0004Ny-Tu; Fri, 27 Nov 2026 17:51:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1xX4nF-0004Ni-RS
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 17:51:49 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1xX4nE-0007jP-D9
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 17:51:49 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3BC4A6124F;
 Fri, 27 Nov 2026 22:51:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6297A1F00897;
 Fri, 27 Nov 2026 22:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795819904;
 bh=DSQA+xeiJb+yxQDqn9LrCWe41N//kRX5g+abijPx+JA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=d+c+c4LQYoeMGwtDwDYo7zmMglaeEjlULdtPOHQwbwoDYb9W2vk0y8Twx+RWlbtQj
 kAy+kUlutViFLDYMVZd3yXGOAKCLCJWCnfo+rAcbkb377BAZOF9jhodZ60QDiloayU
 2XxYFZnvGoowjlWcMqtIfuKnytk862JcCeodT9eI3GJc5Y48opyA+6eLae3jiabXn7
 xboAQJBZd0183gVLxhFxd9pZB+P5nFxErKC2v8WCIztae7JF60xY7iOPHeKygFcLlo
 VvPE8H+gmUYrF+PAnuUNpCh6iMPyEdNGIWfqcaoaxdmhItZlJAhBO6BMoC4mScLoBk
 64s3D2FPavBKQ==
Date: Fri, 27 Nov 2026 14:51:43 -0800
From: Wei Liu <wei.liu@kernel.org>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <doru.blanzeanu@microsoft.com>,
 Wei Liu <liuwe@microsoft.com>
Subject: Re: [PATCH] target/i386/mshv: set hypercall MSR runtime-unsafe
Message-ID: <20261127225143.GB5355@liuwe-devbox-debian-v2.local>
References: <20261125143211.51151-1-magnuskulke@linux.microsoft.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125143211.51151-1-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=wei.liu@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 03:32:11PM +0100, Magnus Kulke wrote:
> Windows locks HV_X64_REGISTER_HYPERCALL after configuring it, so writing
> back even the same value will fail. Hence we mark it as not runtime safe,
> so e.g. an "info registers" command will not fail to writeback the MSRs.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>

Reviewed-by: Wei Liu <wei.liu@kernel.org>

> ---
>  target/i386/mshv/msr.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/target/i386/mshv/msr.c b/target/i386/mshv/msr.c
> index a06844cc99..5696b7eb83 100644
> --- a/target/i386/mshv/msr.c
> +++ b/target/i386/mshv/msr.c
> @@ -332,6 +332,8 @@ static bool msr_is_runtime_safe(uint32_t name)
>       * while the guest's timer is not frozen.
>       */
>      case HV_X64_REGISTER_TSC:
> +    /* Once locked, the hypercall MSR rejects writes even w/ the same value */
> +    case HV_X64_REGISTER_HYPERCALL:
>          return false;
>      default:
>          return true;
> -- 
> 2.34.1
> 

