Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F6BC3ABCD
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 12:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uESEP-0002kW-MQ; Mon, 12 May 2025 08:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uESEL-0002j8-GJ
 for qemu-devel@nongnu.org; Mon, 12 May 2025 08:26:01 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uESEH-00030b-Pn
 for qemu-devel@nongnu.org; Mon, 12 May 2025 08:26:01 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-7053f85f059so37501707b3.2
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 05:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747052753; x=1747657553; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1T2SnZt/Gi/wBk1n3wFUN8hbGXkVcClD7mk68AW6340=;
 b=BiBENz3+wzWKv+isqEyRK82XR5N4exKqNXx2SatOACQKu/BZILMcHMMu99RWC86/0G
 pzDUIj05lJ+5ToUD1r2nHQZj9Mm0Vs5tYMogT+64gS7pvPm72nGLI6ylGpcXCR/Bq3tb
 cK47KGdM6vZljeMIalUPoBbXHF6xBjA2vnH6YTkX7VsQNTc5Dq0U1bWJqXMv0QjGeiZO
 IAC5l3SPTFsWy7zvTYPQ/wpwDP2ZU0ghxzywuvuBHsWlUmWzhw+2wN60qwhuxXkffwX/
 lGV6jChZ63aRMJSEELbD8l/Ii1e5l5SDU/TPdSt22mqNMJfU2T4+Phr5OJ3Umk8fVgdU
 jSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747052753; x=1747657553;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1T2SnZt/Gi/wBk1n3wFUN8hbGXkVcClD7mk68AW6340=;
 b=WmgVihrRoAhq/yZCJ1bToB8SWPDC8NYJ4o8SLZUjMJYlP2vMb3Gwxkm6WqG830hImf
 ltC+q0nD+qOJGtEZxTyDVhLbnS4ps0PemnRz36dkt3pIeYTipLAku2vtT8ItFTeyq1BO
 j2z7TbXEfvBw8vU1XLiC1W26q8ngWsOVSgm6qA9NSsErECcHh9/2irzqpimo8bz6YPEK
 Zhe7vq8snqDnfy6cV2basRjjLOMbeAPjMR19EapV979x1cAsmm7VLDZgVaYO/NC1AetB
 E8mAJ/QWD0DZpp1w2m8vWvkdvtjYimXxPiDhW/2r2IUgICCtJ4mJ6VaXEoKSB96wmGr9
 7WUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZd/pDRi3+C0zfCHLnVxlhvXB7VkMAHEgOm7uDrqcVzvcamVfEkDJhavotv5G2QNWMMPE2H1HxvdF9@nongnu.org
X-Gm-Message-State: AOJu0YyOfEvkHvDAWXmlMexMNHvmWSpq80bMNXKMQJawCTwj7mIoQkEJ
 0izfL2N30ZdZ5zF/I48Plnk+uF3dpxqTpRMiOws15QXNAoVW4OhuPLLHrKWfLYUyS5OoH9wmbyY
 iEYRP6/yIWtiGdb/bkjz26RcnC9LBSWwO9fXoyg==
X-Gm-Gg: ASbGncszB0hMZkFeslD1VYRgN19784/Cjc2iVEUr6IYg2b3gHweBEbw2ctxucxKZS9B
 R4x0R02nwdwTOv6YONw0FPuO6ddeNIeVh8mSREEzc5XNBzrtak89JCa4RFBeJe2ftMcwAZwqB0v
 Kq8Omry6x5QyCwAvkXFMgIaCZ8Po82/yxDpg==
X-Google-Smtp-Source: AGHT+IGUupOOvls1aFofqONW6coAArv/WxNSSxStlqhid6mtQBV0l8vd45fjshPLnKtiD4XDjofcwieVQiWwBHiyNU8=
X-Received: by 2002:a05:690c:2506:b0:702:5926:8609 with SMTP id
 00721157ae682-70a3fa261acmr160720907b3.12.1747052753081; Mon, 12 May 2025
 05:25:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250502033047.102465-1-npiggin@gmail.com>
 <20250502033047.102465-2-npiggin@gmail.com>
In-Reply-To: <20250502033047.102465-2-npiggin@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 May 2025 13:25:41 +0100
X-Gm-Features: AX0GCFuCVPs3qMJBpToG-1G69TSD-nZ-9ZpOODp85IXcLyqFbG4ZMkYID6X3ViI
Message-ID: <CAFEAcA_AJxm3iTMeNPJd-M1bU9D5b3kQr54CAqWutR_E8=Zqig@mail.gmail.com>
Subject: Re: [PATCH v4 01/22] hw/usb/xhci: Move HCD constants to a header and
 add register constants
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>, 
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Fri, 2 May 2025 at 04:31, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Prepare to use some of these constants in xhci qtest code.

This commit is doing more than it says in the commit message.
It also:
 * renames some of the constants (mostly prepending XHCI_)
 * adds new constants, e.g. for the register offsets and
   for some shift amounts, where the original code used
   hardcoded values
 * makes at least one actual code logic change:

> -    case 0x10: /* HCCPARAMS */
> -        if (sizeof(dma_addr_t) == 4) {
> -            ret = 0x00080000 | (xhci->max_pstreams_mask << 12);
> -        } else {
> -            ret = 0x00080001 | (xhci->max_pstreams_mask << 12);
> +    case XHCI_HCCAP_REG_HCCPARAMS1:
> +        ret = (XHCI_HCCAP_EXTCAP_START / 4) << XHCI_HCCPARAMS1_XECP_SHIFT;
> +        ret |= xhci->max_pstreams_mask << XHCI_HCCPARAMS1_MAXPSASIZE_SHIFT;
> +        if (sizeof(dma_addr_t) == 8) {
> +            ret |= XHCI_HCCPARAMS1_AC64;
>          }
>          break;

It's really tricky to review when you have a single
big patch like this that does more than a simple
mechanical transformation. Could you split it up, please?

thanks
-- PMM

