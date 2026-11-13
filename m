Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66A9607104E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 18:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=DHTXUK4I
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRwQs-0005i5-31; Fri, 13 Nov 2026 13:55:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRwQk-0005eL-Fq
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:55:23 -0500
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRwQi-0002iL-CF
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:55:21 -0500
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-67990a45e02so1377093d50.3
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 10:55:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794596119; cv=none;
 d=google.com; s=arc-20260327;
 b=J6dXYQ5DO56g9nSsH+QCuyyDzL2qvIMLsksL8Ip/tD3qgiyMjfaQhEfjRxakqsCSiz
 nsFRID0/7GOoIxtLpMfIlHy44lPu1cIY5PTMZjikQKv5JttMqaq67eMKgzyjULgQzAEw
 PqxPZCHe1GZC7JSFUFFbs3WtFaz8oK5p6ClcIUY80rawxaOTsIQxzIMWsZHoyLV3L1Pi
 yVo3pEpvkw9QtsaZZL/AzOD3zGpervChhgpzCLVQNdaJKqjSI896wu2YKmfHkRcOvQHq
 mkpjDD9VpkUI+ZNiicgZwIQju4uL3mb3Ftuqi/jEWPjljQrAFbPV3jXjwHjflZjlgYkZ
 I7Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5yUQz0oRrhnwrN3KjE4ESfdFm0LqHS05K6oOdecwAAg=;
 fh=LxX7tgPD3LlDVMyq339w77dWzfJqxpF7JR3tcFjf6aA=;
 b=MKB6mPruWvh/qAAqCkYnWGJDmGLwpohDzp7nlj+7spuL0okMQCDExtxBZiYPwmK/05
 tnad3uAYzoTLxVWaPTxC+kkEWQ2gsE0xttSa98sW21QJA3olCnBRCgOTnSnBn0ipPHXr
 HoAOJkB67in3rfsRlsUUfqyI6/4dFIkJlp0LcUooRqQd0FZg4/9QgcbKNX/c8noFvxh0
 6yCRlhy8bsDx7+CPmtPjPme4l508sOmUVVVJU4YWlaj95BldemqmhFR6fs/3lVo0MHW1
 sqQQR/xxx4ae8Q7C+AXNPeJ+1osKjsW1hLj6mROzP3TQSpfeIqcUZR9T3qtA/ihegqPk
 +Mrg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794596119; x=1795200919; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5yUQz0oRrhnwrN3KjE4ESfdFm0LqHS05K6oOdecwAAg=;
 b=DHTXUK4IlAzsVZgAFs00hRC+wM1f00vwwJ/snL8mHNVbDJUpVrpBPcLLzqITZpsCXn
 yBYT20dDNJmaQPh6i/XvBOoRxu+OrwvWSOktwxtrpKTA4YG7LViv3n2dnuAfZKhBBC0t
 tqjYOXxBFMvz5zQMuNkuMO65VTQKcC3VyHWf06l9XaW2iapQpmjUz5vtrvWNHKgfQ66C
 5lYTlyuPNBStH4zOu+DJ+0lYIAwFg2T0QAUKg4zThZHGj21ToNARvdsJK1k2K+PNMpUF
 20ccLSpJ4fYXkyEBifVGFHDAfZQt/jrSSGWWemv9mR6Ge9eZHW9pMCBLXYSqXarauYQ3
 ZqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794596119; x=1795200919;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5yUQz0oRrhnwrN3KjE4ESfdFm0LqHS05K6oOdecwAAg=;
 b=XrkmD3eK1HwtRmAyiM/1JULtThZy0Dpl3a+lLHd/GwoKvPleVnRzhRwNA4K6E6gALT
 /Y/dUMZ4CtCg46rofaqLrNZOylnNHW0uyBZ6l/diqqOFu7DWJBzGjPCbDnKIXnjcbGIP
 escE/wV2IVi8V8mTHxHnuyHY0BDQvXALbcGaLiZQToWcHGfiA7jvhU+GeVfFf8uxR5Rn
 TdeehIFCsj6eUUuWUW/4Q5TqzywAB/DNCpiuY0xXfs3los43bd4TLi9PTJ686SW/suw8
 5TRSiDDBN0NsOd9UT+LP42ff5iGhNW/brQlCRl7Swv8uowvQfVt6umMRYoC9oRaIrNUY
 NdBA==
X-Forwarded-Encrypted: i=1;
 AL+hErGKaCuAcspy7de6EIlqtDhIVBMQYssqwR6FPOk2KfHs02QPLlfLPnVdmP4s3CCDUDw0qtRemPzBg4o6@nongnu.org
X-Gm-Message-State: APuU4Z+VdI1+QSloO4ghPPo+BmHgNiTt7r7dRL6kptXaAORzRa50GKV6
 Y8mXh1hWKZ4r5lsrbmQwMfHZvOQAfpH3KYmHT0pBCzUPMP9PG5rvm9EZx6jjhpzptEdC9xTOKO1
 VfoywxzwhqLjSaQ6+oOayUxbeqHQ90aWXb6Toqp1plQ==
X-Gm-Gg: AYBFou3m5aF62Ly8i755BT/LhBg5qsinlkz60KEHDBPEk1SA6f11ujvfaBjxr+nBPLY
 XtsN4trTqG4BmkKUqizFk/BnTRxOzN9h4YLW2vyaUpl+HLtSu7/5FBBCz6qmfjE/9Ri0HGJ1sCK
 viPflicX9AP+H8wR4VHbYQnNgHq1GQTzCE2uHdgtjca3CcHPriHe/fdVqKQyReb2IDjWOqybvxi
 3DFj5arMlU6h8Ajrz/TmpW24z+Ff4hiNi4Gys0AhmU97xSJJw7DHYMGRtM19+kdWXzQTsjG63OC
 4k8m9sQ8MpDp9b5PlALBTErFsmDOp3gFte5I62hFoZzSThazGSHa/Fm21eH1ndPv4fLKTyJrqu7
 ShiLKgt65RUspKZDAw9sjgzr1uCIytTYlybsPr6hU4mF3FFVM8gTMhphHuAUhXUv6PnxpDHyJBs
 TZTjCrAUN9wWuo5xHn9XyAr0l2aTMRjjXGU2Edvhee+Q==
X-Received: by 2002:a05:690e:4811:b0:67c:6e85:56d6 with SMTP id
 956f58d0204a3-67d8971822fmr1642868d50.48.1794596118523; Fri, 13 Nov 2026
 10:55:18 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112180859.85380-1-philmd@oss.qualcomm.com>
 <9b64d3d9-736d-4878-80d7-4caa75eee778@linaro.org>
In-Reply-To: <9b64d3d9-736d-4878-80d7-4caa75eee778@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Nov 2026 18:55:06 +0000
X-Gm-Features: AclHuK_VVHo-e8YYO6oZ9bWUpkAFBAvn1WX8kWyMt4kCMftTN7Tg82QS4Y9Goc8
Message-ID: <CAFEAcA8La+8TqFY0yCxRsXY2Ad9MA5Uu-sVEbysExZPkUXVawg@mail.gmail.com>
Subject: Re: [PATCH-for-12.0 v2 00/12] linux-user/aarch64: Support both
 endianness at runtime
To: Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 devel@lists.libvirt.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 13 Nov 2026 at 18:39, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/12/26 11:08, Philippe Mathieu-Daud=C3=A9 wrote:
> > Since v1:
> > - add ./configure error msg
> > - cover ARM32
> >
> > This series lets qemu-aarch64 run both little- and big-endian
> > ELF binaries, retaining qemu-aarch64_be as a compatibility alias.
>
> Why would we want to do this?  qemu-aarch64_be exists, but is
> essentially unused.  It's certainly not supported by upstream Linux.

I know the kernel just dropped big-endian kernel support
recently, but did that also extend to userspace ?

(We should check with the kernel and gcc folks about
whether/when it makes sense to deprecate qemu-aarch64_be.)

> Having runtime selection of endianness seems silly within that context.

As a more general question, is this something we would want
for architectures where both endiannesses are relevant (e.g.
mips, ppc64)? At the moment we consistently for all targets
handle big vs little endian as "it's a separate target with
its own executable". That's convenient because you can at
compile time hardwire in things like variations in struct
layout between the two. We could switch to doing that kind
of thing at runtime, but what is the benefit we're aiming
for by doing that?

thanks
-- PMM

