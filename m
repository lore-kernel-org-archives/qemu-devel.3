Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC36C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 18:50:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubOEM-00029Z-BH; Mon, 14 Jul 2025 14:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ubN86-0004dn-Qh
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 13:38:27 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ubN84-0006k9-Vc
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 13:38:18 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b350704f506so3577952a12.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 10:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752514695; x=1753119495; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d1uDIEJz0HplCU+tLHkXO4wim3junl025RN6GrmGQZc=;
 b=OSu+pQt1JrdcneysJd26jUC8WXXcbYBhw/Ovolv3TLAPu9y75AKSFtDcLpMtKOuZST
 8oRAOAncdNDuVAZmOecN74phPWY5KH1f8cR9z8bOyh35gbBXpdXA1fSZ/DPvl9YlNETi
 nCZNAtxjwEaHfy88ia3Y7Od9aOIaKEGtu7vz2dwzAY1tHU/GD6MZKtFlQOOYuUfPsR3b
 udCpKhsD+0G/vL2ukH7D+8HGdaVWu1+tZTeQm8yxurky+Kh8DygxU3jjdIFi+I/LzFkp
 bpBDcnXxuxECHXhpHC/gCQqFi2FKUXqaWm2lOT2hcmiV2w9LVG3/e5WHvZmXViiiWS7l
 eh7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752514695; x=1753119495;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d1uDIEJz0HplCU+tLHkXO4wim3junl025RN6GrmGQZc=;
 b=eyst3ez6A4B/gX5N8iHYSRrajZpKwpCnPr8RrUrVbINgmPhVJ8AIQC1j/CRnvjTlTM
 8k5QIaiY567t3yNM4pQDRKQVktok3cgEwWmIpxxgJkuzQ0zwPqsWZ3tUXRjSC0CY1XZv
 +BSa0L3ga/zDYGYdKuZ9qMSPmNdjYjN7dTFa71URKfw0OKi/PRdzIYBk8dLmFsPnizCd
 XuzVY/q/brLMk31y5q3UEd2xELuAwJmmqaEtkEiciVwOxZUM4e6KZwLlx+oByzQbWAT5
 ijOW2cgE0JVDPg24bxb+gHgI6TABRMsG5sQj6uTs+EEnHzzUoU6GEgJ7QuPNKAIUDZL/
 iHQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuxfhb9tFigirVBJJfFry9y2nls1Wtsg0UM7diY9Gz+3bx1PO/OO65SD3HitSNnFfK0m6EfWU2DLtK@nongnu.org
X-Gm-Message-State: AOJu0YybYVvf63MHd6TJZ3+uUU9RqaHigaP0jZu6I0c4NYTHy/+QbqRu
 jg2LREG1hplaM2BhgqlF5I7I/T+zG9GfU/n36s6FsubjdOa5Is8Vge2kqAfPb9wPWTtkW8UgN/z
 EE7xV
X-Gm-Gg: ASbGnctDvlrAjzLLo3O3aCkNwiwtgyea5VEPRlIjoacKj3a2wsmYGqzM//bkzdcM685
 eWzxvbWkT1yKg4c6iKEP8uIknqopeOvVIm6CMxY9zkdpDItJ0RQA39f2B3NZPqTR3SJjp3L7xgB
 FfjuafQfxoBn9tHlEaxTfTH+XLBMudZ3HAbXXsn+afEXEAPB6yaDgwoES0CPBh2plGpHDyCMpeA
 VuxrrF6kFon2k+1jSctpzmVmGE82BXAZKmFYQhxKJ3zaBwp/40GhoyEK4OTiYwHoHZ/gkFWAU+Q
 JhkOIn0xfXaFMIAD2BDgH0YsiUJszVG1vQ5ZXzoqIiZWDIyAJFPvJR4IFPjYUYuP25VI7ohNf/Q
 yyuzJbrAL4FyWMht7SwDuciDxe0ALDZgPGa/dUaUElEBwQw==
X-Google-Smtp-Source: AGHT+IHoo45OHhT7xUt80Y/e4IUBUuZ78BoWpQyAItUV1bXq1DyXsg/sLRB6TjDc2Z4GrXSsoUeNAw==
X-Received: by 2002:a17:90b:1f86:b0:2ff:4a8d:74f9 with SMTP id
 98e67ed59e1d1-31c8f865e22mr572610a91.10.1752514694586; 
 Mon, 14 Jul 2025 10:38:14 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c30069171sm13496040a91.16.2025.07.14.10.38.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 10:38:14 -0700 (PDT)
Message-ID: <261c8c14-7df2-4ff6-8952-216555e0a557@linaro.org>
Date: Mon, 14 Jul 2025 10:38:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Provide always-false kvm_arm_*_supported()
 stubs for usermode
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250714135152.1896214-1-peter.maydell@linaro.org>
 <0b438773-01b9-42e1-8edf-2330e50387f8@linaro.org>
 <95b00393-bdd2-4db3-ac39-02a09f83b4d7@linaro.org>
 <6f0cd2fd-2152-4c28-8dd1-ca7271e686f4@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <6f0cd2fd-2152-4c28-8dd1-ca7271e686f4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x531.google.com
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

On 7/14/25 8:52 AM, Richard Henderson wrote:
> On 7/14/25 09:41, Pierrick Bouvier wrote:
>> Indeed, clang does not fold the condition "value && kvm_enabled() && !
>> kvm_arm_sve_supported()". Looks like a missing case.
>> This code compiles with gcc -O0, but not clang -O0.
>>
>> extern int f(void);
>> int main(int argc) {
>>       if (argc && 0)
>>           f();
>> }
>>
>> As folding is not guaranteed by C standard, I'm not sure it's really possible to file a
>> bug. However, since we rely on this behaviour in other parts, maybe it would be better to
>> rewrite the condition on our side.
> 
> It's probably worth filing a missed-optimization type bug, if that's available in clang's
> reporting system.
>

Sure, I'll post a bug report on clang repository.

> With my compiler hat on, I suspect that GCC generates IR like
> 
>     if (argc) {
>       if (0) {
>         f();
>       }
>     }
> 
> in order to get the short-circuting part of && correct, which Just So Happens to fold away
> exactly as we wish.
> 
> I'm not sure how clang expands the expression such that (x && 0) doesn't fold away, but (0
> && x) does, as evidenced by
>

For gcc, the simple GIMPLE tree is identical for both.

int main (int argc)
{
   int D.2775;

   {
     if (0 != 0) goto <D.2773>; else goto <D.2774>;
     <D.2773>:
     f ();
     <D.2774>:
   }
   D.2775 = 0;
   return D.2775;
}

This is the LLVM IR difference between "(0 && argc)" and "(argc && 0)".

  ; Function Attrs: noinline nounwind optnone uwtable
  define dso_local i32 @main(i32 noundef %0) #0 {
    %2 = alloca i32, align 4
-  %3 = alloca i32, align 4
-  store i32 0, ptr %2, align 4
-  store i32 %0, ptr %3, align 4
-  %4 = load i32, ptr %3, align 4
-  %5 = icmp ne i32 %4, 0
-  br i1 %5, label %6, label %9
-
-6:                                                ; preds = %1
-  br i1 false, label %7, label %9
-
-7:                                                ; preds = %6
-  %8 = call i32 @f()
-  br label %9
-
-9:                                                ; preds = %7, %6, %1
-  %10 = load i32, ptr %2, align 4
-  ret i32 %10
+  store i32 %0, ptr %2, align 4
+  ret i32 0
  }

-declare i32 @f() #1
-

We can see it elides completely the if as expected, given the right 
order for expression.
On a side note, the first operand still needs to be evaluated if it has 
a side effect (especially a function call), before ensuring the shortcut 
properly applies.

>> +        if (kvm_enabled() && !kvm_arm_sve_supported()) {
> 
> 
> r~


