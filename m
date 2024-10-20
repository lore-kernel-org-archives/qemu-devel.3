Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4802ED3C92A
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 20:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2cPE-0001O7-Ax; Sun, 20 Oct 2024 16:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t2cPC-0001Mi-Qq
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 16:20:02 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t2cPB-0005Pc-6t
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 16:20:02 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2e3fca72a41so2377841a91.1
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 13:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729455600; x=1730060400; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WjBqs7nTo6qtTxtTkKm98tJRN8pIQH8CQltOrgFPwW0=;
 b=n227KrIZ1nKMVh/OeWdyGJb7mKrv7woLF+yJ0DzwKxoNKQWrTLaAApJAcE9Ri6xRXZ
 Hcj0/ayTE7z/TmwNAkjnPUwYCP10uk+G36tF9jH+u/lAFGJIvSlLu8VHB/TO/MJ38XuO
 s9npRkM/PcyQIsR4oGIQL/BLlZRaCoveU/elvH5PX9na5OUX+QaZgewgPaq43gr2MT1e
 r9xCYuPf1r7PZYHj2omePG6khrtIvPee2AUEqEMlLMsIpUYFQ0EFyG8uEj6iOQTirHl1
 QYC3Ckg996EYlSEScdL9JG7QAQhSg9ml7DKN94FXMQB8hsCD1E7ldBsVPBWv8RP/mn0D
 9UrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729455600; x=1730060400;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WjBqs7nTo6qtTxtTkKm98tJRN8pIQH8CQltOrgFPwW0=;
 b=EIlLJKm63cOIRnJL3QiwFc6cuR2hYn6cjqKm1I9zAiurvSChqwL7mARl3ZUOPjTZqN
 LnPn9xVI5RB3yikgA23O0vyqmsfY5Ue9ZE1hJ65UxgNeIN2w/ynzaaIpk4j0fwWIHPYi
 GlYwTHwJDkZsJ80c0oqUsTvyJpXVsweAI8ld3dz1+AZHR9JU8uh2pa0kOz08JAcimE6K
 7sgJ5e1+v8aPmiDaOUdGLJrS/RsrZbkBbur/JoCLfME3sE7ea58NGnV0j/s/nCmKKPxS
 EnXf2twMleWBRlFv15ljx8uPwmDL3J6Xq6FKk1QEf1Xvr2G5j1/dlOP6OeIKa9gMY6xU
 5LoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6ItyBPxL7dLjfaTddlSPeWi1iVD2E8X4e14YJ5an/pxmVovmBl7HUqo9v/lScgb+LqR63x5j6mRhv@nongnu.org
X-Gm-Message-State: AOJu0Yzio3p7/yFE2pDtS0nyQx29y24Vl2I+X7CU7SOZyQciSIRpQfVU
 jt94TS6BdCv+hfgmEH9Ez6KWpuaQrZ9Mm56XozTst2K727gQjh25shvyaIhwUXLpHB1X4NPvDa4
 c
X-Google-Smtp-Source: AGHT+IGGPW9fZFpEgl8aKA6dtGwsBBJKw04tHRA/mGXqSfXQqo1ifCF0PmwiPlCH0xhWSxhOGLZRHw==
X-Received: by 2002:a17:90a:d903:b0:2d8:7561:db71 with SMTP id
 98e67ed59e1d1-2e561702ff7mr10235499a91.25.1729455599735; 
 Sun, 20 Oct 2024 13:19:59 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e5ad4ed825sm1949069a91.35.2024.10.20.13.19.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Oct 2024 13:19:59 -0700 (PDT)
Message-ID: <2241fddf-e615-4433-8978-30bdce322deb@linaro.org>
Date: Sun, 20 Oct 2024 13:19:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] target/i386: optimize TEST+Jxx sequences
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20241020155324.35273-1-pbonzini@redhat.com>
 <20241020155324.35273-9-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241020155324.35273-9-pbonzini@redhat.com>
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
> Mostly used for TEST+JG and TEST+JLE, but it is easy to cover
> also JBE/JA and JL/JGE; shaves about 0.5% TCG ops.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

