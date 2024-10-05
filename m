Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E761BCF8868
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 01:18:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swtQx-00088D-Ol; Fri, 04 Oct 2024 21:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swtQv-00083i-Op
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 21:18:09 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swtQt-0005JX-54
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 21:18:09 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7cd8803fe0aso1911536a12.0
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 18:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728091085; x=1728695885; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GX/Eqy1qm099gCDJtIWpuYiPrXuYxuiWTsK33NygheE=;
 b=EfSci7sN4srsTI9IrI9VDXdRnzA1igS2t9yRRkoZ0FnFnsfmsUcLBW+LSX/iStG0QU
 jVz8104kLbqz2kCTVYsHZXSNwrvNbJTZNi/xMLs1lt0SfbP1KJr7RC+ib9k9q2t+IiWn
 4laxcQm9OTMX18d7h5xSskKJGzMPcNc8kgw81zOGFTVIFZUwv8DeB4y6KZVtCsg2AvXh
 iQEgu6hKSpVO5bOGEgUqrd/5vgUhyQ54iHD3wk3do2PeUIEOCmWSRn1hgbAm+9ruO1a6
 G04bliAUACDVhA4F7/SSaU8G95jEOR0ufclVb7R5xa3jzCQ1OQJi6FkdPTgk/xdQ2o5W
 YIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728091085; x=1728695885;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GX/Eqy1qm099gCDJtIWpuYiPrXuYxuiWTsK33NygheE=;
 b=jDGMWHo3PDRS7xYHG1httzvQLyng8yMtFDSBXrBaj6yLPJf2lJ7+swDQ/tCn6dAsRJ
 WlKLElEx9f1RZbo3sMCohy6KntwIYyq1G6/e3ZKV1k2DB7j88YoWZ6Rca07QEw5ZlGCq
 nXf7RTM9tgn6drM66vGD+1uUDYlDxf9dHOrKGIpZ5TvPzQqAzm9uKxzhGDaOy6YIenNf
 ddhJH53lrPqaHErZTo7cJMD+hVcHGy7zM41zsFWIrKlilhePLLkvvmI9XjMis0bqHjCN
 tmes02K8TFNyzgQGg+fCz5xsQ/Q++7ypz54uLLt+7mJ7/kVYVQgzqhz5qWu4lwkxp9+y
 +dQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVR1lLtRgJ8AG4vdPoQtKULF+qU2p9Rkr6n/la4a31x9l8FFq5CDXSLGYwu8pLsOC9pUlZKcTZkCetC@nongnu.org
X-Gm-Message-State: AOJu0YxZEFWW+FrRuzaYS2qwaUbg2xui3nMweF4534TOAKJn80qexGj8
 ZnrcMi/M2Ce4tmiDGKNAyZyqVWHR4UlKS4nJRY3Xx/IIPNM7/XvYnbEeOqlLDZY=
X-Google-Smtp-Source: AGHT+IEnnNmpluWhLtWH6c+kZ4eKqfCDu42gFhZRsXu6PATwsNVkZaa/XKVqO+VF0wnJPLADXNr+BA==
X-Received: by 2002:a17:90a:ab0e:b0:2e0:b5c8:9ca2 with SMTP id
 98e67ed59e1d1-2e1e6224874mr5045578a91.9.1728091085589; 
 Fri, 04 Oct 2024 18:18:05 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e20ae6dfa4sm622950a91.2.2024.10.04.18.18.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 18:18:05 -0700 (PDT)
Message-ID: <b200deb1-1951-4526-bfc3-8ed35409071d@linaro.org>
Date: Fri, 4 Oct 2024 18:18:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/25] target/i386: Use explicit little-endian LD/ST API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org
References: <20241004163042.85922-1-philmd@linaro.org>
 <20241004163042.85922-10-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241004163042.85922-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

On 10/4/24 09:30, Philippe Mathieu-Daudé wrote:
> The x86 architecture uses little endianness. Directly use
> the little-endian LD/ST API.
> 
> Mechanical change using:
> 
>    $ end=le; \
>      for acc in uw w l q tul; do \
>        sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
>               -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
>          $(git grep -wlE '(ld|st)t?u?[wlq]_p' target/i386/); \
>      done
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/i386/gdbstub.c                | 30 +++++++++++++-------------
>   target/i386/tcg/sysemu/excp_helper.c |  4 ++--
>   target/i386/xsave_helper.c           | 32 ++++++++++++++--------------
>   3 files changed, 33 insertions(+), 33 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

