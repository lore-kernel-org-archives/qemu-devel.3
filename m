Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C054CC83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 11:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueu5c-0002k4-AS; Thu, 24 Jul 2025 07:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ueu5a-0002Xp-K1
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 07:26:18 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ueu5Y-0001in-MV
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 07:26:18 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-606b58241c9so1448419a12.3
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 04:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753356375; x=1753961175; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6DKrVKUkyZOaMKtK8sPeIiTjv1xZjPYlZHCmoXM9z/Y=;
 b=R+v3pK5YYkc6/bLriTieiO/COpXsLicCHeiHP3FtTMAT3/4pdxOUxacGxvxCFs6l0M
 uqtb332C6/fYQDh2mhg0y9SOgMSXKiuMYypMVMHoJT2viLh0btuyvHWsuoalg8efEhxI
 pIpQX4OO19p+VwAeSnPPR51i5givAJxXMAwkELfX0y+8rmjCZwhrvIiYPN6ZnRYl/dA3
 3ZRgNFdZmK5djQ+NmV0iPnNTW7F8Op6khgB0RPO5TabC3XPoyQJ1OHkvC+DcFmq8lqLy
 vfZpY8Xll/1pGdrVRgt+EM8AzULGQ1f6ZFz46yCYmtSL/fwhv5aEDfyeqq3vWiByR/wP
 yl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753356375; x=1753961175;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6DKrVKUkyZOaMKtK8sPeIiTjv1xZjPYlZHCmoXM9z/Y=;
 b=LSJl+DdRiU6ez65NnfcTc4mdRf+dC2d4nPLGsWbqIjGmEevzGmrGrga84QHaqx7eSO
 T3LCxEB8a4WHXCs1kEWN3P/jgOiegVUYzYiuzSfwE+mpsDAmuTZOhuoB05ZIoPd3YEGF
 +9vw5AXEO55AmpoxV2Pj9nT2J52v9h0OLy/J8+1ZoMRaJ1c7ptfGiscmE97DHYJ/Z+Dj
 W9OAjlKpAoMg+MnpCvsbrWJjiAYeppDVBAKwJiIgj9YvWboeufJ6sr1XXatL4IOdqrBk
 3aGHQx1+rTcu8AwaFkiJVZvBQK3P6vOpSH5A7YYbx9uO5ycq4Ybiwl223j1Ti7WY7StP
 iniA==
X-Gm-Message-State: AOJu0YysBcPw2lgZQkYuobIX6kV66gxK6xq7rmPKY6n/yTRMXzUoaQsR
 ilH1YnhpG6bCevEjU8ACfbC5iU5o17buxCyVR/7kRr628PWu9A8NXQdbwjO+7Af9FnWZ28OWvXw
 oIW/vXQ5LtsDNfQoKzliJ2wAzlY3u+VjYY44BuJu6OA==
X-Gm-Gg: ASbGnctkjG3kdS/voqdhP84s4RVERyOPQ7+D/ISAVmYHUOV1o8K5ykBuCSW/hR5uaGz
 4xfCltLP/wZVOEtb2gJJCXvo0UuKOHDUslkkxNfR+vQ+svXKdjlIn+xTzSXzGT3xIFWGnL28x7X
 cv2MsQ1XGAmJnezDaFK8lMxnJ5wPSDAGzCNp5aswYrVazuOF45gDp+seSwCXW1mgOvnham71ZvZ
 gmiqw==
X-Google-Smtp-Source: AGHT+IFOy8mQR0S8OGCRQ7g8HX6+vGFhQdQma3icjVzaHMr16fxv990gQLyBuB9gt6xvVxocEDPtvLsMbR1g+vR4bKo=
X-Received: by 2002:a05:6402:2706:b0:607:28c9:c3c9 with SMTP id
 4fb4d7f45d1cf-6149b40d0c2mr5444213a12.6.1753356374498; Thu, 24 Jul 2025
 04:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250724105939.2393230-1-alex.bennee@linaro.org>
 <20250724105939.2393230-12-alex.bennee@linaro.org>
In-Reply-To: <20250724105939.2393230-12-alex.bennee@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 24 Jul 2025 14:25:47 +0300
X-Gm-Features: Ac12FXxtKNi22oqTl9TlXq_ibNJ1g1TrOe0-wlzXdG_N7bp-xLxVXxPbD4JM2WA
Message-ID: <CAAjaMXb9-jkDhLA1euY3-90c4q=2my=QuDpJQGGObAZGTy3-xQ@mail.gmail.com>
Subject: Re: [PATCH for 10.1 11/13] tests/tcg: reduce the number of plugin
 tests combinations
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52d.google.com
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

On Thu, Jul 24, 2025 at 2:00=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> As our set of multiarch tests has grown the practice of running every
> plugin with every test is becoming unsustainable. If we switch to
> ensuring every test gets run with at least one plugin we can speed
> things up.
>
> Some plugins do need to be run with specific tests (for example the
> memory instrumentation test). We can handle this by manually adding
> them to EXTRA_RUNS. We also need to wrap rules in a CONFIG_PLUGIN test
> so we don't enable the runs when plugins are not enabled.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/tcg/Makefile.target                     | 23 ++++++++++++++-----
>  tests/tcg/multiarch/Makefile.target           |  8 +++++--
>  .../multiarch/system/Makefile.softmmu-target  | 11 +++++----
>  3 files changed, 30 insertions(+), 12 deletions(-)
>
> diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
> index a12b15637ea..18afd5be194 100644
> --- a/tests/tcg/Makefile.target
> +++ b/tests/tcg/Makefile.target
> @@ -173,14 +173,25 @@ PLUGINS=3D$(filter-out $(DISABLE_PLUGINS), \
>  # We need to ensure expand the run-plugin-TEST-with-PLUGIN
>  # pre-requistes manually here as we can't use stems to handle it. We
>  # only expand MULTIARCH_TESTS which are common on most of our targets
> -# to avoid an exponential explosion as new tests are added. We also
> -# add some special helpers the run-plugin- rules can use below.
> +# and rotate the plugins so we don't grow too out of control as new
> +# tests are added. Plugins that need to run with a specific test
> +# should ensure they add their combination to EXTRA_RUNS.
>
>  ifneq ($(MULTIARCH_TESTS),)
> -$(foreach p,$(PLUGINS), \
> -       $(foreach t,$(MULTIARCH_TESTS),\
> -               $(eval run-plugin-$(t)-with-$(p): $t $p) \
> -               $(eval RUN_TESTS+=3Drun-plugin-$(t)-with-$(p))))
> +
> +NUM_PLUGINS :=3D $(words $(PLUGINS))
> +NUM_TESTS :=3D $(words $(MULTIARCH_TESTS))
> +
> +define mod_plus_one
> +  $(shell $(PYTHON) -c "print( ($(1) % $(2)) + 1 )")
> +endef
> +
> +$(foreach _idx, $(shell seq 1 $(NUM_TESTS)), \
> +       $(eval _test :=3D $(word $(_idx), $(MULTIARCH_TESTS))) \
> +       $(eval _plugin :=3D $(word $(call mod_plus_one, $(_idx), $(NUM_PL=
UGINS)), $(PLUGINS))) \
> +       $(eval run-plugin-$(_test)-with-$(_plugin): $(_test) $(_plugin)) =
\
> +       $(eval RUN_TESTS+=3Drun-plugin-$(_test)-with-$(_plugin)))
> +
>  endif # MULTIARCH_TESTS
>  endif # CONFIG_PLUGIN
>
> diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Ma=
kefile.target
> index bfdf7197a7b..38345ff8805 100644
> --- a/tests/tcg/multiarch/Makefile.target
> +++ b/tests/tcg/multiarch/Makefile.target
> @@ -189,6 +189,10 @@ run-plugin-semiconsole-with-%:
>  TESTS +=3D semihosting semiconsole
>  endif
>
> +test-plugin-mem-access: CFLAGS+=3D-pthread -O0
> +test-plugin-mem-access: LDFLAGS+=3D-pthread -O0
> +
> +ifeq ($(CONFIG_PLUGIN),y)
>  # Test plugin memory access instrumentation
>  run-plugin-test-plugin-mem-access-with-libmem.so: \
>         PLUGIN_ARGS=3D$(COMMA)print-accesses=3Dtrue
> @@ -197,8 +201,8 @@ run-plugin-test-plugin-mem-access-with-libmem.so: \
>         $(SRC_PATH)/tests/tcg/multiarch/check-plugin-output.sh \
>         $(QEMU) $<
>
> -test-plugin-mem-access: CFLAGS+=3D-pthread -O0
> -test-plugin-mem-access: LDFLAGS+=3D-pthread -O0
> +EXTRA_RUNS +=3D run-plugin-test-plugin-mem-access-with-libmem.so
> +endif
>
>  # Update TESTS
>  TESTS +=3D $(MULTIARCH_TESTS)
> diff --git a/tests/tcg/multiarch/system/Makefile.softmmu-target b/tests/t=
cg/multiarch/system/Makefile.softmmu-target
> index 5acf2700812..4171b4e6aa0 100644
> --- a/tests/tcg/multiarch/system/Makefile.softmmu-target
> +++ b/tests/tcg/multiarch/system/Makefile.softmmu-target
> @@ -71,8 +71,11 @@ endif
>  MULTIARCH_RUNS +=3D run-gdbstub-memory run-gdbstub-interrupt \
>         run-gdbstub-untimely-packet run-gdbstub-registers
>
> +ifeq ($(CONFIG_PLUGIN),y)
>  # Test plugin memory access instrumentation
> -run-plugin-memory-with-libmem.so:              \
> -       PLUGIN_ARGS=3D$(COMMA)region-summary=3Dtrue
> -run-plugin-memory-with-libmem.so:              \
> -       CHECK_PLUGIN_OUTPUT_COMMAND=3D$(MULTIARCH_SYSTEM_SRC)/validate-me=
mory-counts.py $@.out
> +run-plugin-memory-with-libmem.so: memory libmem.so

Hm why wasn't this needed before this change?

I see the make `memory` target sets CHECK_UNALIGNED but where is
libmem.so target coming from?

> +run-plugin-memory-with-libmem.so: PLUGIN_ARGS=3D$(COMMA)region-summary=
=3Dtrue
> +run-plugin-memory-with-libmem.so: CHECK_PLUGIN_OUTPUT_COMMAND=3D$(MULTIA=
RCH_SYSTEM_SRC)/validate-memory-counts.py $@.out
> +
> +EXTRA_RUNS +=3D run-plugin-memory-with-libmem.so
> +endif
> --
> 2.47.2
>
>

