Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38148C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 14:58:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCgDR-0007Nl-Ia; Wed, 07 May 2025 10:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCgDP-0007NJ-Ld
 for qemu-devel@nongnu.org; Wed, 07 May 2025 10:57:43 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCgDN-0001Rs-U4
 for qemu-devel@nongnu.org; Wed, 07 May 2025 10:57:43 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-acb5ec407b1so1243801966b.1
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 07:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746629859; x=1747234659; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+WVajEV11GEqSenfOy+NdjDhSwEzJSbqG5IrfbmAHQA=;
 b=ns6siBlI6tDSWR21nO2PVjco/A3zyECgVS0rogEOD7TiAmHazaQ5qavboCUHIKD7gE
 LE2EFVf/So5PsbwzXZtAjGlLlDM7VCN5WYqmeLArcQ2cqk1d7DJqwWIXn0Ake4G6hkE1
 EvLMb+AXWhESFRRLX+MplLcA00OhvjIuEV3QEb749AdxxyUqKD0nM2xvyqR+0HgYs/Lb
 dpWJh5cfy+CpUArCf95iWokbf9jSi+1xmyQJn8ilhC4/7vaaWhAnAzfLdeIO6Cx4WR1p
 aAr1zqg+eeGJe9hPx+vkPsNHfs9T1IlnQHiNlEnZceEStJb9vlxqV6oqwVAIdRKiGKln
 I07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746629859; x=1747234659;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+WVajEV11GEqSenfOy+NdjDhSwEzJSbqG5IrfbmAHQA=;
 b=aiYg7z8bQAYkoFhxLQ1V2vkRvwXBoftG3aQXvviA7UkXVoEKB6hGPLXWFZvEQtlCq6
 xPVoTBvd0mHImU+cVbu7ilurD+pisYgrM092GkmizhcnFhlHvuPetKj0ntnUswyD31/P
 naU3as7M2wLbLqPoSKFF67ydbLsr75ctyjhgNjnfBSrYAEL2Om2VVqz1+3c3PXiidnLH
 1Tz43WeN9Rk9HXUfdgiYJ9kqoZ3L7zvGCeABTXCl0FPvnQn19nckK1xFelSZz2nbp88B
 VJj5R9sonPpImK+V+VUexYGGMXKuHf8LO8EENRoxHSJ4axREh6caXrVlzW+oxXXiPVJB
 r9oQ==
X-Gm-Message-State: AOJu0YxjO+hgmwIF4G3y/edC0T2emyVckeV93500U2DYhJla8cZR1gJr
 OLJLiqWFmlVpbl/rY5TztCY3nfI6MBP6fXfnyYV9stgq8maZDQcdy+CJob7BGe2YrQvaw3Ymdev
 tvnw=
X-Gm-Gg: ASbGncvV9WFDuuq0GavS3d9orVDW+gglU4LNzxhOKz/U4vhbw9xlx2qVXu7yAOJUPG+
 qYxMrOTL2wKj8PeyhtwJUCtb5d7JqSOBMXI07p1yLHFdU7/ODFgU1d9U4PNbvdiddxW622OTKFC
 Z6OOnO9HyYYYzfW70HKI2ajYqeserDkKJVcZ2vBARmSbgRe0Y60HLyR9FuIk3kN0YaO+ozZBmYB
 3+FyRp1wH511Yxyg4OOiImNMPn1lcADPFV+sXDZZNA7J4WiSnur92AguNuYK0i9gjhpMo2qX57K
 ZjUYdwfn9p91AqVHJcI0JpJx/sX4FYRcmDcBgeO3l+nAF5BotIJY8uvteVJMC2hEbmhWf7JeHOI
 y
X-Google-Smtp-Source: AGHT+IEnWxS0QJMPEPvUtwR0wOpUCzHEPpr+VPoiUlw2fHopGKxji7hGoFmMBwBN2mKfWabSncoGSg==
X-Received: by 2002:a17:907:c12:b0:ac4:169:3664 with SMTP id
 a640c23a62f3a-ad1e8c934d6mr339387266b.33.1746629859402; 
 Wed, 07 May 2025 07:57:39 -0700 (PDT)
Received: from [10.194.152.213] (26.21.205.77.rev.sfr.net. [77.205.21.26])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad189147375sm922084266b.12.2025.05.07.07.57.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 May 2025 07:57:38 -0700 (PDT)
Message-ID: <0d976e4f-f8d2-407f-891a-8b13ea621821@linaro.org>
Date: Wed, 7 May 2025 16:57:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/32] target-arm queue
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>
Cc: qemu-devel@nongnu.org
References: <20250506144214.1221450-1-peter.maydell@linaro.org>
 <CAJSP0QXi1eGdbi5=2EGWuHdL2JX6h513wwVMi167xYZKHjbFSw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAJSP0QXi1eGdbi5=2EGWuHdL2JX6h513wwVMi167xYZKHjbFSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

On 7/5/25 16:05, Stefan Hajnoczi wrote:
> On Tue, May 6, 2025 at 10:52 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> Now I'm back from holiday, here's a target-arm pullreq :-)
>>
>> thanks
>> -- PMM
>>
>> The following changes since commit a9e0c9c0f14e19d23443ac24c8080b4708d2eab8:
>>
>>    Merge tag 'pull-9p-20250505' of https://github.com/cschoenebeck/qemu into staging (2025-05-05 11:26:59 -0400)
>>
>> are available in the Git repository at:
>>
>>    https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20250506
>>
>> for you to fetch changes up to 607e1208b53ac713a76d158f4abc4cd2e8870051:
>>
>>    hw/arm/virt: Remove deprecated virt-4.0 machine (2025-05-06 15:02:35 +0100)
>>
>> ----------------------------------------------------------------
>> target-arm queue:
>>   * hw/arm/npcm8xx_boards: Correct valid_cpu_types setting of NPCM8XX SoC
>>   * arm/hvf: fix crashes when using gdbstub
>>   * target/arm/ptw: fix arm_cpu_get_phys_page_attrs_debug
>>   * hw/arm/virt: Remove deprecated old versions of 'virt' machine
>>   * tests/functional: Add test for imx8mp-evk board with USDHC coverage
>>   * hw/arm: Attach PSPI module to NPCM8XX SoC
>>   * target/arm: Don't assert() for ISB/SB inside IT block
>>   * docs: Don't define duplicate label in qemu-block-drivers.rst.inc
>>   * target/arm/kvm: Drop support for kernels without KVM_ARM_PREFERRED_TARGET
>>   * hw/pci-host/designware: Fix viewport configuration
>>   * hw/gpio/imx_gpio: Fix interpretation of GDIR polarity
>>
>> ----------------------------------------------------------------
>> Bernhard Beschow (4):
>>        tests/functional: Add test for imx8mp-evk board with USDHC coverage
>>        hw/pci-host/designware: Remove unused include
>>        hw/pci-host/designware: Fix viewport configuration
>>        hw/gpio/imx_gpio: Fix interpretation of GDIR polarity
>>
>> Mads Ynddal (2):
>>        hvf: avoid repeatedly setting trap debug for each cpu
>>        hvf: only update sysreg from owning thread
> 
> Please take a look at the following aarch64 macOS CI failure:
> 
> ../accel/hvf/hvf-all.c:61:54: error: unknown type name 'run_on_cpu_data'
> 61 | static void do_hvf_update_guest_debug(CPUState *cpu, run_on_cpu_data arg)
> | ^
> ../accel/hvf/hvf-all.c:68:5: error: call to undeclared function
> 'run_on_cpu'; ISO C99 and later do not support implicit function
> declarations [-Wimplicit-function-declaration]
> 68 | run_on_cpu(cpu, do_hvf_update_guest_debug, RUN_ON_CPU_NULL);
> | ^
> ../accel/hvf/hvf-all.c:68:48: error: use of undeclared identifier
> 'RUN_ON_CPU_NULL'
> 68 | run_on_cpu(cpu, do_hvf_update_guest_debug, RUN_ON_CPU_NULL);
> | ^
> 3 errors generated.
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/9962088576

"hvf: only update sysreg from owning thread" missing:

-- >8 --
diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 3fc65d6b231..8c387fda24d 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -12,6 +12,7 @@
  #include "qemu/error-report.h"
  #include "system/hvf.h"
  #include "system/hvf_int.h"
+#include "hw/core/cpu.h"

  const char *hvf_return_string(hv_return_t ret)
  {
---

