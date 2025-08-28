Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4760C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 08:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urYKl-0000HH-6D; Thu, 28 Aug 2025 04:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1urYKh-0000D8-0l
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 04:50:11 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1urYKe-0001WO-89
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 04:50:10 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-45a1b05ac1eso3320125e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 01:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756371007; x=1756975807; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p1hQtmOQGBZa1yuAFviVcjQiqSOgaYsu7/vEEkbZH2k=;
 b=fYLiiUBQ1aHy0TvWi8w0d+P/imUn2uy0pVXtsG8GhmaQRTp/m2ORrpp0uBkduNacIw
 Rizu8MCpLnNyRXgdxkR9cBpVl3u09tVuTNVuJwgGOMQK6bqzq7pJ601q/4x1EexWUCN8
 YZPi+N/+ge168RyNYRfYqQkFVETD/u6TQI4PmivjJaXn2U+1xK1wCln187fePLmVnHCz
 NJ9k1N2ChDOvQ6347KGIftRH/8hLIj1ArAky5iVY098IUPO92meNJTlB/grk9nHxLDxF
 8J6TKD61Y3TweQcMn3T953+EoPoIPZM5q+ymfhIw47kj2z0VNFB2bEtjbJ7kAaeUC6d8
 PbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756371007; x=1756975807;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p1hQtmOQGBZa1yuAFviVcjQiqSOgaYsu7/vEEkbZH2k=;
 b=oRyzDsl4hngxehiaD0cl0PafBdlCwHwkKeyNiVFuBxyrWGx1TQiyiZQ6wkF59tcoCy
 rA68Hh6dzm4cuB/JJqRv5eCkJVO1MISl1pfn3+H5PECYAAKuWs3c/e2dQOnQ8iwDWf/P
 sqOqI+BvJdR4q0S1mabu1V860RujraOarWtRp2S0kWKmWw1FRMBq/F+ZJJ9ew6NhxmKI
 07T5F65MEz9kpgroexegZx9EFlvhDbdyNaHWAnI29GNnNzqjYEeAJNkLc8NasEta9P4V
 nke8cyYvM+he9ukjvzqFgxUP/me51ZZaGc98jPnZBY5QVUydM66hxfsnLmAPXIeMaB+F
 EWgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5jClZZpBrDHXNQollmtIp68OHCOvsj4TvsvaVHEC5qMsiQ9+GbiFpM17oXGyYrE2qZQrrTJ6F9vSy@nongnu.org
X-Gm-Message-State: AOJu0Yzb8+4xjG5LpzEIqTrcqcE2x7S9eJpSVrLae60Ofw9PO3KPTPzb
 ermsMGhHLzX8ysnbVMgybf2GZNioxwAZP0Ipiz4OCqnPwTt6rcW0ocoWkY5wRegIZEw=
X-Gm-Gg: ASbGncvW9f5coeqr+gVq4zxOd7fgJUXo2ucmgRhP+eH/qdZuT8ia9GjhC5OetwwRRBW
 zvaX9bniuoRJiX/z0WHFFw2CEaUDeJZ1CGIfb0LuZ58NsZdblRNQbWUevlizqDZliojqr1J9tTh
 9JVMLrYIN3CHkle1iSs0DGygT8/YS1SFkrW4OaMe0V5Y5kWabicFt0pBPUXJMwM7jnKDMLRElWP
 nl/kYwCs26oK2dthzWbAtyVBYw4YEHthMUYG6DxAPycGQW0wCkiUvOuYHJ3otbEtyG5k4tZFNjf
 JuA0tYfdMDExUJZAgKxZ9MbQUuuVi8YMpUapvx0qrsO3kJCcEamHuw2H8jfnue3Vjywm6/tDxqI
 fB38r9bi3eoEoxSE/HPEDZq30e2bgeokPSFjulN4MBA/qOCkw+9s4Z7CfAhn/Sznbozzm/XNjMn
 pW
X-Google-Smtp-Source: AGHT+IHfH9Vy1EIeCDmH748Ql82W2J+bWkms8kOrnkfTzAvNG56PSJPP32e8z3Ks5QSMcOCPGH/f5g==
X-Received: by 2002:a05:600c:5254:b0:45b:7bba:c7a6 with SMTP id
 5b1f17b1804b1-45b7bbacb8emr7896025e9.32.1756371006625; 
 Thu, 28 Aug 2025 01:50:06 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cad431ea49sm12643214f8f.42.2025.08.28.01.50.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Aug 2025 01:50:06 -0700 (PDT)
Message-ID: <c2274ce1-65ee-4238-81f8-7bd6be5491d8@linaro.org>
Date: Thu, 28 Aug 2025 10:50:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/char/max78000_uart: Destroy FIFO on deinit
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jackson Donaldson <jcksn@duck.com>
References: <20250821154358.2417744-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250821154358.2417744-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 21/8/25 17:43, Peter Maydell wrote:
> In the max78000_uart we create a FIFO in the instance_init function,
> but we don't destroy it on deinit, so ASAN reports a leak in the
> device-introspect-test:
> 
>      #0 0x561cc92d5de3 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/qemu-system-arm+0x21f1de3) (BuildId: 98fdf9fc85c3beaeca8eda0be8412f1e11b9c6ad)
>      #1 0x70cbf2afab09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62b09) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
>      #2 0x561ccc4c884d in fifo8_create /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../util/fifo8.c:27:18
>      #3 0x561cc9744ec9 in max78000_uart_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/char/max78000_uart.c:241:5
> 
> Add an instance_finalize method to destroy the FIFO.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: d447e4b70295 ("MAX78000: UART Implementation")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/char/max78000_uart.c | 7 +++++++
>   1 file changed, 7 insertions(+)

Patch queued, thanks.

