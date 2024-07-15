Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D3BC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 09:59:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTIUb-0007yg-ER; Mon, 15 Jul 2024 05:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTIUZ-0007su-MB
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 05:59:35 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTIUX-0000J2-Um
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 05:59:35 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-367a3d1a378so3654702f8f.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 02:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721037571; x=1721642371; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pcaVBXPpmlyTHvYtq2LxI+nkD/SmHzorQzN90/YZHjs=;
 b=YPla4KyU7+D+BuaY9w0Fvu1Oc7Gctt+lGzoeRgLYGfLlFT9XdoefN0DIvhquWcvf0P
 GcEd/fzi8i7FRm3LP25eLlCFuesue/ycEZ+q/A1VQuiP3A8MyJywaDZ8YcP/8cfYdGwD
 7v3C51us061lXfz3NGL7LYgYMD2VJsGCX5DpULsa6UDkdBjCkY22sH2MnHp6+UZGybIq
 yc+BGxMs2Qc+SEk5+iYz3fXWVGuUQWZoZTwwS/raQDR44e6CA0xacecpRtDyGR1m1mmh
 0diFV4oaKo2zEenAv42e2fvGZjTwvf0kcElPtGOSDoAhZPaH0WNKtnU+2PDsYd76RE39
 2e6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721037571; x=1721642371;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pcaVBXPpmlyTHvYtq2LxI+nkD/SmHzorQzN90/YZHjs=;
 b=PNBRGC4nRkLtCjUrEU5JfD84TOmLBVkZlfEXNQ2Af0zY9vYb991jFzM0fBPbUjQha5
 KWIYmFEp7bIKfUWja01yWv65q3xQ6JmzdoSDj5m8bdyB1b6Oy1vLnG/AA2hFBu+NSmdZ
 AMFC7iW8KdoL/2t+VDCEI0QokC3FwHoHC0OlobxyNgEcWftc/rDPrvNlF6I6Ff9wq9QP
 RVHRMJhCob0J+zX4dr4Nh5wXHwHg4aRBSKGHQF/80EvS/NtahQ1urmPRvKj/yESMLKHe
 c+i+8C1/XhdflU8ACAhgRKoAHrGccHBct86ja0vzOGaYJGuihQtEsLnR79xEJFdREBx3
 /MQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5AIFWMVC+jZmKTdMCoMK7duEiLZ8cBlmR04lTN3Y7bpeXJdnsprFeaO+O/l+T/cupGlDVfaDP44Yph2GmvOboUcFxebU=
X-Gm-Message-State: AOJu0YzG6cKxCfCMAREwCGVk9oct/mOTsF/njRER6/ET2pVSANLRF7mG
 ibCfvIcr+XeTCb5AROuSTKrVuvoPiO0odO1f2yZNgYCP/3XR/s4ngyQA4g8GHEU=
X-Google-Smtp-Source: AGHT+IHqF/FfqfscOwMu5LwnE/vYRuUEnewuLdTEeN1trADJsLlNFmbWwxfX0cHNAR646BIljB5Gsg==
X-Received: by 2002:a05:6000:1848:b0:367:890e:838e with SMTP id
 ffacd0b85a97d-367cea96272mr19558253f8f.40.1721037571347; 
 Mon, 15 Jul 2024 02:59:31 -0700 (PDT)
Received: from [192.168.121.175] (91.red-95-127-43.staticip.rima-tde.net.
 [95.127.43.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5ef44a9sm79475865e9.40.2024.07.15.02.59.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 02:59:30 -0700 (PDT)
Message-ID: <1cf2b5cc-0837-4725-bf41-95bffd5a9b80@linaro.org>
Date: Mon, 15 Jul 2024 11:59:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qga/commands-posix: Make ga_wait_child() return boolean
To: Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>
References: <20240715095939.72492-1-zhao1.liu@intel.com>
 <20240715095939.72492-3-zhao1.liu@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240715095939.72492-3-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 15/7/24 11:59, Zhao Liu wrote:
> As the comment in qapi/error, dereferencing @errp requires
> ERRP_GUARD():
> 
> * = Why, when and how to use ERRP_GUARD() =
> *
> * Without ERRP_GUARD(), use of the @errp parameter is restricted:
> * - It must not be dereferenced, because it may be null.
> ...
> * ERRP_GUARD() lifts these restrictions.
> *
> * To use ERRP_GUARD(), add it right at the beginning of the function.
> * @errp can then be used without worrying about the argument being
> * NULL or &error_fatal.
> *
> * Using it when it's not needed is safe, but please avoid cluttering
> * the source with useless code.
> 
> Though currently ga_run_command() only gets &local_err instead of NULL
> @errp, it's still better to follow the requirement to add the
> ERRP_GUARD().
> 
> But as error.h suggested, the best practice for callee is to return
> something to indicate success / failure.
> 
> So make ga_wait_child() return boolean and check the returned boolean in
> ga_run_command() instead of dereferencing @errp, which eliminates the
> need of ERRP_GUARD().

I'd avoid mentioning ERRP_GUARD and just describe:

   Make ga_wait_child() return boolean and check the returned boolean
   in ga_run_command() instead of dereferencing @errp.

For the code change:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Cc: Michael Roth <michael.roth@amd.com>
> Cc: Konstantin Kostiuk <kkostiuk@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   qga/commands-posix.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 7f05996495a2..64bb0be94479 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -59,7 +59,7 @@
>   #endif
>   #endif
>   
> -static void ga_wait_child(pid_t pid, int *status, Error **errp)
> +static bool ga_wait_child(pid_t pid, int *status, Error **errp)
>   {
>       pid_t rpid;
>   
> @@ -70,10 +70,11 @@ static void ga_wait_child(pid_t pid, int *status, Error **errp)
>       if (rpid == -1) {
>           error_setg_errno(errp, errno, "failed to wait for child (pid: %d)",
>                            pid);
> -        return;
> +        return false;
>       }
>   
>       g_assert(rpid == pid);
> +    return true;
>   }
>   
>   static ssize_t ga_pipe_read_str(int fd[2], char **str)
> @@ -178,8 +179,7 @@ static int ga_run_command(const char *argv[], const char *in_str,
>           goto out;
>       }
>   
> -    ga_wait_child(pid, &status, errp);
> -    if (*errp) {
> +    if (!ga_wait_child(pid, &status, errp)) {
>           goto out;
>       }
>   


