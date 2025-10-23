Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6662CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBuV8-0006cI-Ey; Thu, 23 Oct 2025 08:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBuNl-0002DW-VA
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:25:32 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBuNi-0007dv-59
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:25:29 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-71d71bcab69so7337317b3.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 05:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761222315; x=1761827115; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=coX3KGZGroDxNHrZ4mhAkuLR6HRjaI1KOz7uItO4O2U=;
 b=aGrlR5i9oqqOjnX1in/aySesJX8t5LDVsgV9JUTfvTIAMzQgk/5PsFRVoAR1l0kogi
 T5N7JgPKfQqvuTjZJG2dZZy8AgdDYIoCXE1Rgu6PF88eQxVz9LggjDi/BnGEOCvGnfa7
 7/l7yIBdBucAVvVzYA7c0bcAHJpHq2N/ts/UfyUVkly5vcALTpk5nG3Jk0KdKOebCJuf
 ltEFEKCUSrNBH9jiY7gae8UC7UTjIN/fXj/WPKr4cv+OLqnwiPC6XpNYwkXq+gjopOqb
 OWybaqm0wcAmpOaCrG7pxCW8D0fLTlqw0nBb4lwverYblDEzAAqyFO7Sr65uVN/pgeCh
 jdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761222315; x=1761827115;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=coX3KGZGroDxNHrZ4mhAkuLR6HRjaI1KOz7uItO4O2U=;
 b=PBRSwZAkHL750BoFstApNTl5hQB+uT6px9qmOxLhABWeypOZ81pyFO+uXBdZz1hV7j
 2SGpX6IhYNfdzQ+CkaLIwlDK3Ikbj3PDR1G6UgA8DYUC9Ztr/pD9QyH7sBfcOFQa9G10
 AtI9jyt+68Awgdjx2bpTvsLPnsZIoc1hp08KoVpD+odaOYvD1hb+FdxIayRI3+BzJmpt
 bQUOgkSEXZSYN2461YsM0K2e63z8q6LFj64T0VgpwWRJhSdrjV7OS0SQcS2oSHFnmhxS
 UpN22fxDp7Bb7zk0hII1+JhUdKxueIVjM0ZESzwDWt25yIv7yQYvF/GHT9Qwh42J1dxa
 n+3A==
X-Gm-Message-State: AOJu0Yxrr2z2WIj1suuLLrrKYKBznrXoTdRBwsf/SWCTrPwgM/jny3w9
 zU5PML+cFHWOp5IJ0DJD8iwMRIi038B7+4WMiszyL1EulbS1zY0ojsER6/HblUN00pUK3lXlxuv
 fl1fxKKxSNc5Ff/mCYNpJcwADoukT55EihaRcNFp2cg==
X-Gm-Gg: ASbGncsI6ajKJ7hQXRGfVdFAxIPVO4txHjmPxKkYzqdWySQ6oJbl9ILj/3G9GXLFC1X
 igjudKpDvzMkaK3Wy1NIjWquNr0pTe3jJj0kp6CtCnoZ2AjP3XweGM1BJvBOqnRrCjfQSk0f2sp
 WoB3UfC86g1SppA2NmFs4quEUcX68ESpjaUlreHAbK+6/FPXw3WKl23YrJc0Gr1rRCwLhHFvype
 +3Jvi/qcDFnqFC41HHY8c9W1e0N9DMhlRjdCcE5kln/Oc87VangLQtA9xO3GYwvOAoliK5q
X-Google-Smtp-Source: AGHT+IGzbrBaOc7ai4U1OaQbuxrP84QC0YVxrQ7D3vpHpxPjHvD9UkmEWLERW/NCW1H3gRZZpTCByAtiy8sYHS3ANtU=
X-Received: by 2002:a05:690c:6891:b0:781:64f:2b0f with SMTP id
 00721157ae682-7836d39a031mr211048657b3.65.1761222315071; Thu, 23 Oct 2025
 05:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <20251015091729.33761-1-corvin.koehne@gmail.com>
In-Reply-To: <20251015091729.33761-1-corvin.koehne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Oct 2025 13:25:03 +0100
X-Gm-Features: AS18NWDD2W97qDDD_xi7uFaf-_MuoPVPNNqBSox42xGoAABTh1wWHkPB0-lbDr8
Message-ID: <CAFEAcA9+oSu+z_Jgm6dK6hVdTYf=NyGrD_cOF--+j=uOZJD8rg@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] hw/arm: add Beckhoff CX7200 board
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>, 
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Wed, 15 Oct 2025 at 10:17, Corvin K=C3=B6hne <corvin.koehne@gmail.com> w=
rote:
>
> From: Corvin K=C3=B6hne <c.koehne@beckhoff.com>
>
> Hi,
>
> Beckhoff has build a board, called CX7200, based on the Xilinx Zynq A9
> platform. This commit series adds the Beckhoff CX7200 as new board varian=
t to
> QEMU.

Did you base this on current master? beckhoff_ccat.c tries
to include "exec/address-spaces.h", which hasn't existed since
commit dfc56946a7005 renamed it to system/address-spaces.h
back in March, so it doesn't compile...

-- PMM

