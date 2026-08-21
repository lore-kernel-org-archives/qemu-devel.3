Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C35FC5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 09:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxLTf-0005O0-GP; Fri, 21 Aug 2026 05:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxLTd-0005Ne-MM
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 05:23:53 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxLTc-0003OB-6N
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 05:23:53 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-66c4e9769bdso906074d50.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 02:23:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787304230; cv=none;
 d=google.com; s=arc-20260327;
 b=BU99Cb0AY9YzDm90fK9SB8fbjl2HhfXbzvtXU9VHD5cC37Pgul0jmmH6bwqcJBSuEa
 HKJfJhrg31D6gwx/tb0iSk0xNGF5pLSwooIObLKkYjcEjgCC/7TNHrHje9tPxVQJeDOM
 MkUyxkMPJkOiFfpqKLgm0WQfq+BCzU19b7uEAi34kfiM4fPoTdTeM6gFtuLvuMqIhEvf
 bZeIEGzNrMKGdFZaVyr9D1yZ4PpFTmWwR0ACsv2uc+PCtBTUIlZ7GAlIEynZrXgzzMjx
 UqygJ2YgJJ/nIQaDHFoLEF0l5hC2EVbrf/i+/5KaHQSOpFdAoncrOo2eOWVW5QwoRVRp
 H67A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=k02/bwYb2C7W9O9X3E/L/K2Wz5vCdCbnOvWA2AOHkkw=;
 fh=B2R9c9dPyz8m/0Pc2hGy+IbXU5ZCYgi/G36ik355GiQ=;
 b=BhSpzDBP7KIZcFU/VT6nSThF1zFKblkwuYTWN5TfbZkKjqcTlfy+vWmglnFpUnbQBH
 TYtcqEPkpXq1RveMmf6NIRtwqJ60xFmT6c9imEcIm871THBlDp9uvMLKp19NYl8KUPNS
 K8OhEBE9hDVt9ZfPs4SNEvKPg5xTeM3wHouUMwsWC8UC3SdCTCrGHbLevKBARympTrQ4
 xx0gOT0omcPcX4F9FFihZv9qzrBHVeGqI288EVJiZtmX2GFAiESprRuZ7igMkaVnBvcZ
 LI6+Xjwd1mv4hSdTTTOyJIDaBiwEWqNOJlzGFOa0y/MwHhVxsBAHkhgVMvgMSwj46P5g
 9hPw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787304230; x=1787909030; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=k02/bwYb2C7W9O9X3E/L/K2Wz5vCdCbnOvWA2AOHkkw=;
 b=lvhjuqIYT4eBTUl/J47kszrfM+dD8e+7QXD4izWMzavjVF1lgtLGg+rgANWyMGf3aR
 r/7vGz3JEBEQLzIQH7388MuSKQLbFnUylZZVDAkV1EJ/x89AoNT80R3NI4b1B3D7yD3z
 rXG0XwGI/zasp8wYYACh3UDCPwj48jza1cRy/bi5OKlFpsYy7vPPTECqFq+So+w7txVj
 O/5Sm6Vtt/ywWDqwBkLZQs0FCN2PsAgp0JxkiJ+xrdcDnkCYJBpg7FUOSjmMQ26nOt5f
 At911nrVHId4X9/silIqOBHuuZuZNoQ//8R4RqJyq7b9MEYTDhEXjjyO0tmTMs0nK4js
 kuyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787304230; x=1787909030;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k02/bwYb2C7W9O9X3E/L/K2Wz5vCdCbnOvWA2AOHkkw=;
 b=aNDMeF2j6NnnKyxPhI+uTIbn9Rx0lcs63JLxNEMPJTvINGBEvAk4IllXVBTopJrZzy
 L3U13NN+HvNLuST2338iFIybKuNe3CaBfqryob71dmd5UGJX4tlfbNNkQ8o1+v6KZ155
 3/LytL+z18pxWjxWDqd1u+V+vxecwC8fcvxz1wQL2YAI7OCtFUCmfO4P+1SyQUbL3kQa
 3UowxFlRDq8WbDVRfVRrTZmT7GyWhrVIraqVsgXA/8sGfERQghrKiWnORRnxdxlJiiyh
 FxiD6H6jtw0ynXHn0DMAttd6Tqz9CyuO8LuVHzEE/E5NfV8qLn/+Jm275WRxhhvzS0DL
 5jpA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqZ5G9LHKLKg9smqzbGn0Fkh9cXD56pnl6QnhbzShA+9lr4G0zfn9I1BBq6WlJXcpNYhCxUUzYoSPRB@nongnu.org
X-Gm-Message-State: AFuF++nLalWGXlOzJLQnXzPl4EBKY72pKohz9Jz+2pV1gTUWolc2P+W0
 /bQqJZEFOBPkAqYFGehyB9mlJUQngIHWLrZfO5mrl0xvnw6yb9zN6dtPLYWyd2k9huqPxWj4jRo
 Nt9yK/3Ar7u4z3KGpPCiOS8+W02YLTc5/Xtz85xJ75g==
X-Gm-Gg: AR+sD13mZQ0sj35oJigFMtuEGuOv5KnBO1FFI2Xj6Qm7rcjOToZAQmxlUura8oCyrph
 B7E6o0yv0gVH2rr3NQe0JNDCjEk9aoNG6uXUpsiyctuqBf8rS+pOnBxGPFJQ928N2CDtlePbJgf
 dMbC83AbC0UA8xf84HaLsG6Z7oZlojQpb9Y44PKLd+wv2xP0t46yv2NxQ6ww3bZiTMLUVuJ9ttd
 +x7lz+7AweZila4+uB+IltKWR3RceDBlRhW4YoYyK4X59m3vbDG3hMQmt4JqZREjW4925/F7kTr
 14AsdFCtNfLHbj3t7HD8jIxBRAIy1XhVt2pTRyKZ/nJMXFiILZt5EiS1yF/hIGLjYgoqhVR5w0b
 Bc/166jw9Dgb7qfqDEV8ugchteluX
X-Received: by 2002:a05:690e:2587:b0:669:48b1:d19f with SMTP id
 956f58d0204a3-66ce4b4ace1mr1791102d50.39.1787304230558; Fri, 21 Aug 2026
 02:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260816131300.51799-1-bin.meng@processmission.com>
 <20260816131300.51799-2-bin.meng@processmission.com>
 <da09d1aa-5aed-492d-9afa-01d3a1fcb813@oss.qualcomm.com>
In-Reply-To: <da09d1aa-5aed-492d-9afa-01d3a1fcb813@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Aug 2026 10:23:38 +0100
X-Gm-Features: AcwNN1VmNjs9pv03tbrjQRoB1TO9jDIYH5m2pCHQsZdE7OWn4O8qoZ--8hfv2tQ
Message-ID: <CAFEAcA9scKMTHfrGdYRY6i+2rtU26z8ObTx5fOC3iDbDdtpPdA@mail.gmail.com>
Subject: Re: [PATCH v2 01/20] hw/arm: aspeed: Store boot info in the machine
 state
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 Kane Chen <kane_chen@aspeedtech.com>, Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, 16 Aug 2026 at 15:54, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 16/8/26 15:12, Bin Meng wrote:
> > arm_load_kernel() keeps a pointer to the boot info struct for the
> > lifetime of the VM, so the struct logically belongs to the machine
> > rather than to a file scoped static object.
> >
> > Move the boot info into the existing AspeedMachineState.

> > -    aspeed_board_binfo.ram_size =3D machine->ram_size;
> > -    aspeed_board_binfo.loader_start =3D sc->memmap[ASPEED_DEV_SDRAM];
> > +    bmc->bootinfo.board_id =3D -1; /* device-tree-only board */
>
> Should #define a self-explanatory BOARD_ID_DEVICE_TREE?

> > @@ -42,6 +43,7 @@ struct AspeedMachineState {
> >       char *fmc_model;
> >       char *spi_model;
> >       uint32_t hw_strap1;
> > +    struct arm_boot_info bootinfo;
> >   };
>
> Maybe time to add a typedef to be style-consistent.

Mmm, and if we're adding a typedef then fixing the capitalization
style to ArmBootInfo is what matches our style guide.

I think these are both good ideas but in the interests of not
delaying this touch-lots-of-files patchset too much longer
I think we can do them as separate patches afterwards.

(Interestingly the kernel does not bother to define a
name for the -1 value -- it just hardcodes ~0 in its
DT_MACHINE_START macro.)

thanks
-- PMM

