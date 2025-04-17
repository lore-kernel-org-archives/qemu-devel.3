Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DDE7C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 07:16:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5JTc-00043F-VZ; Thu, 17 Apr 2025 03:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5JTa-00042m-2V
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 03:15:58 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5JTX-0007PA-R6
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 03:15:57 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43edecbfb46so2829595e9.0
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 00:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744874153; x=1745478953; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5JJBdii6dcHKAjFI+mgghLcmHyOIvbYQMW9QkENWibE=;
 b=q+68aWLL+j1awGqUP0YVv55fv8BU3V0y9bcxRjLye6nQHWMiPT2gJz0GUPvRV8vyQB
 aY6uwkjFzbhatyMAfH5W8xH2poSr6e9wirdTKsdvRscppCY7SaVdA3oZ2KXQZPmbiDpd
 japqqSCsWJIfJvyjbFbZU2Wd76s8F+CKpP4X6dwj61rS73g+QCM5FXlNI9V7DhfTUb21
 EOzw9KlZ+/J/vMpWGQGAeJpAW1bLHir1+PSSoFttkvqhyLmrEcoeyDWzjLvtZCe8evaI
 SHkHgZkSXLq3P6jEza9UsFMM46dQQjwEoBM0NbE8FG0gTgeKsk9+O4lljXfgyviIW5UZ
 azYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744874153; x=1745478953;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5JJBdii6dcHKAjFI+mgghLcmHyOIvbYQMW9QkENWibE=;
 b=h9EwtyQHlQ1LmbnMipkt1laJsPdoiqY+gVyAOHdypnHDH+lV0T1qeu1KuMtkihPInV
 znL4rYhMkaMUS7q1hcZeRHDzoFhcmpP0AvIiBrnDGriNSKub4YrDAVIZudefWzP0pqYm
 keg8oywYA4eqyS8pFih1YcGYPJ9UP+SKHeVsX9MTkjxAKCfaMIchcuT6kMxVc1DuLeNs
 uaLPSsb3iCtn1zJgd5gn5Db6LwepFtLkMSDK3oVn+PJBsjZhrNntY9VQSNR1SNexY3iQ
 AK1hirZgZQpp6bc2P6WAUhcVkLeQA09tjL/dhPISprwNCz6LMnKN9tFipnRJGYlxmQPF
 prYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqJ2ecanCKMkt17EPhMV3GAaLcB9o+1ZJIN7Hhddve/KdtnaHEGG+RjxEGs8MWL6MtuJ9FTIV+crw0@nongnu.org
X-Gm-Message-State: AOJu0Yxojmq8NCp6sseBL2xfpBL4D23hiaAaslzn/dVk/MWj3TM4z35m
 /wAWcjPLJGHnvK5njZcBwCc5/b0pTQESRyvIodDI+Zx/WjNVGbcX5bN6mF6P+X4=
X-Gm-Gg: ASbGncvtyaNkZkxHMqzEWu6sTwSXcxiGJNtW5P8qMnwFsSyzb7BmqBxaH6cmRu4h8L7
 hVwUI89MMlopBhacrowNAGoRF0hTDi6DkB/5R+4UJOY18E9mzxCYRcgcXFVsfWERNRejkfEjyxm
 cVzkIpl8dI3NdqxdezuEIoxZ6b4JC3BlZwFp5MsgYPc206b5j41ekXJigdYgHcZ09+/jazQd7ta
 Q6sQNjWy/+MmsZRsbFMJ/5S4HwENpJndCqmBdwjj8fT2TICWtxRXm7t7OwcHSJmlJy5PJj5yALC
 NKQpgPsuX+RA8KMi8SY5DM0FLizx3aLQsmLCDCMGPy1QKbezArxxLhUDcZEwMr87SRrV6Rob6iq
 2tdJdfAYE
X-Google-Smtp-Source: AGHT+IFzKngjPdJkmE3UajkY57UdHo9/qHorCQm2iqlFZ+nAjUgfpRqxXi1T9T4HBNFph23XMNCyng==
X-Received: by 2002:a05:600c:1e0d:b0:43d:4e9:27ff with SMTP id
 5b1f17b1804b1-4405d5fcd26mr47709905e9.7.1744874153073; 
 Thu, 17 Apr 2025 00:15:53 -0700 (PDT)
Received: from [192.168.69.176] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4405b4f3227sm42480605e9.20.2025.04.17.00.15.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 00:15:52 -0700 (PDT)
Message-ID: <19ffd753-4851-44f0-8c4f-d2e9c416405f@linaro.org>
Date: Thu, 17 Apr 2025 09:15:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Hexagon (target/hexagon) Remove gen_tcg_func_table.py
To: Taylor Simpson <ltaylorsimpson@gmail.com>, qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, quic_mathbern@quicinc.com,
 sidneym@quicinc.com, quic_mliebel@quicinc.com, richard.henderson@linaro.org,
 ale@rev.ng, anjo@rev.ng
References: <20250416150343.73444-1-ltaylorsimpson@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250416150343.73444-1-ltaylorsimpson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 16/4/25 17:03, Taylor Simpson wrote:
> This can easily be done in C with opcodes_def_generated.h.inc
> 
> Note that gen_tcg_func_table.py has some logic to skip instructions.
> However, there aren't any instructions currently in the code that would
> be skipped by this logic.  So, it is safe to base the table on the
> complete opcodes table.
> 
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---
>   target/hexagon/genptr.c              |  6 ++-
>   target/hexagon/README                |  1 -
>   target/hexagon/gen_tcg_func_table.py | 66 ----------------------------
>   target/hexagon/meson.build           | 10 -----
>   4 files changed, 5 insertions(+), 78 deletions(-)
>   delete mode 100755 target/hexagon/gen_tcg_func_table.py

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


