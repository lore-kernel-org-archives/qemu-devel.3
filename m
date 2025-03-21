Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9775C36002
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 22:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvki8-00011C-1h; Fri, 21 Mar 2025 18:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvki6-00010u-AY
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 18:19:26 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvki4-00021a-Lc
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 18:19:26 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2243803b776so27987305ad.0
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 15:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742595562; x=1743200362; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2m5L+7pt7GeWrU7Kt4b77ijay6+lliI8NzQ5LxIHZMQ=;
 b=yscsbzga+fle7C7NDQgpGOqrE4JHykylraujAIF3UiwKBa/X0UZkVnyE2dSd12aJNH
 WRCzu8yQiA2OZRSIG8wL9X0anqI2mqqTf96Gr3NcOi+tnEPJvj4S2bM8ok2xn+CISauK
 Ot1H09UW0oZ2IVt077rdAtupDo//tGwbu3HRS9Tmu5CXq99YM5Dwxunqx0nE8sYW+VeT
 d6IdArvpvC5z7/c4bFLEid+e6t/qVTNptjaR68mTzV1zjFeEa96LSJqX2jfQdX2wFmiZ
 BcLgWb/q9m39b9dwv9nEez2lwTLEg6LLV1t7j3/xEuhnQs1kTLwmJExvEF9XtpmPVke6
 kQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742595562; x=1743200362;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2m5L+7pt7GeWrU7Kt4b77ijay6+lliI8NzQ5LxIHZMQ=;
 b=X5aEdSP5bt8T9Q6pxjQhdH1qq6XMLnS1Rn8ilmsFcj6kZPwufZCqiQRLgCv3Vrdh1V
 VkHSjM9iKd10UJQhBzdmiiU7itrAQXPpLf9iPYOTSLCIg9S8njBvcpdlQAniod65wb50
 G2u6Vzqe55SBKxNrQLMZ9rdJz0cdMi6fSp/7khDwxPLLm8CdNaE6XsYgQPyf2sZKkum1
 iMvRIRYjGPER30p2vduSHCFTiEzbZaZ3pOew8KQmjrafMTqGKYl3aXywHnfdDUXWkN9M
 i+o90Z7GOnnlpjgon2OR9UX+tSVPYGCrWjzxIhWzru367lY4M8FsWQJPqIfrTzPsA80+
 V8uQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRy+nQy7hocuVbUEbjSLIQOLNAKc1W+pTJiyw1hkygkdLllRChlJdenZ0qCBF0miLi+1mJcouj+U4i@nongnu.org
X-Gm-Message-State: AOJu0YxdVTa+GAaHJZdJXeK2A6Sxau/Nm7bKcnAPFUG4nQUqPfNds9K7
 PVaqW3p1aaDvp2PfzIu/OL7sZ9Yz8zEzhrZUCR32mSViHG7/dN0G1M0SWwZapc8=
X-Gm-Gg: ASbGnculdg05h2J4P/NhkrbmiDYoamW0FEy0V+CRRL9otJJYVDNUt4LL58pLbrdKlOK
 h/5M/MV4IlGSK70sj1clMsxA3i+zVDdeRbsR5kfX4QgUdc/tgQShUmtRxzObYJK55i+vtlrfdts
 SU4ndTtS6InW0CYZY7nBd6C9Ykgyraj8VNFmCXc6g/g9M8ywzZdoLoSkqw+wFD3xrNSAr/WocB4
 mgwmEOzvFiDF4SslKgZ1VDObzGECcIslCM/DW6yu8ae/nnN107HODbxnqxr5HbgYXp4B54Q3p++
 xhXxJnK3YM0QN4hp8sjvWZphTSCMEQ0hiJ3IFgRrUJmEukxgl4O0OYwY6Lo/DVZKBxtTRNn1lFd
 zH3BrsaLsJS92FnKp9zw=
X-Google-Smtp-Source: AGHT+IEW6cQdABbMHDm5Jw4zpDdOGnA50ctGXbvRzVQOXJyT4XTYONXfp+PmiJ5E+lNB/pujFV4exg==
X-Received: by 2002:a05:6a20:2d23:b0:1f5:6f5d:3366 with SMTP id
 adf61e73a8af0-1fe434371c4mr9545558637.37.1742595562592; 
 Fri, 21 Mar 2025 15:19:22 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af8a28058f9sm2346075a12.24.2025.03.21.15.19.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 15:19:22 -0700 (PDT)
Message-ID: <c0e338f5-6592-4d83-9f17-120b9c4f039e@linaro.org>
Date: Fri, 21 Mar 2025 15:19:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/30] exec/target_page: runtime defintion for
 TARGET_PAGE_BITS_MIN
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-18-pierrick.bouvier@linaro.org>
 <2e667bb0-7357-4caf-ab60-4e57aabdceeb@linaro.org>
 <e738b8b8-e06f-48d0-845e-f263adb3dee5@linaro.org>
 <a67d17bb-e0dc-4767-8a43-8f057db70c71@linaro.org>
 <216a39c6-384d-4f9e-b615-05af18c6ef59@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <216a39c6-384d-4f9e-b615-05af18c6ef59@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 3/21/25 13:11, Pierrick Bouvier wrote:
> On 3/21/25 12:27, Richard Henderson wrote:
>> On 3/21/25 11:09, Pierrick Bouvier wrote:
>>>> Mmm, ok I guess.  Yesterday I would have suggested merging this with page-vary.h, but
>>>> today I'm actively working on making TARGET_PAGE_BITS_MIN a global constant.
>>>>
>>>
>>> When you mention this, do you mean "constant accross all architectures", or a global
>>> (const) variable vs having a function call?
>> The first -- constant across all architectures.
>>
> 
> That's great.
> Does choosing the min(set_of(TARGET_PAGE_BITS_MIN)) is what we want there, or is the 
> answer more subtle than that?

It will be, yes.

This isn't as hard as it seems, because there are exactly two targets with
TARGET_PAGE_BITS < 12: arm and avr.

Because we still support armv4, TARGET_PAGE_BITS_MIN must be <= 10.

AVR currently has TARGET_PAGE_BITS == 8, which is a bit of a problem.
My first task is to allow avr to choose TARGET_PAGE_BITS_MIN >= 10.

Which will leave us with TARGET_PAGE_BITS_MIN == 10.


r~

