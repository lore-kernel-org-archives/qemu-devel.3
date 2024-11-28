Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F4FD70DE8
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 17:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGim3-0005A1-C7; Thu, 28 Nov 2024 12:57:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGilz-00059X-8f
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 12:57:51 -0500
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGilx-0007AM-CS
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 12:57:50 -0500
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-46679337c24so7506351cf.3
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 09:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732816668; x=1733421468; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pmSSx3yKTELgLR9FqXOLIdTPzHZ79YewI8zZWJu36ow=;
 b=pFtqfkLk3Z232HFbkfPrmfsP4uhYeWjvwbxNH2iiQe+BHjiYD1Lkh8Ky8wcG4blToO
 0i/jjJz6U3Vjowp4rL6nU5CIlBOsAYPENOy3wOq3+OPcGkkk7MH8u54bpDWYtKi9s9fy
 wxJnct1qDxa1k9buBBzw4z1y7QqL31xRmVX6pVB29jfN74lOBV3EyLmRtYrKpE7paSo5
 Rw9qLlgBRpKoT61EYK4K1CKBnVEBh/3qCDsgZQ05HgPqSYziKstPSBOYdJAv7E4C1UV+
 NUm4Qt/Idkeq2i7tirrplrH/uZlsmzBnuo9AitVXXRnmpChnTxj8KZ1RHgsQNnKHvQ4m
 Tydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732816668; x=1733421468;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pmSSx3yKTELgLR9FqXOLIdTPzHZ79YewI8zZWJu36ow=;
 b=AkWpdrYlS2qh5rKquCJvIaP1Yb1KIdyBmkplpQm3V4voIfms4hoPtPHbbORrF3iXZu
 z8Ni79U0tbAciI4Wofupq5XWzcR3s12/7Vk8rECwiUgepRXCCaYvq3dcCNP+Y26lIM51
 DpJ6FrgTOdUdtP+Q6+9ogTkegX+kSKkXfl8TGDVcrctLfK/FuHDb/XarsXCs0NGw+va+
 BcUQacfwcUpy8f6DCstIzACAxvE/SUudIOtsB+zVFGaOEfWAg0U4vYAV9ccZXKhITivN
 4mro9TLPiETDcBdsAnX/JbJax92okRSu/7qtPMLyJG72nqv/k7Y/5iYHZJYIHixmq20O
 UrSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXD2T2yO83jAFh0aiwHdeBU2XYfIGuhwfoCWg+TL7gUkBi9jGUzHdqAGWQ4po5mNyDiHXcHkLQKiENE@nongnu.org
X-Gm-Message-State: AOJu0YywmgH0GIvdKVaa8PYW7bYBYN8gtCnIfFXJ1LUuwusUyBUAPMOi
 USMNWnKW+ikPjxsYWRnoVZzfiAQBsqnxYJfZUH0ZkCAZs39S1Hi5vgIAoYQg++w=
X-Gm-Gg: ASbGnctlEs+ahU8Bqm2iQouZumLQb6d1TQADc/gvCEmKtLNDPNWpdu1KFxku46abLtm
 wdxzso0+Nrlczk7IBFxIwjXpui29r+5bubiCeIGEBIruEvZseNirSoc9AUBTfw1rxOnfk7tMAbY
 U2z30hMbCgoDInl0iE3/lw5n6tkD7Z40Txsw32wmHqpbSXMhlPCeo1+Fi5x24ZegLppELIehXqP
 9fwlFvhkJQaNg68UvfrZgJUNuGMPWKSLBW2wIcHTZVMVFcdBfreWDRBMVOQebeh4PE=
X-Google-Smtp-Source: AGHT+IHTEbU/aiQyHfMOLnVlQCmE7sraPPe/BE+zcx61J1LMH7nxB2d1ILgI2yi7JKa1XZAw07cquA==
X-Received: by 2002:ac8:5a13:0:b0:466:9c5f:d2e0 with SMTP id
 d75a77b69052e-466b3516485mr92727951cf.16.1732816668153; 
 Thu, 28 Nov 2024 09:57:48 -0800 (PST)
Received: from [172.20.3.167] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466c4054cf4sm8665321cf.5.2024.11.28.09.57.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 09:57:47 -0800 (PST)
Message-ID: <e9951253-bcc8-4c18-bff3-a43f09068d58@linaro.org>
Date: Thu, 28 Nov 2024 11:57:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0 24/25] target/hppa: Set Float3NaNPropRule
 explicitly
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
 <20241128104310.3452934-25-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241128104310.3452934-25-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 11/28/24 04:43, Peter Maydell wrote:
> Set the Float3NaNPropRule explicitly for HPPA, and remove the
> ifdef from pickNaNMulAdd().
> 
> HPPA is the only target that was using the default branch of the
> ifdef ladder (other targets either do not use muladd or set
> default_nan_mode), so we can remove the ifdef fallback entirely now
> (allowing the "rule not set" case to fall into the default of the
> switch statement and assert).
> 
> We add a TODO note that the HPPA rule is probably wrong; this is
> not a behavioural change for this refactoring.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/hppa/fpu_helper.c       | 8 ++++++++
>   fpu/softfloat-specialize.c.inc | 7 +------
>   2 files changed, 9 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

