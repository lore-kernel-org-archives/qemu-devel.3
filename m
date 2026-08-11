Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43588C5CFCF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpUf-0001GB-AE; Tue, 11 Aug 2026 12:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtpUW-0000zX-4w
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:38:16 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtpUU-0002mi-BS
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:38:15 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-80cebd41372so46413547b3.3
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 09:38:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786466293; cv=none;
 d=google.com; s=arc-20260327;
 b=YqNydX0mGCiDqlr665eM5/19vGd6xjkg/ZqPNFOv93S0/F82vdSUYnH9brL4s3Ftt5
 6r1/rIFPwqsm9t8LQfNhXmAl6QiOtozGNsEDC1oXCUt7iEFBiFMJ6BDMrFMoHTMebvL1
 +dV+2t+ebkogc8uCk8YPKYh5OJsqnlZjoJnTxMv/edL6hNeYp34js4AUajD+sD8U31yd
 /2v1nkM2t/7sacHuVR44ty45wBiqvWzxoNjAhahhjuKZmmUaA9F4mc+fieaUVLcaXesT
 fOkv2Jayb8aCW1UGB/NBFswFIRjd4PEv0z4FfbcElqJfHWM20tf7KdsSRyxSrVdsbPTR
 osmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dFjvSQ0Z5STTXqbBfIW5yzwrJ19UJ0wpYPKOA1LkQKI=;
 fh=w2qb3jk9JwAPSB6Csh8SoINPieWh1o32x8VoECJYBoE=;
 b=QCvwTENdiZqenYqlgSOu9V+/hvaoI2ZyZK8fPAV38AS/E59HS18h03uqdalHn/rfBX
 a9q2bnbECQYOfVr7WdEgUB8UBJ2DmUfdlXzQ6LQv7N64gZvuPlZ5/Ohu29tYpnf0IHwR
 XAXsfW4/9GLoXBbGHo58HZOpBzthgwOEYhkzGumfU1Xo/+popIfhrrJbot5Intvy/LZ0
 /LSKocyvcVVjdcAVGvQhMYV3kGfZnwc1y7+PqTRu0JK/na673f9Ikh7VIZa427QBaAJb
 wgyYoEcsij+uIwPPUCf6R+1mNiJyT07YoTmRDydTqqeab4S0cGrjRLjoe04TILtX6gRG
 ielA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786466293; x=1787071093; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dFjvSQ0Z5STTXqbBfIW5yzwrJ19UJ0wpYPKOA1LkQKI=;
 b=PEn3NBsrKBY9rXek0eWdlZZsMJ1yFig12kX8PnuwEgLBdTPKUHk2rtSpSfJ8diAwM4
 l1aIPSOFjyvwZTBCTh8eBajYPknZau05UhKOveACiiBNakR8CotPbpZgihmQck7ewNDE
 hhIq39W54BnJaCPrKX9ZzApUkuvDXHXswZS/qX9sGi7P2UUp3Pq6CCK3Chi2Gu78/xW9
 4OVd0CqFTnOrlKiIPeIeGOxCWquta7oEeOLgaC2n72naTkStv3trppFca6uJtQU4rUpd
 cFIm5Lr+QinA8TzkFSzOIwbz3LWvKH02doMZeBkon9Lqw6ItNN4z5QBkoffCB9EQ2a50
 GipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786466293; x=1787071093;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dFjvSQ0Z5STTXqbBfIW5yzwrJ19UJ0wpYPKOA1LkQKI=;
 b=GuRAj3y4VRAQTvgnFlmj0G+3HNufwsI7EQjGJp/hzWXlwNUxFILbT+H4r+hgJ9Bwbs
 e0uVb19dgPUdWZUY4LqIOzNnN4cRwvNRuojx3B1XcNjcdDhfZncrwl82RqX5X/8SMQ+c
 nIvtE/EFdFxzeO12mOpz8mBKp+sPfHm3AwQ0eRwY3AZ/26I/N6fRITG5+einm4w5Azni
 8MeHR0KcK9HL8MG//SzUgm42EZgDU+ApshyUX3FSUvbejN7p5iS3BS2yrjMemBPple9H
 GCjwTfLPx6Z8YolLpJFK/9pKsc/VQ6SdFzGJCiU36enldGx3zeujgCdekoKodxuaUQBk
 dX8g==
X-Gm-Message-State: AOJu0YzPbC2b6xExp38ZhxuKp2NjsiuQ2g75tupj/Gm3DHpMWTcZNrIm
 N6syHjvx52TYx7dubH99rG/CAqGbfLl/fmU2vV6aVcvM5eLweTzGuw93B0AOwE/euGGIxoA2hVr
 jbmh1n259zN0dO5+GC4jgmZa7UFyYIb/4Z/BZVMM3Ag==
X-Gm-Gg: AR+sD11Gvy7U2+OTzAAC4zAXXibCKy3oKuFqY/sIum/eVDy8ciR8zlTbjPWJf8Xc23k
 Kfeh5CW8rRm5HvcX/T2a+YHIVF9G/yk+Crz9zfGOgpQlqhRCs/khrrEo4uJk0p1YYS0H/C2z08W
 ADUAXwU+EqPfwSBs9ZYsr9W96WcF30TLeLXFKrfOl33UhLkN4DHqVss1dx1b2q0cZ5EyFSp2Ude
 9R29xZeTTP/B4HI1ZfZvnRXkxnGzmksPssKf/0cuOgfz72H9qr07E3yK+s+CS9BxPpPhLBfYLV+
 q6oZfsQtAHJBfATNbh8oiBS0b3I4MKZZNJZHjpWoRPjFzFmnst/9o7FvpUC25F85j8oQJpWVVgf
 snDESUtp9UEruFCeXQ56X9zaRAUJP
X-Received: by 2002:a05:690c:698d:b0:81f:650c:98cd with SMTP id
 00721157ae682-82f2dc957b4mr35649487b3.28.1786466292911; Tue, 11 Aug 2026
 09:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260811154930.13915-1-philmd@oss.qualcomm.com>
 <20260811154930.13915-5-philmd@oss.qualcomm.com>
In-Reply-To: <20260811154930.13915-5-philmd@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Aug 2026 17:38:01 +0100
X-Gm-Features: AUfX_mzkGLnWUOyapv75Mq5EtKUny6ry6vUJNsBlgwPnJh8pRPkCmUXWBtjU-vQ
Message-ID: <CAFEAcA_3uQhuCmuzTi1xnsrXZXO9zJHLC_WE=OfmLGwi3h6J5w@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] hw/nmi: Remove @cpu_index argument from
 nmi_inject()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Corey Minyard <minyard@acm.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Tue, 11 Aug 2026 at 16:50, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> nmi_monitor_handle() is not related to the monitor, rename
> it as nmi_inject().
>
> Return a boolean value indicating success / failure as
> recommended by the Error API since commit e3fe3988d7
> ("error: Document Error API usage rules").
>
> The 'cpu_index' argument is not used, remove it.
> This officially drops the current CPU for HMP command.
>
> Document nmi_inject() as suggested by Peter Maydell in
> https://lore.kernel.org/qemu-devel/CAFEAcA-yALySmCJLbitCmYpiZKUXJNOavGJG9=
RYeo8fKqz7gcw@mail.gmail.com/.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
>  include/hw/core/nmi.h  | 25 ++++++++++++++++++++++++-
>  hw/core/nmi.c          |  9 ++++-----
>  hw/ipmi/ipmi.c         |  3 +--
>  hw/watchdog/watchdog.c |  2 +-
>  system/cpus.c          |  2 +-
>  hmp-commands.hx        |  2 +-
>  6 files changed, 32 insertions(+), 11 deletions(-)
>
> diff --git a/include/hw/core/nmi.h b/include/hw/core/nmi.h
> index 4c4ce79071d..2ff5be1e214 100644
> --- a/include/hw/core/nmi.h
> +++ b/include/hw/core/nmi.h
> @@ -46,6 +46,29 @@ struct NMIClass {
>      void (*nmi_monitor_handler)(NMIState *ns, Error **errp);
>  };
>
> -void nmi_monitor_handle(int cpu_index, Error **errp);
> +/**
> + * nmi_inject: Inject an NMI, in a machine-specific way
> + * @errp: pointer to error object
> + *
> + * This function injects an NMI, in a machine-specific way. The
> + * intention is that this should typically trigger a guest kernel
> + * dump or reboot, and might happen as a result of user request
> + * from the monitor, watchdog timeouts, and similar events.
> + * (For example on the x86 PC it triggers an NMI on all CPUs,
> + * and on s390 it triggers the RESTART interrupt on the first CPU.)
> + *
> + * The NMI is injected by looking for QOM objects which
> + * implement the TYPE_NMI interface, and calling their nmi_monitor_handl=
er
> + * method. Usually it is the machine model class that implements
> + * this interface.

I guess with patch 7 this ought to say "looking for a QOM
object which implements the TYPE_NMI interface, and calling
its nmi_monitor_handler method".

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

