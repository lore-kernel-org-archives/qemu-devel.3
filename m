Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BECC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhatc-0000oy-9O; Thu, 31 Jul 2025 17:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhadF-0000HZ-QW
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:16:17 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhad7-0005l6-R6
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:16:08 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3137c20213cso1062823a91.3
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753996560; x=1754601360; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CmqTCUe96iESu0bw2yjw9CPAjvn6DZyZjgJveiBW7yI=;
 b=MWA/P0wuHfzwi6YYPXB1ZvmGD/wUv79LrArPC0OmSfGl/D6Gy0hF/Dt+pW1NiTX6mW
 WBZcVOzP41RRqG+3YdaqIR58PT1cho23UCtx21yF6zwFScWVDIqDoHa/zttDA6wIYd7q
 Xtpqgg21KCmduj7pmuhqcWVLxisKzv7SLLAdNczJb4amu6rV9JSONoyj/7K4OVLL789I
 ezA0NJPpNQoUez1z69s0q6jHG7XFKh8KiWKYPfZwWrX4i7lXgpy3x1ElHYOSgBhGXAf9
 54M8ldaaFu20RTrLRkWazJu7miES9AErkhoOkgjb1XcZhU7AgwcuwLIDL1YYbHqN6J0P
 fPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753996560; x=1754601360;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CmqTCUe96iESu0bw2yjw9CPAjvn6DZyZjgJveiBW7yI=;
 b=P0S1L/stRl3hDpbv6oYRSzQ7sd50s3mxk0bZqxGArmfXEaHYQNk2G8QJugLryh7Vb3
 p161gGUfKHy6X1RXxbDbl+GTYvkYo0ZYBrPK97OnLC9PzGPXKzr2MEo6K88xZcPfCoMX
 32ruGPDKCCQd8g2H2/x5SzKRr4v5S0o3jxrhSDHkJJhEur8B6hxborjrBP1BqgwLVFs2
 oECbM//LJW50JE1jlkNoYYXDCjLQv9UHAiodlBQ9FPuFGe3CiYQt6cwUEM9FU2611gfC
 NDeMqxG1myRlF7s7wMwRglpiazssgUSPXyr//tpz58hBz54BURq9yP5IvsDdyi32KdR4
 ZBaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgg6OiUiioeTwTjP/dAh4/UjWSeKi2tZIAP4v6j7BEKgpZSU+4wUnuF+WT02joPM/sejcXmF5sunix@nongnu.org
X-Gm-Message-State: AOJu0Yz5hzro2yBBhp8B+YLQWFSt3ZAthlvW4eBVrC+wbhmyr0tetj8X
 aDV04nImTEYVCPJ5748ei8cCEm+CwpSiwlv/i/IzCv6G+aQvfvym9PAabO+4GklBHuU=
X-Gm-Gg: ASbGnctm9Y4kg4YX72SdDg6qNRo5ok0UDOdqLE0EBwCU1DIL48kE9IEr9Z/ooWzUW2T
 7H5evtq5LmaHbpRXv/LtTkzS+vGE2ljyhj4Zo0opfamZG/6ZAPdkh5jSBM2yphE45zsItLlrC4Q
 9EOnKmwKOy7gmRqVw0LbX3M08OhJyhqPzvggisGLLm6rYVYjSGfuZpthds+fDmVuYkexI+8WhKV
 GB2HRcVpM+HkaNjlNT97165Y5o0KrIlbvkZusQNdj8co0peSuqoLoIu2cC7DILwBdcsWTLgRDaa
 GGaGOMMlQAL1s4vbkNZZJN17PqVPqVW1B53ybTnTMFpVeJK7oqQ606D4dQYtfukZeo2XK8gApPE
 BKpOWQJn29/GZ3riY5baM/9t56snyB7WD7f8=
X-Google-Smtp-Source: AGHT+IHcJgvUA6TDFb+y1YoFc8PSr2OHzUbFTvXWwYiXhDz0GOxI7JDquXCSqLbDOOJLEpKTPvg6LQ==
X-Received: by 2002:a17:90b:4c8c:b0:31f:762c:bc40 with SMTP id
 98e67ed59e1d1-320fbc0ad60mr478332a91.16.1753996557795; 
 Thu, 31 Jul 2025 14:15:57 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63ee49e0sm5558504a91.24.2025.07.31.14.15.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 14:15:57 -0700 (PDT)
Message-ID: <73ebca7f-570e-4627-8813-04a82871b5c6@linaro.org>
Date: Thu, 31 Jul 2025 14:15:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/82] target/arm: Implement get_S1prot_indirect
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-17-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1034.google.com
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

On 7/27/25 1:01 AM, Richard Henderson wrote:
> This approximately corresponds to AArch64.S1IndirectBasePermissions
> and the tail of AArch64.S1ComputePermissions which applies WXN.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/ptw.c | 169 +++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 143 insertions(+), 26 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


