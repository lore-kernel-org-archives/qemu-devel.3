Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9A4C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 08:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYhyC-0002vO-9e; Fri, 17 Jan 2025 03:44:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYhyB-0002tY-2V
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 03:44:47 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYhy9-0005WJ-CH
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 03:44:46 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso11472105e9.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 00:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737103484; x=1737708284; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YzTa+vdDPW3UL04bOLKxpARyyypdyPVQpZLJ79xLSas=;
 b=BqBjF2TLP/P1+bCffqXTGkI+TjR2MNec+uJSbr0caO4OjlzYzhMvHWMAXL3PvX7j0B
 tOsHe6m1vYj2Acx1RMTIX5aLtSyH8L9rW6TUf06zKSeh2Ver2wdgjw/3VPj5txpPKCys
 n5DanieEARaurgj+GcmOOImyvlcBSveWkmef38c8JohMg+3LRDxAgv9zV23XFSeHCXGu
 /1QjA4uwlcs3C+nJ2qMw/pKKPSlj/cnknFMl9002PlGKmxHeNzJdhEANQN2rQ2/4ULQ1
 JNwCpovwJ97rYIvXMO857jlL8WnW0K5wTjHHgvIFgFwEdduVP7vRC8RO2H0CcQ5JK91V
 k7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737103484; x=1737708284;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YzTa+vdDPW3UL04bOLKxpARyyypdyPVQpZLJ79xLSas=;
 b=D5t9bmMU4lHK8xzkg7l5PoB4wPK7kfZYoSpX3DLxSPe3+VhD1ZQLngI6E0X1rf3bga
 7McYcV3aW5HMClHGRU3wi8Gku6+kce6ZqoNhFH5V+UlGIpWVXazv4Hlc8Mhv9xrDElLB
 dXmfKwNF1yOJjVTU1kldZwx9ZOWWJrE57UvKEcgo8PMRNXdNUlGfjtQNdS2Sh9W1JFWz
 AE03evo+5lyQoUg3AytxXq30QsXNp/GOv6mm++IZQIfgG7sJxKyooMJjrGfJB21Hi1xA
 cr2c074QjcR5b/G36W9mf4xdGYh5JcwDQUB1f3xjaigwZtHoNco0cqN3HQSCJOL/Qev7
 OUuw==
X-Gm-Message-State: AOJu0YxuEsxsI3rSvUQ0Q6Hhel2uRn/5i5RztyRbUCRGFwJOBOHMbT50
 jyNoQuxnlgK+YtySNiiC+IUKGdfJJJzu+M7C85P9rNmFvbLHLgt+qkNYhEcBtGc=
X-Gm-Gg: ASbGncvC4kKdHJTtqASF8nX9pLT+IPJjYUuXmV3U4V92LvXzgwynot8F6WB1KG14ji/
 Oey0cLFoHJ4EipcNJXkM9/08iO4se+w+Ow61VS36fxocmB6kodc1hAvih3ILmH7tadpkm+DD6C+
 b82NSeQqVq+3LmNf0mgGr0yq7y+nvaXEaS2ZW6vBlZT/6oZsoI/0wVoa6KdTZXzydykaoyTU0+I
 abz1EFYJD5rXeDE0IMLnXg9WK6/XNJOMdKfGPYIAa6p+8O80oPvN3ZPA6dXXP01RAaJG11Jkabh
 1pY+Vfi+3J1SlWopGz1pvuiK
X-Google-Smtp-Source: AGHT+IF/XPTLLw3zQygmZLQR4E3xYTMD8mTAwWTEj0S8uy4LYvaFAb4b8f69PWLy66aQS8q0jhZSNg==
X-Received: by 2002:a05:6000:1a8c:b0:386:5b2:a9d9 with SMTP id
 ffacd0b85a97d-38bf59f263bmr1341320f8f.53.1737103483603; 
 Fri, 17 Jan 2025 00:44:43 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf322aab8sm1956563f8f.57.2025.01.17.00.44.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2025 00:44:43 -0800 (PST)
Message-ID: <fd1e14db-e8ed-406e-9551-03d03f12c3a5@linaro.org>
Date: Fri, 17 Jan 2025 09:44:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v2 00/13] hw/arm: Remove virt-2.6 up to virt-2.12
 machines
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Andrew Jones <ajones@ventanamicro.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, qemu-arm@nongnu.org
References: <20250116145944.38028-1-philmd@linaro.org>
 <823a0892-e9d9-4d26-b862-83ffd60c2ad1@linaro.org>
 <d9f97b63-dbfc-4322-b7a1-8759d6be5cd7@redhat.com>
 <Z4oP9YEBc-opiL4K@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z4oP9YEBc-opiL4K@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 17/1/25 09:09, Daniel P. Berrangé wrote:
> On Fri, Jan 17, 2025 at 07:47:15AM +0100, Thomas Huth wrote:
>> On 16/01/2025 22.13, Philippe Mathieu-Daudé wrote:
>>> Hi Peter,
>>>
>>> On 16/1/25 15:59, Philippe Mathieu-Daudé wrote:
>>>> The versioned 'virt' machines up to 2.12 been marked as deprecated
>>>> two releases ago, and are older than 6 years, so according to our
>>>> support policy we can remove them. Remove associated dead code.


>>> Please ignore this (reviewed) series for now. I'll rebase it and
>>> repost after the 10.0 release.
>>
>> Why? IMHO it should be ok to include them now already. While Daniel's macro
>> only starts the automatic disablement for 10.1, it should be ok to remove
>> them now already according to our normal deprecation policy: The machines
>> have been marked as deprecated in the 9.1 release already (via commit
>> https://gitlab.com/qemu-project/qemu/-/commit/ce80c4fa6ff ), and thus they
>> have been deprecated since two releases already. So it should be fine to
>> remove them now, shouldn't it?
> 
> No, because as of 9.1.0 we documented that machine types are under the
> new policy, and these were only deprecated in 9.1.0, hence the new policy
> applies to them.

Thomas, see Daniel's larger explanation:
https://lore.kernel.org/qemu-devel/Z4jRYiUGAzz1_NRV@redhat.com/

