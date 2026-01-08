Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6805D1D48E
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 20:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdwTV-0001kO-Rn; Thu, 08 Jan 2026 15:19:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwTV-0001k4-1m
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:19:17 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwTT-0002gf-AF
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:19:16 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-81dbc0a99d2so206907b3a.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 12:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767903554; x=1768508354; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2w4OFujIv4n7HOlukTvzF0n124Px8YLrGRLWcgLxx/0=;
 b=n9swR0t82szHg/5DaD9oITiQaFclU34TpyNPzj6llrt9krNKEl1ixo5xzSd8DGwj4p
 tuZRP4XEo9y5Ax/7ZCEWGz7G5yNtqCi71K5dnJjBirKd7/dVfAad2bDY0Y3cXR/dp8hu
 FPnMOxotdieGLqzxa5qa/w2CXszLrn9RgNzkD1s2nnVYo/QyZUdklTfTitV6DYpOthqh
 ykIhWja93ewUGDBxqw48RwbG0X3SHLCFe4nWJnNOkvafnDmVO6CuFJvmVRzXzjsegmqr
 9F5gmItUbYfy+ftnHr01VyXQFdV5n/YNmEC5sKRqCEgMT6tlqDoNIQmDJ1FyYKCoY4Qo
 Rcsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767903554; x=1768508354;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2w4OFujIv4n7HOlukTvzF0n124Px8YLrGRLWcgLxx/0=;
 b=FlHqu3mnBBSdquaulQCzyCRvHStBIjBPYzQ2WZ0WYbND04Bss68sqK3lysWgh+7gXh
 VT8cs/P6VaPFoXwmiZEvgf/uaQlaCA07P5wbDUna58fa3xGWXB2QtGtwKFnviORtzJ4u
 cIYSpP8UwRZHkFE1bqcxV+coIu4UDLt2ViSuoLquTuwT8XO0P3XAzZnsXeRMKL6blOXg
 gddbetw/rlOs66tYBghl6EtTAPjGWLkrbr/ltDKwqdB/Kwtcw7jf2WI1Q12ZrV4HHF3/
 iQZNKmTM8shenH4DiFTDThXDBO6mDclLsdF/7ANJDfM8OyE9TRf/SmWqZbTxwUjaHeHM
 XS1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfu0PIGTdBoIz0A2TPCYoBV5ITvGVRXSt7dprIrZmuv8cVVCwgELW5LRu9DM76/LKdLJxGy89g3J41@nongnu.org
X-Gm-Message-State: AOJu0YxEHvif8ScLhqB3gwQ5UkwRJkqCKcUqIJvy2pkDBn8oy1/N2+gH
 gqBi+HX0vcKJ9yHqzNO0LgUKo4i0qRBMK5EHjWQk2XXWbH3llECAoRGEr7RrVv7ZhI0=
X-Gm-Gg: AY/fxX74n4XrAkza7ekU3LwRM40Vl1ux6WKJVsP8NF3pHoXXwaf7Slalg2ZD5baduEc
 8bqWKjkC5Bxgom89cU5utL+bz39KIK8wofekH4qcwH9/hR3QM+hQsGXKnRKvkMb9ty/88lyt2K9
 6n9Cc50nvfdDR7ikr285NXt2PtmaKXyPylT+Hab8XaD2T63BHcODMPkh4snufQFvcp03hzv+w+V
 0/GLH9FSHgIoVezu8eL1UVRRBfjDnV6x1l4GMkwLBuy4F1Iul4onjzBOEiX0WAKTZHg3gXU4/EF
 KHOg3sfYTO5Z0DBKpApjY3HRp6GjgazlxT6CAbMa+VgbLd12SeYxlwb8r8oaWf6+CrEH2fGgdcw
 GlFz6Es3kz6n2naqAndqlUN7lhSYHQDqSdbh1nWC5a7qzIm+xlOEwgsZZK2iB8VyYcTQxYvZprO
 APrIGU1Llgignbespcgl6IpVUB9+mHw5CBAQkfBZ1OeOsPKB6/3nxbNMr5
X-Google-Smtp-Source: AGHT+IHowBFcUGNq9h+4PDXD97GvbHn6utJTmW6ElWyKZ3yMesxejB3qbPRnd10spFHRIm5EjKxq3w==
X-Received: by 2002:a05:6a20:2588:b0:244:d3d0:962a with SMTP id
 adf61e73a8af0-3898f91d2e5mr6776337637.22.1767903553851; 
 Thu, 08 Jan 2026 12:19:13 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc8d29516sm8691983a12.19.2026.01.08.12.19.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 12:19:13 -0800 (PST)
Message-ID: <25fde9aa-9e23-40cb-8004-b547208d41a3@linaro.org>
Date: Thu, 8 Jan 2026 12:19:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/50] meson: Remove cpu == riscv32 tests
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-16-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

On 1/7/26 9:29 PM, Richard Henderson wrote:
> The 32-bit riscv host is no longer supported.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   configure   | 10 +++-------
>   meson.build |  4 +---
>   2 files changed, 4 insertions(+), 10 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

