Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EEFC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 22:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u85KB-0000eH-5k; Thu, 24 Apr 2025 18:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u85K5-0000dr-EO
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:45:39 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u85K3-0003fS-Rf
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:45:37 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cf628cb14so20701175e9.1
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 15:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745534734; x=1746139534; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a23LylhXPo5J2+R6wCgy8Oo8RQAHxtHJHLsuyq6Plyo=;
 b=ye6gg5YH9PDLTXfZifviZyIhusfA1vw+Qy5kxcu4QemxfJCiSqdKxqA2oXUMHVpnRW
 FsKjYJGENIu9jvPTvtbVwifZr+R8aBsf7xHg4VQmaFzsLcNuXAZLjvQMFtB4mJH8Fqz5
 v9dQIKlLcXDG/d3LQk6ggpSC8zDNyaKIfu2xO5xJcZpNGUTNOgzk3gZw4tIR52fe/eI6
 ZYN/YJvCI+lASIjx4dHHJoWGuZVBTU1OmpJJ90zVI+kJPkEilZms2CqUEr2xMuownBDQ
 1eRhzhVBZTGmIe55h/inylQx0Vjs4xcv2grI9EqqMFtGt4mGMyOQu3p1WWOT00P/Sz2w
 mORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745534734; x=1746139534;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a23LylhXPo5J2+R6wCgy8Oo8RQAHxtHJHLsuyq6Plyo=;
 b=s70kYa5JagyrSPhqtp7LQFUa73vJ3dmaWd0Et/16dTxHvv9JURl1Q/IajJdbWQKd4x
 y+gzkxXSBR0O9X8iZqzw6bNEI3zR2+26e/nx5qo3o+PYDWctfrxs2tioIve1eDQkaWhT
 v+hD4nN3ofC5T9P5oaQjxOBgol8qZ9Gq7Cx9tLntrVaejXJfRQTYgV+6xVF5IBb6k0UZ
 IV3BBrALmkduC+9gmK12T5jDdkYpzXK3EAYZLK1wrNj7VmK+Txzw7DnSPDsjYjWQcwuv
 ra7TiBTilL85+Wr6kQkWfKIFx4j5DKms+i4Ux4RE2OYHzdshSgGms0P0oV9L7IUQkKcH
 cIrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiaOJ46ABPV0AcXr5zyjA8LBymk9KN0Cysikifldk9hsWxgI4zuiOlUJ/GOUi9iX0VJIX/Ar4T4S6b@nongnu.org
X-Gm-Message-State: AOJu0YyHosbPnFnfrNw6nHsw6uiDOZKrgiFBwHweKYaWGTqeA7n04nfA
 DrRbKXKjTZSOt3UzxcBAu9KI8db/aAqh/9GMy4nhJgy9zMCWEpgmGT1CtwEgkn4cap0jrhcNAvW
 n
X-Gm-Gg: ASbGncsBbqwSCDlsW9L4hW3xkbFmDo6buBoyfUTnAOQsv6IvKwTasi88xTcEtUuz9wv
 nXk2/IX4Y889nsrwtH4zgIIsQ71ruxFx3KHZwhmNPvBI/Hvuab7BVaRju4bEsf6sk+7ZMAlXXSO
 w7GTt9Wipal92lC2H4TDfPr9WEaDgicEpalLgHUp26DasVNmJzgSW2jwPQSeraM8kcdvsNZ1YpP
 +trYvOFipUd41x2UoHkfiMDzA6aMWop722p/nyyFF0EWTGLH1XTT8MDFp03kwbwQQH9VaqyUflx
 2HGjabusanv1QrMFacQsKje4YOAheeib06ZGm8ut/tVmxf1JgtcipabbjRhVHMpDJSK2dRq/lq+
 5t6dEMRiss3ultQkhFD0=
X-Google-Smtp-Source: AGHT+IHZsg7YqvaEtDrIr0YmcAORkNFOqhtqaQbnmEC4gXzA0JUU6IGiULorbSTcsGcy/uCHHJYO9g==
X-Received: by 2002:a05:6000:1868:b0:39f:cd2:1fa1 with SMTP id
 ffacd0b85a97d-3a074cdb94bmr8843f8f.3.1745534733799; 
 Thu, 24 Apr 2025 15:45:33 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca4e50sm575002f8f.30.2025.04.24.15.45.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 15:45:33 -0700 (PDT)
Message-ID: <ef72c90a-530e-4a29-b7cf-4bb06886f043@linaro.org>
Date: Fri, 25 Apr 2025 00:45:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 08/21] hw/arm: Add DEFINE_MACHINE_[ARM_]AARCH64()
 macros
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Anton Johansson <anjo@rev.ng>
References: <20250424222112.36194-1-philmd@linaro.org>
 <20250424222112.36194-9-philmd@linaro.org>
 <b9d5b3fa-44bd-4ecd-ab71-9085ffee3717@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <b9d5b3fa-44bd-4ecd-ab71-9085ffee3717@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 25/4/25 00:35, Pierrick Bouvier wrote:
> On 4/24/25 15:20, Philippe Mathieu-Daudé wrote:
>> A machine defined with the DEFINE_MACHINE_ARM_AARCH64() macro
>> will be available on qemu-system-arm and qemu-system-aarch64
>> binaries.
>>
>> One defined with DEFINE_MACHINE_AARCH64() will only be available
>> in the qemu-system-aarch64 binary.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/arm/machines-qom.h | 13 +++++++++++++
>>   target/arm/machine.c          | 12 ++++++++++++
>>   2 files changed, 25 insertions(+)
>>
> 
> I won't block this change as we need to move on, but I still consider we 
> do a bad compromise between code readability/grepability, to avoid a 
> code size increase of +0.0005%.

I know, I'm just trying to keep moving while keeping everybody happy
(there was no further update on your v4 comments).

> Anyway, we can always change that later when adding a second architecture.

I expect this to not change for (current) homogeneous machines.
Heterogeneous machines won't use these fixed arrays; there I
expect compound literals to be more useful.

> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Thanks!

