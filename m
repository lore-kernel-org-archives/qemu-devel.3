Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F75C3ABC3
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 04:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFQZz-00025f-41; Thu, 15 May 2025 00:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uFQZx-00023y-Sf
 for qemu-devel@nongnu.org; Thu, 15 May 2025 00:52:21 -0400
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uFQZw-0002RO-5s
 for qemu-devel@nongnu.org; Thu, 15 May 2025 00:52:21 -0400
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-525b44b7720so166794e0c.0
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 21:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747284739; x=1747889539; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MBQuF8Tc5wzOQv5t+abVND2//mmOWlRf+pyDgCrE/eQ=;
 b=OKTyWt6ZGHT0pFmxsvY2/g2wWPudFkkvwOVhYYpegPlikNUAhQKFihIb9eUIjfWFq2
 DrPE7DvAFjz21PJyI5SIEWoRiKPHwy1ZKcN2kgAU2OHkLVF3vfZUVaqgB67LRmfxTFYA
 bYJtRBN4QekYJ40jN3XDypH0ESY1NqUoIAmE4dwsyiks3Dljb73LCfnvofN2swUMEFfs
 N7UxRPEZxcJPmXbe98+o0GlafBlSXFp7/8uz10k/0Itc7o0zeJCPJahwRuBoOQYnSFLw
 l02FcO/FBjffcb+UG1aRlW6eGAtAz0Y0W1/XLD+imliTSLtc/9MmlSsEUlAHzeEIpIlB
 xfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747284739; x=1747889539;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MBQuF8Tc5wzOQv5t+abVND2//mmOWlRf+pyDgCrE/eQ=;
 b=HD8eJLLaaoZPG338hwI+QjFV0GI4wbEIDxCrmhOo7jrITlrRVucaO9X0GRulPBVFOj
 HT0G4Dr4/3ZPpHGV6vnozVlVQUjyZebRaN/RGrm8A9mfYwFLYJ8Wf2WkhDSEZOxSWu0s
 SH/ZYxihJo/dHfkZl1skKzUWo3pBAMhaWxzPeVd2ByYYt5A1QyOvsflqG5m2yl2h6RkX
 CzUXA6LAlMFgKxj+0+0U5NnAWRvWh8pp2trFu8cNyDi7x5JSsvvpWhtRtfre6SxKXXfT
 RU+gHHnochc9hbeCjWQayyhrJzE/fTTKoGmJ8yJgQoJh2T7bCJ5LW1G8ZSCBCJxdYeAp
 5d0w==
X-Gm-Message-State: AOJu0YwgWsSrfCoCbv9+qpvi91cGHl/P8KxW60pEaTJmhbFUP3LLJeif
 pCS9G2vGXQKqshEW7WfJb94gqj3Y3NCizp/BTqLIRHCJh1PKI6ZRCNHinZ0chN/HJS0KW4jCTYU
 7ZY8dWTyMGpt6D/GIzQpLjmvBZ0w=
X-Gm-Gg: ASbGncv9TdfH647VotKdHbKh2jmz7l1MXiVk0gPFySShhHL3ckTkEx7jqMxuOCXghdh
 T8dAuQVyJx1NyY7/1HEmmWsAbjwxWWshxiGSXDxMt1wSy+kifcWFrSVU327vBB0nRC6IM7/rRyO
 sWD3JNAvXguHieUAQy++OxXyq47EyopKQ18BwQyicqj0hyqDW4qWY8GggEQT0yXbQ9HIa+5Rwcs
 Q==
X-Google-Smtp-Source: AGHT+IE3QS86BGv2Y4uxRGopBKwu1zBaXLX8SKSO44MDHSn98Ulp9fXlmrkyFjsZB/M0TWlnkY4Ht3V2VSiU+ZGGZPw=
X-Received: by 2002:a05:6122:8298:b0:528:f40f:347f with SMTP id
 71dfb90a1353d-52dabcbd04emr794624e0c.2.1747284738858; Wed, 14 May 2025
 21:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250512095226.93621-1-pbonzini@redhat.com>
 <20250512095226.93621-11-pbonzini@redhat.com>
In-Reply-To: <20250512095226.93621-11-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 May 2025 14:51:52 +1000
X-Gm-Features: AX0GCFsUTQhpvPcRt_7FfTMe9M_wvhZAXPFmqK6DlyfemzJfy4roP-GSGKovlyw
Message-ID: <CAKmqyKNerB8pxFEMJHpFVfAuSY_VMi=OCJT_wyMvH_=UDF9-hA@mail.gmail.com>
Subject: Re: [PATCH 10/26] target/riscv: include default value in
 cpu_cfg_fields.h.inc
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, dbarboza@ventanamicro.com, 
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a32;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa32.google.com
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

On Mon, May 12, 2025 at 7:53=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> In preparation for adding a function to merge two RISCVCPUConfigs
> (pulling values from the parent if they are not overridden) annotate
> cpu_cfg_fields.h.inc with the default value of the fields.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_cfg.h            |  2 +-
>  target/riscv/cpu_cfg_fields.h.inc | 22 +++++++++++-----------
>  2 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index e9bf75730a6..aa28dc8d7e6 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -23,7 +23,7 @@
>
>  struct RISCVCPUConfig {
>  #define BOOL_FIELD(x) bool x;
> -#define TYPED_FIELD(type, x) type x;
> +#define TYPED_FIELD(type, x, default) type x;
>  #include "cpu_cfg_fields.h.inc"
>  };
>
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fie=
lds.h.inc
> index cb86bfc5dc3..59f134a4192 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -2,7 +2,7 @@
>   * Required definitions before including this file:
>   *
>   * #define BOOL_FIELD(x)
> - * #define TYPED_FIELD(type, x)
> + * #define TYPED_FIELD(type, x, default)
>   */
>
>  BOOL_FIELD(ext_zba)
> @@ -153,18 +153,18 @@ BOOL_FIELD(misa_w)
>
>  BOOL_FIELD(short_isa_string)
>
> -TYPED_FIELD(uint32_t, mvendorid)
> -TYPED_FIELD(uint64_t, marchid)
> -TYPED_FIELD(uint64_t, mimpid)
> +TYPED_FIELD(uint32_t, mvendorid, 0)
> +TYPED_FIELD(uint64_t, marchid, 0)
> +TYPED_FIELD(uint64_t, mimpid, 0)
>
> -TYPED_FIELD(uint32_t, pmu_mask)
> -TYPED_FIELD(uint16_t, vlenb)
> -TYPED_FIELD(uint16_t, elen)
> -TYPED_FIELD(uint16_t, cbom_blocksize)
> -TYPED_FIELD(uint16_t, cbop_blocksize)
> -TYPED_FIELD(uint16_t, cboz_blocksize)
> +TYPED_FIELD(uint32_t, pmu_mask, 0)
> +TYPED_FIELD(uint16_t, vlenb, 0)
> +TYPED_FIELD(uint16_t, elen, 0)
> +TYPED_FIELD(uint16_t, cbom_blocksize, 0)
> +TYPED_FIELD(uint16_t, cbop_blocksize, 0)
> +TYPED_FIELD(uint16_t, cboz_blocksize, 0)
>
> -TYPED_FIELD(int8_t, max_satp_mode)
> +TYPED_FIELD(int8_t, max_satp_mode, -1)
>
>  #undef BOOL_FIELD
>  #undef TYPED_FIELD
> --
> 2.49.0
>

