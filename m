Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E161FD3B7E5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 22:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZzfw-0006EG-U0; Sun, 28 Dec 2025 17:55:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vZzfu-0006Cw-PB
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 17:55:46 -0500
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vZzft-0004jw-DZ
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 17:55:46 -0500
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-640e065991dso7095052d50.3
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 14:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766962544; x=1767567344; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8LOnjzhSj7irEtS7A/k2nEwf6fFd69hgtz7m5WkXCh8=;
 b=NaNzVUDhK8hYcpyaYJMuFw6sD1OM9f/VsHBIJwP+0H/oz7BE4bOABwxKLlFBjYU/0V
 8HJr+qxUaO0FXhqW9dNvQXw5Uqf7uq0JH/1jR8GdNFP7jdIG8gGt5SaR0iioCQWS41IF
 yBffNS2Nb3Dhu5d/1h0y7hTAIdZ8R8/RJtbgs2tO/tqmdGVKhi1FDHYpmMBA/p2Z/2eK
 Sz0xua9GpTrgK49biqxGmAqZajOCzKBWRCkG1vuHEhgJ83QtawloQORRTOTOhV2LDKPz
 rlC/mM91kTzscVK9Xf0vwLTfRv08gAuKDqo0sf8M5qHfV1N9qnlK/Nj3PL7AbA4uFpwT
 xQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766962544; x=1767567344;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8LOnjzhSj7irEtS7A/k2nEwf6fFd69hgtz7m5WkXCh8=;
 b=pb1brly5CsQf0fxGbDcwrBoxX02OFykPixBwGGJK7wIuVy3T5Vfc9VuUGx5vERZjYj
 lJ4wUM5Lg1sDAJYPLkC2fpI0C7ATqzwjswz1/DHkrYzHN7duDVV8gYqN6Y1DSL46/ODn
 ks2002X7RWRnBosJSngcIGtik19iJF7I8ErZbtvbC0v4nG5Qr6q0o33cPlNLydKuTktR
 4mxUFafl2fNlhmhqkcS8a7BYMDnEAPWYnu//yfuse+tk1njNDm/gCbevDEfMTwszJ/md
 XeXyEM/XwyrDuCCLam2hlvyFr/9XGMWinRMKv8rLBTt3xvY1ghViNE3lCjB50bup4+ta
 4Suw==
X-Gm-Message-State: AOJu0Yym0h+NKyk4N3c39qUFKG2508ZfvYa08gHy764VIz8H/NxL6gN0
 lO8pthoZQDSQQW4LKO6lpMuEMejtsr/XjZ4XZAxO7vkvuResNltwB3iNstuu1RvhKGryPpCrEdo
 gIvPO
X-Gm-Gg: AY/fxX4vyzZ4TXdUTuRdw0qd4IOHRkiYDxNeUiyvoIBA/cXUNOTiPjkYOsBEqOjBGfn
 eDfWmjUt6jiACQWrZY0gBmI/J6dlQ1OKfFQC7AJfqlVY4EaAL6aMok2Ebka6Eif+rAO9rCJd+7M
 +vdMuFjl32tfcFfrS3mbYrIlX8B+M2Jaw2w+FkTcM8o3B6thfvyXsvfjwS4pCXtVy+ETX+tF+Al
 SWej06xrfVXix5SsQt7PqGyLNE6s+RNN99MVX6zdgAOXa3255iHJZdq0L9+IIobPSOrh8O5XaDp
 UKP0snIxcLsM9TfpUfJwC3KajP55H093/Lhk8ikK7Djrl/yU9MelK/8bnj+uPiRSviNy7XsGn1V
 oXWFOPNcR1Dy367i4rajQsOlK267y+H6S+XB8P/xVsVL1bsLU1U2GvzVp9Iil3jS7R9LCGDNaYM
 HVaoz+S1Z/NGlnNdwUGB/KgDu0zsou81isw9nez43bUQlgeIV+39le
X-Google-Smtp-Source: AGHT+IHXWaUn3yHPt3aWoWJcQWlWUVViAb1AX89HYZpvojNCpodxs9dTbpo5HM3OYGoN4hl0nihWPQ==
X-Received: by 2002:a53:c94a:0:b0:646:5127:9ce2 with SMTP id
 956f58d0204a3-6466a8abe7fmr19642006d50.46.1766962543522; 
 Sun, 28 Dec 2025 14:55:43 -0800 (PST)
Received: from [10.212.166.227] ([172.59.192.106])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-78fb43782bfsm109263017b3.5.2025.12.28.14.55.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 14:55:43 -0800 (PST)
Message-ID: <f7d3507a-a6b6-49f9-8881-d4b0e33bb1f5@linaro.org>
Date: Mon, 29 Dec 2025 09:55:37 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] m68k: link.l is only available with 68020+
To: qemu-devel@nongnu.org
References: <20251227210250.411882-1-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251227210250.411882-1-laurent@vivier.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=richard.henderson@linaro.org; helo=mail-yx1-xb12a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/28/25 08:02, Laurent Vivier wrote:
> Base 68000 only supports word size.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   target/m68k/cpu.c       | 3 ++-
>   target/m68k/cpu.h       | 2 ++
>   target/m68k/translate.c | 2 +-
>   3 files changed, 5 insertions(+), 2 deletions(-)
> 
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

