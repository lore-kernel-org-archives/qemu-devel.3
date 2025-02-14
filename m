Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96376C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 15:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiy1O-0002T9-7A; Fri, 14 Feb 2025 10:54:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiy19-0002Ss-4j
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 10:54:15 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiy17-0005CH-If
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 10:54:14 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2fc291f7ddbso1856272a91.1
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 07:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739548452; x=1740153252; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1wCbTaOwWdHHJ13x1dNiatphfyIzFvISwGiFEvxXfxY=;
 b=Hx6yl0N3hA61d/I/sAu+EwEz7hIVwSzIBIMzaBT2SAzE3uDaMW1g8hlRwQSV7eQoUS
 HZ6/b+aoAdvtr1FH/WLIfU7ULVuROqaxb0gzbNsaCf1o5UlalIruZJSxz4ZM3e8oxdJ5
 lw6wkOVizK78l7gv40sRdF5YmLrrCEPkplYqSUL9mntz1mprumxv/g0Cq26c0s37Vvdw
 18WDRUC9Lv4FLZGrp6+ekoisn3YZOsmOlbu5/+PTUX7NOe17tprZCbq2rvJXsv+p/hC6
 L/GYUK1gJQDklXxCGOynqhAihuQtLjIGFi1Jt+RNFjTYoIwaDLyvFxPtFvnR0AxbhX0D
 DxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739548452; x=1740153252;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1wCbTaOwWdHHJ13x1dNiatphfyIzFvISwGiFEvxXfxY=;
 b=D8xaV0BbZ0UnmHsWEi+34kmcQAfabj9jSTa6GYpWJPgBxFP4gsFv+kfmm9AiGlHVjI
 iiWy9APmJNTzPk4+JKXnjjK5XUi3+nAuNodkT4DG6+0ZtZL7jqEhdOqrsbXymneOis4R
 LW5dWynjY+nhh1F4quv1rlQBkubgBVyxMPuPLz904WmGS4vMuJZjYeSWrs6B74T+HrZ0
 /yvvbJDZhiMBwlAk5UN8f1Kig3e5qOozrqG98ZD2CKXqgfapdN30nPo19z6RlZanpfk3
 /l4kV343MeOAVwgF1lMaEBlJtRhs56yiHe7HEzmGByY59MUqvIc+S+s0poLlJaJ8sE4r
 oiLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyrVq2wNF0nmPpVyfZXf4+zb3UtOr1EhbwFcbe0kaq4I1qi1M5ld69yK3t4uzfkfOKb/lVEqqvsNJ3@nongnu.org
X-Gm-Message-State: AOJu0YwnaIHaMjpKsFDkSbcXY/VCT9Zq3WxNBUNH/1qmsbuZyqz8j9EE
 QfqKlsZBCD/n87Uz6Mx3PDLZsjKaT9W9Flx/BaGVFi+qY2emmJAhPY6s95S4nveuLjULkgNVQX8
 N
X-Gm-Gg: ASbGncs45j4reTsNzr+TmauKnP2YC9GJYVESy7GoQw9VN1FOCVrroOUyM/Dy4HWHAXr
 hONKJnyvoRiOaM7NbJyCETUovCCeNjsv9J9qdTU/FDdM6I2yR2/0R2qs3vn0QZExIO6xMDPt9P0
 8nRVFvpL3MV/AWhSl+/HSdagY+qcnR1AZHDZSp7cyeSFLsnIMZPP9Ns18UXNmq3zRF/mU3c09Qy
 EKXcK19APJz16uJxaUam24ZF8V9ox4H1wZF/gSd6P4Lb6x7xD75WiZHPgMJ+YE+ofvFwDXFvq3r
 NZYLheE9ZiVlfPRS1RIccNnJB3L5OHJGVQETObUNOetHtIzvfvPiuhY=
X-Google-Smtp-Source: AGHT+IHRPyHzSYbnaGzK3mLpGfxQ4QG/IjokCFP4SBQ7w23bc5DweheNK3HA+eVa9RzO4HWttp3I1w==
X-Received: by 2002:a17:90b:54d0:b0:2f5:63a:449c with SMTP id
 98e67ed59e1d1-2fc0f0b05bfmr11862309a91.28.1739548451999; 
 Fri, 14 Feb 2025 07:54:11 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fbf98f0facsm5364398a91.23.2025.02.14.07.54.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Feb 2025 07:54:11 -0800 (PST)
Message-ID: <a8aef09b-e8de-4ef5-874a-f541d0122a5f@linaro.org>
Date: Fri, 14 Feb 2025 07:54:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/sparc: Fix gdbstub incorrectly handling
 registers f32-f62
To: Mikael Szreder <git@miszr.win>, qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20250214070343.11501-1-git@miszr.win>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250214070343.11501-1-git@miszr.win>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 2/13/25 23:03, Mikael Szreder wrote:
> The gdbstub implementation for the Sparc architecture would
> incorrectly calculate the the floating point register offset.
> This resulted in, for example, registers f32 and f34 to point to
> the same value.
> 
> The issue was caused by the confusion between even register numbers
> and even register indexes. For example, the register index of f32 is 64
> and f34 is 65.
> 
> Fixes: 30038fd81808 ("target-sparc: Change fpr representation to doubles.")
> Signed-off-by: Mikael Szreder<git@miszr.win>
> ---
>   target/sparc/gdbstub.c | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

