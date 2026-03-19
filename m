Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BAD11088E70
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 03:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w341I-0001nX-OO; Wed, 18 Mar 2026 23:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w340x-0001j0-Dg
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 23:25:39 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w340v-0005B3-6H
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 23:25:39 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b93698bb57aso87410266b.0
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 20:25:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773890735; cv=none;
 d=google.com; s=arc-20240605;
 b=coEocuiatuCOyXmoIZuMa/Ypi1aiQehC3ag0M5aC3syWQoz9gN0DZkBtpzfOT6QUD9
 L4Lby5cy39x52jqgKWNhWPEu8Ipm6PXBnNdWP+v2zSlwhtvw4UlIFog6sl+Aj3sT9ZEZ
 XJdnxN1qkKchigSJ7i9b0GpwXACx1mv6r99cqIZuOHxdnWE2S62ngmVHy0cqtFIAW+yZ
 hagozi7/1pjCGYp1BWuwzaldJOj+x6NeQp7i+fsqAzWh1TudKCX4ccfsgLNjsBZfIHH0
 t3nX8/L1LH9Y7HfkPDBRP/roNTcUUSSfaaagn7UqcrB0sUy2+vWxYBMDqXwX0bg4fAyQ
 GNGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=c+Vcu3y3TcHx8I34U4dfrv+aGz4EYSy1Gd2zQWNbnX4=;
 fh=XErS4XjkAQDBkClscxjQUC7TY1MVaIkgq5whaEGujtU=;
 b=j0AJ55hYBLJEmdE9GLpUa4X9NfMLbQYKrBrlv+Y6nke1XI7CGW5hvxJOKa5AvWxb5k
 9UcrxpZau+ytpGLw6066hIRjven4lHDt/j03VUWhgm0PoggJx+0sa8EPzuXi/QVHt5Rm
 WW1zZ7HWKOphogJu2mgxaNiJ6oWswsp6xSZMQj9iV+SCuKDSIahyTeHq7CHLOAdWK5h2
 2jclrFpdorAjs6xAulnYf6hEY0XSbJNEwL2tG/aYzm7HwHppceqpc4qSsgfbpxlkx2Kv
 Zj/aPWeoQO4GJEqeyUxpQ+znh2wzym2OMjSDES60SQCzmifv9tyrVlp0m7RwzM0GnvAp
 llDA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773890735; x=1774495535; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c+Vcu3y3TcHx8I34U4dfrv+aGz4EYSy1Gd2zQWNbnX4=;
 b=bQr9UyJVAiWdw5M4uKty3udDdHeID0fLwt1Zm+XznmP68NSPNeTlKm8I2X4i9L2uCD
 5vz9o4uAAe8JF3Chx7vY3zUF4VFxzasJG70ArtQsYrnihukawPsYS62YImYwi2qNLZoi
 qUkX3/zuzPdQlMV1sGVvmH9GaJ3lyWT4S+bXj818zFkSfFR8WmMvCLud8mySCdANeK2L
 Om+0bRwW6ATXjNd4vMFis8p4z8v3rv+ffweO819GW43x3NPiiFhlFh8k0VgIzAaA+1e/
 F1nMCT+cy+u6M+7OoHLnrFXwlLkvUuI1byMQci6UCWDqKpkukMGixL8/EpWaermzIuYs
 TEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773890735; x=1774495535;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c+Vcu3y3TcHx8I34U4dfrv+aGz4EYSy1Gd2zQWNbnX4=;
 b=KkN2KU40wQNwY5JF/IGuIQD8W9hWeqttU/EayjgelSG8lC688DV4LF3cBQdf0T5AWu
 lEEYX3okGUhVJzKDs7JW2pROTka6AFGangc6vAfB0V6mijipbBaVjBST/uwqxH5xya/9
 QLXWR3y8qYoyO3fNuVhZj/YKovNhC+cpPrzDa49urE4WtZLaSRMKAOnZKI2/ne1Pi3OX
 ny+EfQ4mrKv6Mai74W7VCpxI3QsttQC+FKlXcDXqjsAaKy/Pppt5KxW3fECMLiR49Hz9
 UrF6KytwlQtzA3xY2nJ5L6eqHWpX3ci6F1vYn5vWUmWF44uFhxnafqbwpeHcUKB6Q2Ni
 dv+w==
X-Gm-Message-State: AOJu0YyWHMDYYcygJmcSA21vc7rRPqugvEPZ0nNLbTjcI1Yr/zNsyOer
 boagYArETSjzAfaP+50DDJrzVZ1ishYsP1uhmft28mnKYSUJSK4NmfQI6HgfkN4qGWxdkU9kB8A
 /YfINomvg1ckGWPC/19JvN1T2dZbMjgg=
X-Gm-Gg: ATEYQzyEGiYu1padZ4hqR93n6X8HeSKoCG5jydPe3SA7YQWuGepJC/ivQfw+nqERrB0
 k6Jsm9OCLtc8ttDe56isJbEBCniByVu1ulSkGCkbKadXss55P2yki3+qyPWH12wkZ84d09odkdj
 jmTE3pHpNG3T3w39DYnsYqwNB+RV0E/TbVtRdsaITEglHakxYiHgBLImIxZBjqGBjrjzJN7s4oh
 PTz/Z2Dg9Scrd37t87Y+EOvOWt4MsdXbAC8F2N6g4V8OyltcmhMcEiHtWmALuK8om5ib4A8Unz+
 anceTaF3cQQIPlUwTvTNZnaIK/dheT/fzJy40A==
X-Received: by 2002:a17:907:1c8e:b0:b98:34b:e45d with SMTP id
 a640c23a62f3a-b980fa1bf9bmr102518066b.24.1773890734995; Wed, 18 Mar 2026
 20:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260318013805.1920377-1-max.chou@sifive.com>
 <20260318013805.1920377-3-max.chou@sifive.com>
In-Reply-To: <20260318013805.1920377-3-max.chou@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 19 Mar 2026 13:25:08 +1000
X-Gm-Features: AaiRm506Ho1ve7C7mFMHTkl_Sm0B4N-hZCC7TZWDmqBSbkTkL5ljxiMtrxOMgXc
Message-ID: <CAKmqyKNNEmziWXAyj0df1gZ6-jEkgk9p3TL=Au+jWHFjtT9iFQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/riscv: rvv: Fix page probe issues in vext_ldff
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>
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

On Wed, Mar 18, 2026 at 11:38=E2=80=AFAM Max Chou <max.chou@sifive.com> wro=
te:
>
> Commit 17288e38bebf ("optimize the memory probing for vector
> fault-only-first loads") introduced an optimization that moved from
> per-element probing to a fast-path broad probe. Unfortunately it
> introduced following bugs in cross-page handling:
>
> - Wrong condition for second page probing: checked "env->vl > elems"
>   instead of "env->vl > elems + env->vstart", failing to account for
>   the vstart offset.
>
> - Incorrect second page address calculation: used
>   "addr + (elems << log2_esz)" instead of "addr + page_split".
>   For segment loads (nf > 1), this would probe the wrong address,not
>   at the page boundary.
>
> - Wrong second page probe size: used "elems * msize" (the first page
>   size) instead of calculating the remaining size as
>   "(env->vl - env->vstart) * msize - page_split". This would probe
>   too little memory and could miss faults.
>
> This commit fixes these bugs by leveraging the probe_pages helper
> which automatically handles cross-page memory accesses correctly.
>
> Fixes: 17288e38bebf ("optimize the memory probing for vector fault-only-f=
irst loads.")
>
> Signed-off-by: Max Chou <max.chou@sifive.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/vector_helper.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index a74ce70943..f038997095 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -772,9 +772,9 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPUR=
ISCVState *env,
>      uint32_t esz =3D 1 << log2_esz;
>      uint32_t msize =3D nf * esz;
>      uint32_t vma =3D vext_vma(desc);
> -    target_ulong addr, addr_probe, addr_i, offset, remain, page_split, e=
lems;
> +    target_ulong addr, addr_i, offset, remain, page_split, elems;
>      int mmu_index =3D riscv_env_mmu_index(env, false);
> -    int flags, probe_flags;
> +    int flags;
>      void *host;
>
>      VSTART_CHECK_EARLY_EXIT(env, env->vl);
> @@ -788,16 +788,8 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPU=
RISCVState *env,
>      }
>
>      /* Check page permission/pmp/watchpoint/etc. */
> -    probe_pages(env, addr, elems * msize, ra, MMU_DATA_LOAD, mmu_index, =
&host,
> -                &flags, true);
> -
> -    /* If we are crossing a page check also the second page. */
> -    if (env->vl > elems) {
> -        addr_probe =3D addr + (elems << log2_esz);
> -        probe_pages(env, addr_probe, elems * msize, ra, MMU_DATA_LOAD,
> -                    mmu_index, &host, &probe_flags, true);
> -        flags |=3D probe_flags;
> -    }
> +    probe_pages(env, addr, (env->vl - env->vstart) * msize, ra, MMU_DATA=
_LOAD,
> +                mmu_index, &host, &flags, true);
>
>      if (flags & ~TLB_WATCHPOINT) {
>          /* probe every access */
> --
> 2.43.7
>
>

