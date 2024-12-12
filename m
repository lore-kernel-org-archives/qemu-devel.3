Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 630C4E77182
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 15:11:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkpJ-0003tF-FK; Thu, 12 Dec 2024 10:10:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLkpH-0003qZ-G1
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:10:03 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLkpF-0002zH-N0
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:10:03 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-432d86a3085so5099525e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 07:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734016199; x=1734620999; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zbFMmxz7nM1yc8p8UWBHCmx19nHrfB71vT62zsM493E=;
 b=zXcJiIyQrb0Yg2OP/cC3Z9rUPD06rPfXiowjZVUy95Rjc5+im6DpuOG6aZTupQJMye
 Hz/H6O1Ke6vOeDpBrt8G56b33FCZ5gwNWwYoeWGXko9czbZoru6BAX1XUaGhmN/4ebfz
 JF3IJ7Lkgt3tguju8PbddCRw46Ne+Jf+Q0FsTmhgjATZI9C6MlDUghKAfA76wXwun9ue
 bouZXEZDielKl2NUscDF8ELsCpaU4272ECrRgC+Y/MeJZIb5IhlrYVUdlMsABl6LN9lQ
 DjLaCeeIi5Z33VSziHkGkhDx0Knod9TqIDivW5QcFDNJTCVOkgbr/zZ1W0h+6aHsBoJD
 C8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734016199; x=1734620999;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zbFMmxz7nM1yc8p8UWBHCmx19nHrfB71vT62zsM493E=;
 b=Fpj+cW/Whg+KBkVi/dFm5evGRNjBRO9GTl2QOf+yaTGXLqdPkCbpgEziwA89bKxFno
 frLgoOO9DUBT6UYSeVllTysWBtuRwPYMdROxhuwT2T6Ed6RadSlSXME5qaFU+TL60QuS
 GSV+LhJgCA2cCVa3pvfee9g2lncme3jzi4VnVzS0eJ9q6biIDWe51+WJVWBhn9qpfamC
 rQyUQdeL/uMaT0fqrZpWzGJ+wSZTffp2/J5Pv0N94Q52YjxaQ9SOMrMrJo1Sl3zowbqG
 b8mf49sryGRoG4gzFv5SVc4AlC7F+oBvZprTSo9eoWfWHkfTS8Gqh9AJd+D8avwJTmbR
 okmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNT+GLQF5V7pOhNtf0kAXZjGgCOwOf2Q+lJiHCagjRJNASydY22ebrP+M39EfI+nWoEFVtCY1Ri9jh@nongnu.org
X-Gm-Message-State: AOJu0YwJxougN10jFXxJLMzM/d2L6wtFeyAm3y+ykaOkD9fs8f9VsPnJ
 UHTIHHfNlTN0Ql4D1q1arga9RJ5BbUli4ddyZBQzkN3op+wi/SM8eEB51WL0JyM=
X-Gm-Gg: ASbGncs/oAgQx+M79NWOnB5I/hLq1yIDUGjjnDdZLvzMtt7hvMAWtJt7dkFhSFjajHM
 uAfar89ue/wm++YFlGHwPlsGtJyGzSba8ZEe4ahJwqgzmJnK7aR5QqUwQAnIk7G2f0iVAY2Cr2J
 uB0gwOmZM+9vqhPJ20D/bfy4TLic8y+Ktil9oSIb8bUb73sJPlDWqqqDsW28hbipu3VdwQMDPMi
 Te/DkCYEhKswkG7HiLdljl8fzkZybn+SkbrQ23tTboGQA22bOi1vHZcB1U3dwffnylxLwPDxKMw
 gSvb+4ZfOzTgyB5Cz3O6qV1k
X-Google-Smtp-Source: AGHT+IGb5f2GuwX5tOKBoBnEmUqTLh+ALf69Y2Jh+IilyVYTad0LCLcg7VQVx3c9JrCv2k6nsA3EQQ==
X-Received: by 2002:a05:600c:468b:b0:434:a968:89a3 with SMTP id
 5b1f17b1804b1-4361c35ceffmr57443275e9.9.1734016198630; 
 Thu, 12 Dec 2024 07:09:58 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-387824a5085sm4265001f8f.38.2024.12.12.07.09.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 07:09:58 -0800 (PST)
Message-ID: <8c52c730-cc87-466f-b36e-270d738b86f1@linaro.org>
Date: Thu, 12 Dec 2024 16:09:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] qemu/atomic: Rename atomic128-cas.h headers using
 .h.inc suffix
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241212141018.59428-1-philmd@linaro.org>
 <20241212141018.59428-2-philmd@linaro.org>
 <ee831fff-eb0a-4e56-8eee-99222e55d707@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ee831fff-eb0a-4e56-8eee-99222e55d707@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 12/12/24 16:02, Richard Henderson wrote:
> On 12/12/24 08:10, Philippe Mathieu-Daudé wrote:
>> Since commit 139c1837db ("meson: rename included C source files
>> to .c.inc"), QEMU standard procedure for included C files is to
>> use *.c.inc.
>>
>> Besides, since commit 6a0057aa22 ("docs/devel: make a statement
>> about includes") this is documented in the Coding Style:
>>
>>    If you do use template header files they should be named with
>>    the ``.c.inc`` or ``.h.inc`` suffix to make it clear they are
>>    being included for expansion.
>>
>> Therefore rename 'atomic128-cas.h' as 'atomic128-cas.h.inc'.
> 
> But these are not templates, nor included multiple times, so...
> I don't get it.
I wanted to avoid including "qemu/atomic.h" in each of them due to:

     host/include/generic/host/atomic128-cas.h:23:11: error: call to 
undeclared function 'qatomic_cmpxchg__nocheck'; ISO C99 and later do not 
support implicit function declarations [-Wimplicit-function-declaration]
        23 |     r.i = qatomic_cmpxchg__nocheck(ptr_align, c.i, n.i);
           |           ^
     1 error generated.

