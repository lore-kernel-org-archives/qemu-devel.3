Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CCF9E93812
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 04:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC8co-0006GM-J5; Mon, 13 Apr 2026 00:10:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wC8ck-0006A1-Ai
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 00:10:10 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wC8ch-0004XP-Uh
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 00:10:09 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-82f22f6b0feso560919b3a.0
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 21:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776053405; x=1776658205; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ktW+sYHlOxY6S6tKtBlesqzd2Xsa2EzYvmz+6Vk8FNc=;
 b=T12MSaHvU7540esUC+KKD2b8ZgNEjTlbzabQKoJL91tx2K8kHa6S4E0dl3Zg1Ggcb+
 QjJ2uAPo1+m9XhJOidc3JKimjUuu65dfuyNicI5G7sNaFaGQx3F0jez38qK8u6Y3JjzP
 O6NpjrM1qvCOY09AvRDDqufGr/Yk3gdiyw5E4fHl9r4b44BQAWLgSojrL3tzafUwwzTE
 McCUQKqiZkgQqjZKGtLShjGm9ZV5VT1E+qjbjhnA5DhZ2Hqgje1hhELFJjTnFHhjktOj
 Noc1QEfbZMvhyDwbYjkkOANlH2i8AD7xBqCX7USvDH9KwxK6FQQ+rYPu8Sk0tNsj2wYx
 3K2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776053405; x=1776658205;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ktW+sYHlOxY6S6tKtBlesqzd2Xsa2EzYvmz+6Vk8FNc=;
 b=bN2Fyzx26OERjUqzVYKPhHWFqM1Fafo2sXaJW/on7WlWuntFl34XcMlhehDXHzDGeH
 VWYHAgg+dic67JsYSE8bBTNs3QnWgJ7oXq3X8niNBDkSg8goV7z80izndbgPKejIExe9
 VPjJzQEK96YS4Y8l7tPRQh66bP0qbGVj8MvA+qQqN+k4ILZkxNtXfLmiijL0ATjsHO00
 VnzDkpIOxNspWIhQScFM6SKHr658o3TxIxgSjcFgQoNcL+xw+kw/QaDSVs3YGme89Zi0
 RIFuwA/lCCs4AxZsU2UfvZZwgJ48rrxzw9760aABQ0BGdySSftMsiVsIPteLszyQrNXo
 0/Vg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/wPb0dystDpvXVZvJ6Aw4Ql39OSujll0PKwR/D8X+Nh14yugl5Yn8Q4QT/iSn6QDIdNlEsqDVBINX4@nongnu.org
X-Gm-Message-State: AOJu0YyAuMPFMO2rC6+DnWLaH+HDe1lZ14i3w3k/+rKb8CbjnWULZDF9
 lO8Vy83AvGf9eYhjvoyBW4PmvoPrpZ3JCUcyhA4p1Iy8vHouyY6gz8uKMUtJ84Cjx+I=
X-Gm-Gg: AeBDiet2uvYA9LIRSqFMDrO5lO+pNpZkSzLw+tPHxeHoXoWhYvSg+BewK61KNGvWidg
 ajg28doW54uI+ymmwoVDDrBE7/0dZwm2qGnY0MkvoRDrU3bj1Luy722U6u3LW/rXx92zxYlS5WY
 e/xMoli9/BFHFof/y959fFeQ3FdD7nKpLHAaGNJIQPD23jEMAsKXJNLH/dNWYDoGWhbTcZdiUo4
 tEKzu2kK88soZL+8N2QT0zS93kHx5kkXaH73dwUXDN8GCI3nHqbg410gg8deQUAMImwyegQzSNa
 RzQ66Abkuvd0l7lvS9hoMcSaZR2wi/IpL6nHiPzgF+qyucc9UrI5ArZrNQiW99C6fNHgOMNB88Z
 r+95wtLX95kquddJMiKCCVJiQEos7SXSWAlqJGsYjGPf0Mn3GYe3khpOYHwhBR0CsLbiWaTCemS
 zNndkj57k3umPIAGJxVwAf8LYlPddC2m7LzHSt6u2Gl+DAGnGiO58BJVq7h1njZQ9uz/kWb4UnR
 bOsS2N5icRZqvunACT1/0ib5z5YJ+hwOI87lLTw7DvIwelHmvl8/jA=
X-Received: by 2002:a05:6a00:6c88:b0:82c:212a:a9b5 with SMTP id
 d2e1a72fcca58-82f0c24e1b4mr10032057b3a.36.1776053405138; 
 Sun, 12 Apr 2026 21:10:05 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f?
 (bg30dj032xp6rdh0yngy.ip6.superloop.au.
 [2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f0c377318sm9262190b3a.26.2026.04.12.21.10.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2026 21:10:04 -0700 (PDT)
Message-ID: <bbaed291-ceaf-4913-a9c2-f17c635b222f@linaro.org>
Date: Mon, 13 Apr 2026 14:09:59 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/27] target/riscv: Register target_get_monitor_def in
 SysemuCPUOps
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-13-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410195323.17937-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 4/11/26 05:53, Philippe Mathieu-Daudé wrote:
> Rename target_get_monitor_def() as riscv_monitor_get_register_legacy()
> and register it asSysemuCPUOps::monitor_get_register() handler.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/riscv/internals.h | 3 +++
>   target/riscv/cpu.c       | 1 +
>   target/riscv/monitor.c   | 4 +++-
>   3 files changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

