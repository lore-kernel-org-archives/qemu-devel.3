Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C8ABCD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 17:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZuB0-0000Ia-6t; Wed, 17 Jun 2026 13:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZuAz-0000IQ-Gx
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 13:35:45 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZuAx-0004Pk-Vt
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 13:35:45 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-84347ad88edso4443336b3a.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 10:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781717742; x=1782322542; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=olaRwlh1GX8sW8G1K63YnjNnR7VxdEjNpTxzSB1AE60=;
 b=vH+0Yvc4xfHHNDjyt4yBPFD4SdR1knrNcH6llE1CUoP3BjmKzvTm+LyCVDHtkO/xQn
 9pAOLmdtVaLNSloGel8MaCyNyoEHWTiYi5Lkf9n/WwKrwrus5hJXVVb2rp8tMRxx/2WN
 qeXbkiUknsmHoJZl6i5FkifMsqZqTMvf47g4tlM6gMilX1N2JeBwVqZnQT5jUm7yhLk2
 9pwTznuxJ4TB0VvB/EiMqBtHY0jPXw7TSq4jIzxO55vDWFDMvBV5BL7tnGE8egxWDGPp
 7HeMMVPx3X2vGMzhnpzQW6w+3dBAFG8WZYKdhHwEeTCxvdtiTkx8nCO9/mTTbCBvYkPv
 IjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781717742; x=1782322542;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=olaRwlh1GX8sW8G1K63YnjNnR7VxdEjNpTxzSB1AE60=;
 b=K+CoZZNrQ3YUEsNyIUx/4oNy+lzzVHjJZfAibQeTkRvI37s0/sXt7MMpSZBMoT8yge
 21DVDpE6R3CP/wA7u8BLvkmOQpufmxWOTuphfqVLhU7x7Iek9vLspTSiPVrd99EaK25c
 ru1q0BcXYIrNk3ZghwdLl2OlsYHDty4oCJS5kV24yY5Q0Ii31f7nGmwvhPTtHPN+x2Gf
 gqY+FbpT+VjkWRrB8yIFXcReGqOeKXnqVKQWCh9dRoO6ntmtCeiJOVl9EAOkzMLQtby+
 ssZKvhYZyKzV7lJT0KPdJQjvTUmF/fIpm42ZCOCW19dI9/dK/uEbc8SO5j7BuLrxOVUB
 y81w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+8YITG65J0kWic/9c8qCP57NQzdciQVHaFdJayIL7shcIlEVeOelkErtynf8+I81x7oC/gE98zM7EY@nongnu.org
X-Gm-Message-State: AOJu0YwDIkr+0IfswRLLK8hN1+vYMdzFjEFjKoyun2Nzulu27ChmXJg6
 6551DSaE4zZhLc8tZyx67oN83YDZxqk4IRg18tsfvWVFedX+Qyw2VuEexN6a7lYoM/g=
X-Gm-Gg: Acq92OFaWySmfdij+XyzZeljnooIU1h3LAN9oEqMuoAV8EPmBe6qWTCtpPM+sjRbIPm
 EErWEETO2qKrxSq2JSPoTh047S2kMHwloken0WB0+1QVFMJNh7XHUcO3cIdf9NNTYyDr3IyHD8a
 RfJJawt9pMuGvcE+p+jf+R5VwuTGuo7wvtwEy2KkSsHwRYEJDUeQm9ze/UE/lGsGmfkW4NJ7JjJ
 jciX1MJqkQ7R/Hq3cq0GqFPhuny+I0d+7WORY6qwQWqWQD5GmC1hofmu7l3pxzO6wV8ZSUvwLsV
 s8Rmw9UfaKU0RwvQWIpU3AqTBxtAooeTbDL4C+ojskKApk8bXUSecjAG/28x97GV6FN+Xzaipoa
 anamrON/HSDOONz2yvwp5KD85Ril8CNpdPM+J14nypXNr7bJ1e6/tFGqEKOZI72eSfGLkE7j+rS
 sx9gBw0fL5MhVXadqRKiLqic2g/Mo5WXSKdxORl720zLn6+730ACeBB2B88g==
X-Received: by 2002:a05:6a00:3d4b:b0:842:80c5:c425 with SMTP id
 d2e1a72fcca58-84524569afemr5190307b3a.35.1781717742085; 
 Wed, 17 Jun 2026 10:35:42 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434acca7ecsm17151995b3a.13.2026.06.17.10.35.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 10:35:41 -0700 (PDT)
Message-ID: <6a92e439-f571-4ec2-a390-ef4368c7ae0b@linaro.org>
Date: Wed, 17 Jun 2026 10:35:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/11] accel/tcg: Have cpu_loop_exit_requested() take
 const @cpu argument
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20260617171438.75914-1-philmd@oss.qualcomm.com>
 <20260617171438.75914-9-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260617171438.75914-9-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 6/17/26 10:14, Philippe Mathieu-Daudé wrote:
> Since the CPUState argument is simply read-only accessed, make it const.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   include/exec/cpu-common.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 3757ab15967..9919ffb1838 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -76,7 +76,7 @@ void list_cpus(void);
>    * call can be used to check if it makes sense to return to the main loop
>    * or to continue executing the interruptible instruction.
>    */
> -static inline bool cpu_loop_exit_requested(CPUState *cpu)
> +static inline bool cpu_loop_exit_requested(const CPUState *cpu)
>   {
>       return (int32_t)qatomic_read(&cpu->neg.icount_decr.u32) < 0;
>   }
> -- 2.53.0

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

