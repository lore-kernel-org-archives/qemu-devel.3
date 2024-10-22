Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC24FD2CE12
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 17:53:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3J3x-0000ri-B6; Tue, 22 Oct 2024 13:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3J3s-0000mN-Aa
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 13:52:52 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3J3q-00060V-Ku
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 13:52:51 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20c70abba48so49311565ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 10:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729619569; x=1730224369; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8mLYshpN2oThMiXV+pNtRfPyIEXp6fY3q+ThzeOBlJM=;
 b=q7KpS3Ii2xml73I+m2Pm8qxxrmgmxXySmE9ND0WlmCYXdau4Ar7+OanZcz+rRwU3ep
 VnY8bXciNHr2hr8e+a1SNxjDYGW+HuX35jdiQ49Lpt7tpUtdlX++2kyN++sg9+qTTUI6
 ocVt7QytOTu7fVnpzVHMOo8FDZ2co9E2I4OGSWho11fJHEYW/vOePol35hQslI+Tc8av
 70wT87tIaQl0p0yV5FnorPpUCbaREqXr2I/D7leBWzAwo/U8MpNff1sSIRZ4pHtCuQWr
 PP8NuXtcHh5ksSfK7fN6Uuv27t3oobuZ7yeVpoDWZurM6zbGhEQ6ZFTPHGuszucFS2zn
 Zjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729619569; x=1730224369;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8mLYshpN2oThMiXV+pNtRfPyIEXp6fY3q+ThzeOBlJM=;
 b=dUulA7oLe/U3lQuaKJ2hxxYz6ZO/mNT3i+rm4NvELUiz1yC2COUL0hZjX9CgVOrwH1
 aJa68INrrZpFQ66aU9MLkMYnD2FJeusSQbzwONr4oqRGCaPVQhLEdr8HdaL/8oJUyvBH
 XGcXau6Kog/67QAFcw38mqNJh691mYYRa2gW+STn8V+XUhppbLkLGMXzJK9N/NKe8gaN
 YXdnK/XLv+NMCIUbFcP71E/a4SED3bINW8rP1+FS3isuAN1wwfrvVd6J8vF9AtpN1K2t
 xsnoCM25NFMys9YY/K0+LFqEWs2gSEkJfi88Oxr404BZadN6WFCxMNQqEt0PH7aAEHEh
 97FA==
X-Gm-Message-State: AOJu0Yz3QPxEXEHX2+QEwZyOsb3aiJq8fpLP8l9y6NXIiqKVwLIqfa8b
 dEu+WgSKhn8tY9hPmLvDvlfulYt7XvctEkMYxzwQVQKDvNmxckcl+yTNtnmE8Gw=
X-Google-Smtp-Source: AGHT+IEOA4BUOlJffJXl/C7iIPybGlmQRLCb2wM0L3T9Kgy6imrLajJA9zdEiD+1ilIYP+R7aswokA==
X-Received: by 2002:a17:903:24d:b0:20c:6bff:fcae with SMTP id
 d9443c01a7336-20f395cddaamr3646695ad.5.1729619569233; 
 Tue, 22 Oct 2024 10:52:49 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f106b82sm45331005ad.301.2024.10.22.10.52.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 10:52:48 -0700 (PDT)
Message-ID: <d2d3bb73-28d1-4775-945c-572aea80fb74@linaro.org>
Date: Tue, 22 Oct 2024 10:52:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] linux-user/ppc: Fix sigmask endianness issue in
 sigreturn
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20241017125811.447961-1-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241017125811.447961-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 10/17/24 05:54, Ilya Leoshkevich wrote:
> Hi,
> 
> This series fixes an issue where an emulated ppc64le process running on
> s390x attempting to wake up a sigwait()ing thread would instead
> terminate itself. Patch 1 is the fix, patch 2 is a testcase extracted
> from the real-world scenario.
> 
> Best regards,
> Ilya
> 
> Ilya Leoshkevich (2):
>    linux-user/ppc: Fix sigmask endianness issue in sigreturn
>    tests/tcg: Test that sigreturn() does not corrupt the signal mask
> 
>   linux-user/ppc/signal.c                 |  2 +-
>   tests/tcg/multiarch/sigreturn-sigmask.c | 51 +++++++++++++++++++++++++
>   2 files changed, 52 insertions(+), 1 deletion(-)
>   create mode 100644 tests/tcg/multiarch/sigreturn-sigmask.c
> 

Queued, thanks.

r~

