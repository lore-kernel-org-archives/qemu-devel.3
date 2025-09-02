Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4839ACA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utROK-0003mQ-0h; Tue, 02 Sep 2025 09:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utROG-0003fC-RI
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:49:40 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utROA-0001mR-7Z
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:49:40 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45b883aa3c9so16933875e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756820970; x=1757425770; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r/PgtYDlAZgGkBjrM0vYB8lmsKLahB55EiWXMvrk1gY=;
 b=g1XbOPVvq/goy3khbuBiAX/9h4xaz/Pirmax9uyn6CNFfKQ/bZoUlBM8/qFAi9a/LS
 MN1aNltTT6LKmhxIzSsA4+8YPVwp8Ukhp7CTJrmyLfCQ7CKlfuVJP+OC2jDUeoiHtvf6
 7zT20oCzPaEIuviQpIztfYF/WIUrLr80S9mVQqMeNiYlKvb4ge/y8op5q39E8spRbKVL
 yyD4i2M2xHQGGxwBxbxKNYuyLrEkUn5CWNyqblAeBHCSrvvN66PuJPZUl6+tx29cRmlp
 75ZdxNfExHcw+uDkx7oaaSN21IGBmAPZybXkH1EQBPoMQqGdUSBT0ZSRIUbFITUvzeBn
 NI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756820970; x=1757425770;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r/PgtYDlAZgGkBjrM0vYB8lmsKLahB55EiWXMvrk1gY=;
 b=HZyrvs9oPyCJO1MigreUoXxW7ye9v0/Q0+2lyKzFdSfTfVEVx5ynbwd55MKQ7JBwRV
 HrYbVq8Ag7EOWwNJm7rBOYuLRp8XBQBfaB9IAzxXP+XdQ5/O5LeBW2xRJoYFgcwZ3wey
 xZbCvU8NlV6GrwT3xLVjfycTB0FOLxTMYFjnAZWUeVCIXv73/3B/19FgsdDz/b/BuBLh
 D5fXU8vO4bH425OcVOMwfK6ho3w9TzJKG6O1YMzksj2AfnWY6p96GK8o05fx2MfTpN6K
 Xy00g84FJGmdAT7geM6T0QvSoFEKrWmhJ+jvnN+yIpL8TGohn+fVgU7NR3lveZE2+GLT
 AcEg==
X-Gm-Message-State: AOJu0YxvIntmeXmFaNLzNu7mb8Nk1u2DQS1rV196HKLwsxiISO2k6Oi0
 GRqxPpcs7ePfwwJMFEu4SYkc4UWof8HFMNA924T97wkMUxioJU+trEO4rzME3b2vpoCETtHCqmb
 7j0ee
X-Gm-Gg: ASbGncveJ5lzoukOvzfJ3rw7/O+5Bz1n22pIqRf+L/+ZKITehI/EHG3PlJR87MAEri1
 7XMfnn4WMvYqv8l2cQjV5rwzdtdyi2kfmH1znH16NDwtLIasjYW5JDk7lGTV6TKo9YJS60LeUbQ
 4NV448EZJyEvpKdcioZ/KZRGdba7p1Jm7Q6A1lVSGPrtTAnzpVti6eCmKTBXsjA6uHfkRw0LUI2
 edZjZDLB9OoTAe+/jIdg9ExBHSZ0qEwcIMmdmuVe2MCBY+BQe1cLlAWE/+p/jW0BrnMDOJ3oNTQ
 kqX43DEMkBYcBHHDL3Z0+LUuldOLpV0Bun9qAHQogX27JZMGsEz7SV0fcwu9BHv++RWudrnEZm3
 y/Rcb289RiwvsyxpQJUd13Y2fh7j4gbFkN7F0OqPp1pnRNYYsBlZNC1Ti5CURwlrPTg==
X-Google-Smtp-Source: AGHT+IFaFQc2YDpKn4pXZdJ0MZWNf5FxUalHPCs9Hx6CuWVdT1HFx21txLSkuRo9+7BOxzPUWPJM1Q==
X-Received: by 2002:a05:600c:1d1c:b0:45b:8adf:cf0b with SMTP id
 5b1f17b1804b1-45b8adfd0b5mr81524115e9.5.1756820970071; 
 Tue, 02 Sep 2025 06:49:30 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b93fae643sm45411725e9.3.2025.09.02.06.49.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 06:49:29 -0700 (PDT)
Message-ID: <41c83d3f-e5dc-42c5-a743-1aafc4cce27a@linaro.org>
Date: Tue, 2 Sep 2025 15:49:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 00/42] accel/split/arm: Run EL2 using TCG and
 EL1/EL0 in hardware with HVF
To: qemu-devel@nongnu.org, Salil Mehta <salil.mehta@huawei.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Alexander Graf <agraf@csgraf.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Cc'ing Salil

On 20/6/25 19:27, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> This RFC is a proof-of-concept we can have QEMU run both software
> emulator (TCG) and hardware accelerator (here HVF). Unfortunately
> I'm exhausted so I'll let Alex explain what this is about,
> otherwise I'll post the real cover letter next Monday after
> getting some rest.
> 
> Full work available in the split-accel-rfc-v5 tag:
> https://gitlab.com/philmd/qemu/-/commits/split-accel-rfc-v5
> 
> Regards,
> 
> Phil.
> 
> Julian Armistead (1):
>    accel/split: Minimal stubs for split accelerator
> 
> Philippe Mathieu-Daudé (41):
>    accel/split: Define SplitAccelState
>    accel/split: Implement cpus_are_resettable()
>    accel/split: Implement accel_init_machine()
>    accel/split: Expose 'hw' and 'sw' properties
>    accel/split: Empty setup_post()
>    accel/split: Implement supports_guest_debug()
>    accel/split: Implement gdbstub_supported_sstep_flags()
>    accel/split: Add cpu_thread_routine() stub
>    accel/split: Define and allocate AccelCPUState
>    accel/split: Register MTTCG
>    accel/split: Have thread routine ready to dispatch over HW/SW
>    accel/split: Implement cpu_reset_hold()
>    accel/split: Implement synchronize_post_init()
>    accel/split: Implement synchronize_pre_resume()
>    accel/split: Implement synchronize_state()
>    accel/split: Implement synchronize_post_reset()
>    accel/split: Implement synchronize_pre_loadvm()
>    accel/split: Implement kick_vcpu_thread()
>    accel/split: Implement cpu_common_realize()
>    accel/split: Set use_hw in cpu_thread_routine() and switch over
>    accel/split: Add few trace events in cpu_thread_routine handler
>    target/arm: Implement SysemuCPUOps::can_accelerate() handler
>    accel/split: Implement handle_interrupt()
>    accel/split: Empty ops_init()
>    accel/split: Empty set/get_virtual_clock()
>    accel/split: Empty get_elapsed_ticks()
>    accel/split: Empty cpu_thread_is_idle()
>    accel/split: Kludge qemu_tcg_mttcg_enabled()
>    accel/split: Implement remove_all_breakpoints()
>    accel/split: Implement remove_breakpoint()
>    accel/split: Implement insert_breakpoint()
>    accel/split: Implement update_guest_debug()
>    accel/split: Implement get_[vcpu]_stats()
>    target/arm: Emulate EL2 under TCG
>    target/arm: Have ERET switch to hw accel for EL0/EL1
>    accel/hvf: Emulate HVC at EL2
>    accel/tcg: Introduce TCGCPUOps::rebuild_tb_hflags handler
>    target/arm: Implement TCGCPUOps::rebuild_tb_hflags()
>    accel/split: Call TCGCPUOps::rebuild_tb_hflags()
>    tests/functional: Add split_available() helper
>    tests/functional: Test Aarch64 virt machine with split-accelerator
> 
>   meson.build                                 |   1 +
>   accel/split/split-accel.h                   |  54 +++
>   accel/split/trace.h                         |   2 +
>   accel/tcg/internal-common.h                 |   1 +
>   include/accel/tcg/cpu-ops.h                 |   2 +
>   include/exec/cpu-common.h                   |   1 +
>   include/system/accel-ops.h                  |   8 +
>   target/arm/cpu.h                            |   2 +
>   accel/split/split-accel-ops.c               | 381 ++++++++++++++++++++
>   accel/split/split-all.c                     | 196 ++++++++++
>   accel/tcg/cpu-exec.c                        |   9 +
>   accel/tcg/tcg-accel-ops.c                   |   1 +
>   accel/tcg/tcg-all.c                         |   1 +
>   system/vl.c                                 |   4 +
>   target/arm/cpu.c                            |   9 +
>   target/arm/cpu64.c                          |   7 +-
>   target/arm/hvf/hvf.c                        |   6 +
>   target/arm/tcg/cpu-v7m.c                    |   1 +
>   target/arm/tcg/helper-a64.c                 |   9 +
>   target/arm/tcg/hflags.c                     |   5 +
>   accel/Kconfig                               |   6 +
>   accel/meson.build                           |   1 +
>   accel/split/meson.build                     |   9 +
>   accel/split/trace-events                    |   9 +
>   python/qemu/utils/__init__.py               |   3 +-
>   python/qemu/utils/accel.py                  |  10 +
>   tests/functional/meson.build                |   1 +
>   tests/functional/qemu_test/testcase.py      |   4 +-
>   tests/functional/test_aarch64_virt_split.py |  69 ++++
>   29 files changed, 808 insertions(+), 4 deletions(-)
>   create mode 100644 accel/split/split-accel.h
>   create mode 100644 accel/split/trace.h
>   create mode 100644 accel/split/split-accel-ops.c
>   create mode 100644 accel/split/split-all.c
>   create mode 100644 accel/split/meson.build
>   create mode 100644 accel/split/trace-events
>   create mode 100644 tests/functional/test_aarch64_virt_split.py
> 


