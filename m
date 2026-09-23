Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE37C98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 19:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Ssx-0005U4-OA; Wed, 23 Sep 2026 15:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Ssv-0005Tr-M3
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 15:44:05 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Ssu-0008IZ-2n
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 15:44:05 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-398c066106cso828568a91.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 12:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790192642; x=1790797442; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/dVgCJ5IAJeSDenv4AxEwpvdyHkRjUDTCGH5xZtiV8c=;
 b=kN3x7Pol9i7i7kyFHKnhcjm8WpnqWS2pueKMc6guGuQBLH2figVmOhnA6cpHjickww
 TCZmRqoZUnaIIwql5qThtFnPJqBmcDxeQntp6yKnERjqlOTBO+ax/3mwtxkc69KKasMk
 1Ociu6w2nvS4vMwdY2jqNMtaF1Q/Ou16SREuPMHmArOb8PbX05bR1DTJZkJRkt9uhHPw
 5T8DIyqnhjlPPmKSmTUNhwnq2fEKQZ7Igwv6gXsLCAlNCPdY1CZqCZvkAdAQBJAe30ZX
 uEhrI8XVytC4fPqpR+T5IBbxkwKhWnCgVEMiA053qNIR1e6TdQ2D19f/jqvOuJ9jsbgb
 tEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790192642; x=1790797442;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/dVgCJ5IAJeSDenv4AxEwpvdyHkRjUDTCGH5xZtiV8c=;
 b=tnG/iEpUIuG+VrOR1xESir907R+H0BkwH6TIERVExMMnbv8V4aFGWkJSMe2RuHldc/
 BkA+I76JHenZFws/BLc1rSlgW5KjPn3ujvNUFdadLCR9kYqY+aEufrB9vQ2mSV+ftWh/
 L/DIFkSpiySnc2JEfjMh2xx4FJRjltLO1XfB6oXpJQ4vJfhdGdES5Ec0sj+AMK5wwGb7
 JoL96IwTOXyfgSQySb0W6i8825bDa0G9juYXkbojIfLiyj/RpUiu3chB9MlE8msHA+J+
 RCrKYebILw20bWswgm6GL/NvEOte4vB5IN5z/cnz5OvNMXCifQXHvWuEbavy2p7DbaPm
 41ZQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwDOSrkbn6OPgjj8rpcfu51P9TLMXc95QsfcbX1e1Q9XzmXqZ2ozcULfpNuzyIQJuZpKcFb/uoREGa3@nongnu.org
X-Gm-Message-State: AFuF++n7l1nz2Fn5avKTXPrn8FsB2u3JVFFGTi7oYzxSp7fjMN+Wsv3G
 jwabxXzLVWI95aaNnHkJdLSURwWh3S2eL7/rFMBKDn3XM6/rUEvomFQ84vjv90zIAmk=
X-Gm-Gg: AYBFou3jA0EASnD1dT9iyfoW7RMT15R2Wjsko76ojRPU0GQDsphipGEpembA9Z/lcEo
 +UP4OcX6PidQP3BGMvZR+Ae3Eg+EMkQghmA8yPTAtJYJpmheYaRbhXZ8DLR2+xEDSMA6kjIeayi
 jauJvtl5UGzPGrVl4lYgNJ20S6UGMElAqAi2cLiZImaJv3IOXS7qZGbvGr0mIWYVCtbwpZSMoCA
 U/++jw+3AGHgoiEk3J8ntC8cAXQ8ARGmGcBJSgYp2hQFCbqOpf2t2ys/Vg1lQlSAc2ZE7Dh3Hqb
 Y66/pkb6BTFTTX0SBDwVyp3lMr9pZw9T0XLh8aYgzdO7/rkV8hVSe5MvBnKOI8K6z7SAxqodczr
 SupBtB/84tmBntR1S0pVJAwy4aHDJmjuRlGRmoe5Omru6mHEKNORO9uCcofPaZpsWz0zdSOyB2n
 bCzga1TAuTzNzUTlduM0ustnb772sEhWrTRaZ9A6zoeSgZCGJbJIHF9zoJ2EW+ybxfvxX5Cdkw2
 WwBfMNAXadMSZ5hJRxCKG1zwDFM60YEI9+qtQbY
X-Received: by 2002:a17:90b:4e8f:b0:39e:6c68:1551 with SMTP id
 98e67ed59e1d1-3a09896c4demr178020a91.25.1790192642148; 
 Wed, 23 Sep 2026 12:44:02 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0974ec5d0sm602788a91.4.2026.09.23.12.44.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 12:44:01 -0700 (PDT)
Message-ID: <5760a9e5-dc2e-4427-ace5-9092819d6d35@linaro.org>
Date: Wed, 23 Sep 2026 12:44:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/11] Bsd user 2026q3 patches
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>
References: <20260922192109.98467-1-imp@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260922192109.98467-1-imp@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/22/26 12:20, Warner Losh wrote:
> The following changes since commit 7074591d7954876951f84c15b994a43251d5a3c1:
> 
>    Merge tag 'qom-qdev-20260922' ofhttps://gitlab.com/mcayland-ntx/qemu into staging (2026-09-22 07:56:00 -0700)
> 
> are available in the Git repository at:
> 
>    git@gitlab.com:bsdimp/qemu-from-official.git tags/bsd-user-2026q3-pull-request
> 
> for you to fetch changes up to c79adb04654bba3e505e5332b90b7ca2c639b044:
> 
>    bsd-user: Remove host-os.h (2026-09-22 13:07:11 -0600)
> 
> ----------------------------------------------------------------
> bsd-user: misc fixes
> 
> Catch up with a number of trivial differences between master and blitz branch:
> 
>   - HOST_BIG_ENDIAN and TARGET_BIG_ENDIAN are always defined
>   - Drop support for FreeBSD 12
>   - Flag shared memory as needing atomics
>   - Initialize per-arch child registers
>   - mmap fix for flags from long ago
>   - Move tb_flush stuff to begin_parallel_context
>   - Implement exterrctl(2)
>   - Implement sigfastblock
>   - Eliminate unused regs arg in load_elf_binary
>   - #ifdef sockopt that aren't in 14
>   - Remove host-os.h

Applied, thanks.

r~

