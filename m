Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B13C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 07:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhjnr-0008L6-4a; Fri, 01 Aug 2025 03:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uhjRe-0005vL-Pp
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 02:40:49 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uhjRc-0003l6-QB
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 02:40:46 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-748e378ba4fso2389464b3a.1
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 23:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754030441; x=1754635241; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L8GV5m68XdYds2nLAzRSVCei/nM/wyjpdhEO4v57SPA=;
 b=F9vAWYXAVtA8jZmn/hLt19QkIya1CeqGYYmBfZ5UgsmRV9/iWqefNg6SPYa8Oqa+a5
 XdA05k2GwmfqDGQs4eEKlD8+nRc9WAq8yoAFx+SZ4t8i1hn4rzrdJuoepUCMNv3RSwbt
 vGHdM41N6OFrXC9U86RWDVK68hfFsxakwHqWZYEIlPwWq6C9nDkwALwcdY8qgregCf9u
 ZqF6Dkb8Y4nOUzOGX+BiwrM7NexIXI1vCojo27HJKmPDXjNFSORDRJd4stCcSTQDdVaT
 46rleVloCNMMEb3jwnstuu0wC7tq5lWkP2N43wGo1J0pU0+QOsydgUWT0DCqR1NOC6Uk
 z7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754030441; x=1754635241;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L8GV5m68XdYds2nLAzRSVCei/nM/wyjpdhEO4v57SPA=;
 b=vW1Fe5nypB1rOcbHJGXfsfM/OxqScnVXUoRFmEstzmmcD2Mn91ez2/XlBtrd6RX8L+
 D5DzSoHOMoh0EX1oP1aGHhIq4SHGVAJKy31a0qJaBcYskciQ21bhbWFTCbt5V38Ov21u
 EDMUy1wMtd/rRonUO2NMSpwdJKZZKm6S6wo2mtAjJgcFptOe3r2jBnaivwSFJzY5IglO
 EoduhPwG6mBpG2n+ZI5qfuscDHmEH8L/50t0oYdBOMRi6Y153l02Gy93v6vZCAX5iX6g
 40G4hrM6twM8lLkaKp1Hnqftm1nceb2TRQ4vAaNWKqjeSWfw1jt4Y0XvffjWhuYGJSlB
 gkUg==
X-Gm-Message-State: AOJu0YyspPnXPECYIAlQc92sKgp51Ns2uhn87aRFoV2lCWrMyzobsXkM
 PTV+/mi88tLsCtscFA4xUy9+kAfqUc6g95yUIKASOYkZe8BBIsiLN+oZRlXpijvNF0fCbFsW3wZ
 9PS0Xd88=
X-Gm-Gg: ASbGncu7PyHkTt80LejyzCOmVralsBhT6IkmAfEY8eOTTWyUrwdUAAX3haHo66iQU81
 GBeYgarsC1qBqIB9UaqNeCQGG047prYdXoK363pzN4UIPtcVLSAAjQ3eEq0VgIb4clLq0wezUG4
 ACwdnVD1v1Intblstp/EbNziZrVieB8U574BacO0s+EM9ADBU1Duz9tpPu72VRanpaI8wsTQsON
 mHgEOOXcgTRRsIN6bOVL96JDh4gPw/WPp1aKDi+kGDkefjzPOFk+aOpxmND9Rkxb+hX6N7jjP7y
 uLuBDBIHR3uAeMd2awHTm2SKjeXVGVdBF3s9n48gnp+CCM7k4QenkoDHSUM4UasWAMZfDOELiPi
 GbI13FgsZDvXUuHaO7ZwVDhmb1BCfpquVS9WV50qo
X-Google-Smtp-Source: AGHT+IGJbnkccbMa4MpRMNmM3MAHemTIojYKg3JCHwnCiELpw35Ftw/KKBCgKPEj/htosqk5zZ3sOQ==
X-Received: by 2002:a05:6a21:99a5:b0:220:aea6:2154 with SMTP id
 adf61e73a8af0-23dc0d916b8mr13983933637.17.1754030440551; 
 Thu, 31 Jul 2025 23:40:40 -0700 (PDT)
Received: from [192.168.4.112] ([180.233.125.160])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bccfbd22csm3280783b3a.65.2025.07.31.23.40.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 23:40:40 -0700 (PDT)
Message-ID: <eb5b5966-2a3c-42f0-8549-395d24d9ea63@linaro.org>
Date: Fri, 1 Aug 2025 16:40:35 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 01/11] hw/sd/sdcard: Do not ignore errors in
 sd_cmd_to_sendingdata()
To: qemu-devel@nongnu.org
References: <20250731212807.2706-1-philmd@linaro.org>
 <20250731212807.2706-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250731212807.2706-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/1/25 07:27, Philippe Mathieu-Daudé wrote:
> Unfortunately when adding sd_cmd_to_sendingdata() in commit
> f486bf7d109 we neglected to return any possible error. Fix.
> 
> Fixes: f486bf7d109 ("hw/sd/sdcard: Introduce sd_cmd_to_sendingdata and sd_generic_read_byte")
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/sd/sd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


