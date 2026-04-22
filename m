Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50740FA1FD6
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 17:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFb0s-00045t-O5; Wed, 22 Apr 2026 13:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFb0o-000432-SQ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 13:05:20 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFb0m-0004Au-N8
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 13:05:17 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43d73422431so4870216f8f.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 10:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776877514; x=1777482314; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SSEwGfbuXA0olrN5K5NowCOkrdaMfejYxdGhJTnpAso=;
 b=oUEvj6e9ojYcJfCYraQ2dKZTY8DkQKnJ7Vb9C2+anaQ8QiKn3UxBbrNNxEKL0MtMc2
 OyrO5IbKds/2hO4Q6fc6SuFu2Av7E8eJ4IWrMB3hT/jyHDhN90CqlJU+rV5Y6oeWh2WB
 Zr5kOUyrB8WezcT8xteJ7Ysxa9WVidwdzfyNeR+K9EUpxKYHCv/2Q8ntHmQPYT+miK8E
 gz9+5e7IarQpshcTM31N/3dRLUjuw43Rwfs+YGFoMp0E35rLDarQjbwzGeTn3rjSszvA
 soKlwWCP7rWnCjmPlS3ijhqp5AH6ikIT2Vqlc4eJK8CHTgR6Bct6L5haBzhlXZ9A9RoW
 DWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776877514; x=1777482314;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SSEwGfbuXA0olrN5K5NowCOkrdaMfejYxdGhJTnpAso=;
 b=JRR+u26oMI8QjZrucnL/y4B5DfyZRfyv9Td+QWqHMtHYiwS26EZ5W3Kq4kyde26Hwf
 785dnVDfubRfugtnh49PEr4FVITjye33pVhvDk2kj+XcrEIvyMB2q6/yOKTxF9UOR4i/
 Za8xo80Jm+F87RgJdUrEdSVpqP3QTw1Z4CvmKrZl0FMYAa/ue/sKMYUxqUI6lpMM1WuP
 KXpgsV/26WRNlc0tvsPlcu/o6p0VqJNrlAylDTMbO14N8ZwIaU5ZseNaVeBCzho/Pchj
 uNOSMSbkRpa9a0r1r3SoMuKA/kqGK46fAeN+UoozAb62QXH9Cq58tTHRCrnOn36ERbCy
 PmTA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9QrMQLIQXues77CQFEIlNlLYheEB2RKaiTNXwtXSNolBXcq0Z/wIJNMNGCDGn1o3AiG5bgVVZaotJB@nongnu.org
X-Gm-Message-State: AOJu0Yzz8o4wzX7jRSKXp89TcHfCXeA8/ixrrbwB10QQNQhEzFjIh7yC
 eH6eBS2k+4OJHFrK3E9ieQH9v5IGc0wKG5yxtjW1pH8gRZjWNU7+LfD8UXcoZTOd+kA=
X-Gm-Gg: AeBDiesJjtK86IjAB5OTcaaR3c+QO8HOgsYV7Uq3eMFpYfUP82XiKvQ7grn9zwowaJw
 BwsVqY/xyG4FL8QlvHOQgEcDLAtwysVI9QP3v9gNJ9nlAR7ZCW54jAGS8glLOxpJxXOwNZGezil
 ZZV7j8QsyslLoBZj/kE/7mVm2XVpqA0M1NfasOP7TGGAfM6K/3RpDMPdj/F5QuRsAVtRSIs16+Y
 a3hVoqcObaTllGGhJLGc1luNAOljdS1g2LcHOjISz/CXtwD2410C2YzMSj+hhq6mYycJ0U5FWe9
 ABXqUMIxpxPg1eCzGM1KfSA5zbN7+MSeWM/Q4CamTRLiGomt5QjjJwBP47saaxBwjJ9rpuSH7Wd
 PQi4wKZef7HCt4rqHijOEfXLR57AF4qUmRdKs7+zjDWmG2nU+ySZbj4jbgkPkm1z4jxnObWETrg
 MDIO+dRSryv1K5RNhfOe+VXVYiB3Iqqa/8dw47dRrZEppqZybtHTMyY/rHNkD1jmZQsYVlgESwG
 99+
X-Received: by 2002:a05:6000:2890:b0:43d:77c6:be78 with SMTP id
 ffacd0b85a97d-43fe3e16c4dmr37158960f8f.39.1776877513693; 
 Wed, 22 Apr 2026 10:05:13 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4d5b1sm50743462f8f.30.2026.04.22.10.05.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 10:05:12 -0700 (PDT)
Message-ID: <c8db1261-8a5c-4be5-b151-79e0771b173a@linaro.org>
Date: Wed, 22 Apr 2026 19:05:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/10] accel/hvf: avoid executable mappings for
 RAM-device memory
Content-Language: en-US
To: "Scott J. Goldman" <scottjgo@gmail.com>, qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, pbonzini@redhat.com,
 rbolshakov@ddn.com, phil@philjordan.eu, mst@redhat.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com, qemu-s390x@nongnu.org
References: <20260405072857.66484-1-scottjgo@gmail.com>
 <20260405072857.66484-3-scottjgo@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260405072857.66484-3-scottjgo@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/4/26 09:28, Scott J. Goldman wrote:
> On macOS, HVF can panic the host kernel if a guest accesses device-backed
> memory through an executable mapping. Leave RAM-device/MMIO regions
> mapped read/write only and keep EXEC for ordinary guest RAM.
> 
> This works around the immediate crash seen with passthrough BAR
> mappings. There are still platform-specific performance issues with
> guest write-combining mappings, but uncached mappings behave much more
> like the host-side mapping and this at least avoids the panic.
> 
> Signed-off-by: Scott J. Goldman <scottjgo@gmail.com>
> ---
>   accel/hvf/hvf-all.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

