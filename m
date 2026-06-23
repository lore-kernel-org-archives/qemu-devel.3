Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1327CCDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 18:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc6Hw-0007lu-Pm; Tue, 23 Jun 2026 14:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wc6Hp-0007lU-CH
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 14:55:55 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wc6Hn-0002nB-Uy
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 14:55:53 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-84232e83ca9so134268b3a.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 11:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782240950; x=1782845750; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aAJPV/Hs2vK6jVQiOy5pyY4IPiRJzraRE6SDwv9bFXU=;
 b=O8Oj7myzsoT7N2jBxLwe/IkPXjsu9ReTZB47JfGREAIVulUdyo94c7UE3Dv7ahMfaq
 JA5/QBs26F2ug1xz2WgzTDTWD0jHlGKNCJkgjAac6D8QHXpELEwgAeg2erRXKeylJbHp
 yVYVDnAFIKLPfkwyVVndkuOgKMw7NESJdzqPiLrk4YGKXi7yCnJGwc9tL/gyjAC6vCWD
 j8ZOn/bYcLwsRZcdIpR/dN1pnMXXmruDwXc6SsTl5ogH6MReMxQxzCRdmQ8UKdzNdyYR
 KPuAk5bZzIGCj1appALY2F//MOlmOnoNLmN/QusSGoPFe++m1YO3Xu+uO0iPDj51hWTC
 p3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782240950; x=1782845750;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aAJPV/Hs2vK6jVQiOy5pyY4IPiRJzraRE6SDwv9bFXU=;
 b=HhDPrLVdUthB5/GeebpXoKVbuwbiVmJuHDm5Ig0ZP+KnPtOCbt4WJzTj65qtpWf8Mh
 xPzx/jMihdCVs+UPgaVjwvBe1ox3wyV8z+2qwZfEi2FYLaR7R6k/cxXThOY6ccKApUkg
 cbXrJGMAIjBqT1Aqc7IEUE6nCUyBECW1t9e0r6AlAr9mjG+WIbJYB4QVtR4L/7NIM880
 TUcNyLLvgX4LNXUMqMIGOUK+MTa+PnPyl0zl5CnG0RogLVhnyDyDbmZS9gDk7QaLTEbH
 hOAlX7i1PgX72P/IXJT/T4FMe2wSoWEQt332zPjOPLh8NEDoNfTAg5XZ4kSfGXgTOK0r
 p+gA==
X-Gm-Message-State: AOJu0Yxgs6REq/L5iLEYGqXGuZrXK4TKwikGhoYIhTycuSMDI2X3mCIz
 N0PJFyNnkMmizkMt/FxoW2SnUsk1aRWq8KsJlpJZpH6rl65E6i6ecCSBWgZEyhl1F+UAyJMcxqE
 CXYyp
X-Gm-Gg: AfdE7clHcxKGWAlBXpbg6NYydFchheEKLUueNyQe3bjyE+nQGxH9Ppdts9/rIyQFr/o
 1v6k6flXTVPhGeu+a/Qj2a5D7Gqzrzn4j/pTOmt8TxkbbYdJBOsr5mwM6zaSSUNevu+iqm+ZGB7
 yTHu+JD+fYVhCCHzm2JcxOed7flGDcgugnjMrAYHLY2roDhviCT87KHItRgVdyGK8R6RxFU9MLV
 mD61tdTqXZv8Np2FPH7/jVdSlSusQMfAFzG9ptGG+7bMYSoaALO7TNVRUMxmWfJ1VPfUVNwPEtK
 bk/ATHmQGb+eqCqMXXw9se0epuTbUxpBXWxn4ZlhFgt7wpw/l7TiW8Pp+JlocTqPIbtmwxtSpQh
 PQPd4CyyzLON3fbHPT0bOEtz9GHPyDEbiQk+K2f5MfJZeoDp0KfaPf2CPPmvSBIJmobatkQxzIO
 UYkWD7lAMYdopJ5Yor4V1e0b742MFR6geARxa3VLO8/nU8KOOz5WPmQN3DqQ==
X-Received: by 2002:a05:6a00:298b:b0:82f:776f:a78d with SMTP id
 d2e1a72fcca58-845952905ffmr5038557b3a.19.1782240949551; 
 Tue, 23 Jun 2026 11:55:49 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84564d8dddbsm11503792b3a.19.2026.06.23.11.55.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 11:55:49 -0700 (PDT)
Message-ID: <915de382-7df2-4dfc-b83b-401f8349c545@linaro.org>
Date: Tue, 23 Jun 2026 11:55:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/40] bsd-user: Add file operation system call dispatch
To: qemu-devel@nongnu.org
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
 <20260620-misc-2026q2-v3-10-f6ce23ad8dda@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260620-misc-2026q2-v3-10-f6ce23ad8dda@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 6/20/26 21:19, Warner Losh wrote:
> Wire up additional file-related system calls: poll, lseek, pipe,
> pipe2, swapon, swapoff, chflagsat, close_range, __realpathat,
> copy_file_range, and __specialfd. Also fix __realpathat to use
> __sys___realpathat on FreeBSD >= 15.0.
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Assisted-by: Claude Opus 4.6 (1M context)
> Reviewed-by: Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> ---
>   bsd-user/freebsd/os-stat.h    |  8 +------
>   bsd-user/freebsd/os-syscall.c | 51 +++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 52 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


