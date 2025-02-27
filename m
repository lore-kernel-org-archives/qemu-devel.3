Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0AE3C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 16:37:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tngrg-00065p-GF; Thu, 27 Feb 2025 11:36:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tngrT-00062w-Tt
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 11:35:53 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tngrP-0005rB-8i
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 11:35:47 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2234e5347e2so24027565ad.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 08:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740674139; x=1741278939; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1bcl3PLBOyvlDjjxGk9BtXCRaSICo2z9tXjne/+S/dQ=;
 b=PPEuLXbf8mKPW2urtwxXrMPZZ0rvpEDEpKQiE5+YQw3yMS0Wg5TYqACUpUkaAOo81u
 NyB7UxBAMy7hBEuospFYQHMcxZk4lp3vy3rwdI2DTxhh51vUO6sJTAl22JwvV6NlhNVx
 OXPRK1RhKuqAR32/qTMqEinf6LthBYICvQh4yBGmDjTUOfVVwMXJNt8/kNqZ4fF25YTq
 n1TSVjxmGG2+/xEfv0qj1CSC1+7CkLxlHn4gfnXK+r77mhGoZe5cZcqfro3yjRigBuPe
 KMD5Au7tTQqFizxUuQ9Py8N9V+es8HKqkUcrW8nQHV6hjVMegnB8s5msYbc2pkviNTn/
 c6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740674139; x=1741278939;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1bcl3PLBOyvlDjjxGk9BtXCRaSICo2z9tXjne/+S/dQ=;
 b=s+wAfBmJUfwMyUzPh4652pm02BbguNMhIZ2UOe7Pv1g634owgUNNpy9yNXatlyUbsN
 bFloeFF7ReuoChApaYGKPpXF2zQPmMkY61wPy0aRrDEhoN4ZbllQ5jciN853xKsUz4e4
 rHg0sSFLRqKtBJdx+g777bAvuF5vpDsgC9BqAnK5VL2v6ZBJshQjmH1ogRrtdWfRWG6B
 aTaS7s7r06WvEAT1i9KU2kTYaI/3WSkDrAcg89PzKl/gFxfqoqFMfvpUoBN964bWOKIR
 JPu+OWqhtNG/00jbwa/c/CGHln9sLBpLExCwD1t1xDv9UMK1Bmi7oPUNiSJcpJrsnF2I
 L/fQ==
X-Gm-Message-State: AOJu0Yx8S3r0a4+lEDsTgYUgqJVA8s2DYiN77ZZj7plk0vsxf1M9ACzS
 GCS/CnqhKcFyc+w6YEDoACh9MVbvgAnFTqMA4jgPcnQ2DIX9OLzJXylz6/g90cbdcO+vq46wGg0
 7
X-Gm-Gg: ASbGncuGguAH8o37+vR/I1qDNSljNGl7YwJnFaLwTq8sBkwngpEfrHP/kAo5LvFFR3G
 ACKQ2OPVzI/UL10e5OqWRigOS7eC4QM2RGYHXoewz5tOY4TKWaLCMJv2Hrcx5pKl+eZF7QNh+QT
 h4m9lvk5oPLjD8rmXf3g8mpmTWBN/E3MnW4BVNmx8uukjxZNMOIzYMpj/9OmEaE/k43RRbe4/wD
 UeOP1tZ9I4d3g8wqY2FgZBoTZnoalN5H0HkjojzT3kQ7KHGhyfchF/OmBUJzYBaHbPzsCwf7XxR
 J/6nLPtbbnPrm+KSReE4Cq6a9X42KgIbUqHCVtH1CIpuvhIMfnV8Dw68YVQDDdEFto35zQyv5dV
 mv08szGA=
X-Google-Smtp-Source: AGHT+IGloj0BOX/CIi/38OlytRqFtvnUSUghF6Ebm1l6a2CwlMJPOR/IMglDN/JiyiuptIPt09SWAw==
X-Received: by 2002:a17:902:f791:b0:223:2b15:31d8 with SMTP id
 d9443c01a7336-2232b153f81mr90646195ad.27.1740674139495; 
 Thu, 27 Feb 2025 08:35:39 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223504c5a3esm16950435ad.132.2025.02.27.08.35.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 08:35:39 -0800 (PST)
Message-ID: <1c3acde9-9540-4a23-97dd-dc28dcd77f5f@linaro.org>
Date: Thu, 27 Feb 2025 08:35:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tcg: Suppress compiler false-positive warning on
 sha1.c
To: qemu-devel@nongnu.org
References: <20250227141343.1675415-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250227141343.1675415-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 2/27/25 06:13, Peter Maydell wrote:
> GCC versions at least 12 through 15 incorrectly report a warning
> about code in sha1.c:
> 
> tests/tcg/multiarch/sha1.c:161:13: warning: ‘SHA1Transform’ reading 64 bytes from a region of size 0 [-Wstringop-overread]
>    161 |             SHA1Transform(context->state, &data[i]);
>        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This is a piece of stock library code for doing SHA1 which we've
> simply copied, rather than writing ourselves. The bug has been
> reported to upstream GCC (about a different library's use of this
> code):
>   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=106709
> 
> For our test case, since this isn't our original code and there isn't
> actually a bug in it, suppress the incorrect warning rather than
> trying to modify the code to work around the compiler issue.
> 
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/2328
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   tests/tcg/aarch64/Makefile.target   | 3 ++-
>   tests/tcg/arm/Makefile.target       | 3 ++-
>   tests/tcg/multiarch/Makefile.target | 8 ++++++++
>   3 files changed, 12 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

