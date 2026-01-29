Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405C5D73E84
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 19:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlXVg-0000vO-6C; Thu, 29 Jan 2026 14:16:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vlXVe-0000tA-GN
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 14:16:54 -0500
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vlXVb-0004W1-PI
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 14:16:54 -0500
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-501502318b1so10646951cf.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 11:16:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769714208; cv=none;
 d=google.com; s=arc-20240605;
 b=Pd0NDvdy9Dwz2fE0rgAx+XMPqSyzJvhl4goJhfh/i2y2S2lXs+u0wyoATeL8HcGSIA
 J3JtuNaBKrtETV7w7QeX9PUvH9yl0QyJEIgid5VYGucIko9osaOGDqCg8n1ouBTEpAnD
 YRPwkhd+hIG4zcc4viZ1dmBtgjg3pPiCCR906ad40D9v8Ihw706fqESW8453yYlhGcAu
 HhlM2X1m9NMYhzLgwqb9BOY8gOkPCdKju/ooG3Ze5k93yC7v2iFFBiIFMqgB0q60dLZ8
 6PtkwMr5WjuSR7y5o5KcXsaD23iNL72AqH/Rdtcg9uIm23jO/hKhzGEylxeseGykdojo
 DxNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Upx+0WSzsXBjqpFtSSLmr+g6c16ezAAcWo8Tqdf1Qto=;
 fh=Ga0XYVXhCFK52l0VzBX9LzgGK/mpVxrwa2pzCzeE/B8=;
 b=Zw5HVfORzt7IxeYAUdniPaVUWdADGAhMZ3cpnArXT/9GwhDkUT0TdK+iMoI4dHIDnk
 bVhFt4HGW1bEetM6qSSQqHfzXdTSkhOL/TKh0DtC/QSntCv5wTpb0eJpWLaMVdsSuTp5
 iMLL/luZVNtV2Bu7imGqg6tDojB9o1kQqR6RnY0zyb3YB1mkp3NZiFykM4yqAL3WXobZ
 sQ0j/v2fXJ8cAzvoiLjeZyqAL7cf2LajKZDEAPKga9hOYWz+anyyUhiMRvoUe+E7zxoB
 AnOBD+1LOgu8dVB20pffGjGoHt0Y2ayEpkKtWcDe3uw69S9xGd3J5C2YqpMNPPoOxYT9
 +7Lw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769714208; x=1770319008; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Upx+0WSzsXBjqpFtSSLmr+g6c16ezAAcWo8Tqdf1Qto=;
 b=lV8r2H6W6yLx7NARox2N6KJ0Lg+Nyb1x/zE8DimxvgFRIJC4Cs0aZGJ0azJfEijkcB
 4CFmwUSRipOO6z7sJwfv9VGG46nMWGPbklOSebYKL7pPUF5IhjE/KFnl0cETqCwDEjHj
 olheR/v5+7p1Blyi31PRss+cc5pDcpBes4jG817q2Pz1Jo99zSitAyUJERixDQu1JVQZ
 Knqb568QdCsTJ4FCoIaTz2ovnfOsmaW3Gh1QgtQ5k+29fmugrcqrbry07dyB55INGe3n
 KS8tp9Tl9FVUI6TjeqUJGz2Zek2G/8uIduec5d9oRF8M5REEsWxssu6CabLU0jcIS/yU
 2egg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769714208; x=1770319008;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Upx+0WSzsXBjqpFtSSLmr+g6c16ezAAcWo8Tqdf1Qto=;
 b=qRFKWDUp97xvdrv1EMRdTU3/TNW+HatEnuLnzBV5ZIBk79IWuTARmGYAbfYR2qJk1y
 TXrXLF4rdLLbQj+zwZ9xG/lX01K65kF1eREeAKhZRci50uZ0Kubiv+mgqUZJYCf1w3DY
 Yy7dU+0jI2ArZil9T5MsIyb6foTZ7D9+cKUkCy/Y5dL4OVtqUfHF59tn77s1zLUFL8rL
 1XG0P+cCFyee8CDIGPjOY1lpjN3rBLb9X9l3gRrcNcEQstMoSH0WKlXnklN+vYIZRJs8
 djcvwFIq1TU2HQgknQYsYTVF+xc/4JkmumsudH8+YUlKnOpPiNqRHFrr/j9y2Yrk1Mha
 rrDQ==
X-Gm-Message-State: AOJu0YziPS5MUEjEfQt7iZN493LUwzRWEM1RZEH+6+AxJ3xKuJx267yk
 V481rI72Clz6OknIj+mFjUYd7qPzN/C7RrxST3mhd9eUNAjb+CWsklCXWpGY8kKvlYTHHHjQZuK
 5xBC4PP/ezchBtks8q7uc1cQDe8NNtDk=
X-Gm-Gg: AZuq6aJSrtiKi7rEID+GbhwdsdmH0lSK5s2ieSH9fr8DOhzlCUo7SsU8NGtO79xJgrL
 vVnKsmGwR1VQES6Z0tGMYqR0o9+p5aHaXxDfmb4ncvwLidIUkfbjPMumL0M1PdFoUObzCvwkMyo
 VG7pDqyH8JDEIUtXpyvQR7spkSSYvv2bDyY/8S8JZopibonVZplp176F8Ic9CHMWW6dlqLqJ9T4
 cgn4KUp4wMuzALZAnMoW9DMSakhNVPB/YtoX/15q44Lun2M7X7hR6AtKHf6fcyzTSrK3AHY1+te
 imy6RSuoiu/lkDBP0aAPeLAmuBk=
X-Received: by 2002:ac8:7f8e:0:b0:4ff:a46b:3af3 with SMTP id
 d75a77b69052e-505d2151a2amr7862331cf.16.1769714208319; Thu, 29 Jan 2026
 11:16:48 -0800 (PST)
MIME-Version: 1.0
References: <20260129190444.225306-1-rkir@google.com>
In-Reply-To: <20260129190444.225306-1-rkir@google.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 29 Jan 2026 23:16:36 +0400
X-Gm-Features: AZwV_QhRPKfVzaB6TFtJ_sp6Mq4kECw8aazcWyLMF4Eaa4-jlTz4fL-1f88SW0s
Message-ID: <CAJ+F1CJvbg3WMfZX4kFkCsts91w-Joa=9ODLbu6=0gg8K0wTcQ@mail.gmail.com>
Subject: Re: [PATCH] ui/kbd-state.h: Make the header C++ compatible
To: Roman Kiryanov <rkir@google.com>
Cc: qemu-devel@nongnu.org, mjt@tls.msk.ru, whollins@google.com, 
 jansene@google.com, jpcottin@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82e.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Jan 29, 2026 at 11:06=E2=80=AFPM Roman Kiryanov <rkir@google.com> w=
rote:
>
> This patch fixes the C++ compilation error:
>
> ISO C++ forbids forward references to 'enum' types
>
> Signed-off-by: Will Hollins <whollins@google.com>
> Signed-off-by: Roman Kiryanov <rkir@google.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  include/ui/kbd-state.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/include/ui/kbd-state.h b/include/ui/kbd-state.h
> index 1f37b932eb..3522ebe51b 100644
> --- a/include/ui/kbd-state.h
> +++ b/include/ui/kbd-state.h
> @@ -9,9 +9,7 @@
>
>  #include "qapi/qapi-types-ui.h"
>
> -typedef enum QKbdModifier QKbdModifier;
> -
> -enum QKbdModifier {
> +typedef enum QKbdModifier {
>      QKBD_MOD_NONE =3D 0,
>
>      QKBD_MOD_SHIFT,
> @@ -23,7 +21,7 @@ enum QKbdModifier {
>      QKBD_MOD_CAPSLOCK,
>
>      QKBD_MOD__MAX
> -};
> +} QKbdModifier;
>
>  typedef struct QKbdState QKbdState;
>
> --
> 2.53.0.rc1.225.gd81095ad13-goog
>
>


--=20
Marc-Andr=C3=A9 Lureau

