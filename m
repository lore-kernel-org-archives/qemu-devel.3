Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D1DFF886F
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 01:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wId52-0000rc-VO; Thu, 30 Apr 2026 21:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wId51-0000r5-Cn
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 21:54:11 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wId4z-0001DN-L4
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 21:54:11 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b9382e59c0eso260921966b.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 18:54:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777600448; cv=none;
 d=google.com; s=arc-20240605;
 b=S2F3XYdRY6enjT0SFUrodYD67d4bwpaxE25aLjXC9YsNAbEdaSVdnZhxBs+mORPCA8
 RyK+o4Q2ZfGtca3XAGu3gLPOFY75cEGQuWRsOTg2znNWTSHg+qgrQfVgtQQhcEKLUHuG
 6WvLMkhafUuS3bOCQ1fleoRy+2pz9nwiXX03dcLa974l5h5iVifkq/MTq/bPcRcqK5Jj
 CcI+WydIlC7HqBTJcvVQKl+Mr6X1Q1IIE369nJkkcsS7WQ7jaB00HrmRcjPXej5SOVk8
 1o+XXE1Z1nuf9+LD1QZgQqXMU8x8TopqFDsH/34QYwDOd9gs6rbPB1mKYeJtWDF0vcET
 FL1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ircn2BEjGgDpdelDeQ4S47x0YWnSsTew6kHFdCmEDF0=;
 fh=YIM9f+9AkDlR8k7CEzJDyJruqgjM59fv6z4QlF2aJX8=;
 b=etdBOQGFWG1keNysLCnuCClAuyufsERMr123PscunfwaBnDFVOhMnE+4wcP/P1Xp9L
 Ywqgv06HkIKT/Z1vs3GhT7lpYipm9OoIPlBZswDP49j1fFB0c54AiDqgeblCbxuhBtnZ
 THcxu4fFRDWWMsEqcNy1yjSyHfu1ATPGM7sL35IQRwqWVO2os4A4nvPPF9Q44u9CogKY
 d8q2dcqKLkPkjymwnOEwopU2fCFrGDq7SB7hLHu9vZRORcdfowPAULTkYPK2Q0FgSBGI
 ckLM37fxnNDbBH3DIow5laNPmzv1H/1d/IQfd16jlZmJmySllkEKL19p+OZENyR/+xdJ
 Ug9w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777600448; x=1778205248; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ircn2BEjGgDpdelDeQ4S47x0YWnSsTew6kHFdCmEDF0=;
 b=YAuiaIiZ8w6xOasulqhosSHv5MMO4vGFbeyqQgM3/W9H+6DtD32JkYXS3Rnbv9LZw5
 sQ6BMeHUVaW22MzUrkqeLvUo1318OIza0lqjy8OGC+8bf+2sjBrL02oDD7U4CYH2qjlc
 5403ccpG1AzZHVlY+Ky/A+hd/OQ9fQVP0cyQwYUQhJkPhlWdywh/S/yY1nnN3bAJS6/U
 fGQPZnnZjjbAfRwfNl7/JTfV7O4LUcJ+JzJGCQph18S0s5xQGe1J0iU6NOlcRzDu/xMA
 nI38RAxyINqHooOKoT4eeInjfvaO0vY2OxNFm1E/75xCwTaf4WtjRoXWgQlMlisUeg9w
 cCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777600448; x=1778205248;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ircn2BEjGgDpdelDeQ4S47x0YWnSsTew6kHFdCmEDF0=;
 b=AJlrOsYvfeurtUQgJpgvO0NZ08eHHJziAyB3mZc1ETe3XTTenAsJmPGuIG3r6O68aT
 fhJ21Y9RYVKGOZdmRPbUvlr4Wv7lkIZz9uRb/myF6d/beSg6ihdonSz0vYiaJOFxmmd7
 CRh+pF5y2VIq3PNdmCztiYYLR0fVFkXdje2RC0aDerq4Lh5LdPAdVy7TpDg8qq/OeHmf
 CR4368LRBknkk2J+oJGRgtVx1pUg+j5FPpEoAuc46jz3xjtj4dCRx/oaKnNpvE0HX7N5
 OkVuwSSR6Bf1MiaqCuABSVe6OObDjGDp9izABQKIb5f8zw55dcTYoHBk5HkxH3oe/FGy
 MAAw==
X-Gm-Message-State: AOJu0Yw9xQtzsMeIFrMzmNEZf0uIbWqv9TTsqPLwMOCJV9fv/Wx0ZhsZ
 5VQnwhzgwI0U3f8wDFK8cyXL7KFAr9jhmxb2HuxIUwGQMapijAg1uc9KLzkMGEdu7nPhUuoYtAm
 dP1bJ6TKndiLSgXlrokGmTVHTUtXV3WU=
X-Gm-Gg: AeBDiesuyJutCq2POrnxb6YJ4lQ+Tt0tp73FyrXUagH9IKWnQWRqGNyL1YgP3ulaUek
 409cjkPNbqgfEa/9zTmgJRONXYYi8Zh06ltUc/vAmueMVrkrGmZA5LqJpmMqQOGVM9o11vBGQW1
 JiGAtNStsqBurcpfnUzNjLQjGFV+Da1IjxsYEHYBqjZT8Rd0K8/0mMi+BYc7os16q+4LpC+y9JW
 l/ulP78dQ6BzSxulY7FqMouqgqgAr6FQwYmwcmX777kh+88+Tfth19JqdNAa6sSU2PbAK0tyS24
 vcYCp3dcgaOiVjIMoTRoeUuejdHV5g52ifvvEZ/Czwc1eCrfBAVbXKeu9+8=
X-Received: by 2002:a17:907:3d10:b0:ba7:b198:7d25 with SMTP id
 a640c23a62f3a-bbac66a25eemr360297366b.21.1777600447737; Thu, 30 Apr 2026
 18:54:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-38-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-38-c413f3605311@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 1 May 2026 11:53:40 +1000
X-Gm-Features: AVHnY4JeX1EEQZHP3hzV8HzmNi1gnNOMON2xU8ZU5kO4Cx6pY0Dhk_IumTxvkFU
Message-ID: <CAKmqyKPQWSEtpgMSoMuBwa0L_QrjMoKq_mCoCXWSa-z5KaAEuw@mail.gmail.com>
Subject: Re: [PATCH 38/41] target/riscv: fix general_user_opts hash table leak
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

On Tue, Apr 28, 2026 at 5:50=E2=80=AFAM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> The global general_user_opts hash table is recreated on every
> riscv_cpu_init() call, leaking the previous one. Clear any existing
> table before creating a new one, and destroy it on CPU finalization.

@Daniel Henrique Barboza I'm pretty sure there should only ever be one
instance of general_user_opts and that's the bug

Alistair

>
> Fixes: d167a2247ede ("target/riscv: move 'pmu-mask' and 'pmu-num' to risc=
v_cpu_properties[]")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  target/riscv/cpu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 8ac935ac06e..15fa03e22a4 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1101,6 +1101,7 @@ static void riscv_cpu_init(Object *obj)
>                              "riscv.cpu.rnmi", RNMI_MAX);
>  #endif /* CONFIG_USER_ONLY */
>
> +    g_clear_pointer(&general_user_opts, g_hash_table_destroy);
>      general_user_opts =3D g_hash_table_new(g_str_hash, g_str_equal);
>
>      /*
> @@ -2961,6 +2962,11 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt,=
 char *nodename)
>      DEFINE_RISCV_CPU(type_name, parent_type_name,             \
>          .profile =3D &(profile_))
>
> +static void riscv_cpu_instance_finalize(Object *obj)
> +{
> +    g_clear_pointer(&general_user_opts, g_hash_table_destroy);
> +}
> +
>  static const TypeInfo riscv_cpu_type_infos[] =3D {
>      {
>          .name =3D TYPE_RISCV_CPU,
> @@ -2968,6 +2974,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .instance_size =3D sizeof(RISCVCPU),
>          .instance_align =3D __alignof(RISCVCPU),
>          .instance_init =3D riscv_cpu_init,
> +        .instance_finalize =3D riscv_cpu_instance_finalize,
>          .abstract =3D true,
>          .class_size =3D sizeof(RISCVCPUClass),
>          .class_init =3D riscv_cpu_common_class_init,
>
> --
> 2.53.0
>
>

