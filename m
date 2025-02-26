Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CCFEC021BC
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 17:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnLCJ-0005Nu-F6; Wed, 26 Feb 2025 12:27:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tnLCH-0005NQ-0M
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 12:27:49 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tnLCF-0000kH-F8
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 12:27:48 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-223480ea43aso7649035ad.1
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 09:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740590865; x=1741195665; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UcwWxqC23XL7N7XCAOPO9ZFI4NdQ90BpbvO5hqyFRFg=;
 b=eQ0/x7entCBy1GPg7WykjZzqvmlIoH0gAYbu+Xlgq/16mftNNSqPUkEnx6r/v8+wEA
 iKd9Nj8H9H/qLg8tiIMnolBbsB2GDw6m68gJbbIue1Knt72lLtP4D47f8UZYcHZ7L7o6
 lVG+EbJ/I/I02Ot/7Q+hxgQAaJYfs6Blz24XBGi8JpnZJzdN55BLGfkHxbd89ol4gn5r
 gUWN/gOXu03czTOAqYdeGdrfCA98eY2gFJS9hbacDMz8qQP52iCqABboi96nDgIuedJx
 90jB0EjJ0i+9iu/NNwbo4yx10vyBtw8OCRBrbVzPr/eVyxDw2WUDGlIbhbftpOsKvL6o
 n3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740590865; x=1741195665;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UcwWxqC23XL7N7XCAOPO9ZFI4NdQ90BpbvO5hqyFRFg=;
 b=k5OJiSf1+xLaxhkdaahr98yhWGSXetF/3qEKuwz5fxdkHrkRDrFZl/QN4ls4cfzWPi
 YUqh6we2NN4Ez4IiZFt8QOXKULhs7hnAFVgFGWzoEJ4xxU1cXrcAHlV/EeBkDYZ4ILph
 fwIidW4FKUqaNVeUMmAeU3fk3SVdw29o8LOQbu5E109gbjeE/BBhR7/VbAIxiconFVlD
 KuakDZ4irB0umdoBhJTM0xon7n78Tj8YFqMmLCPXMEP/+hkX2SpL9S/Wb5JYoD/LiysY
 S2gIRvN3x6WFTTRfLr3lgY9CP7JP04xgHnguRbRCUaEnMrPCfOgqjG05SkVSS+l6VyLw
 IOag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVtywZfuOGsz4ZsAeHNHHbiWmjtQg/6amjAkaqhK9GXtw2skv8zLhhc9IS9JaZUKoVHPi/1Dmc4837@nongnu.org
X-Gm-Message-State: AOJu0Yw+l5LNBaZ6oe3dR8cTMip138BTfv9HlEnW860xI1KgE/zjQoCm
 6wzvGNWEpKML9aRhT2TOAjQa7hKQr3YtzhqoAVc/86DIBK3wxUizGizhpwNlvSg=
X-Gm-Gg: ASbGncuT6NoivmiV8O0s6df4KNXNQHELLd1tfIiPHk2cpGz9aL+BrqpynWxc1g+AJFc
 2+CtV6Ji4aOC+eLd4R8URDH3xdzndcu+N1N6BNiTVW+ID1FY8W+K4B+wP5GK4sIX3LzApgNYwky
 WXIWXIVPvUBLZpSfBVLgcQ58jz4Y5ihl2Xkwo5Dmys15S2OS/36PPzdT9s7O3/NiFhfDDyeYwn0
 8XkpQwNUOBEJDvYS7ryodUvXWaJqQkOg93iJ10x5xp+rcCtFDlOMTsV32clwggXeqLTtAHqDZjm
 MmhzAD8TgiXwwqIw4ShKknx8X1HiqGNoW9MvNKl9jzshJ4zo
X-Google-Smtp-Source: AGHT+IEJHPbX6b01QT/Da5sMIoznVjlqmwRjj06kb70oBUaurMMLayeMfMJCJVnUUXmSBxcujsBFzg==
X-Received: by 2002:a05:6a21:8cc8:b0:1f0:ee68:aab4 with SMTP id
 adf61e73a8af0-1f0ee68ac38mr17729125637.23.1740590865389; 
 Wed, 26 Feb 2025 09:27:45 -0800 (PST)
Received: from [10.254.143.227] ([172.56.201.232])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-aedab01de14sm2964087a12.72.2025.02.26.09.27.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 09:27:45 -0800 (PST)
Message-ID: <a3894386-c96d-45a6-86fe-f109521770a5@linaro.org>
Date: Wed, 26 Feb 2025 09:27:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/25] plugins/api: use qemu_target_page_mask() to get
 value
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20250226140343.3907080-1-alex.bennee@linaro.org>
 <20250226140343.3907080-16-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250226140343.3907080-16-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 2/26/25 06:03, Alex Bennée wrote:
> Requiring TARGET_PAGE_MASK to be defined gets in the way of building
> this unit once. qemu_target_page_mask() will tell us what it is.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> Message-Id:<20250225110844.3296991-2-alex.bennee@linaro.org>
> 
> ---
> v2
>    - use the proper qemu_target_page_mask() api
> ---
>   plugins/api.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

  Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

