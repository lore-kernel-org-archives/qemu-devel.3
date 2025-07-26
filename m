Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B86FC87FCA
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Jul 2025 01:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufTak-0001WT-7d; Fri, 25 Jul 2025 21:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufTai-0001Vr-I4
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 21:20:48 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufTah-0007l3-0P
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 21:20:48 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-23f8bcce78dso31448815ad.3
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 18:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753492845; x=1754097645; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8mSBqu11tO3t9Ob+Q+pUhtHb1gH9qK4Kq0Dxh4pJPSI=;
 b=RB2+TvmJt7xOOpU98jMEI1nZtsh/IHcsQywFGR1ux+7bv8ys5jm47N6oZxA8RoQSEu
 xDTflWYpCg6mMuMlfv5nMZfTYL7we730ZspK5dJ8ntKAX7hSPBgz58bDsCeYc5TvCRBF
 u6wfdYY3a0EgM9oVzJ+AonjC9VeH3ZHErnACVgsUXPZH0+dfiQlGbzBs2PBnvN5k6W/B
 WslUdWz+EgDCd5MlkhJrq0BhU+iY0QDPMKqlc8iLaf6bm6YqTQkcUNLwzvWC3kZhV2TH
 akBk+N8aWvU7P1WsrZNDMvfSj0kLOs3/bI3iXBsvOMaMdVkOeGt3jLB3hgXUyZeEw68A
 3txQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753492845; x=1754097645;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8mSBqu11tO3t9Ob+Q+pUhtHb1gH9qK4Kq0Dxh4pJPSI=;
 b=ZBCcnrEoU7qxYseKw1UWcVQDX4yPEmsyWyV8RUBSv8LPZBQYyjFHM72+xeY64m3lE6
 RqF2LJnQMR8D9ySK9FqwA7LbAmw6ymCy6UHrGOAjtDVHeA3ftcij2tDCiLHOWVtKQCJ6
 cWhGNvzJGcC2vqx1fLSHkeHNwLhY6S4uTvbN8OQMpU5KVsBwBOy4i34h7WxFABAOeIi+
 ffjiDUV4OkyawhkjlgkC/EWiIZEqjKkKdMUdMFKtYNvoS1hLiWcIVu936o1KA4QwAZd3
 lXOYJDMW+e91fwjnlhWVintRS4vcDnhjjmx4KSR5b4dj4QWXoApTAePG0Zl5l1n+P4io
 sAOg==
X-Gm-Message-State: AOJu0YzDKpj7Vk+ZONuLqzfWL9FkXnkrPuLw+BJ5IsbwMUspf+vyC0hH
 WZI1WF7LRVcG8jO/a7gz+KmgYG8Q49NXbaSlDEiHlMNfW64af3PWGyf09WdYuOXfBcarq3cVymu
 Blc5z
X-Gm-Gg: ASbGncu6pNSU4qs2CHMIOQXDWXAn2e82T7n3D6Fl9wx2hbZG1kmTjUqbbYrlhCNku+X
 FE33wuMjFqaSAOYs0sN8lcMIFs3R6/cZ6lKQOvAadjV7Ac7Na7376joC+S+MTBV/9FXI9+NuE+m
 1KniXOPMSfgi5lPJQVNmamSUOsGIW0EkEaIlVn5HkdTWL4m3U78vo/9gAhoucOb331gTJ7pSrT6
 9GmO90ePrhlAQrXLBvydK/vpKPd9lztNsvNN81zVp49CDsW5E19vum1gnF2goies0Tp4Tpp1Vff
 2pqYpmjxCGI7FC5SyZmbRtCRc1ImVfX5G/OvUFcnHNsHW6iliY6zljxcyJfUOw27V7MdysKuHBO
 GnCbAqUuwtQ7mnhfszo/wSgUUynryXXV3hhKIkUdVrN842KHWTdnWDPa9DCBH6KbOxpqPQ7VXWz
 sBgw==
X-Google-Smtp-Source: AGHT+IHIDj9nb8XKywJ6BgU9yWLn27fjzNWmNNlcf7WFPqwJUzx8xlIX4npSkr6D5CqxTl72kWZghA==
X-Received: by 2002:a17:902:c950:b0:23d:ce98:6110 with SMTP id
 d9443c01a7336-23fb30657f9mr64316435ad.10.1753492845368; 
 Fri, 25 Jul 2025 18:20:45 -0700 (PDT)
Received: from [192.168.4.112] (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fc5aac459sm2757565ad.105.2025.07.25.18.20.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 18:20:44 -0700 (PDT)
Message-ID: <7b01ac68-7d93-451c-8cbc-93faa72e97b3@linaro.org>
Date: Fri, 25 Jul 2025 15:20:42 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/17] target/loongarch: Use loongarch_check_pte() with
 page table walking
To: qemu-devel@nongnu.org
References: <20250725013739.994437-1-maobibo@loongson.cn>
 <20250725013739.994437-7-maobibo@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250725013739.994437-7-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 7/24/25 15:37, Bibo Mao wrote:
> Function loongarch_check_pte() can get physical address and access
> priviledge, it works on both TLB entry and pte entry. It can be used
> at page table walking.
> 
> Signed-off-by: Bibo Mao<maobibo@loongson.cn>
> ---
>   target/loongarch/cpu_helper.c | 38 +++++++++++++----------------------
>   1 file changed, 14 insertions(+), 24 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

