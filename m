Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D30C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 13:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmvux-0004pO-NG; Wed, 20 Mar 2024 09:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmvuv-0004p3-Rf
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 09:23:41 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmvun-0002qq-Ie
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 09:23:40 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-568c714a9c7so4867130a12.2
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 06:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710941010; x=1711545810; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aPPeELzfp5oH6kR2aiQwq9oPNOmrrcpNf0JV8zedWZg=;
 b=raLEfDx3PEWwpXRTxf9Q8knzFEIwaAy7/cFi0nIiBJUNRM1UO9SeOEXil8TkAj4hfa
 TVurkPzmHYM/f/GPaAJIYWnpPXFVD07cPduFiN01aJdgHN6tff80yFdOzp2ndgl9DqC1
 uhFuP9IXLbLJ0Ga9LlcSNSWNB6xGRO9ogywsKI9shO3plTkBCTuP1tMM1FvpIt/ZSA4s
 lxnXEsDxIeCC2hWmI7FNGEMgMIh7a2iy2lx60vDzA2H4rrTwng0VMsD9sn5350p18ypd
 YBKILaKWveg50nm5O9IoRhRWuCNjIfWgMV8cW9tdmikqZEVTH5NyZaeLfshmrJsK0oaO
 N2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710941010; x=1711545810;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aPPeELzfp5oH6kR2aiQwq9oPNOmrrcpNf0JV8zedWZg=;
 b=ODLntwg1vBBg80kDeILuB4icMGxaMfF67rSiCvcf3f5we7WkS6z+oJ7x9pkqrjJ1Su
 a3YeyBxMbLlCP9cNho57foX9LCLrdOuYGqZbPK4xYwjPVzcVmLvDQGX9gyIVOapv1oO1
 +aLDkkrG8SloIC2bfMVLZ2O88CGxHsfo40P6VZrWHM5kiCNQlLK5g09BJcfBzInMBWRV
 U9FxpocwqQL/mEGQzcob6slc/OMKlJUs1mv7bPWQiVQNdc4H0I/3GGNV2a15/cze/Eeg
 WfJCTeA2w1HbDrbt1u2OqZzeaxVm1dqab1BXDDlY8kT2vVRSSC9auTvf4fzxWytkTL1t
 WI1A==
X-Gm-Message-State: AOJu0YzdC1DvXDuqEq/PfAV2CgwvOLKPScDM0PA8XqwEll3rcHDfy4R4
 UX4KrN3QClngNXzhk/YyFI1SNwxrcKvsu6GpAUfHzSA+ocmLHMV3oGyNYvkwgvGACR9V/bLCPtJ
 1YqByhmqlqVOT1pNwC1HhgWqhislKztLqX+N+zA==
X-Google-Smtp-Source: AGHT+IFdiUxXyr0lJbN32TcZ7VdBsocjsraprBNBYUQU5ntKxZQeKh3xmpPwjygn4dUr7rkU7chhMr5V7Ltnly0Pr6E=
X-Received: by 2002:a05:6402:3788:b0:568:9934:6dcd with SMTP id
 et8-20020a056402378800b0056899346dcdmr13651765edb.0.1710941010561; Wed, 20
 Mar 2024 06:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240220150833.13674-1-philmd@linaro.org>
 <20240220150833.13674-4-philmd@linaro.org>
In-Reply-To: <20240220150833.13674-4-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Mar 2024 13:23:19 +0000
Message-ID: <CAFEAcA9kVkM16paZQfH1voNNjWRT3DmchepiMs045w+YA61Fzw@mail.gmail.com>
Subject: Re: [PATCH 3/4] hw/nmi: Remove @cpu_index argument from
 NMIClass::nmi_handler()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, Helge Deller <deller@gmx.de>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 20 Feb 2024 at 15:09, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Only s390x was using the 'cpu_index' argument, but since the
> previous commit it isn't anymore (it use the first cpu).
> Since this argument is now completely unused, remove it. Have
> the callback return a boolean indicating failure.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/hw/nmi.h           | 11 ++++++++++-
>  hw/core/nmi.c              |  3 +--
>  hw/hppa/machine.c          |  8 +++++---
>  hw/i386/x86.c              |  7 ++++---
>  hw/intc/m68k_irqc.c        |  6 ++++--
>  hw/m68k/q800-glue.c        |  6 ++++--
>  hw/misc/macio/gpio.c       |  6 ++++--
>  hw/ppc/pnv.c               |  6 ++++--
>  hw/ppc/spapr.c             |  6 ++++--
>  hw/s390x/s390-virtio-ccw.c |  6 ++++--
>  10 files changed, 44 insertions(+), 21 deletions(-)
>
> diff --git a/include/hw/nmi.h b/include/hw/nmi.h
> index fff41bebc6..c70db941c9 100644
> --- a/include/hw/nmi.h
> +++ b/include/hw/nmi.h
> @@ -37,7 +37,16 @@ typedef struct NMIState NMIState;
>  struct NMIClass {
>      InterfaceClass parent_class;
>
> -    void (*nmi_monitor_handler)(NMIState *n, int cpu_index, Error **errp=
);
> +    /**
> +     * nmi_handler: Callback to handle NMI notifications.
> +     *
> +     * @n: Class #NMIState state
> +     * @errp: pointer to error object
> +     *
> +     * On success, return %true.
> +     * On failure, store an error through @errp and return %false.
> +     */
> +    bool (*nmi_handler)(NMIState *n, Error **errp);

Any particular reason to change the method name here?

Do we really need to indicate failure both through the bool return
and the Error** ?

thanks
-- PMM

