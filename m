Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C31CCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 14:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8ftG-0006ll-Il; Tue, 14 Oct 2025 10:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v8ftE-0006l8-C8
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 10:20:36 -0400
Received: from mailgate01.uberspace.is ([2001:1a50:11:0:c83f:a8ff:fea6:c8da])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v8ft9-0006YU-4B
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 10:20:35 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id 457B860C0B
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 16:17:19 +0200 (CEST)
Received: (qmail 17755 invoked by uid 990); 14 Oct 2025 14:17:19 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Tue, 14 Oct 2025 16:17:19 +0200
MIME-Version: 1.0
Date: Tue, 14 Oct 2025 14:17:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <0f109e7dc2c365666073ea4a0a766cc9f5c64558@nut.email>
TLS-Required: No
Subject: Re: [PATCH v7 25/25] tests: add test with interrupted memory
 accesses on rv64
To: "=?utf-8?B?QWxleCBCZW5uw6ll?=" <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, "Daniel Henrique Barboza"
 <dbarboza@ventanamicro.com>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Alistair Francis" <alistair.francis@wdc.com>, "Weiwei Li"
 <liwei1518@gmail.com>, "Liu Zhiwei" <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org
In-Reply-To: <87frbllkex.fsf@draig.linaro.org>
References: <cover.1759744337.git.neither@nut.email>
 <729c8db0f4b61033f5a460747ea50fced9dabc1e.1759744337.git.neither@nut.email>
 <87frbllkex.fsf@draig.linaro.org>
X-Rspamd-Bar: -
X-Rspamd-Report: BAYES_HAM(-1.741587) MIME_GOOD(-0.1)
X-Rspamd-Score: -1.841587
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=a9QiFizIzGO8/btMhOZAu5BFFy7jZtVnmMctjKiLLIU=;
 b=Y4RFNMmhuOapY1wcqkqQ1GlMGeVaZSh30nt1rOFqj72vENbFG1VBfrSz73WGs3fJsAdfU7vm2v
 bQFPb+gFFj8H4BtxvOv1gOGyxx1EYme5r2kLqvwGxmfIL/zHaFlSfK+PQzEQ/Glkx+msqgBDK8jH
 J4NOAckZwJ5IHZ+eT59BrjxXDM/pLbP1GfVORvbZv8/qxbiRmQ8KoGsH8SgP3nP8pLIF/uM8jUfl
 V3Jp0Zaw4wEH+QpvHP8u+PsST7UIHX0hqxcZGW6VcIo2wxI9Tt0vOjVkh3LDt1QcMrtUYEZzhKh4
 9LksUG5gvIsGE36+Z5ozRFJNNU/K5wk6F6XZTQ1diEbkiKzDhaxBGKBCEU26WrI+n5TTmzcNgHl+
 lzjhh37vFLls4i7QCURRkrzlMNRAghdHd6WPnPUzVgO3qot10qXhAQjQoO7NgVz9mOqmoWtYnqjZ
 shJ7D7ZPISIFbpFztm2GLBw5iOT2vGGOQhRq0JV+sjv1306Mc1VBAJQqZvQnJb1f2t/GMA0NPPjz
 lVzSOMeMilK6mUFsutkNdfq1AyDKIwWoTM7I7p2Trd3e1bKOVAf2Oce/F5VJl52EIhdDU2kbXAqh
 LghuCarGurUE9UT6nnjRByVaeJQvG10+zlOfV1RrJGdPU6xrih28hYG/Rjz/2fZ+7tSpec3eYUCu
 w=
Received-SPF: pass client-ip=2001:1a50:11:0:c83f:a8ff:fea6:c8da;
 envelope-from=neither@nut.email; helo=mailgate01.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hi Alex,

October 14, 2025 at 2:47 PM, "Alex Benn=C3=A9e" wrote:
> Julian Ganz <neither@nut.email> writes:
>=20
>=20>=20
>=20> This test aims at catching API misbehaviour w.r.t. the interaction
> >  between interrupts and memory accesses, such as the bug fixed in
> >=20
>=20>  27f347e6a1d269c533633c812321cabb249eada8
> >=20
>=20Even better the abbrev with title:
>=20
>=20 27f347e6a1d (accel/tcg: also suppress asynchronous IRQs for cpu_io_r=
ecompile)

Will do.

> > Because the condition for triggering misbehaviour may not be
> >  deterministic and the cross-section between memory accesses and
> >  interrupt handlers may be small, we have to place our trust in large
> >  numbers. Instead of guessing/trying an arbitrary, fixed loop-bound, =
we
> >  decided to loop for a fixed amount of real-time. This avoids the tes=
t
> >  running into a time-out on slower machines while enabling a high num=
ber
> >  of possible interactions on faster machines.
> >=20
>=20>  Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> >  Signed-off-by: Julian Ganz <neither@nut.email>
> >  ---
> >  tests/tcg/riscv64/Makefile.softmmu-target | 6 ++
> >  tests/tcg/riscv64/interruptedmemory.S | 67 +++++++++++++++++++++++
> >  2 files changed, 73 insertions(+)
> >  create mode 100644 tests/tcg/riscv64/interruptedmemory.S
> >=20
>=20>  diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg=
/riscv64/Makefile.softmmu-target
> >  index 1a71a78653..d8f92b8e61 100644
> >  --- a/tests/tcg/riscv64/Makefile.softmmu-target
> >  +++ b/tests/tcg/riscv64/Makefile.softmmu-target
> >  @@ -30,5 +30,11 @@ run-plugin-doubletrap: doubletrap
> >  $(QEMU) -plugin ../plugins/libdiscons.so -d plugin -D $*.pout \
> >  $(QEMU_OPTS)$<)
> >=20=20
>=20>  +EXTRA_RUNS +=3D run-plugin-interruptedmemory
> >  +run-plugin-interruptedmemory: interruptedmemory
> >  + $(call run-test, $<, \
> >  + $(QEMU) -plugin ../plugins/libdiscons.so -d plugin -D $*.pout \
> >  + $(QEMU_OPTS)$<)
> >=20
>=20Something went wrong with substitutions there because I see:
>=20
>=20 timeout -s KILL --foreground 120 /home/alex/lsrc/qemu.git/builds/all=
/qemu-system-riscv64 -plugin ../plugins/libdiscons.so -d plugin -D .pout =
-M virt -display none -semihosting -device loader,file=3Dinterruptedmemor=
y

I fail to see the issue right now. I'll have to dig a bit and compare
this to other tests.

> There doesn't seem to be any output either when I run it manually -
> should we be checking the output and at least confirming we are
> detecting the right sort of events?

The test currently only communicates success and failure via the return
value (via semihosting). I can add additional output. Printing at least
the final result is probably a good idea.

> > +
> >  # We don't currently support the multiarch system tests
> >  undefine MULTIARCH_TESTS
> >  diff --git a/tests/tcg/riscv64/interruptedmemory.S b/tests/tcg/riscv=
64/interruptedmemory.S
> >  new file mode 100644
> >  index 0000000000..a32d672849
> >  --- /dev/null
> >  +++ b/tests/tcg/riscv64/interruptedmemory.S
> >  @@ -0,0 +1,67 @@
> >  + .option norvc
> >  +
> >  + .text
> >  + .global _start
> >  +_start:
> >  + # Set up trap vector
> >  + lla t0, trap
> >  + csrw mtvec, t0
> >  +
> >  + # Set up timer
> >  + lui t1, 0x02004
> >  + sd zero, 0(t1) # MTIMECMP0
> >  +
> >  + # Enable timer interrupts
> >  + li t0, 0x80
> >  + csrrs zero, mie, t0
> >  + csrrsi zero, mstatus, 0x8
> >  +
> >  + # Find out when to stop
> >  + call rtc_get
> >  + li t0, 60
> >  + slli t0, t0, 30 # Approx. 10e9 ns
> >  + add t0, t0, a0
> >=20
>=20The runtime of 60s seems quite long for a tcg test. Can we not show
> stuff happening in a shorter period of time?

I can simply reduce the time, e.g. to 30s. I can also add some output
every X iteratins or every second (with the number of iterations) so we
get an idea how many chances we had to trigger the regression.

Regards,
Julian

