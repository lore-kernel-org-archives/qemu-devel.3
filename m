Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44810C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 09:04:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9gs3-00061c-Ex; Tue, 29 Apr 2025 05:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1u9gry-0005wR-Q2
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 05:03:16 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1u9grw-00024D-9D
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 05:03:14 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-39ee5ac4321so6174638f8f.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 02:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745917390; x=1746522190; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WqYYzZJ2etaj+iMzBfgvsYHIDCe3M37Qn2AkgGnnBQ4=;
 b=bLGws2JG8vlJzS5bD8oNsBbxYyIPRAeofCO5abgDJQDF3LujX4jxCzZYuslIHqv1pA
 43oQrtj71X1B6KrknXGUvORNdvC5JMrdqqiLh8YoVk5z74Si08ob82gdn9BgXyLnKVxW
 cbC8WYrr42e9B1TTvZxQNAA5Xf4kjyTbSLD6Zm0BL8/e/p6x8fbtUfX/LbpbYaPw/1Ao
 jk4s5LF23LaKGYZ0ShWebhxDJ7wt64ngn50VJtSqFa+EX8pfuP50MeQAA4xp3kLF1aP8
 N+c/iVHQorVJHDya61Rm7P0KoaDgnnJUJ8vJHPmbSU+YXsoa9bh12qpOmOhsUD+aDd2l
 NLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745917390; x=1746522190;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WqYYzZJ2etaj+iMzBfgvsYHIDCe3M37Qn2AkgGnnBQ4=;
 b=LxzY5YaDjA0jZJ/3uNxiBCO4y71w4tC5K9ktQTTz5eb7luEywjxgex0xd5l4STHwGV
 1AK1kTnecP9nC2lLKp9aglwrksO5gkWixD1w5VrS1xjhFT9lZLeyb5RSPe+6m+vWVtxj
 Io1JevhNT+KmC+cuMTZGxGcaeA14oNK053CpZFcnPeSCNYmMg232ByWlGMaWIBJ9K1jw
 qWMOigVe1vFO2w4kOR5f2oef/QG373PciSKYS+nv5PdnMf7rhgpBWdMaI+QRqxISprCr
 HjgJdPL0keUdBE5HlvGC3Br3jYNra3ZcM2xV00ZltwRCB/XUL1birDfsCOzpZi54/bf/
 GfsA==
X-Gm-Message-State: AOJu0YxVUEwhoJv1aspZfo53QzTLSDWBWAqKf/DGcsVYNVlNl/YSkxKt
 nyyvvYMcWSD8Gc2BtkZ02jBR8tc19LfhyaXGRIPUp1FzzulPh9zWH/S1gX4ncoo=
X-Gm-Gg: ASbGncsqmnm6aaVUMyHgvrWym9OsL9GtT7Sw4hdeXtpTReACoBGD34MqlAbVZL2zgTS
 6uGC7BnBTYW9vr7NKf7kdSN9PUNk73IOLzM3nL7/rN4hhLt26VGmJNfWA7FTVkrQYyRd592Vu1J
 cyWXHqUEZoL8XRxxydNYiijtlUYbsLunHDgFLTzS0CSZWXnZe5IOO7uxYxfw+oHZIKpQ2bronhp
 mHp1MAYhEd/Iov+MB4SHd4AaM7LuVCmGm5G4qXA89wfqgmCcfn5gWeWtVlw6p5A/brD+dS9XlPq
 cRuZ0x+om8NzXSJ9xZRPzheUMiJRUrjwvJgtpmc=
X-Google-Smtp-Source: AGHT+IHNo/K259IOEMrjXVSiVhCsZiYcv3RF3C8lySddyQWQ0mrOdZgyHeYM7+RuX9dVXyTO3zXJQg==
X-Received: by 2002:a05:6000:1887:b0:39e:e438:8e4b with SMTP id
 ffacd0b85a97d-3a0894b0c0emr1939446f8f.50.1745917390045; 
 Tue, 29 Apr 2025 02:03:10 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::f716])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073c8ca72sm13081625f8f.4.2025.04.29.02.03.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 02:03:09 -0700 (PDT)
Date: Tue, 29 Apr 2025 11:03:09 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
Subject: Re: [PATCH v4 0/9] target/riscv/kvm: CSR related fixes
Message-ID: <20250429-a9aadd5aae504ada565a7c1e@orel>
References: <20250428192323.84992-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428192323.84992-1-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x431.google.com
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

On Mon, Apr 28, 2025 at 04:23:14PM -0300, Daniel Henrique Barboza wrote:
> Hi,
> 
> In this new version a change was made in patch 8. Instead of changing
> scounteren to target_ulong, change the current logic to honor the QEMU
> env storage instead of the KVM reg size. 
> 
> This will make QEMU the authority when deciding how to read/write the
> CSRs in the env flags instead of KVM.
> 
> We're doing this change in patch 8 but it could also be squashed into
> patch 4. If the code in patch 8 is good to go I don't oppose merging it
> with patch 4 if desired.

I think you mean patch 5, but I think I prefer it separate anyway.

Thanks,
drew

> 
> No other changes made. 
> 
> Patches missing acks/review: patch 8.
> 
> Changes from v3:
> - patch 8:
>   - instead of widening scounteren, use the QEMU storage size instead of
>     KVM reg size when reading/writing KVM CSRs
> - v3 link: https://lore.kernel.org/qemu-riscv/20250425160203.2774835-1-dbarboza@ventanamicro.com/
> 
> Daniel Henrique Barboza (9):
>   target/riscv/kvm: minor fixes/tweaks
>   target/riscv/kvm: fix leak in kvm_riscv_init_multiext_cfg()
>   target/riscv/kvm: turn u32/u64 reg functions into macros
>   target/riscv/kvm: turn kvm_riscv_reg_id_ulong() into a macro
>   target/riscv/kvm: add kvm_csr_cfgs[]
>   target/riscv/kvm: do not read unavailable CSRs
>   target/riscv/kvm: add senvcfg CSR
>   target/riscv/kvm: read/write KVM regs via env size
>   target/riscv/kvm: add scounteren CSR
> 
>  target/riscv/cpu.h         |   1 +
>  target/riscv/kvm/kvm-cpu.c | 335 +++++++++++++++++++++++--------------
>  2 files changed, 214 insertions(+), 122 deletions(-)
> 
> -- 
> 2.49.0
> 

