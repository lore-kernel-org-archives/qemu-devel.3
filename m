Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4168D49C83
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 09:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlkfM-0001lT-8x; Fri, 30 Jan 2026 04:19:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlkfK-0001l0-Pb
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 04:19:46 -0500
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlkfJ-0006qe-2y
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 04:19:46 -0500
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-7948e902fadso17861077b3.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jan 2026 01:19:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769764783; cv=none;
 d=google.com; s=arc-20240605;
 b=MsnJKE4AJvTBzvM6f/LI+CqzIBuaq01q3LYO1Cqt8nZIGkUIms0osHFyznVBqPN4Xj
 R3qtWUuwyk9ufTDcjxf4mpHFXm9qvFS/gUpUDAWc7sPT3kNsCgN6wZtFwQJeKjpFwdrB
 QnW2QmWlgskfTbnNE+7hfl7YMYrbOGQvK1orrlbgBFXh7WlitYcZIfnDmPo8ohO2+6jh
 G8xSCvQIdnFscH2+NeQlhqvDwHTCRxXi7IyNDMcbXnzBPsLDeJPDIKw6MzlYbec2neo2
 kh1rFqs4OyZvRP2JwH1A96Kn/PU6C/GlawH1zQsZ7W8AcZ6mmkrETacPzaELSg4T4d/r
 Qt8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dhPgQOAtxKG+XLLzcQh/xqtiqf5dxmTUI9MO5HNg6us=;
 fh=Eaf5cQ723ZQPSqRb/qGjygjUJf+CZ8mgNgtIDKLN8D0=;
 b=CnXDPREStJcG8i8YFyH4DYjetuCYMJmy3Va90jKA8j+3Whm0nTQGxCY7OhuTNqBRQQ
 jgBtg3djDAZAYyR5K+LFrj20/RMLbV9R6mm0amV7b+KEX1m7evHdJJBBekhNhlB5HXt2
 zoKTv7NzG3lgc2pNe460t8KBIV4BZWIn3drcOugIZJlUCWFkXcmWlpThSWilcZb/2pQu
 DH7wnzZgG56k9C8ARbzW5VuDbCxvTsrypo0RROaKF0uvVxvqLUsJlN2fhWQOPoqfsi6w
 XszsjprFmHRuYyDBJV8NoRLRyISg/9Idqd4BeJ/sVoOWfmIKu7bVPFXtsIKy3HuoKwMI
 3G4Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769764783; x=1770369583; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dhPgQOAtxKG+XLLzcQh/xqtiqf5dxmTUI9MO5HNg6us=;
 b=CzCiLcDQW3NXjFCiRo2VEyffLWBA6aV5LBrZzuqzWIV3TCM1+lTa8OqqMz0Q/ZTsiH
 jkea+9CXPf11LzfxSHF9aqlJq6rMhsyj2GRw9TxLOtlMtGJQ8fH7+MkyUtAdMdzIIIuS
 lf84BGeU5ptmkc9SfkN54HBsQb+V0BAeKv3iOWfHDHECZD60WrZaq1M1UUlXBUN9DnHo
 s3G9T6xxMWrv/hhatO4bPnyrG87VQyiewUautB1nbfWg3UwULpIskceflUmvxOSu7SX0
 79OGUq4mq3UqKK3+T8pA5O/rIf7i1JE4STl2cntGila+4dI0+pZ1yfpSvynDB+xWO7C6
 co0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769764783; x=1770369583;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dhPgQOAtxKG+XLLzcQh/xqtiqf5dxmTUI9MO5HNg6us=;
 b=Ew2oRM4aw1Cd8o+XqmuRNyqajR20NO08xz/RQxrMJMf+/Sj950onE8WSqpwMUFVA+i
 EwcUSbG4odt0BTLLL3SnmCE7CpJqbj1kiqdeXSBLMII87EZxgk9xXovFpKEj+zk6FXlF
 wteMq88vzrApPBDPjJm26fX9M+S8SaOnFz4RFJWzYTkRe/yNvHodid2byBHVvP+6gvbU
 NT6jLofnvxXm3JAJphYHyy96MbJOlIy65fR3JcS8if3wJb3ETlYGE3+jWutbL0vNHAXB
 ZXSLN+wyMkRg+BXHdr1Gz6wmuqW8Te0YWdbcIzFhKXhpLhMx4G8g28nVMfFxnoXXywmK
 7Khw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXz6nDOe6TaJEfrmVbLJMMh890ZbZk2uF6BhwKAOXT5/LZbb/9e0xlK0oG7ATS+Ffz+n/7HYsGCA9pY@nongnu.org
X-Gm-Message-State: AOJu0YxgJ6kZhecKPsqPNGbnhZA2iQUPrPao15i4oNpKNYFS31fe9DEU
 rIQHTrK3B11eAoU/3Z7Yx2468zW5xlx0JjLndTFXv2B3R6yBYfa45eSdZYekC4TMhG7OzG4AWZU
 d4ErEtARoj7K/CStysbL+X9nX8TsvkFHCE0Yr4PGxhQ==
X-Gm-Gg: AZuq6aKC6WjFM0rgxWN14wYsfBv+egqLP0K/Cx0AaoJSu9TraX7wISGqz0recUBwBqO
 snMGSdTQ+6yLSplzpIHN9aCMPaOkHGmm7wxWx+ZaN02h8pB592/aa1t94LY9LkbN6uliMw2bq3h
 SvZJw7BfWoiRvQK38hrciWu/DP1uqitdfoMir2Z7Vp3VxhFOEe+nGtGIWldm80+akvc8qraBwYq
 kqXxxqP61ixUxRT+Ml/6ib1BXEjq4Pk4lKggLoh5Vngawvu2jqEL4yYjL8F27fmD10iOQ==
X-Received: by 2002:a05:690c:f08:b0:794:8603:3b2e with SMTP id
 00721157ae682-7949de65372mr21142437b3.4.1769764783434; Fri, 30 Jan 2026
 01:19:43 -0800 (PST)
MIME-Version: 1.0
References: <20260129190444.225306-1-rkir@google.com>
 <10b26b57-bcd6-4853-9e2b-b8410b404806@linaro.org>
 <CAOGAQeqsvEDMy4EURsWNAmRF1ZmSfmj0+s3LzxSEw7JZVeCdTw@mail.gmail.com>
 <CAFEAcA8E5RZ1ZRy2dETG_X20dJPq-E=uK9=wvM8oUn897gj2Yw@mail.gmail.com>
 <0954062c-c032-42be-ad0d-df2559360963@linaro.org>
In-Reply-To: <0954062c-c032-42be-ad0d-df2559360963@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Jan 2026 09:19:32 +0000
X-Gm-Features: AZwV_QisZ3FSmx3FoBm72lXvWTqGBgF_KgS0HsKwsLUiBVDn_LcI2nWn33Bqvd8
Message-ID: <CAFEAcA-ShmtJ2tOO_bz+d_oKJaDTG15bc9s775mND=FLWQdRpw@mail.gmail.com>
Subject: Re: [PATCH] ui/kbd-state.h: Make the header C++ compatible
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Roman Kiryanov <rkir@google.com>, qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, mjt@tls.msk.ru,
 whollins@google.com, 
 jansene@google.com, jpcottin@google.com, Eric Blake <eblake@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
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

On Thu, 29 Jan 2026 at 21:44, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi Peter,
>
> (+Paolo / Eric)
>
> On 29/1/26 21:31, Peter Maydell wrote:
> >
> > What are we trying to achieve here, and why does it benefit
> > us as an upstream project ?
> >
> > cf previous email thread from 2024
> > https://lore.kernel.org/qemu-devel/ZnqPpqfBxlk9tEdX@redhat.com/
> > about "drip-feeding" of this kind of patch with no clear take
> > on what the end state is or how much churn it's going to induce.
>
> I clearly know QEMU is not a C++ project. Now I don't see why we should
> be reluctant to have headers being usable by a C++ compiler, as long as
> it doesn't make our project worst to maintain.

Every bit of code that is written by some downstream in C++ is
some thing that will essentially then never be upstreamed without
a big rewrite. So making it easier for downstreams to use C++
reduces our chances of seeing them contribute what they do back to us.

It's also extra work for us (for instance in this thread you
proposed adding a CI job, which is more CI minutes cost to
the project, more work for maintainers when something that
builds fine locally falls over in the CI, and so on).

Each individual fix might be trivial, but they add up.
So it matters whether this one is "this is the only thing
we tripped over since 2024" or "we just rebased to a new
QEMU version and are going to be submitting dozens of these
over the next few weeks".

> See for example non-invasive commit 7246c4cc470 ("exec: don't use void*
> in pointer arithmetic in headers"):

> or commit 17c7df806b3 ("exec: avoid using C++ keywords in function
> parameters"):

For the record, I wasn't really enthusiastic about those changes
either, for essentially the same reasons.

> In this particular case, I always have been confused about what would be
> the size of forward-declared enums. The C99 standard chapter =C2=A76.7.2.=
2
> point 4 mentions:
>
>    Each enumerated type shall be compatible with char, a signed
>    integer type, or an unsigned integer type. The choice of type
>    is implementation-defined, but shall be capable of representing
>    the values of all the members of the enumeration.
>
> When compiling this file with -Werror=3Dpedantic we get:
>
> In file included from ../../ui/kbd-state.c:10:
> include/ui/kbd-state.h:12:14: error: ISO C forbids forward references to
> 'enum' types [-Werror,-Wpedantic]
>     12 | typedef enum QKbdModifier QKbdModifier;
>        |              ^
>
> So arguably this could be fixed for C.

Yes, I actually like the specific change in the patch
on style grounds. I'm just not a fan of "we should make
our headers compile with some other programming language
that we don't use". C++ should have a better foreign
function interface for consuming C headers that doesn't
mandate changes to the headers it imports :-)

thanks
-- PMM

