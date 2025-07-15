Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745A3C83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 10:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubcVs-0006fT-3s; Tue, 15 Jul 2025 06:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <apatel@ventanamicro.com>)
 id 1ubcVd-0006bh-PU
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 06:03:37 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <apatel@ventanamicro.com>)
 id 1ubcVb-0001WI-Sg
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 06:03:37 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-553b584ac96so5234903e87.1
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 03:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1752573812; x=1753178612; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2xjQmuDCGdjXJTbqeZ26m4iepUkkU+JnpxrcriQakXM=;
 b=NJ6g7mldkYIiTbFvnfcxxExdGHdtxDcAeH4NoouJj9mc17G7BDW44Ke/c5dQpnNXA1
 Lb1i1Wiofpv7Kp2krk7eknlzKZLUha3AfilyrlZlQ0nbXdy6syBldysv7K95GwnWMk3c
 Ft/P+EMX+402a7+jrrnF7453SclbbwAr3zUmeKQrPCo1+uvEAOnmp/owUZMRpsJ3WBX5
 qdldf7wUhIZqe68BymtkqjPGCZ9tqkKdIMz0KLLxU7MtcSp+fnLUibYDgH8Im7padF7O
 VeoeMHP6cO4mu/bYR34Ftpidz1b9QLsTDE4Cmf99KTJYwnEMzkKOtRD9wrtmaUSYS/DZ
 u09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752573812; x=1753178612;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2xjQmuDCGdjXJTbqeZ26m4iepUkkU+JnpxrcriQakXM=;
 b=N1CQ4ZQmoFlalb1MA4ty1lqJAa3AEBMp48wST5mcoq9YGnD/NexEMoc1nQ+okN8zGU
 CH8jpu8j5I4F9XYHD58BzHqqMMDEEYn8XktInY/9XXdQX3s77VuQ0JpZbyr+pmNVBpZO
 wbgN38N2ytDJwudrCL4sZBnXKxoHJ7U0TDxJ1wBo69pGgITq1Wfa5N8P5++8VheJH/mm
 /s4QFxqP+wNb70T1ifRSue/WBNkaSwF9J6Poc7RnJF2p+KMLudF5zD33XE9nnGrTO4Cj
 WRcBCxeKWnE5tAVf312vM0TyOJizVJNuFGieSTuekIDrNknqnXuE+kR1Tia2hoB3rt+V
 fwrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHIS8HuN7xmqeBcxTHZ8J+w6Hifli8TCPTnr5S1PRoRfV1IiQJXrGEk9ridzaO/bSRvFhWZQ+k0Exn@nongnu.org
X-Gm-Message-State: AOJu0YzA4SY/h/P4StBeu6IHSXffTzAgIbxiYrZecK/n0G0cO0sgB51x
 Y+PUiTZsbNDNFT/ZoqXykJ6OFWTDlo3VlQdf309N38uR+yUuRIi8HqfjYpI284rwGIOxntB51Wq
 40zfqEl/u+qJbp9mNduZ0qKSeUOYwYiUoZofroZKZAg==
X-Gm-Gg: ASbGncvO4U8zzyvqCW/WbqWtOOkmkSG3ofF0kNDAmXPvlsfTET97JSAashF9YuKgu59
 KpTZZJYhlBadBVRJwvjxVlGElLZXuBhj357z9k15aPcZ+I8zzupPxedqOTXaTTF2MnNsdgZdQ65
 gh4kJWlM/wesfbkpXbrMRmiKnuDGOqtfjtTJ3IpSVDm77lj3eYxDWc7YPdtO8OwaZDLIC6B2jC9
 yvfPZZn
X-Google-Smtp-Source: AGHT+IFXLT/YIZudceKXxU577T8aQrk7qew1ipDBKwaHY1bg2iIe0I8LJJDGnk5r+vfLTBC7YsxthAc0xYjwcoLNxS0=
X-Received: by 2002:a05:6512:b9b:b0:553:2c92:fdcb with SMTP id
 2adb3069b0e04-55a057c3c43mr4851000e87.3.1752573812309; Tue, 15 Jul 2025
 03:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250708060720.7030-1-luxu.kernel@bytedance.com>
In-Reply-To: <20250708060720.7030-1-luxu.kernel@bytedance.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Tue, 15 Jul 2025 15:33:21 +0530
X-Gm-Features: Ac12FXxx34DKhRmAxeDmKtKcGhnGF01dAkjBDQu1R7v66kLO01ZB-2f8U4Xrw30
Message-ID: <CAK9=C2VzaAyNS8fLNJS8wMF=wxRtWBX1_G1xw9=WPnPVYG99eA@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Fix exception type when VU accesses
 supervisor CSRs
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=apatel@ventanamicro.com; helo=mail-lf1-x12d.google.com
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

On Tue, Jul 8, 2025 at 11:37=E2=80=AFAM Xu Lu <luxu.kernel@bytedance.com> w=
rote:
>
> When supervisor CSRs are accessed from VU-mode, a virtual instruction
> exception should be raised instead of an illegal instruction.
>
> Fixes: c1fbcecb3a (target/riscv: Fix csr number based privilege checking)
> Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>

LGTM.

Reviewed-by: Anup Patel <apatel@ventanamicro.com>

Regards,
Anup

> ---
>  target/riscv/csr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 8631be97c5..9bebfae3f0 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -5577,7 +5577,7 @@ static inline RISCVException riscv_csrrw_check(CPUR=
ISCVState *env,
>
>      csr_priv =3D get_field(csrno, 0x300);
>      if (!env->debugger && (effective_priv < csr_priv)) {
> -        if (csr_priv =3D=3D (PRV_S + 1) && env->virt_enabled) {
> +        if (csr_priv <=3D (PRV_S + 1) && env->virt_enabled) {
>              return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
>          }
>          return RISCV_EXCP_ILLEGAL_INST;
> --
> 2.20.1
>

