Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20EA1061B14
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 16:05:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7F5x-00057f-Ky; Mon, 30 Mar 2026 12:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7F5X-0004tx-Cz
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 12:03:45 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7F5Q-0003tO-9q
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 12:03:37 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48700b1ba53so41630495e9.1
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 09:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774886606; x=1775491406; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c6nXK4vduDW/HOxuQ/JtFSDWomQu+PdfsvqXxNj5Wzo=;
 b=Rm94Mo+1KLpBh8FVbmXe6rOClYTaLPMGpA8QvlWd7LSQEI6SYqz2wrmhPpp4hkgIe3
 yKliyx2HTd4QaFtTrabqeHM2pbfzqi2UJnBU6LQk9SU9Fh3I9bAs63oCwAL3H75BL7Aq
 TyLS2eeHG6G3iBJy9y+/Yu918r8cpvsWnUBVCkI5GWkAMQT+OPlnBoRinFYSmo+QnEQn
 veLt8fzUBA8K6vKyPMrCiLesAyOsfrnqmQ0S+GvlKU1ev+K604AwhROOUxmdOWpcF94g
 Cf1qOH8x0QIgHM9jvPTgST+vAeSsSbO73c4waeZpciNTnvUBDpxzpoiBdqwgkYatP8WC
 w4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774886606; x=1775491406;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c6nXK4vduDW/HOxuQ/JtFSDWomQu+PdfsvqXxNj5Wzo=;
 b=T7ClK4Mt9xbfBZ0MeDo7QFn9I46TRkTyR8M4S4Qe5URw2i46o0mcKugMVGnwPVGARr
 S1dG42Bcm9k5f5IQpwQF4f4jftiBLRf30CNDp4P7mKnYeN9PnvBFpOFtmR0oYNjUnK+i
 qbn73KRZ7786WwPnFvnmDR3aLMS4xuETqnw/cwipkdvWvqeHIJkKhUGfizP7KwOVTzY6
 PzgdCAciRA3AWpyN646DpK/HYa+Vh2iZtpol9/dWNASNrmmSTuut3962dJqh0DziBB3Z
 W0im0KeBhi9WuEP01IRfJRyvtQnmnm9YaYcSXQVpsozNp87jDiDv2czBhlJFuv+qRJZc
 oIig==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUOuxaNIHgga9rXQrJ3axOqTrGPN/6aBgEWjd/iRY2SAeBn+TGt1pdxGjncKxaRw/2xUrWqF20OTPJ@nongnu.org
X-Gm-Message-State: AOJu0YyHrmrUg6ZAAEkQ6AilYwFWokP34fbF7zj4mZzu6p20jXqxt9jM
 PmhpWhTHvC0Gd8gwJhUIMl2a1qbaWvEZiWlgxyHHcbYKxC8zY0T5WH+DRSZdRn6QKE4=
X-Gm-Gg: ATEYQzwb9l/xvCVCUk8GlWtZ0XjKZo9xH6NrYuRQuo9KyRiIduHxYigDmHhN5qwpfsH
 mPKg0vK3/BsKdjt5l+T3NtzSrfjDIMhofeX7P1gGeoXGosRFNs2HniIejwrGUtGS+2LeY5Aesb2
 dpeetMVzSYl/p8m0icCqVc54cqbgJBi0c6/78FKNK1lJDlX5QNaKrkv4dEQOi7u6SqGY+l8ReSi
 GTPgHy9VRKIA0rmxGZhwIy7WG+SovH8+xn3X58NJo9l+LLWFq1La50kbRAxLKX7xIxW3VdNvp70
 eIBDyWXhz/oPzcvtindNfiXEp/en3bo5Qf/AtNf3CWg+EF6RTXCCcEt9JD9ZEVaKo0cqdl7vwQ7
 4mkjT1LqyFBfmhMSY1nueDRnc935dJCqIAZ1vWXrFOxVAEG723y2GccDUPBBKYr06BpiFq/CPNc
 h6tNRKdTRHw7UKzrh1FMDVjSKnFCGGSrM4mj8ojgGgpjGKWV7k2dOOmL1kOS52LeY=
X-Received: by 2002:a05:600c:8489:b0:485:39b2:a47c with SMTP id
 5b1f17b1804b1-4872809fdb3mr218981205e9.25.1774886604523; 
 Mon, 30 Mar 2026 09:03:24 -0700 (PDT)
Received: from [192.168.1.67] (91-163-26-170.subs.proxad.net. [91.163.26.170])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4872712acb7sm83941455e9.18.2026.03.30.09.03.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 09:03:23 -0700 (PDT)
Message-ID: <96d3b045-1cff-4f51-8c30-9db586be82d5@linaro.org>
Date: Mon, 30 Mar 2026 18:03:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hpet: lower HPET_MAX_TIMERS to 24
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20260327204704.424158-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260327204704.424158-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 27/3/26 21:47, Paolo Bonzini wrote:
> Each timer block occupies 32 bytes, but they only start at
> offset 256 of the 1024-byte MMIO register space.  Therefore
> the correct limit for HPET_MAX_TIMERS is 24, not 32.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/hw/timer/hpet.h          | 2 +-
>   rust/hw/timer/hpet/src/device.rs | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

