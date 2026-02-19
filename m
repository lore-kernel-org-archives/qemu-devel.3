Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7956E9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1CJ-00036x-Uv; Thu, 19 Feb 2026 05:23:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1CI-00036D-Qv
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:23:50 -0500
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1CH-0000yS-89
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:23:50 -0500
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64ad46a44easo661611d50.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:23:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771496627; cv=none;
 d=google.com; s=arc-20240605;
 b=QZLadl0N+VyQAgwxLvRCuhrQLgF9Q+/VGniV2ub6JqDhrnEkO8K/nXHFFPy3n+pHQc
 jmTrvjPFekK+EJjn/IndLem/c/CYUz/+rGKDP9kD4nBRL9IabiWWybaWlcS56hEvovP9
 c+1YdpwMT1XgXJGC335DtIOrzVyAWZKg2Qu3h1clx7tO6ui+5duoC/GA4yMTtH/6fRqM
 NRqstoEIUmJNgD/pmU+ugL4zL7mzV/L66/s6c+t/ZC2CYdFPfHp9KKWG7qCEb91gK3lA
 KNZVXSDcXsSO0m5CYnT+y+3pZjLYfHgUryZicIrR5ho85ya3E/7i9KUanMYg/4+M0w6r
 CclA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jQYXw6sx10gUEwJLfbA+ICno0L/ffvARi0dVcJmefc8=;
 fh=5Q281T3cc8WUg4epsyFmyhkHOeoXoHkugv2URdONmqQ=;
 b=kY8cT4Dj/GQ/76W7zSOCu1NJhrEKgrsw8ZMBQYO27T5QLU0i4xiztHmnViN7tU1bPj
 2faX4anWIznslYO66oQyXCiSDlUKBi/pKZbqDqfXwR5kmxAdGsYDHMVQbXfjm156F+jF
 3FkgnxUAwZbzb3zSNYMH4XZuFTvDatajHLN7gZUymfMYn7hWIN3GE/Gj+0N8YCl1HT69
 JDROEowtOKEoXlpDy7vcrwNQ2lbGhuRgCallaWdUZ3Ji65U+vE9dpm1SP6FatX63jW2b
 3aaiDE0z8PoKnULzfz9o/I7+lSIZMzN/DJFfh02LYFG2UdrHkWZxTgFXyz27HbJ1WMNJ
 T8og==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771496627; x=1772101427; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jQYXw6sx10gUEwJLfbA+ICno0L/ffvARi0dVcJmefc8=;
 b=q+v9gGTGbHgUOpM8NAJsqXAV+sE2fcXgvWBKEOekw6aCOVbnriM3IPdbK1OqMU7qdf
 dx+Qva1MwR8+5+kI74YgKoi/WDMSLgrO6kevuX8m/uL2AYRwadEqOZYzZUa9w974Bsl3
 i6NyfN/yqyFPiSp/yQtxWQse85yPr6MIRt+7a5Nvws2pd4JaH2WmaDB7Jk19Qx2jy4ur
 cVUpWCXFkN1VH99ye5Hm4TnmkH7z30LdgGIgJMKV9dsCoKtc5NdvorJ1qLKZ4jSF1it3
 A4K2y7ulqkLo6pbJhC2ct/vKpnv1U8SwrfGF6fGPg8QOlxjQPHgaSDjJdpSL5gerOdU/
 pyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771496627; x=1772101427;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jQYXw6sx10gUEwJLfbA+ICno0L/ffvARi0dVcJmefc8=;
 b=Sbix+AmzSUR7dpMM4X/tEicXbvJAiH3z2o5MI1KAuADpSkWXTpXckU26xFf3VmSfFL
 QvOSasCVmJDQTpOPgBGCeTlAJaqYXSzCqlVZLgz9d2QvDbQiTrWjEXnbTsq2RHkxWmA5
 MkYV+PcSKTwBBayAQhKz/o8X1hyaTalLeWKWhMp0EDeWRrw8YpDJD1nPki9ATJpWRG4d
 e+DNFX66BG92/qEMMxC182roWNOcyBql9O2NOhCmgrOv5oRc5xDwThfaQ+1LDWTiBYm7
 WTiZoXampzXwle0gEikICst5t8+NqObx+twsEUTMJCjsIHcvPDykCvwewkGcug6v4QM7
 Zr6g==
X-Gm-Message-State: AOJu0YxnvVa+R6R2wRh8/ZVw7xCcQzbKcfWYgIE136X3/H/EgcbCCcTS
 FhLcsz7JzEJ2yyQjKR8qq0ldzJf/D6krku1uq2+DM6bJhV7lLGPeDpZrg7DTKrqTCKxDu2JFAU9
 +1WQ9dTBtxY1xwpwMvbvM7+6P6ZlotMba8Fl1wKRXCA==
X-Gm-Gg: AZuq6aJeKqc1OjbpfYd8EZwST9Nw29cExCee2QaulqRAW1GZzJw8cVxSuoKJswPZ8Lo
 VpOWB0eknVMHAM83NcgdkfijMISQZfJK4d5xNx/9FHz2amMYPyASfvJdIQ9+Enj3xpDoRlN2i7W
 LQvWtPAjUvxGRSnSnv+OOWgxR6FBbn9+IU/5K4/wTDrz5Tdo59rLn1yDk45BmVCMvjJpdg6MflW
 9KKDVVJN5YsIa/9bLOijlmqNDZpduCj9dH5MuWmGVc+JDH8kU/rtp0CE1GwhTLT/+JcWR4w09mE
 Pcu14oQlIjDfzuTLAaa7iFE55M12d1f4Rhvvlrw1ekwKR14dQk5kR+yl60BnRISO/mpOprIkiK7
 Avg==
X-Received: by 2002:a05:690e:160a:b0:649:429a:4577 with SMTP id
 956f58d0204a3-64c14debf24mr12756476d50.86.1771496627301; Thu, 19 Feb 2026
 02:23:47 -0800 (PST)
MIME-Version: 1.0
References: <20260211152508.732487-1-berrange@redhat.com>
 <20260211152508.732487-26-berrange@redhat.com>
In-Reply-To: <20260211152508.732487-26-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Feb 2026 10:23:36 +0000
X-Gm-Features: AZwV_QgQBFllVjmt3-GtQ5RGuFq4ljBu7_zazL_LwSjZEMHOtS5KTQskYwLhdZI
Message-ID: <CAFEAcA-6XMp6B-V2X+=25Q7XKwy5JuOpGj9RNpN+mTNxm71wpQ@mail.gmail.com>
Subject: Re: [PATCH v6 25/27] util: add support for formatting a program name
 in messages
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, devel@lists.libvirt.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, 
 qemu-rust@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Wed, 11 Feb 2026 at 15:29, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> The error_report function can include the program name in any
> messages it prints. The qemu_log function has no equivalent
> behaviour.
>
> This introduces support for a "program name" in the new
> messages API, which will be included by default for all
> binaries.
>
> This change tweaks the output of the error_report function,
> adding a space between the program name and the location
> info. The qemu_log function will gain the program name. This
> can be easily seen with the 'log' trace backend, and how it
> is now more closely matching error_report output.
>
> Before:
>
>   # qemu-system-x86_64 -object tls-creds-x509,id=3Dt0,dir=3Dfish -d 'trac=
e:qcrypto*'
>   qcrypto_tls_creds_x509_load TLS creds x509 load creds=3D0x5584e13937f0 =
dir=3Dfish
>   qcrypto_tls_creds_get_path TLS creds path creds=3D0x5584e13937f0 filena=
me=3Dca-cert.pem path=3D<none>
>   qemu-system-x86_64: Unable to access credentials fish/ca-cert.pem: No s=
uch file or directory
>
> After:
>
>   # qemu-system-x86_64 -object tls-creds-x509,id=3Dt0,dir=3Dfish -d 'trac=
e:qcrypto*'
>   qemu-system-x86_64: qcrypto_tls_creds_x509_load TLS creds x509 load cre=
ds=3D0x5584e13937f0 dir=3Dfish
>   qemu-system-x86_64: qcrypto_tls_creds_get_path TLS creds path creds=3D0=
x5584e13937f0 filename=3Dca-cert.pem path=3D<none>
>   qemu-system-x86_64: Unable to access credentials fish/ca-cert.pem: No s=
uch file or directory

On the other hand if you're using the logs for debugging
then you now have an extra big pointless prefix on them that
you have to turn off. Especially if you're logging to a file
that's a lot of extra garbage in the output. I'm not really
looking forward to now having to give QEMU an extra long
and unwieldy command line argument every time I want to
do debug or tracepoint logging.

Why do we care about the qemu_log output matching the
error-report output? The logs are expected to be
quite frequent, to only be there if you've explicitly
turned them on, and to be usually directed to a log file.
The error reporting is more likely to be infrequent, to
be on stdout, and to be important/fatal things.

-- PMM

