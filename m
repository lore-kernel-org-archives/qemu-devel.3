Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98850C54ED1
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 15:41:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIqzu-0008RC-Lt; Sat, 24 May 2025 11:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIqzr-0008Qt-PN
 for qemu-devel@nongnu.org; Sat, 24 May 2025 11:41:15 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIqzq-0005Yr-6n
 for qemu-devel@nongnu.org; Sat, 24 May 2025 11:41:15 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a37d24e607so745724f8f.1
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 08:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748101272; x=1748706072; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JstNNR19O/xeXhv9oEzrMg52dogzQAeCNqm4a/pQDrY=;
 b=NM+j82fvSm1LuJ7rkWMBAaDI5yl1EDEng8XEdSxVzMhV1EP78eKPxhifKPT5k/jlgm
 Gs+4fumItjMzghpsJ7tjZb1iuHYq6RkRDivlcA+cKMBbiXjQkqitmrbEjDhnvZAz5u+L
 SYqcaCjr5XEAd+zM7r1iymwcE83Z7RrXTaHZJI7P4ArBiahfQKdOwo5RZVw5MawS70EH
 1wfK1S1b2B0FNS5x0vi0udXARFIXDbMotWyejr6h672xrzU11pt3j8XO5qZQ0mQzFPFr
 Q19wOkqZU1VtqmfXOea8TElqL+SrJAy6vFDiVqpRN+Zkjg9fFShhLv8ZOPgUgTz0iGyj
 pCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748101272; x=1748706072;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JstNNR19O/xeXhv9oEzrMg52dogzQAeCNqm4a/pQDrY=;
 b=ao+PnwtfrPQgwmrFAObFgcnKk2ARb4vq9/Pv5U2HkIUAJGoGsI34egyAw+otxGvTD+
 EPGHxP0LWKKHr9ZJKmtKwvhDN5XaNHjIf+x21bNRJ4445MiANNZ1mM/CqBjAYvYZuxN4
 SjNAOhdIaMe5so+HassNDOP91+WiZ1UAh1mayYaoCWq5YU/TvLfgjD9J4ZJTWJzMiEoz
 +xEasYW5d0oo3zWZWEO6x5eZWk/Qs0mQC+LOb1Qh0bL6GwEeAhjpzB8G+OT2UkPcJh8V
 zbqVKvIjHaA5K9sflpJXtVyeldxcnmlX/n+ZfifNJ4GH/u56uYY5yrdFcdyZKQcGsnI+
 r7eQ==
X-Gm-Message-State: AOJu0Yx9GGCmeus/pvR6ozGL6pI6eg5mB8OGGjZZ6rUxsEYRiOVUwySc
 pRjkgqpHVQX4Rt/VY9Ny/3LDUDZUiJp89SrFUz6xooS+ezh9duwVgtV41NwpwDhIX4RJnVaIH5u
 y7/NPyoTuMQ==
X-Gm-Gg: ASbGncskLGaqmmVDHE9gFgYKivJfP2E8DWpzC1vDmsoVFiFnmBPdrK5mjAITD/hzRbF
 Vux0ynlNKaCgYrmP9/Ef6FNriyL4w+fkVAmO7y2Caq7ZFmirAtPtgs4/Tlml6Y606UllxiUtpM4
 6b+zRIDhfYoO8oBJD9y6BSUk8rYNuBSiGIUQwIZVObnIwCKOWyaFWMjX54TCiql+IB8jBZ4D67p
 BgYe9/yreb7XiQubyW7FHKTvt+nlYpEaPz9kYIuQngBCAHI4hKkDW0Q10RKxEAxyaIXs+817Q4n
 WEAZ70STIm7QX34s/5/cRlmWYq+48TsAPVWlIr0+dioo54Vts4bnsh7iqrkyc1ranw==
X-Google-Smtp-Source: AGHT+IGYRzTsK6of/oqDhqIoxXUNdJY6g1iJB3NNUNCWNiVN8JCGBs8TwFKcIGEXZD2Aq0ktpusqog==
X-Received: by 2002:a05:6000:2304:b0:3a0:88e4:3d2f with SMTP id
 ffacd0b85a97d-3a4cb43dbacmr3166335f8f.5.1748101272612; 
 Sat, 24 May 2025 08:41:12 -0700 (PDT)
Received: from [172.16.25.47] ([195.53.115.74])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f6b29672sm190688745e9.3.2025.05.24.08.41.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 May 2025 08:41:12 -0700 (PDT)
Message-ID: <953b015b-b9b5-4a4f-94d5-f8eea14596e1@linaro.org>
Date: Sat, 24 May 2025 16:41:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/block: Drop unused nand.c
To: qemu-devel@nongnu.org
References: <20250522142859.3122389-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250522142859.3122389-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x429.google.com
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

On 5/22/25 15:28, Peter Maydell wrote:
> The nand.c device (TYPE_NAND) is an emulation of a NAND flash memory
> chip which was used by the old OMAP boards.  No current QEMU board
> uses it, and although techically "-device nand,chip-id=0x6b" doesn't
> error out, it's not possible to usefully use it from the command
> line because the only interface it has is via calling C functions
> like nand_setpins() and nand_setio().
> 
> The "config OMAP" stanza (used only by the SX1 board) is the only
> thing that does "select NAND" to compile in this code, but the SX1
> board doesn't actually use the NAND device.
> 
> Remove the NAND device code entirely; this is effectively leftover
> cleanup from when we dropped the PXA boards and the OMAP boards
> other than the sx1.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   include/hw/block/flash.h |  18 -
>   hw/block/nand.c          | 835 ---------------------------------------
>   hw/arm/Kconfig           |   1 -
>   hw/block/Kconfig         |   3 -
>   hw/block/meson.build     |   1 -
>   5 files changed, 858 deletions(-)
>   delete mode 100644 hw/block/nand.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

