Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD7DCCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 15:37:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBEPm-0001wH-1o; Tue, 21 Oct 2025 11:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBEPk-0001w0-AH
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 11:36:44 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBEPi-0005KA-DX
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 11:36:44 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-63e10cd6efeso5507695d50.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 08:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761061000; x=1761665800; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BhO+EL2rp3xRGrAorTviBtcREoQQpVtKTK3qqKUTnX4=;
 b=m8MZV6bgbxFJpDr8h234ybo6HEQ0ucxl5N5Ts1VOLW38NVUdwsxv550cBV/GdCsqMw
 Tujrb7rYSVljfstSxD9MmNyD8d6dunYwUPHAD9ybsWlDAnLfRynhBxGnR8GIhwIccap+
 WRBudveghQAxg1u2OkHVHYEK0EU2gBO0hmm3v77lxRfhuMNVKIUbnVcNJk+LnGxeudX7
 I2NmbPcGTa0uQ+PMzRyCZiJvxHB68oPh7SlU8s9tP36y+mK/UTQb4E7I0VD2knp/60Ng
 yyvGLKmIoDOvu4CNkrcc+KYW7VSwY2RvXljQG0tMrhuwimDzdlDiiXO43WMeYTE3kxA5
 gHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761061000; x=1761665800;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BhO+EL2rp3xRGrAorTviBtcREoQQpVtKTK3qqKUTnX4=;
 b=niVh7AF0wzQgJsUDGSV3Oy4VzVIEjGRz1Haf+oDKfGCiy0M2Z080gz9Abjen1cfGKe
 ZsWRXgROGZLwtazRPFbO+9P36I06OBu2TiaWtxDDauzndS0MeQSZzWJ4v4mEYagvRLT0
 jmzQlrlAqviztZsg1if7qhU/nc9/h6vd31o5YffRLly8/L1TeV7pDMyJ0NuRp6/DXTwl
 0RDFCZwDYxd/lVqypPKgYEyQG/+wkCMynoQ/TG8nVnCvg5hySGTbSbz2KgBjW8Hf1zkt
 cQ00SdcRo0XPQUcmb/Q5RkoxPzpgkL5XE84/Jw89FoUg8Yv92UpsouiQgz1EWRmvcxRq
 thnw==
X-Gm-Message-State: AOJu0Yy+OThF/FHelEJ6ykmf06gBdvm6iIP04V7oiwYVkY+aaLKAvdzP
 Nqe6Ri5ygxnXMSCbxC4ra3OcQuZnQBgGl8/KWz3yshPOoF/GZwUi0jbM7x3TwRJUX/HUKQdFgBn
 ObT7V9iyogIZmoENRl7J+9h46jUydna28NnieY8eqSw==
X-Gm-Gg: ASbGncueFvvHNMsUMSA6XxT+H98w2IKvyo/l5WFc/KuGpiieuwoJa0wAnWxlkIwbu9J
 SlncyYWh6PdFRnzoZtpcUtZCx/9s+M3TeGHLWnKr5sU1xa5m44wWySu9QEv9xlzdDJbNJGQjAof
 LLPCrSdLYubIl540MURQIbHKSCthm5vx5CoFBf3XEccRIVMJzSFVJML6UotIv+HbCHSWuEaeufN
 O+dbQjVnsX2TdLvbc48IBoxjj8ylzYs2E4TD1Me/ghVaLX43rlRw1GJot4Cqhg95ITfod8s
X-Google-Smtp-Source: AGHT+IHgYLyI6SB/jy8gLWW8NicF6oCBSWN1os9aImOUnbEt28AIbhGZ7XME0WFHrpV9GLbaF2tyyWdgkz+UDyWDZqc=
X-Received: by 2002:a05:690c:10c:b0:781:49b9:a79f with SMTP id
 00721157ae682-7836d381650mr262223107b3.66.1761061000344; Tue, 21 Oct 2025
 08:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250311125815.903177-1-npiggin@gmail.com>
 <20250311125815.903177-71-npiggin@gmail.com>
In-Reply-To: <20250311125815.903177-71-npiggin@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Oct 2025 16:36:29 +0100
X-Gm-Features: AS18NWAOVrENKdxAc2A5WMRE88aOVkYmA8vQgxzSz7MsseEpl7dZlO5l-EXi1hg
Message-ID: <CAFEAcA8pgga4g3yex=EsfOOC7SVaAccOs-CEjzYmb0XCY1H-Sg@mail.gmail.com>
Subject: Re: [PULL 70/72] ppc/amigaone: Add kernel and initrd support
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Tue, 11 Mar 2025 at 13:24, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> From: BALATON Zoltan <balaton@eik.bme.hu>
>
> Add support for -kernel, -initrd and -append command line options.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> Message-ID: <489b1be5d95d5153e924c95b0691b8b53f9ffb9e.1740673173.git.balaton@eik.bme.hu>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

Hi; Coverity reports a memory leak in this function
(CID 1641398):

> +static void create_bd_info(hwaddr addr, ram_addr_t ram_size)
> +{
> +    struct bd_info *bd = g_new0(struct bd_info, 1);

We allocate the bd_info struct here...

> +
> +    bd->bi_memsize =    cpu_to_be32(ram_size);
> +    bd->bi_flashstart = cpu_to_be32(PROM_ADDR);
> +    bd->bi_flashsize =  cpu_to_be32(1); /* match what U-Boot detects */
> +    bd->bi_bootflags =  cpu_to_be32(1);
> +    bd->bi_intfreq =    cpu_to_be32(11.5 * BUS_FREQ_HZ);
> +    bd->bi_busfreq =    cpu_to_be32(BUS_FREQ_HZ);
> +    bd->bi_baudrate =   cpu_to_be32(115200);
> +
> +    cpu_physical_memory_write(addr, bd, sizeof(*bd));

...but we never free it or keep a pointer to it.

I guess we can mark it g_autofree ?

> +}

thanks
-- PMM

