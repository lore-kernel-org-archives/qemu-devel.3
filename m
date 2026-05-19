Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 370F3CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 04:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPBgc-0000WS-Ky; Tue, 19 May 2026 00:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPBgb-0000Uh-8V
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:04:05 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPBgZ-0002W0-IY
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:04:05 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-bd0209f25c1so535680866b.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 21:04:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779163442; cv=none;
 d=google.com; s=arc-20240605;
 b=fu24nIKOq79XTmXZNF2KGq0fBOaSacLI2J+6SYHVvyd12EowBOHKygxL++fmEFC2sn
 rd+HKKIBAy8CFUkBP650IBGGtdhHF0xN6LU5GNVAm9HlOyQKbO5jKIexkIQzE5/sRxUj
 H/8kZQ2Sj0UBpfeT7V4BFnZ3w2KmLL1hivNMuit62wq7xnJB11rAyhfPkaZerR0cpDE1
 E47ZPEZydwWoUxXzm9WLUSnVx7FTEHNkSnTXoXI2Dg5UYfQW/veBV9kRwpRi6s7S9Rud
 yZqC/wGjFIK4hp+PMADeKVfdwXSPSARFvZ+rh1+YHRVBQxxUUi2VDFIb3T6vMGFQVZZl
 0n4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mXrB+LKef4bg6Q/hyQAa7sDqwUoByTMclWkpSbpXZho=;
 fh=+dPXGxW3pQNYFrTSil53fSXYfdhGIs7bI6Dyql1Mx+Q=;
 b=iOEeKAQ0R+cVkYNpuJ7OsbYM1N1Rz4M3ZrJOSb6mptQU3lzYLcJwk/IRFMtOQ7Y/cE
 7fa75MmHIIhJ06yG//NftYtI+yWXCZcPzidw3izkQfozSoe/71NONjlFMtFAS/J08Dt2
 YbLcerWphqq/nQ9wgTt8wHHfbniYv35LBUm5BH6nT88YVeT9N4cnrVDqZrWL614pu31R
 GxWuyd6a9Nak+EoOSShFBc8NPdukP20vIlkoBeVjfvUlwKTK3I6uE4gons8+/0F/ZUYx
 1BS5Zm87OdGEh6q7qs+WbadA6SN4rIjFW26EnzGyMufvk0EiP/BhF6V3TIsxW4s40AvO
 qFqA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779163442; x=1779768242; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mXrB+LKef4bg6Q/hyQAa7sDqwUoByTMclWkpSbpXZho=;
 b=ZGwx0c6aEINlBzOV+I1DoxZ1NDemXygZrVlOJ2CHv1Ls3PvYZ00GflDRhrKFvq0RDK
 lHIzbn9UwJkkRdgl3J3qDj5dju8MGPbtyssj5GrbmgJ+ECjnJrlCjoq7d0zf5AdellMk
 EXMFsipni0/PYbmy6Q5B7u3h4eJlwHvbMprqnAiqY/LYaAZvYYrBYkjG5go6sVOJv3iS
 2dC+g2qQqKZvT1WBMDF2MEljtNKW+JhBgfk/Xhe8aM6DFTEyrlctzRkUaOGVAvY/LTZ3
 mFKwQESuXNX+iCPREQrrhEyqUc3gY3ccDsbt9ypQYclhZkpH4bunlR7RNG9RK3jNne3m
 Q91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779163442; x=1779768242;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mXrB+LKef4bg6Q/hyQAa7sDqwUoByTMclWkpSbpXZho=;
 b=N+YTNei4lGyriacaTeAFaIOvUDXJNrgHwroatYun6GA+pa9C+/Pu6DP8bNCtRescP0
 aVUBktYFnaVBe2QdEt6uR0smNvFNs3q92t3QIt2iMh9IgmVVaMIWOfHekjTn8xp58WuX
 NUEa1eVJtClf95/ZEREV4ih6+Iq5aUlECiflaNX06n16S94lWr7JCSTNhpbmy1Gopm9P
 SFsVcLoIdWiaNEYFw+NUpf/Iu7S9wNWW7fLahlatgLPBJZneG0VuI1feSNKUbZzTrJgk
 olDtnjBN9GI6UtMz+2klHYRORsADoPsMlCsqtYkSZaXOpmuVSnQAs6M03g+hYM8K+UQ+
 WGZQ==
X-Gm-Message-State: AOJu0Yyl2ID+rVF6mOvGTxZxKU70PvxizJ4JJZ9MxyqkZ37I5eHcwglI
 cEwbZB5smP+vi/j74TRclTq+7NNuZ0AXVz3FFTml12bF9gUNrBk3Sjzegk8TH0xSr3MOZ4Hx0+4
 tPcw7GYpyRWnjNvIryQRRVACKLn340BxVR5ZM
X-Gm-Gg: Acq92OHxNFJdXfRZzYnpYVEVBVfilaLb6X/8bbxcNHjVBVxAT3AcZXxrgHDk5ATxL++
 Ja2Wfn5jj0USOXcHFUrfa5AuDcHbsIX+WzG2jq8R/TwOygyfuxxr4ginN/oQVqA+VTZv9raqZkq
 WhEMrmzsXd1cJw/NDgGFG1s5UfbCOlNlg5wncSQA+8lmsYfAkianMgvg8g8uJ2nv9hhTWenKjUv
 UDVut6ODbmX7N78vHgDVm2rsHMWK4a1IAoACAOG1ptzIj+uG8Bw9Ra55/b8ib8HZqwiJwGrvATo
 Ox9PASo7eo3+jGJBvIdF0vqBfYK0QwvyNMYEQg==
X-Received: by 2002:a17:907:6e86:b0:bd5:2cc7:d845 with SMTP id
 a640c23a62f3a-bd52cc7de89mr785132266b.30.1779163442014; Mon, 18 May 2026
 21:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
 <20260512032926.1978818-11-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260512032926.1978818-11-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 May 2026 14:03:35 +1000
X-Gm-Features: AVHnY4KkA4L_4-pSLksTI7-gfri1mMy91qqG1cE7ReUybN9FuUxpjcZSahZrX84
Message-ID: <CAKmqyKPL1QN=zvJDVdoKQqJevCcBDkJ++YuYoHw0Ofb3=ECseA@mail.gmail.com>
Subject: Re: [PATCH v2 10/14] target/riscv/tcg: use isa_edata_arr[] to enable
 max exts
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x636.google.com
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

On Tue, May 12, 2026 at 1:31=E2=80=AFPM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> Use isa_edata_arr[] to enable all feasible extensions.  Filter
> experimental and vendor extensions by checking if the riscv,isa or the
> prop name starts with 'x'.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/tcg/tcg-cpu.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index b7d59f40f2..eb48a76a6d 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1614,13 +1614,18 @@ static void riscv_init_max_cpu_extensions(Object =
*obj)
>  {
>      RISCVCPU *cpu =3D RISCV_CPU(obj);
>      CPURISCVState *env =3D &cpu->env;
> -    const RISCVCPUMultiExtConfig *prop;
> +    const RISCVIsaExtData *edata;
>
>      /* Enable RVG and RVV that are disabled by default */
>      riscv_cpu_set_misa_ext(env, env->misa_ext | RVB | RVG | RVV);
>
> -    for (prop =3D riscv_cpu_extensions; prop && prop->name; prop++) {
> -        isa_ext_update_enabled(cpu, prop->offset, true);
> +    for (edata =3D isa_edata_arr; edata && edata->name; edata++) {
> +        if (edata->name[0] =3D=3D 'x'
> +            || (edata->prop_name && edata->prop_name[0] =3D=3D 'x')) {
> +            continue;
> +        }
> +
> +        isa_ext_update_enabled(cpu, edata->ext_enable_offset, true);
>      }
>
>      /*
> --
> 2.43.0
>
>

