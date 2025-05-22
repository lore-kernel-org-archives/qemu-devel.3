Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB93C54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 18:42:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIArd-0002DE-03; Thu, 22 May 2025 14:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIArZ-0002Cb-N2
 for qemu-devel@nongnu.org; Thu, 22 May 2025 14:41:53 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIArX-0002Cn-Ts
 for qemu-devel@nongnu.org; Thu, 22 May 2025 14:41:53 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-742c3d06de3so6269722b3a.0
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 11:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747939309; x=1748544109; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Dqf+6w2QfOmdXavhJ3Obery6ceilUl9qhvYxqUCLtHw=;
 b=ge4hSLLPBteZDkBVYR4l7wYmutW2RwjhtmL9u1/RDBvn6tGe9YikkEMYUrC1vGvdyg
 AKEZ2Cgdl5JdbS0/TRprHdpqwPlv8t47j3omJpZlAKsBXfZ9K+8/NZ23240gmD8KvkWT
 IMh6Me/gmZGP7JzHPD3/LFVTjrVo6YI7UeHgbFer/w84T+8XhVnS7YY70pF4mYE/ANgO
 l9Y+8jP9ErIa9lr86r+PV6CLPGQYwJhndvhkjTNKY5qY7KjH2E+WppQcwRu9uI35+oFg
 +RyluUwqEQawBilEQwbTxRH4GFUll3zq0lWUqVFP0OocURzmV0AS+IzDrEPW+aN2z0C6
 8oKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747939309; x=1748544109;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dqf+6w2QfOmdXavhJ3Obery6ceilUl9qhvYxqUCLtHw=;
 b=eHof/O/M1pawFrfjDIT9YUa0t9eBahlNz6bXs9uzcaYf66SQQAl/MDO2tQMhMRl2zD
 ikNBsBQfEZs+WNr/Hxl08UyLIswmu3HvU6Ce0UkUtXoi6QDO8OAjDgoR8n3nu0ZXI/SD
 xPP0D15FRPeQDpezCMEZOAPDStMIhuWETYTClyFLP7E8SGtpnXCNPYzFAAGWK69/Q4tg
 0EUmQYNbjq/M4eCAR7r5lwTlMOXv9IODxhIvbKe40XgazRAbsVrizHOpViHLxB9RDQ12
 VqUXCx/in4ouVa1jdRSdUZA0w1cbYdFvgT3wnPW2DSj9r4DEyaRXiIeL8Tj1++YVwatH
 Ow7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVO9nUQpOEo6M3iaozVHtNKnyEBT9rM/4r/i0b1aI9a2UuPGp1Ejw8CTVdVNSjOOY7duOjDqWr+PhbC@nongnu.org
X-Gm-Message-State: AOJu0YyIISQkPkZv1vWkBs+TkijLazQ1hkxcaLNwepja8u1gx8LygNOv
 uxByFaXaKGwNujURa6CmdAlp3X0FM8O3nf7h7sxrCMypX2ZVLrch0V7wlgUUeZ6AR4I=
X-Gm-Gg: ASbGncs2JOe1L8i+H38ndICSor2Z6yd2+XNblsE1akGd2rBxFE8JTOdBHaMsWZMMyE6
 U2yZ8qJDBFlvc9r5YJgMvAWtBzU2+n6k9QLMvI8e4sMJCbkW0wl6CiuIcIT7HiAnxyuoa+rd8t0
 dmXNVmjJ7uSfJYsN5sQGu+eMy1emmxo0mwKmJL1usGXihOqPAmrhTSmuWES3IyADHh7G38Iy1HF
 ROrb5snHg1oJuZXK3xxpxvsU8Mpx6VJ2lzN3QqykHQTwBAAp2OSLHtGOZESgiQVxqVxTZZZdrA2
 7q/HX9/fGwI7MYcSi/q3JkJTQASFRpI1h2sMnLyLjSFlM+P9jlNqK0li/rqxkEMV
X-Google-Smtp-Source: AGHT+IEWk7mGWRc+KoxqKjiasU2XzKA7uaPpJVNySwHRFLgNzh5f8+IUNe75ERsDwX2gruzEh+Paqw==
X-Received: by 2002:a05:6a20:1591:b0:215:e60b:3bcf with SMTP id
 adf61e73a8af0-2170cdeb43emr41521787637.30.1747939309133; 
 Thu, 22 May 2025 11:41:49 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a98a471bsm11554857b3a.180.2025.05.22.11.41.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 May 2025 11:41:48 -0700 (PDT)
Message-ID: <1a5b4bd2-4648-41b7-a6c3-9ad5c843a063@linaro.org>
Date: Thu, 22 May 2025 11:41:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] hw/arm: remove explicit dependencies listed
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250521223414.248276-1-pierrick.bouvier@linaro.org>
 <20250521223414.248276-3-pierrick.bouvier@linaro.org>
 <a86894c0-5afa-4a85-bace-aa138f77a161@redhat.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <a86894c0-5afa-4a85-bace-aa138f77a161@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

On 5/21/25 9:52 PM, Thomas Huth wrote:
> On 22/05/2025 00.34, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    hw/arm/meson.build | 4 ++--
>>    1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> There is another bunch of pixmans in hw/display/meson.build and
> hw/s390x/meson.build ... I wonder whether we could get rid of those now, too?
> 

It could, but those files are not (yet) included in target_common 
libraries, so I think it can be cleaned up later.

