Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8763C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 13:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtmcY-0005SL-Ht; Tue, 11 Aug 2026 09:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtmcX-0005Qz-Ol
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 09:34:21 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtmcV-0000vU-AV
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 09:34:21 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c15d111ca99so314389666b.0
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 06:34:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786455257; cv=none;
 d=google.com; s=arc-20260327;
 b=p9T8Qf3iJx0XZ9cff/JhJt5g92hSUsJ85QnbCEqQVdPLGs26nIbzzSli2bgp/B/GPB
 vjf7llR9ClMGHF0iGmNjCQOFZ0ARMwXSJcHTNtK34nXNzfZNxsinpa3H55FZSiK8G9uy
 0d2BJLyKYVKm1s/X1AkoY33CH1DCWCSpQvklMfWBMg1R/RSZJmnmX5zKjtA+vws0Nb6A
 pp6hBrwN6ZJndsyidbK7/kEvQPcbo+ODFpW+KZc7nm3dqD2S4aP/ATAfX70Cl0AM9eK0
 6bnOTlRZ2b0SCgWyjkYRBzpvpmT4tmIrnEphPNbJUpbpKoQc2MEo7lYFIXvy/cKsOEZR
 dJ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FKZZo8xnlUHU9qDgmZyGx+4l58xMWEjWH8OgOvu0uBo=;
 fh=QB6K4VlEaqxCEtT2pOmdKzpfCwmGHCFBJFmJ31OhPJs=;
 b=iv4CPv2HxaToNYHWG06C5BvEt+bkVC4cAFFf2cD4mjlSuoXpBRoNaJI8+GpDQg/gDT
 OITF32YL2dLhfW5DSEiN6QeDzLJIwDy74cNL1y9gVbSsW3ci4AHbTXdoleDiayOMvxFs
 dnhNEAYjcUQd3IaA1HuHe7ZcMc56hTWPyfW5Tz/DGRtNzZHyw3+XCUJblLV6AHDehNNX
 RoWWM7Ord/SYxUTtUH4I3YjNsmuJiK55VfnjYaR+gdBLFEi6nPAHUJCYjNAE6yAXN+GD
 8pF8jiLZz6LMy+fLcG7/43x+KTzDcPG7TnrWiJXIktgQ0cGJbIa2n6q4H9YTR6KyY0EP
 vVhg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786455257; x=1787060057; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FKZZo8xnlUHU9qDgmZyGx+4l58xMWEjWH8OgOvu0uBo=;
 b=o6AUd45NNi6wtWWt6meWOgDtwrUdZRzst35zTSxefNbchiR3vy+E2/HR7I2XjD3ev3
 LgGCWPWRSgR0CMX3XsbbMKpUWcYs2ZOrBS16DVttC08+2PTzAlAav2L9Tz/VVX5SZpvD
 Y754m0dBUgx60mZQhq61FY7YWLQbpZGJs+Wrwm+EzkRFZb6zhLmNejQZ2EWJU1z1CNSU
 ehZspznY0bb/tMXAO2G5gEPmIIdSeeTQSG0/nXLORewLusOFDLL/s02ukpk3QAC9tdTO
 iOP19qDI1J2T/SILHs34kueZd/08A9gdSmN3SkdC2Zxjko18pFgCBvaPepUq+ubRKufS
 jzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786455257; x=1787060057;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FKZZo8xnlUHU9qDgmZyGx+4l58xMWEjWH8OgOvu0uBo=;
 b=sDzr0byGgH1jR5NMWiBEP759LEbUSI3GNkb7w5+Vqh/sNkVHrCFkCYJu7q3s/utoiv
 PjPepCQ8XPF6Q0fsAlnv77gAH08ydLvb1qfh708KPg11p/oOV5C2QXuEIunZ5ApXVfKf
 CxmU/AewSvb/C55Y+y3ccOKUUGVGYHIgP5RbSVTCZjt63uSC+zo/yoRS9cYi8mZ++kSF
 AS3UL1i8vBATkZCtdnIpiloV6/yg5c9qTmVcl3vw79mko/s/H2e+FYoftgLd8KZs5RA6
 M63iGcOUc3+VofPWXqqMgzjBeCtvljg98cs7Mv+SESrMxYqkFMI2luk4rq7rmumvBqpT
 aLTA==
X-Gm-Message-State: AOJu0Yw5Dq1CSfs4Z0cTrY3Fl92HQSu/67PRhO4b8RmdFLUmJy6qq1rf
 80fonHNF6XPrn3qP2IGLof0oR8r8CC2RpWyH7U6n4WwCaI3m0bQRzGo+omvswnv+TVPJocmM/vI
 B2CxCtVqQGKwGaN3BKGlmcWa+kq8OsE46bP93L6v0oQ==
X-Gm-Gg: AR+sD100bxzkynOsfgLQusKEYdr9Th+Qm8mfMwAKKLbrAlMojDadYkjUH2PFthugxRf
 8dK9vz7/nXq3OlWQIRKlTl8lVxt/xoO7MMpRKvtZ4tTa3mujNpp3PuX6II3jn0N83ltDszvzdwu
 9QZC8xVJVNmaMG+RvwCXRIhQsew9tWCiP0qJIxAoTIxYX1YQ93h/rXJxhw2YftanieV0qjVfdKd
 16F+ORfQJzswOq4p1RRtMs/kfX+62c8nDZu1TNQeNzREgfteDyF7nAqdCodLy5Qu9zqwrLQJwdz
 rEsZM2puQqwjrJGbYSIxk0y2XOUrh5HMiMyXRnnfXg/VpkWxYTB3IMY0OJtAUYAYwHfDOaGGlcJ
 6myegpz2TG80MEPGlVnWXmO7F+KkSI2c7XC3bRvO+Vf1FPaIYCkA=
X-Received: by 2002:a17:907:3ea7:b0:c20:5121:89c1 with SMTP id
 a640c23a62f3a-c20e6103fb4mr177874666b.12.1786455257538; Tue, 11 Aug 2026
 06:34:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260811105425.7429-1-philmd@oss.qualcomm.com>
 <20260811105425.7429-8-philmd@oss.qualcomm.com>
In-Reply-To: <20260811105425.7429-8-philmd@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Aug 2026 14:34:04 +0100
X-Gm-Features: AUfX_mwIQdcrkqdLG3K_oR2LYE6tTym2Sz4lpo30hS-mjfJXM5SbStqdhjG4yBM
Message-ID: <CAFEAcA-kPGVfJ5KfKYLVJaEtxCZd_Qhs44j9HB4XxWQ7GZ5t_Q@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] hw/nmi: Deliver NMI only once
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-s390x@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Thomas Huth <thuth@redhat.com>, 
 qemu-ppc@nongnu.org, Corey Minyard <minyard@acm.org>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 11 Aug 2026 at 11:55, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Use the first handler available to deliver NMI only once.
> If anothers handlers are available, no need to keep delivering.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
>  hw/core/nmi.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/core/nmi.c b/hw/core/nmi.c
> index 8eea75ad530..4fe5ee75bfc 100644
> --- a/hw/core/nmi.c
> +++ b/hw/core/nmi.c
> @@ -31,6 +31,8 @@ static int do_nmi(Object *o, void *opaque)
>      if (n) {
>          *handled =3D true;
>          NMI_GET_CLASS(n)->deliver_nmi(n);
> +        /* We only need to deliver NMI once */
> +        return 1;
>      }
>
>      return 0;

Looking back at my review comments on v1 of this series,
I think we could clarify the comment / commit message a bit.
Commit message:

We only expect one device in the system to implement the
TYPE_NMI interface (typically the machine, but in a few cases
for e.g. m68k and ppc this is an interrupt controller or
similar device); so we don't need to keep walking the whole
QOM tree once we've found it. As no machine type creates more
than one object implementing TYPE_NMI, this is not a behaviour
change.

and comment:

 /*
  * We expect only one object to implement TYPE_NMI, so once
  * we've asked it to deliver the NMI we can stop looking.
  */

With that

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

