Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22747C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 15:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvHag-0001p6-11; Thu, 20 Mar 2025 11:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvHaC-0001ft-Do
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 11:13:21 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvHaA-00052b-5O
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 11:13:20 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-225b5448519so17696825ad.0
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 08:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742483596; x=1743088396; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YCS8O4MmUem4w8mHqxQ9TRwcBYWZ95XyUopa9nTs86I=;
 b=sK/zfAF3be+2/5+bZV6qQCdHHEkm1PVLvXUooAnHE2IvcAsiiRWd7oUTaJkQYj3Kur
 iYmYWPKgyLc9P4XKp3Ai6weHGzmbbErvlynkhc8hp4Ts1w0EeFucKQazyEBZf/Bb8rwX
 YRe/rDKKWmeTHy1ui8a6Hs9eSPpjnrolEmX8MGCNn62Y3YkgIdIcpwUWVpV1Bs5+2eyr
 b8oL2FxBuyynT1BYho7u25Ii5qpzh0EYBL5QAQDT1MR001uwlPfNLsjbEvmYEDrbnoYl
 4e1kyt5TQoeRfCXnaXDOVsQpas6gZob5rZPG0g84nd+iSSgbyZXJ/VqgN5eUe/mH+Ezb
 vPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742483596; x=1743088396;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YCS8O4MmUem4w8mHqxQ9TRwcBYWZ95XyUopa9nTs86I=;
 b=CqXoC8LwvXjxtzErvPlMMBQkFsl/JVyLATpXJnXFcknfLnRNpfn+3wMAXIg8GjyjP5
 63L3Ips0IWA+HJQVy9tlbPRE2+UHCzquWnoFd0fgMlI7IfSAR6jPfRqm+R+IQO2RqEf2
 Bbrj/tI5zEpR/39m58pzxeP//ChBsImII1GXBNkzNbVM1eqCizBCm5pXMQ33N/9X/4Rn
 qTDo2azq9PSXmUlMtmfeXLqhhaXAEcwxOWkadzzKM3S+QaJVBCCfMx0gDWB+UpOhqvy7
 lv7CT46kwjbrgGD8vfwpGR5++iSX81xSOkSVZPaynhoypdH0zvK+9207COzXynV2oBDW
 vZ1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIG6gugJAPA/u9/pi0e+9I0PbZkaLdXLHey7OYoraOlCMlnTJKzc0eywkXsH0jvJ/ua7WYeHfBki/h@nongnu.org
X-Gm-Message-State: AOJu0YzV6xGSbdQMxM2KfQtR2rTNxXQ6zzGAX0hOexBrjjHI+2+B1s7U
 Z5fIk+4RV/wAzXdLPmQ1pXb65/I675u+WXpzzVbaoCKjhV7vVbCBhc7aTyIhLvYhjH0ENpH+4v/
 5
X-Gm-Gg: ASbGnct8nXH/u75mYrp3OeFoVJQXP1RQ1VdyAKl5sEGDGh4rmmeFCwzYznFmdilXdDe
 1ha+MK6gxQL4AZUcP+jow4A3JCQwr+sxyAH+R0f2EkZc5u2PmiqC3e00UiIavQKsxB5/KTzkCF8
 NMzTZJwA3zE7pIikmNNnvqMknJdrQRVBgZjAS134wDlkBycMYrKw1lOMVJBV/9e/pBMDAwh5sPf
 NUIjRhlx10Iau8zoZkdOhgbcd3qCy/mglKi4Z6q1PS6fxgwDP6mALeJ6AXiX/0GHcYvZhPmkBzP
 Q6vAAmwIMYrxQGGU7Q+Y0k747zjO5ft9ClU7SrrQdOkKPRwptbbjoLsGdSqbUVuu1Y4m
X-Google-Smtp-Source: AGHT+IGFGJxQVTCsONwW2mZsxbT0Ifv2fjovsf6+KSm8KYd+nfI8vuO2HqJMCtA3APcl/tRocr4qWg==
X-Received: by 2002:a05:6a00:21cd:b0:736:8c0f:7758 with SMTP id
 d2e1a72fcca58-7376d5fec71mr9464886b3a.10.1742483595999; 
 Thu, 20 Mar 2025 08:13:15 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167e07fsm13825116b3a.119.2025.03.20.08.13.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 08:13:15 -0700 (PDT)
Message-ID: <4a81b02a-9b03-49bc-a682-4f5e7f745324@linaro.org>
Date: Thu, 20 Mar 2025 08:13:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/42] include/exec: Split out cpu-mmu-index.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-7-richard.henderson@linaro.org>
 <c76d7019-7087-4522-9b49-bc99fa71436f@linaro.org>
 <b039499c-4c0a-4eb1-ae74-ce1fe5386f20@linaro.org>
 <5dd0a559-388a-46b8-9479-5fdd5a1e8f81@linaro.org>
 <9843f1ba-de69-47a1-9fc1-5dec97329469@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <9843f1ba-de69-47a1-9fc1-5dec97329469@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

On 3/20/25 07:58, Richard Henderson wrote:
> On 3/19/25 10:16, Pierrick Bouvier wrote:
>> If I understand correctly, this is simply an (arbitrary) choice related to each target
>> architecture implemented in QEMU, and it does not match any property of a *real* cpu. Is
>> that correct?
> 
> Correct.
> 
>> In other words, it could have been implemented in a way that MMU_USER_IDX is the same for
>> all arch, but it hasn't been done this way. Is that correct?
>>
>> I'm not looking for modifying anything related to this, just want to make sure I get it
>> right.
> 
> With minor effort, perhaps.
> 
> Take loongarch64 for example.  The system register field CRMD.PVL contains the priv level,
> where 0 is most priv and 3 is least.  Simply extracting the field is the easiest
> implementation, so MMU_USER_IDX == 3.
> 
> If there were some requirement that MMU_USER_IDX be 0, then obviously we could rearrange,
> but so far there is not.
> 

Thanks Richard, that's all clear for me now.

> 
> r~


