Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE40C3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 16:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twkqj-0005zb-7s; Mon, 24 Mar 2025 12:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twkqi-0005zE-Iw
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 12:40:28 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twkqg-0000T4-3j
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 12:40:28 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3913d129c1aso3316914f8f.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 09:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742834424; x=1743439224; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bTa1qSYmCQTmQKOmrsf4vKQV804JWM9ydm18X7vtUJ8=;
 b=kdZvkyz994YlAMnFqp9BxgWZsJfJWm0GYCPYdnzjhmOnn4gGh+TfG0wwDcLPQ1QEuz
 e5bwxcPIoVc/JbfoCWKcFJ9biwSpDNj8CMU6d6twE4J/vAr+uaAbgEGbYTpipWkd0QvZ
 vEWC/dQCcVjoXD/+qodoNv9eRJuDzpIkqpFZ2VcHWu2NinEZXPHUbJgoomLhyqF3zd67
 EKgQcJkTcBEn2th2HCNmEKeu1CIv7B5TdfiQe0oLdiB7dBZOVVQi4CuDqutBmEqakS8U
 f29/1kEfY0ihCnPdEDqghZHyLse9bHVEiocApyIG8+TUb19wsBjrQ+AG/2lEyoGFuRr1
 xauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742834424; x=1743439224;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bTa1qSYmCQTmQKOmrsf4vKQV804JWM9ydm18X7vtUJ8=;
 b=RdTqULP9orGOL+zf1HgUqicVXuFWYMxVNXrLMnc8F9cR9vDVaL0YSD0ciMXi5jJiyA
 aqYlsxj1wZnhmN5wD+s2bmw0+T3ZgAtKuQJUvKPGTjwTXQdk9LcS2tLTceSwI4EX46k9
 CSI+e4Pd592rA3rlbqU9U5Lkx0etPZ3oaeSUTbNsp8GUD6J5MWph+aiUejORWgS/Qnaz
 OR/XrbZVTuXN3DvBh53Wu0Vt3JSuU9jp2k5ik+JGub1eGE34xBfJKiz4bS/QdHeWMhtz
 1G0hABQUkiIRv1jy450zDmXCQemDvjZ51nqM4JHH52a7MY4m9xi9ZfTA4SRyANMoue3G
 VzdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOCdxchxJk0ENnPl92NihCdy3RoiD4PdmeTea62KPqXzu3M4RJDVV6EaBIQ3G361saeBqIOzA8X5l2@nongnu.org
X-Gm-Message-State: AOJu0YziCoElGTzm0h6Iopwi2dCxV1nGH55l21PU3+RAbUAa+zxY6jUy
 4/J/jtS3ylNs/waLbz23NLhpdhZZlH1NcMjTs+Xqj0YG9vuGw04f/p+MxDT3ems=
X-Gm-Gg: ASbGncu/EqOBNen8HnZZ2QWpxUbbXdgs1rKUWNBd1Y+th2toO6NZvbX2N8enSU3HPco
 8/wCsuXWdMCad5Qhj5ciA57w7Up5wZFBuOq0OO+DhbAJK8EwJb+d4ndwQ2BjOSU4yM33xPbDdJs
 SP9G9V7wRtcljjnmNTwUBHGuW0gpjUBsZTpbsPY8latQNeXmWEc5YorfAa1ZTs3Pn43ToQx4RJP
 iCnv9j5mDbkD0eB5dB5BGXgmHmQwsfkCRyrND30E+ODyRD/h3KMbFNwf1MqjaV5mq8Cn216/3sV
 epVW/Ifvyl0Uam+eQME6AVzEYqHyOWwWCxjCiLp0OfK800ptp63EB2cLF5KHkTII6gyETrlpbm0
 pp5i9fhemuY8KoVcLOQ==
X-Google-Smtp-Source: AGHT+IEvZ/GXzs2W0cmBjidBxwdbJWVMhXMMKf14qXn9WElgvhHpYj93Nmhq/cx3A3UvvPASUW0QoQ==
X-Received: by 2002:a05:6000:154d:b0:390:f025:9e85 with SMTP id
 ffacd0b85a97d-39979586dc7mr15451843f8f.21.1742834424250; 
 Mon, 24 Mar 2025 09:40:24 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fdbd348sm125765705e9.39.2025.03.24.09.40.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 09:40:23 -0700 (PDT)
Message-ID: <6d31aa14-376e-471c-99eb-646f25e6e9b2@linaro.org>
Date: Mon, 24 Mar 2025 17:40:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] include/exec: fix assert in size_memop
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20250324102142.67022-1-alex.bennee@linaro.org>
 <20250324102142.67022-2-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250324102142.67022-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 24/3/25 11:21, Alex Bennée wrote:
> We can handle larger sized memops now, expand the range of the assert.
> 
> Fixes: 4b473e0c60 (tcg: Expand MO_SIZE to 3 bits)
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>    - instead of 128 use 1 << MO_SIZE for future proofing
> ---
>   include/exec/memop.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


