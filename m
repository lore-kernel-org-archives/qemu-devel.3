Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06798D2C55F
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 14:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3G1f-0000oZ-8Z; Tue, 22 Oct 2024 10:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3G1Z-0000l6-PA
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 10:38:18 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3G1V-0008Bz-2D
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 10:38:14 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20bb39d97d1so53289925ad.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 07:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729607891; x=1730212691; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZHv9odFw8OtU6TsS81DtLGPHRsVBR4nOrm4U1FpdkKA=;
 b=QIfAHF5/pDgb20MHxFB6y/IBed/nquL5sDwwHTRrMG+K9FPwhEb+GN5HNLb41Oqi37
 PIWdUdaCVRr3zj/ETXe9yJkm3nf4HX4cEaI8gFMxnVkUBOJJSraAmKdWzaXtWSD87sZI
 5KDAgCpyj+p1xAgOhMgwkx9ohzqDZa4NhVoybqr/d0d6lI39tlNoadAjC/2sDM6z0Di+
 mt1qQ24q3oU/Ygai24SFZxkwstGwD5D3h8ts2rqaP56xoY7cnZEOOqK6CzeAgJux034j
 JkOhCwBwhmCyYdcTWdFjE2bi/Y8Z04JdnKwFwq/8v+XoiwO6Qt4tePqNgZx443rxYLBd
 /Z3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729607891; x=1730212691;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZHv9odFw8OtU6TsS81DtLGPHRsVBR4nOrm4U1FpdkKA=;
 b=qLRYP85xyKpY/l/ziBJZC2Po7M8KnCz+cfje+Cqyu4XZPlzB5Ry+qep6EUXdjDXU+y
 PLnznNsRwkEGyrQT9LL/5RC4ibXEgan4MNTWUq7mpbHW7q3mqo0OQPw1zeIZQFXIv/sk
 H5zajKLbdO+RhjHJsGZnQX+VRgAnAjEqk1LIF3AJixpPyqWyyxOiguVSukXPu2/cy+WH
 rTuSE/ffntb1KTPONHA4FlFXwXXmSAP4rEHU5uh5d45pa6LWLYK/mDBEOInVl9dWzUEd
 F+rezQCSiCowLmfrVdgwlqQ/tGyrlSj8y9Ap5mfDSjxQzies6ZDifhgZkIXGH3C5UwS4
 tfCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRFJNXW3q7r8qGxkzrlDifxcfF0g4RtldJL1gdpvEdZ51Ofp+r34Sq6hrXGRLM5sgdipfuegLsO1En@nongnu.org
X-Gm-Message-State: AOJu0YyV0F+eGTXGhbJ7VvNNpoJExgP+h8dz0OvoFeTn3meB81evRVRc
 muQetUhSfe0/6HAy97TXS0hm5bOD6SP9/uCvGMHV2r+CxIToygRAZcmQIGymf0U=
X-Google-Smtp-Source: AGHT+IFyHDQVRkdOPQ3WY0+L0QN0w0F96Me+U+Ko08pdBhh9JnZW1M40d41Mtub9x3TII3/TSoZv6A==
X-Received: by 2002:a17:903:1c1:b0:20b:5b1a:209 with SMTP id
 d9443c01a7336-20e9487e129mr50870435ad.9.1729607891653; 
 Tue, 22 Oct 2024 07:38:11 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7eee64fesm43659175ad.56.2024.10.22.07.38.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 07:38:11 -0700 (PDT)
Message-ID: <47ead90f-fbb1-4e18-a5fc-5143b79889e6@linaro.org>
Date: Tue, 22 Oct 2024 07:38:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: fix CPUID check for LFENCE and SFENCE
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Guenter Roeck <linux@roeck-us.net>, qemu-stable@nongnu.org
References: <20241022055944.148030-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241022055944.148030-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/21/24 22:59, Paolo Bonzini wrote:
> LFENCE and SFENCE were introduced with the original SSE instruction set;
> marking them incorrectly as cpuid(SSE2) causes failures for CPU models
> that lack SSE2, for example pentium3.
> 
> Reported-by: Guenter Roeck<linux@roeck-us.net>
> Tested-by: Guenter Roeck<linux@roeck-us.net>
> Cc:qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.c.inc | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

