Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F68C83F26
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 21:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhDv7-00033f-C8; Wed, 30 Jul 2025 17:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDZd-0005WX-GA
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:38:53 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDZO-0007NA-Sg
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:38:53 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-75001b1bd76so148049b3a.2
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 13:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753907916; x=1754512716; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7gwIN55fs+OQWf7RqDB+KYKzCJLXeuv1KGiZze9XsPA=;
 b=nzj6Au69EkL0XykN656FlAxR7jxNXK0/piGTUx3sRSnvrA1qy77yLxskgDHR7yKq+B
 Y7uenjnPRp7lP49jJPvxxb9Vz6S79ehhl49o1HXrF9H3GPo2INZYax5jQBzKpoisqAGe
 z2+GyR6j1AOki6PwC6VPROVeY0iULIGz7tCaP2w1PA3N4F0DEXkeQdez5iY9/qRlPRnJ
 oV9Klj0/VNlolMI2OHvpqCNxrk/cqMRc3Vd1JOktqDkQaJmXo56BqJDC5a7nz7BV9Z1w
 Cxlu0yLccFW3dy3FncVkYUsgpitTqvNDMK5nbMi9qNKh/Unq9kM4zWqCBHNOVhF6vV9D
 /XDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753907916; x=1754512716;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7gwIN55fs+OQWf7RqDB+KYKzCJLXeuv1KGiZze9XsPA=;
 b=igl0y8WvArB2DHsXJhTtMd0WwOx/bSt2Q1FRVm4Vw7hptW1ryTXICyRyEJyndHjy0T
 3EKL8zbb7brpApZAT59MNzEX5PKYO3Qu2unOTdQr2CdcRR0rwdtoD1m+AbWQHgV08XfM
 GMrJwqV5wwusHDZeNcNhXKdJaxgGfbjD7rxfBrSCqNrSHtC42GePQAJFbkMIg8+rrbsR
 FDqP/lTtnWvJbyJIkpA1yN6MyIpKWQoG3fPQ9FF7eU7OO9O+Vn1A+HA4FUtGNjDV3fsm
 jKgWzny/rGWjmhrZIZ5iuwwSzET+jlc50F9Ye3y2Hy8/nVJGe+YYjki/WYtIoccT5nr3
 g5MA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmMX8je+OpomWo/AjW/cx1MG0ZQN8mcGnf/lDg+CC8A2LMPxOmdvtWWWyqFv2rEbcCLX5iw5RjU2Xu@nongnu.org
X-Gm-Message-State: AOJu0YyTn4et/jepvbXn662j6K+QGgZd9qVJB2otp3DA/agaqQzzRgWA
 cTHzCNR8DYL91gBT3w/M6cG5unNptrf7FXwwth4D70+y00ZQ978ErVXokBnnkMyTLGc=
X-Gm-Gg: ASbGncsWCJFVGw4a6b4ksnS2E6DPA+p9u/jbOIGMRqer2aJlcqLOy0aTLBqXG5xk9SU
 T0qw7V4+zyLhJGN0uIly+ofCzrKo624IpwxvklDnUBNJnUG8hfE0oBamtDlzhfMpxfTYQoIYdfU
 6Hp4k6qr5UW7pfNoDtnGmhI/+5zxJyGGcKkpj13VNc3HSOpud0aPKBtUMhPP3g8zU0/wsKDdi/t
 5xkr32oQVtArKsitrGUCKZY//2SAX/KNo8Rd97pYFT8rfNrl76onIwDTQjFSjIJoo/NzxLpRdte
 VkGUig2KoEFZVcOeCXq/UndMKaOhPypi6MuovvaDysnOrGEqjba15uB6P5Z/nBYIr0eMhgUX6ye
 cs5MPBQF1F2GrX2Mjy/MlvSwiAJviUP0ONOQ=
X-Google-Smtp-Source: AGHT+IEMIRxEq5fsMGWCUQ+bkm57ETVj4vddJ+zXtrDI689VoYoarH1ujGf3Kggnd8POvyEJ/dEsBw==
X-Received: by 2002:a05:6a21:339b:b0:23d:6889:f1f0 with SMTP id
 adf61e73a8af0-23dc0eae27amr7977418637.37.1753907916318; 
 Wed, 30 Jul 2025 13:38:36 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640872a4easm11418928b3a.24.2025.07.30.13.38.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 13:38:35 -0700 (PDT)
Message-ID: <a2fdb3bd-1a67-4238-bb62-3fb71f4b3f2c@linaro.org>
Date: Wed, 30 Jul 2025 13:38:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/82] target/arm: Implement FEAT_ATS1A
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-10-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

On 7/27/25 1:01 AM, Richard Henderson wrote:
> Implement FEAT_ATS1A and enable for -cpu max.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpregs.h           |  1 +
>   target/arm/cpu-features.h     |  5 ++++
>   target/arm/tcg/cpregs-at.c    | 44 +++++++++++++++++++++++++++++++++++
>   target/arm/tcg/cpu64.c        |  1 +
>   docs/system/arm/emulation.rst |  1 +
>   5 files changed, 52 insertions(+)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


