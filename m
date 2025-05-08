Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4D0C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 10:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCyZ0-0006FC-LU; Thu, 08 May 2025 06:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCyYu-0006Ai-SD
 for qemu-devel@nongnu.org; Thu, 08 May 2025 06:33:08 -0400
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCyYr-000640-Sl
 for qemu-devel@nongnu.org; Thu, 08 May 2025 06:33:08 -0400
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e78e3200bb2so849655276.3
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 03:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746700384; x=1747305184; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KMtOUDyAwjpqecoun8+xjSclmRlj4tmUuc9dTCbiEV8=;
 b=wqPGHeYyM0bqrPfSUGbhZ1twt6+GHWwBsmbJ1gMFKK8RVRg35MKiKu7KOwKAwXTaHB
 Ao1VryJCGKFcTwZcrmuAAAm9TZQQb3Bjllvc9Eg2Xa/7P83Fku9qpmz3630gVlnfZj+1
 /iM84f7Bhr8y4a7OBlHVPt+kiPg67vUAOSiT/UDrot/Owzkei0RKYBjf5lExlgZ0kEaN
 jxjc572S15QcVW2Q9A9XftLPPU2fo3NH5eRPtnKGPdiclk3/tA5PmD2lQ0fNR4XQhZn2
 fYY/v/JUAzwM38KNEtMZJFph/D7lYyaYCz2eLaSnlBKBjNaVDm0Mxub3rrgfb5IFHTjT
 RCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746700384; x=1747305184;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KMtOUDyAwjpqecoun8+xjSclmRlj4tmUuc9dTCbiEV8=;
 b=aqTOH4fBVsiAFs/4qDWexpfA/AehAVyJqu9ZLbSDuANHrfrwIGZkFS7UpqfyYzLwaL
 EfMA0nRY81I5FdReM5Fsb4PrJdmbXJ38v39tExnaFkBwXf9HZg4R1b5RM9yBPrImByU1
 p7PdeL7tx8tf1RP9J73fkHstU1c7YxLnIu2cwwn1BOzdyls1XLg8eOwKTCUv6bsDt0v9
 uXZkcz5ip6U/c8E521rfcf8cpN4vUAd4nuBhBDPlMNo8soWs4amhSCaljj7ZNwR+CLEk
 m/upGjJCsVw4RPVVFkXJUXTb09sAWCUF2LBDCK3haK2F+8fdfraVHVCx/SNUeu1mEfQk
 8pIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWa7EukpKVufAnzZyy9n1t+A/xoxT/8DXltTfZhyp5r+hhS3QEQd5JPCj+lCpiSK3vvW/t7smCh9A/I@nongnu.org
X-Gm-Message-State: AOJu0Yw/dnqNCmH3JhSrqzDTaTGhKqiBKG3vNRx6dI4MZlQQAEolA7gy
 8fqnR3o9iUie+R8FUOXzDKCWwgCGoSRyuFBHvHCCDodgpuwjLSzkKcjktZNPdEn8I6NDvoZsTQd
 606n8UWxUTRRJzTS5Jy3Rps1/X93zkxYQV/ZHgA==
X-Gm-Gg: ASbGncsZZeKYHlnMusbl2dxiXqmIEuharabo7Fj2kaCXptAhwSlVbq6s/hmuWSPiAPL
 N190DsXIp0Ja1VvXB5oxrEtHbSj5o49D4f3QBMq5y/z0F2Putb9xg1IhlPyz1oa51o6U8ee29eJ
 DDIYt49rQ4JApB9+6726MxNhI=
X-Google-Smtp-Source: AGHT+IGftwn4e/xnN3j6P31cm8Yf/u0yUcP4RFH7pgWCyb3qFVhXMHM7d5lZEz3AnQXFN+6mL0SXOp1EDzElTrOvo80=
X-Received: by 2002:a05:6902:6112:b0:e78:effa:714 with SMTP id
 3f1490d57ef6-e78effa155amr2291036276.31.1746700384509; Thu, 08 May 2025
 03:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250502132441.64723-1-philmd@linaro.org>
 <aBnCk2WE_SNkRgSH@redhat.com>
 <20250506040903-mutt-send-email-mst@kernel.org>
 <59c4d557-2f73-4b56-8650-f16ed3cd7bb2@linaro.org>
 <6af5a9ec-a197-49d8-880f-cdd88621e180@daynix.com>
In-Reply-To: <6af5a9ec-a197-49d8-880f-cdd88621e180@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 May 2025 11:32:53 +0100
X-Gm-Features: ATxdqUHp7jirf2HcolIcpMHLpg4XXjrUi-k12MNNu9eYjKtF6HK2NVemzIMK9bU
Message-ID: <CAFEAcA8FR8LmvOSoFjrNBexa4UnC43r21gwxQLO6TJfA-A-JPw@mail.gmail.com>
Subject: Re: [RFC PATCH] hw/virtio: Introduce CONFIG_VIRTIO_LEGACY to disable
 legacy support
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Jonah Palmer <jonah.palmer@oracle.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, 
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-ppc@nongnu.org, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Anton Johansson <anjo@rev.ng>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
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

On Thu, 8 May 2025 at 09:37, Akihiko Odaki <akihiko.odaki@daynix.com> wrote=
:
>
> On 2025/05/06 17:55, Philippe Mathieu-Daud=C3=A9 wrote:
> > VirtIO 0.9 needs knowledge of the vCPU architecture to get its
> > endianness. So we need to somehow propagate that at creation
> > time, guarantying which vCPU (or set of vCPUs) will access a
> > virtio device.

> It may not be too early as QEMU may already support heterogeneous
> endianness.
>
> An Arm CPU have a register to switch the endianness, which depends on
> the current Exception level, and QEMU already implements it at least
> enough to switch the endianness for virtio if I read the code correctly.
>
> This means QEMU should already be able to handle cases where the
> endianness changes depending on:
> - timing (due to writes to SCLR or switches among Exception levels) or
> - vCPUs (as each vCPU has its own register instance).

Mmm -- the virtio code uses 'current_cpu' to get the CPU which
did the device access to it, and then queries that CPU for
which endianness it should be assuming the data to be.
That ought to also work in a fully heterogenous setup with
e.g. multiple Arm and microblaze cores, I think ?

There is however also a function virtio_default_endian()
which seems to get used in contexts where the device
isn't being directly accessed by a CPU, such as system reset,
and which looks at target_big_endian(). That I think will
need attention for a heterogenous setup. (For runtime-endian
change setups like Arm it doesn't matter, because when the
OS resets the virtio device it will set the endianness that
way. But AIUI target_big_endian() becomes kind of meaningless
in the heterogenous single binary setup?)

Note that in practice nobody's going to be actively flipping
endianness and expecting the virtio device to keep up: the
use cases are "the OS sets things up once at bootup before
it touches any virtio device", and "the CPU boots up in
big-endian mode (i.e. the opposite of the target_big_endian()
compile time value) because the board/SoC model configures it
that way".

thanks
-- PMM

