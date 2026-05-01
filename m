Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73EB8FF8864
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 03:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIetM-0004JR-NU; Thu, 30 Apr 2026 23:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIetL-0004Iu-03
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 23:50:15 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIetJ-0003eV-Bw
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 23:50:14 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ba545100a13so290165966b.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 20:50:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777607411; cv=none;
 d=google.com; s=arc-20240605;
 b=AUIIJawpkDAdcoIm4PgHOVe0MZVHTMBNsWi13ZHGM5OwVx3o+OsK4zRuSsbkXa76C4
 hK8ylD3dww4gVRPxwS/OrBNo4l7ZBziqcBFpN1vmUQNZoxA1HvqEqh4y19qc/I0Wt6a9
 XEqQc7HEqiM69QHjN6uG8DIEChQVBjWtWNDsmttw3irrf7oFxRkDR5X6s3eDPpenOeMm
 KjHgko2D4GUgftoupEYsxpNGev8HyY5luwUQ0sJBzOtpKJayJ5i/VKbrSIeegBPklHfj
 DloBrOp4TkdgZ6vC7rGgfXoNWqzjewKpBhE3RnQo4J3rMW1lw/ZH09WP4u+KboAg3tV3
 d0Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TF1ML5GDLDpVD+V5jPOOPurViaNM9Bv+vY7tZN/fVUc=;
 fh=9ZBm7Jeorp9wSVPYF5AiPBCRDB4kcVwmpribd+uGcX8=;
 b=Q4jxvmzEwAdfWnYwUQetV4/GdfN8MD0VEO5bPvTL8Doc6ZOhSQUn6xl6nE8XEKW4j3
 U3R9voHZ3d1gR4dIcFqnpuJseKyPad41gQyq0ONd89LFSshzhHgolfhF95OYwdzEsniJ
 i6tkD5ep/1Lu7Zi/j4uRAz4ZojC5bmposqzDzykKJKxbJxemH/NlX7Wd+W/k5Hmz/YQD
 eh2fvZdJebxUOb0DsnxRSde0QTFG72uOGAjwu2HnHtrO35rP09SKf5EYSzmn3u0UIlpG
 /JRQ25M4fFStTpt7TVu7GR7oEvNgDAGMjZORpS/XA+WwIrs5v++Cs/d+jEwJp+AYNyiX
 QtMA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777607411; x=1778212211; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TF1ML5GDLDpVD+V5jPOOPurViaNM9Bv+vY7tZN/fVUc=;
 b=cICS5C9GqML4LufEL2xPpHedwHRbtpKGetLfXt4yDXgaNsoOeC0BYy1sQyk06m4CrK
 AogDc5zzo1XQgnLhPFvM9a3xYTu8tZJYzwbT6p11FJylrXldoZ4d7uit8R1OL2/EwPfZ
 3yKuMMxLTYEW5dVON4U7zXaqX5hA7GHg53y+KQEP234WYYex/+xmouGwZU4a9uuiL7a9
 3a3hCG7fu8JdNXenAiOy//t/MflS9nJ8QqzTt7NeSiEyaGEKMsCJDYDzH6QKlFZ9zp2K
 NoVnKOwpuyVPQYUf09v6Ur3EWXc131Ry9GLqSVUVhRTaQs8IF6bdLd10LcliPCrD07HR
 06jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777607411; x=1778212211;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TF1ML5GDLDpVD+V5jPOOPurViaNM9Bv+vY7tZN/fVUc=;
 b=YQodeY5ddX2sI1YohHHjp+lYlxHFnD/NE6NiKBQg/scni5SjtCxFJdROQzpWlVf1F9
 zJu3bVQw2AcxTpvps5wNNt3zX+PJU/o20N3nbp7jfj1XLsMjCTVrwQRIgnKQGlt3zgl+
 ZWqd2GT1eVcgaTRjefd1kNEiO68ZqxUDmk647lECRlkGog/4Jb/Y9lnePMhEjD36dVi4
 wv88ZMi6S0MCAtjIZokPWTlYEYnkWIjvfHBaZAIYWQfqk+PnwBHs4Bpqw+8eLznaqqPa
 PjwkoRYAWoi2FXa3Kj8KxMjS50h9S/p9Gc0krBhwhN37CuA06LLvHlEjlGvDQA65SF5S
 rpmg==
X-Gm-Message-State: AOJu0Yz85SdIWJs+eS1wbGbyMZGCC0pwdwLri5BayLzN75KlaOSXZVOX
 OnMJWQKlB/or2ufLCrBs1OSfYBl5zLbSUO8ry/X0E//OJOR/e6F+N7x0+7+5tLWb8MEJTms7IET
 MGQsVYkegPyRCU2BhNgpXVjjojqukCqU=
X-Gm-Gg: AeBDietYC8iXlkzikh/EIRBTiqB9EFVtuPSakmIVaadbOwmZ/ffG9SU4aZAn2l+ivrW
 2w9pYj4MqJ0rg3/fUpTXzC6h9o5rWWD98VwyQGCb27u5LlaiuLnNs0FThZzxjL5JCijApahwVU2
 BdEA+H5CZRw/oqFvUY/Ns/sC2c/23QcLD97MtSDOXxubflfdz99Hnpjxt3kqGpP3uc4W80lLOrk
 w6Ha6NM/K29V8hiWcwMZcJ5qE6wF8hPCcULqMafUHA6Re9eCNWDqIUBbUQCM43ec5F1l0R1oO6e
 ol+06dVttXxVWj+HnlSCauarL1d0lWiM4n0uwUCdqYyM+WIG
X-Received: by 2002:a17:907:3e9d:b0:baa:67d8:9106 with SMTP id
 a640c23a62f3a-bbec10faf28mr60132166b.36.1777607411206; Thu, 30 Apr 2026
 20:50:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260424102800.24022-1-frank.chang@sifive.com>
 <20260424102800.24022-2-frank.chang@sifive.com>
In-Reply-To: <20260424102800.24022-2-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 1 May 2026 13:49:44 +1000
X-Gm-Features: AVHnY4Kx39Zmkxe-gyvLuZ6OLx0Yxpfurzd-wVHSU8eK03N_wFrsdxKt_blE6o8
Message-ID: <CAKmqyKMWxQGBsS4D+=Bz0vW3+GYjsedf+85hTBcVDwwND4YcQg@mail.gmail.com>
Subject: Re: [PATCH 1/4] target/riscv: Add Zicclsm CPU option
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Max Chou <max.chou@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x629.google.com
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

On Fri, Apr 24, 2026 at 8:29=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> Add Zicclsm CPU option so that user can turn on/off misaligned loads
> and stores support.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Max Chou <max.chou@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c                | 2 +-
>  target/riscv/cpu_cfg_fields.h.inc | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index ce15a17c37d..df56b64a736 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -127,7 +127,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zicboz, PRIV_VERSION_1_12_0, ext_zicboz),
>      ISA_EXT_DATA_ENTRY(ziccamoa, PRIV_VERSION_1_11_0, has_priv_1_11),
>      ISA_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, has_priv_1_11),
> -    ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, has_priv_1_11),
> +    ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, ext_zicclsm),
>      ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, ext_ziccrse),
>      ISA_EXT_DATA_ENTRY(zicfilp, PRIV_VERSION_1_12_0, ext_zicfilp),
>      ISA_EXT_DATA_ENTRY(zicfiss, PRIV_VERSION_1_13_0, ext_zicfiss),
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fie=
lds.h.inc
> index 734fa079f28..fc55dc6d892 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -139,6 +139,8 @@ BOOL_FIELD(has_priv_1_11)
>  /* Always enabled for TCG if has_priv_1_11 */
>  BOOL_FIELD(ext_ziccrse)
>
> +BOOL_FIELD(ext_zicclsm)
> +
>  /* Vendor-specific custom extensions */
>  BOOL_FIELD(ext_xtheadba)
>  BOOL_FIELD(ext_xtheadbb)
> --
> 2.43.0
>
>

