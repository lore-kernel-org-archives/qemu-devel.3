Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59DF2C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 07:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvAMs-00066t-Fe; Thu, 20 Mar 2025 03:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvAMp-00064W-OI
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 03:31:04 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvAMk-000439-95
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 03:31:00 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-391342fc148so220742f8f.2
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 00:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742455856; x=1743060656; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9Q3cy8jYCn9xr9CHTDFTQ86895kEPqzjD05yFJjZ0rw=;
 b=Kd3Y0EKT2SN0SmyaG6paEhHajzBeffg/cr+px+GDYQShLpT2x/DG31ckZnzLLhkg+R
 cUFSzB6NFFvgsc5UhGRdRceZXZVfuEsWEMni5ZzEg53Bd59365bf1BC+A6WF63FfR4N5
 4YZKoU1ohv0hsIMF80mYDg8Ur1OuYcgzxbLD1nCRU1CaMNj6TeLzX727++nvt5Gt3QzC
 5m52peCNfC1jwwFX5xRxMwRsM4JKNAmSElenBzk4c6I6S19TpjDFm9SUF49KaBjo3+K2
 txWXBCsqsC1JUxp6lrD3N4A2z46XPFJ0tuWcpGMhG8BvJZ697UXPRIDJv+VkCMNFzaA2
 1XlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742455856; x=1743060656;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Q3cy8jYCn9xr9CHTDFTQ86895kEPqzjD05yFJjZ0rw=;
 b=YbleKzdzVUUZ7mVm26c2r/T1NMxaLq9DXHP4izHwIBctwnujJwptWVXTuDYPF4osNc
 wzyecw6h8tZ+PT4+t7Urn19aZtHo4ddR3RwU+jycH2BmxmcNaR4TZoc9j5YMzyYyt9/Z
 MX//oKn/V3z0cmgQHizHqfcOfsR4Z9jWYNNV4eaUZ5WhjNAiyjKgTFAz4bSC2YSGkQMF
 wan3QbjAEjU2WwIVXPQJoJhRgwawpCSB7alQU/sZf7QnBizShvw1NHGh+o82jBHwGoiy
 C65O+7tr3oPupEtVLnFH3q0GMmPtYv/5kexennma7HF76IdAw7bl4SPA37VSVCG+i5hA
 J32Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjnJJXeR+m1QjRVdfJ3UuQGdtfDtyy8u7Cw5Jm8GMQ/8Ih9CByLZzfnf7Kfxdy2vtEgYoJb+2jebg/@nongnu.org
X-Gm-Message-State: AOJu0YzBQMUwWAAqnw/2YvBvAworxzco9UlpkzVu6l0bPcbOSm8sc+2a
 fhMjvw18Z2nOZh7l6zSKI87xAynxZ3ZldVQBEaBP0UhjTvdIJoZpUC+yidak+vM=
X-Gm-Gg: ASbGncu+isUTVG6Dgo/cYppjh/R3HTaYwBK7NY2qMO9QxhuwzR5cvKwT/Tjcm10Hidw
 wTi2VEUaujCfxoZmfdxdloycMFRrCZaWA7HvBnwuBryZVCdNJzgJbVIWdPLGVfDEL+Hr5Jim5qQ
 m0xhgVaqZYToCg3trDtjcKja/C87SE6GYXm4repQaQyabIuX4uEJVbusy5B0saXKU3GbyraZl+r
 3bT01iA6HRgetTmHiuTEhr9xcMEl3uoPpovjmTdm5XK/wQvC7CWr2DufBVjXEXJAy/FTGEmnUcO
 +NsA9KVHUHQt/skzO3aDvkYA962MCa1XByWBgcgu9tPTR9QHd0GmilxwPZzpMr2BJKwak5dZbIi
 g31bxTBXzFfyO
X-Google-Smtp-Source: AGHT+IEEU0dq3TPYHgyykoRWUKZC23YFtuaNL8zhpMLcXVGLieVgHtXNvExrNGc44SfaN/TffgArRA==
X-Received: by 2002:a05:6000:401e:b0:391:454:5eb8 with SMTP id
 ffacd0b85a97d-39973b3207fmr5800696f8f.48.1742455856248; 
 Thu, 20 Mar 2025 00:30:56 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39972df9b9esm4431024f8f.18.2025.03.20.00.30.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 00:30:55 -0700 (PDT)
Message-ID: <05412bd7-a389-4e9b-a344-1a65396409ac@linaro.org>
Date: Thu, 20 Mar 2025 08:30:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] include/exec: fix assert in size_memop
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@trasno.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>, qemu-s390x@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, qemu-arm@nongnu.org,
 Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20250319182255.3096731-1-alex.bennee@linaro.org>
 <20250319182255.3096731-10-alex.bennee@linaro.org>
 <d3688ce0-e2f3-4bee-863f-dac7a394c789@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d3688ce0-e2f3-4bee-863f-dac7a394c789@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 20/3/25 07:29, Akihiko Odaki wrote:
> Updating the email address of Juan Quintela according to .mailmap.
> 
> On 2025/03/20 3:22, Alex Bennée wrote:
>> We can handle larger sized memops now, expand the range of the assert.
>>
>> Fixes: 4b473e0c60 (tcg: Expand MO_SIZE to 3 bits)
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>   include/exec/memop.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/exec/memop.h b/include/exec/memop.h
>> index 407a47d82c..faed3ff902 100644
>> --- a/include/exec/memop.h
>> +++ b/include/exec/memop.h
>> @@ -162,8 +162,8 @@ static inline unsigned memop_size(MemOp op)
>>   static inline MemOp size_memop(unsigned size)
>>   {
>>   #ifdef CONFIG_DEBUG_TCG
>> -    /* Power of 2 up to 8.  */
>> -    assert((size & (size - 1)) == 0 && size >= 1 && size <= 8);
>> +    /* Power of 2 up to 128.  */
>> +    assert((size & (size - 1)) == 0 && size >= 1 && size <= 128);
> 
> This is the minimal change to fix, but perhaps it may be also nice to 
> change it to use MO_SIZE.

I concur.

       ... && size >= 1 && size <= (1 << MO_SIZE));

> Regards,
> Akihiko Odaki
> 
>>   #endif
>>       return (MemOp)ctz32(size);
>>   }
> 


