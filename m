Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7FAEE498D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 10:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soKcd-0008RH-Mr; Wed, 11 Sep 2024 06:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1soKcc-0008Ow-4w
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 06:30:50 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1soKcZ-000332-LN
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 06:30:49 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c26b5f1ea6so8349398a12.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 03:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726050646; x=1726655446; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O6YScidXs4ZruwMChjgg9F5p8Y1MF+KvzXWEwgzH/vs=;
 b=VBtfjQXtep9Qaf56Q6t7Uk9HUUv7J0SnL7L1JXoukpLfVV0wO9js89hZKwvTi9qOQM
 y90H0mROG6cE9JVsCxChoQv0bST5VdYXdmYH2pWddARKOdQzq2SS5ALVmkLjlE0WMWak
 UKixfYpKQjZLkxCULaZtnOZ3bBz6Ta9IXM2tJzM4fKhyOPlOlCkf0VmMET9wi4g2lo1I
 lhr6/fhAvQLjfmsIdxQbslTB2lKoCGIkfEN+HmB80gSbK9y7D0KlW5mRZKdngsw72fTl
 CUSIHK0vfBsOLBhShm1P+9dOrr82qs92vUCJD7TtMeL3oLitlKpkuQ92ImBxbQKbg9XQ
 vZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726050646; x=1726655446;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O6YScidXs4ZruwMChjgg9F5p8Y1MF+KvzXWEwgzH/vs=;
 b=RZFV4cDlWI7CzMAnVYjWaRtJn5L60KkJj8NYEdwORs/OIS7WDfSUHwtr5ZC8c8tKey
 1vk52d/sEnespiP19sGqKpiWo7LRdvzTnGcVqQO4j3mSqZLPs4gByHBaPaAfLOsXgNPT
 feOe5w7DN1a0NwA+83VeE4Ii3sWXHsxb4QcrNxVm8xsAwnXMP5oGz594vxmT2cxm8XEA
 4IW1335A8VM5PbGl/210E1QKua24cnSd6nK7+rfJYXZx2NuJG9YRekeo31UvRqZko+4v
 Vn4np6L7sHb9/jIF+6/MWhVjQoJxrHISZ32K9XCGr2Wy1UfTGTod7IkQzrBbWu0GlfBk
 O2hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDdfd3LQWdUqXedgM3ANdUk8rA+WEyrv27p4hTLIJBaG2Eu7asHASav88mKwhkL8HErCughDMQftZy@nongnu.org
X-Gm-Message-State: AOJu0YxmyD0qt01bGpDy6vrgK0NhpLpW72sNSwlcVDWoZ/u3chh3sEpE
 OOH7+1+qThhW4soMsnUN6iaUQtkwhMXRpFluWOku1bWjsRHzETLGfYJWVrH2YUn+uhDZqiudeQf
 vftfFFk7txwhaHTndFXM1hbUQMxFvkzIovL6iiQ==
X-Google-Smtp-Source: AGHT+IEcrfmZxvsqRntLIJm+VAuLrjSTfSWr/3vmrIDTpPc9Fx/gAG3BdGYNCzsirnhLnnzSWqXT6e0LPDdIFIDWpQc=
X-Received: by 2002:a05:6402:51ca:b0:5c4:1244:6a08 with SMTP id
 4fb4d7f45d1cf-5c412446a85mr267470a12.8.1726050645825; Wed, 11 Sep 2024
 03:30:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240709060448.251881-1-gankulkarni@os.amperecomputing.com>
 <CAFEAcA_7BOXSLXJ=VV0pWDvrN=2dWrM3bRTG+31ivPjeVbWGKQ@mail.gmail.com>
 <0b5764d4-fd63-4779-a22a-8e10ebafbcc7@os.amperecomputing.com>
 <CAFEAcA9oP5HNYK=HFazBU8M9eaGN8sFhAvLFQvcy36Xf+Tm+7A@mail.gmail.com>
 <db36a703-1330-44dc-a80f-57903fbb305f@os.amperecomputing.com>
In-Reply-To: <db36a703-1330-44dc-a80f-57903fbb305f@os.amperecomputing.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Sep 2024 11:30:34 +0100
Message-ID: <CAFEAcA-6z82LPVY-pWSCyvJdPKg5BZK3ZTEywyJzznjTNomPSA@mail.gmail.com>
Subject: Re: [PATCH] arm/kvm: add support for MTE
To: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 darren@os.amperecomputing.com, 
 Gustavo Bueno Romero <gustavo.romero@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Wed, 11 Sept 2024 at 07:50, Ganapatrao Kulkarni
<gankulkarni@os.amperecomputing.com> wrote:
>
>
>
> On 10-09-2024 05:53 pm, Peter Maydell wrote:
> > On Tue, 10 Sept 2024 at 12:57, Ganapatrao Kulkarni
> > <gankulkarni@os.amperecomputing.com> wrote:
> >> On 16-07-2024 09:15 pm, Peter Maydell wrote:
> >>> Since Cornelia first wrote the patch this is based on, we've
> >>> landed gdbstub support for MTE (so gdb can find out which
> >>> addresses in the memory map have tags and read and write
> >>> those tags). So I think the KVM MTE support now also needs to
> >>> handle that. (See aarch64_cpu_register_gdb_commands() in
> >>> target/arm/gdbstub64.c.)
> >>
> >> I looked at this code and it looks like, complete code is under
> >> ifdef CONFIG_USER_ONLY and for kvm(target aarch64-softmmu) this is not
> >> getting enabled. Are you asking to remove these ifdef and make
> >> mte-gdbstub commands available for the KVM mode as well?
> >
> > The system mode support for mte gdbstub is just about
> > to land. The current patchset is this one:
> > https://patchew.org/QEMU/20240906143316.657436-1-gustavo.romero@linaro.=
org/
> >
>
> Thanks.
> I applied these patches to qemu and compiled gdb as said in the
> cover-letter. Below is the log of the run, help me to interpret the logs.

I've cc'd Gustavo since he's the author of the patches.

> [root@sut01sys-r214 mte-qemu]# make -C build -j 32
> run-tcg-tests-aarch64-softmmu
> make: Entering directory '/home/ganapat/upstream/mte-qemu/build'
>    BUILD   aarch64-softmmu guest-tests
>    RUN     aarch64-softmmu guest-tests
>    TEST    mte on aarch64
>    TEST    hello on aarch64
>    TEST    interrupt on aarch64
>    TEST    memory on aarch64
>    TEST    memory-sve on aarch64
>    TEST    hello-with-libbb.so on aarch64
>    TEST    interrupt-with-libbb.so on aarch64
>    TEST    memory-with-libbb.so on aarch64
>    TEST    hello-with-libempty.so on aarch64
>    TEST    interrupt-with-libempty.so on aarch64
>    TEST    memory-with-libempty.so on aarch64
>    TEST    interrupt-with-libinline.so on aarch64
>    TEST    hello-with-libinline.so on aarch64
>    TEST    memory-with-libinline.so on aarch64
>    TEST    hello-with-libinsn.so on aarch64
>    TEST    memory-with-libinsn.so on aarch64
>    TEST    interrupt-with-libinsn.so on aarch64
>    TEST    hello-with-libmem.so on aarch64
>    TEST    interrupt-with-libmem.so on aarch64
>    TEST    hello-with-libsyscall.so on aarch64
>    TEST    memory-with-libmem.so on aarch64
>    TEST    interrupt-with-libsyscall.so on aarch64
>    TEST    softmmu gdbstub support on aarch64
>    TEST    memory-with-libsyscall.so on aarch64
>    TEST    softmmu gdbstub support on aarch64
>    TEST    softmmu gdbstub untimely packets on aarch64
>    TEST    softmmu gdbstub support on aarch64
>    TEST    gdbstub MTE support on aarch64
>    TEST    memory-record on aarch64
> qemu-system-aarch64: -gdb
> unix:path=3D/tmp/tmp80lbp057qemu-gdbstub/gdbstub.socket,server=3Don: info=
:
> QEMU waiting for connection on:
> disconnected:unix:/tmp/tmp80lbp057qemu-gdbstub/gdbstub.socket,server=3Don
> qemu-system-aarch64: -gdb
> unix:path=3D/tmp/tmp8h7kx8kyqemu-gdbstub/gdbstub.socket,server=3Don: info=
:
> QEMU waiting for connection on:
> disconnected:unix:/tmp/tmp8h7kx8kyqemu-gdbstub/gdbstub.socket,server=3Don
> qemu-system-aarch64: -gdb
> unix:path=3D/tmp/tmpo0448vk6qemu-gdbstub/gdbstub.socket,server=3Don: info=
:
> QEMU waiting for connection on:
> disconnected:unix:/tmp/tmpo0448vk6qemu-gdbstub/gdbstub.socket,server=3Don
> qemu-system-aarch64: -gdb
> unix:path=3D/tmp/tmplvwd79e3qemu-gdbstub/gdbstub.socket,server=3Don: info=
:
> QEMU waiting for connection on:
> disconnected:unix:/tmp/tmplvwd79e3qemu-gdbstub/gdbstub.socket,server=3Don
> qemu-system-aarch64: -gdb
> unix:path=3D/tmp/tmpv1t2ffjfqemu-gdbstub/gdbstub.socket,server=3Don: info=
:
> QEMU waiting for connection on:
> disconnected:unix:/tmp/tmpv1t2ffjfqemu-gdbstub/gdbstub.socket,server=3Don
>    TEST    memory-replay on aarch64
> qemu-system-aarch64: QEMU: Terminated via GDBstub
> qemu-system-aarch64: QEMU: Terminated via GDBstub
>    GREP    file untimely-packet.gdb.err
> qemu-system-aarch64: QEMU: Terminated via GDBstub
> qemu-system-aarch64: QEMU: Terminated via GDBstub
> make: Leaving directory '/home/ganapat/upstream/mte-qemu/build'
> [root@sut01sys-r214 mte-qemu]#
>
> Last few lines of untimely-packet.gdb.err below:
>
>   [remote] Packet received:
> 0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000
> [24 bytes omitted]
>    [remote] Sending packet: $qfThreadInfo#bb
>    [remote] Received Ack
>    [remote] Packet received: mp01.01
>    [remote] Sending packet: $qsThreadInfo#c8
>    [remote] Received Ack
>    [remote] Packet received: l
>    [remote] Sending packet: $p56#db
>    [remote] Received Ack
>    [remote] Packet received: 000000000000ffff
>    [remote] packet_ok: Packet p (fetch-register) is supported
>    [remote] Sending packet: $p57#dc
>    [remote] Received Ack
>    [remote] Packet received: 000000000000ffff
>    [remote] Sending packet: $m400027b0,4#8c
>    [remote] Received Ack
>    [remote] Packet received: 80c2ff10
>    [remote] Sending packet: $m400027ac,4#be
>    [remote] Received Ack
>    [remote] Packet received: 1f2003d5
>    [remote] Sending packet: $m400027b0,4#8c
>    [remote] Received Ack
>    [remote] Packet received: 80c2ff10
>    [remote] Sending packet: $qSymbol::#5b
>    [remote] Received Ack
>    [remote] Packet received:
>    [remote] packet_ok: Packet qSymbol (symbol-lookup) is NOT supported
> [remote] start_remote_1: exit
> [remote] Sending packet: $D;1#b0
> [remote] Received Ack
> [remote] Packet received: OK
>
>
> --
> Thanks,
> Ganapat/GK

-- PMM

