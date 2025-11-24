Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15ECCFD31F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 17:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNa1z-0000YC-31; Mon, 24 Nov 2025 12:07:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkrcmar@ventanamicro.com>)
 id 1vNa1s-0008PQ-P4
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 12:07:12 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkrcmar@ventanamicro.com>)
 id 1vNa1o-0004Jr-LO
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 12:07:07 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47797676c62so4405875e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 09:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1764004017; x=1764608817; darn=nongnu.org;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y03jS9yKZdIuUw5sNGcqpZgXDc3pcFdoE+155gn3nEo=;
 b=BgdP9Ih8FAbjBRqdMOhJDHQuRpXLHUfa3rGw456u+cYxFvzK4OsAYRkufH6IOf2gJG
 x5KSQUbd9GoTl4ZaYo7RS0lAd9Xin/Wt69JdgKISI64kdS4LFj/aYUJCTzDPwC2o0UcW
 BA7EUu5J5k5Kbn8RGixIn1bH4PLmsk8zzHzdBYDaB9Ursv5NrHDlCNTRkBxi0MYCqERn
 P6Hhpm+fQZDTTTlwzn60bAT5gCHP9tYjLL5aOue6pNKVQBr1mF6POamIujOGNRTL+KWu
 XcY84rJjFrOlf7rG0Bo9wgKGQn44DCikhheB+z7ESIY1g+5ndg4twaC5PM62YjI2WqhL
 GP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764004017; x=1764608817;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y03jS9yKZdIuUw5sNGcqpZgXDc3pcFdoE+155gn3nEo=;
 b=qY+KJs5MacV8fn4lVXrzXJTh2DrNIgMTwiVtYe8tKX/cdVLAP384t99XZzurjrYmUE
 kOc9aO0fYS8PzhTNzgJ52cxjX80jQsvXuSz+zaBdeq0qrdRolbjDhzaTasM5y+8iwPA8
 dmW7AbcHeRJftQASNKQcaexnLrRWjyVpsqfX0PkGLGURK3FQUfMT7Ulb8QKaniwkbLb4
 0JphWowjEBxnW9MVfI+cd1WqJDStp4z1hUG+tKf615Adl7recIwebqoihCshGLz4EcpC
 xtlJ+X5uMwdUayUVga2EVxLyNJIByudHUwLpohdTYDz9K5Z3k7dwcvKp88oEJPGQYfQS
 Q5mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmgZnUX3jTsGzBvx9kd43JNJZcK6l1UdyNrJqWccAgrtWSa1hYunp5lz7Bposqb6WpdjnpxV02qdOP@nongnu.org
X-Gm-Message-State: AOJu0Yzam8d14KO1MBUHy0PworAyTMZr0zatRbfVW3b6DWvvjMMu78Mn
 aPtUSCztsJrxqKnc5JAvm/cQ1QsfeSqyxtV3uhPdPTbXmDEcVa9HSokE3oRo7+MmPVQ=
X-Gm-Gg: ASbGncuDPwDAAGEFYAFptr+e0CvVEKQ4ATo7A+ZOmZmY+uEjtKhdQUssq8COADjfNXT
 G3T4TcxvfdY54mKUpl7dWRcCLMqMlj3q2ga/XDDUOusSpjxKGTHmaDX8eb5k7MAiTBg26r/55Cs
 ELtTlkIJFisnbdogdbwUx0tuADTPNCu2zW0EpKPYTKgfx2Bz/vZrxLZpC1roJUdfIWjFWFmRaRZ
 r2ALPXPKRAU0H3B9X3gjmNfpUt3WFJYezx2wS9YQRE94jC8IWWi4AvaB5NVSYZYbopRtIX7XCKQ
 V0EJZ3VxdpEm4qRZqR2BmtLAw8jkj8qnCMX3/iwI0t2nRI3CEDpOWEHvu13kELQwd9bhIsSsuqM
 YiUHcrrLyJZLY7LAtiJf1Z8wCOAuuM2X1G5Emg4S7Frw5LXY7dNp5boX2uscHiA6MWo4VNRLOV7
 M=
X-Google-Smtp-Source: AGHT+IH1UcLs6Z8EDCiPmctYySD5NjdPIWI4jOao4tVNsa/NrxrP14kAs4b2WHQhOQxzs4BOiY5vIQ==
X-Received: by 2002:a05:600c:444e:b0:477:9a4d:b92d with SMTP id
 5b1f17b1804b1-477c314a201mr79236065e9.5.1764004016818; 
 Mon, 24 Nov 2025 09:06:56 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::3052])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-477bf227ae2sm205686545e9.9.2025.11.24.09.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 09:06:55 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Nov 2025 18:06:21 +0100
Message-Id: <DEH381ZF2STN.G7QL6LUEEBKQ@ventanamicro.com>
Subject: Re: [PATCH 4/7] hw/riscv: implement CBQRI bandwidth controller
Cc: "Palmer Dabbelt" <palmer@dabbelt.com>, "Alistair Francis"
 <Alistair.Francis@wdc.com>, "Weiwei Li" <liwei1518@gmail.com>, "Daniel
 Henrique Barboza" <dbarboza@ventanamicro.com>, "Liu Zhiwei"
 <zhiwei_liu@linux.alibaba.com>, <qemu-riscv@nongnu.org>, "Paolo Bonzini"
 <pbonzini@redhat.com>, "Nicolas Pitre" <npitre@baylibre.com>,
 =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, "Atish Kumar Patra"
 <atishp@rivosinc.com>, "Atish Patra" <atish.patra@linux.dev>, "Vasudevan
 Srinivasan" <vasu@rivosinc.com>, "yunhui cui" <cuiyunhui@bytedance.com>,
 "Chen Pei" <cp0613@linux.alibaba.com>, <guo.wenjia23@zte.com.cn>,
 <liu.qingtao2@zte.com.cn>,
 <qemu-riscv-bounces+qemu-riscv=archiver.kernel.org@nongnu.org>
To: "Drew Fustini" <fustini@kernel.org>, <qemu-devel@nongnu.org>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <20251119-riscv-ssqosid-cbqri-v1-0-3392fc760e48@kernel.org>
 <20251119-riscv-ssqosid-cbqri-v1-4-3392fc760e48@kernel.org>
In-Reply-To: <20251119-riscv-ssqosid-cbqri-v1-4-3392fc760e48@kernel.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=rkrcmar@ventanamicro.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

2025-11-19T16:42:20-08:00, Drew Fustini <fustini@kernel.org>:
> From: Nicolas Pitre <npitre@baylibre.com>
>
> Implement a bandwidth controller according to the Capacity and Bandwidth
> QoS Register Interface (CBQRI) which supports these capabilities:
>
>   - Number of access types: 2 (code and data)
>   - Usage monitoring operations: CONFIG_EVENT, READ_COUNTER
>   - Event IDs supported: None, Total read/write byte count, Total
>                          read byte count, Total write byte count
>   - Bandwidth allocation operations: CONFIG_LIMIT, READ_LIMIT
>
> Link: https://github.com/riscv-non-isa/riscv-cbqri/blob/main/riscv-cbqri.=
pdf
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> [fustini: add fields introduced in the ratified spec: rpfx and p]
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---
> diff --git a/hw/riscv/cbqri_bandwidth.c b/hw/riscv/cbqri_bandwidth.c
> +static uint32_t bandwidth_config(RiscvCbqriBandwidthState *bc,
> +                                 uint32_t rcid, uint32_t at,
> +                                 bool *busy)
> +{
> +    BandwidthAllocation *bw_alloc =3D get_bw_alloc(bc, rcid, at);
> +
> +    /* for now we only preserve the current BC_BW_ALLOC register content=
 */

There are a few checks that we could do even without any real
accounting, like rbwb > 0, and sum_{rcid}(rcid.rbwb) <=3D mrbwb.

Doing so might help us find some bugs in the software management layer.
What is the level of ISA correctness that you're aiming for?
(I'll tone down my review if nitpicks like that are not needed.)

Thanks.

