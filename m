Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B20C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 17:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFcOZ-0002c5-Rq; Thu, 15 May 2025 13:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFcOV-0002NB-EN
 for qemu-devel@nongnu.org; Thu, 15 May 2025 13:29:19 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFcOS-0002Fg-Mt
 for qemu-devel@nongnu.org; Thu, 15 May 2025 13:29:19 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-af6a315b491so1011647a12.1
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 10:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747330155; x=1747934955; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FYedixI6lFZBk1lJBzI5v6/hl5cIdyd6RqWZzgpF72Y=;
 b=qaWep2P41hW5Rt1gAzGZ/23cNvK541veOFl+ygJrMp3JblSVTklt898tSy/Ag81ARI
 NHvjT2BDAIKejGP9vGx5Ooe3y+MOJy3mBnV4MWsS+4gClg4AIOh7kHjx+MyWKV/FUKVX
 v7BgfCRswZismsMzJSdkJ2zsGVh7D0WRRXYvkJkfopjkD/47vosZwGa6dLhD4E9tlUJ9
 so0N4XcyT7vIhmKMHFVSfvld7fpYYpxGv1CSUI8JMZdJJo6/DVp+oMp7SybNbN6A4nWs
 xq1IbOTDdXTsRFqvTjEIGFyZuAkmS2azccCEBZjJ3mnKmRWm18Ms3OqnwVeIvhomq0DQ
 bwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747330155; x=1747934955;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FYedixI6lFZBk1lJBzI5v6/hl5cIdyd6RqWZzgpF72Y=;
 b=J6tFmazxxSY9Pc8avd38m0zkudHDmVKh/6KiJdFHiSpjZmeQd4kGhCTXv3gexHvBh2
 f3JFg1nxEy8tdgUc8a+jpUxpOpSVlqOeGdj7FeobadktxyKF4K5y4cF/xucGf7KJ4WvJ
 hr/HKiyAeIvCKmZuLTueWv209dU3gs43X7NJDnD7dw4GYZ2zhTElQMBxebIxKq0Sxv9U
 a/Nv1Mvy0SipdjsVxjK3KoLSOttF/CjjxECkOW+qk8Qu0zv2sTVbjNHgno2drnuHmsDo
 I5UGU236L3SxWYaC43E1dtiXLU76dsC8QERjYzte0O478wsRmIR0F1fmW9YydXed8e6F
 EZBg==
X-Gm-Message-State: AOJu0YzB9DzKpAjQszuxrFcBc8sMt/JiD8zlzOg/SZwAJzBMJjrUmR1/
 WZXgOi6ofDhOKAcfAVCvDY3agUPCYTbB3jCGHmuoPhabiQ97pdwwLhq+ETD/iAO0VsmUXRxEv1Y
 JmvUg
X-Gm-Gg: ASbGncvk1SE3QNKIW1GW2zWDESQjYxxuiF7nMI+Gw5rq0tmzV2W3bGIJkd74uWQWCNU
 Rp/F4p7as0vkevBzBuKx1lDvm0Bo4+wai9Vdrg2UZJ++UemvIUqgn3pxF8RG9NcakNeD9/8s0YP
 dNETpKTG08adfpT+8+2zaod5V38iSA6klzXNxRP0RExZGNYIIRtgpVdhUObJ1fdvfFnsxj2P2pp
 NqN7QAt/CurLwcIUPIySC3JKlx+HX2jRQCowlSB0L3+YEPu9TNY7JCQphIPjAYTHD9HV58AdUm9
 DdEWxZXVbqglNsKIBZK52/7smAXwgG3qJnX01Uu47IpoVyvYjjPmNChcjdUIEdJD
X-Google-Smtp-Source: AGHT+IEzOEn9266WXgIZ53NHPVtbLnszESOwsudy+9khwASGcsa8BOWf1/BjL6KzM2LOdp2An95WjA==
X-Received: by 2002:a05:6a20:430f:b0:201:b65:81ab with SMTP id
 adf61e73a8af0-2162190a3f0mr551657637.23.1747330144876; 
 Thu, 15 May 2025 10:29:04 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a985e417sm63774b3a.123.2025.05.15.10.29.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 10:29:04 -0700 (PDT)
Message-ID: <9b2ddfaa-9bc3-4b8d-946e-4705145e2055@linaro.org>
Date: Thu, 15 May 2025 10:29:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] qapi: remove all TARGET_* conditionals from the
 schema
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 berrange@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250514234108.3746675-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250514234108.3746675-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x530.google.com
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

On 5/14/25 4:40 PM, Pierrick Bouvier wrote:
> This series exposes all qmp commands for any target unconditionally, allowing to
> compile QAPI generated code without any TARGET conditionals.
> 
> Based on original RFC from Daniel P. Berrangé:
> https://lore.kernel.org/qemu-devel/20250508135816.673087-1-berrange@redhat.com/
> 
> v1
> --
> 
> - remove file qapi/misc-target.json (Markus)
> - remove qapi/*-target.json from MAINTAINERS (Markus)
> - remove qapi_specific_outputs from qapi/meson.build (Markus)
> - update comment in rtc-reset-reinjection stub (Markus)
> - build QAPI generated code only once
> 
> Daniel P. Berrangé (9):
>    qapi: expose rtc-reset-reinjection command unconditionally
>    qapi: expand docs for SEV commands
>    qapi: make SEV commands unconditionally available
>    qapi: expose query-gic-capability command unconditionally
>    qapi: make SGX commands unconditionally available
>    qapi: make Xen event commands unconditionally available
>    qapi: remove the misc-target.json file
>    qapi: make most CPU commands unconditionally available
>    qapi: make s390x specific CPU commands unconditionally available
> 
> Philippe Mathieu-Daudé (1):
>    qapi: Make CpuModelExpansionInfo::deprecated-props optional and
>      generic
> 
> Pierrick Bouvier (2):
>    qapi: remove qapi_specific_outputs from meson.build
>    qapi: make all generated files common
> 
>   MAINTAINERS                               |   1 -
>   qapi/machine-s390x.json                   | 121 +++++
>   qapi/machine-target.json                  | 523 ----------------------
>   qapi/machine.json                         | 363 +++++++++++++++
>   qapi/misc-arm.json                        |  49 ++
>   qapi/{misc-target.json => misc-i386.json} | 154 +++----
>   qapi/qapi-schema.json                     |   5 +-
>   include/hw/s390x/cpu-topology.h           |   2 +-
>   hw/i386/kvm/xen-stubs.c                   |  13 -
>   hw/i386/kvm/xen_evtchn.c                  |   2 +-
>   hw/i386/monitor.c                         |   2 +-
>   hw/i386/sgx-stub.c                        |  13 -
>   hw/i386/sgx.c                             |   2 +-
>   hw/s390x/cpu-topology.c                   |   4 +-
>   hw/s390x/s390-skeys.c                     |   1 -
>   stubs/monitor-arm-gic.c                   |  12 +
>   stubs/monitor-cpu-s390x-kvm.c             |  22 +
>   stubs/monitor-cpu-s390x.c                 |  23 +
>   stubs/monitor-cpu.c                       |  21 +
>   stubs/monitor-i386-rtc.c                  |  14 +
>   stubs/monitor-i386-sev.c                  |  36 ++
>   stubs/monitor-i386-sgx.c                  |  17 +
>   stubs/monitor-i386-xen.c                  |  16 +
>   target/arm/arm-qmp-cmds.c                 |   4 +-
>   target/i386/cpu-system.c                  |   2 +-
>   target/i386/cpu.c                         |   2 +-
>   target/i386/monitor.c                     |   1 -
>   target/i386/sev-system-stub.c             |  32 --
>   target/i386/sev.c                         |   2 +-
>   target/loongarch/loongarch-qmp-cmds.c     |   2 +-
>   target/mips/system/mips-qmp-cmds.c        |  12 +-
>   target/ppc/ppc-qmp-cmds.c                 |  12 +-
>   target/riscv/riscv-qmp-cmds.c             |   2 +-
>   target/s390x/cpu_models_system.c          |   2 +-
>   tests/qtest/qmp-cmd-test.c                |   1 +
>   qapi/meson.build                          |  18 +-
>   stubs/meson.build                         |   8 +
>   37 files changed, 811 insertions(+), 705 deletions(-)
>   create mode 100644 qapi/machine-s390x.json
>   delete mode 100644 qapi/machine-target.json
>   create mode 100644 qapi/misc-arm.json
>   rename qapi/{misc-target.json => misc-i386.json} (76%)
>   create mode 100644 stubs/monitor-arm-gic.c
>   create mode 100644 stubs/monitor-cpu-s390x-kvm.c
>   create mode 100644 stubs/monitor-cpu-s390x.c
>   create mode 100644 stubs/monitor-cpu.c
>   create mode 100644 stubs/monitor-i386-rtc.c
>   create mode 100644 stubs/monitor-i386-sev.c
>   create mode 100644 stubs/monitor-i386-sgx.c
>   create mode 100644 stubs/monitor-i386-xen.c
> 

v2 was posted:
https://lore.kernel.org/qemu-devel/20250515172732.3992504-1-pierrick.bouvier@linaro.org

