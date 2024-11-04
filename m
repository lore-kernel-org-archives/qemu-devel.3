Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB07D132B4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 11:34:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7vLt-000579-5R; Mon, 04 Nov 2024 06:34:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t7vLq-00056E-Ft
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 06:34:30 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t7vLo-0000MN-4W
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 06:34:29 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a9a0f198d38so709870266b.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 03:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730720066; x=1731324866; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y8MJWF+I4ZtbY0EHnDipXqwGUYPmO+91DvOjYLLW7v0=;
 b=vPf//5vB6lUPFC8dDCD2Y2TYEdYGsepeYgfwLkaw3vBJazfe5l0peJFcEUuXpTncGq
 var+rY+km23jCLC4cmoEnQSIWvZWo8clDrTQPlq+VV+tb6kQEmvVDMj85szlOFoYzrGX
 cY2HBoQpB6iHYfzYpQ00s2XrywZNoqsYR2k7rNHZHDaqS+ntkljwOKmaiOOGAnZZFTYt
 FL5vVWayYeQbTxiN9SuHz166ttVwhyaPRPOeS+lvntFTbV+2OC9SPUU6OvotbWaUivVi
 vXoYN2oEVBqJtZGBWuVK++TluTg5ytFoL8Q1svtjmOHnU5ZOxVM3qZQOSt6OBlBHNqgh
 OiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730720066; x=1731324866;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y8MJWF+I4ZtbY0EHnDipXqwGUYPmO+91DvOjYLLW7v0=;
 b=fqV0jZF/ISueWu5RggeEQGG1Jd4kJSM8pBVlwPeE1LjvPJU4Ap/k2kz6degwYFMtb5
 EeSfjPWQpDM0+OUTV592A9GCqMTxpaufi7Qyp+3vqD4+f0dIDA3EfDKPgtNBzi3fTG/E
 icmX13XxwiybmYXIy//TKZZNDVwoqNcIpeUbhjewfHLZHftfoN+zFSKBG+jdXj+lAhoS
 p9xMlZkcNWahlt5g+tRcgpWuYIRTX8MXo4oMnlkkXETRmF6XfolSboxKP0kjitQS8lNF
 TOewZYBffE4HZlkBAixM69S+Cu07URkrnnp8KhubOkPwMCdIn4Yy1hnRGwKFTi0F6TDR
 0ApA==
X-Gm-Message-State: AOJu0YyIHcVvYNCxaYgzIKM4ucIe9TGGtJ4CW54D/UfOKknQD57C5J6o
 MtQkSrfCcX7liBieS9/RQtwUSFbMi05r7aJrWJEVbUzrtD9C6ngnlfkL+CVdgpo=
X-Google-Smtp-Source: AGHT+IEejGGzGBlPdeKclydSTaO5okhIxO0GUYZchGnNFwGY1qwg8FN2bGzPg/PQSzKfAkiAmg43eQ==
X-Received: by 2002:a17:907:1c02:b0:a9a:ce80:b08e with SMTP id
 a640c23a62f3a-a9e658076c7mr1274970266b.65.1730720066190; 
 Mon, 04 Nov 2024 03:34:26 -0800 (PST)
Received: from [192.168.21.227] ([91.223.100.66])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e565df8c2sm541391266b.102.2024.11.04.03.34.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 03:34:25 -0800 (PST)
Message-ID: <727d4d4f-a299-4cdc-9723-c6b943d526ab@linaro.org>
Date: Mon, 4 Nov 2024 11:34:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tcg: Do not use inttypes.h in
 multiarch/system/memory.c
To: Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20241010085906.226249-1-iii@linux.ibm.com>
 <59b7a93e-7acb-4a73-9aae-bbfb36101c5d@redhat.com>
 <4f0cab2f2d564037e1a36a75ad1fb9d350c0f0e1.camel@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <4f0cab2f2d564037e1a36a75ad1fb9d350c0f0e1.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62e.google.com
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

On 10/29/24 23:29, Ilya Leoshkevich wrote:
> On Thu, 2024-10-10 at 11:20 +0200, Paolo Bonzini wrote:
>> On 10/10/24 10:58, Ilya Leoshkevich wrote:
>>> make check-tcg fails on Fedora with the following error message:
>>>
>>>       alpha-linux-gnu-gcc [...]
>>> qemu/tests/tcg/multiarch/system/memory.c -o memory [...]
>>>       qemu/tests/tcg/multiarch/system/memory.c:17:10: fatal error:
>>> inttypes.h: No such file or directory
>>>          17 | #include <inttypes.h>
>>>             |          ^~~~~~~~~~~~
>>>       compilation terminated.
>>>
>>> The reason is that Fedora has cross-compilers, but no cross-glibc
>>> headers. Fix by hardcoding the format specifiers and dropping the
>>> include.
>>>
>>> An alternative fix would be to introduce a configure check for
>>> inttypes.h. But this would make it impossible to use Fedora
>>> cross-compilers for softmmu tests, which used to work so far.
>>>
>>> Fixes: ecbcc9ead2f8 ("tests/tcg: add a system test to check memory
>>> instrumentation")
>>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>
>> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> [...]
> 
> Thanks for the review!
> 
> Could someone please pick this one and also [1] up?
> Both patches are aimed at improving the situation with the test builds.
> 
> [1]
> https://lore.kernel.org/qemu-devel/20241023131250.48510-1-iii@linux.ibm.com/

Queued, thanks.

r~

