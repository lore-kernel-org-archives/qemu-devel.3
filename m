Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E30ACA6017
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 09:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFTJh-0001dK-6S; Sat, 10 Oct 2026 05:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xFTJg-0001d7-6b
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 05:24:32 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xFTJe-0004n6-Hl
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 05:24:31 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a022fee0caso816445e9.1
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2026 02:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791624268; x=1792229068; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mkc/2aQr7URuaOwgydZF8XmeAUluTJIkkZof9aLAhRw=;
 b=lnqh1gx+t/JEvVHuaIfpnni5AB9w8xztkokdadxyv+C1nNQGDd1rHwaxf0OQd/JX0c
 UL1bdZmxQVSPXHYqkJPNIroDe3KWIQ09AQvk+XqQ6rwKrLi1hb813IhbbPz4ksz6QjQ8
 NIa5uu67SHXTVWh2OgxeYN8SBnUKwaaUZ1HW+5HyaSxdPYVsDSqiOT4VaqhY7NVLNH6S
 OsaI6tSeuEIwVetz9+9H7W8pMwYoIUx6uEQYbQd7PD0XbWloDuC5HUYsSY5V7Wfqk1Sp
 GwxHXddd0skzPO6DCIv0BXun1lD4GwcmpxgAY7p1G30vqFddP9NnM3a7hN9lG6F+rvI4
 5IRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791624268; x=1792229068;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mkc/2aQr7URuaOwgydZF8XmeAUluTJIkkZof9aLAhRw=;
 b=c/9nKo3ssDsYc85K7aP7K27bGL2IRj0cxj91ab7w7wqw33hgHz+GvKlSBZpt9T4pUy
 mUH4+uhRVVrIIgQ/NE3sku4zIVdT2CP2tU8YJe9otre0SqiBBPesZGOgy+AchaE1feZi
 e1/2YISwuF7IQWdlEoyuZijBEsoBcSsTgl8f71fylh8mOZNfUbKaUiVfo0Pzwu2JnQjn
 6nHRsOq7FW8PIxpfgZC08qQ+351dxDIWYppOyrT7YQoVHkpg8hsdD/7zjbKuk4NCFFem
 Tmo8l2RCvs2630X8tBlE46bopCxzWn90Bjet1w/81Q5QYgYFugdYiIRyzEVJJTzjbvob
 bRbg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzDuMs223IdFNtlz2NCTxCbnUpAzSu0ylZIOXsX/DQvDrUAqvdzbMrN7n/iLf3PJ0rXLiGHLOTta6rp@nongnu.org
X-Gm-Message-State: AFq9FYKw3XmHJKRrgOR983jcUCnFB6rawQ6u/gOSe2o23VxKmwUuNVkc
 aVNhypApsN39yG88sOGGW7tlOVzQoojIzpOCjiKGNqhe2eFHfrhzj3wfmyR5/Y/vo5A=
X-Gm-Gg: AYBFou3fTVQg1B38Yi2nxgLTx/4mP53pN6m+6fCfeaOxcjGN8+OkygFMdvK2sWlFkvo
 QFPlbG6s/QXKVmco6+5K3bVqD2G4fpIwWRETSGQvSWCLb0q7daHPJwyUPPp8KjTG9i8hKmdsZKl
 vR2yHiiUPCsdPAhe14OEZN/AIsRuSF+p5VSp8qRkN4UJ4ScrpWwcsO2F1QhfsGl/pDUVptLOVCD
 w+zUQB+BWWrh2EDHo4+2y24gb9LmtXT2opeumD9yuBrFLScHcoT3g/tqgw/UROVoPDTjay3jzmx
 uH1SLEVTU4L0j1dgJYYj9JEY751cy40fQbqAABD6aDaoZvbmR5Kh6xclnZPe8XR960cGJCtlY9r
 0nbNwXH34OEJS2dRsyDhhZWckKglwKMCNb8d6Qu/r/l3mYCXXo6PGH340b3xfPPGBAgTD7872og
 FHyHMT3UuLLqX6WdBsM4mqxL7UoWvOfGsc6KN4IK3gkBnN3Nj+i2tjx3FJSU6DvYJYxOmUho0kK
 5OZ0ecYk6PbowfXvPRnmDoSbjftUUVlS9fDfD5uF65T5NaX7elYSMg=
X-Received: by 2002:a05:600c:c104:b0:4a1:96cd:2f67 with SMTP id
 5b1f17b1804b1-4a196cd3240mr7697885e9.4.1791624268037; 
 Sat, 10 Oct 2026 02:24:28 -0700 (PDT)
Received: from ?IPV6:2a00:1e:e082:2901:1896:21cc:25f1:819c?
 ([2a00:1e:e082:2901:1896:21cc:25f1:819c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bea0f1csm186330825e9.9.2026.10.10.02.24.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Oct 2026 02:24:27 -0700 (PDT)
Message-ID: <22222b65-2093-4501-baf4-e5644c8e4018@linaro.org>
Date: Sat, 10 Oct 2026 11:24:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: don't print core dump message by default
To: Andreas Schwab <schwab@suse.de>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <mvmzews2zze.fsf@suse.de>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <mvmzews2zze.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
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

On 10/5/26 12:39, Andreas Schwab wrote:
> When the target binary is killed by a signal with core dump print a
> message to the guest_errors log instead of stderr.  This avoids breaking
> various testsuites due to the extra output produced by the emulation.
> 
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>   linux-user/signal.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index f0a22577e5..cabcc2bb28 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -839,8 +839,8 @@ void dump_core_and_abort(CPUArchState *env, int target_sig)
>           getrlimit(RLIMIT_CORE, &nodump);
>           nodump.rlim_cur=0;
>           setrlimit(RLIMIT_CORE, &nodump);
> -        (void) fprintf(stderr, "qemu: uncaught target signal %d (%s) - %s\n",
> -            target_sig, strsignal(host_sig), "core dumped" );
> +        qemu_log_mask(LOG_GUEST_ERROR, "qemu: uncaught target signal %d (%s) - %s\n",
> +                      target_sig, strsignal(host_sig), "core dumped" );
>       }
>   
>       preexit_cleanup(env, 128 + target_sig);

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

