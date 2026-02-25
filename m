Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBAC7FD3779
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 17:39:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvIr1-0006ro-74; Wed, 25 Feb 2026 12:39:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvIr0-0006qu-2w
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 12:39:18 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvIqt-0003XI-NN
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 12:39:17 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-823210d1d8eso1631b3a.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 09:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772041150; x=1772645950; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Mh126TEDiEzju1ir/MHNkquCylBFPpRvBvuE2fC455E=;
 b=CP0c8/e1nmfEJSogcy+pe/wDK80J3YIH91pDmNew5bBbSky4P83mWLPGEJDulG7m4k
 4NEkhzv+8TsYJGp4XKgt0b3niDOTt9XxU26phjriqSWktQQ+27WgVywy7cLGSFVLOmvv
 7SiHiHPurLruKn+AuRkVEcezWlA/iFpDGYReWYFHjKBl9oUqKXSlS/KwTj1nbxxFuF2Y
 ClICyjmYSoDXGrN5YBHo7zfakpL49m8hkypReJPSN3z7f7YwJkO2L/1m5fFKwt+AR7Xp
 aCOpOvPQ/SpXcLJ0EaVxFprjT85VYfxL848gJ8EupKMYwlkCtmeSkZ/rr2D/j3FdEb/b
 hpSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772041150; x=1772645950;
 h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mh126TEDiEzju1ir/MHNkquCylBFPpRvBvuE2fC455E=;
 b=HjLooeo7Vl4Nf3nwSn/IIh31OOuVtQ9P2sDt1S3JIim1oRxRstEDBd+vUbKCMaHC4Y
 UWc9kRwK2YDFmHTB/i/4Rr6wRmKIhSpDLXvjWgswXWEw5zOyB/1fTKH6QkwOZjiLU00l
 PBa/3ag0sy1gfrJVdICVy7arYTtIetNzrigTUKDlQMoZnLXc8tvhREFu5oKnJ8VmI29Y
 oCHOh6UO0/Wxy+HeLMoscxzCtaoisxaQpOJoqisaiJAXzImV9KpK30x9du3FlEV9Veko
 ItROAh3LP2MpFw+tP007b7B+IodbVOKSvXEaw2dSauCX1cGGnNxzdUtp546J3eae8Dir
 IgPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNf1taQT7St6g/BHMIL/NbI3iVT/JAGr+Ec6Q5cedFW6MPJYLokMWfU68wx6jvQZFCOtNyb8zNDjYr@nongnu.org
X-Gm-Message-State: AOJu0YyQWFhGsXswB2x2caoaFNmw7E2bo1/ZJXVirgXr//Z4Rbn5Ns2r
 EYlV84Cbqe2f4Qg0FWJsQjeOHjmsyJWqjcoMhoAR1zLJTPsyMvuNntd5si1fsVTaxtc=
X-Gm-Gg: ATEYQzwzJmrwmsYqkZXuUoGZs5IBjAslxOWXoj1eKlGPqu2K3NBlXx5r5CpsR5f/RF0
 iAHGK5zBAxynydZIURaj1i9jAhp/+7x6rnZYqZwf3vGZoaySUA/Kdi50JQZkkYT2nXyMVKRmLm2
 IL0fZmEw4GSTOnW330ODBWLWDpV+9CE79RcFtD1OWoeAVnEq461GiQtXh8uTAOacj+ZVcbxSbKh
 OSZN9TI06XxBoAARszpy2+NlPVn2cddj8M/IbKDZ6Rz02fweP8w8mTmIY59/sCP0coMnq2wembp
 o9efcNQKmY7eo4zyH15TAf/W5DrtIIugJPCEl8GZh8ebloExHUXY8p35T5aXjYiYuwXI7HuSRP7
 6fc0lf/eOtMPPuXvBY0SZ2f+uuUjpbPczCJedgaA+33OEKNu9raUxIGyJ7PQNxO8MNihsBI+LYO
 sXdG/HPfo30EI0m8IXYOiDhhShk9KTp0CwbqqwpeILDGhm8/YUbWpa5FH+JlACZsnDLfnM
X-Received: by 2002:a17:903:1ad0:b0:2ab:3ac6:8d01 with SMTP id
 d9443c01a7336-2ade9a61189mr10779355ad.29.1772041149989; 
 Wed, 25 Feb 2026 09:39:09 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad7503d406sm139566235ad.75.2026.02.25.09.39.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 09:39:09 -0800 (PST)
Message-ID: <e6f671cf-400b-4ded-b9bb-1bebcb632877@linaro.org>
Date: Wed, 25 Feb 2026 09:39:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] tests/tcg: add test for qemu_plugin_set_pc API
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: Florian Hofhammer <florian.hofhammer@epfl.ch>, alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com,
 berrange@redhat.com, qemu-devel@nongnu.org
References: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
 <2ccc79ee-48ab-4097-a9cc-4d2b79ab9a8a@epfl.ch>
 <383fc3ee-20ed-45e7-bcbb-1c188256bfad@epfl.ch>
 <e317d484-eee2-489e-8c9c-d30f7800cef9@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <e317d484-eee2-489e-8c9c-d30f7800cef9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

On 2/25/26 9:30 AM, Pierrick Bouvier wrote:
> On 2/25/26 8:21 AM, Florian Hofhammer wrote:
>> On 24/02/2026 16:52, Florian Hofhammer wrote:
>>> The test executes a non-existent syscall, which the syscall plugin
>>> intercepts and redirects to a clean exit.
>>> Due to architecture-specific quirks, the architecture-specific Makefiles
>>> require setting specific compiler and linker flags in some cases.
>>>
>>> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
>>> ---
>>>    tests/tcg/arm/Makefile.target                 |  6 +++++
>>>    tests/tcg/hexagon/Makefile.target             |  7 +++++
>>>    tests/tcg/mips/Makefile.target                |  6 ++++-
>>>    tests/tcg/mips64/Makefile.target              | 15 +++++++++++
>>>    tests/tcg/mips64el/Makefile.target            | 15 +++++++++++
>>>    tests/tcg/mipsel/Makefile.target              | 15 +++++++++++
>>>    tests/tcg/multiarch/Makefile.target           | 22 ++++++++++++++--
>>>    .../{ => plugin}/check-plugin-output.sh       |  0
>>>    .../{ => plugin}/test-plugin-mem-access.c     |  0
>>>    .../plugin/test-plugin-skip-syscalls.c        | 26 +++++++++++++++++++
>>>    tests/tcg/plugins/syscall.c                   |  6 +++++
>>>    tests/tcg/sparc64/Makefile.target             | 16 ++++++++++++
>>>    12 files changed, 131 insertions(+), 3 deletions(-)
>>>    create mode 100644 tests/tcg/mips64/Makefile.target
>>>    create mode 100644 tests/tcg/mips64el/Makefile.target
>>>    create mode 100644 tests/tcg/mipsel/Makefile.target
>>>    rename tests/tcg/multiarch/{ => plugin}/check-plugin-output.sh (100%)
>>>    rename tests/tcg/multiarch/{ => plugin}/test-plugin-mem-access.c (100%)
>>>    create mode 100644 tests/tcg/multiarch/plugin/test-plugin-skip-syscalls.c
>>>    create mode 100644 tests/tcg/sparc64/Makefile.target
>>>
>>> diff --git a/tests/tcg/multiarch/plugin/test-plugin-skip-syscalls.c b/tests/tcg/multiarch/plugin/test-plugin-skip-syscalls.c
>>> new file mode 100644
>>> index 0000000000..1f5cbc3851
>>> --- /dev/null
>>> +++ b/tests/tcg/multiarch/plugin/test-plugin-skip-syscalls.c
>>> @@ -0,0 +1,26 @@
>>> +/*
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + *
>>> + * This test attempts to execute an invalid syscall. The syscall test plugin
>>> + * should intercept this.
>>> + */
>>> +#include <stdint.h>
>>> +#include <stdio.h>
>>> +#include <stdlib.h>
>>> +#include <unistd.h>
>>> +
>>> +void exit_success(void) __attribute__((section(".redirect"), noinline,
>>> +                                       noreturn, used));
>>> +
>>> +void exit_success(void) {
>>> +    _exit(EXIT_SUCCESS);
>>> +}
>>> +
>>> +int main(int argc, char *argv[]) {
>>> +    long ret = syscall(0xc0deUL);
>>> +    if (ret != 0L) {
>>> +        perror("");
>>> +    }
>>> +    /* We should never get here */
>>> +    return EXIT_FAILURE;
>>> +}
>>
>> I'm running into an issue for all four variants of MIPS if I don't
>> hardcode the section but pass the function address as a syscall argument
>> and then use that as jump target in the plugin: according to the ABI,
>> the t9 register has to contain the address of the function being called.
>> The function prologue then calculates the gp register value (global
>> pointer / context pointer) based on t9, and derives the new values of t9
>> for any callees from gp again. As I'm currently just updating the pc
>> with the new API function, t9 is out of sync with the code after control
>> flow redirection and the binary crashes.
>>> I think it is fair to expect a user of the API to be aware of such
>> pitfalls (or we can document it), but I'd of course still like to make
>> the tests pass. The simplest solution (theoretically) is to also set the
>> t9 register in the plugin callback before calling qemu_plugin_set_pc.
>> However, the MIPS targets do not actually expose any registers to
>> plugins, i.e., qemu_plugin_get_registers returns an empty GArray.
>>
> 
> A lot of things can go wrong when jumping to a different context than
> the current one, that's why setjmp/longjmp exist. You can always add a
> comment for this "This function only changes pc and does not guarantee
> other registers representing context will have a proper value when
> updating it".
> 
> A reason why I pushed for using value labels, was to stay in the same
> context, and avoid the kind of issues you ran into.
> 
>> Given this behavior, I see two solutions:
>> 1) skipping the test on MIPS, or
>> 2) making the test code a bit more contrived to use labels within the
>>      same function while preventing the compiler from optimizing the
>>      labels away (which it does even with -O0). I've got a prototype for
>>      this, but the test code looks a bit contrived then:
>>
>>      int main(int argc, char *argv[]) {
>>          int retvals[] = {EXIT_SUCCESS, EXIT_FAILURE};
>>          int retval_idx = 1;
>>
>>          long ret = syscall(0xc0deUL, &&good);
>>          if (ret < 0) {
>>              perror("");
>>              goto bad;
>>          } else if (ret == 0xdeadbeefUL) {
>>              /*
>>               * Should never arrive here but we need this nevertheless to prevent
>>               * the compiler from optimizing away the label. Otherwise, the compiler
>>               * silently rewrites the label value used in the syscall to another
>>               * address (typically pointing to right after the function prologue).
>>               */
>>              printf("Check what's wrong, we should never arrive here!");
>>              assert(((uintptr_t)&&good == (uintptr_t)ret));
>>              /* We should absolutely never arrive here, the assert should trigger */
>>              goto good;
>>          }
>>
>>      bad:
>>          retval_idx = 1;
>>          goto exit;
>>      good:
>>          retval_idx = 0;
>>      exit:
>>          return retvals[retval_idx];
>>      }
>>
>> Maybe I'm just missing something obvious, I'd be happy to get some
>> feedback on this. Thanks in advance!
>>
> 
> Can you post the exact code you had where labels are optimized away?
> On which arch was it?
> I tried something similar but didn't see the second one disappear.
> 
> I wonder if it's related to compiler detecting g_assert_not_reached() is
> a "noreturn" function, thus it doesn't expect to go past it, and
> eliminates dead code. You can try with assert(0) or moving
> g_assert_not_reached() to another function "crash()" instead, that is
> not marked as noreturn.
>

I'm pretty sure that's the reason:

Given this code:
void crash(void)
{
     g_assert_not_reached();
}
int main() {
     crash();
     printf("Hello World\n");
}
resulting assembly contains a call to puts.

Meanwhile:
int main() {
     g_assert_not_reached();
     printf("Hello World\n");
}
Doesn't.

gcc does dead code elimination even in 0 for cases like this, or if you 
have if (0) { ... } also. Beyond code size optimization purpose, it's 
useful to remove dependency to symbols that are really in dead code, I 
discovered recently we rely on that behaviour in QEMU (for various 
X_enabled global symbols).

>> Best regards,
>> Florian
> 
> Regards,
> Pierrick


