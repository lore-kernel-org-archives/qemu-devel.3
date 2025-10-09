Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD8ACCD185
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 14:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6rFU-000166-Uk; Thu, 09 Oct 2025 10:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6rFS-000152-2T
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:04:02 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6rFI-0007NI-Bk
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:04:01 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e52279279so7003795e9.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 07:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760018627; x=1760623427; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=isG008FQJssEySnXdvRxmB1JtzORDQiv7f0rDRCoK0E=;
 b=ezHcyyLbLSgnDoY0iYGNP2vQyB50Hcvm0Yc7HV/PyF8DLHqZikP+C61o6cBhFJmZRR
 DlG3It2mWh/zqe+gBLK2jCTMuOXsVr8K0BN2teGbVrF3QWYuB4x5zwuY1+F37slZgnHZ
 bfMRAu8njZuFFezH0dBeDBTF5h2EdJbtMbJ9FUggMNk05lPh3DTaZ1AMXcurX8QWfjSP
 1duCHWdAD/UuoQYPpO7GVteR8knLpUcCxbd1CLFdI5ui3rmqJcrx9btMkU1eVxZMJLDE
 par/LDLl2zqP6gbpzh6IPy7/NWXbP/nY7zJbbVMvL4yyuopKx7/K+JGc6syBksvCXgbE
 FvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760018627; x=1760623427;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=isG008FQJssEySnXdvRxmB1JtzORDQiv7f0rDRCoK0E=;
 b=jalkfXhdsnEj7sBPUH7UzZslZStA3YIvfwaDyJqUcnRafEFlK/WdAoqaZmEETdgLXx
 WJt/QZ0pEgMsabJ/Qx3N0iYAhEBY1/VyRCMXu7UZKNI+82Zt5vToLKKjFrIiGc92RFQY
 WbDSjLdM5IvkXdvkTikLIl4+8tRTKu0sV6H72LVkXjCafq9Ji+FgJFroAiPRdLnt2c2T
 Z8RVMHulZHLI5exneI8bOOukg9E4PQ2b67GfmIJklPVy7EGiRyvnyd1pSenCxRtBdxCL
 5Qq9eujT4dd8wTeysIlZ8n7YMCVyPGTcr1s4LmmnA7/bHiAbm420MmU4mHx3bBFx268N
 G7bQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvCtOI0CatDZ6JZoQ9Mv2Qt/dKuZ08bPFhJLvTxLiJvbkGIJgGohx49G6ielV5kHNV6AOjYv3nCt1V@nongnu.org
X-Gm-Message-State: AOJu0YzkLU187+vJB9R/8jcBDLfcdtp+IJNFYOMj+goX/9BrQOSjHu2D
 1oUiEu+XuJ7Y1QYdu3TYZ9V9cM22O0qv8+g3TAu4TpsQhNgrRH5vjcQxGIo/q4aI4/14R9TyklU
 RAHEI4OI9Mg==
X-Gm-Gg: ASbGnctqkhpfGLle/CinCprAhQHULiUCZ8Mq5bxb+MA8sDUC+mXaBRM2RreZNTWcCPi
 K6D5i65BVkfu1iCbk/Lvke7VNhTM2HLLDuLtejkOeZBDIuO2H9R371ie3l6BKYLxI8ImY/FLuvN
 BpSsuA36iD46vyI4AUci4xDta4LHxDLDkVlVqvQJ+jC9hrzcfEpLXQj1XN7u56ijnYlsGXHMIdd
 25Y4tvPHshLBAIIy1t4epcJLhb+mGnoHjdylq2SNoOjZmjHTLC/MSwXX0Kl6sB4DnVMGXZTi+LW
 wJA2BngHppxUGmC4f1y1oqmHTzQxNJLWqT0WCx5a6g3IsBNBhjOuv8rrS7CtJEh5JVMLKHk3uOZ
 St1fBmBaCdLqwXm7jc7hUSQ8h1QHAooX1vNgpnZ0X+nRMCtgrotzsTIhA1oJ4zUgh53gVznytYS
 Zw/XWzKywQIxIyzL926A==
X-Google-Smtp-Source: AGHT+IFGagHjZIA0p/4QMvDx7LiGAEIVH603xuASPfYxj98dyhWs9VpA14WG7tpLxAqD9OU387IeRA==
X-Received: by 2002:a05:600c:1f93:b0:46e:376c:b1f0 with SMTP id
 5b1f17b1804b1-46fa9a8ca9fmr50714925e9.7.1760018626986; 
 Thu, 09 Oct 2025 07:03:46 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46faf16abf6sm50830395e9.12.2025.10.09.07.03.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 07:03:46 -0700 (PDT)
Message-ID: <a08aea35-960c-45a3-ab97-e4d1487feda9@linaro.org>
Date: Thu, 9 Oct 2025 16:03:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/73] include/exec/memopidx: Adjust for 32 mmu indexes
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
 <20251008215613.300150-15-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251008215613.300150-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 8/10/25 23:55, Richard Henderson wrote:
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/memopidx.h | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


