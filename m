Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2E8C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 15:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZXSU-0005zF-2p; Thu, 01 Aug 2024 11:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZXSR-0005vi-Um
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:11:12 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZXSP-0001NP-8y
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:11:11 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-428141be2ddso46663825e9.2
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 08:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722525067; x=1723129867; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LtzYU4EAQ/64KGY5dkVWVMjhw64MBBfi7ihRWhb5tSM=;
 b=Ik4s2WVcB1A4mUjRRvlXiYthX8K/gdpiXrvjbU0MhZf6LVnrbtupyppDrOqRV+xCGU
 Xp230DkwkIqb7qkCHKPOV4K0irVfPOB+1kvbVknp2xis878aSPRSHtoxwj3rYGH8ExaC
 QYuFPJ5EsUIyvT7udT8RMsMhsr401Kqpxda/1O/Oxy+aLSZ2LIVweyV/vveB11X5zvkV
 /epbGvs1ntulzF+orIvU8Pfdj3xkZ1skmt03RlE84lsjeVfCRKPIxBYuOTZmkF9/Wz4J
 B2dKPlI2512vLe52vAlKax1ADfEOgPA7r2hT/+xtcVOJUN9SyOpmC2cGifjak5z8RdzK
 PPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722525067; x=1723129867;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LtzYU4EAQ/64KGY5dkVWVMjhw64MBBfi7ihRWhb5tSM=;
 b=VqfCTQp8utYP5PvYLyVEeJnmJCK40ZTCFC/O2TXwyPz2H3ezZP2K+WSCKyKAdiXUS1
 6T548gnRU4KQ+Uzj1YRuqvp7wNUTDd0Q6YFjzSMgzdWN8ebELTtxeRVvypyBkQ1I+4N9
 ugNBt15b6AoS87+Mw14iNqQSyI3aE2B7QpxuPCYNjWGCnRnzaZMGoPjRGT2lku7Otjie
 Ky65dVZCn8SRUQo0E2UqVaT/iEBrCZUUXMBbfOLU7D8YYTepCdD2hFBxBS14hndVMYRb
 58NTKjTmMh1VSuGnU0ayFpEVL2Gj8og8gGHzLYexndfg4GvzgdXHAW6BGeXYUqzt4aAf
 5SDg==
X-Gm-Message-State: AOJu0YwVTee0q7jmr8EK8ISx7jJygfhbZjPwYhT/aqs0bFmAawMz0o8y
 wV2iyROv4YCyGmf/A2FZro+Rwdo+WyI/9RnLNUwLt2rbC19LrK5gFjXspnwGD7s=
X-Google-Smtp-Source: AGHT+IEeK37Y1i03cyHBJ6frJWV8rtiOL7azULrW4Vn5ikRZcdvVLYmNzuJ7tK4Xrse9YJO4EfrtYg==
X-Received: by 2002:a05:6000:4595:b0:368:6678:f792 with SMTP id
 ffacd0b85a97d-36bbc16101fmr82278f8f.39.1722525067146; 
 Thu, 01 Aug 2024 08:11:07 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.130.148])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b368638fbsm19512217f8f.103.2024.08.01.08.11.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 08:11:06 -0700 (PDT)
Message-ID: <b6cd444d-a530-43e8-93ce-0900c6c7c484@linaro.org>
Date: Thu, 1 Aug 2024 17:11:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/24] tests/functional: Convert the riscv_opensbi
 avocado test into a standalone test
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair.francis@wdc.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
 <20240730170347.4103919-17-berrange@redhat.com>
 <9fbf2f80-c7df-4819-8f74-c7ce75dc70a5@linaro.org>
 <42fb9582-9215-4ccc-bede-0c4f03fffd4c@linaro.org>
 <Zqte2ySm_scvu17t@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Zqte2ySm_scvu17t@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 1/8/24 12:09, Daniel P. Berrangé wrote:
> On Thu, Aug 01, 2024 at 09:00:36AM +1000, Richard Henderson wrote:
>> On 7/31/24 22:56, Philippe Mathieu-Daudé wrote:
>>> On 30/7/24 19:03, Daniel P. Berrangé wrote:
>>>> From: Thomas Huth <thuth@redhat.com>
>>>>
>>>> The avocado test defined test functions for both, riscv32 and riscv64.
>>>> Since we can run the whole file with multiple targets in the new
>>>> framework, we can now consolidate the functions so we have to only
>>>> define one function per machine now.
>>>>
>>>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>    tests/avocado/riscv_opensbi.py         | 63 --------------------------
>>>>    tests/functional/meson.build           |  8 ++++
>>>>    tests/functional/test_riscv_opensbi.py | 36 +++++++++++++++
>>>>    3 files changed, 44 insertions(+), 63 deletions(-)
>>>>    delete mode 100644 tests/avocado/riscv_opensbi.py
>>>>    create mode 100755 tests/functional/test_riscv_opensbi.py
>>>
>>> Please squash:
>>>
>>> -- >8 --
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 98eddf7ae1..a906218f9d 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -336,6 +337,7 @@ F: include/hw/riscv/
>>>    F: linux-user/host/riscv32/
>>>    F: linux-user/host/riscv64/
>>>    F: tests/tcg/riscv64/
>>> +F: tests/functional/test_riscv_opensbi.py
>>
>> It seems worth taking this opportunity to add per-target subdirs of
>> tests/functional/, so that we don't have to list every individual test in
>> MAINTAINERS.
>>
>> Surely one
>>
>> F: tests/functional/riscv/
>>
>> etc, is actually maintainable...
> 
> Either that or wildcard the filenames
> 
>   F: tests/functional/test_riscv_*
> 
> 
> but subdirs matching the target is probably a little nicer to really
> encourage people to follow conventions more strictly. We would also
> need a "tests/functional/common/" for tests which aren't target specific

Hmm I'm a bit reluctant to both suggestions. Various files are
added to cover a feature which ends being tested on various archs.

Once I wanted to use Avocado tags like GitLab labels, and keep a
file where developers subscribe to tags; doing the parsing and
label to developer conversion in Python (or Rust), and having a
./get_maintainer.sh calling both the Perl one and anything we can
add in Python/Rust.

That said, wildcard pattern is a simpler start.

