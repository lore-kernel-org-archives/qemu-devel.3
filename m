Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188A2C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdOr-0007km-T2; Fri, 07 Mar 2025 14:30:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqdOf-0007J3-78
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:30:18 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqdOc-0005Ei-9s
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:30:11 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2235189adaeso39038195ad.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741375808; x=1741980608; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OKe/9uxtkFAajxZczlKcExAQTZPTYGe/0Zw4RLHeawk=;
 b=HOi3AoGwMlWVXS25TmsRDT1D/LitmBxL5kQXSx8yEEEiJ+kl3wUrZBLRMjLe6HQc9D
 LC1qiY2ehc1fgQMfxVnwYHnMZBcTnHINns94nqzxsGtZIevYD4m1isqOlPnf4sOipb0A
 lTvprngdcymobCzsaTPIb40kgM1a6GmJe8/Yi1SsUsoqzueLDqLlR8bp/ScelBYvZL6K
 xnk9dMvJHY7FWxjNHRfZlOYe+ajhhZONBl2FH7Er9O4k2Z4uUvVnAZ3Jw6catFfhSEHd
 FjiN1KhX7jnDIq8XXOmam2eCaRixOmxFmtZd0hKOeHJ64AftfM5Sei+cx6hRCv4/Te7/
 XHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741375808; x=1741980608;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OKe/9uxtkFAajxZczlKcExAQTZPTYGe/0Zw4RLHeawk=;
 b=BGR2zQdOBQYbYveWuhF20c7CuuKQyMV/WlkNId8kEYrsSE6LAV0ratcjQ4seWkGPnI
 DLsT/bOuBbiutsJslRQ6lJJAiw/Ocg1o9k4BDCr194/ETtupPrQEZn9eghMtEoU3yFGk
 F0a6N+9InqtWeUpPyL+WsIsgZ37u8VUI7bBzZ5K3THLXX8Tu1JzkLI1fwVAxhr/6+RGH
 SW53A2b7YuewwFbi1tgNPOcebTck3XQrhJjZmKSQSjLPMSvXh4PpRonpYdqghk3lNZJP
 hn4gVBgGYlqMr+dYIU33QsPMdj2TRzajFkblmM6jzKtSEzORT6S9QO0SWPmtbWD0O0ge
 dfmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWlY1INRXktesFw8AO7D8Y/LGliA6sbKMOtTnklH40mhWbZGXHIKOFOzNn6LDW6hF4IFrVLw6ZQLxm@nongnu.org
X-Gm-Message-State: AOJu0YwXLA1/aXPd6Ee4k3gLh+Yjt7rabkE71+Mvjn5J1gDRHQnYFbe0
 V1LY+xlwNh1+KuTBl7hWxKOyhEOt/vmRBTLsZjIA4ZEsAk1VXToQtR44VVu6TzY=
X-Gm-Gg: ASbGncsXV8KRRW5h1fT5+w85H/UwUAfOr24KS/V8i5hl4Ae1p8js+toUNd5pp/BmR+h
 2rliigfLCU/dfHCJNfK6Vql8dFpFFkMyK54YHt+8FzorXrqp7O34VFN0CiQmqsAf2tFFKA1VxCX
 l/fus4rax0VIgLQYkSiLt6Hg1Nq+5oJRRKbId/O+9uynQrt6XC6+0MZTJH2Dq/IYmnnZ7IOHIyk
 qMXQubHzt7BNA+c2MYKI8KWeiRxpiJOFz1yaCGkuzYT4EVvF2lW4QM3HJ2zm5/bsSGs03H+F+gW
 0aYRYwAwUs2kN0aAzTFwm0cbEZi5KZL/N4nV43oDlH4RrT/vc9pNLfW0c0YMmzFO3lb0EvFy00q
 8U+uPCVVL
X-Google-Smtp-Source: AGHT+IGKZK8oJgsxTqvLKQzxgs81GESVfzH9goWbMO79ltB5TQZHurX6dLEbKPLbOJNsnE5z8XMbqQ==
X-Received: by 2002:a17:902:d48a:b0:215:758c:52e8 with SMTP id
 d9443c01a7336-22462a488fcmr13556705ad.12.1741375808621; 
 Fri, 07 Mar 2025 11:30:08 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a7fac1sm34002025ad.124.2025.03.07.11.30.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:30:08 -0800 (PST)
Message-ID: <2de80620-decb-4200-b3b6-158be3be4427@linaro.org>
Date: Fri, 7 Mar 2025 11:30:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] hw/hyperv/vmbus: common compilation unit
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 alex.bennee@linaro.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 manos.pitsidianakis@linaro.org
References: <20250307191003.248950-1-pierrick.bouvier@linaro.org>
 <20250307191003.248950-4-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250307191003.248950-4-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 3/7/25 11:09, Pierrick Bouvier wrote:
> Replace TARGET_PAGE.* by runtime calls.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   hw/hyperv/vmbus.c     | 50 +++++++++++++++++++++----------------------
>   hw/hyperv/meson.build |  2 +-
>   2 files changed, 26 insertions(+), 26 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

