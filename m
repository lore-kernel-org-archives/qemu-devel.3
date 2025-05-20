Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DD0C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 22:07:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHV76-00027P-As; Tue, 20 May 2025 18:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uHV74-00027E-PI
 for qemu-devel@nongnu.org; Tue, 20 May 2025 18:07:06 -0400
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uHV72-0001ES-VR
 for qemu-devel@nongnu.org; Tue, 20 May 2025 18:07:06 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id B198AA4EC01;
 Tue, 20 May 2025 22:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6EE9C4CEE9;
 Tue, 20 May 2025 22:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747778823;
 bh=FEmzV1jwXMWsJIFBI9D9FCNju+m6SFqPEe3SeHd3VDc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eS2DYeoIM2eYu9U+1JNNkRen1tQw9NQUqkysfzREfJLJRqNlCqjQG/qXr52nJ3QwU
 qYjKzP44ATE9Nl7rHDu3czw/E9xGi5ZuHnhFsXbPLI83dtV44tFQaOmq8TvKfMjpIi
 c5dEzhCcHNJAPB6kndCyCZiPPoxEd5lu358FUk9ggP8gCAQLoc3tK8zCm7qYjc/BoB
 c9CgQ2+9Cb5O6uG+0B1E2l2FFzea8YVmzbqvVKoJHx2tDvskcYP/mUSgyZ2bKzrxU0
 1vcoXtwi7Odr4+sKASVIZ+hHrbm5IUMs238PzJX9j9BdidBlb22Hp7zlX4A9CNN9Sn
 jlmpbksGRMKYw==
Date: Tue, 20 May 2025 22:07:01 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: magnuskulke@microsoft.com, qemu-devel@nongnu.org, liuwe@microsoft.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [RFC PATCH 15/25] target/i386/mshv: Implement mshv_store_regs()
Message-ID: <aCz9BXChINYOYAa3@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
 <20250520113018.49569-16-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520113018.49569-16-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=147.75.193.91; envelope-from=wei.liu@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Tue, May 20, 2025 at 01:30:08PM +0200, Magnus Kulke wrote:
> Add support for writing general-purpose registers to MSHV vCPUs
> during initialization or migration using the MSHV register interface. A
> generic set_register call is introduced to abstract the HV call over
> the various register types.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
[...]
>  int mshv_store_regs(CPUState *cpu)
>  {
> -	error_report("unimplemented");
> -	abort();
> +    int ret;
> +
> +    ret = set_standard_regs(cpu);
> +    if (ret < 0) {
> +        error_report("Failed to store standard registers");
> +        return -1;
> +    }
> +
> +    /* TODO: should store special registers? the equivalent hvf code doesn't */

(I'm just using x86 KVM's special registers as a reference)

We should not need to store them every time we refresh the CPU state,
unless we know some of them are dirtied by QEMU.

Thanks,
Wei.

> +
> +    return 0;
>  }
>  
> +
>  int mshv_load_regs(CPUState *cpu)
>  {
>  	error_report("unimplemented");
> -- 
> 2.34.1
> 

