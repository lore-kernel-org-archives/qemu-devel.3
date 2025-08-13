Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED84CCA0EE0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 06:09:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1um4fF-0004Mj-Aa; Wed, 13 Aug 2025 02:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1um4f4-0004LY-1k
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 02:08:34 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1um4f0-0004wQ-77
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 02:08:33 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45a0dc77a15so15956195e9.2
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 23:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755065305; x=1755670105; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ENCAYDjp+PDVl2IS5ZyULDrTb1pibqqvUg9qN9kQHUE=;
 b=gxsSo0+m92Fy9nxFTG5lwOdtVMNAvo4cyz/HkLXg4XiYWqXp2VEWZIn65l13ZBZCRC
 N+eBdZENNiesUv+XRpGMwH5HyAroMebkUTQA+UEDR2GFIfFvNIYpH8eCk71vL1+rYDhd
 hf+uVAGMcxn/06UHv0ypzkeCnS7WVuZjhTUzb+nRHJr9VBk1IGSsLQlwVQsaSMz/J5ve
 Te/HQy0wonxsoXjtPoTiuxrPGHy4RZqQa2YTha9PbY4b25P3yGd/r8+Be8EGAxCpVhJj
 RrxZv2jjkSkFwV4lQXkujeJN1oy1igrTF+FPbRg1gWOZ4fen8yTeDibToEWpvih9/2G/
 S7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755065305; x=1755670105;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ENCAYDjp+PDVl2IS5ZyULDrTb1pibqqvUg9qN9kQHUE=;
 b=upjbBiqL31eECjZ6bKLW95m8eeV56Y4I9dSCYk9iujXy81GwoEU4XVgkPHm/3IAjjw
 X4z92g5hlJZn2bj+OMVmiGyldhhvEnGw54sPWh0hc8rEMgVUHC1IV6ZB1WDduskANWsW
 kthjmaR6Jxnuigc37JCJH6a71rcPKx419XJjevGtmld6tw0nz8wiC+Uvz0BuYyIz37qV
 sPLFDNoNT02dTQXgw0ADHHFHoXL2gbB/Uz43G5GXhwIpDYPiNxqfIK/M8EvgOX6/SN59
 KWhwJZJDFzUyQTZ7j65CT72lSPdvOdEZfQU/gJIY23MKv9SO4BecUiCa7sGUHp5piAG8
 aW7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVO+gzFBgJalwe0bjcmTJjXk4UrcmYHP9kfu4G5qWcDsxrs7SZyBIBuVhmSmYPAznJyicXyF3zFaCAi@nongnu.org
X-Gm-Message-State: AOJu0YwI7S9ViBlGfOtuDqkymMdB+vNEcBjY2Hqe+TbvvkkKy7yxKMcw
 7Zm7nX6ZB91oU5Ilnuz/ZJn3f+JD4x4NXrCapdguPs0RZehEpcshQttpQVXT2VpwRoo=
X-Gm-Gg: ASbGncsv8F9tqv2/VhR0tt5gMV8wh7ivE0CSYA1vZ9/d8hKE5VjIcQI7pMH+WjNm1O2
 TQwQ3S4AOZZYt49tLP/Yz7t9oRKzsaKOIQPehvvxbRRZqcDZqlYX4EoK58ypr6DJp8v6ZwMCC4F
 CDP0g6/2CkCyWdWu+edAtL4/7K9b6ArO9LIBxwfiLUggKZKpyoHZEGdFeh0y40qDWmx0z3bQu7f
 5WN3db712s3EJnaQAJgAfKVXF3zCgRLWGiq0OEP3qUWIzHMfTkDtVd0L6z9vUjb+lpaREq+38yo
 tMFShPC3kgS2PrjRlfYpajVUKunLcph1ix/0wEjs2rE93lxqq6uNK2hsfT3MaU/yxAUKrDn3tR+
 1ZMuHNBMdHK6BznImWvV4Ka3ciWXo5D6JsVqK8TbvF/hZ5nZMWJzgdhVekihh+8BX7g==
X-Google-Smtp-Source: AGHT+IHzQ3oLJbqTSsMpPUo6kC3QugKU5mh7FKOHW4U/GkUtNxh7gsuihOvDbOJw6sz0S0LgnFWb2Q==
X-Received: by 2002:a05:600c:4710:b0:456:8eb:a36a with SMTP id
 5b1f17b1804b1-45a165a7cfamr13840175e9.13.1755065305114; 
 Tue, 12 Aug 2025 23:08:25 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c485444sm47072038f8f.66.2025.08.12.23.08.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Aug 2025 23:08:24 -0700 (PDT)
Message-ID: <e5bc7985-ceda-4bbd-b1ca-130f9e6dc370@linaro.org>
Date: Wed, 13 Aug 2025 08:08:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 10/10] target/arm/hvf: Allow EL2/EL3 emulation on
 Silicon M1 / M2
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20250812172823.86329-1-philmd@linaro.org>
 <20250812173234.86970-1-philmd@linaro.org>
 <2f3cd701-6051-46e0-b7e2-e807b29afa28@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <2f3cd701-6051-46e0-b7e2-e807b29afa28@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 13/8/25 00:34, Richard Henderson wrote:
> On 8/13/25 03:32, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> Another API PoC.
>> ---
>>   target/arm/hvf/hvf.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
> 
> I imagine this waits until accel/split is present?

Clearly, but I wanted to get host_cpu_feature_supported() right
first, to not keep rebasing / reposting 183 patches...

>  If so,
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks!


