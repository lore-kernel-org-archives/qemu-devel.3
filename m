Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B09FCFD376
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 10:00:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQNAj-0001L1-SI; Tue, 02 Dec 2025 04:59:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQNAh-0001KV-RU
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 04:59:47 -0500
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQNAf-0002wV-F7
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 04:59:47 -0500
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-78ac9f30833so42691397b3.0
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 01:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764669584; x=1765274384; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M61zbiKGh+28tMQvSneWKLphvK1HV0LNOeNffpRI8DQ=;
 b=bdZgrmCKX4S9ObVck9jYtow4fMdUw44MDi44qx5OzUmxcmhwr+vO1DD6Fba8ZsY8bI
 mfGzJeafKiUMDJ8s1OL6muRKkicvb6VKgB1RHTDCRzTDgkjkNxPR38EHYCUbQxKZ7JSC
 s7ttf2QvBrtCjacEW2Yt505IuPyHiDe4FdMmUS/ieD7Tkp+kQgKmkxuk865u9h4dLcD+
 iM4sCDuWg5MWYDlwtwa9mlKsJHz2DQ6wIRyhb3sUd2vjgb3dXukozCgPZsjpV/K0q/Te
 fM7Z+eoHbmwaukNSZakhFD4aiitvWYzDGZCltYLGdKb9HWK93XMgVAcH43n5mxgbua65
 zuMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764669584; x=1765274384;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M61zbiKGh+28tMQvSneWKLphvK1HV0LNOeNffpRI8DQ=;
 b=sbDbzPi6ZrcF+XHN6p5+yqNLSZnmX9CYW9WKxvJckCwpJMehc5FMAIHTkgsCahXhTx
 Hcc7fkY8oIfch2aPx/FssTQIeQmzdU6BA0Z4scdUwe1kaIPA7Uxu5+py3uOHOe/9JB5K
 qYn3g1f/85eoOvpd2Mdh4729xOEzFW+y/JK3UZEwubHNLSQb4B3IbTPK3I2Hdd61PNv4
 wQkkQxnaZSIK5A8JWNrsnsCqRZVXhwZitmsj7smyXb8S+h1YUl2w5uk+TzAMv1dR0SVY
 cFLBIUgItKh1PhLmV+kAHIHKgRXMzoZjUbkX5/bzA18CpVVjog+vsaN1dmWyqXjsjqLy
 MgNQ==
X-Gm-Message-State: AOJu0YyDh5DjfqRiwj7dfvXbZ1ltLZ/jJ7BEHt1UB6QHOQ0dSxX41HEt
 XmumeewPsCNFv9LL5UFSlltq6qr+P3xitBpi1NAy90cZA51sFIkyu9s8NgWT+PWtr/HfMq2k7Th
 ncEpAIZHqWcaQbmeBzJ9CPlYJoRsXBaNHcj8JH3HTLsixPORaMNV23gM=
X-Gm-Gg: ASbGncsEenIL3DFul5vI8LevaWEu+Z55H9AwrfqOCNTbjAEcjmD7DNm4Me5UrF+NNty
 OBSGu8BFrzuoWMBYsNg37koEeTpig7EBBf9Ex6Ku+5xwu5WNr0v/jRGT02wvowrt9XdySktVyGZ
 nnbBvNn+R5PJ5eLs+NBb+xmBaBlETY/oEISEiGcRE+z7Skmkx1RQQnmYqLt7SINpaTmGVELqffm
 lpYc6wqDxw2BhQEhD44cuhUQckKzqPvWLSF1Kq7aeJAcOPq29sfNrCb5JX22kt3Vc35GpB4
X-Google-Smtp-Source: AGHT+IFocvcHtelExyMKbVThc05t67yA6W2K/6jOUfqWNWog37iKLONHVbYAVxdWAW47xvDnXNdtdfcgTlkQFjy7Oso=
X-Received: by 2002:a05:690c:d93:b0:784:8153:c61a with SMTP id
 00721157ae682-78a8b529edcmr376673497b3.34.1764669583965; Tue, 02 Dec 2025
 01:59:43 -0800 (PST)
MIME-Version: 1.0
References: <20251119130027.3312971-1-gaurav.sharma_7@nxp.com>
 <20251119130027.3312971-2-gaurav.sharma_7@nxp.com>
In-Reply-To: <20251119130027.3312971-2-gaurav.sharma_7@nxp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Dec 2025 09:59:31 +0000
X-Gm-Features: AWmQ_bl16XRVXcV-7-qvmqSLAP4x3lexZRHbjyla-EUBBejGylaSexlcXBmHiRQ
Message-ID: <CAFEAcA8pb6cJ0h+L=fsE28HYpgkC2BWrT=kcwgVxCazJMPMy+A@mail.gmail.com>
Subject: Re: [PATCHv3 01/13] hw/arm: Add the i.MX 8MM EVK(Evaluation Kit) board
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Wed, 19 Nov 2025 at 13:00, Gaurav Sharma <gaurav.sharma_7@nxp.com> wrote:
>
> Implemented CPUs, RAM, UARTs and Interrupt Controller
> Other peripherals are represented as TYPE_UNIMPLEMENTED_DEVICE
> Complete memory map of the SoC is provided.
>
> Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> ---
>  docs/system/arm/imx8mm-evk.rst |  68 ++++++
>  docs/system/target-arm.rst     |   1 +
>  hw/arm/Kconfig                 |  12 ++
>  hw/arm/fsl-imx8mm.c            | 363 +++++++++++++++++++++++++++++++++
>  hw/arm/imx8mm-evk.c            | 109 ++++++++++
>  hw/arm/meson.build             |   2 +
>  include/hw/arm/fsl-imx8mm.h    | 156 ++++++++++++++

Could you also add a section to MAINTAINERS for this
new board, please?

> diff --git a/hw/arm/fsl-imx8mm.c b/hw/arm/fsl-imx8mm.c
> new file mode 100644
> index 0000000000..0c658141cf
> --- /dev/null
> +++ b/hw/arm/fsl-imx8mm.c
> @@ -0,0 +1,363 @@
> +/*
> + * i.MX 8MM SoC Implementation
> + *
> + * Based on hw/arm/fsl-imx6.c
> + *
> + * Copyright (c) 2025, Gaurav Sharma <gaurav.sharma_7@nxp.com>

Are these files really Copyright you personally, rather than NXP ?

> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */

Is there a URL for a reference manual for this SoC that
we could give here ?

thanks
-- PMM

