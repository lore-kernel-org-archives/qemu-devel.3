Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB05EFD3779
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 17:40:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvIrf-0007Bp-Aa; Wed, 25 Feb 2026 12:39:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvIrc-00079P-6L
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 12:39:56 -0500
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvIra-0003gj-Lz
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 12:39:55 -0500
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-7986e0553bdso6679947b3.2
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 09:39:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772041194; cv=none;
 d=google.com; s=arc-20240605;
 b=a6zDPSGbweQXi3vnPwSdAnWJoYxIa28a4rO/485+IOGYuMMKl9UEQI3qVqekeD3FVy
 T1IkkqJndDjHEFuH5aVu4SwDg8wS+3gCLizbdMpebGTiktbZNnO4zUSNYMfi9jClVV/O
 jlG+bzexPtjcwSgLR5UZ3iEAfnIA23yTaTXjKfnaS3OfzoCXTVdHAYGfOsK9yzZ78Gql
 GUMeQ2E3WSGo3cVqSBN3BbMid17Hy47jDhdRqqE++PjVgCxeNpV0GgQIhVVkmkThmaCy
 1a6JPrjj5rhHX37Vapbfx4X/DMh0x7ElxTQHnAtqU2wNWw4qfq1mqWggbRuaaav0+SKK
 e+YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bdRGZOqeEOBOacNi4xKQxNU7losX1c7ejXBpAXBJYSs=;
 fh=5Q281T3cc8WUg4epsyFmyhkHOeoXoHkugv2URdONmqQ=;
 b=M7TlgavHunud2uLbnltQte+EhvLYrbo8gh+77hedeC9aqinClHrvj3oE2Yj6fATuqW
 /KxY1ov1+rpIErmcVhfwML95oD1gCYHAudHrkydZsV85RfW8KYo73GUW9UYWweUAito6
 iyUsLaceaFFHah/aBDMeBTwk/Kxy1nliFrdvNoTHZKiOhwWpADD6nJMIMFJpQ8+GkiP5
 bA/ATgZKcrL5y/HmSFDpj/AH/hzjIyQYDx9f/Vq48Cz/KV0Vl+l1GrPD3PV2XeancY3E
 sWOOq8+Ag3w8l4mySKVeWaj0OYN3ZPPSX719u9EPDTXw3NWVzZeHZlGpDomv/0P2CNdD
 1BeQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772041194; x=1772645994; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bdRGZOqeEOBOacNi4xKQxNU7losX1c7ejXBpAXBJYSs=;
 b=NS9Fs5wG1W5c5ydgRjEWYtGRfC4xu9M3I1vTMwX0V6CIzHkzpM+IrTyHEgoQQGFew3
 SJRWTAfiqwhG8AitXxVSpitmbqGCk6Z70tJ3rzMyz9KxnozYzgVf/do7pgs3jDDNGDBW
 XyBPuUsj3b7rAcz5BniSQt7bbv/gKVYVnJtTnnDGEj36C/RqG8rKBF2ndS9auA2yUJLU
 OSHmDguzY5aYq4cZdA8UHnM4dG5kB0r4VpE935DdsmOxdIHnAJVWgWEWWMX2ZE8MV9sw
 TqN8r6GehuweWwPFfCuZtoebZDuxFnuoJN2iYD74lHNM6EW8OIuHbsBYenOxxMmlSMRy
 cEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772041194; x=1772645994;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bdRGZOqeEOBOacNi4xKQxNU7losX1c7ejXBpAXBJYSs=;
 b=NmVbcPTWnVnKpqYQzd9Rl/CETHv9/dLVIzOGKd/Ocqqz5sFnqrYvbdGFgaP/QjVZXf
 Y7ouWMszczllRg5RjyAV9Yg3dtlEugV7i+vVyw4DVPrJKmEUPMHJeOUriaDOp/VqEMr2
 ornooHBBzCeSYnJrr7JbL/CENoUm5pxOc8Uhh5rR3W6F4qQuH4tbWTGckpBQbguIU/F9
 6lSJv3ffoMbBQgO6X7mqFLkDh3zoSUxI8y7hdSgbZoyKhIU6qhTNtjeAXNgDD/1LEWDd
 r69vQ/aPvl8n/TwOolNxd3Un+HIlOc/uSwea7qfLuDanTpwtIowMeqKkeB3cpkz7FltO
 JK8g==
X-Gm-Message-State: AOJu0Yx2KeA55SxoEzJlY7J2I8uEdWurQQEHwj4j/1IoY5P5+NxMG1/T
 QoMBNRy8c+rpNhR7GUgucko8f4t5dhp0YuuMku3ORKQAePOXcIpzcxLy37t+ciSNObnVlG/CdJi
 qMnldV4+055vfO0EgocbB+alhMNUELp0O5h/BhOthig==
X-Gm-Gg: ATEYQzz9h4b6Ith2ihavYAsfFbhYZ/5F6ZF2AzssT1+vdleW5q1KtSVtWeEBx5Ru+Ir
 Xq0Gl3RVwan7S9O8IewKiRMK8uBqpASn7/G2mEkxuAPnxtld4p7Bl7iSM/gN9nqPSHgYsCczt58
 KM/NYlZB/lW0X2pJvqlI3GtAUqPxgOxjJwVeiRMyi1MuaAxrvJsa4rB+vq3cT3QtZqa8PQK7jpC
 +BX3+tq2Cp8I9fecIkjJdfg89Dv7Pyu2Xb4S2wplhFETkMEw1Q9unaRrXKdL4N/C4k5yjQXE9fZ
 kqrklbZ1Vso748KlCnDl+iawCAWprcffZbIfDq/phtozqA/PY9Hk6vB3wLale1fcZcM=
X-Received: by 2002:a05:690c:e3ed:b0:794:d4c3:3152 with SMTP id
 00721157ae682-79828fc1d2amr153513077b3.31.1772041193583; Wed, 25 Feb 2026
 09:39:53 -0800 (PST)
MIME-Version: 1.0
References: <20260211152508.732487-1-berrange@redhat.com>
 <20260211152508.732487-27-berrange@redhat.com>
 <CAFEAcA-08J-_dn22s858QtUPV32VM4OuAEgBV-WdmGGxvJSu0w@mail.gmail.com>
 <aZ8jpGpOWXf_lByk@redhat.com>
In-Reply-To: <aZ8jpGpOWXf_lByk@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Feb 2026 17:39:42 +0000
X-Gm-Features: AaiRm52YXMf8w8v_OhOSDj2SrQrNPERXD2CrvWxsg1JskEemlg1rXj4AiPeS3kA
Message-ID: <CAFEAcA8sCi2HD33JuMY+JzsCFobOVhy9T9hPuizPhTfr8YXRqA@mail.gmail.com>
Subject: Re: [PATCH v6 26/27] util: add support for formatting thread info in
 messages
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Wed, 25 Feb 2026 at 16:30, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Thu, Feb 19, 2026 at 10:29:56AM +0000, Peter Maydell wrote:
> > On Wed, 11 Feb 2026 at 15:29, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> > > After:
> > >
> > >   # qemu-system-x86_64 -object tls-creds-x509,id=3Dt0,dir=3Dfish -d '=
trace:qcrypto*'
> > >   qemu-system-x86_64: (772366:main): qcrypto_tls_creds_x509_load TLS =
creds x509 load creds=3D0x560db818e080 dir=3Dfish
> > >   qemu-system-x86_64: (772366:main): qcrypto_tls_creds_get_path TLS c=
reds path creds=3D0x560db818e080 filename=3Dca-cert.pem path=3D<none>
> > >   qemu-system-x86_64: (772366:main): Unable to access credentials fis=
h/ca-cert.pem: No such file or directory
> >
> > Even more output enabled by default that is pretty useless for most
> > uses of tracepoints and debug logging :-(
>
> Getting the thread info in qemu log output was the original primary
> motivating factor in this series. This short example doesn't show
> it, but when debugging/tracing QEMU it is pretty important to
> understand which messages are coming from different threads, so we
> can correctly interpret the control flow. Pretty much every logging
> framework these days will include some thread identifier by default,
> and IMHO it is reasonable to do this by default in QEMU too.

I have basically never found that I wanted to know in QEMU
tracing which thread was involved, so I would dispute its
importance in the general case.

There's plenty of other things that would be more interesting to
me to log by default: for instance in pretty much all our
tracepoints in devices we don't have any indication of which
device of possibly several instantiated in the system is the
one producing this log output; having an easy way to have the
tracepoints include e.g. the QOM path of the device involved
would be nice.

I don't object to providing optional logging of the host
thread for people and cases where it's useful. But it's
pretty useless to me, and if we always enable by default
all the optional stuff that might be useful to somebody
then the trace lines end up being a mile long and trace log
files can become huge. Why can't we have this be something like
 -d thread-ids,trace:qcrypto*
so people who want it can turn it on and people who don't
want it don't get it?

thanks
-- PMM

