Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6893FCCF9EE
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 19:11:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDScD-000882-3w; Mon, 27 Oct 2025 15:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDSbt-00085r-0Z
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 15:10:29 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDSbl-0004S6-QB
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 15:10:28 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47106fc51faso64150675e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 12:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761592214; x=1762197014; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GZqcAHDwq/8bZhVixDcuWRbfbFG00mvqohzqg6Rug3o=;
 b=w9T6xW9EZgFMLrhJBJ4Xc8BAZV4f0T4snPYjxuVG/HgM5khyTMoh7YwbmAYpWhOqIt
 EOEpUodypUs2mIzdu4qDqJIQhWlfVnQ4DYUG7/EUxboI9xAlOfSiMcDXO6Vipxce6o0V
 IVvzu0wv9ZnIJQGewQwkbL46i7CIUn7SpunJOYkVztWCaITA9AcvhR/NZ6yDOUMArrff
 F2odpayApH6sWlhMwLFR2WRVBnFWMZpXN1phsLl6YB0lRhomIGyrRJDyx6hawZqB6v99
 c901UW2KsRYakP3Q+Z4o0T+onU1taxSG6Vp5Cjhiqx1XO7Db08icjVOScUFaKHgtEYgN
 c1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761592214; x=1762197014;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GZqcAHDwq/8bZhVixDcuWRbfbFG00mvqohzqg6Rug3o=;
 b=YHtPvg3290Bc+QU5c8kHx03IoHOkG/ZbPg2H+z6HLsJdEERsxtcRaaGqo6F6VMRcQc
 zS1Xx61YZW88jW685qJ2YAlZgAeTK9hfW9yWIy3s3jsjg5ISZ9FnHznxb/iDoa/O8Tbw
 f5/2t9uIMyORnYzfCGEBYeAZcJbowc721G7CtYsGfjjLrvHIrtT1srGdTjXJw0MPNlfh
 hoTEyr7R3+gC4vGlLgMrMUyJIQE1TQ8gwuh2Hs4/FHDkJe3P7OTwOTf7sZAsMFQYKphd
 sHV+tsZs/wjVZWvrrNNrt6HOtGaPMh7ian9L/+qBpleaIoUV/6xPuVRw7bleNKvVz+EP
 UWUw==
X-Gm-Message-State: AOJu0YxCvFKcDjge5ibDSf3ad/fV/zJ+DKMRLYk28EXZ6dc4QWJQc7hH
 1s2bGPyzRSFhUv6cPwstRzGTTuh9/X3a4LHYPLZKTD+d76deXETVcUGfs65pn50qt14=
X-Gm-Gg: ASbGncs8oJpZTvxtFcpe/ZZfokzOCdS5BzdGWEDBssp7S3qlUAJxtqcmuIMEn9X6x6Y
 nac4g7LZbRvq99ZpDeHkVu4kJdg1uJlKaXE5Sei3h6fY+ODWQuMiQpDJbXpbOJypKhzZh2CbrrV
 F7CQKK3h7xzxNlG9jnSIONvpPZJaAQ7jBFzNt4JZP8YiJvZ5KASbgsh6jKpV1dl723S22kjrgEp
 2lnOPsELvWtJxC3zgHN+bRzm/CysGuBN0C4TUDG+NLufKjBnbTrRKbX0+RJ0br75bNumWKuCtiI
 a+fk1LSNZftNIhurN9QLG4B6vIJglo+ZHOU9osBL567nH+69xmwzmwohV9fFNAzAW9KQAguqfHw
 AelyoEO3X+tP7MQVA9d933beg0oGQidV4zl9gNXOfbhthyrI6pAbggSx6PiKr0FqVFpB91pUpoM
 z+X5r8UQoo3jj+zoVAhvlxGn8Cux8fnGyeJraLzpPjogA=
X-Google-Smtp-Source: AGHT+IG0dnk6viuMYuv3p9pVd882H/nSFmvWImA4i+sCJTw4ScDlneA/Xse5EKR7zQi4sqY8OIsR7Q==
X-Received: by 2002:a05:600c:470d:b0:471:1306:aa0f with SMTP id
 5b1f17b1804b1-47717e61be9mr5579345e9.38.1761592213678; 
 Mon, 27 Oct 2025 12:10:13 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952cb55asm15772917f8f.17.2025.10.27.12.10.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 12:10:12 -0700 (PDT)
Message-ID: <e537ac2e-efcb-4e04-80ca-8448bf4d73b2@linaro.org>
Date: Mon, 27 Oct 2025 20:10:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v10 0/6] core/loader: capture Error from
 load_image_targphys
Content-Language: en-US
To: Vishal Chourasia <vishalc@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, berrange@redhat.com,
 alistair23@gmail.com, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, adityag@linux.ibm.com,
 milesg@linux.ibm.com, npiggin@gmail.com, balaton@eik.bme.hu
References: <20251024130556.1942835-2-vishalc@linux.ibm.com>
 <53420335-4e33-4dea-8cbc-2c1f1b7667a6@linux.ibm.com>
 <cd09f9f1-6853-4e1d-82e8-1a167a9e7859@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <cd09f9f1-6853-4e1d-82e8-1a167a9e7859@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 27/10/25 16:39, Vishal Chourasia wrote:
> Hi Philippe,
> 
> Any comments for this series.

None, series queued, thanks!

> On 25/10/25 10:49, Harsh Prateek Bora wrote:
>> Hi Philippe,
>>
>> Thanks to you and others for valuable inputs on the series.
>> Should this be queued via your tree ?
>>
>> Also, I see Daniel and Alistair had provided their R-bs on v3 of the
>> series, which were not retained possibly since the series had gone
>> through  multiple iterations with significant improvements. I hope they
>> should be fine with their ack on finally approved series.
>>
>> regards,
>> Harsh



