Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D9DECE582
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 06:58:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snup6-0005G4-Ud; Tue, 10 Sep 2024 02:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snup5-00059l-4n
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 02:57:59 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snup3-0007eG-J0
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 02:57:58 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c3c30e6649so316911a12.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 23:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725951476; x=1726556276; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6pYbEwq2HSvB/NG3w6TgJAzndJyZ27RKY0oYedHcRZo=;
 b=O3wbwessVKvwf29Ib+brg03sWFLot/M5guOLIMhr8YpSy4tMoHkMGqSqRBHs15KO0J
 +Q0z83Ou7TTThy/FsC2i9xyVUXFHmgEKVHS/JG/HYmC71HOj2hrJ9QlAntZeK1i+oJrS
 +4m/gCwasrEGes15pa2UMm49AuZOKr70haiUQRSWyo1GPBIUiIwsGLE3xe8uC57IBfE5
 qBuQSqqdw48hdCX6efvlPEIrhQGrnWQtpnL/h65ClOF6MutAV22Q43Hc4RitVETjv5ao
 mot+g61s9SQXJYco+Kj5Mb6N/KAR9zH/8t9cAZvyQjy6l/C1Z//tDX+dnEwVfWNpubdB
 n1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725951476; x=1726556276;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6pYbEwq2HSvB/NG3w6TgJAzndJyZ27RKY0oYedHcRZo=;
 b=JA728JwgIUN1w4Zf8gtMyIAFvQuk+4XbxjOxQTWhJWpkloDwRTjaNZ+pM8K69+lbwQ
 MKa/OnpAoxLVBwmPEIkaCgDjuhBwhSjG3oEskqKlV6MqBjdTgETCLgk2sGEMYIFrgIAa
 qO5wAGZmzl2S8Eg4kE9/p5scGlRHWGQUw1+uVr3uBz84sSEjFQdzcDXMZkzrQ/3m+mfO
 McP5Am/gGtTV3rvnXtvmxvjqQWa/9X1XZWYCLHF+cpV2fy72VoW9H3uOfhfGYbmqJ3BW
 iVKZ974fQDa5sRW0OFkt7tEquiRWwEDrt4rqlS7WGvWYqargHfMp5mUOyhHLT41v+85N
 1IXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3HMQ41Au8wld7cwBiPdGz7lLa6Bv3e8yg9tE0P6kM+HprKerKKKI+5XIOq5VfcIv2a/kVejO56Pxa@nongnu.org
X-Gm-Message-State: AOJu0Yxuw2NTz+Fv8W+lwqQbW0V6yMODj/YSWhXAH7IdEFyRKDgc+9FJ
 GGAX0jUMbLTC6ojRurGPhGE4TVR34RjiP6iyajoqm+wfqNOajGaGEEhOtWy1hWnkRwhkzp78Ds7
 6
X-Google-Smtp-Source: AGHT+IHD7R12hyoIgL9zhhXRvx9KYRVd36wdS9CSRXhS0cLHE6JDNIv9plJj382xTEFvK4ibFswICg==
X-Received: by 2002:a05:6402:2687:b0:5c2:1f74:114f with SMTP id
 4fb4d7f45d1cf-5c3dc7c9059mr9087342a12.34.1725951476055; 
 Mon, 09 Sep 2024 23:57:56 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.217.32])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd5201dsm3910327a12.46.2024.09.09.23.57.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 23:57:55 -0700 (PDT)
Message-ID: <14e46285-3050-49db-93de-e898300eb13f@linaro.org>
Date: Tue, 10 Sep 2024 08:57:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] tcg: Export vec_gen_6
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: zhiwei_liu@linux.alibaba.com, tangtiancheng.ttc@alibaba-inc.com,
 liwei1518@gmail.com, bmeng.cn@gmail.com
References: <20240908022632.459477-1-richard.henderson@linaro.org>
 <20240908022632.459477-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240908022632.459477-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

On 8/9/24 04:26, Richard Henderson wrote:
> Add declaration to tcg-internal.h, making it available for
> use from tcg backend vector expanders.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg-internal.h | 2 ++
>   tcg/tcg-op-vec.c   | 4 ++--
>   2 files changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


