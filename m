Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05287C021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 19:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiecc-0007v1-ET; Thu, 13 Feb 2025 14:11:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiecY-0007ub-MQ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 14:11:34 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiecW-0005c1-NC
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 14:11:34 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2fa40c0bab2so2451519a91.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 11:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739473891; x=1740078691; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VNAAW0nzNrl7Gw274IU/EtxGlbL3XYf6wJ7dSgg2S0I=;
 b=iZrkVPWjRT2Ju+vwb0cFZzF7w1JSt4hEcgYI1BlFoueZs/GG/2NF/3qeFpMbqsP0Rq
 EhQxzd2+/4YPkndEu14qiQJmyVzoivH8sYXTmsaHrxOcg++Y1ldzFCnAq6eEvX33ITuh
 /IFiZjquMn6O/P50vxvl0qAxjqt/GwMds9bS9lHNbSzHZ45rMdIHKCXy6PhRk8hRs9rR
 +kLNpx0wiDelewSqDa3uqOXjyQ3phh5oT3ujjyEDijqx2eR5nsyMnz/lDlK9BBfPgr8p
 twE3yGa+Cf2EdjcTwDRVmBtPokl8V4zWsFuAExnzwKnKTFYIYszh1UAzjJtxsEwAhtRt
 Lehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739473891; x=1740078691;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VNAAW0nzNrl7Gw274IU/EtxGlbL3XYf6wJ7dSgg2S0I=;
 b=IoG/baDNtIOe7jokmedNn7RppKFCxQZUvS38lQ9yUYuoUtEqCBa+MpixyeCaUT1sNo
 zTNq6+x8/p2Ao+8wHQrhCywLskHYhAhRmH2ZDCTv5gDQLa6mfdkf5+AGVOHzAufUy/GD
 88XCyK72weW/jtNYrHFWSlVofxjfTAufudT3IhSClk5i8IDg/D3saq3lq4VpxrRKERvq
 OHiKQesXH+JBXsy9jnf+w07j6fAj+LWAB0lj2oRgh60ClYPaVCjpT0lZfCZ/IixGlRDr
 MQWKQWcqJslHAKiYWKoyHl/tuXGFBWjSZ1FeEeqA/Xo7WUMHJq5ra/KBmBw32aP7Jwjr
 shLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyZxmzv/6tgUaJ6OkmVRE/+mVDIwiUp7W6Z38KVUaCfAuFUZkteMJite/BsBPWwplc7J/JqWFS5/jj@nongnu.org
X-Gm-Message-State: AOJu0Yw7Qkpqi56xumfS4xdZk+x24A5JyOey+qkN0VYbj9o5niYI4bun
 ZgQKVaXthNh47onip9GvSGsfAgr3cZ2poKD77cb06DeHS2OM4gx3oEFZqtxU0gE=
X-Gm-Gg: ASbGncvtWLTewxx3hPGb9lVCemURYIuTLooyBjm2jackpFaI2KwXH/vzf1kWzm94785
 NWe3Jc68r/UGgP/OEMleJZDgU4e5TMhkKzFJG1yvALci3LPw6MJK/czj7otX11Ea7ru3BwOSGGR
 tORFZ0ezcv9XXzm6Gy7/MYR1+cqXvrtP8QZbj7XvxDu7JSYNsiQCBgQ7JKKKX+RtMFSpA/qDx2/
 FmH4G8YSxDOZAGncQ2UgUqCgcb9A/2aGqA0MStnL+squxDxcaLgw+H6DqMhV0zSuUJDyEGqNq8j
 fTsCtTgzo2en1grhFn2ZC/CFNaFUHFQKB3EtkRPsPIpiiHjnhS+Gvdg=
X-Google-Smtp-Source: AGHT+IH4ejn1A2Do8bbDWVFQoB0DI4b9ziGvCcIQwuHG+QnpkKfXag3FMTYpDcv5PSoCFpgc43GHtw==
X-Received: by 2002:a17:90b:280a:b0:2f6:d266:f45c with SMTP id
 98e67ed59e1d1-2fbf5bb1d26mr14218116a91.2.1739473890627; 
 Thu, 13 Feb 2025 11:11:30 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ac0a66sm1611680a91.12.2025.02.13.11.11.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 11:11:30 -0800 (PST)
Message-ID: <5b29c7d9-2a2c-4cd4-a094-1aac8a34d3bb@linaro.org>
Date: Thu, 13 Feb 2025 11:11:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/sparc: Fix gdbstub incorrectly handling registers
 f32-f62
To: Mikael Szreder <git@miszr.win>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20250203145056.83567-1-git@miszr.win>
 <ddc4ca31-22ab-4818-88d9-08f299559945@linaro.org>
 <C0AA2E55-2126-4399-8667-672ADD86B698@miszr.win>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <C0AA2E55-2126-4399-8667-672ADD86B698@miszr.win>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

On 2/13/25 11:03, Mikael Szreder wrote:
> Sorry. As you correctly pointed out there is no f33 register. I wrote f33, when I really meant f34.
> 
> I believe the index of f32 is 64 and f34 is 65. This is confirmed when looking at the XML description of the registers in GDB: <https://sourceware.org/git/?p=binutils-gdb.git;a=blob;f=gdb/features/sparc/sparc64-fpu.xml;h=8710585774d821c660af5e76f92707637633daf7;hb=HEAD>

You're correct.  As should also be obvious because 80 - 64 == 16.

So, we could use some updates to the patch description and to the comments within the code 
itself to match.


r~

