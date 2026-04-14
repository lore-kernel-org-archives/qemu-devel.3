Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 858E2F9D0D5
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 15:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCflD-0007pO-B1; Tue, 14 Apr 2026 11:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wCfl7-0007nm-9G
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 11:33:04 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wCfl5-0002GE-0N
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 11:33:01 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-651b6a003f6so1690290d50.1
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 08:32:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776180778; cv=none;
 d=google.com; s=arc-20240605;
 b=lvO7Uvf8cHFgqJ4IBK7Xwdx1wKCOv1mgVkn3BKA/9JVDEinu7ZSl5US9hRyaglHej2
 6AsYBoIw6POfV6NOAelb6h4om9KPbv3cjMVtdCoiK5Ft1N+92WL4FVVuwzCBEQHyW+nN
 QsWpCVWmBaMdrU0zQR5z3tSNBAdT9GB37t4/wEVaPTpecSVCLwNV1h7NrR8ekfFsDzky
 jHMaTAHzz+Szil6aNwBW6p48Z+o2teABSdFabVLvvwBkQCK9NN+Od81IAMzCzyoA1jfI
 cwDAGUUs24JmH88ewiuasaxSVcBW8WyEaP9mkNru2heOHYi5qeBX9W9BTfhOwvYWrrEF
 ZK7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9XcKb4ic8SZ75FN0QhdHOTzfREVld7nJw/v1GdoJ6P8=;
 fh=BvMs5h2lmtYS+BY3Xnbys+9+pOQ38go/MYZve7QKXuM=;
 b=SQjPngrzktveDViSMHxBa9s4NYghBmhXGijnWOB00USaaMhDcBjGLOZK1Czz+uU7f+
 5opwG6jvxSErkXk49YLdxWii3fUrmZ3nkY0Z++U97ZJbUQk4p0rxzHrua2PTG3SLvrmL
 uUPSBEbTsbiIM3Tjdin6ApRwx67d5SJs5F+qOwZK+rmJxC1asVkjrOd6HmonzOZxT9OA
 U5BrJNvA124EXagkvKjBjwTo+h9qnY7IVPmIpRJWzg/fQcQ58LomUrZG4cz0CEUCsgHD
 YMyFqZ1cGxZuiialn6wZS9Sezqw22Z+iO/W16aidaWH79edyeJGpLyYbH6Hwzr4+IIm6
 9/ow==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776180778; x=1776785578; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9XcKb4ic8SZ75FN0QhdHOTzfREVld7nJw/v1GdoJ6P8=;
 b=KzBw0YJK1oskrXZ56i8+otH1DRa9Ave6xRUArm/8HjxC/gR5lXFiOfkMyWLHjwa5hQ
 tnjQHp11vm+QIYdLrXyaizLpUpGDgbg4ZHSiiS9wMbHwGlJRYRvsJy7BKfkPtReulfde
 4GcJ3clO2s9WHRqKq47HPAy98fZwZ3zBH9h07QXgvty3EGWXtjo1UuIypKHOXOIPf9Jz
 //FFWt0m1jktldSZYPEcM4gBc849nl02tM11b1H6hHHoH22hG3/96hae02cDfXD/1+n7
 pxnID2RK31zRh2R+akWoDNrb7Q8mVSiUVI+Yf//va7j/uFQtplBLQny625nYwRJ1WmZJ
 N+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776180778; x=1776785578;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9XcKb4ic8SZ75FN0QhdHOTzfREVld7nJw/v1GdoJ6P8=;
 b=n6GQ7RSlc+gYZjXaGP5wuykpagd5rU70O9vxQCZS4JMEoGW1uVqLp+NR+plt5XNW5D
 V5vgIVIANgre+1XN7yP3jc5gp+dEyTCe1qJgT5oNH9PNAQ636nhzaoin91CZfl/vPpsF
 s58pU8BCatMioUzSC8Wbbs1xTlax8tHOQ3QyXg23Xf9f5UvrQNc107E+XAhJ2QfO7252
 E5npkQuVj8dG4uPQc41RdVCywBJ+7vL5P0scbZeT1v6SdvdvaUJLLqhYorF2u3OGiB4N
 7w0Vh40DCwZPjQeoQNF9lgE8oahFtxbRtXg/QNvo5CAaozHGxUKNAxDkKvYIBZH1h8c0
 Nysg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9S/rrPrk3P0uAtwxwK5jXjWZl+unq2fK7gJGZomj4l4ARQnQ9rA3c3B30PAtIXFv/kTyLEMsWhhx4E@nongnu.org
X-Gm-Message-State: AOJu0YxxQqtGL8yIDs9CH4x1ESFqICRSACkXfEazbejG+udZqNeJRjZc
 23GGaORXTW1+ZhPiD70QGD+Z9aGbgONlHGezpj8xyi+yHl274cK2p6rj8vUSq+oLG78rJLg9uWx
 OC2SPv4TdZ7+Mygov8NhtIJXgH+ZJnL9Q98JogAl7fg==
X-Gm-Gg: AeBDieu8JUS8HmZ6siGIFbPzVuIhx6oFsmJhwxMM2NPhjaBGARXXDC0RR0J7gINAntv
 NLo8hyGh5hPKeQoEI7tBteUxnlwXT0ZWtfeZ5cB/+lALuwOgUflC+F46UUCB+HPBnmHlP89J2u7
 51fYVsN6ww6JVy1kl47f6P1dCB3IIvCJLgwmBTmd8LQtQxeS0k/1BMC2kvewIULJy/H3bCgLPBy
 MCzOgj8TRrFGHolQ3QqALmxnUPebVtxIKjWzizzhQdz6QZhadk7cmPfPJotiHHciDWsIg3MK4kX
 3ZVTGtrn/ekStW0TbCbPwyrOCRFGRQ4r3WaqphSQfVQqvkfQrPuZzLEjKiMqLTg5bic=
X-Received: by 2002:a53:bc05:0:b0:650:814:8124 with SMTP id
 956f58d0204a3-65198a88374mr12857206d50.17.1776180777436; Tue, 14 Apr 2026
 08:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260414045911.63662-1-anisinha@redhat.com>
In-Reply-To: <20260414045911.63662-1-anisinha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Apr 2026 16:32:44 +0100
X-Gm-Features: AQROBzAtyFB4kKPLg59FH9PyakIZxRSXCgPUtK1ndhEU2FujvTw9Ai7FAomvh4M
Message-ID: <CAFEAcA_Yr1y2fHmMSmcKm8N=_s-VcoFYsSa0W-+nROg-Mk0Dew@mail.gmail.com>
Subject: Re: [PATCH for-11.0 v3] accel/kvm: return early from
 kvm_irqchip_create if kvm does not support irqchip
To: Ani Sinha <anisinha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org, 
 Misbah Anjum N <misanjum@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 14 Apr 2026 at 05:59, Ani Sinha <anisinha@redhat.com> wrote:
>
> During refactoring of kvm_irqchip_create(), the refactored code was returning
> early from do_kvm_irqchip_create() function if the required essential
> capabilities were not present in KVM. This was not translating to an early
> return from kvm_irqchip_create() as was the case before refactoring.
> This is because, do_kvm_irqchip_create() did not have a means to notify the
> caller of the lack of required kvm capabilities. Fix this by making
> do_notify_irqchip_create() return EOPNOTSUPP error when  capabilities
> are absent and then the caller can check the return code and return early.
>
> Due to this regression during refactoring, all KVM guests on ppc64le hang
> immediately during startup and this completely breaks all functionality on
> that platform.
>
> Fixes: 98884e0cc1 ("accel/kvm: add changes required to support KVM VM file descriptor change")
> Message-ID: <20260413090010.60339-1-anisinha@redhat.com>
> Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
> Reported-by: Gautam Menghani <gautam@linux.ibm.com>
> Suggested-by: Fabiano Rosas <farosas@suse.de>
> Suggested-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Tested-by: Misbah Anjum N <misanjum@linux.ibm.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  accel/kvm/kvm-all.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Thanks; I'm going to apply this directly to git so we can get it
into rc4.

-- PMM

