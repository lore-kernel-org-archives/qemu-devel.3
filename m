Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 773B7CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 15:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSd7X-0001qs-N0; Thu, 28 May 2026 11:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSd7W-0001qh-DS
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:58:06 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSd7U-0000x1-WB
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:58:06 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c802803ac17so5394805a12.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 08:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779983882; x=1780588682; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0YtbVMbJ7/kYaiPiSWo3R9mlA50HhSmnhHNUXfkLNpQ=;
 b=FZduDwNIg90UZh9CKPj3dZPwFu6Q69g4+Q4WJXWsCjslqR6Q8CUWnOwXfE2jUPxGK/
 V/XbhffVNLQZYoX9/Cgd12u0c6KtHYqAhW3ApBRg/Mcf4knxdMt9bsDmFEyhWjxX873d
 VErs4kseMzao3bR+O/PYMgUkAiNDv6Tg0ImDE7q1fJhEz75otCyOVwMFzwFJr67TmmmS
 kga2zIGS6X7lSBdBjyM+qCz7ICWFzhYI8oKS6MYKr9aCirkkfQXXuuaGRWPAcrfZsqXM
 2BPkSvAjSrUuZuRZeiSVZufLJTUP4TF0DnyYWMd+eKj/xKUcwlUsYxOF74iHE16FsS9c
 zk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779983882; x=1780588682;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0YtbVMbJ7/kYaiPiSWo3R9mlA50HhSmnhHNUXfkLNpQ=;
 b=hI6xRM0KTig83tUcRp7ASfl5ezCbnUQE6tvtu+UBthhI3SOEDCqJlL2O+wfI/XIAGE
 I46hk+pBmiSonjxZPqLsR2RjxOw6khE12zGrpfDaiQK2/cpGWBEH1UCr8DZw3AlZbTEM
 8sT1TZRbnhRWETVSWEjGgel3cp555WLeZSYuMQ+21sLGp0jTlW3CMzDKTz+Ksl2mVgeQ
 i2bOvmfNPxntRn7QtnDwbmKbRRsKer53CdsXBpXQSswEVVQ6a2wiwQjw/8t0ApCpSWYS
 CQWQC1Af6BEYJ9sQEgRYUkaQjKtyFBqYnHCSkqiZZFGXh7x9hG3O9IUtayef+bIFCLLt
 Gj5Q==
X-Gm-Message-State: AOJu0Yz4WAJJiBQsZwn/wYVr2rkto0JpToCJg6bHd4vAAJfMPSBJmDbx
 DEQK5H5Wq91tekNuL4xXxo/gnZUeH50REh9EcUMiyBZq4yxHaQEhdXqmYAULIo0b3vSbEUwESrE
 MO5EWg8E=
X-Gm-Gg: Acq92OFd4e/IA9c8IMrHQsEOKm59bCv0l171lRZJLDa8zBzdSA/nL7QOv9brWfEXXku
 Gd6zAcL9TXH9Eilcr3yQZ1XABNrJbLkEsQdn7n0DcD/BYOuV2Yvwo5TFrzJrM0s5GnLoAbOuKAK
 GeX04+kktde9S2WxrmA/s4tENY7rl3jjmJJLlSy0I7ln3x6oBwREOpEEbiQ1q3UsT79oBEWnVix
 8dLeEx31bxIybira/2uRuXJF/ZiYCyoYRG3oD0GufgMbVtsx2C6CovOS4gWJY9cF43xR76A/SCh
 A2ufJtC5ukuYcex6iXQ2nr2BWtY1lMCj3oxLj1z9YoUhND+SyViZqzFPMZdua5iM0SejmF2uHIY
 AfbfXjC9S28RrTPJCOxCqucJ0pse4Kp4bYBEjWCMYZfL0FAJxDGLGZpIC/2G/+xB5Otvg/15W8d
 7Hh5bN3ax3BW5Uw7Oo8MWb2/FnmozNtVcBMbCV6+TMtfkbl50=
X-Received: by 2002:a17:903:2f8d:b0:2bf:199d:8a6 with SMTP id
 d9443c01a7336-2bf199d0a2dmr5492525ad.28.1779983882059; 
 Thu, 28 May 2026 08:58:02 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bf0534e4c2sm28328515ad.5.2026.05.28.08.58.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 08:58:01 -0700 (PDT)
Message-ID: <8a9e1e2c-2616-4c70-9b81-f56a1b5ee801@linaro.org>
Date: Thu, 28 May 2026 08:58:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/8] target/arm: fix WFET typo in syndrome
To: qemu-devel@nongnu.org
References: <20260527114320.1581552-1-alex.bennee@linaro.org>
 <20260527114320.1581552-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260527114320.1581552-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 5/27/26 04:43, Alex Bennée wrote:
> A stray x slipped in and we didn't notice!
> 
> Fixes: 4575da5ecb7 (target/arm: report register in WFIT syndromes)
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/syndrome.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
> index 4d1f1c529e2..0eb54c15ce7 100644
> --- a/target/arm/syndrome.h
> +++ b/target/arm/syndrome.h
> @@ -674,7 +674,7 @@ typedef enum {
>       WFI = 0b00,
>       WFE = 0b01,
>       WFIT = 0b10,
> -    WFET = 0xb11
> +    WFET = 0b11
>   } wfx_ti;
>   
>   static inline uint32_t syn_wfx(int cv, int cond, int rn, bool rv, wfx_ti ti, bool is_16bit)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

