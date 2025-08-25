Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB54CA0EFA
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 17:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqb0v-00051V-4m; Mon, 25 Aug 2025 13:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uqb0t-00051L-6A
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 13:29:48 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uqb0g-0007HM-7b
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 13:29:46 -0400
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-2466443b37fso24908135ad.1
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 10:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756142966; x=1756747766; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oZNgM1armSAFI373VHIOgAPLM43G8zMgj2iz3OVG++Q=;
 b=AH+CVm+WEi/iyUXpUJFVyeItWo4jpXinT0YjyayfTCT3EYFuZj7v95tXSCxO/kib5w
 vNK/CwXMv8jWqqGPE/tZLVaZBLoo4Ezutd4ukXV1Up2KHYXZJAKbqp5eAuiDWgfT66Ga
 oyoudBCgtMFfUYkUMLll+Eh+h4zAfirxhkl6HG3QdT0I/2hNjb9DZISKInRK1lGLSPpS
 AiLt8vLET+W7fHycaNcoqMg0fjUrIcA/Sdt9cRWUNsgItEEfccgV3nSBubdpP8FOd7Ih
 vQQny1Rko3Gop3+FcOUyEFp70V9lOfN4qbv1au478irXC7nvvnZWVtX18BkGlOzhGGcY
 1XAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756142966; x=1756747766;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oZNgM1armSAFI373VHIOgAPLM43G8zMgj2iz3OVG++Q=;
 b=ofIf1dmGy5+EVVBOnuiO3KH01CHqqjc1jnOrtTENG+AdYYyx1NJESjBhM+exWzB0a1
 /EAmvQqlRtBg6u7Vbv754s8C1ysjheoYAiuNo6Q5R95Oe2E8pybvQtFwLsOR3FpySSeD
 DqIATHKWsX+HYsdQQPhtBuhF2bpyiVLd2JFO/QPMR/dwAdZmD+uPszj08v5qQzpRdN0v
 7ISldY8uwRakUKvFLNMlNBhfveFgv7qw9mBDVHRZMwhRcDHK9LfrJlaXjlMh+aIzm5Fq
 UUCc90rWl+yWIACINeQ7t3hI6z66ZL/sZP6oI/ejvwE7wsxl9zA/pXR2S7zY/9CARLJX
 VvXA==
X-Gm-Message-State: AOJu0YxxSzLMZbSxZO1/bY1kKsYX1isB5Jx4WMsQqOigyt9CNX8YxTGx
 CTjTg3YcyaIa6mYBcJ3cuqREYHAjtEPYNxS97jtIX9dbO4Oetwwj1XfXOMgCohCKWxo=
X-Gm-Gg: ASbGnct7egsxQSsJdkR3SVvuKZMkskVPQcJajmotVtTrDLiRL1WocHr/sL75VV8exLI
 Gu0yoMpMQ88viIrnV+q7DAImvjIsPu1s1mE1jjkfkAKzlH8qn3kZH6A8SqSgsB87qWlVYysJh7Y
 qBmw/lyphpg7i5G1GQxAE1d8jDC6OJ4hCVb8QPLdy3YJ/hCkfooEmBguugH3D2CvtUFTYS1r7LJ
 wx2mkQ5dnr1VFD83tK0d523jkG9nDYZUUW7pfmBn118DJdANqx48uxPAb67ijvuesUgrX7yBg9E
 r+gZ1NW5wjUZEv1Bh2FYclxq4z663dynJmtA3Xbl9+IMFAb6Dv7ypWNcEgrayIz7u3VMMp6CRPz
 ZJ+KWGzqOF38pUa+9wkjnF05k102Xkwy2cuegc0XhJSEt
X-Google-Smtp-Source: AGHT+IG9j4zUfNWGO55FG2VkH/mVmqzPrmNb+KvcE+j/0jG3x90h3wlHzq+Atrqouvq75tRtuyy2Cw==
X-Received: by 2002:a17:903:1107:b0:240:2145:e50b with SMTP id
 d9443c01a7336-2462edaca91mr195862425ad.11.1756142965962; 
 Mon, 25 Aug 2025 10:29:25 -0700 (PDT)
Received: from [192.168.0.102] ([187.75.38.174])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3254aa63db2sm7656858a91.23.2025.08.25.10.29.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Aug 2025 10:29:25 -0700 (PDT)
Message-ID: <3ba9ea8d-1590-4f87-8758-1b18bad0d3b8@linaro.org>
Date: Mon, 25 Aug 2025 14:30:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] tests/guest-debug: Make QEMU optional in run-test.py
From: Gustavo Romero <gustavo.romero@linaro.org>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, qemu-arm@nongnu.org,
 1844144@gmail.com
References: <20250819143916.4138035-1-gustavo.romero@linaro.org>
 <20250819143916.4138035-2-gustavo.romero@linaro.org>
 <875xeb2v4w.fsf@draig.linaro.org>
 <afd31a15-d4ed-477d-9f72-9c9a23b64047@linaro.org>
Content-Language: en-US
In-Reply-To: <afd31a15-d4ed-477d-9f72-9c9a23b64047@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x643.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Hi Alex,

On 8/25/25 14:26, Gustavo Romero wrote:
> Hi Alex!
> 
> On 8/25/25 14:01, Alex Bennée wrote:
>> Gustavo Romero <gustavo.romero@linaro.org> writes:
>>
>>> This commit makes QEMU optional in run-test.py, allowing it to be used
>>> as a GDB runner, i.e., to call GDB and pass a test script to it without
>>> launching QEMU. In this configuration, it is the test script’s duty to
>>> configure and run the VMs that GDB connects to.
>>>
>>> The --binary option continues to be required when --qemu is passed.
>>> sys.argv now includes the full path to the test script in addition to
>>> the script’s arguments, which allows unittest introspection to work
>>> properly in case it is used in the test script.
>>>
>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>> ---
>>>   tests/guest-debug/run-test.py | 81 +++++++++++++++++++----------------
>>>   1 file changed, 45 insertions(+), 36 deletions(-)
>>>
>>> diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
>>> index 75e9c92e03..7fa17aedca 100755
>>> --- a/tests/guest-debug/run-test.py
>>> +++ b/tests/guest-debug/run-test.py
>>> @@ -22,10 +22,10 @@
>>>   def get_args():
>>>       parser = argparse.ArgumentParser(description="A gdbstub test runner")
>>>       parser.add_argument("--qemu", help="Qemu binary for test",
>>> -                        required=True)
>>> +                        required=False)
>>>       parser.add_argument("--qargs", help="Qemu arguments for test")
>>>       parser.add_argument("--binary", help="Binary to debug",
>>> -                        required=True)
>>> +                        required=False)
>>
>>      parser.add_argument("--binary", help="Binary to debug",
>>                          required='--qemu' in sys.argv)
>>
>>>       parser.add_argument("--test", help="GDB test script")
>>>       parser.add_argument('test_args', nargs='*',
>>>                           help="Additional args for GDB test script. "
>>> @@ -53,7 +53,7 @@ def log(output, msg):
>>>   if __name__ == '__main__':
>>>       args = get_args()
>>> -    # Search for a gdb we can use
>>> +    # Search for a gdb we can use.
>>>       if not args.gdb:
>>>           args.gdb = shutil.which("gdb-multiarch")
>>>       if not args.gdb:
>>> @@ -73,41 +73,49 @@ def log(output, msg):
>>>       socket_dir = TemporaryDirectory("qemu-gdbstub")
>>>       socket_name = os.path.join(socket_dir.name, "gdbstub.socket")
>>> -    # Launch QEMU with binary
>>> -    if "system" in args.qemu:
>>> -        if args.no_suspend:
>>> -            suspend = ''
>>> -        else:
>>> -            suspend = ' -S'
>>> -        cmd = f'{args.qemu} {args.qargs} {args.binary}' \
>>> -            f'{suspend} -gdb unix:path={socket_name},server=on'
>>> -    else:
>>> -        if args.no_suspend:
>>> -            suspend = ',suspend=n'
>>> -        else:
>>> -            suspend = ''
>>> -        cmd = f'{args.qemu} {args.qargs} -g {socket_name}{suspend}' \
>>> -            f' {args.binary}'
>>> -
>>> -    log(output, "QEMU CMD: %s" % (cmd))
>>> -    inferior = subprocess.Popen(shlex.split(cmd))
>>> +    if args.qemu and not args.binary:
>>> +        print("QEMU needs a binary to run, but no binary provided")
>>> +        exit(-1)
>>
>> then we can avoid this.
> 
> Sure, thanks for the suggestion. I'm fixing it in v2.
> 
> 
>>> -    # Now launch gdb with our test and collect the result
>>> -    gdb_cmd = "%s %s" % (args.gdb, args.binary)
>>> +    if args.qemu:
>>> +        # Launch QEMU with binary.
>>> +        if "system" in args.qemu:
>>> +            if args.no_suspend:
>>> +                suspend = ''
>>> +            else:
>>> +                suspend = ' -S'
>>> +            cmd = f'{args.qemu} {args.qargs} {args.binary}' \
>>> +                f'{suspend} -gdb unix:path={socket_name},server=on'
>>> +        else:
>>> +            if args.no_suspend:
>>> +                suspend = ',suspend=n'
>>> +            else:
>>> +                suspend = ''
>>> +            cmd = f'{args.qemu} {args.qargs} -g {socket_name}{suspend}' \
>>> +                f' {args.binary}'
>>> +
>>> +        log(output, "QEMU CMD: %s" % (cmd))
>>> +        inferior = subprocess.Popen(shlex.split(cmd))
>>> +
>>> +    # Now launch gdb with our test and collect the result.
>>> +    gdb_cmd = args.gdb
>>> +    if args.binary:
>>> +        gdb_cmd += " %s" % (args.binary)
>>>       if args.gdb_args:
>>>           gdb_cmd += " %s" % (args.gdb_args)
>>> -    # run quietly and ignore .gdbinit
>>> +    # Run quietly and ignore .gdbinit.
>>>       gdb_cmd += " -q -n -batch"
>>> -    # disable pagination
>>> +    # Disable pagination.
>>>       gdb_cmd += " -ex 'set pagination off'"
>>> -    # disable prompts in case of crash
>>> +    # Disable prompts in case of crash.
>>>       gdb_cmd += " -ex 'set confirm off'"
>>
>> The re-formatting makes the diffs very noisy. If you want to clean up
>> the captilization of stuff do that in another commit.
> 
> OK.
> 
> 
>>> -    # connect to remote
>>> -    gdb_cmd += " -ex 'target remote %s'" % (socket_name)
>>> -    # finally the test script itself
>>> +    # Connect automatically to remote only if QEMU is launched.
>>> +    if args.qemu:
>>> +        gdb_cmd += " -ex 'target remote %s'" % (socket_name)
>>> +    # Finally the test script itself.
>>>       if args.test:
>>> -        if args.test_args:
>>> -            gdb_cmd += f" -ex \"py sys.argv={args.test_args}\""
>>> +        argv = [args.test] + args.test_args
>>> +        gdb_cmd += f" -ex \"py sys.argv={argv}\""
>>>           gdb_cmd += " -x %s" % (args.test)
>>
>> I can see this echoes from:
>>
>>     env QEMU_TEST_FLAKY_TESTS=1 ./pyvenv/bin/meson test --suite thorough func-aarch64-aarch64_reverse_debug --verbose
>>
>> Shows:
>>
>>    GDB CMD: /usr/bin/gdb-multiarch -q -n -batch -ex 'set pagination off' -ex 'set confirm off' -ex "py sys.argv=['/home/alex/lsrc/qemu.git/tests/functional/test_aarch64_reverse_debug.py']" -x /home/alex/lsrc/qemu.git/tests/functional/test_aarch64_reverse_debug.py
>>
>> But trying to piece that together on my the command line:
>>
>>    env PYTHONPATH=/home/alex/lsrc/qemu.git/python:/home/alex/lsrc/qemu.git/tests/functional /usr/bin/gdb-multiarch -q -n -batch -ex 'set pagination off' -ex 'set confirm off' -ex "py sys.argv=['/home/alex/lsrc/qemu.git/tests/functional/test_aarch64_reverse_debug.py']" -x /home/alex/lsrc/qemu.git/tests/functional/test_aarch64_reverse_debug.py
>> Python Exception <class 'ModuleNotFoundError'>: No module named 'pycotap'
>> Error occurred in Python: No module named 'pycotap'
>>
>> What am I missing?
> 
> meson.build in tests/functional is properly setting PYTHONPATH in the env
> when meson runs this command. libpython called from gdb binary will inspect
> PYTHONPATH later. It's meson that knows where site-packages from the pyvenv
> is located, so that's why meson is setting PYTHONPATH and that's why it works
> when run by meson.
> 
> We should never need to put pieces together to run QEMU tests, I really
> hate it (see my previous reply to Thomas about why using Avocado GDB for
> test like this is not a good idea IMO).

ah, and I can think of some way to avoid having to put command pieces
together to re-run the test after we agree in the other more fundamental
aspects of this series, e.g., ok to kept it in tests/functional, ok to
use GDB Python API, etc.


Cheers,
Gustavo

> That said, try to add the site-packages from your pyvenv set in your
> build dir to PYTHONPATH:
> 
> gromero@gromero0:/mnt/git/qemu_/build$ ls -l ./pyvenv/lib/python3.10/site-packages
> total 16
> drwxrwxr-x  3 gromero gromero 4096 Aug 25 12:47 meson-1.8.1.dist-info
> drwxrwxr-x 17 gromero gromero 4096 Aug 25 12:47 mesonbuild
> drwxrwxr-x  3 gromero gromero 4096 Aug 25 12:47 pycotap
> drwxrwxr-x  2 gromero gromero 4096 Aug 25 12:47 pycotap-1.3.1.dist-info
> 
> This is where the pycotap and other potential modules reside.
> 
> 
> Cheers,
> Gustavo
> 
>>> @@ -129,10 +137,11 @@ def log(output, msg):
>>>           log(output, "GDB crashed? (%d, %d) SKIPPING" % (result, result - 128))
>>>           exit(0)
>>> -    try:
>>> -        inferior.wait(2)
>>> -    except subprocess.TimeoutExpired:
>>> -        log(output, "GDB never connected? Killed guest")
>>> -        inferior.kill()
>>> +    if args.qemu:
>>> +        try:
>>> +            inferior.wait(2)
>>> +        except subprocess.TimeoutExpired:
>>> +            log(output, "GDB never connected? Killed guest")
>>> +            inferior.kill()
>>>       exit(result)
>>
> 


