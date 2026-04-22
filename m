Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5993BFAD3E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 23:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFghU-00047W-PT; Wed, 22 Apr 2026 19:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFghT-00047M-CH
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 19:09:43 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFghR-0003M8-Ty
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 19:09:43 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-82f1f6103afso2837105b3a.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 16:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776899379; x=1777504179; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+/shEJfN6mEYjxFEdU4x/fDJGKvbjNq93brJW86ZMN8=;
 b=eANvDJMaLO9pPMD+FaR2RpRY1WhVmkQ3U7QopORcMwdJdwQrFoE1AlLThSklqtaQQ4
 vURzjY5UjXXcwK02kIeoNJoAcl/4sfoAVyhNCzfpes3BeRYDPryH7Ew+q11vQla7cl8P
 0gm6WBraan7CONs/EFdOsML50HhL8YUo92LeNZlv+cY9F/QpGBmxtLsLtaZSVXRYRjVk
 ObVivP9A94WOt828oH2l4fHQkeC0HIAbEaj/kUSOWZHPG0pQI7XNKJH26gVmGFRSpwqf
 J02sBlppbCDSIGN2LpP+rNKtHL1OMeh/flsiO35FBiX10rjBB9bHYuhmWSklC4OfEtFG
 w+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776899379; x=1777504179;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+/shEJfN6mEYjxFEdU4x/fDJGKvbjNq93brJW86ZMN8=;
 b=RjQNjs8L9xbYR/5SZMfPfHXQ+94IFitO7uGixADR0OEjS4V+R1dKyARfJLe/fizzg5
 mCYCkW1L+MfXxUL66roNosK0xyW0pxq0+KgRlL8i5Sas+0LbI/MVUMjJ7sacpMl08MkK
 pYvcCd602It4tdc/8Bpvfz9S13wFQQTcCPn7GAckiUsESp2g1nBbq8QfiwwbslNNlq9X
 1UAQaLNX1QFizwbYOUPigmmubKH5W84MxV1RPgWwr2ojJEHmsk6jqpIG7KRGGIabvCH6
 Sw9ex0YEQ9hU6yVIrdDd+s3my/5Z+dexa5KUSD84VnASI+nAZTlblbBnBquzGZ3DWaqV
 uFTQ==
X-Gm-Message-State: AOJu0Ywi3yfIJSjGfu+EVQyIKNwADi20mbN+sASW/xHK+jIBDDWgcNKZ
 RzCjDvm0MFgGNXXl9XPJopbrQB9X/R3ApWK6Vf18w4oRGwNjPXceXUFFedEhgb22lXA29jBoOsF
 Gbvyfkks=
X-Gm-Gg: AeBDieuyY3R60aiwk8yB14q40ARSK3lI1pHIcFi7Mfn1V+WvhzxDv0Qqe+q0XTDImV7
 yUKyCbiJmF7FqMM4aGglTNiIFZD5sl24r1H/CWpOWow7qm/+e3uFUtK6L8rkl9Gpxtv3Gt6CjUy
 UvQp0iY51ihDn2KTqaZJQit0Ek+xQLBgJJfcAWIt6Cfk8YpurumNssmJq9JbgogpT4I95UkRaX/
 T8qzRXHWFw5nTBogWRYnt4/eEEk9+qSYw6fQv19HcDEjS+vTk29Md0ci0g399/4i9QeFsV0Ibxx
 y6Uj9/1Jy5UccaR+17zC8/i1lmupOdn0aQQ942KhEJ9YNi0NfgV8Y3XkZpIm3RnXDIy9XfWLYIc
 wn4DQXRSYbDGhb5mHWinhX5FsUSd2oN9b5AlG7f8AK7uoaWInR5WBxOYVnXAv+o7pKN377rO1mf
 AZSCiCzPPN6uAQadIMQRoFRsaES1z8TFstSqspvTJ8v5fM/ZD9Ow==
X-Received: by 2002:a05:6a00:3690:b0:82f:4f67:1ff6 with SMTP id
 d2e1a72fcca58-82f8c82e873mr25041001b3a.4.1776899379404; 
 Wed, 22 Apr 2026 16:09:39 -0700 (PDT)
Received: from [192.168.1.134] ([110.239.0.232])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e982fd3sm22817016b3a.10.2026.04.22.16.09.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 16:09:39 -0700 (PDT)
Message-ID: <33e744c8-7dfb-4648-b465-31dde9107b91@linaro.org>
Date: Thu, 23 Apr 2026 09:09:34 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 31/32] target/arm: handle the WFE trap case
To: qemu-devel@nongnu.org
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
 <20260422125250.1303100-32-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260422125250.1303100-32-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 4/22/26 22:52, Alex Bennée wrote:
> Now WFE can actually suspend on A-profile we also need to handle when
> its trapped. To do this we need to pass the instruction size so we can
> deal with the is_16bit syndrome encoding.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   target/arm/tcg/helper-defs.h   |  2 +-
>   target/arm/tcg/op_helper.c     | 15 ++++++++++++++-
>   target/arm/tcg/translate-a64.c |  2 +-
>   target/arm/tcg/translate.c     |  2 +-
>   4 files changed, 17 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

