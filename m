Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B05CAC58E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 23:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwr4g-0002vf-2X; Thu, 11 Sep 2025 19:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uwr4f-0002sk-47
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 19:51:33 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uwr4S-0004vQ-NG
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 19:51:22 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-24cd340377dso9301215ad.1
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 16:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757634679; x=1758239479; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jzt8fZAiJxy8CMggOsbgEYt3c/CWXdu6thBIfAsi0e4=;
 b=h9Youz0wKxtFVRC1jFtUaZUbSaAnoEFOE4bbyfOtka/csm0tBhqi4T5vSsYVgbqpg6
 jKtMIvMD87sANpTJoEHtYosoG22SuRZTsOFc7fyzA7SmzznUpoDINOAhPcgkTVAITBLd
 4sMqUYxJc/Koo5wgYXNWjzrH8AHMzdsWSZdgFWgWIi13x9+yfsv2lCLV4jLERajspMOs
 JfIct1ljiBFqXtWG6ucotlahECzC+dmOVQnfDOOVF9Lgn25c2ekSwlw6SMwwE7Xf7LND
 hytZxzi7wfeywOz2GdpkDjt1hAdr0t1p4iwy7lSJj93JSmVXQ37lo1p0oltvQ5kd9M7u
 /yCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757634679; x=1758239479;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jzt8fZAiJxy8CMggOsbgEYt3c/CWXdu6thBIfAsi0e4=;
 b=oR7SK7P5o/2h3evChAp4A54n1DTOOLg7FPbXM9SOZgTEQHPAvwhI8Tae2RSNoavTYG
 +y0udMF/CJa81hRLkjaOLfZlJ3xcJNEX9Qfj3H2hPAE7eLuUmmjXA+e6Q2fPchigGvn7
 ffxKWc6VGmFQnjDkOjq+rH4JCCnAFa4YyuTqwvILNAHAfnG6aCku/jMY7jxkv1zm7rJk
 HR61KFa4YGSrZHhk1Rum/7F6EV2z85S9YkAESeXaGzLQqKhGdrorVS9Uj/2s8snfYoM9
 ZxuY60eOumgAPLn8GZ8PCZr5qc+hxww7rqUR6Xx/Q3qhocn6daNxizUZziHOy8MU2KWK
 bPjQ==
X-Gm-Message-State: AOJu0YyUvQrQ8yHhgUV8jV48ohhK76Y4lnerwoP99vs/fhgFMF53hVqX
 wi8kI0m/OafCOJLsPxtJL11j6CZjapcnY96H4r5GhXHQ75ZDj3xaGVF6PiZSrdEc4RM=
X-Gm-Gg: ASbGncuGCPvNmFBNzvzCCO1lxEU+x49QA9+NcNe0ny97QZ9XVSSopAhAynKwe073IOX
 ebXAWtshnqT912DEKn6h8CGf03QoJFIb5g+VRq6R/JFsA3wcleizL4r35Auw3k3Cs0lZGPqLgpB
 ahkOJTHrEiip3BD8mLFUOu8O13bsefBwB78syHZksgxOX4+b6+b9zIJOPdOsQtYYi/NvnTE+SkX
 D31uZMfAWX8n2zNJrnsx8iTHvqGPqPl0f2RkYYsEOxORSBYsZAc2v+dVur3q0xav6wF+Nj2bNxk
 Ponw4kBwtzXnenIz/I6/79zn0uHoVeZH1mugtidSQbKOjH1FbA5QSQn1Lh1GgSWXl1o0SYMqoKr
 2/A11Cl+3lNIQ3KmRGTEgmNaLY+bl6PP+Fw==
X-Google-Smtp-Source: AGHT+IF0BtcBCb7ejbGUs9ksFkJdlfJEfbqYG7evbjKVPIYkpikmTxZ7Q5aL1+AFzMT4vzLDNG//Zw==
X-Received: by 2002:a17:902:ef03:b0:24c:7b94:2f87 with SMTP id
 d9443c01a7336-25d243ef68dmr12815175ad.14.1757634679068; 
 Thu, 11 Sep 2025 16:51:19 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.55.55])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-25c3ae29aefsm29892675ad.118.2025.09.11.16.51.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Sep 2025 16:51:18 -0700 (PDT)
Message-ID: <a6320118-84f0-4088-82de-7192be6093cd@linaro.org>
Date: Thu, 11 Sep 2025 20:51:08 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] tests/functional: Adapt reverse_debugging to run
 w/o Avocado
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 qemu-arm@nongnu.org
References: <20250904154640.52687-1-gustavo.romero@linaro.org>
 <aL7CsSppNc-WZFY-@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <aL7CsSppNc-WZFY-@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62f.google.com
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

Hi Daniel,

Thanks a lot for review and the suggestions.

On 9/8/25 08:49, Daniel P. Berrangé wrote:
> On Thu, Sep 04, 2025 at 03:46:35PM +0000, Gustavo Romero wrote:
>> In this series, we leveraged the run-test.py script used in the
>> check-tcg tests, making it a GDB runner capable of calling a test script
>> without spawning any VMs. In this configuration, the test scripts can
>> manage the VM and also import gdb, making the GDB Python API inside the
>> functional test scripts.
>>
>> A --quiet option has been added to run-test.py so it doesn't print the
>> command line used to execute GDB to the stdout. This ensures that users
>> don't get confused about how to re-run the tests. One can re-run the
>> test simply by copying and pasting the command line shown by Meson when
>> V=1 is passed:
>>
>> $ make -j check-functional V=1
>>
>> or, alternatively, once the test run completes, the exact command found
>> in the 'command:' field of the build/meson-logs/testlog-thorough.txt
>> file generated by Meson. Both methods provide the correct environment
>> variables required to run the test, such as the proper $PYTHONPATH.
> 
> While I like the conceptual idea of just sending human GDB commands,
> instead of working with GDB protocol packets, I really dislike the
> effect this has on the execution / startup of the functional tests
> via use of the custom runner for a number of reasons
> 
>   * The command line for launching the test outside of meson is very
>     complicated, so not memorable

Why very complicated? It calls a simple runner instead of calling the
test script directly, but it doesn't change the way to re-run a single
test. One just have to pass V=1 to see make's command line  and copy
and paste the full command line to re-run the test. I mentioned
inspecting 'testlog-thorough.txt' just for completeness.


>   * It makes the meson.build rules much more complicated

Do we want to never augment functional tests' meson.build? Nothing
complicated is being added. Basically, just a new variable suffixed with
'_with_runner' which holds a tuple (test, runner) that tell the test
to be executed, following the same logic we already have for all the other
variables that specify the tests per arch/mode/speed.

Another option would be to select a runner based on a suffix in the test
name, for instance, 'reverse_debug_with_runner.py'.


>   * Running standalone there is no TAP output available making the
>     test hard to debug on failure or timeout

This is because of an unfortunate GDB Python API issue, please see my
reply in your comment on patch 5/5. This can be solved but needs more
investigation on GDB side.


> I understand the need to spawn the test via gdb, in order to be able
> to import the 'gdb' python module. Looking at what reverse_debugging.py
> does, however, makes me question whether we actually need to directly
> use the 'gdb' python module.
> 
> The only APIs we use are 'gdb.execute' and 'gdb.parse_and_eval'.
> 
> The latter is only used once as
> 
>    gdb.parse_and_eval("$pc")
> 
> and I believe that can be changed to
> 
>    gdb.execute("printf \"0x%x\", $pc", to_string=True)
> 
> IOW, all we need is 'gdb.execute("....", to_string=True)'

Yes, I do want to directly use the 'gdb' python module directly in the
tests. We shouldn't look at a solution only for reverse_debug.py but also
think of any future tests that will require the GDB Python API, so I don't
want to specialize here and reduce the API to a single method.


> With a little extra helper proxy script, we can achieve this without
> changing the way scripts are launched.
> 
> The script needs to listen on a UNIX socket path. When a client
> connects, it should read lines of data from the client and pass
> them to 'gdb.execute(..., to_string=True)' and whatever data
> gdb returns should be written back to the client.
> 
> A very very crude example with no error handling would be:
> 
>    #!/usr/bin/python3
> 
>    import gdb
>    import os
>    import socket
> 
>    sock = os.environ.get("QEMU_PROXY", "/tmp/qemu.gdb.proxy")
> 
>    try:
>      os.unlink(sock)
>    except:
>      pass
> 
>    with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as s:
>      s.bind(sock)
>      s.listen()
>      conn, addr = s.accept()
>      fh = conn.makefile('rw')
>      with conn:
>          while True:
>              line = fh.readline()
>              if not line:
>                  break
>              data = gdb.execute(line, to_string=True)
>              fh.write(data)
>              fh.flush()
> 
> 
> In the functional test suite, we should have a helper file
> tests/functional/qemu_test/gdb.py that provides an API for
> launching GDB to execute this proxy script, and an API to
> execute commands by talking over this UNIX socket path.
> 
> With this, we will need no changes in the way we execute the
> reverse debugging script from a test runner POV, thus avoiding
> all the downsides of use of the run-test.py script. IOW, the
> first 4 patches in this series go away completely. Instead we
> need a patch to create the proxy script and a patch to create
> the helper APIs in tests/functional/qemu_test/gdb.py, whereupon
> the last patch can replace
> 
> try:
>      import gdb
> except ModuleNotFoundError:
>      from sys import exit
>      exit("This script must be launched via tests/guest-debug/run-test.py!")
> 
> with
> 
>    from qemu_test import gdb
> 
> and the earlier mentioned replacement of parse_and_eval()

For the sake of not adding a few lines into meson.build, we are going
to design a new ad-hoc API for the functional tests on top of the GDB
Python API, which will communicate with the test script via a socket
and will _still require a runner anyway_ (just now hidden under a
module/API)? This is far more complicated than having a simple runner
to call GDB and pass the test script.

In fact, I think that if the test script had any clue in its name,
like the "_with_runner" suffix I mentioned above, maybe Meson's could
take care of calling GDB itself without calling any runner. Would that
address your first comment in the bullets (and maybe the second one too,
but not sure without trying it) and get this series accepted by you,
since the third one, about the exitcode, is related to GDB's odd behavior?


Cheers,
Gustavo

