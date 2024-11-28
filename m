Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A915D70DE9
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 17:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGigf-0007dJ-Uk; Thu, 28 Nov 2024 12:52:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGige-0007as-M3
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 12:52:20 -0500
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGigc-0004LK-R9
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 12:52:20 -0500
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b66e94bfb8so72663485a.3
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 09:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732816338; x=1733421138; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0BsGpLJot4thl7mneZbDcBlSGLyHsqkIkpI8t6CMwes=;
 b=DGJVBzIIcSMWVU4Y8SJm4khM02nlBt7dpRWcE0NCVr6XtuhHBbgYWSIPBXbWr6ICJz
 2OxEh228iaoHRbJiPnSODdGO0h8JW9nnDDENGaI2o3QjP1lREdU+f2N+IKtw4VYp3yeC
 VQdH5mD99NNBtk/Ovt4kxgvyBwpvve3Q+tQF8Zp7xF3o77XQM/gFPDikpIW0MJoHFLXD
 W8CMVM/jQ5154c+s3/VNQG1Sn5CrrBN1oECJwMLWJXjHI5lm56lh+EjbRDRpPzurzscQ
 j8lw1OKFPCg+kqeK9mOxMWpMt8qxwD84SO7HWrAZ/3BEAJ6QZryHd5UhKDlL6lS027D3
 xgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732816338; x=1733421138;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0BsGpLJot4thl7mneZbDcBlSGLyHsqkIkpI8t6CMwes=;
 b=H3RXmcoSUxWLQ2kJLKnrGSil6m2oiiA/B9q2hxahPKZSt6Ssc93oWIvo4++NrmqP5M
 0kaI9RRineoXrNsTSb/ImHdfeGMicCZ9DKVbaiMgWB0HXa8vpiD9nm+UEQi52fu6Ruu+
 L6HxPnRZtV2J4pxKRXrXXcX8GFRCWkHeLOPqV2ZagLdeozh445bHCRS/Rw2sEP918kgn
 VPyl/HauCRBUZRwFeEfRTwrCXcZo70l4UO+tnjAaU7nNTwE9OAsWD4Ys4AtR/2LSzsi0
 iadOmtdECP8+4uzDFUuzC5TmdqTkauyxKIHEzW9txWHcS7Xcy3Thxh+xO1noYo3bSaOT
 fwpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzLKFxGKM0zk3GZzh/xAFGFrkzhMx74dTonVZurpeTGyggj6Ht1UILt4tvQ6uMPdiJPy1ObsUGGtb7@nongnu.org
X-Gm-Message-State: AOJu0YyFxFjgyHMqBlO/KlrNfcU1oeZ+ml9BNup1MGFFV5eMwYQWhbMU
 nZzwLharCmsmhGdHKc5heJbnWjWpb6bVqQK52WANfdMJbyMPw9CBjxE5URfFdMY=
X-Gm-Gg: ASbGncuPO9MNqFYKf/yMsnpUWEX6XXLVtbCjp0QTf4mA8U6r5ddqrQRLJN1LldQfe1X
 K5fk0wjaWszb4tifA5rGWmskHlNCpUxPJnPFzfam7HdnaxwxZbYfEtnhrxGPwldT7RvjJxWYt3x
 23T6rIOTJ+xSkjs4nwIVpX4Yr/FoLC+7P93xnrSx8DGgfDNyZMa1V6y+sb3ojsOzrGl4mri71QL
 LQt7hNdHZ0Ctmo3EyiyxFMsTYqA3BcuSHG8WD4t+JtNjBDZrixWRfTQx5JdzZEAm3Y=
X-Google-Smtp-Source: AGHT+IEJzMMPB8o44DKubop8SNi/M2P4IhPGxAXItIloSXauKaxTJVK0LfUoNtAaCC3qxcLU8IPNRA==
X-Received: by 2002:a05:620a:372c:b0:7b1:8cda:6f4c with SMTP id
 af79cd13be357-7b67c256c62mr944949185a.3.1732816337827; 
 Thu, 28 Nov 2024 09:52:17 -0800 (PST)
Received: from [172.20.3.167] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8751f54ecsm8494636d6.77.2024.11.28.09.52.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 09:52:17 -0800 (PST)
Message-ID: <41dcce00-700a-44db-bd04-84ed7e7e75e1@linaro.org>
Date: Thu, 28 Nov 2024 11:52:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0 17/25] target/loongarch: Set Float3NaNPropRule
 explicitly
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
 <20241128104310.3452934-18-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241128104310.3452934-18-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::734;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x734.google.com
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
> Set the Float3NaNPropRule explicitly for loongarch, and remove the
> ifdef from pickNaNMulAdd().
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/loongarch/tcg/fpu_helper.c | 1 +
>   fpu/softfloat-specialize.c.inc    | 2 --
>   2 files changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

