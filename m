Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10EDDC87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 08:40:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiqju-0005sW-PF; Mon, 04 Aug 2025 04:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uiqjZ-0005gn-4V
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 04:39:55 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uiqjW-0001cN-DN
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 04:39:52 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-459ddf9019cso706355e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 01:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754296787; x=1754901587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cIbZcS9QBoHKGZTMPxYYuRJt2hjnDtXVq145p2TMbJo=;
 b=R6F+/+AxFkW2xyHJpR3/XBNKy45pd4E1BkSmc0unhyVwU9GGaY8O63vKSUxsk32ww5
 r8bYi+XHJeztjXTea/ohtq2rTSERawk08EsaIHvHxdYaIzG5JUkciDPAtMGxmiUDfWQV
 4taO/PiWCm0hnyEBWjXQ3AdC078yTkV8kc/PW7jawZlgJKyBY3au5iKLd3n02FFWr4rT
 1Z9Ut0HRr8t4hHRaxKJTZlnVUHnPp+eUn8VnUYI8BDq4i/pqyiOAYxMFzOwKFUuwY1vh
 UdsHAzYGZy8RhWaErl15z/ZHqdpel1mEPFVI5r/csIDgCJn55LbncBWlHBX/8ajRw2/i
 9EKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754296787; x=1754901587;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cIbZcS9QBoHKGZTMPxYYuRJt2hjnDtXVq145p2TMbJo=;
 b=tJqf0l0lTQSonTg3kT+GUX3UUJn38I8IiTdrbjDTLLTaAiD4fDIKxCwXA9pJ60WD4U
 07YXbY66oeFkykPvDSoUNFuR62Ho1oBzR6gHz+sjcJWT5XcSPc5kL7a+DGfTCbK4ZU1q
 8smgHl01HOCXCPWTIAiDq/oKxA6F5EjgmA38ruwfAkGutDbg7xh5NHBgIzywJWzgvMZw
 nYgfWH23JKwExrRarkpLzhP0lvX1VmEb5JgEjEpN7plFGI0ozcRoWFdoAY66Tt4rnSpi
 FEf1kEtzKJdHe2UwhiEBc6rXLsKgQPHAlu/eFBoRQNEiy8uoFeP6C7rDGlt5puiRcPTh
 tvOg==
X-Gm-Message-State: AOJu0YxQC/UecZpQdUbMx/cigxBzMWJyOaNruKx3MdIumu5iiLusLZie
 hZdhVDKpW6fILpADtCr44Y4Zzy4MD1dVm8LIqmzmv962FBLvjLqRgGDWq3SZKVCFBnxxQqWluSK
 myOuW
X-Gm-Gg: ASbGncvg1tmm0m/W6rQAgo9qh+xRGoI91udkXabASYRahwyIMXvihYhae+dpEJaskRU
 m/DP7JhlBR1uEqGlSilUNWbPlg3WUxelm+vtC7Pb6aJ46OCvY6IEFOmK8rnRUdYTVuBELhx+M6R
 j4dzQoMjH929Sb+t3Et1LF/I2WD9GCuS5EswLW0LEXKEqyhr5Ykg3j+XbA2gfveePDwdV/Mg5zj
 UI8PULGpRVTcXdgxn6Tzd+f/cOH9RRNrXvocpkkHftBHno+1rvQH+x123XEBO75SZIZ/WcdaRq5
 F01IieD6l9Cu8GwuAp6FJ4q6ptr6UgVxFnU+wCCIUWEFKtb9Hl0P5zato6W4SNe/j1C46IZFWdq
 AR47Ll3SlzPkY2n8SmwK+FqI=
X-Google-Smtp-Source: AGHT+IF36XDFU24ToBKhT0yzphIZz2fLTrEp5rQi6NHPR31aWjGPoRIsGumQ2YMko/frGB9jyoUQwQ==
X-Received: by 2002:a05:600c:3ba5:b0:459:d616:25c5 with SMTP id
 5b1f17b1804b1-459d6162762mr32381275e9.12.1754296786974; 
 Mon, 04 Aug 2025 01:39:46 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e0b2d2fasm4635123f8f.50.2025.08.04.01.39.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 01:39:46 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4D5A35F88A;
 Mon, 04 Aug 2025 09:39:45 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PULL 11/14] tests/tcg: reduce the number of plugin tests
 combinations
In-Reply-To: <d1fc8730-19c5-4ee3-a37d-2ce9c6fe4b9b@linaro.org> (Pierrick
 Bouvier's message of "Wed, 30 Jul 2025 00:25:00 -0700")
References: <20250727083254.3826585-1-alex.bennee@linaro.org>
 <20250727083254.3826585-12-alex.bennee@linaro.org>
 <eee5b640-6c65-4796-9b36-ca324f08c07c@linaro.org>
 <d1fc8730-19c5-4ee3-a37d-2ce9c6fe4b9b@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 04 Aug 2025 09:39:45 +0100
Message-ID: <874iun8oq6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

> On 7/28/25 12:03 PM, Pierrick Bouvier wrote:
>> Hi Alex,
>> On 7/27/25 1:32 AM, Alex Benn=C3=A9e wrote:
>>> As our set of multiarch tests has grown the practice of running every
>>> plugin with every test is becoming unsustainable. If we switch to
>>> ensuring every test gets run with at least one plugin we can speed
>>> things up.
>>>
>>> Some plugins do need to be run with specific tests (for example the
>>> memory instrumentation test). We can handle this by manually adding
>>> them to EXTRA_RUNS. We also need to wrap rules in a CONFIG_PLUGIN test
>>> so we don't enable the runs when plugins are not enabled.
>>>
>>> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> Message-ID: <20250725154517.3523095-12-alex.bennee@linaro.org>
>>>
>>> diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
>>> index a12b15637ea..18afd5be194 100644
>>> --- a/tests/tcg/Makefile.target
>>> +++ b/tests/tcg/Makefile.target
>>> @@ -173,14 +173,25 @@ PLUGINS=3D$(filter-out $(DISABLE_PLUGINS), \
>>>    # We need to ensure expand the run-plugin-TEST-with-PLUGIN
>>>    # pre-requistes manually here as we can't use stems to handle it. We
>>>    # only expand MULTIARCH_TESTS which are common on most of our targets
>>> -# to avoid an exponential explosion as new tests are added. We also
>>> -# add some special helpers the run-plugin- rules can use below.
>>> +# and rotate the plugins so we don't grow too out of control as new
>>> +# tests are added. Plugins that need to run with a specific test
>>> +# should ensure they add their combination to EXTRA_RUNS.
>>>       ifneq ($(MULTIARCH_TESTS),)
>>> -$(foreach p,$(PLUGINS), \
>>> -	$(foreach t,$(MULTIARCH_TESTS),\
>>> -		$(eval run-plugin-$(t)-with-$(p): $t $p) \
>>> -		$(eval RUN_TESTS+=3Drun-plugin-$(t)-with-$(p))))
>>> +
>>> +NUM_PLUGINS :=3D $(words $(PLUGINS))
>>> +NUM_TESTS :=3D $(words $(MULTIARCH_TESTS))
>>> +
>>> +define mod_plus_one
>>> +  $(shell $(PYTHON) -c "print( ($(1) % $(2)) + 1 )")
>>> +endef
>>> +
>>> +$(foreach _idx, $(shell seq 1 $(NUM_TESTS)), \
>>> +	$(eval _test :=3D $(word $(_idx), $(MULTIARCH_TESTS))) \
>>> +	$(eval _plugin :=3D $(word $(call mod_plus_one, $(_idx), $(NUM_PLUGIN=
S)), $(PLUGINS))) \
>>> +	$(eval run-plugin-$(_test)-with-$(_plugin): $(_test) $(_plugin)) \
>>> +	$(eval RUN_TESTS+=3Drun-plugin-$(_test)-with-$(_plugin)))
>>> +
>>>    endif # MULTIARCH_TESTS
>>>    endif # CONFIG_PLUGIN
>>>    diff --git a/tests/tcg/multiarch/Makefile.target
>>> b/tests/tcg/multiarch/Makefile.target
>>> index bfdf7197a7b..38345ff8805 100644
>>> --- a/tests/tcg/multiarch/Makefile.target
>>> +++ b/tests/tcg/multiarch/Makefile.target
>>> @@ -189,6 +189,10 @@ run-plugin-semiconsole-with-%:
>>>    TESTS +=3D semihosting semiconsole
>>>    endif
>>>    +test-plugin-mem-access: CFLAGS+=3D-pthread -O0
>>> +test-plugin-mem-access: LDFLAGS+=3D-pthread -O0
>>> +
>>> +ifeq ($(CONFIG_PLUGIN),y)
>>>    # Test plugin memory access instrumentation
>>>    run-plugin-test-plugin-mem-access-with-libmem.so: \
>>>    	PLUGIN_ARGS=3D$(COMMA)print-accesses=3Dtrue
>>> @@ -197,8 +201,8 @@ run-plugin-test-plugin-mem-access-with-libmem.so: \
>>>    	$(SRC_PATH)/tests/tcg/multiarch/check-plugin-output.sh \
>>>    	$(QEMU) $<
>>>    -test-plugin-mem-access: CFLAGS+=3D-pthread -O0
>>> -test-plugin-mem-access: LDFLAGS+=3D-pthread -O0
>>> +EXTRA_RUNS +=3D run-plugin-test-plugin-mem-access-with-libmem.so
>>> +endif
>>>       # Update TESTS
>>>    TESTS +=3D $(MULTIARCH_TESTS)
>>> diff --git a/tests/tcg/multiarch/system/Makefile.softmmu-target b/tests=
/tcg/multiarch/system/Makefile.softmmu-target
>>> index 5acf2700812..4171b4e6aa0 100644
>>> --- a/tests/tcg/multiarch/system/Makefile.softmmu-target
>>> +++ b/tests/tcg/multiarch/system/Makefile.softmmu-target
>>> @@ -71,8 +71,11 @@ endif
>>>    MULTIARCH_RUNS +=3D run-gdbstub-memory run-gdbstub-interrupt \
>>>    	run-gdbstub-untimely-packet run-gdbstub-registers
>>>    +ifeq ($(CONFIG_PLUGIN),y)
>>>    # Test plugin memory access instrumentation
>>> -run-plugin-memory-with-libmem.so: 		\
>>> -	PLUGIN_ARGS=3D$(COMMA)region-summary=3Dtrue
>>> -run-plugin-memory-with-libmem.so: 		\
>>> -	CHECK_PLUGIN_OUTPUT_COMMAND=3D$(MULTIARCH_SYSTEM_SRC)/validate-memory=
-counts.py $@.out
>>> +run-plugin-memory-with-libmem.so: memory libmem.so
>>> +run-plugin-memory-with-libmem.so: PLUGIN_ARGS=3D$(COMMA)region-summary=
=3Dtrue
>>> +run-plugin-memory-with-libmem.so: CHECK_PLUGIN_OUTPUT_COMMAND=3D$(MULT=
IARCH_SYSTEM_SRC)/validate-memory-counts.py $@.out
>>> +
>>> +EXTRA_RUNS +=3D run-plugin-memory-with-libmem.so
>>> +endif
>> I'm not sure how it's related, but check-tcg on aarch64 host now
>> fails
>> [1] since this series was merged, and I suspect it may be related to
>> this patch. I didn't spend time to reproduce and investigate it.
>>
>
> Reverting this patch solved the problem on my side. As well, I'm not
> sure if it's a real problem to run all plugins for all tests. At the
> moment, it takes 5 min on a slow machine with 4 cpus and a sanitized
> build, something we can probably live with for now.

It definitely is - but it really shows up on linux-user builds because
we have an increasing number of multiarch tests and its not sustainable
to increase by $NARCH * $NPLUGIN everytime a new multiarch test is
added.

>
> Unfortunately Alex is out this week, but it would be nice if another
> maintainer could make a PR reverting this patch.
>
> Regards,
> Pierrick
>
>> [1]
>> https://github.com/pbo-linaro/qemu-ci/actions/runs/16575679153/job/46879=
690693

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

