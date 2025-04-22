Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2AA8C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 16:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7GwG-0003XB-Hw; Tue, 22 Apr 2025 12:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Gw6-0003Vq-Uo
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:57:32 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Gw5-0002oq-1O
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:57:30 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22928d629faso52403935ad.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 09:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745341045; x=1745945845; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oTd28yt23+BdUjdhMJLFrIJ+2S8YGmhUSqzebQk08OQ=;
 b=jR1l7HrdLqJYtQfVe3WIAQ6RIOQOjJC8BXK5LwQCVjHRC9yKDrVI+iAobT2yHgsFUq
 ufdS3MhR+YKOFXPacVfn4VotFHu098a2l9QSL2cgaiPBL+PQxzL2BrC3X/kBTqbkzu4d
 W0CQO1CwobI9WhMKsruOBsskQIbXe92tPfxYAA4skRdIhhHi63v9fshjpKDlPYoWKERl
 cjMT0ISgnwWEZrKb5CXYmCLlwIVk+52roN2GyAcJMzVyWhM7P5pKbM/1maAIaMVAWzXA
 Sakthmvoy0mqHHNUgZkJbCyo0IAZoCamgdb9+uS7anxiFHMmcO+D9R6Cv9TJ0iByRKa3
 GHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745341045; x=1745945845;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oTd28yt23+BdUjdhMJLFrIJ+2S8YGmhUSqzebQk08OQ=;
 b=AomcMFdxGvZEfVdHgyEvqIHq4CjZ7fFcyxjXRwQhMfxQMxRDwbwdhMxDedC2d+Af5v
 qGmAjVz4ZVoCtAo8H6cDfcShna7EbuTybrsPqC+amt549Cntr5b39OO62zqxAS5v+dY6
 0JiWy5kVC+xxUN1SibbY9/cb4fJ4WoyPaHYvBpzOBC9EvYkd4oLIuMLCyKIsw002VmUb
 85SnEJkr3d8ThuKibMLds2ntOXdCjJuRRU7qoEYr/pW9rMc7ezU680uLfbilC3oqwhs5
 woWUKkaQzMw5jthZ8nuKSBDvt6Ebxh5mISK0/nemg+3o3aam79fzN98/k6/jGRn0rlek
 sAtQ==
X-Gm-Message-State: AOJu0YyYfdofwc9QUD1hgpsm6+Uh/XLk8xShlCv3gYWkN7CSl73udYQj
 LdmdrxXr9HnUcmODjEQDhVThsG1EgaiUBaLG84U1kodrwRtHXXevy3wuKpTOsQds/gJAqQdbLqw
 G
X-Gm-Gg: ASbGncvi3ZUiDd1a4bnnD2quZkwbDRZyaB2binob9ff65Mm/r9ymwTtQUa/foOIz1GW
 GASc25XgN15BLgXhYT+D603MT5fl5MnZrXrNsJt/BhGBRLaHn0eir0OFu7ygGkBVQtzR41EXIT4
 iRC0c4U5fnaaLnYxdcsmFWVJCZUdzyfZGCvj6WBBuFSnZUfRtV/zpVjoWzOzpVbPUU+yJdCJiAf
 VITv1oKby8SZHDR6m7GCtYqoWbEwa9HLd6bSMJBdw+LxDacAFtozpNwCqLBJ9yBNUd10G/lLyou
 YPbrYqJgRvBW+T2pGWCNxni1tcE0kiGzA8Z25oX52DOki958d/ZGkY43xtDSxNBuSL7VGZg3E68
 gIq7HyZA=
X-Google-Smtp-Source: AGHT+IFUC8MWojICrU48zfF3IJkvJWNxU3kOME628vxAPnhRgzKc1V2L4OLHxXmmxXmj5HbBTWdcrg==
X-Received: by 2002:a17:902:ecd1:b0:226:5dbf:373f with SMTP id
 d9443c01a7336-22c53379f8amr250067995ad.10.1745341045430; 
 Tue, 22 Apr 2025 09:57:25 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eceb74sm87157235ad.166.2025.04.22.09.57.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 09:57:25 -0700 (PDT)
Message-ID: <c845e82c-5e53-4767-a064-8380ae470f14@linaro.org>
Date: Tue, 22 Apr 2025 09:57:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] target/i386: tcg: remove subf from SHLD/SHRD expansion
To: qemu-devel@nongnu.org
References: <20250403092251.54441-1-pbonzini@redhat.com>
 <20250403092251.54441-4-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250403092251.54441-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 4/3/25 02:22, Paolo Bonzini wrote:
> It is computing 33-count but 32-count is used in the same TB, so shift
> further by one.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

