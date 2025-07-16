Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA439C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 16:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc5B6-0004rX-UM; Wed, 16 Jul 2025 12:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uc5B5-0004no-A5
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 12:40:19 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uc5B2-0008Ml-E3
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 12:40:18 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-60d666804ebso579491eaf.1
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 09:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752684014; x=1753288814; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hWud1wwOv0+fRiIm88rHy1JLosMUoUEjaSs+Zgs4Zb0=;
 b=WSbG0AafE0mDkNuOixledCVDE7SGsxNTXPOOF0PB8z4THqU7qCvOOPYrvalJrWecDx
 iztFyvje6alLT90cfTK7VVnIYTo5M8gIFAP5bkxwc9AcCr4CvvA+BH7yeeRf7vuT078i
 mhLX9Zan+hCZxtO8KDkkGGdB/YgtfyML2fXIUHYgAKkr0HFZfhTlFylE4honZphZfGnQ
 /IfvtTEWmF1reTO/xQbtkE7Z44nqygfS+ilZ8VMg0lYs79OgOfaF4TdrQRARxwSTrq3+
 lWQItUAsSd215OcDFJHaw6XoY9XBiPpc2IU+kGjqkaXWKcrv9xYlq0B6tweolu+BwyIJ
 weVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752684014; x=1753288814;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hWud1wwOv0+fRiIm88rHy1JLosMUoUEjaSs+Zgs4Zb0=;
 b=STDKgH6Bw8j/cti318D1zXjov2nQaaSfd5+kGygD6LWpS57AqSvqUZt6C6Rtg0B6OR
 ni6Ge7/nHydBAzQz+hTw5OkbcwNWQZKC/qndKMvc7yWsLIPESn7jiP+6USL5PML2c+mL
 9oDnqLahofNqf79jUm52+HRWbgozyL/WVEI0NEbKPBcA6xXY/At+BGjjFCaL9vOu5Dc3
 8b+KtDF/MGfAHLf+0ndGqJjvJHDj1ZBFwWx0KgFORgTLM38+3P+t7YBdRIFZCNtZCvRt
 mvUwnDlTB0nZsiyj95v7uO122NC0fuMTnlLGnPfZk9T3ajDeREbejGksN6vWg0sDwLpt
 H9Sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdtIsW5Vb95JxzUlqq3qatpE0RZgAQaUTd2dv46pUVW7kmbKyrfpjqrOj2i+EMuEfQkK16zPilH/EN@nongnu.org
X-Gm-Message-State: AOJu0Yy+EGoGiRIehgxealIY1pwSkpEl/KpbBA+NR0CKTJe8HZug/lsA
 OlsTKooIyv+wiCJlpx2+PM8aORiCojSM/fdetae0xcjqVZnY9z0gGEth+gQnRJT/sVk=
X-Gm-Gg: ASbGncs20y6gSCcCLAROs09IKXKi84WhPMauUw6W60o1ax13StytuBACvhCTQc5uU0T
 AeIusuBez54a2M9Tf05NCsHy93PIXdOrCn7YFFrnT7U0HejO+EiIGY3KHLHEo8PvpdKESMBKMaR
 2TT43A2l5bi7Bv+WzggAgV6lrlCyyzoZ9R14HzgD7l3lxZRR2trP7DzGy0bmS+uL7SECGhG3UM4
 WCLaWPiqjNDO9xrOGAL1GXNxmVwxhWNp2jOrYQto+XYIviYj/CBwTZu6oEK9B0J5x71xMVootP1
 Xo+GPNvULWdwvmCNY5msUZlOYzfyrVTbxFfqupg/WGU87LPb8uxw1X78IJzboZ400eKTC3zk0/0
 INonpjtdHfki8HrvM5LrRBukOo+O43Dj4CJH7f5qN2Gmqr3c8P2WIhVtYJpsEEkQ63MqxNSts7x
 Oz
X-Google-Smtp-Source: AGHT+IF5QUK+5n68tnc0gJq45fW4CCjVfDZ6IiCOOjA7ElipNrpe9TbdUsltvHstkGmfVGcJO544JA==
X-Received: by 2002:a4a:ee19:0:b0:611:758f:1fa4 with SMTP id
 006d021491bc7-615ac9288e2mr159432eaf.0.1752684014425; 
 Wed, 16 Jul 2025 09:40:14 -0700 (PDT)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-615a4e9f0b1sm345917eaf.25.2025.07.16.09.40.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jul 2025 09:40:14 -0700 (PDT)
Message-ID: <52c5ed4a-0225-4360-b1c8-e3866041c4b3@linaro.org>
Date: Wed, 16 Jul 2025 10:40:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] aarch64: update test images with new trusted firmware
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, jean-philippe@linaro.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>, gustavo.romero@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250715212335.2215509-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250715212335.2215509-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc32.google.com
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

On 7/15/25 15:23, Pierrick Bouvier wrote:
> The FEAT_MEC series [1] introduces FEAT_TCR2 and FEAT_SCTLR2.
> TF-A needs to be aware of that change to allow accesses to those registers, and
> thus must be patched [2] to enable this for QEMU platforms.
> 
> Concerned test images need to be updated to allow them to boot.
> 
> [1] https://lore.kernel.org/qemu-devel/20250714155836.1514748-1-richard.henderson@linaro.org/
> [2] https://git.codelinaro.org/linaro/dcap/tf-a/trusted-firmware-a/-/commit/c8836cec14213bf92dae79d353bc345254a0a31e
> 
> Note: [2] will be upstreamed in TF-A once associated series on QEMU side is
> merged.
> 
> Pierrick Bouvier (2):
>    tests/functional/test_aarch64_device_passthrough: update image
>    tests/functional/test_aarch64_rme: update image
> 
>   tests/functional/test_aarch64_device_passthrough.py | 9 +++++----
>   tests/functional/test_aarch64_rme_sbsaref.py        | 9 +++++----
>   tests/functional/test_aarch64_rme_virt.py           | 9 +++++----
>   3 files changed, 15 insertions(+), 12 deletions(-)
> 

Thanks.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Richard Henderson <richard.henderson@linaro.org>

and queued with FEAT_MEC.  I'll re-post at some point closer to opening of the 10.2 tree.


r~

