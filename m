Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A16F433CD
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 00:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDAIG-0001Cf-VR; Wed, 15 Apr 2026 20:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDAIG-0001CW-2z
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 20:09:16 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDAIE-000878-En
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 20:09:15 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2b24fcc2b5dso49919655ad.1
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 17:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776298151; x=1776902951; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zS7I857YHphVzxQmSshvRdtCo9lVGjHuVWY+FD0F6og=;
 b=Ny3wG/t9qDD5f4LkN2eFrBmaG0lPawKMZEjaGRQiIm6C1kn0/m47h0U6ebJUo2Wkln
 kHsbaesZhoAPL7E9WrDr5TW0m+bDrk3X/aPlecnw5K/7F5V8LnxrXTyS4JIxNS+Vhn/t
 XhmX7irVd9HiWbC8RANAegOkwRnCJVGi2PdXW6dAFb76MVFT69ZjzjMtmGOlDkYvNUku
 6Yvims3iKLDn1HX1/S+bZp0z1mjDgmHrkmH5YYgLwojTrFak5tOOqtW4GdGHHW7Yx6MZ
 bTcJScCcd840Zz6TZZap5l0vQvwyjMaU0nKefOzJt4MIMk23NdHFg8d5nfXDeplO0lsp
 jePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776298151; x=1776902951;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zS7I857YHphVzxQmSshvRdtCo9lVGjHuVWY+FD0F6og=;
 b=Qsu5kzuN+D6ZBiv4mKMM21/I4xB4b1SjGeivDEmJIbPQHNS9g9rdLfkYXkQCm2Chhm
 uNiJzbn1NcqmPbFgauGmBnMCU6gjjuRyMTqz84181E/YPxj0UoJuZnWB0qfjEjoGG2iB
 BIMyJOO12l4GXOAU5N9LnNIFxWmcXucfp4v8Kgk+RuWsifImAZC5YHGC2HlqLTH5Q9Vw
 Jc3z06vZ3mK+oenXu/zT/r4hpZQveFSUitllrULE0eYr0dyhiq4GMRR5WK1eXmch/coA
 HmxeWloMxR6Z4OHq23X8CYlrY0d+gI3DjfGBCPcTw6kteCSHdoqeXRnDX8Og5A8ILX8a
 oVIg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9hTLxOxpf8C81zQlWxXSeXv/JOpqJAkz8AXQf4WagjiGDMLuTE7GrzbuhfFFNzwvkXPSySkFYlpa0e@nongnu.org
X-Gm-Message-State: AOJu0YwgZ3tMXGZWvHyWDovUrXGcNuLtgfaz5/4vBLs+/+Ur3s/DMsuj
 Sx/HeOe9j7quUWMgHO5NdOUuXe9fcltxuN20hoLyJVnwGCjzk+QfNiMEjAAXAvw3SEc=
X-Gm-Gg: AeBDieupFy6Eq5aLHTFEQkg4mfxRl8yLvCswHSutYGqIRwdOldrZt8OYOFnngrk9NW+
 yQl7hRsOY6xgqZ8T38iGlBLrx1peRQh5cG7L6f0J8ZGC0z1wJIg2/BpDwQEj9FjMzUJLzlzrXhV
 g1csz3E92X+TzlmGSOQiZNBPnu2eLECMergFQsY+Ls2p4IMAbRRZHkGzWQe7xIxGpAbkqztSXkh
 78sP5bOVmfzDhxfD0nRNx5dpSxvdoWyXocBak6stxJkOTaPfX7isHAfexoJNlBwnXWA9NdIzJiO
 R304yQLijgZZnfF7MUulrbkgLuAMcL/S9n7ijG/fHvs8f+b4bciOv+Sf5WPBv5Cf9qIDDz8Qi2B
 RFROx0bPAWs2KyCjSeHYTQgUj2IhmQLpinNpByuJO3ZPvDO9KHPFXzwFFa8lU7PtNn/d3jdmcPz
 0ZSaj9IcrsUjvbgBkQm+mjPUbPxAUK1K/C8//O1OPCck67SkZOOg4NILfmH9q0q4LLq+MtMWnet
 GmPtTjI3CvQyM/sTn5pOABAXDDhqtj0nVRXwdB992tHOD6SxTMT6xH8sqLC7vv0Qg==
X-Received: by 2002:a17:903:249:b0:2ae:6192:8d78 with SMTP id
 d9443c01a7336-2b2d59411dbmr233838155ad.1.1776298151388; 
 Wed, 15 Apr 2026 17:09:11 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:31f2:aa94:4389:37f8?
 (bg30dhzr9yyk68wp6s9g.ip6.superloop.au.
 [2401:d002:dc0f:2100:31f2:aa94:4389:37f8])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b4782ace42sm41977035ad.68.2026.04.15.17.09.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2026 17:09:11 -0700 (PDT)
Message-ID: <ec2130be-52c2-4096-86ad-2aa0ed42fd20@linaro.org>
Date: Thu, 16 Apr 2026 10:09:04 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 2/6] target/mips: Convert MSA LD/ST.B (Byte Vector)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20260415202027.83008-1-philmd@linaro.org>
 <20260415202027.83008-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260415202027.83008-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 4/16/26 06:20, Philippe Mathieu-Daudé wrote:
> Replace runtime helpers by translation.
> 
> Replace the legacy cpu_ld/st*_data_ra() calls by
> tcg_gen_qemu_ld/st() which allow to respect atomicity.
> 
> Consider the host endianness.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/mips/tcg/msa_helper.h.inc |  1 -
>   target/mips/tcg/msa_helper.c     | 28 ----------------------------
>   target/mips/tcg/msa_translate.c  | 30 ++++++++++++++++++++++++------
>   3 files changed, 24 insertions(+), 35 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

