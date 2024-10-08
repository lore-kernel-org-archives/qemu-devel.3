Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4216CEFC40
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 18:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syFDt-0005ZP-9d; Tue, 08 Oct 2024 14:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syFDq-0005YQ-3Z
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:46:14 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syFDo-0001hW-Jm
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:46:13 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-71e0c3e85c5so1598009b3a.2
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 11:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728413171; x=1729017971; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mwI5zpkgxFjBO+cBmgATiJElXkzRJflrPxxcWxKcpfQ=;
 b=g5B10fcrIRtxEHuIzgiJRRNYd8jMa0SeIX8ppp8wzJqksq87ntQATLvXfl/2BBkt8Q
 nA6ecrWIBiCMkP5DJdT388rVu3U3KachROGRXFUnMna4HF5ZOYrjrftXmUO4LcZMC8Qs
 rcjpRTtVYLCYieBAjzK6v6/9URtb6dB2hE2OVvOTu4uICEtY9wuBqjDIi5AeiB3b8VN8
 SYUkXiLHCZJfGrcpwnrCHsOIaM6DsegVvj2FbSqk8ylT5h0FaCy+HmSCXteZdis+ihui
 Yr0irh1SBfvgLI88yNmkytmc9aAtj6WBXdTbCzgBb1it8iddY3d+wyJql6aCs4yBNB0T
 W9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728413171; x=1729017971;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mwI5zpkgxFjBO+cBmgATiJElXkzRJflrPxxcWxKcpfQ=;
 b=nvoPTuLPzTq4ScBwASox1dUZuM/R/YyEOxxvIVDBjxUl3wXBJuyrBz6c1PYYTqaBD8
 sr910Za8CcnoQzxVtZR2QHR8qQvJ3FOU8sGtuusL2zbsmVL4om0jbkUFazHMeXgstBCr
 cCbQSOfuRSdomOHVfcLmNe1YXRO47THbNjycURy5kJ0oH6XIeCHpzZAJVwkoSP5Fc7Gc
 86ZjREVRZDQeaQD0t26E9/bgCAKDKjp3aFw0Fs4hnUECgMnewnct5HU7bPaisOVWQ7uk
 zbssW7enqB4OzFkdZw7mAw7+Qf7kXyNMLvbHa0vG20otp7a4pbZUFeVshjR58juz0pKy
 S/Rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+5Y9PE0KbKXdePNYqAecoSu5agnltyaswYQ3Iyr24j2zT68gW6iW3Uh1+cjJkNDLczEUMeUwGQ+t2@nongnu.org
X-Gm-Message-State: AOJu0YxWjpov68nKYRXAZbARE/vimI31N1lZMlnfoP0AIdtZ3RGvhxp7
 2v1OsXw06x0oNaSdF0Z2OZp/p0p02cGVwMbF10PbU76l2t4HB79sIQS+XZdC9J2uRUajL9DpYwj
 +
X-Google-Smtp-Source: AGHT+IHeUGe97qikVGMHXYmZxDw4YRCNGI+IP3miYZoBo3doP6bg+0meBTDJSgEUmrEkFKGcbyVpNg==
X-Received: by 2002:a05:6a00:1742:b0:71e:19d0:2988 with SMTP id
 d2e1a72fcca58-71e19d02afcmr2292882b3a.14.1728413170878; 
 Tue, 08 Oct 2024 11:46:10 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d7d02asm6428912b3a.197.2024.10.08.11.46.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2024 11:46:10 -0700 (PDT)
Message-ID: <001b332a-4271-484b-872b-056cde3e9655@linaro.org>
Date: Tue, 8 Oct 2024 11:46:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] block/ssh.c: Don't double-check that characters
 are hex digits
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>
References: <20241008164708.2966400-1-peter.maydell@linaro.org>
 <20241008164708.2966400-3-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241008164708.2966400-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 10/8/24 09:47, Peter Maydell wrote:
> In compare_fingerprint() we effectively check whether the characters
> in the fingerprint are valid hex digits twice: first we do so with
> qemu_isxdigit(), but then the hex2decimal() function also has a code
> path where it effectively detects an invalid digit and returns -1.
> This causes Coverity to complain because it thinks that we might use
> that -1 value in an expression where it would be an integer overflow.
> 
> Avoid the double-check of hex digit validity by testing the return
> values from hex2decimal() rather than doing separate calls to
> qemu_isxdigit().
> 
> Since this means we now use the illegal-character return value
> from hex2decimal(), rewrite it from "-1" to "UINT_MAX", which
> has the same effect since the return type is "unsigned" but
> looks less confusing at the callsites when we detect it with
> "c0 > 0xf".
> 
> Resolves: Coverity CID 1547813
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> Reviewed-by: Kevin Wolf<kwolf@redhat.com>
> ---
> v1->v2: make hex2decimal() return UINT_MAX, not -1
> ---
>   block/ssh.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

