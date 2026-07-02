Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E32C43327
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 21:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfOcf-00010i-Ax; Thu, 02 Jul 2026 17:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfOcd-00010J-5g
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 17:06:59 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfOcb-0000cp-LC
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 17:06:58 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2ca70925c25so25235795ad.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 14:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783026416; x=1783631216; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mCywSbIJrS9QlOe5nL8lKZn0bv2GdkeZrb0iODuwdS4=;
 b=jFh66dfj0OdvUWxfvIcPz65IHDU0425aXwAd207eYSp3J4tBNxw/lPvzWlT1dX18iz
 DEhfZpqEIaJffZze/kUkMNIlmwJ4gYTcrxShwXNTU3OdKIo7icWBDhtVTcCbVCM0OJit
 BI5L2895TLAJCbam2ECMAPn3x9ntBFEy2F+ZcTOlpvqlm1LzOgupBHPUzo0pKGCEpcQu
 TT/h+6wJZ+u7fTmebgsNt96L5Iz/5dMFdiAMpbmuNpOkzy7JVU0hBhvVgviFnuap0Y/x
 5xTujecYlWUONGSb3vJ2xRJ1zqrU+ZZ3X5EoZVSxRz0MaJeQUasYnmoJ1Mm5JYD8F9YP
 7yjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783026416; x=1783631216;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mCywSbIJrS9QlOe5nL8lKZn0bv2GdkeZrb0iODuwdS4=;
 b=KW6cHgGEkRAP9uKnAEYuC1SFBkPpxGQZPnuXmeStZfV+17okvm9/5XXdLQ1zDR7ztl
 oHLkstQgnumCkYbaMGpDr5SkbEkeAW/nuXCM7iM+51UsF0+ffJZNaeNnE6oOmC5ogaHH
 o6k7xNXaemm2qkI5vd1EgrQEp3dfMh2RNeTUWiqRa8va+Yj3eBHjFE2chv/TvJEn9uiJ
 R08FtShE5Ut1KKS7TycIXb5zpGUjFlvBBUb80kKdnLsXGCTqWVaDffjcdTXQuvBJhcNN
 W8YoAuZPJpkMcja51y96kdU8sOqsthxY/Aqfpba1HVbwa82MDWhh3Rn3ZCdhx75wm5Ig
 d9AA==
X-Gm-Message-State: AOJu0Yy89dA2+lTHORA5hcK01sZilFgiwIEPzQ27dm0/XR/3upcDZhFJ
 zSJptIHqZCZklXf32A+YGaMdb7vTrDw6D+XgR/lhpbO3AZ9serrVJjXm589Ks52MoOwdC9xPTP6
 WNG0Z
X-Gm-Gg: AfdE7cmjEB/seAOFB/jCmXW2z6Efh1I4fC2Z8WZBAPikG9/ttbJCRusUfX1UxGhYFwy
 v/YAMsNjgQW2PQ9PBXgAiSlZcgvooO94Ky8pqnAxGV5Jb0qxRGUd/M9PFPmyAw3265+dIdmVuDT
 6kjsZ1hPBSMj1x/QzE3D2Ug41+ogpBZSAT4HptfjZsorc3M1AC1XqnJjD5hH9R2JBwbEYEb+yU3
 ncQGrnNcAE7/za1H8a+6aSMsuNoshInm8br4gl6ZP4dAOc82GqmA4K47R9RfJDG6kXWchBIBvLf
 0EiDjkfJhDGpB4jUiAIrZ2SdFUl3FIcOFAP0rgJDTl9S7MWLpnN7HFb0AtqddYcSZz0ckrpvXZy
 pmykj0/aMhK0ANsLIJqT+m20hboRYjrrju6mfgvgSKJZR73w7TLDX+1aw6i1A1FxUYmTtTJ7+JD
 z8YDtn3+xGN+XeOMH7loTPPv0L+tzpzVF+k2WytIYFz+hs5WkDZgUCNSzgSlfkzbDNH4VG
X-Received: by 2002:a17:903:17c5:b0:2ca:a03a:29b2 with SMTP id
 d9443c01a7336-2caa03a2a98mr50119505ad.8.1783026415724; 
 Thu, 02 Jul 2026 14:06:55 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca9a9e96a5sm18687945ad.63.2026.07.02.14.06.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 14:06:55 -0700 (PDT)
Message-ID: <29f6156b-f30f-49be-a71c-68e1eea7d533@linaro.org>
Date: Thu, 2 Jul 2026 14:06:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] target/arm: Handle NSACR.NSASEDIS in HCPTR accesses
To: qemu-devel@nongnu.org
References: <20260702184019.3431139-1-peter.maydell@linaro.org>
 <20260702184019.3431139-7-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260702184019.3431139-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/2/26 11:40, Peter Maydell wrote:
> In cptr_el2_read() and cptr_el2_write()  we have code that implements the
> "HCPTR.{TCP10,TCP11} behave as RAO/WI from NonSecure when NSACR.cp10 is
> 0" behaviour.  There is a similar requirement for HCPTR.TASE: if
> NSACR.NSASEDIS is 1 then CPACR.ASEDIS behaves as RAO/WI in NS.
> 
> This doesn't matter to us yet because we don't currently implement
> ASEDIS or NSASEDIS. But we're about to do that, so add the handling
> to cptr_el2_read() and cptr_el2_write().
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 23 ++++++++++++++++++-----
>   1 file changed, 18 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

