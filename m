Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A39EE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 14:53:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXiHu-0006mj-9J; Tue, 14 Jan 2025 09:53:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tXiHs-0006mF-1r
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 09:53:00 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tXiHn-00054R-5a
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 09:52:57 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d9f06f8cf2so2824763a12.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 06:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736866372; x=1737471172; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2I6VGgAx2CmIznv/nzISg17/tDkwphqCyFZ2rwAQL3E=;
 b=TcuwB5u0MTc/oHwPi9a5aXDkGUB3xS+Tu3Rha7xJjwC0Pwj3LIVhflHRXlZuHvqXKM
 ddaxtw2fmbMxAZYGClUIaRT4OnWj9nCZYBbgw5f439MMRwVPHoDRD1eZlMKIFc2K0qqr
 TERJAf8P0dn5CvNNKVw/raGk9zVwL95pdd1VJde3j39vt+6sz4VzoxY239NEPLudgwqv
 Inlbe2iRjzjsim1fv3bHFqNHNzjayoCNVqVjqvWe03rxxW8x1urgFqk9xMYzfJSFnrk4
 9TmjK9TnXXaVI60/sgUxs3LaBVxqPOc0s/WfUJOuc+eg8yK9EASzsOuzSTQTt2Yc6De8
 Jtnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736866372; x=1737471172;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2I6VGgAx2CmIznv/nzISg17/tDkwphqCyFZ2rwAQL3E=;
 b=n9yoTiGSzC1Ln0U0/Nng6fxkeJBhpT05A3f+Y1E6VyIpAIupnrvcLjDmZycVaXLICN
 sVmccgN8F8xDL3rvJJORaQTJWnwuOez0xPSwwS3jhoViPu5JXlAEKmmjgrROX1JTvTay
 F9zOerVjZ6zHng3cPVVigw7KwstuIU/wRVmoQI7dCgh9WQeKGPKUyFTtEp1GMuXt2KHB
 KkIN++fzbTgBHthNj8Q6LokMwPKc2EKCypob4tsQOtyVElJ+s2adcSxW0qKqgL0fSDCS
 1nrj8oxjTMBO9OY9loYUV0qbCmNBb1xuoUYLOM81hOdl/nf1MdzNSKKmrtH60ZE/FvsY
 sVDQ==
X-Gm-Message-State: AOJu0YzAY9lvqjdhiQ/DO14DVZqBgrq9+Re8aEBeKw+FRIjSBy2yUa0n
 I+uiwGKYX9PHCtO6BE8NEz9Z56Zfi7QkEyYDVUJb1pdPEe1nYxgBqsanP07+7y0=
X-Gm-Gg: ASbGncuq3cMOz6vDRr4vQUOQqrAxdNg/YLUCLj26P0Lpp9m6nBquxJEa7KQ63BQbMtI
 SrtyEQWttLuR+pd4nJ+6dvXJIjRxJb4tG/DSXD9v53FYGwKK9W3Uw5vFP+LnhoJRe4IN/ziXqNq
 EF2qKcWjL2e43WoA6oN9mkCzQTKmrJUq7lXZTvRbRbSc1Oy3nLbXn5OQN/i9iutad7KM44UKviX
 r9hFmNa/rJBK/KSqWX+xsLMfc/qTW3EhTR8VD8QLBL52eqRNuZLH3Ld9UbyVQOI1LHeKRrHyoWO
 DYA4mhhisY5bP7V3gMeB24Nxgse57gFZQyDmDygKNQ==
X-Google-Smtp-Source: AGHT+IEp1eNyKbG9DvvF0pq+98SRAQDLvmIbJGRqu4EKi19cGsWJEnaQ4Ls+6FmxtC2X20Xoc5UyRQ==
X-Received: by 2002:a05:6402:5187:b0:5d9:adb:4692 with SMTP id
 4fb4d7f45d1cf-5d972e06b4cmr23339616a12.9.1736866371993; 
 Tue, 14 Jan 2025 06:52:51 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d99008c394sm6363866a12.7.2025.01.14.06.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 06:52:51 -0800 (PST)
Date: Tue, 14 Jan 2025 15:52:50 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH 2/4] target/riscv: use RVB in RVA22U64
Message-ID: <20250114-85b134099fa79adb42628ebc@orel>
References: <20250114132012.1224941-1-dbarboza@ventanamicro.com>
 <20250114132012.1224941-3-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114132012.1224941-3-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x533.google.com
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

On Tue, Jan 14, 2025 at 10:20:10AM -0300, Daniel Henrique Barboza wrote:
> From the time we added RVA22U64 until now the spec didn't declare 'RVB'
> as a dependency, using zba/zbb/zbs instead. Since then the RVA22 spec
> [1] added the following in the 'RVA22U64 Mandatory Extensions' section:
> 
> "B Bit-manipulation instructions
> 
> Note: The B extension comprises the Zba, Zbb, and Zbs extensions. At the
> time of RVA22U64's ratification, the B extension had not yet been
> defined, and so RVA22U64 explicitly mandated Zba, Zbb, and Zbs instead.
> Mandating B is equivalent."
> 
> It is also equivalent to QEMU (see riscv_cpu_validate_b() in
> target/riscv/tcg/tcg-cpu.c).
> 
> Finally, RVA23U64 [2] directly mentions RVB as a mandatory extension,
> not citing zba/zbb/zbs.
> 
> To make it clear that RVA23U64 will extend RVA22U64 (i.e. RVA22 is a
> parent of RVA23), use RVB in RVA22U64 as well. As a bonus we can also
> exclude zba/zbb/zbs from 'ext_offsets' and make it a bit shorter.
> 
> (bios-tables-test change: zba/zbb/zbs no longer on riscv,isa)

We should still have zba/zbb/zbs on the ISA string. I don't think
Linux yet supports expanding a 'B' bundle into them and other SW
may also have not really cared about 'B' being designed to represent
preexisting extensions after having already learned how to detect
those extensions.

Anyway, what keeps them from being added? I don't see QEMU code
for that. I do expect a bios tables change though, since the ISA
string should now have 'B' added to it.

Thanks,
drew

> 
> [1] https://github.com/riscv/riscv-profiles/blob/main/src/profiles.adoc#61-rva22u64-profile
> [2] https://github.com/riscv/riscv-profiles/blob/main/src/rva23-profile.adoc#rva23u64-profile
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c                |   5 ++---
>  tests/data/acpi/riscv64/virt/RHCT | Bin 398 -> 400 bytes
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index b187ef2e4b..8d0563527f 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2351,13 +2351,12 @@ static const PropertyInfo prop_marchid = {
>  static RISCVCPUProfile RVA22U64 = {
>      .parent = NULL,
>      .name = "rva22u64",
> -    .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVU,
> +    .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVB | RVU,
>      .priv_spec = RISCV_PROFILE_ATTR_UNUSED,
>      .satp_mode = RISCV_PROFILE_ATTR_UNUSED,
>      .ext_offsets = {
>          CPU_CFG_OFFSET(ext_zicsr), CPU_CFG_OFFSET(ext_zihintpause),
> -        CPU_CFG_OFFSET(ext_zba), CPU_CFG_OFFSET(ext_zbb),
> -        CPU_CFG_OFFSET(ext_zbs), CPU_CFG_OFFSET(ext_zfhmin),
> +        CPU_CFG_OFFSET(ext_zfhmin),
>          CPU_CFG_OFFSET(ext_zkt), CPU_CFG_OFFSET(ext_zicntr),
>          CPU_CFG_OFFSET(ext_zihpm), CPU_CFG_OFFSET(ext_zicbom),
>          CPU_CFG_OFFSET(ext_zicbop), CPU_CFG_OFFSET(ext_zicboz),
> diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/virt/RHCT
> index b14ec15e553200760a63aad65586913d31ea2edc..13c8025b868051485be5ba62974a22971a07bc6a 100644
> GIT binary patch
> delta 53
> zcmeBUp1{l%<l!7LfsuiM@#{n`13^7TMg~>JqB1j+%-qDZl;ot1UQ&#clNpsc(ij;S
> I3K$s}0ARKZK>z>%
> 
> delta 52
> zcmbQh+{ern<l!9B$H>6Im@tvcKtP9)kwJyAsLaeHGdD3UC3&N_6yxMHMkS6EMh1pF
> HMg|4|IwT82
> 
> -- 
> 2.47.1
> 
> 

