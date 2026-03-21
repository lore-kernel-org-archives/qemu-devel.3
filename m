Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE40E1094488
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 15:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3yDg-0007Rd-Am; Sat, 21 Mar 2026 11:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3yDe-0007R8-VV
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 11:26:31 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3yDc-0007Ce-Lj
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 11:26:30 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4852c9b4158so20722025e9.0
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2026 08:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774106786; x=1774711586; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k6PIZlwN0pzhzXW0U0gjij/V11eftDHQ+l/iHWjQ580=;
 b=L088aUKb8dCw2RYdbw17znkLvzbc1T6PHtRLZim9Aya81Iv9dq92mEq4nBDMlggl5k
 uSIlkGBA1gqOoHT57Smo2+ygUVbc/+fcUta0cA1v8DKfQwuG6waVovXkztjCxWKJUY7T
 xOh1HIG5VOzCJKgGVyKqI6OyyJHgfBWit612sJENbSY+LT0JMd8933VEXa+O4unlh84M
 4T88u+0Ye/TJ8E2PNvtUEQEmGrm7uMdVtYwnSKoomAsRD/M7sS1+njBsO0Tj6iYaNVly
 DP75IQiVh+4UT1gVK0Fv7ifsoJuSPV5iKR5xmJ8rnFvQuIdySfTnpdYnq8XIx8w4nElB
 aynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774106786; x=1774711586;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k6PIZlwN0pzhzXW0U0gjij/V11eftDHQ+l/iHWjQ580=;
 b=sfpc1JkxcH7BQYBRXeKU5uGS77fLRLWRajG3VmpbelsPI0F7ZY32om59hjmYoIyKAh
 Pu7y8dDEKFNMu5i4air9UgFdQDuYkmVNgc2YZdN6ioM1B4c+ch4s1VOGRL20aiidtMz/
 W63ZwwNVTFSkRGc+VFEnfWr/tbuTM/y2yGqOkguTWpZClWVY9e6UUJjtMOkriucxsjjF
 bzOjLvHJ+msAzTcR2VYWpUPKmNjfWe9Uk25CeMkaBWR9Tg7Gdf6+aEFtH4OLx6TyzQ7v
 AfqYKIm2QhjuC5TdPIgaXyjCjeYFMMhNwZsMfI1jNPcsAtVnFqj4bq/HrxwDfoXv//vT
 ZUGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWFLTodupQXLbldY67Z1/wRRw2Ka7UdclSxXrUnbSyf/OlPMz1sNy2iBvmu6wOLbfy2JQ+CLjhG9HD@nongnu.org
X-Gm-Message-State: AOJu0YxiuS9nAkIjlGzYKoRk7jGd/4H+WD4un0k+F29NfpaGectYGvAN
 EABJoFekpB9sghsuOQb7oNK1PA8FC0LFCFCxThnA73bFQU3+JBCueApCzIqCHK6xMNo=
X-Gm-Gg: ATEYQzzmLsVi/5M4pxloc8Oro/ePytIG3JSdzRb3SKZmSIph+C5D9aWno6XKcTI9gm0
 3z8udAH5x4Ojor3vJ2fPkSqMLbjrwMtH1Ymy/iOLLNVyoHDATczsn201cmNxYUkSk8rRuGRIHRo
 YN/ZHl35oYX8RgIt5GsZH8lYiUmKjolGUpgdLJUXYycuqFds0FNC+r7hmKPFL4mei7BhX9cXKPr
 wuGyQss1rhGeoWOzM7Kc1HOaWJGGGBMfsEpa46HzNYFZh0r3XmCDpohhklHbCvshb972hTaKJD3
 0JVMIhkG+eXje+mXaUkk+cpl1Dw5ez+rFg+BphTfKMND5MNwNmDpYouCVQneMX8VnJfvnZcUH8A
 5WKSOERR6t+EhWa2HuQ+Oa0+beIIM8QqShj/uBg6ILOwjFpXbvsxbAD5A/AJOejgRqb8reH1rNd
 G5LwSJqvyakoTCR5sF1IaCvrxQH4ZkjsGf+rXf5x+YlOyby2DXc6Yxv0uv+8G3O8226OnTmKhXy
 Pnc
X-Received: by 2002:a05:600c:8b31:b0:485:40a4:364 with SMTP id
 5b1f17b1804b1-486fee1af50mr95008845e9.26.1774106785754; 
 Sat, 21 Mar 2026 08:26:25 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486ff1cb178sm39360795e9.29.2026.03.21.08.26.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Mar 2026 08:26:24 -0700 (PDT)
Message-ID: <63ddd321-067b-4c44-99e1-9c6c0ac60003@linaro.org>
Date: Sat, 21 Mar 2026 16:26:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] target/s390x: Forbid to use legacy ldst_phys() API
Content-Language: en-US
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Anton Johansson <anjo@rev.ng>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@kernel.org>, Cornelia Huck <cohuck@redhat.com>
References: <20260319185203.11799-1-philmd@linaro.org>
 <f0965bf8-b736-4e53-b809-374945f0f48e@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f0965bf8-b736-4e53-b809-374945f0f48e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 20/3/26 20:28, Matthew Rosato wrote:
> On 3/19/26 2:51 PM, Philippe Mathieu-Daudé wrote:
>> Replace legacy ld/st_phys() by address_space_ld/st()
>> then lock the target again further legacy API uses.
>>
>> Philippe Mathieu-Daudé (5):
>>    target/s390x: Replace legacy ld/st_phys -> address_space_ld/st (cpu)
>>    target/s390x: Replace legacy ld/st_phys -> address_space_ld/st (mmu)
>>    target/s390x: Replace legacy ld/st_phys -> address_space_ld/st (tcg)
>>    target/s390x: Replace legacy ld/st_phys -> address_space_ld/st (kvm)
>>    configs/targets: Restrict the legacy ldst_phys() API on s390x target
> 
> For the series:
> 
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> 
> For good measure I also ran some s390x kvm regression tests, took a less comprehensive spin with a tcg s390x guest (on s390 host), and forced a few of these codepaths as a sanity check.

Thank you very much Matthew!


