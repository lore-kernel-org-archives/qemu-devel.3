Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304F5D3C93F
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 05:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2lEW-0002ng-FP; Mon, 21 Oct 2024 01:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t2lET-0002nF-V6
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 01:45:33 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t2lER-00041O-4J
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 01:45:32 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20c77459558so34272485ad.0
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 22:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729489529; x=1730094329; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NYZoxT+E6u1jL3locsrOgNtgeRn0RF50FeqMGo5k0G8=;
 b=Evi2e7YEvLKbOJ7xAUTR1CnaWOzFJVsNNZ+Jtev2yQw4kpUxOsRR6Bq/p3u9Dk/Iky
 TgAsLYt80t1+QBWK0Zom2DbLY2u9EI96DOBDYXdL6A7fTXbJra2lJV9DPYKYlFkayf2D
 sqqRkc2cRFWRJ4dSCL+40gbrI37t1npMR9IMNoctW/4PkU6CaBGLnYiKJeBaqGZkWzx6
 yJFBIe8wqh8SADx2UD0gtcjpp8JBesCNoMpH2p0Qi6w37yW/BFkqasVaE1Hy6FDt12he
 cjXqseM1ioZeWRFFh5qcZqMiUNRTvzJU78w0jop4jC1ZaOA6xu1P0gjMyCzBwoi5hPcy
 ZYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729489529; x=1730094329;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NYZoxT+E6u1jL3locsrOgNtgeRn0RF50FeqMGo5k0G8=;
 b=EaxnLQclp6MaNFz21if2SEtcu6Z+wV/79VhUrDyJqHIigGy/LgVcstaBJI1KPw4lKe
 v4mSp/qrdoUGaRjcSQZAHzIZU49xoxXHp4/9EqQdNvqVqMTnea8vB1/40Bdh+d0Y0cCx
 u8/rN/QoAmnph2jvKOcuHKxOe996EAGc71aPkDvnRRHz4goLy0BifVKWVXnnToijaqio
 +ygbClmpcHjmYO306qM4AL7Um/inDhERAKuqbikAZNLzHrD41mMW46LEUcYx10ApVibN
 IdSDo2K4toZic/8PnIWzW+CJTz04hJgYoPfA2cabBIoUWbhGohcfISAMRxNe/FDR0MWh
 abFA==
X-Gm-Message-State: AOJu0YzFU+VifdNKRQQb83yvs4xxWCZ1pK1EbZrS7cULzy9dIz8H11kb
 T4ccUpfXhiQL3qkXj8ejSCW2/K2A0LdCvxMLfEBmvVc4FHfbTukY33OaKONjwoE=
X-Google-Smtp-Source: AGHT+IGJC+NDVg+tu5v/qQkEuc3SLpie0p0OHBnn7TiSVcWk6EJjQqRmxDkckyYMGQ74xAG3OaHcbg==
X-Received: by 2002:a17:902:db05:b0:20c:a659:dec1 with SMTP id
 d9443c01a7336-20e5a8a2b05mr141028355ad.29.1729489528959; 
 Sun, 20 Oct 2024 22:45:28 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.171])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0ebb5csm18214555ad.240.2024.10.20.22.45.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Oct 2024 22:45:28 -0700 (PDT)
Message-ID: <4dd04e19-401b-46e7-abcb-67b64a3791bc@linaro.org>
Date: Mon, 21 Oct 2024 02:45:24 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] linux-user/ppc: Fix sigmask endianness issue in
 sigreturn
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20241017125811.447961-1-iii@linux.ibm.com>
 <20241017125811.447961-2-iii@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241017125811.447961-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x630.google.com
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

On 17/10/24 09:54, Ilya Leoshkevich wrote:
> do_setcontext() copies the target sigmask without endianness handling
> and then uses target_to_host_sigset_internal(), which expects a
> byte-swapped one. Use target_to_host_sigset() instead.

These function names are confusing.

> Fixes: bcd4933a23f1 ("linux-user: ppc signal handling")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   linux-user/ppc/signal.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/ppc/signal.c b/linux-user/ppc/signal.c
> index a1d8c0bccc1..24e5a02a782 100644
> --- a/linux-user/ppc/signal.c
> +++ b/linux-user/ppc/signal.c
> @@ -628,7 +628,7 @@ static int do_setcontext(struct target_ucontext *ucp, CPUPPCState *env, int sig)
>       if (!lock_user_struct(VERIFY_READ, mcp, mcp_addr, 1))
>           return 1;
>   
> -    target_to_host_sigset_internal(&blocked, &set);
> +    target_to_host_sigset(&blocked, &set);
>       set_sigmask(&blocked);
>       restore_user_regs(env, mcp, sig);
>   

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


