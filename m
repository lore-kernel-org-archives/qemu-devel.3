Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D96EC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 11:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfcEX-0001aD-Qz; Fri, 03 Jul 2026 07:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfcEW-0001ZU-Ba
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 07:39:00 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfcEU-00070P-Tw
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 07:39:00 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-664d910cc75so510771d50.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 04:38:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783078737; cv=none;
 d=google.com; s=arc-20260327;
 b=k10JnolwqbXHBqkjIa9suudHHO3pYuLFOpOJYJAJY6pkSZrDroh5uU3n1XtWcKD+36
 F3HLt05CqJKihjr9k2F9Avu9+Qw04pdYnKl5Gszb8TWxGV/NnA520uC7jXv/H4QubXOF
 +WnhGP7uhZbw96CkDtKRpcY6H2qYUGkenwbLw5DYX2B7zWwb1NCzmSu0BMwY6i0/aqAq
 et3mVLHYXucEmeFhFE8KERgTRAwl57JhCGSheCo5IavQWOE1Kr5eFlgy/ERvTzNJQTaO
 KDtHu+OcKL9px7I2wZbdZztpOfhybAAuNLp5Cs5t2jorDUPVd53zISJ5kciSRK0MXQRb
 Radw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ESAkZY9kUQZRFrUWImfvof0NVQ+5tcC2Oz9nhd/9bPQ=;
 fh=sa54kRfqZCSJoqqovfbLshesdcnvoIzhJ6jhb/uDQ0k=;
 b=smQnH2U9/q3lH5zszRbV5DSkQY/kvuc+NJRlCMSKnbfh4UgRKUn8csJzahe3WV3AkQ
 amuB+Ni50eZNOkcVDKevioSPpJbnjljgU3MZkeb/yubXk1hjL5KsC9LGEf6o0S3uURQq
 L12w9NojRL2wZ+0ubEfF6EImKZ7xIf+wssV6l7oTSbQYXHEITbM8DjOUQJmpFHS2AZlg
 SEo7Ws5Liz2VWLtCW9TPb/P0GQDKzjVefAn8mopnQ4k6mRHLwCSrvSGTKkcw/WIwEV2p
 nS5itqg+m+vzMhJunBcG1s2BoiJJSTHoNX+MbDJOOFHagTqJQ6HeFUl/M2v9n0X3MV8C
 Qpvg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783078737; x=1783683537; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ESAkZY9kUQZRFrUWImfvof0NVQ+5tcC2Oz9nhd/9bPQ=;
 b=IouHPlhQLUTr3iWQcuw3S3HP1jN6bHqdBfKfBfX3lqtCjvVtzvqhisD0ZllWRmRsn0
 5M/Knc98PWSJHgPY8bwYintJbcPqKg6ck9COXxh/romJLDOdxPjT5F/bMmJAGlibRMrW
 z3jGCEsROnHde1s7+GvRoJ+ichTTkKLfF88PJpEU6qYzbAArqi+IGoj/JA15K+y0r4Jv
 gfkGPQEuP8kMsvwAAMffKy5vG0IgP0ziRKaISiOtymWxxnC4Da4GNe/j2MKKvf6JyfoW
 tuGcvH/8QOKK9BnD0PtdK1VaK0M3gtvpvz55h6k2Kk0uxjdZvbO/0fSbqtyJHOY71/Qy
 aZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783078737; x=1783683537;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ESAkZY9kUQZRFrUWImfvof0NVQ+5tcC2Oz9nhd/9bPQ=;
 b=BUNPnSIcNFlgiDj0epRvfV3PrUsxaemX3cZYdO2OAt7lVfrYbH0KgMyB7k2BqIx9UU
 T/tOZpk/MZcf3zhyB4I/+/gW6O7Z33GSOx0jxq5r3aG7Iwyetadgg+q2ZLJJvLZ/G64T
 yap91X6DMdSlNQ4beca3+x4F7tIRGWc5HW6GtAcuer8PGhtmT5L6gqOd5XFB7GrLwxeS
 eYo9hqXKq0iPC5JiGUEuGt37tE3HnkVNumsWSj1W4sQBmaTq9+D9F9NNhrPQK5RidZSB
 UK8x9EgIaBP5uAAdp7zrgstU9YpN+KPYqAoOD/kqkfwZVteo/kA0OR5IjO0TSr7BkVPk
 JdTw==
X-Gm-Message-State: AOJu0YzjyQow5hrZq8Z71EkQrodvr9nnwkVzBnDdVqe6O39F3UaLxh7z
 P7o7Aj9j4eXDQQBQCkfyf8qsspBkPN2g9RLZA4zq0qFFyAHNVbmDP4S/ujduPbnFETqvbtXVxwu
 YtIIVo3CiZPEMfwDf2OqgDXWUhK4vc6Xf9ymxgE+57A==
X-Gm-Gg: AfdE7ckNpXQ0PVlY5ftPXrOiuV8t2OeS8z/0OPg2XFon7Qv5paDHyXc8PhIBCos/b39
 bX9Tczz0Zu2frME5XBn7Q1lxualfaElkD1uQoeIQGhHy/MYjbwyyn2SrvxUM5aTUAqeHiPGX6+1
 ZdNmu5n8qS1WGieRO0/5Ic1jx1HlxNHZrZIUdE780de9yOp+a4Z7SVgQjTwb0nwM7YgH7Gp0oh4
 BZpTYbmIEShq1d16XKnFlwjwKwjLoS7OtMXEanH8BWZzjrh7lzKUznGtnw2KtyBR0ZFJXP9lKBt
 qZhc66wA9Y4awOQIDo8sAzZr0M/cjFV7Mg3c9oI/ulK4IV1e0FOLQAqD
X-Received: by 2002:a05:690e:169c:b0:664:c3aa:6701 with SMTP id
 956f58d0204a3-665966b284fmr8882425d50.62.1783078737368; Fri, 03 Jul 2026
 04:38:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260622060507.83195-1-kchiu@axiado.com>
In-Reply-To: <20260622060507.83195-1-kchiu@axiado.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2026 12:38:45 +0100
X-Gm-Features: AVVi8CdqE5HesgG9XkSgNZMh2VjMjlJrI1-r_iGIOpK7tGts463cgJtZx2lCbK0
Message-ID: <CAFEAcA9aPwGf9acMvBMON+mNU+uyvMs33wrmAXxoTFR80vi-rQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] Add Axiado SoC AX3000 and EVK board
To: Kuan-Jui Chiu <kchiu@axiado.com>
Cc: qemu-devel@nongnu.org, philmd@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Mon, 22 Jun 2026 at 07:05, Kuan-Jui Chiu <kchiu@axiado.com> wrote:
>
> This patchset introduces Axiado SoC AX3000 and a EVK SCM3003 for emulation
> The model for Axiado SoC AX3000 supports
>   4 Cortex-A53 CPUs
>   Arm Generic Interrupt Controller v3
>   4 Cadence UARTs
>   1 SDHCI controller with PHY
>   8 Cadence GPIOs

This causes 'make check' to fail. Please test this kind of
thing before submission.

Hint: running QEMU without any other arguments crashes:
 qemu-system-aarch64 -machine axiado-scm3003

thanks
-- PMM

