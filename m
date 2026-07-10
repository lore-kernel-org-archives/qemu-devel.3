Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4C8C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 04:40:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi31k-0001zB-Kb; Fri, 10 Jul 2026 00:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wi31c-0001xy-KY
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 00:39:44 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wi31Z-00067z-5R
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 00:39:44 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-69a50b818c8so884363a12.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 21:39:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783658378; cv=none;
 d=google.com; s=arc-20260327;
 b=kv7e8J/7gXY4IYmT1B3v+/BOmuXjuEc1KtQ7HUaKjft/ruHpv93jS+ikT+bJ6lF/s6
 J7K+o8pprUIT/PDFrFC/Zfv4aKJ8Cqx49n3cuF8TFvE2Dnhfiiy4b8bWhrxNRyDOJEJm
 VrwE6W0PIuwxX4gVVasW4ZGtwiTx6qdIgPklxUI9m1O8dne2MR+e/hhVj9E7HnnUpvtS
 UHTGmZBcBFeTyUzUjQRf7zApbZMhmkKtUBcb0hKwb19I8eSr/WMBAD4RoJWC5BDAp0he
 kf02E/68PZyOgbjHhAzUP5J7IxcAetdgAATp9IOQ4+YK+xZ44srWOTlGwnTib2EARkKt
 BXvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=56w1ROGo3BaSolaKRmb5VJ7qKRqPAZAcXntmgsb80Hg=;
 fh=1HLZQT1mzubMo9sVv7zOEPkjZrMS92jTI1eoXjtFar0=;
 b=TCXsZGOyM9IO8IO2/PZ3NVA9zc4DqtaRw9Q3XyvzFx/pExhrSd4W9MMS8E7dSZEb1Q
 LPZkDGLvAElIo+stsB2+WuM+KednCckfS994hK/XDulefsW4FZ9HVw5y5u399CkFVIGI
 /V4LQLX1smilOa3up8RHIA5EdbrmRwXWMX2mrr0hYdlCtQTKJVyK5fIurX1GmUqnN8Va
 FIDpK9kObXN2N7UmmISRobkK2PPt0OHXuIwdmssE7cFFrQrrYepl7hK0I07k88HYNMex
 LvQElbwb76Y9acyNo5mencOaV48hzIsSCkWZeRzJkMmpQgZupz4h0Xd37kFBCMX5v2xp
 A8GQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1783658378; x=1784263178; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=56w1ROGo3BaSolaKRmb5VJ7qKRqPAZAcXntmgsb80Hg=;
 b=VKj4BpTPP9I/AHBr8VrYEfcOILMaM5oFbBHl1eCaMeP2xd5xCYwQIXrw8Et3Q7mCEN
 VHfojm0SiMSsSzP72r0kmpb9YCSnoiahDHmXUn2ToNl3HKswL14td9zq+75a6FqFPd7W
 UPjwrlZWsELmOx3XGxVowwA8rgc11LbLS3BgwgiXhtD+uWX+5gKRpuz/wUku/xsVv7zj
 0ipJeqne4Y8XsUUe7AT0fR2yT39eLilxrzSYGq27nZL+R/B4NW3ZQmI0LYX+0cHcGW0E
 pEXJiXQdvXThaNoSJm71xvyMCab8xfz8xadNyi8k7kcR+FUvFphFatUUFHk1dt71O1K2
 ve/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783658378; x=1784263178;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=56w1ROGo3BaSolaKRmb5VJ7qKRqPAZAcXntmgsb80Hg=;
 b=lra1Efq7/j+Fw5fnri/inVQW6bLRj2hxuDkd0J3GzXQ2vfTZaKG4oLOAAa9fpJjyDn
 2aBaHtBgx367Lu//4TnilScuKMQtDacQ+zik5SWC4tSZSjYXbADnTqsGgOToAMaIUVPz
 FF/OBIKbUvEFuaGSEIGoFVLwKYvX6H2zkRR88IUUnzYh7tgFic+T5FjffdVdPDY25Teg
 z9lZj0hKM1nBLwHUCNWdnuEJz7vWyl3m/t9bqh4i8+I7Wt5Qjumrq9kv/+yX/+4wnh9A
 FHLO8dWHiHWGeBKaV80Sn1FKp6UwN40RBqkfk7pzoy64ImiYOCC4o+mJaffqNM+f8nNU
 RcqQ==
X-Gm-Message-State: AOJu0Yw19gRrfIjUQ06S3UJDnVsX83Ca2o5SPrVvRw/BOQeccgEp2LXg
 cL29D7V/qKf5jGZ/qsKRNCFqMWwU1wcVKhdfAt3CnOtVoP24EYY4avAJBgvHYiKX0MvfL0CQHq3
 wB8No5HfLiD4wbf7W6P5XcwGMBUJEGlc3hwK46+pz/A==
X-Gm-Gg: AfdE7cnaUViaayih3b9+yYqPKGI0nqYykjBL2zSh82+4jlsNC51AnzPM8bZCxfKRqpM
 raQZDPnr9dm1/35rRVBpsCWEPjFTdWHpqAIl/q4Ogd3dlRv/xs1fmgiA8QdCDGoOMhPsZE9hfkb
 BWOFi896qV81YzcaIZOfh70UFMyp4I2N1OY60TvVQKHg7G9k4Uut2pWBsKIPfxx+5LB/Gd0Rixk
 If8UZlhDe9fRa/zz0zYAOhY/LA6xX0d/Ye5K6ECkvGI5ktKcXlsPnlb8OFkfQQOept1wxcL73M=
X-Received: by 2002:a17:907:94c9:b0:c12:abd3:38c3 with SMTP id
 a640c23a62f3a-c15cdec53ecmr426570066b.5.1783658377835; Thu, 09 Jul 2026
 21:39:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260707091039.2574638-1-frank.chang@sifive.com>
 <CAKmqyKNVo-rdOtN0t9XzRB3teF6nNEgh_twkf9s8zX2q0dPU=w@mail.gmail.com>
In-Reply-To: <CAKmqyKNVo-rdOtN0t9XzRB3teF6nNEgh_twkf9s8zX2q0dPU=w@mail.gmail.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Fri, 10 Jul 2026 12:39:26 +0800
X-Gm-Features: AUfX_mzFNorKhiVFUEucspakxUkU6g1vVDbP-CJ0JeCgvy80vIzvmwkJ57Tgdus
Message-ID: <CAE_xrPiD1d8jRfz9fcjZaNGEp1uuDn8PMO-=RzMLipt3CnBGPw@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] target/riscv: Support the true Zicclsm extension
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 "open list:SiFive Machines" <qemu-riscv@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000030b5d06563a543f"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=frank.chang@sifive.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_KAM_HTML_FONT_INVALID=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000030b5d06563a543f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 12:58=E2=80=AFPM Alistair Francis <alistair23@gmail.=
com>
wrote:

> On Tue, Jul 7, 2026 at 7:11=E2=80=AFPM <frank.chang@sifive.com> wrote:
> >
> > From: Frank Chang <frank.chang@sifive.com>
> >
> > Support the true Zicclsm extension so that we can trap misaligned
> accesses
> > when Zicclsm is disabled.
> >
> > To enable/disable Zicclsm, simply set zicclsm=3D[true|false], e.g.:
> >   -cpu rv64,zicclsm=3D[true|false]
> >
> > QEMU will raise a misaligned load/store exception when executing
> misaligned
> > load/store instructions if Zicclsm is disabled.
> >
> > Changelog:
> >   v4:
> >     * Align ROM reset vector data at 8-byte aligned offsets.
> >   v3:
> >     * Enable Zicclsm for the compatible CPUs.
> >     * Rebase to the latest riscv-to-apply.next.
> >   v2:
> >     * Use (size_memop(size) | mo_endian_env(env)) to calculate MemOp.
> >     * Use (log2_esz << MO_ASHIFT) to calculate aligment MemOp for
> >       vector load/store whole register instructions.
> >
> > Frank Chang (6):
> >   target/riscv: Add Zicclsm CPU option
> >   target/riscv: Support raising misaligned exceptions for scalar
> >     loads/stores
> >   target/riscv: Support raising misaligned exceptions for vector
> >     loads/stores
> >   target/riscv: Enable Zicclsm for the compatible CPUs
> >   hw/riscv: sifive_u: Align ROM reset vector data
> >   target/riscv: Update Zicclsm ISA string and expose it as a CPU
> >     property
>
> Hmmm.... Still seeing failures
>
> 556/556 qemu:func-quick+func-riscv64 / func-riscv64-opensbi
>                TIMEOUT         90.02s   killed by signal 15 SIGTERM
> >>>
> LD_LIBRARY_PATH=3D/var/mnt/scratch/alistair/software/qemu/build/contrib/p=
lugins:/var/mnt/scratch/alistair/software/qemu/build/tests/tcg/plugins
> MSAN_OPTIO
> NS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:print_stacktr=
ace=3D1
>
> QEMU_TEST_QEMU_BINARY=3D/var/mnt/scratch/alistair/software/qemu/build/qem=
u-system-riscv
> 64 RUST_BACKTRACE=3D1
> MESON_BUILD_ROOT=3D/var/mnt/scratch/alistair/software/qemu/build
> UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:pr=
int_stac
> ktrace=3D1 ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summ=
ary=3D1
> MESON_TEST_ITERATION=3D1 MALLOC_PERTURB_=3D7
> QEMU_TEST_QEMU_IMG=3D/var/mnt/scratch/alistair
> /software/qemu/build/qemu-img QEMU_TEST_GDB=3D/usr/bin/gdb
>
> PYTHONPATH=3D/var/mnt/scratch/alistair/software/qemu/python:/var/mnt/scra=
tch/alistair/software/qemu/t
> ests/functional
> /var/mnt/scratch/alistair/software/qemu/build/pyvenv/bin/python3
> /var/mnt/scratch/alistair/software/qemu/tests/functional/riscv64/test_ope=
ns
> bi.py
>
>
> Summary of Failures:
>
> 556/556 qemu:func-quick+func-riscv64 / func-riscv64-opensbi
>       TIMEOUT         90.02s   killed by signal 15 SIGTERM
>
>
Hi Alistair,

That's weird.

I ran:
$ meson test -C build qemu:func-riscv64-opensbi -v --print-errorlog

.....

=E2=96=B6 1/1 test_opensbi.RiscvOpenSBI.test_riscv_sifive_u            OK

=E2=96=B6 1/1 test_opensbi.RiscvOpenSBI.test_riscv_spike               OK

=E2=96=B6 1/1 test_opensbi.RiscvOpenSBI.test_riscv_tt_atlantis         OK

=E2=96=B6 1/1 test_opensbi.RiscvOpenSBI.test_riscv_virt                OK

1/1 func-quick+func-riscv64 - qemu:func-riscv64-opensbi        OK
   1.53s   4 subtests passed


Ok:                1
Fail:              0

func-riscv64-opensbi test passed.

However, I did find another issue when I ran:
$ meson test -C build "qemu:*riscv*"

[1/9] Generating qemu-version.h with a custom command (wrapped by meson to
capture output)
 1/39 func-quick+func-riscv64 - qemu:func-riscv64-linters
      SKIP             0.15s   0 subtests passed
 2/39 func-quick+func-riscv64 - qemu:func-riscv64-empty_cpu_model
      OK               0.21s   1 subtests passed
 3/39 func-quick+func-riscv64 - qemu:func-riscv64-version
      OK               0.25s   1 subtests passed
 4/39 func-quick+func-riscv32 - qemu:func-riscv32-linters
      SKIP             0.23s   0 subtests passed
 5/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/machine-none-test
       OK               0.17s   1 subtests passed
 6/39 func-quick+func-riscv64 - qemu:func-riscv64-info_usernet
       OK               0.33s   1 subtests passed
 7/39 func-quick+func-riscv32 - qemu:func-riscv32-empty_cpu_model
      OK               0.29s   1 subtests passed
 8/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/readconfig-test
       OK               0.19s   1 subtests passed
 9/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/cdrom-test
      OK               0.41s   1 subtests passed
10/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/cdrom-test
      OK               0.41s   1 subtests passed
11/39 func-quick+func-riscv32 - qemu:func-riscv32-info_usernet
       OK               0.31s   1 subtests passed
12/39 func-quick+func-riscv32 - qemu:func-riscv32-version
      OK               0.29s   1 subtests passed
13/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/riscv-csr-test
      OK               0.30s   1 subtests passed
14/39 func-quick+func-riscv64 - qemu:func-riscv64-vnc
      SKIP             0.39s   0 subtests passed
15/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/machine-none-test
       OK               0.15s   1 subtests passed
16/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/readconfig-test
       OK               0.13s   1 subtests passed
17/39 func-quick+func-riscv32 - qemu:func-riscv32-vnc
      SKIP             0.40s   0 subtests passed
18/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/qmp-test
      OK               0.54s   4 subtests passed
19/39 func-quick+func-riscv64 - qemu:func-riscv64-migration
      OK               0.80s   3 subtests passed
20/39 func-quick+func-riscv32 - qemu:func-riscv32-migration
      OK               0.77s   3 subtests passed
21/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/qmp-test
      OK               0.52s   4 subtests passed
22/39 func-quick+func-riscv64 - qemu:func-riscv64-opensbi
      OK               0.85s   3 subtests passed
23/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/iommu-riscv-test
      OK               0.76s   4 subtests passed
24/39 func-quick+func-riscv32 - qemu:func-riscv32-opensbi
      OK               0.87s   3 subtests passed
25/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/k230-wdt-test
       OK               1.06s   7 subtests passed
26/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/sifive-e-aon-watchdog-test
      OK               1.29s   10 subtests passed
27/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/qom-test
      OK               2.22s   8 subtests passed
28/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/device-introspect-test
      OK               2.28s   6 subtests passed
29/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/device-introspect-test
      OK               2.58s   6 subtests passed
30/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/test-hmp
      OK               3.26s   8 subtests passed
31/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/netdev-socket
       OK               3.32s   10 subtests passed
32/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/netdev-socket
       OK               3.30s   10 subtests passed
33/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/qom-test
      OK               3.80s   12 subtests passed
34/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/test-hmp
      OK               5.48s   12 subtests passed
35/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/qmp-cmd-test
      OK               8.44s   64 subtests passed
36/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/qmp-cmd-test
      OK               8.43s   64 subtests passed
37/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/bios-tables-test
      ERROR           17.02s   killed by signal 6 SIGABRT
>>> MESON_TEST_ITERATION=3D1
PYTHON=3D/scratch3/yihaoc/sifive/qemu/build/pyvenv/bin/python3
QTEST_QEMU_IMG=3D./qemu-img
ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1
MSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:print=
_stacktrace=3D1
G_TEST_DBUS_DAEMON=3D/scratch3/yihaoc/sifive/qemu/tests/dbus-daemon.sh
QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-daemon/qemu-storage-daemon
UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:prin=
t_stacktrace=3D1
RUST_BACKTRACE=3D1 MALLOC_PERTURB_=3D162
QTEST_QEMU_BINARY=3D./qemu-system-riscv64
/scratch3/yihaoc/sifive/qemu/build/tests/qtest/bios-tables-test --tap -k

38/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/qos-test
      OK              43.47s   191 subtests passed
39/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/qos-test
      OK              43.82s   191 subtests passed

Ok:                34
Fail:              1
Skipped:           4

The failure is because Zicclsm is mandatory in the RVA22U64 profile.
But before this patchset, ZIcclsm was enabled automatically when
has_priv_1_11 was true.
With this patchset, Zicclsm must be explicitly added to the RVA22U64
profile's extension list.

After the fix, running:
$ meson test -C build "qemu:*riscv*"

[1/9] Generating qemu-version.h with a custom command (wrapped by meson to
capture output)
 1/41 func-quick+func-riscv64 - qemu:func-riscv64-linters
      SKIP             0.15s   0 subtests passed
 2/41 func-quick+func-riscv64 - qemu:func-riscv64-empty_cpu_model
      OK               0.19s   1 subtests passed
 3/41 func-quick+func-riscv64 - qemu:func-riscv64-info_usernet
       OK               0.26s   1 subtests passed
 4/41 func-quick+func-riscv32 - qemu:func-riscv32-linters
      SKIP             0.21s   0 subtests passed
 5/41 func-quick+func-riscv32 - qemu:func-riscv32-empty_cpu_model
      OK               0.24s   1 subtests passed
 6/41 func-quick+func-riscv64 - qemu:func-riscv64-version
      OK               0.30s   1 subtests passed
 7/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/cdrom-test
      OK               0.39s   1 subtests passed
 8/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/machine-none-test
       OK               0.17s   1 subtests passed
 9/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/cdrom-test
      OK               0.42s   1 subtests passed
10/41 func-quick+func-riscv32 - qemu:func-riscv32-version
      OK               0.28s   1 subtests passed
11/41 func-quick+func-riscv32 - qemu:func-riscv32-info_usernet
       OK               0.32s   1 subtests passed
12/41 func-quick+func-riscv64 - qemu:func-riscv64-vnc
      SKIP             0.35s   0 subtests passed
13/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/riscv-csr-test
      OK               0.30s   1 subtests passed
14/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/readconfig-test
       OK               0.15s   1 subtests passed
15/41 func-quick+func-riscv32 - qemu:func-riscv32-vnc
      SKIP             0.33s   0 subtests passed
16/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/machine-none-test
       OK               0.14s   1 subtests passed
17/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/readconfig-test
       OK               0.14s   1 subtests passed
18/41 func-quick+func-riscv64 - qemu:func-riscv64-migration
      OK               0.75s   3 subtests passed
19/41 func-quick+func-riscv32 - qemu:func-riscv32-migration
      OK               0.78s   3 subtests passed
20/41 func-quick+func-riscv32 - qemu:func-riscv32-opensbi
      OK               0.84s   3 subtests passed
21/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/iommu-riscv-test
      OK               0.78s   4 subtests passed
22/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/k230-wdt-test
       OK               1.08s   7 subtests passed
23/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/qmp-test
      OK               1.16s   9 subtests passed
24/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/qmp-test
      OK               1.14s   9 subtests passed
25/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/sifive-e-aon-watchdog-test
      OK               1.28s   10 subtests passed
26/41 func-quick+func-riscv64 - qemu:func-riscv64-opensbi
      OK               1.81s   4 subtests passed
27/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/qom-test
      OK               2.06s   8 subtests passed
28/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/device-introspect-test
      OK               2.19s   6 subtests passed
29/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/device-introspect-test
      OK               2.48s   6 subtests passed
30/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/test-hmp
      OK               3.27s   8 subtests passed
31/41 func-quick+func-riscv32 - qemu:func-riscv32-monitor_hotplug
      OK               3.46s   7 subtests passed
32/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/netdev-socket
       OK               3.32s   10 subtests passed
33/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/netdev-socket
       OK               3.31s   10 subtests passed
34/41 func-quick+func-riscv64 - qemu:func-riscv64-monitor_hotplug
      OK               4.00s   7 subtests passed
35/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/qom-test
      OK               4.40s   13 subtests passed
36/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/test-hmp
      OK               6.63s   13 subtests passed
37/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/qmp-cmd-test
      OK               8.45s   64 subtests passed
38/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/qmp-cmd-test
      OK               8.50s   64 subtests passed
39/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/bios-tables-test
      OK              35.13s   3 subtests passed
40/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/qos-test
      OK              46.41s   192 subtests passed
41/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/qos-test
      OK              46.45s   192 subtests passed

Ok:                37
Fail:              0
Skipped:           4

All the tests passed.

I will send out the v5 patchset to fix the issue.

BTW, I noticed you ran more tests than I did.
Could you please share your test command so I can reproduce it on my end?

Regards,
Frank Chang


>
> Alistair
>
> >
> >  hw/riscv/sifive_u.c                     | 11 +++--
> >  target/riscv/cpu.c                      |  9 +++-
> >  target/riscv/cpu_cfg_fields.h.inc       |  2 +
> >  target/riscv/insn_trans/trans_rvi.c.inc |  6 +++
> >  target/riscv/insn_trans/trans_rvv.c.inc | 18 +++++--
> >  target/riscv/vector_helper.c            | 65 +++++++++++++++++++------
> >  6 files changed, 87 insertions(+), 24 deletions(-)
> >
> > --
> > 2.43.0
> >
> >
>

--000000000000030b5d06563a543f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><span style=3D"background-color:transpare=
nt">On Thu, Jul 9, 2026 at 12:58=E2=80=AFPM Alistair Francis &lt;<a href=3D=
"mailto:alistair23@gmail.com">alistair23@gmail.com</a>&gt; wrote:</span></d=
iv><div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">On Tue, Jul 7, 2026 at 7:11=E2=80=AFPM &lt;<a hr=
ef=3D"mailto:frank.chang@sifive.com" target=3D"_blank">frank.chang@sifive.c=
om</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com" target=
=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt;<br>
&gt; Support the true Zicclsm extension so that we can trap misaligned acce=
sses<br>
&gt; when Zicclsm is disabled.<br>
&gt;<br>
&gt; To enable/disable Zicclsm, simply set zicclsm=3D[true|false], e.g.:<br=
>
&gt;=C2=A0 =C2=A0-cpu rv64,zicclsm=3D[true|false]<br>
&gt;<br>
&gt; QEMU will raise a misaligned load/store exception when executing misal=
igned<br>
&gt; load/store instructions if Zicclsm is disabled.<br>
&gt;<br>
&gt; Changelog:<br>
&gt;=C2=A0 =C2=A0v4:<br>
&gt;=C2=A0 =C2=A0 =C2=A0* Align ROM reset vector data at 8-byte aligned off=
sets.<br>
&gt;=C2=A0 =C2=A0v3:<br>
&gt;=C2=A0 =C2=A0 =C2=A0* Enable Zicclsm for the compatible CPUs.<br>
&gt;=C2=A0 =C2=A0 =C2=A0* Rebase to the latest riscv-to-apply.next.<br>
&gt;=C2=A0 =C2=A0v2:<br>
&gt;=C2=A0 =C2=A0 =C2=A0* Use (size_memop(size) | mo_endian_env(env)) to ca=
lculate MemOp.<br>
&gt;=C2=A0 =C2=A0 =C2=A0* Use (log2_esz &lt;&lt; MO_ASHIFT) to calculate al=
igment MemOp for<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0vector load/store whole register instruction=
s.<br>
&gt;<br>
&gt; Frank Chang (6):<br>
&gt;=C2=A0 =C2=A0target/riscv: Add Zicclsm CPU option<br>
&gt;=C2=A0 =C2=A0target/riscv: Support raising misaligned exceptions for sc=
alar<br>
&gt;=C2=A0 =C2=A0 =C2=A0loads/stores<br>
&gt;=C2=A0 =C2=A0target/riscv: Support raising misaligned exceptions for ve=
ctor<br>
&gt;=C2=A0 =C2=A0 =C2=A0loads/stores<br>
&gt;=C2=A0 =C2=A0target/riscv: Enable Zicclsm for the compatible CPUs<br>
&gt;=C2=A0 =C2=A0hw/riscv: sifive_u: Align ROM reset vector data<br>
&gt;=C2=A0 =C2=A0target/riscv: Update Zicclsm ISA string and expose it as a=
 CPU<br>
&gt;=C2=A0 =C2=A0 =C2=A0property<br>
<br>
Hmmm.... Still seeing failures<br>
<br>
556/556 qemu:func-quick+func-riscv64 / func-riscv64-opensbi<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TIMEOUT=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A090.02s=C2=A0 =C2=A0killed by signal 15 SIGTERM<br>
&gt;&gt;&gt; LD_LIBRARY_PATH=3D/var/mnt/scratch/alistair/software/qemu/buil=
d/contrib/plugins:/var/mnt/scratch/alistair/software/qemu/build/tests/tcg/p=
lugins MSAN_OPTIO<br>
NS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:print_stacktrac=
e=3D1<br>
QEMU_TEST_QEMU_BINARY=3D/var/mnt/scratch/alistair/software/qemu/build/qemu-=
system-riscv<br>
64 RUST_BACKTRACE=3D1<br>
MESON_BUILD_ROOT=3D/var/mnt/scratch/alistair/software/qemu/build<br>
UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:prin=
t_stac<br>
ktrace=3D1 ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summar=
y=3D1<br>
MESON_TEST_ITERATION=3D1 MALLOC_PERTURB_=3D7<br>
QEMU_TEST_QEMU_IMG=3D/var/mnt/scratch/alistair<br>
/software/qemu/build/qemu-img QEMU_TEST_GDB=3D/usr/bin/gdb<br>
PYTHONPATH=3D/var/mnt/scratch/alistair/software/qemu/python:/var/mnt/scratc=
h/alistair/software/qemu/t<br>
ests/functional<br>
/var/mnt/scratch/alistair/software/qemu/build/pyvenv/bin/python3<br>
/var/mnt/scratch/alistair/software/qemu/tests/functional/riscv64/test_opens=
<br>
bi.py<br>
<br>
<br>
Summary of Failures:<br>
<br>
556/556 qemu:func-quick+func-riscv64 / func-riscv64-opensbi<br>
=C2=A0 =C2=A0 =C2=A0 TIMEOUT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A090.02s=C2=A0 =
=C2=A0killed by signal 15 SIGTERM<br>
<br></blockquote><div><br></div><div>Hi Alistair,</div><div><br></div><div>=
That&#39;s weird.</div><div><br></div><div>I ran:</div><div><span style=3D"=
background-color:transparent">$ meson test -C build qemu:func-riscv64-opens=
bi -v --print-errorlog</span></div><div><br></div><div>.....</div><div><br>=
</div><div>=E2=96=B6 1/1 test_opensbi.RiscvOpenSBI.test_riscv_sifive_u =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0<br>=E2=96=B6 1/1 test_opensbi.RiscvOpenSBI.test_riscv_spike =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0<br>=E2=96=B6 1/1 test_opensbi.RiscvOpenSBI.test_riscv_tt_atla=
ntis =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0<br>=E2=96=B6 1/1 test_opensbi.RiscvOpenSBI.test_riscv_virt =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0<br>1/1 func-quick+func-riscv64 - qemu:func-riscv64-opensbi =
=C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A01.53s =C2=A0 4 subtests passed<br><br><br>Ok: =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 =C2=A0 <br>Fail: =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00</div><div><br></div></div><div class=3D"gmail_quo=
te gmail_quote_container"><span class=3D"Q6ibn ng" style=3D"border-style:no=
ne;background:none">func-riscv64-opensbi</span> test=C2=A0passed.</div><div=
 class=3D"gmail_quote gmail_quote_container"><br></div><div class=3D"gmail_=
quote gmail_quote_container">However, I did find another issue when I ran:<=
/div><div class=3D"gmail_quote gmail_quote_container">$=C2=A0meson test -C =
build &quot;qemu:*riscv*&quot;</div><div class=3D"gmail_quote gmail_quote_c=
ontainer"><br></div><div class=3D"gmail_quote gmail_quote_container">[1/9] =
Generating qemu-version.h with a custom command (wrapped by meson to captur=
e output)<br>=C2=A01/39 func-quick+func-riscv64 - qemu:func-riscv64-linters=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 SKIP =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.15s =C2=A0 0 su=
btests passed<br>=C2=A02/39 func-quick+func-riscv64 - qemu:func-riscv64-emp=
ty_cpu_model =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.21s =C2=A0 1 subtests passe=
d<br>=C2=A03/39 func-quick+func-riscv64 - qemu:func-riscv64-version =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.25s =C2=A0 1 subt=
ests passed<br>=C2=A04/39 func-quick+func-riscv32 - qemu:func-riscv32-linte=
rs =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 SKIP =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.23s =C2=A0 0=
 subtests passed<br>=C2=A05/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/mac=
hine-none-test =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.17s =C2=A0 1 subte=
sts passed<br>=C2=A06/39 func-quick+func-riscv64 - qemu:func-riscv64-info_u=
sernet =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.33s =C2=A0 1 subte=
sts passed<br>=C2=A07/39 func-quick+func-riscv32 - qemu:func-riscv32-empty_=
cpu_model =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.29s =C2=A0 1 subtests passed<b=
r>=C2=A08/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/readconfig-test =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.19s =C2=A0 1 subtests passed<b=
r>=C2=A09/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/cdrom-test =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 O=
K =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.41s =C2=A0 1 subtests =
passed<br>10/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/cdrom-test =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.41s =C2=A0 1 subt=
ests passed<br>11/39 func-quick+func-riscv32 - qemu:func-riscv32-info_usern=
et =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.31s =C2=A0 1 subtests pa=
ssed<br>12/39 func-quick+func-riscv32 - qemu:func-riscv32-version =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.29s =C2=A0 1 subt=
ests passed<br>13/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/riscv-csr-tes=
t =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.30s =C2=A0 1 subtests pa=
ssed<br>14/39 func-quick+func-riscv64 - qemu:func-riscv64-vnc =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 SKIP =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.39s =C2=A0 0 su=
btests passed<br>15/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/machine-non=
e-test =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.15s =C2=A0 1 subtests passe=
d<br>16/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/readconfig-test =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.13s =C2=A0 1 subtests passed<br>17=
/39 func-quick+func-riscv32 - qemu:func-riscv32-vnc =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 SKIP =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.40s =C2=A0 0 subtests =
passed<br>18/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/qmp-test =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.54s =C2=A0=
 4 subtests passed<br>19/39 func-quick+func-riscv64 - qemu:func-riscv64-mig=
ration =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.80s =C2=A0=
 3 subtests passed<br>20/39 func-quick+func-riscv32 - qemu:func-riscv32-mig=
ration =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.77s =C2=A0=
 3 subtests passed<br>21/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/qmp-te=
st =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.=
52s =C2=A0 4 subtests passed<br>22/39 func-quick+func-riscv64 - qemu:func-r=
iscv64-opensbi =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0.85s =C2=A0 3 subtests passed<br>23/39 qtest+qtest-riscv64 - qemu:qtes=
t-riscv64/iommu-riscv-test =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.76s =
=C2=A0 4 subtests passed<br>24/39 func-quick+func-riscv32 - qemu:func-riscv=
32-opensbi =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.=
87s =C2=A0 3 subtests passed<br>25/39 qtest+qtest-riscv64 - qemu:qtest-risc=
v64/k230-wdt-test =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1.0=
6s =C2=A0 7 subtests passed<br>26/39 qtest+qtest-riscv32 - qemu:qtest-riscv=
32/sifive-e-aon-watchdog-test =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1.29s =C2=A0 10 subtests passed<br>27/39=
 qtest+qtest-riscv32 - qemu:qtest-riscv32/qom-test =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2.22s =C2=A0 8 subtests passe=
d<br>28/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/device-introspect-test =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 2.28s =C2=A0 6 subtests passed<br>29/39 qtest+qtest-ri=
scv64 - qemu:qtest-riscv64/device-introspect-test =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2.58s=
 =C2=A0 6 subtests passed<br>30/39 qtest+qtest-riscv32 - qemu:qtest-riscv32=
/test-hmp =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 3.26s =C2=A0 8 subtests passed<br>31/39 qtest+qtest-riscv64 - qemu:q=
test-riscv64/netdev-socket =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 3.32s =C2=A0 10 subtests passed<br>32/39 qtest+qtest-riscv32 - qemu:=
qtest-riscv32/netdev-socket =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 3.30s =C2=A0 10 subtests passed<br>33/39 qtest+qtest-riscv64 - qemu=
:qtest-riscv64/qom-test =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 3.80s =C2=A0 12 subtests passed<br>34/39 qtest+qtest-r=
iscv64 - qemu:qtest-riscv64/test-hmp =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 5.48s =C2=A0 12 subtests passed<br>35/39 qt=
est+qtest-riscv64 - qemu:qtest-riscv64/qmp-cmd-test =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8.44s =C2=A0 64 subtests passed<br>36/39=
 qtest+qtest-riscv32 - qemu:qtest-riscv32/qmp-cmd-test =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8.43s =C2=A0 64 subtests passed<br>37/39=
 qtest+qtest-riscv64 - qemu:qtest-riscv64/bios-tables-test =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ERROR =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 17.02s =C2=A0 killed by signal 6 SIGABRT<br>&gt;&gt;&gt; MES=
ON_TEST_ITERATION=3D1 PYTHON=3D/scratch3/yihaoc/sifive/qemu/build/pyvenv/bi=
n/python3 QTEST_QEMU_IMG=3D./qemu-img ASAN_OPTIONS=3Dhalt_on_error=3D1:abor=
t_on_error=3D1:print_summary=3D1 MSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_=
error=3D1:print_summary=3D1:print_stacktrace=3D1 G_TEST_DBUS_DAEMON=3D/scra=
tch3/yihaoc/sifive/qemu/tests/dbus-daemon.sh QTEST_QEMU_STORAGE_DAEMON_BINA=
RY=3D./storage-daemon/qemu-storage-daemon UBSAN_OPTIONS=3Dhalt_on_error=3D1=
:abort_on_error=3D1:print_summary=3D1:print_stacktrace=3D1 RUST_BACKTRACE=
=3D1 MALLOC_PERTURB_=3D162 QTEST_QEMU_BINARY=3D./qemu-system-riscv64 /scrat=
ch3/yihaoc/sifive/qemu/build/tests/qtest/bios-tables-test --tap -k<br><br>3=
8/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/qos-test =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A043.47s =C2=A0 191 subtests =
passed<br>39/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/qos-test =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A043.82s =C2=A0=
 191 subtests passed<br><br>Ok: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A034 =C2=A0<br>Fail: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A01 =C2=A0 <br>Skipped: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4=C2=A0=C2=
=A0</div><div class=3D"gmail_quote gmail_quote_container"><br></div><div cl=
ass=3D"gmail_quote gmail_quote_container"><span style=3D"background-color:t=
ransparent">The failure is because=C2=A0</span>Zicclsm is mandatory in the =
RVA22U64<span style=3D"background-color:transparent">=C2=A0profile.</span><=
/div><div class=3D"gmail_quote gmail_quote_container"><span style=3D"backgr=
ound-color:transparent">But before this patchset, ZIcclsm was enabled=C2=A0=
</span><span style=3D"background-color:transparent">automatically when has_=
priv_1_11 was true.</span></div><div class=3D"gmail_quote gmail_quote_conta=
iner"><span style=3D"background-color:transparent">With this patchset, Zicc=
lsm must be=C2=A0</span><span style=3D"background-color:transparent">explic=
itly added to the RVA22U64 profile&#39;s extension list.</span></div><div c=
lass=3D"gmail_quote gmail_quote_container"><br></div><div class=3D"gmail_qu=
ote gmail_quote_container">After the fix, running:</div><div class=3D"gmail=
_quote gmail_quote_container">$=C2=A0meson test -C build &quot;qemu:*riscv*=
&quot;</div><div class=3D"gmail_quote gmail_quote_container"><br></div><div=
 class=3D"gmail_quote gmail_quote_container">[1/9] Generating qemu-version.=
h with a custom command (wrapped by meson to capture output)<br>=C2=A01/41 =
func-quick+func-riscv64 - qemu:func-riscv64-linters =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SKIP =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.15s =C2=A0 0 subtests passed<br>=C2=A0=
2/41 func-quick+func-riscv64 - qemu:func-riscv64-empty_cpu_model =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0.19s =C2=A0 1 subtests passed<br>=C2=A03/41 func-=
quick+func-riscv64 - qemu:func-riscv64-info_usernet =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0.26s =C2=A0 1 subtests passed<br>=C2=A04/41 func-=
quick+func-riscv32 - qemu:func-riscv32-linters =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SKIP =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 0.21s =C2=A0 0 subtests passed<br>=C2=A05/41 fu=
nc-quick+func-riscv32 - qemu:func-riscv32-empty_cpu_model =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 0.24s =C2=A0 1 subtests passed<br>=C2=A06/41 func-quick+f=
unc-riscv64 - qemu:func-riscv64-version =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 0.30s =C2=A0 1 subtests passed<br>=C2=A07/41 qt=
est+qtest-riscv64 - qemu:qtest-riscv64/cdrom-test =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.39s =C2=A0 1 subtests passed<br>=
=C2=A08/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/machine-none-test =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.17s =C2=A0 1 subtests passed<br>=C2=
=A09/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/cdrom-test =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.42s =C2=A0 1 subtests pa=
ssed<br>10/41 func-quick+func-riscv32 - qemu:func-riscv32-version =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.28s =C2=A0 1 subt=
ests passed<br>11/41 func-quick+func-riscv32 - qemu:func-riscv32-info_usern=
et =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.32s =C2=A0 1 subtests pa=
ssed<br>12/41 func-quick+func-riscv64 - qemu:func-riscv64-vnc =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 SKIP =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.35s =C2=A0 0 su=
btests passed<br>13/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/riscv-csr-t=
est =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 O=
K =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.30s =C2=A0 1 subtests =
passed<br>14/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/readconfig-test =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.15s =C2=A0 1 subtests passe=
d<br>15/41 func-quick+func-riscv32 - qemu:func-riscv32-vnc =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 SKIP =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.33s =C2=A0 0 su=
btests passed<br>16/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/machine-non=
e-test =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.14s =C2=A0 1 subtests passe=
d<br>17/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/readconfig-test =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.14s =C2=A0 1 subtests passed<br>18=
/41 func-quick+func-riscv64 - qemu:func-riscv64-migration =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.75s =C2=A0 3 subtests passed<br>19=
/41 func-quick+func-riscv32 - qemu:func-riscv32-migration =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.78s =C2=A0 3 subtests passed<br>20=
/41 func-quick+func-riscv32 - qemu:func-riscv32-opensbi =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.84s =C2=A0 3 subtests passe=
d<br>21/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/iommu-riscv-test =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.78s =C2=A0 4 subtests passed<br>22/41 =
qtest+qtest-riscv64 - qemu:qtest-riscv64/k230-wdt-test =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1.08s =C2=A0 7 subtests passed<br>23/41 =
qtest+qtest-riscv64 - qemu:qtest-riscv64/qmp-test =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1.16s =C2=A0 9 subtests passe=
d<br>24/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/qmp-test =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1.14s =C2=A0 9 subt=
ests passed<br>25/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/sifive-e-aon-=
watchdog-test =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 1.28s =C2=A0 10 subtests passed<br>26/41 func-quick+fu=
nc-riscv64 - qemu:func-riscv64-opensbi =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 1.81s =C2=A0 4 subtests passed<br>27/41 qtest+q=
test-riscv32 - qemu:qtest-riscv32/qom-test =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2.06s =C2=A0 8 subtests passed<br>28=
/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/device-introspect-test =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 2.19s =C2=A0 6 subtests passed<br>29/41 qtest+qtest-riscv64 -=
 qemu:qtest-riscv64/device-introspect-test =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2.48s =C2=A0=
 6 subtests passed<br>30/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/test-h=
mp =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3.=
27s =C2=A0 8 subtests passed<br>31/41 func-quick+func-riscv32 - qemu:func-r=
iscv32-monitor_hotplug =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3.46s =C2=A0 7 subt=
ests passed<br>32/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/netdev-socket=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3.32s =C2=A0 10 subt=
ests passed<br>33/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/netdev-socket=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3.31s =C2=A0 10 subt=
ests passed<br>34/41 func-quick+func-riscv64 - qemu:func-riscv64-monitor_ho=
tplug =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4.00s =C2=A0 7 subtests passed<br>35=
/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/qom-test =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4.40s =C2=A0 13 subtests p=
assed<br>36/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/test-hmp =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6.63s =C2=A0 13 =
subtests passed<br>37/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/qmp-cmd-t=
est =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8.45s =C2=A0 64 =
subtests passed<br>38/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/qmp-cmd-t=
est =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8.50s =C2=A0 64 =
subtests passed<br>39/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/bios-tabl=
es-test =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A035.13s =C2=A0 3 subtests pa=
ssed<br>40/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/qos-test =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A046.41s =C2=A0 192=
 subtests passed<br>41/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/qos-test=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A046.45s=
 =C2=A0 192 subtests passed<br><br>Ok: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A037 =C2=A0<br>Fail: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A00 =C2=A0 <br>Skipped: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4</di=
v><div class=3D"gmail_quote gmail_quote_container"><br></div><div class=3D"=
gmail_quote gmail_quote_container">All the tests=C2=A0passed.</div><div cla=
ss=3D"gmail_quote gmail_quote_container"><br></div><div class=3D"gmail_quot=
e gmail_quote_container">I will send out=C2=A0the v5 patchset to fix the is=
sue.</div><div class=3D"gmail_quote gmail_quote_container"><br></div><div c=
lass=3D"gmail_quote gmail_quote_container">BTW, I noticed you ran more test=
s than I did.</div><div class=3D"gmail_quote gmail_quote_container"><span s=
tyle=3D"background-color:transparent">Could you please share your test comm=
and so I can reproduce <span class=3D"Asgive ng" style=3D"border-style:none=
;background:none">it on my end?</span></span></div><div class=3D"gmail_quot=
e gmail_quote_container"><br></div><div class=3D"gmail_quote gmail_quote_co=
ntainer">Regards,</div><div class=3D"gmail_quote gmail_quote_container">Fra=
nk Chang<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Alistair<br>
<br>
&gt;<br>
&gt;=C2=A0 hw/riscv/sifive_u.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 11 +++--<br>
&gt;=C2=A0 target/riscv/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 9 +++-<br>
&gt;=C2=A0 target/riscv/cpu_cfg_fields.h.inc=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 2 +<br>
&gt;=C2=A0 target/riscv/insn_trans/trans_rvi.c.inc |=C2=A0 6 +++<br>
&gt;=C2=A0 target/riscv/insn_trans/trans_rvv.c.inc | 18 +++++--<br>
&gt;=C2=A0 target/riscv/vector_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 65 +++++++++++++++++++------<br>
&gt;=C2=A0 6 files changed, 87 insertions(+), 24 deletions(-)<br>
&gt;<br>
&gt; --<br>
&gt; 2.43.0<br>
&gt;<br>
&gt;<br>
</blockquote></div></div>

--000000000000030b5d06563a543f--

