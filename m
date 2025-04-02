Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1BDC3601E
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 20:01:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u04HT-00008q-88; Wed, 02 Apr 2025 16:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1u02cs-0004Ks-D6; Wed, 02 Apr 2025 14:15:46 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1u02cq-0003Pz-A9; Wed, 02 Apr 2025 14:15:46 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id F090D434E4;
 Wed,  2 Apr 2025 18:15:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8BFAC4CEDD;
 Wed,  2 Apr 2025 18:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743617731;
 bh=plB+3vOFjT5WCk4owIOmSgL2ZPFj0kfRhk3LH8hLZjc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=X6XK+qHhSIFFg0nn8XO4MdCP71cU83YSLtrGL9TSe6hO5y/YavESU7gZeNcD/keea
 zA1lMpTyBAJF6QivH9zIgQBpSgs7strOBIlzL8faqKmV1uQIeQnCyK3BBJKTjZoauC
 NNlKsKKYos8VeqwkYMnPo4+W+vO+EgTZlGa+f5MeIZRnb5SSFiCv/ySA2lZJI6bn8c
 HVHMAs+IyhQ/j2pOirSGSZ60eMRrcQ4/LKPltkKgmMbBPk3+F6lFpKVLK8I5Iy4Uej
 BLRRGgsuFhDpKf0X1SqwkytbRm2QVx0GTUGp/AEnQsk/Nqh4Z0nn98kD3n1lcYKmoQ
 wTUISQr2nzcfQ==
Date: Wed, 2 Apr 2025 20:15:28 +0200
From: Daniel Gomez <da.gomez@kernel.org>
To: Mads Ynddal <mads@ynddal.dk>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Cameron Esfahani <dirty@apple.com>, 
 Roman Bolshakov <rbolshakov@ddn.com>, Peter Maydell <peter.maydell@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <m.ynddal@samsung.com>, 
 Daniel Gomez <da.gomez@samsung.com>
Subject: Re: [PATCH 1/2] hvf: avoid repeatedly setting trap debug for each cpu
Message-ID: <enffkbdotdb4z2yggxxciyouprg64xcm4cybz72i4ryl5jqwzm@u2wnlphszxwv>
References: <20250402135229.28143-1-mads@ynddal.dk>
 <20250402135229.28143-2-mads@ynddal.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402135229.28143-2-mads@ynddal.dk>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=da.gomez@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 02 Apr 2025 16:01:39 -0400
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

On Wed, Apr 02, 2025 at 03:52:28PM +0100, Mads Ynddal wrote:
> From: Mads Ynddal <m.ynddal@samsung.com>
> 
> hvf_arch_set_traps is already called from a context of a specific
> CPUState, so we don't need to do a nested CPU_FOREACH.
> 
> It also results in an error from hv_vcpu_set_sys_reg, as it may only be
> called from the thread owning the vCPU.
> 

Reported-by: Daniel Gomez <da.gomez@samsung.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2895

> Tested-by: Daniel Gomez <da.gomez@samsung.com>
> Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
> ---
>  target/arm/hvf/hvf.c | 27 +++++++++++----------------
>  1 file changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 2439af63a0..48e4b12725 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -2277,28 +2277,23 @@ static inline bool hvf_arm_hw_debug_active(CPUState *cpu)
>      return ((cur_hw_wps > 0) || (cur_hw_bps > 0));
>  }
>  
> -static void hvf_arch_set_traps(void)
> +static void hvf_arch_set_traps(CPUState *cpu)
>  {
> -    CPUState *cpu;
>      bool should_enable_traps = false;
>      hv_return_t r = HV_SUCCESS;
>  
>      /* Check whether guest debugging is enabled for at least one vCPU; if it
>       * is, enable exiting the guest on all vCPUs */
> -    CPU_FOREACH(cpu) {
> -        should_enable_traps |= cpu->accel->guest_debug_enabled;
> -    }
> -    CPU_FOREACH(cpu) {
> -        /* Set whether debug exceptions exit the guest */
> -        r = hv_vcpu_set_trap_debug_exceptions(cpu->accel->fd,
> -                                              should_enable_traps);
> -        assert_hvf_ok(r);
> +    should_enable_traps |= cpu->accel->guest_debug_enabled;
> +    /* Set whether debug exceptions exit the guest */
> +    r = hv_vcpu_set_trap_debug_exceptions(cpu->accel->fd,
> +                                            should_enable_traps);
> +    assert_hvf_ok(r);
>  
> -        /* Set whether accesses to debug registers exit the guest */
> -        r = hv_vcpu_set_trap_debug_reg_accesses(cpu->accel->fd,
> -                                                should_enable_traps);
> -        assert_hvf_ok(r);
> -    }
> +    /* Set whether accesses to debug registers exit the guest */
> +    r = hv_vcpu_set_trap_debug_reg_accesses(cpu->accel->fd,
> +                                            should_enable_traps);
> +    assert_hvf_ok(r);
>  }
>  
>  void hvf_arch_update_guest_debug(CPUState *cpu)
> @@ -2339,7 +2334,7 @@ void hvf_arch_update_guest_debug(CPUState *cpu)
>              deposit64(env->cp15.mdscr_el1, MDSCR_EL1_MDE_SHIFT, 1, 0);
>      }
>  
> -    hvf_arch_set_traps();
> +    hvf_arch_set_traps(cpu);
>  }
>  
>  bool hvf_arch_supports_guest_debug(void)
> -- 
> 2.48.1
> 
> 

