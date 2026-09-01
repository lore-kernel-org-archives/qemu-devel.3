Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACEB7C61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:46:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1JBm-0005Hr-Ft; Tue, 01 Sep 2026 03:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x1JBk-0005HX-O7
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 03:45:48 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x1JBi-0006yk-Bf
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 03:45:48 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-66f7f62e915so650732d50.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 00:45:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788248745; cv=none;
 d=google.com; s=arc-20260327;
 b=KCYMk7RuP7c4PnR1OMFy/s/66yMbxAbHxOupM2aie/yEYDNPZTKMeIdaXZOE6YN6MA
 t4xgp8v3/V/SrFzJOGD7knuWgtuO/dzU57HV8WN8Nhpwpx7tYbMa4+ogK+EQn32QEFNU
 QRxmhtIimW2UP60uIrZSaR4jDvaFc+yEdTeRnlirLq3evJ5NMv2dqDKRviW4v0T0a3T+
 wUhslxdooSx/R9uUo1u/3GrnKRxrllb3tD/gGjIzoHRk0u7c4JsX4PgZvH3UWeWS4h7C
 Q6CKSjdFm7NUOXdH2X6AxQD/ynBn6GZnZcUEn2l7Vjl9ktxM58y732yrGN6deRLK/Koe
 3VoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=U48hKlV1cRP43rKRiCqIlG/RIdxRBIvcw8d20WllOJI=;
 fh=qGOM5QQP9X6RNGKSpNmViwpg6ayjOE5TSnbgUXgj5Jw=;
 b=OSXx8CZS5xjiVMzLodMV3ZyiYaqTCv3ID/z/f0+v5/RaoP7cybo56hnhwKHSXgixgl
 O3WiEvoQ/40/i5ZonDifEgo0yQVBJ8ppdEjnJoYNSrRwQchgw2cTP7Y2gR0kP2hq2H1F
 9va94W0fAtbw19h4jCE2s1ag2YUmA+o70Ub7LqtqKjkFpfYgPifVCT/NRe5EK9NRdJlh
 yH60D+8+1WLGeY9aIV77LsIzFn5OrE4uXjhvic/YwpFriVMP0N9JbxHha6iMGSVET83Q
 7w7tfRWJJnTVX9VdtMU5J4YAYncOzrjpWI1dHPSUHVTRTwD/eyIHnV8DeZ8xri+P1KsK
 RF9w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1788248745; x=1788853545; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=U48hKlV1cRP43rKRiCqIlG/RIdxRBIvcw8d20WllOJI=;
 b=CzJgD7F293TdsJyL+yTQQT0dOK9AEfV9XA5Sw4szVlnCVrRU29LxwOMKerWW9JmWG7
 7mCZvVigTgjSQAk9m0O0zb7G22wWkF+OzYlv/q0OlkQYnNkPnw9vOX0YX/6uXat+eGeS
 WPJqQ2xThrjjFqk+AlcTg52HbzRmTYffQBXrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788248745; x=1788853545;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U48hKlV1cRP43rKRiCqIlG/RIdxRBIvcw8d20WllOJI=;
 b=lcdE4lEpBE2HLLlxrQdbwUUCYhhtwxHy+qFvoggCSDQQsnhnh9JyRX4j+6R6GHAnaS
 zhOqLfKG9gvxd4lrrbD3iULWaHld5Z7oM5fgfU6q8DEYvzEJqLP/aTvrayuuP1JlRIK+
 rg15uxEetHSlEHroHodjMZj+ofOYuVJleC9qSm47GAqzj9TqM0wFo4zd67G9LMkDg25I
 oCH2TXx4vv2P9EaA93Lgl657pG/CZoTNfOODnWuvM4mhit30PIbm1yvrrHoeb64F0o6I
 k+7lGjTTmZLmtIgQB0xAeEFE6Zf+h4RzdY3Odb1/IXr9oZawLhlpi8G/La7asfat3Fxf
 yzoA==
X-Forwarded-Encrypted: i=1;
 AKwUvByX/66vBmMwZS9suteB/mzpGlq0Q0xBSgrPeyxYH0Jy0h0SSdf8CKv3Ab9S1b1OL9Mw3EPmeHSwL/oW@nongnu.org
X-Gm-Message-State: AFuF++l0N++1WHYUV/xeeaE0gUCZAYBrdmHjHFP0SwNnE38X9Pa92qHa
 o2m30jCv6Ef/zgoUcUl/psVwq+HWX4XzhVjRYKbTbU/W6xrg1uTRL4R70BEU2LM5jdDUTs1Tqym
 SJ+lwQ54ezQa0Bqa0fMBPTVNEDwdcEQg=
X-Gm-Gg: AYBFou1sPtJ9Yhfci2Sj28cVyarGFiuNPi8H/5bYYYUUkaKGTCIhcUe1tL9uoxQZwBP
 Tcdau05WQSZHtmfJUxVRGtzLNmswE4N3Xzmhofd+Pkfeo7dXzI83HOx8Y19ir2qkvlWLk8fr7E9
 P/72zL80jXFYnxUlbWOkVi1y9Z1Us9DfCpfxkFF0hcua9GFFq5US++VaK5DxST4BPPofW9K5DXd
 8j7gXLWD9+BZqf5qgpnhdMdu5wwHycLBSzZCniyatjvQ18VfaverSrdp/Tcpw4f/Hdrb7AWHUxM
 6zsbQVB+G+jyJN6EpMkBaImUuDOCNT37pND47KwTQOU/bAru1ttUmD/T4D02i7jihwJGOjiPJND
 9712FixgvzrrJPjIuQdW7zlbfK06pBncXOa4SWnF9PTDkBDPs1aOpEaphyms+7nyP9o4WmSa7Sb
 4TMseYctIt3evjQ4ky
X-Received: by 2002:a53:a2cf:0:b0:66f:7d7f:508c with SMTP id
 956f58d0204a3-66f80c61e8amr2529567d50.50.1788248744728; Tue, 01 Sep 2026
 00:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260831021500.82565-1-joel@jms.id.au>
 <20260831021500.82565-3-joel@jms.id.au>
 <bd0e113a-6495-4f4b-9ed7-bfd206a6acf7@kaod.org>
In-Reply-To: <bd0e113a-6495-4f4b-9ed7-bfd206a6acf7@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 1 Sep 2026 17:15:33 +0930
X-Gm-Features: AcwNN1VdMoeETI9xhtG6mjaODAq76yAEzKe1JEV7ydmW1S5HiKtyQXku9OH3C0w
Message-ID: <CACPK8Xf5UVHuwCo9gyXNUCqH53F2zji5ZZ3K6h-1Rz7bELzYTQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/16] hw/intc/riscv_aclint: Take a MemoryRegion for
 the created devices
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, 
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=joel.stan@gmail.com; helo=mail-yx1-xb133.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, 31 Aug 2026 at 17:51, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 8/31/26 04:14, Joel Stanley wrote:
> > The riscv_aclint_mtimer_create() and riscv_aclint_swi_create() helpers
> > map the device they create into system_memory, which prevents their use
> > by SoCs that map devices into a memory container of their own.
>
> Since these routines are going to be used later on in a realize()
> handler, I would add a 'Error **errp' parameter.

Seems like a reasonable thing to do.

I started having a look at this and plumbing through errp is a bit
more involved. I think I'll do that as it's own series as a follow up
to this one.

Cheers,

Joel

