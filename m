Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 914A3CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 04:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPCAA-00020k-KP; Tue, 19 May 2026 00:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPCA5-0001xi-Ui
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:34:34 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPCA4-0006y4-5q
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:34:33 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-bd85ebb368fso334089966b.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 21:34:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779165270; cv=none;
 d=google.com; s=arc-20240605;
 b=kjh9EjEQ0e0D1oorMDX+2BbBdOREDPfc+QZczBM4xfKV+HfKK/pxovsPiGJW65kuok
 443Y05HraI9NKF8pr50MGJJCh7GpnF4ZhG7BGMNXd7S5I6XUdzLnOkhW3TSIqZJQSRxc
 YOPZkHkqUWoYNHEPokmxEsf7L6awPds9LjGI3qfcyQ5+KRH1FxfZAwSSg6mBoHkxI8j5
 LjuhcSkWWR/IiLMgrl+U51OHYg3+cx38StJ/mzYzf+OSuZ/UdqQojplzqJk2P7CJDHbv
 d73Uf5SD+aRAaQrA7jHBEqqkAzOvoeKGaMrnwSTvJPPUc5gcGvX1t2cmerIz/eoOjJvx
 +QCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=X3DJnJyAhvzX5iRg1tKctmrqXz8Y9Fq2axuTB1fqZ5Y=;
 fh=+dPXGxW3pQNYFrTSil53fSXYfdhGIs7bI6Dyql1Mx+Q=;
 b=kwO7O5BDGk5tkV242kOMXmbiC1THpR2uPtEac6Xhhza+7CjluWjR5Fi0GDl8MoJg8c
 j7Dw22PGAjeUpOgu2lJNGNDCoPP2BEB90SnxkDiptz1ZMk2d12w9qfT48uj9yD4MmosY
 ZKONxYXPNHnYLYgL9neM/vmy5RaxNvWH+SJ9cMls7VzZ6+u2sR8id+pYWz9p1CFxM++9
 Qbr4/XLc1sGxr6Oe39WDM8zKMzBm3XHAVDVT7rxEA7T4pS6zGNxT6DRC6CP9FYjtzCAM
 qBCkhBav2DaXquF0a/YHx+dVkZqLdHqt6tPZXJNiqA9QPD0vEHsfnkbySkKYHPNcQ3Cv
 j2EA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779165270; x=1779770070; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X3DJnJyAhvzX5iRg1tKctmrqXz8Y9Fq2axuTB1fqZ5Y=;
 b=IoP7E7XubOgr0gHJBzPajtsKbKnWRNJ59Isij5TxXRPgJCpVii1REH+7xKBUxc1AYk
 2HBz59qwTXq+rGBL7VRRGxJsnfFWUN02BWz5vlTQF5IW4F9iCUbWa/hO4iiBIeBuIjPR
 SDtinO3IFN6ZQexUrguZGzXezjdok/OW+7jR7YOymWTHdp1cF6ETP9ZHhLzYfqMpYTKN
 NLl0xkZvD3PxZDEvyJ2OT7IzNzE/W5VvurS1jwyLSkw6OjwJsRz8RVXBh7jEejMqrOeT
 I2qrXSID9xAyTUhgeRXwwMR/9h5eIqdcHdFyRiUzM54l/EXBGi9Zbnv+RNXLu+AOEYat
 vSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779165270; x=1779770070;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X3DJnJyAhvzX5iRg1tKctmrqXz8Y9Fq2axuTB1fqZ5Y=;
 b=quRJY/u+RwNBfztQlnHPR5uq/yD7XidMkqLq92uQ+M2NvGhqKzioR3m/0zIMzHXvWL
 qwIgTZVFTy3D1b3J7gqkMDyJ96q//jvyS8Kgtqp/9hCvF1kg1JuEDBWnHGVsd+hiODmq
 2ukqPKR5dMzyNz2DqD+3TpXQCqoYfAE02Q+rqO70hTJI0frvBCMqBGVF1dwNZm1xMQzO
 bIosYuwKHDaRWHCHNjCmYQELzqWYoGaQXKAFqe/yvI7YTKoKQuP4QMxPDu9iMqGwmwBz
 EF1LEWSS5382k5u5v/FkeQZJUFynETs3uFAqVOqaVRTPmk3+wa84ayKnu6ozPcGzc+wv
 SdLQ==
X-Gm-Message-State: AOJu0Yx9Zgj/2JkpXnJMjKjhGlrwS7GRrowdCzQ0YDPuvai/iJ+CiGYa
 iVAf3XgqfeSAPfoEXeTjuOr/0ZzXkfnG9WSnVqWIVSRGyzrDvECyISxUqa1FtU+NRO70yQGd49S
 WQRGFAvUxNSa44j1qVop/NxQLr/7wisA=
X-Gm-Gg: Acq92OHgf/0n6wERFtCGVXKouZAFHd2UNsU4Ebi7EMyHg0X17yB6N/IURAzpM+mY9o6
 d65lx6EZPwqvUla8r6GtGQRDrc1gRR1eVUqA9gfGimYFcX9CMJEmVjq3CdDmtAH5AMFaYu9/lQT
 OjR7yY2YMpe8gT1sEaWXAW2D6I8FpERbrQCYIkNTAJGOly06Id07u9A7P6kKKt6/4yhCMRf/uYX
 59vRZSEGKzvO1kZWaqu3gRdHEdrIiKk+WUhV4zI7V5NBCwZXsGUxF+8mT7+0mJeOnnmBY8oC0dF
 TV+Rvqb4MY65jmUKHfkUtB5AkHmBcUYGVE1SUDi1/8Tz1wMtJMGUqCG4VzM=
X-Received: by 2002:a17:907:c248:b0:ba7:500c:ea16 with SMTP id
 a640c23a62f3a-bd51785d8d4mr1030070066b.13.1779165270371; Mon, 18 May 2026
 21:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260514123342.2139464-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260514123342.2139464-1-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 May 2026 14:34:03 +1000
X-Gm-Features: AVHnY4KuoapGlaTpPTZbDRtljzHDsMHAOOVFwKTD9Az1imUeq3bCUTFI43UtHbc
Message-ID: <CAKmqyKMY9-nUvpHe-TW_zz8vLy3gxONWs_GtpvoCGO77pE=58w@mail.gmail.com>
Subject: Re: [PATCH] target/riscv/csr.c: fix read of pmpaddr(0-63) CSRs
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x630.google.com
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

On Thu, May 14, 2026 at 10:35=E2=80=AFPM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> The priv spec defines, for RV64, that the upper 10 bits of
> pmpaddr0-pmpaddr63 are WARL and are supposed to be cleared.
>
> After this patch, using the bug reproducer in [1], writing
> ffffffffffffffff in pmpaddr0 and reading it back now results in
> 003fffffffffffff.  Here's the 'diff -cp' dump before and after
> this change:
>
> *************** IN:
> *** 5272,5278 ****
>    pmpcfg10 0000000000000000
>    pmpcfg12 0000000000000000
>    pmpcfg14 0000000000000000
> !  pmpaddr0 ffffffffffffffff
>    pmpaddr1 0000000000000000
>    pmpaddr2 0000000000000000
>    pmpaddr3 0000000000000000
> --- 5545,5551 ----
>    pmpcfg10 0000000000000000
>    pmpcfg12 0000000000000000
>    pmpcfg14 0000000000000000
> !  pmpaddr0 003fffffffffffff
>    pmpaddr1 0000000000000000
>    pmpaddr2 0000000000000000
>    pmpaddr3 0000000000000000
>
> [1] https://gitlab.com/qemu-project/qemu/-/work_items/3362
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3362
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/csr.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index e1cd4a299c..476a620035 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -5362,6 +5362,23 @@ static RISCVException read_pmpaddr(CPURISCVState *=
env, int csrno,
>                                     target_ulong *val)
>  {
>      *val =3D pmpaddr_csr_read(env, csrno - CSR_PMPADDR0);
> +
> +    /*
> +     * For RV64, bits 54-63 of the address registers
> +     * PMPAADDR(0-63) is a WARL zero field (priv spec,
> +     * section "Physical Memory Protection CSRs").
> +     *
> +     * We'll have to add an annoying TARGET_RISCV64 gate
> +     * here to avoid complaints about masking bits 0-53
> +     * of a potential 32 bit target_ulong '*var'.
> +     */
> +#ifdef TARGET_RISCV64
> +    if (env->misa_mxl =3D=3D MXL_RV64
> +        && csrno >=3D CSR_PMPADDR0 && csrno <=3D CSR_PMPADDR63) {
> +        target_ulong read_mask =3D MAKE_64BIT_MASK(0, 54);
> +        *val &=3D read_mask;
> +    }
> +#endif
>      return RISCV_EXCP_NONE;
>  }
>
> --
> 2.43.0
>
>

