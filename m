Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E52C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 08:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udlw6-0007QR-88; Mon, 21 Jul 2025 04:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1udlvl-0007EK-N5
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 04:31:32 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1udlvi-0001J6-Rl
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 04:31:29 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3b611665b96so2166070f8f.2
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 01:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753086682; x=1753691482; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BM+XpGpoFgdgk8BQ/1RXBrAiK2PD629/Ss/licxoFoY=;
 b=nHpqjedm2dGIk2yIjm2ZdIB6pblmgZr4ROiy6GRkldMo27MhiBBUdH9q044ZeRMnPv
 XHCaayfX/dFH273++EVxKdkWiFzq3QMV40rNVvYDFLVYeyTNnH8RbIa/whqd8mCx3IZE
 NDFDHWBAsNofzdUzgYU7XAnClJ8s99MnipaBCZuqUP2Qi7Fb3QnCqi+O7uaBOPE/pdW1
 k2KUmDjzkvDz8g5y9KfRtdcWPwkTpaWD8w8pn3x4TXD+Wm0oW41QBWVU4st8XJh2DHtz
 0NlGsyQgHwbliysTAwgzNfVSoqgTUZFLttK89/wfTzQPVXSV3nn4qWjbRVFj0UL7n7Dk
 aOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753086682; x=1753691482;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BM+XpGpoFgdgk8BQ/1RXBrAiK2PD629/Ss/licxoFoY=;
 b=J4cPEixUACkuLEM63bcys7VSiZU6wfy511//MzPA/zY94WW+QxF8L81Uy+CWleoIYp
 /2dtqHqCI6FA2mm/+ouV8aYSQatqVzIjCi1jf1fJLKrapriKblj+vsu5c3uWKnziEqaV
 w+1EBDvB41PvaWhsKzNRfL6R+6wxovzbzo4ds/v6uIMmvvEYax+kWEFUnzPvxqsNT8xi
 aCeSdTDFGtqfwhPhf++o4oBdczy38hIwirX4o3WB2IiqtWXqbZp97iNhvb+frnbub319
 RskhBJO2qbKJavd/sJbML2UjLKwZfPqRipuJiXYzNSWtp/dBzH9Kt6Y62iSBr/AElvwz
 lTFA==
X-Gm-Message-State: AOJu0YwNraIu1YaacZCiojmWzOGd89B5MwJlx817VtmRqao/H3M4++ti
 jtzOaj/M1xuQ92Dl8UgdYGaRHRyZ0mThginNMySqxvhhNXrYJucFCWBet/gpDNTVdCo=
X-Gm-Gg: ASbGnctyX5nd0Q/xvHGULYnFzF/vDnUsWSDARXkxro+Mm4Ymt+41Fu/9rG8KjEYHInA
 Omk2FmF2j71B6ExQr41M8wViDjB48+RIA4sc7qU0tZboJUjf9XSk6Snaee72EOjBI8RxiSI64eS
 sKYT5weogXph4SE7MDY3Kko41roXyWyRpRn4+STbMX1355QTWZ8ShoU81w7djLYk47fa5RWODLG
 WRFgNtFI9qEKhLL3VUV68+U3bPWZheNrgISRnYRwEk8vynkRWa8eV1ZWfKAZyMSCGt0VGtpYxUm
 ZII5Hfl2BuhHEMYcAD7o7SqLvOBrZI1k/UESUGmKT+2kOhQjnWMUyBFe86KKE/CLDVpI114JdZN
 aqrWHJentg0LmuEB3psoeymqbgqqDeIvPc6MsdYJJW+mKIcevAmsa8L9+aIKFX8FrAQ==
X-Google-Smtp-Source: AGHT+IFeyPnrsHwb3rD5VoWiT/kBU8pSy7umjSVdZ/RBKgl1eO1v//vLicqDE1mSZ/gnrGwonbsiVQ==
X-Received: by 2002:adf:8989:0:b0:3a4:f936:7882 with SMTP id
 ffacd0b85a97d-3b60e523c5dmr10921099f8f.55.1753086682317; 
 Mon, 21 Jul 2025 01:31:22 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca48c40sm9826049f8f.58.2025.07.21.01.31.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Jul 2025 01:31:21 -0700 (PDT)
Message-ID: <4068807d-d1b8-4929-97f2-520a2b46d891@linaro.org>
Date: Mon, 21 Jul 2025 10:31:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] tests/functional/test_aarch64_rme: update image
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, jean-philippe@linaro.org,
 richard.henderson@linaro.org, Leif Lindholm
 <leif.lindholm@oss.qualcomm.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, gustavo.romero@linaro.org,
 qemu-arm@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>
References: <20250719035838.2284029-1-pierrick.bouvier@linaro.org>
 <20250719035838.2284029-3-pierrick.bouvier@linaro.org>
 <CAAjaMXYRar1FnWSXqxRb1cKabWOXu2YxFi5B_JhypS0OZZ2LSg@mail.gmail.com>
 <7afa0c8d-71a1-4c97-aedf-1ed401f95fad@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <7afa0c8d-71a1-4c97-aedf-1ed401f95fad@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 19/7/25 17:38, Pierrick Bouvier wrote:
> On 7/19/25 3:57 AM, Manos Pitsidianakis wrote:
>> On Sat, Jul 19, 2025 at 7:00 AM Pierrick Bouvier
>> <pierrick.bouvier@linaro.org> wrote:
>>>
>>> TF-A needs to be patched to enable support for FEAT_TCR2 and
>>> FEAT_SCTLR2. This new image contains updated firmware.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>   tests/functional/test_aarch64_rme_sbsaref.py | 64 ++++++++-------
>>>   tests/functional/test_aarch64_rme_virt.py    | 85 +++++++-------------
>>>   2 files changed, 66 insertions(+), 83 deletions(-)


>>>   class Aarch64RMESbsaRefMachine(QemuSystemTest):
>>>
>>> -    # Stack is built with OP-TEE build environment from those 
>>> instructions:
>>> +    # Stack is inspired from:
>>>       # https://linaro.atlassian.net/wiki/spaces/QEMU/pages/29051027459/
>>> -    # https://github.com/pbo-linaro/qemu-rme-stack
>>> +    # https://github.com/pbo-linaro/qemu-linux-stack/tree/ 
>>> rme_sbsa_release
>>> +    # ./build.sh && ./archive_artifacts.sh out.tar.xz
>>>       ASSET_RME_STACK_SBSA = Asset(
>>> -        ('https://fileserver.linaro.org/s/KJyeBxL82mz2r7F/'
>>> -         'download/rme-stack-op-tee-4.2.0-cca-v4-sbsa.tar.gz'),
>>> -         
>>> 'dd9ab28ec869bdf3b5376116cb3689103b43433fd5c4bca0f4a8d8b3c104999e')
>>> +        ('https://github.com/pbo-linaro/qemu-linux-stack/'
>>> +         'releases/download/build/rme_sbsa_release-a7f02cf.tar.xz'),
>>> +         
>>> '27d8400b11befb828d6db0cab97e7ae102d0992c928d3dfbf38b24b6cf6c324c')
>>
>> Hi Pierrick, I got:
>>
>>> qemu_test.asset.AssetError: https://github.com/pbo-linaro/qemu-linux- 
>>> stack/releases/download/build/rme_sbsa_release-a7f02cf.tar.xz: 
>>> Download retries exceeded
>>
>> Maybe fileserver.linaro.org is a better option?
>>
> 
> In years of using GitHub releases to download various sources/artifacts, 
> I found that it is very reliable (as much as cloning code from GitHub), 
> so I would favor this over any custom solution.

GitHub releases has the advantage of not involving manual steps to
upload to fileserver and generate a shared URL.

Another downside of fileserver.linaro.org is its bandwidth is limited.

My 2 cents anyway ;)

