Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3586CCF34B2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 16:05:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swOKk-0000Xn-77; Thu, 03 Oct 2024 12:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swOKX-0000Dr-9f
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 12:05:29 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swOKT-0007Lq-Uh
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 12:05:28 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42cae4eb026so11409615e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 09:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727971524; x=1728576324; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7kpPjMlJVqShFPgYpPzg3EJ1Cv/u2eVST13+yvT/bSg=;
 b=QEo1vssuHx7xvQCPAWYoqvgOIUORpSRuH2kkWnAcnGdV+b8vYB+vNo6xX+PxFRX8Z1
 O42LhPSnAjP15oflj482fU11hg/CnYnLXfQa5x0mhY9PKpzTqyouApOoO8BS//F7ySBV
 7NAlzxV69SRkM5e3Dv8Vs0AVeOx/xgMWnSWxF40vMeimmzkecHUrXtuo9xdEN3Ve09cW
 K/TPsFfhFMtsHB+OpFAHn4T/q5di7vlRoHLS4iUGHUxBTYf3j4fCyXgJMAes1REJyjYV
 YPzn74ndwYtWW8NyXz7ow4xGFEdXmTfZSDZg8dskx3msbgwZT4UvE04F3q2fIps6Cedm
 dEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727971524; x=1728576324;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7kpPjMlJVqShFPgYpPzg3EJ1Cv/u2eVST13+yvT/bSg=;
 b=wPCASJnb7JIB7gYP2elyqroNZbBFU1FvJ+qX8mc3Tjxk4w4BZ/SyQbWwPETxf8peB/
 4dwkaffZEyAABXXb5kXmsQy7jIGr+PxqPOCZTUoj0jxlF+sGgrBl3DNAlGY5ytcD6WT9
 yizkp4Bd8xSE2sL7j+auTJ6Mgkp2eWWoDXaLWyCwLAuZzSwwh7B5m/5o97M4JdjeZ6DZ
 +LEsD7F/MNGlzbT+u/BmftPz7w9n2BrpyJZwgq6Lg82BhD30iQaTR9PmMlfCG2b2YKzx
 DvKofaR+fq8yDegBMkcx+TW9hGRaX3AcAmv3DBLjSNre6LMrJpfmkAclVkQNT6AhTb4K
 NObw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfd2hOKxVx6z/KucQ7Y0jRt/YzzT58HkliYtT2EGYIaaPr+TymoTzbF2g9YSzLro6pPoarkRv7i9NF@nongnu.org
X-Gm-Message-State: AOJu0YyoV5vhabdUn+N6cfAc6B3VGcSGW6hWdKuuj3UDR4Xmkw3Siv1w
 NkzEZ2kyTO/lWZgquS4Tg8TTYYEXpzHXAXXVABzgeQGQnO4xVj40iC9Ct8g5LnY=
X-Google-Smtp-Source: AGHT+IHMCDjuShiMG0GfAe4HVg9B3Uoa4pWFEkLwlcA5DQiJq/RGmv73kn50JCbsJos4esTEKPo+iQ==
X-Received: by 2002:a05:600c:1914:b0:42c:bbd5:af60 with SMTP id
 5b1f17b1804b1-42f777ee77amr50962185e9.24.1727971524111; 
 Thu, 03 Oct 2024 09:05:24 -0700 (PDT)
Received: from [192.168.13.175] (49.red-88-29-183.dynamicip.rima-tde.net.
 [88.29.183.49]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f79ed4b3esm48326875e9.27.2024.10.03.09.05.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 09:05:22 -0700 (PDT)
Message-ID: <32d6b780-948a-4703-a399-67b3e64e05cd@linaro.org>
Date: Thu, 3 Oct 2024 18:05:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add myself as maintainer of e500 machines
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 QEMU Trivial <qemu-trivial@nongnu.org>
References: <20240926075948.2343-1-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240926075948.2343-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 26/9/24 09:59, Bernhard Beschow wrote:
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   MAINTAINERS | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


