Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7785CD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIVTM-0001uR-Pi; Thu, 30 Apr 2026 13:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIVTF-0001qn-JK
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:46:42 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIVT3-000371-Ep
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:46:39 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-651c5d525f6so1094988d50.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:46:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777571187; cv=none;
 d=google.com; s=arc-20240605;
 b=JHoA8laj/ugoLXX/u+6y8KhA+ZwFr0XUzpv6DsxiFkggX2SzD3mjjcIr4WfEFQr1/q
 G9+lf/9n7pX4+QH6VMVS8+Kkv79xGioXS9XGkWmKuWQaSIukAwf67SUDQZ+yAjtmaC6M
 QSdNjGSaj6uLE2JKyb42u5THDrX0BO4BYID4AWdOYwtKcAGhPVvyjYlTCj6QY12A39pm
 8t4t44N37oqPVwVO/H/2hMrvpZLoz4/xMB7GRV/YVmhzILLhi/PJj8z8djogMib3F41c
 Az1bzNZqynxyshvNzXsl/PzyFynRKPncD+r5Bsh7csMdgwWXoSP9XJNuKmUaOAaetHRb
 asVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VXhKDBVSrNWVdYMGuEbCrz4gNZKtic5H2J/y1kj/Ah0=;
 fh=Y56ORpsDzrlZrUHidfEj9AF4dptKkL2zAjRbgZS6E4E=;
 b=JVshoyE4wp2EfuITkcIZad8QCnMwQQd+BLGsZpjx6sd60ZQaNdPL7jdAmG0isGlyaE
 IJgLf4/32d06BKibPxjx+DsqJFLODnLFQsDA/1G5eUJmXTicUY3V1UWflmVYOThEOCpt
 LOS1x8wfZ/9H2JdX1MSzqpbSN9URPt8PHclB03yciHgBuwQ+hr3AHYsFZtqgtGlpB9M1
 cq4PAOq/KiDIT0LCOvOsKR1mgG4KIKTVxuiMh3ylyJzMYU3XVSHJ7hWzs3pP2ZG3OU7r
 yORBFByXPTRLI6iHZbZh46TyR7stARTCq295AyXFIQjvsHZlyfl0d/wju+s9cif0rJrw
 qXug==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777571187; x=1778175987; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VXhKDBVSrNWVdYMGuEbCrz4gNZKtic5H2J/y1kj/Ah0=;
 b=eMWdgK7m4Lg3QVLmimxtkK6FUdiazDIi+nMdQBfJXHa6UsjZpMRUw+sBzU0yqkn1+K
 GDuDnoMZwbleQgb97bGPtAj9W1sslfmeLhYdyM2+vSn3PqIKWz1AgUYwj8x7JpnbQsd7
 OSsOjgWuw20z1uiOJq8liKMX/YvXQY6JeAmI3cPq658tuTf6HQ4zqWePBrsMGb7KOlqr
 F8EyLj668E2tCaQHvD4Q/iBYD/oJ6gAFAJXyEBS4ybQKZQ2Zz90NhomliS/w643ozYHr
 OwuGKrgRJEru+0x+pVT7KC8LWbUD7Xg8OPPjUgKKMR6D9Kt7XlpUj26dVnf3PjQELd5b
 Zerw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777571187; x=1778175987;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VXhKDBVSrNWVdYMGuEbCrz4gNZKtic5H2J/y1kj/Ah0=;
 b=bBYbQg69gn84a0vxXDKgXDs5tsckEiyPB4y6wntP8s4NuIDX11fImjxNZHI7NXTnKg
 9k0oUD4zTcrxSOiBGN04JcOsOuXUtcb1T+hse0D2pb5SiLiPi8cpXhyGY0RxRCDsEZmq
 /bfhzaRZfTB7sUMYVGHNv45PabzhtX1+8RwcvCT3yZp1Fr/YfWAJ9+qlABq65tKcPT1I
 Icg+z116sTGG1uhA+m5AQY606rKGxTYPCxaN5UD8DhNW+zCuG2enumUsoJnbEHRiv5TL
 A3NTNQeDchIke7mndFs3wb4KaRseYJ1Xzq8VdlT3f6Xduma+dss8Ln51FJ+9V+uUzLBP
 lLpA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+TJqsA7oJnvzjrKURYIOZv5GiQpz7151amDDOLRktsBnr3h+m9Qnm4zDP2Pgan/sOmkHFSbb7Xefs7@nongnu.org
X-Gm-Message-State: AOJu0Yx/BokSwckLMDGqwzJe8wgfqenTwskjdxVoG7KgF0PdoYUoNuw6
 yYzUdJdaPIWt+cBnNaHLCxlluoMCqCSu0CKm8LF1pweUKeEiq2wtzEb/VwAIvakmKsdqCM68/gg
 eZmoD/jNGPSWQI8vhg6IYjE6zofCXTrzNGCilealHKA==
X-Gm-Gg: AeBDiev4LK/i2xb45dW1vgrsR3KOxyoS4JAwyLQc9iIWiOTB7joJsG42E3zJ+4xHfLz
 fTwcYDe33fco6y7a8BwEWOAP3A7o06NwZhWt86T4CMMSu0mxVjnayI6pwhJ6inFJy7lhH8BBgD6
 PAv2TpZVLLaneebb5wmYkj+eZdom4gZv3P8P2pLHJ7DDwmKSUAYnWLegwFPcvLYonwbthx16k8T
 L6wnLCXdHjmk/Brs8u3X8Bilor3Ji1m+aNOvy/1tRWxqGTe1nMSXmcTWSrLj5WZVIWdrOoD7yYc
 CAWuYsL2VFY7Cl0TLU5zKLzBYNjcWP0HorKJYKVbqPNKbUY00s+baxOfFToge/7LMPDE1c+sg9i
 SJg==
X-Received: by 2002:a05:690e:138f:b0:658:9bfb:602d with SMTP id
 956f58d0204a3-65c18dd9a20mr3463259d50.38.1777571186650; Thu, 30 Apr 2026
 10:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260430162941.584960-1-mohamedaymanworkspace@gmail.com>
In-Reply-To: <20260430162941.584960-1-mohamedaymanworkspace@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2026 18:46:15 +0100
X-Gm-Features: AVHnY4I1LD-X9to1Ir74s2Z9GDaeD4qHHAmsY-brWPkW2JHEB-U9xiNE8gx_EtU
Message-ID: <CAFEAcA9zPTngrm4ZG3t96Rr7bKRrmx7MB6-0QSjd=ntj+X0uNA@mail.gmail.com>
Subject: Re: [PATCH] bsd-user: remove cached host page size and rely on
 qemu_real_host_page_size()
To: Mohamed Ayman <mohamedaymanworkspace@gmail.com>
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
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

On Thu, 30 Apr 2026 at 18:08, Mohamed Ayman
<mohamedaymanworkspace@gmail.com> wrote:
>
> The bsd-user implementation previously cached host page size and mask
> in global variables (qemu_host_page_size and qemu_host_page_mask),
> which duplicated information already available through
> qemu_real_host_page_size().
>
> This introduces unnecessary global state and potential inconsistencies
> if the host page size is queried or changes during initialization.
>
> Replace all usages of qemu_host_page_size and qemu_host_page_mask with
> qemu_real_host_page_size() and derived expressions, and update all
> alignment and masking logic accordingly.
>
> This simplifies the code and ensures a single source of truth for host
> page size handling across bsd-user memory management paths.
>
> No functional change intended.
>
> Signed-off-by: Mohamed Ayman <mohamedaymanworkspace@gmail.com>
> ---

This would be a nice change to have to the bsd-user code,
because it opens the way for us to rename qemu_real_host_page_size()
to qemu_host_page_size(), and similarly qemu_real_host_page_mask().
(If I remember a recent IRC conversation correctly, they only have
the _real_ infix for historical reasons and because the bsd-user
globals are currently using the more obvious names.)

thanks
-- PMM

