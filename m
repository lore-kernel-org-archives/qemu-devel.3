Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E51C5AD49
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Jun 2025 08:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOBPC-00033L-H9; Sun, 08 Jun 2025 04:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1uOBPB-00033B-GF
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 04:29:25 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1uOBP9-0000bv-W7
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 04:29:25 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7481600130eso3446779b3a.3
 for <qemu-devel@nongnu.org>; Sun, 08 Jun 2025 01:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749371362; x=1749976162; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=csUJbLlxJ1s6rdrgxzhinpBi7XR0Bej4xTK7NbGJ6sc=;
 b=iF+NvsNC0C7pndNvAFrejWVrdhptQPxRnpgBZgQMu8Urbs2uKEGWCQ2LjHUGIvDyYQ
 YW+ErJ40E/oAUrZ9vKsk/0msrel3U8cLsdoBBkSDeKJ/sR5NrDCex2/1CXMaE+HjWYvn
 gM60M8LjAAZ2vclztT5oKDyB1OQkwMKa9hx5MP2bJMnvTzHMZt59lGnJ/u4vivH+aCwr
 Mnqw+ENGuAg4enC43wqznDWvOtzFmbzKAJkcwhXS57uI88Dw40rh/tthsWCPVa31iuMV
 DHsZOebfVuTr2nDSKO7YiYxgCASaMfvXUEIGZDuQeiAHfONzN9L8wFo1PVgusIaDl5OO
 S1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749371362; x=1749976162;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=csUJbLlxJ1s6rdrgxzhinpBi7XR0Bej4xTK7NbGJ6sc=;
 b=WTe3GT2YnmMtyZ6BsFu2VJ8tmShCqRbtUqaReTjq23S6R8UR6hSiDgsNsNNym+8CTd
 sVyJhTb2Thbv1wGPzOCy1LrAAxlCCT0JfqiHDM92VwsYFjqlNif2A7Pwkmc+q4FPawvP
 cuNtp1EfV1PES4Vb1sVFq0Jkx66rIuRQUjvSW93/VmY5yBO5tr0nSHrwpo3reNwo9tw1
 1CMZtdF1BJcQxuaRoJmGEjwA8zcZryNSa84gmkAtimkhgH756fFfiRyHZMrgCmKTAQtG
 4sKX4imqH2MmjqjeqMhDevlBO6QRXCDn4zrWM242O38Hc63jUw4S/pp0IYOoNNLErBt6
 bjzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1WntAMkMukRcVD0JLXyRmlF9xeApJPyVC07/7IkBwl3lesYh2LB7xzjp3trAstG2tdcKA9Uiwm6LY@nongnu.org
X-Gm-Message-State: AOJu0Yzy7wZ/DhwMfL94GG0Tfdsx9aBDeFvQjvahu52rwPDgwVarQApR
 wGApppfVsgc7nZdaOWAAirF2Oyepl9wP9OM4/9+YEXDTxULvr59EnfQf
X-Gm-Gg: ASbGncswhmEu/eCJHZekQGHDzLq0gV9hIwT/JY+91cTblS22SyXO8gAWCvYWlz5Uy1a
 PTNGx/p/YbLbBoBKpxddgSSf4towFyzx9sHWF3ARcSj+mPwhEnyHtZcOfNKvt3IVqnREO6jfj1i
 53dYs8bqyvhY8P18zIlaub1D9YKaHHOqJ81ELDz0cahXaUDSW+MXrRld8l6FGf5RzM1gujDa+wE
 V12G0RXPy3D1xVzH1zzaLgvZ54Z2/CwH8GSKWYoNu6A88GI9o6Q+3TTPbCM0G1ZMsj+2xDIbxhf
 u9WQLzb21KH8jZ+nHdLGq1ZqE5GHwYLnjWu+Ewuqp4Slv4N3maarZ3lQHCbSRLJDuAwaf7Wjkg=
 =
X-Google-Smtp-Source: AGHT+IHBAvBTQzCuUkzg1G3bRh/XQAw6mlAXox8YLrNS8nPXUdDfwacPB0ucrJd9HKD7pezOP4n1Hg==
X-Received: by 2002:a05:6a00:23c7:b0:740:a879:4f7b with SMTP id
 d2e1a72fcca58-74827f15a8bmr14222443b3a.18.1749371362192; 
 Sun, 08 Jun 2025 01:29:22 -0700 (PDT)
Received: from [157.82.203.223] ([157.82.203.223])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7482af38267sm3795066b3a.2.2025.06.08.01.29.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Jun 2025 01:29:21 -0700 (PDT)
Message-ID: <59d1c34b-6015-4e0f-a0a6-7caa419ef372@gmail.com>
Date: Sun, 8 Jun 2025 17:29:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 13/17] include/exec: fix assert in size_memop
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250605162651.2614401-1-alex.bennee@linaro.org>
 <20250605162651.2614401-14-alex.bennee@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <20250605162651.2614401-14-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On 2025/06/06 1:26, Alex Bennée wrote:
> We can handle larger sized memops now, expand the range of the assert.
> 
> Fixes: 4b473e0c60 (tcg: Expand MO_SIZE to 3 bits)
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-ID: <20250603110204.838117-14-alex.bennee@linaro.org>
> 
> diff --git a/include/exec/memop.h b/include/exec/memop.h
> index 407a47d82c..cf7da3362e 100644
> --- a/include/exec/memop.h
> +++ b/include/exec/memop.h
> @@ -162,8 +162,8 @@ static inline unsigned memop_size(MemOp op)
>   static inline MemOp size_memop(unsigned size)
>   {
>   #ifdef CONFIG_DEBUG_TCG
> -    /* Power of 2 up to 8.  */
> -    assert((size & (size - 1)) == 0 && size >= 1 && size <= 8);
> +    /* Power of 2 up to 1024 */

I suggested using is_power_of_2() to remove the comment entirely to 
avoid hardcoding a number. Please refer to:
https://lore.kernel.org/qemu-devel/eec76ce0-c3ca-48ed-befe-e0930d4a39d9@linaro.org/

> +    assert(is_power_of_2(size) && size >= 1 && size <= (1 << MO_SIZE));

size >= 1 is unnecessary because being power of 2 implies that. The 
comment doesn't mention this condition either.

Regards,
Akihiko Odaki

>   #endif
>       return (MemOp)ctz32(size);
>   }


