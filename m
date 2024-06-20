Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFA3C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 15:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKJcC-0005j0-T0; Thu, 20 Jun 2024 11:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKJcB-0005is-Br
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:22:19 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKJc9-0007pf-U7
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:22:19 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1f9aeb96b93so8059975ad.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 08:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718896936; x=1719501736; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LYxRRHrFLXjBu6x3E9bHKIH/sqVDpzERW+KEdi14p1I=;
 b=HQOECb621vaudnuxgC9JCW/ecoNbM0oEZp6KvQpEnGEfxPr7cNwlWfXiK98emhvxyq
 SoEfI8wzODg/zK1mdHWIMkyu3GOuvvvvW2M2KnZCku5KA54Vyp2u5n7Fr8GIqLju4Jsz
 ntPBcNl97fwmf1z4S1/JIhCEv+8TQOXu7EUcsDDZOgMwWTp/J36x48lTagvPAnsEOr1K
 w08HIyk7qMGbxd8UurOuB01CpDLx5N0aQuBnqsxFVoxgfQ7oA876nHwh2vdglMvuESVw
 EFDe3OH9TgvPDY9yYbj3+HhtiSOgFRzDgFYpjM+mYGm+ybHxrouvC6jhkQ8anm0vomL0
 0toA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718896936; x=1719501736;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LYxRRHrFLXjBu6x3E9bHKIH/sqVDpzERW+KEdi14p1I=;
 b=SyzQc/03Uz/lCU4btCRZM4LP0a21HhfB8LABHW5iAZCRwpBh6mMTn5Up/zpJ+c5IYN
 5FFVa8/KuwqjyCpkudUpfmUTTZW6czSrtoeeqa5LJNCoF4oZRLIR5e3kY4UcB4IeSFvL
 5OHSfMGkMl4ZUrrZl58c4SpCIajPriJPZINX0ehhSA3NZQUIIPsjolNb4B2Hgj4UeSRq
 efRMmsfVMTGNYTKhryeUgOIRgXelfL7Gyh5RaqRrMk5oh/5yFPvef5Fm8AYnT3IMawmA
 QXvH/7/MPNOAea2WBeIor1nswbt2LiU92aV8f6lVDbD8tReISMPLdmdO4K31GnGc6F1k
 wjDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCULSSPcIwiQVmM7YKDvU5Iiwb3xinp+D8BBTWA9RfGzz5j2dGeO9V9o/IVIj78zgEOpsaq2XB202TmX4m6RdRB4QKGEOWE=
X-Gm-Message-State: AOJu0YxqQ6q4emXpHZKgbE9ShKhAZFguXFf4tHzcvSKYNtUDqIiAOLT1
 PPOgVsLKjinfzETg9Xc4JVGPokC/yylfb3+A7GLwQPcKwHtMcBlC0ysO38fkbnA=
X-Google-Smtp-Source: AGHT+IES4MIVeumoogDJOzZGClM8LLbSmXHCuNZAdAVjytEzOgIGBV0WUiXLcE7wSqq9pnTnixnx9w==
X-Received: by 2002:a17:902:f54d:b0:1f9:b7ea:c320 with SMTP id
 d9443c01a7336-1f9b7eac674mr36319775ad.41.1718896935954; 
 Thu, 20 Jun 2024 08:22:15 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9c22ae4a5sm22426975ad.7.2024.06.20.08.22.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 08:22:15 -0700 (PDT)
Message-ID: <a090fbb9-1b74-458e-bf55-8801aefbbb65@linaro.org>
Date: Thu, 20 Jun 2024 08:22:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] target/i386: convert bit test instructions to new
 decoder
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240620095419.386958-1-pbonzini@redhat.com>
 <20240620095419.386958-4-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240620095419.386958-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/20/24 02:54, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.h     |   3 +
>   target/i386/tcg/translate.c      | 147 +-----------------------------
>   target/i386/tcg/decode-new.c.inc |  40 ++++++---
>   target/i386/tcg/emit.c.inc       | 149 ++++++++++++++++++++++++++++++-
>   4 files changed, 181 insertions(+), 158 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

