Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4F7C83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 12:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueuhh-0005CL-7Q; Thu, 24 Jul 2025 08:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ueuhe-0004hm-Dj
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 08:05:38 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ueuha-0005xX-H2
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 08:05:36 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-607434e1821so1356818a12.0
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 05:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753358730; x=1753963530; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6scm7tk/bo1T8S6AvaIM3VoGDSQ9R+KslNTLKventBI=;
 b=Cd0MQbC1Yv5zcjPjyjhr2DC/Mfc2CbTXcbuCf0wv7Zb/l1MrKYNmqteUFZfL2Dk0pH
 nUGi7CKJskbX2ienzFe4nyMC9QaOCnVk0c//giSQ0F2yuOsgTk1k1AXHJVcNwjQp2aBd
 BEEzjyUuWaoEnMB99pizhXyExMhiZQuYI/CjbpKufXI7wNfigzwWmFnJwvkY4+3FO1fs
 vq7k5exlTRp3ghNFCCitV24GjNI5W7l4L6Hbx0rPh+U7X1mdNSOWNaqIFrufnYfL4ok2
 m8FVq/zoa95sNIa8k9cDtUgjiGw94MPyPA4sLJHmg7caLmRndLEZYLpDdtxdpPdQO91u
 I+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753358730; x=1753963530;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6scm7tk/bo1T8S6AvaIM3VoGDSQ9R+KslNTLKventBI=;
 b=EKeRsbWXTYCNjUOIhDlx8hDkQSe/mfMoEI1Uo/iQHEo3uQD4S1G3ek9mBbG/GEqmQH
 PqTzUj58y5obF/vIRUFrNV0TN9wy8ML1UdcWbDSdBkle2azOBJBG72Cyujdz5bqP8dbJ
 YNtxZ9R+ALU1S6hqe907IHEdZJeheWdD3C3FpVpbqfiN8jSTMNh3M6yeME6C+a60Eung
 dkk15UQaqF6ZHvq+HGuTyJzdXMxNbu18/7dL/5G7svvwxfmE5tXiKEgFZM6aZh2OO2Mg
 h/RGq1C783Jr/5VFWaNX9sxqKlFJ2sLzzWjaRSJsSqvjuhtrfkBKtCJJMHhhKW6hn139
 P8Rw==
X-Gm-Message-State: AOJu0YzWz0ZJ0lll1tnMp/36haTelAdUMW/DimPFGEC4JI0rd7p89ZyU
 zXhXXVztOz7kcBsp34HcRbk1tJPi1QcL8GGjgpieethtzrWFyaDhrKD1YB4u6ylLFPQPImWV8Gl
 2eaQiV4L2L4IQYNfmA93A9CeSF1Wg8IxpwpQHu3qC9w==
X-Gm-Gg: ASbGncvIo7hPgbS2E5PpzfAaA6PSmkwtbBGXiLuwezuEt7hQ7i9UTM8hZUAIwtIHnNM
 0syMqvQ10RUX/qZaPQqPiyLFVCT9qTJXaKo2g0dw7YvZndCWOzwPqi7VvUqXZgGzMpJ9q/uJ1fM
 U/nxxzF10PQKjILd1QZY+WyrDzLFQ4L8mkST/ayAQEnwYUXQXp/wpqDYjK8LRVE2Ok2/xvSpVIw
 UVvQw==
X-Google-Smtp-Source: AGHT+IEzCfRlqXcVmoy68kZyq2ZVDdN4j8FwLvCkT1GpqCy4DF0P2fFswc3ubnpJJb86GtnOb/QnzaslcrZnomRSNnY=
X-Received: by 2002:a50:8d5d:0:b0:612:b742:5bba with SMTP id
 4fb4d7f45d1cf-6149b432c75mr4862914a12.13.1753358729754; Thu, 24 Jul 2025
 05:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250724105939.2393230-1-alex.bennee@linaro.org>
 <20250724105939.2393230-12-alex.bennee@linaro.org>
 <CAAjaMXb9-jkDhLA1euY3-90c4q=2my=QuDpJQGGObAZGTy3-xQ@mail.gmail.com>
 <87bjp9vlxd.fsf@draig.linaro.org>
In-Reply-To: <87bjp9vlxd.fsf@draig.linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 24 Jul 2025 15:05:03 +0300
X-Gm-Features: Ac12FXxbKIAR7HcdtHm8DBy9JynKKVdfAIFRlMazNemidSkGr2wntP9qF3Yyv2o
Message-ID: <CAAjaMXbtw0dw23w2Jx6PmVtZFThj-5w1GzUq0BnzZ7WME-dO6g@mail.gmail.com>
Subject: Re: [PATCH for 10.1 11/13] tests/tcg: reduce the number of plugin
 tests combinations
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x536.google.com
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

On Thu, Jul 24, 2025 at 3:00=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
>
> > On Thu, Jul 24, 2025 at 2:00=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@l=
inaro.org> wrote:
> >>
> >> As our set of multiarch tests has grown the practice of running every
> >> plugin with every test is becoming unsustainable. If we switch to
> >> ensuring every test gets run with at least one plugin we can speed
> >> things up.
> >>
> >> Some plugins do need to be run with specific tests (for example the
> >> memory instrumentation test). We can handle this by manually adding
> >> them to EXTRA_RUNS. We also need to wrap rules in a CONFIG_PLUGIN test
> >> so we don't enable the runs when plugins are not enabled.
> >>
> >> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >> ---
> >>  tests/tcg/Makefile.target                     | 23 ++++++++++++++----=
-
> >>  tests/tcg/multiarch/Makefile.target           |  8 +++++--
> >>  .../multiarch/system/Makefile.softmmu-target  | 11 +++++----
> >>  3 files changed, 30 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
> >> index a12b15637ea..18afd5be194 100644
> >> --- a/tests/tcg/Makefile.target
> >> +++ b/tests/tcg/Makefile.target
> >> @@ -173,14 +173,25 @@ PLUGINS=3D$(filter-out $(DISABLE_PLUGINS), \
> >>  # We need to ensure expand the run-plugin-TEST-with-PLUGIN
> >>  # pre-requistes manually here as we can't use stems to handle it. We
> >>  # only expand MULTIARCH_TESTS which are common on most of our targets
> >> -# to avoid an exponential explosion as new tests are added. We also
> >> -# add some special helpers the run-plugin- rules can use below.
> >> +# and rotate the plugins so we don't grow too out of control as new
> >> +# tests are added. Plugins that need to run with a specific test
> >> +# should ensure they add their combination to EXTRA_RUNS.
> >>
> >>  ifneq ($(MULTIARCH_TESTS),)
> >> -$(foreach p,$(PLUGINS), \
> >> -       $(foreach t,$(MULTIARCH_TESTS),\
> >> -               $(eval run-plugin-$(t)-with-$(p): $t $p) \
> >> -               $(eval RUN_TESTS+=3Drun-plugin-$(t)-with-$(p))))
> >> +
> >> +NUM_PLUGINS :=3D $(words $(PLUGINS))
> >> +NUM_TESTS :=3D $(words $(MULTIARCH_TESTS))
> >> +
> >> +define mod_plus_one
> >> +  $(shell $(PYTHON) -c "print( ($(1) % $(2)) + 1 )")
> >> +endef
> >> +
> >> +$(foreach _idx, $(shell seq 1 $(NUM_TESTS)), \
> >> +       $(eval _test :=3D $(word $(_idx), $(MULTIARCH_TESTS))) \
> >> +       $(eval _plugin :=3D $(word $(call mod_plus_one, $(_idx), $(NUM=
_PLUGINS)), $(PLUGINS))) \
> >> +       $(eval run-plugin-$(_test)-with-$(_plugin): $(_test) $(_plugin=
)) \
> >> +       $(eval RUN_TESTS+=3Drun-plugin-$(_test)-with-$(_plugin)))
> >> +
> >>  endif # MULTIARCH_TESTS
> >>  endif # CONFIG_PLUGIN
> >>
> >> diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch=
/Makefile.target
> >> index bfdf7197a7b..38345ff8805 100644
> >> --- a/tests/tcg/multiarch/Makefile.target
> >> +++ b/tests/tcg/multiarch/Makefile.target
> >> @@ -189,6 +189,10 @@ run-plugin-semiconsole-with-%:
> >>  TESTS +=3D semihosting semiconsole
> >>  endif
> >>
> >> +test-plugin-mem-access: CFLAGS+=3D-pthread -O0
> >> +test-plugin-mem-access: LDFLAGS+=3D-pthread -O0
> >> +
> >> +ifeq ($(CONFIG_PLUGIN),y)
> >>  # Test plugin memory access instrumentation
> >>  run-plugin-test-plugin-mem-access-with-libmem.so: \
> >>         PLUGIN_ARGS=3D$(COMMA)print-accesses=3Dtrue
> >> @@ -197,8 +201,8 @@ run-plugin-test-plugin-mem-access-with-libmem.so: =
\
> >>         $(SRC_PATH)/tests/tcg/multiarch/check-plugin-output.sh \
> >>         $(QEMU) $<
> >>
> >> -test-plugin-mem-access: CFLAGS+=3D-pthread -O0
> >> -test-plugin-mem-access: LDFLAGS+=3D-pthread -O0
> >> +EXTRA_RUNS +=3D run-plugin-test-plugin-mem-access-with-libmem.so
> >> +endif
> >>
> >>  # Update TESTS
> >>  TESTS +=3D $(MULTIARCH_TESTS)
> >> diff --git a/tests/tcg/multiarch/system/Makefile.softmmu-target b/test=
s/tcg/multiarch/system/Makefile.softmmu-target
> >> index 5acf2700812..4171b4e6aa0 100644
> >> --- a/tests/tcg/multiarch/system/Makefile.softmmu-target
> >> +++ b/tests/tcg/multiarch/system/Makefile.softmmu-target
> >> @@ -71,8 +71,11 @@ endif
> >>  MULTIARCH_RUNS +=3D run-gdbstub-memory run-gdbstub-interrupt \
> >>         run-gdbstub-untimely-packet run-gdbstub-registers
> >>
> >> +ifeq ($(CONFIG_PLUGIN),y)
> >>  # Test plugin memory access instrumentation
> >> -run-plugin-memory-with-libmem.so:              \
> >> -       PLUGIN_ARGS=3D$(COMMA)region-summary=3Dtrue
> >> -run-plugin-memory-with-libmem.so:              \
> >> -       CHECK_PLUGIN_OUTPUT_COMMAND=3D$(MULTIARCH_SYSTEM_SRC)/validate=
-memory-counts.py $@.out
> >> +run-plugin-memory-with-libmem.so: memory libmem.so
> >
> > Hm why wasn't this needed before this change?
> >
> > I see the make `memory` target sets CHECK_UNALIGNED but where is
> > libmem.so target coming from?
> >
> >> +run-plugin-memory-with-libmem.so: PLUGIN_ARGS=3D$(COMMA)region-summar=
y=3Dtrue
> >> +run-plugin-memory-with-libmem.so: CHECK_PLUGIN_OUTPUT_COMMAND=3D$(MUL=
TIARCH_SYSTEM_SRC)/validate-memory-counts.py $@.out
> >> +
> >> +EXTRA_RUNS +=3D run-plugin-memory-with-libmem.so
>
> Because we add it to EXTRA_RUNS so we don't want that if plugins won't
> work. We could just wrap EXTRA_RUNS but the rest of the recipe is moot
> at that point anyway.

I am asking about the line

> +run-plugin-memory-with-libmem.so: memory libmem.so

Which adds two make target prerequisites `memory` and `libmem.so`, I
don't see where they came from, or maybe I am not understanding the
makefile logic here correctly.

>
> >> +endif
> >> --
> >> 2.47.2
> >>
> >>
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

