Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6429F36B97
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 01:06:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB0Je-0001Ob-HS; Thu, 09 Apr 2026 21:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wB0Jd-0001OK-LZ
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 21:05:45 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wB0Jb-0002Pz-TW
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 21:05:45 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b886fc047d5so229303766b.3
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 18:05:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775783142; cv=none;
 d=google.com; s=arc-20240605;
 b=HyiKyLk3tXXVNiVC4Dclh5gdVCFbs62GHrxZXzEVvYHYIIvt0IpGlUMzlWDETiQ4tU
 ht+kBoF+DU7O0BYUw1Om0dETxp25sc4n6iIcaqodVwu1c9pjmkaBzEeNQyJ81bzjREoj
 +eTdpIHmuITGYehSQ8UHpNmCPha9MTp+nnfo+NOGiF2FNgy7WD7BVPx716cd0Dvg30uX
 S/Yz4MtansvdPrpCZRg10OpUxptsAlvQUtxykaVLASlzaV2BzWNveEYDZAoB3kycaI/N
 Ub/MhI4QaHoa9aGnuRatucG8n2Bw7HnbSOA+QWg4icninkTXzj7K/U1FH9gUwRZO2Ky4
 PipQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MBak4VLf/nagWglgeUb+oF6IkZgO/ezHJrewpPNO9Qs=;
 fh=yA45nsw3/GlmR4yv0X4Y623/LexEZcgSQA1vCu7Dy/k=;
 b=fBEqEfdtj15M4VnAVSB1xcVGBHNOVUwJF6jaovIa4DnAe7nvJcpNXlOyFifxNbSkyQ
 yrBNFmVrkzhOkDRNi7Pb2p/b+zV4elwWpYjX+5bAXFottYPC49Bp+e1qxZuOqaoJaXCT
 s3Vq4NZHpaFmn+Z6oKaPuhPSjKJIkaOmVfyh5e0b0of7S1ngJB6MV16q5tKe0esOxzyB
 7KnCnx8ozEjezKgS1g5XurMfdX0c8LmJGsmsCoCNAVOHZYVWteDESJEOXLhtev5hPwFf
 Jb1KoN4yN/UrmU1Bc95xa3akcGKbuQrvg+9GxuDaxanOIaBk6pRKP3rlmYi7B5pssL4z
 Mv4A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775783142; x=1776387942; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MBak4VLf/nagWglgeUb+oF6IkZgO/ezHJrewpPNO9Qs=;
 b=EjD0mIIVafwO9xlXV7cbah9bfpDqM/ipzFRMjcc4jRTXFG8oNT6nQyzr9L3g9q2Mc8
 nFsqRwZcEW29fAhqcsRECsIkK3k8jZgMlCoVGmVwDjWrWMInovueyhbMVkZjrCNOFhBi
 jgCe2QYLAz4iGxP3EHQ9pVLY54JPtnTaj5aPdws3/0gJSHcWZqsc04nQbRZJC+kqJmx2
 i+P4jLtIuoVy5HS2CSRi4YRxu9cZw2EhEnbtRzRbih1mPlF6CAN4vsx9JwZToEQxK8o5
 pXadEpTQVE2NlCR9fi9t8XgYkhst0R3EN8YvMYgJZvuskOXbEfGZEZLumS9NuZ0w0TP3
 9EMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775783142; x=1776387942;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MBak4VLf/nagWglgeUb+oF6IkZgO/ezHJrewpPNO9Qs=;
 b=GSOBxssO1TEvD1r9BYfF6j0o4AbFcwxLb9hmcwtBRR85KcSen4u3kNV0/SAK8+Lvfq
 T0UQaEpQdTDxS0NOyRuqhYx8QnKTZyMX919PO+4t5nWKf5mQ3o/S79334TRgZZZ5Uv85
 wjEoyenWofSZwKII/+cROPaqPDqi1BTjrhdAFYc/kwWC7egv0fxs/6Fr61dDFQMKcw/V
 7jO+e0KKPWe0vdJ/vIbo+xzLBuQCHIG67wFn8q/Woi6Xj77GhffpklRLdlIEdP/HVTWP
 SsKLxKHLVKcLE8/JP/dmMhP9/Ph2Im/VJ+kwnGV3afmno+UROJOM9FvnmrBwZyvN4pJu
 jb8w==
X-Gm-Message-State: AOJu0YxlsFg9M9c0/K4f2gLIn83xdKRKvFz5hRiQJc3n7IDTTU7D3XfU
 O7BaFfLVw1ueB8M9SiZjbcE2HqeUzCRh8tsfnkwxIJLDLAkSbjIo06wPzyyKEMlHePW9zwieMuq
 V2YeAU+HYYv7VtbiYR2MFU1dxd1iuL3w=
X-Gm-Gg: AeBDies/XtmlMKUlep6DS7FNbiZPZ84kMnEjnJl4IaJbVck8LBN127fVkkCKMG+El6j
 1sGnZWPvUT6bUd5+zc5xAkWGJpBP9kKHpwwYiVH1eerAtYx3tsHliYfGpa4UOLi58XIwZ89Rnuk
 UpNr3YHjW9dMnoUShFXssbaVKZCxm7GhA/TTELvCYT6xKjQwyR+yVT2WeprGx2KdrHO+PxksRze
 UZYtOdcssoprXfE7bRKSvoHhaCOx+maDbX7a9Bj2+ipjUTGexb9pZbbqU3EBCXa+7CDQ7F6Msju
 zfxOX2xVCnd//5ebYxnLpaLaxH44HjsnaD0Vyw==
X-Received: by 2002:a17:907:782:b0:b97:7d03:68c1 with SMTP id
 a640c23a62f3a-b9d7265ce29mr65939866b.30.1775783141872; Thu, 09 Apr 2026
 18:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260409155344.2849233-1-bruno.vilaca.sa@gmail.com>
 <20260409155344.2849233-2-bruno.vilaca.sa@gmail.com>
In-Reply-To: <20260409155344.2849233-2-bruno.vilaca.sa@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 Apr 2026 11:05:15 +1000
X-Gm-Features: AQROBzACqyk9RA5mGvD0Uj14P5AEkITpxANbBhqpkvytfsFBHAP0YXuQiDsGIps
Message-ID: <CAKmqyKO4x=WQcq+6RJW4i-naqBKweyEoyPkc5fyMa3rJTvO15w@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/riscv: preserve RV32 henvcfgh on henvcfg writes
To: Bruno Sa <bruno.vilaca.sa@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x632.google.com
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

On Fri, Apr 10, 2026 at 3:27=E2=80=AFAM Bruno Sa <bruno.vilaca.sa@gmail.com=
> wrote:
>
> On RV32, STCE/ADUE/PBMTE/DTE are implemented in henvcfgh. A write to
> henvcfg should therefore only update the low 32 bits of env->henvcfg.
>
> The current write_henvcfg() path overwrites env->henvcfg with the
> low-half value and clears any bits previously written via henvcfgh.
>
> Preserve the upper 32 bits on RV32 henvcfg writes and keep the existing
> RV64 behaviour unchanged.
>
> Signed-off-by: Bruno Sa <bruno.vilaca.sa@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 7948188356..d322bdbd47 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -3326,7 +3326,15 @@ static RISCVException write_henvcfg(CPURISCVState =
*env, int csrno,
>          }
>      }
>
> -    env->henvcfg =3D val & mask;
> +    if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> +        /*
> +         * RV32 stores STCE/ADUE/PBMTE/DTE in henvcfgh, so a low-half he=
nvcfg
> +         * write must not clobber the upper 32 bits.
> +         */
> +        env->henvcfg =3D (env->henvcfg & ~0xFFFFFFFFULL) | (val & mask);
> +    } else {
> +        env->henvcfg =3D val & mask;
> +    }
>      if ((env->henvcfg & HENVCFG_DTE) =3D=3D 0) {
>          env->vsstatus &=3D ~MSTATUS_SDT;
>      }
> --
> 2.43.0
>
>

