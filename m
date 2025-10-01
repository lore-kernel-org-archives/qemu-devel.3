Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC328CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 21:03:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v43wb-0008Sg-35; Wed, 01 Oct 2025 17:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v43wR-0008Q5-3k
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 17:00:52 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v43w3-0003p6-1t
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 17:00:48 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-27ee41e0798so3775135ad.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 14:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759352418; x=1759957218; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wdmqQJ/fxdEIX4rh2+AlOpIkmX6/hbmxM7dCMfu2NB0=;
 b=Rrc5aNenQIm2iDYn0bDhub0Pg+CNe//OYlGn4n+pc5pjvYYTDSPPfPuVihrH9duFSZ
 HzwPdeg6iZs682pRQT7gC3Q/g+SSA7bvWpz/y/QUCRih81hIL2D/IZwS9bDjFY5PShcZ
 Ns0HztUirp7M/I8A5QFOAGbKzpvbexiW4xt9plPm8/ql8GB6ikpgp3V2pYMuFlgr3XrY
 iCZ2dLUBUjgEyHoxqqFc9oW0sHi7DAMPeiymuCN3dyTPBzsm9m3L7ykqk3L4j/5EPWkm
 YrUIZ+vK7P8bSMYRCeEZZ0bJ2Ok4x97lFnCteGNzddhqlbC2o5hunkzrNPTkOBJD+K09
 bZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759352418; x=1759957218;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wdmqQJ/fxdEIX4rh2+AlOpIkmX6/hbmxM7dCMfu2NB0=;
 b=YfHu2QDe40ADOZV7zBbZWel4LVFgHl8XWJpq7jgnWUeOgDD1skEoakm9tUtuRK5j5p
 GZgWpPBX6s1TEhqIT0X9O5aTnCJtUSLv98+T1s+skCIKgeAeo83mHBN59pVfmNPnGl7X
 P/lHGyubOcZp925zp8qEWRL8gwGMvCDoLGcC7l6LbqiVTHgeshiLclgEm1TR/VqCjsnL
 loszwy+L96UDks6wURh9MKAIU6R8LjCQQ94ooQARVcgsgWrVDc9btG7FD81H+DGgwNp4
 Sh4zI4kS/vUL3Dw3xmbEwyLbw+qAdp0WgXwpQuPNCREfgUZqpKyh6jP7GaBItKV/BK+F
 fadA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8lddOmZ2/lnS7wl8vmn3UmfQ7ZFjpQ6MmN1Ts5GGVjndy5GbEkQKbvoVLJ+V4wBwNRBUyi/HBOjHb@nongnu.org
X-Gm-Message-State: AOJu0YxUK2+XUb/M870DUCUiqnXYiplylcBeawrKl0l8lz4KXbjq/wbd
 Hws+CAEUEAY2S+WOQv9gS9unOZyzuGIu1FKlVmq3j21M/zsVVcYvkcYE+6ucmTjjd00=
X-Gm-Gg: ASbGncsX6mxP9W7RM/6i3VjGdH1fIOilKiFZYp+j8vRdq+d9dUuoPNCMhsWIquxXPvc
 YgGSA5SlEClLHoQ8u/n26fOYSq85HkyNjNEGd/PYhKGAsPId2aVsbq8D07BCQj0no9vi5p9DAZC
 fTyjvFUNkQ6X9SsSngRgjOCkQSEy/B3WViAUdV3gWobPdtA6RoeI7DDKOi6fw3UOexDHobgjld6
 NTDTeKVlq1h+o9blqE9TNlEa0kGufoI7xDklju5OHmUHXbGH6sE0/cSuFOyrfApUCDEybX9VrCa
 i1IDMonhy/zd4M+pic3x0YWfOL3jitG0jQB1VXmzVnwtewMzbBV4hz6FoOzM7GFaX7vthGu7pn3
 KiUAzWHFv0r0BmwSdy/d1mdCVDkC4CHUJaq54urBiKYNvKD/U18KmrdWIzsJC
X-Google-Smtp-Source: AGHT+IErvrOUdvMK4ALfqmyePFrbzX2oD6EASyLVjzQ975A7wSh3CdfpG5IAVfHOiiAXG2d5bGGMPQ==
X-Received: by 2002:a17:902:db0c:b0:268:f83a:835a with SMTP id
 d9443c01a7336-28e7f45526dmr57700895ad.60.1759352418290; 
 Wed, 01 Oct 2025 14:00:18 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6099f79832sm388387a12.49.2025.10.01.14.00.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 14:00:17 -0700 (PDT)
Message-ID: <25d11c62-afd1-4ade-8368-83490d7e3b25@linaro.org>
Date: Wed, 1 Oct 2025 14:00:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/18] system/physmem: Remove _WIN32 #ifdef'ry
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20251001175448.18933-1-philmd@linaro.org>
 <20251001175448.18933-13-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251001175448.18933-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/1/25 10:54, Philippe Mathieu-Daudé wrote:
> Commit fb3ecb7ea40 ("exec: Exclude non portable function for
> MinGW") guarded cpu_physical_memory_set_dirty_lebitmap() within
> _WIN32 #ifdef'ry because of the non-portable ffsl() call, which
> was later replaced for the same reason by commit 7224f66ec3c
> ("exec: replace ffsl with ctzl"); we don't need that anymore.
> 
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/ram_addr.h | 3 ---
>   1 file changed, 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

