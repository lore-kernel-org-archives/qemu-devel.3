Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90328C83F26
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 20:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugUDr-0003lA-ML; Mon, 28 Jul 2025 16:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1ugUDo-0003jC-7d
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 16:13:20 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1ugUDl-0001H3-Jx
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 16:13:19 -0400
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-23c8f179e1bso55138545ad.1
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 13:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753733595; x=1754338395; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CK9yFVQtD4ZAvw7QtkLY4WCaJp220DBcsLSZrJ2N6rc=;
 b=pBUBYYO5CU+ZLJjm0GKoPBlZFAIH/DqVMAj75trZsvAT/gRFy5n9vOdNlM+uGDMJyf
 tyqmhMM8HDTE6LHXpsIyHClrsgPJcvo1gTT6MDM9ME+fE4t/ofmnxuPJgDWoo9jxyVtT
 ugq8zQsEjFUmWsZCcp2JnWzi0E42AE5b1cZoCVVpb8OP/PwlQ0m8rm2aLV3q9NhMZHrE
 LisjERbC9DT6bjNnRmIXQHbVlT7KL0YkuS/FBGiClM/US9g0HGWX3ucLDityEdMlPrAV
 6sISJFP5FF4ql185vYLhCpxRjygcioVSG0yZtNL0ErFGnbCcfZmYVZqhWETYfbefciwO
 lKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753733595; x=1754338395;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CK9yFVQtD4ZAvw7QtkLY4WCaJp220DBcsLSZrJ2N6rc=;
 b=RuOjp6+wasfNFndMkE2+31C4AwNFSwUYZQANhI5USgH1ujXkoALvJHtPvCyGEfsy+p
 B1Ap0hmEb6QI6BAIbycr8EPV7NatjY/9nlX1/W2x+n4QgJrnv0QXyOvwEM9lP2Dm5YV0
 +FhFsjRecRQhuAkJytYKDTGYGkxO3QwUr+qzLzobTQYbQEko3kt52omZNU6gRNXoUDyq
 9THF1FfPGVmlwelHjBQmZhQII0/aQkGVU+t5OkuXUdsis3W7/age8ihHS2YxN+xS+i+6
 34IebYm6RfwTWOZPhVY6J4R1Jo02eEH4xGE4ZaEZ45j2J2mN8/+v+MTrsKYc1r3EzXMw
 TDGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWR6AUPPnp0SPhkgNwOKYO9S1/4QYY186mSDC2074jwssf0JBJUDUpD87KeEI4tKN80pINCDWFcIOjx@nongnu.org
X-Gm-Message-State: AOJu0YxCXIoEc6RIysAxbF0d7mfiKwbA5VMV2oZkzV6rb+x9HXBGM6QA
 vjIwjnunTlrFqAoNLq4/7dEHNaNbKkJ05CmTo3jMFu8VDPHHFKjwqC7dLCNfabf4jns=
X-Gm-Gg: ASbGncsj7XMoa++xeLompYUVLJd9FE5RurWcO9McBc4tHj5lYo2q/IfI4LlRMt/UvWA
 PPZ7KvlvAYuLjg9rkEd/Gm3tszGHEqrj8nQbppoDg5DKj6UzHuzR7BpyRcEp6Q0lPSFlwj6vp8T
 t4DTesZlBtT+gaPtcrCPY4+V2RWat6XKmn4E72mDRte1j/INkIp7nBwTCEU+vrGV+ULR2uoQGgM
 7YYEOw6Wkjd/FGLLmOj3t3a9BQIu0AOmFanEZoslS+E3vFUp9XDtPNzOCowEXv1xj3rXCzTOCeP
 5Hqfxn8pXCH7VM8eQrTxhbwCVSSN4miyIVYFGz7Y5rmNluR6aVNNHZdFSsvErRpUoVT8HBhBsC/
 UPiKaKogpbapErBQVZJeyAwrjbyny00TCsw==
X-Google-Smtp-Source: AGHT+IGX8Fs2lQrfNyNNtyJF06BKjWFKtiJ2/ZDBxI/VU9pcWZy+x2CHI+LEI2Z1SLmkoq8xLK0igg==
X-Received: by 2002:a17:902:ccc9:b0:240:2eb6:d5cc with SMTP id
 d9443c01a7336-2402eb6d9e9mr86850905ad.17.1753733595400; 
 Mon, 28 Jul 2025 13:13:15 -0700 (PDT)
Received: from [192.168.0.102] ([187.75.37.236])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2402ec8a087sm26031115ad.84.2025.07.28.13.13.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 13:13:15 -0700 (PDT)
Message-ID: <2635ef88-b662-41b9-b206-ca1923e87e91@linaro.org>
Date: Mon, 28 Jul 2025 17:14:08 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 11/14] tests/tcg: reduce the number of plugin tests
 combinations
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250727083254.3826585-1-alex.bennee@linaro.org>
 <20250727083254.3826585-12-alex.bennee@linaro.org>
 <eee5b640-6c65-4796-9b36-ca324f08c07c@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <eee5b640-6c65-4796-9b36-ca324f08c07c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x643.google.com
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

Hi,

On 7/28/25 16:03, Pierrick Bouvier wrote:
> Hi Alex,
> 
> On 7/27/25 1:32 AM, Alex Bennée wrote:
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
>> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> Message-ID: <20250725154517.3523095-12-alex.bennee@linaro.org>
>>
>> diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
>> index a12b15637ea..18afd5be194 100644
>> --- a/tests/tcg/Makefile.target
>> +++ b/tests/tcg/Makefile.target
>> @@ -173,14 +173,25 @@ PLUGINS=$(filter-out $(DISABLE_PLUGINS), \
>>   # We need to ensure expand the run-plugin-TEST-with-PLUGIN
>>   # pre-requistes manually here as we can't use stems to handle it. We
>>   # only expand MULTIARCH_TESTS which are common on most of our targets
>> -# to avoid an exponential explosion as new tests are added. We also
>> -# add some special helpers the run-plugin- rules can use below.
>> +# and rotate the plugins so we don't grow too out of control as new
>> +# tests are added. Plugins that need to run with a specific test
>> +# should ensure they add their combination to EXTRA_RUNS.
>>   ifneq ($(MULTIARCH_TESTS),)
>> -$(foreach p,$(PLUGINS), \
>> -    $(foreach t,$(MULTIARCH_TESTS),\
>> -        $(eval run-plugin-$(t)-with-$(p): $t $p) \
>> -        $(eval RUN_TESTS+=run-plugin-$(t)-with-$(p))))
>> +
>> +NUM_PLUGINS := $(words $(PLUGINS))
>> +NUM_TESTS := $(words $(MULTIARCH_TESTS))
>> +
>> +define mod_plus_one
>> +  $(shell $(PYTHON) -c "print( ($(1) % $(2)) + 1 )")
>> +endef
>> +
>> +$(foreach _idx, $(shell seq 1 $(NUM_TESTS)), \
>> +    $(eval _test := $(word $(_idx), $(MULTIARCH_TESTS))) \
>> +    $(eval _plugin := $(word $(call mod_plus_one, $(_idx), $(NUM_PLUGINS)), $(PLUGINS))) \
>> +    $(eval run-plugin-$(_test)-with-$(_plugin): $(_test) $(_plugin)) \
>> +    $(eval RUN_TESTS+=run-plugin-$(_test)-with-$(_plugin)))
>> +
>>   endif # MULTIARCH_TESTS
>>   endif # CONFIG_PLUGIN
>> diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
>> index bfdf7197a7b..38345ff8805 100644
>> --- a/tests/tcg/multiarch/Makefile.target
>> +++ b/tests/tcg/multiarch/Makefile.target
>> @@ -189,6 +189,10 @@ run-plugin-semiconsole-with-%:
>>   TESTS += semihosting semiconsole
>>   endif
>> +test-plugin-mem-access: CFLAGS+=-pthread -O0
>> +test-plugin-mem-access: LDFLAGS+=-pthread -O0
>> +
>> +ifeq ($(CONFIG_PLUGIN),y)
>>   # Test plugin memory access instrumentation
>>   run-plugin-test-plugin-mem-access-with-libmem.so: \
>>       PLUGIN_ARGS=$(COMMA)print-accesses=true
>> @@ -197,8 +201,8 @@ run-plugin-test-plugin-mem-access-with-libmem.so: \
>>       $(SRC_PATH)/tests/tcg/multiarch/check-plugin-output.sh \
>>       $(QEMU) $<
>> -test-plugin-mem-access: CFLAGS+=-pthread -O0
>> -test-plugin-mem-access: LDFLAGS+=-pthread -O0
>> +EXTRA_RUNS += run-plugin-test-plugin-mem-access-with-libmem.so
>> +endif
>>   # Update TESTS
>>   TESTS += $(MULTIARCH_TESTS)
>> diff --git a/tests/tcg/multiarch/system/Makefile.softmmu-target b/tests/tcg/multiarch/system/Makefile.softmmu-target
>> index 5acf2700812..4171b4e6aa0 100644
>> --- a/tests/tcg/multiarch/system/Makefile.softmmu-target
>> +++ b/tests/tcg/multiarch/system/Makefile.softmmu-target
>> @@ -71,8 +71,11 @@ endif
>>   MULTIARCH_RUNS += run-gdbstub-memory run-gdbstub-interrupt \
>>       run-gdbstub-untimely-packet run-gdbstub-registers
>> +ifeq ($(CONFIG_PLUGIN),y)
>>   # Test plugin memory access instrumentation
>> -run-plugin-memory-with-libmem.so:         \
>> -    PLUGIN_ARGS=$(COMMA)region-summary=true
>> -run-plugin-memory-with-libmem.so:         \
>> -    CHECK_PLUGIN_OUTPUT_COMMAND=$(MULTIARCH_SYSTEM_SRC)/validate-memory-counts.py $@.out
>> +run-plugin-memory-with-libmem.so: memory libmem.so
>> +run-plugin-memory-with-libmem.so: PLUGIN_ARGS=$(COMMA)region-summary=true
>> +run-plugin-memory-with-libmem.so: CHECK_PLUGIN_OUTPUT_COMMAND=$(MULTIARCH_SYSTEM_SRC)/validate-memory-counts.py $@.out
>> +
>> +EXTRA_RUNS += run-plugin-memory-with-libmem.so
>> +endif
> 
> I'm not sure how it's related, but check-tcg on aarch64 host now fails [1] since this series was merged, and I suspect it may be related to this patch. I didn't spend time to reproduce and investigate it.
> 
> [1] https://github.com/pbo-linaro/qemu-ci/actions/runs/16575679153/job/46879690693

I was not able to reproduce it locally on 22.04, but in the CI indeed the test command is missing the "test-plugin-mem-access" binary at the end, just before redirection to .so.out, it should be:

[...] -D test-plugin-mem-access-with-libmem.so.pout test-plugin-mem-access >  run-plugin-test-plugin-mem-access-with-libmem.so.out

not:

[...] -D test-plugin-mem-access-with-libmem.so.pout  >  run-plugin-test-plugin-mem-access-with-libmem.so.out


Cheers,
Gustavo

