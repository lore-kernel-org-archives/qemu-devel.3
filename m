Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA76C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 14:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWyiw-0003ZE-G5; Wed, 02 Jul 2025 10:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWyit-0003Yh-Ei
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:46:07 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWyir-0007ap-C9
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:46:06 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2e95ab2704fso3090719fac.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 07:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751467563; x=1752072363; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TcvruI7SrJqMu/I1zSdlWdkR1NrX7rdtg+XEHoMTuFg=;
 b=CW0VxKr1S93uGqyYfFagKyOwQMgd3Yx3mO26ebESB+xLRhTZ6qeNgelUVxPWMT578y
 mxnqt4rPICRcEdJncVMjlHbKwXO9o1I+sR/un0IzOwjABQ1ei3HS+aILzkksMjGj2b+r
 gjJ25NsCL/ID7hjADzikxD9kt2k8MKx/qF0aoPFElzsPVZeaHhHKS/ctSzlAlqa7bs3O
 a9911u4Ckxs8aikt/9Dou254noQUewyZx5hPz3SRfbZ7wipRDuJ2o0QXjPeOR6P3jfiT
 LJGc8lIn9q2JtgjloX+kM2LEt/WTMzdll2U7l9Bm9x5RZwIkGJpOqT/yhjND+Gd5Tkig
 2tjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751467563; x=1752072363;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TcvruI7SrJqMu/I1zSdlWdkR1NrX7rdtg+XEHoMTuFg=;
 b=tGlxzKW2BDHp1vWb4xBB8nKYGsj38Z/BUfLadCLo/YO982/uN+X6GfrUOJYchh/Gww
 z2dYXkw0XUd50sY1zbruG/+3uy6AxPJikhRdDeWqNMh249jjINyj2SP/ATtAVU4vcDYY
 lol+mLQL+R+I+pEj3Zq8m87kjCRJ831ZT7XnSaRQyUWSazIwbRwG7eqHhTmh7Q51Ax3j
 oenjx08wuaBJt9K1lSwvef7UFyOteN8KQ/qwJTDznqBUqluRrMYFewCupsN6Ry8hQ+Lo
 i0HGdOtrcUcJq8mboMBFMwRjMUuZ7ASl6RCUmtFU247tZVWF8hLW90u6zEioMJjjSG7a
 i+YA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW006GtygpYWkviNcAEZRS4BTH/AQ5K20SAdqyjmVNlc8QAgbnkRcdfmObpDynmzwBOHbRVOE4AiLIr@nongnu.org
X-Gm-Message-State: AOJu0YyAbaHzNZrtgQ/w+STZJwvEWgW2/2ZR9YDxION8TB7tmKlPxsQ6
 ywoKWN8zSXFGGnh+ek5lSlgG26VpfWvmHmy3hKfECNe4KqprdzoYVM4ImUfY3dng8Kg=
X-Gm-Gg: ASbGncvzA/40VKtMZC9tkt8AX64XcWV2bsSKK+9TXh5reGPzqIwEuKKM8omvDitp3/w
 oGRZoFvkjbhu0C6XbDTn/qnx71QqVU2C8AV+P1IzcNvB5+fEFbrHXuISXmpNaHXMh2rmj2pZHJs
 fsyg0gd5Ux5bXKkg+NU+gspohSkvx2KrIkGQmNL9Jbm566NPEGlM5TBmIIEoiyYTquLRXnp8yIK
 8HgsQ02zZ7ZudnsQ+rVchfhRzr4Uo3/l8W7i/5YehE/+is+Wq4E+7TQ7wRicEN141YwpG2+mHX8
 HwSn97sRvC+nHF87jo/5lsp8QOFp8ffkeBDazx/vk92MCYJedjbn2pw0zHRkru1W1lkQF8shWLH
 x
X-Google-Smtp-Source: AGHT+IFOWco0S82bMuBlfN3/Ym91dLqpksF+f9GwakMD/1XpagimOCvWL5hcnqcwgzfxhhlmamq9eQ==
X-Received: by 2002:a05:6870:3313:b0:2d8:957a:5163 with SMTP id
 586e51a60fabf-2f5a8b200a0mr2340130fac.10.1751467563516; 
 Wed, 02 Jul 2025 07:46:03 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4eb261fsm3911600fac.8.2025.07.02.07.46.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 07:46:02 -0700 (PDT)
Message-ID: <41541d93-90c0-44ac-ad6c-28656cbf5746@linaro.org>
Date: Wed, 2 Jul 2025 08:46:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/12] target/arm: Fix VLDR_SG helper load alignment
 checks
To: William Kosasih <kosasihwilliam4@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20250702111954.128563-1-kosasihwilliam4@gmail.com>
 <20250702111954.128563-7-kosasihwilliam4@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250702111954.128563-7-kosasihwilliam4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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

On 7/2/25 05:19, William Kosasih wrote:
> This patch adds alignment checks in the load operations in the VLDR_SG
> instructions.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
> Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
> ---
>   target/arm/tcg/mve_helper.c | 42 ++++++++++++++++++++++---------------
>   1 file changed, 25 insertions(+), 17 deletions(-)
...
> +DO_VLDR_SG(vldrb_sg_sh, MO_UB, int8_t, ldb, 2, int16_t, uint16_t, ADDR_ADD, false)
> +DO_VLDR_SG(vldrb_sg_sw, MO_UB, int8_t, ldb, 4, int32_t, uint32_t, ADDR_ADD, false)
> +DO_VLDR_SG(vldrh_sg_sw, MO_TEUW, int16_t, ldw, 4, int32_t, uint32_t, ADDR_ADD, false)
...
> +DO_VLDR_SG(vldrh_sg_os_sw, MO_TEUW, int16_t, ldw, 4,
> +           int32_t, uint32_t, ADDR_ADD_OSH, false)

Use MO_SB, MO_TESW here, as previously mentioned for plugins.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

