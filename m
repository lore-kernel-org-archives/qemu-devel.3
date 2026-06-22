Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E9ECDB466
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 00:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbSSt-0005NG-7p; Sun, 21 Jun 2026 20:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbSSr-0005Mz-3U
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 20:24:37 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbSSp-0001Wn-5P
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 20:24:36 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-696bf0e7c9cso5812326a12.1
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2026 17:24:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782087873; cv=none;
 d=google.com; s=arc-20240605;
 b=SI9ykuylNL5ouF6qzi5wxHGNgmi9RMgfqqFeLV4OnH0zNv3mT5ouRACSLn9VkaPggW
 S7H4g/Sn4EtFD8NyL+1iW+e24W3dyYSyB5cq1yY1qSN9KkpL6cwDUCUijV46DsuVPeuJ
 F3MQPAbgw/2caQdbnZhbVIgNgNgJENHvo70aeaNl7gGFx6WtFCyHNIWMDn8p0s8SmG7z
 DgVS4MniKYYhtijtkOV3vPP1oHAUtkcCzoUSkd/TT5I77X7QBnXrywNWuK9IThOQYuAI
 BboC8LzkuQA2fuOOd0yXZPMINTZFJBzYFsHda08Tb1leR6f31UXHr0lAmL0l8tg81U88
 PwSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0yHC8rdsAiU+IbMB1rh8N/25F56NnW1Izx4WmzTKgWY=;
 fh=Y3zsm/xEeT77dc4kQERwALfPp7kWGm28ntxZ4gZppHk=;
 b=XAjdh/3X9B49/ROnks8J8f+HSHVg914moGqnAsyMKJMnTwCSVInWrDMWqE+iOBB0sR
 ulRKgtwdmsfPXgLBUEx3zVXHX9uGnedsWb9JlKpmiBGo6nsEl1JPNgfFXK9DezZaYGrF
 oYP+lrzfcImg9do/lIxlSrc3rHr3BP9St1deDRlAusjCiLSQRkOXIRSGTHvPt9wACV4d
 c1JKcwYQdFLy+q8NinJ5mSsPfQ0WozX0H8g/KCuxHLgVrzcetyiWqebgnUw53IosBHBD
 WH7Qg3rtCrxuGAp40DPvfbPN5DOX2Uy2XZ5zE+7N16SfqYvmCdnS8SVo26Dz2X1tLAhv
 a9sg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782087873; x=1782692673; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0yHC8rdsAiU+IbMB1rh8N/25F56NnW1Izx4WmzTKgWY=;
 b=Tyq6INQ2s73kFWvcpgXOXuVOde6q6gekAZGepjq2YO4gCwEpspZ7ZVvC+FJ2LhjsUj
 /KWIxtMqOm5LouAWlHQXvRwRTmtfKRKwy0BRb4AefP/lvGOnwJoK3pJrmtZX2l2RF3um
 +pSCtJ0+f9I6ZsJW8Ov7x606Q5FbjTgnZO4nwzl0OBocuq+JsNJs6H7cCyeWecqbF7Jn
 /OPhEmc6BcP0a7cnfFkvQ7qs7gs/l2GinWZKCbTHVT57tnItYJwh8A1kDMg8Bf+tvFV+
 kp4wWQosTw/A/nX87d8WX3c0KDAQHI/5RS3JYSsIT0u1KBfa0AQRSNFZT2uSs+qeohOA
 /bYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782087873; x=1782692673;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0yHC8rdsAiU+IbMB1rh8N/25F56NnW1Izx4WmzTKgWY=;
 b=Zn84H0W1uIFQOekdvt/sy55D6LNSizVd04mGZedgMwM26gBR0cesOdPB4kgJ86xieL
 Q+ZK4cHbbRhTsMrK6E/Kic1x/vnhtmsvCHK5YWtS0/e2TgG/iN4O1F84ykOdvGr2cd3Y
 2Yw756TlQR8kKD7Ck6kM0UktV4kwxA8yRhlSeW26Y1n61diDL/wLRV83L+7Or2+fLwtS
 HwxYDg6y+/mtJEUQs82pVjYT/6yy3Et+kOeLQ6DlJ4nQYSlVomhhkOYvwVOiuzEGqkui
 Jc6wnV34jtJhocb/X4xiooLElOJJsycdUXi8MBm5u6lcFc1gXHJ9Ow0QKgbzqY7wjPMn
 v8qA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/C0BAdz0m+KXtm84vG0AcGk0blx+6Mvjnr8K8AMOhFHbtEjvZZ7vntRfudNSDdvhqkI5erE8BsNBDc@nongnu.org
X-Gm-Message-State: AOJu0Yx0Jetiz7aa49zbJ2RXhlf/R1gr0litJkAM7gmjAID3of2LlD6S
 IJ2eibQ2KJWmwzFunhFGQrYo6PfjBqRO68OECJjr6PrBHH9FPfFiverANDx9x/a6Nyg/z324No7
 O0TnkPcVXAo9CvyZX+aLVENpjkA4/mHM=
X-Gm-Gg: AfdE7cntOghCOHD0a9EIlwnSlGWsrBeqYnSPidF70b9pyyMSZQrr3AZ/AcE/14qRK97
 EZpM45tulm0Z9TW8mCqtYgXoP8oFVmxxSAqDa8c5I0ayZvt4ThM7RCKOLWMUKTqez4QFbE8Jj/4
 wvu+FuIi/lXpvEbBjCmRYzYb8yKpBNjA5quoaIr7ielSCqYGWv6/9FjyJpOgWCuYnMUafFw9KI5
 OMrGJsm46/YbdNlJvUgrvHb042pilnSYCGu+X146KBQMsqKwPGoWfqQMQ7sT8J53qKtx/rzpH9f
 Imxy3SGgkSwYgmi7xnZg0+LerwY=
X-Received: by 2002:a05:6402:3548:b0:670:d548:62a1 with SMTP id
 4fb4d7f45d1cf-6973b0ccebdmr5204449a12.3.1782087873441; Sun, 21 Jun 2026
 17:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260617054034.1020724-1-joel@jms.id.au>
In-Reply-To: <20260617054034.1020724-1-joel@jms.id.au>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 22 Jun 2026 10:24:06 +1000
X-Gm-Features: AVVi8Ce2EpB78JbfMWB9Gg9CBCgWuuvP829BGVusIMqUrF9jlz2804ObfJQ0Oj4
Message-ID: <CAKmqyKO4y2QK6HGGQc=8MsO5wdODjyTGA728mkRyXWctQBQzmQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] riscv: Fix IMSIC CSR write and add tests
To: Joel Stanley <joel@jms.id.au>
Cc: alistair.francis@wdc.com, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Jun 17, 2026 at 3:42=E2=80=AFPM Joel Stanley <joel@jms.id.au> wrote=
:
>
> This fixes a segfault in master with any machine that uses the imsic.
> A test using the virt machine is added to catch this in the future.
>
> Joel Stanley (3):
>   target/riscv: Avoid NULL deref in IMSIC CSR write
>   tests/functional/riscv64: Use newer kernel for tuxrun boot
>   tests/functional/riscv64: Add virt machine AIA boot test

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/csr.c                      |  8 ++++++--
>  tests/functional/riscv64/test_tuxrun.py | 11 +++++++++--
>  2 files changed, 15 insertions(+), 4 deletions(-)
>
> --
> 2.47.3
>
>

