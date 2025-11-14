Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFDEFCE8D5B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 16:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJx85-0004mr-9M; Fri, 14 Nov 2025 11:58:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vJx80-0004jN-Gk
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 11:58:29 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vJx7y-0004TH-Ie
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 11:58:28 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-477775d3728so22713725e9.2
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 08:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763139505; x=1763744305; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NWNhjPuhS6WuZzcLBYdZBbWEXj+DsWHg0Bvqes+UNNU=;
 b=L6JY0kSNmSbS89ibL/IJCpaw5jWJkXaebiDEZvrp8AZWF17+KDYZEK/lTb/WjBLROy
 8azylXCCrCAdiI0F2+UOHx9KKj7GVaPkYHQs/yxdopyjJACYSxcXrcE0FWxTTFHu5JfG
 uXXvfTjicGDX/WafyxqjzPz7nzXDiJUAivaI/2AO8Eiapa9k3oHbff7aElwCUG8vnLcY
 NJqKbv/4342LVaSnbMGHN7C+VWe9WIWp3T+EyFhH47NvgjeW6T8sPEmyBiWecnMmIWp0
 /7aNyL2tuHDH84DN5bfUNDGR0kT18tVz1gVSdVru5iyq8i+ThNQgxHmd1/RiXLHI0gER
 +W6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763139505; x=1763744305;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NWNhjPuhS6WuZzcLBYdZBbWEXj+DsWHg0Bvqes+UNNU=;
 b=Ko9aW3B0oInyXOhhsW9V8orOzIs8JKtGOHbVzk++IrvVYvzGqx1ApJ30zY23NjFp4N
 l86II2jtkJYlxQx9UdhpPr/OIFfPZAXrtOwSH3pfj51XMopENyYnbY2YVFadddnjNwfA
 IjCi2SdtM8hCMEZ35xwKmyf3QZ2gC4tSDRE7Bf9JDHie10a+fx4/wVimBrWILUQV3gkH
 Ab9uN/Or3r4nnx3yEFZQhy0hqvuWvfiV+yVTzdfSOQrGwmGGHnAo/2IJGv0LFngvqHq8
 KqC46uVLrB1fpFoUyzRu52z9eO4lgbWtiQAOl10/2hK2n5P1/qq+QUuoBgZXxlNS/WrO
 3KCA==
X-Gm-Message-State: AOJu0YyiS/cZnsWcOME9HAY14lYONowe5lMsfKQll7Qs5XdsrmDvkrbS
 2rjqirurhRAtm4WNB+PXYQkmdM2X1T540+WFhXUpCtB1tPhqTfb34FSJ48aCOZhFmhPm3Z/A7aj
 3ZKtqeuw=
X-Gm-Gg: ASbGncsICUJt6x5GQcwK2ELpvUEz6VJJYEMulNSnMFKmoJL7TJyPfutxJ5LP557BNK5
 +sArAqi9PTBlFRlq0K8tAKP7xPkQtEgZlMAokEnEKyGDnGDP2nPpC67Mne6UdiQVdHhHtUSoLgj
 bcbeDI+sVM0bnShsRPHUnp6Dzyyb7SoKvOECHz+HOiWwvVBrjqIWWiqEkqWHj03+UoVhHnZlYp8
 2dbYNFJ0WnsNOvDM9wItg9HJpfNQzuene0aF2HILgYZSYBxI6334bodyjp3AVlGiu7qeE9vUScD
 PK8SITdgmz2eHg5ozOHbemE9D15KuRbRo/vQWmjzUOmudD6hiVunZDjCJEAIrQCLtyZXUi9b6ts
 I8p0YbTAN0v9O+o+korDMg7IcK1QS1gOIQMpAKSHIm7ykJ9CQMM2hwFMdEWaye817smQMdaRpQ7
 Nzv4r+Kn1Lk1LWTt3JRXeeKVLyjQUNfAw1awj0R4b5KVkBc4okiEBQvUJ0WLlECzOsF1QT
X-Google-Smtp-Source: AGHT+IHPvjuLH4H5DCiNPwE5HU7gHG5X9aIoDeJz9hPpDkL1e77KXUgQzeahrLXoRtmCAakXMGwBZQ==
X-Received: by 2002:a05:600c:4744:b0:46f:b327:ecfb with SMTP id
 5b1f17b1804b1-4778fe5ebb8mr41331555e9.9.1763139504839; 
 Fri, 14 Nov 2025 08:58:24 -0800 (PST)
Received: from [192.168.8.105] (86.red-80-27-231.dynamicip.rima-tde.net.
 [80.27.231.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e846afsm11064818f8f.13.2025.11.14.08.58.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Nov 2025 08:58:24 -0800 (PST)
Message-ID: <f6a8142a-fe6b-43fb-8f7a-6dda1dd5bdb0@linaro.org>
Date: Fri, 14 Nov 2025 17:58:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/5] Net patches
To: qemu-devel@nongnu.org
References: <20251114034806.2440-1-jasowang@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251114034806.2440-1-jasowang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
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

On 11/14/25 04:48, Jason Wang wrote:
> The following changes since commit 9febfa94b69b7146582c48a868bd2330ac45037f:
> 
>    Merge tag 'for-upstream' ofhttps://repo.or.cz/qemu/kevin into staging (2025-11-12 11:47:42 +0100)
> 
> are available in the Git repository at:
> 
>    https://github.com/jasowang/qemu.git tags/net-pull-request
> 
> for you to fetch changes up to a01344d9d78089e9e585faaeb19afccff2050abf:
> 
>    net: pad packets to minimum length in qemu_receive_packet() (2025-11-14 09:59:55 +0800)

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

