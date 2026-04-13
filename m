Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60835E93812
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 03:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC8RL-00033q-5i; Sun, 12 Apr 2026 23:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wC8RJ-00033h-RK
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 23:58:21 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wC8RI-0002Ax-9u
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 23:58:21 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-82f0884bcfaso2105632b3a.1
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 20:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776052698; x=1776657498; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z0f6WZDT/cNKtBGb7vSpgqe9v67QRBDxx5Wvbsnj+fU=;
 b=eluorMFkW5Vd+C13LCeI/IXXsSzDzqy9ofwtHlhMDOse5fyx3EE4dhzcqoumcCoQi/
 +bPh4tsGcQu5SvoLT4ZQjnqh2F9HAkX7vBUWXiBsx2ZBu1fKqH5b+wGSfFKSfRqWE+cy
 cteLGkrtv2WNvLpwWHlJ7DTghE7BKDyKMmJ23OsqAtOhBUxDBpctuUnebk8kJsWNDtZK
 D+ZfP+2LLMVZU8An9bYdFSmZYUvCH1ScxlYxJIgMTfYuHflMVL5lZWhBcAeQXzMZXjm0
 oTzcrXn55HPz5RziFF28wZZgiGuXrSElYqViEuxjkS3A1V2wkAuutNZ5pPgENtTTs8SU
 S7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776052698; x=1776657498;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z0f6WZDT/cNKtBGb7vSpgqe9v67QRBDxx5Wvbsnj+fU=;
 b=fxHaHlaY8wyYPK+T7nyCDKHROwwpv1psWu5wADdVIVt/VAqEoYqwoxtF3x4HvBWoSs
 HnvVT8Vm4LU0qQES2/tCvz5XtLhF/ZS2S3JkrjL/XtPx++uykYyo/GOxiyqPmtfDn0ep
 F0Humt2DG2xNYqtXHaEt4cK0UokthgGbS1qzHQsmAC0bBkkronC3ALpJ4mkuGO+DV7nO
 ybUgokhYM3auxvni/MVbeneRhSdLk4hK49s+4KhlrNjjMQEDPaOf+NMxCpPQnnep2ALx
 Zo6jsZnHO09BqEzGxH9riDdTMYa/0BOlgX24Me4goy25P49BmGvXehh3xDghrp8we75x
 VQdg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8kMrf4XlYFJvOr4QqkRJoJEjped5tkAKLDiglvxpVFFD0fFFBvv4ElRAkCwqgduiPsDv74gE6K3+/s@nongnu.org
X-Gm-Message-State: AOJu0YyfNwwedlVzemtKyZyZoRI0nBIpIvc3Yj+ApHx6G+24SL2eCsMt
 xABy/SSK4dmbDAgvUjDAjKU8UYDazmjHau1+jYq3uAnYHEgLkMhS9ip2gClDUyFgMBo=
X-Gm-Gg: AeBDieu44SFPakI2bRksJm9G9Um9uzP9mAg/gkF9wWPUaHP9hIklbTeYX4vH+nCZOJm
 ufxyT8VxwfWzYuP2kOEzw/3QoSIYv1RWfp/r7Y9lsbmnc5PppH2AvGEG+YdqbjZoOL4fnKq6/Ur
 e0DmgLiT+MIMbxqA3rgzZyH+BNI7kSn3cMwHjfQnyoLCqOko1i2k1QiLsCLM3Ps2aHH7Q8wlKEC
 mJgz/bLLFCX6fFCAisat6Tl3P5fJFhHJtTJ+jIerO+9ZxEGxJdMLuMO09ykp6zzQSGE+4iihnlG
 Bo21/s1nvLz4+CniueQGx9TcWj85+YPTDp9qQ0qJN6GHNBdWxpXPSoO8vxE/qte741QBCuay+qR
 qG4WMKCekXhS0VSpWxPMRRFbL4ouDMME5xlVrAsvMJVXH3u/jIq6mSwutHFiOR7j3oDYYEMzD1V
 /Kl4BrRh3RZu73+21wln9qX8vd5sryS7pFLEY4oJ6Y1iod4/6n1v9G5Ywy4e4sm38x3Ed4n5BNg
 t1DDsJ7ZrLQiYqbt6CI6ADTERELrizL6TloOMw2cskvDU9rtIqXIqA=
X-Received: by 2002:a05:6a00:f99:b0:823:9c6:1985 with SMTP id
 d2e1a72fcca58-82f0c288c79mr12179207b3a.16.1776052697989; 
 Sun, 12 Apr 2026 20:58:17 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f?
 (bg30dj032xp6rdh0yngy.ip6.superloop.au.
 [2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f0c33f2easm10869299b3a.22.2026.04.12.20.58.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2026 20:58:17 -0700 (PDT)
Message-ID: <0e52c263-aa62-4226-9963-6400f649906e@linaro.org>
Date: Mon, 13 Apr 2026 13:58:11 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/27] target/i386: Replace target_monitor_defs ->
 SysemuCPUOps::monitor_defs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410195323.17937-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
> Restrict x86_monitor_defs[] to cpu.c, register it as
> SysemuCPUOps::monitor_defs hook, allowing to remove
> the target_monitor_defs() method.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/i386/cpu.c     | 24 ++++++++++++++++++++++++
>   target/i386/monitor.c | 25 -------------------------
>   2 files changed, 24 insertions(+), 25 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

