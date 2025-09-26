Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BC3CAC5B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 18:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2Cyz-00066R-Fk; Fri, 26 Sep 2025 14:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v2Cyv-000620-QZ
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 14:15:47 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v2Cyo-0006qk-0z
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 14:15:45 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-77f1f29a551so3316435b3a.3
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 11:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758910528; x=1759515328; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rhEyu8bfBt8unG1DTjMeOH3PnADamHBw2zj4j4HAaAk=;
 b=PHsc8Zhw3YgDGJotqcApGg9LsbneUA71v7edEyXsNA+UhWxSLiQumKvbbo3r5hZ9C3
 n7trAov9U0LNpFPJCzswFk60DAs+dmPEQ/mJGibU0/q7MzlyleerXN3Xuuzx/lWrf3e5
 oLmF/sIp131bU+HVW/Jk7oPiieg3PyiSZy+j4AuGy5zMLjrNKRi5w/D6/qGLwcrl4NNq
 f8r1y6LhWShLb/unLCdoM4mghDPHN3JIbrqOLFn1LhIIwJKwToHnfmoSPCUrp4HGCbIk
 oiorNhwqBumXVHUVYR76ELAZcxEHujVLUCAtIgytFCvkfmTLGPllpTFP0FnD20ifpsPg
 QFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758910528; x=1759515328;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rhEyu8bfBt8unG1DTjMeOH3PnADamHBw2zj4j4HAaAk=;
 b=bCpPuMFT16qOG/lT4BTrKrULwfu+kcS88acAGTiLSpMYlzyC2fqK8/6Rc5kJjc/7E4
 gAMFgQ+Ez7QXenA9DoNZgeAp6cgoqD5mFmSDhdSrjnlWXQxD7K2fSuEgsVtFIKKLha9C
 VYCxqd72FstxwOTHIjoh78kYe3QpUlBwC1ZbjZjqqjKL8P0wGBXdx7H6QM265nV4I2UH
 kkO5RUgV+BXNk+tmQo5lSVagH34XhCOS3MKgHVnlp8RTnVj0WyrKEr9fPURW9ylVVUix
 40gAwyRb5Bx/GdcU6rrLeUEIDTQOWEg2CO+XhvlD6/naRU6FzWWZ11P/e9QQfYrpGlnY
 4SNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcrzQPJv22om69XhdAM6nYs1WV8Zi0oMdXx3UJFpl6rjU9ouULOqNNqZcyCyDVYFOAszlczlwvi36E@nongnu.org
X-Gm-Message-State: AOJu0Yw3UzfadT2W4hRwDfYGfMxUcQSY27bhGSaqLwuHchIWqZ7AOVLS
 w+1BhfXaKV/y/QcSHlSrSpIJL6BN7deqk9K8fzNPeS+7tpvXgM0+GgFg+SvwspAfPw0=
X-Gm-Gg: ASbGncubCOOGgi/4byJav2c/sDdQ2ae1Vlbo+EZvt76t+KVRGCBLm3BvVK7FiT5hyGg
 y6p92hfrHu36GjdStSJRNUDAQ4l3+AxNUmQWjmSQmi40v4GAtVi9CuIPY5sHdV5hoGV5Ye6T9r2
 V7rZPzwPDM9cuqhVOsO67MfrXPv3sv2ggILEAV0jJr/E8HH2aNWDnAQj6rJPYBzdX17NTt01O/u
 MidOwtEHnO/dEw44f8ViOD7dwJcNP3ix+117RGV5vbKEGd9jx8Kqg4ocy9StQQYP1BWFNdP5ERg
 br+Erd9wVcAwNvVlMaxFxHHqO7fCMitQ0UVhvRzUw/Cqahgm3KNJhhu3f4v3CB/5Qv4Mldo14MB
 gy6RcW5IG4DceAzs4Jr0wxBoQkuZaqUnFKU8qMfSIRSzeJbG/SZhfthX5l2Qx5zr8
X-Google-Smtp-Source: AGHT+IHGo6GJ99yrEtfeqWAhoNrG9INAC9cP6QZ5qggVCqug5Z2uQd2xekH3nAMuFQjFgeMuEAEwug==
X-Received: by 2002:a05:6a00:181b:b0:781:2177:1c9b with SMTP id
 d2e1a72fcca58-78121771e77mr2041252b3a.17.1758910527512; 
 Fri, 26 Sep 2025 11:15:27 -0700 (PDT)
Received: from [192.168.0.102] (189-47-45-49.dsl.telesp.net.br. [189.47.45.49])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7810238cafasm4976130b3a.4.2025.09.26.11.15.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Sep 2025 11:15:27 -0700 (PDT)
Message-ID: <599cd42e-0619-4556-ae70-b2d360e6405a@linaro.org>
Date: Fri, 26 Sep 2025 15:15:24 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/9] tests/functional: Provide GDB to the functional
 tests
From: Gustavo Romero <gustavo.romero@linaro.org>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, berrange@redhat.com
Cc: qemu-arm@nongnu.org, manos.pitsidianakis@linaro.org,
 peter.maydell@linaro.org
References: <20250926051542.104432-1-gustavo.romero@linaro.org>
 <20250926051542.104432-4-gustavo.romero@linaro.org>
 <a9118adc-f9ac-4df0-8e60-4407945a5908@redhat.com>
 <bd906237-c0fb-4921-a017-a591bc95f31f@linaro.org>
Content-Language: en-US
In-Reply-To: <bd906237-c0fb-4921-a017-a591bc95f31f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x430.google.com
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

Hi Thomas,

On 9/26/25 15:08, Gustavo Romero wrote:
> Hi Thomas,
> 
> On 9/26/25 07:03, Thomas Huth wrote:
>> On 26/09/2025 07.15, Gustavo Romero wrote:
>>> The probe of GDB is done in 'configure' and the full path is passed to
>>> meson.build via the -Dgdb=option.
>>>
>>> Because a single functional test can cover different arches, such as
>>> aarch64, ppc64, and x86_64, only a GDB that supports all the arches in
>>> the target list is passed to Meson for use in the functional tests. To
>>> handle this check, a new shell function, is_target_arch_in_arch_list, is
>>> introduced in 'configure'.
>>>
>>> Meson then can pass the location of GDB to the test via an environment
>>> variable: QEMU_TEST_GDB.
>>>
>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   configure                     | 21 +++++++++++++++++++++
>>>   meson_options.txt             |  2 ++
>>>   scripts/meson-buildoptions.sh |  2 ++
>>>   tests/functional/meson.build  |  6 ++++++
>>>   4 files changed, 31 insertions(+)
>>>
>>> diff --git a/configure b/configure
>>> index 0f7eb95586..20e05d233f 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -1142,12 +1142,31 @@ fi
>>>   #########################################
>>>   # gdb test
>>> +# Check if all target arches are in a provided list of arches.
>>> +is_target_arch_in_arch_list() {
>>> +    arch_list=$1
>>> +    for target in $target_list; do
>>> +        arch=${target%%-*}
>>> +        if test "${arch_list#*$arch}" = "$arch_list"; then
>>> +            # Target arch not in arch list
>>> +            return 1
>>> +        fi
>>> +    done
>>> +    return 0
>>> +}
>>> +
>>>   if test -n "$gdb_bin"; then
>>>       gdb_version_string=$($gdb_bin --version | head -n 1)
>>>       # Extract last field in the version string
>>>       gdb_version=${gdb_version_string##* }
>>>       if version_ge $gdb_version 9.1; then
>>>           gdb_arches=$($python "$source_path/scripts/probe-gdb-support.py" $gdb_bin)
>>> +
>>> +    if is_target_arch_in_arch_list "$gdb_arches"; then
>>
>> No TABs, please!
>>
>>> +            gdb_multiarch="yes"
>>> +        else
>>> +            gdb_multiarch=""
>>> +    fi
>>
>> This unfortunately does not work with the GDB from Fedora - it only supports "arch64_be arm riscv64 riscv32 ppc i386 s390x ppc64 aarch64 ppc64le x86_64", but if you configured a target like "alpha-softmmu", this breaks.
> 
> argh! ok
> 
> 
>> (BTW, does the gdb-multiarch from Debian/Ubuntu really also support exotic QEMU targets like tricore?)
> 
> No, I've checked GDB upstream and I can't see any trace of tricore.
> And I just saw that Alex left a comment in scripts/probe-gdb-support.py
> saying "# no tricore in upstream gdb", so nope, it seems that it still holds.
> 
> 
>> I think it would be better to drop this hunk, and rather check in the spot where we use GDB if the required target is really there (i.e. in the functional test that uses it).
> 
> OK. I'm also not a big fan of doing it in bash. How do you suggest
> to do it? Directly in the code, via a skipIf decorator, or something else?

$gdb_arches, obtained using scripts/probe-gdb-support.py in configure,
could be passed to meson and meson sets it in the test env, as we're
doing for $gdb_bin and QEMU_TEST_GDB env var. wdyt?


Cheers,
Gustavo

