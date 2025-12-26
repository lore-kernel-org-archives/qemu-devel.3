Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DEBEE8FDBE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 21:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZFkS-0002tm-5P; Fri, 26 Dec 2025 16:53:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vZFkQ-0002tH-1C
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 16:53:22 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vZFkO-0001q1-HN
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 16:53:21 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2a0833b5aeeso101569255ad.1
 for <qemu-devel@nongnu.org>; Fri, 26 Dec 2025 13:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766785998; x=1767390798; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wu9p1omgNkyltOVs7Gu6sa48lMbFXukYjvdOA+PYK7c=;
 b=NgDBwbr50Rq52f3uNummxuglz9AvBDf16LAYfLKUqdN6ZqYwBHJlmE282Xya1ot8vB
 MXMPLIYxx+pi6wTpDi7bEy+cgOs4MIyU1NeNjzGb9r11qQowPIHJAWW8JUYIpgEN9jt/
 sEig0tHdR4CtOjtF9G7qfEF8l19oOUH2Jvzf/5wpjEdnG+8eT7+ez7qU7hYhn1ixBaVk
 TnmiCe98JgEmQUkrM8NT+QttjZJme5osWumPjjK4b2PPMb7r4ec7wEpAiCrCok8efrF5
 oWsCDYzMWi+rg9lOb2qfczLOj7FY99FjU6Bfcyz/vTDMMJ22I0C7vHqYwdn4CYJbkAEw
 z2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766785998; x=1767390798;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wu9p1omgNkyltOVs7Gu6sa48lMbFXukYjvdOA+PYK7c=;
 b=MCIZMf8Hv4H1SYRYl54SyoYttgXFhXc/hEI10MdhpfLlaW3GWKtiev1pxiw+FP/xjw
 bNQB25LiMWjq0uoBHSbF/4M4lXfZXXlcTGTg3+RwXEnICuZKYwu73XbkIs5cZq0L+FA4
 sP/tYT/xaX6OoBjn7aheUpTNWBW4Wl58k8OQqrET9T34U94QwnJlfbiZm1BcTehkeDOz
 RqnBE7CvzDkS/N/fZ18Y6e2hl2213kFzHsnVhDZBnpMSVGW2KmkbQUE/QwvzgMVVKW6/
 RdZvI4qIFud/4Iy7+ZslwIGwNZs6tANKOD9/AQK3td2X4Vo685Jn5lqz+cfxNLJvP9x0
 xgug==
X-Gm-Message-State: AOJu0YzAsNAFQutUQ26PSppLgxKCbxBHvwxOJitafR/lRNsZrHz76XX5
 tVDfZbJCVro2e4KZMrVZLf++d4QPNqEut1+Z+UwjIQxkQ7WHUsYnJW2iRwd3aF8CmWRHwr4KaMo
 6dOqDXwI=
X-Gm-Gg: AY/fxX7//XvBiH9Azk1re16nskSjNrI1ueiNdZ3XnZeaP/UkETp4lU3fymL29p3+dHz
 I1ekJky/skekOOJ5OTCYbxW+vXzkCyeGWZ4y6nBtXP0xjLUIjiwQKjiyWb+H0MCHYX2qs5ioBaz
 yZdc7kk+eN7sMy37sqISIEvAZGHgz9x7NBAT3/VPAKkzVQKNCMt213klNy3PyO5VrywUcmmn/IK
 qxuM5pgweINOrwYREa7vWjvWeGvcek/kFeyTHh08jheQufsGhtPaTTJx0DYvFjdliNPP8r1drdN
 IxmY85LYQ3hA09OHWxCxA5ZNv8XQfY76toZr9S0wl/GNOJkdTPTdudjNGVtAhrP84aREU3OPXm7
 FmiGzqScvXO+fjNwWBixEWg5GeW8mBudBzfQwoqig58lmiuDqA1qavuDLs7z2jKfaBS5znV+tT1
 OjUog9mNyls2UHhymeJEQuN4C1CwnLwj/1onGSlyWQnIwwD3vPXdATYjlZW/A19KUYzRH/E8nj
X-Google-Smtp-Source: AGHT+IFeof7hfWo7/LDacNEKKMdwX7bO3adFSeBz7Bsp5fb7QxW3ziBqBfkqByOLETyPvAZYJtwe4g==
X-Received: by 2002:a17:902:d507:b0:2a0:b06d:1585 with SMTP id
 d9443c01a7336-2a2f2836801mr269583305ad.34.1766785998450; 
 Fri, 26 Dec 2025 13:53:18 -0800 (PST)
Received: from ?IPV6:2001:8003:c017:b900:974c:a93e:48b7:5aed?
 ([2001:8003:c017:b900:974c:a93e:48b7:5aed])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3d5d407sm211266305ad.72.2025.12.26.13.53.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Dec 2025 13:53:18 -0800 (PST)
Message-ID: <631ab629-6dbc-42da-ac71-6d8f9480cb63@linaro.org>
Date: Sat, 27 Dec 2025 08:53:13 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: add support for MAP_32BIT
To: qemu-devel@nongnu.org
References: <20251226203147.1964597-1-jean.christian.cirstea@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251226203147.1964597-1-jean.christian.cirstea@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 12/27/25 07:31, Jean-Christian CÎRSTEA wrote:
> x86_64 defines MAP_32BIT which forces `mmap()` to return a 32-bit
> address. This commit adds support for this flag if supported by the
> host.
> 
> Signed-off-by: Jean-Christian CÎRSTEA<jean.christian.cirstea@gmail.com>
> ---
>   include/user/abitypes.h         |  2 ++
>   include/user/thunk.h            |  3 ++
>   linux-user/strace.c             | 26 ++++++++++++++++-
>   linux-user/strace.list          |  4 +--
>   linux-user/syscall.c            | 50 ++++++++++++++++-----------------
>   linux-user/x86_64/target_mman.h |  3 ++
>   6 files changed, 59 insertions(+), 29 deletions(-)

You can't just pass along MAP_32BIT to the host, even if it does support it.  You need to 
take guest_base into account, which may well place the low 4GB of the guest space well 
above the low 4GB of the host address space.

Emulating this requires full control of the guest address space, which we don't usually 
do.  Though, see reserved_va.


r~

