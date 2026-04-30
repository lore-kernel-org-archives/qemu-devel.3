Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96CCFF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 04:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIJRG-0006bQ-P5; Thu, 30 Apr 2026 00:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJRE-0006bG-IZ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:55:49 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJRD-0002Pw-18
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:55:48 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48909558b3aso5127615e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 21:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777524945; x=1778129745; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TC34PoZ1DVoXnuEaiq2ZXHpm7UlY/EEvye81PAbCjKw=;
 b=UyPp16v8DU7iaY5JRx822eByKQuWlE5xDvIAw+MkMg63iFA6/NBYl3YwnlRL/ZKe//
 oFd4zbCX6qA8HbQimpvo7VMKmgj0Wx6DElg4/BJtB0egq2U1e3r85BWjtmzJ8z7fS7SS
 J+UBDH1ZSx+PumEf0mO4+4o1pukReuHbvV8KCbdU8o7ALb7qJiw0INr2zDCEJEojkA0f
 Mt9F0sbDPPLsbOMf6QT31NNrkMnyh05TLy5as/I4uy2LZKrX/lMHBuBijInpOAMHtMLq
 4AjKW4JLVtHAwM0e/utchyr0f+u6MG14eu1KvkpQsQkmkJqQkKFdtzAihYucWg2jihV6
 OZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777524945; x=1778129745;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TC34PoZ1DVoXnuEaiq2ZXHpm7UlY/EEvye81PAbCjKw=;
 b=m8P/9CEW+9biHNAYYAxfHyFD0Bl7jB+oryDf2mQR7g29TRTpXGnTfuUYmZIQla22pw
 x0p55+e3ClXHMrJZxau0DrtUxwnBrDi1wdLAYFaymyZTbJ7ChYDnRuqlUVm8+vkTFLtj
 yarvt8wE2MxPqXeFsYzSFImXOF0H6YzhJmxrPpQDHU5YnaFe8e/IF2Rz3EzuyFuKgxw+
 b8Uxpfefheh1t+EIdBGLgkbgX9UJPrEZjU0DuFUMI7i6Ggi+KZJA9IOHkTLPkIAtNEFs
 sHTx89xZPE/O6rqsj74Om10S3mSir5mUjJumpcpjDigJY4kYvq3P4JL18zHhZ8zBLilU
 vuDQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8vKjuY2UMXaqtO3pcjkqQDNwFYtJFD1afOoen0zDkWOg53IgolfCmSPvLoIoCj+AbCFdb692EXd8Ub@nongnu.org
X-Gm-Message-State: AOJu0YzTU61YXPKCvIoZq79Sz6e1zy8N6rQz8JdzOp8llY3B3H/eKO2B
 HHI8gjU2HZpSI6mKxI3GFho7KpRmGhiVU/XwFLFOA/J0D7Y6csEB6/1NYTfXUz9nK3DTr68p8qu
 xY2RcXCQ=
X-Gm-Gg: AeBDievZeAJW3N6rQO2YgCTvpJiWyBspBYWOmfc2F4EJieJYvHh6r8/9V3lyLWFqVcL
 FtRpKh6RIwtgw+rnAlvBGHMsHhsICbXZAlGkV/fUzXAZeE3dITIrvY4/Hsq3xqeIXg+G1H/GCDT
 RZWtpi+LXCwTqiT7QuTxk8N6WgVZqvoB/Fvbhf0G14Ibsa2FLqKv7C62tZ/WCM0MQweB76EFOr5
 d9P4CzIBg3YaF3MtAUC9yf3ZlUsGigmtBfKESm6CWFmVchMRti8MODeiJ0ad9SYG1CmPqA2jZYz
 +NzwJST6yfuO95msqfzkDLaZ/h9+Lxz3Ceb04PZDKpgosqaMumxr2BCyCqShaf79c5bxPbLPHRX
 woi1dPpfLFYdwK8Qp/bZO5DuR89AtZCXwNYK1bH3xRQIT0cqNSaWP2NptDy/59wz5FIWyqvfYrY
 RFZ62NxvsS5VcPJB9jqRoCPzwPUeyr1WyRNnAWP0L4eNtXeUVmLrZUbTKc/vPJVioNjxMjiRDzu
 fBG
X-Received: by 2002:a05:600c:4f44:b0:487:2439:b7be with SMTP id
 5b1f17b1804b1-48a842566a4mr22617035e9.6.1777524945219; 
 Wed, 29 Apr 2026 21:55:45 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a822c82f2sm38269515e9.11.2026.04.29.21.55.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 21:55:44 -0700 (PDT)
Message-ID: <220f1be2-6e25-4741-8fc4-0abd9650b8e4@linaro.org>
Date: Thu, 30 Apr 2026 06:55:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/40] fpu: Return struct from parts{64, 128}_return_nan
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260430000524.56046-1-richard.henderson@linaro.org>
 <20260430000524.56046-15-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260430000524.56046-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 30/4/26 02:04, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c           | 14 +++++++-------
>   fpu/softfloat-parts.c.inc | 15 ++++++++-------
>   2 files changed, 15 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

