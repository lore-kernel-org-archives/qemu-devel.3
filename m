Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCF8D42B85
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 14:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAs0N-0000RT-RZ; Tue, 12 Nov 2024 09:36:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAs0I-0000MI-GK
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 09:36:26 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAs0H-0000Ea-2x
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 09:36:26 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-71e8235f0b6so4790835b3a.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 06:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731422183; x=1732026983; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x886+rp6KvccbKprmkYzQc4c4qH5gn/nioBAMMQaMTs=;
 b=wzWhvMn1LLAq1OREGdZ9EQdfBp4QoNp7MQJKUkmpZKx4kBNBIDY7tWqWRHWVDD+BNS
 J3Ov6sdMbDmBjoAWzJV/7NtQjJKMW+qVZKAE3ib5qp8jvmOMZFN2YtaEv6ie1td6BvzJ
 bZhS+KovG0GCorjJYxDKky1Kx+yIduemlH/SOJ3WDQ9HkBmY9itdIusqJ81AHv+o9yza
 sVEsflj3hJoUAEMPbkRAQRMqAcNwilu4BxclwlE1fN6edTFlIzYeC+ROoa/vmsRXuyqU
 GXUcv3xoQHEi1itcACaWEJ5PBNSaT52NTRky09XVabiwBBf5/dhofTc5Rfk16uOPZlgm
 V/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731422183; x=1732026983;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x886+rp6KvccbKprmkYzQc4c4qH5gn/nioBAMMQaMTs=;
 b=oWWYnKUJiSlwlB1SBhPYPaBCqkA+bRxtjZmfd82OVe4uE8oBmHyLGOz+GxBAK6yq71
 /XatCt3Qk39ZGTNK/o+TH1xJKlzcw68rV9EqfVczPrdyV0xgfZYK5GtyXYR+J0RYC6gI
 kBaes/G6NM3aHBn35fj9rR4zFOB3SjZTtVc7+zUqbZsSrJpr4AAyozDjfQXeU3a67z6c
 HdH3TR9HakLMlM39MG6Zkg/K1Lo5diNTCOavzIQMVbDV/XYODtGIFT+pw76ZnlEMr4Uy
 Ox7fg08PnJELHivwQVvPYNkQ9a6WD/LseE7trTWLGOPol2GZzrL/1/hpsxmWZULd6gzJ
 BdmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs8GZP8x8g7WpOUfMRVJ1Mjg3x7sFIGJyE/MnOhvTy6zI74kXTYpglVkjiwrRdx44HDYGYmBrUfY5Q@nongnu.org
X-Gm-Message-State: AOJu0YwqRPs+oZYtugT4YA42qGHxUUHnMj470n8foRDB/U/Uqrs9h4Q8
 ZqqF7K2ktD3c6J/ZNKQNThT76f4AEdPhiieZxZ0MpfENsy9UVYS4EUNKuNYoKjM=
X-Google-Smtp-Source: AGHT+IH04zWtSZ+PJfc08phtlGQ6bN0Vzm7tyhRrf9a/bAxR+2erf8qiilFH/spbc5wPgJ0el0H/EQ==
X-Received: by 2002:a05:6a20:3d87:b0:1db:9367:d018 with SMTP id
 adf61e73a8af0-1dc229d6d4dmr24781109637.20.1731422183610; 
 Tue, 12 Nov 2024 06:36:23 -0800 (PST)
Received: from [192.168.52.227] (wsip-24-120-228-34.lv.lv.cox.net.
 [24.120.228.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7240799babesm11109821b3a.111.2024.11.12.06.36.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 06:36:23 -0800 (PST)
Message-ID: <09a587f5-4727-4d2e-9e80-ef158d86318a@linaro.org>
Date: Tue, 12 Nov 2024 06:36:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] target/mips: Convert Octeon LX instructions to
 decodetree
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20241111222936.59869-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241111222936.59869-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 11/11/24 14:29, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> Few old patches lingering on an old branch I'm trying to rebase...
> 
> Extract gen_lx() and call it via decodetree. Trivial IMHO.
> 
> Philippe Mathieu-Daudé (3):
>    target/mips: Extract gen_base_index_addr() helper
>    target/mips: Extract generic gen_lx() helper
>    target/mips: Convert Octeon LX instructions to decodetree
> 
>   target/mips/tcg/translate.h        |  2 +
>   target/mips/tcg/octeon.decode      |  8 +++
>   target/mips/tcg/octeon_translate.c | 12 +++++
>   target/mips/tcg/translate.c        | 78 +++++++++++-------------------
>   4 files changed, 51 insertions(+), 49 deletions(-)
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

