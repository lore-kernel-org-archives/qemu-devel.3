Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D97CAC5B0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 21:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v59d6-0007E4-4a; Sat, 04 Oct 2025 17:17:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1v59d4-0007DJ-IK
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 17:17:22 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1v59d1-0005hl-TD
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 17:17:22 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-330631e534eso3802068a91.0
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 14:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759612638; x=1760217438; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=VVc1jePNohYy0guFrZmYjVLuHzGyBrzbcZBMpLGimTk=;
 b=IuvLiT9T8MK4FuPrxYsvxIq5/STE0j1qg3APiUysouyjDoG72s3KsKWu84NlSVotHX
 YtFWgTlg6/gXCxj3IeriIsdhUjN+KAOozWVWlkU3fV8AtcDV+W6OFS9K9EfQPLQQFqnc
 aJVPRifDI97f16TAe7RIfS/vouGn3YN4Z42p7evQ3rAN9zqSWkCQN6xx1y0b3xB5sDcY
 PdP81UI+Y1NXNoXed18QktPhzMyvIEhV2BGYdaGOdeUuxJIbwD1IeT6Sdkd2AdGEZ1Hl
 I9M0Tvf7jpuarbF57hOzLVHPP8yR3gQvprL/pOzEahwheyIchxvVoPcTG8/xb0kcQDRQ
 5SBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759612638; x=1760217438;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VVc1jePNohYy0guFrZmYjVLuHzGyBrzbcZBMpLGimTk=;
 b=Q99cf3GsxcdGdCbFVpUQkQ3XWymmtnA67BDeHv/AOUL0ssjo/T55VfzoV7fEsonhDN
 ojH1gyMYUH3IFQPvubrdqTlwUJwgVz0Fkdn32NKsq8k8cvDE41c6p0rqEUDXDWeotwPT
 JNss0SJK65/1AFFZAJe3PWLGvbBE4a2mlnrB2gKjnWtgGvwxkn+9M20LHAGaLUH+RgkM
 mOwZuhU6BGGUXrOmhPpnPR52dz27Vd8L2Xyftckyd9BQZTT4CmPWggYgMvV9KUTX6w4M
 PxVhgHyGye09lalQqewsaVm/+HBCBSEnFfjlXWyNSRmD0peAhaS8alWAK7kZv98kE4gj
 xRTw==
X-Gm-Message-State: AOJu0YxAHB1v1MyNxJqcZEKh6NHCQzMvroq1spk7BPtqvBNvqiezojzp
 Agyl8JXwd4zD5fmxVZL7JWldw0UUTs43at3GpgHF9VTtreQcsJ1KfaM0
X-Gm-Gg: ASbGncuIT1DgaqyTQxdXmHEHqBAtFpy841opacA1/715JE4NA4U+jaNpv6Sj0ztFwAX
 G31xmALJSboxRmZM9msJbauco7s/i0caSBFV22fpV7t3V4g7jDtsmdhcLdKVKUY42idGmRFs73+
 E0HIg4gKLLF61dpr0UsMo33Ir/7nyttUnybUbSDdivTLZLPgbq0jatuEL7BPamGdIzdUDpnGg3Q
 wyB0cXwQj2CnXnYANrSJXGgTfBSewG6ew0xW6xdiFLYu+bDQD6+CP7V6C5HQt4x82xOIjKT07Yk
 X/aJR1nNNSqxmjSM5Eg5kNuGsZ+fOLGSMT/BzCTXzIfKzWiA1q5aVQrYlRQ8czDgPbyiQ6L4x4J
 Y2TSPp9gPvkHPsGRIsWm8m5ODz0gF3xIsL1xtoVWV+ufMiC7EvZ5ke0aGHTytTf4Ye8o6Pw==
X-Google-Smtp-Source: AGHT+IHVDPuCtm4Mxh1NxzWmyupi/gENm2Ni6iLiFjmBzGTzWlxpff3OsbK7Pw5f1oSjYIXULQF4cw==
X-Received: by 2002:a17:90b:4f82:b0:330:6edd:9cf with SMTP id
 98e67ed59e1d1-339c27a56c4mr8068917a91.22.1759612637940; 
 Sat, 04 Oct 2025 14:17:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6099afa6a3sm7974252a12.14.2025.10.04.14.17.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Oct 2025 14:17:17 -0700 (PDT)
Date: Sat, 4 Oct 2025 14:17:15 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Sebastian Huber <sebastian.huber@embedded-brains.de>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <alistair23@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: Re: [PATCH v3 3/6] hw/riscv: Make FDT optional for MPFS
Message-ID: <38528707-3d28-4be8-8b58-60269cb1db1b@roeck-us.net>
References: <20250319061342.26435-1-sebastian.huber@embedded-brains.de>
 <20250319061342.26435-4-sebastian.huber@embedded-brains.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319061342.26435-4-sebastian.huber@embedded-brains.de>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=groeck7@gmail.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

Hi,

On Wed, Mar 19, 2025 at 07:13:35AM +0100, Sebastian Huber wrote:
> Real-time kernels such as RTEMS or Zephyr may use a static device tree
> built into the kernel image.  Do not require to use the -dtb option if
> -kernel is used for the microchip-icicle-kit machine.  Issue a warning
> if no device tree is provided by the user since the machine does not
> generate one.
> 
> Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Starting with qemu v10.1.0, the command line is no longer passed to
the kernel when booting Linux on the Icicle machine. Looking into the
patch, the reason is quite obvious: The /chosen property is set in
riscv_load_kernel(), which is now called before the devicetree is
loaded.

I was unable to find a clean solution other than reverting this and the
next patch of the series, so this is just to let people know about the
problem.

Guenter

