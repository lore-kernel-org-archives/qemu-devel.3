Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C5B9C3ABCB
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 06:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF5MJ-0005DY-2q; Wed, 14 May 2025 02:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uF5MH-00058k-K3
 for qemu-devel@nongnu.org; Wed, 14 May 2025 02:12:49 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uF5MG-0005tr-0k
 for qemu-devel@nongnu.org; Wed, 14 May 2025 02:12:49 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a1d8c09674so3595293f8f.1
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 23:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747203164; x=1747807964; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pJP3i5Ja4tsH+USF3De857L3YIRU0Q0edmiA4knXpsM=;
 b=j9QKmwB9UJSN1O48zXT0VB8F0vGZSi98Ce+d0k68s2aYLBEqbmyroiLg+XpORbb29M
 8vHnHXO7BzCRztB6Fnc/ZLvQ3NVHMDCaembBV9PerDYOuGWTGoqh/OFLIeFMK4eQmsQH
 cPyKpbvxEabbUcDj8ru2j4LraYoRcrTBKHYCZT+NgCu8B2bPKGtMs9DeoRjnz8fCvn/B
 HWMSv2a4gnhN8D3+FTpRfMA9k9FvJewAiWpShG+Wn5ZD6EGSbbKOZ7sqxIeiMvw1H8gC
 8NzqRdA4V5jFnp8U1vC3qrAMj387gwBPnzCMiB+k4Gow3mlS/J7NFREziRRA2syaX8+L
 7GCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747203164; x=1747807964;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pJP3i5Ja4tsH+USF3De857L3YIRU0Q0edmiA4knXpsM=;
 b=USlfLVAHRSoHX8JJiatdOVUzpHXXvNjWfONN1g0OTKxhxO+vFnw3AhHTp6YGefETBR
 9/H05Lsng+YR7tHSmPXOGYa4bOADIAlNSCg96HAlvujda6RO0K3e51nuoYEZv0zVwg/f
 k19/ra6LRdOp0+KhFbTCjS8ipousKyVRbJ0VyxIpgN+qI+KBrt7hPwI0PxDIXkncJPDw
 bnt6CnNVsqSkOLkGvIajhDx20NLbjprrnQCfe63AIRT2Yzu+VEv3PMGYvwUZOLqmWMkV
 sHcZdnEO5OQgStlluH94UGRVxbLEnVeZcaMiGPf/idXT0xX+wnvST1rLyfeANuqqt8RX
 1lzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9fe+MuKZesNEVNKXykQgCEfY7ZjF23ZFWqhKKBLwTguGAT6J9v8/sbwITn2lioEt4KKvUqLJ0Hgpr@nongnu.org
X-Gm-Message-State: AOJu0YyspwTedA4AwJqZ/28hvlJtnHWMKJoimEwX4YHOR/PwHXEFMfhb
 W5+ylxC6in6ihT8ERI06pj877X5Tx6+pbLUW3/GflZ98r1OFiDMArAUhkCS6R0A=
X-Gm-Gg: ASbGncvCPQLPB0v2kxUafGON3sWO2Rk5bLyTXo1sQVGbRGl6AOscKHnjnN7xtY1f19I
 MCUWsF9rg3Tktqr/j4DCh5hqRdOoQrgoT93E33iAChpQQMPfyMJZSRjxs6q7snvfzi89QNFk/yC
 wT9I8wbC+5vgcVyi8wuolQhMHWr60j+AHrwVAeuxKm510OgGzTFI+hewuHIBBNyidCOEWJzR+7/
 BJ2YvDYStu+3MfLUKyidbunYGoWTPDN9r0eFHRnbVvx0SZIMYO0BmidE8C6GUiusq/0q1DXepda
 Yj0HuVjCnm9N8hm2ncw6YSWGuTtOloW1Yzs1HtmPX/fzBhmMhX1ACAl8CQN8XUyzx4v2pcCvyCh
 i0yIBTkNIANk/1vzqtl5SqIvGLYI=
X-Google-Smtp-Source: AGHT+IFzSspgMHWhdre95XZ6yQu1fgkJ9p1RBBf5WV6Mv83GrLrzzzr2HXymO3TbBPUm9gEG14WDGw==
X-Received: by 2002:a05:6000:3103:b0:3a1:f537:9064 with SMTP id
 ffacd0b85a97d-3a3496c0063mr1511833f8f.25.1747203164593; 
 Tue, 13 May 2025 23:12:44 -0700 (PDT)
Received: from [10.61.1.204] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f57dde0esm18762430f8f.18.2025.05.13.23.12.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 23:12:44 -0700 (PDT)
Message-ID: <2be48d40-809b-4c3a-b528-e712bb6ed1fd@linaro.org>
Date: Wed, 14 May 2025 07:12:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 30/48] target/arm/ptw: replace TARGET_AARCH64 by
 CONFIG_ATOMIC64 from arm_casq_ptw
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
 <20250512180502.2395029-31-pierrick.bouvier@linaro.org>
 <91cd9b9a-8c67-47d3-8b19-ebaf0b4fab5d@linaro.org>
 <39c6f5ab-6e45-491d-a0e8-07408e29e2f8@linaro.org>
 <cb2798a2-e673-427c-a83f-2afbac59751b@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cb2798a2-e673-427c-a83f-2afbac59751b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x436.google.com
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

On 5/13/25 18:12, Philippe Mathieu-Daudé wrote:
> On 13/5/25 19:03, Richard Henderson wrote:
>> On 5/13/25 03:41, Philippe Mathieu-Daudé wrote:
>>> +    /* AArch32 does not have FEAT_HADFS */
>>> +    assert(cpu_isar_feature(aa64_hafs, env_archcpu(env)));
>>
>> Why?  This is checked in the setting of param.{ha,hd}.
>> See aa{32,64}_va_parameters.
> 
> I suppose the "AArch32 does not have FEAT_HADFS" is misleading then.

It isn't -- aa32_va_parameters does not set param.{ha,hd}.


r~

