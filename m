Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91244C0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 14:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiaDn-0007XR-4h; Thu, 13 Feb 2025 09:29:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiaDl-0007XC-6X
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 09:29:41 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiaDj-00072d-Ln
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 09:29:40 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38f1e8efe82so1107587f8f.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 06:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739456978; x=1740061778; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xPko0Kx9/Lpp1CPXhiRDhStIaF170FzG7g2apzcDPLo=;
 b=jm91jhZ3JyBzrmqmo9blybS0IIn8NJot9vXOgrf95kfJo7aArjLzeuvmFtbPBlOhf0
 h3i1zT0qrli9y8RVfFHSKBnbShiclSZObfjb+iBSZaPZn+gbtov0lCsi2V4fiswkbrZ5
 PZLrJUVglQ5vAO1fA01A+ebNxChb0OA32NWCzz275fOOn60m2LSE9mHo75COdtIDwJC4
 xmnq+Q9OVtTHCiTBDoGE8Z2jDLVJRG8Btamas0SfgrtP3wc2DpGNo5FS3d3gkx6u4o6o
 Pbe1RCRpfdu1qIGk7JwVB+64HwvMvGEjD3Ctyo/39IiO+150TnSaUIjHRXp3YVcg/O5X
 adKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739456978; x=1740061778;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xPko0Kx9/Lpp1CPXhiRDhStIaF170FzG7g2apzcDPLo=;
 b=n+Ydmsi8+c5b+wNUAQ6jFBIYfPOj4/v4tmYU1Y5PeiDxpuIOirM2oEarOq8rhpzvK3
 oJoo3OAOuZptWizFOOpUfkJGYzRUOIh9cJZCzgAGjyHZyhcmPOChdPmmNshROdIDSftq
 EZdiLWX4vKM/tsiH1xe7/v5Gb0Qx/Q+87NeODdb8HJrWla+a+yp5OXh5Q1mVHalniO2B
 /NVOd/KShQRABr+PeEJ0/UIVkpEtEQF8i/6ZPQ9M1MISqfY7TDjdJ+sMH7W/GKX8mGEP
 xkyKh0X52vQxUoDl2gTeJDSMXyhGUtfS1QgMp1MMepKYZL5cRIgOyB3N++ECqzmozLAM
 yZ5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXV6BsDpA0rsY+Kvokb5T66B84h2D/E7Harxcvs+JU/2lv+ttfTvUU7xdf8oneutbKHbvoVzvGtZbz9@nongnu.org
X-Gm-Message-State: AOJu0YzdXOtoc9irSWm8oc5HVJ4c6O0W3/bNQKtkXSa3MPLkQQRP6KJZ
 zQm8u26SUHQLJGuyOHfxvkOyeyTof7sgVozKYxOzpzacAMnUiRo6Yh7Eo6+p8NU=
X-Gm-Gg: ASbGncvVkDHaqg72yGQpvjdiH+HLEd1BPp+TBhAvHrFu7iIrAR31WpeyTi2VrrZdLAG
 RAfyfSaAtDyOjJS4uiPZAaySHmYRCK2XyLIplDLs0cUa4SUHBkZlIB2sLWFN6ubKAo9kD3TM7ma
 58No4WKQKdHW96cqQ3wlIwgk1Q47Y5/gLukvAe8QXszLOo7tGsmqFuRatlMOV7Uq4WvjptB7a7b
 sZnsxpnRJw/ewnFccvCYPyHpSiOtQQyWv61PB5npmeNYRLk1mZy/t7TDbwpcXcpSBiekERYTHB2
 yGoZqBIzuWWG/gUxVt4QtBnhAlZyKZ0aIKC67bXDf7JtEBvgclSt4FLw6fG2XoS8qjPItW4VQw=
 =
X-Google-Smtp-Source: AGHT+IGvt67p2biKA2omS9Qp+8ecuJmsosqCOw5KmAzRfjNyA2ppqmT3RPSIcZddSSnzv0JSfU5K7A==
X-Received: by 2002:a5d:6c6a:0:b0:38c:5bc1:1f03 with SMTP id
 ffacd0b85a97d-38f244da1a1mr4041682f8f.7.1739456978136; 
 Thu, 13 Feb 2025 06:29:38 -0800 (PST)
Received: from [192.168.1.20] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439617dac7bsm19908325e9.8.2025.02.13.06.29.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 06:29:36 -0800 (PST)
Message-ID: <d0389ae9-5d3f-45dc-9206-5ed5db8f4c79@linaro.org>
Date: Thu, 13 Feb 2025 15:29:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] include/exec: Use uintptr_t in CPUTLBEntry
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250205040341.2056361-1-richard.henderson@linaro.org>
 <20250205040341.2056361-12-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250205040341.2056361-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 5/2/25 05:03, Richard Henderson wrote:
> Since we no longer support 64-bit guests on 32-bit hosts,
> we can use a 32-bit type on a 32-bit host.  This shrinks
> the size of the structure to 16 bytes on a 32-bit host.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/tlb-common.h  | 10 +++++-----
>   accel/tcg/cputlb.c         | 21 ++++-----------------
>   tcg/arm/tcg-target.c.inc   |  1 -
>   tcg/mips/tcg-target.c.inc  |  9 ++-------
>   tcg/ppc/tcg-target.c.inc   | 21 +++++----------------
>   tcg/riscv/tcg-target.c.inc |  1 -
>   6 files changed, 16 insertions(+), 47 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


