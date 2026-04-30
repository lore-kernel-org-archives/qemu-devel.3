Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96ACFFF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 06:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIKoI-0006mk-7C; Thu, 30 Apr 2026 02:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIKoD-0006mN-Vk
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 02:23:37 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIKoA-0007u4-Pr
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 02:23:36 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2aae146b604so3813575ad.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 23:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777530212; x=1778135012; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rmrftOXBbaOWgc28nIMdOLmoc3qk1BCk73oy3yWW8kw=;
 b=cEVi8QmZhGWb+ckJcvmZz00S4Ies+eZaDgO8VIDYiLpw/zZlpSnhFAe50WLXvQszy5
 iC4Nz3rnmdMsmwIR/fYrehEEbhM6qtmtfdTEKbcaO2l/UCqJe6KFJ+BlJbTw9+bzMJFP
 BVY5pnTLEdD8uCYG6c8XM7rM1gPyenhFVa2mSIWCML9mpYRHi1QoqrlaHNvbookF18Nn
 uQfKoFM3rRei49VSqUXWUWo0p92atYRLO2Yo8ddeNDHc019IrVrEf+9h8N7kiV/eVXrV
 gQQj4J/9Tij3LOhjir7ITRMoTKaXWmzEbM73fs8L0rMjEeGGswuPAIBwqkCOSK3bHC3i
 ofXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777530212; x=1778135012;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rmrftOXBbaOWgc28nIMdOLmoc3qk1BCk73oy3yWW8kw=;
 b=pVnbkdg9OpTwEt1YkRCYvZVK2I2OJvTx/4AE0R6Fwcn27+HSd9KJ8zkemeWrEzNcqV
 gTkVmuRkwLuCHS9l6Zl3USol+kpUysKBpc3nGSFsc3OhrdeB/OPj5czMXwA8DDu27rNZ
 KQdpqZO24QluLfQMcwdCu88L6qHJynybq8WGQTLqq67S95ayR/HfXj6ywW7zzAm9KdTj
 17zsSSDSRMkV3jR8+KDwi4zx+jGgH2SPMEC2DTFs2vsYJ0VySQQdMVcSswTrffeYWZhC
 Q4F+7AhJ1rvbYW3VrSe0GAxXZQLz0tvcNBd90YGGwHOuvujkQoXv4G4PuC03KLyQyNjf
 Bitw==
X-Gm-Message-State: AOJu0YwHMoaFiM4UERm/qocR1CJbth86a1lmcPq+ijp+e1fxD2xARNs/
 cvE90uC+agsF7IB/XnWAzMzIMPDNwLCT5Ng/EOzB9jvzWPmdTp8CGbLmERN7J7O2RQZlwjD9GZV
 TQYwJqYM=
X-Gm-Gg: AeBDiev0zYezAtrKga8par/39lpSn1d3pucJsIl+Et4NU47ktklEBmKqbxYsBz4qjNH
 LfFbc99mB4OCB/zSg0uc4tVFwmxqV0TuEmDQWpPULrupTD58QoIcpzoSd5eCz2jF5YZeEdOLQ4v
 wcRuD+GCRepRdJcm+4FeuCbkzHCpLWFJZX2+dFVZOz14FB+VC09xEqKzXJomvp4VElwtBq4Z1p+
 1zkdSvi8UtV4qziXKowy0rqR2P4jBe0hG31lIJoryA9QcA0+zNwChf6tJLWBtAF8orrY5xl50ng
 1ZlzBNM5M+tWEnG3FRJ0leP+jqJhEOhu+xbaO8CTC1G6grZv6Z2tRHAgovO16m7Dy9lffrjU2Ed
 06CqooukLz2mDW8EkUIZXg6qX/lHUGhRtIhCLvBL/VfJftAOwcGonTB3gV75GsIw0LyyXiZDAuG
 +wpdPQT+MOlVWAGgjtoJ9ObJ/fSKcKHiIa7i21upZmyKgFxhISRy8+
X-Received: by 2002:a17:903:3d8f:b0:2b9:5d1b:73da with SMTP id
 d9443c01a7336-2b9a24e3ab7mr11059515ad.30.1777530212100; 
 Wed, 29 Apr 2026 23:23:32 -0700 (PDT)
Received: from [192.168.10.140] ([180.233.125.15])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b9889911a1sm41907295ad.81.2026.04.29.23.23.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 23:23:31 -0700 (PDT)
Message-ID: <7db34886-a7d4-4af3-80f1-405a34d38b22@linaro.org>
Date: Thu, 30 Apr 2026 16:23:28 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/riscv: Deprecate the shakti_c machine
To: qemu-devel@nongnu.org
References: <20260430052218.771358-1-alistair.francis@wdc.com>
 <20260430052218.771358-3-alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260430052218.771358-3-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 4/30/26 15:22, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> The RISC-V shakti_c machine hasn't had meaningful contributions since 2021
> and is currently unmaintained. The machine is scheduled to be removed as it
> appears to have no users.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   docs/about/deprecated.rst | 8 ++++++++
>   hw/riscv/shakti_c.c       | 1 +
>   2 files changed, 9 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index f3622dcf93..041f71c5bf 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -282,6 +282,14 @@ firmware is available to boot it. It can be replaced by the
>   ``ast2700fc``, another multi-SoC machine based on the newer AST2700
>   SoCs which are excepted to receive better support in the future.
>   
> +
> +RISC-V Shakti machine (since 11.1)
> +''''''''''''''''''''''''''''''''''''''''''

' does not match preceding line.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


