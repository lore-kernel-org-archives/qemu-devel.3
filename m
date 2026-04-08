Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB3810F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYQ7-0004RE-RF; Wed, 08 Apr 2026 15:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAY05-00052P-9c
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:51:41 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAOeC-00056i-LN
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 04:52:30 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48897fd88ebso46384955e9.2
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 01:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775638347; x=1776243147; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9uUUnxtFBhwO1Macg7o3jj5U/GPlkp6OmGByalmzxyA=;
 b=OHUlJ/2a4DlT0bTT8Un7QnZn1SR5Ja4qaLqnRlt+6nDGrgVkz14YoQMLsOZi0UjKIj
 DVxAdG0ZAPtcQMJ3O1vKvsCUSayfcV02b6bl738AWTuO6lBRqQgSkM8cUT7ugVTLvMFO
 swAqGFu9SqHQX+Kc6rAfQ+mDTQq7JL0Wu96PxeMScD/b6/w1f/2Em8GwFNj6O8xMlVmQ
 JSqSM8rdaaZN6Vjhw5MA9Eiq/teQFXHNwEa0/x0CsQ0Qdv+2oAM4iA6V4K3ImaaMTrde
 fXAtek0AQJifgYfwTc/cH+BvYOqPH6f+mfndxPN9FXBtEwq1cfSZ47qIviXsJz97SX6G
 DKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775638347; x=1776243147;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9uUUnxtFBhwO1Macg7o3jj5U/GPlkp6OmGByalmzxyA=;
 b=njwe8m30v1La5Sg6GhmvocDMLyLtcT6qXFGFRojAoLNP30cTaDwdE/HoHnW1AZmBuo
 TFOLn/bj+j/Uc/93u4E7LD2HXFmyNAXIRbp25lYlRyOwLbbvRj0Y2jgt9/vtT+46AoIN
 8YVRYS/zsOyiRtiwVVerGBJg87GfyWgSE4y85ucZZHWPnKi3CR3Vgb7h9DD3txtxyBQt
 p8wkyE/5lJIH2fRq8aEAun8uCVVrRWs+645kAryb8nN9vaVIV2C9tpHregB+g+CMDzjY
 qcn/hRXbzhLSmAbMo0/YC67PUrwRokKURHGWz3gTeUOGTwM4QKRXSc5cpMnEPVB4oO+1
 zDWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBDn/zph/nX/UsC6pPF2XDRZeEf1GHTYtNcfc5ZuUoJbn+Ic9Xp2Y5b9kpPJMUA4vOqdmkFsSrlBRi@nongnu.org
X-Gm-Message-State: AOJu0Yx4GT84U1n2ooeBVJiW1o5E882OBHTwMY3yemg99hsKJd8sZgnq
 +Vp9YqiQLIYW8qnOFIt6N1XtG+KDYp5qfyQ+ZWjwRROxYldbuJqxAsDrPDN4ZvZVdM8=
X-Gm-Gg: AeBDietdj/AFymJrpC91e8ahLEVfNMoac01NsuMSPsrj1t/neoc7u3qLgw4ELM35+Qk
 m7fGiqqVvhprSb0Q7+WukppGjexZrp2u8LVi+nes4qlPTbsQmqqDoDPxi1wQpEY4EUXjQabLGsC
 gW0ZE5VoiyeA6MCgck16KNgMtDQmWHvndShANm/0ApkHnj60N/v1Ad/TKTJB2YRcxvWqVhvGkpv
 eb0ft/glBKsacc6vVoauD7XJqp6JC/ia7DJ4JbVgl2ObSb3DcJ/yillxCI3atQIiqE4udnuYe9u
 ZmXnmAj+NQQyi5Q+IHJpoXIWX1frcKlStmkrqB9sXhKRSFgI18USWjSaA95aIH0JgGn+zvwp1GI
 5flU90b6DKfmyNhqotktMAhYcHGeGkUB87u7eLlYJeT+Ves+meUplPAynVOmLLErl+IwU1+2U77
 7iNBB//BmxW7y0Gdm5ALty4HIq//LNFDXxFnM2XBpm0ghSDIkl1a1f4PPsb8un/QvN+g==
X-Received: by 2002:a05:600c:1d86:b0:488:8b52:f7de with SMTP id
 5b1f17b1804b1-48899715a69mr241607675e9.12.1775638346927; 
 Wed, 08 Apr 2026 01:52:26 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4f52easm58094329f8f.36.2026.04.08.01.52.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 01:52:26 -0700 (PDT)
Message-ID: <7cab0763-c744-44c6-9488-3191869cce6a@linaro.org>
Date: Wed, 8 Apr 2026 10:52:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 19/20] target/arm/tcg/translate.c: remove target_ulong
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, jim.macarthur@linaro.org,
 qemu-arm@nongnu.org
References: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
 <20260407022748.57629-20-pierrick.bouvier@linaro.org>
 <614088dd-edfa-4cef-aef1-b697c8b4aaa2@linaro.org>
 <ae93b673-7969-48be-818e-086ca39fa1e8@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ae93b673-7969-48be-818e-086ca39fa1e8@linaro.org>
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

On 7/4/26 21:56, Pierrick Bouvier wrote:
> On 4/7/26 12:16 PM, Philippe Mathieu-Daudé wrote:
>> On 7/4/26 04:27, Pierrick Bouvier wrote:
>>> We can replace it with uint32_t, because we know it's limited to 32-bit
>>> target.
>>
>> That, or widen to vaddr for consistency and save a "why this uint32_t
>> type here?", anyway:
>>
> 
> It's really specifically uint32_t we want here.

Well, the caller pass a vaddr argument and the single callee also takes
a vaddr type, so sticking to vaddr is more meaningful but probably a
simple matter of taste at this point, I don't mind much.

> 
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>    target/arm/tcg/translate.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>
> 


