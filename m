Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B55C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 12:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Hu1-0006RX-E0; Fri, 25 Apr 2025 08:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1u8Hty-0006Qt-7p
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:11:30 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1u8Htv-0002hw-IJ
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:11:29 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-39ee623fe64so2089495f8f.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 05:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745583085; x=1746187885; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1kScVoLyjKlBL6tKudOwB4udef7cfYVq7fLgZ2bYekA=;
 b=QcsrEns2ide2jVtBHcuYWBSbIXVv9UhkR0t6/sWrT5WgGbLUDx25VVCOei161r1P+d
 RqsmS8jF/2nq9MZjucHMq4sIZBnkZNXv8mTUSAXUsBYB+RvW7nJuf9vMEwZ4+EM+POfk
 0RYs5lYVhWv0vzHuNwpOSosg5qZRpLN273FtsZJZQmWjhFSnuZjR+XUh0bj96jl1lAhM
 qeIuPkyTOTx3OEtaQ4SgQK5U5Wdmf4ksZiZYTKe42qEAEKBYfWsgmZI0yheituyE1hts
 jWDfbcs+biqbdKhcD7B7YynTRr58xyXRDCWnXVMK9lNdAoqwTTjhm3pyFYiz1bLB9PCx
 uQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745583085; x=1746187885;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1kScVoLyjKlBL6tKudOwB4udef7cfYVq7fLgZ2bYekA=;
 b=JboFhZbkuh5Vim4OwNVIpPfvWxCMRtM4k62GjSWq+DFCqM04McOCqB/q7ECgP+6ccK
 PH2yKBz4N6kvTUE4fdlxmGMI1nhwXt+a4C4S1naqo7NeIrabTnhPKwQc1KAAo2Pf+kDz
 tuRuTSc2nRyGzRiX0Tbzys9eBIP7Rccvf8zV7u4kh/5BWf3EQC2y//IYni2yvcrZIElk
 0sDLjeUlUKoRHCO9ZmPyiksbzzcHPyvbTImHK9aBhFxQzfiQXKaggcpmnfRoDSRcIsu3
 6zDHcATjCq0tf/ZAVXzCm+AwzhtklGv1eCV4avhT3B8sORcCICVC52lYe7x5fK0kFWZO
 R0lA==
X-Gm-Message-State: AOJu0Yw7TZLTx3rvtVPckAQjO/nyjfVQHS3r79ehe8zoQzy/cSmnzHBj
 ud5pj6C/Z1nelS596sN9e+CGUDPk0nlXejeLYK43EhTL/akOxL7WJKFTpINc5J4=
X-Gm-Gg: ASbGncsa++okZEx0gi5Nxs9XiUIsmyBU42ZxCTmDAeU6815heoErL+c7R4PQeeJLqnF
 OtXhNeSshwDtFWHnJpIqnBjqmCCduWSXC6a9gzdn1xGtMAMiF1yleluz1Cj6WdJc6iivCYybZB6
 9QV0cCBF8PAALl5AK1MJnAxgDxRoUbCXxLH6iUUL/P3PA+o4xYbEhoNHR3smLCHJIWxDw9FT/Y5
 RXQXeWTmnQbHirXiZw6zy1wLzRc0DrhDKn2Oud2MGM6FsSNhbhl0oFy832FXRxNRSWhcTByYAHh
 qGHf/L8515BlJI9dyra3rNGr7y9F
X-Google-Smtp-Source: AGHT+IEOMsnPi0/qmEEe9UU2t/HQJXERPrlMVjaye1AX/0qgHDLa/RL4oA08DcN6MDeujs23NTlmJQ==
X-Received: by 2002:a05:6000:2283:b0:39c:f0d:9146 with SMTP id
 ffacd0b85a97d-3a074f11d7fmr1610276f8f.45.1745583084938; 
 Fri, 25 Apr 2025 05:11:24 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::f716])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e461bfsm2191386f8f.79.2025.04.25.05.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 05:11:24 -0700 (PDT)
Date: Fri, 25 Apr 2025 14:11:23 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
Subject: Re: [PATCH v2 8/9] target/riscv: widen (m|s)counteren to target_ulong
Message-ID: <20250425-d3897a3163a3fb2853763a8e@orel>
References: <20250425113705.2741457-1-dbarboza@ventanamicro.com>
 <20250425113705.2741457-9-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425113705.2741457-9-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Apr 25, 2025 at 08:37:04AM -0300, Daniel Henrique Barboza wrote:
> We want to support scounteren as a KVM CSR. The KVM UAPI defines every
> CSR size as target_ulong, and our env->scounteren is fixed at 32 bits.
> 
> The other existing cases where the property size does not match the KVM
> reg size happens with uint64_t properties, like 'mstatus'. When running
> a 32 bit CPU we'll write a 32 bit 'sstatus' KVM reg into the 64 bit
> 'mstatus' field. As long as we're consistent, i.e. we're always
> reading/writing the same words, this is ok.
> 
> For scounteren, a KVM guest running in a 64 bit CPU will end up writing
> a 64 bit reg in a 32 bit field. This will have all sort of funny side
> effects in the KVM guest that we would rather avoid.
> 
> Increase scounteren to target_ulong to allow KVM to read/write the
> scounteren CSR without any surprises. 'mcounteren' is being changed to
> target_ulong for consistency.
> 
> Aside from bumping the version of the RISCVCPU vmstate no other
> behavioral changes are expected.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.h     | 4 ++--
>  target/riscv/machine.c | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index f5a60d0c52..0623c3187b 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -400,8 +400,8 @@ struct CPUArchState {
>       */
>      bool two_stage_indirect_lookup;
>  
> -    uint32_t scounteren;
> -    uint32_t mcounteren;
> +    target_ulong scounteren;
> +    target_ulong mcounteren;

Let's leave mcounteren a u32 and write a comment above scounteren
explaining that it's supposed to be a u32 (as the spec says) but
we're using a ulong instead to support KVM's get/put due to how
it's defined in struct kvm_riscv_csr.

>  
>      uint32_t scountinhibit;
>      uint32_t mcountinhibit;
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index df2d5bad8d..4b11b203fb 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -401,8 +401,8 @@ static const VMStateDescription vmstate_ssp = {
>  
>  const VMStateDescription vmstate_riscv_cpu = {
>      .name = "cpu",
> -    .version_id = 10,
> -    .minimum_version_id = 10,
> +    .version_id = 11,
> +    .minimum_version_id = 11,
>      .post_load = riscv_cpu_post_load,
>      .fields = (const VMStateField[]) {
>          VMSTATE_UINTTL_ARRAY(env.gpr, RISCVCPU, 32),
> @@ -445,8 +445,8 @@ const VMStateDescription vmstate_riscv_cpu = {
>          VMSTATE_UINTTL(env.mtval, RISCVCPU),
>          VMSTATE_UINTTL(env.miselect, RISCVCPU),
>          VMSTATE_UINTTL(env.siselect, RISCVCPU),
> -        VMSTATE_UINT32(env.scounteren, RISCVCPU),
> -        VMSTATE_UINT32(env.mcounteren, RISCVCPU),
> +        VMSTATE_UINTTL(env.scounteren, RISCVCPU),
> +        VMSTATE_UINTTL(env.mcounteren, RISCVCPU),

Since we only expect the lower 32 bits to ever be written, then do we need
to make this change?

>          VMSTATE_UINT32(env.scountinhibit, RISCVCPU),
>          VMSTATE_UINT32(env.mcountinhibit, RISCVCPU),
>          VMSTATE_STRUCT_ARRAY(env.pmu_ctrs, RISCVCPU, RV_MAX_MHPMCOUNTERS, 0,
> -- 
> 2.49.0
> 

Thanks,
drew

