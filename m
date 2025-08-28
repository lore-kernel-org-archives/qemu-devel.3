Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C105ECA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usOgx-0004rv-62; Sat, 30 Aug 2025 12:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1urkai-0003ev-8w
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 17:55:32 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1urkaf-0008Of-6j
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 17:55:32 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45b627ea5f3so6103525e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 14:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756418125; x=1757022925; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=himmVZ1AMNLozirnOY2wu+QpUFfS93WwBoK6WfM4uOE=;
 b=nEnyKHPBi0A8RRHwlkpRmJIk4KwJlPd3lTfjOOiGki04prHjav/2PZrrxhj2UfXNns
 NqJqrOBFNEvjYSloiv4yoyI4izAhrj0hK4kGFyQMhTS0EaQS5tUutemtT8/gkosLipTV
 IUx4YeMiYxsIvNmwMVXy7duBP+eV3sJvvcZZUtwggW2McSrmRZkUYgE0QyNAw9YjLtZc
 iKgwgKdMFms33VOBBKvBUSBJKIxsm1322lQiyMbTIJfltXGGclGoKuuosaM5zuU8s/Ss
 DTls+T3enfS24hgSZuI1cuMEpuiFkoa7AcaSkbnJ1d5pownmQ+AUHCWNCgiJ2HVtsFXI
 j0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756418125; x=1757022925;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=himmVZ1AMNLozirnOY2wu+QpUFfS93WwBoK6WfM4uOE=;
 b=GM+tmzcIalIioeXZwwPAEmXn1WoedIBQLqf0gFbzdZPun7+qr1CvscO4/1BY2hOuEc
 AANHDY+qgShyI8ISmalYuD1wBzl3tyrI0cLPNpoyJadk8OKrUUdfcpdMU6NswdUR1f69
 8Wvd5Boo+GugN9lbRFWW4thQOh5YNY8ddNvOW+ErBtUG1CFBG42S6Fcm/tyczjW+F+6b
 CA1QFQaC5hsQ7iwjgSHwvlgeQlyYeSVAWNl/FOo3WXd9veKvbwHzaJA40XnU87buH1d2
 ZMm8Hur6kDjOtL5p1IeIV6c4z9gPsgZslXJf+rUzkYBAIJyRbNza48fHzjFHF22tBbQd
 6SSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWU3ayTm0sORtFlGgNZ6Hv5tB718bOML8Ymw+mRYlbi8nYzuJVVVBJAMrspRAqhgMZqAJOI1lXrUKgd@nongnu.org
X-Gm-Message-State: AOJu0Yz6HHTVC1OeEvJzgNwpngWagJErUBPW/t6WmpFXw1bqv4cFkuZp
 F4BaGvw6MFk9llYPP1N+zIh4w/fFIZV/JFBQ1oKUH+hoIA+5qV0vB0HodCewrrZKSir0SI3Ok0H
 jOHJp
X-Gm-Gg: ASbGncvRD/Fz+7jlGzXQ9ewxdbCKSaU/mukY0yrF8YPQRht6Ycdj0zHMJF6nbUqoa+Q
 meb1BMbk+pvRJfY4KYaMGPud/HEl0ZNS8kT70FaJv3fnAB/RbbX9is2lkIIcF0MlHWZ1HhvT8CF
 FbglSrMMkGKCXcMgPu3U6ifM+tOy2Obi3cI4hZI2DcpeOBGm+zXeYzfA0FfwlBk4PKsqLNqTv2e
 VI/+abBK4VUubOBRLnFVxNWfsCwWRuxsAqZV8alufegSY6GVMlVL3RrROWMxHpOO5+4+0gl4XMm
 BeB+CAKZbR6/1HxrgWrUYEOzgImnJpFYh8tD5QTS1pnYM0mvJoBrYvFc0Vkw1PvgZIFr0pJbqj9
 R39b3/VpqPOaC5GSAN04Legwfnh9PGBEiUGVOULGLU6Jap+1N56PB+pCKWFoqCsPeLw==
X-Google-Smtp-Source: AGHT+IGW0szNFr30KnSNi6TZYT+rMvSezvccioz68Y8ix2WHEA9yOFXcIRAKL8qRdXEMo2tP1bhWuA==
X-Received: by 2002:a05:600c:3505:b0:456:1dd2:4e3a with SMTP id
 5b1f17b1804b1-45b6bbd3411mr72548875e9.3.1756418124639; 
 Thu, 28 Aug 2025 14:55:24 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf270fcffdsm806193f8f.2.2025.08.28.14.55.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Aug 2025 14:55:24 -0700 (PDT)
Message-ID: <973ed433-c365-467f-90ae-1d9348d59730@linaro.org>
Date: Thu, 28 Aug 2025 23:55:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/core: Use qemu_log_trylock/unlock in
 cpu_common_reset_exit
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250827053822.4094239-1-richard.henderson@linaro.org>
 <20250827053822.4094239-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250827053822.4094239-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 27/8/25 07:38, Richard Henderson wrote:
> Ensure that the "CPU Reset" message won't be separated
> from the cpu_dump_state output.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/core/cpu-common.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


