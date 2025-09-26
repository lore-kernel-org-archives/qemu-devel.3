Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0318CAC5B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 18:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2CsM-00049j-VK; Fri, 26 Sep 2025 14:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v2CsI-00049I-Fd
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 14:08:54 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v2Cs9-0004pe-G2
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 14:08:53 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7704f3c46ceso2460383b3a.2
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 11:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758910118; x=1759514918; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8JcLycoO1lSHWStAilne7Mz1b/F0Ltls0w2ntFWmrbQ=;
 b=h2B0Hc5YY9Gv3MIAEWB2rS4GYgB/fSeylblaSznTrusKDsQy9OQrB7pweJthQu0tFk
 tS3dPx4MvKZz2j42a65MiYMuffzmqQfkuRKydtbsGRhLKZcQUGMdZSJPDwihEaYCzJcD
 8QTBCXpM8ISi+hMKkkj218JMreZE9XjTE1oUNCKGO7dfnKrIOiTE2TGjtFzTPGoTL1bh
 lZ22X63slmAwMc3vuPJ0g/vVNa2lEcifH+uMWiRmBACD/ZsCGt/QHGef6/sMg4RNsiIf
 KKlbqUuYi4/kfihLfbVgju9qglpuUgga6vvXRLX9NWhIsk0J/+wNVn4XAKTX+/o+4LKa
 uUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758910118; x=1759514918;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8JcLycoO1lSHWStAilne7Mz1b/F0Ltls0w2ntFWmrbQ=;
 b=Maf1gg+SOxZx8vBBKU+5vF5JaQssGVy4FidYFjq9HXdftta3N8YiPtdUoivBBzryNm
 OSJ9PTtxTk9MhZEQPaCYO9C68IDd1alEUYSPGeyqKVdJ1rlUZ8tIfKPzdsOrMNuVh9Hg
 4UWAuZ0lTySujn786hz7OPra4O09jVwGz+mMGtizxfZXK92aBdXlciAKgBb9CSsJAl3m
 sqylf+XizQDWSH8PsXBeWCL0IlSb//RSjrZGRTeSGIVU/KclBZ8xvkiyO6ekNszBgvvK
 Q9/B8HaFuHSZWk/EjXbohhvNlgm0Q60N6wuUIpjvTD3B9RQ7Wye/Sx2Pac/E1bmAVitG
 PysQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWu41v9KZ88dosX4UieXa2JSYAg5a4V+jNeuSMCrW+Mht045R1/q8eGK8GUK06z7LS8KvsxWxCQQvQs@nongnu.org
X-Gm-Message-State: AOJu0YwotZWGFAzRUaXe80KxY+WegxJfUr28VrfxY4ffQGlxZ6u3S0sZ
 AYpRBuBUBzhcNpk63uYYN4SqKSnZAVUaeeL8MqX2ubIIYJirvlRO47DgCWZs2U5a4c4=
X-Gm-Gg: ASbGncu6lyk1zpsYmClIbjgJHz25v02zYQaEwTBMMqjlwA7F938Ia9ZrlRFCSkpqM7T
 BNnqZY/QpwjgpaJlOD8nWa5lEH4xSRaYoRpCISX9E1fAhpc14n2YQ+XnJoSJ9tNMaIWrwf4WmUW
 nwv83ln5FFZDzQ3hGtEz1yMEb0ll91v7NbSKIrodSJEOHtb4dZLesoYFq8CQmA7sEoauhsH2Bil
 9R73h8rOL9zk8q3mJzY4VnHWCZCRuXVGwtbzozF+pyFCSe/qjdPdsrN2dfT5HDjCPcgqR58C3E+
 chjRO02u8jadbwbify314ww/wAiVPXbCBQ49ebQLoeq9TvH4oTQpajn88cWBPXSweDg3gky9JN5
 2IimAZmy1kbMUDUo427n2f6G5mwhodDyOdDLoWf0V1/GKo9UMVAzoCMGOdmWwGarpWnV4FwHUFe
 sIrSlb9uqC1Q==
X-Google-Smtp-Source: AGHT+IHRBtYO8iojq1hnBjXKKAfChvwNEaO51o2Aa9J/APsdNoOMuXbrRuYPQguIU2Vy7XAQQ+TOnQ==
X-Received: by 2002:a05:6a20:6a1c:b0:262:52de:c577 with SMTP id
 adf61e73a8af0-2e7ce91f433mr9593532637.34.1758910117830; 
 Fri, 26 Sep 2025 11:08:37 -0700 (PDT)
Received: from [192.168.0.102] (189-47-45-49.dsl.telesp.net.br. [189.47.45.49])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78102c06ff4sm4823126b3a.86.2025.09.26.11.08.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Sep 2025 11:08:37 -0700 (PDT)
Message-ID: <bd906237-c0fb-4921-a017-a591bc95f31f@linaro.org>
Date: Fri, 26 Sep 2025 15:08:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/9] tests/functional: Provide GDB to the functional
 tests
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, berrange@redhat.com
Cc: qemu-arm@nongnu.org, manos.pitsidianakis@linaro.org,
 peter.maydell@linaro.org
References: <20250926051542.104432-1-gustavo.romero@linaro.org>
 <20250926051542.104432-4-gustavo.romero@linaro.org>
 <a9118adc-f9ac-4df0-8e60-4407945a5908@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <a9118adc-f9ac-4df0-8e60-4407945a5908@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 9/26/25 07:03, Thomas Huth wrote:
> On 26/09/2025 07.15, Gustavo Romero wrote:
>> The probe of GDB is done in 'configure' and the full path is passed to
>> meson.build via the -Dgdb=option.
>>
>> Because a single functional test can cover different arches, such as
>> aarch64, ppc64, and x86_64, only a GDB that supports all the arches in
>> the target list is passed to Meson for use in the functional tests. To
>> handle this check, a new shell function, is_target_arch_in_arch_list, is
>> introduced in 'configure'.
>>
>> Meson then can pass the location of GDB to the test via an environment
>> variable: QEMU_TEST_GDB.
>>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   configure                     | 21 +++++++++++++++++++++
>>   meson_options.txt             |  2 ++
>>   scripts/meson-buildoptions.sh |  2 ++
>>   tests/functional/meson.build  |  6 ++++++
>>   4 files changed, 31 insertions(+)
>>
>> diff --git a/configure b/configure
>> index 0f7eb95586..20e05d233f 100755
>> --- a/configure
>> +++ b/configure
>> @@ -1142,12 +1142,31 @@ fi
>>   #########################################
>>   # gdb test
>> +# Check if all target arches are in a provided list of arches.
>> +is_target_arch_in_arch_list() {
>> +    arch_list=$1
>> +    for target in $target_list; do
>> +        arch=${target%%-*}
>> +        if test "${arch_list#*$arch}" = "$arch_list"; then
>> +            # Target arch not in arch list
>> +            return 1
>> +        fi
>> +    done
>> +    return 0
>> +}
>> +
>>   if test -n "$gdb_bin"; then
>>       gdb_version_string=$($gdb_bin --version | head -n 1)
>>       # Extract last field in the version string
>>       gdb_version=${gdb_version_string##* }
>>       if version_ge $gdb_version 9.1; then
>>           gdb_arches=$($python "$source_path/scripts/probe-gdb-support.py" $gdb_bin)
>> +
>> +    if is_target_arch_in_arch_list "$gdb_arches"; then
> 
> No TABs, please!
> 
>> +            gdb_multiarch="yes"
>> +        else
>> +            gdb_multiarch=""
>> +    fi
> 
> This unfortunately does not work with the GDB from Fedora - it only supports "arch64_be arm riscv64 riscv32 ppc i386 s390x ppc64 aarch64 ppc64le x86_64", but if you configured a target like "alpha-softmmu", this breaks.

argh! ok


> (BTW, does the gdb-multiarch from Debian/Ubuntu really also support exotic QEMU targets like tricore?)

No, I've checked GDB upstream and I can't see any trace of tricore.
And I just saw that Alex left a comment in scripts/probe-gdb-support.py
saying "# no tricore in upstream gdb", so nope, it seems that it still holds.


> I think it would be better to drop this hunk, and rather check in the spot where we use GDB if the required target is really there (i.e. in the functional test that uses it).

OK. I'm also not a big fan of doing it in bash. How do you suggest
to do it? Directly in the code, via a skipIf decorator, or something else?


Cheers,
Gustavo

