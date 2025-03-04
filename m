Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDDCC282D0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpb9e-0000Rw-Kg; Tue, 04 Mar 2025 17:54:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tpb9d-0000Rj-HR
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:54:25 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tpb9Y-0005wf-Be
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:54:22 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-223959039f4so67734395ad.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 14:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741128859; x=1741733659; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H7CLqvg9Ykbo/wvvVdw0zhQOk+Gbqd50QlVXaAiqLpM=;
 b=ISFlkJZc9XbIPTOzNjG61HlJsVDA99zmngmfYOSNRg609PzL9hZpzTram+bVV9VeR3
 /SGcpYfeJ7y/Mq3yOrhmX0V9oAkvOuQ9gmznFF2UhL2arAlXDbvhhM+NCYbcxS7Gi9OQ
 E/NODIbUUW9nzAfJ2okC3i4kc386DyAvL3UEaG7gFsTTWGyUCMVD18PrWmXg9H1BT1c/
 JctlDIPS9AKOvIwbt0ADBFLmJ8oAPLuXPhmX+qJPzOqakVhF6MZnUuCxDZnq+tCXqtom
 WXRpSgAMg+5Q35xr+z1z+22Ul4VUJHlCDLjx3WLLH3Pu7bmB2G5siAUQ++Tbx0fl3d3G
 bs9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741128859; x=1741733659;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H7CLqvg9Ykbo/wvvVdw0zhQOk+Gbqd50QlVXaAiqLpM=;
 b=jNiPVwIdEbFLRe6YbBONgFm2apfwhD/5t+Tv34O2crxOs59vSLhlQoQqTv099+5joC
 +EIWWTCyAxuApaDKcm6WhuzaMiBMm3pKeXGXn32VKD3GBeiPZJcKUK+lUcIbBivjnLew
 5vuO1QvB3uD5/24cOThQXQ1PG01LgYh5yg13e7Wmi3e3kq8FOjEl6ponXYnNe3MbG3Gp
 bbKzlIkxnWBVXFFcEc1hFqEVIVFvG5SG08HycxTn5dLLnu0Z08dG0y36fVDSOLma4qVi
 mFxtg8ntaoHWsSm5N7D9Nl6u/eldS1+s+lPEX8U80fcbiunsnwLqoeZMOZ4nc2qdHHvs
 sr9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxZk2alreRt+1JA/er4HnG0zIwhEp9Y3BfXiyr4y3KH0TkNLNjkMcm6dzAHzcQi0UkCfJqbJHSlXMJ@nongnu.org
X-Gm-Message-State: AOJu0Yz4WeSFVVbIpDJrY3jUq+r3B9XcbKHJAcNu3ltkgQG9V1PrudDF
 hdq34Mj1O9LXEwTAc0bQ13JgdUeCJR441cTFoHzz4mOTrr/MiuC9ihhzvqDssKw=
X-Gm-Gg: ASbGncsW+5+mutUbzMAgQUM0o4lHBQvignI8ZBomgCwATKcCXEX6X0KgJnGMKc8sMBX
 HM48OT561ZSpMSDySt7bpV3y6auKsLg0puZwFqje0zI6XKid4JpJEwkTgzqXBxVvvKVqLGUritd
 N/HWGOFMDV3/TiIs7xX8XcdJ/BnATO+bOnsK0T/YUDTQ87h6S0ygRQz0H6szxsEWqJk/CjGI52E
 NUuE4hHwkNOQkxW2oz/02sohEo0gvxM1lRARZiB8BTTrjwRUf2Co83WqbXZzHfwPJB7BUbw5Kc4
 R57YNYIHW/snxf4mb33SCBTP1ztHiQEKc0gwjy4VUhQSYFV+KueuiuW0OqUBM2pNYnlAvhDrrnw
 fHm+et/ta
X-Google-Smtp-Source: AGHT+IGAK4+BQYCDROmM111HeareqR1lKzlqoF/H2Etp/6AdhlAvn3mZmOHeRl3AJFg1JIrwBXVWTw==
X-Received: by 2002:a17:903:2283:b0:215:acb3:3786 with SMTP id
 d9443c01a7336-223f1c8011fmr12972695ad.19.1741128858715; 
 Tue, 04 Mar 2025 14:54:18 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea679df1asm11622033a91.22.2025.03.04.14.54.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 14:54:18 -0800 (PST)
Message-ID: <f42e79f7-298c-47d5-8b98-66c8f8597b34@linaro.org>
Date: Tue, 4 Mar 2025 14:54:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 30/32] plugins/core: make a single build unit
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20250304222439.2035603-1-alex.bennee@linaro.org>
 <20250304222439.2035603-31-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250304222439.2035603-31-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 3/4/25 14:24, Alex Bennée wrote:
> Trim through the includes and remove everything not needed for the
> core. Only include tcg-op-common.h to remove the need to
> TARGET_LONG_BITS and move the build unit into the common set.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   plugins/core.c      | 10 +---------
>   plugins/meson.build |  5 +----
>   2 files changed, 2 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

