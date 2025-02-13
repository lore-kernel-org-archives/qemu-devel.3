Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8D9C0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 14:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiaIk-0003x0-Fs; Thu, 13 Feb 2025 09:34:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiaIj-0003wg-3l
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 09:34:49 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiaIh-0008KP-Fk
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 09:34:48 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43957634473so10440245e9.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 06:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739457286; x=1740062086; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5S7bMQad/mLAMWj21WZGiC6rSCElPWW0glvzpdXHISI=;
 b=IpypSmBAEuNIeAs5rr2aeJBtEo0OkvHbplPE/J6QDPZ0IUJ7ceYk1IaTbZD9/R/C58
 I4SG+68HXLDpbBLOvaL8mcKC1lCIG/pdipxTJ12K6pNJKUBIRGS6mX6VcCYJKY5bfReG
 Gz5d11YVENicbbEO8tu6zjBtx1GJSi6qu5H5WHDB+MWr4BwKKTJ0f62Ea9yTOA7MTvh4
 sm0IxNy2KfOpRPle0umL5NBHCpfk8r/TgAsfzRMAoKfhWNpZ+yZBTUXwfpOmReo+cW1+
 ZTYFeTxw3yYMiAxpVt/LVeW5wYfmIKqZLuLbvRnsPM8zmulVI5V6xhHcUqeqWRJOGEVe
 wevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739457286; x=1740062086;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5S7bMQad/mLAMWj21WZGiC6rSCElPWW0glvzpdXHISI=;
 b=W+YNhi1yAWFO9Ad6Ku3CtM+iqN0wk8Wly50tcInzSlZgF8W99Z74LxHun5jOjgJXIr
 jyB7FJXcJxHI357BkcBtkSqlYOquA75ZtuKycXM5SUi28IwKF7xsoSmvbD4KyDPEZhEb
 iUsoWhz+9BIofZE/hDN2q6HhIjIiZQHgrAEg5MK472caoC9mp8vIWjuantR3PUhCHhOg
 zI0V+FgFidNIZF3lzjxk0mBhgl/ro7cgTDR+mYzIajrsReAo+SvisRetc6d3HxBkPnRl
 MaB08g3pAtKa+MSwzdZhUw8CitdbFoTPwOOQhfq0Imh9c93AgZiNeUzlG9HpTQzEWORN
 UcxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu+RI7qcXpjb624die2XzYWWSb0TZ1XcjVv0YWXyLlsjPId+s/tNkoCtIBSxyq0vYQ6Zv4O/PuFmg2@nongnu.org
X-Gm-Message-State: AOJu0YyxpdpAQAZRWfqy8xDGHqHTSbB0pO2jeBDLk26RMq4CS3Qs+2cX
 DWQgTMweobzzMd7fcu08s7tWJ+UaAOw2LtQBcdw8ORJdYmJZlSzqkWUbQp0J0jV/mm+QnQnKe5k
 fIpA=
X-Gm-Gg: ASbGncsfRHWiWtkc2suNC+CIqisEwJHcmk8Jyek+jaAXe+BbjVLebCV8J6blAgg8qj8
 rX/IKvqWdo7HuWrVnGL/VrkOpCZQutQgclp3XW9dGYDKAHeqf3DN8ib9Qku5x+uXfmogNPWoIzz
 CMsfTcHjCfNCdbNUqZO4QlTE1cP9WsoGHESi3BrnF3/sirc3Y19SneMACS/bv3fR7pQ2MSx5krJ
 oWtHFqGeyx1SA5fLzxuHD4FUOv8vR5EE3PuXimj2sKn3j4Wd0YyqHkzuVIdVaWl9fe8YKIiGqFR
 FRSowr8A2i6eqgCitxT7l+UnCukQiijttNkqptXVb/3HwFxU5U1IZR8st/f6d5eK0hVl7qOZ8w=
 =
X-Google-Smtp-Source: AGHT+IGYoqoVqCYu/wkg5PTDr6wH3g4cHD3hj/NGQZZvWjeYE9K4asIQhTWF/G7MgGSjo3ocqo0h1A==
X-Received: by 2002:a5d:62ce:0:b0:38d:e363:497b with SMTP id
 ffacd0b85a97d-38dea2688b6mr5700499f8f.19.1739457285842; 
 Thu, 13 Feb 2025 06:34:45 -0800 (PST)
Received: from [192.168.1.20] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259f8217sm2066822f8f.90.2025.02.13.06.34.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 06:34:45 -0800 (PST)
Message-ID: <7e437c78-4b78-4bb9-b9f5-6df75eb77ce1@linaro.org>
Date: Thu, 13 Feb 2025 15:34:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] tcg/ppc: Drop addrhi from prepare_host_addr
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250205040341.2056361-1-richard.henderson@linaro.org>
 <20250205040341.2056361-7-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250205040341.2056361-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 5/2/25 05:03, Richard Henderson wrote:
> The guest address will now always fit in one register.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/ppc/tcg-target.c.inc | 75 ++++++++++++----------------------------
>   1 file changed, 23 insertions(+), 52 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


