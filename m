Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43173D3A661
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:43:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5oNF-0001Hk-SF; Tue, 29 Oct 2024 11:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5oNE-0001Hc-Hp
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:43:12 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5oNC-0003Nx-Re
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:43:12 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4315e62afe0so57817495e9.1
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 08:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730216588; x=1730821388; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Vgoe2gOtGb/LIYP7gyVU+kzG5Cq6W2dqmQXXDfXw2lY=;
 b=qFvYa9lgqRhFkHQIL6YkHDta+clbtxr0oXgYwt2gZsJkAE8K0c69bHXOouSEJHzE1H
 VnopzGF5+Pi04fgC7ukhIgt8tbppd157vypCpMyTeWXw473QpTYvS5ckvb4RHNRTfo4n
 eELo8sjJmwX6PvH+HtslJOT9Q41UkaBzj2DFaVEtFf3pFpZxiPlrvBPBSjFJtxLRmkQl
 LkR/afSUzboRahUJvR5eO15KfjhF44fryDL1jQR8D83JBI8h60utTONGmugcExtUkyaJ
 ZvLMzPj+G19PGqXJ6IKRBVvfECW209kwZRxeHDwli+KjfdYj7b+NDnPYkC2qUz/FuO+S
 M5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730216588; x=1730821388;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vgoe2gOtGb/LIYP7gyVU+kzG5Cq6W2dqmQXXDfXw2lY=;
 b=CeOMJK9IcFJUp1Cy3IyHH7eXc1NznpyurHELgwgVlws1iwrl1M8Wql15b/31OaFQ5y
 quqQ6t+bsiENLWtS9Dn3cODa7p4D+JvL5C9pVNI2TXfjzOit9XQbvnsbhR4dJ42Vli0T
 Nj2dCFY7WShBkUMxGD4Qr6AQjwsSStLwcyLaeCQQwVpLzGAEtLGo7R+M7idaCOVX3s8o
 XDCudn46nIjI7cBX1Uz6uPvFJKFOKmIcnkZ1vTDJ9W0zvcAdQMX55SCLOsgKED6tFuv7
 0VS3D5S6cIkBce/bjg+Mk2bG+mbgRJ4YhzmIQ69UBPdsjJ2OiveMX5HPx+Za8gCBZPzG
 HxSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKSkfkJGSikQQ4l+kHFgDVC12keEO2vuv+ei2LmZu16CrnT/neCYemiGD7gJt4gVvKARobyRRWXXIP@nongnu.org
X-Gm-Message-State: AOJu0YzoLiqvuaICxJnbh1ROTXWa4QTOL6W201832tshy0QTg8Bm2BDw
 NfgxoBRaPmWVUrzj8JVPaws9LxmzubebHYbSFQC4QFvpmS2P3fnnZja/hkhTFQs=
X-Google-Smtp-Source: AGHT+IHt9ZaHPZxFPPUoLYxJ+XX/fK8WO1+5hexLDakMQz//B0gniWfhRE6R5otuV6HE3bbDf2JqsQ==
X-Received: by 2002:a05:600c:1c01:b0:431:12a8:7f1a with SMTP id
 5b1f17b1804b1-4319acadc13mr127155415e9.16.1730216588390; 
 Tue, 29 Oct 2024 08:43:08 -0700 (PDT)
Received: from [192.168.21.227] ([89.100.107.89])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431935f7213sm148287095e9.32.2024.10.29.08.43.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Oct 2024 08:43:08 -0700 (PDT)
Message-ID: <42daae6d-fcb6-4986-a37e-93f36173f2dc@linaro.org>
Date: Tue, 29 Oct 2024 15:43:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] target/i386: optimize computation of ZF from
 CC_OP_DYNAMIC
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20241028151851.376355-1-pbonzini@redhat.com>
 <20241028151851.376355-8-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241028151851.376355-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
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

On 10/28/24 15:18, Paolo Bonzini wrote:
> Most uses of CC_OP_DYNAMIC are for CMP/JB/JE or similar sequences.
> We can optimize many of them to avoid computation of the flags.
> This eliminates both TCG ops to set up the new cc_op, and helper
> instructions because evaluating just ZF is much cheaper.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/helper.h        |  1 +
>   target/i386/tcg/cc_helper.c | 13 +++++++++++++
>   target/i386/tcg/translate.c | 10 +++++++---
>   3 files changed, 21 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

