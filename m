Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33046ECE581
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 23:38:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snnxH-00081u-Ar; Mon, 09 Sep 2024 19:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snnxG-00081P-13
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 19:37:58 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snnxE-0007O7-Ev
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 19:37:57 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7cd967d8234so3167161a12.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 16:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725925074; x=1726529874; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DW6LJyx2dNgZ272uxAiT3haCOmUNz68fwaZEhVW14rw=;
 b=zH9LSuw2pcnC9NZbaETXM1TSOTlLbAWREuZF73TLtcFCBi7CFzjOdGgBZ1k9PqvgDc
 woZnNaAd0oPBNhdJ2hgsQAUJxHtW1Hx38aCM3m0Iaz6n2N0BwcDY05ai41j1CgEpt2wC
 kQTL1M/lSiMYQJXSPlq3+XFTwYxPI3GdfTY660/iJNx34Jy6dCc2WuWlsqIrat6o3S7Q
 qg15CyxbLXH3m+JRsShPY2mp9FLm0il6odKG5zDnMaoQ+jzn/OY7fKAyfbosi+iB4vlP
 DVtnZqIHsl1l+EP/GCwUFsv7vw4r68HZCBYixlZfOA7v6meb+DPnOvDp9iYpAh/ce8ZN
 eOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725925074; x=1726529874;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DW6LJyx2dNgZ272uxAiT3haCOmUNz68fwaZEhVW14rw=;
 b=FPp64YVv3E12Yo7qJ3CTibvg7Xz58jJKDmwldEjKYSvDNVINdbVOkjPW+3jkFDcsJy
 U6rL4KJnxvHNcytBts/B852/7TGQEcc9VHvNLoUy42BEcx0Qv0eJY9Ke4wJB7vfrTHPw
 2IGlxH472mG0IRgdyb9uhib0T6En6zbabYyvHfw6Mf/CD5TfvSHryennpHbnWgfI1ng2
 KSVHVVl+dh50l8x199x40845z1loQxrYAmUXURY9y/YGIQnwhDGSk2eGToYrHCsDhqYV
 2af/LmbM0DnjKnEuhUYBIBPeJX1567k1gZtEnfsiEK6/xJOZpPSCQlIqld4FfErXWzIo
 1ZEQ==
X-Gm-Message-State: AOJu0YxFB2B8PV6P4BGjYxQp+M3U/mD3yfddJcYwsnvVeokvIM/TShpm
 QhnskSZ40PNjuDF/E9tFOnhUPrR04IrhzRQYrBKGhvceUBojMzYYxVTmmi66x81fqnt3FBMCklZ
 +
X-Google-Smtp-Source: AGHT+IG3cWPIuVu0JSQABh2JXmkvC78xI0/RxaaoNAfH4314wIkiMJmw3CeHKU5z+JUGRyLXwT+XCA==
X-Received: by 2002:a05:6a20:a61c:b0:1cf:2438:c9de with SMTP id
 adf61e73a8af0-1cf2438cb04mr8021853637.21.1725925074195; 
 Mon, 09 Sep 2024 16:37:54 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-719090b0286sm265120b3a.146.2024.09.09.16.37.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 16:37:53 -0700 (PDT)
Message-ID: <50aea887-5d7b-4bc7-835a-0e332288901d@linaro.org>
Date: Mon, 9 Sep 2024 16:37:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] tcg: Improve support for cmpsel_vec
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: zhiwei_liu@linux.alibaba.com, tangtiancheng.ttc@alibaba-inc.com,
 liwei1518@gmail.com, bmeng.cn@gmail.com
References: <20240908022632.459477-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20240908022632.459477-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

On 9/7/24 19:26, Richard Henderson wrote:
> In order for that to happen, the tcg/i386 backend must be changed
> so that it does not rely upon choices that it made during early
> expansion, before optimization changes things.

FYI, tcg/ppc and tcg/s390x need similar changes.
But that doesn't affect review of the other patches.


r~

