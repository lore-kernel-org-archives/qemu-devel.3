Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D40EAF532CC
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 04:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5ycC-0007Pj-86; Fri, 27 Mar 2026 00:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w5yc7-0007Ox-4u
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 00:16:03 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w5yc5-0004Ja-Cy
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 00:16:02 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2b0abdde280so16680635ad.1
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 21:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774584960; x=1775189760; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y+S68uIrLvV6AJj403lbVxEftF5rGIOFW9dWbWeKYDo=;
 b=hjkzalialpQfyU/9LNM+T0bXw5EfoIS2ZlINhEb8PbWMpvKuaGWp3o3UIwVCLhdcCZ
 jORcbBQjjsD+YnTk9a6kEYMXeW6lq7x77tLVz2IM/M2BAT2N2f8lfPHlHl9OlqMCH7OH
 F8gcD+ohoKT9NE8OT6b8uQt6NuSaWwN5Mu079r22s3LLB1EnIjFVjs25EIJ412IGRdtf
 OR+U0YR4fXXcwKe4pOcE7QzZSyGyGihuX08YdzoyKlKUt7kAAmHkd5aNHn9evtT6lCyy
 q+av5OmoZnfyYCBFJc1Rw74pEwd/zSkLmGtJIECLE7VnS5JT+f9tYlRvoWT2VBguiRks
 RWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774584960; x=1775189760;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y+S68uIrLvV6AJj403lbVxEftF5rGIOFW9dWbWeKYDo=;
 b=rx5DnDlomDwGk2mkrsxdkS1C2f51vH1f0ifK20AkcQkZiOv2Z+KcBTygHZNtOl4xnd
 OZvbM2k/QWj0WSNIAiuqH+k0t8z7mL4sKj2FfM7HY7BJ7xikUeNUzr9vH7/nLLEIJims
 2N8vpAg7D8hs+iUrUVFWSXGnIJOCDpfqA+/BgsdhJNAlC/QtOegF7ZHoaSKc1HKriBxS
 akU/7/ETTOS9VkkG4Eow1pum3LK1+jLbfEEAOOKdKuK9ZNDui4JfMs1fh4e4Jpt0GRij
 eldBG9cT6Q7LaGkNY0j3fhzw6CKrm96tA97AMn43INeiuakLkOr4ZqeR4RQs8qfFBvqf
 V/NA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSjX+wZR/5x6tsANEo3KIpRjTd71lnAVp/t0wc3PPu61sG3H2b10dqtMYZYrPeZZ+l3QSdGqbcZiKt@nongnu.org
X-Gm-Message-State: AOJu0Yxx0gVVYV5o1XRH7p41nN26fWDp6DfBBkZwaAXtWYoRY3yoUGG6
 0RnBiA9+PsOm4DmFqoTJTKUuJ8gM40HQfbVbaAgUUcSzso/Po7DaiMTo6lwneA8Upz0=
X-Gm-Gg: ATEYQzxuq9RUqr/WhJkDkKllS0NDWH4FTxDYX+jCbMbNc0cImkw3AtoEK7nsBur1dKt
 28vXJWlkpWmFMZCwL5shQUYo6EfYu+s6eXcX3CbCPrrI+rYgrPi0XhGntFxWH5FWQboQVoRMUcf
 ivMYkmoUYdvn5wiDsrnrYF8bYnHI/3Q+j5U/V3+KWgvrjzUaaprb9vJ4gJA6qaMGHelOc/jqogH
 wnVsQQCjK22HI11d97wwDPb1a3v+PnCXGmZZ7Q98M7sDjwCcLoLt5JhsOuC5JXSEsDjbu5Dvma9
 wwcQpRbA5myjwPYpmW5coI3Bkk8ZoZ4BdqQjgNmLhKLbQwo7hYp3fz3djSu2Ow9fRDqKcp2QAn5
 jvwg1lVlGnGdSZU0QlacfcfgHWpOo/EuoRbPlqt73QFIVOhJEwdaKc2yzLi6mhuIgrO1N2VtPAe
 ioTXfdDmNQmWpIjY5CYXlYhjbM5/zEJhm1ahhjLNxaaD4qbwDsr/fH
X-Received: by 2002:a17:902:d487:b0:2b0:ac1e:9720 with SMTP id
 d9443c01a7336-2b0cdc5d700mr11716795ad.23.1774584959764; 
 Thu, 26 Mar 2026 21:15:59 -0700 (PDT)
Received: from [172.16.11.156] ([103.100.225.140])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc773472sm45929635ad.7.2026.03.26.21.15.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 21:15:59 -0700 (PDT)
Message-ID: <ad208f30-4454-41a9-a91d-756fb40930df@linaro.org>
Date: Fri, 27 Mar 2026 14:15:52 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] target/riscv: Support runtime endianness in virtio
 via sysemu callback
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>
References: <20260324164007.549397-1-djordje.todorovic@htecgroup.com>
 <20260324164007.549397-7-djordje.todorovic@htecgroup.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260324164007.549397-7-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 3/25/26 02:40, Djordje Todorovic wrote:
> Implement the .virtio_is_big_endian SysemuCPUOps callback for RISC-V.
> This makes cpu_virtio_is_big_endian() return the correct endianness
> based on the hart's MSTATUS MBE/SBE/UBE bits, which is used by
> virtio_current_cpu_endian() during guest-initiated device resets.
> 
> For bi-endian RISC-V targets, this ensures legacy virtio devices
> correctly detect the guest's runtime data endianness, matching
> how ARM handles its bi-endian support.
> 
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---
>   target/riscv/cpu.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)

Nack.

I replied to v4 before I saw v5:
https://lore.kernel.org/qemu-devel/23a0d240-6f77-4edb-8128-fd2c2b8354df@linaro.org/


r~

> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index eed5afd27e..f813acf579 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -32,6 +32,7 @@
>   #include "migration/vmstate.h"
>   #include "fpu/softfloat-helpers.h"
>   #include "system/device_tree.h"
> +#include "system/hw_accel.h"
>   #include "system/kvm.h"
>   #include "system/tcg.h"
>   #include "kvm/kvm_riscv.h"
> @@ -2713,11 +2714,21 @@ static int64_t riscv_get_arch_id(CPUState *cs)
>   
>   #include "hw/core/sysemu-cpu-ops.h"
>   
> +static bool riscv_cpu_virtio_is_big_endian(CPUState *cs)
> +{
> +    RISCVCPU *cpu = RISCV_CPU(cs);
> +    CPURISCVState *env = &cpu->env;
> +
> +    cpu_synchronize_state(cs);
> +    return riscv_cpu_data_is_big_endian(env);
> +}
> +
>   static const struct SysemuCPUOps riscv_sysemu_ops = {
>       .has_work = riscv_cpu_has_work,
>       .get_phys_page_debug = riscv_cpu_get_phys_page_debug,
>       .write_elf64_note = riscv_cpu_write_elf64_note,
>       .write_elf32_note = riscv_cpu_write_elf32_note,
> +    .internal_is_big_endian = riscv_cpu_virtio_is_big_endian,
>       .legacy_vmsd = &vmstate_riscv_cpu,
>   };
>   #endif


