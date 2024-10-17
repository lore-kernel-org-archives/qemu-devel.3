Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243B4D374BF
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 16:21:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1TEt-00047w-Ix; Thu, 17 Oct 2024 12:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t1TEr-00047H-Vh
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 12:20:38 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t1TEq-0000PC-HD
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 12:20:37 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-71e4c2e36daso1682900b3a.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 09:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729182035; x=1729786835; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4M1YR2DDmo0rIL5P71LnPIPhdDPeN1EaHFGD8ZjQvEA=;
 b=OGng9gVvSIRGPvpWqUdZeiASpDXdRXrifbQDJDV0jkN6vYaacWwBT2Z3yXBGj0ktEM
 5mUReHSLcoFhSjH8PNpP7TWT1dCcgjJiEI5kzeqodakalJ3LLfi9tMa/+WdOklUEnH0t
 XhAsLZieHIwJhjyyqtlPC8BpLKi9JLVyKXcxI7aBZ4Q+zG6AqfDxw0dm81T4KDLB0Li0
 NPDI5mjIwXSm78Dv7r/Zr5Rhvh015symSZAzFfymnFQoZcGGrw33APhWHF0EQ/qbv6HI
 xPo0VtL0Lw5O+GV64osSWOICnJ2Czc0cq+PA5QPatWFtH0AJQmZUV962Ec3/9I9vmt1k
 OjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729182035; x=1729786835;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4M1YR2DDmo0rIL5P71LnPIPhdDPeN1EaHFGD8ZjQvEA=;
 b=ZNPENRWydSmteWsHsubggxcH8AiLbXK3mnGfniE6JFVxvPZ45BU91oMq5inkr72awK
 wRAL8ZrblxKKuw4sO8Fbvty8IGXeZ91SWdK8kAZvuH5yX9Nm8P6ySKHUm73hy6fyN93q
 Xa06Mld6O5D4F8oKMHotvZFC9+OQBP6yv/gDDA7VAgsb3QpgwRtGhy+JpjR5KfT4hmAh
 HrDrRRp/q7PGU9A3AN00Xjk9iXCQP0YRKYl9f8UY7owHvrS2YhNqqEg5uxNl/KRYnflI
 I4L2weq7f59cNGcgASAepvfIkbOyGAkNnTAJUBLhVkxljedDvHdynYtlRljzYJ7CRemn
 Qqfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHYTgyz7Byuf5KnRZv7zM+Vpj+sRJn9K63C/UvIVgFMWZR7b0JKiYaYajPJfW/t4j045uw4NFDUiE8@nongnu.org
X-Gm-Message-State: AOJu0YxqGbw3YtvFbg5bphBxV0jRRTUFJ7EynoA/LkLW1vKKCdc1U6Xe
 5M7R+fyT6AHGdnXzVa9N4B4vDPNwMuu4jzTP4AIumIau2Pl9Bna618DE2k5tX7K/3o3Lp5oegN5
 R
X-Google-Smtp-Source: AGHT+IGVNnBBvoD2gndyhI4hsMUSGDFN9JdObOaDcfkHvrjzBzInGxn+UDvfQikTb7F/pw+g+6Td5g==
X-Received: by 2002:a05:6a00:8906:b0:71e:427e:e679 with SMTP id
 d2e1a72fcca58-71e8fd5e1admr5538518b3a.4.1729182034843; 
 Thu, 17 Oct 2024 09:20:34 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e774d2a0csm4922963b3a.181.2024.10.17.09.20.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 09:20:34 -0700 (PDT)
Message-ID: <743f977b-88f8-42f5-aa2d-e205394f4dd2@linaro.org>
Date: Thu, 17 Oct 2024 09:20:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/s390x: fix constraint for 32-bit TSTEQ/TSTNE
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20241017091401.783102-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241017091401.783102-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 10/17/24 02:14, Paolo Bonzini wrote:
> 32-bit TSTEQ and TSTNE is subject to the same constraints as
> for 64-bit, but setcond_i32 and negsetcond_i32 were incorrectly
> using TCG_CT_CONST ("i") instead of TCG_CT_CONST_CMP ("C").
> 
> Adjust the constraint and make tcg_target_const_match use the
> same sequence as tgen_cmp2: first check if the constant is a
> valid operand for TSTEQ/TSTNE, then accept everything for 32-bit
> non-test comparisons, finally check if the constant is a valid
> operand for 64-bit non-test comparisons.
> 
> Reported-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   tcg/s390x/tcg-target.c.inc | 24 ++++++++++++++++--------
>   1 file changed, 16 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

