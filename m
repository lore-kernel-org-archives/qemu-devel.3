Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC729C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 07:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq5v1-0001EF-VL; Thu, 06 Mar 2025 02:45:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq5uz-0001Ds-Od; Thu, 06 Mar 2025 02:45:22 -0500
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq5ux-0004NX-JL; Thu, 06 Mar 2025 02:45:21 -0500
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-86b68e51af4so111307241.1; 
 Wed, 05 Mar 2025 23:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741247117; x=1741851917; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C9v9nPOfNMQlX6CwUkNiuQMITxSAHT0ikDIyCfYk6x4=;
 b=cNMEMSDXfH87H52e6H4UG+08UDx6v4Xg86BubqLptQ4dHrOgon7adLEcqw9RHl6AiG
 SW2i51FoZHNye4ExjFS/YXlRi2F0UsHGRBT5zTkRcPbv1wE0E2eeoN8jg1FTzrpZjoct
 PpvoTQXZ3ddkwJd1D85t14jMCzo0iudEUIXF+K1N64eHlF3PPXbuQkv+6ssHG8zh1MeB
 i7Kfff8ad8izqbU4uORn2brs1HkIjguh0aN8ynnoPYrAmm8M2O2AfZ6biPQEllfeBMPt
 bpG348bzuhfIvgAlM0OgSZWkQiJqFrEvZsYXIWqzp9qmjMQqYlvk0rjGRF/+tCxh3tMb
 Bn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741247117; x=1741851917;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C9v9nPOfNMQlX6CwUkNiuQMITxSAHT0ikDIyCfYk6x4=;
 b=qtuQLNODPrTavwcyj3W9eTX9oclb6jD/jfj/LkHubPy1Lz4FCc4YZcbx+lKOa+n3r6
 yeryxmJ4Px7ScHdLRA6rCacYoT2TeaiMBzoYIXQZkuDyKrbB9alUlbwP0ShbEyhdLLuj
 gAxiPFsbeI5sTNLn3Of3CCf5X8FaYu8H5aA8PNxWR7cHi2bnSCZO7lIYM+BvJH2AOfIP
 SLcZyFj+sw7GZZN65L36mm5zCj2eCerIMh3aQHysJtMLN/VVCjH1NYz/iT5cO0GocOLL
 SX8vXWWBbTrH35BuqNRByfJ5fGv6HI4y0uBwB0F5NGqS0lqnidNHvWlbfWoSKaBwqdZt
 3qvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQFLZQImNXWMN7PfqOmX1edICVqYVn4HUCVCtuKt87yiQU458NlhyeejrxPaC0LGnmCy7R1nU9axIKwA==@nongnu.org,
 AJvYcCUj7I8uQZWFsW31lYOQIOgFdsDb7npRuMDgC/Am5QjhdJmtfBK+u3ruOlnXlamAjeR9/7lxND9MF5uA@nongnu.org,
 AJvYcCWKgDffL91a13kCarJAsPyXLC0KYmNtc5U02nFUoVCVeR4Qi6zJ0P3Wbg2iHecZ7ebhRzOd2s+FZdD/x/w=@nongnu.org
X-Gm-Message-State: AOJu0YwfFWycbkqDiPjtt1SmH1oE2zDNDtewFn2/tTlARjGSaxnrlk8Q
 +kWxj4+MQVd+EJn+Pv0hayQfEXbPd3VFs1T6KUeEmxygu7EE4CqPURufx1wy6H8TO43pL9/Jvjq
 rtZM3I390whJiHu+cefpl879EvG0=
X-Gm-Gg: ASbGncv8fOan7SAdGvLA8yAA1/fSpvtQ6LOYHIcpA/L6W7acuw2IhOaIQh03ajlZwzj
 1lqFHx9onHHDr62hxKejh+juLhqGV2fa9Koa2Gi9Y9LYr/gYWlCcO/uCVcMsBLT+ucQpxWkqQiP
 CVYg1il7w3urTPfb2OiYAcNCeptYtpDC6GMXbQDN1jepW+VH2d+5KLEm/z
X-Google-Smtp-Source: AGHT+IHeeD1WGZgD8aZklX+nsiL05gZ/CrDLHJwDS4cvPDKBjJv3JVw0CgUFZl4XWM9U3b3nWWXbPvcWghntSUcXdiw=
X-Received: by 2002:a05:6102:1607:b0:4ba:eb24:fb28 with SMTP id
 ada2fe7eead31-4c2e274c502mr4187796137.3.1741247117574; Wed, 05 Mar 2025
 23:45:17 -0800 (PST)
MIME-Version: 1.0
References: <20250121170626.1992570-1-dbarboza@ventanamicro.com>
 <87cfded1-0ab0-4445-8b52-31c283c9a5f6@tls.msk.ru>
In-Reply-To: <87cfded1-0ab0-4445-8b52-31c283c9a5f6@tls.msk.ru>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Mar 2025 17:44:49 +1000
X-Gm-Features: AQ5f1JoAd-p9Piy_KiaIwrhGczEWtebuM8tosauUnrdZfCqcY9KTyM9k6qCAlGU
Message-ID: <CAKmqyKNmfWd0ZfeDdtG0sgUwFSa_OKw+YgtfVLGewNWBvXGCAQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] target/riscv: throw debug exception before page
 fault
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 alistair.francis@wdc.com, bmeng@tinylab.org, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, 
 richard.henderson@linaro.org, qemu-stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92f;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92f.google.com
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

On Thu, Mar 6, 2025 at 4:33=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wro=
te:
>
> 21.01.2025 20:06, Daniel Henrique Barboza wrote:
> > Hi,
> >
> > In this new version, in patch 2,  we're using the address 'size' val fr=
om
> > riscv_cpu_tlb_fill() instead of infering it from the CPU XLEN.
> >
> > No other changes made. Patches based on master.
> >
> > Changes from v2:
> > - patch 2:
> >    - use 'size' instead of infering wp_len using the CPU XLEN
> > - v2 link: https://lore.kernel.org/qemu-riscv/20250120204910.1317013-1-=
dbarboza@ventanamicro.com/
> >
> > Daniel Henrique Barboza (2):
> >    target/riscv/debug.c: use wp size =3D 4 for 32-bit CPUs
> >    target/riscv: throw debug exception before page fault
>
> Hi!
>
> Is this a qemu-stable material?

Yes

>
> If yes, is it worth to pick it up for older stable series
> (currently active series are 7.2 and 8.2)?

If it applies then it probably is

>
> Please keep Cc: qemu-stable@ for fixes which should be picked up
> for the stable series.

Sorry, I always forget :(

Alistair

>
> Thanks,
>
> /mjt
>

