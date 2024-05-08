Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5916CC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 22:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4pjf-0002VU-5r; Wed, 08 May 2024 18:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4pjd-0002VJ-2W
 for qemu-devel@nongnu.org; Wed, 08 May 2024 18:26:01 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4pjb-0000M8-A4
 for qemu-devel@nongnu.org; Wed, 08 May 2024 18:26:00 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-51ffff16400so270210e87.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 15:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715207157; x=1715811957; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dbBc98+zFeaVhgd8PdBcKMiD7Ph2Eef9azq2MGlTC0s=;
 b=ed9brEQya8p3LI8li6gFzeqae46PNCUuD3AGdtycjfPmZdBL0/UjZAUNd9XlHlR5zv
 VPZ1lTiRNvUojHLoko9ScwaMzxka1K3iigBCFXCnAzvoSyjapcBouuWqJm/ZzEHFzaDf
 SDcxoIMK66NEQCEsu4Xno+oVd7GnHldW2nRtzb0zV/ucj2i92u03mi1I5QDC+izkWDvF
 iDc74gFQX39Rn3pEAtVPRJEnPQMwQxzuMDgnFpKLTQuoTkDz/sEWDeizYKcNdN3PpSoo
 yOZszRKXUE6w7T+N/XEqh9wkbEVti++9E7TwlZu5LMhMQPFOgmTRROlj67PSiXV/njWb
 eL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715207157; x=1715811957;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dbBc98+zFeaVhgd8PdBcKMiD7Ph2Eef9azq2MGlTC0s=;
 b=S2AcJcXE6iuqJWMH6PewskU1y9wEJIVgXeOWa9ojkyg+b45vEwip+WYvTyNUNZB15f
 kIeNZAEJDhQ/v9XIHK210uKTr4LynJJWvG+cEXpMeyNkFdiUcgw+GcsBKhD1NNJ9oLGs
 RLxV5nYO7baVl26XsdhCi4wAEUh5VY8p3H58ISag2SD1cgjc1UAf/Y8ulHz50Bh+v55Q
 1Ir6xz7oG2BhttvRLwHGpdXwBmleFp/aGQ3A09KyqJO1XPcajJ8yyu7IetRSEXw1PifB
 k0mQjOxsyMLm+f4SVns9Cg7zkTGgBwhGx3/LidWUpa+9ESS1bXIrZ1xaYnoKXZWCAroS
 Tc+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUT+5sIE0Tdm92dlcqqWgZ7bIW3y0HVbHakQE5qQWiTINvD7ZPJFKcM6im2cWWDFtwOFjBeIlq5KQ/QdB73vCOZvEf0u9I=
X-Gm-Message-State: AOJu0YyYa1iejlcniQdr907MDTDLDdVVLWRuLx6Wi1gjyTdc0JatK4RN
 PGas3RbYPLcleQlX74Fo8/vdNH4Dqo1q60DUDgsu7YqRktsR21QwPtD31UtYpFY=
X-Google-Smtp-Source: AGHT+IHry1z4SuJTN+G0xAgi9aZk0iDqX/FyP7dv0+Hu6AASpJWwfhnIqgC4Rd4dUY7a5oYEnSvC8g==
X-Received: by 2002:ac2:48b4:0:b0:51c:fd0a:7e37 with SMTP id
 2adb3069b0e04-5217c567393mr3288258e87.20.1715207156578; 
 Wed, 08 May 2024 15:25:56 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1781cdb5sm7750866b.29.2024.05.08.15.25.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 15:25:56 -0700 (PDT)
Message-ID: <ef295b83-ae04-4b5c-abae-b1975933a2c4@linaro.org>
Date: Thu, 9 May 2024 00:25:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitlab: Update msys2-64bit runner tags
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com
References: <20240507175356.281618-1-richard.henderson@linaro.org>
 <f754d4a9-f481-4da7-ae7c-edbb013f55d9@linaro.org>
Content-Language: en-US
In-Reply-To: <f754d4a9-f481-4da7-ae7c-edbb013f55d9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
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

On 8/5/24 10:28, Philippe Mathieu-Daudé wrote:
> On 7/5/24 19:53, Richard Henderson wrote:
>> Gitlab has deprecated and removed support for windows-1809
>> and shared-windows.  Update to saas-windows-medium-amd64 per
>>
>> https://about.gitlab.com/blog/2024/01/22/windows-2022-support-for-gitlab-saas-runners/
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   .gitlab-ci.d/windows.yml | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


