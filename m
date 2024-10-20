Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC89D3C92A
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 20:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2cBL-0007hW-CP; Sun, 20 Oct 2024 16:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t2cBK-0007hB-Bw
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 16:05:42 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t2cBG-0004QH-TA
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 16:05:41 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-20bb39d97d1so34415225ad.2
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 13:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729454737; x=1730059537; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MlQBpHmMmDsdDctkEulIme4QCbIC2xCJIRQDh0Wlj8M=;
 b=r0w9w9wqNATc/dhhbWE5hXwZE1eEvgYm/bj/+Hy+bScYwG9a6iq+pERbLnEL8Poi3G
 nuUZfAbqVW27PLV/l8vJFdbPqvAgRBgRkWGOFxKVGZ5tNeusxuhm5y+SDVCzkSXWrXjS
 QnkgJtyht6aubPIR5gvIUsGMZWjuRs43MQmM1p21hg9UfT8JjskAif3BzPUXybwuyIjC
 PJfB0P8wZPKiLxJ/YSvWSndpjvjX6PisjFBvEsyH4qxqPKyq/DRtq47LgvoORMaQQ9ui
 yESxDTeZCllinpg5O+rrx0wJQlnCg9E+TLEdni0RYq8n5Jw/E23xPI2+0Vm48pLfvgsD
 4TUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729454737; x=1730059537;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MlQBpHmMmDsdDctkEulIme4QCbIC2xCJIRQDh0Wlj8M=;
 b=GX0JcrqkHshVVzrZmcFlzOYsQqVBEOTFOidY1fnsY/PsbQgFWkKmxpyafidcGuj0o4
 rw/oVLH1Xor6zmoeBZhgK6Qnn+W8DL1xASfKgbceGuj5lssmnu9r4rWVwZHuomxE1x7e
 BhVLAX4s9e3m8dtVGLYti7ywOiqDdt9LDECVkRBvemlLC3X4D9qm46PVzGMnqauXjxNp
 PyRw1NjDOhKtp3KR2LrbzwjFxmTsFqP/r6Qx2IeYKnd48GRe4veZaqwbhuN4ZxrnxPNf
 2uX5FiDuq75zsyWaMpeM8f57UxhtpWNTzuq5pqnLHSjU85uTYtz2Iv0JpUE/mqyqvj9D
 dfBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWo0koKOZzUN1Na3G8eIUhndrfOLZqxEyKsafiWPnIOAKnQgwd8uX6u19ni/9OWzRK6zJ0H8pbDjgt@nongnu.org
X-Gm-Message-State: AOJu0YwNLND3a1AEAz9YFb4HYXWBfAEw7fNvqn779SFPK0pk4NI3S1PL
 wdHIwHHoiLXJREvHbiYT8BpeEIhdCY8v8YaP5SCF0wozCGl0QEP5XujTW/a5bX81NIXkb+fM9s2
 c
X-Google-Smtp-Source: AGHT+IGMmn/fzPs7fhjmZqM3AZaBY56bqEQ9BnZ/9ShF50U+05CNhgRpjIwCc+MY/zqMpQ99dnPyBQ==
X-Received: by 2002:a17:902:e744:b0:20b:770b:ad3b with SMTP id
 d9443c01a7336-20e59a9c3edmr122185085ad.0.1729454736725; 
 Sun, 20 Oct 2024 13:05:36 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7eaeabc118fsm1635386a12.70.2024.10.20.13.05.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Oct 2024 13:05:36 -0700 (PDT)
Message-ID: <d36362ab-a99e-4e3f-b6e5-13890e20bc6a@linaro.org>
Date: Sun, 20 Oct 2024 13:05:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] target/i386: Wrap cc_op_live with a validity check
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20241020155324.35273-1-pbonzini@redhat.com>
 <20241020155324.35273-7-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241020155324.35273-7-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
> From: Richard Henderson <richard.henderson@linaro.org>
> 
> Assert that op is known and that cc_op_live_ is populated.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/cpu.h                |  1 -
>   target/i386/tcg/translate.c      | 21 ++++++++++++++++++---
>   target/i386/tcg/decode-new.c.inc |  2 +-
>   target/i386/tcg/emit.c.inc       |  4 ++--
>   4 files changed, 21 insertions(+), 7 deletions(-)

Wrt keeping the array,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

