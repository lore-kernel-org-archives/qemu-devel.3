Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE81C2D0CD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 00:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFihC-0003fx-GX; Thu, 15 May 2025 20:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFihA-0003fO-7u; Thu, 15 May 2025 20:13:00 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFih4-00036u-5u; Thu, 15 May 2025 20:12:59 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22e4d235811so19864095ad.2; 
 Thu, 15 May 2025 17:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747354372; x=1747959172; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UtAYeWwMzpy6VBiwNE8IVzaiDEUE3QtioC9gTZqKReQ=;
 b=ID16oo+Bml5psw40V3JaCZcLOG4nnBxp5uI6umkRSItwOv6waX84VQdAd0+u7m/Jwr
 wYvJOg95aeQPIVl2NFqJ3M1KzC9dAgKHSTrkJSDPwib8OhdahuxWfNdAgzkB0xn4t/kV
 EMn1xoTUdwEhE+Z4072qQmwrF4yr15c+U0iwElpC3bgVTI6F7I2kcKw6UFaifBWMpQwE
 h8Q+5x0Zf4Cvyz0Kr4xpy9i8TzD1AlBkOF8O+8FsSnZtDWoh7sjZCyPI4w/QuqlV3CA/
 f4+x/xhp6ISVIDmx4ulAcg7U12wPnSlcwZqzmdmA1wYY6E6bFhTeZ9Qe4DfFBbm2MmPt
 d3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747354372; x=1747959172;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UtAYeWwMzpy6VBiwNE8IVzaiDEUE3QtioC9gTZqKReQ=;
 b=Qn1FaBDSiV6OetYLOArvynSWAiQ3B0mcDi39NBMVE230UwK6ev6W3DwDwUcNsEMsFY
 oNH8jaCr57MsvS18DQdJ1iSTn3tAG0xI5GoUdthKXDIczgwljN2E1K62vjGyBBFM7nrm
 lgGAM/g1/Onk69vlI9ANDYTKciLokU4s9fJiT9M1UC+44X0DDA1Ai9AwTU59duAn/xox
 PBnUTsHal/Swgs5/sWAT2mUvysf/6O+nx68BGFDyqvPqV2doUDyMc2ffkH1OfnXTFEYD
 eFWxU4DvZcH0tmvmHVeLI0cz1xcuwwcKeedULXQ9ckjD3RrGk98KgFzpxKdxBKz9/NHH
 BmgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPtfrUAveubENKXIWPkW/WFzOwnqiRZs82muiWNMXU+OBgMk99Q5QQjdWECEvfm7BVsjmtAnH9Nw==@nongnu.org
X-Gm-Message-State: AOJu0Ywx74mgO/ecSFtrV342JICw6kwBX20nrQSBW4NcRMWiHldRYwX/
 VrmEgvCOim54QtZwxY5pebKxEBwQsmTSofop/MV9TRvn9YQu40nK8miA
X-Gm-Gg: ASbGncvHvI8LCaBoITWNA0g4ZH4SrY5iYJ9qxA7AQFQSy8Vh+zPxLUAcuv0heJGbX4Q
 20+8q+CGVGQGaz19FwUtLQhTQd61omxMWsZXTS8LuI1eoCSYWpb2Hc3yaeOIeXjKTViYqjpINCL
 i9hK9TY2COJzSqXjlZlfQEbQ+sebUGAtFs2wuQzzs4Dj3U5dyQbWsOy+hek0ZtRXnx0f2uuvNRt
 Kfb222XjZozh451UdKTOQhpvWAeqTC2yRgW4xlIEFpzjJhMqzItbxRUEGgVJhebtVEFvYKt8N5j
 High+8id8PcoIbbQEHvBWrYPj8Riz3fn73WzWLClB3q/rSA=
X-Google-Smtp-Source: AGHT+IESOQz/6mEhUiUW+4ka3xhr3WApHW/SAH6IDiF+dCV+eYPFVoS+0EJ5IV4qkTBffqyO1J7sEw==
X-Received: by 2002:a17:903:28c:b0:22e:4cab:f786 with SMTP id
 d9443c01a7336-231d43a7f8fmr15383375ad.18.1747354371675; 
 Thu, 15 May 2025 17:12:51 -0700 (PDT)
Received: from localhost ([118.209.229.237]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4e97db8sm3458455ad.110.2025.05.15.17.12.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 17:12:51 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 May 2025 10:12:45 +1000
Message-Id: <D9X5FDZ917LB.1HYODTEUEB7LH@gmail.com>
Subject: Re: [PATCH 08/50] ppc/xive2: Use fair irq target search algorithm
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Nicholas Piggin" <npiggin@gmail.com>, <qemu-ppc@nongnu.org>
Cc: <qemu-devel@nongnu.org>, =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?=
 <fbarrat@linux.ibm.com>, "Glenn Miles" <milesg@linux.ibm.com>, "Michael
 Kowal" <kowal@linux.ibm.com>, "Caleb Schlossin" <calebs@linux.vnet.ibm.com>
X-Mailer: aerc 0.19.0
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-9-npiggin@gmail.com>
In-Reply-To: <20250512031100.439842-9-npiggin@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon May 12, 2025 at 1:10 PM AEST, Nicholas Piggin wrote:
> From: Glenn Miles <milesg@linux.ibm.com>
>
> The current xive algorithm for finding a matching group vCPU
> target always uses the first vCPU found.  And, since it always
> starts the search with thread 0 of a core, thread 0 is almost
> always used to handle group interrupts.  This can lead to additional
> interrupt latency and poor performance for interrupt intensive
> work loads.
>
> Changing this to use a simple round-robin algorithm for deciding which
> thread number to use when starting a search, which leads to a more
> distributed use of threads for handling group interrupts.
>

Does hardware always do the "histogram" distribution? I wonder if
there would be any performance benefit to do something like send
to an idle thread/core with preference. I guess the xive controller
might have a difficult time querying the state of a bunch of cores
before sending so it's probably not practical for real hardware.

In any case this is a nice improvement for group delivery.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> [npiggin: Also round-robin among threads, not just cores]
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> ---
>  hw/intc/pnv_xive2.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index 72cdf0f20c..d7ca97ecbb 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -643,13 +643,18 @@ static int pnv_xive2_match_nvt(XivePresenter *xptr,=
 uint8_t format,
>      int i, j;
>      bool gen1_tima_os =3D
>          xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_GEN1_TIMA_OS;
> +    static int next_start_core;
> +    static int next_start_thread;
> +    int start_core =3D next_start_core;
> +    int start_thread =3D next_start_thread;
> =20
>      for (i =3D 0; i < chip->nr_cores; i++) {
> -        PnvCore *pc =3D chip->cores[i];
> +        PnvCore *pc =3D chip->cores[(i + start_core) % chip->nr_cores];
>          CPUCore *cc =3D CPU_CORE(pc);
> =20
>          for (j =3D 0; j < cc->nr_threads; j++) {
> -            PowerPCCPU *cpu =3D pc->threads[j];
> +            /* Start search for match with different thread each call */
> +            PowerPCCPU *cpu =3D pc->threads[(j + start_thread) % cc->nr_=
threads];
>              XiveTCTX *tctx;
>              int ring;
> =20
> @@ -694,6 +699,15 @@ static int pnv_xive2_match_nvt(XivePresenter *xptr, =
uint8_t format,
>                      if (!match->tctx) {
>                          match->ring =3D ring;
>                          match->tctx =3D tctx;
> +
> +                        next_start_thread =3D j + start_thread + 1;
> +                        if (next_start_thread >=3D cc->nr_threads) {
> +                            next_start_thread =3D 0;
> +                            next_start_core =3D i + start_core + 1;
> +                            if (next_start_core >=3D chip->nr_cores) {
> +                                next_start_core =3D 0;
> +                            }
> +                        }
>                      }
>                      count++;
>                  }


