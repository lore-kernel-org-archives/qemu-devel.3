Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3068C0218C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 21:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcWPI-0003Xb-0W; Mon, 27 Jan 2025 16:12:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcWPF-0003X6-UV
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 16:12:29 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcWPC-0000aY-4j
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 16:12:28 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-216426b0865so81536645ad.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 13:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738012337; x=1738617137; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tikZBc8zXMa2tH0z3aY/WEvQ26VmEeakiKukD5u3FXk=;
 b=P4F+tB99TF866rXpZicoed2yHJKWbTnUE3gXZlZ4C6uHbDca5Wou10nUs+isuLq82/
 Zq2HddSZUDzuZFixZaC4WfGWju6qLYhX6m2JM55fUEITc+W29ZZgojzhrBE70Nxy+W9a
 s4JWEu+XWrTwyzDzrsEpA4NWXXVN2pf/JV0Uez1sECtF+6y07Fk+bAGzXHaupip7wBFE
 iDuxDq4KC87LDZ1WgS3oqwGAafkFGQWRNora0/9VS4xCL2bwUISkB8/mLI/+iwecK6qa
 nSvNfrDHxiWuXw2Ef8BK2u62vYHseOfKFhDZVTUEE3uTrxuHAGANX56mluZoPX8AbDzy
 Vh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738012337; x=1738617137;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tikZBc8zXMa2tH0z3aY/WEvQ26VmEeakiKukD5u3FXk=;
 b=BA+fq/cidGMdCsnetw1kp3f3LIA4GNJwhsPE+vbYcfs23aPIy1rjJWpubqZIE1b6eG
 ndo+qAM0axCLTUohPjCUI7sgyWMwQDqjrlO3wiMWj5jrYKGoWM844oO50ItJFN4bl/3k
 4hvrbS8w9IY0KCVO5LQsn6F4lUSDqjXt2SXrvFxXkSU3zVQJ+PXUt7uH0WUzERY2JZzf
 ViBSrVwrC3UGqQgx8jDM4HewHEYg7nLrK3TeJe95KiKCKd/C2E9NFZfQzaSqR7CjjocJ
 MpXT9zZuRU84XCGl82Vz2V/YohRjQgKaLr+T9R6u2XLkqYFXR+8sbmeco5z5l1Ixxrq8
 Wt3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3pAn9yCnWJ4EplQVfuX74WOB4uabnpGQj0Pegtxi6zszPc0t+0wbEI0FGtIrPnlXRV6whHjBalajh@nongnu.org
X-Gm-Message-State: AOJu0Yx8A9d414mMgU0+m2AjDH0tfT7NOhL3g+Fm2FT7sK/vZhKOZKgO
 KNpXhzVPiBcTriSSHWcYUJQ75GkptOBE0DqBgM/dVh6BsiG1Hy0XfR6Htae8cQM=
X-Gm-Gg: ASbGnctgQdTgjeP94D63eQIJ0oFpk3h/F+lhAS3Hhou7N0FPbMYoYqGGIJd3pZYsN82
 jGKxxc3LYz5SVdgvaAheozN+LMx71vtXXVe66F7+lKRJ7ND7idv4swB01TYAPBrWop23Lrag40b
 QgNJGjrdM5tWDe78Jucp/Wn+siXdLDcIODs/rVUgWO9QUBn1k6F5VMtbm5wBZZyvHj+v8fgYIwd
 sbHjZjxTJ/VirzEESabqYLHto0e0HwWFiE+uTGCxtEAP9oXiFTocY7yYsj73QVpH2TSbOHNaSNq
 gb17fSLRz9FWWVWNEfriywr8eamtnf0Ng5cEoPnt8OkA0y8=
X-Google-Smtp-Source: AGHT+IHTRV/zR0ngSwO6nRU4rNIMpB4Zp6d/x8iGynuJ09YLyPCmRI+84vFMDE2oY3NOL+fXhVN+cQ==
X-Received: by 2002:a17:902:d510:b0:212:5786:7bbe with SMTP id
 d9443c01a7336-21c3550e908mr729352445ad.24.1738012337566; 
 Mon, 27 Jan 2025 13:12:17 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da414cc20sm68552005ad.165.2025.01.27.13.12.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2025 13:12:17 -0800 (PST)
Message-ID: <8ed100de-9136-4beb-b9c1-cd6cdf78a635@linaro.org>
Date: Mon, 27 Jan 2025 13:12:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] hw/loader: Remove unused load_elf_ram()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20250127113824.50177-1-philmd@linaro.org>
 <20250127113824.50177-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250127113824.50177-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/27/25 03:38, Philippe Mathieu-Daudé wrote:
> Last use of load_elf_ram() was removed in commit 188e255bf8e
> ("hw/s390x: Remove the possibility to load the s390-netboot.img
> binary"), remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/hw/loader.h | 14 +-------------
>   hw/core/loader.c    | 16 +---------------
>   2 files changed, 2 insertions(+), 28 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

