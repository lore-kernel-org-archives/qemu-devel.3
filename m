Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C7ED69107
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 13:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGeFa-0001cu-0E; Thu, 28 Nov 2024 08:08:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGeFY-0001cd-7e
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 08:08:04 -0500
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGeFW-0006nj-6k
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 08:08:03 -0500
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5f1e560d973so430627eaf.0
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 05:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732799280; x=1733404080; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SjZo32ga+iaM5ZFyJOsM6N1jqR5pVG9O8XSaJsR/NHE=;
 b=S9PSMvQZeA+zD5pEIppFBPDf5tm1+Mi6wifhwXutWTMcMSHPLPRbZHUwT2cOO9YaDe
 49WLxDw6nyw9U1FA1IUqSa7+s1Yk6QAtqbcNg6A87sH5IijaHE4rx0l4GoHfXhg1EWlc
 tTEQ40qzUx/LMooYx+qrTV4nFfp/t8IbdMCDAD73uN6PlmDhUzcJNGu6MKf3N/RQK6/q
 1aWDk+ATNtXfPg5i0g++DmBf8gR+m6EYoir+0UVQM3pUjUM6iXyWwHbabDEBbDibIr3R
 h/OdwzJscD9aiM+/GlNx6gRaEZSiLFCWuu2wmQjd2+vJ1MVLGk5IRMd2h/cx67/bYZoe
 7R4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732799280; x=1733404080;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SjZo32ga+iaM5ZFyJOsM6N1jqR5pVG9O8XSaJsR/NHE=;
 b=WdXlnu5eEJ/gCub2BAOu0xBjnW/uvIf6IgwOOwl2oxopS8Ylx0XmDsLuR+Q97jIW/H
 dsh741DX67naEd4s9sspezl6pSKVRZjbSlEuGfy+IibsRSsLJ9tRU+u9+MpeTwca5bua
 3aliATXzbZFUmcGP+aF+FsxyCgYT8pCHjjoLrkfHLW3o4V5EcrYSi3mPDL7GqTRWRQXr
 afYQaUKYKueCPfb/wGZTceY/64KWCjH1q4bQ4vp+khc/8XLZDXncfeM1gUTvKBKquHEm
 ksW7RI+2HtJDLhfluYbRvFlPuumMiYjPS/9jIKsebqGFbRXI85DXyi1xqXT4rIJTk8/1
 xPZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgCqk0SA9yYgMH8Bn5hI2yE1yJIvI7l5M6rT1/lQwSug6/iZrp/HlRZDtxrA7tGyOj+izejJ/1PDOe@nongnu.org
X-Gm-Message-State: AOJu0Yzmf+Z7TazAxX2gr28KkxV/G6DOdp891S4VnPn87xkOeejrF5Ih
 ALqJ96K2bA6eo16JSloklEwtFQG8Xd2Qo0GkVTZpEb0gwuY+8sLXlM8FOFw1a4x51VJAelVFEsH
 CZe0=
X-Gm-Gg: ASbGncuxj4+WpkCqLSFH0ugVSH4/U6ym2VK68EOH4gkgGj/yRsojaQ0xNjWwOqiiOt9
 q5BtZbm1g+rW8h3PYpTHFoluxsd8S8ZaVQHc0DvdC6cj/ESR7/5oVn3m559IQJMCc55qg7d+/04
 SuwAbKlEuRVnudHLdrfUFVemGZ8JxNfrBWIhbCNXdCPy1ksLzlU6ohPps8FdmWjwil7vePsnu5m
 k/hrOMWcZ6RQs4gf+5qMcS5JyZeNTXKSrB7ZhOtqRJAo55W0a4pC65cAUk1LKXjzS1x7MpK0Jwl
 E8/KE3sYwxnAADtpmatxbIdgjgsD
X-Google-Smtp-Source: AGHT+IFpLYaUVrTkK9fc2RmOvCW4gO4ktdzjnxVExQS/JM52+/X+pY6nEl3LGrkL6D0KH44UE6MKKA==
X-Received: by 2002:a05:6820:50e:b0:5f1:dc89:fa85 with SMTP id
 006d021491bc7-5f2179fa1eemr1667881eaf.3.1732799280508; 
 Thu, 28 Nov 2024 05:08:00 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d7255f7bfsm288268a34.38.2024.11.28.05.07.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 05:07:59 -0800 (PST)
Message-ID: <9ab8dd47-d9ff-4a1c-83de-71f4c04c8967@linaro.org>
Date: Thu, 28 Nov 2024 07:07:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0 01/25] fpu: handle raising Invalid for infzero in
 pick_nan_muladd
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
 <20241128104310.3452934-2-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241128104310.3452934-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc35.google.com
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

On 11/28/24 04:42, Peter Maydell wrote:
> For IEEE fused multiply-add, the (0 * inf) + NaN case should raise
> Invalid for the multiplication of 0 by infinity.  Currently we handle
> this in the per-architecture ifdef ladder in pickNaNMulAdd().
> However, since this isn't really architecture specific we can hoist
> it up to the generic code.
> 
> For the cases where the infzero test in pickNaNMulAdd was
> returning 2, we can delete the check entirely and allow the
> code to fall into the normal pick-a-NaN handling, because this
> will return 2 anyway (input 'c' being the only NaN in this case).
> For the cases where infzero was returning 3 to indicate "return
> the default NaN", we must retain that "return 3".
> 
> For Arm, this looks like it might be a behaviour change because we
> used to set float_flag_invalid | float_flag_invalid_imz only if C is
> a quiet NaN.  However, it is not, because Arm target code never looks
> at float_flag_invalid_imz, and for the (0 * inf) + SNaN case we
> already raised float_flag_invalid via the "abc_mask &
> float_cmask_snan" check in pick_nan_muladd.
> 
> For any target architecture using the "default implementation" at the
> bottom of the ifdef, this is a behaviour change but will be fixing a
> bug (where we failed to raise the Invalid exception for (0 * inf +
> QNaN).  The architectures using the default case are:
>   * hppa
>   * sh4
>   * tricore
> 
> The Tricore and SH4 CPU architecture manuals are clear that this
> should have raised Invalid; HPPA is a bit vaguer but still seems
> clear enough.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   fpu/softfloat-parts.c.inc      | 13 +++++++------
>   fpu/softfloat-specialize.c.inc | 29 +----------------------------
>   2 files changed, 8 insertions(+), 34 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

