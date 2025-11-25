Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D964DD0EE0D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 17:34:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNwv4-0005yo-94; Tue, 25 Nov 2025 12:33:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vNwul-0005iC-C6
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 12:33:21 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vNwui-0001OK-Rr
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 12:33:19 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3414de5b27eso4571601a91.0
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 09:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1764091995; x=1764696795; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4cOlhBBT6TLEtaxXJTpmTeLIUIcggYLoDf4sKiNxFvM=;
 b=CYkZd+TAzC17ikdUxpVQ8nqcNlO2x9XsLV+NvIAOJKJFle8SfaXK2sguQ3Gne7gPYu
 dvdx5ngvz2dR/gV/5CaZq0UXGfGYQKVYnv/VkjF99MWi/iBddCYBfDpmq3Pv9kdqyfV1
 AqyS7AmkkwUQLvHAnCJ/xDr2n6S51BEg/V2a5ET5dB/sJ3S9QLPQRFpMx9tA2jEOLwzL
 Hv9Qvyf760qC6jCMBOgmv8DXeHi4j7GAJd3KYEzMnygdsHgHCvbbHkK0Wolkj8gOdE4E
 lysTV4fJ9kza+wgds4GEM2oX9uKTGsQ/YUc4q5XHt5DVXxoDVHKGytE2fcvHfYV0x6zh
 J0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764091995; x=1764696795;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4cOlhBBT6TLEtaxXJTpmTeLIUIcggYLoDf4sKiNxFvM=;
 b=TX0G/euYvIjlveSVBsklkQuvT93H+gUUtjvMQyiTRESpNW1j/Au/TwJsSTyc7vmsT2
 OdRbkLCp7cyNFRmOT+P18w3IjZwc8ueC0jW2xbPOesHZBtLtfirrDroqEOU3CdRRe6ot
 VdmYRpFFne/zi5PfU17kXdDUomSOB/a52yB+AY9bwHb8DD1q+bTHwDUOTtJ/EODjS2rl
 Hhs8SNtKFirjtnma4LCN3dw0dKcI29bjYzREW6WDrM0L9dxXeceWxnRtqSLFTe6hkLSV
 k20Uc4nufAXSWXC4Udk4fqmrt3nALqkAByRmrq+HY4CteCT0kmNuBoM2KCSm8/JAhDFh
 7vOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuqsoqwj5KF559MVnXpYNnnSEG+flT07CJICDLm/E28CWM8hzUxaVXSZh2rkZKzqjh5vdR82Ew49b9@nongnu.org
X-Gm-Message-State: AOJu0YzfsoU2b2uRGyNauROvzJioqUTIaaR64Ofb9M1soL3zWqI9e2Y1
 AUTe996zkieR8gGC3js5DuXsqnpuaz4EproKbEsuhngvm9wlok/LGql18Ec9y0ocbO4=
X-Gm-Gg: ASbGncszE9VOdam4b7JVE5PSabRWLM1cqbQPtVrUP+2KH0Tlo3qipQqoHrfWzk1Q3KZ
 7Ghouu6Dh4d/IM0zX2kaJfnFgM9ZMNCEoD5WrRemw0wNU3y3RTm5a06k2MSZxIVM5tv0+kqxR5V
 aiDhM9bChKbwHbS6ZpSaHU5FMT6mBJhCgSpRi0t1DXFDKxIcPadNGS7xNMtlDMWpiJNcK2yLcis
 rYLh56UchdBIBYqVEvF/VqTqHaCia7+uigYtHyo1Dinp0i4D8bzcl6U2OiX6L2eT9UhRf6+30VX
 Br8b8iHXQB7yu34mskxF9yfE4/WXhTrUxpPSzz9SqYmwy0mXXC9nvNXyKx0npvXQBipz31uZuxz
 zgAReBe7DVMDdnMZ9Scsj66TYj005Nrrte3cTNHHXF6qWi9xRoUSks50hgCc0ZLXVdhZwFMzRbG
 Vpcp58CGTJPPgbZjnjrco/hdo6Ow==
X-Google-Smtp-Source: AGHT+IF+k1XI6jD+Cu2Yk8po/yULtZGxER4bUNGlcrR67HkbxyQMeTdvPmZKvh3QqbENlBYA4ej6IA==
X-Received: by 2002:a17:90b:1345:b0:343:7f04:79c1 with SMTP id
 98e67ed59e1d1-34733e8f60bmr14977276a91.9.1764091994710; 
 Tue, 25 Nov 2025 09:33:14 -0800 (PST)
Received: from [192.168.68.110] ([179.133.97.212])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7c3f0b62e95sm18912472b3a.49.2025.11.25.09.33.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Nov 2025 09:33:14 -0800 (PST)
Message-ID: <63fb31b9-23e7-40fc-b7ba-fc03c69d2b1b@ventanamicro.com>
Date: Tue, 25 Nov 2025 14:33:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] hw/riscv, target/riscv: initial e-trace support
To: Konstantin Semichastnov <k.semichastnov@syntacore.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com
References: <20251111114656.2285048-1-dbarboza@ventanamicro.com>
 <115a56af-4db1-42ee-9541-8077322207c7@syntacore.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <115a56af-4db1-42ee-9541-8077322207c7@syntacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1033.google.com
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



On 11/20/25 9:14 AM, Konstantin Semichastnov wrote:
> 
> 
> On 11/11/25 14:46, Daniel Henrique Barboza wrote:
>> Hi,
>>
>> In this v2 we're addressing a review comment from Konstantin in patch
>> 14. We're also doing changes in the FDT (patch 5) to keep up with the
>> changes that the kernel support is making [1].
>>
>> I've been thinking about adding partial support for N-trace in this work
>> as well. From what I can tell the difference between N-trace and E-trace
>> are the encoding of the packages, with everything else staying the same.
>> In this case we could add hooks in the code to be ready to support
>> N-trace encoding in the future.
>>
>> No other changes made. Patches based on current master.
>>
>> Changes in v2:
>> - patch 5:
>>    - changed tr_compat from "ventana,veyron-v2-trace" to "qemu,trace-component"
>>    - renamed trace encoder prop handler "cpu" to "cpus"
>> - patch 14:
>>    - removed updiscon generation in gen_jal()
>> - v1 link: https://lore.kernel.org/qemu-riscv/20251002112335.2374517-1-dbarboza@ventanamicro.com/
>>
>>
>> [1] https://lore.kernel.org/linux-riscv/20251101154245.162492-1-apatel@ventanamicro.com/
>>
>> Daniel Henrique Barboza (16):
>>    hw/riscv: Trace Encoder initial impl
>>    hw/riscv: Trace RAM Sink initial impl
>>    hw/riscv/trace-encoder: add trace start/stop logic
>>    hw/riscv/virt.c: add trace encoders and trace ram sinks
>>    hw/riscv: add e-trace message helpers
>>    target/riscv: add initial trace instrumentation
>>    hw/riscv/trace-encoder: write e-trace packets to RAM sink
>>    test/qtest: add riscv-trace-test.c
>>    hw/riscv/rv-trace-messages.c: add encoded trap message
>>    hw/riscv, target/riscv: send trace trap messages
>>    target/riscv, hw/riscv: send trace ppccd packets
>>    hw/riscv/trace: add format2 msg helper
>>    hw/riscv, target/riscv: send resync updiscon trace packets
>>    hw/riscv/rv-trace-messages: add format 1 msgs with branch info
>>    hw/riscv/trace-encoder: send branches info
>>    hw/riscv/trace: update branch bit in sync messages
>>
>> Mayuresh Chitale (1):
>>    hw/riscv/virt.c add trace encoder and ramsink fdt nodes
>>
>>   hw/riscv/Kconfig                              |   5 +
>>   hw/riscv/meson.build                          |   2 +
>>   hw/riscv/rv-trace-messages.c                  | 373 +++++++++++
>>   hw/riscv/rv-trace-messages.h                  |  40 ++
>>   hw/riscv/trace-encoder.c                      | 609 ++++++++++++++++++
>>   hw/riscv/trace-encoder.h                      |  62 ++
>>   hw/riscv/trace-events                         |   9 +
>>   hw/riscv/trace-ram-sink.c                     | 263 ++++++++
>>   hw/riscv/trace-ram-sink.h                     |  83 +++
>>   hw/riscv/virt.c                               | 135 ++++
>>   include/hw/riscv/virt.h                       |   2 +
>>   target/riscv/cpu.h                            |  11 +
>>   target/riscv/cpu_helper.c                     |  26 +-
>>   target/riscv/helper.h                         |   6 +
>>   .../riscv/insn_trans/trans_privileged.c.inc   |  11 +
>>   target/riscv/insn_trans/trans_rvi.c.inc       |  15 +
>>   target/riscv/meson.build                      |   3 +-
>>   target/riscv/tcg/tcg-cpu.c                    |   5 +
>>   target/riscv/trace_helper.c                   |  62 ++
>>   target/riscv/translate.c                      |  19 +
>>   tests/qtest/meson.build                       |   2 +-
>>   tests/qtest/riscv-trace-test.c                | 120 ++++
>>   22 files changed, 1860 insertions(+), 3 deletions(-)
>>   create mode 100644 hw/riscv/rv-trace-messages.c
>>   create mode 100644 hw/riscv/rv-trace-messages.h
>>   create mode 100644 hw/riscv/trace-encoder.c
>>   create mode 100644 hw/riscv/trace-encoder.h
>>   create mode 100644 hw/riscv/trace-ram-sink.c
>>   create mode 100644 hw/riscv/trace-ram-sink.h
>>   create mode 100644 target/riscv/trace_helper.c
>>   create mode 100644 tests/qtest/riscv-trace-test.c
>>
> Hi, I am currently working on adding the N-Trace message format, based on your v1 patch set. Currently I have supported ProgTraceSync, ProgTraceCorrelation, ResourceFull, IndirectBranchHist, IndirectBranchHistSync, Ownership messages.
> 
> After finishing the internal review and rebasing over the v2 patch set, I would like to send it here next week.

That's awesome! Let me know if you need any change to be made in this base series
to properly support N-trace.


Thanks,

Daniel

> 
> Konstantin


