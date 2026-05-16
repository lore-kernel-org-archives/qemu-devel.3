Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B481ACD4F25
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 06:38:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wO8eu-0001yE-8m; Sat, 16 May 2026 02:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wO8et-0001y4-HZ
 for qemu-devel@nongnu.org; Sat, 16 May 2026 02:37:59 -0400
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wO8er-0007nt-WC
 for qemu-devel@nongnu.org; Sat, 16 May 2026 02:37:59 -0400
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-2bdcf5970cdso334115eec.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 23:37:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778913476; cv=none;
 d=google.com; s=arc-20240605;
 b=eW7m7bNlP1MfsqkqnRFqlpkU6BZZv7RYUuIPQJeR9rb5fhY82vBK+7/QN013GsUwf6
 u0gmu+ahkMkpEC5juejLvGHfQ5zBCxlmOIBBBUf6Eo3dtrULj81lusL1DPOYEqV221Wo
 F8mfSCYVM2+tHnwQgnbazQ2JuGGN2x6wGIdf+N0189bLPUu3N/g3iuXzoPqU3ueQ2TjP
 Y8iNuUGLepADjGwt1AdrVjZUo4Ami36PuJTfWQlP+aVMhp79CdZDzpmsZfbNb5H++FCs
 iBY6IEge4ZdDFpl2DJORSYnWscGl6n44h/3NrOhVjt34yjMun5yottJKJzZzOeK42l5z
 6MuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AVQETZtQ13S1hIH9u2zWetK6wsDOJq2o6Qx7IFXlGdM=;
 fh=G2NZjhr0Y6d+bdm3u/pm8DwvT9RU2Z/AkACVIgxH27E=;
 b=ZCQKx6h1utBZfEGzRbzr+yeuK2kH2FDvfLgRH9CYfSUTqqz/fPUI9K6IrYyvu938Yj
 Yy0DKbIT/d08v8Ncld1kbHP3eBEgTssK6B3oRSm8jMrDigY7DdZFaszzNjJrbCbJEhoL
 ynWNqpWLOUUn8CJJknMJtBKmAKxdrZvNMaXy8hbH20U655kQBqwasVu9TcbuMaD/eR56
 l26TVoCLlX7CbqkxHNT7UhvJ6fF8VsXl98H4st2B++QOK6MmuCIrJfbLbGzyocZ74YkP
 EpQF4dnSnfFxj7obRjr2kd1GBJdcXve1d58NczMEi1b1sZYXlaGmoOSQtdV1RflLsJRM
 ZlGw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778913476; x=1779518276; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AVQETZtQ13S1hIH9u2zWetK6wsDOJq2o6Qx7IFXlGdM=;
 b=BP2GEjVPVvVHkcZhMvrpk7r1iRvM0ijFUAbcgQ1ztmh9Fb0l6UP424Id9peYupl9EV
 vNY8jsx7vCqw58WapuFdkh9tYDg8CyV1ydfOwu5TTInru1sQ9CnrUPW9lebIO1ORQEIG
 gSH3oxekaotwiXKJF9JRcI9ODjWHxjW76n3LJKaqcywsLVsq0HQn7Jd6n6u13diS+hvJ
 a2Yk6vsI0pxxv58MXTglyR06BJIc4QrcZJWXRv4m46ioB+cCV/FkOpUgQ1ewhJP7rVB+
 3RJN8GmmX55QR0Xf3UTNJYExlcHakCBalUuvfhL7VUtbgcuKjSSZIrqnmAWdMeOsG3TV
 HxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778913476; x=1779518276;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AVQETZtQ13S1hIH9u2zWetK6wsDOJq2o6Qx7IFXlGdM=;
 b=WsnPyJbPL62a/6AJFL5CfcCbDSXC/t5j552tJcBtQ+m/RSazXLKzg8ohPC6XPbdHGr
 XGzD2VwM4/OlP/JW7MDb9wyXvdnD4zE9DFwgSzuhtDNcec8+RANSS0yttMbKKGBXJtck
 k4oHPlvCEsruBmjYgJXYPJcbEYOCBNBygR3NaUWm+x8CsHmYW9q8HhpHgBjoia0WcWtr
 EGxOqNKKiJaK+fJFJescwdkWi5jiK1eGoQtTafj6VuHYZ0y4JA8NaB0M8rMpPCaCSSZ+
 MDupPTZ2nDohEjt/GTSif7deeGzz+TGmAYbBfhUeoqBYPF+qY1FZUXZZ1KVfnka+JEJJ
 UfZA==
X-Gm-Message-State: AOJu0YxYdkokyNpKwtM1tp79c37G8bSYAWvqRT6wDI0/0OMybtsIukyi
 s49R0hJE7iiIQzQD2npqdDWdbbS+mWFwRA5KBJkUPKin3n2hoQ5oJfAtNoJIJiHQXg7u4MOj11y
 +KC5PvU3f1YhyC/c08opcPISE7aQgjd8=
X-Gm-Gg: Acq92OF6RWTgSl2gpFEKftE71R6NCx3DdcImzVOmY8hRcLsWn4xBmvUdAJGL43TFJak
 uedYyz2Fl7U1YF9Za11sDuXBQcUUYgyT24xLFvNuytfGrx7XFDnn8UmRd2W1Swf8/TJ6vqHK2qN
 e/NZCtVJu6IhjFqXZBHf5zmSmI9p9Blnutn0IJGVcj2fwcM+gOhJ+R/yDDAK45QdglvGLmBwE0q
 JbudeL7AZev09+BomAq4gmZEpUFVoqb6PtqJC2C0TGA8RVewXK3u9NXSyCq++O/moFhOuHpeOKv
 qVmw5QH7EtiA3KRq+txrz3tgDVNCe8uBo/bhyVY=
X-Received: by 2002:a05:7300:7885:b0:2c1:82c2:bc31 with SMTP id
 5a478bee46e88-3026197f5b2mr5154834eec.10.1778913475795; Fri, 15 May 2026
 23:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260514191844.105888-1-matt@matthewpenney.net>
In-Reply-To: <20260514191844.105888-1-matt@matthewpenney.net>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 16 May 2026 10:37:43 +0400
X-Gm-Features: AVHnY4LPJeIxoSZMgddGnZjzZ5c5rUzF2WM3wZNPskNHCt5WELyD0jjJ-R5veEc
Message-ID: <CAJ+F1CK9Y8kYeUcFShzTjbz_6fatbse=VjkQyEuxFrH0aZEoow@mail.gmail.com>
Subject: Re: [PATCH] tests/qtest: fix discarded const qualifier warning
To: Matthew Penney <matt@matthewpenney.net>,
 Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, lvivier@redhat.com, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1332;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Thu, May 14, 2026 at 11:20=E2=80=AFPM Matthew Penney <matt@matthewpenney=
.net> wrote:
>
> Modern compilers warn that the result of strstr() may discard
> const qualifiers when assigned to a non-const pointer.
>
> Make 'found' a const char * to fix the warning.
>
> Signed-off-by: Matthew Penney <matt@matthewpenney.net>

Fixes f606321be8 ("tests/qtest: Individual verbose switches")
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  tests/qtest/libqtest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index bf9284b9a1..b1e06ea364 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -2146,7 +2146,7 @@ bool mkimg(const char *file, const char *fmt, unsig=
ned size_mb)
>  bool qtest_verbose(const char *domain)
>  {
>      const char *log =3D getenv("QTEST_LOG");
> -    char *found;
> +    const char *found;
>
>      assert(domain);
>
> --
> 2.54.0
>
>
>


--=20
Marc-Andr=C3=A9 Lureau

