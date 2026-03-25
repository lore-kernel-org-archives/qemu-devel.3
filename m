Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1748103A99E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 02:30:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5E04-0000ZF-Uv; Tue, 24 Mar 2026 22:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5E03-0000YW-9s
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 22:29:39 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5E01-0000ex-TZ
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 22:29:39 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b979d16dd0cso898756966b.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 19:29:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774405776; cv=none;
 d=google.com; s=arc-20240605;
 b=PiSfVBc1TNuMl8385mQuzOy4qQq/Pfx0o57hLvHuOPzwn1n0M6rtMeyPaU5Y6JM/hv
 isUQTfLqq9FnRTFnhEtB9/5mA665VvJMdrY0mIG0QhLsb159RPScwP259v9FbtujUs8+
 PMuLmkvph5P1XahDhZijBui3qj39hrykFzhhEXV7+uzWFlEPYlksYAwRXpEcBTGOt/sF
 DfYr0aLv6rDHiZrNrmx8YBxjOwTCeuJA8gfeYfSGPFioU0eNJe+dL+p3zg1k4Z/NLahQ
 TZ3pSCX1ckBNBrTlvH35rAxWTyPdwixvpnwSJgBZjFVsvws3tE7Z0VTfiXpB8xeRMVbk
 Bulw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LFhofnyL2zu2tWqMFnrF7Xc2fiFOlLXQcwR0hUhH+oo=;
 fh=Ykz535V6Tkaof7buRypbHUBTN2MzFgl0yupx65lIR2A=;
 b=lVVMWRvrQ86hKGm4aLIxCWg9y6HpmW05FXgs5673FZlDc5bzh5gn+xMjrJrnDXXEzr
 /qqQu9VmqpiHZDYTpp/ZL/QbdQSn2Gt9i/r1FerXiJbcWeOCkRLZ/JkRwrgjjBEUzhLj
 QzvshdRALXZSdxdj/6OGXlXSe0Ky3sqmRISJRlSzVEXawNe3JumqfG/HAv6d3r251m3b
 nADV5XQQ+eazDSSFxBLLasmEYQENLfl7kyanAyKrrSIxEK+uy/qnfj5eGnTtiow/CGgt
 GR6cXW/cLBOZEURcfSqNxvRl7Ph0j8Yd8b+RH0F7aU/LHOcmfgtxnjbhabA1iPu5CPR5
 TYqg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774405776; x=1775010576; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LFhofnyL2zu2tWqMFnrF7Xc2fiFOlLXQcwR0hUhH+oo=;
 b=Vb1EB8mwZViwdQpjoob+tT2NfLBBKE23uOjFvTvH0pVZtQLiKiUpmY9xpX57XVNR1y
 +HRVepWRrLWFqv96PCO5n9bSMo6HgKtanaS1ZWAWDw+xo14aLSrj+qKqXxV0VRn7eudB
 I+Ih8V1oyVjdevTA6ygxQxVEkjxnQN0D5aI0Xg3TKsgqPgRnTK0cjdfc6Lta3eWV70vU
 ImgWaup/8znDVueVfH8dz5lP+EhMQyXXcIwqbOa9ekTvCB12cQck2Y6uuTBJCCdOrgZk
 S8EPZf7bebyiaEJrVibuAXEkoY2JhuledF6jTip+lzcwnXXmAzCrH5z5W4mgzO5u0CFk
 oFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774405776; x=1775010576;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LFhofnyL2zu2tWqMFnrF7Xc2fiFOlLXQcwR0hUhH+oo=;
 b=qALXFCHEzl93fyYGd/+UlInx1PbtDCtUji4Yeq6zPazMgdnBZnMtZRTodnXZfvrBEb
 aSVPhnB7RRgnLfQzHaXe0PLB2lx9L+DhlEuLoxgDMyuOoNE6e0ZG5JC2QGlGlRetMOd6
 sgd7gLfY73XTPd2mCIg1akat8hazsUEB+57B6zPB6xdmf5t0HwY039ZkGeo1WVCLc6v1
 w8v+59erJ/8UKxSnzvTB3O3b78L7ORqwcm18dKab0ANO0j61UCpxMGQ/xhx3opwQTJsh
 vUUf3HidXXtf6Q4CeaVhi9WlLRYqWuqc6/gQB4Wd0cVpY3cPbCHY5x7IV3/q003Vi4Na
 jvbg==
X-Gm-Message-State: AOJu0YxpMMBKw8ithbn+6JH4m7ZCMidNBsr7n6xqB4+80dcbdX0Gaj9b
 sC0GjMdTUX2o8FUMNv6fHjWL67MR3m6tJYhNqO8UJ8hZgAPo6TcTQT3FGyX7uxvwV9oMegj+n2s
 sGKHRo+s6uTB5eTuwlv95Ao11i4fpU8o=
X-Gm-Gg: ATEYQzw+sYXllX7BGWiQ5TJ9ZE3DzRXFf2XRZexG222SdJBHvuyx+ulBRatoQNEeM+L
 yTOoETOSauTvM+c1Gmb6Fzhav5STLgb9ZFi1vMqcGZ/hbb/4V3rnHHar9hBqXH1h3z8dAZqRzD+
 uPxk9eaclzY+rjoQ7M3OJQn+koPML6mcSHSLttU0A4FRlu3/Y3L5raaZWr4yzV2q69g31izEOg9
 CkY6OFaP2LgH13PeIAjVdTCb1iiyXo8RieIskJXkyoLpQKvA+5QtyUUm+fzwa7PshT5PtpTzDYC
 Nt3zPbbH5rmLFc+jdK38Kkk0RY/yrSURhi7HYYXQJtmc4vXV
X-Received: by 2002:a17:906:5983:b0:b98:1b18:7840 with SMTP id
 a640c23a62f3a-b9a3f17188emr70308066b.11.1774405776251; Tue, 24 Mar 2026
 19:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260325014856.58948-1-jay.chang@sifive.com>
In-Reply-To: <20260325014856.58948-1-jay.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 25 Mar 2026 12:29:09 +1000
X-Gm-Features: AQROBzA4eoAsiMTUTsZ4wRlCZiQzzoj2WEyBIjRriOqpWuwWp45uuU35I8O0WRo
Message-ID: <CAKmqyKMBMtv45CMsPDMerpYcNZU8UqLZwWvro0_rdLJXgCa4CQ@mail.gmail.com>
Subject: Re: [PATCH v2] hw/riscv/riscv-iommu: Use standard EN_PRI bit for PRI
To: Jay Chang <jay.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Frank Chang <frank.chang@sifive.com>, 
 Nutty Liu <nutty.liu@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62d.google.com
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

On Wed, Mar 25, 2026 at 11:49=E2=80=AFAM Jay Chang <jay.chang@sifive.com> w=
rote:
>
> Replace the temporary custom extension bit (TC[32]) with the
> standard EN_PRI bit defined in RISC-V IOMMU specification.
>
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
>
> Change in V2:
>   Align code
>
> Signed-off-by: Jay Chang <jay.chang@sifive.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/riscv/riscv-iommu.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 225394ea83..30343e98d0 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -1572,11 +1572,8 @@ static int riscv_iommu_translate(RISCVIOMMUState *=
s, RISCVIOMMUContext *ctx,
>      riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_URQ);
>
>      iot_cache =3D g_hash_table_ref(s->iot_cache);
> -    /*
> -     * TC[32] is reserved for custom extensions, used here to temporaril=
y
> -     * enable automatic page-request generation for ATS queries.
> -     */
> -    enable_pri =3D (iotlb->perm =3D=3D IOMMU_NONE) && (ctx->tc & BIT_ULL=
(32));
> +    enable_pri =3D (iotlb->perm =3D=3D IOMMU_NONE) &&
> +                 (ctx->tc & RISCV_IOMMU_DC_TC_EN_PRI);
>      enable_pid =3D (ctx->tc & RISCV_IOMMU_DC_TC_PDTV);
>
>      /* Check for ATS request. */
> --
> 2.48.1
>
>

