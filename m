Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF34C55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 15:37:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrdfu-0002M7-1V; Wed, 05 Aug 2026 11:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wrdfr-0002LL-VO
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 11:36:55 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wrdfq-0000MZ-JT
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 11:36:55 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-66771ded50aso1644271d50.1
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 08:36:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785944213; cv=none;
 d=google.com; s=arc-20260327;
 b=Y/H1bSxMREEcDWOrIZlVCR4l6hCO7w1HXeXwdzSpZDRWwDq4U/adDHhhGMoLfSZ0Px
 8ZupvL68fO/gQYJ8gL9RjCa2CuJPJe5LrISs+54sMi+9brQr1T1ElN8WFBkLgkIX8vGj
 e5VrpB25HpBAP7gStdhrLqsYRBfLpzS89JRVRujfPlTRyJw8L4JgKWoRwMmGGS/xoB/3
 +4oPObidKhHxK0HayDXxgWVj0KEeMn/eO1IKNkcVxBMJqkXXEkBhfo1Kie7griKoR1MC
 YDVABduEm6EPUJaVKNlOQN32ks4fXoKlJ47sTo84iTGwYCeVoYkvfC6jNIlxoTQqG0No
 NvzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dcVDqOBD+RYP8gAP5Yk2CFuORvHnd74U/mYR1CF/7zE=;
 fh=qCGCLWECMPJt00xO2lmEnyKMUwUmgfeLlFh3mWJKEqU=;
 b=jcz5SapstTU49ej+FiNbtIGRQHR5gPjbDhfpBdhmxUwjNSvYbsem0mpL9n4PfiJy3C
 4sEIvi1M4OCcRbRagv5Yu1TXuyhP+whvUlfhdjFROHdHn6FfkRD4Nae2RLFh002POf+r
 feEYflML9mXhB67pQ85hyU9Ty5ujCg+CZgrmQQMvwCZECnja5mreGC2GDG/PPKqaNpje
 ytbBMn4vbJMOD6ylfcl/SmrCQGjzHpZMh2SbJ7xBCvcbxAAxS1UAJDvtM3A2/Q2egZq5
 6RwfvtD6FVEyEuBWzo/NGT00eKXQAWabKHB8HxvArOvhAg3qzBKdV1/oeEaGsLH6Rmvc
 T6OA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785944213; x=1786549013; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dcVDqOBD+RYP8gAP5Yk2CFuORvHnd74U/mYR1CF/7zE=;
 b=EFCUV2I7MYdMGiOlnv/6KzenXyfMd1ne5s9/qHgbuXfxirWY4aO6mSUjlCe7GmlcI8
 I/LSwNNxocmjBstDYb8hHWEpES+Sjqz7xhfp2x2GObJfz2cQq1T5J9V5+rrOyUsZ2aof
 f6Qv1DtQH71iZFUzN79Fc1aM63g67wSwpEVa7mP1Z0ISjQd4Lb5ZoOrjahV0Xnbsvogi
 2ZFtJT3MWwnHgd6YA37oKeBN9+mCNI8FsL1V7oWf05fGy/tNd5x4LCUkCty0Dwf749AX
 6Mv2nAjzOVlI4+NXOM3Gv7CdGWrmKUcZVoWWrUWLPgxaFVP7kDsHDAk04xVbepbKrBXy
 vN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785944213; x=1786549013;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dcVDqOBD+RYP8gAP5Yk2CFuORvHnd74U/mYR1CF/7zE=;
 b=orVjANXJSu/sRWk1+0lUeBoHKIilxdN98aG3VK98ozPv+wbqTVk/2xQZyKddEse7fX
 l1dUV6lEL+F9v4G9Bln95yIAwvaNHJhbwFS5cY5T8pYnvSmIVJeFh4QfKX9QgfeqLyDi
 32bNLOJcUP4MfGNcQpnoYwSCpenKlW8LEjUV3lJNvVu38+A58PtvwqtIq2CGMo9SgVwy
 po3+87cXsHjIUZGvOhDnV3kBlnzQra43xcpZokjMvMS8lc1DEQls9vUBWuB9CHdjZu1U
 t7ofczxvJyoApScXU1hvyr1+gcwz8ZBVyEtvd5qLYgwKqx47+YUi6Bir6sJLAEdEcjKI
 1xRQ==
X-Gm-Message-State: AOJu0YyySAEWewfJK03pSZnQCwXJEwt2keJhTEKIo52XU17/KXAFgWAp
 0Myf0GOUkTsotMHA567zTwKpskcrkuCCeoMdprEWNYMAEsZSYr/NVjikkrm4FMW7o2vREfkTs9S
 iuREPC5qbLKODV/RvN//N9pxsD4Hp/Sc=
X-Gm-Gg: AR+sD11nqn9o7UO7Etkm3CsvBW0wLKk/9NGzEJe2WVfn+JOzDRpKk44OHKlnE2WVRjv
 qKEQj9szuLtKn9ii1DS9IZrxCVjEiCPux4TI/x8tUEDlmAHSzIFjWgZpuTqY0Nlltm/x4MaFHoI
 ZzK45WfFS3+yEbFQ+RMBC3qA7Wx6LQghhkCGLrFOZixq8h3WamfcbBFafZ0rAeb9fh/Q+ezUIJI
 IctH4LNP5Ws5r2IV9eEDE8EAWyFjBT+LjS4g1ADLllIyMr6LqrAvPHwQm1kcTHnmSJksBOd227g
 Hgbk7uKbVWVfnuPdpwdZB3Vm+PDZjRsKkRU/Ygenug==
X-Received: by 2002:a05:690e:408d:b0:667:c09c:4a40 with SMTP id
 956f58d0204a3-6699ab8eaf8mr4761596d50.51.1785944213312; Wed, 05 Aug 2026
 08:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260801192848.30606-1-flamboyant.h.01@gmail.com>
 <20260801192848.30606-2-flamboyant.h.01@gmail.com>
 <itp7xmctqnac4c7kytqyrrs3xbfnbjprem6ezlltc6b5ncdpdn@6pypq3e7lbog>
 <CAAW0U4a-nG-ck4g8w0_Vt1Jbu5dNcYEDjJNR-YvGEiHa9G4Rdw@mail.gmail.com>
 <CAEev2e8UcXn46OoyqTXpx8-_PzUNyGJDVF094J+boLUSqQ3VLw@mail.gmail.com>
In-Reply-To: <CAEev2e8UcXn46OoyqTXpx8-_PzUNyGJDVF094J+boLUSqQ3VLw@mail.gmail.com>
From: Kangjie Huang <flamboyant.h.01@gmail.com>
Date: Wed, 5 Aug 2026 23:36:42 +0800
X-Gm-Features: AUfX_mwtx1eBucGDkJh-NGFymJ5SHIWUBRX65d3a40fABZXcAO7IOIUNzhBuP9s
Message-ID: <CAAW0U4a95WEHCY87mN7WncHg9buiiw0YsdO4VFTroONe3XWFbA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] hw/ssi: Add Synopsys DesignWare SSI standard PIO
 controller
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Bin Meng <bmeng.cn@gmail.com>, Chao Liu <chao.liu@processmission.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Kangjie Huang <flamboyant.h.01@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=flamboyant.h.01@gmail.com; helo=mail-yx1-xb12f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi,
Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com> =E4=BA=8E2026=E5=B9=B4=
8=E6=9C=885=E6=97=A5=E5=91=A8=E4=B8=89 23:15=E5=86=99=E9=81=93=EF=BC=9A
>
> Sounds good. I wouldn't worry about supporting dw-apb-ssi.
     Thank you. I will fix  in the next version.
Regards,
Kangjie

