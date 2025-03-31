Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C361C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 19:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzKzY-0008F9-Kz; Mon, 31 Mar 2025 15:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tzKzT-0008E7-Fm
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:40:13 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tzKzR-0001tt-Fx
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:40:11 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2c2504fa876so1202177fac.0
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 12:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743450007; x=1744054807; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p5QGmjjGn1LDjsDMDwqOYUG1yZ/zC73CVhSAkqxB1ow=;
 b=ciKVQHZPJbapQydCzmCF9XB0L5/3Y2PXn5O5iC/6cCSpdlceQaPh1jJK8M2DArvqcX
 CcMF2lqxQ0NRDfcWvKBgeMTicsCTl6HfaRl86UExcFi90F4pfy8KQo/HM11kqzs8SuwC
 J6HKNprOgQfUig6oeaklkBX5C9uFyskA22pHXEdjjOkLx7ix2CxSWImzNOoUnqlgo1aw
 dAYB629j0UpnV/bX04SRwwABCCyk6zTub8pDP+MScb7St9+mhABtjzY8isjpkE64kype
 u9RYClrMT4NymHYS+owFfiwIHC5qJTFPF0lOl0sgKfQsWqIqtnmMBRPp6RTnM4oeFGsg
 2obA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743450007; x=1744054807;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p5QGmjjGn1LDjsDMDwqOYUG1yZ/zC73CVhSAkqxB1ow=;
 b=nmxMd8yXWvYab14+qMfRxIvthv0DSOJ6t11WcoDDfshLsvvtykiZzsBMA/HDIRU2zV
 7J34zdGazQwsap1Am4wx57MH5PO9iUbMdYIVO7xepQcUx5q4A+AgRCUQu7XXAE+jGjZw
 nKSWQmHIr6YJXXLs0cNF7B3Q2musDLoZA//gq13XtLQfMyXd1h1M0Hn6zAFXWmhiGrvf
 uOzMIs0wYpyx25M+UhTzKC3vPLDjG3Rj5XOXghwK1bCVc7qIKKbNBkv821RMB5zQ3yXq
 OH9ri+X7GeNWvg/qZbmq4NUfjlnc765l1mu9otUJxgVvnipaDUzLINlDk1lhUlOtkryB
 niEw==
X-Gm-Message-State: AOJu0YyangHYbfyvAejthFRr6JAQHI2T7m1p5dSI9p9MDs+JxjZN4/9F
 kcl+jWvLctJU09NzMqASGNXizKDQTcVsjBC4zpwKojixlCsGSzAuPdDgH2jQUIg=
X-Gm-Gg: ASbGncumL1+8jz5wdYZwz+vj5i3Vc0AhdN96cPkBnhLra0w59/LJxyaUk5q286yx4Ox
 4exnfi3AKdw4f/Xmp8GML3WzIZj230pnD3LSmjKsXXGIgq3wKKt2jqHbRkZ0d2StZwkBVD3c5O/
 Zt9kbCRCYDYqn9NNvitdpIoyiuMlR8CEfpFtMwKiO8DkcWNUrffr2xvcF2H3r/8kyWEpcriJPIV
 r5R14UqqMWg7qPEW/UshzGZ2BU4GAl0kVaDCmkGuxupR5gUjFFMax5xEK09WUTKRuFaiXYMmmOC
 HnDfGgKUxuvgoUeIYCWCgkcCIKz/Ys49ai0eQo7urDuv9AwN1ro/WI8Kb67y1L4VhT8Aru4w+0J
 kNjvBOEBooa8fuDwvZRO+e9KB87x5t4Kb
X-Google-Smtp-Source: AGHT+IEi4ZUfoSEI8dHAkHpYT4udVpXImACYWN9H1F7hGE3lStc8egHFYJtHRS9ocFzwAaxun389wg==
X-Received: by 2002:a05:6870:7d82:b0:2c2:5270:f182 with SMTP id
 586e51a60fabf-2cbcf7e0013mr6166105fac.39.1743450006816; 
 Mon, 31 Mar 2025 12:40:06 -0700 (PDT)
Received: from [172.20.102.85] (syn-071-042-197-003.biz.spectrum.com.
 [71.42.197.3]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c580d30e0sm1584826a34.37.2025.03.31.12.40.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 12:40:06 -0700 (PDT)
Message-ID: <6e647368-9fde-4c7f-ac17-d4c4e46fab3a@linaro.org>
Date: Mon, 31 Mar 2025 14:40:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] translation performance improvements
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20250331155423.619451-1-npiggin@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250331155423.619451-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2e.google.com
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

On 3/31/25 10:54, Nicholas Piggin wrote:
> I've been struggling with these couple of performance issues with
> TB coherency. I almost thought deferring flush to icbi would be
> workable, buta note in the docs says that exceptions require TB
> to be coherent... I don't know what requires that, maybe it could
> be worked around?

Which note?  Anyway, qemu implements accurate tb invalidation for x86 and s390x, which 
means we don't really need to do anything special for other targets.

Compare aarch64 "IC_IVAU" which (at least for system mode) is implemented as a nop.

> Another thing is PowerVM runtime firmware runs with MMU disabled
> for ifetch. This means a fixed linear map with no memory protection.
> Is it possible we can enable goto tb across TARGET_PAGE_SIZE for
> ifetches in this mode?

No, there are several things that assume nothing jumps across TARGET_PAGE_SIZE, including 
breakpoints.


r~

