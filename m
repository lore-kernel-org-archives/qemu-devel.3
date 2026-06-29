Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DB6C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 18:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weGS5-0006Ge-I3; Mon, 29 Jun 2026 14:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrhilke@google.com>)
 id 1weGRy-0006FR-DL
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 14:11:20 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jrhilke@google.com>)
 id 1weGRv-0000m6-Jw
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 14:11:18 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5aebbe750f8so822e87.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 11:11:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782756672; cv=none;
 d=google.com; s=arc-20260327;
 b=NHwU4Ps+uHh75GaKMboA5xH1WuyrJn3bc8xu+921JSIeOPuIm+aDX/KN2WKzPMFANe
 J2ykCJtLj7A0G4k3cZuedjBLrC2SoYjWdaRGmEeLoj4RZ6HUlswqsmkJ7UxfwkXElz0F
 IV+6kUzdN1uin0s+J+Z+UPeefc1C/PHbLqaScLBKV6aURiIuH7iDd3Ab/862lMV7I+n4
 FMOsiO/7K8jbtGL1K9y7N8oIsTfskd3XYNoxbKFljPMYdNcZzqwJWrVQ9bHPcxrhSIj0
 ym5L4xPRA5Zji7RPZiVgN6CkHtCbGjmUL+DqI6Jwv3hI+E43XNk8Qmh1YXGaRvrzRn5Q
 mGdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=o8Hjjrzg6nhDYxAuTUyBC9KqAbA77PY2LLyRTaWs3Zk=;
 fh=KsJfx1kmR5J6Li61dAbKAc89p8yaB8XD7+9hrlG1J58=;
 b=b1wvHOqJ38MgKHzRcWYVHe1DKcmFRzNgWNPNJ6AS2mBTRLjHAP2kIWymRqiJTMwG7W
 DyIWVRiNiF9Jr+iLYCH+KBT1OFX7o/+h5x7S8CzdZnPbd7rIFw7Xy6lMxfh/gcM/Azj/
 Io6pRZiBXGPSQmk+IlmBhij1EQgIKMVOuE4XkLt5FBUUzkcvPJ0DEYkQydf5AUAqWBb6
 X9qDnbyCW3rxvTWpsn7mLDRI6Nofnt/RVmqBDyBaoLjsksV5fYDki+kg2Mzf02hOnNof
 dj7ScPbSzl4HawfQcVh+Z7cKAurpFTk2F5MmavbeHveZqpY0zTyXrfsz9ks6PUR5uqbT
 SO1Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782756672; x=1783361472; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=o8Hjjrzg6nhDYxAuTUyBC9KqAbA77PY2LLyRTaWs3Zk=;
 b=h8wWs9Q2wU8wmt9loR2YbhXYTSxU5yHYQ6Ju5MCerR5lF0qYYbObE2BbFMSINrFllE
 61Hc0VWUi1t5X+jJcSQK7ctcEbmaa4v2KYBXwEOhyhpi4VBuQbIM9J8GPlynQgyc1Cmv
 UkL6Dq/vefI/9OJy0gQIxiO7PDp6vdEjlUGw/aNcA40QBeF3C2pVoyRId/IaS7xkbYkE
 7HjDKuIycST+zLTmPfqmHghbHvcF14U08WShH56D43a7FeFrJWvlXJajA55IVVEECP6Q
 0iTzZRClcKTS/Z4NFT6oDCgGPxkxiehyREheH0dtdbyTJkZbm0aT9KKaMkhnoSDZ5ep3
 K2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782756672; x=1783361472;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=o8Hjjrzg6nhDYxAuTUyBC9KqAbA77PY2LLyRTaWs3Zk=;
 b=RtL2gI3c/4p0+sJFgGgTWf5hAV7p90LBJLtqsrc0g/qbxQjNUcn+EvRg6XYzWSiIgg
 v1KFsmC+5ZakchTAuOoEgvRNvjUbC/ojQLOsf5h0F2JD6hqzrLWOqlST5dyVhGcpZ9br
 dEQgkFGdibzeRcyHmBNeFDz8oql8yaGfJtd+L2BT4bIFFkvS/E6zAveoySt0oKz1Jzrq
 hfjqZ7kGoCMXQXvLePmOHe6B9tgNCTDp6/alDdrzKWb8jzU8y+chl0dVnbXVjOyvVK8f
 vFUTBrmsSvOy74iyFWTG9dHVbxd6V0zA1QaHS1EB9N8bxu1fioznWfXBOjsicRzA9aTO
 JlRQ==
X-Gm-Message-State: AOJu0YzIGQcXZQyU58uxUhYdGkLrLmDpjOg9bILU5eVIHcIA0EgmnxDj
 gXzNypL97nHOoJA7rVHDw05fli8LPxDIm7/2jfNA9nKvXsDlaoN18yrF+zdAIjElFa+um0/mPlj
 nps+8gnmHt9VCN3y8SGxCzr1FN99/kT8Yw4azZI0=
X-Gm-Gg: AfdE7cnpGNed0f8R0RuuZ0Ze/cDFcMSqSclYD3ttabQwH+9PJbosnZG1Zkfq+7MUGEc
 VhE8R65vGE/k+c4TeRYcuh8O8E1cA/bV7z6JCWCyfV2wlbaLJhzOVmRnYYyMlo8/ZFP+L3oOvg9
 UFRd9XW/+aW5ED3m4Yrlsj9EMVD2WSur3vSPCM5GCYFODDRdE1yB7n31qRgMhGhRbLfXD0t92RA
 HjugJ+Vy2CbaAtTACFz3h9hAQUxkbc8sUHwlvoOXjADV9udEc15MC4k4jc2bTtxocgqVqVvpqgg
 hoColvNolq5ZE5nL/1Po0w5fRw==
X-Received: by 2002:a05:6512:1095:b0:5ae:ae6e:40e4 with SMTP id
 2adb3069b0e04-5aebe146c8amr15052e87.11.1782756671662; Mon, 29 Jun 2026
 11:11:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260623-igb-trl-v8-0-c9b1fc6c3304@google.com>
 <ff0bcd39-afd6-4842-9cd5-3e39e56ec901@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <ff0bcd39-afd6-4842-9cd5-3e39e56ec901@rsg.ci.i.u-tokyo.ac.jp>
From: Josh Hilke <jrhilke@google.com>
Date: Mon, 29 Jun 2026 11:11:00 -0700
X-Gm-Features: AVVi8CfhO7Ai44g6nnZFlujQXF5RCNe5CQUwptswRuhml_PO5BjUP3eCQET1IKo
Message-ID: <CAAdrzjtjVyG-yV+MnZ5wtgef3UQ-MLCWZtHh9feeBK4ek4YXJg@mail.gmail.com>
Subject: Re: [PATCH v8 0/7] igb: Implement Transmit Rate Limiting (TRL)
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=jrhilke@google.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Do I need to push a v9 to include your "Reviewed-by" tag?

Thanks,
Josh

On Wed, Jun 24, 2026 at 1:18=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/06/24 0:05, Josh Hilke wrote:
> > This is v8 of a patch series implementing the Transmit Rate Limiter (TR=
L) feature for
> > the Intel 82576 (igb) network device emulation in QEMU.
> >
> > v7: https://lists.gnu.org/archive/html/qemu-devel/2026-06/msg05440.html
> >
> > Changelog:
> >
> > v8:
> >    - Fix extraneous whitespace modifications.
> >    - Use muldiv64() in igb_trl_calculate_delay().
> >    - Fix comment for rate factor in igb_trl_calculate_delay().>
> > Signed-off-by: Josh Hilke <jrhilke@google.com>
>
> For the whole series:
>
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>
> Regards,
> Akihiko Odaki
>
> > ---
> > Josh Hilke (7):
> >        igb: Define TRL registers and core state
> >        igb: Add VMState support for TRL state
> >        igb: Implement TRL register write and configuration
> >        igb: Refactor TX path to return processed byte count
> >        igb: Implement TRL throttling and timer resumption
> >        igb: Add QTest for Transmit Rate Limiter register multiplexing
> >        igb: Add QTest for Transmit Rate Limiter traffic throttling
> >
> >   hw/net/igb.c           |  43 +++++++++++
> >   hw/net/igb_common.h    |   1 +
> >   hw/net/igb_core.c      | 142 ++++++++++++++++++++++++++++++++--
> >   hw/net/igb_core.h      |  12 +++
> >   hw/net/igb_regs.h      |   5 ++
> >   tests/qtest/igb-test.c | 206 ++++++++++++++++++++++++++++++++++++++++=
+++++++++
> >   6 files changed, 404 insertions(+), 5 deletions(-)
> > ---
> > base-commit: 98b060da3a4f92b2a994ead5b16a87e783baf77c
> > change-id: 20260608-igb-trl-19be198da6f2
> >
> > Best regards,
>

