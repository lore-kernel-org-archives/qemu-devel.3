Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64665CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 04:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPBic-0002K5-6f; Tue, 19 May 2026 00:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPBia-0002HP-44
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:06:08 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPBiY-0003IO-JC
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:06:07 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-bd3eb594960so386348066b.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 21:06:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779163565; cv=none;
 d=google.com; s=arc-20240605;
 b=fAIBopyBAnoU2Wgu21vVTczZ/KUFhdLj7zeBC9rzI0hySvZgSrfvQMN/Ht/jeQ0s/k
 Yh/PuAV/d5Vs5dkt18i9GKh+b/cL3KeXI0i81gpEslrxFvvZKpzlZ2dUMIR+3k9YgxX7
 7M5UTLB9Bgw6SfMfFNE8pQSVSDcWl0AQqF4nhEDWBPcgah5wFt0ftvZNuLwecSjNDP7D
 HTg+cEO6q4EQLwvqDKSnwDkWJwC4tuRjfBeMHN3iNC4ub/t/fV5JKaJ49TV9YA2yjoTH
 EQiwS12nJmst/R1SXqCJmsw0yCIVCyPc8Z4nrrN88b3aeXPsKsIt+Rb1ERH3zY+TmSLj
 Rk+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nnOUL0jOjQyQ8UGODZdjAG29PM3rmj54nR8ku+r0o+o=;
 fh=+dPXGxW3pQNYFrTSil53fSXYfdhGIs7bI6Dyql1Mx+Q=;
 b=Yzh3qztM3nNHEljTfOwD3lHHFORXZsBltD6heVOdNyO+sdPRpYiuNUj2RjlVITpSX8
 DzSp0WNjB6JPwNJPyJsTuvIM9CW1c/wys+ebsRRtlw8oPl3rw2RHw34kaZ+6iyrAr4l4
 HNYO2FHCb6QRRLQuSp9i0Vz11Q4BdhLjgQLOZk/cAX6Y0ZgFIOgBnne5YSVg/L3hwTwU
 69bCWrxZzJeQd1G86xL95b1qGvqLb+6edOMco2nykfSzClRrPTbyfZ3wK/lmNOWJQ6Io
 4oDud0SdThgRlNXxBNmd9AeCMn/qJKW8BSdvgU+y0to0t+po123XXUj9jrl4VFGWo8jQ
 vSFA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779163565; x=1779768365; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nnOUL0jOjQyQ8UGODZdjAG29PM3rmj54nR8ku+r0o+o=;
 b=U7GrJ15tfnLtHdZTJhVheOPfFxv6zvKiXtmwQNArMPkWpxvPQAXtz2RftfXcbNNN1d
 WIxqYCX27SMM/0emiHjcdJbaQYjTKA9JmorUw1int6CIxcEKt/J9MMORdRJrq9+0IJQD
 TLA8LbghK+AknFU7sEZLbM5OvihTOKltf/fLiRRSg2eJIOBCgkK7ZThjpH2rcU+cxGuw
 pOUEftqbyFTJJoWHn00Cy0T9taRQrTHgiBm9WraKJnz8Kj6wxCEKgjqbW7yxDDX07jg7
 It/wkXHJQtOmq3lYD/znTmZ3MsjUoDVODRVEbx6CRVo0dWjrlZOcAicLaXN781BdXI7Y
 m+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779163565; x=1779768365;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nnOUL0jOjQyQ8UGODZdjAG29PM3rmj54nR8ku+r0o+o=;
 b=Nc0tTY5Cxrv9mDNweT6Wgdctr9CR3AaKREO8zBnfWztsW5qXblgrfGQyj2oP7cO0an
 GIYGub5DlcmjTLpMuuvBZUk+2NiCPjHvReCErcZStpo0NkKncKI4L7NRE61lCD8oNRL4
 HqdLuVR+4w/7UwdACTiTstpdDs3g9HG35fLXER+ZT6VU3S2cownmOikr/f1+gdZZx/r2
 TgYhpahZMsQRiGT6w73lJ8QyIQKP01IX/YCmdSDoCp5G9+1V3V5lWbmFq9BOE9VB4LyO
 UYXsj7Vdq8MDooKA5u1EPKTfdHYRILOekRwncSxcCoV+GupCXcvOHdxt8HlBrHIu8SXv
 tpQw==
X-Gm-Message-State: AOJu0YykJeQa4TzVSv/puhaGwhHSOrN5ysxiBD1k3ZmFN4MWLCSUGYcD
 Hng7YoO9AVhoNfvGP5uGs+rKewHryfgKKXWv3pB1XZHCvRly3W/T+iFdpc843hHlRrjfVW0Otsq
 5Mdt7CS2ZcLsDyzcFhEnrwGGvQ+S9X+bYwaqh
X-Gm-Gg: Acq92OEGGWNrdCwtluWiENYvChDLYSxIgcWjzMpj2TqdB3zccGZ41q056Gci48K8r9F
 /iVulqWlURsSR/F6feVDagjfVH94Nuriaw1dCEdG8NNTP2nrVC6vA3241JSie/eJa16qrJWr1Bs
 GnCLARrrgM/ewNXz7iJPe8vP7V6hf6tSuhbSOqDjNDHau30QbP/8Ek4yWUeIp7aJDEWXHIcFw+Q
 b5cD1XtalXMlJFAMcCqh3iZRyoqb0h+Zhprs5g6Qu+hSYqe9u8X1E/q0Z89tGFjk/aHsrKuF3bO
 U8Xvp6wbDIHpFwMkL+7pvWdwoVPzuCzqvRg0/A==
X-Received: by 2002:a17:907:26c6:b0:bd8:1537:d63f with SMTP id
 a640c23a62f3a-bd81537d682mr321920966b.37.1779163564764; Mon, 18 May 2026
 21:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
 <20260512032926.1978818-14-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260512032926.1978818-14-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 May 2026 14:05:38 +1000
X-Gm-Features: AVHnY4Ixj8wLgpBmh59CdI4CdxP7jw0-CQWVOnaUMKvMajCgxWIvuzLKWkyhA_Q
Message-ID: <CAKmqyKM-_A7gqT3nH93p=L06dAC7Z1hCazX6briFfLe6oW43JA@mail.gmail.com>
Subject: Re: [PATCH v2 13/14] target/riscv/tcg: use isa_edata_arr[] to create
 user props
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
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

On Tue, May 12, 2026 at 1:30=E2=80=AFPM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> This change has been done twice now: one in riscv-qmp-cmds, another in
> the KVM.  We're now ready to do it for TCG.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/tcg/tcg-cpu.c | 34 ++++++++++------------------------
>  1 file changed, 10 insertions(+), 24 deletions(-)
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 7575884d7e..3e22e7ed53 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1550,27 +1550,6 @@ static void cpu_get_multi_ext_cfg(Object *obj, Vis=
itor *v, const char *name,
>      visit_type_bool(v, name, &value, errp);
>  }
>
> -static void cpu_add_multi_ext_prop(Object *cpu_obj,
> -                                   const RISCVCPUMultiExtConfig *multi_c=
fg)
> -{
> -    object_property_add(cpu_obj, multi_cfg->name, "bool",
> -                        cpu_get_multi_ext_cfg,
> -                        cpu_set_multi_ext_cfg,
> -                        NULL, (void *)&multi_cfg->offset);
> -}
> -
> -static void riscv_cpu_add_multiext_prop_array(Object *obj,
> -                                        const RISCVCPUMultiExtConfig *ar=
ray)
> -{
> -    const RISCVCPUMultiExtConfig *prop;
> -
> -    g_assert(array);
> -
> -    for (prop =3D array; prop && prop->name; prop++) {
> -        cpu_add_multi_ext_prop(obj, prop);
> -    }
> -}
> -
>  /*
>   * Add CPU properties with user-facing flags.
>   *
> @@ -1579,15 +1558,22 @@ static void riscv_cpu_add_multiext_prop_array(Obj=
ect *obj,
>   */
>  static void riscv_cpu_add_user_properties(Object *obj)
>  {
> +    const RISCVIsaExtData *edata;
> +
>  #ifndef CONFIG_USER_ONLY
>      riscv_add_satp_mode_properties(obj);
>  #endif
>
>      riscv_cpu_add_misa_properties(obj);
>
> -    riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_extensions);
> -    riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_vendor_exts);
> -    riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_experimental_exts);
> +    for (edata =3D isa_edata_arr; edata && edata->name; edata++) {
> +        if (edata->prop_name) {
> +            object_property_add(obj, edata->prop_name, "bool",
> +                                cpu_get_multi_ext_cfg,
> +                                cpu_set_multi_ext_cfg,
> +                                NULL, (void *)&edata->ext_enable_offset)=
;
> +        }
> +    }
>
>      riscv_cpu_add_profiles(obj);
>  }
> --
> 2.43.0
>
>

