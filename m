Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278DACCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 17:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6uT8-00064b-Hb; Thu, 09 Oct 2025 13:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6uT5-00061u-Eh
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 13:30:19 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6uT1-0003fa-23
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 13:30:18 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b5515eaefceso1039699a12.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 10:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760031008; x=1760635808; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ROdeIa9mi4lfjO4SE76khyfKtLwAqnBPn1GAQHuZR18=;
 b=Cb8vw95UnkWC/Z5Y3Yzo1T+QJBNU2g7xr9urvAS932EBsqrKokmht9BkO5J4OxMceT
 T1sUzNj8lf+Gfd/YIsnMrM6xbT7WOSm9rfe5C3X9mL0rkk9MEkKREGYqqJO62lARFk94
 yAMVS+c/zp/9Cb0Kg36XBY5nkjz/lFCcsbNUf20RFU07v67BDuEmPz6kAtFtQrhHCRDY
 5hs9kYm0zaW2SMDi/633sciWvMblPxGZh4+BHBa6WAT7pdLH7N3VMZleuUpBLUE+fXQk
 ZRSh6RLR70AS+lYs1PVjpav+nHQUfmVynutXZ7kK2hcsF1K4S+O3DB6OglY6wUrNosCi
 XtSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760031008; x=1760635808;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ROdeIa9mi4lfjO4SE76khyfKtLwAqnBPn1GAQHuZR18=;
 b=CF3Yb1MXBJGkz/IWSDwJmXwm5ZHc8HUJTr2g0auNnbnjFAxioE3Wkpj46F+ds49HkY
 2eC3lfmx5J9n85G73a1aFoyPkxq21jmgOyR80B1k31K0OhK52tCuQkkcT94DHrgV8bcN
 7vq9Q4IcJRT1fFfJPsxBuwI6WL1VlRwOOrugENt/4oLHfBULc6wNttmPc0zc1E9Y5ABr
 p+LZJqGx+iL+/KwnqjqUjiF+e1HvHvzYpVEOnTXvOPZevKrrkowGSOcqtU0pk9HwAWfO
 7ZIPBYsDXVnayU5GYHFFh115oVj95oudcxIiZ2SJIyL4I4Q+cSjDJBFKHufAc5mJjudr
 Nrbg==
X-Gm-Message-State: AOJu0YyHEQsczcn86HUHjkfT2KEV7w2iFVSGb67Gw/HDzDr8btYrg3aX
 4u8N4guhZUzrRtbAtw8/3+kY4bPGERFROPMqs4HbYhvDt7gT9Za48Wl9jqkS4HOEcWIubIPRUHi
 R9zbPIMo=
X-Gm-Gg: ASbGncu5J4i8HxS8R6EUFTUyXyMgYf1mr28B9lUiyQmXrwA6qRyHmJ8tz6NkP0JBDld
 FIy4JHuf2wVM8oHmxwo4Re8RZpv86G6l1q2rrdfY31XTiaVuDis5aUbjMsZazmNpzR04ONlo/OH
 n2TXbeJRHSSG6tEVh6XvW0Z9Q9qx+4AcIHxJFFpb4YUECUsrSsnKIO+7JYr77MjxjTvwnwiSYCb
 wcO3x/VBm/368kIGarrzIRk5isYK3vUb7EVe9McpLb7acAddXZFPyhCpvFwoJb4ufKdHXF1OJdA
 Iyz96kReuJi3LqBh/ba3ACWOwEqKHgL8uu+Mp6SjOVA2iNwa526wT3fYNx7edQ8HJo3JOHIjh2y
 B9L431r4e3Ixk57pbv7yBKDHNKSctyOOoUGu4k15epIjQV0hw6Y5fZjMGba0Dx19+Vtp2NKi0Rx
 s=
X-Google-Smtp-Source: AGHT+IHQLrG+l/rvMW5h26s5IkckZpNwDKiGuNscUPJyjS05qMrZmAQihVs5RDEWrcMa0ZGPRUCsUQ==
X-Received: by 2002:a17:903:2d1:b0:277:3488:787e with SMTP id
 d9443c01a7336-29027356933mr108119805ad.12.1760031007975; 
 Thu, 09 Oct 2025 10:30:07 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f93b71sm34207625ad.114.2025.10.09.10.30.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 10:30:07 -0700 (PDT)
Message-ID: <ef968eaf-8197-4aed-9018-8f5b8987494b@linaro.org>
Date: Thu, 9 Oct 2025 10:30:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] target/rx: Replace target_ulong -> vaddr for
 translator API uses
To: qemu-devel@nongnu.org
References: <20251009151607.26278-1-philmd@linaro.org>
 <20251009151607.26278-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009151607.26278-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

On 10/9/25 08:16, Philippe Mathieu-Daudé wrote:
> Since commit b1c09220b4c ("accel/tcg: Replace target_ulong with
> vaddr in translator_*()") the API takes vaddr argument, not
> target_ulong. Update the 2 callers.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/rx/translate.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

