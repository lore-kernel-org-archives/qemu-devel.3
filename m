Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAFC9C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 22:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdcpM-00059o-53; Thu, 30 Jan 2025 17:16:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdcp6-0004ws-IV
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 17:15:44 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdcp3-0007kF-Vf
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 17:15:44 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso10297685e9.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 14:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738275340; x=1738880140; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8OSVaKQ3JvAJ3blBdcWlqqwr3YtG9QWmvfHJA5UHTYE=;
 b=F9rwKZ0UHyYEObG9xRErJxlK1uSTBp/+CtZVTD690rC6OTKBuUGJduwFs1DX2i7R5t
 uWk7hv9rnLGYdMjNhPEQkHhmTz8Jm9hfSJMVQsEx8UXih5ebbxu9PDSHIT5lGTu1SSYi
 R3SKG9R9tvjJQ3+IBriTSTYGZjB/ecspi+CqWMqv1miGkcr0qfc2ILYtK1VZDFo71fNB
 TQ4CxwI1BiARpk8Qbf/IVh0dIDu/aIw2/2K7Moe9/NpPX0I+iFFhxy3j4/+GMDwcHBSg
 eMzxgEsQ5jYW419G1Atd2YcJDLNEGBH2XBt3ljJlYhzY3BFl2Wjk7tIoVcHBSXhGe6XF
 tdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738275340; x=1738880140;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8OSVaKQ3JvAJ3blBdcWlqqwr3YtG9QWmvfHJA5UHTYE=;
 b=EXJOYk/9mMcRVCA6B/4xFuRjXFqyBzMjyvDnv0Nj7vwvnuyOjEVT27RfDdKJ7CFR+e
 OjgHhORBY/UXPOP9CXLEaKGUVW9MYfciCO2y2TIBLwOqQ7Xh6ozG23giSWnFb4bXUcz+
 wsYC4+hKKC/CggVBYZz10U9DP1fQXDh/+Ilht7OWjl3hNVu3HlyYFlU3GFTmfZbjugO4
 MWzpbW77+mKjRbaeSh/JmS32Xtqc7Di4UPCuE/jCsdhTCCw9eQoRIoLpAN8fYWX6lQq5
 Pul+rnCOOl077u1hLrwz342tUjJpUSL2Og+EEjLUrx0+cfF+FDdbalxfIcN0WxzPtB9E
 vU1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmZIDyRmTywYnVxXFwa3Mvku9iwm7BKPw5TiZCnRoylUGVMVdsramsaPzIMbpiIutRqLdC9dUEWe1Y@nongnu.org
X-Gm-Message-State: AOJu0YyQ/pTLWe5JrVMnZq3Wjsi0q11DowBgO5s/OJZDpWtdqCJ0aQIz
 d+z4dqVxTUs3mZvcJmWQxaMEWJ4vJbRYklZgno0695kJ1Lf7UA2zJ7FIA6CYeooFTEzMw0dQNH9
 +1DE=
X-Gm-Gg: ASbGnctkF86ioibyzaTPyZyjdYSMPJem/eVy8WbUUtzn0NtKsuLK6lrsuW2pPUPUPTk
 +R05gxGt5TC6UOZAhlw1TQCLG4Xf3n1yNNVo/Wfx8F/DKHIuFp5mZv8R7nheLaMBZkEPWob8Cl8
 oeiKgu8U/kWXMwKuZIIv540+R/mldRubZY3W+VI8l3dt59NRzLCNKJuMdHYFfVL7/Dr9XFoWGNU
 vVld4dcGjLq7arHUYKSmGiKdBwTPF+p9cZQ0cQ5PW9Wx9fuhRhU/LTwlf/re74mkaHhRqcZk0mq
 xWw7CM6wpDj+QNtIL2zK+O5KzcL0eaeNcXWAUwslqZnbXt5EX9bMHyXdD4I=
X-Google-Smtp-Source: AGHT+IG634+pNUjZ28ShBFHdpMNzzKYo9imCgpPhVElTsIN4tazacyQL52T+VxDnJukn3/xnRK+puA==
X-Received: by 2002:a05:600c:1f94:b0:434:9499:9e87 with SMTP id
 5b1f17b1804b1-438dc41d8a3mr70794545e9.25.1738275340267; 
 Thu, 30 Jan 2025 14:15:40 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c102bdbsm3036290f8f.28.2025.01.30.14.15.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2025 14:15:39 -0800 (PST)
Message-ID: <d62e2e08-4b17-43b5-9ca8-ee3e2755943d@linaro.org>
Date: Thu, 30 Jan 2025 23:15:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] hw/sd: Remove unused SDState::enable
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
References: <20250128104519.3981448-1-peter.maydell@linaro.org>
 <20250128104519.3981448-12-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250128104519.3981448-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 28/1/25 11:45, Peter Maydell wrote:
> Now that sd_enable() has been removed, SD::enable is set to true in
> sd_instance_init() and then never changed. So we can remove it.
> 
> Note that the VMSTATE_UNUSED() size argument should be '1', not
> 'sizeof(bool)', as noted in the CAUTION comment in vmstate.h.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/sd/sd.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


