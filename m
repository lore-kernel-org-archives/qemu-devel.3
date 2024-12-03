Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA140E74AD6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 21:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIa2N-0003gb-RX; Tue, 03 Dec 2024 16:02:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIa2I-0003fE-Iu
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 16:02:24 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIa2E-0000LM-LP
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 16:02:21 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-724f0f6300aso6725828b3a.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 13:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733259737; x=1733864537; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yOb502jSFdBMyubDWurmBmelXcxiqlYO1XH0RxIyYkY=;
 b=u6H+1JGhR9q21Uw8g88vQeLoo4Jjphhhq6PkaJ3C2QZdkeQ4Rsal4z6pUKElPC+hBd
 XUaivJFPH1yzvCwbQwajl5iODqBNbWLAvbOSURyg6c/+0ZlnotoNnVlmfaloEg6vZMIA
 pCsH5lZCL4HqNz2z2nuH6CDoeFKBNVkWcqZDVWDKHtSTEsCEIZUWHLqqVmShQBzR6kAJ
 zozqNUu4BeWIikpbsa+2nnqZz0X5g66tFfxEufOE5fKrHVAB6ba8o1x0AxZHaAaVdtDA
 rpBepJEY39knXcnkTiNpI+A6U1jmbx5AZVb0HOT+GK6CnUrda5TpXGjlr1Z054I50J+E
 7nPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733259737; x=1733864537;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yOb502jSFdBMyubDWurmBmelXcxiqlYO1XH0RxIyYkY=;
 b=MGuqcdgNPuGqKtvPvG3SeGrfH5EKjXxZQlETde8Qj/0Iy2T7jt2AMZM6jHNAdbdE1N
 wgbzVJIXmLgSWiFpr4lxxTZ9qxPy+8Xw498tY8bG3kBVEp6NtqrE9vn3Gp/skxz1lxiW
 olvYxaBVKOx7tGTMyR3/31M0grDI5si9k3cWN1DwWmFQA9SsxAgPL0quxK2HAVYRG0wi
 7n25D8/o4H7EybPO6axt0LrhZtlpmCXuRMwwAAe2VON5c2VQCyv/4EqRhn1crNyeASFT
 u4ZLNVG+P/WXyDAGZy0rwkr38N8L2a9sB54q5i3LotSBeNI/NCBMvD0CqHc9Z42J1e2E
 KpIA==
X-Gm-Message-State: AOJu0YyGU5WIC5/6OGiuWq6I8/z/P1ZDeWtYEkn89nSFrK73YhwMoUC4
 a31ttMkmjkka+7zNdRrEwn553BPOYy+7eCFSU41WVEh2B+O44zz//qTwUAcXZz8=
X-Gm-Gg: ASbGncv1mYVOWvFpu72lUB6Ro2UMJTHsO4i1HL+9DQEh3ECuTOoORL66nqhqhWfwF0O
 cc9oGfbvIXm7vmWSsBqXVesp50hPVypLjTGh5pWMDMQCjus4+fe965gX8Anx433r6BegJZZw/5P
 um7A8rQiMTf1r/EiirQaA1CPwzUGVKkddARXH9U0eD2oYbzCR3ovEXUETE0YLg776h9FGziUpym
 3vq8NzQI3hTElIRb+JMom8yBud//FcervhiWXZsUSzUR7Xo4sHEUcP+fQ2MxSoA1qKclBJuyi0y
 /qctr0ubsUL2x6nmBkxKyg==
X-Google-Smtp-Source: AGHT+IEd1X8kLlU1Fhg3MMfidtSgrsolG9pBcFyjnSGwLFxeLgXWwM6I5+rJaM1JyOAA7ibgeryKQQ==
X-Received: by 2002:a05:6a00:1793:b0:724:f8fa:402a with SMTP id
 d2e1a72fcca58-7257fcca177mr5975350b3a.24.1733259736780; 
 Tue, 03 Dec 2024 13:02:16 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725417fb7e2sm11255469b3a.120.2024.12.03.13.02.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 13:02:16 -0800 (PST)
Message-ID: <7bd70ef0-7ad0-4c0d-91c0-04c8b4223614@linaro.org>
Date: Tue, 3 Dec 2024 13:02:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] docs: add a codebase section
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 Andrew Melnychenko <andrew@daynix.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Thomas Huth <thuth@redhat.com>,
 alex.bennee@linaro.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-arm@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 manos.pitsidianakis@linaro.org, qemu-block@nongnu.org,
 Michael Roth <michael.roth@amd.com>, Konstantin Kostiuk
 <kkostiuk@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, gustavo.romero@linaro.org
References: <20241118172357.475281-1-pierrick.bouvier@linaro.org>
 <20241118172357.475281-6-pierrick.bouvier@linaro.org>
 <CAFEAcA-UkmPvyNW_6o22-WhaLxnnji55UsBp3UcPA-gYH7kvVg@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA-UkmPvyNW_6o22-WhaLxnnji55UsBp3UcPA-gYH7kvVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

On 12/3/24 07:53, Peter Maydell wrote:
> On Mon, 18 Nov 2024 at 17:24, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> Present the various parts of QEMU and organization of codebase.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> I like this; it's something I've thought for a while would
> be good to have, but which I never got round to trying to
> put together. Thanks for doing this!
> 
> Mostly my comments below are spelling/typo nits and
> other minor stuff.
> 
>> ---
>>   docs/about/emulation.rst               |   2 +
>>   docs/codebase/index.rst                | 211 +++++++++++++++++++++++++
>>   docs/devel/decodetree.rst              |   2 +
>>   docs/devel/ebpf_rss.rst                |   2 +
>>   docs/devel/index-internals.rst         |   2 +
>>   docs/devel/migration/main.rst          |   2 +
>>   docs/devel/qapi-code-gen.rst           |   1 +
>>   docs/devel/testing/main.rst            |   9 +-
>>   docs/devel/testing/qtest.rst           |   2 +
>>   docs/index.rst                         |   3 +
>>   docs/interop/qemu-ga.rst               |   2 +
>>   docs/system/qemu-block-drivers.rst.inc |   2 +
>>   docs/tools/qemu-storage-daemon.rst     |   2 +
>>   docs/user/main.rst                     |   6 +
>>   14 files changed, 247 insertions(+), 1 deletion(-)
>>   create mode 100644 docs/codebase/index.rst
>>
>> diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
>> index 3028d5fff7a..3bc3579434f 100644
>> --- a/docs/about/emulation.rst
>> +++ b/docs/about/emulation.rst
>> @@ -176,6 +176,8 @@ for that architecture.
>>       - System
>>       - Tensilica ISS SIMCALL
>>
>> +.. _tcg-plugins:
>> +
>>   TCG Plugins
>>   -----------
>>
>> diff --git a/docs/codebase/index.rst b/docs/codebase/index.rst
>> new file mode 100644
>> index 00000000000..353830ef175
>> --- /dev/null
>> +++ b/docs/codebase/index.rst
> 
> This is developer documentation, so I think it should
> be in docs/devel/.
> 
>> @@ -0,0 +1,211 @@
>> +========
>> +Codebase
>> +========
>> +
>> +This section present the various parts of QEMU and how codebase is organized.
> 
> "presents"; "how the codebase"
> 
>> +
>> +Beyond giving succint descriptions, the goal is to offer links to various
> 
> "succinct"
> 
>> +parts of the documentation/codebase.
>> +
>> +Subsystems
>> +----------
>> +
>> +An exhaustive list of subsystems and files associated can be found in
> 
> "associated files"
> 
> "the MAINTAINERS file"
> 
>> +`MAINTAINERS <https://gitlab.com/qemu-project/qemu/-/blob/master/MAINTAINERS>`_
>> +file.
>> +
>> +Some of the main QEMU subsystems are:
>> +
>> +- `Accelerators<Accelerators>`
>> +- Block devices and `disk images<disk images>` support
>> +- `CI<ci>` and `Tests<testing>`
>> +- `Devices<device-emulation>` & Board models
>> +- `Documentation <documentation-root>`
>> +- `GDB support<GDB usage>`
>> +- `Migration<migration>`
>> +- `Monitor<QEMU monitor>`
>> +- `QOM (QEMU Object Model)<qom>`
>> +- `System mode<System emulation>`
>> +- `TCG (Tiny Code Generator)<tcg>`
>> +- `User mode<user-mode>` (`Linux<linux-user-mode>` & `BSD<bsd-user-mode>`)
>> +- User Interfaces
>> +
>> +More documentation on QEMU subsystems can be found on :ref:`internal-subsystem`
>> +page.
>> +
>> +The Grand tour
>> +--------------
>> +
>> +We present briefly here what every folder of the codebase contains. Hop on!
> 
> 
> I think it would be helpful to mention at the top of this list something
> like:
> 
>   The folder name links here will take you to that folder in our
>   gitlab repository; other links will take you to more detailed
>   documentation for that subsystem, where we have it. Unfortunately
>   not every subsystem has documentation yet, so sometimes the
>   source code is all you have.
> 
> just so readers know that if e.g. they have a local source tree
> already there's no point in clicking on the 'crypto' link etc,
> but that other links are going to go somewhere with more
> human-written detail.
> 
>> +
>> +* `accel <https://gitlab.com/qemu-project/qemu/-/tree/master/accel>`_:
>> +  Infrastructure and architecture agnostic code related to the various
>> +  `accelerators <Accelerators>` supported by QEMU
>> +  (TCG, KVM, hvf, whpx, xen, nvmm).
>> +  Contains interfaces for operations that will be implemented per
>> +  `target <https://gitlab.com/qemu-project/qemu/-/tree/master/target>`_.
>> +* `audio <https://gitlab.com/qemu-project/qemu/-/tree/master/audio>`_:
>> +  Audio (host) support.
>> +* `authz <https://gitlab.com/qemu-project/qemu/-/tree/master/authz>`_:
>> +  `QEMU Authorization framework<client authorization>`.
>> +* `backends <https://gitlab.com/qemu-project/qemu/-/tree/master/backends>`_:
>> +  Various backends used for device emulation.
>> +* `block <https://gitlab.com/qemu-project/qemu/-/tree/master/block>`_:
>> +  Block devices and `image formats<disk images>` implementation.
>> +* `bsd-user <https://gitlab.com/qemu-project/qemu/-/tree/master/bsd-user>`_:
>> +  `BSD User mode<bsd-user-mode>`.
>> +* build: Where the code built goes!
> 
> The built code doesn't have to be in 'build'. We could say:
> 
>   * build: You can tell the QEMU build system to put the built code
>     anywhere you like. By default it will go into a directory named
>     ``build``. Sometimes documentation will assume this default
>     for convenience when describing command lines; you can always
>     replace it with the path to your build tree.
> 
> ?

I'm ok with the first two sentences but the third one (Sometimes.*) adds 
little value, and much more verbosity.

> 
>> +* `chardev <https://gitlab.com/qemu-project/qemu/-/tree/master/chardev>`_:
>> +  Various backends used by char devices.
>> +* `common-user <https://gitlab.com/qemu-project/qemu/-/tree/master/common-user>`_:
>> +  User-mode assembly code for dealing with signals occuring during syscalls.
>> +* `configs <https://gitlab.com/qemu-project/qemu/-/tree/master/configs>`_:
>> +  Makefiles defining configurations to build QEMU.
>> +* `contrib <https://gitlab.com/qemu-project/qemu/-/tree/master/contrib>`_:
>> +  Community contributed devices/plugins/tools.
>> +* `crypto <https://gitlab.com/qemu-project/qemu/-/tree/master/crypto>`_:
>> +  Cryptographic algorithms used in QEMU.
>> +* `disas <https://gitlab.com/qemu-project/qemu/-/tree/master/disas>`_:
>> +  Disassembly functions used by QEMU target code.
>> +* `docs <https://gitlab.com/qemu-project/qemu/-/tree/master/docs>`_:
>> +  QEMU Documentation.
>> +* `dump <https://gitlab.com/qemu-project/qemu/-/tree/master/dump>`_:
>> +  Code to dump memory of a running VM.
>> +* `ebpf <https://gitlab.com/qemu-project/qemu/-/tree/master/ebpf>`_:
>> +  eBPF program support in QEMU. `virtio-net RSS<ebpf-rss>` uses it.
>> +* `fpu <https://gitlab.com/qemu-project/qemu/-/tree/master/fpu>`_:
>> +  Floating-point software emulation.
>> +* `fsdev <https://gitlab.com/qemu-project/qemu/-/tree/master/fsdev>`_:
>> +  `VirtFS <https://www.linux-kvm.org/page/VirtFS>`_ support.
>> +* `gdbstub <https://gitlab.com/qemu-project/qemu/-/tree/master/gdbstub>`_:
>> +  `GDB <GDB usage>` support.
>> +* `gdb-xml <https://gitlab.com/qemu-project/qemu/-/tree/master/gdb-xml>`_:
>> +  Set of XML files describing architectures and used by `gdbstub <GDB usage>`.
>> +* `host <https://gitlab.com/qemu-project/qemu/-/tree/master/host>`_:
>> +  Various architecture specific header files (crypto, atomic, memory
>> +  operations).
>> +* `linux-headers <https://gitlab.com/qemu-project/qemu/-/tree/master/linux-headers>`_:
>> +  A subset of headers imported from Linux kernel and used for implementing
>> +  KVM support and user-mode.
> 
> We could add here
> 
>   Don't change the files in here by hand; instead you can use the
>   ``scripts/update-linux-headers.sh`` script to update them from a
>   kernel source tree.
> 
> But maybe that's starting to be a bit much info for an entry in this list.
> 

Yes, it's a very specific detail and I doubt someone will try to update 
this after reading this doc page. They can still try and see what 
happens on the mailing list :)

>> +* `linux-user <https://gitlab.com/qemu-project/qemu/-/tree/master/linux-user>`_:
>> +  `User mode <user-mode>` implementation. Contains one folder per target
>> +  architecture.
>> +* `.gitlab-ci.d <https://gitlab.com/qemu-project/qemu/-/tree/master/.gitlab-ci.d>`_:
>> +  `CI <ci>` yaml and scripts.
>> +* `include <https://gitlab.com/qemu-project/qemu/-/tree/master/include>`_:
>> +  All headers associated to different subsystems in QEMU. Hierachy used mirrors
> 
> "The hierarchy"
> 
>> +  source code organization and naming.
>> +* `hw <https://gitlab.com/qemu-project/qemu/-/tree/master/hw>`_:
>> +  `Devices <device-emulation>` and boards emulation. Devices are categorized by
>> +  type/protocol/architecture and located in associated subfolder.
>> +* `io <https://gitlab.com/qemu-project/qemu/-/tree/master/io>`_:
>> +  QEMU `I/O channels <https://lists.gnu.org/archive/html/qemu-devel/2015-11/msg04208.html>`_.
>> +* `libdecnumber <https://gitlab.com/qemu-project/qemu/-/tree/master/libdecnumber>`_:
>> +  Import of gcc library, used to implement decimal number arithmetic.
>> +* `migration <https://gitlab.com/qemu-project/qemu/-/tree/master/migration>`__:
>> +  `Migration framework <migration>`.
>> +* `monitor <https://gitlab.com/qemu-project/qemu/-/tree/master/monitor>`_:
>> +  `Monitor <QEMU monitor>` implementation (HMP & QMP).
>> +* `nbd <https://gitlab.com/qemu-project/qemu/-/tree/master/nbd>`_:
>> +  QEMU `NBD (Network Block Device) <nbd>` server.
>> +* `net <https://gitlab.com/qemu-project/qemu/-/tree/master/net>`_:
>> +  Network (host) support.
>> +* `pc-bios <https://gitlab.com/qemu-project/qemu/-/tree/master/pc-bios>`_:
>> +  Contains pre-built firmware binaries and boot images, ready to use in
>> +  QEMU without compilation.
>> +* `plugins <https://gitlab.com/qemu-project/qemu/-/tree/master/plugins>`_:
>> +  `TCG plugins <tcg-plugins>` core implementation. Plugins can be found in
>> +  `tests <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/tcg/plugins>`__
>> +  and `contrib <https://gitlab.com/qemu-project/qemu/-/tree/master/contrib/plugins>`__
>> +  folders.
>> +* `po <https://gitlab.com/qemu-project/qemu/-/tree/master/po>`_:
>> +  Translation files.
>> +* `python <https://gitlab.com/qemu-project/qemu/-/tree/master/python>`_:
>> +  Python part of our build/test system.
>> +* `qapi <https://gitlab.com/qemu-project/qemu/-/tree/master/qapi>`_:
>> +  `QAPI <qapi>` implementation.
>> +* `qobject <https://gitlab.com/qemu-project/qemu/-/tree/master/qobject>`_:
>> +  QEMU Object implementation.
>> +* `qga <https://gitlab.com/qemu-project/qemu/-/tree/master/qga>`_:
>> +  QEMU `Guest agent <qemu-ga>` implementation.
>> +* `qom <https://gitlab.com/qemu-project/qemu/-/tree/master/qom>`_:
>> +  QEMU `Object model <qom>` implementation, with monitor associated commands.
>> +* `replay <https://gitlab.com/qemu-project/qemu/-/tree/master/replay>`_:
>> +  QEMU `record/replay <replay>` implementation.
>> +* `roms <https://gitlab.com/qemu-project/qemu/-/tree/master/roms>`_:
>> +  Contains source code for various firmware and ROMs, which can be compiled if
>> +  custom or updated versions are needed.
>> +* `rust <https://gitlab.com/qemu-project/qemu/-/tree/master/rust>`_:
>> +  Rust integration in QEMU. It contains the new interfaces defined and
>> +  associated devices using it.
>> +* `scripts <https://gitlab.com/qemu-project/qemu/-/tree/master/scripts>`_:
>> +  Collection of scripts used in build and test systems, and various
>> +  tools for QEMU codebase and execution traces.
>> +* `scsi <https://gitlab.com/qemu-project/qemu/-/tree/master/scsi>`_:
>> +  Code related to SCSI support, used by SCSI devices.
>> +* `semihosting <https://gitlab.com/qemu-project/qemu/-/tree/master/semihosting>`_:
>> +  QEMU `Semihosting <Semihosting>` implementation.
>> +* `stats <https://gitlab.com/qemu-project/qemu/-/tree/master/stats>`_:
>> +  `Monitor <QEMU monitor>` stats commands implementation.
>> +* `storage-daemon <https://gitlab.com/qemu-project/qemu/-/tree/master/storage-daemon>`_:
>> +  QEMU `Storage daemon <storage-daemon>` implementation.
>> +* `stubs <https://gitlab.com/qemu-project/qemu/-/tree/master/stubs>`_:
>> +  Various stubs (empty functions) used to compile QEMU with specific
>> +  configurations.
>> +* `subprojects <https://gitlab.com/qemu-project/qemu/-/tree/master/subprojects>`_:
>> +  QEMU submodules used by QEMU build system.
>> +* `system <https://gitlab.com/qemu-project/qemu/-/tree/master/system>`_:
>> +  QEMU `system mode <System emulation>` implementation (cpu, mmu, boot support).
>> +* `target <https://gitlab.com/qemu-project/qemu/-/tree/master/target>`_:
>> +  Contains code for all target architectures supported (one subfolder
>> +  per arch). For every architecture, you can find accelerator specific
>> +  implementations.
>> +* `tcg <https://gitlab.com/qemu-project/qemu/-/tree/master/tcg>`_:
>> +  `TCG <tcg>` related code.
>> +  Contains one subfolder per host supported architecture.
>> +* `tests <https://gitlab.com/qemu-project/qemu/-/tree/master/tests>`_:
>> +  QEMU `test <testing>` suite
>> +
>> +  - `avocado <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/avocado>`_:
>> +    Functional tests booting full VM using `Avocado framework <checkavocado-ref>`.
>> +    Those tests will be transformed and moved into
>> +    `tests/functional <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/functional>`_
>> +    in the future.
>> +  - `data <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/data>`_:
>> +    Data for various tests.
>> +  - `decode <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/decode>`_:
>> +    Testsuite for `decodetree <decodetree>` implementation.
>> +  - `docker <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/docker>`_:
>> +    Code and scripts to create `containers <container-ref>` used in `CI <ci>`.
>> +  - `fp <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/fp>`_:
>> +    QEMU testsuite for soft float implementation.
>> +  - `functional <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/functional>`_:
>> +    `Functional tests <checkfunctional-ref>` (full VM boot).
>> +  - `lcitool <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/lcitool>`_:
>> +    Generate dockerfiles for CI containers.
>> +  - `migration <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/migration>`_:
>> +    Test scripts and data for `Migration framework <migration>`.
>> +  - `multiboot <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/multiboot>`_:
>> +    Test multiboot functionality for x86_64/i386.
>> +  - `qapi-schema <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/qapi-schema>`_:
>> +    Test scripts and data for `QAPI <qapi-tests>`.
>> +  - `qemu-iotests <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/qemu-iotests>`_:
>> +    `Disk image and block tests <qemu-iotests>`.
>> +  - `qtest <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/qtest>`_:
>> +    `Device emulation testing <qtest>`.
>> +  - `tcg <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/tcg>`__:
>> +    `TCG related tests <checktcg-ref>`. Contains code per architecture
>> +    (subfolder) and multiarch tests as well.
>> +  - `tsan <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/tsan>`_:
>> +    `Suppressions <tsan-suppressions>` for thread sanitizer.
>> +  - `uefi-test-tools <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/uefi-test-tools>`_:
>> +    Test tool for UEFI support.
>> +  - `unit <https://gitlab.com/qemu-project/qemu/-/tree/master/tests/unit>`_:
>> +    QEMU `Unit tests <unit-tests>`.
>> +* `trace <https://gitlab.com/qemu-project/qemu/-/tree/master/trace>`_:
>> +  `Tracing framework <tracing>`. Used to print information associated to various
>> +  events during execution.
>> +* `ui <https://gitlab.com/qemu-project/qemu/-/tree/master/ui>`_:
>> +  QEMU User interfaces.
>> +* `util <https://gitlab.com/qemu-project/qemu/-/tree/master/util>`_:
>> +  Utility code used by other parts of QEMU.
> 
> thanks
> -- PMM

Thanks for all the suggestions, I'll integrate those.

Pierrick

