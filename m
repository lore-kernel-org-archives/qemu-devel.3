Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC8AFF3C250
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzaVx-00013a-00; Mon, 09 Mar 2026 09:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzaVv-0000zq-4w
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:19:15 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzaVs-0001iV-LH
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:19:13 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64ad9238d8fso11302174d50.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 06:19:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773062351; cv=none;
 d=google.com; s=arc-20240605;
 b=UrUs2EJQkgsbwUle67cfJoRcSYtfHQ3upACnEBKA8UxqY3VlWEgMTwIUJNPmvPOLQK
 GTQ45QXtEXbh/bAM/lzwQKIQqlCtGSJHLGbxAMgzDfZgGLVp/QljsSwiA/pzL15gp6Dk
 ETLfTfCetXN3CrXFaY8nN3fWbM32acLn2PGmyrS54BswywbYwmu/rpB+ISZUvtAFYyZ7
 AWwEORY1e0/UvXiigi3ZpkxaNOvMY/XzE74wIVgHVgz0r7EZwH50CZjLMPUgtbuy0SXS
 semWowTqBR8KMW7+juAG/5YPwgH0lHQXi9acnx77A2Dm328kFDNWTGwzVg6ffehnUmxF
 KAVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XzlsigYirrCf5DKmtzeFieoU9kezpUoLMRaf2paP3I8=;
 fh=VUZ7eJox894qpEuQTEFSefKlY4l3x+uBmRGBSaSsOHU=;
 b=PzhcJx5n1bVtdTqLWfHgXP3SeShLC/TnQhrMRhlQ59mbJYuSGAmi9J0zg/5RhMf5Rb
 LvmCm+MxdlmixJyzJ8JRFjR47Ms2v2Kvf16FlFhbFzYWqAomFq/6YcgBiGLZxaA7VqXT
 KPP0gX2vc5XZGhxbce3JgMMe5BN0EIKOjL730HsSJiRufALYQtbGF6/ihgtQj6SIY8Nz
 zylJfQBSD6Mvd4rDYlgca/KGjfUoQPEBR0FzI7sWHKHcP8fQIo55Y+gE6yJ8jU9GFL/1
 KT4JDY4J5brbp9DEfRnwJdnYFsPOSt/ZinxYrbX2jduIm2dbijArDI4CHoRPJ9uBVHYV
 sqLg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773062351; x=1773667151; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XzlsigYirrCf5DKmtzeFieoU9kezpUoLMRaf2paP3I8=;
 b=xIWSmTIX0mn16agpHMCN4h9+aysvSGygJ4Q3BnhITg1OsFSXLB6GCHjTRYXLszH8mC
 AjKm5xZxpe4GKyf+nPaQQTthXUoYjP0wnprHU6mA0Dr8qFe+KcZivU8HtF170iz1/IM2
 jSl5yuB07H4RVExi4e5+pAK0qasyC9X2/lMRJ65JalwkYsvjKtmC6FpYkOcuGR5sXqnl
 GBQaCEDYdjxC7nXXJz/BpKyt9ddYyCPnSrEy1d3il/z4wKCZO4Opq90b6Rc6jqP0RpRq
 YYx1j6fuHevmrN5UNKCmCH59/t9MPWAxjXr+a9Swa4zB5Ivsebk/hTkU/Wwsyey11zu2
 sMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773062351; x=1773667151;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XzlsigYirrCf5DKmtzeFieoU9kezpUoLMRaf2paP3I8=;
 b=l9l0ToX1qY1IhGTbQzo/mkzFtmuNDmPl4fQojAIuXuPJO6ZEG4/2bBFUe0pOQbm3Yy
 rpVMw7oVQKJY/dfLJWEQ8UweQxnSAoQx0iKjLwZw7BGqO7wFRDMe+91DMMHYhsaF5tsI
 1O6GrmVJoqo/gt7ef7yLmb7FowM8q0F/ya0tVacxSY3Srju9uumsCt6MKOTcqPfuA/iR
 n2rvV8LXGrMv6TEM5n/TQOPASeApEnCN9I6oWuETH5tNcRJyI13yVPP+EU9ZwJc5X0Ti
 ovKZansUtbNZUA8/e5PnCeGp0VS1nKisCzXA1GjvjmVpsyhUAIMLRyo5rCYqOERAeqUH
 6Wvw==
X-Gm-Message-State: AOJu0Yz/0aW6zrOt3xUg4WD1TAXd61I/lH2iaUB3B0vBppUBSAK4yF0Y
 zmb3CVROKG5q/zsJ9W+wX0cmo0FC2J3Vq+29ewhCta9HqVE5tZncJFSO8Vfrbh8lJr08mpgem4e
 xI7xVM/9ty9g4zlG5ygFCE9qeeiYXA4qgVq9CFVCvfA==
X-Gm-Gg: ATEYQzx45R1vAjozeOrr1YDU+SPEgCgwTbQvKdB794EdzDvS+ME1p/0IY1SjIJA4Ji9
 X+YoZgtFAhT5IpGIaNEzV098ULhRZtOVYZAMzf7Nm0g03Qqe7QVImhwfSss707tdjzopVhTtDlm
 VJXQGdpOplId2UR9eqP018qPhduKvlPXQhjFdH0rvi5ZAZAQuUAqLtjpflY+46/Poz+wsLEL4kq
 4fmnxJWfoXtUicWTOfLGDm6D+RrCG40AUS9is7yRIuX3BULWpdYSel84Ek/rdFLQdRQiWYknQUj
 hsffHfFnyzZaKpbtjRXfaDNC1XKaC83sc7lM1bpEcRsnYeI10DQ8VA/ho3zB/hpk0xc=
X-Received: by 2002:a05:690e:11c9:b0:64c:ea3d:a895 with SMTP id
 956f58d0204a3-64d143328ebmr10473457d50.61.1773062350605; Mon, 09 Mar 2026
 06:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260306121511.1781020-1-kchiu@axiado.com>
In-Reply-To: <20260306121511.1781020-1-kchiu@axiado.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Mar 2026 13:18:59 +0000
X-Gm-Features: AaiRm50lO0Soi7XsE3nKxVr8yo96YK5qXojYbayLUPlM01_Vygr--B95nujsWuU
Message-ID: <CAFEAcA9jGP=W=C53u728+i9gkdekSCQHGc3aJKherqnB0A-OgA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Add Axiado SoC AX3000 and EVK board
To: Kuan-Jui Chiu <kchiu@axiado.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Fri, 6 Mar 2026 at 12:16, Kuan-Jui Chiu <kchiu@axiado.com> wrote:
>
> This patchset introduces Axiado SoC AX3000 and a EVK SCM3003 for emulation
> The model for Axiado SoC AX3000 supports
>   4 Cortex-A53 CPUs
>   Arm Generic Interrupt Controller v3
>   4 Cadence UARTs
>   1 SDHCI controller with PHY
>
> Verified the machine "axiado-scm3003" with following command
>
> qemu-system-aarch64 \
>     -m 4G \
>     -machine axiado-scm3003 \
>     -device loader,file=u-boot.bin,addr=0x3C000000,cpu-num=0 \
>     -nographic \
>     -serial null \
>     -serial null \
>     -serial null \
>     -serial mon:stdio \
>     -drive if=sd,file=obmc-phosphor-image-evk-axiado-github.wic,format=raw
>
> Kuan-Jui Chiu (2):
>   hw/arm: Add Axiado SoC AX3000
>   hw/arm: Add Axiado EVK board

Hi; thanks for sending these patches; this is just a note to
let you know that they are on my to-review queue, but it might
take me a little longer than usual to get to them, because I
will be prioritizing work for the 11.0 release (which goes into
softfreeze tomorrow).

thanks
-- PMM

