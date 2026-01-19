Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29304C98315
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 01:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhdxi-000504-5m; Sun, 18 Jan 2026 20:21:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhdxd-0004zD-Gl
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 20:21:42 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhdxa-0003l6-PD
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 20:21:41 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2a0834769f0so25481525ad.2
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 17:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768785697; x=1769390497; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0gvxH66qpJYEFDYvBJzcnrey3tjKoB7HqY4h0oF+Cuw=;
 b=BCADxYUSwnphsnfVjUUpgHKiOWgZilQc/T9waIiOzSUn/vQA+pWZ5jTaee8hHXnBj6
 vy2kRw5Uv5iyzIFjMn/i/tfQyy3z6djKNFsoYb121wyyGilBatDyO1xkRdsdRg2/k3Im
 IdPlbbJttoxj84VKrh0Xhokuqy2QNrjhVCX4f3tL4jbORHNaaoQkBwfG1rz7LA+OKZVl
 cu6K0anHFeYxrZkRXrbpvzRjUnw3+gqOK55L8Q+WvEkvsR33OpBRMD5sVkjL1is+mwyM
 C5A/kGAxU/fWZAasCriOkfpYkeNmR61xaQG1VSmNTSyIi1yVTKY3bR4T5ccLKEh7gRko
 /Eew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768785697; x=1769390497;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0gvxH66qpJYEFDYvBJzcnrey3tjKoB7HqY4h0oF+Cuw=;
 b=Wth4Kg2oGqveE5gKPiUW1nSHV94CWNalZ3SIy6h0RkREr7xP451C9ILJoKYw3d8cD2
 EFvb3DHjnR/d0YeDHpSeJyOfqsVrXpQ7hIbnD7k81KzAE2JvRS/gVaNrWckqPxflgbim
 zXZ7aM5g3NjYn67RB8Kku8ESk4H4+85sAC5MnweUhIzZadtXuTsA5dRjJrulsoRxNBTH
 EVDiW+L/d+3pTlNWeogQtwTLmnVY1HAGMQCrKwHWdY55Qx+uLgWr0NupGGifgW6nJlaV
 4UZmDiLxuzqXosiaHU3TzgyTBLKi7fjcO2GKhnyWpbODZLwTRROhrcHpza4FCUTeQhL9
 /t/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSAxfFVOP4CO/wa83GxH0w8z8AcC5m8FPillnVgtuL+0qbHYds2Bq3ep4nhP+YnqrXQfUpgZc9ucP6@nongnu.org
X-Gm-Message-State: AOJu0YxeZVGZvzwUNYvICmz08NGEuDhRDhQL8SQXNsxH2ZDik9yqNLkG
 iR25+zh0UMiQJ8N8RjnyGjROs6Ngx9bqFbEqauZhVStAAY1FT4qg7OivafM91AKemn/pv2oNJvj
 FGql5f4gaUw==
X-Gm-Gg: AY/fxX7W3o7KlhT8A0aS00cYdL8pDGzsRX1lFDKFQw7Huw3AEoDn6eIqXOUlQMeBmaf
 H0lRdcgIabaT8grh0oqs09ugbOpcI+EuB+US9t6BjmvHyJAQB3xWbHTULk80WQeTcFisXjvRCDV
 dV/aS+7ShzhgKax4H8U0QYyekRYPcWimRrMJ05xTSCqxyLhvNeFpyTwSj3BBpX26ZaTiAQx/wBO
 +MsXS7lhYhKBnCQ1K7ovwq9Lg1txU34XJzK7/LHc7qUavtpUuASgjoBJDQoPeObI8PeJqEkuyWe
 Tx+3c+0PZ6LGT4fPr0RAlWyZSrjTcxemSrGWD4usNlyXiqh2PtET8hT3B3xRdXVQ6xOTqn+43Ro
 ygQCFevxHWHFA0KV+T4g3jyinaF5pGWjWpm81pay+t3sACXwT0JCBo5NUZh7Lh8V6/DOEgDGP2m
 TAFkPKjOOS6p4ZDT0zGkc7k3cUyAZxtA==
X-Received: by 2002:a17:902:ce88:b0:299:fc47:d7e3 with SMTP id
 d9443c01a7336-2a7188fd7fdmr87801215ad.31.1768785697064; 
 Sun, 18 Jan 2026 17:21:37 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193dd582sm76924405ad.52.2026.01.18.17.21.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Jan 2026 17:21:36 -0800 (PST)
Message-ID: <9eaa51aa-a234-4682-82e4-9e77488c4a14@linaro.org>
Date: Mon, 19 Jan 2026 12:21:32 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trivial 2/7] meson.build: stop checking for splice()
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20260113130008.910240-1-mjt@tls.msk.ru>
 <20260113130008.910240-5-mjt@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260113130008.910240-5-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 1/14/26 00:00, Michael Tokarev wrote:
> CONFIG_SPLICE was only needed for linux-user/, where it is not
> used anymore (assuming splice &Co is always present)
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   meson.build | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index c58007291a..9b5f1540ff 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2913,14 +2913,6 @@ config_host_data.set('CONFIG_PTHREAD_AFFINITY_NP', cc.links(osdep_prefix + '''
>   config_host_data.set('CONFIG_SIGNALFD', cc.links(osdep_prefix + '''
>     #include <sys/signalfd.h>
>     int main(void) { return signalfd(-1, NULL, SFD_CLOEXEC); }'''))
> -config_host_data.set('CONFIG_SPLICE', cc.links(osdep_prefix + '''
> -  int main(void)
> -  {
> -    int len, fd = 0;
> -    len = tee(STDIN_FILENO, STDOUT_FILENO, INT_MAX, SPLICE_F_NONBLOCK);
> -    splice(STDIN_FILENO, NULL, fd, NULL, len, SPLICE_F_MOVE);
> -    return 0;
> -  }'''))
>   
>   config_host_data.set('HAVE_MLOCKALL', cc.links(osdep_prefix + '''
>     #include <sys/mman.h>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

