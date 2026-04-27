Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC50FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 16:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHOrT-0001fb-6L; Mon, 27 Apr 2026 12:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHOqe-0001OP-Er
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 12:30:39 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHOqc-000602-Vi
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 12:30:16 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488a14c31eeso86584825e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 09:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777307413; x=1777912213; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xt0ca2GI1SHOL/nBZOUB5slIOp0Mz7XRw1zMH9TIfFc=;
 b=SGPSdv5pcPTL6BIuewEO66LVoKuhcRQs86MB137ekG1WqS87BtZCbL8uqCzD8rmvOY
 qWhNFakrho444SB9SaqJZzD4dwLclDYC9TX24NuFYgBLnMmEpcy2GJLryrbBAls33FOR
 RqSHF3f/PDLP7vPQZbGuf1IHw7kmX/kOL3TlGUSslaQAbCi7x3rvtJ4QB8xUBssR2zBi
 9+RWj+u5Mhu/EFtyTDT3iP/B9evjUNVUZ8njRCNiNn30lHsT1XCqfkKAsV8bMYb8vAWO
 lFzvecdaq2Oc4wogRJOyYN3DG5sjRoXH1FxZzrZQ8JfKIloE6gGRT4Fsfyujsk2mmjJT
 fxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777307413; x=1777912213;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xt0ca2GI1SHOL/nBZOUB5slIOp0Mz7XRw1zMH9TIfFc=;
 b=pvFdHZvlb1/HmIngR4CnC8/V55Rp9Zs3yLtLVJ8G+32U34vQIbjDnosSMLNBPGyjBh
 3dTRWWpHlCBao+JdalYTIp/k0Q+YUi2M7CkMfs+FDjDM07i4hhEm5/BMvYDBrR2obFO9
 79beW8HauwXunQrlbCynxn4dSCUYM+qe4QWxoaX16EecnkaTX1zjAsG1IPyNNhwY/XLf
 2Kp+ZnhgcMLrSAlyJsq/nAtL4qS9frvEWG/wO42bFfEA9RvGMrkm6PtjUyyNeUK0cR6v
 cHNEMOjr1NeaoUbVnt9pXXJdhgRls3ny7Gk2OUQMLfouhxCYWHGL9mEEUcaaM3xAP+sx
 vmbg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8wx0QNGrd7JRq8NWQiPkiwAaP9lUvwb7VaGD9ehmBYEwjJOXY80eq0Wpb9sTQMtXBC+SYRThKyXFGf@nongnu.org
X-Gm-Message-State: AOJu0Yy3DKAPEY7w4ervgq5hwkp/HboAVXHCfagA72Nr7oPs3TSrVAax
 jEyzEp5TAK5ZzcWAq2mQeclOAe42M0XHT3RaPu/aEMSzdkejSXUb4rXIWwzFfPAO5Us=
X-Gm-Gg: AeBDieujUxO4sotBKGuCAUq9pIQIUrM7Uccud72Z6v08bg4gNQ9ZGV/sST3kHaiSCp7
 MdzKmgR7xOvqfbtbB0sB3gDiOsXpXyZ9sVbMFBglNLlvM20xotXmeEcAuBCRj7bJISd0+XfSwre
 FZGi91WVvij8i1oigMB1cvRIwLbODZfz9bxfpUDarvwQ5fa8bYwkLwGZMVcgb8nXaQRhBAoef38
 56+vzeoa60vOGJ/QVFJ66NFUm1NAK36852Okyi9JzCESuGy460Zf0SPDe0mO8WZ2+95Lj7KB7bV
 Bp3DCbOkmQCGI5j7hQX7Vu9l14MlYwzdNOlNXsBsnvCOa1vM4sFIfrQOgaTUXeSwY39wKHkic76
 7R4Bz1kZP+WCuk930kvgA43vWsfYh7939ttwBv+6k6gYJyLMuTWlx44ZRGMXT+0/mNKgt6lqkT5
 cGDWG3aMlAO6P29mTZTzR2jCd79qPZ0YSeDUSO7prPekHWbSufuPfeafv3OYEBGk4hz/dt7Qo93
 Ilt
X-Received: by 2002:a05:6000:24c8:b0:43d:70b3:7edf with SMTP id
 ffacd0b85a97d-43fe3dc5386mr68497966f8f.12.1777307413210; 
 Mon, 27 Apr 2026 09:30:13 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4412150a071sm45010172f8f.21.2026.04.27.09.30.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 09:30:12 -0700 (PDT)
Message-ID: <81402f05-a443-465d-85b4-2ab269462256@linaro.org>
Date: Mon, 27 Apr 2026 18:30:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/84] fpu: Drop parts_pick_nan_muladd
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 26/4/26 15:38, Richard Henderson wrote:
> Use partsN() at the only call site.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c           | 12 ------------
>   fpu/softfloat-parts.c.inc |  2 +-
>   2 files changed, 1 insertion(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

