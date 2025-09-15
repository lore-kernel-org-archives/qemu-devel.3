Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE81CCAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 22:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyHR0-0001ja-OH; Mon, 15 Sep 2025 18:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uyHQu-0001iE-GH
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 18:12:24 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uyHQg-0002Y3-MU
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 18:12:20 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b4755f37c3eso3986071a12.3
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 15:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757974322; x=1758579122; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QxVOYWyd2LkvoUg7aXq+N53uRKsFD9A2D50a62UMNmw=;
 b=JvvnDbc3MovCSHemx8GLOY9XTLJg724MFx8qMXN87shoU7ticv7m59aIhtN3dM/Cl9
 gZZDCobbCw9AuFPRJC6WT10SRrmJ78rM4MuRBpXek8u0KxFdrSuZgFGgfqihmENlbu3y
 rqV4r9XAntJoCtLewmNgJGkkHMFu0RmWMju1u7xnXaYyzW5eQC9362mkZPK/oxlxWPCt
 TYnc1yo8E25T1A1jJxgnms8I03J8y6dn3CRA5OCeJuIB3Iml6Nbdhb090naW/yQQ74A7
 kg/52fXnhjZWZyuE/Ri8LlGBVVL6djmKHk2IryD5ZmHN/Ol73Q3r2XZg9BXPGTlz6f+z
 wcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757974322; x=1758579122;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QxVOYWyd2LkvoUg7aXq+N53uRKsFD9A2D50a62UMNmw=;
 b=kcOYCFhw0REKoUYE4ENVBl3umdByH51xPC3AHeHkarrD2VA5zWw7SfrZdUiXzW7vwN
 STqU4T0WvbkcSofDQa4S54lrmjGTriWicmsy/sJoeZTy0nT1ZGl/bKowiH6GKcGWbYcj
 MvkajZhZXNeStodej1WACwfgCLDOAoKe1BUo13RuTk+VRqWPFEEVBtzdary+qK7FZ/0A
 udsQQNbBtpYVvCmy4I8q0EN1WLf1A28KiXmpCIWLiqWoplAZKl99hQe+HFjKhhGueFos
 frp983AVf/TJvTf2DKpoqUi7W53Z4d/PGNkrmr87mTswJGblq3eeLzol0bZV8rBf4UZe
 erRw==
X-Gm-Message-State: AOJu0Yw9//NTy89PeuM+/zc+1bTuOVmoFSYbkGPFmnJOUGgXgEoFUONz
 fIe0w6OQrfNMDD2GoIHoCv2j3i3xBqQK/+7FOhmtVs78OuGrPS3tcF1YL9aQUCcxXCE=
X-Gm-Gg: ASbGncssJ5wHXJLFrsVx4e4cX2KhsbcvCAmfkWJDKJJ13KgyxTUmpPiVLZ8yRkPqbGr
 VD1fumkoGC/K3NggWlb5RxXcc0Q8fSJYR1iFH5IswAMbCJL2VTgphiEwcg26m/CMKEAKiI33466
 3WUms6+E1C6QlGUUux6uHl+KR+pP6Pk/V2jZEL8xNHhWLczb/doTlL06iX7+9JoTCba2RCELjvH
 HfEjYWqtge10zKqQjwWPb1DzcPfvQ8waNd2zgzX6CS9GWkWQdUIqSy3TmkWDuSR1auPuCHUYRQf
 Kn/DbHhJwKOQQYa8wUWw39+keceHjmwrxNBvm+Hqqn76GrzVhLFPzowjEkPi0ZO+iW3DUUUsSrq
 i3Rtgki9/JGOLgXC/QHGkS9v2eTaB5fdcnC5Z4ZWz35PxlGJ1ww3/wBxmTyBhau5txXpD9udg7Q
 hVCQ0vwZCWOjJnEw==
X-Google-Smtp-Source: AGHT+IFgx4CBu/xfSaotDfHsoNW/PZTGhhh2rjr1RWdqoop8rfQotEXy7LNxM43XyBZvCd8aL2vs7g==
X-Received: by 2002:a17:903:2290:b0:246:76ee:535b with SMTP id
 d9443c01a7336-25d2557fbb1mr199599905ad.27.1757974322214; 
 Mon, 15 Sep 2025 15:12:02 -0700 (PDT)
Received: from [192.168.0.102] (200-162-224-93.static-corp.ajato.com.br.
 [200.162.224.93]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-261333a972dsm78979455ad.75.2025.09.15.15.11.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Sep 2025 15:12:01 -0700 (PDT)
Message-ID: <5f65fb4a-c90f-4765-9040-394c65ec2744@linaro.org>
Date: Mon, 15 Sep 2025 19:11:57 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] tests/functional: Adapt reverse_debugging to run
 w/o Avocado
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20250904154640.52687-1-gustavo.romero@linaro.org>
 <aL7CsSppNc-WZFY-@redhat.com>
 <a6320118-84f0-4088-82de-7192be6093cd@linaro.org>
 <aMQzD0m3QluWzlmh@redhat.com> <871pob64iv.fsf@draig.linaro.org>
 <aMRJ6nfXF2l7iu7b@redhat.com>
 <07635935-fc6c-48bf-81b6-bc3709197411@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <07635935-fc6c-48bf-81b6-bc3709197411@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pg1-x530.google.com
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

Hi Thomas and folks,

On 9/15/25 09:49, Thomas Huth wrote:
> On 12/09/2025 18.27, Daniel P. Berrangé wrote:
>> On Fri, Sep 12, 2025 at 05:04:40PM +0100, Alex Bennée wrote:
>>> Daniel P. Berrangé <berrange@redhat.com> writes:
>>>
>>>> On Thu, Sep 11, 2025 at 08:51:08PM -0300, Gustavo Romero wrote:
>>>>> Hi Daniel,
>>>>>
>>>>> Thanks a lot for review and the suggestions.
>>>>>
>>>>> On 9/8/25 08:49, Daniel P. Berrangé wrote:
>>>>>> On Thu, Sep 04, 2025 at 03:46:35PM +0000, Gustavo Romero wrote:
>>>>>>> In this series, we leveraged the run-test.py script used in the
>>>>>>> check-tcg tests, making it a GDB runner capable of calling a test script
>>>>>>> without spawning any VMs. In this configuration, the test scripts can
>>>>>>> manage the VM and also import gdb, making the GDB Python API inside the
>>>>>>> functional test scripts.
>>>>>>>
>>>>>>> A --quiet option has been added to run-test.py so it doesn't print the
>>>>>>> command line used to execute GDB to the stdout. This ensures that users
>>>>>>> don't get confused about how to re-run the tests. One can re-run the
>>>>>>> test simply by copying and pasting the command line shown by Meson when
>>>>>>> V=1 is passed:
>>>>>>>
>>>>>>> $ make -j check-functional V=1
>>>>>>>
>>>>>>> or, alternatively, once the test run completes, the exact command found
>>>>>>> in the 'command:' field of the build/meson-logs/testlog-thorough.txt
>>>>>>> file generated by Meson. Both methods provide the correct environment
>>>>>>> variables required to run the test, such as the proper $PYTHONPATH.
>>>>>>
>>>>>> While I like the conceptual idea of just sending human GDB commands,
>>>>>> instead of working with GDB protocol packets, I really dislike the
>>>>>> effect this has on the execution / startup of the functional tests
>>>>>> via use of the custom runner for a number of reasons
>>>>>>
>>>>>>    * The command line for launching the test outside of meson is very
>>>>>>      complicated, so not memorable
>>>>>
>>>>> Why very complicated? It calls a simple runner instead of calling the
>>>>> test script directly, but it doesn't change the way to re-run a single
>>>>> test. One just have to pass V=1 to see make's command line  and copy
>>>>> and paste the full command line to re-run the test. I mentioned
>>>>> inspecting 'testlog-thorough.txt' just for completeness.
>>>>
>>>> Today we can run the individual tests directly
>>>>
>>>>   # ./tests/functional/x86_64/test_reverse_debug.py
>>>>   TAP version 13
>>>>   ok 1 test_reverse_debug.ReverseDebugging_X86_64.test_x86_64_pc
>>>>   1..1
>>>>
>>>>
>>>> (assuming you have PYTHONPATH and QEMU_TEST_QEMU_BINARY env set)
>>>
>>> and the old version of Avocado...
>>>
>>>> This gives you a very easy way to interact with the test, see
>>>> its progress, understand what failed, and debug it with strace,
>>>> etc.
>>>>
>>>> This change looses all that. It appears I can run it with
>>>>
>>>>    # ./tests/guest-debug/run-test.py --quiet --gdb gdb --test \
>>>>         ./tests/functional/x86_64/test_reverse_debug.py
>>>>
>>> <snip>
>>>>
>>>>
>>>> This undermines the core goals of what we aimed to achieve with
>>>> the new functional test harness.
>>>>
>>>>>
>>>>>>    * It makes the meson.build rules much more complicated
>>>>>
>>>>> Do we want to never augment functional tests' meson.build? Nothing
>>>>> complicated is being added. Basically, just a new variable suffixed with
>>>>> '_with_runner' which holds a tuple (test, runner) that tell the test
>>>>> to be executed, following the same logic we already have for all the other
>>>>> variables that specify the tests per arch/mode/speed.
>>>>>
>>>>> Another option would be to select a runner based on a suffix in the test
>>>>> name, for instance, 'reverse_debug_with_runner.py'.
>>>>
>>>> IMHO the overall concept of using the run-test.py runner for launching
>>>> the tests is flawed and not viable. It adds too much complexity to the
>>>> use of the tests, and harms the output.
>>>
>>>
>>>
>>>>
>>>>>>    * Running standalone there is no TAP output available making the
>>>>>>      test hard to debug on failure or timeout
>>>>>
>>>>> This is because of an unfortunate GDB Python API issue, please see my
>>>>> reply in your comment on patch 5/5. This can be solved but needs more
>>>>> investigation on GDB side.
>>>>>
>>>>>
>>>>>> I understand the need to spawn the test via gdb, in order to be able
>>>>>> to import the 'gdb' python module. Looking at what reverse_debugging.py
>>>>>> does, however, makes me question whether we actually need to directly
>>>>>> use the 'gdb' python module.
>>>>>>
>>>>>> The only APIs we use are 'gdb.execute' and 'gdb.parse_and_eval'.
>>>>>>
>>>>>> The latter is only used once as
>>>>>>
>>>>>>     gdb.parse_and_eval("$pc")
>>>>>>
>>>>>> and I believe that can be changed to
>>>>>>
>>>>>>     gdb.execute("printf \"0x%x\", $pc", to_string=True)
>>>>>>
>>>>>> IOW, all we need is 'gdb.execute("....", to_string=True)'
>>>>>
>>>>> Yes, I do want to directly use the 'gdb' python module directly in the
>>>>> tests. We shouldn't look at a solution only for reverse_debug.py but also
>>>>> think of any future tests that will require the GDB Python API, so I don't
>>>>> want to specialize here and reduce the API to a single method.
>>>>
>>>> If any other tests needing GDB arrive int he future we can consider
>>>> them at that time.
>>>
>>> We already have a whole chunk of gdb tests under check-tcg. Maybe it
>>> would be easier just to re-write the tests to use the check-tcg system
>>> tests rather than jumping through hoops to fit in with the
>>> check-functional requirements.
>>
>> Well if 'easy' is our goal, then we can just copy the gdbmi.py
>> file from avocado into our test suite.
> 
> But maintaining that stuff in the QEMU repository is also kind of ugly.

I totally agree.


> I took another stab at the problem:
> 
>   https://lore.kernel.org/qemu-devel/20250915124207.42053-1-thuth@redhat.com/
> 
> It's basically Gustavo's patches, but I removed all the stuff around tests/guest-debug/run-test.py and the cumbersome code for running a test through gdb via meson.build.
> 
> The test start in normal pycotap mode, then call a new function called reverse_debug() which then takes care of calling gdb with the right arguments (i.e. this logic has been copied from the run-test.py script).
> 
> It seems to work fine with the aarch64 test already, but details and other architectures still need some more love.
> 
> WDYT? Is it worth to pursue that approach?

Thanks Thomas, I prefer your approach. I've reviewed your
series and had some minor comments on it but overall it
looks good! :)


Cheers,
Gustavo

