Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDA2CD37AA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 18:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slY6W-0007LY-9Y; Tue, 03 Sep 2024 14:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1slY6U-0007L2-Dk
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 14:18:10 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1slY6S-0001wZ-Hl
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 14:18:10 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7d4f8a1626cso486663a12.3
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 11:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725387487; x=1725992287; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7OjYGljhmdm5zqLgU5viOKQnBhqt6G43Kg3e8DJKOzE=;
 b=qDS9eLcp11TD0+QbRqN3W1MvRwZZibe9y/OX6QQhrwh/I065pcLNmJdft0YNLPNewa
 cVp+TNnRr635Kj3SKB4BQ5gPL5dDD86QKU3/B3M0EfPGEysPD99scv+WVInnpwFfe9+3
 znZkJ+P+WZy+4+LtLAp4SDt0S0N4MFGjvJukuNVMyvMwDN2cmfXVABdDrVUfVEEUpV0s
 Q1oA8TTEUdha0SDlw2UM7a7Hm+ny973OQ0ImGceyn21+6Q5roSwYo3YNeWc14r3rj2gK
 JPn2ychHDlS2wKSq7jKaeH3eB3ObnjutNxFxKh/ylXir8xQCKuEJi063rnZzV7G7y3S6
 G2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725387487; x=1725992287;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7OjYGljhmdm5zqLgU5viOKQnBhqt6G43Kg3e8DJKOzE=;
 b=DLLDGlgd3XAazAfifFbW9F3U98xhID9REzH1sBrhJaxuIfwjl+aWsijvCY0iLgzgc6
 t6dAGz8eJ2t7zgbmHBrUELJX3WSWq4ooDJDnN2lH6DtPBks7fPNYZQH9I4ofTBADSsUN
 vqyi60dZ30U4uidx45QH9cMWm4qz2H5rZYa+t3vs+DtkazPKzMyqHva43Ssz1cigOd+q
 ZAidyPovhnU8+YS7IzFO+7IAMqqVp7tlQSQEH2DePZjNHq94Y+jO85XFlG0gsevfxbE3
 EDG1chZIF2v9WOTbi0CFPonfjnShip3ui5xvzt4ifHImC26LdhJoQoQgi7sRSgBPVULs
 kHfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbt1ajVetJdc0yKn+eTrZh6F8UpqqDLsFtpDakseeefLpuVisbK/7Kplu/H0g+aW1E4QG4YVnOKusC@nongnu.org
X-Gm-Message-State: AOJu0YwEVTifI9icgmFwIuXCLcAxrSPDx6bHJIIS1XV53SEHYEyPLNy/
 4pEEd2WWYPyY6X6fYzBmRxLtHa0tWCerdBJYcW3zyXo7y8MQ5me1XnK5D5qGokw=
X-Google-Smtp-Source: AGHT+IE4dVwJJ7TspXl1F8qLtUhbOobgad9TpbJiXV+ZyZLlzKBLXHFut6Sok8jhDi8114TlyjhdVA==
X-Received: by 2002:a17:90a:fb48:b0:2cf:c9df:4cc8 with SMTP id
 98e67ed59e1d1-2d88e6f3aa2mr12743376a91.38.1725387486632; 
 Tue, 03 Sep 2024 11:18:06 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d8a5324db0sm6946551a91.56.2024.09.03.11.18.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 11:18:06 -0700 (PDT)
Message-ID: <c5cc5902-dd23-46df-9c1f-b22d7625b926@linaro.org>
Date: Tue, 3 Sep 2024 11:18:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hppa: Fix PSW V-bit packaging in cpu_hppa_get for
 hppa64
To: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: linux-parisc@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
References: <Ztbk0Vk35dDGLoCd@p100>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <Ztbk0Vk35dDGLoCd@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 9/3/24 03:28, Helge Deller wrote:
> While adding hppa64 support, the psw_v variable got extended from 32 to 64
> bits.  So, when packaging the PSW-V bit from the psw_v variable for interrupt
> processing, check bit 31 instead the 63th (sign) bit.
> 
> This fixes a hard to find Linux kernel boot issue where the loss of the PSW-V
> bit due to an ITLB interruption in the middle of a series of ds/addc
> instructions (from the divU milicode library) generated the wrong division
> result and thus triggered a Linux kernel crash.
> 
> Link: https://lore.kernel.org/lkml/718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net/
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Helge Deller <deller@gmx.de>
> Fixes: 931adff31478 ("target/hppa: Update cpu_hppa_get/put_psw for hppa64")
> 
> diff --git a/target/hppa/helper.c b/target/hppa/helper.c
> index b79ddd8184..d4b1a3cd5a 100644
> --- a/target/hppa/helper.c
> +++ b/target/hppa/helper.c
> @@ -53,7 +53,7 @@ target_ulong cpu_hppa_get_psw(CPUHPPAState *env)
>       }
>   
>       psw |= env->psw_n * PSW_N;
> -    psw |= (env->psw_v < 0) * PSW_V;
> +    psw |= ((env->psw_v >> 31) & 1) * PSW_V;
>       psw |= env->psw | env->psw_xb;
>   
>       return psw;

While this is correct, we should also update cpu.h:

-    target_long psw_v;       /* in most significant bit */
+    target_long psw_v;       /* in bit 31 */

With that,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


