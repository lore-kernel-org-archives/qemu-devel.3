Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7BECCA474
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:17:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3ySy-0004pD-5N; Wed, 01 Oct 2025 11:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3ySv-0004kq-D6
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:10:01 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3yQx-0000vP-6f
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:10:00 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b551b040930so4926580a12.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 08:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759331267; x=1759936067; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lV8RNQ++v7c1oOQ5Jt+EgzxKPMz0iuJCb5RvvPAFXjI=;
 b=FClKisEJ+eqUqxecBub8h0sO8bvJwRgKKWJCiK6a0ru70krgHOvV7uUXh1TDBfS6JR
 ibjSO3aDcxSfyHXHRG6H68+jkXcl3rWW1zut+yGMcBpkZdJni1r4Kb01329mH0ZDjgRS
 DURGZuLXQkIBMenCfYsgAJuYafXTX4OcjpI/E0mPcauSNNFwt7YsqbKKG020WWA+J+Hq
 LGXms924aZHqdeQ3i1+wNtYhm4BNLqHE1EAJM6OrTtJNBBnpgM55t0guFp99NrTF+zq2
 ICXDN+W8uEESEOl/IEptxg5u8BA0c4ZQBZIBDaUxmzAgBZ4b6aHmlOMy/Dl3PYOV6DD0
 6tNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759331267; x=1759936067;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lV8RNQ++v7c1oOQ5Jt+EgzxKPMz0iuJCb5RvvPAFXjI=;
 b=BT7NmqWSNWucNdBpkdT5ncadb1bRQ8XyIzVxDOLLVoflsT8YxNorhP2u3VAHttSJJ9
 D6Ug4Vzk/Tb9JpH8p2xdlr2w9OO770U2UnIpwE1LwP7Jv1bflsesJ80qBjsDMxMSFHX9
 T0Ewheu4q6RKt225lcQTUXMmWIR57frLCeUwGZW0e/KH+0MVGcX1WS6yrbA8ABEVALbD
 8FW1qVKHXIOi24clilhlfzdo2ShD2XFlKuYmzi26cdf02c6ibxiT495uw57Wa6CtHZr+
 qAgK9RQcAKW8MJYWDpwVf9L88CUJ4LegWUjpS9ybBrHX+SfuMFlvBHSOH6FmTagjw+qr
 Jb8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIUerGJgH98VefC3T1aNOX/2Nc8p9EpOWu51fby95oqx0yH2p4aeowgBrL2o5XM8hQwD9WyTjGu8wh@nongnu.org
X-Gm-Message-State: AOJu0YySBmevbkZE7jy0qSESA23pJDl6cnI2Cce8CiAYaxtki/Rwx0Oc
 Hnz9GV94/APj6P5UPD24S3SS5Y8Mc2R0/GeLdRgjO2W1V+X1ZbHx3SU/Ag+7U1QQSg4=
X-Gm-Gg: ASbGnctl0zxGep2oTl5lWPx2pRAeVWEsBoJjFDFlaRgKuHxrASMY9R+FUBOVjD0Nq3v
 sZUHBo5yR8VGN1dP9UqVBHkRbDt7GEFLlNSVATlaGHSUg3nP8K77lTToqpzQFNpBNROidP/cMU0
 ULh3EAQ8ONmQvTEU/Uhs2ngAgD0yld2L7x+DAmPbH01RbroltDlSocRb2budTzObrVrvq8/yujY
 bACFYBTUvId3j2yWF1EL9m1103CJVCocQS1FExgOhs6/mFnP/LqeKFnmTBMv2yMMwyejX2+3WuA
 bg+Eg5kY6IH/JF0r8XJHhhMvPlo6VWXrYtj7iJbTmfE6eHtCiE2GpKaiGUyPVaufFLNN19B1Xyl
 I6NGAjCEi7Yh2HDdrR3FkaFHoEYgHIXsWxwRQN5MiTz9Y2JJM0qglUR5pRxM2e9dNj6QKBxSjDH
 fVsCE16Gc2A/tF5bVLk2PiLCgecgKrj18=
X-Google-Smtp-Source: AGHT+IHsj3LfL1OZ6MVjCk9NFYryHQqrNJYfMBizfOgQvVA128KboxttFRoVzP5J9XDQ/W5Y7O9jEQ==
X-Received: by 2002:a17:903:11c7:b0:269:8407:5ae3 with SMTP id
 d9443c01a7336-28e7f4b6843mr51178595ad.54.1759331266582; 
 Wed, 01 Oct 2025 08:07:46 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345?
 ([2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed66cf181sm189688935ad.28.2025.10.01.08.07.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 08:07:45 -0700 (PDT)
Message-ID: <997bf266-1dc3-49b6-96b2-44088f5fd75f@linaro.org>
Date: Wed, 1 Oct 2025 08:07:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/25] system/physmem: Un-inline
 cpu_physical_memory_get_dirty_flag()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20251001082127.65741-1-philmd@linaro.org>
 <20251001082127.65741-11-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251001082127.65741-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

On 10/1/25 01:21, Philippe Mathieu-Daudé wrote:
> Avoid maintaining large functions in header, rely on the
> linker to optimize at linking time.
> 
> cpu_physical_memory_get_dirty() doesn't involve any CPU,
> remove the 'cpu_' prefix.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/system/ram_addr.h | 46 +--------------------------------------
>   system/physmem.c          | 44 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 45 insertions(+), 45 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

