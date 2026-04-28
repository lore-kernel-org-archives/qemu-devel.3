Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9719FF886D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 18:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHn5s-0006Yd-47; Tue, 28 Apr 2026 14:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wHn5m-0006UR-PY
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 14:23:33 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wHn5l-00048f-BQ
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 14:23:30 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-67845996252so9990688a12.3
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 11:23:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777400608; cv=none;
 d=google.com; s=arc-20240605;
 b=EaZBpDF8nG5mRoJh+PT0/e0mINikxj9chH0RkyoU7OBAGDMusNqGFSSNW1YgzCffa9
 j5QUHq7+M8Zu/8d1PXQ0UQF7u8Cs6ssrKuaIp/Szc9N8W/pG3w9xVirOg1wKCe+13kSW
 4Pv/nm30hUcSl8Qkk80ml9hxGAAR6WwFyvmbeeZZFQlBIN0M8nxsBfP86FFMhPShTWMv
 TXDlKgZjjQTa2xclW5iW0xE3HgZHfyr+k9mzlGqscROqEHNfAhC7HB2u57F7NviS9pXM
 l5B8c5Aw9ugvUz9ixw4h83pLabRNiREefr21B39QArK3ZjtGkspYWifYA99L2qqTMn7B
 gqaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xMdf1mBOY8QAB1AjHuyg/2fSOzoWpj51t+K/nxh7pI4=;
 fh=UNi5ADdXjP8hFe8deNu+JoOqX6QLybmH/ZEq2//exNs=;
 b=Yzeg8vGqqZfQFGtmW0oNI/7R1yFK3Qqrlxy7nzVnmGJuhIbODgNhF1YjzCRbWwb+lt
 bXg3MvqA5GmvfB/OPYT6QZMO6lp2H809KC++jE5Syv33sf5PFYr4SyAKDSCSZNhUKSYZ
 MW9DRO/WVFpqtjaAEFNwRPP7MiUJMy2gW3Rp/65uS1Imwo9I6FnD/8WxR7c0tHGpGWQ3
 uwIZhd02MZ6Z2X7JszAbbOfKkuz+ZIoKXZ8evmIKwF2zqm6duIUZU3fkj6FP37zFKxzK
 qeAAZZf12gQLWQyEWJVvm7rx58sX8Y9HfQB4PvYx5bkGcAuJexrztoRWfCCQPLcsopxb
 tW8w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777400608; x=1778005408; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xMdf1mBOY8QAB1AjHuyg/2fSOzoWpj51t+K/nxh7pI4=;
 b=IkgzZa7BmzCsq/URVMLlzmP52mncsn7ixr14VOrn+x+N5YB0SWF49iXZX9IvO8xMaJ
 j/oYRSIrHobsbteEUZvbPEbi+d1PeVkwkbWbVf7ya+pK6fp+JT7dBOkiWW7avvKHd1Gz
 WUWAy0tNU+MwaIvs9zBtFbPH9rbcc5xwoWXZGlVZWh2CkwacuYKqlGWzy093Od+7fNEc
 ehhClYiwxk2ehAAZu1wptIuGhTq/apmvCAPdPrXLAi8nxqUMsMAjW2BlbLWlcwGpIDF5
 Dwhrw9XE14+3llTnxw+LvCN+J2D/j26KHw9zsZ7Xjqc7gf5GzDPZm/FrQCo6C5tr7RH9
 ZAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777400608; x=1778005408;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xMdf1mBOY8QAB1AjHuyg/2fSOzoWpj51t+K/nxh7pI4=;
 b=FEnCBy6ZSGqdC4AksY+2z9ZSpwOV6JFW2MpKdT8oiQTLs9+HSQ5l0cH8XI1jDR20nJ
 zWtDpE0bQwi7tZQSs+S5ksSvi3ZX4y2H1IR0IzpseIf0fABFK0jAPR3hFZd/GYs0N9pq
 fjxRjbxOqZxcMQE9ph2a2+sXBTgQ7cE4Jl7QNBsALuURnQuoackr+N2sOHURqZQiwLyB
 8srVtxE+xYdY+a9HSjIUVr6GkKEyW9zZKSj+bI1uT0vcqDvLFLxHcbfd92lscPWXpPCe
 jIFADwxg9i+EUXk7PDEFqOE4vzXugS0dvrQXQ+8/aPmCcwsv+ANzhsC7MktcBBTGRHKG
 YcDQ==
X-Gm-Message-State: AOJu0YzviecAKRpYPudZnrlj9UHyYbmtmBWi4viGTYVOz57uetRoYgnI
 LZ3tMEBxgJ+Ymto0FBgHKd3aI8Jf5M7pMgbb5LjYKpFGAf78sIGXIXAS/yxIGE/qDi8Fwl9ToL8
 iO1dkkpMriZwzGB/Fd3LAB/MT8Z2jc9w=
X-Gm-Gg: AeBDietVMX975D/O3SVje3Pub5jIy+3vp3edOiBPLf+MwxGo45mAh5yTYFKpC3RTJPo
 pP+9IjdNrR1rLCJiPjNBaGmPk++J1mMN/U26pj1BnACM6irMGTV7vzHTD5l66HP1JnCvU6twBrB
 FnuPWzvnuCes5vlWLHh7wUX/LNsFVTmCsK2t1LnpEJJcrgQRxpdHhPTTWPoZsDnMtHsGyD0kYL1
 Rq8eTwjebbcFeTzmaNe0xJi22GsiPOJ2I3gBniSNmfxNBWsMahvcC/xbHWE2r4xKZVdDSPSqF1d
 5GUNS/wUCq6ibFWNMGW0fHUEnMbb5aFwmvCagTrGyI9KagSa
X-Received: by 2002:aa7:d490:0:b0:678:87d5:de0e with SMTP id
 4fb4d7f45d1cf-67b1fe1bc1cmr352839a12.23.1777400607206; Tue, 28 Apr 2026
 11:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260428160120.12130-1-farosas@suse.de>
In-Reply-To: <20260428160120.12130-1-farosas@suse.de>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 28 Apr 2026 14:23:14 -0400
X-Gm-Features: AVHnY4L5tT95r_eoW1ap8pn7349-W4lVfh7YIlI1ZgUMR5SpEg0LQOLEH5dQ4KQ
Message-ID: <CAJSP0QXAJvSbgjxfL2eOubzNa1i3Xqc2B_rykaXzYfi9d7FPJg@mail.gmail.com>
Subject: Re: [PATCH v1] tests/qtest: Avoid timers from default devices
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Apr 28, 2026 at 12:04=E2=80=AFPM Fabiano Rosas <farosas@suse.de> wr=
ote:
>
> Having default devices enabled while testing timers leads to
> non-deterministic behavior on the usage of the QTest
> qtest_clock_step_next() command as the implicit devices can have
> timers of their own that may have a deadline more recent than the
> tested device.
>
> In the particular case of npcm7xx-timer-test, having SLIRP enabled in
> the QEMU binary may cause the net_slirp_timer to shadow the clock
> advance that was expected to trigger the NPCM7xx timer:
>
> npcm7xx_timer-test.c:475:test_periodic_interrupt:
>   assertion failed (tim_read(td, TISR) =3D=3D tim_timer_bit(td)): (0x0000=
0000 =3D=3D 0x00000010)
> npcm7xx_timer-test.c:476:test_periodic_interrupt:
> 'qtest_get_irq(global_qtest, tim_timer_irq(td))' should be TRUE
>
> Add the -nodefaults command line option to all tests that invoke
> qtest_clock_step_next.
>
> CC: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/npcm7xx_timer-test.c | 2 +-
>  tests/qtest/pflash-cfi02-test.c  | 4 ++--
>  tests/qtest/rtc-test.c           | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)

Hi Fabiano,
Thank you for the patch! I'm not sure this is a long-term fix since
any code in QEMU could use timers (monitor, io channels, etc)?

Whether it is a full fix or not, it's definitely an improvement:
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

