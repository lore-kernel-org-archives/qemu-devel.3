Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4967AF8DFCC
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 22:01:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDUle-00010N-BJ; Thu, 16 Apr 2026 18:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDUlZ-00010C-SJ
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 18:00:55 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDUlY-0003lL-Cl
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 18:00:53 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3590042fa8eso42063a91.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 15:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776376848; x=1776981648; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aLzobJG50jYWmKZQvLRRaXVGk9hzIyFK902cWt/lXbY=;
 b=HUjQNrn+2WuMlhRhnr2WU2RmEyjnTcAwY9pWU6P/xTL/LdoZVWyQp1jtysROFf30yG
 qGXsyn7lliVUk2U+b22Hx0ZznB92LXNMjzFm98xOG8H29TU5OgptNknx7MFPuWloRaZN
 hjITmJKZD6ZoFHqKcJPoctJWB+4edgpRQd6gUXmKBDIAqF15LTXkq/t+iY8Vg+npFgLt
 nr0fcg3K6mTeVSm52J8NXdpVBdAV7h+7A65ZnhKUJ/XJ5VvTVLvKUQPuvGEqi92VtwKw
 RinU9VCGdVUPxQYZbDZj/B5tKt1HVBIcueQJEX7TK4A691XD5ybTIJURKk9/qnE/aCyV
 NB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776376848; x=1776981648;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aLzobJG50jYWmKZQvLRRaXVGk9hzIyFK902cWt/lXbY=;
 b=hJdsBxbiqEgWlJBHyhDxRNji+Sr1Ohl/WIpiydDRWKgePP2Uo67brxLXPvN1X9OA5d
 tOojTv3RmceaDWKrn6/y5GyYVvfPn01Yq15TS8bZO5gKbmfgxwwZifiIJknnIIh9tEcx
 E9ujbmoPjFOZTr55HXqrizZ+Mxsgc4D2TgAxqDiQ8PUUlyLaJ/RIVnCvm+7S3Uhg+Z5/
 efH7zknWC+rXKRP+x7SKX9YB/sMMxI57r2FxqRpnbn2kj8XkWk6ozsGGNynlknI57Cca
 juV2a1NgKofxFMBNt2OEBS0zKIpJqBX6/anyHNfsEIc/6jPgVvIUTbM9cY4p6Dc5+DQ7
 117A==
X-Gm-Message-State: AOJu0YyFefPZf6z0snCfnlTbw7EbEvaiv3HjraZvgzWs1G2cBNoAcyDk
 RwSZ1f61ldTqTnYO3LlgQrxBlVzIZog00wCeSwno49eXMmHLcjPYHOBw370gF1lCefcfO97Izu8
 gxiDmL2M=
X-Gm-Gg: AeBDieudqtcyvgMSldhsaNDjwvxol6jcHIDL72qJuhNCADhvFhscpLyrE7qpt7XGjBt
 +C7QsFP43J/f7a9GXii98BIXBP/8G//4TnucxDpZiG5WoVZM9MJX+3KCDVIPgH0PMImhw4kf6RM
 JQiPiRFYA7h1K2Xi+Q4qdmH9t5tMn5Q/3vGNTDqXKM83PmmFgFOWUxD5KT1cn8/Hmc3bU0+DJL1
 4LiXqdO/eZszrjFHX98vDk/i4nCkGhiWg+bAHRtz0TuLzURWrwkdosQiDfrJIe4+rhMjM4/gyDx
 qRq2wjWb3SFifzAhjuvvNuKL0kOt/bwTi4dxMs6HzMq/GavVqRsAEDOgGi8NyZ0oLa6TQ5D8Zs/
 xDg9H2kP0WpU/332LqDNp0qclAIq/wiUc0ZQ2+5HABoXFjK5tyIMuhU+DrOFyhErH8AV7P54Rie
 H/8nYVHGx/Sx05HugKU6/j0a3AmH06w7hYwh3k/lY8L21Aat8LSVWrZCBxcTMFddCTEikUZVPOi
 u2EDlMq8CpZb8pcNikPJFYn3DA3Fdvir98FatolpEijDZknwQZv8mQG3u4S3asnaA==
X-Received: by 2002:a17:90b:384e:b0:35e:5a24:3c43 with SMTP id
 98e67ed59e1d1-3614040861dmr139761a91.8.1776376848068; 
 Thu, 16 Apr 2026 15:00:48 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a60a:7c34:dd75:e66c?
 (bg30dj02y68bx09myf73.ip6.superloop.au.
 [2401:d002:dc0f:2100:a60a:7c34:dd75:e66c])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36132cd538asm3471596a91.8.2026.04.16.15.00.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 15:00:47 -0700 (PDT)
Message-ID: <34e08369-8b5e-4b71-94d9-b5c8860eba5a@linaro.org>
Date: Fri, 17 Apr 2026 08:00:42 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] virtio-snd: check for overflow before g_malloc0
To: qemu-devel@nongnu.org
References: <20260416-virtio-fixups-v1-0-ec14e2de0852@linaro.org>
 <20260416-virtio-fixups-v1-2-ec14e2de0852@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260416-virtio-fixups-v1-2-ec14e2de0852@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

On 4/16/26 15:48, Manos Pitsidianakis wrote:
> +        /* Check for g_malloc0 overflow. */
> +        if (!g_uint_checked_add(&tmp, sizeof(VirtIOSoundPCMBuffer), size)) {
> +            goto tx_err;
> +        }

This works by accident because of _GLIB_HAVE_BUILTIN_OVERFLOW_CHECKS.

The variables are of size_t, so g_size_checked_add is what you want.


r~

