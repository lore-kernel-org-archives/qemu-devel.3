Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65AC0D262B7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 04:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viQ5H-0005Su-Vp; Tue, 20 Jan 2026 23:44:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1viQ5F-0005Qv-Qj
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 23:44:45 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1viQ5E-0006ob-0v
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 23:44:45 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c0c24d0f4ceso2187020a12.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 20:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768970682; x=1769575482; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4zx7doX7UoTngoxwG03mZXvl0zEiqMmCA9YlOsTrq0g=;
 b=S76wu8AEhcahIj3XqsOkeeoq8U4TzTyvOw2rO6S0bWx3D4O0oQcPAXdQfliWQAQKQH
 92O8SJGGcveJnCy7Ot6qu/b2c9CbnA14Mcmg/txgf77kbGnbqPQ9impzJFab/BbiL2r/
 5fuoOo4sjAvTWFpb/mmCvd+/z/avT8Bv5pQlnF7HAqbc0VVI8cHrtCg4qG2029PG4qnf
 j4dpsOr0+cuGXF6b2WhA0vXDhp5A4HJFGxSoEk5PZgk0uk4M8VtuqvO0SI7q5roSMZ3s
 Xu1DzZjFZwh2R0y8h1T63LgmYgTByR+8zmmh0m/XeobroRd667uKGsQqOQGWflk/VH6e
 X0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768970682; x=1769575482;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4zx7doX7UoTngoxwG03mZXvl0zEiqMmCA9YlOsTrq0g=;
 b=dgp4AFhDo5IXTY7OK7iEABRa8DN5Dwz3+7ISfH+wsE9yPqGJH5jcYI4KsHOyRsMQAW
 H7atylSauCiBDh8s/Pz12OpX/cz3P3GbCLFAoMOJJJKQhmbfUtGcDXClQ4EUChVKUoQH
 X/1F1IiB3zS6LpPKdvidQWtqjbof/L3hHXIWbkonYYVPs+6tAEZiWY3AUUwaCotGqZ4u
 S8ceQPJdIVKEUCsEn0NI+NYQJA10RlPO7khXtXbHV3gYzCj+BEG6WqVMSQj68YW9aUQr
 o8dFou8xIkEfLE7gB1aI2sWamQux081z8gIQED/tIXuYqYsEcVviiFeryK5RMEnX2i8d
 IEPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoFnJ349umtf4ga33ala0UqHJ4zLMXyBKvZWhYqNk4WYtu750lZhdwXu5aSC+pW6p9VWx+2+vp24JH@nongnu.org
X-Gm-Message-State: AOJu0YwwdTFzORf/XBmOoRnSwsAmA5Hd7HfvqeO5zKthdAJ7uzkhiDea
 qAdrfV890WRnFuyvs1m56oAgxGzN97XcMi68MV0B7LZ7yVAASaVZOawxnw7OqXzOaq0=
X-Gm-Gg: AZuq6aIq7tZiIY7BaSQzuU46H5eeYPMwqBvpk10Fr+o4WkxGHuPScPMfZ2KaEq7SXmC
 41jxAiFA8nFfE2KfhdCaWEMQeQbnQZQeE4rWm0dCba544P5yx3dJsICD5FN6HNMEBstXCXot4+U
 fFTh0WO22662pFdkvglidlpJOkfdss0nCaH5t8XTbxxl1M/mgz6oN6cLh6lrMX/xyeaXo5DCP/E
 9VSZPbVaa8uTmTYXuLuS2DOZiaJtJKPu2Zu2cx4sujGWhPKZY9R8ezBPiG6nuobkLhKkk38zfuh
 7g9vIKBGoqr7UQvEaCBHdVDodGojYEJJk/RuN92T3qztyrswgTlIdpYKks1O99gkr/14Wa41KMU
 x7vR4tQ4DmgF0PSwPSKtQa+V5xuqGBkEBY4jC3d3HvmPr5whWW0gDYlDyhMwrA4ZVSFD5H4ip4Z
 XRa1cLU5SeDAhR8omTkLRqaiI9yyo3yg==
X-Received: by 2002:a05:6a20:4325:b0:364:be7:6ffc with SMTP id
 adf61e73a8af0-38e00c029d0mr15784224637.18.1768970681667; 
 Tue, 20 Jan 2026 20:44:41 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa108b21fsm13595345b3a.13.2026.01.20.20.44.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jan 2026 20:44:41 -0800 (PST)
Message-ID: <ca79d5d1-2e7e-47ea-b695-c2bd67f5e78f@linaro.org>
Date: Wed, 21 Jan 2026 15:44:37 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/10] Trivial patches for 2026-01-20
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20260120123107.2255178-1-mjt@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260120123107.2255178-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

On 1/20/26 23:30, Michael Tokarev wrote:
> The following changes since commit 38879a667fbb4ef54c70de71494882615f600a64:
> 
>    Merge tag 'pull-tcg-20260119' ofhttps://gitlab.com/rth7680/qemu into staging (2026-01-19 09:04:31 +1100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches
> 
> for you to fetch changes up to f0de58ccf6566ad5cf04948788f9b0cfb8b960b4:
> 
>    bsd-user/syscall_defs.h: define STAT_TIME_T_EXT only for 32 bits (2026-01-20 15:28:21 +0300)
> 
> ----------------------------------------------------------------
> trivial patches for 2026-01-20
> 
> I'm also picking up the STAT_TIME_T_EXT fix from Pierrick
> (not resending whole series, just this additional patch)

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~

