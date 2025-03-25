Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51538C36005
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 23:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txDPC-00009A-GX; Tue, 25 Mar 2025 19:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txDPA-00008r-8b
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 19:09:56 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txDP8-0001l4-FV
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 19:09:55 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso46911545e9.3
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 16:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742944193; x=1743548993; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bDybgzDygDsE/iTXbnb+8qzzukMTqwuA/mXM/jtKs4Y=;
 b=lCq2Ea0YO0gQi13sFGGQq79AO0C68a6DaQQfF//mT/kep4rf/QC78n2HEMXhwr9Wg7
 bLZdJUioTl7JgGd1qc88RiV/rdJaS8owZoAp2yYshAsmfMxx4hTUx1sAGjXUuunVIODO
 76k+AvpmbmVzjPudg1Nv2vXLCH07jySjhZizPqklLZbtJxV/y6C/PmZQhkGsDDBvPh2f
 K3ZfkzL9SDqmkLKcexz5M6P82sVVImQ9IfVdba+Mzh+fYJkakIw2/0GMV+MADWDk1rfD
 m56+0zovVOpEeeg+pLjaDAUBNKUOD0SKrvvLXtQpgl6lku3AZy+zsM0RORRkGOWRR35G
 OAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742944193; x=1743548993;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bDybgzDygDsE/iTXbnb+8qzzukMTqwuA/mXM/jtKs4Y=;
 b=K9qwdzSKHR+exzSO+FoIlcXpRHcGk8369UIuSNlTeNtjRUOP7+0afaXNW05NGoO1r1
 rtXh10eXyEAWiGf2MIhpZOdGs+8aKq3/Q2dndxUzxVbO6qn8h4s5nKY5lYPWmHc75jS6
 p7tb9LnNrGCoj6UJ8cd2gqxmkXeeW3m268pv/9CMH4YxaoJmYGMnkKCZcFNto9xj42Lo
 pCTHo0BBTYjSwHNKBMAYHeWG9HxZ1PKPVmEUoypN6P3TxxfWy3aBKYNIOX0Zvw2HgfTm
 ek89cPdoYr6hnnohnJ4lV8XWvJjurMr4jwQUbhLXi/Nhfx6XIzEgous7jRhef2EW1y/0
 UZEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaasCWKIrB9NyWKQ7EEv/Vz1Refzq5ZGmpMEYe9W4y0KH7ERKdWBzwaSv9fYMvIE2UtZH9GmSpE66c@nongnu.org
X-Gm-Message-State: AOJu0YySGc638ZDd21LStArEbYX6uCsm9sJCzlcI4Pk4M9dxMD/tZzm8
 4WKUSomx5jDpwInAaSlb+yeRbXmmZ+9su0tb1d9ugOPMar17EKhlfaqpfjLW6uM=
X-Gm-Gg: ASbGncvonPF13eQkpdm9W9qAkDDnbX08YqGmcYvMEEOmY6kMzXcRm3EgDlPvNk76zIs
 2Nfxuijt4QukNTDybLUHdDOhQ/LpYHztoCJVk5/yFtoKn7PURgEcKESK0bknTNOZwplEEVMxFLt
 dM8TQ6pBu1iLJFmUiLJAKGK9abmXxz7wKqQCz3vnU66V7Gt5X+yj0NK+oVr2hHQ1dweU/CEEDzm
 27vELQi01jNf/nZB13ABvoD04GDdwJxFgPL6jLWLASRS6MROLU55yzGuo7VcOzjHDVmfbReCTfx
 YvrsNnLCqx06FREsgfZzfoKcsSmZLlNQPhEGAxETxXuy6418hCNzIynmUgw8mNsy6AacXcWy15P
 h7rJRiQhXLNkq
X-Google-Smtp-Source: AGHT+IH7fOqT1jyGDqpwOqigD/H1WOfLCoZOpZp2BGVrMUAAm8T34LMEKfcCfbc0UoP87njkvAHUMg==
X-Received: by 2002:a5d:5f42:0:b0:390:df75:ddc4 with SMTP id
 ffacd0b85a97d-3997f92f6e6mr19316539f8f.44.1742944192666; 
 Tue, 25 Mar 2025 16:09:52 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fceafb7sm168190435e9.1.2025.03.25.16.09.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 16:09:52 -0700 (PDT)
Message-ID: <db87aac7-9988-4f74-990e-0df9bf47db45@linaro.org>
Date: Wed, 26 Mar 2025 00:09:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] target/avr: Fix buffer read in avr_print_insn
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, pierrick.bouvier@linaro.org, qemu-stable@nongnu.org
References: <20250325224403.4011975-1-richard.henderson@linaro.org>
 <20250325224403.4011975-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250325224403.4011975-2-richard.henderson@linaro.org>
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

On 25/3/25 23:43, Richard Henderson wrote:
> Do not unconditionally attempt to read 4 bytes, as there
> may only be 2 bytes remaining in the translator cache.
> 
> Cc: qemu-stable@nongnu.org
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/avr/disas.c | 21 ++++++++++++++-------
>   1 file changed, 14 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


