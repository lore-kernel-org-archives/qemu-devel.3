Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56722D78339
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIAAw-0000OQ-3L; Mon, 02 Dec 2024 12:25:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIAAj-0000Jc-HV
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:25:24 -0500
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIAAf-0000JK-0W
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:25:21 -0500
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-46677ef6910so29197331cf.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733160313; x=1733765113; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+irlA47iNIrITGZGZKV93kqfM2PBYrsQFmFR6PW5r+0=;
 b=Zi1Yo7Z61IiWepNlueHcGlNgT+vZxn+i6pZQU2lA4ucP2jQ+A2DRTQ39qMwE5PGy9F
 yzj9vpsf/Wp0BL/tLx+yBws96DbTrM1x4lkF565T6s6k09/eqV5O94BT3mcVNWX3VLmu
 0A8kcKSDYAlzsewiURqa8yDCUKEPMUbFF0jwFXccKTWw4OZS6yv1miMz3NyNkJ8gTgIC
 +8KWcWET6OgJD+2gh4BvlvcgSznfiMlLnG54x11powyKVNBLamaeXWryYgEytqrk3uTc
 szEJH4yp8fO2H2sVQnOJ57sKqvt8jU3KKgSm4jDqremRvzOP6qCQn6qH6mCi8Yd0/n2l
 uqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733160313; x=1733765113;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+irlA47iNIrITGZGZKV93kqfM2PBYrsQFmFR6PW5r+0=;
 b=JsrxlOn0pToBYUABERLuD+ZRI/1epQQCWaEvPfatOevDWUlVkKLp1reE5Lbp0t9Q4N
 E0EQzH4Wy3vdf2e7vF4nLmLIO8Ai/dbkg1Kr+VzCZZAIderQ/QG0pstFnsVWPBF/XjXr
 dMH25Fp9gpd3rxYvryrQniAv7/BnTYLHtDZ8hVauqUfKFRxlQjnVmha7q1qpch0tuMqr
 nJ2LWyPTrTeSV24eSHNDM05ZMd9rwek69u9C11lb6LDuIPeM3u1OEligMxoFgWHYVpZ1
 UAJA7e7CJFjUu2UG9vpwy2kvfka3Y6TO0JS1xalFIRbKCeHr9m6JVxnmZLFM4PMb/Hce
 RZzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8EFW3OP0GhylAjAw+W+Hb720rbhkABeWbEwHZ2MpSpkDrIVF6fhVJC0pNZAKyJRhIDCBhm9GIzgR1@nongnu.org
X-Gm-Message-State: AOJu0YxnSmX/8YqGc+DEHPX0PBejZ+nBUklyb+Hh4Y22ltmskEn/jzfK
 ZR8UnR4+ah7eJ301O5/g14ZJit1R0NMyGY6RcWgDSN07xFEFpf00i+p8Vtz++oA=
X-Gm-Gg: ASbGncsnWIELXb1m75GpJ7SlZC9rIMe7ISxLJ0c3qiVHeGQUgnQnfbfPppMOKS2lCsx
 qHsfQBConFj9gtCmz+tG4sYmSmGNvQkp2PCFdEoKy9PYxQ4djtt0KLdDrlCFUB83G0N1I1YJmn3
 OfU0NMHoTo7bS/miKicdo/ijg848jzsLarr+tsSYhLl8cnWx1IXEh3GG2V3zZ42LJQigQee79C2
 HVwN1e2WpFz13XZdQU2+q6FU/fKyMl5qQ6A/eKVzxOxW0TDc7PZzl2Vsesk/wWjirwHcu8=
X-Google-Smtp-Source: AGHT+IF9BmM3OTjBXT77pCvp7IbgtYK6nHYap74A1L+KBXYo+zxvl9ZjWGqAl1L5e3vG3fMb3T0pMQ==
X-Received: by 2002:a05:6214:f2a:b0:6d8:9124:878e with SMTP id
 6a1803df08f44-6d891248a9fmr205825466d6.4.1733160313427; 
 Mon, 02 Dec 2024 09:25:13 -0800 (PST)
Received: from [192.168.170.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d875221f5fsm50464226d6.111.2024.12.02.09.25.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:25:13 -0800 (PST)
Message-ID: <525acdda-9a87-46c1-8ea6-711ac9408120@linaro.org>
Date: Mon, 2 Dec 2024 11:25:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-10.0 33/54] target/ppc: Use env->fp_status in
 helper_compute_fprf functions
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241202131347.498124-1-peter.maydell@linaro.org>
 <20241202131347.498124-34-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241202131347.498124-34-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x831.google.com
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

On 12/2/24 07:13, Peter Maydell wrote:
> In the helper_compute_fprf functions, we pass a dummy float_status
> in to the is_signaling_nan() function. This is unnecessary, because
> we have convenient access to the CPU env pointer here and that
> is already set up with the correct values for the snan_bit_is_one
> and no_signaling_nans config settings. is_signaling_nan() doesn't
> ever update the fp_status with any exception flags, so there is
> no reason not to use env->fp_status here.
> 
> Use env->fp_status instead of the dummy fp_status.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/ppc/fpu_helper.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

