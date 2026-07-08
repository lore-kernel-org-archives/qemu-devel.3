Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8C6C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 18:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whXSI-0005Xn-UG; Wed, 08 Jul 2026 14:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1whXSG-0005Wr-MC
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 14:57:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1whXSC-0002oV-OC
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 14:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783537022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jqQ4EwDwHFLu+fXnApgDzpWiE0n6rveTpVrsjJra1Uo=;
 b=CllBcu4LXKBkjKfZIdLIzmd/CMPlYUSo83VvvBNsST9nQgPjmTxbdcZzHNJv+xDHEBGK/p
 DZovhJXur8u41PvT3fw4W+Hb4mUnvcl8OrC1H9292wYJs2UG/3lWqzHwTrnYs7PjgkdbiA
 +5clXULTG+PNkNY1ImGbN8FXt65aUOM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-4fWVRIStM-KpqBPIiz_jjg-1; Wed, 08 Jul 2026 14:57:01 -0400
X-MC-Unique: 4fWVRIStM-KpqBPIiz_jjg-1
X-Mimecast-MFC-AGG-ID: 4fWVRIStM-KpqBPIiz_jjg_1783537020
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-493bb6a4336so9114415e9.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 11:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783537020; x=1784141820; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jqQ4EwDwHFLu+fXnApgDzpWiE0n6rveTpVrsjJra1Uo=;
 b=HdPeTYkX09YHWH5TlnJifU28rqbpEFLwxFkjQI5985jFeR1k9sUBbYHwVtiUPHE5Ia
 NDclia7b3I2PfmDRKxCLk/NfHJfKobtFgoPR2HjxGieNsaNrqxwwPXkTKEhjq+DLJ902
 4Mkp8LErnXdksO/zr1QGZDtXpRfyJ36VXuOk0DDQHfx0ytBNJR1NkodWK8prJpX5l1LQ
 QlMlMleu3eEcNVa0An8zRNXo47AN1Ifh60aYCk7oFKPWcx8lovSTClNSM5QkTFyNRInm
 JVE6NrQhPsbzWrl8IwDxgvn5qHSz6o0k7fxec/JSN2Q+9hxej+4u8+/IQI2H9fS4fXlU
 D4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783537020; x=1784141820;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jqQ4EwDwHFLu+fXnApgDzpWiE0n6rveTpVrsjJra1Uo=;
 b=sGtEoRVpEzR8iq1Zzt8G4WpPp6jQPdek2TEqGRQBzEspE8ASsNddfvI1Ud7+qbNVHy
 yuKfwajbMO3UByAcQwwiwpHTy8VC67d0AA2x4cduN2RNWmIF6DkQvfRSyBJfICFPOtPM
 qYd0lgqpIYdqE0atoJfnNPP8/AFU5dIQJFC/NVcnpGLv8L3D20EkgMFnKgANH54x1kN+
 5SJt8pzRiuAILSoJ3f494ol53Eavv5ywSh13+/OTyeZv8fcvT5fOJ+W9f8XeA8uNqwT2
 8rlLPquL6V0ucoajJI9gGG6WBVWFYO12tfjBFhHe5LzUhYh4OhZYTZXLeChmzoSuNCsZ
 k8aA==
X-Forwarded-Encrypted: i=1;
 AHgh+RroH5YRiQakPlyFJL7fQmqxSoxiKDXAVFH28hn9olTN9MWd+2U1J03ZJkQGxrEWTHNiTboha2RNzAmp@nongnu.org
X-Gm-Message-State: AOJu0YzrvMgwtfQOvKmySBnJm0/NoMoCf0IKxeOvzkS/SEBUsm9avfOb
 75U74nVeBwderJ5Ou06L9OTR0KEpi7gOe1XCIclJo5EffHQZnA4hSo0ZL2wK9Lb2nk6Ad3tLMpN
 aDZfGLNeL0sKhmweBVAaYU7Sd6oUn2m7X1tk+fDR2bwy2qQsHciYDjw33
X-Gm-Gg: AfdE7ck8hrTHycEG90C0C8e1cFreIBGxp/6Owz7PJjmog7hybCbG+MZU1iBFCSHpwzA
 QHj+dCtRGQm+PpZusrYrcMl8ZnxxB8oYmqX3HGdp+d9YJcM5OZ/yZb/kmnzu43rOPe/4zEJB3eJ
 DjlUmtWNcksH44tCno8TPl1HGzvUnxs5GRyfl5OLXRLoDmYGvfBQrAf+j3nwFz3SNKbYA/FIPSe
 XzgdgEWwSx4tjusnTUCz7VKyXyX5izPsRox9Der2HbG7ZRRCZxfAZCKHvWMka2dkbQd7owMMLLk
 7wccO68jD7jqV8q/mIHnxqi+N5QdDbi/g8yddyA9CX2kcAsqZySmVh1VSogPDPd1E/ve+TDrOpe
 JKz/03mbg
X-Received: by 2002:a05:600c:6208:b0:492:3e44:214b with SMTP id
 5b1f17b1804b1-493e6843fb6mr37681015e9.13.1783537019859; 
 Wed, 08 Jul 2026 11:56:59 -0700 (PDT)
X-Received: by 2002:a05:600c:6208:b0:492:3e44:214b with SMTP id
 5b1f17b1804b1-493e6843fb6mr37680585e9.13.1783537019172; 
 Wed, 08 Jul 2026 11:56:59 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.244])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e5a6240fsm57895585e9.2.2026.07.08.11.56.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 11:56:58 -0700 (PDT)
Message-ID: <f9053102-bdcd-4c09-be76-924056407bc3@redhat.com>
Date: Wed, 8 Jul 2026 20:56:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/91] tests/tcg: run tests with meson
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x <qemu-s390x@nongnu.org>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
 <ed40c4a1-3e15-4ca9-8287-602723cbf6a4@linux.ibm.com>
 <5e1aac59-63a8-4e5b-87f8-b9437dc44e61@oss.qualcomm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <5e1aac59-63a8-4e5b-87f8-b9437dc44e61@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 08/07/2026 18.25, Pierrick Bouvier wrote:
> On 7/8/2026 5:09 AM, Ilya Leoshkevich wrote:
>>
>>
>> On 7/7/26 00:32, Pierrick Bouvier wrote:
>>> This series replaces TCG tests makefiles with meson, with the
>>> goal of having something more readable and maintainable in the long term.
>>> Also it closes the gap that tcg tests had with the rest of tests, by
>>> integrating
>>> them with meson directly.
>>>
>>> It covers all existing tests for all architectures, including
>>> user/system/multiarch-user/multiarch-system. It implements all
>>> requirements
>>> listed on original thread [1].
>>>
>>> [1] https://lore.kernel.org/qemu-devel/87wlwfsay4.fsf@draig.linaro.org/
>>>
>>> We also have for free:
>>> - correct and complete dependencies for any test, including:
>>>     scripts, c.inc, headers, reference files and binaries/plugins.
>>> - catch test declaration issues at configure time vs test time.
>>> - proper data types for variables instead of string expansion with make.
>>>
>>> Series first introduce the meson machinery needed in tests/tcg/
>>> meson.build, step
>>> by step. Then it adds support for all existing archs. Finally, we remove
>>> Makefiles and configure bits.
>>>
>>> Usage:
>>>
>>> ```
>>> make check-tcg
>>> make check-tcg-aarch64-linux-user
>>> make check-tcg-aarch64-softmmu
>>>
>>> make tcg-tests
>>>
>>> ninja clean
>>> ./pyvenv/bin/meson test aarch64-softmmu-asid2 --verbose
>>> ```
>>>
>>> A few items were left for further work (out of scope for this series):
>>> - xtensaeb: didn't find how to cross compile for this architecture
>>> with what we
>>>     have now in container debian-xtensa-cross. Tips are welcome.
>>> - tricore: implemented but reverted as all tests seem to hang. To be
>>>     investigated.
>>> - riscv64/interruptedmemory.S is hanging. To be investigated.
>>> - i386/test-i386-fprem.c is deactivated for now. It's broken (output
>>> does not
>>>     match bare metal result) and is the slowest test we have. To be
>>> refactored and
>>>     fixed.
>>>
>>> v3
>>> -- 
>>>
>>> - add all architectures
>>> - reduce number of plugins tests (only add one test for each plugin from
>>>     multiarch pool)
>>> - add depends for executable - allow to depend on a custom target for
>>> generated
>>>     headers (x86_64 mmx, avx)
>>> - add new tests added since last version for aarch64 (mte + gpc)
>>> - refactor series to keep all arch files at end
>>> - add docker host architecture selection
>>>
>>> v2
>>> -- 
>>>
>>> - s/mispell/misspell
>>> - moved comment about why we remove 'lib' prefix for plugins
>>> - if user declare a wrong entry in a dictionary, list possible keys
>>> - build tests by default (with 'all' target), as long as cross
>>> compiler is
>>>     natively installed, to avoid triggering a container build.
>>> - reword some comments based on reviewers feedback
>>> - always declare all tests and avoid "per config" errors (no 'if' in
>>> arch files)
>>> - move compiler feature and gdb version checks directly in tests/tcg/
>>> meson.build
>>> - add support for cross containers
>>> - add top target 'tcg-tests' to rebuild all tests
>>>
>>> Pierrick Bouvier (91):
>>>     tests/tcg/multiarch/system/memory.c: remove unused variable
>>>     tests/tcg/multiarch/plugin/check-plugin-output.sh: take test output as
>>>       input
>>>     tests/tcg/multiarch/plugin: rename check-plugin-output to
>>>       regex-compare
>>>     tests/tcg: introduce meson.build
>>>     tests/tcg/meson.build: introduce exe_name
>>>     tests/tcg/meson.build: introduce test_name
>>>     tests/tcg/meson.build: introduce cflags
>>>     tests/tcg/meson.build: introduce qemu_args
>>>     tests/tcg/meson.build: introduce env_var
>>>     tests/tcg/plugins: build list of test_plugins
>>>     tests/tcg/meson.build: introduce plugin_test
>>>     tests/tcg/meson.build: test gdb support and introduce gdb_arch
>>>     tests/tcg/meson.build: introduce gdb_test
>>>     tests/tcg/meson.build: add default flag for testing compiler support
>>>     tests/tcg/meson.build: introduce wrapper
>>>     tests/tcg/meson.build: introduce expected_output
>>>     tests/tcg/meson.build: add wrapper run_and_check_forbidden_output
>>>     tests/tcg/meson.build: add wrapper run_with_input
>>>     tests/tcg/meson.build: add wrapper record_replay
>>>     tests/tcg/meson.build: add wrapper check_plugin_output
>>>     tests/tcg/meson.build: add logic to skip tests
>>>     tests/tcg/meson.build: introduce cc_feat and cc_feat_cflags
>>>     tests/tcg/meson.build: introduce gdb_feat and gdb_feat_version
>>>     tests/tcg/meson.build: move gdb_arch support check
>>>     tests/tcg/meson.build: let test infrastructure detect compiler
>>>     tests/docker/docker.py: return error code if probe fails
>>>     tests/docker/docker.py: remove "Image is up to date" info
>>>     tests/tcg/meson.build: introduce cc_dockerfile and cc_docker_arch
>>>     tests/tcg/meson.build: introduce depends
>>>     tests/tcg/meson.build: add top-level 'tcg-tests' target
>>>     tests/tcg/multiarch: declare user tests
>>>     tests/tcg/multiarch: declare system tests
>>>     tests/tcg/meson.build: add generic plugin tests
>>>     tests/tcg/aarch64: user tests
>>>     tests/tcg/aarch64/system/gpc-test.c: remove unused variables
>>>     tests/tcg/aarch64: system tests
>>>     tests/tcg/aarch64_be: user tests
>>>     tests/tcg/alpha: add float reference files
>>>     tests/tcg/alpha: user tests
>>>     tests/tcg/alpha: system tests
>>>     tests/tcg/arm: user tests
>>>     tests/tcg/arm: system tests
>>>     tests/tcg/hexagon/overflow.c: add missing include
>>>     tests/tcg/hexagon: user tests
>>>     tests/tcg/multiarch/sha1.c: fix big endian implementation
>>>     tests/tcg/hppa: add float reference files
>>>     tests/tcg/hppa: user tests
>>>     tests/tcg/i386: add missing float reference files
>>>     tests/tcg/i386: user tests
>>>     tests/tcg/i386: system tests
>>>     tests/tcg/loongarch64: user tests
>>>     tests/tcg/loongarch64: system tests
>>>     tests/tcg/m68k: add float reference files
>>>     tests/tcg/m68k: user tests
>>>     scripts/probe-gdb-support.py: add mapping for mips architecture
>>>     tests/tcg/mips: add float reference files
>>>     test/tcg/mips: user tests
>>>     tests/tcg/mips64: add float reference files
>>>     tests/tcg/mips64: user tests
>>>     tests/tcg/mips64el: add float reference files
>>>     tests/tcg/mips64el: user tests
>>>     tests/docker/dockerfiles/debian-all-test-cross.docker: add or1k
>>>       toolchain
>>>     tests/tcg/or1k/test_addic.c: remove unused variables
>>>     tests/tcg/or1k/test_muli.c: remove set but unused variable
>>>     tests/tcg/or1k: add float reference files
>>>     plugins/api.c: identify or1k pc register and mark it as read only
>>>     tests/tcg/or1k: user tests
>>>     tests/tcg/ppc64: add float reference files
>>>     tests/tcg/ppc64: remove dependency on qemu/compiler.h
>>>     tests/tcg/ppc64: user tests
>>>     tests/tcg/ppc64le: add missing float reference file
>>>     tests/tcg/ppc64le: user tests
>>>     tests/tcg/riscv64: add float reference files
>>>     tests/tcg/riscv64: user tests
>>>     tests/tcg/riscv64: system tests
>>>     tests/tcg/s390x/head64.S: declare _exit symbol after main
>>>     tests/tcg/s390x: add float reference files
>>>     tests/tcg/s390x: user tests
>>>     tests/tcg/s390x: system tests
>>>     tests/tcg/sh4: add float reference files
>>>     tests/tcg/sh4: user tests
>>>     tests/tcg/tricore: system tests
>>>     Revert "tests/tcg/tricore: system tests"
>>>     tests/tcg/x86_64: add missing float reference file
>>>     tests/tcg/x86_64: user tests
>>>     tests/tcg/x86_64: system tests
>>>     tests/tcg/xtensa/crt.S: align .text section
>>>     tests/tcg/xtensa: system tests
>>>     tests: remove tcg tests machinery
>>>     tests/tcg: remove Makefiles
>>>     configure: remove --cross-cc* options
>>>
>>>    configure                                     | 473 ---------
>>>    docs/devel/testing/main.rst                   |  22 +-
>>>    plugins/api.c                                 |   2 +
>>>    scripts/probe-gdb-support.py                  |   1 +
>>>    tests/Makefile.include                        |  68 +-
>>>    tests/docker/docker.py                        |   4 +-
>>>    .../dockerfiles/debian-all-test-cross.docker  |  16 +-
>>>    tests/lcitool/refresh                         | 107 +-
>>>    tests/meson.build                             |   2 +-
>>>    tests/tcg/Makefile.target                     | 281 -----
>>>    tests/tcg/aarch64/Makefile.softmmu-target     | 147 ---
>>>    tests/tcg/aarch64/Makefile.target             | 198 ----
>>>    tests/tcg/aarch64/meson.build                 | 195 ++++
>>>    tests/tcg/aarch64/system/gpc-test.c           |   5 -
>>>    tests/tcg/aarch64/system/meson.build          | 108 ++
>>>    tests/tcg/aarch64_be/Makefile.target          |  17 -
>>>    tests/tcg/aarch64_be/meson.build              |  22 +
>>>    tests/tcg/alpha/Makefile.softmmu-target       |  34 -
>>>    tests/tcg/alpha/Makefile.target               |  18 -
>>>    tests/tcg/alpha/float_convd.ref               | 988 ++++++++++++++++++
>>>    tests/tcg/alpha/float_convs.ref               | 748 +++++++++++++
>>>    tests/tcg/alpha/float_madds.ref               | 768 ++++++++++++++
>>>    tests/tcg/alpha/meson.build                   |  55 +
>>>    tests/tcg/alpha/system/meson.build            |  46 +
>>>    tests/tcg/arm/Makefile.softmmu-target         |  80 --
>>>    tests/tcg/arm/Makefile.target                 |  87 --
>>>    tests/tcg/arm/meson.build                     |  80 ++
>>>    tests/tcg/arm/system/meson.build              |  66 ++
>>>    tests/tcg/hexagon/Makefile.target             | 146 ---
>>>    tests/tcg/hexagon/meson.build                 | 111 ++
>>>    tests/tcg/hexagon/overflow.c                  |   1 +
>>>    tests/tcg/hppa/Makefile.target                |  14 -
>>>    tests/tcg/hppa/float_convd.ref                | 988 ++++++++++++++++++
>>>    tests/tcg/hppa/float_convs.ref                | 748 +++++++++++++
>>>    tests/tcg/hppa/float_madds.ref                | 768 ++++++++++++++
>>>    tests/tcg/hppa/meson.build                    |  22 +
>>>    tests/tcg/i386/Makefile.softmmu-target        |  37 -
>>>    tests/tcg/i386/Makefile.target                | 102 --
>>>    tests/tcg/i386/float_convd.conf               | 988 ------------------
>>>    tests/tcg/i386/float_convd.ref                | 988 ++++++++++++++++++
>>>    tests/tcg/i386/float_madds.ref                | 768 ++++++++++++++
>>>    tests/tcg/i386/meson.build                    |  58 +
>>>    tests/tcg/i386/system/meson.build             |  48 +
>>>    tests/tcg/loongarch64/Makefile.softmmu-target |  33 -
>>>    tests/tcg/loongarch64/Makefile.target         |  20 -
>>>    tests/tcg/loongarch64/meson.build             |  32 +
>>>    tests/tcg/loongarch64/system/meson.build      |  47 +
>>>    tests/tcg/m68k/Makefile.target                |   7 -
>>>    tests/tcg/m68k/float_convd.ref                | 988 ++++++++++++++++++
>>>    tests/tcg/m68k/float_convs.ref                | 748 +++++++++++++
>>>    tests/tcg/m68k/float_madds.ref                | 768 ++++++++++++++
>>>    tests/tcg/m68k/meson.build                    |  23 +
>>>    tests/tcg/meson.build                         | 447 ++++++++
>>>    tests/tcg/minilib/Makefile.target             |  21 -
>>>    tests/tcg/mips/Makefile.target                |  19 -
>>>    tests/tcg/mips/float_convd.ref                | 988 ++++++++++++++++++
>>>    tests/tcg/mips/float_convs.ref                | 748 +++++++++++++
>>>    tests/tcg/mips/float_madds.ref                | 768 ++++++++++++++
>>>    tests/tcg/mips/meson.build                    |  25 +
>>>    tests/tcg/mips/user/ase/dsp/Makefile          | 184 ----
>>>    tests/tcg/mips/user/isa/mips64r6/crc/Makefile |  40 -
>>>    tests/tcg/mips/user/isa/r5900/Makefile        |  32 -
>>>    tests/tcg/mips64/Makefile.target              |  20 -
>>>    tests/tcg/mips64/float_convd.ref              | 988 ++++++++++++++++++
>>>    tests/tcg/mips64/float_convs.ref              | 748 +++++++++++++
>>>    tests/tcg/mips64/float_madds.ref              | 768 ++++++++++++++
>>>    tests/tcg/mips64/meson.build                  |  27 +
>>>    tests/tcg/mips64el/Makefile.target            |   8 -
>>>    tests/tcg/mips64el/float_convd.ref            | 988 ++++++++++++++++++
>>>    tests/tcg/mips64el/float_convs.ref            | 748 +++++++++++++
>>>    tests/tcg/mips64el/float_madds.ref            | 768 ++++++++++++++
>>>    tests/tcg/mips64el/meson.build                |  14 +
>>>    tests/tcg/multiarch/Makefile.target           | 233 -----
>>>    tests/tcg/multiarch/meson.build               | 149 +++
>>>    .../multiarch/plugin/check-plugin-output.sh   |  36 -
>>>    tests/tcg/multiarch/plugin/regex-compare.sh   |  28 +
>>>    tests/tcg/multiarch/sha1.c                    |   4 +-
>>>    tests/tcg/multiarch/sha1.ref                  |   1 +
>>>    .../multiarch/system/Makefile.softmmu-target  |  81 --
>>>    tests/tcg/multiarch/system/memory.c           |   3 +-
>>>    tests/tcg/multiarch/system/meson.build        |  53 +
>>>    tests/tcg/or1k/Makefile                       |  71 --
>>>    tests/tcg/or1k/float_convd.ref                | 247 +++++
>>>    tests/tcg/or1k/float_convs.ref                | 187 ++++
>>>    tests/tcg/or1k/float_madds.ref                | 192 ++++
>>>    tests/tcg/or1k/meson.build                    |  72 ++
>>>    tests/tcg/or1k/test_addic.c                   |   2 +-
>>>    tests/tcg/or1k/test_muli.c                    |   5 +-
>>>    tests/tcg/plugins/meson.build                 |  11 +-
>>>    tests/tcg/ppc64/Makefile.target               |  63 --
>>>    tests/tcg/ppc64/float_convd.ref               | 988 ++++++++++++++++++
>>>    tests/tcg/ppc64/float_convs.ref               | 748 +++++++++++++
>>>    tests/tcg/ppc64/float_madds.ref               | 768 ++++++++++++++
>>>    tests/tcg/ppc64/meson.build                   |  56 +
>>>    tests/tcg/ppc64/vector.c                      |  11 +-
>>>    tests/tcg/ppc64/vsx_f2i_nan.c                 |   7 +-
>>>    tests/tcg/ppc64le/Makefile.target             |   7 -
>>>    tests/tcg/ppc64le/float_convd.ref             | 988 ++++++++++++++++++
>>>    tests/tcg/ppc64le/meson.build                 |  14 +
>>>    tests/tcg/riscv64/Makefile.softmmu-target     |  45 -
>>>    tests/tcg/riscv64/Makefile.target             |  20 -
>>>    tests/tcg/riscv64/float_convd.ref             | 988 ++++++++++++++++++
>>>    tests/tcg/riscv64/float_convs.ref             | 748 +++++++++++++
>>>    tests/tcg/riscv64/float_madds.ref             | 768 ++++++++++++++
>>>    tests/tcg/riscv64/meson.build                 |  38 +
>>>    tests/tcg/riscv64/system/meson.build          |  38 +
>>>    tests/tcg/s390x/Makefile.softmmu-target       |  57 -
>>>    tests/tcg/s390x/Makefile.target               | 127 ---
>>>    tests/tcg/s390x/float_convd.ref               | 988 ++++++++++++++++++
>>>    tests/tcg/s390x/float_convs.ref               | 748 +++++++++++++
>>>    tests/tcg/s390x/float_madds.ref               | 768 ++++++++++++++
>>>    tests/tcg/s390x/head64.S                      |   2 +
>>>    tests/tcg/s390x/meson.build                   | 140 +++
>>>    tests/tcg/s390x/system/meson.build            |  92 ++
>>>    tests/tcg/scripts/check_plugin_output.sh      |  25 +
>>>    tests/tcg/scripts/record_replay.sh            |  16 +
>>>    .../scripts/run_and_check_forbidden_output.sh |  19 +
>>>    tests/tcg/scripts/run_and_diff.sh             |  15 +
>>>    tests/tcg/scripts/run_with_input.sh           |  12 +
>>>    tests/tcg/sh4/Makefile.target                 |  18 -
>>>    tests/tcg/sh4/float_convd.ref                 | 494 +++++++++
>>>    tests/tcg/sh4/float_convs.ref                 | 374 +++++++
>>>    tests/tcg/sh4/float_madds.ref                 | 384 +++++++
>>>    tests/tcg/sh4/meson.build                     |  25 +
>>>    tests/tcg/tricore/Makefile.softmmu-target     |  53 -
>>>    tests/tcg/x86_64/Makefile.softmmu-target      |  44 -
>>>    tests/tcg/x86_64/Makefile.target              |  40 -
>>>    tests/tcg/x86_64/float_madds.ref              | 768 ++++++++++++++
>>>    tests/tcg/x86_64/meson.build                  |  83 ++
>>>    tests/tcg/x86_64/system/meson.build           |  62 ++
>>>    tests/tcg/xtensa/Makefile.softmmu-target      |  46 -
>>>    tests/tcg/xtensa/crt.S                        |   1 +
>>>    tests/tcg/xtensa/meson.build                  |  89 ++
>>>    tests/tcg/xtensaeb/Makefile.softmmu-target    |   5 -
>>>    134 files changed, 30491 insertions(+), 4114 deletions(-)
>>>    delete mode 100644 tests/tcg/Makefile.target
>>>    delete mode 100644 tests/tcg/aarch64/Makefile.softmmu-target
>>>    delete mode 100644 tests/tcg/aarch64/Makefile.target
>>>    create mode 100644 tests/tcg/aarch64/meson.build
>>>    create mode 100644 tests/tcg/aarch64/system/meson.build
>>>    delete mode 100644 tests/tcg/aarch64_be/Makefile.target
>>>    create mode 100644 tests/tcg/aarch64_be/meson.build
>>>    delete mode 100644 tests/tcg/alpha/Makefile.softmmu-target
>>>    delete mode 100644 tests/tcg/alpha/Makefile.target
>>>    create mode 100644 tests/tcg/alpha/float_convd.ref
>>>    create mode 100644 tests/tcg/alpha/float_convs.ref
>>>    create mode 100644 tests/tcg/alpha/float_madds.ref
>>>    create mode 100644 tests/tcg/alpha/meson.build
>>>    create mode 100644 tests/tcg/alpha/system/meson.build
>>>    delete mode 100644 tests/tcg/arm/Makefile.softmmu-target
>>>    delete mode 100644 tests/tcg/arm/Makefile.target
>>>    create mode 100644 tests/tcg/arm/meson.build
>>>    create mode 100644 tests/tcg/arm/system/meson.build
>>>    delete mode 100644 tests/tcg/hexagon/Makefile.target
>>>    create mode 100644 tests/tcg/hexagon/meson.build
>>>    delete mode 100644 tests/tcg/hppa/Makefile.target
>>>    create mode 100644 tests/tcg/hppa/float_convd.ref
>>>    create mode 100644 tests/tcg/hppa/float_convs.ref
>>>    create mode 100644 tests/tcg/hppa/float_madds.ref
>>>    create mode 100644 tests/tcg/hppa/meson.build
>>>    delete mode 100644 tests/tcg/i386/Makefile.softmmu-target
>>>    delete mode 100644 tests/tcg/i386/Makefile.target
>>>    delete mode 100644 tests/tcg/i386/float_convd.conf
>>>    create mode 100644 tests/tcg/i386/float_convd.ref
>>>    create mode 100644 tests/tcg/i386/float_madds.ref
>>>    create mode 100644 tests/tcg/i386/meson.build
>>>    create mode 100644 tests/tcg/i386/system/meson.build
>>>    delete mode 100644 tests/tcg/loongarch64/Makefile.softmmu-target
>>>    delete mode 100644 tests/tcg/loongarch64/Makefile.target
>>>    create mode 100644 tests/tcg/loongarch64/meson.build
>>>    create mode 100644 tests/tcg/loongarch64/system/meson.build
>>>    delete mode 100644 tests/tcg/m68k/Makefile.target
>>>    create mode 100644 tests/tcg/m68k/float_convd.ref
>>>    create mode 100644 tests/tcg/m68k/float_convs.ref
>>>    create mode 100644 tests/tcg/m68k/float_madds.ref
>>>    create mode 100644 tests/tcg/m68k/meson.build
>>>    create mode 100644 tests/tcg/meson.build
>>>    delete mode 100644 tests/tcg/minilib/Makefile.target
>>>    delete mode 100644 tests/tcg/mips/Makefile.target
>>>    create mode 100644 tests/tcg/mips/float_convd.ref
>>>    create mode 100644 tests/tcg/mips/float_convs.ref
>>>    create mode 100644 tests/tcg/mips/float_madds.ref
>>>    create mode 100644 tests/tcg/mips/meson.build
>>>    delete mode 100644 tests/tcg/mips/user/ase/dsp/Makefile
>>>    delete mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/Makefile
>>>    delete mode 100644 tests/tcg/mips/user/isa/r5900/Makefile
>>>    delete mode 100644 tests/tcg/mips64/Makefile.target
>>>    create mode 100644 tests/tcg/mips64/float_convd.ref
>>>    create mode 100644 tests/tcg/mips64/float_convs.ref
>>>    create mode 100644 tests/tcg/mips64/float_madds.ref
>>>    create mode 100644 tests/tcg/mips64/meson.build
>>>    delete mode 100644 tests/tcg/mips64el/Makefile.target
>>>    create mode 100644 tests/tcg/mips64el/float_convd.ref
>>>    create mode 100644 tests/tcg/mips64el/float_convs.ref
>>>    create mode 100644 tests/tcg/mips64el/float_madds.ref
>>>    create mode 100644 tests/tcg/mips64el/meson.build
>>>    delete mode 100644 tests/tcg/multiarch/Makefile.target
>>>    create mode 100644 tests/tcg/multiarch/meson.build
>>>    delete mode 100755 tests/tcg/multiarch/plugin/check-plugin-output.sh
>>>    create mode 100755 tests/tcg/multiarch/plugin/regex-compare.sh
>>>    create mode 100644 tests/tcg/multiarch/sha1.ref
>>>    delete mode 100644 tests/tcg/multiarch/system/Makefile.softmmu-target
>>>    create mode 100644 tests/tcg/multiarch/system/meson.build
>>>    delete mode 100644 tests/tcg/or1k/Makefile
>>>    create mode 100644 tests/tcg/or1k/float_convd.ref
>>>    create mode 100644 tests/tcg/or1k/float_convs.ref
>>>    create mode 100644 tests/tcg/or1k/float_madds.ref
>>>    create mode 100644 tests/tcg/or1k/meson.build
>>>    delete mode 100644 tests/tcg/ppc64/Makefile.target
>>>    create mode 100644 tests/tcg/ppc64/float_convd.ref
>>>    create mode 100644 tests/tcg/ppc64/float_convs.ref
>>>    create mode 100644 tests/tcg/ppc64/float_madds.ref
>>>    create mode 100644 tests/tcg/ppc64/meson.build
>>>    delete mode 100644 tests/tcg/ppc64le/Makefile.target
>>>    create mode 100644 tests/tcg/ppc64le/float_convd.ref
>>>    create mode 100644 tests/tcg/ppc64le/meson.build
>>>    delete mode 100644 tests/tcg/riscv64/Makefile.softmmu-target
>>>    delete mode 100644 tests/tcg/riscv64/Makefile.target
>>>    create mode 100644 tests/tcg/riscv64/float_convd.ref
>>>    create mode 100644 tests/tcg/riscv64/float_convs.ref
>>>    create mode 100644 tests/tcg/riscv64/float_madds.ref
>>>    create mode 100644 tests/tcg/riscv64/meson.build
>>>    create mode 100644 tests/tcg/riscv64/system/meson.build
>>>    delete mode 100644 tests/tcg/s390x/Makefile.softmmu-target
>>>    delete mode 100644 tests/tcg/s390x/Makefile.target
>>>    create mode 100644 tests/tcg/s390x/float_convd.ref
>>>    create mode 100644 tests/tcg/s390x/float_convs.ref
>>>    create mode 100644 tests/tcg/s390x/float_madds.ref
>>>    create mode 100644 tests/tcg/s390x/meson.build
>>>    create mode 100644 tests/tcg/s390x/system/meson.build
>>>    create mode 100755 tests/tcg/scripts/check_plugin_output.sh
>>>    create mode 100755 tests/tcg/scripts/record_replay.sh
>>>    create mode 100755 tests/tcg/scripts/run_and_check_forbidden_output.sh
>>>    create mode 100755 tests/tcg/scripts/run_and_diff.sh
>>>    create mode 100755 tests/tcg/scripts/run_with_input.sh
>>>    delete mode 100644 tests/tcg/sh4/Makefile.target
>>>    create mode 100644 tests/tcg/sh4/float_convd.ref
>>>    create mode 100644 tests/tcg/sh4/float_convs.ref
>>>    create mode 100644 tests/tcg/sh4/float_madds.ref
>>>    create mode 100644 tests/tcg/sh4/meson.build
>>>    delete mode 100644 tests/tcg/tricore/Makefile.softmmu-target
>>>    delete mode 100644 tests/tcg/x86_64/Makefile.softmmu-target
>>>    delete mode 100644 tests/tcg/x86_64/Makefile.target
>>>    create mode 100644 tests/tcg/x86_64/float_madds.ref
>>>    create mode 100644 tests/tcg/x86_64/meson.build
>>>    create mode 100644 tests/tcg/x86_64/system/meson.build
>>>    delete mode 100644 tests/tcg/xtensa/Makefile.softmmu-target
>>>    create mode 100644 tests/tcg/xtensa/meson.build
>>>    delete mode 100644 tests/tcg/xtensaeb/Makefile.softmmu-target
>>>
>>
>> Seems like something is wrong with cross-compiler detection now.
>> On Fedora I get:
>>
>> FAILED: tests/tcg/s390x-softmmu-memory.test
>> /usr/lib64/ccache/s390x-linux-gnu-gcc /mnt/root/home/iii/qemu-
>> worktrees/20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com/
>> tests/tcg/multiarch/system/memory.c -o tests/tcg/s390x-softmmu-
>> memory.test -static -MMD -MF tests/tcg/s390x-softmmu-memory.d -Wall -
>> Werror -O0 -g -fno-strict-aliasing -nostdlib -I /mnt/root/home/iii/qemu-
>> worktrees/20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com/
>> tests/tcg/s390x/system/../../minilib /mnt/root/home/iii/qemu-
>> worktrees/20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com/
>> tests/tcg/s390x/system/../../minilib/printf.c -I /mnt/root/home/iii/
>> qemu-worktrees/20260706223343.988769-1-
>> pierrick.bouvier@oss.qualcomm.com/include/hw/s390x/ipl -I /mnt/root/
>> home/iii/qemu-worktrees/20260706223343.988769-1-
>> pierrick.bouvier@oss.qualcomm.com/roms/SLOF/lib/libc/include -
>> march=z13 ../tests/tcg/s390x/system/../head64.S ../tests/tcg/s390x/
>> system/../console.c -DCHECK_UNALIGNED=0
>> In file included from /mnt/root/home/iii/qemu-
>> worktrees/20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com/
>> tests/tcg/multiarch/system/memory.c:15:
>> /usr/lib/gcc/s390x-linux-gnu/15/include/stdint.h:11:16: fatal error:
>> stdint.h: No such file or directory
>>     11 | # include_next <stdint.h>
>>        |                ^~~~~~~~~~
>>
>> The cross-compiler situation on Fedora is that they ship the
>> cross-compiler itself, but no userspace headers, so it's usable
>> only for kernel builds. In this case QEMU should fall back to Docker,
>> which works for me on master, but not with this series.
> 
> Thanks for the report. I just tried that on debian for now.
> 
> Also, for s390x, I noticed that some tests are relying on roms/SLOF/...
> headers, which are not available if submodules are not initialized.
> Probably another corner case to cover.
We've got some logic in the configure script that should always initialize 
the roms/SLOF submodule when you build the s390x target:

if have_target s390x-softmmu && probe_target_compiler s390x-softmmu && \
     GIT=git "$source_path/scripts/git-submodule.sh" 
"$git_submodules_action" roms/SLOF >> config.log 2>&1; then

Is that failing in your case?

  Thomas


