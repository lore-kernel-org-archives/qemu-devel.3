Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1842E68951
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 04:32:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6Mqf-0007D1-9p; Thu, 31 Oct 2024 00:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6Mqd-0007Cl-TQ; Thu, 31 Oct 2024 00:31:51 -0400
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6Mqc-0007rE-CB; Thu, 31 Oct 2024 00:31:51 -0400
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-50d46cfcbc1so197045e0c.0; 
 Wed, 30 Oct 2024 21:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730349109; x=1730953909; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QWPFyYv8tWUTQlDwQvxk+wa+BarRO7P8WkYjElgotIU=;
 b=Gkj6GRQXZfZj7kBQz/MPGSct2QHtpL7nIzqady1jJkFK76P+Dcs66WzhNMqtHwdWhV
 8MjSpHnIN5pc3ns76BIqiGMFrXo0Up23BYl+g889sMGVn49mx/yi1sxDaVV5tVwylBm1
 SCj+UcgKLGsP0IKFpF2gC9TjpvqhOnW5+We5yUo3A7Dx0CjtJFxjh6UmZC561Dj7v7HT
 4Mtdg5h6yFIw/2ru31/P23/CEEs/iiuWVsaAxinscJP7AWZix7bANeRvdNf1thfe13Mf
 qNx4UST7PLC7a/KQX6kjo8YWcG7mARqvPYnWeMmGhoiYAu8DhOAOquXFjsTIIWoC3hZY
 ZfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730349109; x=1730953909;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QWPFyYv8tWUTQlDwQvxk+wa+BarRO7P8WkYjElgotIU=;
 b=Iuk3l8BF8DTW8CX/Ce6mpnSN1Ce0vyq1dnWLcOE6Q55bfQWORyVd73UEK5Q3gjpWc6
 ImjltKqs8a02Uqs2uunHglnBMf6Mrv0BbZ4bpgINzVdO/aFtrxkdB40K7TxFyH3U5QuG
 ImhMa3uNrF4eMiOls8Nyeps/O6DjtS1tVjFoapnOVUt/dM94Pis4XL7yGCNoSz5Oaom2
 2txKUGXAiC4LgsuS0GRBNZwLsLvS117Bt36YR9FRe/9nPMi/niPL+q5RUsCeUNn9U3B6
 hOvaObB1cF2FhpOqbeGByrxP7BzfqDK6y3pu+CsyDRhnEE5O4VtEKvvvZ1BlEEvHdEX3
 RlNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAO8tHELUCWR46yVCX4xlRB6lJu+ovsc5rZ1yoQG2Cj0IqAwDKray8AhO+wBXLMQANbERQc4D5tVo6OQ==@nongnu.org,
 AJvYcCXjL0LIT83+sJ2aGwmTozSs0b2N9qt308Isaa1pK1as7QY1IzMNy/cFzrEdvJAagpyrCA89zgvpvKvA@nongnu.org
X-Gm-Message-State: AOJu0YxtYGaIc7El1BKejkK5NOhwe2c34NS8SHL/pWiJki72nL1LsUBD
 6Nu9UINeVuDgUS7lSiuoiRsFNIAPeLLNj3c9+PR70YrQ2mj7qQIgJeDjN1la2zMH7LNRmp5hr7M
 Ee/kSz59Dg32Hh+w6MJ+s7j8jkPo=
X-Google-Smtp-Source: AGHT+IEc+PFp6fJlA63j+PYiwkr1MqYl7z8UuCsI3y42daDAszijRZHYiD4Xgad4MWr+kJ5Yn8Fix3epvkS/exLl58Y=
X-Received: by 2002:a05:6122:a24:b0:50d:354a:19ae with SMTP id
 71dfb90a1353d-5105d0d3338mr5899290e0c.10.1730349108622; Wed, 30 Oct 2024
 21:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20241017072507.4033413-1-sai.pavan.boddu@amd.com>
 <CAKmqyKNfoakaJ66PCN49x5+=gVkAnQVV1UWTdPe7ARr3RA8ouA@mail.gmail.com>
 <7dbcb2de-89f9-445b-a096-2a3d03a2dfe7@amd.com>
 <34d6acf1-2106-481e-a016-375e697f31cf@linaro.org>
In-Reply-To: <34d6acf1-2106-481e-a016-375e697f31cf@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 31 Oct 2024 14:31:21 +1000
Message-ID: <CAKmqyKPrrYXigM42DyTGFv2SvM=e9iGdOiig9pWfSKWJ3mJSVA@mail.gmail.com>
Subject: Re: [PATCH v2] hw/riscv: Add Microblaze V 32bit virt board
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Michal Simek <michal.simek@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a32;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa32.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Oct 31, 2024 at 2:06=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Hi Michal,
>
> On 30/10/24 02:53, Michal Simek wrote:
> > Hi Alistair,
> >
> > On 10/30/24 03:54, Alistair Francis wrote:
> >> On Thu, Oct 17, 2024 at 5:26=E2=80=AFPM Sai Pavan Boddu
> >> <sai.pavan.boddu@amd.com> wrote:
> >
> >>> diff --git a/hw/riscv/microblaze-v-virt.c b/hw/riscv/microblaze-v-vir=
t.c
> >>> new file mode 100644
> >>> index 00000000000..6603e6d6b06
> >>> --- /dev/null
> >>> +++ b/hw/riscv/microblaze-v-virt.c
> >>> @@ -0,0 +1,181 @@
> >>> +/*
> >>> + * QEMU model of Microblaze V (32bit version)
>
> Is there a 64-bit model planned?
>
> >>> + *
> >>> + * based on hw/microblaze/petalogix_ml605_mmu.c
> >>
> >> Just a question, are you sure the virt board should be based on the
> >> petalogix_ml605_mmu?
> >
> > It is definitely based on ml605 and it is fair to say it and keep origi=
n
> > copyrights around.
> >
> >> This will be the reference Microblaze V implementation in QEMU, and
> >> the petalogix_ml605_mmu might be a bit old now. It also uses a lot of
> >> the Microblaze architecture components (like the interrupt controller)
> >> compared to the RISC-V architecture components which might cause
> >> issues for you in the future.
> >>
> >> Just something to keep in mind
> >
> > And the reason is that it is really design like that in design tool
> > (Vivado).
> > There is no risc-v specific interrupt controller use but origin axi int=
c
> > used in origin Microblaze designs. Timer is the same story.
> >
> > ml605 board and it's chip is old but IPs which are used are still
> > supported and used in new designs.

Fine with me, just wanted to check.

It's probably worth stating all of this in the board's documentation,
just to be clear that it's an abstract board.

> >
> > And regarding using virt in name. We can create design like it is
> > described but it is not going to work on standard evaluation boards
> > without extra fmc cards for example.
> > It means word virt is just description that it is not really target any
> > specific board. Definitely name can change and suggestions are welcome.
>
> What about 'generic'?

Yeah, I think we should avoid virt. generic seems better. Or something
like "example" or "base". Names are hard

Alistair

