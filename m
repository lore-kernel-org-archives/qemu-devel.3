Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9CC8FF886F
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 03:11:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIeHW-000677-C2; Thu, 30 Apr 2026 23:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIeHU-00066R-Hh
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 23:11:08 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIeHS-0000cH-Ed
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 23:11:08 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ba699316b42so225591866b.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 20:11:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777605063; cv=none;
 d=google.com; s=arc-20240605;
 b=ieKnSSgx/BkhipnnifQvhJPBPeG9yf67mn+r9cEnUcbWEBXPlFeikrRIw0sGjFhLl3
 BaDifvtLh4tkXkaVhWZ/qmI+fUJtkTOrBFZCZRsBfa2UYdzXZOT/O046EZDMXZ0y4T+9
 vTn3VIueRkh4D4h45a+FwTp9ZyfMV8iB6g7dvEXbu2GYYf+/B4rnOnxNs/JgHlPZ2VHO
 nZIUlZJZ0GTtbRk0iwv0UONAKTLtqgxP71vO44B4RAZgZyMECOnNFVWLKqaRkB47Gwjl
 /n1Plg8uwlZSDFN1SF5p1FI135QVj22DoRjw7Aeoj4BOQMcuIBJeJCtwTfiCqvtiUctd
 479A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cB1F79HbhefG7dQcP6hshdVQr+A+ou/V8zX3ebFsuD4=;
 fh=I21oKyNy4Il063R1ym5YZ0eyRc5zhdOlCZYXtgX0pn0=;
 b=K2lkQ3Kh7eNUhJXPtSGirtGxicvJochSrQyFYeDz+11VpC9q/zC2medZeNxxe0HxrU
 y/rX1Pzc495URY8VZJRxuSaJVev99yNZZsbI2A9kOUe75NuZUiVBGtJt5NEVheGmmUGK
 UKzmMK/jfLFYB4jX9jdrM1cmcswbi8rKLbZV0nBUxnjzceOQj2NhNxkeZXqDHUhBdijK
 iasIaq9U5W45XsiMzF82XjM4gk0rGfJbORONyVBi/fWCnz45ZQQut9iTw0I7BYIzcw5p
 tijZoEaC8CA2AI0QJSDFFroAmjej7VadX8SJgJgLbJqv0zLewQYkOZ0jr3UM6oVvELRY
 wlLg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777605063; x=1778209863; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cB1F79HbhefG7dQcP6hshdVQr+A+ou/V8zX3ebFsuD4=;
 b=ESsiR1rqchJjb8kvd2cuv6AwZWeZ2ufUOoSUGrh1mUiSos/aVfWD64/HfElrbZUy1E
 IBKxijCBJ2VFmqHd96CNE2/AGIqmQ+3rCx/2xcd2XWxpWzzCONg4DaAD0DPMKAyp0mfc
 sjo4s7Ugyc/PUM79SWcF0nPI3wxMJ1+MxwE1grJFQvfOd6hYe+igTxv2sHiLpzU0sMqm
 VuYQF8xlUsUfNAu3VHMtvSWg7EFqc4fNcFrWvBOFfrwJv4OmjFmz/wMCGzA2E0FzRxog
 0LR9VYRpqIqWJwX8WQJ0C96cCjociZrOGySfLA8Z3YxKBLQlq6hd6aqgGfByxMX9fVBv
 koUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777605063; x=1778209863;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cB1F79HbhefG7dQcP6hshdVQr+A+ou/V8zX3ebFsuD4=;
 b=QVYyDGmbjIU/ppZ/vqMprLHuxxmMNJPDAbId3Z9fgb4NATshsQGFdN7T2QD45TfTB3
 oOP5tPXKAUOZaDaeq3wD38gubiG/XrlB5Q32XFpW54OM2NlRDzJzAw4ZVuNBdUBMRov7
 hNFQaIFPvNgJcksaasEIlYusscWKX+k2occ/P1saVn87ScRTgSarLzPMvN3cpZCgfMkI
 PT459BJ+8Avs9OK1g844VC/PPbFn/cK6Gx5dKTtVJmlYTqbKJ/DFhFeGzRW9jRO1vr+G
 0M5IXmQtaavZad5UZ3e66xxo74OJwi2ITd0t9EqtiPOzuIUZF2vnqzBfqHIqbfDB0eWB
 1KPA==
X-Gm-Message-State: AOJu0Yw9YvSq9NyKk0jY4tx/Xc9Q/7b5gw1JYXwM3Bs5CO258YE61SlD
 bj2UVyTBJxSyaQeh3tD3qvAS0G9NJreReJpb0Eoq7sulxlumVnKzImqqpt6iHVRwSpJ0Fh2rxJ7
 nmmg2JwaSJBPXhysoS+vwxyPLWEUsP94=
X-Gm-Gg: AeBDiev6CJs3A3AFaT6wsZxfgHDiKFu4b8g+igjhPtwtg/dJXX0muac/SPoCS9ao9Tg
 rF+3c2XMzAoL+Z17A4nbvNH8HMfBf40vizrIHB23frEJGIvuoWZUMwM0+WaP70+LNrqroWsO4VV
 ronvPe5cJES0bCexuAwGu339fWR//IoEGMduske1t8ISfQWTbOMB6kv1NyReIDa1yCfurgjZmWd
 aQM9M4L9OkSHd/5KHVCWlbNpirLjCtBF9tti5fALRPwXY5PWlPAWG/SFny11uZROaVYrl6cYWex
 Sis3CR1Cyoo6cw8/LOb/Dfw8l1PoavVIxgHl2q16hxMheaV0oTzgPdRUdFw=
X-Received: by 2002:a17:907:849:b0:ba6:1412:9326 with SMTP id
 a640c23a62f3a-bbac67a986bmr358036966b.19.1777605062941; Thu, 30 Apr 2026
 20:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260424191129.1494381-1-daniel.barboza@oss.qualcomm.com>
 <20260424191129.1494381-3-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260424191129.1494381-3-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 1 May 2026 13:10:36 +1000
X-Gm-Features: AVHnY4L-kHkK_2Ye22PtAf-SpQ-DwinnWUI_tj549cUFAo_3gJhe3Am1IbR9Mmk
Message-ID: <CAKmqyKMmYewFC+nJtnwboapFZq_395kk9KeO3_zoC+WMpZfcyg@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] target/riscv: Add server platform reference cpu
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 leif.lindholm@oss.qualcomm.com, Fei Wu <wu.fei9@sanechips.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat, Apr 25, 2026 at 5:13=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> From: Fei Wu <wu.fei9@sanechips.com.cn>
>
> The harts requirements of RISC-V server platform [1] require RVA23 ISA
> profile support and others.
>
> This patch provides a new "riscv-server-ref" CPU to go along with the
> future "riscv-server-ref" board.
>
> [1] https://github.com/riscv-non-isa/riscv-server-platform/blob/main/serv=
er_platform_requirements.adoc
>
> Signed-off-by: Fei Wu <wu.fei9@sanechips.com.cn>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>  target/riscv/cpu-qom.h |  1 +
>  target/riscv/cpu.c     | 11 +++++++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 30dcdcfaae..a150acd151 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -42,6 +42,7 @@
>  #define TYPE_RISCV_CPU_RVA22S64         RISCV_CPU_TYPE_NAME("rva22s64")
>  #define TYPE_RISCV_CPU_RVA23U64         RISCV_CPU_TYPE_NAME("rva23u64")
>  #define TYPE_RISCV_CPU_RVA23S64         RISCV_CPU_TYPE_NAME("rva23s64")
> +#define TYPE_RISCV_CPU_RVSERVER_REF     RISCV_CPU_TYPE_NAME("riscv-serve=
r-ref")
>  #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibe=
x")
>  #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
>  #define TYPE_RISCV_CPU_SIFIVE_E         RISCV_CPU_TYPE_NAME("sifive-e")
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 586683b28a..4b59dcabff 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -3401,6 +3401,17 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>  #endif
>      ),
>
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RVSERVER_REF, TYPE_RISCV_BARE_CPU,
> +        .misa_mxl_max =3D MXL_RV64,
> +        .profile =3D &RVA23S64,
> +
> +        .cfg.ext_zkr =3D true,
> +        .cfg.ext_svadu =3D true,
> +        .cfg.ext_sdext =3D true,
> +
> +        .cfg.max_satp_mode =3D VM_1_10_SV57,

Why not SV48?

Alistair

