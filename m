Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66636CCD1A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 10:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCFEm-0000vq-46; Fri, 24 Oct 2025 06:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vCFEW-0000lY-35
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 06:41:22 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vCFER-0006TZ-Sp
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 06:41:19 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-785db6b7484so7783917b3.1
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 03:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761302474; x=1761907274; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UNZOXNjNOa+0RMSkjsgHycnPmn/M+Yfs+8PIWi1Yi/k=;
 b=YXX2jkicmW9gTUrzEiaQ+U7xsoTbUoar8wvOi4BDryc+Ev1QBxrSZ0gAGYoS+hmua7
 DXIV6M4ZUQJe0Xh3PdmwYxMHNGKTVVkkeaqyYLWrplHo6WYV5YST0gUEwDmlfgy2ILNm
 rMQ7TQE/6IklbfgSSy0QZuKRamvgi6JaCmakkGMFni4X8E3+4mm/c2jkT5P4+cpLvBPO
 sN0dL2Kfyf6q6KTTt/9dPRzHUx7MwDBXzBZWAguznZFRnnF8H0uXa/UJgL31yTLYJ62G
 akKDTGNbNcqq8kegtyxQAsCe3XIRqIDw60xRK7Pwmi7zIAz9Q4WOJM8qfWWGqdnJkJjd
 Pc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761302474; x=1761907274;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UNZOXNjNOa+0RMSkjsgHycnPmn/M+Yfs+8PIWi1Yi/k=;
 b=k0BxyTCKkJMfnqoGyTbfJrCE4DHVlgAp/+sp94pu0ESIP33HMXNiJ2FCoBkpi2Iy4i
 2scT3c6fDCKWAvpWlyaN9Mjn5e27Vgt5n+nQDHjbC6NB8IQRtF2MsHZLrjvzXnmvvXh6
 vwX+8OciOWm9p85H8G1Lgrwkaf6hhC0bVbdZOcYrbR+aWL/lnfwwD6eU8gwAeiI4V/zR
 cYGiHtah1kMuPPvV/WwY6dBu14mO79dEpQHjeYITS0T9d9eqi+JRyG4Myj2/ywxGYVak
 JTyFZkS+NjwUbBZRlQjGBAf3+zGqZ45hodKu0fNq4SL2posZxTX+WXw8x8+mYQmFDoB6
 OR9Q==
X-Gm-Message-State: AOJu0Yz6+VJqa2ZRu6RoBgzFcOf7HRuHRWNk1wzm/tQEP/FIztCNZ6uB
 2wmB0r6A6K381MEjDdJ7nApzZXkkLMX3y0jHebNE+m7WecEJ/RYMSeBoAOFKKb4DBTOHcsfXANd
 6yWrbuBlE47Xy3uzgXWAqjDLcRzyO8TD8Ph7AHM29HW5ty8Z7yaV0
X-Gm-Gg: ASbGncsP7QvEXTLklGvNhgiBQmx4VPPsrv9CiCQ01vK+LYkKduoXYx0/XudU+6+PFIv
 w/c7s5oW9q+clrFo39AnpeSdiF2T5zVZhfDm497y06ZHJTQJh9e82kWAr05DrS8lsmOrdbTGafq
 9TKrR1OQwc2IEbTrH3di+dYeZUzuxpJEbfVsF3ApXbs09PIh15+paTYYeIJV3SPxxhhzBcMMruj
 8n78reYy4Y/ElneGGB5rwjjqGOekbm2vW4qdVzon62B7zT4gQOYR76TCagpLg==
X-Google-Smtp-Source: AGHT+IESBr8Hl4Wse6g7pKDMsbrpxzlz6MaRDR9bQwBwoA3ifQxkFmgPklbM/iE/6mH3ZIMBYkSqaCcINzZj7N/dh84=
X-Received: by 2002:a05:690e:4149:b0:636:ca97:d6d4 with SMTP id
 956f58d0204a3-63f377f6ad3mr4289708d50.20.1761302473759; Fri, 24 Oct 2025
 03:41:13 -0700 (PDT)
MIME-Version: 1.0
References: <20251024071918.228749-1-pbonzini@redhat.com>
In-Reply-To: <20251024071918.228749-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Oct 2025 11:41:02 +0100
X-Gm-Features: AS18NWDX1Y9Zm4QcGBmFhZxmmUgnhvfYC48Uidn4-KSy-2KM1Y6UNe0K3JWFeFM
Message-ID: <CAFEAcA9JQCU1K84+Nx_oqqPjVBWaf5ipdEQP64vxLZ3vfoumcw@mail.gmail.com>
Subject: Re: [PATCH] target/i386: clear CPU_INTERRUPT_SIPI for all accelerators
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Fri, 24 Oct 2025 at 08:19, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Similar to what commit df32e5c5 did for TCG; fixes boot with multiple
> processors on WHPX and probably more accelerators
>
> Fixes: df32e5c568c ("i386/cpu: Prevent delivering SIPI during SMM in TCG mode", 2025-10-14)
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3178
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

This should be
Cc: qemu-stable@nongnu.org

because although df32e5c568c itself has not yet been in a
mainline release, it was cherry-picked back to the 10.1 and
10.0 branches.

thanks
-- PMM

