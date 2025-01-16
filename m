Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101A6C02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 12:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYOn3-0000Wd-30; Thu, 16 Jan 2025 07:16:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tYOmq-0000V3-FS
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 07:15:48 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tYOmn-0006Bt-4N
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 07:15:48 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2ef70c7efa5so1237043a91.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 04:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1737029743; x=1737634543; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oIlJHDEAr5kXhrWvJRykxP6NHD7AfkEEmwT5hp65unc=;
 b=Ni4l4en3T2fnjlEqNCEt8oTOCP723A4rgYMobD1yQafFZu/b+f3hEi3sSOyr+2hgPr
 V29H93kn7l4MwP2Vd8YjNHGH/wEr77rpGGJUTOCGXkIy+gqI3UDgkWggNATGK9xJZ7LT
 gq04ze5d9pw34aP0CUtZkD69fysgK1NK/LlTgGyHqjuCur5A/j1xOgM5TToVcpK38QLl
 YNfjFjhQyspUeNBmNwbb4Irx4y7mfMC5GEnRMFM69wpFTiEKPHuss1VYtCaWSx5KfLCZ
 bFSoWEUc1E5+gyH8Nh6ylrWKb4Lec2VvEB+CSHgmaqDGBnc++Oo3OBoa8rvb2owJjZaf
 T7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737029743; x=1737634543;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oIlJHDEAr5kXhrWvJRykxP6NHD7AfkEEmwT5hp65unc=;
 b=spanNpmyqWqh8VL7IUZe61+EWdjferx3c2qLZnUsUzt8Ns3ZlyhAA7t9nHi/PmB6Bb
 fpJQtuRLHV+N7CQ4ZBnIYSxo5HTXIlA4S9jmuKkLXG9IRXYH0ZdTYe1caMk4fruLSy79
 w+/i7nnfAjYO/vLXT+EeYejkJ+96fX86iXEVgK1lookw2C5qXKz6O/C9nQmSoz1VkLmF
 cFxo1bvh3tS2hPFtfvMemt5yqROuWjt05B+HwV5w76wjNuOGdsI/eqYNB29qJGzrb2bc
 2AL2GRxwkPlen2oKtVHR1hP//GuFARZJVZo/J0OlBYnqDAJIdoPNqGoZkSyrCPTPJHir
 XlKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb3s11+ea3yZKzcWxHGit5AZNsPXTPG96e9HsevCrfV8IP5JJYt6VDpQaj0EYKmY/OYEkrg/Z7ggye@nongnu.org
X-Gm-Message-State: AOJu0YxyXhPaf5WgQUJKKwYju6SMiXZTCyaF065oAEnVa+WR2dgvN8pt
 yQjyplDLBgl3DRr/njx+aO9uKHaT0Ke81wtr37YPOvKQ/ENfs1RLsZJD/DwE3p0kV+I0a7r9ZCr
 x
X-Gm-Gg: ASbGncvmZVN6z/sshNKwj59VwDi8VNyV4fH059ZZq/+vBLb/GvPHtr4BpBwDDEdMgzH
 eBLoPIRh8P2ScnmFrk1BY+p01XzgEFLFHgTx5qoRZ7krHW2vbnMAPsqqysFj3gYO3JWle6YcJkT
 h19oKBsSs665uXPMZcs2dobnsTqKURAWBfSA/Vv7IVQr82bayTfuzY2CwpQS7Wm6qX3B/CpsaeF
 7GglhAt85f7LwCMi2KKVwEKA9qqXivCt2wo8P9zQ90gMKsCH8uWn73Z7ekv9J2FoZxMG/c=
X-Google-Smtp-Source: AGHT+IHcuQl++MXnv7VUxcDBEBUzfMMwL1csW1vlU/7AHIxhtCqEyrbkXvZ+d+hBFn5+CawXuyyGRw==
X-Received: by 2002:a17:90a:d00c:b0:2ee:c5ea:bd91 with SMTP id
 98e67ed59e1d1-2f548f1d783mr46518448a91.29.1737029743043; 
 Thu, 16 Jan 2025 04:15:43 -0800 (PST)
Received: from [192.168.68.110] ([191.202.238.10])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f72c20ce31sm3153444a91.33.2025.01.16.04.15.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 04:15:42 -0800 (PST)
Message-ID: <9c58515e-bdbd-4183-9587-a7fd205717db@ventanamicro.com>
Date: Thu, 16 Jan 2025 09:15:39 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: disable Smdbltrp for the max cpu
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org
References: <20250116092352.1630278-1-cleger@rivosinc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250116092352.1630278-1-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102f.google.com
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



On 1/16/25 6:23 AM, Clément Léger wrote:
> When present, Smdbltrp is enabled by default and MDT needs to be cleared
> to avoid generating a double trap. Since not all firmwares are currently
> ready to handle that, disable it for the max cpu.
> 
> Reported-by: Atish Patra <atishp@rivosinc.com>
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> 

This breaks 'make check-functional' indeed. Not sure why we didn't notice it
earlier.

The change is fine but it should be made in the patch that introduced the error
since it's not merged upstream yet. The patch is:

[PATCH v8 9/9] target/riscv: Add Smdbltrp ISA extension enable switch

Otherwise we'll have a gap of patches where 'make check-functional' won't work
and it'll make our lives harder when bisecting stuff. This is the same review I
gave Frank in the v10 of the 'smrnmi' series:

https://lore.kernel.org/qemu-riscv/26ecf1ca-07eb-4aed-9d06-a12c036c0723@ventanamicro.com/

You can re-send "target/riscv: Add Smdbltrp ISA extension enable switch" as a v9 (I
believe it's fine to send it standalone, no need to re-send the whole series) with
this patch squashed in. Alternatively Alistair can squash in this change in his tree
if he's up to it. Whatever works.

But an extra patch is only justifiable if the change that broke stuff already made
upstream and there's nothing we can do about it. This is not the case, and  we should
fix it properly while we can.


Thanks,

Daniel


> ---
>   target/riscv/tcg/tcg-cpu.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 48be24bbbe..0a137281de 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1439,6 +1439,16 @@ static void riscv_init_max_cpu_extensions(Object *obj)
>           isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_smrnmi), false);
>           qemu_log("Smrnmi is disabled in the 'max' type CPU\n");
>       }
> +
> +    /*
> +     * ext_smdbltrp requires the firmware to clear MSTATUS.MDT on startup to
> +     * avoid generating a double trap. OpenSBI does not currently support it,
> +     * disable it for now.
> +     */
> +    if (cpu->cfg.ext_smdbltrp) {
> +        isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_smdbltrp), false);
> +        qemu_log("Smdbltrp is disabled in the 'max' type CPU\n");
> +    }
>   }
>   
>   static bool riscv_cpu_has_max_extensions(Object *cpu_obj)


