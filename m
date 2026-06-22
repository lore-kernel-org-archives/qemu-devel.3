Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D53CD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 22:10:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbmpU-0000CZ-6P; Mon, 22 Jun 2026 18:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrhilke@google.com>)
 id 1wbmpS-0000CL-F1
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:09:18 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jrhilke@google.com>)
 id 1wbmpQ-00050u-Kr
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:09:18 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5ad4ee260b0so2215e87.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 15:09:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782166153; cv=none;
 d=google.com; s=arc-20260327;
 b=Ms7ht55lK8FF221XH0xxocVqQrGK0HXWEzMOnU+MMkbg9DDWFxy+l84b4CCTFTJjTX
 T2+FyOYANxr6OxEaq5rfYWiIh+X1k+AWCP0rFU70+YZ9S5LWpC9kvP6IoTK085fw9wm4
 RAh667WsindVEsq+nyskmaeDMEt4Q/00YaCn+re9mYUz5Sl3wLDA/JH+kKgpU7SCYKrb
 bORCLUnBaXlHQ91hzmklkSr1az2Heg613NaqtXfE+2S7j2SOrqa3A4L5riKhImWPftaa
 pyX5dlFNWOro4tEnyftduuEUmGpTksnxhN3QVUT/t78U/dVF8fJwiVREpXhzPizWqnIp
 uwdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=edhVOjG1RYckgvQfTc+chzQn28SgCVma4qbJ79AGjLo=;
 fh=vl+2TddJos89Z0fx/5Io1W/1uAgiUZBQcisNOZRRBBc=;
 b=VyWK94WdxJpQMHbPk7UPhqwa98WKRztBQhjgXzr1jW1n+u8uft467UfDWesbCQP9/R
 UjOdvmgrI6S/3f7r9n4vLpZ2h/lc1ae+Sz7ojy5x3wCBx9Unhgvx3FnKPBPPREWIMJjW
 4jjySYpBt0S/EEQLhEzaGhFcLpWUwwAghGEDDM2dKkg8pOzHZDkk5LfUCqHn8n3lRc00
 5XUV2QdkCoqhwX1vghMvPvig4B3wDblFt3FtfisUYi+w5dzC3+FX2EkEkW+LrlErZt6h
 VZQBCqXvqLTTgX6OYZPo9NoF3IMPhwJbm7jxCiVsWpbeiIKH3Ivl+B75ILl8Do7D5L85
 VjBw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782166153; x=1782770953; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=edhVOjG1RYckgvQfTc+chzQn28SgCVma4qbJ79AGjLo=;
 b=etSiP7D6SsStvE1uacWkOXFXMY/xJox3hiUUP8pseCDgnpzO6O9r+xQrQQm/KtoeAy
 QS+USt2cYsVZTWHEBrDYudff+JLCh4ucef4MSfNsQGUygEfOgqeBHia3MVxozLDYnQdZ
 ItjVvQYtqkEdUimCOtW9nBok33lIOe27uX8qw7UwoF3RU9C7uR36ABAsKFIn7GBxwS/b
 ZONGd8Qm4w94nWdAeeiupEg65Yg++mdeDUTyie1zEAl2xvUl5RWWD6cGRg3fYMyHt1lW
 Y/R37DN2jvdw05inqx30gysdrXgJAlGIsKvpUIbMjHujwv9Iy/KNIoH4ZBApfop/MrVq
 okOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782166153; x=1782770953;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=edhVOjG1RYckgvQfTc+chzQn28SgCVma4qbJ79AGjLo=;
 b=UzKZErn8mlhv0nW5fVc73s7kcbDl2OYWADpVo9g7d0ktKh752hjlH4TM+4YeltfYkg
 M2c9apyZhI3npCl2D0qaoubvYLBHU+oqFC3kLG9XhQfgpCIFRFoIma4q1CqnJooHbPgi
 YqTBXF7ebSVl0coY39q0yz5gxtqgdw3yHE9qU3cM7RyqQ4FfXdUVHUczdBE4tWV0txt6
 rvcSL5IsjRiR9uRTM3hDcsQQwSBDjKguIGc1QLUE+ENXgN0fYq8KOmUy1+oIlcaBvSle
 ZCijf9uvf9d0D5mWxrFPLvc3zhqZ2dmu11CvRYBZmKewCJWWLSVmjj+eUF6TtFJ69050
 Pt+Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ98XFjkCc0sg8uhvQcuQLAF7qJOA/642DoAp3Ox3+Pr15f+JkfspcxA8Y3GRzv9crN9dJ0UHjNrFC8R@nongnu.org
X-Gm-Message-State: AOJu0Yx0vFDj0txmn9wGgt/C8+VGKVOr40TYj3Cyxe2rEm8jOBZEm4tc
 lADg0U7Gwe9/cL/A9X46ybBwnTZtrZDh6fuY9SquEq7Br+Q3uzxD4zrbGAzYpAOtzT+5QahE6dP
 WqN4bakKauyykQqZe6XOsbzkkimNeQuHCY+wuk9M=
X-Gm-Gg: AfdE7cm3oP3K5OlUwH4l0FvEaPy40c1Noga4YOcgZmbhSk+0ZxFT4N+AcvLOswg8GqN
 zgBcMA2R1m+Zv7SNIuqhS5+K2ZqHi7wU1gLhUmoayAsDhaQIbQBESjsqfIeHUPXpwM5bp3RfjT6
 t9Ww5guieU0VgnNxO0/P0EffHsaSIXkz4jKtXCCkUk5AvMTDEi9o71lSUfx6BM18R7HThGCFlOO
 yiyzpLTAndGipn1GH965HlXxbukM32+cyq/MQUr7DiT4AVE9oLYGBDp2A2FeBowyxElViKEaurB
 axJS0OGGrbA9d5KHaa5YpKMuSWxP+A==
X-Received: by 2002:a05:6512:6892:b0:5a8:cb91:1e12 with SMTP id
 2adb3069b0e04-5ad698134c5mr36829e87.2.1782166153080; Mon, 22 Jun 2026
 15:09:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260622-igb-trl-v7-0-abb960e767ac@google.com>
 <033dc4c3-6398-49c0-aaec-487927cd549c@oss.qualcomm.com>
In-Reply-To: <033dc4c3-6398-49c0-aaec-487927cd549c@oss.qualcomm.com>
From: Josh Hilke <jrhilke@google.com>
Date: Mon, 22 Jun 2026 18:09:00 -0400
X-Gm-Features: AVVi8Cdvwa8QBow4MBPduGx4Hr_-NipFOTqjBdXemtUIInGMAdXu9c4zcKhc8Cw
Message-ID: <CAAdrzjvZvikgz-pC0W+n5W-DFn73pqoToqv32A25or77YzCi5A@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] igb: Implement Transmit Rate Limiting (TRL)
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Matlack <dmatlack@google.com>, 
 Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=jrhilke@google.com; helo=mail-lf1-x129.google.com
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

No need to review again unless you want to. The updates in v7 are just
responses to Akihiko's comments on v6. The changes are pretty minor at
this point.

On Mon, Jun 22, 2026 at 4:50=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Hi Josh,
>
> On 22/6/26 21:05, Josh Hilke wrote:
> > This is v7 of a patch series implementing the Transmit Rate Limiter (TR=
L) feature for
> > the Intel 82576 (igb) network device emulation in QEMU.
> >
> > v6: https://lists.gnu.org/archive/html/qemu-devel/2026-06/msg04562.html
> >
> > Changelog:
> >
> > v7:
> >    - Inline igb_trl_disable() since it's only needed in one location,
> >      igb_core_set_link_status().
> >    - Fix indentation in QTest.
> >    - Don't set PCI_MSIX_ENTRY_CTRL_MASKBIT when clearing pending
> >      interrupts in Qtest.
> >    - Fold calculations igb_trl_calculate_delay() to simplify logic.
>
> I already reviewed some of these in your v4, should I review
> the patches again?
>
> >
> > Signed-off-by: Josh Hilke <jrhilke@google.com>
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

