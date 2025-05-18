Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 806B3C3ABD8
	for <qemu-devel@archiver.kernel.org>; Sun, 18 May 2025 09:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGaHu-00042C-ET; Sun, 18 May 2025 05:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uGaHs-00041f-Fq
 for qemu-devel@nongnu.org; Sun, 18 May 2025 05:26:28 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uGaHq-0002f4-1q
 for qemu-devel@nongnu.org; Sun, 18 May 2025 05:26:27 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so26173485e9.1
 for <qemu-devel@nongnu.org>; Sun, 18 May 2025 02:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747560383; x=1748165183; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tye68HsEbrPuvv/GNCaIp4vNWzgV0y61jF9TskKCzhg=;
 b=J2TxckeYWF5zZhuE8iUQgaxFiyt8PX917jzOU6nyqghunoUcw/zH9b34MtxXa2r2QT
 LmmY2M/s2TGSIwBRFAQCxt9nSPVtLCo7lmNC5xoCfBjuv6ALjbvdyVulOiQQ/UJOmfze
 NvRs/iAlLrJ7qENg4gQQjzA31zfzLW9Aj5dtLjdgtRa3hb5B24DTFKBcbRrKul/WWQsA
 h8D9vyKHIMk5beXehmkgyMEFMz/CTYsnuSPzFxYQ6E2PftG5qgkvYPnI11J/HH971Usn
 1YJdq4q/6FAN/CE98OpbNocHYy10gYGNAw0t0TXd0qjVpLCTYPRcL9hH0HPS3xSAeRpX
 kiow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747560383; x=1748165183;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tye68HsEbrPuvv/GNCaIp4vNWzgV0y61jF9TskKCzhg=;
 b=PMl/OtDsUr+X+C9p4xIGTq88Br12KfYgeyAhq9lWFZO6Pd0u4tNKpYDJBMujimk82s
 NgLyXz2oCb3Cb3Gq5JGEP5qrEcpUWitdCk5L6uNJRvyEcej25Eqm78cMAu6f68tz4Ij1
 e6ciLv4h4XPYgnxlVvKqjNYTUoIQ7I+vbvjkzceyjsWOz04TTnUsvS48PvJzceqi2WnE
 mGPAJPnJSysw+PBSWUNMxgHePLcfoLGJxQvK6Q9QiK3QRMmS5GaaETuUrjhT5Mvj0lDX
 UV9I5O7EQ3Vy2IglL09vhfFfs76ugoFEa0Mych/6BuJ6kCLHQlVjv73bVtJDSr1M7jcv
 IkyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTIgj8l7xnTb38ippye7An3o0zmSPKwo+vro4ZQm6tPjIvG/V7zcq5EuK+pEgZHDenpTgBpSnFcBQU@nongnu.org
X-Gm-Message-State: AOJu0YzulqooAnFqSUmoEVNfzOR3jZ1zVjGVf9rbFfMYONcpaXpM2ztT
 Cb4aeF8DJDsm9RYIERjREEgFrGhtLq3mIumz5DqvimgNWBbrCz8fWaooWqQkuPIhJY4=
X-Gm-Gg: ASbGnctME+rwLv9UUbNU2WrlZTVlzOpNrzhlz6uQH/kcX2bkeEuTVTY2wg6Ku71Q93Y
 LPgTqt5QU7gktO8tiEHe+jxn+Q1KY/cSHNDPT9Dr0nYVmHAkI+SHl/7ko99KJAewNeEpdEHmzMK
 RloaHocPTi+dWX9L/5zAue92d3KfwmqzxwNAawgu1Q6Smu08g52CJL3//IX9W9EEfdUxYWGU2ka
 5OXHxSXOXfvBPgGuTnjcmZiBzNTIhVYuvmCS5C+gBQ8yrX0x3luY2F378PG1hRpsgakOERXMnYR
 zsC+ehNKXDOCWX6jiZye6LZAe2+WGYB2d9sX387Mpkq4s4RkLy5wqj14Yc/YXF0=
X-Google-Smtp-Source: AGHT+IFrD+DTG+DLL7LAIEFVYVoSa5Rgqme73HYIJq7iBNkVmTBRwa9aTLfERWguJWsofxaYYEtLXA==
X-Received: by 2002:a05:600c:4447:b0:43d:172:50b1 with SMTP id
 5b1f17b1804b1-442fd675932mr89412965e9.29.1747560383249; 
 Sun, 18 May 2025 02:26:23 -0700 (PDT)
Received: from [10.226.118.16] ([149.232.183.5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f39e84acsm175837185e9.25.2025.05.18.02.26.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 May 2025 02:26:22 -0700 (PDT)
Message-ID: <85f13ff0-80c5-4a62-8b33-ff35911866a5@linaro.org>
Date: Sun, 18 May 2025 10:26:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] tests/functional: Add PCI hotplug test for aarch64
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, thuth@redhat.com, berrange@redhat.com
Cc: eric.auger@redhat.com, alex.bennee@linaro.org, peter.maydell@linaro.org,
 qemu-arm@nongnu.org
References: <20250512144629.182340-1-gustavo.romero@linaro.org>
 <002caade-699e-4128-ac08-7797b83b3cc8@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <002caade-699e-4128-ac08-7797b83b3cc8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=gustavo.romero@linaro.org; helo=mail-wm1-x32f.google.com
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

Hi Phil,

On 5/16/25 15:47, Philippe Mathieu-Daudé wrote:
> On 12/5/25 16:45, Gustavo Romero wrote:
>> Add a functional test, aarch64_hotplug_pci, to exercise PCI hotplug and
>> hot-unplug on arm64.
>>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>> ---
>>   MAINTAINERS                                  |  5 ++
>>   tests/functional/meson.build                 |  1 +
>>   tests/functional/test_aarch64_hotplug_pci.py | 74 ++++++++++++++++++++
>>   3 files changed, 80 insertions(+)
>>   create mode 100755 tests/functional/test_aarch64_hotplug_pci.py
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 23174b4ca7..9ebb768214 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2065,6 +2065,11 @@ S: Supported
>>   F: include/hw/pci/pcie_doe.h
>>   F: hw/pci/pcie_doe.c
>> +ARM PCI Hotplug
>> +M: Gustavo Romero <gustavo.romero@linaro.org>
> 
> As mentioned in v2, since this might interest ARM contributors:
> 
>     L: qemu-arm@nongnu.org

I thought you're saying "include qemu-arm@nongnu.org" when sending the
patch, not "add the email into a L: section in the MAINTAINERS".

The test is now queued in Alex's branch. What's best: send a patch
now; or wait for it to land in the master branch and then send the patch?

Thanks.


Cheers,
Gustavo

