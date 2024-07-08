Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC316C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 11:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQm6W-00040X-Aa; Mon, 08 Jul 2024 07:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sQm6U-0003zn-7L
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 07:00:18 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sQm6S-0007r9-4D
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 07:00:17 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a77b550128dso474367066b.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 04:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720436414; x=1721041214; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qobbC99mOxzEr0mauDIxs76Kx9Lgqj72EeDtCwXUsNg=;
 b=vkcs0HYQ7UD3XgrLFOHyrR/mwy7uluUvLd4j2IFiomYXZeYPjZayPrAPbWJfnAhsKt
 rr41Zcl3VHjEBeNHuVUZQqyoRsYN5ToceGLIGfzkNgXXydS/T2REx7MCPrBLnc+UqCxC
 7cRqqsUfR8Tk3Ncob/VvlnqcpGs0h1x2wOlMeD4Mqk2hyjkVTAy6nvinegjDA6Iu4vob
 IOuurzIdKlVtyeVfMhofhH6kYWumDVlwGIKIvrNMkVvHGEWyCs7LprinTVjcnJho7o8z
 XYitQq1zslBSRKv/IsP2Bn7hohuJrcz33i5tsjxbXIL0QSRgr8sTwlmiRDpbGGALWtm1
 ieAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720436414; x=1721041214;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qobbC99mOxzEr0mauDIxs76Kx9Lgqj72EeDtCwXUsNg=;
 b=AwWYjfmvdEFHYdj+J6aysHnERLgPDLMV1eH3pS99xBTcYWJ3IZHiWUS9QvBSu8oP+J
 29r9r6niuNcQzVXAzIMww/vdKb10dX/9NrjY5TBaPQvvmaYuy33ZCZHMWUcmGUJY24mL
 BS4/nsYrftcLYvfKHxjzxCFEeiGqH2OoNLW+PeOdgo5Lnw0frvMxJf1oGVE5aC7/ETac
 Qcx09FID3LtC5RK2C6FiwhoA3HCtcTIGfPh/ZuN9owVmdC+rXltTrgzeaMc6SDzNbipa
 2FTTjgjK1xGyTm+2GG89ri/o4Na56o0gFUFeutu38fKPoZDOD9EvH1i9Xjmia6Q7h+cf
 wF+g==
X-Gm-Message-State: AOJu0YyOLFrG9AzsVricVsuUuu4wSKKrfK46Jvv9RbpH6mmzkDo4EBhZ
 vEFjdKmPbgt9TfYDYkNo66OnSyq+jAg4BsJcKCamh/PlyxruDIq97qb/tTbhFyo=
X-Google-Smtp-Source: AGHT+IHxLnxmSSOfi7antfo1xK/E8dPd3rtZmsKtU1Tz2afQf6mSOVXQqpMrCcqbYgQQAgM/mFPplQ==
X-Received: by 2002:a17:907:daa:b0:a77:ec9f:d9c1 with SMTP id
 a640c23a62f3a-a77ec9fdadfmr492707366b.70.1720436414130; 
 Mon, 08 Jul 2024 04:00:14 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab08cab4sm935430966b.144.2024.07.08.04.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 04:00:13 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C94485F7A1;
 Mon,  8 Jul 2024 12:00:12 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,  Eduardo Habkost
 <eduardo@habkost.net>,  Yanan Wang <wangyanan55@huawei.com>,  Xingtao Yao
 <yaoxt.fnst@fujitsu.com>
Subject: Re: [PATCH v6 4/7] tests/tcg: add mechanism to run specific tests
 with plugins
In-Reply-To: <20240706191335.878142-5-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Sat, 6 Jul 2024 12:13:32 -0700")
References: <20240706191335.878142-1-pierrick.bouvier@linaro.org>
 <20240706191335.878142-5-pierrick.bouvier@linaro.org>
Date: Mon, 08 Jul 2024 12:00:12 +0100
Message-ID: <87ikxgtagz.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> Only multiarch tests are run with plugins, and we want to be able to run
> per-arch test with plugins too.
>
> Tested-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  tests/tcg/Makefile.target | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
> index cb8cfeb6dac..52616544d52 100644
> --- a/tests/tcg/Makefile.target
> +++ b/tests/tcg/Makefile.target
> @@ -152,10 +152,11 @@ PLUGINS=3D$(patsubst %.c, lib%.so, $(notdir $(wildc=
ard $(PLUGIN_SRC)/*.c)))
>  # only expand MULTIARCH_TESTS which are common on most of our targets
>  # to avoid an exponential explosion as new tests are added. We also
>  # add some special helpers the run-plugin- rules can use below.
> +# In more, extra tests can be added using PLUGINS_TESTS variable.
>=20=20
>  ifneq ($(MULTIARCH_TESTS),)
>  $(foreach p,$(PLUGINS), \
> -	$(foreach t,$(MULTIARCH_TESTS),\
> +	$(foreach t,$(MULTIARCH_TESTS) $(PLUGINS_TESTS),\
>  		$(eval run-plugin-$(t)-with-$(p): $t $p) \
>  		$(eval RUN_TESTS+=3Drun-plugin-$(t)-with-$(p))))
>  endif # MULTIARCH_TESTS

I have no particular objection to adding this (except a minor nit of
maybe the name should be ADDITIONAL_PLUGIN_TESTS). However the use of
this later is for the test:

  tests/tcg/x86_64/test-plugin-mem-access.c

and aside from the inline asm I don't see why this couldn't be a
multi-arch test. Could we not use the atomic primitives to make it multiarc=
h?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

