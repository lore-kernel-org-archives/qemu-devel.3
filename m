Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2912CFF8850
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 22:15:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGOn7-0007to-2T; Fri, 24 Apr 2026 18:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGOn5-0007tM-N8
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 18:14:27 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGOn3-0005Bv-Rg
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 18:14:27 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2b7d3ecc10dso6235665ad.2
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 15:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777068864; x=1777673664; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1Gc5Zw+6rfjDygI1bc1DkZM/p7nsmTSlETdiH9XVpOM=;
 b=KGM+JpzmRCFqnrptALwvt05QrcXA4ecvuc+2p2xEXCvIYWaedA5oCdokggUL9p/Rgv
 XX8Na/0TO0hxZLuAznqdr8Hl+jgEO4YkMgKGxgslehmF6Ahc+Yccz4VSvb5OmAiZfkHf
 tdU2PNHUE/PuuU7oge/nu/OK66l467MO/8mvz7l8Kl46KYRLXxAxL7F791ubVy0keWRe
 puc17Y/Ewq7+rcr2wWtsg73N1kng7RDGgMv7fxVDkYH+A2fK7tGOLkDJt6S9SHoavaKo
 qBKFN/JnfunnsTQNok3yZx2HFoxiHQGkOV0hLWXlOEddElXZxXwIaLxqFUoVw30yWXnD
 iCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777068864; x=1777673664;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1Gc5Zw+6rfjDygI1bc1DkZM/p7nsmTSlETdiH9XVpOM=;
 b=caeIXzyk5whqzyKPLOpywGzLOciIDDn7LZCpgp7TJT9bhrvyaPYJA4J0mik+V+YCTS
 RLCFZBFCNbARNLLnvVGnNMb/jcI57sZI9I+UTt4Rs+DZCn3Ud2rQFFAhBfFVBFhUywgd
 raxJAXdE0k0reSTp9RVyux+BiEaOnLbEa2RvIVFwPRbd8SPauA5FYEzsB26fRNfDlBvJ
 S5XB249qecV9EU6TU7NgPLdXDflseJbh17O4odpBhA5HNJusQ1scHJ2JdPyDI5zUGp8s
 f6W/NkPoU33QWkfP1wtKzLegGOYhh6PKvt7Wf7eqdzG2/JriOkpePGVCyZji2q4XePG4
 l/1g==
X-Gm-Message-State: AOJu0YwctBBK1TA73r4fFx2R6GunSQFamZXD27AY4y3Hwc6PeYcWpaqS
 b9MFiHkts8ZY0UIF13Szgeb2QzezT4IF9rLy9zYZMrvEENV2duApjfeUNB3GsQFmeomPuCe5kdD
 paHeM0sc=
X-Gm-Gg: AeBDiesrjLRoR4MQlFhG330yZRQqcUyCljzOYt51l44Jd1hfhpZgDF81F6hOtmXeYYB
 NW8LxFEBQYN86e4+KzHL7rp5SfH9nMZ7QrM5JwXTOkt7foKA6A2Vey1MMyz4UYuXbiW4wSfxfH8
 /2KQjCtFpTN9LUqrVzzbcYyyibm6gck1OiOcrcIFaAFT1PqxpUASZDcIXjubn3Lc6IylufRq3b2
 dkPpZT5kMTirJCMlTD65i94aAVxF78zFIgJkR+T6MQGrgo0Kn1yDGgwkwIHUHlv7V/maG8m1g7n
 2Hc8FEvCzLDkN6wy9t/UqZQQ+PGTUba+Vj0nXhLfp5pO5r7naacNPaIIm7rhWnHH2x5eqI5DUy2
 ePso5vW5K6tXypfO0/DbIrd8n6jD8QjGYZ0mpvtyCs+YSNTuSYW4GOZ+q75Yd1qLM8+6fXOd5Sq
 tn4XjnEbwLueiVTJNayehPFcx3r1H75i42iO8N8Dr2BCiWiNOx6SiN3Wydz/NWqns=
X-Received: by 2002:a17:903:2283:b0:2b0:54dc:63e with SMTP id
 d9443c01a7336-2b5f9fadcd4mr369265105ad.33.1777068863715; 
 Fri, 24 Apr 2026 15:14:23 -0700 (PDT)
Received: from [192.168.10.140] ([180.233.125.15])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fa9ff39csm239650435ad.4.2026.04.24.15.14.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 15:14:22 -0700 (PDT)
Message-ID: <3def1014-3eba-4778-8be7-cfb473a536d0@linaro.org>
Date: Sat, 25 Apr 2026 08:14:18 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] linux-user: Use int64_t in target__kernel_sock_timeval
To: qemu-devel@nongnu.org
References: <20260424091024.23495-1-deller@kernel.org>
 <20260424091024.23495-2-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260424091024.23495-2-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 4/24/26 19:08, Helge Deller wrote:
> From: Helge Deller <deller@gmx.de>
> 
> The Linux kernel uses the __s64 type for the tv_sec and tv_usec members of
> target__kernel_sock_timeval, so prefer the native type here as well.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   linux-user/syscall_defs.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 6967306be4..138ce6abb1 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -238,8 +238,8 @@ struct target_timeval {
>   };
>   
>   struct target__kernel_sock_timeval {
> -    abi_llong tv_sec;
> -    abi_llong tv_usec;
> +    int64_t tv_sec;
> +    int64_t tv_usec;
>   };
>   #endif
>   

Nack. This has target alignment implications.


r~

