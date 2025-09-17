Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6E6CA0EE8
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 10:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uypqz-00029X-G2; Wed, 17 Sep 2025 06:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uypqx-00028X-Bq
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 06:57:35 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uypqv-0001A0-Cs
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 06:57:34 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-633a2be31daso1196070d50.1
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 03:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1758106652; x=1758711452; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=84c3VNroE74AFp+IRcBXBbLbxAvwpiB2t7NxUceco40=;
 b=CrLhSkIImfE+6AX+92vy37Ka1/uJe+kRPheR2uiDWUbttLZ3E/xhmYLhAhLdNNPo4N
 ujX3BLz3jyVDHn40M3QdII5LN1Cl5hcuK5XxaAFEAPuvVGVR3l2egxWfTIZyxKc6TsUF
 MBFArqrekIlmKDa/iiWhdWK7AMHo24dMQG+VY7Ncmo+EHGijBj/K3rejscBlyYMnPxOe
 wdDUxW7s3FeQdhQANLT2erwvO14N7zIp7XT7lHjDGRAzNWsZcOEEwtX/UG1gy2l3Uu9X
 yZdyOqPgS7SD2OHLhmuuw86lOvehdHTj3xk9ORZy973K0oS/Zz2hKPT8ePwyCBOeqtVh
 cjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758106652; x=1758711452;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=84c3VNroE74AFp+IRcBXBbLbxAvwpiB2t7NxUceco40=;
 b=GKQDTuF6Tms46DWeHkmjQJRYHjOOmXeQ6NmP3sdHP6gYysVXgaSKwudKhMOcb9IHgM
 Soqm/JzmgouPdxaNL2VFt9mFcbENYC312Q3k5eGSgl0BCFKT0goHo9Fgn9mlD6kDmoTH
 +1plYrbcQthmQ6QfJKO/9mgbjFl8e7sg4kF4rYQUP4OJ43TjnQydHVrsTsRB3yVlQ8qR
 nvlWat0z9lSiQu9/b4ce0hhmtB/kxlo0w3pgLoDW42OLJ81CHSptiqIuhq3fdwt8zZ2b
 Th6NGYTVNbuhBVlj9QllLAt/FsCBlGseW6yIUa2J/aBV/jTh8RJ3zv+mKg3gqVoNVHhN
 ED6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXJUvSGAw//c57TlLGaxwQyNJ5RNXVj4FiPi3Tld0sEiURmrXi5yNNO7yxdkociZ/snVZYI8lkrRQA@nongnu.org
X-Gm-Message-State: AOJu0YxQDIO3tr6b0hd7vwWcHDb9gfoaSjA36yDtUluAUW1RgK0uWK3q
 kXk0SpTNDU37mlDQcuq6hZbDH7dwykJBb9c8ztima0BA/+82Q31AV4uqPUtpGCftOQs=
X-Gm-Gg: ASbGncsJjoxK33GWIaNnsKPHYhBg/Jr9pvoasICTg+Cdu7E+brb0dlPNRmEipcBOYN3
 fNUqQJLoRf4epf5NLK/uK2mPa1hwex0pUdz7tLeUSwNX/9vuvohLIQ6/c4A9QCaoWHUMrTnN4Ci
 rdT4coAP+5/UNRdUk9ISAkTjSPwh2Qv0JG0QzEYfT1HWz+q2OJAADGPIheMFqmWPPDdr5rmPpDB
 SHl8nnh2uGEbZa1oL8mdKNa9lKKF41fXCnc/ZA/PoaOf/GuGpNYZvPea6zxcxfEqPDpOyK1M/en
 gXEWHMNAVAElKRB4w3BhCUqIo8DUCFdWTLiwHoOKer6f3k6Kp6nlqy3BlTUE7eBmp7U1qWTc81I
 7XqmX97XL0ZrfG1jPDLssNydt+fxasig6zi4FIbIE+oKVRFLUZbryUMtN391b52hXyfI3VP0siJ
 LM
X-Google-Smtp-Source: AGHT+IHnqh1G2sdGSoptdgCUBAzThJtOWQn4mTUCmO6+8UOXhnUpS9of7RnYshOIAhXrHJ2x886k/Q==
X-Received: by 2002:a05:690e:42c9:b0:5fa:d9ec:9963 with SMTP id
 956f58d0204a3-633b0736cd3mr896229d50.19.1758106651953; 
 Wed, 17 Sep 2025 03:57:31 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bcc0:ba1a:8719:7c4c:526a:fdea?
 ([2804:7f0:bcc0:ba1a:8719:7c4c:526a:fdea])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-72f79a8b7e2sm47523197b3.64.2025.09.17.03.57.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Sep 2025 03:57:31 -0700 (PDT)
Message-ID: <cbef8903-8927-4db0-93ba-c5a5ae7241c8@ventanamicro.com>
Date: Wed, 17 Sep 2025 07:57:28 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] target/riscv: Implement SMSDID and SMMPT extension
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com
References: <20250909132533.32205-1-zhiwei_liu@linux.alibaba.com>
 <1d82761a-a968-467b-96ca-427bca7edc65@ventanamicro.com>
 <192bf4d1-f519-4303-9636-e6d572971553@linux.alibaba.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <192bf4d1-f519-4303-9636-e6d572971553@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yx1-xb12a.google.com
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



On 9/16/25 10:40 PM, LIU Zhiwei wrote:
> 
> On 9/16/25 8:49 PM, Daniel Henrique Barboza wrote:
>> Hi!
>>
>> On 9/9/25 10:25 AM, LIU Zhiwei wrote:
>>> This patch set introduces support for the RISC-V Smmpt (Supervisor
>>> Domain Access Protection) extension. It only includes two sub-extensions:
>>> SMSDID and SMMPT.
>>>
>>> This patch set implements the v0.3.4 version of Smmpt
>>> (https://github.com/riscv/riscv-smmtt/releases/tag/v0.3.4).
>>>
>>> As there are newer SMMPT specification versions, this patch set is
>>> not intend for merging.
>>
>> I'm not sure I understood. Do you mean this patch set isn't supposed to be
>> merged even after review?
>>
> 
> Hi Daniel,
> 
> Thanks for the follow-up.
> 
> My primary goal is to have this feature merged eventually. I marked this version as "not for merging" because I'm aware it's based on an older specification, and I plan to update it to the latest one.
> 
> However, if the community finds this specific version (v0.3.4) useful for current development, such as for CoVE or other ongoing work, I am open to having it merged as is.

Having any implementation merged is better than no implementation. As long as we document
it properly I don't see any problems. Let people use it for their own work and we can
update it to a newer version as we go along.


Thanks,

Daniel


> 
> In any case, I will continue to work on an implementation aligned with the newest specification. I would greatly appreciate any review comments or feedback on the current approach.
> 
> Best regards,
> Zhiwei
> 
>>
>> Daniel
>>
>>>
>>> The implementation is broken down into a series of logical steps:
>>>
>>> Patch 1 adds the fundamental definitions for the Smmpt extension,
>>> including
>>> new CSRs (mmpt, msdcfg), their bit-field layouts, and the corresponding
>>> CPU
>>> configuration flags (ext_smmpt, ext_smsdid).
>>>
>>> Patch 2 introduces the core logic for Memory Protection Table (MPT)
>>> lookups.
>>> It includes a new file, riscv_smmpt.c, which implements the multi-level
>>> table walk to determine permissions for a given physical address.
>>>
>>> Patch 3 integrates the MPT permission checks into the main MMU and TLB
>>> handling pathways. This ensures that both page table walks and final
>>> data accesses are subject to Smmpt protection rules.
>>>
>>> Patch 4 adds support for the new fence instructions defined by the Smmpt
>>> extension, specifically `mfence.spa` and `minval.spa`.
>>>
>>> Patch 5 enables smmpt and smsdia extendion.
>>>
>>> With this series, QEMU can now model systems that utilize the Smmpt
>>> extension for enhanced memory security.
>>>
>>> LIU Zhiwei (5):
>>>    target/riscv: Add basic definitions and CSRs for SMMPT
>>>    target/riscv: Implement core SMMPT lookup logic
>>>    target/riscv: Integrate SMMPT checks into MMU and TLB fill
>>>    target/riscv: Implement SMMPT fence instructions
>>>    target/riscv: Enable SMMPT extension
>>>
>>>   target/riscv/cpu.c                            |   4 +
>>>   target/riscv/cpu.h                            |   9 +-
>>>   target/riscv/cpu_bits.h                       |  27 ++
>>>   target/riscv/cpu_cfg_fields.h.inc             |   2 +
>>>   target/riscv/cpu_helper.c                     |  81 +++++-
>>>   target/riscv/csr.c                            |  83 ++++++
>>>   target/riscv/insn32.decode                    |   2 +
>>>   .../riscv/insn_trans/trans_privileged.c.inc   |  30 ++
>>>   target/riscv/meson.build                      |   1 +
>>>   target/riscv/pmp.h                            |   3 +
>>>   target/riscv/riscv_smmpt.c                    | 273 ++++++++++++++++++
>>>   target/riscv/riscv_smmpt.h                    |  38 +++
>>>   12 files changed, 548 insertions(+), 5 deletions(-)
>>>   create mode 100644 target/riscv/riscv_smmpt.c
>>>   create mode 100644 target/riscv/riscv_smmpt.h
>>>
>>


