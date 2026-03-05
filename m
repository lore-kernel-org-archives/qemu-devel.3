Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBCFAF3092A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 10:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy5cR-0004dX-Kv; Thu, 05 Mar 2026 05:07:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vy5cI-0004Zf-9k
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:07:38 -0500
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vy5cG-0007W6-DM
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:07:37 -0500
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-7986d231b3cso104040847b3.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 02:07:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772705255; cv=none;
 d=google.com; s=arc-20240605;
 b=fXZGgl6g/TkjnEQ0mB47tKkdVFAbfKzL3TjtwUJDejOSJmFu0uDwfsxLogMNf6iC54
 D812Cqz8Wl4XdGelPVTz4hkh+mBpaNCeu390keVBoRN/Bf9KH53k0CootHiiNyQ5w+/N
 WFeaeNRlwwVm6WlEsAIeMd2O0EXjX4+8+vrwDt4OJenMc7KwMWI+p47BBXaQ17kbEE5s
 nXJwHbZL7MUZKjnRtDxEd44IJsVAxp5Hpf8LUNmWTMbDf2V/Mf5Jqt4T9+tbtXtQDvS0
 PalkTUx8nEf83I/fvPrXQSQPrlKeJbtRhNORaZYm+/CGZTp7olQirKXPPPmcWp1fpPse
 ql2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+46PBAE5dfExJ6zUoKpB0SFCPla//ppQb7h2XoBIa1E=;
 fh=jIzvWV6lmISWZTXv3M0Np2HMsoZAsMa3LTC/2QEOYEg=;
 b=SY0uoKORzORUhq534B/bWYYA7Gd9MyokNq8EyXV5lmaMJjAqNXMQUKPDkRcDmo6Cyc
 Hhk2FgVUHL4o7zR7f9RH6+8i+2FStlHzsCupf1Nr9JZH6dx2G/wryo0+2yc+/qG06bUt
 atFzBEThUO0w0aFCIFy/RI9lp/QW7NvxdrpkDEhwBMCQhjDOHz2s69dpUnt34FD88nam
 eo6soOwgKSLvuPkl3fFIJkH/TqcrcFbFb4+pT8frEJBySk3Y+FnaMjfbYA6m37i1EsUe
 XHxg5evzsjYgqlqk7LTLLa+xdHlLJgyrlztC3u+3FAJnVorK2RQmm+tNXx6+OAPcUMbb
 Pp7Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772705255; x=1773310055; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+46PBAE5dfExJ6zUoKpB0SFCPla//ppQb7h2XoBIa1E=;
 b=xd19bQ6E2STDqTKekquppd9HZoEViVwwuw3iY/ZxTHFCs2fuXYCl8gHwTjnCo5Bhjh
 B8wnYPj0BpAdz2/TzQuxZ909krIOTLjxZ4uQEQwGiA8E7Fy6DzpXYcbSJY/eDjMDHSnH
 jI9LYVNnuAlRUWXTuenLxqn/mlUzZTxYWFqLPVrH+MWqJ1N0cDORQHdnQ9zHnpevQlR9
 2oNjFXUKPDZ3e4BSfC+cLoD0NE9KHAWHBwH39wMKEmglg6maz8HnLyJz2N5aABQdv0MW
 JwiaWg6M5aSuU+A2n9QU7jwXO+LCnPzVDKl9BjBLMq4VuH3gCa2V811jXpNTJcmOroNA
 3BXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772705255; x=1773310055;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+46PBAE5dfExJ6zUoKpB0SFCPla//ppQb7h2XoBIa1E=;
 b=tFh0Kj6+zH+T5SBuR2Gn9u7Ptt/kBe2+fPG20wOBBQ9htoDK0884aDZiw4gFLLD+wP
 QHXGCgj0MZkxszo58zddWT4BDbzUQQBFk8sG+egIJlh2oLKTQHU+lyLLTICPlTGUsHvY
 s72gLGELPtx5wXdhcRZdv7+OZJphyiN8TVfhXb2cvL4cW8dJXm8xL2AFW9/5kE1qyyFo
 LhCa6wg+2X7N4ea/TWbZOtT4v3qigRFAXEJJs8LRUae906RuAvpOTW9HN4Tp6fTRb9E8
 ASFXUO7ucj4dJldORhxJd3NuVXt5avHsB7QO+P1Sd+XtGvh3cytNvNHmCxr53MllkjAL
 MDyg==
X-Gm-Message-State: AOJu0Yyh/bNXoyx+kHaHR7S+F+uJnHYFHtmetvSYdplGsqTrhHkZ3rZW
 VbjzacOmOVH91ZtUhIab+5u1L8yN3luzxFtG888L/8H3bXFiWeqzqR8dfOZKBWjXHkFBEa0ZEWs
 XCFFPoZ/hoKeP82n6q6BN1Q4H5SGxOHtFkvUMKGwNsHWq4LbPHW8k
X-Gm-Gg: ATEYQzyoI2kkvBaay0n7rpCfC89KqIoVMrx2rJURkCk4uN9XwWIZc3vuH+I7JKS7PJo
 YuVwZAiQ/SHxK/H3RS5IMjSJ3TLGxpscc6pvGjYTtrFDuB4PQcbc2/Mzb+AM+wiMV0hX0jKrZNE
 +R4IBptvRVy38aYFLn6akOaA+gP7xLMCoglPM1gxahBsfkQALJEo3Yy/IYHmtznKurORHWjt8Et
 6lAzFnDy6Z9fK9mVP/DdlRrhjFFod1l1M9FgWb5Qa02Y5H9lRkUu9HRRzSezv8CdKVdv02M3wbK
 nJzpXubYv+QX9jvjx0rR1LDNI7r1jejr8W7VuE8IGMUy7P3hQ0GTbOFA2mw7+SHkG1s=
X-Received: by 2002:a05:690e:118d:b0:649:601e:432f with SMTP id
 956f58d0204a3-64d070f58e1mr1261297d50.16.1772705255009; Thu, 05 Mar 2026
 02:07:35 -0800 (PST)
MIME-Version: 1.0
References: <20260303222143.142741-1-shentey@gmail.com>
 <20260303222143.142741-13-shentey@gmail.com>
In-Reply-To: <20260303222143.142741-13-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Mar 2026 10:07:23 +0000
X-Gm-Features: AaiRm51NkiPdLBQUrOzgk6o0VMlTRHI-BEEjXNeIbRe9fT-B4AqTejoCmfqH1pc
Message-ID: <CAFEAcA9LLOTOrkUQW3Q74rrOiXGa7BoC8Lu11O9ESC-36WHtew@mail.gmail.com>
Subject: Re: [PATCH v2 12/13] hw/char/serial: Inherit from SysBusDevice
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Troy Lee <leetroy@gmail.com>, Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-arm@nongnu.org, 
 Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Tue, 3 Mar 2026 at 22:22, Bernhard Beschow <shentey@gmail.com> wrote:
>
> SerialState currently inherits just from DeviceState and serial devices
> use SerialState as an "IP block". Since DeviceState doesn't have an API
> to provide MMIO regions or IRQs, all serial devices access attributes
> internal to SerialState directly. Fix this by having SerialState inherit
> from SysBusDevice.
>
> In addition, DeviceState doesn't participate in the reset framework
> while SysBusDevice does. This allows for implementing reset
> functionality more idiomatically.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>



> diff --git a/hw/char/diva-gsp.c b/hw/char/diva-gsp.c
> index 2ea60103ea..55c42effe9 100644
> --- a/hw/char/diva-gsp.c
> +++ b/hw/char/diva-gsp.c
> @@ -56,13 +56,13 @@ typedef struct PCIDivaSerialState {
>  static void diva_pci_exit(PCIDevice *dev)
>  {
>      PCIDivaSerialState *pci = DO_UPCAST(PCIDivaSerialState, dev, dev);
> -    SerialState *s;
>      int i;
>
>      for (i = 0; i < pci->ports; i++) {
> -        s = pci->state + i;
> -        qdev_unrealize(DEVICE(s));
> -        memory_region_del_subregion(&pci->membar, &s->io);
> +        SysBusDevice *sbd = SYS_BUS_DEVICE(pci->state + i);
> +        qdev_unrealize(DEVICE(sbd));
> +        memory_region_del_subregion(&pci->membar,
> +                                    sysbus_mmio_get_region(sbd, 0));
>      }
>      qemu_free_irqs(pci->irqs, pci->ports);
>  }

The ordering here looks a little odd -- is it really OK to
keep using sbd (passing it to sysbus_mmio_get_region()) after
we have unrealized the device ? Remove the region from the membar
first and then unrealize would seem a more natural order.
Perhaps the MR refcounts here save us, though.

> diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
> index 38e5a78e6f..4e51d14111 100644
> --- a/hw/char/serial-pci-multi.c
> +++ b/hw/char/serial-pci-multi.c
> @@ -50,13 +50,13 @@ typedef struct PCIMultiSerialState {
>  static void multi_serial_pci_exit(PCIDevice *dev)
>  {
>      PCIMultiSerialState *pci = DO_UPCAST(PCIMultiSerialState, dev, dev);
> -    SerialState *s;
>      int i;
>
>      for (i = 0; i < pci->ports; i++) {
> -        s = pci->state + i;
> -        qdev_unrealize(DEVICE(s));
> -        memory_region_del_subregion(&pci->iobar, &s->io);
> +        SysBusDevice *sbd = SYS_BUS_DEVICE(pci->state + i);
> +        qdev_unrealize(DEVICE(sbd));
> +        memory_region_del_subregion(&pci->iobar,
> +                                    sysbus_mmio_get_region(sbd, 0));
>      }
>  }

Similarly here.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

