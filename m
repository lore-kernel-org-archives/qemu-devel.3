Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44970CAC5B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 16:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2At2-0000O6-2A; Fri, 26 Sep 2025 12:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v2Asf-0008Um-HI
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 12:01:10 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v2Art-0004UO-2o
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 12:00:39 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-26c209802c0so25857675ad.0
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 09:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758902414; x=1759507214; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4mtixmopWyKRFf1DMseLcp4UDl+prOas/nWheRX9QxE=;
 b=lmOLMU66d8/0C0047bqNYVTLVi/S3pl7t1dbRBVmKbNfzV5a//hyuO0/W+FSRUSP/V
 QAlSLrHhJTV9OAsW7Bov0FrKpGFvfWi9l0i6QxuMQZzHqLCf5P2qQ6HxzZqyXPrKdfot
 sPxpa0qY+aN4/AnPKSxOLb5QurLVnJEgss6KYtxXHtZZ6VW1si2Zsat1YmY3nf3fbpBX
 /whdUalIDg0jVa9uHeFfV3vxGPhl8MrK6WsvvoQ4DmuDyyOGaq3n80k8fi8vGn2Qyma/
 Rzi8hQbHnOFurNr21ShCtMvESRGWh7PNQre9m01nEkjsztShYtVc5AHVQloDrAG1+aCp
 lPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758902414; x=1759507214;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4mtixmopWyKRFf1DMseLcp4UDl+prOas/nWheRX9QxE=;
 b=NOkOoOLsDw73Nav5H2b4lDqNssOcSUK+n+CdiHj4UUuNaY0P6to8/JIRN6u0doIpQG
 Hp/v4Kgx7RCwp8t1LJOUbJr71fwbT1dNF/BiBCwjQ5KkjSb5BfislC9aMbnHHOVPAeh+
 ivx85ExME44YKab02DfA+VbQVi3M6o6RXeReLZ0l+hCtiURelQxn+3OkBoMF+uuyxUK/
 FtSxwiGk6MmjM8ngrIpRc0GIqO7Re/vfO4poykCX3L7mXIbJUfesg7vOyqgyAXNfPiSZ
 IKypwXk1YEUf5DQUREKTo2Nzz+iSXLleFJY5oX+pouJGUTAFwSferzBhhIf3cqWRyDlV
 X2vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaC/nrg41YndujYM4CLATV575pDst/ZmOgkwwcbsUE179ErpAL8Qw5duiI9WsdxcMjYC8ZYenodGYm@nongnu.org
X-Gm-Message-State: AOJu0YxHO2M5b5hkajy43ONjtfTTcVz3obqoJ15+vfhiy5TLTXnV9NQc
 SHA87anqsfXAep8L1xbrv5wHpUuJss5Qz/jE9EwUi5HCHzPK7WHkp1C9rT8FJ6l7R00=
X-Gm-Gg: ASbGncu7dJzRWlQPyQwo9Vf6w2lapo/sRMuPLhiaA8PXqXB76OXcU0MaE7YhXMmFHZw
 YMf19fbMthTc42kB9cXKZRaS0KJh+x/E6r1qcP9kf3L8nYc1qX5ATEqi08W6bjTtWf3vCSp+FAM
 kRfaYMPAmo+Ld0VBVBaTk8IueqJ7/2zZDk0dvZmOgkEDtTHU73cB9su3xercfmm+ZJRE0y+4ho1
 zZC+QMsz6VMVGlO0y55HatV+KRfNNR50UeodT3i8DQlWpUgE7n+UQBB1GrV+zX/QSssXhwSfs/k
 wlvG2LTKE3vlHXHFlbKxdlHCc8VoF7bSUpnhM0EkkWifHY7gn4Qo3af9+Yrjoe+qGnmvakuXEHZ
 anI8iEkhiUl1iWGXKKiG5lG/Hw35H8kz77oJ/UzD+bc8v6XDzK1YDYw1vvDKVSqJd/Df88chWv7
 M=
X-Google-Smtp-Source: AGHT+IE6HYg5nWIyVd4q6G2kgkOR/Exlh0RSElqgJHubdLhdm5lo8V4bekjX0Rlk5TcfFlMx+dY2/Q==
X-Received: by 2002:a17:902:ebc8:b0:271:6af4:15c with SMTP id
 d9443c01a7336-27ed4a91a97mr98199955ad.36.1758902413831; 
 Fri, 26 Sep 2025 09:00:13 -0700 (PDT)
Received: from [192.168.0.102] (189-47-45-49.dsl.telesp.net.br. [189.47.45.49])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed66d3fe7sm58736935ad.7.2025.09.26.09.00.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Sep 2025 09:00:12 -0700 (PDT)
Message-ID: <4266bc6b-44ad-4318-99ac-71d94d02fae9@linaro.org>
Date: Fri, 26 Sep 2025 13:00:09 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/9] tests/functional: Adapt reverse_debugging to run
 w/o Avocado
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, berrange@redhat.com
Cc: qemu-arm@nongnu.org, manos.pitsidianakis@linaro.org,
 peter.maydell@linaro.org
References: <20250926051542.104432-1-gustavo.romero@linaro.org>
 <20250926051542.104432-9-gustavo.romero@linaro.org>
 <ec28971b-fe8c-4a6a-b241-10ff1468c991@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <ec28971b-fe8c-4a6a-b241-10ff1468c991@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x630.google.com
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

Hi Thomas,

On 9/26/25 05:44, Thomas Huth wrote:
> On 26/09/2025 07.15, Gustavo Romero wrote:
>> This commit removes Avocado as a dependency for running the
>> reverse_debugging test.
>>
>> The main benefit, beyond eliminating an extra dependency, is that there
>> is no longer any need to handle GDB packets manually. This removes the
>> need for ad-hoc functions dealing with endianness and arch-specific
>> register numbers, making the test easier to read. The timeout variable
>> is also removed, since Meson now manages timeouts automatically.
>>
>> reverse_debugging now uses the pygdbmi module to interact with GDB, if
>> it's available in the test environment, otherwise the test is skipped.
>> GDB is detect via the QEMU_TEST_GDB env. variable.
>>
>> This commit also significantly improves the output for the test and
>> now prints all the GDB commands used in sequence. It also adds
>> some clarifications to existing comments, for example, clarifying that
>> once the replay-break is reached, a SIGINT is captured in GDB.
>>
>> reverse_debugging is kept "skipped" for aarch64, ppc64, and x86_64, so
>> won't run unless QEMU_TEST_FLAKY_TESTS=1 is set in the test environment,
>> before running 'make check-functional' or 'meson test [...]'.
>>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> ---
> ...
>> @@ -53,49 +55,11 @@ def run_vm(self, record, shift, args, replay_path, image_path, port):
>>           vm.launch()
>>           return vm
>> -    @staticmethod
>> -    def get_reg_le(g, reg):
>> -        res = g.cmd(b'p%x' % reg)
>> -        num = 0
>> -        for i in range(len(res))[-2::-2]:
>> -            num = 0x100 * num + int(res[i:i + 2], 16)
>> -        return num
>> -
>> -    @staticmethod
>> -    def get_reg_be(g, reg):
>> -        res = g.cmd(b'p%x' % reg)
>> -        return int(res, 16)
>> -
>> -    def get_reg(self, g, reg):
>> -        # value may be encoded in BE or LE order
>> -        if self.endian_is_le:
>> -            return self.get_reg_le(g, reg)
>> -        else:
>> -            return self.get_reg_be(g, reg)
>> -
>> -    def get_pc(self, g):
>> -        return self.get_reg(g, self.REG_PC)
>> -
>> -    def check_pc(self, g, addr):
>> -        pc = self.get_pc(g)
>> -        if pc != addr:
>> -            self.fail('Invalid PC (read %x instead of %x)' % (pc, addr))
> 
> I think it would make sense to keep wrapper functions get_pc() and check_pc(), since that functionality is still used in a bunch of places (e.g. "gdb.cli("print $pc").get_addr()" is used a couple of times).

Yeah, I considered that, but I really think that using the
wrapper functions doesn't add to this test (as in the original test).
First because I like reading the test code and easily map it to
its output and, second, the original test that used check_pc() was
actually failing with this "Invalid PC ... " message in all the cases,
which is not informative. In my version, because I check PC in place,
I also fail with a specific message for each case, like "Forward stepping failed¨,
"Reverse stepping failed", "reverse-continue", etc.

If you don't mind I'd like to keep the test this way.


>> @@ -124,68 +88,99 @@ def reverse_debugging(self, shift=7, args=None):
>>           with Ports() as ports:
>>               port = ports.find_free_port()
>>               vm = self.run_vm(False, shift, args, replay_path, image_path, port)
>> -        logger.info('connecting to gdbstub')
>> -        g = gdb.GDBRemote('127.0.0.1', port, False, False)
>> -        g.connect()
>> -        r = g.cmd(b'qSupported')
>> -        if b'qXfer:features:read+' in r:
>> -            g.cmd(b'qXfer:features:read:target.xml:0,ffb')
>> -        if b'ReverseStep+' not in r:
>> +
>> +        try:
>> +            logger.info('Connecting to gdbstub...')
>> +            self.reverse_debugging_run(vm, port, last_icount)
>> +            logger.info('Test passed.')
>> +        except GdbTimeoutError:
>> +            self.fail("Connection to gdbstub timeouted...")
> 
> I'm not a native English speaker, but I think "timeout" is not a verb. So maybe better: "Timeout while connecting to gdbstub" or something similar?
> 
>> +    @skipIfMissingEnv("QEMU_TEST_GDB")
> 
> Somehow this SKIP is always triggered on my system, even if I correctly pointed "configure" to the right GDB with the "--gdb" option ... not sure why this happens, but I'll try to find out...

hmm maybe you could play with the env. vars by running:

$ ./pyvenv/bin/meson test  --verbose --no-rebuild -t 1 --setup thorough  --suite func-thorough  func-aarch64-reverse_debug

which has "--verbose" so you can see and use the "raw" command containing the env. variables, e.g.:

gromero@gromero0:/mnt/git/qemu_/build$ G_TEST_SLOW=1 QEMU_TEST_QEMU_IMG=/mnt/git/qemu_/build/qemu-img ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 MESON_TEST_ITERATION=1 RUST_BACKTRACE=1 MALLOC_PERTURB_=186 SPEED=thorough LD_LIBRARY_PATH=/mnt/git/qemu_/build/contrib/plugins:/mnt/git/qemu_/build/tests/tcg/plugins MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 QEMU_TEST_QEMU_BINARY=/mnt/git/qemu_/build/qemu-system-aarch64 QEMU_BUILD_ROOT=/mnt/git/qemu_/build UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 PYTHONPATH=/mnt/git/qemu_/python:/mnt/git/qemu_/tests/functional /mnt/git/qemu_/build/pyvenv/bin/python3 /mnt/git/qemu_/tests/functional/aarch64/test_reverse_debug.py
TAP version 13
ok 1 test_reverse_debug.ReverseDebugging_AArch64.test_aarch64_virt # SKIP Missing env var(s): QEMU_TEST_GDB
1..1
gromero@gromero0:/mnt/git/qemu_/build$ echo $QEMU_TEST_GDB

gromero@gromero0:/mnt/git/qemu_/build$ which gdb-multiarch
/usr/bin/gdb-multiarch
gromero@gromero0:/mnt/git/qemu_/build$ export QEMU_TEST_GDB=/usr/bin/gdb-multiarch
gromero@gromero0:/mnt/git/qemu_/build$ G_TEST_SLOW=1 QEMU_TEST_QEMU_IMG=/mnt/git/qemu_/build/qemu-img ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 MESON_TEST_ITERATION=1 RUST_BACKTRACE=1 MALLOC_PERTURB_=186 SPEED=thorough LD_LIBRARY_PATH=/mnt/git/qemu_/build/contrib/plugins:/mnt/git/qemu_/build/tests/tcg/plugins MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 QEMU_TEST_QEMU_BINARY=/mnt/git/qemu_/build/qemu-system-aarch64 QEMU_BUILD_ROOT=/mnt/git/qemu_/build UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 PYTHONPATH=/mnt/git/qemu_/python:/mnt/git/qemu_/tests/functional /mnt/git/qemu_/build/pyvenv/bin/python3 /mnt/git/qemu_/tests/functional/aarch64/test_reverse_debug.py
TAP version 13
# $ set debug remote 1
# $ target remote localhost:64512
# Remote debugging using localhost:64512
# 0x0000000040000000 in ?? ()
# $ set debug remote 0
# $ print $pc
# $1 = (void (*)()) 0x40000000
# $ stepi
# 0x0000000040000004 in ?? ()
# $ print $pc
# $2 = (void (*)()) 0x40000004
# $ stepi
# 0x0000000040000008 in ?? ()
[...]


Let me know what you find :) Thanks!


Cheers,
Gustavo

