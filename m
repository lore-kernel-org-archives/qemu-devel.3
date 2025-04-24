Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 105B0C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 22:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u85DO-0005mJ-6k; Thu, 24 Apr 2025 18:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u85DK-0005m7-Eb
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:38:38 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u85DI-0002oK-Kg
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:38:38 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22c33ac23edso15722305ad.0
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 15:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745534315; x=1746139115; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yZScttqycTcZnPiTNsOx1VJabjCNRlzcz34u3Z3bdVA=;
 b=r2nBHuD25yyj7liOu2S+0t1eW9LX3kxzreHId4N/wXlXTbiu+H24MNKL/Fj5L/b+fU
 o2QGTOogg0EjP5vk+lbg3QrXGwM9aNqYKCZ3Cpq13Dx2K2bimTk1H18HYUjVxWEmzH7s
 Ag1ctHkyqfxBhI9u8YEnWOEp4O55Cl5WbkHiniYV/5hzaCg66lvQ8dMvgARNyT30qekn
 szuidYpWg6DAbgHy2/wGvTun4zRqVztOxiqWql2pWB31VXBQLbf6p3V44kADvTxlGNJp
 o4f3hcFGZpH3jIIhmdpSa9fDr/91oGjUErFmtHHEs9IylvwfuW8zyHE9x9qjjc4rQRaa
 juJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745534315; x=1746139115;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yZScttqycTcZnPiTNsOx1VJabjCNRlzcz34u3Z3bdVA=;
 b=T2EMYzGdRi56oirh/6zETlmh/lk++qRoeZg8oSQJ9O5oF7xq0cSB+0zDYIoSIzqCW9
 3kJ1lLcC0EsWrVndwYjPO/K2W7VzNYl3gx6ef7Zi21si4GrF0Vk34c3Btqr+liZvL9ds
 AQ1fMkN6ywMtGAdLY4ZMbJ/o4jfIh24oO9LteTdTXwVsvwKFodtho5Rb72FYJAtc7YcL
 wK/V35ICCamg5gsplnw/56Zy1TgF17obS56JHdHPvZiVY/3NFKmhAtrMTor+32yPW6E3
 Ab+bYur/C71SDMDTus8TykqDWIzl52jMJte7IRm/8ovgXmXPjDbEqsyVB/onP9qa+Y5g
 iQEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpiNYGlbM7EhKCP80647bzNN8xtwZGPEBYmjmW8ucxAUncg22flo7Cv6kJRy8X3QOq4HoZR4LO+1qO@nongnu.org
X-Gm-Message-State: AOJu0Yz4a+s0Sy1TOamAgCZduLH2Nz6R8o2VFt1oH6C5G7Op0Im2qLLJ
 UPAj9wWsJcI/YKMUOLki+kKEsq5YvGg9t0aKQO+TY7fp4Q4xivw5cx7V5MgE6g0=
X-Gm-Gg: ASbGncstTAphxmb+T3h3NUqXO8pChexNWgswtdjhsnHikLE2s4kWB0pDzMxfwlkPqMZ
 NP1knykf/EhyO00zXE+Pv63xj1jij2LPWg3lJqopiDQLFnIiUv/hrjC/8IaoMUf33LxIwjkoVqi
 QjG2I93R2LDM9jXJq/kl6fbRgMPdsuS3TNkXDR6D+jruMxsXbA2Dh4hADfPmWCe+wKKYHs93Zbv
 sq+f5H1ciaCXjq3phPVwJrJg47N/3q6u/gG9mX2Gf9H2XpB/7P2zB3JChJIYpaBqBFtnFDFYoOG
 EYW73Jsq+SImSSFGkVD17PSikhN8sMjnlOUy4KBuqToAMYgtK0WLjQ==
X-Google-Smtp-Source: AGHT+IEELsbgKLtETkgqZ2gALBm0+rZW7r4ClMGaMn+WzV8Xz+g9KZuQRiu1yMEHNdK+oy4vtAhuaA==
X-Received: by 2002:a17:903:2289:b0:224:78e:4eb4 with SMTP id
 d9443c01a7336-22dbf62c693mr509015ad.39.1745534315203; 
 Thu, 24 Apr 2025 15:38:35 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db521a6a0sm19011225ad.254.2025.04.24.15.38.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 15:38:34 -0700 (PDT)
Message-ID: <eb738fcf-4116-4591-aa21-25cff1fe7351@linaro.org>
Date: Thu, 24 Apr 2025 15:38:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 15/21] hw/arm/virt: Register valid CPU types
 dynamically
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Anton Johansson <anjo@rev.ng>
References: <20250424222112.36194-1-philmd@linaro.org>
 <20250424222112.36194-16-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250424222112.36194-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

On 4/24/25 15:21, Philippe Mathieu-Daudé wrote:
> Replace the static array returned as MachineClass::valid_cpu_types[]
> by a runtime one generated by MachineClass::get_valid_cpu_types()
> once the machine is created (its options being processed).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/virt.c | 59 ++++++++++++++++++++++++++++-----------------------
>   1 file changed, 32 insertions(+), 27 deletions(-)
>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


