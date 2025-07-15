Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2719C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublh4-0007yM-0B; Tue, 15 Jul 2025 15:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublIR-00070l-Bj
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:26:40 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublIP-0007T3-Ps
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:26:35 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-45600581226so38127215e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 12:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752607590; x=1753212390; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/MsqpTOtu6WQLcNEE41UXu5Adkjh+bLwBmP6Of7vKbs=;
 b=UFWn34gw0ZmL9iy/Fozqc10y1LwmlPwJ5nMeFmqEz7uCKoe3pVgnOSHgFZ7poEE5q5
 YCo4xsrr0AlXHgOfP3noSr09Dp/WkMrywKOZEgROf2CWD6ZOqtdUOylRKGCvduWtula3
 HJYziAFNFb1F1HN7BZRHzSWKN9S4xRSRf7bDWkCc4omHNyG3wVpSdUcBnl8xja+mkgXY
 SXa4b6kT1D16fT3M3HU+8E7joAqkaw6oJ39iZeP90nTJEktFYFMk7JtbXHJXlEM8GXo+
 EAXXREaryu6+SWCMcvaGav+yAdaJ6Q6LGsJ16bJ6hiLmjRitPSNNQ0R7bDLv4NkhWCpT
 qSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752607590; x=1753212390;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/MsqpTOtu6WQLcNEE41UXu5Adkjh+bLwBmP6Of7vKbs=;
 b=LtywJPpWYTUrPSmPGh9tNUULOZg24N4NYHqgQQ5ajofv7h6FSpXJfofrW5WJ3IxwNS
 WOUaP6j7b4SEN9YSudby9jkZQid8IKMXXGamnFL7P2tzZ+nUgtgF2lEXreoVNygLB+re
 yfKsygUzXBU2Zl84Gkdy8ul8yCUz2K9iO9CfBP0t7kF/4EmSqI5HP9JDFYlIfACv2EV2
 ZGMZkDVfOV+JIRV5tS90u5rrQGot/k+nreMQXt58epu1WD4HuQKsZUx6qXshHWgK/IN9
 oaaiI5COf7BslVqv75GY5cRS+p1J4uN7VUU1340NISJXX5qeOtLKUa+lvkpYGt01vI+j
 Mr/A==
X-Gm-Message-State: AOJu0Yx1BN7nbm4H8b6BaxkXFYe0USIXkN/ZUy2jwgFYf0wD72tNcYUx
 VClOvn0yaYJpeLoKOhswdFIghdyV3xz59hltvZKPBLCiK+D/PDkdzJZCwppFLNTNsw0yLlyQLyE
 yl7rc
X-Gm-Gg: ASbGncsITey17srfAWVGV5mv0Uxs39ftzI10r0Tc47Ej2eOUGSR5u/7L+ESsyblCkpD
 OSheKV0jBIQhyNJgQIkp4963xsOWIgt/7m4OAhDhEw+7da3S1gSixg6Soz1M0M7esOAHNPDtTJ5
 qv2cW1Ef8Z3lKeUaMokZJwJWpJA90gsXjdcYBBZifbgUyXWLGphidrb+cJDoObyzUERzGqqcZKf
 OWKaXKOy0RzIoCEmGOc9D8YiEWUs1G6No+1ciM1SA6OUrPYj0fNYO3YOs/7AC4bMoLMPDXamUMj
 WZA41BHSM4W5mC4DQvZxf4pjDn0w7FTH2IRJbBY9adLsSRmsqB2sT2QzATsK8jgptUEkAui9UxD
 C9GfVmHykYMAmqDCZ7C06kU3BrLxmEiLRNmj4Z9jsz7L4OyExsBGbLyHmBMwgz1Z9obtjOzk=
X-Google-Smtp-Source: AGHT+IEWeI6awE6R84XlKZgHhqWg3E4vAjcD0I460V1pGEqmL5abXovNa5Q0C+M/Lrg6w8PHPi6sfA==
X-Received: by 2002:a05:600c:3491:b0:439:9b2a:1b2f with SMTP id
 5b1f17b1804b1-4562e039d93mr1393845e9.3.1752607590023; 
 Tue, 15 Jul 2025 12:26:30 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4560eb98a40sm99725735e9.27.2025.07.15.12.26.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 12:26:29 -0700 (PDT)
Message-ID: <61a8bd94-c99c-4d8d-9781-3786e3cdd071@linaro.org>
Date: Tue, 15 Jul 2025 21:26:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v7 0/2] hw/core/machine: Display CPU model name
 in 'info cpus' command
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eric Blake
 <eblake@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20250715090624.52377-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250715090624.52377-1-philmd@linaro.org>
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

On 15/7/25 11:06, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (2):
>    qapi/machine: Add @qom-type field to CpuInfoFast structure
>    hw/core/machine: Display CPU model name in 'info cpus' command

Queued, thanks.

