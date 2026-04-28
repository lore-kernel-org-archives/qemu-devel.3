Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5979FF8867
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 02:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHY3r-0000C9-Mp; Mon, 27 Apr 2026 22:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHY3p-0000Br-TO
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 22:20:29 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHY3n-0006bn-Sx
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 22:20:29 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b8f97c626aaso879616166b.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 19:20:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777342825; cv=none;
 d=google.com; s=arc-20240605;
 b=U42Fj1be3AHdGsz4XWINr5XntRALjaJC3wbOWwfaxxX8oZ8qCmH7jiqPc7ygf7iibE
 aGdApYyaQm6S/po+U2NsscT7HNt2jxCG8m7DXIMncW9lZRi+rc5ZcM7B77aeMYLF/2kN
 MX0XOJkK+zZfsEROnqr9QKCk+3WW/M8x67INDT8C86qkGeukhs+bc+BnP+tZFcJ5Hjor
 GkpR2JbMn8I8umDUzliw4gRbtrmtjaUdVt5vuzN1tgvNHlihv29Dh6ff9oyqz8kqhKNi
 B2cFyp+vrgKJh10gT5FiMLD75LvfCdx3J427U0G62UgPPQvQLFsl9g6wFpVSgCvW7JtZ
 HRWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qOUkFDwsx2H385bDqa4mSjkalmJd8rNY8ENVpk8rETI=;
 fh=YIM9f+9AkDlR8k7CEzJDyJruqgjM59fv6z4QlF2aJX8=;
 b=cOejpRX84ijWU/IgJLLAdaeVd3XmrlKT7bHj0ily78BI44lwpFaeoblfPJgdfAGU4S
 EwDxo/E4fNOY4vskD3vgKqE9z8sd5RNX+jz3TQMXwJBs3OxE6z4GW/yB5DE3/dFbYV4U
 jc6XhlOEdLgYqZkqbQjSDrnI284/GojxKRWH0KVjqXlbwfCpRZmfvkzsqCpHZTN5AZ7V
 a1tWnEdDjiI7/RVKB1ksbx/mEZIGUahhI5cARXQSDHUXpalB5pNIdpl4LhmWWDWxFm4X
 Ijflm9ldKBeRcPNKO2Q6zFPuGI2Y8Qyp53/jAkQpE7GFpCcPAWMj4oAtAQqBshWFgDdY
 q3VA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777342825; x=1777947625; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qOUkFDwsx2H385bDqa4mSjkalmJd8rNY8ENVpk8rETI=;
 b=crhFhyU/rjLEUWanueL0DNZRN/Dh5yD5nTTprOy+E5hQdHWtGDE43yslwOrGlEPB6e
 sKZJMr3CfAnvj2NoHiRpclOhixBeYru8DqPcZAd8TUoffyvfoa9ZwY20wsvW9JmDzxPA
 M20A4ENgJIaL3Uy1UT89sGLcmebcGeyUMz7+LogdbgSLwqDDCdxlsikOvzFoe32ZBY+b
 FNQP1D8FzdsgxTfVQB1+PSNlgzOlRROastlOTxsPZ+lnSsCX6ResYpMYVmAkEup6uhpT
 2RoDzUuVHiJxCXI+OmgqT0VlQh9d/f+s5okv1AENTKTaoY/Uf54wj4oRsVZhUEK4eG3i
 yjbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777342825; x=1777947625;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qOUkFDwsx2H385bDqa4mSjkalmJd8rNY8ENVpk8rETI=;
 b=iFX/0coZv3LWJTeKpPKUZl1MtiSbVtBbyq9AK729cBrMNbZrZOfbgWFGz+k9malJrb
 JbIQvHTretG5lYt34MtdOvESCqfBBHhaG00pdJZLwS9NOiKN7kEYau6l9F3r5a2Pz3P9
 JciYKN72xU7oL3nDDAoD+X8LMeTqjTrUNXFuKOp0+fkxMNkrF52bQL8oOlG/L7YIhBZ5
 uOgRYDSSWMROTNLZyohedeh43KD7OO2RcQ5VB7kO5FBE7coG7NHc1MeVup9qbfai/9hY
 Eo0NNnUcBv9dUlRZjUIPCPHRn3MMAlOqv5KrYogKhKXgtccu4PMz+RvYc0tWUZhaqeJI
 bAFQ==
X-Gm-Message-State: AOJu0Yy8ytlEDUnxsOXiLk7tAiRe4nyRo1tbVTJMbUmeu6oWi84UziXd
 vZPdvP/VBYnRKuxCbwgkUvnSNC8R3ya/FcmHb2BFVkupNeGolL9ayYiQzZwLGwG84kVgrgIScLb
 fZAW98NJTKpY3+yxg30YSJgknSJ8xH7c=
X-Gm-Gg: AeBDievfSgX1+w3NbLZUYNd0yNpZQ7MyprfPveFf4cOZipN8tbiEgkt/XxoS246v59K
 R14uVzkshco/7Ek0DMXMDqs2B5VKOi4M0c+rmvHPvwyDUVeUoxJpnv0uKmDa8CwVbRSBYTaqWj/
 CjQXeY/eKB/zNbp1uonB/jwrIzXmd+CCm7l8qXITQj0ZoKf1JT5asAXbXe2YLucDS32A+7XurE3
 OraVBBIkS1Ozb+7pWIBS9ToVZNmnICVlSfHXB84fwIDBtfe5VeG+P9psU7beWxga29jUigzM4h2
 5ABb1bH1j8BlVD+2munDtWAsRbkx6yl5zfViHwdgEjHH8PRD
X-Received: by 2002:a17:907:d303:b0:baa:65b:fe43 with SMTP id
 a640c23a62f3a-bb804c33104mr59213266b.38.1777342824714; Mon, 27 Apr 2026
 19:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-39-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-39-c413f3605311@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 28 Apr 2026 12:19:57 +1000
X-Gm-Features: AVHnY4KHytxvJSxfL9Mi32sfzwGgNuwEo0mrkpe_Nkn0-gZikn3v5IQAATFO3q4
Message-ID: <CAKmqyKO5bfV0gNgUCHAPO=32SgWGwO_sGRng6p-5jF3yogTkJA@mail.gmail.com>
Subject: Re: [PATCH 39/41] hw/riscv/virt: free flash devices and OEM strings
 on finalization
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62b.google.com
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

On Tue, Apr 28, 2026 at 5:49=E2=80=AFAM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Add instance_finalize to free the two pflash devices (when unrealized)
> and the OEM ID strings allocated during instance_init. Fixes leaks
> found by ASan.
>
> Fixes: 71eb522c4063 ("riscv/virt: Add the PFlash CFI01 device")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index a1c323e66df..315049bc86c 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1745,6 +1745,19 @@ static void virt_machine_init(MachineState *machin=
e)
>      qemu_add_machine_init_done_notifier(&s->machine_done);
>  }
>
> +static void virt_machine_instance_finalize(Object *obj)
> +{
> +    RISCVVirtState *s =3D RISCV_VIRT_MACHINE(obj);
> +
> +    for (int i =3D 0; i < ARRAY_SIZE(s->flash); i++) {
> +        if (s->flash[i] && !qdev_is_realized(DEVICE(s->flash[i]))) {
> +            object_unref(OBJECT(s->flash[i]));
> +        }
> +    }
> +    g_free(s->oem_id);
> +    g_free(s->oem_table_id);
> +}
> +
>  static void virt_machine_instance_init(Object *obj)
>  {
>      RISCVVirtState *s =3D RISCV_VIRT_MACHINE(obj);
> @@ -1984,6 +1997,7 @@ static const TypeInfo virt_machine_typeinfo =3D {
>      .parent     =3D TYPE_MACHINE,
>      .class_init =3D virt_machine_class_init,
>      .instance_init =3D virt_machine_instance_init,
> +    .instance_finalize =3D virt_machine_instance_finalize,
>      .instance_size =3D sizeof(RISCVVirtState),
>      .interfaces =3D (const InterfaceInfo[]) {
>           { TYPE_HOTPLUG_HANDLER },
>
> --
> 2.53.0
>
>

