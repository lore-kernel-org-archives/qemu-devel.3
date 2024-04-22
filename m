Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE64C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 03:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rykmi-0001r9-SP; Sun, 21 Apr 2024 23:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rykmf-0001qm-9l; Sun, 21 Apr 2024 23:56:01 -0400
Received: from mail-vs1-xe36.google.com ([2607:f8b0:4864:20::e36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rykmd-0001eh-Ap; Sun, 21 Apr 2024 23:56:01 -0400
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-479cbfc62e9so1052040137.0; 
 Sun, 21 Apr 2024 20:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713758158; x=1714362958; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aaO/gUqiTbPYh0MI6/kxlUTbhth4CUAI/39aqaVKvNk=;
 b=IM8x0cFcqVzaTBg4reuLPA7p5qy+c2Ee6UP2jIQXNyKXhMWm16h6B3dVaS90X7f4/K
 pHlMJ2FyYrjV928KPbXen/U/Kj1W9rRSt8D46V0r2QFRaPiJU4AFY/77QOpt+ouTFqi+
 sQ0PQXfaT5FzMRhzcxWEZPaZePxnzCapPzWYIwhL/+L527vbJG4zUUUlDllr+dX6dmUF
 vC/ROvjqKv7Xs7RIzgUBiW0cNx/9fD/H+Es1gG1C1vxY2RojmRmi7zjmpN2R1Rkju9Jp
 5vCk2x9Yv2SV3slA09+adkAQzZwkkwRGN3op9m47VcttNBB8rtRenKa6BljQR63hrUHV
 t4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713758158; x=1714362958;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aaO/gUqiTbPYh0MI6/kxlUTbhth4CUAI/39aqaVKvNk=;
 b=ZondcrCh/AUPrWbD7BxeJZ+AhbjfyB2viGv2gEiuKwrZgE0vx35y1Hebo25B7Tl5O4
 joXc7UQwNaJPUPwF93ATr7+LxBsDjBTU98xPGbF7PYRZ31LCHcCLN0mgl3g5zhPHHlWm
 y9gwACxFGsU/iDodFqDQr8kRvm1hY7Bh8SE0Im4wuD/O7a1jubFjiuFS7TGaIVJJdLN/
 4zEc3gyFiromATzJV5fIfIWY7MX2wn/cKC9F64GrZYTDtE1Moz1xin1QHptJ31tGz8P2
 aH2vU4aK1FhWZPSXP+8WBqmjn+W9vasuBcaghzRZBjlfUXbRj/7HRJZmIokQLuNJoazu
 0e4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXO7ul9/azIVu+cXFZ8iM2Gk/+UEzqfdeAGWx7DgGIbCJD4pskVpKdIBbRwERkTUpty6ocxPtrmw7NU5RZ1qZqPtcYN/fw2NEoKVMBO1hXQE3U1Ww9EfnaxRwRVUg==
X-Gm-Message-State: AOJu0Yxuvx96uwIqf+S4lSJt1eFOHY1ZBnZ+lTvpglhwVhos1ATULueP
 vyaS7iLgTPS6PjrpCNs3oMjJKecCvHYiP3fUnKe9k9Bt0aDx3M8+e/08+F2T8hVyXMF3BD14DXK
 pTBzDmDZ33T74Lrm8PeUZ+3lRz+U=
X-Google-Smtp-Source: AGHT+IFCwfp0L5ntpDVpd/9Ar72JW1gBzSPcqrBL840bbVQiSvQN1xXnKTAtaIiFxZqd7Nz4rMNghkkJgVSZ0O1jico=
X-Received: by 2002:a05:6102:19c8:b0:47a:2c1f:cba1 with SMTP id
 jn8-20020a05610219c800b0047a2c1fcba1mr10851674vsb.10.1713758157756; Sun, 21
 Apr 2024 20:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240326-672b9d2fa4066ec883a9f037@orel>
 <20240413112526.8748-1-alexei.filippov@syntacore.com>
In-Reply-To: <20240413112526.8748-1-alexei.filippov@syntacore.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 22 Apr 2024 13:55:31 +1000
Message-ID: <CAKmqyKN1ATWcSqNXXG-81shqRj_XPG0hSVPVtW3gjeOCgNNfuw@mail.gmail.com>
Subject: Re: [PATCH v4] target/riscv/kvm/kvm-cpu.c: kvm_riscv_handle_sbi()
 fail with vendor-specific SBI
To: Alexei Filippov <alexei.filippov@syntacore.com>
Cc: ajones@ventanamicro.com, alistair.francis@wdc.com, apatel@ventanamicro.com,
 bin.meng@windriver.com, dbarboza@ventanamicro.com, liwei1518@gmail.com, 
 palmer@dabbelt.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e36;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe36.google.com
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

On Sat, Apr 13, 2024 at 9:26=E2=80=AFPM Alexei Filippov
<alexei.filippov@syntacore.com> wrote:
>
> kvm_riscv_handle_sbi() may return not supported return code to not trigge=
r
> qemu abort with vendor-specific sbi.
>
> Added SBI related return code's defines.
>
> Signed-off-by: Alexei Filippov <alexei.filippov@syntacore.com>
> Fixes: 4eb47125 ("target/riscv: Handle KVM_EXIT_RISCV_SBI exit")
> ---
>
> Changes since v3:
>         -Clear Reviewed-by tags
>  target/riscv/kvm/kvm-cpu.c         | 13 +++++--------
>  target/riscv/sbi_ecall_interface.h | 12 ++++++++++++
>  2 files changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 6a6c6cae80..844942d9ba 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1392,7 +1392,6 @@ bool kvm_arch_stop_on_emulation_error(CPUState *cs)
>
>  static int kvm_riscv_handle_sbi(CPUState *cs, struct kvm_run *run)
>  {
> -    int ret =3D 0;
>      unsigned char ch;
>      switch (run->riscv_sbi.extension_id) {
>      case SBI_EXT_0_1_CONSOLE_PUTCHAR:
> @@ -1400,22 +1399,20 @@ static int kvm_riscv_handle_sbi(CPUState *cs, str=
uct kvm_run *run)
>          qemu_chr_fe_write(serial_hd(0)->be, &ch, sizeof(ch));
>          break;
>      case SBI_EXT_0_1_CONSOLE_GETCHAR:
> -        ret =3D qemu_chr_fe_read_all(serial_hd(0)->be, &ch, sizeof(ch));
> -        if (ret =3D=3D sizeof(ch)) {
> +        if (qemu_chr_fe_read_all(serial_hd(0)->be, &ch, sizeof(ch)) =3D=
=3D sizeof(ch)) {
>              run->riscv_sbi.ret[0] =3D ch;
>          } else {
> -            run->riscv_sbi.ret[0] =3D -1;
> +            run->riscv_sbi.ret[0] =3D SBI_ERR_FAILURE;

I'm not sure I follow. This seems like a failure but we report success
to the caller of this function?

Can you expand the commit message to explain why we want this change

Alistair

>          }
> -        ret =3D 0;
>          break;
>      default:
>          qemu_log_mask(LOG_UNIMP,
> -                      "%s: un-handled SBI EXIT, specific reasons is %lu\=
n",
> +                      "%s: Unhandled SBI exit with extension-id %lu\n",
>                        __func__, run->riscv_sbi.extension_id);
> -        ret =3D -1;
> +        run->riscv_sbi.ret[0] =3D SBI_ERR_NOT_SUPPORTED;
>          break;
>      }
> -    return ret;
> +    return 0;
>  }
>
>  int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
> diff --git a/target/riscv/sbi_ecall_interface.h b/target/riscv/sbi_ecall_=
interface.h
> index 43899d08f6..a2e21d9b8c 100644
> --- a/target/riscv/sbi_ecall_interface.h
> +++ b/target/riscv/sbi_ecall_interface.h
> @@ -69,4 +69,16 @@
>  #define SBI_EXT_VENDOR_END              0x09FFFFFF
>  /* clang-format on */
>
> +/* SBI return error codes */
> +#define SBI_SUCCESS                  0
> +#define SBI_ERR_FAILURE             -1
> +#define SBI_ERR_NOT_SUPPORTED       -2
> +#define SBI_ERR_INVALID_PARAM       -3
> +#define SBI_ERR_DENIED              -4
> +#define SBI_ERR_INVALID_ADDRESS     -5
> +#define SBI_ERR_ALREADY_AVAILABLE   -6
> +#define SBI_ERR_ALREADY_STARTED     -7
> +#define SBI_ERR_ALREADY_STOPPED     -8
> +#define SBI_ERR_NO_SHMEM            -9
> +
>  #endif
> --
> 2.34.1
>
>

