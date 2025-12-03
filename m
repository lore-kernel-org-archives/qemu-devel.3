Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F372D15DBC
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 17:28:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQqeY-0003EP-5m; Wed, 03 Dec 2025 12:28:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQqeW-0003Dw-A3
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 12:28:32 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQqeT-0005gv-L6
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 12:28:32 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-42e2d44c727so36167f8f.0
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 09:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764782906; x=1765387706; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qi39fxeo85zsyPjTzGqWWSYCJvp76khQeXeQq/WJLOQ=;
 b=E4ypMKR/MxbhiAxTr9Wej9VJVRqLg3wGGXjcsktdNGrLiOZQv2JCC7GAduAXCw8MeD
 /x+LMCMDg5esE24J/BBtjs+J53pl+JvYjqi6iBVFQNo4Tu9MDiNULMYobuyXvZldW2ab
 US9TJr3JKTIsNFVmNnvephQ06TZbI29Zi+LpV3uPDJFY5LFoOdPwqHf6j4jU3G9IGp51
 7Mb+P3N1+LAzaN1tGSA2nzVry6jHaPyIliKQJPWkYhDzj5vNvjhPcSuuDqFU56wxpDkM
 77J0CmBl2ashjtn3x8nwJS9vZtpwZ3iI94QMUbVMNOHVeeOfvJ8hzARviUGAaUx1pa3M
 qisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764782906; x=1765387706;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qi39fxeo85zsyPjTzGqWWSYCJvp76khQeXeQq/WJLOQ=;
 b=Q74NfXnuktIOWF5cMR04p2Tq5nNkkFU4HpcewB+5JXp8uoZ41pVHPKhrg8bRxO2JpI
 Suz+fAJhSskKFl83lea4CvDvJRc7jiteb6+w8zlYX2q6imHq43eifbSt+bix9t4Jcx6V
 7B1v25asCj8/MBM0WSjGsfFm0lNBl1uEI8qGca23u3UX8UjyViQhhR+6xwrbwczpWnvQ
 SL2tQiFySBdRjlcP3GkCV3izbbSFn2+bBpxDH4qq4YMj+SmBGmFcyaFuE8MqBhp/Tnq5
 CBV1Y7VjTp0OtylO0DMvA04h/VqMxWxY7sqee/W5JK37apvVTmxblp7+GyQot2Ax8VvY
 jmDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWx7Rce3WW7cf8sg5tLZCCLypcXRyX8AcWaop85b4nfxmLUzLHPJODXQOS7VJ+X7qG4DrFLehS/rA4W@nongnu.org
X-Gm-Message-State: AOJu0Yy5v78lBOErMZxnqDP0Q1Y52Rl2BqAUQjZVs2VVtx89x+fCn74n
 i28JBoDm561Bns/rNfhxMJ8QeGD6BRW/Qvhm81x4VI6BTktOJF6zvqpELCYyTZB9zFs=
X-Gm-Gg: ASbGncviyxEliAIIJsyL1LskDkYIRsZnkE6lTPpIE/n/rxZn7I+HKzMwxrL2e4jWhnA
 KYnch1JnncF+geAOBRqdclHu/gN+vqnsJk7rQvT4YcENPoraaerId5hMqi88UMfJyHXm1r5345t
 AOBwq8HW9I9iYhJoNg15mNW43fiiCJk5sW1/oRo0zP6ehQicKgJPUfYIMzDsfTRb/++3cy+eiZf
 mHawgNvXrRjOLaR528nfO1tZ9hHpe88wieeLqi7kxLj+FO+H96RM5slwtJxXgT2+qyFSAow3rzi
 DG7M8Z4Yjx7PNK9q8AhqtuoSgGiHRGGJ22ezcBN0Q3cNGzCvsfozHC1iEmAmju/wd5NPSzN3Y5l
 heX9dhz8/G1/1c3i1W6mZBdoDBNqWk+Z614RaRLSIVLNyqNGvIAgRnNQbzWtbE5c8u8NRfy1Us/
 tosUaHAdr7jAMRP74uS6jbBFGdwD4RkntEfTs+g/s93bjWEcBq85irgA==
X-Google-Smtp-Source: AGHT+IEoD1iXR1h4XIiiLJBD9xNwNl7KDBxzmYxHapD6h6C1vUghLyxK1X4En+7QIRkovsYBdQlDbA==
X-Received: by 2002:a05:6000:240a:b0:42b:3806:2ba6 with SMTP id
 ffacd0b85a97d-42f7319d3a5mr3083067f8f.25.1764782906351; 
 Wed, 03 Dec 2025 09:28:26 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1cab9af3sm39518778f8f.41.2025.12.03.09.28.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Dec 2025 09:28:25 -0800 (PST)
Message-ID: <ab0f7be4-4d57-4936-bba2-579a806e22f9@linaro.org>
Date: Wed, 3 Dec 2025 18:28:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] include/generic/host: Fix atomic128-cas.h.inc for
 Int128 structure
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20251203161500.501084-1-richard.henderson@linaro.org>
 <20251203161500.501084-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251203161500.501084-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 3/12/25 17:14, Richard Henderson wrote:
> Use the Int128Alias structure more when we need to convert
> between Int128 and __int128_t, when Int128 is a struct.
> 
> Fixes the build on aarch64 host with TCI, which forces
> the use of the struct.
> 
> Reported-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   host/include/generic/host/atomic128-cas.h.inc | 24 ++++++++++++-------
>   1 file changed, 15 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


