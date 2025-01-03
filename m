Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91040E77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 17:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTlIA-0004IC-33; Fri, 03 Jan 2025 12:16:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTlI3-0004Hq-Rt
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 12:16:52 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTlHx-0007l5-NG
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 12:16:51 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-436637e8c8dso126769945e9.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 09:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735924600; x=1736529400; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hr+aVtCaKzlkXbNEKmFT9c/S1qhdem6wwl/faHDIfS8=;
 b=fPeAzrVyzOTebR++5pfaWEjoe5vXVH0EJn+o7eSwseSiqedWoCrUwvf7OxCzFGPLW3
 YcrO6u9wXSMhdv8uP+n4FUlDw2xj2OXfxwuh/r5S0U7eg0WfcGDyYg1Fz75Qts/OO4s1
 rZxI4Qiq31jCsOrxBMAGQRq1n7VpGzQ3G8Yf0jezxBq9eWTHuFQb8uh0TmgAsDTR04eD
 L6l/8Yy85sCBGODpch9+xzPxzARieJw0FZ6/dghWkjcQTuEBgsfB8pbyXs2l0OVrYR2A
 C282aAZecd2V79ZGALR2tQktzqOrF/y26fcrY2NtaKPT0GtUfNNaRo7OwSs+KT5XM0fF
 RDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735924600; x=1736529400;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hr+aVtCaKzlkXbNEKmFT9c/S1qhdem6wwl/faHDIfS8=;
 b=IVEibVGyRwd8hq1E0EnlCiKZcwiF6GBvAbey+I9gnMEZ2UrpUk5k/y3P4FqbieI8fK
 RIGTLfYTFlehJLBShF6VnMqxmIjTgxPjPiJBvtR8+XCY66jZuq8xWDDc44RyzQCn875l
 BXEUQCZFk7kX6Ud56JyVwb82qKnXzauqfjjqkAiAWyuqM2KAujYzQCc1JD/fx2JFvKTS
 HGzkxsevYssovzbEFidK6DBit/6RfYFZZ80a2iHyHJ0XbOBwSttfKPacUJ/QGYTzJYon
 48M0YNTQwlYaDxcfyoezzVKqNZRo3G7mXcrXL09z0FjiHejN4fQcUCKfLVNk7ahEcp7k
 1ZVw==
X-Gm-Message-State: AOJu0YyqRQjVjGsdXZSAw9hmgLJ3qzJCI7E/4tZRYz+5fz8ZhBvPsSDv
 4ATvVUVfgVg9lM84v6FA/WI7VCOCKd4gm9ya/PBuUML78v2TjdzjZ2QnXuR9bUM=
X-Gm-Gg: ASbGncuAGGq3VbKAtkDK2NXi2I4CjsNEOkbnjL8KvptCmwhDj/9+o6w5qPRMZxMrKLm
 3lw9k9gsAz7OrKr5qnU2zu+ir5ke3/puV8uDWvQOP7WQhI6R73ct2+RPmxoi39w9DuFAtUx3GBz
 aie4kxcorCq4+JR5i8MHuTQqjo4urB+6vdIexKi+74tRxiRiVeTkz0Ap7Coo7wZC8NTM54eaWrP
 EY0myLB4fPrQlHiMpK04R0zYeK9Zddb9mZEXEa2s8OHC6XSU34G2d19OdCTON1wQeRrLW3As1Np
 iuJkV4aJCBaT169S6gwyvJzg
X-Google-Smtp-Source: AGHT+IEND1AWliTYEzh2ULD8BKlTdDwUDUV848cCWoNzawOiJSbEU1SqPuCyzuDlQL9Fbbk+K0og+w==
X-Received: by 2002:a05:600c:444b:b0:434:a1d3:a306 with SMTP id
 5b1f17b1804b1-436685489aamr421596515e9.5.1735924599967; 
 Fri, 03 Jan 2025 09:16:39 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4364a379d69sm473685555e9.0.2025.01.03.09.16.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 09:16:39 -0800 (PST)
Message-ID: <d06dd874-c6a5-49ba-89c1-60668ad639d4@linaro.org>
Date: Fri, 3 Jan 2025 18:16:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system: Try hardware accelerators (KVM, HVF) before
 software one (TCG)
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>
References: <20250103150558.1473-1-philmd@linaro.org>
 <Z3f--qO8x45MpiXQ@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z3f--qO8x45MpiXQ@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 3/1/25 16:15, Daniel P. Berrangé wrote:
> On Fri, Jan 03, 2025 at 04:05:58PM +0100, Philippe Mathieu-Daudé wrote:
>> As Daniel suggested [*]:
>>
>>> We should consider to rank HVF above TCG, on the basis
>>> that HW acceleration is faster and should provide a
>>> host<->guest security boundary that we don't claim for TCG
>>
>> [*] https://lore.kernel.org/qemu-devel/Z07YASl2Pd3CPtjE@redhat.com/
> 
> Note, my statement above was on the basis that HVF passes all our
> functional tests, thus indicating a decent level of confidence
> in the correctness of the HVF impl.

Indeed, I forgot about that, and only tested in my 'HVF-only'
directory before posting, but ...

> If anyone knows any show stopper problems with HVF that would
> justify blocking its promotion ahead of TCG.... say now.

... here we go:

  3/15 qemu:qtest+qtest-aarch64 / qtest-aarch64/migration-test 
       ERROR            0.88s   killed by signal 11 SIGSEGV

>> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   system/vl.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> 
> With regards,
> Daniel


