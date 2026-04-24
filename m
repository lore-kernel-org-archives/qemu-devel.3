Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A69A7FED3C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 13:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGH3A-0006RE-Bf; Fri, 24 Apr 2026 09:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGH39-0006QU-Dc
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 09:58:31 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGH37-0004Ex-Qa
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 09:58:31 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-483487335c2so77068945e9.2
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 06:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777039108; x=1777643908; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jeXr2YAxxcksPi4zIMDOPQzcc4Jtkevn9hjVtpztcmU=;
 b=bkB/INg/sZ2sOM++VianZA4NxmzLE1lsN7T32va5Bk3AcxdTbhHYUA7U0+t2NdSWLn
 wLD1uupiqBygec89OqOXUiH1+nQoP6Xr8m5G14C5LiIBTQqp7JJwIeTIBvzra4AIptL7
 MwQTeVIgTHxy4Q4aOyNFIpItkW0UAyEyP0RBKH5o8cNz7ZPluYw6SxOGt2/R8sjChi1v
 L9OW0WxB0bvWkDTJxV9AmOr6VrsE0G9NhuNx3k6/6QdITNudnNtN5lAzRn5ZwnmtORvV
 f9LW47e2UgS8df1P9GsKh6Zz85d9SwozXRjLGvgC55m/DFktroJXydpfDUfaY64gBpHc
 ZIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777039108; x=1777643908;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jeXr2YAxxcksPi4zIMDOPQzcc4Jtkevn9hjVtpztcmU=;
 b=mnlA4x4yAyO3Gh30ik/KHWt2+6R5c6XObzznNZTTmBEgAgWTAFXHqYjPbNKk6kLqdk
 w0TUbsqcWub0a5cvk/f/7Tt/oEQNCFP/v1NoOa7rV/+k3qwvCAcEp7DDD3iCZRcwbGgH
 eKac+mThzRDUpS6BArf00r1434noLZkuUR1+BaAJuYdIO6c53MDOpsDsV7ePmZsTd66K
 XiZTNoAMMXXHpvI3IytWhpZstzQABodcwY76BrFIhp8OtLTHH+0CYrJfR+FXPWVockVp
 aLuU3eBniysHXSOgthDJQXllIcw6Q/5YWw9B9rTBg8chMUBEJJw32pk56z4VJyTg1Le9
 /wRw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Tg/5cFnKCskx9Q5Nf5apT8/5l32KmnyfeT2roR7s1M4EVQij87+kM1kFMC7VBrEPRC+XTBgE18CSz@nongnu.org
X-Gm-Message-State: AOJu0YwXb+5FxhiXAprk0QclUILSwwAoPMX2dyiGpelaivZbS4CAAshI
 dICMC0eEi2vCFbztlHcR4+bkYebJAy0RCrj2G1knAG5Iu4UfS4DOU91XMcU6mowoWOQ=
X-Gm-Gg: AeBDieuC7czh0Fh46RftV/H0kC4sA+FEoovnU3y4lBo7FgvIyKCRhclYfNbBbCTzn41
 uUlg+dq3JqB3VyC1VTEHyd6IoQn8BzNwZVKJTd1GnrOgTPY8ia4pEtqKNmCcRGpkxoNK4k03MLs
 9ul3kfylHsXriw5eou4L/bUmabsSrfH3UdaUzBSUqR1IX3VDQipvzv4x7dxohrh9bF6gbyg0rFq
 IlDLc3KaX7yUjSJBw89FYbawS9D5zvaY+FXgUfzlmDxJPj+U4fajcLja0OuInzVy5lJQTKPEfOY
 O+430Pvk6x3SxNpjutwyoJIQrQ2T90gCn3tPFUiJJVtQ9VSV4XdlgVGfdbV+PEuAYWOaBKrq08/
 ZPDqGpwvW2K9aJ9j/adLuNhOYr7Y6XQpbhNvlY7EHv0sDwI//ucI/VB0M/ZoOTAh+L8UJw8M7B+
 R9LmgRPs+/T7+gyWjFIFsPcyRckuup93TdGbOIBPiRX+PjfOFs+ZKIwLo2Fqwev0LWSXYaoSIHk
 73N6lRhrFINJ80=
X-Received: by 2002:a05:600c:8b8c:b0:489:1d74:56d with SMTP id
 5b1f17b1804b1-4891d7406famr341492525e9.29.1777039107885; 
 Fri, 24 Apr 2026 06:58:27 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a66533ff4sm16606895e9.6.2026.04.24.06.58.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 06:58:27 -0700 (PDT)
Message-ID: <e7022bd7-7fcc-4ba5-99be-35a032c41c52@linaro.org>
Date: Fri, 24 Apr 2026 15:58:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] intel_iommu: widen impl.min_access_size to 8 to
 fix MMIO abort
Content-Language: en-US
To: Junjie Cao <junjie.cao@intel.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, yi.l.liu@intel.com,
 clement.mathieu--drif@bull.com, zhenzhong.duan@intel.com
References: <20260424201842.176953-1-junjie.cao@intel.com>
 <20260424201842.176953-2-junjie.cao@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260424201842.176953-2-junjie.cao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 24/4/26 22:18, Junjie Cao wrote:
> Raise .impl.min_access_size from 4 to 8 in vtd_mem_ops so the memory
> subsystem always widens guest accesses to 8 bytes before calling the
> handler.  This eliminates all 25 assert(size == 4) sites that crashed
> QEMU on an 8-byte access to a 32-bit-only register.
> 
> With size always 8, the if/else branches for 64-bit register pairs
> collapse.  A zero-extended 4-byte write to the low half is safe:
> wmask protects read-only upper bits, and trigger functions re-read
> the register file and guard on their action bits.
> 
> The entry bounds check is relaxed to `addr >= DMAR_REG_SIZE` since
> the widened size no longer reflects the guest access width; the
> framework guarantees addr stays within the MemoryRegion.  Default
> branches fall back to vtd_get/set_long() when addr + 8 would exceed
> the register file.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> ---
>   hw/i386/intel_iommu.c | 121 ++++++++----------------------------------
>   1 file changed, 23 insertions(+), 98 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index f395fa248c..4b25907778 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3697,7 +3697,7 @@ static uint64_t vtd_mem_read(void *opaque, hwaddr addr, unsigned size)
>   
>       trace_vtd_reg_read(addr, size);
>   
> -    if (addr + size > DMAR_REG_SIZE) {
> +    if (addr >= DMAR_REG_SIZE) {
>           error_report_once("%s: MMIO over range: addr=0x%" PRIx64
>                             " size=0x%x", __func__, addr, size);
>           return (uint64_t)-1;
> @@ -3707,13 +3707,9 @@ static uint64_t vtd_mem_read(void *opaque, hwaddr addr, unsigned size)
>       /* Root Table Address Register, 64-bit */
>       case DMAR_RTADDR_REG:
>           val = vtd_get_quad_raw(s, DMAR_RTADDR_REG);
> -        if (size == 4) {
> -            val = val & ((1ULL << 32) - 1);
> -        }
>           break;
>   
>       case DMAR_RTADDR_REG_HI:
> -        assert(size == 4);
>           val = vtd_get_quad_raw(s, DMAR_RTADDR_REG) >> 32;
>           break;
>   
> @@ -3722,26 +3718,21 @@ static uint64_t vtd_mem_read(void *opaque, hwaddr addr, unsigned size)
>           val = s->iq |
>                 (vtd_get_quad(s, DMAR_IQA_REG) &
>                 (VTD_IQA_QS | VTD_IQA_DW_MASK));
> -        if (size == 4) {
> -            val = val & ((1ULL << 32) - 1);
> -        }
>           break;
>   
>       case DMAR_IQA_REG_HI:
> -        assert(size == 4);
>           val = s->iq >> 32;
>           break;
>   
>       case DMAR_PEUADDR_REG:
> -        assert(size == 4);

Does this device support unaligned accesses? (I doubt). Otherwise
aren't all these assert(size == 4) now g_assert_not_reached()?


> @@ -4184,7 +4109,7 @@ static const MemoryRegionOps vtd_mem_ops = {
>       .write = vtd_mem_write,
>       .endianness = DEVICE_LITTLE_ENDIAN,
>       .impl = {
> -        .min_access_size = 4,
> +        .min_access_size = 8,
>           .max_access_size = 8,
>       },
>       .valid = {


