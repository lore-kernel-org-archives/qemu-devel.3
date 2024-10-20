Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BDED3C92A
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 19:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2c1Z-0003qL-0M; Sun, 20 Oct 2024 15:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t2c1O-0003ie-Vd
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 15:55:29 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t2c1M-0003AN-0G
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 15:55:25 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2e2e6a1042dso3063610a91.2
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 12:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729454121; x=1730058921; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HEx3yaOQ+UUv2fl0LMuoaa7A/6ZwyFBbigLymXasA+k=;
 b=DO0BrCl54H92lxy24UWbOUm2zniN573E2wtzCkHloVAC2wW0g/ukI3tKyt20TCXxh4
 j+fiESfxCm+bHVTGNvEF9hcR5Z+Mq+yO/sQAOHnYz6a5qUlf2dQkmTTer+7xdRxGvYTS
 FX8cdjDjTpy9tjV8pI4zS4EOLVW+DjaPSgwqusTPRf/2RoB01q+R4RMoMvAMZ0joj3yB
 7bp9WCN/TClsygHQSO9jfVDl3m/hrYc0ZEuCuGfxnOe0VQcPiJMvHXmuXXBH6EG85xLZ
 agSTLVbiwh9XOLnMDZJngXTmepJAxFIyb/vyxLwT4XkSP7FntUABcz+qTR4WRiqmC0y2
 dx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729454121; x=1730058921;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HEx3yaOQ+UUv2fl0LMuoaa7A/6ZwyFBbigLymXasA+k=;
 b=vNmIAzqRKF6gflvpR0vNjE0qOrkD1jyno9E/cEjhX5tYKoFUH4R+XaVzvQGQ0Wq/cm
 SvpYpyQOogAsrb9D7NNK/9/TIAbBOcnrqL5ejFd7YakasURKwKcx0VQqTozjmN4ky0am
 6PFoTxIQUVvVjjgwwlTqxh3rHxvzFnyMTC9htyZhsPsWUpCaQ441IIV5jGVS2eWWTNfQ
 xKqzA67zBch111Df4Ge1z6D8wpU+r8XBPHCy7BgqyszOt3sZxz10ZYvWRS7LSwDfLtlm
 cLpDYrHh1zsC1eCDAaJLNWf/0b5cL/invWfdZnLHT9SnM4PoeEk+PymML7u2MByAu0m6
 TQXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpJRhVSG3YcIFI1vLrwqh8K8pmxyoeYmbVG9Y9FEEYajZLs3yJf/NDR/BROHablGyZKB/MIwwEgTS3@nongnu.org
X-Gm-Message-State: AOJu0YwgUHJcqkrMTCvh0+eZ0s14VzwQY3NrnXCM5qpr//LncsxmG03L
 UmqUiTP9T9z8Q0hnl6GnUdgT9S8TnaSuoI/YfG8JvEkI86eRMhNmKRyS2u2TnBk=
X-Google-Smtp-Source: AGHT+IGPtW9eLUNFUgfaNw+qyC1Dj/ErohAEvAWYY+f3qz7js09J2zr2u/zK3N0wsy2nQ2eFvM8YtQ==
X-Received: by 2002:a17:90b:17c1:b0:2d3:cd27:c480 with SMTP id
 98e67ed59e1d1-2e561a11092mr11668874a91.33.1729454120883; 
 Sun, 20 Oct 2024 12:55:20 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e5ad3677b2sm1933020a91.20.2024.10.20.12.55.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Oct 2024 12:55:20 -0700 (PDT)
Message-ID: <20713904-0754-43b1-8b7b-9230c05ed7f1@linaro.org>
Date: Sun, 20 Oct 2024 12:55:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] target/i386: remove CC_OP_CLR
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20241020155324.35273-1-pbonzini@redhat.com>
 <20241020155324.35273-4-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241020155324.35273-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 10/20/24 08:53, Paolo Bonzini wrote:
> Just use CC_OP_EFLAGS; it is not that likely that the flags computed by
> CC_OP_CLR survive the end of the basic block, in which case there is no
> need to spill cc_op_src.
> 
> cc_op_src now does need spilling if the XOR is followed by a memory
> operation, but this only costs 0.2% extra TCG ops.  They will be recouped
> by simplifications in how QEMU evaluates ZF at runtime, which are even
> greater with this change.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/cpu.h           |  1 -
>   target/i386/cpu-dump.c      |  1 -
>   target/i386/tcg/cc_helper.c |  3 ---
>   target/i386/tcg/translate.c | 10 ----------
>   target/i386/tcg/emit.c.inc  | 15 ++++-----------
>   5 files changed, 4 insertions(+), 26 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

