Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8887FD2444F
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 01:44:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz4gh-0006Iy-Oc; Thu, 10 Oct 2024 21:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sz4gg-0006If-Tr; Thu, 10 Oct 2024 21:43:27 -0400
Received: from mail-vs1-xe2d.google.com ([2607:f8b0:4864:20::e2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sz4gf-0001xq-3Z; Thu, 10 Oct 2024 21:43:26 -0400
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-4a40afdcb95so538790137.2; 
 Thu, 10 Oct 2024 18:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728611003; x=1729215803; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MojceMVibMvQ1nODpYlDWAPIdfRbNthEGeRQJJgQdwo=;
 b=dJsDn5qegCSLS5pvrunVe0j2EwgR781jr6X6O0welOmE5kzppAd1qUYZNobNKTxmov
 i1nd1mqwjVxG474z1oufluqu/C9U2ki3SYT6vyz7YbnuGaFYJ1Mus39kfQvEdGOTof5k
 jmXCkQBIH3TiMMKwe9wp+IEKGmbh11kYsPZ6e7u10lnk6E2Mum8AmL/21Nzto4ML6lNt
 2gaCSumlrW8qwM52WuQlZOxm1F0b5xs5EvfOHmPM03Rp1xGPnJfpEwPR1q3Mm9TkYPgE
 drxxWLU9oQGrwftTEJ5auxqLtpVcLnY2EJrWQCVug8GQMhy5+MwqE0PXL/0bA6db/arl
 S7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728611003; x=1729215803;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MojceMVibMvQ1nODpYlDWAPIdfRbNthEGeRQJJgQdwo=;
 b=bNOfpVSDEh4IWXK+KUVrX2yGPtxBEqY1WKAAyac2UV6jyHRXkGdzlosqS+xuYwfqXA
 AzGrFO0zBm9Fg2w0TNpVxIO+fnSCotLDASiqNP03kaNedEMQmbEqIi9rU7Qtm87IPmkE
 ChAplSQ33pShdVI4CDpoo1J5BRshkI7cYP28WaomuSL/rbj/2brZbEtyFTxl4NPkUHQY
 DzXgek1H9qT+tNa9nzugqhlSRcMzWgdj+AFQVzQniZR0zo1q034keZ0IZ9Gfmc6JuJU9
 Y9pWJXoarFIQZ0W+0a8zL/13B3BZ5IyLzejOCRQx4vSuQJy3pvRf1LpyMq33fnOmwa2Z
 6CPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4ofv1EkCMYUOF24VVCi1gY1dclNNhl+ujdnnEtpQKeS/nKxbAeMNl07pL5MLXrMJVAOyffbeG0IUh@nongnu.org
X-Gm-Message-State: AOJu0YyA76q0JZeRzpxQ1mr28cDabb+K/OKw3tYGICfZhXd1g7BcdKxY
 WMBNxMk0aJrd9h2OzkEl/66VeLvEKOVttaEs5wPHQpRYTEIHCVBswuqKSbAcUjHMaNvdLXc9A4D
 Qp0XsSMpg+9lhiX5AH3DfLsoH1Is=
X-Google-Smtp-Source: AGHT+IHyJHIwDqW0tRTYvGGG77vo4PSuy7Jv+crjK/8FqsSyqtmzOCZsz718/LuCX3AC/PezKTLtgSy/Nml5gauovEI=
X-Received: by 2002:a05:6102:5125:b0:49b:d12f:40b0 with SMTP id
 ada2fe7eead31-4a46595e8a9mr1246953137.1.1728611002758; Thu, 10 Oct 2024
 18:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240924124407.766495-1-dbarboza@ventanamicro.com>
 <20240924124407.766495-2-dbarboza@ventanamicro.com>
In-Reply-To: <20240924124407.766495-2-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 11 Oct 2024 11:42:56 +1000
Message-ID: <CAKmqyKPFKFR60u=df3_0zO4bNLXjneGJcaEDcHV9BQSbNPSBtQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] target/riscv/kvm: set 'aia_mode' to default in error
 path
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2d;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2d.google.com
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

On Tue, Sep 24, 2024 at 10:46=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> When failing to set the selected AIA mode, 'aia_mode' is left untouched.
> This means that 'aia_mode' will not reflect the actual AIA mode,
> retrieved in 'default_aia_mode',
>
> This is benign for now, but it will impact QMP query commands that will
> expose the 'aia_mode' value, retrieving the wrong value.
>
> Set 'aia_mode' to 'default_aia_mode' if we fail to change the AIA mode
> in KVM.
>
> While we're at it, rework the log/warning messages to be a bit less
> verbose. Instead of:
>
> KVM AIA: default mode is emul
> qemu-system-riscv64: warning: KVM AIA: failed to set KVM AIA mode
>
> We can use a single warning message:
>
> qemu-system-riscv64: warning: KVM AIA: failed to set KVM AIA mode 'auto',=
 using default host mode 'emul'
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/kvm/kvm-cpu.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 341af901c5..970a7ab2f1 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1711,18 +1711,26 @@ void kvm_riscv_aia_create(MachineState *machine, =
uint64_t group_shift,
>          error_report("KVM AIA: failed to get current KVM AIA mode");
>          exit(1);
>      }
> -    qemu_log("KVM AIA: default mode is %s\n",
> -             kvm_aia_mode_str(default_aia_mode));
>
> -    if (default_aia_mode !=3D aia_mode) {
> +    if (default_aia_mode =3D=3D aia_mode) {
> +        qemu_log("KVM AIA: using default host mode '%s'\n",
> +                  kvm_aia_mode_str(default_aia_mode));
> +    } else {
>          ret =3D kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
>                                  KVM_DEV_RISCV_AIA_CONFIG_MODE,
>                                  &aia_mode, true, NULL);
> -        if (ret < 0)
> -            warn_report("KVM AIA: failed to set KVM AIA mode");
> -        else
> -            qemu_log("KVM AIA: set current mode to %s\n",
> +        if (ret < 0) {
> +            warn_report("KVM AIA: failed to set KVM AIA mode '%s', using=
 "
> +                        "default host mode '%s'",
> +                        kvm_aia_mode_str(aia_mode),
> +                        kvm_aia_mode_str(default_aia_mode));
> +
> +            /* failed to change AIA mode, use default */
> +            aia_mode =3D default_aia_mode;
> +        } else {
> +            qemu_log("KVM AIA: setting current mode to %s\n",
>                       kvm_aia_mode_str(aia_mode));
> +        }
>      }
>
>      ret =3D kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
> --
> 2.45.2
>
>

