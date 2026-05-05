Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDCF4CD342F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 09:58:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKCWo-0007Tq-9p; Tue, 05 May 2026 05:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKCWm-0007Th-QE
 for qemu-devel@nongnu.org; Tue, 05 May 2026 05:57:20 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKCWl-0005sP-91
 for qemu-devel@nongnu.org; Tue, 05 May 2026 05:57:20 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-7b4ee3a88e1so74483557b3.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 02:57:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777975037; cv=none;
 d=google.com; s=arc-20240605;
 b=VZAEvBj186AHbK8Mf1hfTCxg0AAbWQox6zi0yLcm6M4xqVJSHJ9GZhldiAE/S3UCFf
 6WcfvuklKjBZLlxcpwGXIzAm520StguNgOyOB+KIF6ZjGtMH/R0hB5mUKOOhNZzlsrAq
 W5/28fwMCwvFWyAS+VyduD2UmyV4n+6EiVF/or4D2tPq8BCzSz7puowPwKh6ek8Qu+4e
 PN2UE5SBOA+tOk6vnSeAOQE6CljRe4V7ERAN1KmztYKDdzu6+F31Adc5eNXTkPbV+0xd
 efUbwT5YxyDgJnM5rsjfALHoT0QxrnUS5GGfOLJPoDGXGVoEorZFT60RQJPl1K/8pCjk
 jnqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=U/uSYcs3J1+GqNVhy1p8D076tYJ0geHr1IXNfw6aAMY=;
 fh=+1firF9KONN4Yc1L4UE+f7hjZIqv5yKMPW+CbJoXUyw=;
 b=QFTGU+dF1piSUnSP/6yBR0SEp4ejnXtJ0ovjtL1Pwax7HjiJhN0NkT1xQW6WHwngQ5
 psX4VRLVV2QBzooFCZRTxxImLY6rWT0vjalWqPiH7d7Wm9AAxzyOBCpRFjMp2yHsZGv0
 Q8azTEsqGaPICx/VCqWFImh1Yf2FRVJau21bL7rmReB2gys3YUKJF9lw2jbK5FE/LHzN
 losIBQMQFGNa+XpxBuJb6Ct2vL/MiGcL54MEAwhvp5zESZZE08lLQwXn5bGbAxdTBP3j
 JJUm42Yf/zBcrqkWMJSJr/RH2v624iRE05KBZvSLH701rzYUlF6PkRB0LvsyF13VJ9Nk
 KH/g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777975037; x=1778579837; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U/uSYcs3J1+GqNVhy1p8D076tYJ0geHr1IXNfw6aAMY=;
 b=w1jr17nXWvZ9OfOIXxkHLM/WP9ZLdu01UtsIzgFUlVov7xDBTFyDs/1ULpFhzpm2K5
 ieLj+AwEfDt6KL0qnwK+ck7Jk8D8Ob3EFaX3Omji/Sa7Q5G5Qvmv6qBzEOA3ucH4l2Ta
 RQOdDgfSuT+oMkC2GIDGEoxgumUVARVmv1lDroya6xq5W49nTMei24ApIToda5fNk80s
 vpFysezrqNeCEBxNQPWbc7HMcBJlJPm9N3VtVAAOZrUeSkndZvzvsTw2vsmSJNlwJiGO
 mZPALQHMd1Q+5FhGninJvNbqzf74CG7LCPLt65XLxdTJsHyTnUtUX/uQMB6VREM/epCU
 qjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777975037; x=1778579837;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U/uSYcs3J1+GqNVhy1p8D076tYJ0geHr1IXNfw6aAMY=;
 b=WvtnBdGIkQ1xxFPNHNjdHCzklLl4fEjqHuXtGnHyAcaianV1UwXcSmCWTPbmLqA+16
 xi4F54lKwtKrCxcfW1RZTbaVtIWNzOc8A9Q2sdzaKkaOeHMs0sx5fjLk7pwMxoIp3Mew
 0LCb+dmY/+TA2LufwBL9H0Lg4rpRtcZuH145MA08vcMuOt97MQftatNhVlVsm03tqALf
 Zxirhhmhqr5dTUgY8MN+91/ryxcsRCuXnkMLbeCrSBw5DD/6fiYK0sHP7BcvKoUnKvA5
 Mhb/25IOlm5SRGuhl4jvfDueBWfAH2oyz1zt4B4q9osI1jtWADKaBvikdRszVWpjSpbz
 WwRQ==
X-Gm-Message-State: AOJu0YxU0SFPYekSuTC3welP8JqG7HGSVC/J7j9iGVXcZ6wTP7t6aCPK
 MUuaxGNpR73kSRvlFzFMthgMkpvgzq/QkKdOeysBwhea8VcuaD6xVbhun6ZaQDPMU12qIs83Wbp
 eq0yA/33n3F0bsgK8kTIzQ0eu4Wd6miPYKFxypExBwg==
X-Gm-Gg: AeBDieueVGZS5JmJNoDVeNI+oVL2PwG3D67xKoyWpSTeIUCO55f/GgRDGZsGktm8+bR
 EZwb/+2AG0Ans7fbCZ5Qyhb9Dv/JLjOW9mNFNPk06fJLFSxeUO5GzqKfpyxtB5qkh+cPnFJJ7X8
 20eS30lMjDvIKwa19/rG0gu8onjjrXbKPix+WblXGaDEnmgK5DFOGLipoTNKE/XHpJoG9jITlXN
 5dtojMNSaLi4lnmYpcphfov4786W+t0HY32yBZZYVLYOhI3wWkJiKsN3Po6FCQrVljYqIRUzXZy
 U0TAQKvglUlmm0pX4KaQ0YP5TFZQWG/fNEp2ZVEk1bYgBE78savy9R+QqsRCpFqSSGciC5vLnsD
 k/A==
X-Received: by 2002:a05:690e:13c6:b0:658:ac79:ad4d with SMTP id
 956f58d0204a3-65c3db3178amr14004394d50.47.1777975037310; Tue, 05 May 2026
 02:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
 <20260504-qom-tests-v2-7-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-7-ef7e3dc94f7a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 May 2026 10:57:05 +0100
X-Gm-Features: AVHnY4LVBDjNllxaTUCJf--cYZSY9oiTVZc51W85NManT2WdRs_5roNPKrwrGgM
Message-ID: <CAFEAcA8BAOvSKUxvE_yn0psM10v+WPZy=9=DLeneXGKeiWSrHg@mail.gmail.com>
Subject: Re: [PATCH v2 07/46] hw/ipmi: reject NULL 'bmc' property rather than
 crash
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Mon, 4 May 2026 at 12:36, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> The type-checking macros (IPMI_BMC(val)) which crash on NULL.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/ipmi/ipmi.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
> index b49affaccec..d532d38e556 100644
> --- a/hw/ipmi/ipmi.c
> +++ b/hw/ipmi/ipmi.c
> @@ -95,7 +95,14 @@ static const TypeInfo ipmi_interface_type_info =3D {
>  static void isa_ipmi_bmc_check(const Object *obj, const char *name,
>                                 Object *val, Error **errp)
>  {
> -    IPMIBmc *bmc =3D IPMI_BMC(val);
> +    IPMIBmc *bmc;
> +
> +    if (!val) {
> +        error_setg(errp, "%s cannot be set to NULL", name);
> +        return;
> +    }
> +
> +    bmc =3D IPMI_BMC(val);
>
>      if (bmc->intf)
>          error_setg(errp, "BMC object is already in use");

I was looking through the code to check where the type macros fall over
on NULL pointers, and I couldn't find it, so I did this little test,
and as far as I can tell they don't assert, they just return NULL:

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2ecad3c503..32569c1f09 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -66,6 +66,7 @@
 #include "e820_memory_layout.h"
 #include "trace.h"
 #include "sev.h"
+#include "hw/ipmi/ipmi.h"
 #include CONFIG_DEVICES

 #ifdef CONFIG_XEN_EMU
@@ -1580,6 +1581,9 @@ static void pc_machine_initfn(Object *obj)
     PCMachineState *pcms =3D PC_MACHINE(obj);
     PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);

+    void *foo =3D IPMI_BMC(NULL);
+    printf("foo =3D %p\n", foo);
+
 #ifdef CONFIG_VMPORT
     pcms->vmport =3D ON_OFF_AUTO_AUTO;
 #else

This code runs on the pc machine startup and prints "foo =3D (nil)"
without problems, even on a debug build (which enables
CONFIG_QOM_CAST_DEBUG).

Is the problem you saw really with the cast macro, and not with
this function's explicit dereference of bmc in "bmc->intf" ?

thanks
-- PMM

