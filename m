Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A68C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 14:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD2ff-0001hk-0Y; Thu, 08 May 2025 10:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD2fd-0001hX-Dv
 for qemu-devel@nongnu.org; Thu, 08 May 2025 10:56:21 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD2fW-0006XQ-0N
 for qemu-devel@nongnu.org; Thu, 08 May 2025 10:56:16 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-30c1c4a8224so499106a91.0
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 07:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746716170; x=1747320970; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JjuTY6zGE9ik70+ln5opJSeuZ1LOb0+5kSIFOAQJcGc=;
 b=BdNfvLwofqQbwcnsGl3+tk/fWDcA8nDdpEN+RIW9kaKQ7x0+gPbFGDPVmp9YD1eYSn
 ugwYXMEAb6q6BLn7i+NdgY5ZjJAIxpQS7xHjyWBf3Y+8qmhWOinHBnZXiugFLUxTCmwj
 axibDZiEJrfYUgLZsWX7fOtVgUeMBU+AkeDLKEtVyr5bzwMPxUmvUO9A4iZ3kfhvwqjd
 BEIpohVpglLLGssUCeTVvWd1suxAdxYScsjBaXpeROxKHC5PVEWTdh/ZbkqxJK7EN2Gk
 FHmVbu+NGd4Ef9YC8bxZ6cjTLdxYqh4HnvBvGyCE1Ym55nX6yRRBiJ/NZ9pO9OhuysHS
 1tyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746716170; x=1747320970;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JjuTY6zGE9ik70+ln5opJSeuZ1LOb0+5kSIFOAQJcGc=;
 b=p4vie4kFNPvG8ioVYpGdL16ttFo17uZLwZVZ/a9dBnzYx28R3PefPo8+ev8EOOi556
 PYSTD0bOFNRCH41qs9XG7N0J06MCsekJHumpN7qfjeHQIr/ifw7m6fzW6serTi6aVfte
 zNupafbb3deFGC2e2Gq/zFgbBJ5V2yxAaEDaPH/RY/472QhL16uJ49/j0fM3MtisVKY7
 P1RLfB4DFlxiuQsGt6PmbmC/mx5vyrw9Jl4hvSaUZ++hl3si4eQq95CkWRvmmAYgBQoD
 ebQgYd1bhDNBUof3PomI15FT45P1Ovr/UdGAbndI1km+B2N81KutwdniIj3b7JSvjx9u
 cNWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgIhmL0Bt53rbqWR5ZOIS6lyQ52V8ttELcWchz3OBjMfP7EXlxa1XXIDUxGGiGuNmiPM8XDOiHCgVQ@nongnu.org
X-Gm-Message-State: AOJu0Yy39oZNF8H1QiNjTyGuQ+I3xuCz0JdFw3LsAmLO9lIhQeD+l3LG
 o1RsSPjaa1jKMUZv5fWHR4v7rm+ubcpAvLqx2g8Uz51dAYO83qezs2TImUz0Yl96JLZsybwR20a
 qEZsGWg==
X-Gm-Gg: ASbGncumjQ8AofkLozkErfw+eI7cf4JsjzncE8ef7sxev69eusq4O0h86RlCaqoWn2s
 8Hdk3ydVO7Bn9K8iI5UlS86ZxClUXjI2duuXDfmIxjSNo8cTWkSxG8olJ4FJyWyNdXjhhKovpjZ
 pgLOQHWuLXxzOegnUjJpVcLydXFzxYIhdwsQ4euGuMNycnznDqtAQuTevNgLDr8tI6KE0RmWyUE
 5cBqtnLsnB3LZju4fuJMezeK5bJnZpLTRiElxPNXZIqxquNeh2t2GopCrkkFd8o90K+T+SBYEEr
 zUB2IcnRgfB03g51zdRDJCskVZs4Klf43QBbREUdifkDzRXaPgYaIRqPnPVHKkIjSaGMmpskk3w
 tVwy3at0m
X-Google-Smtp-Source: AGHT+IFOWqbzSDS8YFolCF0Z0SE8ggmaxub1gZ/dXcRTC7xrkaKoplhAzaxCseLz0Ziz3HMRx3Ps+Q==
X-Received: by 2002:a17:90b:3d02:b0:30a:255c:9c89 with SMTP id
 98e67ed59e1d1-30b3a6634a4mr4840322a91.19.1746716169815; 
 Thu, 08 May 2025 07:56:09 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30c39dd4b95sm51364a91.20.2025.05.08.07.56.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 07:56:09 -0700 (PDT)
Message-ID: <a0b57e48-e826-4376-aa69-8db92c939064@linaro.org>
Date: Thu, 8 May 2025 16:56:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/10] qapi: remove all TARGET_* conditionals from the
 schema
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250508135816.673087-1-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250508135816.673087-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x102b.google.com
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

On 8/5/25 15:58, Daniel P. Berrangé wrote:
> Pierrick has proposed a series that introduces a concept of runtime
> conditionals to the QAPI schema, in order to adapt the TARGET_*
> conditionals currently used at build time:
> 
>    https://lists.nongnu.org/archive/html/qemu-devel/2025-05/msg01699.html
> 
> For the sake of comparison & evaluation, this series illustrates the
> alternative approach that we've discussed of entirely removing any
> concept of TARGET_* conditionals.
> 
> With this the QAPI schema varies solely based on CONFIG_* conditionals,
> and is thus invariant across different target emulators.
> 
> In this PoC I've taken the minimal effort approach to the problem.
> 
> The QAPI schema has removed the TARGET_* conditionals and in order to
> make all the emulators then compile, the stubs/ directory is populated
> with a bunch of files to provide dummy impls of the target specific QMP
> commands.
> 
> This is sufficient to make the current QEMU binaries build successfully.
> 
> To make the "single binary" concept work, however, would require
> additional followup work to eliminate the stubs.
> 
> Instead of having stubs we would need to de-couple the QMP command
> impl from the machine internals. This would likely require greater
> use of interfaces and/or virtual method dispatchers on the machine
> class. This would enable the 'qmp_XXXXX' command impls to exist
> once. Then they call out to virtual methods on the machine to provide
> the real impl, and/or generate an error if the virtual method is not
> implemented for the machine.

Note,  I don't see commands "per machine", but per device (including
CPU). When not specified, we iterate over device implementations / CPUs.

> 
> Daniel P. Berrangé (9):
>    qapi: expose rtc-reset-reinjection command unconditionally
>    qapi: expand docs for SEV commands
>    qapi: make SEV commands unconditionally available
>    qapi: expose query-gic-capability command unconditionally
>    qapi: make SGX commands unconditionally available
>    qapi: make Xen event commands unconditionally available
>    qapi: remove the misc-target.json file
>    qapi: make most CPU  commands unconditionally available
>    qapi: make s390x specific CPU commands unconditionally available
> 
> Philippe Mathieu-Daudé (1):
>    qapi: Make CpuModelExpansionInfo::deprecated-props optional and
>      generic
> 
>   hw/i386/kvm/xen-stubs.c               |  13 -
>   hw/i386/kvm/xen_evtchn.c              |   2 +-
>   hw/i386/monitor.c                     |   2 +-
>   hw/i386/sgx-stub.c                    |  13 -
>   hw/i386/sgx.c                         |   2 +-
>   hw/s390x/cpu-topology.c               |   4 +-
>   hw/s390x/s390-skeys.c                 |   1 -
>   include/hw/s390x/cpu-topology.h       |   2 +-
>   qapi/machine-s390x.json               | 120 ++++++
>   qapi/machine-target.json              | 523 --------------------------
>   qapi/machine.json                     | 363 ++++++++++++++++++
>   qapi/meson.build                      |   5 +-
>   qapi/misc-arm.json                    |  49 +++
>   qapi/misc-i386.json                   | 479 +++++++++++++++++++++++
>   qapi/misc-target.json                 | 504 -------------------------
>   qapi/qapi-schema.json                 |   5 +-
>   stubs/meson.build                     |   8 +
>   stubs/monitor-arm-gic.c               |  12 +
>   stubs/monitor-cpu-s390x-kvm.c         |  22 ++
>   stubs/monitor-cpu-s390x.c             |  23 ++
>   stubs/monitor-cpu.c                   |  21 ++
>   stubs/monitor-i386-rtc.c              |  10 +
>   stubs/monitor-i386-sev.c              |  36 ++
>   stubs/monitor-i386-sgx.c              |  17 +
>   stubs/monitor-i386-xen.c              |  16 +
>   target/arm/arm-qmp-cmds.c             |   4 +-
>   target/i386/cpu-system.c              |   2 +-
>   target/i386/cpu.c                     |   2 +-
>   target/i386/monitor.c                 |   1 -
>   target/i386/sev-system-stub.c         |  32 --
>   target/i386/sev.c                     |   2 +-
>   target/loongarch/loongarch-qmp-cmds.c |   2 +-
>   target/mips/system/mips-qmp-cmds.c    |  12 +-
>   target/ppc/ppc-qmp-cmds.c             |  12 +-
>   target/riscv/riscv-qmp-cmds.c         |   2 +-
>   target/s390x/cpu_models_system.c      |   2 +-
>   tests/qtest/qmp-cmd-test.c            |   1 +

Eh I did a very similar series last month which didn't pass local
review, I need to remember what was the issue...

$ git diff --stat eb3020b6ed2baca63..32235d621871df0ccc
  MAINTAINERS                                        |   3 ++
  qapi/machine-arm-target.json                       |  47 +++++++++++++++++
  qapi/machine-s390x-target.json                     | 301 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  qapi/machine-target.json                           | 295 
--------------------------------------------------------------------------------------------------------
  qapi/{misc-target.json => machine-x86-target.json} |  94 
++++++++++++++++++----------------
  qapi/machine.json                                  |  44 ----------------
  qapi/qapi-schema.json                              |   4 +-
  include/hw/s390x/cpu-topology.h                    |   2 +-
  hw/i386/kvm/xen-stubs.c                            |   2 +-
  hw/i386/kvm/xen_evtchn.c                           |   2 +-
  hw/i386/monitor.c                                  |   2 +-
  hw/i386/sgx-stub.c                                 |   2 +-
  hw/i386/sgx.c                                      |   2 +-
  hw/s390x/s390-skeys.c                              |   1 -
  target/arm/arm-qmp-cmds.c                          |   3 +-
  target/i386/cpu-system.c                           |   1 +
  target/i386/cpu.c                                  |   3 ++
  target/i386/monitor.c                              |   2 +-
  target/i386/sev-system-stub.c                      |   2 +-
  target/i386/sev.c                                  |   2 +-
  target/s390x/cpu_models_system.c                   |   3 +-
  qapi/meson.build                                   |   4 +-
  22 files changed, 423 insertions(+), 398 deletions(-)

$ git log --oneline eb3020b6ed2baca63..32235d621871df0ccc | tac -r
c92b1454ef1 qapi: Restrict ARM specific schemas to ARM
9c708185fe4 qapi: Restrict CpuModelCompareResult to s390x target
c50cc3c438c qapi: Restrict s390x-specific schemas to s390x target
221ec7acf18 qapi: Restrict SGXEPCSection to x86 targets
a3606c5b23c qapi: Restrict x86-specific schemas to x86 targets
32235d62187 qapi: Guard x86 specific schemas with conditional


