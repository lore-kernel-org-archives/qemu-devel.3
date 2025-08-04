Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6549EC87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 18:29:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uizva-0004IQ-J4; Mon, 04 Aug 2025 14:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uixzd-00012X-4P
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 12:24:59 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uixzX-0002lb-2v
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 12:24:55 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-76b77a97a04so2614092b3a.1
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 09:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754324687; x=1754929487; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JcTFinklZFp0nOBbtJKDh/zg/5aYtHEKdq9TmxLOD0Q=;
 b=JbX8I/Y5txJlnTJs2j2m7HhSBIhB5BsQRQ3vO4z8nSFMcjZh9WoQCO14yUKWxq/cwj
 5s/6btQyKgYBz7GQpHyxesl/GM8titWc0QGE0YNGYf4IT3FogFOYcy7gbcUqpCgukrUH
 VIBuA8eicXFjWMnoAh8fR3hZoS2Cv4RWtnZhtUna95xJaJKnx5YNbxYmMpwc648dPfCM
 MNsAQu+Hk5mzR3VQQ6h9NXbvjW9JJMh+MBk6YVH3YRAdDNVlsz0Ylc064g7kMr+KCViJ
 OInfbSx+OKBQPTfZxOhcHvHkZQE4gImD82Vg0umFlpIYK/lqb3ZmzjQAVQzrHWwcHh28
 rbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754324687; x=1754929487;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JcTFinklZFp0nOBbtJKDh/zg/5aYtHEKdq9TmxLOD0Q=;
 b=h40ZurBP9nMyQPz3IW4VJ0INBhnGRar6UWy+GWKiN2UDe+Ang7/DCfPy8NNQ1wSROR
 Jau/vStLvUWdQ6MzMowrq6f7sYQ4UKnT8mk6HCvrNC7LizuJ7ZoN3QGs1VMV6In0GbBF
 nsxg2EbEg60iLvI+kyKawFk6JvNLQlgQhnnF5WoOD3qtZSeYOTZ1yvTs0pYXVz9prjqB
 YvWjpLhVRA50iTv3kmTNN89w9MXTuxTVuBbwuAAZfGKCvIlZwYz9So7KWetBujSNy/fR
 /kfkB3kuQG2vEMwh8AqbBaLcZrcl+DjZSUnyNaJX43vqsgx0GeuPolTO0gcTCM+YqnE/
 krbQ==
X-Gm-Message-State: AOJu0YzpAQtQm+LCZbrO4e5jx/mjOfQGbVRIXjmdyJiI3HNMpMOOtNQY
 FKKdb/RoPVNVDerjyJt2wKDPp7Wip7qA3Qk1xKoU/NlCLOK97VOUyuvLWc3ax+VcWyw=
X-Gm-Gg: ASbGncvLLlhVxvpieH7LxpBt7IZUzCmMCzkYSliMtgld1T/sOVglmIX93piZbnRLh0+
 93pFaLurixq7g4E1T/yLFq1NgMiruq9C+zTYxbbMIGwIab7d/1LDL9qxNE42hcEHkhgX4/Qgx4S
 Mkhxggg3BuCcOhlgoLKz2GSXS/lkpiUYfN0P7ocv2ZoeiqxWA5LEz5gPqcwAodjwVnXYBi1OUtW
 WDpjLMrqCRMkNyP54xejI7A8zhaCWhI5DECj9crHwRC4F99JMO17pm+ei15pTj6UVnkuZ+sCfqN
 lCkVlPzXeOjarinhk1UjwTM74TQAERz1H2vWFfy2+h1xU9+DCDtHNyuPuUJHuAKLsDnXn5BPDEC
 HPwiMfXlmt0iN+j2fREhTTFIfKS3r3vNILVc=
X-Google-Smtp-Source: AGHT+IEgqWD146BRts1fSOZOPLIHtPj1raF7xKTBR5p6A5db3iJ/oLhjREAfkgSC8+SDph/B4m9VLw==
X-Received: by 2002:a05:6a20:3d19:b0:240:a06:7821 with SMTP id
 adf61e73a8af0-2400a06859cmr7628174637.31.1754324686761; 
 Mon, 04 Aug 2025 09:24:46 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b424e358f5asm4704001a12.49.2025.08.04.09.24.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 09:24:46 -0700 (PDT)
Message-ID: <6df0d443-4dd2-4148-b560-ece95900a083@linaro.org>
Date: Mon, 4 Aug 2025 09:24:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 11/14] tests/tcg: reduce the number of plugin tests
 combinations
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250727083254.3826585-1-alex.bennee@linaro.org>
 <20250727083254.3826585-12-alex.bennee@linaro.org>
 <eee5b640-6c65-4796-9b36-ca324f08c07c@linaro.org>
 <d1fc8730-19c5-4ee3-a37d-2ce9c6fe4b9b@linaro.org>
 <874iun8oq6.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <874iun8oq6.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

On 8/4/25 1:39 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> On 7/28/25 12:03 PM, Pierrick Bouvier wrote:
>>> Hi Alex,
>>> On 7/27/25 1:32 AM, Alex Bennée wrote:
>>>> As our set of multiarch tests has grown the practice of running every
>>>> plugin with every test is becoming unsustainable. If we switch to
>>>> ensuring every test gets run with at least one plugin we can speed
>>>> things up.
>>>>
>>>> Some plugins do need to be run with specific tests (for example the
>>>> memory instrumentation test). We can handle this by manually adding
>>>> them to EXTRA_RUNS. We also need to wrap rules in a CONFIG_PLUGIN test
>>>> so we don't enable the runs when plugins are not enabled.
>>>>
>>>> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>>> Message-ID: <20250725154517.3523095-12-alex.bennee@linaro.org>
>>>>
>>>> diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
>>>> index a12b15637ea..18afd5be194 100644
>>>> --- a/tests/tcg/Makefile.target
>>>> +++ b/tests/tcg/Makefile.target
>>>> @@ -173,14 +173,25 @@ PLUGINS=$(filter-out $(DISABLE_PLUGINS), \
>>>>     # We need to ensure expand the run-plugin-TEST-with-PLUGIN
>>>>     # pre-requistes manually here as we can't use stems to handle it. We
>>>>     # only expand MULTIARCH_TESTS which are common on most of our targets
>>>> -# to avoid an exponential explosion as new tests are added. We also
>>>> -# add some special helpers the run-plugin- rules can use below.
>>>> +# and rotate the plugins so we don't grow too out of control as new
>>>> +# tests are added. Plugins that need to run with a specific test
>>>> +# should ensure they add their combination to EXTRA_RUNS.
>>>>        ifneq ($(MULTIARCH_TESTS),)
>>>> -$(foreach p,$(PLUGINS), \
>>>> -	$(foreach t,$(MULTIARCH_TESTS),\
>>>> -		$(eval run-plugin-$(t)-with-$(p): $t $p) \
>>>> -		$(eval RUN_TESTS+=run-plugin-$(t)-with-$(p))))
>>>> +
>>>> +NUM_PLUGINS := $(words $(PLUGINS))
>>>> +NUM_TESTS := $(words $(MULTIARCH_TESTS))
>>>> +
>>>> +define mod_plus_one
>>>> +  $(shell $(PYTHON) -c "print( ($(1) % $(2)) + 1 )")
>>>> +endef
>>>> +
>>>> +$(foreach _idx, $(shell seq 1 $(NUM_TESTS)), \
>>>> +	$(eval _test := $(word $(_idx), $(MULTIARCH_TESTS))) \
>>>> +	$(eval _plugin := $(word $(call mod_plus_one, $(_idx), $(NUM_PLUGINS)), $(PLUGINS))) \
>>>> +	$(eval run-plugin-$(_test)-with-$(_plugin): $(_test) $(_plugin)) \
>>>> +	$(eval RUN_TESTS+=run-plugin-$(_test)-with-$(_plugin)))
>>>> +
>>>>     endif # MULTIARCH_TESTS
>>>>     endif # CONFIG_PLUGIN
>>>>     diff --git a/tests/tcg/multiarch/Makefile.target
>>>> b/tests/tcg/multiarch/Makefile.target
>>>> index bfdf7197a7b..38345ff8805 100644
>>>> --- a/tests/tcg/multiarch/Makefile.target
>>>> +++ b/tests/tcg/multiarch/Makefile.target
>>>> @@ -189,6 +189,10 @@ run-plugin-semiconsole-with-%:
>>>>     TESTS += semihosting semiconsole
>>>>     endif
>>>>     +test-plugin-mem-access: CFLAGS+=-pthread -O0
>>>> +test-plugin-mem-access: LDFLAGS+=-pthread -O0
>>>> +
>>>> +ifeq ($(CONFIG_PLUGIN),y)
>>>>     # Test plugin memory access instrumentation
>>>>     run-plugin-test-plugin-mem-access-with-libmem.so: \
>>>>     	PLUGIN_ARGS=$(COMMA)print-accesses=true
>>>> @@ -197,8 +201,8 @@ run-plugin-test-plugin-mem-access-with-libmem.so: \
>>>>     	$(SRC_PATH)/tests/tcg/multiarch/check-plugin-output.sh \
>>>>     	$(QEMU) $<
>>>>     -test-plugin-mem-access: CFLAGS+=-pthread -O0
>>>> -test-plugin-mem-access: LDFLAGS+=-pthread -O0
>>>> +EXTRA_RUNS += run-plugin-test-plugin-mem-access-with-libmem.so
>>>> +endif
>>>>        # Update TESTS
>>>>     TESTS += $(MULTIARCH_TESTS)
>>>> diff --git a/tests/tcg/multiarch/system/Makefile.softmmu-target b/tests/tcg/multiarch/system/Makefile.softmmu-target
>>>> index 5acf2700812..4171b4e6aa0 100644
>>>> --- a/tests/tcg/multiarch/system/Makefile.softmmu-target
>>>> +++ b/tests/tcg/multiarch/system/Makefile.softmmu-target
>>>> @@ -71,8 +71,11 @@ endif
>>>>     MULTIARCH_RUNS += run-gdbstub-memory run-gdbstub-interrupt \
>>>>     	run-gdbstub-untimely-packet run-gdbstub-registers
>>>>     +ifeq ($(CONFIG_PLUGIN),y)
>>>>     # Test plugin memory access instrumentation
>>>> -run-plugin-memory-with-libmem.so: 		\
>>>> -	PLUGIN_ARGS=$(COMMA)region-summary=true
>>>> -run-plugin-memory-with-libmem.so: 		\
>>>> -	CHECK_PLUGIN_OUTPUT_COMMAND=$(MULTIARCH_SYSTEM_SRC)/validate-memory-counts.py $@.out
>>>> +run-plugin-memory-with-libmem.so: memory libmem.so
>>>> +run-plugin-memory-with-libmem.so: PLUGIN_ARGS=$(COMMA)region-summary=true
>>>> +run-plugin-memory-with-libmem.so: CHECK_PLUGIN_OUTPUT_COMMAND=$(MULTIARCH_SYSTEM_SRC)/validate-memory-counts.py $@.out
>>>> +
>>>> +EXTRA_RUNS += run-plugin-memory-with-libmem.so
>>>> +endif
>>> I'm not sure how it's related, but check-tcg on aarch64 host now
>>> fails
>>> [1] since this series was merged, and I suspect it may be related to
>>> this patch. I didn't spend time to reproduce and investigate it.
>>>
>>
>> Reverting this patch solved the problem on my side. As well, I'm not
>> sure if it's a real problem to run all plugins for all tests. At the
>> moment, it takes 5 min on a slow machine with 4 cpus and a sanitized
>> build, something we can probably live with for now.
> 
> It definitely is - but it really shows up on linux-user builds because
> we have an increasing number of multiarch tests and its not sustainable
> to increase by $NARCH * $NPLUGIN everytime a new multiarch test is
> added.
>

For information, plugins tests are responsible for 65% of check-tcg time 
approximately, so this makes sense.

>>
>> Unfortunately Alex is out this week, but it would be nice if another
>> maintainer could make a PR reverting this patch.
>>
>> Regards,
>> Pierrick
>>
>>> [1]
>>> https://github.com/pbo-linaro/qemu-ci/actions/runs/16575679153/job/46879690693
> 


