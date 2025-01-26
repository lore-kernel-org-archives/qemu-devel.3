Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55773C0218D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 21:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcAPC-0003b8-4U; Sun, 26 Jan 2025 16:42:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcAP3-0003aj-E4
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 16:42:51 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcAP1-0003d3-3b
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 16:42:48 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2f43d17b0e3so6870699a91.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 13:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737927764; x=1738532564; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JQEjkV7oecrvvTuSjOmJ7XZEga8rfcUKShBin+Jzz70=;
 b=Z3+48MhtwfeSvHGhHpcXYZ8OXO0F+zrCv6e5dXD9wCYpaBaMfDMXIpIp2Uz83nQW3u
 T+vBpuM0IWLrd6pWFJpTARUUOG6HcxiMLMkDOMOazNS6rjL3QC0nC6ucwgAJd1AYfL5D
 lFlg4IvLzP8yGzlYrNQtJ9nD8wRUmbgNsBAPayrWhhqu7vbie6giOpp4lKTOw2gIcZYD
 GMLxhCyrlNTWHdhkOY/iHWqSOxNS11lc9fAfLBlYZDsrPn07cfI6r5SwOzchRKiTmW9R
 nw6HtkhJsXTJgyTad6t1V/Apynk7BAK3rUVqySnOO/stpJeAI9vUGlkmKpx+jXe/ynzS
 ZhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737927764; x=1738532564;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JQEjkV7oecrvvTuSjOmJ7XZEga8rfcUKShBin+Jzz70=;
 b=AMASutDRwH961L8Sqca2Lh2RYntOAhMandIE0x75EnZ2CWizrVKWviQbnO7ATZZ7p0
 LKefjrwl8lx85T5HN5oSZxeYvmNtL6/B7wFmJXh9BKsCEubSbLnHBpayEGDQAHJzZdiW
 WeFOysrqDG/j1S3ZJ5Q+d9HYhSByjt8zP7F2WKw4r2STb3+leymhtKAmEqJjIuTeyLVc
 eVQsqnAQPFo1TYH687DGaoh20ki6+qukMMfuGgzMWq6QY6QfyO/zsUSdYugh/dU3GVKx
 Y1GgrZkfkv8rbYQ1AuZBbJCU4hKh/18gugiYN8OC6bt7XjI8EJ4mPVbucYWqQe6cO28v
 ywZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBFQkPbM4bUjGA8iog3RohpXJoCm1U74Q+N7Pv51vtgShtgG0U2vUVN4/iyP0Qtxxq6auV6OgxxNYw@nongnu.org
X-Gm-Message-State: AOJu0YzgcsqtUthLBfACgIKTS83xjqyTZ145qpSy4esm1WiOGRzPKslz
 v7JkrsU8QPKMSQiwFavUBUpWBqHskBLnKSfpBSRktSznwPnSqkrqhUlClbREShU=
X-Gm-Gg: ASbGncvseN9nuGxxb6a+j3IzdgDKlYqx1r5+z2A6pEemi5jZAl++x24627ExxDlzGH1
 RkSupIFC45lbsqjCWmQZt25kKP/OjQeojsKuJVE/nntjevKlfJX5Fj+4bAB5EOooEh1H8SBc+td
 2yKSzvRz2MQ9tNevAP1BobPMAx6+PA5Hn+G/QUPv5dNw6AkMN+sfBdkYs6+EZcXwoUS0ziNYsQK
 DXGCREi948fi+4neN14La7yiVrjVcQBlJ6o9sHruOGxu4GpePApoGz9VVZwt8R77CK4QcaChpOI
 QA5sze1ot9Nk2+f+cK+Hg6leV1Z1xaIf0yKFYyvY6ROmZro=
X-Google-Smtp-Source: AGHT+IG2713KOLh/mImrRGRztndcrTsRDLOwszdtbdq7K5IziYpDbYMn2mmMYlziW9f+VzBX6lxxlQ==
X-Received: by 2002:a05:6a00:84e:b0:724:d503:87a1 with SMTP id
 d2e1a72fcca58-72dafa018f1mr52766368b3a.7.1737927764378; 
 Sun, 26 Jan 2025 13:42:44 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a76117esm5862076b3a.92.2025.01.26.13.42.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 13:42:44 -0800 (PST)
Message-ID: <ae0a6b3d-b225-4364-96ba-a3c6b29be2f2@linaro.org>
Date: Sun, 26 Jan 2025 13:42:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] hw/sysbus: Use sizeof(BusState) in
 main_system_bus_create()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250125181343.59151-1-philmd@linaro.org>
 <20250125181343.59151-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250125181343.59151-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 1/25/25 10:13, Philippe Mathieu-Daudé wrote:
> Rather than using the obscure system_bus_info.instance_size,
> directly use sizeof(BusState).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/core/sysbus.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Nice.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

