Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2105C47DDF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 03:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSqIH-0008Nc-4Z; Wed, 24 Jan 2024 22:20:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rSqIE-0008NM-HC; Wed, 24 Jan 2024 22:20:42 -0500
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rSqIC-0008En-Ad; Wed, 24 Jan 2024 22:20:41 -0500
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-783c059f947so1580385a.2; 
 Wed, 24 Jan 2024 19:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706152839; x=1706757639; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pvirMcC0hBciY6HwESsOtqownbHaHzsBg2eVAppkNic=;
 b=asFHhr558/gfYx0IjTuCdTVL2amI1YtPLtFikVwK4VYl+gBzFsQje245cqpSji0Loz
 cUVM/lBdVvFeRB7cCJ5Xdr/Yl93bSOYWTwcOVydjXSnLdo8sIy8ioyecJkqkuNUfIUSd
 cYY/VOdtD34JmiGrLbGseeeaS4Fq0CpcWlgQQ0Q0q1nf07ob9yBPVMCLeKJQdiGB9G7j
 xPiOxqdYKzBIR0cjKogfKUZtyuONNP4bt117Y2utM5rY1jt+d1Kb0PQxoCymt3eZH2f6
 Vkh7JTazBFxk0fQKc8jJXnjdnuEeOFNCvy80Sq+ukF4Ut6iEs7r9EjjyiTaiDtsKZuYi
 AZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706152839; x=1706757639;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pvirMcC0hBciY6HwESsOtqownbHaHzsBg2eVAppkNic=;
 b=RWbkqHAMvtJ6cpJ74oJIFv/qDXaCbI68mX+NwNIOx6xItIHiOhSext/5pv1Jrkr+O6
 NllAX7aLDxcD7jwtJ7lhXiD/WB8XyZ84qm+nwhVo2prEvlEGsHIOsJPfCnnSBTQIu2RS
 P6FmQ408bO7TziSfOZlVstBqGd3vFQ68trqzuBtW4cokHnbOjmZGQphkScfeO9pppJtF
 h2mzkG6CENno0by04ykO19u1SszVWIKoKpddygbJQtdeVn0n9+lvlysU5TIB8rAUewps
 6YyagxSg3hd0cly97co1B6s4LmKCFhJPCuSFHSJHfExrQFANVoHrJ8IipEIzZpCMF/yR
 31Fg==
X-Gm-Message-State: AOJu0YxutjCPz+jOWTrTtSXJedTCa3YpsW9k6iIGofjRS2MjmvuEAjOy
 UiFRi1Gr0uPH71qbEeUSgMk/ChgFaC54F2/FZ51+yX7im/Z8KVymiGY2sG6GP/b7swLZMRun5wp
 tEDX3CgQxRvzQI7iV0SY7nITrVTg=
X-Google-Smtp-Source: AGHT+IF8en6yIQ3nUMgMuHO7nvCy0cTPRqawc6iTSyaayBQqyp6wmRLLduRb3k5p4TBmwCdKKF2mL4gGpJ5Bl0TAU9o=
X-Received: by 2002:a05:620a:4441:b0:783:363d:74d4 with SMTP id
 w1-20020a05620a444100b00783363d74d4mr584342qkp.104.1706152838868; Wed, 24 Jan
 2024 19:20:38 -0800 (PST)
MIME-Version: 1.0
References: <20240123161714.160149-1-dbarboza@ventanamicro.com>
 <20240123161714.160149-2-dbarboza@ventanamicro.com>
In-Reply-To: <20240123161714.160149-2-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 25 Jan 2024 13:20:12 +1000
Message-ID: <CAKmqyKP7-+qcr451XZE==W4PYmBMqTphk2sGNaC8V-pTkEuOzg@mail.gmail.com>
Subject: Re: [PATCH 1/3] target/riscv/kvm: change kvm_reg_id to uint64_t
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=alistair23@gmail.com; helo=mail-qk1-x72e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jan 24, 2024 at 2:18=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> The field isn't big enough to hold an uint64_t kvm register and Vector
> registers will end up overflowing it.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/kvm/kvm-cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 4dec91740b..902180e8a5 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -145,7 +145,7 @@ typedef struct KVMCPUConfig {
>      const char *name;
>      const char *description;
>      target_ulong offset;
> -    int kvm_reg_id;
> +    uint64_t kvm_reg_id;
>      bool user_set;
>      bool supported;
>  } KVMCPUConfig;
> --
> 2.43.0
>
>

