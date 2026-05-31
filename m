Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A1ECD6E55
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 21:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTntV-0000vI-F7; Sun, 31 May 2026 17:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTntT-0000sb-IG
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:40:27 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTntR-0006YY-VZ
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:40:27 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-490a7a34493so4391515e9.0
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 14:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780263624; x=1780868424; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vY8e8LFZmtieVlg0sM6NR5U1wF+PPnwi7ROkOdCQcbI=;
 b=TQCW3P4U5GrxIf9qatxHhN/AsCnVCp2NERFZyZYatmG2hU/VkK+d5ZK1F30aOSB4f7
 IPNQ+KDJBHZZ0t7q5GOgVqRCcBpP1UbXsNWn5fBOGfS7AluCEbNoSD/RldDoEEcVkksB
 1wKD8rBDfnKlxLtC2PJT16iZGi6EZip6ugPOYVZEMEVsmxyMTSlcdDliVMHmGiJtMYqf
 4e1QK0gCGLZyO67gpizpOBpvk3rI8deU5Jl6AQ2XA+lGUpYTL0F82KYrWLv+or5PRljH
 0waSbczGlV0xYW3hubEb9CjUEF0t9oIgPxPcuNGhxKkSG2BLfK77iI/b9Dldov+66odP
 O9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780263624; x=1780868424;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vY8e8LFZmtieVlg0sM6NR5U1wF+PPnwi7ROkOdCQcbI=;
 b=hHUasicRv6TqGQC/oEicH0GlSu3OkEgd/Kex8CAOiDvw/4jQAMWNhmLa6MyxbY1Mnx
 NBzBC3Vvtd/JJaVcnP5pDeWfZNfVRc2o6j6SR5VKmUIhI2aSAs2Y1GsF97l7ReDWuDiz
 7ej/YqyRuD0MJvuPAz1/FTVVZtmTEL2urtjYec8lv+tBRoSpZqhDiuBGlw/7oseeJWPM
 NOnssQ/qEdl2cEAJ4XFBcwmID4c/iB6/QTpF/xhG7AFUDWagV9pgjALbyuI4pncKx5t1
 M4nS6ovVggjmJkQc/E/qtT6prL34fxLe4W+ht7Px3DyXiSVZ3HDC2CTYYkfFoigXWbCD
 XNeQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9rENCqitQhGzFK91FADdkyWgF4zh6HZs2+W24caZ7/LScu3qnmUV6Smwcw6o6nKSfftiuKQfBvC2hO@nongnu.org
X-Gm-Message-State: AOJu0YwSK3Ev0+5YvxnV0nXmGam2C4/hrELjW4tdhh8g/0G53d23sacW
 s/MbtEhh/n+QFEdcV0VO7ckiqmVG6lI/1YKSeZRPp3CBTPsCH+v/E9AtyGUwiHn7Nfs=
X-Gm-Gg: Acq92OFAo6YIBOGa77Q0X6JtK5Iqrey+jgbT5FUKPO8+MhtQZK7NwAx33Du18txNIXw
 ZAJFtps2zKFgbP0DuyJJymv5G1QaxDycdSPErywF/YG5b+OBDhvcgonY62A62HO8Y0cXgzzn3k0
 bH66LkkIvMAMVBdJpHz30GAqnZb/mKO6y4HW/+L/7lWpgeNzLijk3gjryqyOUbSN9AAFQenit+N
 jemSZCW0aoR7BePHW9ECfp0BhY5uk/HagpaMXgbdM/iI6/6n5wKVzzIlFcevOx09o4qV+5rjgoG
 vzSnu6awLwNSfJM+kgxHrl+AGea7ddCYFHmTVbj1Vq3uW857BRVRov3CVEStkUnCmRlWstoPLwk
 AKsckPgkDMDnzIVp+XktgnDgIWDMujI51b51x18WtGwAFM1EBRWquJKRZiTOg9Q6zqmZS7A1bhv
 32YLgu/cLRikmWsTAHfl0YS3vhQz/GMsQc8S/mPlliq8HrshMH6XvohmM39TFnwHrjjyZvFNmeh
 s35zLjwtJD+SGs=
X-Received: by 2002:a05:600c:1387:b0:490:3cf0:8d81 with SMTP id
 5b1f17b1804b1-490a2a4e8ebmr108891275e9.13.1780263624072; 
 Sun, 31 May 2026 14:40:24 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d7002e8sm224393425e9.15.2026.05.31.14.40.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2026 14:40:23 -0700 (PDT)
Message-ID: <b5cf1580-4d2e-4532-ba19-7c4a0c3c5c8e@linaro.org>
Date: Sun, 31 May 2026 23:40:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 32/38] target/hexagon: Add pcycle setting functionality
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 ltaylorsimpson@gmail.com
References: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
 <20260529215554.606133-33-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260529215554.606133-33-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 29/5/26 23:55, Brian Cain wrote:
> Replace pcycle set stubs with real implementations that
> distribute cycle count changes across all active threads.
> 
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/cpu_helper.c | 43 ++++++++++++++++++++++++++++++++++---
>   1 file changed, 40 insertions(+), 3 deletions(-)
> 
> diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c
> index bb991a671e8..64c5746c6d9 100644
> --- a/target/hexagon/cpu_helper.c
> +++ b/target/hexagon/cpu_helper.c


>   void hexagon_set_sys_pcycle_count(CPUHexagonState *env, uint64_t val)
>   {
> -    g_assert_not_reached();
> +    CPUState *cs;
> +    uint64_t total;
> +    int num_threads;
> +    int64_t delta, per_thread, remainder;
> +
> +    g_assert(bql_locked());
> +    total = hexagon_get_sys_pcycle_count(env);
> +
> +    /* Count active threads */
> +    num_threads = 0;
> +    CPU_FOREACH(cs) {

Not an issue as of today, but this won't scale in heterogeneous setup.

I suppose we'd need some cluster concept here:

        CPUClusterState *cluster = cpu_get_cluster(cs);
        CPU_CLUSTER_FOREACH(cluster, cs) {

> +        num_threads++;
> +    }
> +    g_assert(num_threads > 0);
> +
> +    /*
> +     * Distribute the delta evenly across all threads.
> +     * Any remainder goes to the calling thread.
> +     */
> +    delta = (int64_t)(val - total);
> +    per_thread = delta / num_threads;
> +    remainder = delta - per_thread * num_threads;
> +
> +    CPU_FOREACH(cs) {

CPU_FOREACH's @cs variable declaration overrides the other one
declared in prologue.

> +        CPUHexagonState *thread_env = cpu_env(cs);
> +        thread_env->t_cycle_count += per_thread;
> +    }
> +    env->t_cycle_count += remainder;
>   }
>   
>   static void hexagon_resume_thread(CPUHexagonState *env)


