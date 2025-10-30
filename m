Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE75CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 06:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEMGA-0007jv-1N; Thu, 30 Oct 2025 02:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vEMG5-0007jc-BY; Thu, 30 Oct 2025 02:35:41 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vEMFu-0006YA-Oq; Thu, 30 Oct 2025 02:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761806131; x=1793342131;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=ka05c/JWyGKqJhdpSvFE7i66F+dJEiVQVgesEq2fPRw=;
 b=SVZnutjJq9vpmblhmAncYGCjMZqgJNnuarB9kwuWKTAs/9x2LwldexwM
 CIbCxVxf/kw5Idj6yGUkw8z5kFDyBWu+T7zrQdDsW655r9+YVCOmGrxAd
 0BJ3FNjp6DfsxqS9mg5UX7d1Mo7rjcNC4LPQ+ksssjPoTutl1XHFgmJKG
 HFA4i3cpdsZXDI50UeDFx3yojQy9dB0YVvsfqMC14Eg9EZ3DJxwSkk/pA
 53mAeC6etDtYDsNNZTh11KYf54iQPISelCmYdiEWocRZaVYLMitWvM69B
 r0gvPu2wNYDOmrecLY4COUkJCwOwXVBWaguqQCUO2vei43LUzEokb5toq g==;
X-CSE-ConnectionGUID: dFHl5RLETeKdoX/lIjCPjw==
X-CSE-MsgGUID: ZcDsHQJRQl2B/n7G43L19Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="89406049"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; d="scan'208";a="89406049"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 23:35:21 -0700
X-CSE-ConnectionGUID: S0xk/W7mSg23oG33ojSvrQ==
X-CSE-MsgGUID: p32bsYGiRjmlFDPjgYwb+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; d="scan'208";a="223092625"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 29 Oct 2025 23:35:18 -0700
Date: Thu, 30 Oct 2025 14:57:29 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 03/25] hw/timer/hpet: Use proper SysBus accessors
Message-ID: <aQMMWTLPSVdCBA2r@intel.com>
References: <20251028181300.41475-1-philmd@linaro.org>
 <20251028181300.41475-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251028181300.41475-4-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Tue, Oct 28, 2025 at 07:12:37PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Tue, 28 Oct 2025 19:12:37 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v3 03/25] hw/timer/hpet: Use proper SysBus accessors
> X-Mailer: git-send-email 2.51.0
> 
> SysBusDevice::mmio[] is private data of SysBusDevice, use
> sysbus_mmio_get_region() to access it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/timer/hpet.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
> index 1acba4fa9db..c1b96d0a89f 100644
> --- a/hw/timer/hpet.c
> +++ b/hw/timer/hpet.c
> @@ -654,7 +654,7 @@ static const MemoryRegionOps hpet_ram_ops = {
>  static void hpet_reset(DeviceState *d)
>  {
>      HPETState *s = HPET(d);
> -    SysBusDevice *sbd = SYS_BUS_DEVICE(d);
> +    MemoryRegion *mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(d), 0);
>      int i;
>  
>      for (i = 0; i < s->num_timers; i++) {
> @@ -677,7 +677,7 @@ static void hpet_reset(DeviceState *d)
>      s->hpet_offset = 0ULL;
>      s->config = 0ULL;
>      hpet_fw_cfg.hpet[s->hpet_id].event_timer_block_id = (uint32_t)s->capability;
> -    hpet_fw_cfg.hpet[s->hpet_id].address = sbd->mmio[0].addr;
> +    hpet_fw_cfg.hpet[s->hpet_id].address = mr->addr;
  
Rust's sysbus has a method "mmio_addr". Maybe Rust side should also
split it into two methods similar to `sysbus_mmio_get_region` and
`memory_region_get_address`, to align with the C interfaces.

For this patch,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

>      /* to document that the RTC lowers its output on reset as well */
>      s->rtc_irq_level = 0;
> -- 
> 2.51.0
> 
> 

