Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F6AC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 07:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7rJs-0008H9-BH; Thu, 24 Apr 2025 03:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7rJr-0008Gw-61
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 03:48:27 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7rJp-0006JU-Dn
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 03:48:26 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso7100185e9.3
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 00:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745480902; x=1746085702; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DPgI1oZLg+jjZlmM6sUVCZyxaRiAtrHDBayvOE4ZQOI=;
 b=XJu5pv2lNXrvkCRB6t3sjQu/vDsLg+kCPhW/6E51fcTvG8CejK3npe+knjD1EZw6er
 4Vrmp+6B7TUKyxh2w7KH7aePu5wPVQABkdKfH2y/vleCWV2QGfVi7MRFbC8xiUMjlsX2
 c5NKTnCzAxLHhCX4x0d+MpDrZdxJS5s9zhDsqzEl6wSEZPcFYOaHgLUR7gQ8Jo4oZVR5
 w7SHzNK8a7ij9kiyoj85u0UlZg06wx2qhXAc22iJM14a3XczRZSV2vEDXZMdulc32XMX
 EjclOFQk9DeVJ86K7vLU0shj0khSsEioC8aGN/pI3YszydWPI4K+8iewF+Brdg45SVTx
 pRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745480902; x=1746085702;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DPgI1oZLg+jjZlmM6sUVCZyxaRiAtrHDBayvOE4ZQOI=;
 b=hRQZSCz+v/71FTdP7JWUYWoUhiV1IIIzNcTjQkXgLlHA6BQa9gY/qFBQGTGQ1itPBU
 KrkFf5rqy+lTVBYiVIrWMtO6PITtPnqs1w21HTwQxmhmo8onMrd3RZYW8mJ2O0TuFT/U
 3F85YyOtHSoEYMQ8ZtLDGJQbXlGaluqo38asF5/jivQ0mD9roX5aj+GbKzdK5SMurIT4
 HWDnsh8jakQby+Ky3Pa2DSWzNf1i54/qkZgpw8p0Y//4PfiS+OLEyohQCB/1cx0quX87
 276Lb1Xuv61k7WjTWSI/Wa4AYK8cQMj4T9lSKnlpcKFP/h4hZfFEvKZNy1255iYtRk3R
 ryag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfqDRp57Blefm02CISKrXLyXoXuUNW1X3hV69dZX5pwACoVFMlm6eSKddSiaNbN6c7mjclk3titMbN@nongnu.org
X-Gm-Message-State: AOJu0YwqEfPzG/Txd4HvKHohWHhZufbNKCo1atjdzKNGSb8AtqObjEZ+
 MuLdCEZ8QZRN8gHoLFaieNj81dI1a8FVvUdwy/czTgao26AbwGKb+I6Zdof2EnIrkMgtk4ifUYw
 x
X-Gm-Gg: ASbGncvpe76OrxQjlQuT1juZ9J3Vu0BjFUtX/11hXs0onazjJNBWFH2RZ/+w1eKZhIg
 4CnSxDTSwjBE3kLcpIZjLNMhfXAoNZuokVEt9L+qIsPOAB0xu0LQnSFNE7Pv3EJyn6WVEgQVm58
 cY0EEOthwisQECoPAkFIMVDU1kVsOdaL7KV3BaKd5FM2/Grg5OLtrHVqZ9M0XnS1pYY7Ml5Uklc
 UEQ3vmxtEzCpRSOelNwbZjt5nJFBNhevJGI7zjqs9dAgJ9rMVB3Wi5jqFNvGzQ+OjqlTiCE3ys6
 4ccAgFzFW5dT6nrKldiyv+qssEbwZWdIjtyi67OfNBWRuV3vBw+KNSKp7bWeTy2NgqodQ+CG/Fy
 XAPwW7Uc49TOiNhljM4J0UTbQ
X-Google-Smtp-Source: AGHT+IFYmDpaQDzQT81hrD3CGfdIU1L6VfOElpBMuPNDL8L0ojAE38h/Ja4G9fVQedmLzMmeiYUmvQ==
X-Received: by 2002:a05:600c:4693:b0:43d:b32:40aa with SMTP id
 5b1f17b1804b1-4409bcfc1f6mr13560295e9.3.1745480902098; 
 Thu, 24 Apr 2025 00:48:22 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d29bfc4sm10134965e9.8.2025.04.24.00.48.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 00:48:21 -0700 (PDT)
Message-ID: <52a40a95-97cb-47fd-8cf7-05dbfbde2601@linaro.org>
Date: Thu, 24 Apr 2025 09:48:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/15] include/exec: Move tb_invalidate_phys_range to
 translation-block.h
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250424011918.599958-1-richard.henderson@linaro.org>
 <20250424011918.599958-15-richard.henderson@linaro.org>
 <d48bfcaa-5d98-41cf-9ab0-829ba5f8bdd7@linaro.org>
 <35f49ccb-05fc-4143-9af1-c4a43e83d293@linaro.org>
Content-Language: en-US
In-Reply-To: <35f49ccb-05fc-4143-9af1-c4a43e83d293@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 24/4/25 09:36, Philippe Mathieu-Daudé wrote:
> On 24/4/25 09:33, Philippe Mathieu-Daudé wrote:
>> On 24/4/25 03:19, Richard Henderson wrote:
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   include/exec/exec-all.h          | 4 ----
>>>   include/exec/translation-block.h | 4 ++++
>>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
>>> index 24383b6aba..90986152df 100644
>>> --- a/include/exec/exec-all.h
>>> +++ b/include/exec/exec-all.h
>>> @@ -120,10 +120,6 @@ int probe_access_full_mmu(CPUArchState *env, 
>>> vaddr addr, int size,
>>>   #endif /* !CONFIG_USER_ONLY */
>>>   #endif /* CONFIG_TCG */
>>> -/* TranslationBlock invalidate API */
>>> -void tb_invalidate_phys_range(CPUState *cpu, tb_page_addr_t start,
>>> -                              tb_page_addr_t last);
>>> -
>>>   #if !defined(CONFIG_USER_ONLY)
>>
>> We don't need to include "exec/translation-block.h" anymore, please 
>> remove it.
> 
> To squash:
> 
> -- >8 --
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index 90986152df3..4c5ad98c6a9 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -22,4 +22,6 @@
> 
> +#include "exec/hwaddr.h"
> +#include "exec/memattrs.h"
>   #include "exec/mmu-access-type.h"
> -#include "exec/translation-block.h"
> +#include "exec/vaddr.h"
> 
> ---
> 

and because "exec/translation-block.h" includes "exec/cpu-common.h":

-- >8 --
diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index b2b9881bdfb..3b76b8b17c1 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -13,4 +13,3 @@
  #include "qemu/osdep.h"
-#include "exec/tb-flush.h"
-#include "exec/exec-all.h"
+#include "exec/cpu-common.h"

---



