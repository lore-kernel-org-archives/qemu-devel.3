Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A062CAC5B0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 19:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v57TS-0007ZW-7o; Sat, 04 Oct 2025 14:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v57TF-0007XZ-B5
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 14:59:09 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v57TC-0006U3-V5
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 14:59:04 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-32ec291a325so2708866a91.1
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 11:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759604340; x=1760209140; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w1ms9llnuJmjmHrm29nMb4SYndF5DNaRZj1VCllhtC8=;
 b=CNVZHpl5ZaKaHFOxIs2DIHh3oq9wbH26E4sPG6vEhrUxwOSHjBasjomsfUvhTLgIwE
 Dec32yLUvoqY18PEAbyRTOd1E9kbJe7+ViuTdtnqLmjEljB2L0KpWWeoIBeKh/+QQd4x
 NP2zqNugHvASrU2OmX/toz2ONNjjvsPYB+1XlkHwVGMigjEJKWO6K0eS3VAIjKXmkcA1
 jSFpbiRbmChX24Srikd7iWLSkfPOxAPRfMWk0uAnQaj+VtC5Ay5fHp1n1pDXhWO0yzzS
 IZL4dC39BeaaEhU3DoMvDGjTQSboKaW9adWDPJ0dOZFMFBmj2u7XwOx462L3qDDvZ8hv
 W/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759604340; x=1760209140;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w1ms9llnuJmjmHrm29nMb4SYndF5DNaRZj1VCllhtC8=;
 b=rJ4Ouv5TEB4u95m1u7hi8O72ZWjeL/OLH72892Ck9CpqmmCE3zPJqHStuQC9LD8m69
 iZHJooU4zsf6RUgUGzrkLgCRADLsYBG9KNZsOQPuzo6F2JH6bRodzehupy+xry4E4Hj9
 N5aJFrt2oTiB0QY/owYXVRXQkmQXvqRY7+FzCd6SP32/FtyRNFVlFk27/9cI1gnqPx1G
 /dNxsMa+n8n1Y9QJ8zYNr8zbMn6pPGnrreqCMvdTOCcexl9zkFTBRYq65GwIMlVah003
 QJATATuy86Kv697Zw6tjHwG4hxQRsSF0q69NZ/7WjZBMMD+bxzudbcqKNW7GTxwSvmOC
 IfnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLuf+V3r5OBFf7vnYtjoDxdPRQqRV6RMmJ1m7q/JlGWZvj6kWGIsesVqfKYe9f9DOAvHXZ+xm46+pC@nongnu.org
X-Gm-Message-State: AOJu0YwH23ndUXgPcNKIfSNFNKQ1745pRtxhe5NJ8fmP/c76sZKbJps6
 +itJBM77PJOaWzKB7o9ib7hiIhjTAtDSbDxdc44B/CxXyMUU1wW2xq78jESHJY/X0wI=
X-Gm-Gg: ASbGncsVthjyDbSS2MeZw8RBKu1v0i0ZL4m/OcpCfLk9Gi3e7OFHbP/j7uQuYwPwlsJ
 fB097akOvacl2qtqvT+cBOJMPm1SvtPPBCEyxexXadfpg3mfB+Qeu3OZb/GcrItBCnWZEANKlMs
 RgDYdWLpPgA93GF36QdnKoeMgIsa2xXRVpGjUErCHGtgSwGtjX4h9NUQiBIetHrTazByaWWLmLy
 VNPPSTxGzUH6r0f8QVov/6HengBpQD1z9BFUHV9/+T7FGG1kGqG+2ehqHmZZEotusVPffrJcrOl
 75GFnToAzIV5tiIs7vuG8pwVhmkrnrZn+80E5D1N4/tMsuxkbtKNE/D0qJqy4V0vj8Ac5dif9Ax
 xjq765BTJEbIDinVIa0i6gcMdyUVM27RfRwZCj1theEeriB/H/Vwdclrfd3+1mRga
X-Google-Smtp-Source: AGHT+IGX2hLdSUkldBGsqc9VhXyyTjlnrbyblbanKvZO971S+wsEjBDvJcchPLbYnz6wicSlVRQrPQ==
X-Received: by 2002:a17:90b:4d0f:b0:330:604a:1009 with SMTP id
 98e67ed59e1d1-339c27b950amr9080176a91.23.1759604340302; 
 Sat, 04 Oct 2025 11:59:00 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-339a4f15857sm7157628a91.1.2025.10.04.11.58.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Oct 2025 11:58:59 -0700 (PDT)
Message-ID: <1acacf21-267e-4655-8635-4389afdf6f38@linaro.org>
Date: Sat, 4 Oct 2025 11:58:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 18/28] target: Use cpu_pointer_wrap_notreached for strict
 align targets
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20250528081410.157251-1-richard.henderson@linaro.org>
 <20250528081410.157251-19-richard.henderson@linaro.org>
 <dee8def3-3ff7-4a86-8bcc-430f3775c1c3@tls.msk.ru>
 <b48aad39-d408-4666-9b19-e8f1fedf1a47@linaro.org>
 <a7182f42-eaa1-4130-87d9-3931e388deae@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <a7182f42-eaa1-4130-87d9-3931e388deae@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 10/3/25 23:52, Michael Tokarev wrote:
> On 8/30/25 06:11, Richard Henderson wrote:
>> On 8/29/25 16:55, Michael Tokarev wrote:
>>> On 28.05.2025 11:14, Richard Henderson wrote:
>>>> Alpha, HPPA, and SH4 always use aligned addresses,
>>>> and therefore never produce accesses that cross pages.
>>>>
>>>> Cc: Helge Deller <deller@gmx.de>
>>>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>>
>>> This seems to broke booting debian on alpha, -- see
>>> https://bugs.debian.org/1112285 .  I weren't able to repro it
>>> though, - asked the OP to get a backtrace.
>>
>> Ok.  I haven't reproduced this either.
>> Let me know if you get more information.
> 
> There's some more info available at
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1112285#56 -
> some other debian user reproduced the issue, published instructions
> about how to do that, and published a backtrace too.
> 
> Maybe this is sufficient for tracking it down?

Thanks.  I've got it now.


r~

