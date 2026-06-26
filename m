Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E3ECDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 01:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcv2p-0004li-8U; Thu, 25 Jun 2026 21:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcv2n-0004lJ-HB
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 21:07:45 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcv2m-0002xf-45
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 21:07:45 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-693c51a8a19so727712a12.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 18:07:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782436062; cv=none;
 d=google.com; s=arc-20260327;
 b=gpLOX/yWckiqIcuHSgGkPw3qDgsa70iOcKasAoUetDOykLOq2lmwxR4TpLWKJGoY/3
 bWRYtaFSVDqaNmE8heSPaJSy2TN5uN+izoZPvPSRV4FAh387hhKzIryy8NDPIpWxqYf7
 lt2DQf9lcJMAu5GiXqH7RlQmnns+UIxnXDatiCISU68xT4g1nQh1fro0CUEfpLfvSQDT
 EChn5DZemBoKmAKhMrd9WK8e4H/SgKMcRXsCYDCrRnBr5h7uDFrw/fikkVsQWweTuqz0
 0SUUO8dRsq8TJ1sdy9mi8aNCD62g3+LuGPZBpzb/PpVMk6fXwikWF6w05JPmVXJgxKz1
 HzkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vCU7BdPY5bJKN5lUioYYQWbcbu6zFkl3Hsl3Kn70JF8=;
 fh=9/4tzqKjgzJcjmYJcCvfm+LbcgW0ATp/rdwAYjKmbVo=;
 b=rgjm52tgA/gba/1znqcbGdIu7c5ywvB7xXiGyKAOK2vqVnCkpmAHAlyNMn5+FJPUqw
 WXNOk7kDNttIw80Qi+xH8IP2+y0KSxmhl2dZhhHS1zkfUaBU2tE14ONCJegVTii56tAC
 WxS2D5AecYPQ/YPWszlKKHlB+1nSO6EkeXlKW3pLwjfJOyCOnsC4IlM9W+C+5M0i+EmE
 JV1MA7QlKkIK6AMpcFZjjjGdj/OyX3OyNrx78nsdthlG6jz02fAntgI46HakxylkT0An
 4gPSOzWp3kXSm0GKwxL/FjRKKEZLExDpFAv50+DuyS2d51t1dPOaqRgOtReJsek83VAr
 gqOw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782436062; x=1783040862; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vCU7BdPY5bJKN5lUioYYQWbcbu6zFkl3Hsl3Kn70JF8=;
 b=cWd6d7ORixSh730y49N56L6Sj3boVLCFVD4Eote7Vlq0BINkw+abjxBlkre1rT6lb/
 HAeEyEDorZ4UZlsAbGKRtGch8L3uELZBMR1nwNqiHsbQ9yG2JV5c8RnTjtOZp+AWLcSf
 I33LFuQSHUg6v6PsApWFoXskXE7GB7EWpakcFRsKN0ipQGTHRoaUwSD/nfk03NXSNKzO
 daB1YLXqWREw8AtL/x84cyFTiPtbABcm0q4oVoYGayH5LWIY3CKie1IYt5YkPk+6xtKZ
 r6nJsMjKK+smS/RpJgk26kxwtVrrHYML8xUXSAiFGRbjxqDG2Cav27Iod3+xLqJrG0p6
 /05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782436062; x=1783040862;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vCU7BdPY5bJKN5lUioYYQWbcbu6zFkl3Hsl3Kn70JF8=;
 b=isa0jrpGaQ1xA92hNaU90S/6QK6TE9RDLu58Btxu5tUB/S3w4TplU5Jz8TyoTPPXCS
 ppSBFj68VtGiCFwCQn12dJWfXGGTSZR9otN5UfLhXHIWEWlcA+CnxFleaPJyWh4l0SAZ
 cKXbJqadKyevt4tmii8leL3SU/mva6Qn/rIC1k5uSeBiadeGp+HNkyUAmBSDlPkqGBKn
 NssYBMbtNPA2wBRE+7HE7LO3nPKGTrylQL901HjXuA71/MCYfMUsdeHYkIwJFgAvwmIg
 RafQz4DWDkwl0+r3jYq+ZIVZROOiNZ/y91wmXwdcM0NJ+eHTIJRXD3DZjjFonou+INod
 BLtQ==
X-Gm-Message-State: AOJu0YzRP6NCDuzkLrkHOscCs7LrtDBc0DJEPAozw1T5Bb0aMHFzuZqO
 ADmrrOdwHYNFl7d4blP9FGgDVpsqW/jhaWpzE68UrOmG/tpxf9gHUroxUP6LZgp3IN5wLmc7xsX
 uzXNiHU0pVNcxlFU5MDZkHseXfdgfoDE=
X-Gm-Gg: AfdE7cmxUftoNJ9exRQuIiiaghKoH8EQa0jJm3Zntrf5aNbaDLDS65AMIpXzNbHiwSn
 KZhqWvLIZXLatM8Gwt1cw0rDAL2+/5fdsyY7kSJ5l5whnZsttL4B8ZF3n+SAukAPMqL7It3aRKt
 BC4o7pj0nVpL2U1DgpcTKnrPjXNCS47AHRhnV1kTRnC5fK/fHjwrYd85BeVyXvI2Uv2cJ3TRc3u
 9SPyEe0937O5HC1z3A4vbBRmTgep+Jnoks/hdaG53k5HrU6pl2ynVdXHIxp3TvMebFX0XNIEsHw
 O0f9syNZk4dbVUM9KUTRqIT4pqY=
X-Received: by 2002:aa7:c30a:0:b0:697:edf5:20d0 with SMTP id
 4fb4d7f45d1cf-69810adbe61mr569540a12.17.1782436062531; Thu, 25 Jun 2026
 18:07:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
 <20260624000632.2149359-16-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260624000632.2149359-16-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 26 Jun 2026 11:07:15 +1000
X-Gm-Features: AVVi8CfRsdeHyNZVcTUVAVEUzPJjiVCQERbzi2YE15CumrpA7TT9Eerd0hFduPI
Message-ID: <CAKmqyKPzg6bb4Av17vRTB1AjnBusx6O3hBPMwn1zNiqcUwnHDg@mail.gmail.com>
Subject: Re: [PATCH v2 15/24] target/riscv/cpu.c: handle TCG bits of
 riscv_cpu_dump_state
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 fritchleybohrer@gmail.com, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Jun 24, 2026 at 10:09=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> riscv_dump_csr() is a TCG only function but we'll have to implement it
> at some capacity for KVM eventually, therefore put it under a CONFIG_TCG
> ifdef while making a note that this function is unimplemented in KVM.
>
> The csr_ops array is also TCG specific, thus the for loop inside
> dump_state that iterates it is also TCG only business.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 4fc0ee2823..7bd5bc0fc1 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -605,8 +605,10 @@ char *riscv_cpu_get_name(RISCVCPU *cpu)
>      return cpu_model_from_type(typename);
>  }
>
> +/* Note: this function needs a KVM implementation.  */
>  static void riscv_dump_csr(CPURISCVState *env, int csrno, FILE *f)
>  {
> +#ifdef CONFIG_TCG
>      target_ulong val =3D 0;
>      RISCVException res =3D riscv_csrrw_debug(env, csrno, &val, 0, 0);
>
> @@ -618,6 +620,7 @@ static void riscv_dump_csr(CPURISCVState *env, int cs=
rno, FILE *f)
>          qemu_fprintf(f, " %-13s " TARGET_FMT_lx "\n",
>                       csr_ops[csrno].name, val);
>      }
> +#endif
>  }
>
>  #if !defined(CONFIG_USER_ONLY)
> @@ -655,7 +658,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *=
f, int flags)
>      }
>  #endif
>      qemu_fprintf(f, " %-13s %" PRIx64 "\n", "pc", env->pc);
> -#ifndef CONFIG_USER_ONLY
> +#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>      for (i =3D 0; i < ARRAY_SIZE(csr_ops); i++) {
>          int csrno =3D i;
>
> --
> 2.43.0
>
>

