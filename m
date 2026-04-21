Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED17BF94CB8
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 23:57:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFKxC-0008UE-N9; Tue, 21 Apr 2026 19:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wFKxA-0008Tq-SH
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 19:56:28 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wFKx9-0001BI-7S
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 19:56:28 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b9e00649769so679496766b.3
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 16:56:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776815785; cv=none;
 d=google.com; s=arc-20240605;
 b=Jjwes//+dZi0pDLLjN9Q8s5sGb1MA5CuS5+8qEaCRkF0URclYqmrKyf9UuE5g1wvRv
 w5fc5BTW79UV6nqiBaTKQSFvG4/7qwPNsSeBurdGpltSt6LIVv3mz2KSJVSuSMBpbPH5
 Le8ro0LahiM0RUtV7ewIq7/Pix3NQbvHh1CPDKxj7PSL/TdInbM1T2HhPaxX0K5WrJFz
 RIcASUXDCCuLAdVxvLrckO83MH/IU/S95VrU4zWrKFAN3ySDOzYkR37XInPunPHGHJqa
 LK3KHutvQZ2qxgLa4XdhCKbuV05IXf63QjrtphRij+NLmCSmELtyxtRUg0F9lt+nvxnr
 /TdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MB2fW1rCVypTALinFvQ+9bLmI+qyoaUiQbMKvRMVzfs=;
 fh=X79f7cC6joFjXa/GVENRWCGALOpkuesxoGuQ2U82tIg=;
 b=GkYcjnv/aKAWvqdCxGCFWMhmzko+05b4angwvMgymTyBZNJXYUwS2BLdnux+MXe3yf
 Sp2iR+C4HI4joZwEDZd92YVnpItzHe39QU4Z4duAG9yp5rD++Y1ja3Jhph3IjNI3whVJ
 y0gY5iNZOZaZ7ClDEOA4Y56iXQeoeml8XhtqAGR8G2XbML/2nO5DZfga2kT0xTyWFCk+
 W32wIqK4kN0fH+QnGpRY++Mrge2jqcF/v5GBzvqz8+8tizRrhe1KaYBBYBDdlKRbvqAh
 saYBCnVEjtVqIiQA1Y0IYTA2h40uog8ja1t2HMb1w3depY3HZcv4pG0n9DzssvktT6IV
 VQzw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776815785; x=1777420585; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MB2fW1rCVypTALinFvQ+9bLmI+qyoaUiQbMKvRMVzfs=;
 b=p6jt9vbqAaMHU2rFaAGc4PpZLgMMwFMF8Fl9gzJ3ad2Wlid2Ca40O2hfKaYV++Am3j
 TqLo8Zv8/9/Oi+hbGzF2b8VvONFGa0nT0hAWSm9sh8MqWd+Ca9WUcP5zYtUlqN2SZEyg
 WJKv9IXO+CJp35FG57q856V4NDO4+5SqSY5Qr993HtqQE5FR8ZO80/TrGeHoSpgxS9FC
 uG0W3vaLt06D4zTWr8gpb5JIIOTGW5o7s/OBCBbqPKDVW3JRR+TRyKh6tISzjjWPoEjj
 L/QaRzTsd1nuqmJJQEnCMU0XegtV7oHbkbf8tyF8Nn1amQi2NvkQWoeJRRTar65hXMhZ
 o1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776815785; x=1777420585;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MB2fW1rCVypTALinFvQ+9bLmI+qyoaUiQbMKvRMVzfs=;
 b=q1mHJ8sxcUnUTOI6g9rsFCtrl20OHXmpssm/r4EvhW1vlNF3NhyWBlySP7ckWdeiho
 wbzyNOSEAlKTnXBXrBp1e+JjedDtgQB7h/RikpHeXzzYvGMId1OWq7D8faQ1/PQMJ8kZ
 8G4eGrKhylhEjJcls0vaB6+a32+zcDR4eWjccRFr6PGtjJtaLy8VPInJjZ3GOt7VJLRm
 OLlcTbRxQa7755kwEpMjfjaXuduKPYRHl9RyyDzp8PiJk9dnuziCsGkxHSdM36sqkKNg
 5FT5csm5y1eXqL3sx7n704BZw351MFaaGYmusiMWlu3yRDq8u66msSOCSBO1r8My8Oga
 5usg==
X-Gm-Message-State: AOJu0YyjaLeQ4iMBvE11i+l9oeyvucP9tB+D4T6d04hv2uAFu53kvOqz
 oIACcjhjB+K4z+R8FpY6LeiCxP88Fm6CmZhOcNcBmPQrkbrxUR1SI/B3+m2OPHPf5qpEE6ozWeR
 VFFI1mzAqaAwchjTwtz1a8hfFFuN6ukU=
X-Gm-Gg: AeBDies0z/f+/pLhAE0BJSglspdcYPzKh/C3TpCgq2X+OJw2zrr53FKZxIL/BAxm6gO
 MTPmaWf6OJTd4lycvkgH9K5MWb0Dl6MG3dDJnHvqeLcBI1kxufMrzb4GW2VE/MMG7+CbRtNcb3P
 81lDKClLCDv4JA4H4B8blNyfoc5YsRRb3TQCR1qqHlJh0TZMEXtEz+LLmIhAuEd9OxshxEEu1wf
 xlYD6XVoMjy/3YzhpefHIR7ynJTrI2oZ3LvPk3bN5NoJYIBgHfHIzJxC1ZYzCpjwefhB/To4mMb
 asXmEa9EBv1Bbl1VjHG2HRU9qEFG8Hat3RnqOVM841ARrsABHuI1Jq6VUvQ=
X-Received: by 2002:a17:907:e0d8:b0:ba8:a21f:9c4e with SMTP id
 a640c23a62f3a-ba8a22ee915mr287367966b.11.1776815785074; Tue, 21 Apr 2026
 16:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260421071107.2848439-1-frank.chang@sifive.com>
In-Reply-To: <20260421071107.2848439-1-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 22 Apr 2026 09:55:58 +1000
X-Gm-Features: AQROBzDnVRwnbiL6MfbIoplg9MHUpMZbpWqmQOy_j4GtrmPEXNx0VVWKsM_gpwE
Message-ID: <CAKmqyKOEc0xzWXn+m9Hv3NBBu1_t7y3hWcA3m2JAd0LhzRyFGA@mail.gmail.com>
Subject: Re: [PATCH v3] target/riscv: Initialize riscv_excp_names[] and
 riscv_intr_names[] using designated initializer
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Max Chou <max.chou@sifive.com>, Nutty Liu <nutty.liu@hotmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Apr 21, 2026 at 5:13=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> Use designated initializers to initialize riscv_excp_names[] and
> riscv_intr_names[] so that we don't have to explicitly add "reserved"
> items. Also, add the missing trap names: sw_check, hw_error,
> virt_illegal_instruction, semihost, s_guest_external, and
> counter_overflow.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Max Chou <max.chou@sifive.com>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/cpu.c | 89 +++++++++++++++++++++++-----------------------
>  1 file changed, 45 insertions(+), 44 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 72c6f4f0f14..ce15a17c37d 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -328,60 +328,61 @@ const char * const riscv_rvv_regnames[] =3D {
>  };
>
>  static const char * const riscv_excp_names[] =3D {
> -    "misaligned_fetch",
> -    "fault_fetch",
> -    "illegal_instruction",
> -    "breakpoint",
> -    "misaligned_load",
> -    "fault_load",
> -    "misaligned_store",
> -    "fault_store",
> -    "user_ecall",
> -    "supervisor_ecall",
> -    "hypervisor_ecall",
> -    "machine_ecall",
> -    "exec_page_fault",
> -    "load_page_fault",
> -    "reserved",
> -    "store_page_fault",
> -    "double_trap",
> -    "reserved",
> -    "reserved",
> -    "reserved",
> -    "guest_exec_page_fault",
> -    "guest_load_page_fault",
> -    "reserved",
> -    "guest_store_page_fault",
> +    [RISCV_EXCP_INST_ADDR_MIS] =3D "misaligned_fetch",
> +    [RISCV_EXCP_INST_ACCESS_FAULT] =3D "fault_fetch",
> +    [RISCV_EXCP_ILLEGAL_INST] =3D "illegal_instruction",
> +    [RISCV_EXCP_BREAKPOINT] =3D "breakpoint",
> +    [RISCV_EXCP_LOAD_ADDR_MIS] =3D "misaligned_load",
> +    [RISCV_EXCP_LOAD_ACCESS_FAULT] =3D "fault_load",
> +    [RISCV_EXCP_STORE_AMO_ADDR_MIS] =3D "misaligned_store",
> +    [RISCV_EXCP_STORE_AMO_ACCESS_FAULT] =3D "fault_store",
> +    [RISCV_EXCP_U_ECALL] =3D "user_ecall",
> +    [RISCV_EXCP_S_ECALL] =3D "supervisor_ecall",
> +    [RISCV_EXCP_VS_ECALL] =3D "hypervisor_ecall",
> +    [RISCV_EXCP_M_ECALL] =3D "machine_ecall",
> +    [RISCV_EXCP_INST_PAGE_FAULT] =3D "exec_page_fault",
> +    [RISCV_EXCP_LOAD_PAGE_FAULT] =3D "load_page_fault",
> +    [RISCV_EXCP_STORE_PAGE_FAULT] =3D "store_page_fault",
> +    [RISCV_EXCP_DOUBLE_TRAP] =3D "double_trap",
> +    [RISCV_EXCP_SW_CHECK] =3D "sw_check",
> +    [RISCV_EXCP_HW_ERR] =3D "hw_error",
> +    [RISCV_EXCP_INST_GUEST_PAGE_FAULT] =3D "guest_exec_page_fault",
> +    [RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT] =3D "guest_load_page_fault",
> +    [RISCV_EXCP_VIRT_INSTRUCTION_FAULT] =3D "virt_illegal_instruction",
> +    [RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT] =3D "guest_store_page_faul=
t",
> +    [RISCV_EXCP_SEMIHOST] =3D "semihost",
>  };
>
>  static const char * const riscv_intr_names[] =3D {
> -    "u_software",
> -    "s_software",
> -    "vs_software",
> -    "m_software",
> -    "u_timer",
> -    "s_timer",
> -    "vs_timer",
> -    "m_timer",
> -    "u_external",
> -    "s_external",
> -    "vs_external",
> -    "m_external",
> -    "reserved",
> -    "reserved",
> -    "reserved",
> -    "reserved"
> +    [IRQ_U_SOFT] =3D "u_software",
> +    [IRQ_S_SOFT] =3D "s_software",
> +    [IRQ_VS_SOFT] =3D "vs_software",
> +    [IRQ_M_SOFT] =3D "m_software",
> +    [IRQ_U_TIMER] =3D "u_timer",
> +    [IRQ_S_TIMER] =3D "s_timer",
> +    [IRQ_VS_TIMER] =3D "vs_timer",
> +    [IRQ_M_TIMER] =3D "m_timer",
> +    [IRQ_U_EXT] =3D "u_external",
> +    [IRQ_S_EXT] =3D "s_external",
> +    [IRQ_VS_EXT] =3D "vs_external",
> +    [IRQ_M_EXT] =3D "m_external",
> +    [IRQ_S_GEXT] =3D "s_guest_external",
> +    [IRQ_PMU_OVF] =3D "counter_overflow",
>  };
>
>  const char *riscv_cpu_get_trap_name(target_ulong cause, bool async)
>  {
>      if (async) {
> -        return (cause < ARRAY_SIZE(riscv_intr_names)) ?
> -               riscv_intr_names[cause] : "(unknown)";
> +        if ((cause < ARRAY_SIZE(riscv_intr_names)) && riscv_intr_names[c=
ause]) {
> +            return riscv_intr_names[cause];
> +        }
>      } else {
> -        return (cause < ARRAY_SIZE(riscv_excp_names)) ?
> -               riscv_excp_names[cause] : "(unknown)";
> +        if ((cause < ARRAY_SIZE(riscv_excp_names)) && riscv_excp_names[c=
ause]) {
> +            return riscv_excp_names[cause];
> +        }
>      }
> +
> +    return "(unknown)";
>  }
>
>  void riscv_cpu_set_misa_ext(CPURISCVState *env, uint32_t ext)
> --
> 2.43.0
>
>

