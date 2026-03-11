Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061851125854
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 17:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0N2C-0002GB-1K; Wed, 11 Mar 2026 13:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0N2A-0002F9-P2
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 13:07:46 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0N29-00024R-9x
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 13:07:46 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4853fd7b59aso443815e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 10:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773248863; x=1773853663; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8ERCWl69wpTIM+okvnTPISLAGxfGEKjhydC5UWCSiAw=;
 b=z7VU+F5Rh0PvgJ1RPBIaS7c5eQAdrfFYgN1cQmyKQkreuEuSZOTftymqSJ1W5ra2Qn
 7MhL/BucNBg/9rLxbw2HjxCGB+fGmucLYq/sFUuQxist2d+fYY0ugEEF4TJLlVunlDHN
 n4ZJgJH0S2pLtwBZvcrtS1wakMKyuDQWTOX3c1cheDyHb9a6Jss1Q04D2gi964jBBotE
 CVLMYBGPz3bvSHaJBzrcFuBRmW2coS4d4Z8JiNKFOYiIfOetIC0MSADfshaTrbalGmsx
 dfIrGuNDgWU3Tfs4oZ/exiHNmjlEz6XYmws0erl7SUwY1rLJc4K2FrcZaqSOxIqsai3e
 JtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773248863; x=1773853663;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8ERCWl69wpTIM+okvnTPISLAGxfGEKjhydC5UWCSiAw=;
 b=UaTjQN8EX9OBeepqthZa1Si1PhICFN0aST+v6Ayuyox4pCVswREbpT5Jka0hdUXYDq
 /829B183duitW5siy+T3P/MrOe3778Ewxb0dIv4+D7TgbtVAY1sRVnlF/DVtVlKddiSq
 l27Vos0hI3DXJtEwq/2qxhkndd+QGr5VE75W+6lj8GERJ8OogzSVeSf1LyFE0tTce/sm
 0NanwdqZJbHvJWlziEivzOhyAevEnqhd6dX01gGtTtof/oBiMM7/tFmk/g3A7HGYwy7o
 A15O02FVpDgMX7dGSYslwnq8Rfi7o2JwWtlNHMiT5BMNF+S+pGa0vTWHIzHnYuwgHfCN
 COXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0HRt0h/7O64m7MZbKmMsRZufPcQSyv2PEROEZn3T8Ya3tPPlDxlkQ4/JzMNy2VyFxeU2wk2yiDl4l@nongnu.org
X-Gm-Message-State: AOJu0YwOwf8ASvKyn7mBGwLX0ihDv1SWvR/gn9/AJKwBLuzt1qfA+vG7
 j7dNrW62KQ+HzBLbr+TByI4TGLIIu8RtMfeWHdCCVMh8OVZedbq02eHy97y6MgROcp4=
X-Gm-Gg: ATEYQzwKBwv1M8WwRKhvftbedVD7u75BsXel6i97iHnLlcDIW4NO+CmLr6N6UZFW1+s
 0rkkeHHhEPJIBTiUWAG68CTAnCr1fmfXUzubXMO1UhDK39yDWLkyBnrrw+VTfd+XUBuBIm4qeR+
 hTt21IVQaywRGDwKHdQDdnBbmqAzoqGCIaR8WahRY1kqHnw1XxSzHdYdGv/9kXCHjFtN7oMLecz
 2IaFtrmyrlcdXmMxyM4AwSBDzGrpZtKruLRiDJK7wzfrwwkcmW52h78UmqkUxRjblcMQYZp0SNJ
 B0CzJwXR15bF0f91hP7U+PZXSnKbL7f4Qm8A3kZmFb4fySNDoGGUBi7Jg+q1Ap2ey9jLPNHt6aq
 tj90jEUI+YeUAdPSalPCt/weumke8rD2FUouC4Qza2KSuXghhUpfTlcvJFxAJWmdmvq9NqfnsIl
 MAXP2r60v4PpFj3WDJVXHGgNY4RprN+rsPNFPS+rol8GCvnwIPUriCARw5s52qhJtY9Q==
X-Received: by 2002:a05:600c:8b0a:b0:480:4a8f:2d5c with SMTP id
 5b1f17b1804b1-4854b129f91mr54889355e9.29.1773248863013; 
 Wed, 11 Mar 2026 10:07:43 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b0caccasm51960005e9.6.2026.03.11.10.07.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2026 10:07:42 -0700 (PDT)
Message-ID: <8cc9c4d5-60f2-4e4f-a534-f35e6c438cfa@linaro.org>
Date: Wed, 11 Mar 2026 18:07:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] typedefs: move QIgvm out of typedefs.h
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: leonardi@redhat.com
References: <20260311162045.563301-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260311162045.563301-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 11/3/26 17:20, Paolo Bonzini wrote:
> Typedefs.h should only be used for really core types; QIgvm is
> just an opaque struct that is defined in system/igvm-internal.h,
> and the typedef itself can be placed simply in system/igvm.h.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/qemu/typedefs.h | 1 -
>   include/system/igvm.h   | 3 ++-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

