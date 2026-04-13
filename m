Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC7FFEBFD0F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 08:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCCOq-0001T7-6i; Mon, 13 Apr 2026 04:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCCOL-0001MC-Jc
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 04:11:35 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCCOH-0008A7-Dw
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 04:11:33 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2ad9f316d68so17772005ad.2
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 01:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776067883; x=1776672683; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VrAxR7RBjv2qef1iynAJ4Li0m9GlvIzfeKHM0n5/8cY=;
 b=yDGeZGRtStTThuXeNKDC681iw5oVYtFxEzQCOkB1E36w+i9X0rjcmD9cOR+dgpCULV
 jBuVFEkqyWXjtabPbyYxyTS7GelhBfP5gqImKYTjbetAQ97tp7ejAc1+5AwjZd0KrfUl
 7zsA014bmKLudQ8Bjf6RWht2+DAApaob8vUlAt4KElGiyLd0pSh7hIyWBl8ZsXW1zwYw
 i/ilb9bX841UeHnGcpr9tX8gyT3KNDpznVUv2/yBpXa0SD6e9hOgM2E6v6Ufz3/yPRMf
 Dbp6+iH5qotsUfO7tScTogK4M7FvVwUHefz6vhItVcafqgyY1ffxavUER/rI2cnLE7ER
 w+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776067883; x=1776672683;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VrAxR7RBjv2qef1iynAJ4Li0m9GlvIzfeKHM0n5/8cY=;
 b=AArqoFgW8UIpfDozoPWyhwu/tYJnSJaX9pUzpqDzAwYXcZReIzmi8Bm8HSjeni1ePH
 o7j1cCh04t4QHOPgMr5XoWk0c8E3OhqwgkBz/YmUt8RA58xPXGts0ZKsA/+60/VKssEt
 JFlp8EkB72AXxm3zNOKdC+gOi0x5u3SFwSfOZ3Wh5dlHL9cIOfHLGfUJw2PRzyUT+zyX
 EX79XaMGhbQtygwJbc1ETfraM022357P0tfdpOsD7BjR7aTqNK1R2zto5VpptQAXufRO
 CnzfHlzgZvnH597KQtalrLIGzzuv62MEkpZ9c2iJ1bWHvUKGDhR2ijANZpJgIohkgYJW
 HaTw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/TRIL7c79dcCadTWhB60sjx0gOUdR4L0LAmMJsGgG67hJBOQUF0+JFedQxb7NpDqVw1zZhsva0jt/+@nongnu.org
X-Gm-Message-State: AOJu0YzyZJWt2HgQMo7fqoQX1+xRV3xojg9fhHoD2lN5n37P8fDRi9XU
 hxJqTMaE+N1He3B70R1PXtaNEZYnlFkVlehzWhLDUedFVhLOrkbCgHVUu0M1dorobD0=
X-Gm-Gg: AeBDievJSEwhkGtr0Q3VSFppQ5pgHpc/+DvQrwONIQOQG0r4ilu+YPd7IEetOXDBRvX
 WoURhuTMyxoahaEsvWac8mrqTOBa7teSZ6AOUozkK6ZyI5o+VaG1/WqZzKpHYtYFuNTRtV5dzuJ
 4C09wxVar8hszVz4dvWzqS8BQKCecRDKXVLipWhImhlehsAsjaq/4Kk/nMwCsuxczN54ifephXO
 kcUQ0uhbYnaoa2cVccVxjsEv7+z9ha04qKBWa8yVrdJ28zKs3IOMVOZ50DEYo7nZyUj2P6uJ7aq
 GiFcVzOmyiHD65e4nixtBnu7RncX3UqlMNkVw4TWAh+7kWO+4df7tGcjuT9sEmEky/VFEZ/2Ast
 dkZW8xMYgCqAQDQONS/qGoRl9sbGSUYUVF99bsp3tqLpHKZMp9X8zVfcEfcInD5c2cgLQqTQ8ir
 JlV/wTUR3eA9n2zcwaXX4YGG7p9c8KFEVyakEsC57I409G45d/hCz0GK5TIHVxxErHxCuA/P6uz
 v75oJz/sPGhr7fZyDbQMk8R92Mgnm2zgv6K1J/ClDM2+Fi8M3IW964=
X-Received: by 2002:a17:903:f84:b0:2b2:4d08:9e04 with SMTP id
 d9443c01a7336-2b2d5962370mr118154625ad.15.1776067883229; 
 Mon, 13 Apr 2026 01:11:23 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f?
 (bg30dj032xp6rdh0yngy.ip6.superloop.au.
 [2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d4dabe01sm106976135ad.1.2026.04.13.01.11.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 01:11:22 -0700 (PDT)
Message-ID: <47e8e8c9-6974-4e00-8238-042cc1d544ea@linaro.org>
Date: Mon, 13 Apr 2026 18:11:17 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 25/27] monitor: Do not check TARGET_I386/RISCV to build
 'info mem' command
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-26-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410195323.17937-26-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
> This command is filtered at build-time for i386/x86_64 and
> riscv32/riscv64 binaries. By using the recently introduced
> HMPCommand::arch_bitmask flag we can filter it at runtime,
> making it possible to compile hmp-commands-info.hx once.
> 
> Since the method depends on a pair of distinct targets,
> define it in its own stub file.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   stubs/hmp-cmd-info_mem.c | 12 ++++++++++++
>   hmp-commands-info.hx     |  3 +--
>   stubs/meson.build        |  1 +
>   3 files changed, 14 insertions(+), 2 deletions(-)
>   create mode 100644 stubs/hmp-cmd-info_mem.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

