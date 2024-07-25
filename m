Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BCDC3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 20:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX4zE-0000qP-HL; Thu, 25 Jul 2024 16:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sX4zC-0000nY-0f
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 16:22:50 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sX4zA-0001Z0-8L
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 16:22:49 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5a3458bf989so1681111a12.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 13:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721938966; x=1722543766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=H5WrtMpmX8oGbQz3GDWG3CL3pLbQm5+Fde99piSzVa4=;
 b=hR5Rc2o6a/HjAO2w7t892JwVbM9R448TLTFxdMOYBGtP3Wk+H/rMt05BIQHLqKbKiF
 3+1OKNEEBRKLQnFSaxUNBwvXc70ldiPQKX8mpvo94JR7gG0edLF07GFe29f7LoYZ++nG
 PD9GLkw6GUfsuN5yZ9NPsYBlw0ayY/5p/EkRKu9qGjhDYvRlOe4MQJQDX2SzcV6kK+0b
 zWEveo7kP5u0wXZ1ykWI3N6+6fGInAudk9nzDmqa1h+kshTXxBzT14yYu0TBJwa4iAOH
 L6f7VCkvIXVT+BMj90uOgPJ7IQxv3VFiYjG0EsNyNsQSj7fPWrPNwMu/+rDeOxsq0Bme
 czqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721938966; x=1722543766;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H5WrtMpmX8oGbQz3GDWG3CL3pLbQm5+Fde99piSzVa4=;
 b=bk52SbS6ax4f5f24RIWVq9uCCzr77kuWXAOAeTxvfYnpYO1fAcvSHYqjOi7+GORQxl
 Z7YauZPE0hDOTU/mRmA7X5Vm5u+ojccez4IZcfO4JkvBh1eIC82rhkYim9t7JI5Uf+JN
 B46a5gC2JdL74absaSwaeJS9ewITGlPrgTk2HGjg/yik39HJBpNBAS3J9W4CzMoiTGTV
 50tDU9DNsqmgZh+TunWOfrxN7YzjCBPBmmgur+QAmHMe6jWokoSq0YOpxP9isPIXVZWu
 8qQ8rf336o94or7MTAdYAxL8zK0reb5CvBWDfzYQrsyiPQk3cyRMqdFuJQDroWVFaAAS
 tqXQ==
X-Gm-Message-State: AOJu0Yy3lZjBuKh+/tElMXjsaF/JCzkRdZna5zKpXbwpLhEySkCTqC+4
 DCLT0fc7lcPJfVq6IQ4pSF1XJ84BXHJcv8FJ3NEAv2ZbtSRGOOGKSvUj4Wxap+0=
X-Google-Smtp-Source: AGHT+IEILAUuufu22k/n6tb7U7NDKM6dqZWObApISTcwF7ozLPTMIbWsPSKBG77D1PjQNqOCsvzgIA==
X-Received: by 2002:a17:907:72c1:b0:a7a:b385:37c5 with SMTP id
 a640c23a62f3a-a7ac4de333amr329208066b.17.1721938966277; 
 Thu, 25 Jul 2024 13:22:46 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab4de22sm105050266b.49.2024.07.25.13.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 13:22:45 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9B5145F863;
 Thu, 25 Jul 2024 21:22:44 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org,  qemu-ppc@nongnu.org,  Daniel Henrique Barboza
 <danielhb413@gmail.com>,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2] tests/tcg: Skip failing ppc64 multi-threaded tests
In-Reply-To: <20240725154003.428065-1-npiggin@gmail.com> (Nicholas Piggin's
 message of "Fri, 26 Jul 2024 01:40:01 +1000")
References: <20240725154003.428065-1-npiggin@gmail.com>
Date: Thu, 25 Jul 2024 21:22:44 +0100
Message-ID: <87wml9mdbf.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Nicholas Piggin <npiggin@gmail.com> writes:

> In Gitlab CI, some ppc64 multi-threaded tcg tests crash when run in the
> clang-user job with an assertion failure in glibc that seems to
> indicate corruption:
>
>   signals: allocatestack.c:223: allocate_stack:
>     Assertion `powerof2 (pagesize_m1 + 1)' failed.
>
> Disable these tests for now.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  tests/tcg/ppc64/Makefile.target | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/tests/tcg/ppc64/Makefile.target b/tests/tcg/ppc64/Makefile.t=
arget
> index 8c3e4e4038..509a20be2b 100644
> --- a/tests/tcg/ppc64/Makefile.target
> +++ b/tests/tcg/ppc64/Makefile.target
> @@ -11,6 +11,18 @@ config-cc.mak: Makefile
>=20=20
>  -include config-cc.mak
>=20=20
> +# multi-threaded tests are known to fail (e.g., clang-user CI job)
> +# See: https://gitlab.com/qemu-project/qemu/-/issues/2456

Given this is only a problem with clang can we only apply these
workaround if we detect "clang" in $(CC)?

> +run-signals: signals
> +	$(call skip-test, $<, "BROKEN (flaky with clang) ")
> +run-plugin-signals-with-%:
> +	$(call skip-test, $<, "BROKEN (flaky with clang) ")
> +
> +run-threadcount: threadcount
> +	$(call skip-test, $<, "BROKEN (flaky with clang) ")
> +run-plugin-threadcount-with-%:
> +	$(call skip-test, $<, "BROKEN (flaky with clang) ")
> +
>  ifneq ($(CROSS_CC_HAS_POWER8_VECTOR),)
>  PPC64_TESTS=3Dbcdsub non_signalling_xscv
>  endif

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

