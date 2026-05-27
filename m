Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86329CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 15:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSGTe-0004rA-63; Wed, 27 May 2026 11:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSGTV-0004qH-I6
 for qemu-devel@nongnu.org; Wed, 27 May 2026 11:47:17 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSGTQ-0007KN-LY
 for qemu-devel@nongnu.org; Wed, 27 May 2026 11:47:14 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2b788a98557so77133545ad.2
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 08:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779896831; x=1780501631; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tDoyv/Ygmfr7CRPIvOINuRexPPTxTNrrwr1+BRAT45U=;
 b=dgB1GDnussfk0tvjil/tOfxI3tlp5bbcl5dfSDWmNgCzZlsyHle0OH5UlXy+wTC3zk
 FjWsqeVaeMO/X2EhuWuFVF2qTaBxsvqdD07d5DMNfJBUvWCWhMVyrEvgQHtLHYUph1ht
 sGU3/EKk0O7J6a4wzBjPT+UsRjbFmeMVtsLbnZ21AIyTa3oNhA3cY+2vORbgAxEUcRD0
 RprL0TFV8U305YxMQ0EHhDVnUAXcB7Tp3y2XROigDcO9thj1uycOXDOXPhz+RKRxGiZU
 TufU9F5+PpZXjWUsvZZ8nkdhlXmGPmGUUzMDf53kLyTFCOtPvY2i7In7LjUs+X39EAUx
 sthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779896831; x=1780501631;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tDoyv/Ygmfr7CRPIvOINuRexPPTxTNrrwr1+BRAT45U=;
 b=IS/Jd2xLgUETLCsQ4KBF9370u9Z5KaqFnFgnFGF4GrDWZ7TanYCOKg0Y858ulQ8/lh
 +TrKu0qRfcRJX1aLi4QilcUnRp/lOl0QBNEqy2Fp/lUTRSvxA+N/+NH0s6Kt4QtnvO0x
 Ozhl/WDeeFatyC1+oEH8ieNTHqd+5H5yYe2F4ErmkLPza64OqSojtiUwSfxqnkVWjfGW
 3ubuIf45qyD/oXnIMhqyAZoduChxJIcmbKG5C5Qdmw3eLJ5V6cIo4xyACFpiEGIZvK9X
 6F3cpM/ZlMhxB12ACT1nFsq10+I/0ArtIqxswsAbLzLyXNZGNisaFBJoDRyfoBNoIj7B
 LCOA==
X-Gm-Message-State: AOJu0YwtxS/fiLwiQsv4cZPtzX4Ov3CuHf/rFN15tNJJ5fwXTgkk0Plb
 hbBdEDQqFVY5pNwbGhr9sG7T0vEzWh4F/l2Dqyoc09RaikzWhPhsbfmDdc6vWMyh2nOFPef83iQ
 7m0+7S9c=
X-Gm-Gg: Acq92OHthNfePKAwyRGP3U6BKw0ZvKCHn9scMTcweEv+5hkGZBeCmL4hB8fzKPnk8mm
 DnuSLX0pFpGxqDJNBe8y8x6/zM8XboGqWBrPGEexszmaaf4cHBDGeWjdXajNMmhKrAiePdOslSH
 bQBlbnuLymOQBOQY9nppgQfvVDFqLTdaV4YnxQvezyxAjwcyFA1aiwVfcNlP53T88nDPqHe4Oxy
 wgd3PmUmi04ZcWytQpESACPAWzIvXsDsfxgQzcSxwmNMOrDGvfmZ8YEnv574dbaY6Yq7ehJRnoC
 bcoPeyMrfkOdpznGYn6nLcie57zN2rJHiXvVRi/AWJX9ITzq5XM372dXQhxBEwLUyq7iJmLpwo/
 5MXJkPlXufykHDmBd0AqgFNBs9kvG5PCDfMLY1Yq+8WjEqx44uxM81LOg5RqPuXp2hGe4+9gEg1
 6HlHVxXVyn0jDMbRqnE2I97RqhRPU2ySaQvt09IJ/bO0fePE8=
X-Received: by 2002:a17:903:2bce:b0:2b7:a1ff:b239 with SMTP id
 d9443c01a7336-2beb0599ca0mr249479935ad.14.1779896830777; 
 Wed, 27 May 2026 08:47:10 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb58c4f20sm154691465ad.61.2026.05.27.08.47.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 08:47:10 -0700 (PDT)
Message-ID: <7e1d5874-1a7c-48b3-9e1b-187ed6463c30@linaro.org>
Date: Wed, 27 May 2026 08:47:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] linux-user: Fix loading static ARM cortex-m55 binaries
To: qemu-devel@nongnu.org
References: <20260526145049.7239-1-deller@kernel.org>
 <20260526145049.7239-2-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260526145049.7239-2-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 5/26/26 07:50, Helge Deller wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Static built ARM binaries for Cortex-m55 may have been linked to have
> their load address at address 0 (because they are effectively a
> bare-metal image). When qemu-user is running as non-root user and will
> try to mmap() a host address at 0 (which is smaller than mmap_min_addr
> according to /proc/sys/vm/mmap_min_addr), it will fail with EPERM and as
> such loading those guest program will fail.
> 
> Fix pgb_addr_set() to always return false if the guest_loaddr <
> mmap_min_addr, that way a valdid guest_base address will be calculated
> and the EPERM can be avoided.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/1890
> ---
>   linux-user/elfload.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 0e757787d2..77e0526996 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -866,7 +866,7 @@ static bool pgb_addr_set(PGBAddrs *ga, abi_ulong guest_loaddr,
>           if (LO_COMMPAGE != -1 && LO_COMMPAGE < mmap_min_addr) {
>               return false;
>           }
> -        if (guest_loaddr != 0 && guest_loaddr < mmap_min_addr) {
> +        if (guest_loaddr < mmap_min_addr) {
>               return false;
>           }
>       }

Nack for ET_DYN aka PIE binaries.


r~

