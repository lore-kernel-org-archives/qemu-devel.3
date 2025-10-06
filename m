Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B386CCA471
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 10:42:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5ifC-0004oq-8V; Mon, 06 Oct 2025 06:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v5if1-0004ms-Uc
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 06:41:46 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v5iew-0001XW-IL
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 06:41:43 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-6354a4b4871so5839067d50.2
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 03:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759747297; x=1760352097; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vwrQcCJGIbsxvMRi/b1fe24qLHYm9LI3TINLoCmsLMc=;
 b=t4bQSWbS/xP4RpK/V46JyDHY8X0mBi3sdXeeWn0SSwva/1lAKHBD9DCu5JMYgzQXR0
 q/i6+NQMv9sRY9aT9ytP8DhjeT3DiZApEwfV7nJqpB3SbkKDqkp6D534QSksDjBIg6Hq
 LXjh5Gey8b/8smZJi+s86+A5xqrgQsgf3XV4QWkEOMfH2o7BzL/Lq/bmVWBbxUl6XIw2
 IbutdHa2AOiqZEjVdYzcTkXgeDgM4Z0ib/gqrqXlyp6wfp02pxW7+MDdKZ7U3H3Fuowf
 oYWCwj+DArrWE8waChFk17zJACh7TpAT56vu814WPwGxb6KMuP15BvBsD5dSqfKULNKM
 4u1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759747297; x=1760352097;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vwrQcCJGIbsxvMRi/b1fe24qLHYm9LI3TINLoCmsLMc=;
 b=UyM+8LE5Ze0DH5ptpqvfVEVU8gn0DAyjUSJpsrsyOoDwDhYj6xka+i0vsmlATMsiNO
 UlY220U6I9AWWUSh0pHDKhLE+x3YYJefdwQE6IUjDGfp1ideXqhPMK2ZnN119AvwZqNf
 vbk3ToYXJnJsKxquZPvC89OZo7RZdVzolWzdvjpZrKCb12oC1g0J1bYj/D7xY1e0cp7q
 ppa4354pB20/8YODtAYEi/OOqMizfjMQp3M/+vR5HM2hJJ1Izjmj34PspD/fZYqO1BP8
 xRlQCGPsydmmxivMVJm7dZouo5pGHVv0+Kh9ytJQ52sgEsxh1B4ge1aON5ca7bWHWsDw
 M6ww==
X-Gm-Message-State: AOJu0Ywkg1J0Pz+e0ztyin9FIdOW687BfL7OoH2gAi98+IzSI1QTyYXw
 LTZEtPONCWe5zftE4714WXIoTk6NSAUSWyGUB59OCqmBlaNJ5MtjF2bPLNaumP9HRjI8vUn4KW0
 ihCL/YsV46qmPMJi4fn/uaKmn5sbMrl4ACMmpYQRKrA==
X-Gm-Gg: ASbGncsMToxXK0rn95kTaoMaiJ4YIVxxcXw8Gmrqkw2nrOJF4O5YfUxEZ44z4Co6O1a
 djWDO643tH5ksB73USwKfo6fAVXdTdLfs7t5mdkqqPn5zGuMXorBlNHIcqUrYSoPE4yPjSAe+Vx
 r9BZcUmvJL7sF8iKzwI7mRHau4qhv9D05p6W0RkzAJHTcII9YUk4k2Xb/mkqDkub3bWJzcuQu6F
 O4aT+5S0HB9od/BYXhCWNdbtxixwScBdVNdfHhxYVI9ysM=
X-Google-Smtp-Source: AGHT+IHMERTFx5EYN3CVOYqNP9Lw1HGa0Td0sIWgKn2ytuLOFeid3ejTjZUf5dSxY8/3eAbvuV97bsLfFKiYQrnFcHI=
X-Received: by 2002:a05:690e:686:b0:636:1bb3:2d2d with SMTP id
 956f58d0204a3-63b9a07fdf7mr8736537d50.22.1759747297216; Mon, 06 Oct 2025
 03:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <CC5A0011-CD14-40F9-8023-8BF5F989BCCF@gmail.com>
In-Reply-To: <CC5A0011-CD14-40F9-8023-8BF5F989BCCF@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Oct 2025 11:41:25 +0100
X-Gm-Features: AS18NWB7RZ1o_mn8Z-KGl28zNr88Ka_Hgag4hcQFKeBpYzqAoYX_71A_p7MS-eQ
Message-ID: <CAFEAcA_PbfzTAW2qeFao1MhPG=jn9dtzt0AzwL-aPCEULijsuw@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: add pvpanic mmio device for arm
To: Alexander Gryanko <xpahos@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-trivial@nongnu.org
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

On Sat, 4 Oct 2025 at 21:19, Alexander Gryanko <xpahos@gmail.com> wrote:
>
> Currently, pvpanic is available in three device types: ISA,
> MMIO, and PCI. For early stages of system initialisation
> before PCI enumeration, only ISA and MMIO are suitable.
> ISA is specific to the x86 platform; only MMIO devices
> can be used for ARM. It is not possible to specify a
> device as on the x86 platform (-device pvpanic); the
> only possible way is to add an MMIO device to the dtb,
> which can be implemented by manually adding new functions
> to the QEMU code, as was done in the VMApple implementation.

No, thank you. I don't want to add more devices to "virt"
than we have to. There is a PCI pvpanic device -- use
that. Yes, you might have to do PCI enumeration in software.

thanks
-- PMM

