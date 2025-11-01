Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640B4CCF9F8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Nov 2025 09:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vF8GS-00015Q-Mj; Sat, 01 Nov 2025 05:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vF8GM-00014I-O0
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 05:51:10 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vF8GK-0000Z7-Lx
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 05:51:10 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b6d5b756284so716573566b.1
 for <qemu-devel@nongnu.org>; Sat, 01 Nov 2025 02:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761990665; x=1762595465; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vYHyWW+Hie06vDN+bJfVMNSpGOls/uKflgQ6lVEvTgA=;
 b=Gwn6zrMtAH0Eaa2yCxG5fOtB0k3XSV3mXQx6Rh6nT/u4PCwDU4dOqbCZWHR9+0Ijhr
 HLq18/lnzLGtHFNL2Y37yciN5Kt6ExX29tkyhQpYOQsoP9lLjfrAcWU20HtSJmSzOKF6
 mbRWhjsfxgtj+aWT5N+t7H8MNQbOPAVkrmR3Z50K3OFfq5XAZDeHUHNb84syOV9Uozc9
 6hcw3Y4om5mpPR0osP9JtuMxmhWpTkBLrt71Zph+BFNLTEQecbQE7pS1RPVjUoxObdeQ
 HDRO69r/N45cb8Cx+lGcGnPX/hMhuwo0W8ZDjiUmGIy1oLyxHOLJMVmp/TtweNpeN0O0
 hDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761990665; x=1762595465;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vYHyWW+Hie06vDN+bJfVMNSpGOls/uKflgQ6lVEvTgA=;
 b=tslQaR6b886+LVO1L6ULrS+yykZsbjfzVkOYdQNu0G//tIn6d+5vW9CH+vheJ7Q1Ub
 8eaRAKv6Ehe721/mejIfZERCrdW7uEfF+luMt1Tx6shvEw04PuFxW9evA3AzxOlqwQK7
 DTUPYrjHOFKXke/SdgQgcNjtzTghVR5sunoV/gXnaP7eraVpLCibybCZZjEPqFCuV1xJ
 zrFGLB9RkHKasQtQ9xKk6d0f4kwkm6bwDf8qJMLSNICKBWjdejAXQlXEX/sxmp1BfGDX
 HWNqnbic62ZiM7HksW2crLBIF9vRBncdgGo6fW5qNF798/A3dHnIyKMnwqe1ZM8UmURB
 WyzQ==
X-Gm-Message-State: AOJu0YzC3wIGhgE0Fqv43XbbQHl/JZDDTrju3/iN7W5T38DmBeIW8tUm
 hWHj35NGJp5Z1Q1XL8vsQcYWPpLcaJQ9co6WaGr+cLSSN7V34iPR1c28aSg2qB/3FIXQZbl5kSi
 RJ6eV4MY=
X-Gm-Gg: ASbGncvfZ6usD48qIIe/c/iTNkVn69P6sPggndmer64BrTqD/UGiQqucxX1wrfaR3bL
 5O7x0WucswHMPtMfyIigjPRxOeNLqrhRR26PbyguheVAmPy3R8jVp4kLk+rv/gb1/nRH2I6CEdc
 oqY1a8KQvgHJRgeLOpMmQDNlLdlF59/6ZSVU+MD7WUpFBFqfFPExvUjCKpZmGCQ3pGRmo3H+ILe
 gOPzH0k5DsGsW7lGJa14tZ6OjrgOaYKq8ljEqOg0qNOyWrX/rrsF1QPmQF5+s0d7EMPDj5OIAxA
 wCg4UL2PF/GPAbI7ojprYX9hlDXsRv9SuBGrUXf2nOl7jGPHJvU0/tD7IzYQjt3IH3RRQqHtzg4
 KsgMM1KfcwpVv/KiamEndeaQDLLxt911hXro3XYdItiCon47GyyK0JWmBZDS4aAFi2wQklBeAGK
 yuKqTVyF072lDlKF8XlZoTVrRisM8t7Rh9XyYoBKUOsupjEmOkNWzk6jqeSPExlw==
X-Google-Smtp-Source: AGHT+IH3nBgHPjEgldRtfzAYeeMRYnppZSgbMJ6GmR2SM1cDwS5rT6zL13r6Fax8M48WmJEYCIJQWg==
X-Received: by 2002:a17:907:2d0a:b0:b6d:5bc1:4859 with SMTP id
 a640c23a62f3a-b70701b109dmr684868566b.29.1761990665552; 
 Sat, 01 Nov 2025 02:51:05 -0700 (PDT)
Received: from [10.240.88.227] (C3239BBB.static.ziggozakelijk.nl.
 [195.35.155.187]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7077c3ea35sm406657066b.34.2025.11.01.02.51.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Nov 2025 02:51:05 -0700 (PDT)
Message-ID: <58198cbd-d88a-4a0c-9681-b97c75f4c730@linaro.org>
Date: Sat, 1 Nov 2025 10:51:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/3] Misc QGA improvements and fixes (2025-10-30)
To: qemu-devel@nongnu.org
References: <20251030131237.181588-1-kkostiuk@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251030131237.181588-1-kkostiuk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x633.google.com
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

On 10/30/25 14:12, Kostiantyn Kostiuk wrote:
> The following changes since commit e090e0312dc9030d94e38e3d98a88718d3561e4e:
> 
>    Merge tag 'pull-trivial-patches' ofhttps://gitlab.com/mjt0k/qemu into staging (2025-10-29 10:44:15 +0100)
> 
> are available in the Git repository at:
> 
>    https://github.com/kostyanf14/qemu.git tags/qga-pull-2025-10-30
> 
> for you to fetch changes up to c5b4afd4d56e9c2251e6674d8c9ae530a923ecb9:
> 
>    qga: Support guest shutdown of BusyBox-based systems (2025-10-30 14:52:57 +0200)
> 
> ----------------------------------------------------------------
> qga-pull-2025-10-30

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~


