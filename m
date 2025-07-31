Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7115CC87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 22:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhbf8-00070Z-F6; Thu, 31 Jul 2025 18:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhbVB-0004tA-Fo
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 18:11:53 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhbV8-00061H-Qj
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 18:11:53 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-76bd9d723bfso477929b3a.1
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 15:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753999909; x=1754604709; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s7p+FwvyvHIZCZ78ukG2Bjd7lRncEsx2cxfkc2H1Shg=;
 b=H9rDbT8hBDb5aOCLUYGzcWxL/99osECelzmzii2gDXNnQjb4NJF5Zj24g6eFYf1sJD
 oTVXRiga02icDolwgAWMuefbqBiF7dOETVC7sm9kBnyH0JSildCylR6ZMOTKxt6vxrZt
 asDJn4s410sB7E2pN8InNAw7a6aND0p7NsEFSJY0q1zOTZv9t5Snca1FNlcwoWJxpHw+
 AJyJaEh/3vw/CcVTga37T6l1V1FMdEoykOAwHiwGFgJ8ExlVqDxP/R62Hs7AP07hZb0I
 aeoId69rz3ARr0q+XnorBo+0BHQ4HIQauiZB1x1mlu2a6lvO4heJ+tr/7q7uE7uCVMWz
 j0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753999909; x=1754604709;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s7p+FwvyvHIZCZ78ukG2Bjd7lRncEsx2cxfkc2H1Shg=;
 b=IV2hXZMbM3+jJJHuGAfb7ppCvD/dPTmDilZ6RsgyelFsbT3bLwzdv/aOQ9cK1BpCHv
 DAKmGKhYzRSTDYHYhO6CBdwhOnC5z3z7GHAYxrXtzkjk7ysfx1tlpVz0XnXFrauhKcIh
 w2DETF9ECePj2z0wa6uQTbJTenbcAnXlB5JG0IPynmGQdwTDBuFWR0F79BkIOGnuhLTG
 kFoeUEhpek63b73LnKZlRd3RNcd2a7dNqsUYTHtG9JYXgbWGdTRBgGS9awCaxkBM58X8
 is4hOtvdGK9HTb2luVFHYfCAeAroSSPGvnQXihpgVbSCgRFNy8TCuZqvxNzYHo02WWFL
 UHqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQnPcMptr/VRkIrQyZb43+XCITFNvhR814M8YegWUeOIXSdXTNOXMDw297Ts+GpZIgRa8ZNkBkEnzc@nongnu.org
X-Gm-Message-State: AOJu0YwX1pYtnj8+ElWCbFQMJgoli+XFyLhn5osRD3wC1FFOmtvzI+om
 S4GAYjG1nstCKYpayalzvexT/ka8LdpazpEuMt6khTmDOJcPkbyNbc3+xfhitK9tUHM=
X-Gm-Gg: ASbGnctNndcVlrNsAP5m0Hz+Td+hCXEOeh9Sridng2/JxQ/WLCbbihVE1dT1UgwTzh9
 IKvQKRtihszp84uouY8mKfSHiY72uLb0l2DpK5kjLTfAWP4wCPa5drckNJ6G42G5u54hqICTEb5
 +H6gzUzQo1E6L8bHWM6/CN5D0+9uZShFymi0X4RjJ1klw57namkpuB9lZGErgiQH3p6239EZBz/
 A34bJgkLoqjfqwaupeJJgpBiygNFQNfSU1/F/5Ei4OyvzJTwKclkav8kA4P+WTRivNLwbtGjfxo
 un2/e9zWXru5qX69OPF5KrRzlLTlbpX1Hga2ynz6+sjmTZYJj3ty7r7tOWN+8Y7SoV0vv0ixZqq
 qFbd5RqXZiky4EKUZBoczkcd+sMLnZ5GWlcIU+RjWI/snTg==
X-Google-Smtp-Source: AGHT+IHfocy4RzaacvYQmjB11yckcZGUFHrZjcJwVyHT+45CNuiQT4AjScYamzVXgVJkhSoxuIYwMA==
X-Received: by 2002:a17:903:22c6:b0:23f:d8e4:ded2 with SMTP id
 d9443c01a7336-2422a6d8f27mr4627865ad.53.1753999909073; 
 Thu, 31 Jul 2025 15:11:49 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1ef48fbsm26645975ad.36.2025.07.31.15.11.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 15:11:48 -0700 (PDT)
Message-ID: <545f1049-bf37-4a88-97c3-1f732ac66263@linaro.org>
Date: Thu, 31 Jul 2025 15:11:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 81/82] tests/tcg/aarch64: Add gcspushm
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-82-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-82-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> Validate successful and trapped executions of GCSPUSHM, GCSPOPM.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tests/tcg/aarch64/gcspushm.c      | 77 +++++++++++++++++++++++++++++++
>   tests/tcg/aarch64/Makefile.target |  2 +-
>   2 files changed, 78 insertions(+), 1 deletion(-)
>   create mode 100644 tests/tcg/aarch64/gcspushm.c   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


