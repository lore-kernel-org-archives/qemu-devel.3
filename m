Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390ECC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 19:30:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thZTi-0007eI-WB; Mon, 10 Feb 2025 14:29:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thZTh-0007dc-G6
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 14:29:57 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thZTf-0008Ld-Sl
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 14:29:57 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2fa3fe04dd2so3817936a91.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 11:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739215794; x=1739820594; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VD0lxv9FCpImfW3kesQ9dC/2nGwHmnQx9EQTYWMxpLk=;
 b=Y75PuJZxqgYFDoyHm7ITcH7R1t514OUDL+TN4G3gKOQh/o74DjVsAX4Zids37HEeAe
 sO7w0zNCleE9gMPdXTcPpyjo/i9M9b0Io5YEIKDRBiOA8XX6qoIIf7Xs+CpWn5N0Dxkl
 DRzqCqUtAHUYze+TUzxU1hfOqepa/TIJ9KzqZaMbVy3Jz/iF/7O3Agr7BT0AbN8XyDVS
 ACLTazBgBvC2Sm8RK32ABFkO6I48FZp5iyXebfq3sFblwjGdAhSCV/5EDI4gP/8ltRaG
 9aKSzdLbH13GIPzD49syzNYFqSB5bqvDA72K/EPE8z2GUEypCw8TBYLMzzdq6Aa3xc7l
 m1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739215794; x=1739820594;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VD0lxv9FCpImfW3kesQ9dC/2nGwHmnQx9EQTYWMxpLk=;
 b=tzlKzhrnTvilNliwUv8JoB8TrxgdVdJzryy1glZMIpd0zHFa8e7rFelj/nEBUmuo9w
 tPNMjPRgxHbcQzCvIJmFIJZ7o0D+EXcMJ641r4F4ZHG78gvrIQCjiKmN4cM636988V56
 uCU+bBWTMo/yO6iYvxHffOWIXdUlLeD2gum+r1zRxwyuozVTuAdc6jN7YvXKAbhT+gXe
 RsgGgElV/vaCHY4PAv9wWyIJ9CjvmOe/F6bJXvOCBQpdfS1r4UbfbvkvdbnK1n/9p+YQ
 Ze2tf7aSSRQDf93Gjjo39OS3QztSRS8NMKJjTE3YHYrj5Lg2sdVIWNEkJ4gLhYWub08p
 zzYw==
X-Gm-Message-State: AOJu0Yxm8/24r0Wh09Y7qAyX3bOxEXCKfXGn6n9EAJ46xsUTe5y+FI0W
 lQDeOr/slbRxEtOUGCluM/DtcvlGznid3YemRB7xwJB248VSxYl7C5zlBdLtTzBXRxu6Hy9/zPt
 t
X-Gm-Gg: ASbGncuRkzdNhoc+75ohJZiWIAJHriif0fbGNDJieoD1T+dwCXRZ7y2rvBnTNYwPB8s
 bUMDs/s/hkgkcUdSoJk5GCSuuXi5l8UqwRRcq/hHtWhX9p/Yq8IkxaaRiirmFTw8/uNPn0ETrUS
 KnEQCvsjB4FrZsrn69kxDynaNXXrXXUW7vWWx9hzHkxnCFoPvy4Rhkd/FS3yj5Fg6qGEee4Caqd
 uf03TiyGBeEIQR5ig5hIpLIsPRJecyUDuiVi1Fx2cYqNBqKncbO4WhEa9mobOBaI/G+q1tzc5E1
 NL/mAoJnPJac3mAdCa2jiKVmYs2snXUTdhZyyGSv20xbzhR+P1IvcKc=
X-Google-Smtp-Source: AGHT+IERfbjZVgBvFl0RoAMG0ReNQSHYBTO1kIFeg7PIdKcJcqgkuuyD8eT6bY6oxQJ2mEgAhSm7Pg==
X-Received: by 2002:a17:90b:4a91:b0:2ee:44ec:e524 with SMTP id
 98e67ed59e1d1-2fa243eeffamr20402680a91.35.1739215793989; 
 Mon, 10 Feb 2025 11:29:53 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa0942d30esm9055058a91.0.2025.02.10.11.29.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 11:29:53 -0800 (PST)
Message-ID: <171769a2-bd1c-434b-923b-5c0a9a3608e1@linaro.org>
Date: Mon, 10 Feb 2025 11:29:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] target/arm: Use CP_ACCESS_TRAP_EL1 for traps that
 are always to EL1
To: qemu-devel@nongnu.org
References: <20250130182309.717346-1-peter.maydell@linaro.org>
 <20250130182309.717346-11-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250130182309.717346-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 1/30/25 10:23, Peter Maydell wrote:
> We currently use CP_ACCESS_TRAP in a number of access functions where
> we know we're currently at EL0; in this case the "usual target EL"
> is EL1, so CP_ACCESS_TRAP and CP_ACCESS_TRAP_EL1 behave the same.
> Use CP_ACCESS_TRAP_EL1 to more closely match the pseudocode for
> this sort of check.
> 
> Note that in the case of the access functions foc cacheop to
> PoC or PoU, the code was correct but the comment was wrong:
> SCTLR_EL1.UCI traps for DC CVAC, DC CIVAC, DC CVAP, DC CVADP,
> DC CVAU and IC IVAU should be system access traps, not UNDEFs.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/debug_helper.c |  2 +-
>   target/arm/helper.c       | 30 +++++++++++++++---------------
>   2 files changed, 16 insertions(+), 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

