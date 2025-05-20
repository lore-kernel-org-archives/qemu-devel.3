Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5001FC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 20:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHTNa-0007Oe-8M; Tue, 20 May 2025 16:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uHTN6-0007Hr-SY
 for qemu-devel@nongnu.org; Tue, 20 May 2025 16:15:38 -0400
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uHTMx-0001sb-H1
 for qemu-devel@nongnu.org; Tue, 20 May 2025 16:15:28 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 1D0F4A492C0;
 Tue, 20 May 2025 20:15:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7736EC4CEE9;
 Tue, 20 May 2025 20:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747772121;
 bh=yfQbyBfXKVVikj7uQZY0nZaf1rOGK8Kq2ccYmB4+xfM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hbQeGlItJiOyCYZeAp7+DMF+GKLA+eCnIBl1NGxZcirrCZtY8EVjju5/jqI8xlwvl
 LcMSr9NUFyZdHk5zSJh7tv7NRsYLjxzWyzfrxtfALhR41FU2gXpHYvaltTS2NuBHhf
 HGlALVIgaEtSVtTtNMLY61zv54g+uOTWdnxuiOfV7pwsPVFEgr9HgiY8mlGrVT3vVJ
 lT1gm3P4wbNK6MBCmTVVeRXTGDb9780mtyl8GxhON5K2DW01Dp4ezFILbwNeek45gR
 pUbNoEP6LYhWKbAuiM7HYHVjg7suTDfIwlPFRrn2EfIUh40ZxfuxMBgxGyC2P2B6Ip
 cJDq9AoVwBSnA==
Date: Tue, 20 May 2025 20:15:20 +0000
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
Subject: Re: [RFC PATCH 11/25] accel/mshv: Add basic interrupt injection
 support
Message-ID: <aCzi2OQRB_YiW7rm@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
 <20250520113018.49569-12-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520113018.49569-12-magnuskulke@linux.microsoft.com>
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

On Tue, May 20, 2025 at 01:30:04PM +0200, Magnus Kulke wrote:
> Implement initial interrupt handling logic in the MSHV backend. This
> includes management of MSI and un/registering of irqfd mechanisms.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
[...]
> +int mshv_request_interrupt(int vm_fd, uint32_t interrupt_type, uint32_t vector,
> +                           uint32_t vp_index, bool logical_dest_mode,
> +                           bool level_triggered)
> +{
> +    int ret;
> +
> +    if (vector == 0) {
> +        /* TODO: why do we receive this? */

You must have seen this in real life, right? We need to convince
ourselves why this is okay.

Thanks,
Wei.

> +        return 0;
> +    }
> +
> +    union hv_interrupt_control control = {
> +        .interrupt_type = interrupt_type,
> +        .level_triggered = level_triggered,
> +        .logical_dest_mode = logical_dest_mode,
> +        .rsvd = 0,
> +    };
> +
> +    struct hv_input_assert_virtual_interrupt arg = {0};
> +    arg.control = control;
> +    arg.dest_addr = (uint64_t)vp_index;
> +    arg.vector = vector;
> +
> +    struct mshv_root_hvcall args = {0};
> +    args.code   = HVCALL_ASSERT_VIRTUAL_INTERRUPT;
> +    args.in_sz  = sizeof(arg);
> +    args.in_ptr = (uint64_t)&arg;
> +
> +    ret = mshv_hvcall(vm_fd, &args);
> +    if (ret < 0) {
> +        error_report("Failed to request interrupt");
> +        return -errno;
> +    }
> +    return 0;
> +}
> +

