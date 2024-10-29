Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E97DD3A66E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:45:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5oPX-0003Ho-Bg; Tue, 29 Oct 2024 11:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5oPV-0003Bx-1w
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:45:33 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5oPT-0003i8-Dr
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:45:32 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4314c4cb752so55204705e9.2
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 08:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730216730; x=1730821530; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FJPOESiGSRpd0rRX1XLnheFUZTmMEaZE1cP6Ie8IL28=;
 b=NJ0zIVxW2xilAEAnVCO36qqTRPX78S5iYnQIzNDqnSAI7iAQBLH0D1BXA6tLbmhRKG
 wdd6LrVUitPxLzEIg0lcLb6hI14+DAF8SlBPSDt46eXxlHGRJX0unVzyiDffyLKFBgjx
 OKybdhwzby6N2pK+6R2etqOrrvJOoD+NV3FPXb8g21fb58lENLt6Q3ceYlnCcCjlrDRo
 uhh8KHsh5RSNkqAL+VtP4e8ixVH5z91lTFYqecu/rCn+ub+rLcF7DLDhZyt7AQU0KlmH
 9IgEoKjp85waiXE0BMoqGCEtjfc1adqknFtUimj2ybncWQoOo26bFSB6NZZDijDZJj/m
 XqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730216730; x=1730821530;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FJPOESiGSRpd0rRX1XLnheFUZTmMEaZE1cP6Ie8IL28=;
 b=Df0i8rhyyQpuE1ry/+7qFBPkAfYFfSZphGASHkJRc0RmSnV6qikRLKM6XubN4zGhjV
 9HyfY+5o6TRovoI7qxD3PMlD0lIKN+iVt65Rs2Yr75xsy4FNLf1IrAzqHp0jYtJrks97
 +bzNKDQ3M2IqbywymaKPKC9fTTzTLJpPgFz9Ly9d4TfmD0Mz1xX4TzdxPYULCnL12Ru4
 op4MPkFbJL+al3bY+akPVVhwcspQMStu4UIDIMmj7C7PUa21nNGL+4KyBEzMOXDfnkTm
 R0QqTYTAztAbyDJiWF09E8FYvyUAeSP57AiyRNAKBcdPZ6wbhSO2uPaoYaDCrbfAzHx/
 wQWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF7KvD4ZntIlk6al/VLgbhqwFgOhfkdetxO86+E6nP6sRT93hqLYa/Zpc4gkDAa+AFk6f9NWSIyec9@nongnu.org
X-Gm-Message-State: AOJu0YyCFRrdjztxlyFBai1Iafm2Nj3Hli7SCVNPkB/q4eJWcxKKfx6n
 25mAbd5rzlFu7daqcTokha4NyQVGvjC3ccNwCt+QCYE22JU5ad2iVbxxTcQMkUplCCWmRGx/LgN
 r9Ln+2A==
X-Google-Smtp-Source: AGHT+IFUojVzVd4Pivm3zKHl7HaARm3aDUj4Kt4nL9rDifWhenGkdbot+WuannVsySbXZnOB2KeJZQ==
X-Received: by 2002:a05:600c:1c85:b0:431:1512:743b with SMTP id
 5b1f17b1804b1-4319acc2afdmr109733545e9.21.1730216729786; 
 Tue, 29 Oct 2024 08:45:29 -0700 (PDT)
Received: from [192.168.21.227] ([89.100.107.89])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431b437cf66sm18733835e9.0.2024.10.29.08.45.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Oct 2024 08:45:29 -0700 (PDT)
Message-ID: <f9a53be7-cb0c-45ee-ba77-c7eb831618b0@linaro.org>
Date: Tue, 29 Oct 2024 15:45:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] target/i386: use compiler builtin to compute PF
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20241028151851.376355-1-pbonzini@redhat.com>
 <20241028151851.376355-13-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241028151851.376355-13-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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

On 10/28/24 15:18, Paolo Bonzini wrote:
> This removes the 256 byte parity table from the executable.
> 
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   include/qemu/host-utils.h                |  9 ++++++
>   target/i386/tcg/helper-tcg.h             |  6 +++-
>   target/i386/tcg/cc_helper_template.h.inc | 20 +++++++-------
>   target/i386/tcg/cc_helper.c              | 35 ------------------------
>   target/i386/tcg/int_helper.c             |  4 +--
>   5 files changed, 26 insertions(+), 48 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

