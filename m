Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63191C982DA
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 22:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8Phd-0006bg-Mg; Sun, 20 Sep 2026 18:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x8PhL-0006YB-Gl
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 18:07:50 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x8PhK-0002HL-1g
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 18:07:47 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc50bcf87b2so1408273a12.1
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2026 15:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789942064; x=1790546864; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qajgS6QE9nYKZojJ7+7HA/0beX+XyFrCIXTsf/nXUII=;
 b=UAVf03I3C5gPuV/LT82PvUFuPGiF4+JhOinYrMuHDcV3bqC2q7anye2NV4z62fDn8a
 /BSXhnNgsv/nRlBt40ZgJMnWiqJVBess1rYrYi9Cgmj3w2OYWdOIUMwsgTkXBYpTJhfQ
 To8oWdrNobmi00eumt2/NexyHxdMsFn1otfi5SlgB+aZueTZHZLr3PWTQJnC+/p/jgX4
 kXvMk2/c92VSb5ENb3zKwAUGINa5Ni4eXgQRNBBA74P6uv0h1SdQt+zhI2vbfqsoM/bK
 I8XS7cwQbZ5WxpPLraOsqFzOrJqQ2t0Wuj8E0zvnUvX+6MaMAql0BmWmZNM5pQZccgFW
 NNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789942064; x=1790546864;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qajgS6QE9nYKZojJ7+7HA/0beX+XyFrCIXTsf/nXUII=;
 b=lmeG5zBGT0dZos8TVRN/Lme38K0M4CklfzjB+48ss68aOY+G7rwjaiB9/KKHYBlBJg
 GOnSURIE+4n7MGEkS3g7T8kPfLwe0HMTqg0Xhc9JxwaVP6arUHVQBuKfTvhSQyD7ueNJ
 +UEaZfJBsG8jxMv49VJl46BkoEvIh9HEN3kC8a27FhBWzdP5l8Y8Azcm7pxKM4oDZmt+
 jBWuigVgN3bA5R6DbLWXzQlPNPGHbdxz+ceZ5AIJROL7GVHsep9gkKgY8VTQx/5rlvlc
 ASIVj8XREjA1Db4eYSZJguOxTVLqFmafCswJW2UKoPKZewJRb4ntK4hBkzq8vLP4z6R2
 bi4w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxQrQNzp2rKkB/6nsqQSqVtxVZsOzp5a5hSHj/NyVA+oqw0OYEgqF6ikFxfgHXKeRhOHeW7Yupf97bx@nongnu.org
X-Gm-Message-State: AFuF++lCKLEmZW/rDuRz9uZ7i/pSW7F6UtaetGJpsfIUhQb9ZyEIQQbk
 diGoIgNOm4O93FDa+PBT+brloRrQRG+aqApaZtxZuttoXz/UBAVZDS0iiLBXKbX4XlM=
X-Gm-Gg: AYBFou194+4c6SLmP4YLxyVfBrgsBMLj1hRQqDac4gWHR4ReJ7VpGnv6tpKmZ/dKJLU
 7p6e0UN6atKVgB29jQiOWTL91ATaRVXs7GQUbb0u/GFXMXsPJMwa6OcIMC+N12rJLZt6yRWvdAW
 HNmmjovk+WcUPuN4kX8ldFmxGj+OOXrdr9NstvDoHZbhE57vfLeU6lANfwoQP3Mi2Re6oQqPmjB
 RP4V/3tv7sCNuuF+NaBEbcVFW/GogTHs20acAJXgpTcfJpxhurcVaKF9Hns4X8QKbPeJI6imL0x
 9leuStKT4dCwcC19Ds9DS4vEwFgxi/Eisqm03UyuVqH3CXuymKaF7La0iwJkVS4DQK/1ProSFG8
 XTQGGbR1lY2FRBFh1OJNI+gje2Alel1AnqqL6TExbBx/XH2UlPwi7E0HuFK4+5fLYCInPtlMNYS
 P05hv43G4E/xMDCpoVe/e554ARUwel9JRP/FPZhUKhCiy+GZ7dZRSCsPG+mciIxl36ZH9JikoU6
 YPp/f9E2lPisyAZt1iTfk/B/BWdsF4eT96Ex2sWbJnP3hVPr4J4G2S1vLUUpA==
X-Received: by 2002:a05:6a20:e212:b0:3dd:a196:30a6 with SMTP id
 adf61e73a8af0-3dda19633dcmr8076642637.86.1789942064260; 
 Sun, 20 Sep 2026 15:07:44 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:5f56:e854:5df2:d786?
 ([2603:800c:7900:ed00:5f56:e854:5df2:d786])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144d55f299fsm26621657c88.15.2026.09.20.15.07.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2026 15:07:43 -0700 (PDT)
Message-ID: <b4bc976a-dafa-466e-bbf5-a9fde46c8f91@linaro.org>
Date: Sun, 20 Sep 2026 12:07:41 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] bsd-user: Initialize per-arch child registers
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>
References: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
 <20260919-misc-2025q4-v1-5-ebfa61049bd7@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260919-misc-2025q4-v1-5-ebfa61049bd7@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/19/26 19:20, Warner Losh wrote:
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/freebsd/os-thread.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/bsd-user/freebsd/os-thread.c b/bsd-user/freebsd/os-thread.c
> index 15872f03fd..eaab062d3d 100644
> --- a/bsd-user/freebsd/os-thread.c
> +++ b/bsd-user/freebsd/os-thread.c
> @@ -1629,6 +1629,9 @@ abi_long do_freebsd_thr_new(CPUArchState *env,
>   
>       new_env = cpu_copy(env);
>   
> +    /* Init regs that differ from the parent. */
> +    target_cpu_clone_regs(new_env, 0);
> +
>       new_cpu = env_cpu(new_env);
>       new_cpu->opaque = ts;
>       ts->bprm = parent_ts->bprm;
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

