Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D65C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 19:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf1ya-00041i-OT; Mon, 03 Feb 2025 14:19:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tf1yN-0003wI-QI
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 14:19:08 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tf1yK-0008Au-Sy
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 14:19:07 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2f9ba87f5d4so181811a91.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 11:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738610343; x=1739215143; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YqeTPKpQ5U72VhaCFs7ctSaXEutKCJ8x27vi+yoMcFU=;
 b=uXutHS/Ta3bGAoXGNOMVzmsTyN+bnfGh7YsBBYJ74CpQAH/lySmRGFmu0MoPgOpw1H
 XEYYTFfkDuvqQmvNMfw8sZJfwgI8ma1tpb5YxJhOSglCE4CXi6WtbBuP79Yq00JDtizh
 lFfEnJcVWCl3O5P+Be0Wc7668mzYFPBX0TfzoTUa8C866YTMW2gH9ppO8aEyIwhWERGT
 f3jz0TzKysFCBgKOG6MZAvaAbNz+ARf921LVf7zUBxgWVgGlMe58h2cRtOQL8+agQIYi
 JPFssCqh0SxZ3af/+WB6xQuMLe22FR4toL+PIfl7NNIANqwcsFIsVNrpmG6QAl6Gj6yh
 3ldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738610343; x=1739215143;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YqeTPKpQ5U72VhaCFs7ctSaXEutKCJ8x27vi+yoMcFU=;
 b=DB0kwZc1ssAKPACyWT3Q5MAUwHzY3U3/6XA0WC6nU3UiBtT4zph0om+s7gLdRyY2Dp
 a+ktnzYDxXN7JQbhMXLE0ZH9HiOiWAHqAUPih4HYbTtTmPQQYjqslQ8mHILS8y9Fn4pN
 HXBwycxOaFpUuVQ94uu9u2uYKHM6Jjl4HZHziFY116CPmHvC0qZldwRGAy/BUdDUcq+W
 KNlBudKnogOFSq+cnpmNk+fzdyBSUKysBcNh65FKcaUDykmg4ZtIBxa28S0AqCcMgbTT
 LLB/PRIFWiHcMb8/uEib5dGeq8kWBPw3y0LLhT7B5KURlSHFSdPp1Mwc1mLcjG9yXIKB
 nRmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsL1gLJ5LQYtafV3ugnpPZFTG2AtimkTRwNVw8hEyNkx8wASPY/c515JMbPAwCM5QjqfzE7eK8+N8R@nongnu.org
X-Gm-Message-State: AOJu0YygKYefXgs09V+wkbb1NcXEYU88IsPjtoma5F4lh9Xw2A8im1sw
 zMTcn5J8cAAnFPwaTm3v2gRh+e8KdvjUoc9e+dJhP4DJqpBamN4uPLqPwfZGOW5AN1zo23P0OKr
 E
X-Gm-Gg: ASbGncsvgkhRXj6iC/oQQ72UV/8NpIB5AlmKbcOmo/6SFMj1Uw+I9W6vH/7XtzJoEZM
 6P2HeW32k3JQkBEKLhewONh70d8fGdgvP4WdZ5vOUSS7n+syZ5+VkFle+uMo79Td/IwgrQ38hCX
 LO+C+isEMph3atkpg7US4zpKk0Og/8HEI/s04lZy/dXAmmd+c7ASRGRje/9MFlirZDmhLJUsvM7
 yUI3yX8ytxlXLp6LteBhorC4NJ01/Jy42y2lzN6kqLeULBzAfoOOFsSqVNoYBsCwj6hVYLdBeza
 RRbKDlJaJ9nLpoXYC21iVu9+MGfI906z0QilIwzrNNsR7f0oTYPTk6g=
X-Google-Smtp-Source: AGHT+IEDB5zWnN3DUq1OJNjAlaBfWV47HESiICjODtVJ5C2wX3mmC55VvSvBC2bMbvQ1lAX2X56z4A==
X-Received: by 2002:a17:90b:258b:b0:2ee:cded:9ac7 with SMTP id
 98e67ed59e1d1-2f83ac0e3f0mr32082817a91.20.1738610342949; 
 Mon, 03 Feb 2025 11:19:02 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f848ace140sm9406832a91.42.2025.02.03.11.19.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 11:19:02 -0800 (PST)
Message-ID: <ace41de8-b0c3-4dda-b90c-7c1edbb9bb4a@linaro.org>
Date: Mon, 3 Feb 2025 11:19:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/14] configure: Define TARGET_LONG_BITS in
 configs/targets/*.mak
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 thuth@redhat.com
References: <20250203031821.741477-1-richard.henderson@linaro.org>
 <20250203031821.741477-11-richard.henderson@linaro.org>
 <707af3de-3e66-4f23-961a-6fb9de45b5a1@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <707af3de-3e66-4f23-961a-6fb9de45b5a1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 2/3/25 10:30, Philippe Mathieu-Daudé wrote:
> On 3/2/25 04:18, Richard Henderson wrote:
>> Define TARGET_LONG_BITS in each target's configure fragment.
>> Do this without removing the define in target/*/cpu-param.h
>> so that errors are caught like so:
>>
>> In file included from .../src/include/exec/cpu-defs.h:26,
>>                   from ../src/target/hppa/cpu.h:24,
>>                   from ../src/linux-user/qemu.h:4,
>>                   from ../src/linux-user/hppa/cpu_loop.c:21:
>> ../src/target/hppa/cpu-param.h:11: error: "TARGET_LONG_BITS" redefined [-Werror]
>>     11 | #define TARGET_LONG_BITS              64
>>        |
>> In file included from .../src/include/qemu/osdep.h:36,
>>                   from ../src/linux-user/hppa/cpu_loop.c:20:
>> ./hppa-linux-user-config-target.h:32: note: this is the location of the previous definition
>>     32 | #define TARGET_LONG_BITS 32
>>        |
>> cc1: all warnings being treated as errors
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
> 
> Orthogonal to this series, what about the other definitions,
> like TARGET_PHYS_ADDR_SPACE_BITS / TARGET_VIRT_ADDR_SPACE_BITS
> and possibly TARGET_PAGE_BITS?

We don't need those at configure time, so there's no need to move them.


r~

