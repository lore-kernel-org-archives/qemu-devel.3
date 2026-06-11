Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 643AFCD98CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 15:05:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXgxU-0004L2-BP; Thu, 11 Jun 2026 11:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXgxP-0004Ju-NB
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 11:04:35 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXgxO-0000yh-5P
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 11:04:35 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-660e9ff0587so3603305d50.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 08:04:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781190272; cv=none;
 d=google.com; s=arc-20240605;
 b=dZOJwj35OzhGu45fymUTVQAhoBmX84ZiLkbqM5yYmQlbJrfRphrk7MZlnrGFpUTU6K
 5u49slqsRqpxxdTlDTI1lW3MflAp/FfzqwmnvkQBTqshhfFU5tEw0jjyObAxuZPKbPO5
 bEUI9Ml0hMWTmynIdG3u+bbqWPSbpQeQhhGC1ehHj8G6zej4ICss+Ij/tFt6aw8xrXOY
 SEA22i5wPzfxAjQopFhFEzqn6zQx3DkHNkNJkDq8Sr+SL5ldgOkp+D3BZR4TKhsSrjmo
 kMkKN9pb+GhXMTU9TAxZruDnP1u9TspmXdziXCOkx+wdU6x9/FrDiiYX0qsGO1VOHIvG
 nm/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=z7Vd1mUizL2q0h+HL/W06vBBTRJy+YRC4k9Z4pycaXg=;
 fh=XUlnlYGkJEPQvmAj3hsT71xKcomHJvKvOElX0pzs/Go=;
 b=XELySJgcwVkzdpnxvlq4Vry+f/rTn1T5tP+Eigesnt87uw+g5XMS9ed/NVinO61FU3
 qLwxLyZHX7cBNs99TyqOoHALxCKgMWqNgblYgTCtcxG+iqgH5IO/c0bCGdvNlU9zJV6x
 /te20BBRRv3XP18JTX7Ww7NGopOW+TiazQnXzKcOlbUvDLb41wp3EaqpqvLbGzjozvS9
 Y1T512fzvuVZQWMwLXTOtUzwQYOVvhcu3qigDWyt6wnfNiX36S28ui3i0mRuLLmGEvpG
 KiWJdQSunhVWUlqPjh2/MxoglE0CTkyK8di2OXPNKN8z0B5FLSgXVg/BKIK/u+oREa4t
 C8lQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781190272; x=1781795072; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z7Vd1mUizL2q0h+HL/W06vBBTRJy+YRC4k9Z4pycaXg=;
 b=VueSNWDQEUgKlV8K2GiUCmbSRq1QPsCdtW42ESTWUqyaT3SrrhvbG8tzij+oROCHf7
 BXcxSXlECFgmnmKClF37WUYY2AHWRsA+7F56BP5acigxCXEF2cTGwfoblPTjgSDLXOVh
 ACsstRtRkbIizqjwJy/bOeQAzDRsfZvaByaZy7nx0DhO9jDe1feCb9cw2vzLQUQhiaH5
 RVqMG/BDcMAb5ZR5H4ps/bNbJ6eyyGUsXOZU4PTaudWEbp/wkPYdp4YYYwgfr5VwDdIu
 irKHzbHE+eOae5jwtlJTjzUWkyNStWKA7Ar1J8GXEws6pnvxCzV/7CC3XXMFiHRIkYF2
 SYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781190272; x=1781795072;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z7Vd1mUizL2q0h+HL/W06vBBTRJy+YRC4k9Z4pycaXg=;
 b=I1RIsW/fvh1Y0Y75pp5J6da4agXUrtvyGq3XA6xIWMsHnSVYrj9Cqj3//e9fMU1bH8
 +B5x40TMLHqnoR9cVyIgrLp8IeAnLZxX5Uq5p+a4k3fZc3b7ODrOJIPoD9E8yTjT46UL
 1cPi1w5kMiqlQWjdT8O0ulOKeI7LhSyQDDYqRK4e1URg2zCmtksf2+sv27CIbHWI6dHe
 WxFhK9BvgjRtHQlunp6FTF4zpDdgQPXYEhvOdAONeXoCBo4ibIHZoPkmEOWFEqHrNdXS
 ctiEWPzVUPg9zCvemOh/pTzJ0XHMGmMczMiwfX8dZmfPnk0l+38AVD3u9dvQXE8O15HN
 dj4Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8d0XaacQQ5PcXkiLkZP/+rpEQ2Ig33hfSv/7VJWnGKzLlvpgGoB2Dtk0/jvhOF/vbcXbgRxDixH39e@nongnu.org
X-Gm-Message-State: AOJu0YzKWa9bxJr9MfhCxwsZr+9dzDNWu40pUJZuqR9YuyT0q/A+k1IX
 UXqea5bzW6qFuncMCuv1FEJ16IrVCvGQDhm+vPDJ5HOTaGvg0MttXmS2kXXM5+wyRv54xCasZGZ
 29SywKVvb4sQkHpZWYdf2Dwyv6iOZjVu9naDeSNgvLA==
X-Gm-Gg: Acq92OEj4Yml2V9Is+jBappcvW+laINMxC9O8aN/fy+VnmoNi0pKnlNGhDhD4+pJPAl
 QSCgZFV+u+Qkw7lUm+E0C3/9lot35dEZO1duAwoHyDQG3hYkX2Tf0lPHm+On/tOXfnPV+rlxPjo
 O1J89cNCErFPpaq6/b+kgDoue5LULj0Zgk5Vj0oepmzAw3PnWkxmCOBqSGa2vpL1xjycfwo1QWk
 dqJ9gNQpJCgnZgwE6FdS5P9RdAGI8IA2V6VJUENIiFLlE3LQ1O4IMXlH640SCBmd2FVP1JqSl9g
 uPF98Y6bWnuStjuGAxv/UNY/1726AU6/OJA625cR/txuwAjEgL2tz4kzwiHuPojCVVSxWoVwN0b
 wSQ==
X-Received: by 2002:a05:690e:d86:b0:661:37ed:647b with SMTP id
 956f58d0204a3-6626961fefcmr2609278d50.14.1781190272360; Thu, 11 Jun 2026
 08:04:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260608001821.850921-1-gshan@redhat.com>
 <20260610041036-mutt-send-email-mst@kernel.org>
 <20260610183046.GB121666@fedora>
 <20260610165710-mutt-send-email-mst@kernel.org>
 <20260611142022.GA202155@fedora>
 <20260611103513-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260611103513-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jun 2026 16:04:20 +0100
X-Gm-Features: AVVi8Cf1q6PHGCBY3IjSA6p-timpIk4iVHgEYZh43i0FueWDdcJcGPGQYG1aUpk
Message-ID: <CAFEAcA8RAsmrAArKz0X7NU6sCnKTC-e413TgwLp1gt2vJGLgPw@mail.gmail.com>
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Gavin Shan <gshan@redhat.com>,
 qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, jugraham@redhat.com, shan.gavin@gmail.com, 
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Thu, 11 Jun 2026 at 15:46, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Jun 11, 2026 at 10:20:22AM -0400, Stefan Hajnoczi wrote:
> > Gavin posted the lspci output:
> >
> >   Region 0: Memory at 661ffd000000 (64-bit, prefetchable) [size=16M]
> >   Region 2: Memory at 662000000000 (64-bit, prefetchable) [size=128G]
> >   Region 4: Memory at 661ffe000000 (64-bit, prefetchable) [size=32M]
> >
> > These are prefetchable memory BARs, so I would expect them to be
> > mmappable. Why does QEMU have no way of knowing upfront whether they can
> > be mmapped?
>
>
> They can be mmapped.  The issue is just that after mmap flatview uses
> memcpy/memmove on them, and that might not match what guest driver is
> expecting specifically for 1/2/4/8 byte accesses.

Huh? The guest driver has nothing to do with it, surely. The
problem is that for some PCI devices (like the network card
mentioned in 4a2e242bbb30's commit message) the BAR is *not*
safe for arbitrary access (because the actual real host hardware
inside it is not RAM). That commit disabled direct access
for all vfio MRs, which is safe but overcautious. Would
"direct access is OK if this is a prefetchable memory BAR" be OK?
Or do some prefetchable memory BARs still have restrictions
beyond those of real RAM?

> Removing mmap is one solution, this is what vfio does now.
> Fixing flatview is another.

No, you can't fix this in flatview. If a BAR is not safe for
direct access then it is not safe for direct access.

-- PMM

