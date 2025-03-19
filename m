Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C00AFC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 23:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tv2nN-0008KA-1l; Wed, 19 Mar 2025 19:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tv2nH-0008G1-FF
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 19:25:53 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tv2nF-0000wZ-Gn
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 19:25:50 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22423adf751so1647085ad.2
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 16:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742426748; x=1743031548; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vjfR9UwecaSn8yWmmPZcnLHVsPnQ7Q3oWoSlhpoapEQ=;
 b=iI1hZsIywlexJryxBo0pwDqTF5rItXoXOuP0h2oMCGsywyfPkQ1nSdv0j401l+gbtO
 nzoE0Lw+pdO3TOEFf7RKZNha84mE2+OhbpnQzuW3CHCclZFyD3rDPY5nHYENKJKfhH/u
 r5Zx+doNr5FT0ZJb17tSnro1ZruxrzvlrIw7Quqygw2R7dURtvBm1+gczG9ZJNd255nM
 Kf10EfxEQQ0bgzwrR7C6sjdKAdhbsiT8JnbCpgeNL+JTtvAs+s5cDYCWWjrZdOxQ/oqf
 LWeEoa3NNCzqc3oOXftujaBM5WU7hcLNAmqn1b80IxRHXhIbN5+5YbSyPQGZMrsUCCYr
 VvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742426748; x=1743031548;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vjfR9UwecaSn8yWmmPZcnLHVsPnQ7Q3oWoSlhpoapEQ=;
 b=qz5U+SNpewGqy7g0J4+8mx7pz4UIeyW+tRU1bGX0QjNRnY12FKTJv7RXf1GTsYjWab
 TZSk/QGRysvP528ZiyXH7vLG97vQ0cgMtXz2UsZQM2hb2FP5N8ZNQXdpIc+x/GxP7dZa
 YrLtNhfLUvl81SCMBMoBKIvon+D+GE8O8c+EkO1T9J3WkasiSMGxAK8AJ3N+tywUmXYt
 0alE/17jJvU8EJZOSAA6eun4RqgaHcpxq1+aDfnaBtkTe9li7Hwce2N2Y4ahEbt2UQYw
 wAzZW95efK/2oR+bNYGvR5b/inQwmlQE9tZynbB3GC5DV9KWtm6d/m3qLfqtonIe2qmd
 BCjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoiPMIHwa7UtO5vG6uPnHCZ7LAre43JrPXXoS7CI/1xZ9Ph724tXWmvj9OFCMGMGdU9xLHwVm6Qkwo@nongnu.org
X-Gm-Message-State: AOJu0Yy+jMNBynYMwgLwxASrR3a0AH4jQmYl+jI9JdjuBYlAr2BNgNvj
 IzhnpgEDptQKdlGEqxC+AIUIyQJjSpbLtDHCaxnpThZtouuVBtZ6K/IPJ319GZE=
X-Gm-Gg: ASbGncsEvS/00SRtNFwuJNf+RWk2X69HY0Os7tDhdguNeZHyrCsMgEkkT1EqgyutTNS
 cVd6rrDynwWv2rCQJIHizFwjgApUKlcxuy2HMq2oKD4GTbeQYdH9Uy9XWwAFUeIF3VFm/xeDFVg
 nMlvJTIMUWQaNS8F9b/Cv0x5/6A9A3dzwL715s5AdxuslQQI0xjA7WTEm4aIXh5RA+7g84CJNiP
 IUEAdRbGmi7afx4aac10BCrPHmanZsrseur4D67vAcW4o+jA6FYMKDkgdzPcaMXCSCb1xakvRiX
 1i/HrQskTSIU1jBWzfBqpAz6oDN98gBEhM/euTOEl7Wz9oThP+bSWGskKQ==
X-Google-Smtp-Source: AGHT+IFJSivWE9HxeLEiVE+QiZGXG8QzUS2VqFdO5auKLYIsHhq4jw3PL5s5J4DC4SaIBehnDY63Fw==
X-Received: by 2002:a17:903:2f8c:b0:220:e9ac:e746 with SMTP id
 d9443c01a7336-22649cb45b7mr67889955ad.53.1742426747979; 
 Wed, 19 Mar 2025 16:25:47 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c68a80e3sm121661665ad.83.2025.03.19.16.25.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 16:25:47 -0700 (PDT)
Message-ID: <a4830467-1096-4d62-a57c-33f6bc05423f@linaro.org>
Date: Wed, 19 Mar 2025 16:25:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] target/arm/cpu: define same set of registers for
 aarch32 and aarch64
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
 <20250318045125.759259-11-pierrick.bouvier@linaro.org>
 <2b438e13-b377-4b4e-a4ff-0b219d7f3964@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <2b438e13-b377-4b4e-a4ff-0b219d7f3964@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

On 3/18/25 15:45, Richard Henderson wrote:
> On 3/17/25 21:51, Pierrick Bouvier wrote:
>> To eliminate TARGET_AARCH64, we need to make various definitions common
>> between 32 and 64 bit Arm targets.
>> Added registers are used only by aarch64 code, and the only impact is on
>> the size of CPUARMState, and added zarray
>> (ARMVectorReg zarray[ARM_MAX_VQ * 16]) member (+64KB)
>>
>> It could be eventually possible to allocate this array only for aarch64
>> emulation, but I'm not sure it's worth the hassle to save a few KB per
>> vcpu. Running qemu-system takes already several hundreds of MB of
>> (resident) memory, and qemu-user takes dozens of MB of (resident) memory
>> anyway.
>>
>> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
>> ---
>>    target/arm/cpu.h | 6 ------
>>    1 file changed, 6 deletions(-)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> I think this could easily squash with ARM_MAX_VQ, since the
> rationale is better spelled out here.
> 

Yes, makes sense. I'll squash it.

> 
> r~


