Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE127E9410A
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 04:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaRnT-0005b9-Su; Mon, 29 Dec 2025 23:57:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vaRnR-0005at-OW
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 23:57:25 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vaRnQ-0007mn-1l
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 23:57:25 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-bf1b402fa3cso9435436a12.3
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 20:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767070642; x=1767675442; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AGYkkWQ/uHEFQUVpDg4g0XlFFdA+JCfF3mzsm+UiYf8=;
 b=O68R7xvSnMmaOWgeXB3ngZKUxBdz54KJnY+wqx1qWdtls/rVVJmagAYbXq4zODd+V5
 4oRTUt++ygdrLwtWC2Rn3XQS2SABLWyXzzMCOyjilm3dI6vL9Jfhl463MBldPbzd9sj1
 R61aguR1jaNW+BvVL+4kG9AKlbf3bT6WjGLhR2eTorypPVoK+JWQZhlTYgo4Eq5GNmnx
 SZ4RYE+0+sWweD0oY45WB8/KlvJh+3TIkyKE0T6vGHg6iNKz1SshXRnekOuzz1QretQr
 LW+Ngp4iwf8kzsDXxdr6laCXafjd9cwCg/VQoR3vvaC90pbltyACOCKALZcmHm69Qp16
 eJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767070642; x=1767675442;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AGYkkWQ/uHEFQUVpDg4g0XlFFdA+JCfF3mzsm+UiYf8=;
 b=FDvLUuxGdV4cnZNgvJ8WjWUXLGrBnL6BCuPuv4lDZqHoaEw5KI9qYN/9cg8x1KdD6c
 R8aBOdweUIkF/CwQ8uvFg8zY8saXq5UKD6nY52NmbEyMbzq5Ma029NQ8nRTu38uUom40
 y9nQ0vfpBrftA6DP1uHUQYZIXbXgGZ70fGO7iWuGcNrDCaw/ZO3PLOHatP1uiVw499ll
 A5nTV38YdrqIdBQbKh6iJvAli0e+z6JVPbRq2RHuKbbjmSifF0/mWv3TwQDOjWVnZGEW
 LTpGXwKbrpFB+1WMH/skGImN0Y8Uhb19aDgeNWd97RrCSrHSgd34UFp7k2gFMpWigivQ
 LAdA==
X-Gm-Message-State: AOJu0Yw10njo0GjPfoNG/anww7GsiYVoIiYfe007IZQx7ERvD4cnvJ8Y
 YFsUSz4QQXBK/uWEic7TvXUA9fWMmkZcKQdsomd6QD/YsH72rzQgX1Kgz+jbfD8LOA2U5XDK1ap
 BF2rfalN5Ky3VDNB7BHqYykpkEp4iOQrvFJ1T3rsNWQ==
X-Gm-Gg: AY/fxX47hpkv+32OhMho4i/EGl8T7HcMF6kBxEbTXe95bPPGGBIVfdb+Nl8t4z7ieSN
 Wmqtb6AsIXHELc7UaKVhKoYRsMKfsV/9OuNAotzwb1fGdJP2iHBK4QRUENu2A/CshiTZDYeZYi/
 QMGMwq30Gw2EyoAAZ0L88Se7e0RPQd40GYNKDJAikLy84/5YaF+FiEMPKvwsa4eUFg28+caxHJC
 TtOGWUM4DxaUhaCu0Myr3EdrhoCA7DnhgcOq98pB6uzusAWxwRnH1kQyYewzMpo85JLQaUPXw==
X-Google-Smtp-Source: AGHT+IFGmIwxXZJg4hjFdDIsfUMmBoK8iYKVL3jgn3EPq03+MHYWlgXAi/r9GbQITN/BjsMSqDQHVIOTDu9Wh2zTQmw=
X-Received: by 2002:a05:7022:4081:b0:11b:6b46:3792 with SMTP id
 a92af1059eb24-121722fdb12mr22100907c88.40.1767070641882; Mon, 29 Dec 2025
 20:57:21 -0800 (PST)
MIME-Version: 1.0
References: <20251223102547.13337-1-jay.chang@sifive.com>
 <bb81eab2-b48f-449e-86e6-32da90236a05@tls.msk.ru>
In-Reply-To: <bb81eab2-b48f-449e-86e6-32da90236a05@tls.msk.ru>
From: Jay Chang <jay.chang@sifive.com>
Date: Tue, 30 Dec 2025 12:57:10 +0800
X-Gm-Features: AQt7F2q3VBJGjPKRbW3l7kd1ceaFPMl1TA3IWfszpOguhn25Wpec46NAId1M3Lc
Message-ID: <CACNNAjMBw+SD7FmnzbOTCjWDfh7MMq7oT3B8VWKymGyRr=gt2Q@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Align pmp size to pmp-granularity
To: mjt@tls.msk.ru
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Frank Chang <frank.chang@sifive.com>
Content-Type: multipart/alternative; boundary="000000000000e717e106472431ff"
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=jay.chang@sifive.com; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--000000000000e717e106472431ff
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael

Thank you for the review. You're right, the sentence needs a verb.

It should read:
" it needs to be aligned to the PMP granularity."

Yes, this is qemu-stable material. The PMP alignment implements WARL
from the RISC-V specification.

On Sun, Dec 28, 2025 at 4:16=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:

> On 12/23/25 13:25, Jay Chang wrote:
> > When configuring pmpcfg (TOR, NA4, or NAPOT) and pmpaddr, if the
> > value is smaller than the PMP granularity, it automatically aligned
> > to the PMP granularity.
>
> There's a verb missing here. It "should be"? "needs to be" aligned?
>
> Is it a qemu-stable material?
>
> /mjt
>

--000000000000e717e106472431ff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Michael<div><br>Thank you for the review. You&#39;re ri=
ght, the sentence needs a verb.<br><br>It should read:<br>&quot;=C2=A0it ne=
eds to be aligned to the PMP granularity.&quot;<br><br>Yes, this is qemu-st=
able material. The PMP alignment implements WARL<br>from the RISC-V specifi=
cation.</div></div><br><div class=3D"gmail_quote gmail_quote_container"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Sun, Dec 28, 2025 at 4:16=E2=80=AFPM =
Michael Tokarev &lt;<a href=3D"mailto:mjt@tls.msk.ru">mjt@tls.msk.ru</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 12/2=
3/25 13:25, Jay Chang wrote:<br>
&gt; When configuring pmpcfg (TOR, NA4, or NAPOT) and pmpaddr, if the<br>
&gt; value is smaller than the PMP granularity, it automatically aligned<br=
>
&gt; to the PMP granularity.<br>
<br>
There&#39;s a verb missing here. It &quot;should be&quot;? &quot;needs to b=
e&quot; aligned?<br>
<br>
Is it a qemu-stable material?<br>
<br>
/mjt<br>
</blockquote></div>

--000000000000e717e106472431ff--

