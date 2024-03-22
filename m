Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F306C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 17:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnipI-0004Df-5z; Fri, 22 Mar 2024 13:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rnipG-0004CA-LH
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 13:37:06 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rnipE-0008JY-SG
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 13:37:06 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6ea7f2d093aso1025567b3a.3
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 10:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711129023; x=1711733823; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MMRs46KCieH0SsPWq1s53+e9N3cdkQJ1ez6yeGH+kLY=;
 b=dmS1Eityy/KF99aa9tKwy+vuP8i7PQSjqokXFAXcJUp5pAzYLfxX5w9z9EoVqe2bXF
 lrXx4L447OA9vDxC21A5sqSehNwaOGlsYHVqI0auO3j1szuZsQg12WZAvxt0pNtkwFiU
 sprW3F256fbywXBvJOBv5XM1+5gD09XyN/fcMXAd6pvIn2dx6pWYvu5wTpE9bftneP4o
 R0R0kqF9fJXn1qTpEMCEKoj9xJpU4CNRKWaxP55xl/UUJesh2N6xE6Vl9UfGG3OgonVj
 28gpBqwZtRPADNbzFpZkZxI029ONc3GnQ1/cp5S9t3Ax45f553flj2/DCoGDpdZk9BqW
 Fp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711129023; x=1711733823;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MMRs46KCieH0SsPWq1s53+e9N3cdkQJ1ez6yeGH+kLY=;
 b=vJbM0MSWS+ck7wXyIW967LOkiwyiW4/HRo8Inkkh9i0xrSu7N/KIAJRf0cwPZD/dgZ
 qHzvdo/L71ZU6RUzZ3YxD1h5nrNvmuMO+Y/rHJOa7kGAivPmsMSfjgrzh0FU4an4zNig
 L5ddnBQuYAuhjK3eAdcKYl4K60f4JchFF8LP3gkbkYfyTT82xWMK7+J9flgkXzuJRYPt
 1sKeatP8W0WPe3pNjP0JdtXHhO9wkZURnAkGgYdGyMzydUsm7hvysgXkOD7Hy71QmIpn
 PRPbGZsX4yXojIJqFMsB11SPqxrcN37PKyzgNB1kDBxx9g+zO8fTpwQYmKkWf89kgZaq
 21JA==
X-Gm-Message-State: AOJu0Ywwjex/wXYI4EjVSIuvhjwRJJVG1HCveyHalm/QwIODPOVwuTOF
 SCTegeAHpqJeVpyEzCwr6rkX63G3ENDAnAzZuzBC+gRnLVg8djh9Av+F1AmbONs=
X-Google-Smtp-Source: AGHT+IGW/foFaldm541guyQQ1KwW37GZ7Bjix0WChYfLq8JA1Rs2Ux9OdNWY7GTjDq2y+tT+H3pW5A==
X-Received: by 2002:a17:902:e810:b0:1e0:9b08:446 with SMTP id
 u16-20020a170902e81000b001e09b080446mr482997plg.60.1711129022789; 
 Fri, 22 Mar 2024 10:37:02 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 u13-20020a170902e80d00b001e00285b727sm2124904plg.294.2024.03.22.10.37.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Mar 2024 10:37:02 -0700 (PDT)
Message-ID: <125cb191-bb3f-4ea6-b3ef-02476d4a47ab@linaro.org>
Date: Fri, 22 Mar 2024 07:36:58 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/9] target/hppa fixes for 9.0
To: Michael Tokarev <mjt@tls.msk.ru>, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>
Cc: qemu-devel@nongnu.org, qemu-stable <qemu-stable@nongnu.org>
References: <20240320003223.554145-1-richard.henderson@linaro.org>
 <812ed94a-1231-492c-bcbb-60a72c059eb4@tls.msk.ru>
 <87cyrnmoha.fsf@t14.stackframe.org>
 <ebd05b86-ba9c-4d66-8a4a-f28dc03d15a8@gmx.de>
 <f4682acd-129c-4695-994d-1cd2cd8a842c@tls.msk.ru>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <f4682acd-129c-4695-994d-1cd2cd8a842c@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 3/21/24 18:48, Michael Tokarev wrote:
> 21.03.2024 21:32, Helge Deller wrote:
>> On 3/21/24 19:25, Sven Schnelle wrote:
>>> Michael Tokarev <mjt@tls.msk.ru> writes:
>>>
>>>> 20.03.2024 03:32, Richard Henderson :
>>>>
>>>>> Richard Henderson (3):
>>>>>         target/hppa: Fix assemble_16 insns for wide mode
>>>>>         target/hppa: Fix assemble_11a insns for wide mode
>>>>>         target/hppa: Fix assemble_12a insns for wide mode
>>>>> Sven Schnelle (6):
>>>>>         target/hppa: ldcw,s uses static shift of 3
>>>>>         target/hppa: fix shrp for wide mode
>>>>>         target/hppa: fix access_id check
>>>>>         target/hppa: exit tb on flush cache instructions
>>>>>         target/hppa: mask privilege bits in mfia
>>>>>         target/hppa: fix do_stdby_e()
>>>>
>>>> Is it all -stable material (when appropriate)?
>>>
>>> I'd say yes.
>>
>> Yes.
> 
> Picked all 9 for stable-8.2.
> 
> And none for stable-7.2.  There, just one of them applies.
> 
> I understand most of them can be applied still (it is just adding
> new lines here and there, the same lines needs to be added to 7.2
> but there, context is missing so every patch needs manual applying,
> which I'm not feeling confident doing.  If anything of that is
> really good to have in 7.2 (which has de-facto become an LTS series),
> please re-spin it on top of stable-7.2 branch and send the result
> to qemu-stable@.

This is all for hppa64 support, which was not present in 7.2.

r~


