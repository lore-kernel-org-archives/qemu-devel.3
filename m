Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E191C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 20:58:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tspd7-0000cy-FI; Thu, 13 Mar 2025 16:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tspcz-0000XW-I0
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 16:58:06 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tspcx-0005rb-1C
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 16:58:05 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2241053582dso36500385ad.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 13:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741899480; x=1742504280; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Rux/j9y0dA/cg2WzMUPU0Y7mMMoh1QKJ85C+nPSOzyk=;
 b=J6f8m8ygDbiSavrX8Xo6AXEIF+M01SGuaI1Dbf8jLYzrN//HVDLTDMrPxazvgzgXr2
 VeL2TH1LAf3nHJK4/tRuVqk+kadZl80vOjWQTBkv1nqZXBBwMo8UlP0xyEkDl5AjzOk2
 S2Hfh7/QCHoYE8bwW4x3vjea0MNGrbf7CI1ifr9W55M99ULos+2bOGlZ6Rkui9whYdxz
 +s8rSgSsFskUOIzvhKKehvJnZSODpGBxsJ2mk6mTGnKmfEnenPWmTGAQFsUzZJYQnB6y
 oMkBgjKct1AmHUYLYMP2RVnjCReiVfLxUVPyRKTgyTCUJNenXaNDtL8E5LNig1MC7fWH
 +c5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741899480; x=1742504280;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rux/j9y0dA/cg2WzMUPU0Y7mMMoh1QKJ85C+nPSOzyk=;
 b=YkDRmU9ki9H1e98A9B7nnYnvgIvmSJsca7P2QnKZokRiGMyRcsDVTktNX18WAepuWn
 ueTjzq2Kg/NM9mRsO8Ytq+DcYJbAGMlP6HHU8COSLQdyKXFJl90OIiubrBJbhhbM/Tun
 O/4w2S9rdfnJocn8Gwj8+Gron4Z6ZdDkWu169l0uA8Vl+9rx+nR1lDEymLeuP4HHQUhA
 dU05ignSE+uW9ubTWUTskJ2oSZz06ixfIZaJLmzbO3+7tJOgvtQ7TXB/ndEIUPGV0BQR
 6LZhyzOUgCByVGB9L51re8Y2Hw3LGcBkwpZgMYxZ2BdOn2ycf6zGIYIneFXFHfiODNPx
 zidw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFC0WXPbx+zags7RH/R1NaWDXKZl6ZdZV4mf/F0bQ5m/Ir4kp3DpopP88eEDNv3ncYfYLAp6bCVY8e@nongnu.org
X-Gm-Message-State: AOJu0YwSUpPUPpDfieYsDXPv0/WIutfEmHMXuN079Oe6chNZbKhRjE02
 vCUgN9mitBMGwBjFUIsRjJxhp4/HlV/kb9hxp+XWi7rIVm87QLVv7MguH4O7YAQ=
X-Gm-Gg: ASbGncs03P6No8SQqzNIPfJ3dSdo4MYV1BR1T0FZ8Zhor4seJyVAUVm/waY2UrBUuU5
 ZNlupVtxo57mibkz+R9kCDAzKjeYg9Er74vWD9ST2eP87EV4l79hrJvvuVMzpS/Zr2Tkx9LyEGT
 OZYR6DSLoFF1Wh2x8CgyC3ED8n19flNfns9eL7TcS2rozZ4Pfg1HeaoYjSKjhFROKlkWFLhUpKQ
 oA5td2n004GFyA9s4gGT9jPER3Z1OW4Vu6ywpgalOLWp36tdpwD4GKYgAKNZfwdEtAA9hyoCR0E
 v/VSdtkel/hCWpMiZ8zwgukJQV5xPjhOKMPjSpOyVFuTMxsIRYkKQDW3PmQWp0QYVMnb
X-Google-Smtp-Source: AGHT+IEJbjhyhsGL28E3BsZd1/6eiizYEVpbo5KCTt/AbPWIrnq9BahRyyw/OBvpPnBmTDdjE972Tg==
X-Received: by 2002:a17:902:ce8f:b0:21f:564:80a4 with SMTP id
 d9443c01a7336-225e0b194fdmr362555ad.33.1741899480218; 
 Thu, 13 Mar 2025 13:58:00 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bd3ba8sm17916065ad.213.2025.03.13.13.57.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 13:57:59 -0700 (PDT)
Message-ID: <39b1357c-fab3-4117-9a7c-7ccaf672dd38@linaro.org>
Date: Thu, 13 Mar 2025 13:57:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/37] plugins: Move api.c, core.c to libuser_ss,
 libsystem_ss
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-29-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250313034524.3069690-29-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

On 3/12/25 20:45, Richard Henderson wrote:
> Headers used by these files require CONFIG_USER_ONLY.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   plugins/meson.build | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/plugins/meson.build b/plugins/meson.build
> index 3be8245a69..5383c7b88b 100644
> --- a/plugins/meson.build
> +++ b/plugins/meson.build
> @@ -61,5 +61,8 @@ endif
>   user_ss.add(files('user.c', 'api-user.c'))
>   system_ss.add(files('system.c', 'api-system.c'))
>   
> -common_ss.add(files('loader.c', 'api.c', 'core.c'))
> +libuser_ss.add(files('api.c', 'core.c'))
> +libsystem_ss.add(files('api.c', 'core.c'))
> +
> +common_ss.add(files('loader.c'))
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


