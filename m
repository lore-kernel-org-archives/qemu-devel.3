Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A826CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 04:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPBvR-0006HL-VV; Tue, 19 May 2026 00:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPBvQ-0006Gs-HY
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:19:24 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPBvO-0004RV-V6
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:19:24 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-67f7caa33easo6509377a12.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 21:19:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779164361; cv=none;
 d=google.com; s=arc-20240605;
 b=MQHNxsdBMDCxRPq/cWf0RaF3NlUehWNyojbYrXVrH5APYaWr1IaymY1AXSMsDSMbVL
 cJkd5wkkoYsXupDzJqdB46Ig4YkWBiWENWsNHFjz2UrYHqpoOMoyUQ9vI5poMC5NutOj
 YYhJjOfoRac/BBrfOByjH1eo6vjADpj+YhKKIXgkJZGHmQlU2b+qJU6B7t9xY2JoFCJo
 a4U9ixr/erdB0t9767K70PseL58brYIeoZXizI3L4+WYv7uuhiZxxXFdLVES3znk0geZ
 1wA2tbN0Tty0DE13jSW5JFQXiipxsNg3kYb1iP7CZj8CpcUKjinnbUv/PfNoP98ERxBN
 03wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4Vl1zN8+kDwnyrGUdfaCl3B4KuC/aP72uUSMjw8ucrc=;
 fh=kdoUSGLdpwQJD6spZ4VnVG4QbA92fFhhesOmqZMV7pw=;
 b=QWxAH0jF8PSiDkmEC0TdUDzYD4uTHbrQJI1TB0Cyg0gmXH2Q3hygquv0XlKbPu5yxf
 EwYnPx2UbIi6sKUawJnOeTLau28GY2bV/Ov8Zl/Ms5QdmOT9WLEtMA2+oUYVoP1dLj8D
 smzzxUP9OUnNE3FHa62gIpyHjj4kSNF1e4pp6jiuS3XFbkhOj+Kh8px89nUb3VBGBSaD
 KhWr/UhsCzO6OhypehEtmv1Mx2Pc0GhWr5vjsMQCIM2B6ojYaNyjnCiwJNVzftq5GzXl
 9l4n3PDMqQb5VCuoKZ1XLeiB22JAFE/sVTEjiAK+1AMRcTdOCCTddqEPTvZTRAygJsrB
 1iEw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779164361; x=1779769161; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Vl1zN8+kDwnyrGUdfaCl3B4KuC/aP72uUSMjw8ucrc=;
 b=ITtNHhC41iFSW+Je1f8K7FmBTCUJW6HyklgX+J2ZJxqF3+okHYxiF3K2nFzEWWd/C0
 +sFrls3Eap3gectVG+dtfh0rJ/uOKp0oxmby31UScsIC9dcKDmwJ4C7oM3B83Sa23bSA
 fT9zrDpARUaSxwAGQb5qcxPvGuW8CleAegv46qrSMih+vFZwy6J6HXtz005GnpViEdk2
 1bX9PIQV3yyOymwYtn62LiWLvRqCfMATLMwB4W6ELN4/Gh9LNBEJYJy4AUxztsd589mp
 ujhgO36nh4x6vdwgwfEVoFtG+aKF0rtN7tJWSZ3XakQ4jiWMQBdUj4QtTCaHAf04Fzw/
 89WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779164361; x=1779769161;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4Vl1zN8+kDwnyrGUdfaCl3B4KuC/aP72uUSMjw8ucrc=;
 b=MxAdPee46INGRtm49+2UFiuLA7dNs5rL/sZIMm2qX6/G++iDPcZ15KBuafSfDgIPv7
 8gZ0Q+Mh75A6YNsk1RoydJcNC8Jnq57eHPfuPBkEO9PJik3X7IznCIhr6aPknKdMHDfq
 tDLzbVY5mU9vlgk9gwcYwFIOO1e9/UdcfbFlAOU6Bl5oc+Jy6BEMTvgTgRLR7/CY9F11
 sGB6CS5UghsivkoyjUXzXyffgwOU8VH6ErC/ITSkURLpzGUqlAyHyCt1LRpD7v4Xilbv
 Q0yifCi22ubEUe4VQ3wNHb8D0NWTu1MC7uMUQNUFp9nGb7RknARRgSHs9VfGBA2p93w6
 bBcA==
X-Gm-Message-State: AOJu0YxOK57F2c0pujSi41H0YnYRp61gPSOKzW3tD6mEAF9kRi87y+Dn
 4H4EQyZStac0QFaDkQZ3mfrqiYMhRqwz2Ps3PBj2u6EY14XpLw+TWXuyaYqc89RR7WuQ9hjFCn1
 fuihptJk8taO0JEZYQCblvxpNdkF25sg=
X-Gm-Gg: Acq92OGxPzXByMct565yUFzD9U997SBuwe8VJKydv3BcTmkNCLqONUP2MAr2Ej6ZTZV
 xFTKGd4WaoQXYBiwCRSyNBr9HasaWDnxpgLZ/9m/UPNQWsdY6Tg5nxJDaVdi5IrZfx+PFDhpy8F
 NWtBfeSujH9gOttOfOqngCKlcgBtUXcybnNmWnYwkKpEfhPqIhz3Bwtj9dsude3+cM5uUEqBx3A
 nQwIvx/YsbQ1fAD94i+F1fyhM3daasdePJe7EfoYudGcrGJ6N57knTV0umgDBVEOWV76oOoJ/1B
 7ShelHIOj16VcPren+4MnvVFjyb50MSqzfbjZQ==
X-Received: by 2002:a17:907:199a:b0:bcb:4046:63ee with SMTP id
 a640c23a62f3a-bd51792a4demr965726766b.31.1779164361170; Mon, 18 May 2026
 21:19:21 -0700 (PDT)
MIME-Version: 1.0
References: <90ffd339-28f0-46e4-bc3b-f7aa650df1c0@oss.tenstorrent.com>
In-Reply-To: <90ffd339-28f0-46e4-bc3b-f7aa650df1c0@oss.tenstorrent.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 May 2026 14:18:54 +1000
X-Gm-Features: AVHnY4IBMLdiuWh_ghMMr1SUTLBnESrCIxq4wjlImC-k-epFi34ZSZZeyzLtHwU
Message-ID: <CAKmqyKMP6=Fr5ycft-MNNYr2DJfGyAfR9QDpTCzCUKLOaVg4ng@mail.gmail.com>
Subject: Re: [PATCH v1] target/riscv: Make hpmcounterh return the upper 32-bits
To: Portia Stephens <portias@oss.tenstorrent.com>
Cc: qemu-devel@nongnu.org, stephensportia@gmail.com, palmer@dabbelt.com, 
 Alistair Francis <alistair.francis@wdc.com>, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52a.google.com
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

On Tue, May 19, 2026 at 2:04=E2=80=AFPM Portia Stephens
<portias@oss.tenstorrent.com> wrote:
>
> The counter value was not being bitshifted for a hpmcounterh read
> resulting in hpmcounterh returning the bottom 32-bits.
>

Fixes:  cfc96df65e01 ("target/riscv: Remove upper_half from
riscv_pmu_ctr_get_fixed_counters_val")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3498
Cc: qemu-stable@nongnu.org

> Signed-off-by: Portia Stephens <portias@tenstorrent.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

> ---
>   target/riscv/csr.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index cfd076b368..c522533807 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -1389,8 +1389,9 @@ RISCVException riscv_pmu_read_ctr(CPURISCVState
> *env, target_ulong *val,
>        */
>       if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
>           riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
> -        *val =3D riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx) -
> -                                                    ctr_prev + ctr_val;
> +        uint64_t cntr =3D riscv_pmu_ctr_get_fixed_counters_val(env,
> ctr_idx) -
> +  ctr_prev + ctr_val;
> +        *val =3D extract64(cntr, start, length);

Some patch issues here

Alistair

>       } else {
>           *val =3D ctr_val;
>       }
> --
> 2.43.0
>
>

