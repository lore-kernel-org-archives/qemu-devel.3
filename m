Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDDCCCFA1A
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 14:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vI60s-0004aI-Hj; Sun, 09 Nov 2025 09:03:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vI60o-0004Pp-Nr
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 09:03:23 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vI60n-0004Te-5Q
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 09:03:22 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b7277324054so306057066b.0
 for <qemu-devel@nongnu.org>; Sun, 09 Nov 2025 06:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762696999; x=1763301799; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zS7AbEGMddZbuw+7JMZ27pbVDA9qbRJcIRYc7b4x294=;
 b=VtgefT/qFxywkrdScrnF9LgBa1sTaMYgcXG/Mb8DUeR3Zx1Wp6rgtQUrHPkWljzqkH
 0/cd1qvE3phC4nnCxPd0PRa0LgI1cZEtfdSTMXdmUyDhnGvbdNQIxqXlmi2oHfDRMxDt
 MY8NIUyhM6XHIW/0j0q9u25x0HH1jKllejXvf63w6IBu3QAv26KY8U7TU5M47o0F+5Hz
 +swXuD7bZZK8CIdyYXsK3wSFaoWH5G8w+gLKov40WTjvOIF+lec9gdPEoMSdq0bWgfJG
 4CJ60M0PbKav9lO6Ki4j58kopz6hGtvsoHom3zgs9SdMFLCvhyWdFWEEklFTsGX9W5E8
 RSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762696999; x=1763301799;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zS7AbEGMddZbuw+7JMZ27pbVDA9qbRJcIRYc7b4x294=;
 b=k+CtBv4aTCOG7syNkSFDlBLdVZs4QJGhx3CD6zm7hh5tK6nNtBDwGLv4xlg1QQGaCz
 HPEJKAqpiy9veeNLcK7F4v9eJypQocp+NuqQPPSsDkmTsWPRfQkmWhCI5AIkblelylho
 lrhfkRJbwsbqDjxGyZCks5trYn2FJRRtLv9WTHE9wH7sEJGxsr28eBpmsHbmP2nc22ta
 Jzvi0/56H93XIGBKhlzuqUHQZJmR6Xt0L4l1DBtbSuzZp/MIa0jH1tmlgD+ZzmjaD29Y
 vUTNSXaZJvwf0YcTx8n8LcBlhZN6PVlR1/RFAR3JAs4habWpNRo1aJyWvketQxQDVbG0
 H9iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCViAYTcaahgh0No1GjmhEXpIXBScUDtQ+iMlVYl+LGIoIDPx1DuIW3fifXOUOg8CS+PWkLjrjTrsEPU@nongnu.org
X-Gm-Message-State: AOJu0YxLtn3eo0fmrvcYqAqVtz7l/en5ob0014xcbq91PjJfbTtLW07Z
 PjQbPKA1dpg1URaQX0YoLANjOWOXOuIWgGvDZNl4fyUuU90di8UHVZQPXdRLUHQT2j4=
X-Gm-Gg: ASbGncv+yB7MveyWdWz4SU2EKcs0iXL6ESJ5VZq5lwWfGwUkgNf1PDcGARP8whDYbec
 dq/722zv8ELaqon5QpvQbv1i6ruTTqxdvRELh4pwD9viojJR6ym6hGxajHOjGlr/LlSi+QJDytg
 2ocR5KM0C4JXUnK1Bsp4SQlfTBh/ZzyK0H2PMnAE9zHl5d7hnHOqfiYuBZqDpoof0XblIYgLsUm
 lDyqpC0QXLFB47T9Q9Za2/oQc23mPAZsf0wEHbBXN89y2fmko65Fgi2/NbNwK0mnZ52Lsu85lvP
 C3BdLXurkg52LVgfnxtPJdwMzhia4mZarJkxh08/c9m54l9MxyxIedEWVh5zOqWJWA/n6jaLdOR
 ytUnLWMmskEhIBOemK/5YEgi12SP1Mo+3nV+0sOAl76jrLAKW0zdeRhOgcGGCwQ8Hcolw/pP3Gd
 FyrUl/847nNgNA5IYmdXCj/Rt2ZF/lpInMYBr2lk73Izds/0wa66kll4KLAw==
X-Google-Smtp-Source: AGHT+IGCuPjCiT+eu1j7JxHX7JwxbFo1LD5zY2H9EFgLMFKeuIzXqJuLq5xVhXYfLTrm13s7LT+YaA==
X-Received: by 2002:a17:907:7e84:b0:b3f:f6d:1d90 with SMTP id
 a640c23a62f3a-b72e02b342emr472456766b.11.1762696999453; 
 Sun, 09 Nov 2025 06:03:19 -0800 (PST)
Received: from [192.168.2.7] (tmo-086-152.customers.d1-online.com.
 [80.187.86.152]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72bf97e54asm806021766b.34.2025.11.09.06.03.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Nov 2025 06:03:18 -0800 (PST)
Message-ID: <420ca5b8-861a-4ec6-b64a-461707a48866@linaro.org>
Date: Sun, 9 Nov 2025 15:03:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] target/riscv: drop unused include directive in
 time_helper.c
Content-Language: en-US
To: Luc Michel <luc.michel@amd.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>
References: <20251107102340.471141-1-luc.michel@amd.com>
 <20251107102340.471141-2-luc.michel@amd.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251107102340.471141-2-luc.michel@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

On 7/11/25 11:23, Luc Michel wrote:
> Drop the unused qemu/log.h include directive in time_helper.c
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> ---
>   target/riscv/time_helper.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


