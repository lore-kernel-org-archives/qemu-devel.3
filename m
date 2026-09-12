Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D934C79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 11:53:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5MII-0004a4-5H; Sat, 12 Sep 2026 07:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x5MIG-0004Zv-0g
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 07:53:16 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x5MIA-00069A-Dm
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 07:53:15 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccda24a3so477955a91.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 04:53:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789213989; cv=none;
 d=google.com; s=arc-20260327;
 b=d2hc4pBNx6CQ6EC1yOltVqfbMvwUBeP+xaKoHvcl9EpZQ9Ef4LM4sRlBbvVfop+Xw9
 w7E0WwlLepddN0t0ALQOQbzutgUBrlWiEkqLV+4cnlPh39iDh5x0NeN56OW9+dXwiF91
 esu4r2ReV8CP9ns1tOI84H4DvYjmkkWzMqZLmsYkb5uRSgxvOezRAx4iRP17E1O6NQk2
 jrRSAACeZ9fKWBHkxvj46Gdrb2nyVDVItjWtVQZ+1XMl+6GRY/gyiBTA9vx+fd6QJcRh
 gjBBUM1Hh0GtLe1bFfXomHESFQYs2OX5zpwJsaCZ5uugLgdnHJQcJN2pYPzh4xIDnEXA
 QltA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9eqVE2jpmUOSCFwIDYdy30fnY3VawKaF8LBSQOK18f4=;
 fh=k2bc4N0C04cfzXGcSWibgHW/HMUMklaoisOB1yFxlww=;
 b=kfhbKXlP/5TNKR2VudX3PK42u0qHmMrTVTENz2U90faGNQW8INpFeU7lZ1Hrd2atUH
 Eez7eDKgsRxdG7xmSl92BIO7do9JbZo+XLfl+SIzdrWn2+Y+Mx69VrK022OdcE2JrbiS
 +uj4UmHLBfAbtKDsPE1kWa/L7Z1Owmg0a05eRNN8XHaJ4+Ejcw/zqSJHIW2Izo8Szd5e
 73ZU+IKOPSEkdGyeaId54wdpj04difBPz8KttYhU0c8cuRpJ5UKNT2j1Ax2y9QaZ4H6S
 F6QWMN+DXr7fonq9LqXVDXF92Qgk15Erraykrc4bJbeOk237JHLLlRhLURUgXGxX7y60
 oorQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789213989; x=1789818789; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9eqVE2jpmUOSCFwIDYdy30fnY3VawKaF8LBSQOK18f4=;
 b=ke9x1zUd3JSFLFDERvt9V+rVAEhLdfDzPRdBP9mM9d26l0fKYpTOOjVsWkYQBlhe3/
 XFHXwgm32QIEUCmLbeMlcPvPIdt5gHd0rKrprC8BWqKm2QsyxY0MlAkBCugKcJKo+yt6
 tGxAyoZe6JZ8EtImCgNpLl/5V5db4Xa/gN81+DU3sS9GMATKLEspn5tOhwUk+Gbdrrqa
 fjNX3nav6YnQUboi8gsEXdKt8/2/f2ewMETsg3Z2AeKgrJWbc1Kb1BcUi5YK6PNcknjd
 V0YNA255el5IALQRwxsWSV0kMnbtTqd2lBH1oetSpH2wHDe0WREAUt7l5Gls+QYkcY9K
 Atcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789213989; x=1789818789;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9eqVE2jpmUOSCFwIDYdy30fnY3VawKaF8LBSQOK18f4=;
 b=SbVNrTiycgCIhTPfLr5+uzH3vCsva+qHmHXdbrZjm2FpRBE92QQl8+4W/ce1RVNwbP
 cZ+chLZT7u6BFPUlRaD0JTh+ELxHfEhRl86NLzPRr07XO2Jqn12TsQSBKYPztXG0kji6
 LyPdwFS/o6t1R0DSgqYoXDXYxu2xeuDUIJu38oDS8re4F0T2gdyT7Z7ZWFGdv3ZtChaw
 3lwmE3IwJH6uHtdDEIRxQuWjL41xYqrtSDg3dbcJ5rhkMYUAOk9sEnN64gDrTtb5WeD2
 Dq77H9npPhSu4DQQNisgg9V911ywKHcRMLjnNt6135F98pP+ko51SksTMnqdBlfoMa+m
 WI7g==
X-Gm-Message-State: AFuF++lY6oEOd9d9oNcoWOCLJXS1hkJHQ1sf2B4jvu1EXdn/lMFAa46x
 c94Sl6peuCJgRPkXhT/0nAj0RGHg4coIC4sWf9EjXGdtWqfy81AZTXGFP6a9Ypd6X0vjffnvrPT
 jk3JWbUEJ7f4GMB0BQ3Bv90yhmX+p1Sc=
X-Gm-Gg: AYBFou37TRtIirRHjRMPevBGZA1o7sR03UCjCe+9HwP4bHSzj9qjchb5yI4wECIN4s4
 17J9D2zP47pu2eemGwK0HjZmXQ60nnxPI4XwGKJIPHu7v47kmqVYN0cEtGQwMEaXBMe+bUimmjV
 74wqxkU5YC3KO74+ILhKYU3T/ejaFmtXLHRQ99PkCU4wbLPPch9OHEJfw5DyDXIC+tCvwaW3nO5
 bVKhWVfBEot/ivPgL9lPP0RMaEyZKO1EYMIkxes/97eO3JZO8EVoCGLhQikGixHarVYjGX43UVB
 iAv8TGiVLRmllgBNWUybwHmyRHXZEbkgu0Q86J7JhqZ0GF0z9mFKk+84ptJJSgeOVTYPHWg7mvs
 Nhrh6JEz5Z3I=
X-Received: by 2002:a17:90b:4ad2:b0:398:9be6:f996 with SMTP id
 98e67ed59e1d1-39d9c34a241mr13663486a91.21.1789213988631; Sat, 12 Sep 2026
 04:53:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260825172051.435372-1-andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20260825172051.435372-1-andrey.drobyshev@virtuozzo.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 12 Sep 2026 15:52:55 +0400
X-Gm-Features: AcwNN1Wiea5caE-Ruz10uSWSobBRoUW6_hRAQWbybJeEBeNrlWYSOrMniuNo7bE
Message-ID: <CAJ+F1CKz4O=Oc3R2ZQDF3Yn7YkQtzCKkDud9mrQee0+j8cMYnA@mail.gmail.com>
Subject: Re: [PATCH 0/3] hw/display/qxl: Avoid crashing on stale guest
 addresses in qxl_post_load
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, philmd@oss.qualcomm.com, den@openvz.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pj2-x10.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, Aug 25, 2026 at 9:26=E2=80=AFPM Andrey Drobyshev
<andrey.drobyshev@virtuozzo.com> wrote:
>
> We've experienced crashes when spice-server aborts on migration target
> when processing an invalid/stale guest address pointer.  While those are
> hard to reproduce, it seems they can be fairly easily avoided by simply
> skipping commands with invalid addresses in qxl_post_load.
>
> Andrey Drobyshev (3):
>   hw/display/qxl: factor out qxl_guest_phys2virt()
>   hw/display/qxl: validate replayed commands in qxl_post_load
>   hw/display/qxl: trace skipped stale loadvm commands
>
>  hw/display/qxl.c        | 132 +++++++++++++++++++++++++++++-----------
>  hw/display/trace-events |   1 +
>  2 files changed, 97 insertions(+), 36 deletions(-)

series lgtm:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

>
> --
> 2.47.1
>
>

