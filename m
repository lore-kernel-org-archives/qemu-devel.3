Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88CBB10F996B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXhd-0001CL-Nr; Wed, 08 Apr 2026 14:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAXhL-0000c7-Vp
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:32:21 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAE5I-0000yk-75
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 17:35:45 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso34814575e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 14:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775597742; x=1776202542; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3W8HqqTxFOh4MkmTfwH6twPO7RF/ZB9to8jMJklt6Bc=;
 b=vxNCfNTXGSZLRTTIcV/m2FCWi3dFGX09FHMP8vW3gVpMsjN7sZYZ0XZhTtxnt1NwHF
 fbWZn4sf61zaZAhOAPU3Z7/S8aL7xUttxTXRbXlLevSjk9DUl1JqkngXjkLKp+JAzJL9
 hkEz8EnmIIog/FT2f6byDyGUtymOBk9zAogksBazZhWrxJctrkjPgmONgIvMXYcONRIL
 kvhBUAAxXl7EcYyl2rMD/W+eTQAx/91aw+HA6QDGe5HdpUAFywk/hUGdnaJKbwLL2idm
 E57CIIGhm+Gyg1PxfSMlQ9TsOi8pT9hLz6pLI2jwGS3ye+mZXIHUq8YI8INO+h/jj5zu
 zlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775597742; x=1776202542;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3W8HqqTxFOh4MkmTfwH6twPO7RF/ZB9to8jMJklt6Bc=;
 b=LCHFpRNeceO2ehOoI5bZpm95CaSXPRmzBggIHhJUpvbkgC4evxpN6t39FsjAd4pmkZ
 8FG6g98iyrKbJIyvMuZfWV4i1qgi02nCU28VP+eaBbeB/Y62tPtNMxWpXXAfFvsHHHU4
 pvHtXL8nnBlQl/CMkX9Aa8FWYBy68J3wGA8J4chaOCs+0bHVDaDwvE0jPyIxKZA9Ls8Y
 qy9WXYohZGs8pEvXEtNu3NSLr2efgdvsMhdwqyg5HAU24SiXGsV4BFj//5TdVhMM4FIO
 +ftR5/7uxxOsLy58LixnIrD83ZVG1SY7j2ibTZx6al7+0LTUB7rmkRSCvoWsQivCv4at
 iozw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKCCYZEbXCF9+EM4dI1KDKp3YQyM02mwJAxvvv3m7MX58o/oD5B173zb0MyqhHg03KwFMS+OIJl1q+@nongnu.org
X-Gm-Message-State: AOJu0YxFDd4foY1M9i1v/9LLfj7xQGNgLOGoONdZnDevuDq2W0WN7HgS
 YcpiaSQ9K0kiB+2MwGVOuCEskqiS4T2k2gCoCr+IvhtuxkP4R8+GUDcSrX5SKnbfofM=
X-Gm-Gg: AeBDieuPfgY/3+8qQfBWOmr7eAYswafxWJTrogE9lJ22kiwnJWi/VfMCdPkXPc449aK
 J5IyZjp8kE//f798cDQ/xDAzpCc5sGzXHDFGiC9QAUpK3hXPIPJLLMjMCPiSLAp3YyXeyn6NqrG
 qpHEzlrKCYCpUV9vIqkV675Z7jw4MU3UhDTa35Q04G3B3r+D8qimq0yKxnBdPK5sTFC9S2fwWUc
 F/RgeLfTRCGV5vft8AbM13UaHjgLo9WHhTODyGhFbClRUHR3Xc+t9036ZphDbE7DpPynPTa3Y77
 efMKngORNtAoc24jvKhUsC8PVNy3MLNjnnqFUpqTOcG/bo+qg+MRT88XybbdVtgjxlQPJQx+fd/
 Ok2G9+KEOOUK/q6UD+sYSY5ZSvnPhEdHdSeNMfJkog5PigM8L9I43ImdV486yfxB1C90/05OjFJ
 tqaVzXOWGPWIfBaKjr28uli1uZmn5/vtIbAFPjCyi/irQSvQTi9MOH23PmQHEOhDu1cA==
X-Received: by 2002:a05:600c:c11b:b0:488:be58:bb5b with SMTP id
 5b1f17b1804b1-488be58c8fbmr45325305e9.24.1775597741690; 
 Tue, 07 Apr 2026 14:35:41 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488940e075esm471801215e9.9.2026.04.07.14.35.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 14:35:40 -0700 (PDT)
Message-ID: <58f386b1-ae83-4faa-a05a-3f36d3bc2e51@linaro.org>
Date: Tue, 7 Apr 2026 23:35:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/21] target/arm: single-binary
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 7/4/26 21:59, Pierrick Bouvier wrote:
> This series tackles (most of) the rest of target/arm, especially tcg folder.
> 
> We extract tcg memory operation in a new header, with a new type representing
> virtual addresses.
> 
> Initially, I went down the way to have a dynamic definition of TCGv, which
> required much more boilerplate and runtime checks. After discussing with
> Richard, I realized it was not needed, and that could simply split 32 and 64 bit
> properly in different files instead. This approach will not work with other
> architectures, requiring something else, but it's enough for target/arm.
> 
> Files left are:
> - target/arm/tcg/mve_helper.c
> - target/arm/tcg/m_helper.c
> - target/arm/tcg/cpu32.c

I remember having an issue with cpu32.c when it registers TYPE_CPU QOM
objects, "max" overlaps with cpu64.c one.

As a kludge we could rename arm_max_initfn -> aarch64_max_tcg_initfn
and move it to target/arm/tcg/stubs32.c =)


