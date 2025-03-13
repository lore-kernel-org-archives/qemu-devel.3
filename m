Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C060AC28B28
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 17:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsmfl-0001kG-6p; Thu, 13 Mar 2025 13:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsmfX-0001e0-Sg
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 13:48:33 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsmfU-0003jH-8S
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 13:48:30 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-394780e98easo861748f8f.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 10:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741888102; x=1742492902; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7+eWOnTVQOPlSGz1RQ7STD6CSHsh65cbHNVy0RvmYdM=;
 b=SbwBkg1yzpB88dOwvqL57T7Bg1dj/zVZ0ZkANAA9NbvIiiKH6SRDTLkOoscLHgyKNz
 8Scwao5b4shsLLpm+ViVAm6K19qJHXtMIAeqjQt4Hg/8IKIk/wmbLgbMivti+mvcBsCQ
 8WtpAJ2gCuF+zJVqFOWN5w6Y1NxD8qNE3FpqgWk+EOVkpCr2x4BdEBJ9gJWBxQ38nmxH
 nZmjyT48YcJi/BtI9TRmINZNJ7M1EXZ1qvyb1HQrt/W90slbCfOg3W2wAM1lIfR5nJhx
 s1mv8C8PS8jqhrnKbzcOgYB8rj+wz7/pdQ2x1bGFPgHfxts8D+1eKmuD5YKFNzvF2UiV
 dVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741888102; x=1742492902;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7+eWOnTVQOPlSGz1RQ7STD6CSHsh65cbHNVy0RvmYdM=;
 b=wKzxwmj1INXk0U0oY4+U3j+Ai6Sk62cDfF3m0Crb7R2UeOsXYYT6+lpCDNOMB/zl3L
 46ggHchV/EfkOZ9IgesjQJasXavI7YdsK7u3m8QLkaIy/89bGIwMiaFWqMY60lPcE8Au
 islbggqUwrzhTwOpezGNO/2da5BPZUszAuDEVZPnH1aFxA2TGc8keEgjugCpDfCVPxaf
 ROZH49a7IkrQ3X7HNQlzeeX4dGd62LoIXFtbJj9zj/ZLwiT8O878ypsnN6a2tL0ATfLz
 eNN3jjTMsBruBu4iXoh++A4PNIiPbAFhmTXIn6ZhMr05tADSSYKGVVv+Wb58AYz6rX+J
 r7HQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWb0jsk0E7VbtunZL/IFiu1oTTs2qOS6SDNPf0KZsiX93w+NjS8JUzER25aw6jScBuROM75le1H+WQD@nongnu.org
X-Gm-Message-State: AOJu0Yx1pKAXHYgLK0YvZIA01HdXHhXccPVq0A2H3jFdat6u9Th/YJLd
 N7EB74RDL+lKluI847BhBwZTJayebpV0sJWxE6hFZ76E7Nk8ewOAKy+WgEmH26g=
X-Gm-Gg: ASbGncvoanXKlCTyzVE5JEylpc5P2zYTbB6KsLX48OFDjlMpLwnhz9i0uOuGBUvMH6a
 ThCyuU55ydBSWOaw5tl7hMCFl7AOhdmqpMvrqA8gcCKb2p/BEk4cNZQpMJZ3Ukz9Nx9ehPXBlJu
 BuJ/XKUU4FmUsgcVJT9LR+VaPf2AaTuTEDVGx7UzK08wSVqBDkTXiRzIibvTgD6jnMBiMDm0Xot
 5MSK98Em1UTMZXRorfnyfM3KYVIqXoX7hfva5mZp8Kg6N2WFwpSuZAiZWPP7O3XcriX2pf6ZU6M
 e5lilAxATZtZqqqgrBXHgWgG5O/RCwpQoV1VS0ij6zT+d/hfZmuvQ1Gu8+EHi09yxrw1PbHsEge
 SHYUWcKl3E2hSVOA=
X-Google-Smtp-Source: AGHT+IFkbdJ2BJiRVWalm1NYAvEUDtqii/VPSLbGj5ZxT/nUy6ITe4xKCHu/kUtmwI51yMlheTFpUg==
X-Received: by 2002:a05:6000:1fa6:b0:391:3d97:bd33 with SMTP id
 ffacd0b85a97d-396c1c264c6mr531567f8f.13.1741888101711; 
 Thu, 13 Mar 2025 10:48:21 -0700 (PDT)
Received: from [192.168.1.67] (91-163-26-170.subs.proxad.net. [91.163.26.170])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c8975bdfsm2771298f8f.49.2025.03.13.10.48.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 10:48:21 -0700 (PDT)
Message-ID: <5215233a-d2d1-4cc6-8958-2e7fb3b8e2a3@linaro.org>
Date: Thu, 13 Mar 2025 18:48:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/37] accel/tcg, codebase: Build once patches
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Peter Maydell <peter.maydell@linaro.org>
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <04c5bc51-ac5e-412e-b77c-a52c5a90be13@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <04c5bc51-ac5e-412e-b77c-a52c5a90be13@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 13/3/25 17:36, Pierrick Bouvier wrote:
> On 3/12/25 20:44, Richard Henderson wrote:
>> All this is working toward building accel/tcg/translator.c once,
>> but it got late and I decided to stop at a convenient milestone.
>>
>> In the process, I discovered that we have already added files to
>> common_ss which indirectly depend on CONFIG_USER_ONLY.  Sometimes
>> this is harmless, and sometimes it really is not.  For instance,
>> plugin/api.c is affected by different translation-block.h layout.
>>
> 
> Maybe it's finally a good reason to tackle user/system at the same time 
> we make the rest of the files common.
> 
>> The only solution I can see is to poison CONFIG_USER_ONLY outside
>> of specific contexts.  I hoisted some existing magic in tcg/ and
>> gdbstub/ to build separate shared_libraries for user and system,
>> as that's the only way to add extra command-line -Defines.
>>
> 
> It's a good approach (make common + poison is what prevent regressions 
> and ensure we progress).
> Working on target code, I found the need to have a common-{arch} lib, 
> allowing to share code between variants of a given arch (arm vs 
> aarch64), with a specific define too.

Are really ARM & Aarch64 different architectures (QEMU wise)?


