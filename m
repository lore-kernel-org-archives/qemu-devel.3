Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F4DCD6E49
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 15:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTLYW-0004RS-Sv; Sat, 30 May 2026 11:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTLY5-0004Ip-4h
 for qemu-devel@nongnu.org; Sat, 30 May 2026 11:24:30 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTLY1-0004yS-Fo
 for qemu-devel@nongnu.org; Sat, 30 May 2026 11:24:28 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-45efa80e0afso252422f8f.2
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 08:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780154661; x=1780759461; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q7qX72u84oxPUXmdgCnHrju6EpU7Gdjld+Q0IfPUpYw=;
 b=TXSfmCHZQzIiNjxMTPBqtp2fvc0IVYWugHa5Xz59gMnYsfB0hSH7ApqWbO/vILRg99
 97A0Ag0eSr2V7iayjhuYxcR1XVEwhSd5LTel2eDl0nb16G3/Po+H85Pj72jlTrgRgjPm
 SxHeqsNkad7robxM9royAYSkal2vhkrJ0lU4pCXO5srLXlE56smECc62spVuYiGsieZd
 VIAy9NB/tdG45mKxllAlwboEo2CqiBsl/lXfAaYhc1W0p1HizD7tUJFZazSqjgnRvPY8
 OiKFn+XdojkPsW5HzafW8N1NDVBNScfVOBdDZnEyYzTIbS12n6BFctcHNGflZ2rZ8UU3
 veFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780154661; x=1780759461;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q7qX72u84oxPUXmdgCnHrju6EpU7Gdjld+Q0IfPUpYw=;
 b=nBAs0ul4fP/kJbO2IleGKiyGQZs4i6/EsfAl5RPjNCnWmgfbkTgFbuvwgeLbwwmShX
 KjmstAXysgP/uk9YMLR6iI3IVaJXo2miUvls1Skz64qpY9+3vLw0K0JboNodoAEHI2w/
 8O6nkayAj8nA5EcgUAXSKKuh/3C2jTMRmTtZCT99ASCeEX/aTwU/I1aya2O+RDc+vsnU
 LNn08EyrGjA6QUfEFzEE726+p0QvVwkuhgnrsqW6NU5vSAKeZwDcF0JiI5IvOPljNpXW
 nERcsNqRG7Ri8+4dB1jtfNtwEbfQiWij0PRZh2vMT9PwJM80zqLoxKDx5U87FdkFux69
 3DUg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+9v+kuT0JwXshLAWWD4vsAl2j2F9/Lk/ljBQAgAYTEiNk2+foxWCt56QVOaULKulV42053VQQ9j1gn@nongnu.org
X-Gm-Message-State: AOJu0YxgKC4/9KameeTOrpDFJj9yuXRw3GfTED/4nb+6Eqb2Y+PaPzdf
 dT78lhrj3Hj4Kbik9+I1Jzl9NQD/DK5BgQobQfpEXPhKDPxQX0sUzTkxByjvj83lILA=
X-Gm-Gg: Acq92OHEqsUv3CBHi3/nxQB4w+dGbN1ae+s5KLy+lNOPBkENdu+eHcjo24mBtNV4Yim
 d6iPYz2nbu3fYPceaxSPuoHih7LRr5WQfMPNuB0yPon5yR1sEgLW+88S7RuMQdvF+KPbT+B/Mo8
 WP9BPy3HKnQd2yermDq+/h77uh5fGN0ssR5FQwqcscAX9g7jEe8DJnqccayc73zed+yCDtQ/hxc
 2QYN/zhYbztghFyQtwqbT7BmSpwuSUCXYfvr0Ky1FVxdhhQsH3qGQU0VwrzV0I0OpgktZkM+ICd
 qrOztyadhp363aRUEw8gjiLc7bvVZzOddEye5oyO/qLHtZBMSfbquuPALIyxcXWTKVVbnw+xZ/7
 exZ+H/TfZaoAijhr6ehauyMaGr1ekMgotg9j9rBZWjFoRkSmdeBg83Dr/W/TJoiJRyjgSEwkh5n
 KQwvjhIY/eT66I8WRI0+oSmmONGulS5bDUcrffXi1JQpe1qo1cPqE/v33A4TGOkhymiT6YOUHbP
 /Zn
X-Received: by 2002:a05:6000:60a:b0:45e:7997:8b82 with SMTP id
 ffacd0b85a97d-45ef6b397b5mr7353895f8f.16.1780154661482; 
 Sat, 30 May 2026 08:24:21 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef34b47eesm12638888f8f.9.2026.05.30.08.24.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 May 2026 08:24:20 -0700 (PDT)
Message-ID: <9ee79adb-56da-456b-9e0f-20a7c602312c@linaro.org>
Date: Mon, 5 May 2025 16:32:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/12] target/ppc: Fill in TCGCPUOps.pointer_wrap
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: foss@percivaleng.com, qemu-ppc@nongnu.org
References: <20250504205714.3432096-1-richard.henderson@linaro.org>
 <20250504205714.3432096-9-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250504205714.3432096-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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
> Check 32 vs 64-bit state.
> 
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/ppc/cpu_init.c | 7 +++++++
>   1 file changed, 7 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


