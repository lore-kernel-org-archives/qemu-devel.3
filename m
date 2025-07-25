Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC6FC87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 16:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufLSd-00072h-UF; Fri, 25 Jul 2025 12:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufLSY-0006n3-PZ
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 12:39:50 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufLSW-0006K5-NJ
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 12:39:50 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-235a3dd4f0dso15191645ad.0
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 09:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753461587; x=1754066387; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JfjDVeNjaULSh7UaTSUhYvK9n1gRTeU1CePdo/RNE6k=;
 b=lNyLql6y8AZtaZ9sH8qIorCi0y0mlgsEG8fm8N/3TFphNfioUhvgqg5a40jLOZSr6F
 xMkx79dRPDQBor3lBUMPni7dg0djqoVKbflmhY/+moBvRlQYsFKu52qBLOK9tDAwooVK
 BeQKpJNd6RD1BC7WWZDI6X6yUh1mnYb7GxTDwh7D5O2U5oEoyc/kyU34BPT3zJ4FrPTo
 /2cfxQLyCtL4ee1sZAXwIyvD2C7dM6cQgY6MzCKWTwtrNDTzRy+hVDddgfWEO8yeuIXZ
 k+xnkUXr8pWwgTIkB59X9QEhdfKfWzDaVUUq9a+PglfNKtdQIs9tm3NPFCVy/xLjgyyq
 M1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753461587; x=1754066387;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JfjDVeNjaULSh7UaTSUhYvK9n1gRTeU1CePdo/RNE6k=;
 b=WY+BofXlUGZ9nNgP3RZpHiO40P2/McPobSPcZiyx0k0gTfNrzhcoQ0L6uMpsw70WhK
 0KJsSKPoAd7T3dCPVdxqjodzAHS074ibra278DSOzsh6doakP8KPcovgdgWWhiPcsk0o
 bndQx/0aJit3Ji0rtdfiIyJXJ8bXgW6M9q7n7fV0Ms8RTXQJD2RFMfwp7Eyq2VvWc32T
 O8FMGd3ojPI80tSisg8BkJPVPr1wkkPjgSBlA6cZEOhll1E+IVjI7TnBQSTkUIoyTRLU
 KddY2Td9MISpJLC8nE66F8M52DbTMUkXWtYQZNZXxTuo/Ko7Pya/3rHSlVFIeIJoZwpp
 IW2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBNvu1Z/DzYLE7Ee9AWwhw59bUvWhm2eis/Xa6EhYvbi9GMWtY6kzTjnBxQKnRPRgm2J+D7IsNOMps@nongnu.org
X-Gm-Message-State: AOJu0YyIrOxt839BYaG4EgNsOi+06Ki/aty9BkEYXiRLBm8ArOJLGs6D
 EB+50RW2Ods7xrqlhTRkhRFfrf0OXFBDez15oinhrmDJuFRJobqlStNZ/gd1JeHYNn7eDP6TQmM
 TFqJX
X-Gm-Gg: ASbGncsp+2FSqbH9GVke/ameCh5j30gA0aKdjHybvaqDzBrnU3K9k+McAhL3G5RC7E8
 5JC5w1+rVOylXB4ZtDBpyzg/XdgjyXiBWkoe0mbePxYh1ZoiEtj6i1+g1jk/CyZpHqAIx7ksxeX
 6Sgva1QF5hni+Am0aCuRVIj0qO2GNpYYSorfbZ2bxT+7eN7Y9e3YC+4Ny8gYbbAvEKDzh57tXOh
 yevCNuWrCz9CLrZ5s79aVMl9+3uwGjVMQpDQEliFGKBmFcYzo1WVHFq67ZPSgxlBPYMJhBzwYQJ
 4D9B8FYAuDHlLfTOeweTr2XeBzkz1hhmzDsXzZSjniZh7qdWmfGrv0KB5BhSQliCDg1n8Md+JPT
 VJ6cbHs8/AFnlPyyPcTcjDSfCOa/P22MiWRIYz81vmm0I4ugj6whLCwXB1INe1YmK6BOldQoXXL
 mhEQ==
X-Google-Smtp-Source: AGHT+IF8epbljUDDAhCzwvD6lTp0HeEtnOANzt/L9WHDaQXhB+zPQ7cQ7KYo4K5Iu2OBgyKLxMZzLg==
X-Received: by 2002:a17:902:f711:b0:23c:8f13:1381 with SMTP id
 d9443c01a7336-23fb3041006mr37388005ad.19.1753461586865; 
 Fri, 25 Jul 2025 09:39:46 -0700 (PDT)
Received: from [192.168.4.112] (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe4fc732sm986735ad.90.2025.07.25.09.39.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 09:39:46 -0700 (PDT)
Message-ID: <f747d280-6d43-4672-9ebe-14151c852cdb@linaro.org>
Date: Fri, 25 Jul 2025 06:39:43 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 2/3] linux-user/aarch64: Support TPIDR2_MAGIC
 signal frame record
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20250725142240.3760452-1-peter.maydell@linaro.org>
 <20250725142240.3760452-3-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250725142240.3760452-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/25/25 04:22, Peter Maydell wrote:
> FEAT_SME adds the TPIDR2 userspace-accessible system register, which
> is used as part of the procedure calling standard's lazy saving
> scheme for the ZA registers:
>   https://github.com/ARM-software/abi-aa/blob/main/aapcs64/aapcs64.rst#66the-za-lazy-saving-scheme
> 
> The Linux kernel has a signal frame record for saving
> and restoring this value when calling signal handlers, but
> we forgot to implement this. The result is that code which
> tries to unwind an exception out of a signal handler will
> not work correctly.
> 
> Add support for the missing record.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 78011586b90d1 ("target/arm: Enable SME for user-only")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   linux-user/aarch64/signal.c | 46 +++++++++++++++++++++++++++++++++++--
>   1 file changed, 44 insertions(+), 2 deletions(-)

Oh my.  I spent yesterday working on this and other signal handling fixes.  Though from a 
FEAT_GCS starting point, so I still hadn't seen the clear tpidr2 on signal delivery change.


> +static void target_setup_tpidr2_record(struct target_tpidr2_context *tpidr2,
> +                                       CPUARMState *env, int size)
> +{
> +    __put_user(TARGET_TPIDR2_MAGIC, &tpidr2->head.magic);
> +    __put_user(sizeof(struct target_tpidr2_context), &tpidr2->head.size);
> +    __put_user(env->cp15.tpidr2_el0, &tpidr2->tpidr2);
> +}

Drop the unused size argument.

> +static bool target_restore_tpidr2_record(CPUARMState *env,
> +                                         struct target_tpidr2_context *tpidr2)
> +{
> +    if (!cpu_isar_feature(aa64_sme, env_archcpu(env))) {
> +        return false;
> +    }
> +    __get_user(env->cp15.tpidr2_el0, &tpidr2->tpidr2);
> +    return true;
> +}

The sme check is better placed in target_restore_sigframe ...

> +        case TARGET_TPIDR2_MAGIC:
> +            if (tpidr2 || size != sizeof(struct target_tpidr2_context)) {
> +                goto err;
> +            }

... here.  Then target_restore_tpidr2_record has no failure modes and can return void ...

> @@ -497,6 +530,9 @@ static int target_restore_sigframe(CPUARMState *env,
>       if (za && !target_restore_za_record(env, za, za_size, &svcr)) {
>           goto err;
>       }
> +    if (tpidr2 && !target_restore_tpidr2_record(env, tpidr2)) {
> +        goto err;
> +    }

... which simplifies this.


r~

