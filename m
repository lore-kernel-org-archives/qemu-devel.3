Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FACCD1813A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 19:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Qmn-0005yx-Co; Mon, 14 Oct 2024 15:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t0Qmg-0005xe-MJ
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 15:31:18 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t0Qme-0005zd-Aw
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 15:31:14 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20c714cd9c8so35059795ad.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 12:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728934267; x=1729539067; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i1AEL1iCDF9gEmhg3gccpp0WV6U4G1Xodmz32GJKaMw=;
 b=zjuyFB0OmiQkTRrZ3CflQxO0937pTI5c2MRVuwXeyptg/QZPTcfX+CcRmj6pd9e3O4
 y3jyHGjjJuIgjGRy9wGg8i/aaI5+Be3DIKpYHo0N+kjgeiuIq7XYPpwmzpEeqtxUdDP5
 3S3inSRjDSZNd8Mt4XgP0e0c3hAFFBbHWjdKAwYb+6ho2HdFYrOeTWpWvb8ku6Xo32BM
 wrzqXmUtJNOW54HNgQ3tocwEwPAVZqIAnAU3zZ++ui6DDrPyTjvU8+rnMEaGDkCaFSxH
 +gqfeC3xySn+GHNahYdX7sKwECvmhLTAVNMkal4CxnCFCuOK/a6/pdbNkihz5mGcMoKz
 JR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728934267; x=1729539067;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i1AEL1iCDF9gEmhg3gccpp0WV6U4G1Xodmz32GJKaMw=;
 b=vWt/UAxLmSTMT1vGMuIY9r/gZnYqXPF30xoDg2j5ARsuVsyzSq/mpbJFtLQQUUN5tz
 D7m+DU2dyYDdX1T0q2gWL31hMpZUzcSGs7Y0w+hIEXXlGMrvzh5OEAx+fmIXrydqwAK4
 0Z2P3Rriy1J414YR2NqiAyLxU6mndN0MWBXLLfebMQUdpytbURbgnvWGqj/21dvHFCxK
 n8PE7jpPi0hXTA85nTn6yw7gO7CZxAYcNg9fWXRakgBOnfle4E0mRaDMBzYHfHdeVogB
 6Wyz95kU/wyf5E+d7Y29bgdGsDBO7gXpCpVAbUQyGRNsQVNZOaiwnDpPgBCqaNGuyAcS
 23fA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOVNt60rAn70h5zrO8/Bvv6bJFxIjPNoGP+VlLCqHl8sOazqFL36FIQw82yfCcZTUVeBnxk1VyF1+j@nongnu.org
X-Gm-Message-State: AOJu0Yz4xI8RixdVyqoEdK8iH3qzBDcrDpQ3VDrG2cHEb1izPNSEz9I3
 zxDxPemtqWobiB6z1qHGr8vG9lnLchCvDhf7o2kOWhqKm3UL+vNuEWbIbaf+ZjA=
X-Google-Smtp-Source: AGHT+IGNwfPrqX/p12MjjHkL5fhFAF3sIeaw3O1of+XU0hk007UxnEm4B47z8tir6AN7cjGiuEiBDA==
X-Received: by 2002:a17:902:fc50:b0:20c:8c0f:f986 with SMTP id
 d9443c01a7336-20cbb1a91camr125106145ad.24.1728934266970; 
 Mon, 14 Oct 2024 12:31:06 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8c3561e0sm69129535ad.291.2024.10.14.12.31.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Oct 2024 12:31:06 -0700 (PDT)
Message-ID: <b8e76800-e5ea-4060-9e3c-35e8a9f8812b@linaro.org>
Date: Mon, 14 Oct 2024 12:31:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/20] target/hppa: Fix priority of T, D, and B page
 faults
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org,
 Helge Deller <deller@gmx.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20241009000453.315652-1-richard.henderson@linaro.org>
 <20241009000453.315652-10-richard.henderson@linaro.org>
 <4810ac6d-cbdc-4f04-a2fa-895e78cf2fcb@tls.msk.ru>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <4810ac6d-cbdc-4f04-a2fa-895e78cf2fcb@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 10/14/24 11:02, Michael Tokarev wrote:
> On 09.10.2024 03:04, Richard Henderson wrote:
>> Drop the 'else' so that ret is overridden with the
>> highest priority fault.
>>
>> Fixes: d8bc1381250 ("target/hppa: Implement PSW_X")
>> Reviewed-by: Helge Deller <deller@gmx.de>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> Is this a qemu-stable material?  For now I assume yes, please
> let me know if it is not.

The kernel fault thing is pretty nasty.
Fixing that probably requires all of patches 2-11.

I don't think the arm fix is serious enough to backport.


r~

