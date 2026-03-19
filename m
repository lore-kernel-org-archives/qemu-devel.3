Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 181031088E67
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 03:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w33lv-0007gl-6M; Wed, 18 Mar 2026 23:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w33lt-0007fb-Jr
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 23:10:05 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w33lr-0000J6-Pl
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 23:10:05 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b97ba4c2be2so62521866b.1
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 20:10:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773889802; cv=none;
 d=google.com; s=arc-20240605;
 b=dPbzwNRRHeDaxPySkfIyRXhnahA27021GQqSQnpLibV8AYCJ7TslHrS78iazHFeHj0
 Gt8j6FoS8JXBmm7p8VVAk6IObCl2e+OuvNCSS+p9PrV1IqOKRE/7AXJsscCLFHAfmFI9
 yDSm4lWwIAQMZrQXtuxT/VrmnRC+ae4jb+c9gfy3bcaGy/CpuybnVFdmE4xI87H/4m4G
 T5C7P8yxJ7xL3hYOEriMUUOQQWbha0yD0Q10kK9Pt4WVuwVDegQ6QKxkZBomECufV8ne
 mp0xKWc/920QIQCT1P4aAdgnU82Yhg9tHMmCs5H8dFEBlPUTLvWubiDgR1le80FjsZc6
 +ZbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nmOirF6w2jm2cEgOGc8ceaxr91LsbHfhtAVwxmw9A7U=;
 fh=0bIOm+75pw/QTN9FDs8ZhfYo0XBcsOIKWWC6mti+rTw=;
 b=KGrWxbWp3edO9RLa8lxxhym49aASVQqyQtsrzN8JEwQMF/ZbM9xK5gb9Vk2QXgNlYr
 u+JSHC+s6W5ZgTh3OrP56z/gSG3ndhIx5oF0/FlIkbDR8XVHQ1tRV4YLWOz8T4WAK97z
 2MKUZUQppTI/fiOvILqDKfAdKA8buS5V0MOX0OWIjomtLT2iJhyYqezSlsBFUdHtpsLR
 KoWFxOYiMAzz+ZksW/7emetqI00VMI3lL1/hc0ckflaIPIz+4JQ3NY2gbRxnks7xNS5+
 k1EyFAEuCQtlii8oOtRLPMOfO5MwRp9CqrdZZOFA0DJisXVnpvSjtTrFIrit3UhLagOw
 k72w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773889802; x=1774494602; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nmOirF6w2jm2cEgOGc8ceaxr91LsbHfhtAVwxmw9A7U=;
 b=HNeB1EHrCJ3k3pfvvb2qocVx8N4Hi4zXLrmaG3Hy1kz45/XltAiX+OCQOtDGP+ksTx
 uY7XTt1XAv8+mbOfQUT5alU0VrUh0Qcw9mot9mjAhRAfa8CRCaikf4hOLCb8FPct3Juq
 jcAQfal33VsZo0z+eOfOvjH7EkOWvLrjGk61ZFdi99IMNUjZ7Bd4f4bROVi3qhuZU2TK
 R/P4nsbQ8SucDGPFOt3gCxuIB1CehydliWYuVJJhW/jL0Lqx1FBGK3qSX22Sx6r4HeQP
 DisKTcmEh76cV6iuWsWClMkpNxvAnS7vKXl94AAzzUY1M8qrMJzJhUzJ7EugCkpwBcLz
 jiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773889802; x=1774494602;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nmOirF6w2jm2cEgOGc8ceaxr91LsbHfhtAVwxmw9A7U=;
 b=NOcccmNarjWcWTta0fU6RBsyRlQOEfDT6bYZ31Cis5OZdIWtjri5P8KRNOdt1jbk9x
 9Gi7srRvWwywht4N70EHZBTEilxMmdKC4d0ChYGvKwuaQc0KivI+pmcXpc5bNxVAsCNu
 XPUGGk3VCZ6oWvwlWDEJwJZttZeYwaJ6jFwpdiGVEousuXhlQc3NE9UtopRuAVRBrPhm
 WE5HjMFwe9dIf1eofynnsHpaKGYYAOsCcl7JA5MhpFifrRjOJOc9HCNOBqPGJyojzaNo
 PbMqcebivxn0rTAIJhs9AlHPJGKFTI2HDTISvX2GMpl4b4rEah7pBiLRXASrCBX64z7H
 cB1A==
X-Gm-Message-State: AOJu0YxyFtpzw6dar6iMGlQL/20nUPrIF84JgthZBc1r2DsQDPmGyo1b
 SpDx73Wtd88zm4eK0RJdQpxBdJO/KYVx6rXIicldpT89j91iwrA0YXgNXqA9AIT+BC8Ak3tFAmf
 QtuUW+K5Sr0O7lvF5+KBXAe1hMuxg1xw=
X-Gm-Gg: ATEYQzy2AxwQfsbPH6RezP8mryAl70efmkzxUnDDakQWUAHXn4dKZpmWLpAJoAJ4+Y5
 Jhn7C1K5YC02k94Q8lBx8LOHBsadXcZ7IqAtP+eYbN2QYVfeKR4agwCReBavxg2R1a9CIUbc60g
 2bwygH9EnNCW2E6fanp4wHNaB+6vR/sfE8SQ6HBq3G6wT10VrDz0Drax+b+gp0KDhsCYqwLuOsp
 qVfMKATnSs6BiPcbmMnX1nDeVKBxZORX/ySyRET9Tai03pzK64OoxfFvnqg4WISTJRaoKYbIsiU
 BNXrvBOfkPKFIJI7dK+N3l9frTrinN1baS/7aA==
X-Received: by 2002:a17:906:7145:b0:b93:5405:9260 with SMTP id
 a640c23a62f3a-b97f4a7e80bmr326032466b.30.1773889801662; Wed, 18 Mar 2026
 20:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260318103122.97244-1-philmd@linaro.org>
 <20260318103122.97244-3-philmd@linaro.org>
In-Reply-To: <20260318103122.97244-3-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 19 Mar 2026 13:09:35 +1000
X-Gm-Features: AaiRm50jZxUp16NBdAGNGwHyJqS5UnqKIUXpKhiAcORGkekI6x6l9I2k8et4OMQ
Message-ID: <CAKmqyKNBUO9PQAma-9z6kr079V6VZu9nYgehNQ4EeKUSvZ24vA@mail.gmail.com>
Subject: Re: [PATCH-for-11.1 02/16] target/riscv: Use explicit little-endian
 LD/ST API
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Weiwei Li <liwei1518@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?B?RnLDqWTDqXJpYyBQw6l0cm90?= <frederic.petrot@univ-grenoble-alpes.fr>, 
 Vijai Kumar K <vijai@behindbytes.com>, Anton Johansson <anjo@rev.ng>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org, 
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x634.google.com
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

On Wed, Mar 18, 2026 at 8:33=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> We only build our RISC-V targets as little-endian, therefore
> the LD/ST API expands to its little-endian variant. Directly
> use the latter.
>
> Mechanical change running:
>
>   $ for a in uw w l q; do \
>       sed -i -e "s/ld${a}_p(/ld${a}_le_p(/" \
>         $(git grep -wlE '(ld|st)u?[wlq]_p' target/riscv);
>     done
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index dd6c861a90e..c28832e0e39 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1365,9 +1365,9 @@ static int get_physical_address(CPURISCVState *env,=
 hwaddr *physical,
>          }
>
>          if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> -            pte =3D address_space_ldl(cs->as, pte_addr, attrs, &res);
> +            pte =3D address_space_ldl_le(cs->as, pte_addr, attrs, &res);
>          } else {
> -            pte =3D address_space_ldq(cs->as, pte_addr, attrs, &res);
> +            pte =3D address_space_ldq_le(cs->as, pte_addr, attrs, &res);
>          }
>
>          if (res !=3D MEMTX_OK) {
> --
> 2.53.0
>
>

