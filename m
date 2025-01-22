Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B878C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 14:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tabnZ-0002vc-Qo; Wed, 22 Jan 2025 09:33:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tabnO-0002ui-JY
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 09:33:31 -0500
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tabnN-0007yw-09
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 09:33:30 -0500
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e46c6547266so10020194276.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 06:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737556407; x=1738161207; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ILzJBeVeOJaRt3x33tApk0oBq1fwp9tG/YCqca+lHK8=;
 b=ufCx//4E5Y9H3ZCQYoPBxaOt7IIKlbGmheuvuQZzDOzP7kiUu13bg8XdtFO1eMOjnv
 NFUxa8Gb13InhDYulMvrAn4gkta2IZnEIuEZx+Jo8AnY1hXMq1CALqnUKvaQecPh1w8q
 Oq37NJ1FW8yUPNOif46beW5GpZhUjx6dHwphB9IoIxuT8Ki2/b5Y02RE6Rv/b8GHL9Qm
 TxbjRXULKu5/sCCbmuVl57ezWycO1DGqoD8OufZUcKOZaOIIgQmcZ4IaPczo0n6q9q6h
 p8a0WP5aeD6rPG5vRtLXXc1aJCMX/z5RpW+jxnnHysFBmtki7+CVNFLboA/QYJfFWhuz
 C79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737556407; x=1738161207;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ILzJBeVeOJaRt3x33tApk0oBq1fwp9tG/YCqca+lHK8=;
 b=G5utj7Ur7Es4Hh0vuvUfMGFBKfSD8Zu3+8VZwgCU1akGaHLKpMXOpc5FYKNCT2Hx/m
 BMSMK+fxiIr71V82iujDUlvMohdYdw8WhkHBGyAtx7t68Tdxz54Vcqa6LTf8MDynGsO3
 F08fLNtVwp8WJCZS8JN1SLv7I+1hxAVrJmwKKGOCBFJHduqXI4uaZcld04XRprad1kue
 rkev5F70XhKwBWK/ncotyayEc3Q6e5N3XZNoxyMLNuj1Pmb9769H/38oZiL2Tfa3v3sC
 m9lzTY8IhVpAIqJEP8Rzxc/dVpsvuI/W2/u/5WVhMl7yvFxAIdbCwMFmcRko/8h6ILuJ
 ffOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzVObZbSO7RuWf7MpoQ0fOn13/XJyRtgkj5Ka6NxqtDsw49A5Qh6M5UqDDlfjMRxTpzZL6/Pv6LPu7@nongnu.org
X-Gm-Message-State: AOJu0YwQByIDSkrHHMpo65rjcquoQOBJeVapINLLio2S8FGxzXa/igUY
 Kj0Mm9fECky0xotb2Pd9Bc8lKMXFqZw11Kx3FfiXm7dvEwtdY3HGQCAg/ZSvKEv+Sl2Zz9C76nN
 BdnDIatObREqA+CR7QD92CBmvHJmAjguCriFmcw==
X-Gm-Gg: ASbGncv0I7OKBymWNYtPJsEqh1cYMNwsFQ2hlaq5dxs4U75A+aRBVVf6YHtH9EsA/H/
 F36yXNOApdQOHinMBoLSllZf7cF07J3k726dElqS54oRG8ivOVDCM
X-Google-Smtp-Source: AGHT+IFVL8AtuKGf7k45657vuRUJUq7An+jskfJi1SyJiVO60AbiRFok5TWAQiQPPSowUpindKJtIsMrlbu1TfeabG4=
X-Received: by 2002:a25:d34a:0:b0:e57:d22a:1914 with SMTP id
 3f1490d57ef6-e57d22a1a98mr9243264276.16.1737556407155; Wed, 22 Jan 2025
 06:33:27 -0800 (PST)
MIME-Version: 1.0
References: <20250122103223.55523-1-philmd@linaro.org>
 <6393ca88-0613-415e-8178-18a34778b2ab@redhat.com>
In-Reply-To: <6393ca88-0613-415e-8178-18a34778b2ab@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 22 Jan 2025 14:33:15 +0000
X-Gm-Features: AbW1kvaNKBFSOoDang2ocA2MTL_mQ3HqVlrsCrKIuJElqBfV3yrn1D-l1GHiPFg
Message-ID: <CAFEAcA-+9xhH+gXWGfN9bN=rnsShyRs0i+Kd0NDfMYrSNVbF4w@mail.gmail.com>
Subject: Re: [PATCH] hw/boards: Convert MachineClass bitfields to boolean
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb33.google.com
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

On Wed, 22 Jan 2025 at 12:36, Thomas Huth <thuth@redhat.com> wrote:
>
> On 22/01/2025 11.32, Philippe Mathieu-Daud=C3=A9 wrote:
> > As Daniel mentioned:
> >
> >   "The number of instances of MachineClass is not large enough
> >    that we save a useful amount of memory through bitfields."
> >
> > Also, see recent commit ecbf3567e21 ("docs/devel/style: add a
> > section about bitfield, and disallow them for packed structures").
> >
> > Convert the MachineClass bitfields used as boolean as real ones.
> >
> > Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > ---
> >   include/hw/boards.h        | 14 +++++++-------
> >   hw/arm/aspeed.c            |  6 +++---
> >   hw/arm/fby35.c             |  4 ++--
> >   hw/arm/npcm7xx_boards.c    |  6 +++---
> >   hw/arm/raspi.c             |  6 +++---
> >   hw/arm/sbsa-ref.c          |  2 +-
> >   hw/arm/virt.c              |  2 +-
> >   hw/arm/xilinx_zynq.c       |  2 +-
> >   hw/avr/arduino.c           |  6 +++---
> >   hw/core/null-machine.c     | 10 +++++-----
> >   hw/i386/microvm.c          |  2 +-
> >   hw/i386/pc_piix.c          |  2 +-
> >   hw/i386/pc_q35.c           |  4 ++--
> >   hw/loongarch/virt.c        |  2 +-
> >   hw/m68k/virt.c             |  6 +++---
> >   hw/ppc/pnv.c               |  2 +-
> >   hw/ppc/spapr.c             |  2 +-
> >   hw/riscv/virt.c            |  2 +-
> >   hw/s390x/s390-virtio-ccw.c |  8 ++++----
> >   hw/xtensa/sim.c            |  2 +-
> >   20 files changed, 45 insertions(+), 45 deletions(-)
>
> So if you are touching all these files, why not go with an even more
> meaningful rework instead? Flip the meaning of the "no_*" flags to the
> opposite, so that we e.g. have "has_default_cdrom" instead of "no_cdrom",
> then new boards would not have to remember to set these ugly "no_" flags
> anymore. It's quite a bit of work, but it could certainly be helpful in t=
he
> long run.

Well, that depends on what you think the default for new
boards should be. I suspect these are all no_foo because
when they were put in the idea was "all boards should
be default have a foo, and 'this board defaults to not
having a foo' is the rarer special case it has to set"...

-- PMM

