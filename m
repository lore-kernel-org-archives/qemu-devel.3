Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB94CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 04:05:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPBhv-0001MK-K1; Tue, 19 May 2026 00:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPBhO-0001Hk-K2
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:04:54 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPBhN-0002lA-33
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:04:54 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-bcd0111ea98so469608666b.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 21:04:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779163490; cv=none;
 d=google.com; s=arc-20240605;
 b=fU+sjl0aaOvRwd0VcWm/LAdqloJybKdbOkA1wWXktsG2iZCCL1VDnX5MB5oQs0l9pP
 BNa+LHZGZITydvOZ2sbAZbiqaq7UMa9hS7DmWx1sC9fk1+gOsmTuGuywc4WeoL4qTiYI
 CVJiBn2eMt9RrI/2lm80qo+cWG3JaDQAGJcxEJDbs8wN6X9x3QylaTZtFCt8f+JXh4w8
 6U03gy+U91uW0Ayg8FDl98afShO/syfcrt7/o7fjC09iSNXgqdTKjcZaCMosZQ1ARP8H
 QjX+62sJ+ihu6thqRrfLJ8X9bOqkxhjzvvwR+UExv85/rzyeXq7rVnvJn1QGCFb8vR2a
 7ANg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xwG8JmYk5UK0YItRC3MUXzAV/qcPDOXekEExLds9/kw=;
 fh=+dPXGxW3pQNYFrTSil53fSXYfdhGIs7bI6Dyql1Mx+Q=;
 b=IyIE5umhMtqq6xma/pYQvrMQjyZo5/aJZOI0H0IPYZlzTaUjWEaneFqG4cTbGky0CO
 dA93Rv/XMFSUe3wS0LKSs8QpfyFml2FHJz09NDrKx5qygGLkYlBqEol0zBeDJmn8JqB4
 eIVCMxXs0T4N+sFBtUc2d+238NBbVZG4Yc2IPKvADvjpbsOf0rw+g/FSFWz9qpVVKqAQ
 PlwBsYqb1jTBkh5lNG7xh33nMGvzM6owv7IhAnKRetLDna3z5t/9x9ec38Qd55mTzFYR
 UvDMwtlqu+XdkzAHsbIZvrx1+0yOz8HJ/9hzjUjG/DY8IjeRm1//wASPEbwSHealB2br
 ezqQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779163490; x=1779768290; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xwG8JmYk5UK0YItRC3MUXzAV/qcPDOXekEExLds9/kw=;
 b=PQXbmW7HYUiycJlai2GeM4GuYgq0u+5ZlNliBM/3zQ7b19jOb918YK8vv3VMmn8wev
 DD5wkN5DXmbK3KDuJA3R6O5pHyeG6xQDgRseEvfJ6WKFIkYPL0Ch342QBrgENsxiiX/v
 jwPQbA20KEnujoRQOdbMAs8fmfG/qFuDMzydOwJkmTSSFeCPJxsg9ip4mj3DKgWQKYQz
 JNANWgxZLddLiAr6nzo9upPo3HkIP2GudZyLAZdzpR6pyK/R8EXMsPngdY2p4fJZLOSy
 1+f86WpdbNnsnxbSwdHdKO+D38EkPwA904cIr6qIUIYSCSkAJQBKv+ZvQHy/7LlSO9V6
 r9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779163490; x=1779768290;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xwG8JmYk5UK0YItRC3MUXzAV/qcPDOXekEExLds9/kw=;
 b=Xi84TNpxTOSYtqdL+lESfXxY+0fTnCrgt13T1hI3jtR75YCtCpC8r/bWq4TUb7PsMY
 TfJleqadmFJjuu2PsngDFqS6qQ0jdViAQ9/svzwYDqD5uotSAtGYMNaVxKo1UeC8wvgC
 Z8smKEme2+Si4Wn54rR0AdPnChjP0mt6UnQ+F7YLuUt2SdTtRKzE8y6WV+jyWTQxqMHP
 GcyNO/de3SqHLhJMyQJBP+MaqZ8kgIps1a3r3tXnwS9jsjdru8JcniFyC1FHl1q3A4FZ
 3aV0G02t9cSTsET+8sZsbjY75evoQJv9jauYzLqqehSl2dJC0o45ui4DM+PqWMw9UQkQ
 I3ow==
X-Gm-Message-State: AOJu0YwKHuUipSjwr3vA0ZRzYF0vDUhcTPoDbdoMOpgDxbHwg8fe0uvh
 bor3LNOVWY7cKCvMeu6wZQl1dp17OKB4dRl2g+3A/aoYqd+3cqz67VbKVpGCYETWQAbQX4qc2hU
 40yI6KADuIUN2Ymg7H6jxoKiJsUE2Pz8=
X-Gm-Gg: Acq92OGnkXbrLvVcymVHkZ+Rx7QGnwkOgADu3ONW6lu2550iUZNwWka7WmMeoTO9Qhy
 gtrFvggiAYVXyVZQFZqyvgjIqAvW/wjr19MpoFOW3EHBzg5GC/javY95k7PO7Cv2sS5VgQfInKM
 myVLrXxkXfjcl9GZNHqyGopJii2hHTK7IvDZ8VWTI26FctqvnCPwex4BsBR5OzkWXCZ8pgoJWbN
 MGVNBRDioDNdesnfoGY3yH+kfB1Wz2+XkX3Z6K38PHOCLAfwhsIB/JQNSyKDiMLxDWoIJumcp2i
 EHxpCymmlJY0ZckYA1axtMaMYEBSpIQpBub0klu8qWng2sQR
X-Received: by 2002:a17:906:fe43:b0:bd6:6b24:49d with SMTP id
 a640c23a62f3a-bd66b240a81mr586812566b.32.1779163489695; Mon, 18 May 2026
 21:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
 <20260512032926.1978818-12-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260512032926.1978818-12-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 May 2026 14:04:22 +1000
X-Gm-Features: AVHnY4LDDoXApQA6-PtV1d9mA0o_FfR3iEN-0nYUiUA_NTNjfPdcjlv2NywQO_s
Message-ID: <CAKmqyKMo4o3559WAoyPN0X6dcuVUf8kA+3QnpqjchH6TzY57Cg@mail.gmail.com>
Subject: Re: [PATCH v2 11/14] target/riscv/tcg: use cfg_offset as
 cpu_set_multi_ext cb opaque
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62a.google.com
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
> The cpu_get_multi_ext_cfg/cpu_set_multi_ext_cfg callbacks are using a
> RISCVCPUMultiExtConfig pointer as opaque, but internally we're just
> using multi_ext_cfg->offset.
>
> Use multi_ext_cfg->offset as opaque instead.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/tcg/tcg-cpu.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index eb48a76a6d..50d9218a75 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1510,8 +1510,8 @@ static void riscv_cpu_add_profiles(Object *cpu_obj)
>  static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *n=
ame,
>                                    void *opaque, Error **errp)
>  {
> -    const RISCVCPUMultiExtConfig *multi_ext_cfg =3D opaque;
>      RISCVCPU *cpu =3D RISCV_CPU(obj);
> +    uint32_t cfg_offset =3D *(uint32_t *)opaque;
>      bool vendor_cpu =3D riscv_cpu_is_vendor(obj);
>      bool prev_val, value;
>
> @@ -1519,9 +1519,9 @@ static void cpu_set_multi_ext_cfg(Object *obj, Visi=
tor *v, const char *name,
>          return;
>      }
>
> -    cpu_cfg_ext_add_user_opt(multi_ext_cfg->offset, value);
> +    cpu_cfg_ext_add_user_opt(cfg_offset, value);
>
> -    prev_val =3D isa_ext_is_enabled(cpu, multi_ext_cfg->offset);
> +    prev_val =3D isa_ext_is_enabled(cpu, cfg_offset);
>
>      if (value =3D=3D prev_val) {
>          return;
> @@ -1535,17 +1535,17 @@ static void cpu_set_multi_ext_cfg(Object *obj, Vi=
sitor *v, const char *name,
>      }
>
>      if (value) {
> -        cpu_bump_multi_ext_priv_ver(&cpu->env, multi_ext_cfg->offset);
> +        cpu_bump_multi_ext_priv_ver(&cpu->env, cfg_offset);
>      }
>
> -    isa_ext_update_enabled(cpu, multi_ext_cfg->offset, value);
> +    isa_ext_update_enabled(cpu, cfg_offset, value);
>  }
>
>  static void cpu_get_multi_ext_cfg(Object *obj, Visitor *v, const char *n=
ame,
>                                    void *opaque, Error **errp)
>  {
> -    const RISCVCPUMultiExtConfig *multi_ext_cfg =3D opaque;
> -    bool value =3D isa_ext_is_enabled(RISCV_CPU(obj), multi_ext_cfg->off=
set);
> +    uint32_t cfg_offset =3D *(uint32_t *)opaque;
> +    bool value =3D isa_ext_is_enabled(RISCV_CPU(obj), cfg_offset);
>
>      visit_type_bool(v, name, &value, errp);
>  }
> @@ -1558,7 +1558,7 @@ static void cpu_add_multi_ext_prop(Object *cpu_obj,
>      object_property_add(cpu_obj, multi_cfg->name, "bool",
>                          cpu_get_multi_ext_cfg,
>                          cpu_set_multi_ext_cfg,
> -                        NULL, (void *)multi_cfg);
> +                        NULL, (void *)&multi_cfg->offset);
>
>      if (!generic_cpu) {
>          return;
> --
> 2.43.0
>
>

