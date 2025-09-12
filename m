Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C611DCA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 16:05:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux6Ga-0005r5-5x; Fri, 12 Sep 2025 12:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ux6GX-0005pw-Ky
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 12:04:49 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ux6GU-0001nW-TM
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 12:04:49 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3e249a4d605so2285980f8f.3
 for <qemu-devel@nongnu.org>; Fri, 12 Sep 2025 09:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757693082; x=1758297882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TYzo0XQTYmovlgKyt9PB4Kp873tXFTSJYw/T9xC7ye4=;
 b=BWRsj3Xx8gQ7xpb2MFOFx+Q07AvBUYpWMaI6Q9SLiJQxyBSJAzMUwcZbZcTTw/05g8
 ATCkOb2lmdQpoViBqOtzHXibp7PWsOUCVrv15bLoh4Gj97BXtxirv+vP2C06EPXcxtnk
 PPlVyC0mfqP8aiWokpQ1Hd3o1Fk/rsFk0HmYycQiVCJRcz3eE9wxjjw/OsGOFYbW0OLq
 06x6SpVM5rEZlM4G09jmpNoUz6wbMNLjA056xD6DJ/qDMuXSpHtbXZKBtlA+/5jdMPgD
 odncU/vnpsa3EJFq5AUPOg0lPyCCkOoSAhCJpyfGinLwLl4XJHe2zcEKgNtae9iZoZf3
 iylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757693082; x=1758297882;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TYzo0XQTYmovlgKyt9PB4Kp873tXFTSJYw/T9xC7ye4=;
 b=O7NmfyhzDeXjPz/pfHdfJ0TU67H+kS5N67mh6SCRC3wV4BO6yqY8dEUxOCO80O2xpm
 tHQXONy4aQRE/+WuAZFuV5vxPOsx1jj25yM3CVw5SFshcXg8CqpognS6MzBtLWqsJu/6
 c3ewf5nahBb7o642JYfh46VqSNBzLXkZNrX9SNbm1ZDatpz0ZRdUtKVPCjNEAr/7uvvy
 Bd6hQP6v5mcMwnHv60b3VaKtWiQqo57zxsjO92Y6uu2ifjSugPBSK6GhRxuRuFlg+fJt
 F/qcEaLR1tXkYyVuCwZvE/++pkdwndgb+I9jfNK3bj7j/vhpcofFqEsh2Yf5ks2M6n3k
 5xbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9jgB+IMWayV4NOdkgP8wchjC99znk3mFEzqnidid7jah3qmJocaPZH0tTARe9/CJh3iqi3lgpx1Gj@nongnu.org
X-Gm-Message-State: AOJu0YxefuOmJJM4eOb+VGYcAyeniIlrYgKYTkydfgnmQKTdSZW5hhXM
 7AyhbFWL1DNfKEZywMEczilfXf7dBVkk9asfAWt/bYE4Oa2zBC4Mb/kbW/Fcw26RBd8=
X-Gm-Gg: ASbGncv2ReeP3lrCQ5l7vdMcMTCCeyErWtvRYjI2WLHDwtZHDOZ3oJYcbAhuDQXpbmN
 qCnxGGBktxLOxu3zfU+vRCPqsJuxNpQ2TqpuGgMWkOr5Z+Z+zycUB+o0BhAPGcpocnPGmHqdXUM
 Y7E08jcuL1yPEnDUeDj2fvYfdFTARNfy1P+2ub0k0HR1N9IoBCxtHOEUgpHv+tiPLThznDkUk1P
 V+MyRJEgbfexBM7eyTe0xtsQOcryseBoVcaQAJGXY2idVhj+S4tuq5m4/dJM3BrqBPjxLm2Hs/r
 a8N5qFayeAtWR8RDoRDUjrUOcy50IjpL/s/9dgbslXf/k84y7w7Ay0GI+8Yxng87PTK+2qu/0xR
 MkbCbbfI+8DK/Jj/0jlYfuzck+LbzEZ81uA==
X-Google-Smtp-Source: AGHT+IFKp67WGqn+OsR3IZldYVwkcJCiHbuevT9dbNpfa/cjUlf/DGxHTXyCCoaSoqcEF0l+V7ejzw==
X-Received: by 2002:a05:6000:2283:b0:3d1:c2cf:da07 with SMTP id
 ffacd0b85a97d-3e765790883mr2883288f8f.4.1757693082109; 
 Fri, 12 Sep 2025 09:04:42 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e016b5c5dsm71146845e9.14.2025.09.12.09.04.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Sep 2025 09:04:41 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 417795F846;
 Fri, 12 Sep 2025 17:04:40 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Gustavo Romero <gustavo.romero@linaro.org>,  qemu-devel@nongnu.org,
 thuth@redhat.com,  qemu-arm@nongnu.org
Subject: Re: [PATCH v2 0/5] tests/functional: Adapt reverse_debugging to run
 w/o Avocado
In-Reply-To: <aMQzD0m3QluWzlmh@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Fri, 12 Sep 2025 15:49:51 +0100")
References: <20250904154640.52687-1-gustavo.romero@linaro.org>
 <aL7CsSppNc-WZFY-@redhat.com>
 <a6320118-84f0-4088-82de-7192be6093cd@linaro.org>
 <aMQzD0m3QluWzlmh@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Fri, 12 Sep 2025 17:04:40 +0100
Message-ID: <871pob64iv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Sep 11, 2025 at 08:51:08PM -0300, Gustavo Romero wrote:
>> Hi Daniel,
>>=20
>> Thanks a lot for review and the suggestions.
>>=20
>> On 9/8/25 08:49, Daniel P. Berrang=C3=A9 wrote:
>> > On Thu, Sep 04, 2025 at 03:46:35PM +0000, Gustavo Romero wrote:
>> > > In this series, we leveraged the run-test.py script used in the
>> > > check-tcg tests, making it a GDB runner capable of calling a test sc=
ript
>> > > without spawning any VMs. In this configuration, the test scripts can
>> > > manage the VM and also import gdb, making the GDB Python API inside =
the
>> > > functional test scripts.
>> > >=20
>> > > A --quiet option has been added to run-test.py so it doesn't print t=
he
>> > > command line used to execute GDB to the stdout. This ensures that us=
ers
>> > > don't get confused about how to re-run the tests. One can re-run the
>> > > test simply by copying and pasting the command line shown by Meson w=
hen
>> > > V=3D1 is passed:
>> > >=20
>> > > $ make -j check-functional V=3D1
>> > >=20
>> > > or, alternatively, once the test run completes, the exact command fo=
und
>> > > in the 'command:' field of the build/meson-logs/testlog-thorough.txt
>> > > file generated by Meson. Both methods provide the correct environment
>> > > variables required to run the test, such as the proper $PYTHONPATH.
>> >=20
>> > While I like the conceptual idea of just sending human GDB commands,
>> > instead of working with GDB protocol packets, I really dislike the
>> > effect this has on the execution / startup of the functional tests
>> > via use of the custom runner for a number of reasons
>> >=20
>> >   * The command line for launching the test outside of meson is very
>> >     complicated, so not memorable
>>=20
>> Why very complicated? It calls a simple runner instead of calling the
>> test script directly, but it doesn't change the way to re-run a single
>> test. One just have to pass V=3D1 to see make's command line  and copy
>> and paste the full command line to re-run the test. I mentioned
>> inspecting 'testlog-thorough.txt' just for completeness.
>
> Today we can run the individual tests directly=20
>
>  # ./tests/functional/x86_64/test_reverse_debug.py
>  TAP version 13
>  ok 1 test_reverse_debug.ReverseDebugging_X86_64.test_x86_64_pc
>  1..1
>
>
> (assuming you have PYTHONPATH and QEMU_TEST_QEMU_BINARY env set)

and the old version of Avocado...

> This gives you a very easy way to interact with the test, see
> its progress, understand what failed, and debug it with strace,
> etc.
>
> This change looses all that. It appears I can run it with
>
>   # ./tests/guest-debug/run-test.py --quiet --gdb gdb --test \
>        ./tests/functional/x86_64/test_reverse_debug.py
>
<snip>
>
>
> This undermines the core goals of what we aimed to achieve with
> the new functional test harness.
>
>>=20
>> >   * It makes the meson.build rules much more complicated
>>=20
>> Do we want to never augment functional tests' meson.build? Nothing
>> complicated is being added. Basically, just a new variable suffixed with
>> '_with_runner' which holds a tuple (test, runner) that tell the test
>> to be executed, following the same logic we already have for all the oth=
er
>> variables that specify the tests per arch/mode/speed.
>>=20
>> Another option would be to select a runner based on a suffix in the test
>> name, for instance, 'reverse_debug_with_runner.py'.
>
> IMHO the overall concept of using the run-test.py runner for launching
> the tests is flawed and not viable. It adds too much complexity to the
> use of the tests, and harms the output.



>
>> >   * Running standalone there is no TAP output available making the
>> >     test hard to debug on failure or timeout
>>=20
>> This is because of an unfortunate GDB Python API issue, please see my
>> reply in your comment on patch 5/5. This can be solved but needs more
>> investigation on GDB side.
>>=20
>>=20
>> > I understand the need to spawn the test via gdb, in order to be able
>> > to import the 'gdb' python module. Looking at what reverse_debugging.py
>> > does, however, makes me question whether we actually need to directly
>> > use the 'gdb' python module.
>> >=20
>> > The only APIs we use are 'gdb.execute' and 'gdb.parse_and_eval'.
>> >=20
>> > The latter is only used once as
>> >=20
>> >    gdb.parse_and_eval("$pc")
>> >=20
>> > and I believe that can be changed to
>> >=20
>> >    gdb.execute("printf \"0x%x\", $pc", to_string=3DTrue)
>> >=20
>> > IOW, all we need is 'gdb.execute("....", to_string=3DTrue)'
>>=20
>> Yes, I do want to directly use the 'gdb' python module directly in the
>> tests. We shouldn't look at a solution only for reverse_debug.py but also
>> think of any future tests that will require the GDB Python API, so I don=
't
>> want to specialize here and reduce the API to a single method.
>
> If any other tests needing GDB arrive int he future we can consider
> them at that time.

We already have a whole chunk of gdb tests under check-tcg. Maybe it
would be easier just to re-write the tests to use the check-tcg system
tests rather than jumping through hoops to fit in with the
check-functional requirements.

The only downside is that we miss out on having async device events as
the check-tcg tests are super simple. But the record/replay tests should
pick up on sync errors so perhaps its orthogonal to defending the
reverse-step/continue functionality?

> I like the idea of the test being able to execute human gdb commands,
> but I don't think the GDB provided 'gdb' module is viable to use
> directly. We need to retain control over how we launch our tests
> without intermediate runners present.
>
>> > With a little extra helper proxy script, we can achieve this without
>> > changing the way scripts are launched.
>> >=20
>> > The script needs to listen on a UNIX socket path. When a client
>> > connects, it should read lines of data from the client and pass
>> > them to 'gdb.execute(..., to_string=3DTrue)' and whatever data
>> > gdb returns should be written back to the client.
>> >=20
>> > A very very crude example with no error handling would be:

My concern is it probably isn't quite that simple - and we have just
invented YAGMI (Yet Another GDB Machine Interface) module. The fact that
we have no widely packaged python gdb interface is probably a testament
to the edge cases that exist.

>> >=20
>> >    #!/usr/bin/python3
>> >=20
>> >    import gdb
>> >    import os
>> >    import socket
>> >=20
>> >    sock =3D os.environ.get("QEMU_PROXY", "/tmp/qemu.gdb.proxy")
>> >=20
>> >    try:
>> >      os.unlink(sock)
>> >    except:
>> >      pass
>> >=20
>> >    with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as s:
>> >      s.bind(sock)
>> >      s.listen()
>> >      conn, addr =3D s.accept()
>> >      fh =3D conn.makefile('rw')
>> >      with conn:
>> >          while True:
>> >              line =3D fh.readline()
>> >              if not line:
>> >                  break
>> >              data =3D gdb.execute(line, to_string=3DTrue)
>> >              fh.write(data)
>> >              fh.flush()
>> >=20
>> >=20
>> > In the functional test suite, we should have a helper file
>> > tests/functional/qemu_test/gdb.py that provides an API for
>> > launching GDB to execute this proxy script, and an API to
>> > execute commands by talking over this UNIX socket path.
>> >=20
>> > With this, we will need no changes in the way we execute the
>> > reverse debugging script from a test runner POV, thus avoiding
>> > all the downsides of use of the run-test.py script. IOW, the
>> > first 4 patches in this series go away completely. Instead we
>> > need a patch to create the proxy script and a patch to create
>> > the helper APIs in tests/functional/qemu_test/gdb.py, whereupon
>> > the last patch can replace
>> >=20
>> > try:
>> >      import gdb
>> > except ModuleNotFoundError:
>> >      from sys import exit
>> >      exit("This script must be launched via tests/guest-debug/run-test=
.py!")
>> >=20
>> > with
>> >=20
>> >    from qemu_test import gdb
>> >=20
>> > and the earlier mentioned replacement of parse_and_eval()
>>=20
>> For the sake of not adding a few lines into meson.build, we are going
>> to design a new ad-hoc API for the functional tests on top of the GDB
>> Python API, which will communicate with the test script via a socket
>> and will _still require a runner anyway_ (just now hidden under a
>> module/API)? This is far more complicated than having a simple runner
>> to call GDB and pass the test script.
>
> This is not exclusively about the meson.build changes. It is about the
> overall execution environment of the tests being *simple* and easy to
> understand. That is the overrriding goal of how we approached design
> of the new functional test harness that made it valuable to spend the
> time to replace avocado. The GDB runner usage undermines the benefits
> we have achieved.
>
>> In fact, I think that if the test script had any clue in its name,
>> like the "_with_runner" suffix I mentioned above, maybe Meson's could
>> take care of calling GDB itself without calling any runner. Would that
>> address your first comment in the bullets (and maybe the second one too,
>> but not sure without trying it) and get this series accepted by you,
>> since the third one, about the exitcode, is related to GDB's odd behavio=
r?
>
> The tests need to be runnable directly as standalone python programs,
> with well formed TAP output.
>
> Given the limitations of GDB, if we want to use its python module, then
> the proxy idea I describe above is the only way forward I see.
>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

