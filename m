Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03628E668AF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Dec 2025 10:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWuaE-0001Fm-Pi; Sat, 20 Dec 2025 05:53:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWuaD-0001FQ-5t
 for qemu-devel@nongnu.org; Sat, 20 Dec 2025 05:53:09 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWuaA-0004KY-UI
 for qemu-devel@nongnu.org; Sat, 20 Dec 2025 05:53:08 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4775ae77516so23275145e9.1
 for <qemu-devel@nongnu.org>; Sat, 20 Dec 2025 02:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766227985; x=1766832785; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TbziLnkevO5kz61ZYgd335iEG479QSAc+44XgVsPOrg=;
 b=ySIgCgJz8Vi1pmoOXGHLVDm5l5bCjstpbSiKVtyiNMsk89paE7E/uVBvBSva6dfw2I
 cKNWhSqZkeJG6iU213l8/I9mX8PIV7IXfqEP0DE2DYwQnFO3GFNboS2T6y7JraEAltxi
 q+7TzN8SpIc7d5tCd5I3lmUsdTYjR7mRRief0UpjMZ76mZSwla3v00mvtOu+AroQB8gf
 94ant2J0Cm/uUBYFiMdoYaAdb5uCWP/NfDOUhuv7BzZm0fctDw2ah9LzrzttOXgv7DZt
 jwYTa1obh0gB5AMjmUGFY/omTUBCEpX2Pizn5wXK5YB7xdS+UmSrClkYSyZF5JgDE0YS
 xwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766227985; x=1766832785;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TbziLnkevO5kz61ZYgd335iEG479QSAc+44XgVsPOrg=;
 b=J3wPRp2ZKf6zoVR+8hZncSOfjl5k6ZOk1WNwdPK2Aewttm8xMIY8C1u3JH4SW2E+Wq
 ZHkc8a+gh0U+nbCDQDKeyB2aQZzDJVIcsHSJsGv7D7coizjBeLvCviSepQWjw6SxPLkn
 l+YBjIRc6b1rjbo/4IbR49jbKIDxGcsGtlsSd/VIbxxj2yWIBzehfKuhXz+95LNTE8zH
 7XxS3ptplSGqJw1gRT+1usyNPyXvW38PFLKyi/1DCdQHXMv6OZwDzzext2L/i+WFjjyk
 2RTi/IiPFHoJd1MWzLZ+J2mXa1cZw6aFBkcbmtHFWbgmjX/eREfw7OOYCTMnt6LwCRk9
 cuKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBRHFwIFMy5wJhJ3zsXgg81gULg1AwlDuHb4sRILCjhM/Ga+KJXRQlHI+KCqsICQnpfrt+CxYLPNdt@nongnu.org
X-Gm-Message-State: AOJu0YxPkawMYrAN2MAT7sRgrPlq0ofSj9OAG0h46EZ/NwSOSrU6HJeR
 2ldaqYU2x1RifOPlpN5OqMmQ2OYOWyfpOs48MUlhOoim89HGUUiy0SBA95Im4F7VHC0=
X-Gm-Gg: AY/fxX6lUit7tPqSJ6L/R6b6+01tPQgKDUUgUjbwl/GCJXyBHd1cDeBy/EjBC9jNqNr
 TMXQQq9FcN8d+VfCjCF32lGKrbNWCT39a42Vo5x9QJyQTEgH9j7ji7vCctb9C9DScHO4AhmNLYi
 gXM+NMW1wMM4eCZkrUH6F0Ccn1M4dB1yqHNG90eLJQ5WLcdyax2gAYn0Lq2T+gXN1bML2Qo3I5c
 2N0H6sFQnnNynPDfMN0FdnpCrfq3xF4jLbtqOCsMHFrcyB8QyYLqkozFKplhaobm4mmWC+jnXUF
 NEB0U9tH9O+il55+kMuzO+D/6yGdUpub376rXHFCHMWClfg8Y3ZC+iGpX/9fLQuj+/jwbHNad0+
 dPzk9zFX1Ni1wfjTixDloVBr5q4vFGC8VnkRExufclgXjZc9woT7jrVI/89Wym/v8PPOWTs4IzR
 YmfX60jUoC4IX3tBoUmPzBm9pQSHZA5+HglPNOsY4ISlhqLAKdDwCJ2A==
X-Google-Smtp-Source: AGHT+IE8Kj7JTjv3PzV1bphKyo8ehzfpgK1TqNiZf7t9D80yzaShbTw9uqDngiH+VPg3EtSP+swJmw==
X-Received: by 2002:a05:600c:4ed2:b0:477:af07:dd21 with SMTP id
 5b1f17b1804b1-47d195b3c08mr55955085e9.25.1766227984878; 
 Sat, 20 Dec 2025 02:53:04 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be2723b2bsm136792395e9.3.2025.12.20.02.53.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Dec 2025 02:53:03 -0800 (PST)
Message-ID: <c05d1639-7ee0-4ddd-a1a7-42d6c7c8aca0@linaro.org>
Date: Sat, 20 Dec 2025 11:53:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: Optimize summary_info about directories
To: Bin Guo <guobin@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com
References: <20251219230456.37178-1-guobin@linux.alibaba.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251219230456.37178-1-guobin@linux.alibaba.com>
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

On 20/12/25 00:04, Bin Guo wrote:
> Clear summary_info first, otherwise there will be redundant output
> about build environment.
> 
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>   meson.build | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


