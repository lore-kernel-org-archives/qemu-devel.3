Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DFFD12669
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 18:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQVGh-0000af-RX; Tue, 02 Dec 2025 13:38:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1vQVGd-0000aG-TW
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 13:38:28 -0500
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1vQVGb-00008i-Hh
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 13:38:27 -0500
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-3e37ad3d95aso3910469fac.3
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 10:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764700703; x=1765305503; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=G1+eqSyexgI6kb1KPvc3ooBFGxniW7Bx2C7w0AtYulQ=;
 b=VdGj06SG5eB/jRYC2W0wJVsyE3E/l/qbY8xyHBNCrqGQlXxR/d4m8x/JbyCqzfnI5N
 TJGwFKpJRt0xOJm1Z1x/4r2LQx8zb0Vqi4MS6rRjBXfI1UZrpEzTsEQWyyyQjNq1secM
 JGcvsxzIWOoGMaVyFoKQDNCGZipKRPkOzwfoU4+DsfMsLENM0wZ6gI7s6/FAZfHWkyYu
 Fhc3X6D/iC3BPGTC0R/L+21lXRmnl4H//rV9vHcgofkhHMQPXZJuKhiLw2r5MdKdUyyc
 ZxzN+YGAOVfbTamui/NFEJrL6LB5jTKdWib5yNrc5ucfw/ne/oeuWJtijO3LzpGVz8Ii
 PMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764700703; x=1765305503;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G1+eqSyexgI6kb1KPvc3ooBFGxniW7Bx2C7w0AtYulQ=;
 b=FaFlw7d4BRy1Abh+3c140ohV9+rv9OoKBGib7aOxV29FkYKyJi3XdZcrzyunjlR8k4
 TsBqeYWkq+zSq4lDMPHiNUGyH7t2wC6DNQdNVbQhR93AEn8sbkPGI/GCvAml1bJ9aOyu
 4kdK7LeILf3/bnraPXa3R27vMectW1d+Twy5GFTj29QNyNlOA5r+qSi5w3PmyY/P+UD+
 hqiCi/tey1rkrg1j0TZM2rEMqA4Ti9vOUYuMJ+I0l5xwgr11d7TNUrId4iX15w7lVD8m
 hfGUWyHwiSO7DFH/AQBzhysNMQjP42qkVCRFlb2HGwR/wIMNN99T4OOuYvX9llDyjel1
 lhlg==
X-Gm-Message-State: AOJu0Yz8ymoiz66aUJ6CQ3TfiBAshjwuqK/lR0H87E9qw7M0D/hCzKFJ
 ZYy9bHRfQM/Aj07GmXmNFNE1wew3aBvr4WqHxk0bSb7SS6hcrmsCoxX7zU+XqJ6c19o1vnOnnmA
 QTdd/5/1suCJB7q4NPIgz1mdCSc7WJ9hkuS4cI91Fqw==
X-Gm-Gg: ASbGncvFH8cIYuljGwDoF5CvV2mMqaL+1N1Oqd2JX1pdSpRFmicclNyi6LyoBPoXbSN
 WGuHeNr0SNQ6M6V1s7/gAV2S/rjFIUe6UIyD949CdQyYTWWGrSYXy+k7fH2PZyRDVo5BuwHm9Kt
 OzmHsNOzv+emYwHBikPU9+EnN/6Ydb+ZheaIMH2nnyQLTQZGTrS6egqSNXY8frOhYsnEsL7XCgl
 B7lzeC+n+AXMb8G+DKDflkE/47o48ZI6vYg0FaXfaryTEvvyeLrUmpw4qr00BR5GPqMgJ0=
X-Google-Smtp-Source: AGHT+IEXvrjuYpGPC17ExohBO0sXYCIEO6FBsm+JRthkUjTmFhUzMErMG32twfyJfK9u7XJgU+izBIDyeD4Z4j1jrd4=
X-Received: by 2002:a05:6808:4616:b0:453:f85:79e9 with SMTP id
 5614622812f47-4530f859857mr9661857b6e.18.1764700703122; Tue, 02 Dec 2025
 10:38:23 -0800 (PST)
MIME-Version: 1.0
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Date: Tue, 2 Dec 2025 19:38:12 +0100
X-Gm-Features: AWmQ_blmBm81JO7J0GV86g6khYFyBf3KZE-fi1eOVU43sysaWBbXf2ZzHmrs8ic
Message-ID: <CAPMQPEKqX2+EOen0fRL1sO=pBOL-rs3-zwz9tJh+e2857kCFWA@mail.gmail.com>
Subject: Re: [PATCH v2 63/93] tcg/tci: Use ffi for calls
To: Stefan Weil <sw@weilnetz.de>,
 Jeremy Huddleston Sequoia <jeremyhu@apple.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=philippe.mathieu-daude@linaro.org; helo=mail-oa1-x2c.google.com
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

On 7/2/21 22:33, Stefan Weil wrote:
> On 07.02.21 21:12, Richard Henderson wrote:
>> On 2/7/21 11:52 AM, Peter Maydell wrote:
>>> On Sun, 7 Feb 2021 at 17:41, Richard Henderson
>>> <richard.henderson@linaro.org> wrote:
>>>>
>>>> On 2/7/21 8:25 AM, Stefan Weil wrote:
>>>>>> +#include "qemu-common.h"
>>>>>> +#include "tcg/tcg.h"           /* MAX_OPC_PARAM_IARGS */
>>>>>> +#include "exec/cpu_ldst.h"
>>>>>> +#include "tcg/tcg-op.h"
>>>>>> +#include "qemu/compiler.h"
>>>>>> +#include <ffi.h>
>>>>>> +
>>>>>
>>>>>
>>>>> ffi.h is not found on macOS with Homebrew.
>>>>>
>>>>> This can be fixed by using pkg-config to find the right compiler (and maybe
>>>>> also linker) flags:
>>>>>
>>>>> % pkg-config --cflags libffi
>>>>> -I/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/ffi
>>>>> % pkg-config --libs libffi
>>>>> -lffi
>>>>
>>>>
>>>> Which is exactly what I do in the previous patch:
>>>>
>>>>
>>>>> +++ b/meson.build
>>>>> @@ -1901,7 +1901,14 @@ specific_ss.add(when: 'CONFIG_TCG', if_true: files(
>>>>>     'tcg/tcg-op.c',
>>>>>     'tcg/tcg.c',
>>>>>   ))
>>>>> -specific_ss.add(when: 'CONFIG_TCG_INTERPRETER', if_true: files('tcg/tci.c'))
>>>>> +
>>>>> +if get_option('tcg_interpreter')
>>>>> +  libffi = dependency('libffi', version: '>=3.0',
>>>>> +                      static: enable_static, method: 'pkg-config',
>>>>> +                      required: true)
>>>>> +  specific_ss.add(libffi)
>>>>> +  specific_ss.add(files('tcg/tci.c'))
>>>>> +endif
>>>>
>>>> Did you need a PKG_CONFIG_LIBDIR set for homebrew?
>>>
>>> Is this the "meson doesn't actually add the cflags everywhere it should"
>>> bug again ?
>>
>> I guess so.  I realized after sending this reply that PKG_CONFIG_LIBDIR can't
>> be the answer, since the original configure should have failed if pkg-config
>> didn't find ffi.
>>
>> Was there a resolution to said meson bug?
>
> Meanwhile I noticed an additional detail:
>
> There exist two different pkg-config configurations for libffi on Homebrew:
>
> % pkg-config --cflags libffi
> -I/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/ffi
> % export PKG_CONFIG_PATH="/opt/homebrew/opt/libffi/lib/pkgconfig"
> % pkg-config --cflags libffi
> -I/opt/homebrew/Cellar/libffi/3.3_2/include
>
> By default it points to a system directory which does not exist at all
> on my Mac, so that will never work.
>
> With the right PKG_CONFIG_PATH a correct include directory is set, and
> the latest rebased tci-next branch now works for me with a compiler warning:
>
> /opt/homebrew/Cellar/libffi/3.3_2/include/ffi.h:441:5: warning:
> 'FFI_GO_CLOSURES' is not defined, evaluates to 0 [-Wundef]

This got introduced in
https://github.com/libffi/libffi/commit/e951d64c0852; should we report there?

Cc'ing Jeremy who sent patches around FFI_GO_CLOSURES:
https://github.com/libffi/libffi/pull/586/commits/8c25da7d2cdf8

Meanwhile, about 5 years have passed, I'll post a patch...

