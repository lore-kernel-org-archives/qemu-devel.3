Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93157C83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 12:01:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueucU-0002LJ-RS; Thu, 24 Jul 2025 08:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ueucP-0001XY-A7
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 08:00:14 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ueucJ-00049e-CI
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 08:00:13 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ae6f8d3bcd4so166834966b.1
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 05:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753358401; x=1753963201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GSyy2ISaFfs8jx2rIvkOQ60Wvv27UpzENUYoKqTOGD8=;
 b=OEKfKqTJtYPgPbou8YPnk5BghoTtLtniMxOWBzG91aEb2WWLuncvWVOJ00Tt1R29kx
 TXTgz4lfGpAVxqiYPLw1c8KIgRhDZArhkbXHUKaPuLojT4ljqCympElFAp79YNgqUDIH
 ROAfb9OAf6k2Qhw29OjCAOEDgW7F4dO/4YMsITdsy+uFA5IvHP+KkZW34m9sxw5T63x0
 zgGfRYqbqv9rcqxCoH/MNcerNy70Dtma+nfC08E2wHtEwRTSlTrb9DIwcnXjEHrkC5uF
 xtdsT0R/SUyi9rMF+ZEUcJn8UIyZhbPFp9d5UEyfAnMHk9HTM2IydrKDHRIW//OWUAPq
 z9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753358401; x=1753963201;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GSyy2ISaFfs8jx2rIvkOQ60Wvv27UpzENUYoKqTOGD8=;
 b=diDeFgDZaD1aawvlBlFYfnLUZ6oCbduwT/skcRDAAEmn05e7qsSiUwRzQRf3cXpiQb
 j8YSagmFeeD3iSm+zOO5+u++vt413ujvAJSAJ37irmZfks3EhtSROkrbsROV84dOfupK
 kKMsE/aQ0lMwWQiDBvYxqRXUvUVmaUf+pPqKVbPe5iqNXQhg/kKS6lQeWBPOjgcBicT1
 I2sumDWH5O4z1Y0VYCXMkYuM055gxNfsuIHQa1UN3hWRiKvUUtijx1SEBP2Sbxcv8+ic
 IYeIWG/YFhx+IeOEsVAXOWpYcGB71Kd9EEJbdXpGVNGujOyzggzBBCDrOo6htF+Al1fW
 AOEg==
X-Gm-Message-State: AOJu0YyrGXYzPFbUCCf41NvFmqPbR4ZANAekW89+NxPSb9m3eX9suy8m
 kVz3Q+5OsI7NhZxd49upyknQG8DtB+QPCFOb+8742+GMJ+jzQOzQnwDTo0PTcomph7I=
X-Gm-Gg: ASbGncuBjaB40G7kRw/W/6BXpPVvkP4kzzQJA0Vo2TAOXnJvm/EqJrPblIZB5WU9xYl
 EtfJwywwegtLqaM9GaI3M+YMAWSwy5uicjkC7SXxoGYKGNwUBMn63Vgzkcjt8tPhr7xs8f4trVG
 /e918KSVsIsyMuG4+QvJ+gjU3nsT7Fwpof7Fcs4wjY10YoAJJ9pqezTNLzY2X/saeYWqc4hJoS4
 B/XN52JwzKlTALVn8DZp1SJEESnyk/3xXRhxGc4KX3NKhC4hzk45Cs7tZSdobKeiW1jkBdPlCqe
 KMkddpYxoCGizCEnXyEiHhMfqmkqCDFFoS1we4Zf2TpYrpB2yW5QJmXD+ZuKfI/IYGRHECpALrd
 0tAM6eEAHnzHekYh0bJd41uw5pzZikCcZNQ==
X-Google-Smtp-Source: AGHT+IEHGLcJkcgodad560dd8EnyfdoNqpv0HO3lWMQyL7T6yU7x/ypqNdhljipEsVVnpYHq9Agj3w==
X-Received: by 2002:a17:906:4795:b0:ae9:8dcb:4dac with SMTP id
 a640c23a62f3a-af2f6b05842mr690599666b.14.1753358400580; 
 Thu, 24 Jul 2025 05:00:00 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af47f8611a8sm102206066b.106.2025.07.24.04.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 04:59:59 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 005F55F7B0;
 Thu, 24 Jul 2025 12:59:58 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,  Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH for 10.1 11/13] tests/tcg: reduce the number of plugin
 tests combinations
In-Reply-To: <CAAjaMXb9-jkDhLA1euY3-90c4q=2my=QuDpJQGGObAZGTy3-xQ@mail.gmail.com>
 (Manos Pitsidianakis's message of "Thu, 24 Jul 2025 14:25:47 +0300")
References: <20250724105939.2393230-1-alex.bennee@linaro.org>
 <20250724105939.2393230-12-alex.bennee@linaro.org>
 <CAAjaMXb9-jkDhLA1euY3-90c4q=2my=QuDpJQGGObAZGTy3-xQ@mail.gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Thu, 24 Jul 2025 12:59:58 +0100
Message-ID: <87bjp9vlxd.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

> On Thu, Jul 24, 2025 at 2:00=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@lin=
aro.org> wrote:
>>
>> As our set of multiarch tests has grown the practice of running every
>> plugin with every test is becoming unsustainable. If we switch to
>> ensuring every test gets run with at least one plugin we can speed
>> things up.
>>
>> Some plugins do need to be run with specific tests (for example the
>> memory instrumentation test). We can handle this by manually adding
>> them to EXTRA_RUNS. We also need to wrap rules in a CONFIG_PLUGIN test
>> so we don't enable the runs when plugins are not enabled.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  tests/tcg/Makefile.target                     | 23 ++++++++++++++-----
>>  tests/tcg/multiarch/Makefile.target           |  8 +++++--
>>  .../multiarch/system/Makefile.softmmu-target  | 11 +++++----
>>  3 files changed, 30 insertions(+), 12 deletions(-)
>>
>> diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
>> index a12b15637ea..18afd5be194 100644
>> --- a/tests/tcg/Makefile.target
>> +++ b/tests/tcg/Makefile.target
>> @@ -173,14 +173,25 @@ PLUGINS=3D$(filter-out $(DISABLE_PLUGINS), \
>>  # We need to ensure expand the run-plugin-TEST-with-PLUGIN
>>  # pre-requistes manually here as we can't use stems to handle it. We
>>  # only expand MULTIARCH_TESTS which are common on most of our targets
>> -# to avoid an exponential explosion as new tests are added. We also
>> -# add some special helpers the run-plugin- rules can use below.
>> +# and rotate the plugins so we don't grow too out of control as new
>> +# tests are added. Plugins that need to run with a specific test
>> +# should ensure they add their combination to EXTRA_RUNS.
>>
>>  ifneq ($(MULTIARCH_TESTS),)
>> -$(foreach p,$(PLUGINS), \
>> -       $(foreach t,$(MULTIARCH_TESTS),\
>> -               $(eval run-plugin-$(t)-with-$(p): $t $p) \
>> -               $(eval RUN_TESTS+=3Drun-plugin-$(t)-with-$(p))))
>> +
>> +NUM_PLUGINS :=3D $(words $(PLUGINS))
>> +NUM_TESTS :=3D $(words $(MULTIARCH_TESTS))
>> +
>> +define mod_plus_one
>> +  $(shell $(PYTHON) -c "print( ($(1) % $(2)) + 1 )")
>> +endef
>> +
>> +$(foreach _idx, $(shell seq 1 $(NUM_TESTS)), \
>> +       $(eval _test :=3D $(word $(_idx), $(MULTIARCH_TESTS))) \
>> +       $(eval _plugin :=3D $(word $(call mod_plus_one, $(_idx), $(NUM_P=
LUGINS)), $(PLUGINS))) \
>> +       $(eval run-plugin-$(_test)-with-$(_plugin): $(_test) $(_plugin))=
 \
>> +       $(eval RUN_TESTS+=3Drun-plugin-$(_test)-with-$(_plugin)))
>> +
>>  endif # MULTIARCH_TESTS
>>  endif # CONFIG_PLUGIN
>>
>> diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/M=
akefile.target
>> index bfdf7197a7b..38345ff8805 100644
>> --- a/tests/tcg/multiarch/Makefile.target
>> +++ b/tests/tcg/multiarch/Makefile.target
>> @@ -189,6 +189,10 @@ run-plugin-semiconsole-with-%:
>>  TESTS +=3D semihosting semiconsole
>>  endif
>>
>> +test-plugin-mem-access: CFLAGS+=3D-pthread -O0
>> +test-plugin-mem-access: LDFLAGS+=3D-pthread -O0
>> +
>> +ifeq ($(CONFIG_PLUGIN),y)
>>  # Test plugin memory access instrumentation
>>  run-plugin-test-plugin-mem-access-with-libmem.so: \
>>         PLUGIN_ARGS=3D$(COMMA)print-accesses=3Dtrue
>> @@ -197,8 +201,8 @@ run-plugin-test-plugin-mem-access-with-libmem.so: \
>>         $(SRC_PATH)/tests/tcg/multiarch/check-plugin-output.sh \
>>         $(QEMU) $<
>>
>> -test-plugin-mem-access: CFLAGS+=3D-pthread -O0
>> -test-plugin-mem-access: LDFLAGS+=3D-pthread -O0
>> +EXTRA_RUNS +=3D run-plugin-test-plugin-mem-access-with-libmem.so
>> +endif
>>
>>  # Update TESTS
>>  TESTS +=3D $(MULTIARCH_TESTS)
>> diff --git a/tests/tcg/multiarch/system/Makefile.softmmu-target b/tests/=
tcg/multiarch/system/Makefile.softmmu-target
>> index 5acf2700812..4171b4e6aa0 100644
>> --- a/tests/tcg/multiarch/system/Makefile.softmmu-target
>> +++ b/tests/tcg/multiarch/system/Makefile.softmmu-target
>> @@ -71,8 +71,11 @@ endif
>>  MULTIARCH_RUNS +=3D run-gdbstub-memory run-gdbstub-interrupt \
>>         run-gdbstub-untimely-packet run-gdbstub-registers
>>
>> +ifeq ($(CONFIG_PLUGIN),y)
>>  # Test plugin memory access instrumentation
>> -run-plugin-memory-with-libmem.so:              \
>> -       PLUGIN_ARGS=3D$(COMMA)region-summary=3Dtrue
>> -run-plugin-memory-with-libmem.so:              \
>> -       CHECK_PLUGIN_OUTPUT_COMMAND=3D$(MULTIARCH_SYSTEM_SRC)/validate-m=
emory-counts.py $@.out
>> +run-plugin-memory-with-libmem.so: memory libmem.so
>
> Hm why wasn't this needed before this change?
>
> I see the make `memory` target sets CHECK_UNALIGNED but where is
> libmem.so target coming from?
>
>> +run-plugin-memory-with-libmem.so: PLUGIN_ARGS=3D$(COMMA)region-summary=
=3Dtrue
>> +run-plugin-memory-with-libmem.so: CHECK_PLUGIN_OUTPUT_COMMAND=3D$(MULTI=
ARCH_SYSTEM_SRC)/validate-memory-counts.py $@.out
>> +
>> +EXTRA_RUNS +=3D run-plugin-memory-with-libmem.so

Because we add it to EXTRA_RUNS so we don't want that if plugins won't
work. We could just wrap EXTRA_RUNS but the rest of the recipe is moot
at that point anyway.

>> +endif
>> --
>> 2.47.2
>>
>>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

