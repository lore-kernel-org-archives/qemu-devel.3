Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5318D3B7FA
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:50:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIAYh-0002kT-Us; Mon, 02 Dec 2024 12:50:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIAYg-0002jW-2R
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:50:06 -0500
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIAYd-0006hr-L7
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:50:04 -0500
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-29e5aedbebdso851675fac.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733161802; x=1733766602; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=afXHuXR2chpuSmtZdTMIHMhVYOc7rp2QIukSzs6GX1U=;
 b=cfHiaeq2cMulTAaO4FM9IZSS5hXptKeYK6LAT1icINuDIAi8sAQYNdqAjHcLOl9fNf
 CuM0pSV6NIWANCMA9WoBCU9dRn46pXWehxYUPPM8WhAwGpuK0+H/P1++pLAx+bt4EaNS
 jIxaWzLQHQTp2pLRuoI/Acb7ZGxjU9b0DVp/b1C8/+3d0LKA0qi8dc767gOA8njwokhB
 Ckmw8k+EMkGqlBFk3R7QiOCL7RQ66ZXtjBcOEZW8aPKkzC94PjRQFn+CU/laqmYuPEO6
 1ttNWzcTfIHcRApilB6BFKlzGMEtOAyQ9cQU3Xf9gXDqF2NxtPGtDJIrgmCcVmGUbJJT
 bF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733161802; x=1733766602;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=afXHuXR2chpuSmtZdTMIHMhVYOc7rp2QIukSzs6GX1U=;
 b=v/DfPKXbraii/dZnq5AtaT0+k5RUSAexVXGAsLXY+4VtlGlYKE4ccXQIm7oaXDKA7Q
 zK3Y6jfS/NepytIpHzKdlCUHbuagNW6u4rWstmMekJDH+/3ztaEr1BLpQwmEZPzxR3H1
 4p2aLQpTqBxWkIdqyQznQwO3p0VjWcCJYy5TGbRj4ouTObhextQ25iLKaDQQtk/uP5x4
 PEd+lxH+6QiNjrtJdEUZIJXQKMzn1hkisrWrUvZX3Pxa8qJEH96Qq3L4AFSXkL5hKLo8
 z3S4u8JyYP3eM26ggzLwClN8YMEvftPFavCR4Y5WoDm7WZDNOMlB9MO1LRb5H8htWOwI
 x/8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUB/r3oZJ1ktKqGBP4XNmcT1DSm9/bszwlkE7Zkh7AoArVfoGPuDSTKaE4qvOsSua3PkSsVA1nY9AFm@nongnu.org
X-Gm-Message-State: AOJu0Yzd/SVr4vkZvxZh1DLqmb9S3vAh0d8GGjcNB0HnNY9Itj3KuFUw
 D4UVsWDPWC/LfFBOJU9bOk1M0KUucKNQlxnmyXNLOErpW5CQq6nhZTzDsJnAjlc=
X-Gm-Gg: ASbGncss03NDiQtk0YRbRvTnD7Px+/wJXmnFeqEe3WIJN/cjAM7+nxFX1F7aUSFR102
 nULB5QBafEJVAoX5jGIXzQpmFQ82ZiQ/qOQvHbGgioj/s3LRWNPIogHDgw4i29Rhb7MDmQXhAQL
 HMOYuDby1/HciZilWKQlqWpvkrf0QXM+B+Qd+A0Aujms6wOeXUSJyB2OKzTEJ903C0lLWt2SimH
 xAeaUxanWBKQXJTCkOf60wS+t9LQxBYvNCqNuXvQ9BKQnFEcurc9ZchQF5EULMk565H9eA=
X-Google-Smtp-Source: AGHT+IHYffnxkL/kdsXahEc3zTts96I0xDFyQbG5BFUq9svjcwS0DFTZ145JH/tm1KSiAfCYvQd+HA==
X-Received: by 2002:a05:6870:5306:b0:29e:5aeb:ea06 with SMTP id
 586e51a60fabf-29e5aebf56cmr5717843fac.41.1733161801659; 
 Mon, 02 Dec 2024 09:50:01 -0800 (PST)
Received: from [192.168.170.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29e520e34fbsm1302895fac.13.2024.12.02.09.49.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:50:01 -0800 (PST)
Message-ID: <c626df3b-3994-4898-a97c-e4d4a45c6636@linaro.org>
Date: Mon, 2 Dec 2024 11:49:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/67] target/arm: Convert CRC32, CRC32C to decodetree
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-5-richard.henderson@linaro.org>
 <59d6b035-8be3-43bb-849d-5664bcd34795@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <59d6b035-8be3-43bb-849d-5664bcd34795@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/2/24 08:01, Philippe Mathieu-Daudé wrote:
>> -    if (!dc_isar_feature(aa64_crc32, s)
>> -        || (sf == 1 && sz != 3)
>> -        || (sf == 0 && sz == 3)) {
> 
> We are not checking the sf bit anymore, is that intended?

Yes.

>> +CRC32           0 00 11010110 ..... 0100 00 ..... ..... @rrr_b
>> +CRC32           0 00 11010110 ..... 0100 01 ..... ..... @rrr_h
>> +CRC32           0 00 11010110 ..... 0100 10 ..... ..... @rrr_s
>> +CRC32           1 00 11010110 ..... 0100 11 ..... ..... @rrr_d
>> +
>> +CRC32C          0 00 11010110 ..... 0101 00 ..... ..... @rrr_b
>> +CRC32C          0 00 11010110 ..... 0101 01 ..... ..... @rrr_h
>> +CRC32C          0 00 11010110 ..... 0101 10 ..... ..... @rrr_s
>> +CRC32C          1 00 11010110 ..... 0101 11 ..... ..... @rrr_d

We are forcing sf (bit 31) to match sz (bits 10:11) in decode.


r~

