Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A062C83F26
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 20:56:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhDqY-0006zE-KS; Wed, 30 Jul 2025 16:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDhy-0005tM-IE
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:47:33 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDhw-00011D-Qn
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:47:30 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-748e378ba4fso346062b3a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 13:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753908447; x=1754513247; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+qbVMC101eKAUl01o/3X7l1jA6vVmTrenKiZtyWgrFs=;
 b=nMYV6VgEXiiV4ep5kd2ryvUVOMdVUvanYLk72H1opnN349BrOhdsgMkjfh+dVbT2cE
 oQF5LmgFOGucs98ztDox4OQ3dLQbUsW9wKCWaB4dEmCCVRJkxrqo7uYCnXmdCojzfGMU
 iN9E38bAlf2mBU1dXgkW3BFFgdjjMdUmRNHZLKty6FD5vVGCUr4IrpbIXRllIXJTF6mM
 XtOfuhG6QczLaUOiV75m2LYHi5m8aMXXZK11Y5T11qgQUM+nURqS9ewqggC791hSS4nM
 GLDjVsz8geoFmqP/kAEF+s6L4WhwrGAYrscZPWNMZfsMNNXVvzgg52/zvSn52T4IRIvm
 eEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753908447; x=1754513247;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+qbVMC101eKAUl01o/3X7l1jA6vVmTrenKiZtyWgrFs=;
 b=kbJAK0GTPTIvhI9lQsetJszAoxYQ3JJJkVXvjn+GhCdHEdmuP3ngS2JUFobvwPcYM/
 aRJXcHtlsKmZaDxGt2cYye5+5n9Krt+OkFgaasss9IX0aB8xo0wfTEHOI8Pujk+8axpm
 TmTTwjkrKBa9KCotpM1h7e2WjyWRiMiUVlHcpn6InwVFDTpCW188Ndit57Qgs1HwyXoC
 dJT/84dNX5YCdkK9swfSF1IeBfpAYdlbkoy3cp4AJRuqAWxJrGZ+X+YM7LLeSjWLS23J
 XkM+mFTtKDSu7cGHyyhMq/kfLXz5IxkDRuq/TuB5AjTK013MOoRrQ3T9mIzlpkc4Rc+a
 GuVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOQyxbHL0r2UxemFh2iE2yCU2N3Hsms/NP0sD5RZIFe+ou0ajFsj/EXoBfMyEskmo/IcNV2abKh2me@nongnu.org
X-Gm-Message-State: AOJu0Yzm6lSK4VDze1h+bJnMfIZXYy1/gcy/TbOCfIkGz81FBn5nxwmn
 7xW2vOkxgn/Z0kpnxMKWPXUvUBJnu7MIOBTst8i216Wortw6evO3tX6HsXhLX13FToxDexa81xJ
 AqxPg
X-Gm-Gg: ASbGncu2Q0G398P82C9X/9t4flKZLY03rY+D57jgpM0koDoNxxkz4URth0j6VQKZ/88
 Z/eRRLUzzc1D+YbBYHsms1SVfx7u/EJU62HKEL3YFn2+IXOCKeFFyC38IYkJkM6cxWEecsfc3p+
 +71jYHm7qwFW4bn7qJNl9ZuXUhOOJMRz1NFcXO2AJXGt9qMfi1FH3FvRZ9vdm0JkRibIX9ORkhw
 RVSGzzB3j+NXTRY3b4aLxVHEy+SsSfoJgc8e10sTMyD+ljc7+bsM/CjgLk3YQi+iZ2UcllCcFN9
 +1uHc59FAcJIGyxmY9oZmuiTMXyPxWrO1XOXv4PbisR6KwfphIls2vMXAAoYDpDuzvzSb8+8VCR
 4Pst5KOeSmU8GusNioR5Wk89RubMOV0ga9yc=
X-Google-Smtp-Source: AGHT+IEqepSlcPq4dCcjCzPj0ChOxrK+3Ojg7ewQJoGyqRGqeUsfiZ4pfx0zDlvVggNA6blaY41l2g==
X-Received: by 2002:a05:6a20:3d1a:b0:22b:f4e5:d0ee with SMTP id
 adf61e73a8af0-23dc0d90c35mr7244529637.14.1753908447387; 
 Wed, 30 Jul 2025 13:47:27 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3f7f58bec0sm10028547a12.17.2025.07.30.13.47.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 13:47:26 -0700 (PDT)
Message-ID: <e26344cc-30fd-461b-bad5-dcacb2db5f35@linaro.org>
Date: Wed, 30 Jul 2025 13:47:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/82] target/arm: Expand CPUARMState.exception.syndrome
 to 64 bits
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-20-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

On 7/27/25 1:01 AM, Richard Henderson wrote:
> This will be used for storing the ISS2 portion of the
> ESR_ELx registers in aarch64 state.  Re-order the fsr
> member to eliminate two structure holes.
> 
> Drop the comment about "if we implement EL2" since we
> have already done so.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.h    | 7 ++-----
>   target/arm/helper.c | 2 +-
>   2 files changed, 3 insertions(+), 6 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


