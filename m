Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4407C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 12:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uevN7-0001xv-Vu; Thu, 24 Jul 2025 08:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uevN3-0001wd-MQ
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 08:48:27 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uevN1-0002Ei-1f
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 08:48:25 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ae0c4945c76so133796766b.3
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 05:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753361300; x=1753966100; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1pJxhQz5CX90okzfo1PIQJANyQ9jDvIOKHQms70gUEE=;
 b=uUPOVUAPaT9fZaLgGVs66ecbh9TBnYIGEXdVSfjp2tboZPPWR5hHktH3uUh16qiWY7
 RGzYqeSRiWHo853TooZW57blE7J8/Y8kMg+EHWzZ91sm8IM5ZbbuaEcGcopwQIwdsTW0
 CCyYL+LKO32VcZzohwkwQ6i0iN2FCZG5tOteII+vSGyPBnUE+yXAvbWWmNPeaiGE/+f9
 ASdor7YEMpAw+AERpUVWi1jySCO95XFPZpNJSYbqm/YxtbmU0BVSCNA5ULJ8vXMi4okg
 odKM+klSsOt1r/7Ptu3EtRokCemN3gZL94jGX1kHSgidsLU6Q/zs/sNCyWjuSFULAj0T
 g3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753361300; x=1753966100;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1pJxhQz5CX90okzfo1PIQJANyQ9jDvIOKHQms70gUEE=;
 b=VQroIra+Araa9WESXV8skeIKhuYQ43ZkKvUtF5kog974yoIogoSvRUzJ/NZZjtabT0
 aUmKm5LBPJl9aszdCa8XJDrb7xlpaEyJth2xyzeqpVb3W91pS99mCUbOUgEnnHfwNl90
 RLQX5SKDAgly78os9GhBRxpOLFJpmr5VmopKFKe0KfMhlap4Pw+HluSxB2niUOqn984v
 /jn1Pv05L9e6wtfu6gqFmFXwIcUIiCVWgeq9RxvEx7Y0xGcUFiABplDdskDbdPMElEi4
 o0pY8LgHQjcYCWeYt33+0pz5gjHWiCB6lWCTTZTnvPb5RunhWnNDKRykAU1Tj67QC7J5
 nfgA==
X-Gm-Message-State: AOJu0YwnqtmFqf0a+81b1aoqHjoi3oPqKxO4/NwMiBd422orUjpaE9n1
 g3mhEtyly+WlNSG1chy/rsr4oywjehC/4wOQ5Z+TmEYPpwt2WjTemXWCDAlbUszisiI=
X-Gm-Gg: ASbGnctGaRD/FrjItUCr2hnxB0FtAikNt39WRsH1Sf1oQZmHJAW0uk3em3om/PmRhOk
 sOH28xbaR4/17Sj/fn2p5RBlmw0Zy67hmFsm3wiKfh5emrsQy7AKKham1hiCyETF+U6i2Xy8Jit
 +J6Whzj/D5zz2DTdZhikgWMvYoxxQ0Wa0Ljxty9WdY34PLnwCBY8d9ByCsPsFuycNjxu5ZFBSlQ
 uJBTwEQDowLzqazX7NtZ7rvyDb9aAXQf/x1iSgBy++hkOi1XVesstzItnbZXsTLEkOsjFOakcjb
 uFKtmcacJPl9opcZnzGFtBzq1dD8anNjUXifCRbY2B6/kkb4CJo8R4fbSpHhPDJef0fw0tRFdCC
 UD/qXbI1TaVJKY0/YO60Iwd9oggJiNh6siA==
X-Google-Smtp-Source: AGHT+IGQA9PM3L0Kq4Q/vS8D1P6PrxXSDftLM1dCxxa8jt/qAk5M/lgp3wv3qdVy6O8S/a3yibjxjg==
X-Received: by 2002:a17:907:3e1a:b0:ae6:b006:1be with SMTP id
 a640c23a62f3a-af2f66c5e54mr629079066b.5.1753361300135; 
 Thu, 24 Jul 2025 05:48:20 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af47fa4bc8fsm106533166b.114.2025.07.24.05.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 05:48:19 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 61CD25F7B0;
 Thu, 24 Jul 2025 13:48:18 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,  Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH for 10.1 11/13] tests/tcg: reduce the number of plugin
 tests combinations
In-Reply-To: <CAAjaMXbtw0dw23w2Jx6PmVtZFThj-5w1GzUq0BnzZ7WME-dO6g@mail.gmail.com>
 (Manos Pitsidianakis's message of "Thu, 24 Jul 2025 15:05:03 +0300")
References: <20250724105939.2393230-1-alex.bennee@linaro.org>
 <20250724105939.2393230-12-alex.bennee@linaro.org>
 <CAAjaMXb9-jkDhLA1euY3-90c4q=2my=QuDpJQGGObAZGTy3-xQ@mail.gmail.com>
 <87bjp9vlxd.fsf@draig.linaro.org>
 <CAAjaMXbtw0dw23w2Jx6PmVtZFThj-5w1GzUq0BnzZ7WME-dO6g@mail.gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Thu, 24 Jul 2025 13:48:18 +0100
Message-ID: <87tt31u54d.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> On Thu, Jul 24, 2025 at 3:00=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@lin=
aro.org> wrote:
>>
>> Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
>>
>> > On Thu, Jul 24, 2025 at 2:00=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@=
linaro.org> wrote:
>> >>
>> >> As our set of multiarch tests has grown the practice of running every
>> >> plugin with every test is becoming unsustainable. If we switch to
>> >> ensuring every test gets run with at least one plugin we can speed
>> >> things up.
>> >>
>> >> Some plugins do need to be run with specific tests (for example the
>> >> memory instrumentation test). We can handle this by manually adding
>> >> them to EXTRA_RUNS. We also need to wrap rules in a CONFIG_PLUGIN test
>> >> so we don't enable the runs when plugins are not enabled.
>> >>
>> >> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> >> ---
>> >>  tests/tcg/Makefile.target                     | 23 ++++++++++++++---=
--
>> >>  tests/tcg/multiarch/Makefile.target           |  8 +++++--
>> >>  .../multiarch/system/Makefile.softmmu-target  | 11 +++++----
>> >>  3 files changed, 30 insertions(+), 12 deletions(-)
>> >>
>> >> diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
>> >> index a12b15637ea..18afd5be194 100644
>> >> --- a/tests/tcg/Makefile.target
>> >> +++ b/tests/tcg/Makefile.target
>> >> @@ -173,14 +173,25 @@ PLUGINS=3D$(filter-out $(DISABLE_PLUGINS), \
>> >>  # We need to ensure expand the run-plugin-TEST-with-PLUGIN
>> >>  # pre-requistes manually here as we can't use stems to handle it. We
>> >>  # only expand MULTIARCH_TESTS which are common on most of our targets
>> >> -# to avoid an exponential explosion as new tests are added. We also
>> >> -# add some special helpers the run-plugin- rules can use below.
>> >> +# and rotate the plugins so we don't grow too out of control as new
>> >> +# tests are added. Plugins that need to run with a specific test
>> >> +# should ensure they add their combination to EXTRA_RUNS.
>> >>
>> >>  ifneq ($(MULTIARCH_TESTS),)
>> >> -$(foreach p,$(PLUGINS), \
>> >> -       $(foreach t,$(MULTIARCH_TESTS),\
>> >> -               $(eval run-plugin-$(t)-with-$(p): $t $p) \
>> >> -               $(eval RUN_TESTS+=3Drun-plugin-$(t)-with-$(p))))
>> >> +
>> >> +NUM_PLUGINS :=3D $(words $(PLUGINS))
>> >> +NUM_TESTS :=3D $(words $(MULTIARCH_TESTS))
>> >> +
>> >> +define mod_plus_one
>> >> +  $(shell $(PYTHON) -c "print( ($(1) % $(2)) + 1 )")
>> >> +endef
>> >> +
>> >> +$(foreach _idx, $(shell seq 1 $(NUM_TESTS)), \
>> >> +       $(eval _test :=3D $(word $(_idx), $(MULTIARCH_TESTS))) \
>> >> +       $(eval _plugin :=3D $(word $(call mod_plus_one, $(_idx), $(NU=
M_PLUGINS)), $(PLUGINS))) \
>> >> +       $(eval run-plugin-$(_test)-with-$(_plugin): $(_test) $(_plugi=
n)) \
>> >> +       $(eval RUN_TESTS+=3Drun-plugin-$(_test)-with-$(_plugin)))
>> >> +
>> >>  endif # MULTIARCH_TESTS
>> >>  endif # CONFIG_PLUGIN
>> >>
>> >> diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarc=
h/Makefile.target
>> >> index bfdf7197a7b..38345ff8805 100644
>> >> --- a/tests/tcg/multiarch/Makefile.target
>> >> +++ b/tests/tcg/multiarch/Makefile.target
>> >> @@ -189,6 +189,10 @@ run-plugin-semiconsole-with-%:
>> >>  TESTS +=3D semihosting semiconsole
>> >>  endif
>> >>
>> >> +test-plugin-mem-access: CFLAGS+=3D-pthread -O0
>> >> +test-plugin-mem-access: LDFLAGS+=3D-pthread -O0
>> >> +
>> >> +ifeq ($(CONFIG_PLUGIN),y)
>> >>  # Test plugin memory access instrumentation
>> >>  run-plugin-test-plugin-mem-access-with-libmem.so: \
>> >>         PLUGIN_ARGS=3D$(COMMA)print-accesses=3Dtrue
>> >> @@ -197,8 +201,8 @@ run-plugin-test-plugin-mem-access-with-libmem.so:=
 \
>> >>         $(SRC_PATH)/tests/tcg/multiarch/check-plugin-output.sh \
>> >>         $(QEMU) $<
>> >>
>> >> -test-plugin-mem-access: CFLAGS+=3D-pthread -O0
>> >> -test-plugin-mem-access: LDFLAGS+=3D-pthread -O0
>> >> +EXTRA_RUNS +=3D run-plugin-test-plugin-mem-access-with-libmem.so
>> >> +endif
>> >>
>> >>  # Update TESTS
>> >>  TESTS +=3D $(MULTIARCH_TESTS)
>> >> diff --git a/tests/tcg/multiarch/system/Makefile.softmmu-target b/tes=
ts/tcg/multiarch/system/Makefile.softmmu-target
>> >> index 5acf2700812..4171b4e6aa0 100644
>> >> --- a/tests/tcg/multiarch/system/Makefile.softmmu-target
>> >> +++ b/tests/tcg/multiarch/system/Makefile.softmmu-target
>> >> @@ -71,8 +71,11 @@ endif
>> >>  MULTIARCH_RUNS +=3D run-gdbstub-memory run-gdbstub-interrupt \
>> >>         run-gdbstub-untimely-packet run-gdbstub-registers
>> >>
>> >> +ifeq ($(CONFIG_PLUGIN),y)
>> >>  # Test plugin memory access instrumentation
>> >> -run-plugin-memory-with-libmem.so:              \
>> >> -       PLUGIN_ARGS=3D$(COMMA)region-summary=3Dtrue
>> >> -run-plugin-memory-with-libmem.so:              \
>> >> -       CHECK_PLUGIN_OUTPUT_COMMAND=3D$(MULTIARCH_SYSTEM_SRC)/validat=
e-memory-counts.py $@.out
>> >> +run-plugin-memory-with-libmem.so: memory libmem.so
>> >
>> > Hm why wasn't this needed before this change?
>> >
>> > I see the make `memory` target sets CHECK_UNALIGNED but where is
>> > libmem.so target coming from?
>> >
>> >> +run-plugin-memory-with-libmem.so: PLUGIN_ARGS=3D$(COMMA)region-summa=
ry=3Dtrue
>> >> +run-plugin-memory-with-libmem.so: CHECK_PLUGIN_OUTPUT_COMMAND=3D$(MU=
LTIARCH_SYSTEM_SRC)/validate-memory-counts.py $@.out
>> >> +
>> >> +EXTRA_RUNS +=3D run-plugin-memory-with-libmem.so
>>
>> Because we add it to EXTRA_RUNS so we don't want that if plugins won't
>> work. We could just wrap EXTRA_RUNS but the rest of the recipe is moot
>> at that point anyway.
>
> I am asking about the line
>
>> +run-plugin-memory-with-libmem.so: memory libmem.so
>
> Which adds two make target prerequisites `memory` and `libmem.so`, I
> don't see where they came from, or maybe I am not understanding the
> makefile logic here correctly.

Originally we generated the pre-reqs in the:

  $(foreach p,$(PLUGINS), \
      $(foreach t,$(MULTIARCH_TESTS),\

loop. Now that doesn't cover every combination we need to add an
explicit prereq for the test case we know we will run.

>
>>
>> >> +endif
>> >> --
>> >> 2.47.2
>> >>
>> >>
>>
>> --
>> Alex Benn=C3=A9e
>> Virtualisation Tech Lead @ Linaro

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

