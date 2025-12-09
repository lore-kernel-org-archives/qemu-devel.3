Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D871D3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 12:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSx15-0005Vd-5Y; Tue, 09 Dec 2025 07:40:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSx13-0005VJ-Ru
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 07:40:29 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSx12-0001aW-9u
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 07:40:29 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47a8195e515so1912295e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 04:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765284027; x=1765888827; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IC8+DC4Ib0SrtPh4l1CU9Gq1c2LnqykzUE7mPJiFwAg=;
 b=ipJJveR2w7zAaRD4FZ7Un6kIiflah7yJzn3R0cqHglSUDbqmZ00KAFGh60TpI5qCtq
 tSow1zW9oPs/jVpLM2hCizfx0Hq6xG9Qx8jxL490RB3mkQ9HmfzkBWX91726ahmgmLdG
 gMVmpt9AeUn5kHMmSUH8lZ0XhZKxy8+bpg37cmfWfTspEhPwBrgC/kfOftfIwfzHIoaB
 3s6tIiBmyjk6ePK1vNHQ9//fWG0DSnPQi4fpuOa6rVN7DnDZcuKXXTdfV5s6Tvoy7v4H
 jAYypqozg9rwmqLO5pHxUflzkMWPiVzqFUUSEA4l7ozwB8mn86+NHFoiHSSjqBruZIGB
 P85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765284027; x=1765888827;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IC8+DC4Ib0SrtPh4l1CU9Gq1c2LnqykzUE7mPJiFwAg=;
 b=v1proOU0aUb/YC5nqFLz62RSLpeDG7Sd+2IcR4Juv/ko9MNyLmE2OuFXKejAGq4xTA
 h+QCmGQSbqFdBKQEGeAUHsBlLTrqyK+8NVZoAPRRA5qqydie9QRAxs4ODy8xFugWwXeV
 3lm/4C9wqM4m98jhAN3XwvOm6GacNW1sQ2THl+kLvvWX+KeirWxCt/623mbxLHIO28V0
 YQ+d1EbFqpZzT4tF5/DHyf8QrCiZoVyxGvPIJMv+hjcfIomVr0NRIybVkz3UxoymtO0R
 4cZKScoSP2lgGqxaHFjZnFvjVC9iBRbx5C1XrDMHleSBUXRs4iurpA8UnQQ9uI2YUxtk
 8ABg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMXy0MYJK3DFjcRxhm3c7bvLJqVND5A8xpAoIWlUagoxiZyLU89cTVfRpxJh0DbWFdbnQcjQLQr+0O@nongnu.org
X-Gm-Message-State: AOJu0YyvMgajWR9GfN+Cr67BwpAqPtvsO60DAHiaLu5jOh244zyQmOhy
 2hUEVs52MflSb4z/1XW+vbZol1xIVgkXbcI+hjwewYCO2Bv5XjY1jnu50IpA4wtrTlidawnK8Pb
 KHoMGaMc=
X-Gm-Gg: ASbGncvWAzL5yruBMMpiYXWuITUI6mkWGfkY0ZcRF31PPsp5Kett+pW03QK8dx8lHe3
 3pydGYLDobfqpWkc3czRvNJt+mYrf4rHTF0xReu7N/LN8oaqcMB3ktv8nJNvwpy0/UOwUmRbsY3
 cEMyJiMuLxKURVyinGV1XjA37zUuKprQGEmmJEt8G1T0NLJTzrPwMzfzIepZixXZW2U3X0aBdOy
 6TyGFjljwrzbmSNOgdxvIkHGKMDbBpZrOtpXLpx3EYbGJ3TMg10oOY5WO2gMlR0wDS34SKjdj1L
 wfN1NmSKmIDmmK2KRBx4JFeB37SVFXWoGmtZqddxEdWZXxk22snqMIZCHiK+ieSOP4ydofHLd7g
 dXtYnWOYVvOs1Fdtny14wYjhKjyRkDM0x4sNyeefDWQmoAUaP/EzuaAHVPL6dzXs005wsgbkKcG
 vwgC+itwg+5VHFC+xRwiP6X6fk0j/0UHR5Rc10v74k7OXrKWHEIkfvIw==
X-Google-Smtp-Source: AGHT+IECehiPEX67BgdGj/I+aSrrbdIXNZCBM3aZysQI2RXhZqeFamVEZkLOOHfmjN5wPEFO+KcJMQ==
X-Received: by 2002:a05:600c:3115:b0:477:63db:c718 with SMTP id
 5b1f17b1804b1-47939e2797cmr129519705e9.16.1765284026785; 
 Tue, 09 Dec 2025 04:40:26 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a7d68ab29sm38108185e9.9.2025.12.09.04.40.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 04:40:26 -0800 (PST)
Message-ID: <fa6395bd-8105-44a4-a2af-75d44f519051@linaro.org>
Date: Tue, 9 Dec 2025 13:40:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] target/arm: ensure PSCI register updates are flushed
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Christian Stussak <christian.stussak@imaginary.org>
References: <20251209092459.1058313-1-alex.bennee@linaro.org>
 <20251209092459.1058313-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251209092459.1058313-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 9/12/25 10:24, Alex Bennée wrote:
> When we handle a host call we report state back to the caller via
> registers. Set vcpu_dirty to indicate QEMU is currently the reference
> and hoist the flush_cpu_state() and make the call unconditional.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3228
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Tested-by: Christian Stussak <christian.stussak@imaginary.org>
> 
> ---
> v2
>    - Fixes->Resolves
> ---
>   target/arm/hvf/hvf.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)

Again:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


