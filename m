Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3026ACD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 00:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOlSF-0005ny-A9; Sun, 17 May 2026 20:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOlSA-0005nc-H6
 for qemu-devel@nongnu.org; Sun, 17 May 2026 20:03:27 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOlS8-0002TH-N5
 for qemu-devel@nongnu.org; Sun, 17 May 2026 20:03:26 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-bd5047a2a4cso297340266b.3
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 17:03:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779062602; cv=none;
 d=google.com; s=arc-20240605;
 b=QpRIjP1MjCkTSJX/9jgxnhAYS04YPyOo7pjHJiQjX8XFytS6IhoOxCC+ew4xzjqGmv
 nGSipyC+opB3BJI/7F1kO/GXNWbM6KT9DP8MeU21wJSxydKw31N1XSBedvpFnITWtM1W
 GAgbbNm/5qqMUxJvjw4DZ9xjwxra1GZ5dwUdi/QqW/NFNvcwApoCKOgykn8wZUNvLIG1
 zxtAVXn3GIbrTKXpoWSS9sHMswbathOihcbYcnhl4wO86AORFpwrhOqNXwHyE0v8da8f
 Bnqn4axSxxjrKADoTMEAjQiIf/IGAT5Oj9I38jsiqJD5uU/EIrnUdpu1lTpOye0HAaT/
 6vMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=exPmyQcipQOaAC+sGcVsdC0Vk8yebHXkxAxpbQdbtxE=;
 fh=+dPXGxW3pQNYFrTSil53fSXYfdhGIs7bI6Dyql1Mx+Q=;
 b=cE2tWiH/cHbT9TTl2j+WMhmDhkwCKos+cKlihJoRyPVpNDcBHwmACHrSPXeJ3cKXPx
 hjLfy1NgclDYjn2R9VklLvkUu135bYTrdmtBYwR6nZL1jrDeIk0wVuv4MLEBVYXeQBTs
 Xiq8VZ6itdUdoadvf7NjAY14qKIJzMa1bLtDAIOj6TvHU9rbQy8UItxOGgD8Fztt30Ln
 zCx/6JqxImqB7NpTbsXZJumYCeyNsQpIX+82U0ePqvUhtPxgWqosHVWdZyHlmSpVBVka
 heVE+hcpYhUzOtgikoeoLyG3X6D3sEtyAEKkm7GDQg7p7+SbChinCEUq5uZy2S4a5rVx
 eqSw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779062602; x=1779667402; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=exPmyQcipQOaAC+sGcVsdC0Vk8yebHXkxAxpbQdbtxE=;
 b=gYTOIavDwNXlDoD2KYn4U3/9Mwv/InoOAneFw5VYBo+gX74y0hPFsDHbLM1K5zc06Y
 SrcmE1QVXgdZQ304U4sIdHFpLHuHBLwOxMmwy4FJhO9AXlfsYeMqEGmgsHBhkIpwbXK4
 2pRfHf+n6bzSzFH5Do6iDBC75xcikHS8KRne1GeG7tB4FFH3umoFf5FjZN0NrCAZ4lNa
 PTUC4fIa8nvAjs0KA9g7d7vCWlLFrvi6twVSjg2cgGiiq7/dsLEU2SYqSRg4xfiDxkgH
 bZ/P6Q+9tlYdBq6321/YVJ+w0uA1aASXPYNI8dVDa4XpXruGYJnsd9yXCekbPkGLn1K8
 oEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779062602; x=1779667402;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=exPmyQcipQOaAC+sGcVsdC0Vk8yebHXkxAxpbQdbtxE=;
 b=PxYftJtibnhl/aUyjBiIosf5V/7tcWXGLUJAITb5yOzFv+1/l5JcX6gvekg/OsUftT
 aQG5QiI+257GevO2zydDDU7w7q+Ll3jpabw6S/omnqrnS/yM8PmYsTlzAjWUQuEkGWOa
 PxKhaIVh72eB66KssvX9a2UNqHxsjOM7LdkfrACTLBEuryAiOVdEq6fC/t829RZ1VOLw
 HHPRzZEILZZHG2Lv9MSQm/+5JNxdMSQFJHbxLU/QJ7e+b8ch6iYl7bNT1BqJiqhd89C0
 eOImRT3K+ZlKtfMRsTYoTzkKsAvL1xremDHjFlmRtZCGzR1CTI7YF9I0PmcTr8Xv+bM6
 WvrQ==
X-Gm-Message-State: AOJu0Yx0TofEzSCw/SnEoPmpjqfCZQvw2z+1xx/iZsoB5fXs24BnJlYZ
 r59+dvJ1VKnUwJSmoLyhvgzmFfumdrK1Zu8wO4cO3lM6MEzrrDCA9TeRG9gRg8+6MQcUpjI1NI7
 0eKlGAptv01vR/qlN/KdrL3yl/c26vhg=
X-Gm-Gg: Acq92OGt2q25A0HoCANeAZOHRuIWQvBxsoTJZjCY+O4fazLmv7GMdBkry/dDnoerqAN
 +cc+eLUi230uChe5Q6jm8PobY7kVBFU3mMGmNbO7blZlEFvAlNfWY42ay0JKgvGfQZGWAEZrMkB
 xtXO6qc8dqmFwgYGCF7IlTE3y2S0bbofwDpz8TSKnQJkvttgHbkT3e3NLVZ6Gw2QMIV2P4i8v4R
 6KwI3ja2/OrVNR8XQ6cIN8B5XsiXZcoz6rZDcDjyVh6C82Ls7DCVr3BgcfbknqIsCT5tMeWPhj2
 jhFPB20xPStp89rhSG3kYaRCkMgMs4bVGKg4sw==
X-Received: by 2002:a17:907:3cd5:b0:bd5:61b:2a9 with SMTP id
 a640c23a62f3a-bd5179054e1mr586337966b.28.1779062601964; Sun, 17 May 2026
 17:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
 <20260512032926.1978818-3-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260512032926.1978818-3-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 May 2026 10:02:55 +1000
X-Gm-Features: AVHnY4Is4jwEGph-o1198Fr5YZmAom_bWmvlEMrlyczIswijA3JKneiSH8GE9h8
Message-ID: <CAKmqyKM7=Yptq_vphRdpz-QAnHVpLcBVo0+x3JtU60KUDZpA9w@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] target/riscv/cpu.c: fix smctr/ssctr
 isa_edata_arr[] order
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62c.google.com
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

On Tue, May 12, 2026 at 1:31=E2=80=AFPM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> Noticed when realizing that 'svadu' was too far apart from 'svade'.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index a9d9d16c1f..ee8f6e5296 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -222,6 +222,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(smcdeleg, PRIV_VERSION_1_13_0, ext_smcdeleg),
>      ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
>      ISA_EXT_DATA_ENTRY(smcsrind, PRIV_VERSION_1_13_0, ext_smcsrind),
> +    ISA_EXT_DATA_ENTRY(smctr, PRIV_VERSION_1_12_0, ext_smctr),
>      ISA_EXT_DATA_ENTRY(smdbltrp, PRIV_VERSION_1_13_0, ext_smdbltrp),
>      ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>      ISA_EXT_DATA_ENTRY(smpmpmt, PRIV_VERSION_1_12_0, ext_smpmpmt),
> @@ -235,6 +236,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
>      ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12)=
,
>      ISA_EXT_DATA_ENTRY(sscsrind, PRIV_VERSION_1_12_0, ext_sscsrind),
> +    ISA_EXT_DATA_ENTRY(ssctr, PRIV_VERSION_1_12_0, ext_ssctr),
>      ISA_EXT_DATA_ENTRY(ssdbltrp, PRIV_VERSION_1_13_0, ext_ssdbltrp),
>      ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),
>      ISA_EXT_DATA_ENTRY(sspm, PRIV_VERSION_1_13_0, ext_sspm),
> @@ -246,8 +248,6 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(ssu64xl, PRIV_VERSION_1_12_0, has_priv_1_12),
>      ISA_EXT_DATA_ENTRY(supm, PRIV_VERSION_1_13_0, ext_supm),
>      ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
> -    ISA_EXT_DATA_ENTRY(smctr, PRIV_VERSION_1_12_0, ext_smctr),
> -    ISA_EXT_DATA_ENTRY(ssctr, PRIV_VERSION_1_12_0, ext_ssctr),
>      ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
>      ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
>      ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
> --
> 2.43.0
>
>

