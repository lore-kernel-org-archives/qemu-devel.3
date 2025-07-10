Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E842C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 18:25:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZvvt-0001Qa-Fe; Thu, 10 Jul 2025 14:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZvJ4-0000x4-4K
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 13:43:38 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZvJ2-0000ES-FU
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 13:43:37 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2da3c572a0bso1075070fac.3
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 10:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752169415; x=1752774215; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3CedxPDRQ2FrYfR+32jAcmSwgcLoV3ZJQqOhAvL9lG4=;
 b=l3CJnts81F3iZRv0IPuBudC3CLjB0TaeikAW46OFXfqS1jlUfcEzefLpjbucyZFGMK
 S9g6dGGvpNLse33wOUTwnnWWBpE77SSV9R4GszCJPjfOdzZUfRo0I2K0bPiABmxqnQZW
 OM9AMdmBLQSxCz4ICtjFSfsHmGXRHu1a1f48TxZA2q6o8RUr7VdVNHrjrtqbMNE30Tjo
 V7e8m1GpuOYnvBVGlL3Co3/3TATrX2g6CQ29mXTgiqad4zQYk6SbSKwj9XLcBXQ5nMAt
 ZPS8oMYRycuJZcPkZKys0hEzg3lmzKUtO0xgZkvRmjwOpyBwWqFRSMWyB7lPrufIrRjV
 pUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752169415; x=1752774215;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3CedxPDRQ2FrYfR+32jAcmSwgcLoV3ZJQqOhAvL9lG4=;
 b=arU5JRVcJUk+LI12yQK1HhKGUfC7r6guu3Xkh7Ftm7RulayR0SL/LdoNDVcVN7QseS
 KNNlSlfP5Q9ZysprQfl9Qf0A3pg4/4QF/PhCHKOZG/rSYxeOqDwZ7UeZsJbFh+Mj1uXJ
 Je1DIbeZCh7KplQOkPnOtPol6Wui8f1Fp3xX1wuE9fVYPH8Gc87O+A/lgHz8+yspSCPd
 Afkg21xhv/FZodgeyNR5pZTsyH1kO79xLVkd2BOwRHN0DV9oiG+ZzFzdLGD4Nf/Qb0Y2
 dFIDik5cO3W2aUN2Z04LW1WXqErL+S2p+9TV03LINOwSMsc0B8VwingpYqpeJ/eLknWq
 lc/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwF/dGW+FSf9sSEpsqOwemKL6a1Mk94YVLoCVveOYCjvVfdCP8XByXkaCqQM+4DL2QWX0gDMRtB7II@nongnu.org
X-Gm-Message-State: AOJu0YxWoNu46Eb3btkR8xHdzlVt7DUh8qxMInTpFHynqQMMendJ7mB1
 nP7d9sgjJhNyfjKv4uHVQxkb26S3/wc1yaMU/AKxhqpEi/lZ53XlWEh6B4pNFZvZ5w6XilCKeLb
 x5vp1Qrg=
X-Gm-Gg: ASbGncuDN6ba7rKLnoP6XfUjXkUjVXpCL5PtBnlSbWm3Yi11bvpAOVRlGj0UtUIGvmn
 LR4lTFpcSwwob5L0J63TNGlzjU9vS2w0o8/7mbRuFAN9plVRa0dpNPtonoi4Yp/Esz0DuT69yW1
 cmhbBOKmiukxquJroOPG1CRqvryKd5L4hrLXS8Yc2SKPcRrZYJM1n8z4lDPVYc6Iw90p1/QoDTq
 v4J3pyI/4DV3Tm8yE1E+gN7RF0nzUJZGe0PCpKU6l9HRYyLwJOQ9LZolVQ2csY5PLr1cet6ohAS
 1LD+vQkkqVDUQ6pxUhDIZ+WCQd+owtvNWQ7QoS47YFPQyhrOtORT6TW4pSQ7G37ztDEtRGUiEzX
 3QdM=
X-Google-Smtp-Source: AGHT+IFd7M210SMtlZsUOBpas8AFN8SC45Xy3GhIFCNkC1YinvzTaxhP7VGy+KE5wALDwIaN4I76vQ==
X-Received: by 2002:a05:6870:200b:b0:29e:4340:b1b with SMTP id
 586e51a60fabf-2ff267625c5mr153711fac.9.1752169414786; 
 Thu, 10 Jul 2025 10:43:34 -0700 (PDT)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ff111c4f8asm383833fac.6.2025.07.10.10.43.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 10:43:34 -0700 (PDT)
Message-ID: <d7e76007-10f4-4507-a2cd-1707ca6a8918@linaro.org>
Date: Thu, 10 Jul 2025 11:43:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] linux-user/gen-vdso: Handle fseek() failure
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20250710170707.1299926-1-peter.maydell@linaro.org>
 <20250710170707.1299926-2-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250710170707.1299926-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x36.google.com
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

On 7/10/25 11:07, Peter Maydell wrote:
> Coverity points out that we don't check for fseek() failure in gen-vdso.c,
> and so we might pass -1 to malloc(). Add the error checking.
> 
> (This is a standalone executable that doesn't link against glib, so
> we can't do the easy thing and use g_file_get_contents().)
> 
> Coverity: CID 1523742
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   linux-user/gen-vdso.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

