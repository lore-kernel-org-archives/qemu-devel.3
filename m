Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A59DFF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 15:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wITkW-0004cn-Cv; Thu, 30 Apr 2026 11:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wITkU-0004ZN-O7
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 11:56:22 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wITkT-0005bP-7b
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 11:56:22 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-6501c9903edso1142632d50.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 08:56:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777564580; cv=none;
 d=google.com; s=arc-20240605;
 b=e3i8PAcY7p1Ahg6Tdci2Y1NramZUbv6ZHq9ZR5bMcMH/iNfKMWaTZjn6yrKKRkedne
 9+2sc1NKSDboYwPd8lXJU3F0xS+wrUUHCCwPnk3T1/fNYIRnBe0tq9Qlnqq+TFTQ5IEN
 u/TgU5uD+d8EA2ykzK049aHApi86nWrZ84astrVLlB0UHHPf+V/v94+HImCI7DSEd/3+
 9SC9vK7/D94r686MJKCCvih24cwGV51JDEvP+7qDlSe+ohshzWI935kUTBnjWzsksnja
 KQi2u+KVU88eM7PSwuxYRaw0J4KzndwUErj1SqndQYyIVSCIthN1oIoYz2jIPmttJfr7
 ObSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xMXqpN92SKXGDZxwQpT/wGrtZuuK9up/gI1Yf/fEMHU=;
 fh=tuf6DLmGcX92PIrTmsOPL1mu7WdxiCZWGUpfgMyopEo=;
 b=jqaS6BPlo0kh0RVLVEsWi8tQwSRboBuDNDkG6h7qIBFaACeJddmKSe5QzISuyAFn9I
 hFfpnMlDR9iPye+GCD3oOt1mIHffOdmPcPeJppj+g3JFjiE8Wz1igs/fjLLmlTmt+yoj
 sM9IWyrx17SJXmmGNXMPQJ3f+fwyMKUkAmXDqoozhyqSkydrrWCrYlOzYuPnu04/UH+R
 kK9cR05JU31wjzIvjMFOnk67tJzyblgB2Cmi69+meqA6l2U9zXiqx7I5w5vUAxeWpYxL
 bOl9aryFGQfVbE9GE3xy6s51WJ/d4AMysRtZT7nkRdDoRn+6UxMZLICW6J7eHrL0S8gY
 jPpg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777564580; x=1778169380; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xMXqpN92SKXGDZxwQpT/wGrtZuuK9up/gI1Yf/fEMHU=;
 b=UU7VTQvSK57kl7JRF5RoTvaCmISy4Zr6WWdjDBJYHYJQYClpTbJiSA6aofRv+wWgzW
 SNyflfQoAHERYDLFpes0K9P/up3a4INC5fTUjm4k6PgXfs5fDf4h/xJiQM4YUA2gVnDB
 pXc8ZwczjKifYJNziMO/21yVQ9ggHjX0dBf3froAFUMlT7hlEOKzS5HYAHUOOqx5Qr6X
 gDMHD8RA/3pyQMNpDhNszqSZ1yjWcGhJgxdvolF875vml30vCMdp6ZospcrQvFyyxpZ5
 YbrilI2x++LG+j8/hnjItuvY8n8hohjA/VQSaIDfm0oD46l9Y/1Y5phB/cTfJqDilYGj
 mV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777564580; x=1778169380;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xMXqpN92SKXGDZxwQpT/wGrtZuuK9up/gI1Yf/fEMHU=;
 b=eEINPSEOy3pPty5De9m77c7OxE8Qlsebj4tQlFhGCU4Ko2njBLuELf47wVvwvat2/T
 WDsSJZsMIAF1DiaKpvUG7jWvOR6eKjjtO/kkQ5bXkvuYop1fYczuTqSi0gJd6Oi5XaUD
 cT4fjqO/aPc7+tEded0olUZvswDN2vtIoLIHPMHw40TvtnkkkPACDYoN5QJ/mA08jiBA
 WXZFOAqzl2WXTVR8teKfjXZaAVROVQIotA8LWS3lzEUbhan9sQJ5rgV4MQv8nUbXoKIq
 Pt5orGJON3QqADzWikJ66BXHpkyshVHldADNtq+9/q0ZPhWvQAbce4TGcjvsmCvbv2Su
 HN+Q==
X-Gm-Message-State: AOJu0YxdgPD1FSJ5frF+gsFlHkJk0C+s2rzl6eomUBKPIjnaZ7kca1iO
 RZmtNuFgPLJ52LkZ5tsa/PvZjoh2raORI30vp4P5rPApzWzEmdy3lcB5X5jVi2UN6x2CCGRZufX
 IMx9A+RP1vDOC2wmSS+l+BMScX+/TZYvF8crydUI03w==
X-Gm-Gg: AeBDiesgp4x5CKHRc5OELSWzelvldCl66DckKeC4WZHGoizg61Xs85Pcmz91qgS++Uu
 rCXjLRl32SaLhBx5aNDsgrw/3wlSwTUKmDB9mvAm6zeXs0jR0EUA1P31WLXkDkS+C+Ijnrj+Z/D
 y5l/eO2Pk5/K2XcomKdHoyiGwNihtHoYSBCa4Iva5mLf1EYVBxEKGzfkBDYgwl4nnEBqOBzUZeJ
 xsdXBpWJQPJ24t/p/owUmjzy6AsMdWMeM1XVch8JC94xVqk/vGjDvu2YKUnU5xfr6BPkGmHpF0L
 Ie7hLa0dfKFG9VfYedrKDrKr9KoBo2KvWZGRN/JvRxU9Jh9RFvPtkC/FUarqUEcK80DsowhRj5f
 6aQ==
X-Received: by 2002:a05:690e:140f:b0:658:e840:d5b4 with SMTP id
 956f58d0204a3-65c18ccf91emr2957670d50.29.1777564580128; Thu, 30 Apr 2026
 08:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-26-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-26-c413f3605311@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2026 16:56:08 +0100
X-Gm-Features: AVHnY4IkTiAPQC5mp_5g4LgXokUDMDchdMkceN42WvdN5sfP_aNAx2N9fUv0J1I
Message-ID: <CAFEAcA_tcK95_mOb0U=69zXbwWtT-Ty1wNbbHUs-sanMEsd2TA@mail.gmail.com>
Subject: Re: [PATCH 26/41] accel/kvm: free device path on finalization
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, 
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 27 Apr 2026 at 20:45, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> kvm_set_device allocates device via g_strdup, but no
> instance_finalize existed for the KVM accelerator type.
>
> Fixes: aef158b093b9 ("Add class property to configure KVM device node to =
use")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  accel/kvm/kvm-all.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 92af42503b1..96f90ebb240 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -4342,10 +4342,18 @@ static void kvm_accel_class_init(ObjectClass *oc,=
 const void *data)
>      kvm_arch_accel_class_init(oc);
>  }
>
> +static void kvm_accel_finalize(Object *obj)
> +{
> +    KVMState *s =3D KVM_STATE(obj);
> +
> +    g_free(s->device);
> +}
> +
>  static const TypeInfo kvm_accel_type =3D {
>      .name =3D TYPE_KVM_ACCEL,
>      .parent =3D TYPE_ACCEL,
>      .instance_init =3D kvm_accel_instance_init,
> +    .instance_finalize =3D kvm_accel_finalize,
>      .class_init =3D kvm_accel_class_init,
>      .instance_size =3D sizeof(KVMState),
>  };
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

