Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F552E93805
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 03:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC85Y-0000Gt-Ek; Sun, 12 Apr 2026 23:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wC85X-0000GB-4F
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 23:35:51 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wC85V-0005pl-Gx
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 23:35:50 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2b2429f98d0so24535475ad.2
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 20:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776051346; x=1776656146; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EO4dONU1FFjGxy5N7cqrcFKbf2Ahfi4yhxsvof/C7jc=;
 b=jlUBuEZVOS0huOIt42/kwobltIr6GEiq+cxZqwJ71iGzgbTaX2Re/JdgVBdD1mR2Lq
 U8orPE3UHHjct5r7KavkbAs5Kg7sJ6fwXzodn2RvH0iSyujz4WGyOvU+DFF9E8aLHacZ
 ISYG3TBWvQGH487qiulnu2a1NwezCWvc6m87FQFhWrBS+nXXjGkJR3dkP2z1/UirsVH9
 KGPtMqWdxAsa6Iyn9SPlLH150exQgvPPSOGITC8JM7SsnjyRyq28+CfldETJ+exSu9g7
 CijyE9a2mIJV/maBkIUKwhozgyzCowXUF67oFMQXTjMHGzFIHVVkDGY3+KboKheycNxn
 lfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776051346; x=1776656146;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EO4dONU1FFjGxy5N7cqrcFKbf2Ahfi4yhxsvof/C7jc=;
 b=TFZhb3Ewd4Jwvnl9YUpJOStdU8H1UIyD3/vhsUmNZMUN9C/nozOTWgkjNLolxhwa4y
 UsiOSj939Rz0av0jhHtqoKgOs4J8zai4/iS7Cyh1bFhL00Wnn72MSiT9AKSxb74TCJQh
 y3rDkkAVpy0hmBB+wf1tApxpOXvlvk23sJWH0XfFoNswX0s6HFVnyRMcnpfOKoSGy+UZ
 /JXJjUHCaPjyYYf4dQlsht7zB7pz/kCtrBUfLPzrSnLStLVLu42UStAiEKzib6SAaArq
 KOBodn922a9uD5Vpm2LedmrH+ccIxq/ic84rThlpDL0Zw86Zl5vUkt1+xcgSsPyFHhHl
 bVUg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8g7XD7WdT2aBb/nG4p8e7cdYZ3umj+98JqcHmIUtKN5QDnKqM8MB9TLtvlvWv5Ioaftt7g/kizrpcV@nongnu.org
X-Gm-Message-State: AOJu0Yxzht7jmmmxPq8KJAXb71BW5T4woJRHMjKUcRrsAm4F3lznz/Fs
 00DF+QOesmDi/dsRyIv/fnb9kQ/z/8LwtWNcHoFXn7vNboCH1t5B+2Iqd9/dE15PO/0=
X-Gm-Gg: AeBDiesB1P3qeo5KwB4tDNUim2zRqoQG++DKRSPI4UlG6p0XeR0qxHPplLLJC82l0fI
 GLd2CQCLZjQh5AIdu+6hHxf0zolNSJySyAsFDfo25TGjUrulp/6KPPAgOnmb+kSciBbuwhLpsa4
 P+pckL34BHrgo4WCqDGJUtul96+t9KtWnQBVR8PU7pc20iaZ0eRc2lWVGmUPZ1nX2XY5bRI7aO/
 qVBy0VjIo9HYN2nYI7//IHKbnzXoMxuKLtTBfxn3EfyMn3r1Fw83F5UWlwOz3rbBp+P4rUVlqKI
 IqGSHc8Fr2ciN/xmkb8eqXbkTByV33ODTFcq5GZK1HIk4hrsdolpmJL87fa75wCeGtX0n2iNfwF
 yGuhMhOx0Qc6CMIc0ace5laM7+UzKGr+CHQrZjX+p9/hDHUs/0kCkU9eiS3PQvOIW0lr6qYwJpq
 Pw3xEJ9jxWSQiuLqnjsOUgm7gnJQXVoxyxfHT9kL2qqHuVvrQQOcrTItk5pVrKRgwBnv06aHAxC
 Oe2hRK0EYoEzg==
X-Received: by 2002:a17:903:1207:b0:2b2:49a7:a5bd with SMTP id
 d9443c01a7336-2b2d591d9dcmr117665445ad.1.1776051346235; 
 Sun, 12 Apr 2026 20:35:46 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f?
 ([2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b45f6c0219sm13597015ad.10.2026.04.12.20.35.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2026 20:35:45 -0700 (PDT)
Message-ID: <8b5a596f-1bc3-4a9d-bad6-c21144ceeeb9@linaro.org>
Date: Mon, 13 Apr 2026 13:35:40 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/27] cpus: Introduce SysemuCPUOps::monitor_defs hook
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410195323.17937-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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
> Allow targets to register their legacy target_monitor_defs()
> in SysemuCPUOps; check it first in get_monitor_def() otherwise
> fall back to previous per-target helper.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/core/sysemu-cpu-ops.h | 5 +++++
>   monitor/hmp.c                    | 9 +++++++--
>   2 files changed, 12 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

