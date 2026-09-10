Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC8DC79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 20:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4l4P-0007Bw-MM; Thu, 10 Sep 2026 16:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x4kmb-0001WK-7X
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:50:27 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x4klw-0000SC-8H
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:49:28 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-39647184c73so1184682a91.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 12:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789069748; x=1789674548; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iO9q3rw3PPPF9C2Mz990QyKjTwyDIonNCxmCiTY691g=;
 b=HKXV7OkElNAVx602C05Nl4KGU5LLCI4hTcpLu0gPYdpbJQgMGjPBX/wl1yOfJur785
 0Fhz52rylgtgEqyQcnSYpdvLH9G3wv9R4cv9CNSHPc4ZNdaHU6ZiIEoxyTjshB5DSJd2
 thTiTfs7A6geGJRTuJICLdWuoYX2YL/62OmbEOj7+M3ZFG/5aqDxI7Ia3Edq62Rowwof
 WzYtyBKvtFLWwBMrmzS2kEsWV2UcQdrSrxCqcGypMko8+KH0YoydNCarc0ZVwn3d8D+5
 09WrOGRXeumS6dN0NHsnd6+IrjEZgmiutFhFFcSwloqRCnpE7nITJvHh2y8r9UijRaU+
 GIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789069748; x=1789674548;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iO9q3rw3PPPF9C2Mz990QyKjTwyDIonNCxmCiTY691g=;
 b=PEPkVg0IFzoMdGe1Tf+tzOtLbnn2KwYCE1C6Ho0mVtRuiRH7ITlEjMkzeByy/FF4xU
 O32oi4AVq2UIbqs3qBdwZLmEsFFqm3xi3D/q2qeR8TxsqGCE2USddf6WRQ07tLP9E7JH
 AQIViWqzdnawk4tm5OHeD9CbnzcjNoNRh5vhHQdiTtcMD6ZWKjqLTixXZ7AULBG1DeY6
 SP0QsWWCrlAL3fnMD9VjpIrvMGlBo+i6H1gnOmIVjtf4Ffgtby+4GbSvKCUd/Z/mqCNR
 DoZ6Us03KFAxZSQbDUUd1ecnwKgvLbV0Pd+AmK5HQlH2X1AWfnKuf/e8HF2GIED+avOt
 D9fg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx3Ae9t3v+hY3CuTFG+PqRTd5aM52phiMDnHgubmBkZ4xCn/lYLl7yjzTGEbAQsORiYfmbwMInZMS9j@nongnu.org
X-Gm-Message-State: AFuF++nRCEY0qZYApHOkX/EJU/5D9Ju6De1gw2RUUNBU6DhQx4xQn8DJ
 g8fiDTjWCHG7Matqvo/mP5qw8h+MfJ7+xaVvmJEyh1Ix6i/w39sBZ25KTFKUtdk0fYN7wKHUiiN
 OpLCktDU=
X-Gm-Gg: AYBFou0t29lureZQD/cKT94ATrs4U2LpCFC0WiCbzMGwWKR0O3bafboMIGFyF5h/4Eg
 PO4u+nYWak84m7Iy26fqziY4KY2mpTch/9eA2lW/8fQF1lxkgRBoaDhz/jghESF+X5F+X4fJnNK
 WYoVbstPe/VQdwW3ccrq7WFYKyCyypbALmyJMLyvSAyLNee8tPOF7MTMV3/DItQdAamf1J8GLUj
 7EnbbPgkRbvsrv+AlyqBQQidLi56GmKo+GDQCsrZfZ5GyDhrkUF4XfrzE3Whiohreu//Y/N07Ck
 OrEAPopBNbNf6CMg6CcAl64byk8u2oBkUM60Dre0zyBCf5FahQlc2IDZPI0mUJ3Sv03ylCLg3+A
 LZg9C9E/XewY6w8G7pWkykS+Bu7oFsL0uKiZki+ry7gEY5OpIMxfqbmQ9xAU7v5Xn3x244T1koX
 zi1qXntRXABpbQveMwuFhja8Yxby0xdd/lUgFFEFu0IP+8UH6mflGcJM5J6dCteY/t+KGJ11x7K
 vkxBK5k2JPlbFU=
X-Received: by 2002:a17:90b:3c8b:b0:398:9beb:a2b6 with SMTP id
 98e67ed59e1d1-39d77b7b11bmr7986695a91.24.1789069747745; 
 Thu, 10 Sep 2026 12:49:07 -0700 (PDT)
Received: from [10.171.0.227] ([98.155.112.169])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4cf72dbsm445807eec.3.2026.09.10.12.49.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2026 12:49:07 -0700 (PDT)
Message-ID: <44486b8d-c1ed-411c-890b-89720996ba77@linaro.org>
Date: Thu, 10 Sep 2026 09:49:03 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 21/21] accel/tcg: Constify @cpu in cpu_mmu_index() and
 TCGCPUOps handlers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
References: <20260901095229.72018-1-philmd@oss.qualcomm.com>
 <20260901095229.72018-22-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260901095229.72018-22-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 8/31/26 23:52, Philippe Mathieu-Daudé wrote:
> All functions called by cpu_mmu_index() take a const
> @cpu argument. Propagate the constness to the caller
> (CPU state should not mutate when resolving the MMU
> index of the current translation regime).
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   include/accel/tcg/cpu-mmu-index.h | 2 +-
>   include/accel/tcg/cpu-ops.h       | 2 +-
>   target/alpha/cpu.h                | 2 +-
>   target/arm/internals.h            | 4 ++--
>   target/i386/tcg/tcg-cpu.h         | 2 +-
>   target/ppc/cpu.h                  | 2 +-
>   target/s390x/cpu.h                | 2 +-
>   target/alpha/cpu.c                | 2 +-
>   target/arm/cpu.c                  | 2 +-
>   target/avr/cpu.c                  | 2 +-
>   target/hexagon/cpu.c              | 6 +++---
>   target/hppa/cpu.c                 | 4 ++--
>   target/i386/tcg/tcg-cpu.c         | 6 +++---
>   target/loongarch/tcg/tcg_cpu.c    | 4 ++--
>   target/m68k/cpu.c                 | 2 +-
>   target/microblaze/cpu.c           | 6 +++---
>   target/mips/cpu.c                 | 2 +-
>   target/or1k/cpu.c                 | 4 ++--
>   target/ppc/cpu_init.c             | 2 +-
>   target/riscv/tcg/tcg-cpu.c        | 2 +-
>   target/rx/cpu.c                   | 2 +-
>   target/s390x/cpu.c                | 2 +-
>   target/sh4/cpu.c                  | 4 ++--
>   target/sparc/cpu.c                | 4 ++--
>   target/tricore/cpu.c              | 2 +-
>   target/xtensa/cpu.c               | 2 +-
>   26 files changed, 38 insertions(+), 38 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

