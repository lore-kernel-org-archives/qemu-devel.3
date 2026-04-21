Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B55F94CB9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 23:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFKk3-0006iV-NT; Tue, 21 Apr 2026 19:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wFKjy-0006gW-Io
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 19:42:51 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wFKjw-0003o8-F7
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 19:42:50 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ba9ad0fbc3aso173774166b.1
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 16:42:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776814965; cv=none;
 d=google.com; s=arc-20240605;
 b=ezqFcvlnfKgYB9DraPVLJkYfkagDAFTvt1v4b7rCxDOdxpgMqGoB7C3dlo5ygiwca/
 LPMaznYopf9kv7XCWy2Pm+Fd8EJCBdYGYI5tOsFkXYdu+Ns9SScaNWN7L0FnYZImjx9+
 8ZCC+ysNs3/LP1h8JWxV/Pplgi25WwIuZQf2cl/+IUqdUCSJS6IjtZz8WC9WowetrliP
 dyMHqMFsetzWQkOfk25V0VJDPlR6zNw5rumNfDlXZy68iKwGPI5HLwzfstHYjYrGD3pr
 TLdHp4PbPiAWbnC65LoboVu/vZ6EohwXT8BUBT7zwkKalC2YNTZkiAtNaLCfZ2JYPV+R
 etQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XzqJz1cP7mVlX8FRkppuKd6Cj5Xcwv1zX/EIiXqsaQ4=;
 fh=X79f7cC6joFjXa/GVENRWCGALOpkuesxoGuQ2U82tIg=;
 b=TFzgvr+elwx3WQOYE7w2CQF4acscSPiWwa5gHkG/MhiYsvy49W10or9Olp2+9KsPcR
 GVtwDIXZ0k/xxwkQLQZ2gEKHpEPoo3IkNf8Vf3cccBufd4RcOMy9X1PTp5qDiSXmPeKK
 F0EMW0WGnWb3tAknOd5C4l5myRFOCT0Jygac5LKS0Kukq/D0N2D9sTG1OlPZvklVe22r
 dX8oyjwn+xol7lq5P8pEmQSbJVXMPAcAVOicciZ29xOKm5F2iYP3o2rfkej0H1oKHNFT
 CZbs7ue+xZkultxSRTc+JTeYYsltygRqPF33pHyGiX6PfDh74rOvbtqhucGTvDjiJCsp
 HMdQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776814965; x=1777419765; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XzqJz1cP7mVlX8FRkppuKd6Cj5Xcwv1zX/EIiXqsaQ4=;
 b=b/NOLL8dUtkpbCIADlv1cEDRE63xvAhHcazoA0kqoXFsveNNxR7qB5+fhFx4orRiEH
 ELmJ3fSg13cpn1MiZ2AvfWSw+1+jCSnL8PTd67TKIrBgcOvArqh1WA8e9bJUQ3ms2PWo
 neIl4tsLCd5Y/cZARmRggf0qsMBWRJ1EjpMi5yvZ2bXp0b4iBPkQs0Q/ddI+Uk5kuyu5
 p49nryYMEbA8uui1ifVxm58kgENkWmEmfHHYMz3Kvu0qCnVa/bb1vEDpE//volW5K8If
 r8W8MUZuLZOqZFKSOLuenLfMqbvk1O32unJnnhiQfJENY5NQ3i68EN0iwzcCsf+d/tbo
 j94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776814965; x=1777419765;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XzqJz1cP7mVlX8FRkppuKd6Cj5Xcwv1zX/EIiXqsaQ4=;
 b=d+2HD8X3vIz4pTrxUfcezlnyJdXqjbzbgHbyapIBs3Qi4ykdT4JLR233TXDSproboA
 Yyp8mOVg3un8sQruq0+p1udiCsX9Bkphz7oV50TRmW/b9HXR6iuZn5eqG+3t79ciK1es
 rvmxdgRoSFPVPOHZkLVqC+vdl0ChO5eqmPBtoR2KEyLHi16KTvBFq2/1gG3TBGlVg3Rx
 yHPfNGVU8XKRDXGXczL2rq0rFjl3+poRxxg0vkdHpyyZQ3APbDS6RWDX8A6dwl95B+Go
 j4C0VkV5JAr/umaScWts0dGmPIZSBe8QGU8+YMR0x+UB+is2MY13TaZE05XsI7a635RY
 e2wA==
X-Gm-Message-State: AOJu0Yyc3wm1IFW7U3TfLY3mygVhhH4/y2Ku16Z1NA8blGAvNZ9+rEE0
 akryRnvYd8lfedeefDIE7CNPzrX+LF/tByjwgilVf6hulUYP28GuwDD90MEF/4F7kP1ASIBuHt/
 Cz+leOknZ3WBGCu3UpuKvef4v+K8R5pg=
X-Gm-Gg: AeBDiev04VnVput64xzzMCDGjIMfM+O9IK42cxi2hP09GOlnD0swqgTdcaS+n+kD2of
 zSEeWNZ9mV4h9Zd7yQs/Z7dP7bjBYRN25exkOjLZOy4D8cCx8wYZNoxngeEd7M0NHVZvGelnkd/
 aZcWO5i9T4arlFiuB2ziJpu7GupbsIJ1gdWGWdldn05Axn8YubOxqq216iSfHvCPsisTFBe7MeM
 D2L3VUVvBRDoYhVaHX3gf9UVbpv6288fXu+aByI47b7F5OR09MFZ5wk2ubN+GxcJNAhoBNT5a9N
 gDwoA8tH2OlUKQA1tmxe63f4yt2kESa8AknMVw78WYiQnopE
X-Received: by 2002:a17:907:c996:b0:ba3:5d15:502 with SMTP id
 a640c23a62f3a-ba41898300emr705775866b.9.1776814964867; Tue, 21 Apr 2026
 16:42:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260421071107.2848439-1-frank.chang@sifive.com>
In-Reply-To: <20260421071107.2848439-1-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 22 Apr 2026 09:42:18 +1000
X-Gm-Features: AQROBzAZGAQ5k5eIl1bTD-53Zu5Wcx1rmyVLzC1oCM9tWVYuP881CwLqrpLl7Uc
Message-ID: <CAKmqyKMgPQ7cVod2JAjs7SURrZkHCGbvmygBUZ3=j2P-Cu=-Ng@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x634.google.com
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

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

