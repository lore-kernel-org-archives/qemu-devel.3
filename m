Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C86D0C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 18:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJcOd-0000iy-8A; Mon, 26 May 2025 14:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJcOR-0000hV-H6
 for qemu-devel@nongnu.org; Mon, 26 May 2025 14:17:51 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJcOM-0006p7-FH
 for qemu-devel@nongnu.org; Mon, 26 May 2025 14:17:44 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43edb40f357so21224205e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 11:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748283453; x=1748888253; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=06+He6DHqOaZC4ejXWxNAP0Uz8gkxE7q8HACenGWpPI=;
 b=N66rd3D+/h7CNSxzpcInnHyoxxNPfKzfZIeDh+IVGugxTmmN3b/J77z9ApYrddpBev
 6RSLAsWb/u4gVejeryu827xtEoa3WZDhhdm5di1aX8mcs7A7ov+pW2yEXum1HadFzidB
 YVoaLRPgriS7MG0cWxsfFnV3a1tbVrRzMmksEdiUnLFc1LeIRWTSmCc6plPi0WxZzS9r
 UwMKh7uPovKrCc0xQ4ouLvuE9+Lt2ewsvTNMBZz3NZSh43s/HBSJbqwbvj+Aa5ka/n4m
 EBhr5UVL3qdh9lIp6/f8TiK5xvB6D+JDfRglyVF2jJdH5btrTzg/dwczmDiQ100zie6k
 +vNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748283453; x=1748888253;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=06+He6DHqOaZC4ejXWxNAP0Uz8gkxE7q8HACenGWpPI=;
 b=wASioQSSXbdpB6oCdZSs3F0Fj13SoIjYmmqp3fWMAW+yO7cBXGRmHHz3+dO4l49Wo8
 TQ9ya0t1YsK8vqgeT2li9VlgquJiwCyLHeV6VvD10zQCZSfLDkRz7ApRDMKrU2UkFpwS
 ISx2JxHIPcyybhU42QAVS3dEowjnNvwA91f4BKyGfmC2mxpr1Zaitjgylm9QVBvF4w1G
 flqD0wCEyQt4rKjgD+kGlcjswbWQ+sWNrO3Ykf6YAkwpweVtxG3cal+vrE2bswAkq2T7
 1F5CAvo+LpGPlAoHXkZx0gz/abaz+4FNPJf2n8o+UOFUkGyn+POnOFY2jI+8Fxg0sATr
 iKHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqflcpaXufdPFIEHIUic73AZWsucI37RhytYMgtVhUAUyoGF1LGMOsdtD6LdgxbLdQemC1h8VsTF5W@nongnu.org
X-Gm-Message-State: AOJu0YzejL5w8oQj7tDSOCdCzm+hvAhCchnxnSbi8sCEDtSd+6j1OWXJ
 c8Q3bO89FaP4dilSr/OV7U3eG1iS2rx9vvzVmSY3SIlFW1B5J0FheovHR77eofyHEhU=
X-Gm-Gg: ASbGncvL/axwte1ZOHIKMdNvvN8YjG/8jkz7cJKvVuechurMHi927exz3cQyEPyU+xk
 75HFvCUB/0XZ6t2RrubfIO0JUCbjgb20d0xhRWgdbCfotlRA7uxP1hXkrVV0QiCo+AHucq4+kiV
 L9OivM2z/U1Boctk2clLOuxsKkrGN6ZcKGjDQGHJJU3SKnYZMR9/UxhyaozmJYp1CJGtnt+S4ha
 YXXhwx/GkRGrj2Alo5wT45SkxVQ7cx4JREh9vyxVzv7XSjL2NQd1Q9Pbj+1yZs5qw4nzgXja93z
 wrVpWAPsjeRtYSQV/dQIJ0wAZMzvoKNdD3PTO7kuPRapT7tMwi2C+LSBZDppYjK4beLXVq4MKus
 MujsVQhNVLdmjpQGYCXQ+I6mG
X-Google-Smtp-Source: AGHT+IH8ZoGj8yU9cZwmT0TFRw9fPGumuy8+Kr8Y2u74GpAKqeKQG2KJaqJZ1IgjwOXJLzvHcyM8AQ==
X-Received: by 2002:a05:600c:4ed2:b0:441:d438:159d with SMTP id
 5b1f17b1804b1-44c91511fb7mr83501845e9.6.1748283453211; 
 Mon, 26 May 2025 11:17:33 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f6b297easm255615565e9.6.2025.05.26.11.17.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 11:17:32 -0700 (PDT)
Message-ID: <1a6f9315-5633-4596-b6b3-e2fc565d5d67@linaro.org>
Date: Mon, 26 May 2025 20:17:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] target/loongarch: Fill in TCGCPUOps.pointer_wrap
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: foss@percivaleng.com, Song Gao <gaosong@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>
References: <20250504205714.3432096-1-richard.henderson@linaro.org>
 <20250504205714.3432096-7-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250504205714.3432096-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 4/5/25 22:57, Richard Henderson wrote:
> Check va32 state.
> 
> Cc: Song Gao <gaosong@loongson.cn>
> Cc: Bibo Mao <maobibo@loongson.cn>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/loongarch/cpu.c | 7 +++++++
>   1 file changed, 7 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


