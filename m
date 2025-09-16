Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C20CAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 12:20:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyUeA-0002Qv-2r; Tue, 16 Sep 2025 08:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uyUdU-0002Ma-OU
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 08:18:23 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uyUdL-0007oq-Bz
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 08:18:15 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-ea4fceb260aso776353276.1
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 05:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1758025083; x=1758629883; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UTDtJEvR6NjQKi2r1wnxsnhhmQxrPbHge+HLrt7fbZk=;
 b=FPJzfXhslm3Ue+n5d4BBPUrVQw8Kj3UiP6Xf6ld9hFgb9VpxBhPF29bkVC7EiU0Uxl
 qgXLWMvIhLCLFYi4IuyDzaB9A71RBx5UCbqYIy8n/EZYGWvDB+oyrFPeYh04yEQmMLhn
 GjTx/bJLjLRmtC9up6XZ/Vm/rhvwg+13/LZNb/v8wYmAOSlu0NSqJ4qKqi2BCuJa3azQ
 FABvZdG0n8Uxjyar9tmx2bGCRHEOJltpms6Y3kOK/vT/ZtXZriQOWYul1kfv983/RQy6
 N1/eE4r1RPRADROmEMO+MtOXDAOTnRsppMGlOQyUZ1ZqbRijOEwJilC+c6sEfue1B2EV
 mIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758025083; x=1758629883;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UTDtJEvR6NjQKi2r1wnxsnhhmQxrPbHge+HLrt7fbZk=;
 b=uVcY+M98MLiG0h9/eImH3CkdW7pwxgCwvC/5r8iRpFZVWLIJvpj6R0pqrYL6CpI4UP
 xLGqdjDE9cQClcapHiZ8W82tzcjyBzggqbC3pZ9oJOLKs1EKPZSLwHzfsuyDZpl1MZtH
 0VJGSG8uW2yDvTaNl7uN+W17bxe1PhwH4kAJULzxNy2tjFVHdVvJgtXdPrNCUvYjXtis
 GGwi9YVmDGPYOxvhRBUo1hX/kO806yeudXR7sNvolD9GIH0Ksge2xvZVsaNZf5W5MK4p
 ARLpMoBOr533h/HBOBqk2djrDMnIP6iwXMQxMNLzBkDWsceKzJKqR3kpjpr9Px7BLw2i
 A0+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJCuT1KD/dthLguKPvVTzx55iesycXbUlU8WqrAUg8hGrf4Ar8YW0onW9cN/mJxCqWZjJLHoT4ormn@nongnu.org
X-Gm-Message-State: AOJu0Ywp0zI9Q/is4nIbamVE+LYXnSviKEEDup8wilcm3wpvnhaWChvn
 EDpFBBjNAUVtUiVqtFojNY4VEhrHjejPd0ABxsZ8mqrNhEX7tkOuqWMPkyBtwaLP1T8=
X-Gm-Gg: ASbGncuNXd/YxglmVsbUvmy8j9BRGqKQXHpLT1U/m7fY4keg3luwcUBVhbxZRaa1YRV
 eXXfYvreq0jOUAKCg3aeYLEeRwqrtpix96tpyuYmCoo/AjLk5Mlk+WS3YZzQ02OmsJVQ/Qb4sQn
 ukjqzh8MoY6AhPakW2YnxUwpT0SgBkNMA94FR4F1XJqyqgAdwEkQEaNFrpZVezyeQCxTTZZY23h
 TV0iXuT4R0bhwpSlr2gSNCVW9r52H4yzwH3AM8JANI+/i56GCdizxoTQtuCmI586Vj5jQAOjT8Y
 jpg/sUsVZLs7oPe2JYa508GPLP8RD/dVlqCu0MwfQ2RLyKtus/KPqkW2LOe7fWVbFZFjWXUQvqo
 M+yPzA29p0MXUoYly0+S4Tll9axF3PkaVQ9KH+GObXW5SDtzQ
X-Google-Smtp-Source: AGHT+IHaV6dqFK1hodH8pbe52ovPZjz6W9iJiE/ku+9YFwfthIoxwA5orVJfjZepCQS1WjFlkiNLmw==
X-Received: by 2002:a25:6ed6:0:b0:e97:6a:90fa with SMTP id
 3f1490d57ef6-ea3d9c3ac68mr9148304276.51.1758025083497; 
 Tue, 16 Sep 2025 05:18:03 -0700 (PDT)
Received: from [192.168.68.110] ([179.225.245.173])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-ea576bb11absm794446276.12.2025.09.16.05.18.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Sep 2025 05:18:02 -0700 (PDT)
Message-ID: <0308d67a-7675-4eed-b85f-b6e7bae553f9@ventanamicro.com>
Date: Tue, 16 Sep 2025 09:17:59 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] target/riscv: Implement SMSDID and SMMPT extension
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com
References: <20250909132533.32205-1-zhiwei_liu@linux.alibaba.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20250909132533.32205-1-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yb1-xb2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Hi!

On 9/9/25 10:25 AM, LIU Zhiwei wrote:
> This patch set introduces support for the RISC-V Smmpt (Supervisor
> Domain Access Protection) extension. It only includes two sub-extensions:
> SMSDID and SMMPT.
> 
> This patch set implements the v0.3.4 version of Smmpt
> (https://github.com/riscv/riscv-smmtt/releases/tag/v0.3.4).
> 
> As there are newer SMMPT specification versions, this patch set is
> not intend for merging.

I'm not sure I understood. Do you mean this patch set isn't supposed to be
merged?


Daniel

> 
> The implementation is broken down into a series of logical steps:
> 
> Patch 1 adds the fundamental definitions for the Smmpt extension,
> including
> new CSRs (mmpt, msdcfg), their bit-field layouts, and the corresponding
> CPU
> configuration flags (ext_smmpt, ext_smsdid).
> 
> Patch 2 introduces the core logic for Memory Protection Table (MPT)
> lookups.
> It includes a new file, riscv_smmpt.c, which implements the multi-level
> table walk to determine permissions for a given physical address.
> 
> Patch 3 integrates the MPT permission checks into the main MMU and TLB
> handling pathways. This ensures that both page table walks and final
> data accesses are subject to Smmpt protection rules.
> 
> Patch 4 adds support for the new fence instructions defined by the Smmpt
> extension, specifically `mfence.spa` and `minval.spa`.
> 
> Patch 5 enables smmpt and smsdia extendion.
> 
> With this series, QEMU can now model systems that utilize the Smmpt
> extension for enhanced memory security.
> 
> LIU Zhiwei (5):
>    target/riscv: Add basic definitions and CSRs for SMMPT
>    target/riscv: Implement core SMMPT lookup logic
>    target/riscv: Integrate SMMPT checks into MMU and TLB fill
>    target/riscv: Implement SMMPT fence instructions
>    target/riscv: Enable SMMPT extension
> 
>   target/riscv/cpu.c                            |   4 +
>   target/riscv/cpu.h                            |   9 +-
>   target/riscv/cpu_bits.h                       |  27 ++
>   target/riscv/cpu_cfg_fields.h.inc             |   2 +
>   target/riscv/cpu_helper.c                     |  81 +++++-
>   target/riscv/csr.c                            |  83 ++++++
>   target/riscv/insn32.decode                    |   2 +
>   .../riscv/insn_trans/trans_privileged.c.inc   |  30 ++
>   target/riscv/meson.build                      |   1 +
>   target/riscv/pmp.h                            |   3 +
>   target/riscv/riscv_smmpt.c                    | 273 ++++++++++++++++++
>   target/riscv/riscv_smmpt.h                    |  38 +++
>   12 files changed, 548 insertions(+), 5 deletions(-)
>   create mode 100644 target/riscv/riscv_smmpt.c
>   create mode 100644 target/riscv/riscv_smmpt.h
> 


