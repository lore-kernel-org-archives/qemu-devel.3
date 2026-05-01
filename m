Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78861CD13DE
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 01:34:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIckx-0006yA-0L; Thu, 30 Apr 2026 21:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIcks-0006wm-Ez
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 21:33:22 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIckp-0001p2-7F
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 21:33:20 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ba922426c5cso274407566b.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 18:33:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777599197; cv=none;
 d=google.com; s=arc-20240605;
 b=TaPAJxM3JK9HyZ95z2P8B5BSbltqtvnyY38mxZy2sHD3l6pQuiO5hUJ0oQttPFHw3G
 dp3JfOLj8Al45IVC5bALpRUdNyOmOQLfOt4GO3r50e6LW5UssHdQ50yxpjaDUNgmNxfD
 wZxunkuQ5PkRhfZhT1e2ifI6frLfViX/h59Hs7rFJ51S0iGHeXnpMv5YULdR3kMDejyx
 ynZx9Mc7r1xMHqcfqx2r05wnePKsq+CiyK5+9AQT4G2YnMEhN0xZ3lzt49FfXj47k+K8
 7KMNwmN8n4m3wvtOulgLVYABCRzyIvhmX5aM5OXs2vdkeI5z3Om5D91EiqHUW4RHY9vn
 IOLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gCyEjZo40981JGMomOtsPb8wjxIYcDbOuIJf+/TERVo=;
 fh=FMJXwKgP2LoSd1RixKTqE9NcD79h3H2uNzu7zpimXsA=;
 b=B/lcgqR4qtjNQ2zL2HJ2h8Fy1cZaSpZ++zpl2C9XKaYRmp/EPNjUYZu94L4H2SG7Rn
 GKjPG1hJQc6728+7lNOkgpNl59OsBtJ96QueLRYTQtxG2Kyc5toZRAb3MAE32LohrRwL
 znO4eyeAVVG3/Lk+rgu2TqwrP/WATJw4+texcHMoAzjhzbt+oh0PHo1pQ6zSM1yv6W6v
 7DD2DGl0eORq9vXJs4L7Ze1fTFB9kRQwAmoRjDJ+ARpEtO1Px+KsCmyUwplzVfT2NkgA
 ycTbt24OeKPr1UhyMFV8QDryjm9ID8vzm7guhTwNI43ctyOEoAowwkjTejaxoTYEx5RX
 pVag==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777599197; x=1778203997; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gCyEjZo40981JGMomOtsPb8wjxIYcDbOuIJf+/TERVo=;
 b=FckcGAGLC5WnXJDPFNDaGrMYN6pr4atOmVApzWClLoqYbkKjlU27frIcfuNSki1jFQ
 HdMqWVHoQSTYiwKjW7nMBx9IFUeO81GS1gcbouaJIYgjsgjF3HwXEVP79uVxM108u4sO
 6UoCzRFaPNWE/QITewOQ3gCpwE5SRfp6ZUckAaXTbISK9wVlUPLNgzkkli1b/zfjGLIh
 MiHBQ6W+lqzHdkGVHtH8hWv9FllkQn8gv54mkvx1+mtBFKXvCBu6MoqyLGAXZoQPYCDc
 Qtx3O/jGKeJmtv77hQjjhdoUyfMUdx+n+AupFH9Z6k7op6iuqRq9Txfftm7j6VuQUnSB
 AaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777599197; x=1778203997;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gCyEjZo40981JGMomOtsPb8wjxIYcDbOuIJf+/TERVo=;
 b=aAtCZykSOuEuXgufz2JSICmPjRogIWDQQPtX61HypFeVXtac9UooCfsT4J/wFJ5vAr
 eE0/m0sqlljaUmPeAMuOW8rLdPmNAa/dAO7/EJLcZTWzk8OgJxLuI1PqVMhmuq2eePCi
 IrvUUALCDwCVeTTeAHSjAIm1mFOsHs6/Ew9/p/wbTC/SYvvY3atgqKivd3FuRnv7DG7W
 9/xEbpxxfS/na+ORFf8brTMbUA5M08CuWOfacXLX9BFYKrB0BWMX5uA3bykbLkQ/5N1z
 /MSNPG8N2P+6GCjg0H3JUU8aAcGc//NCQ/Gq2w86RAYOhr7OvPfeFdQzemDhJzVQ1VnC
 6pZQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8P8TMpYrlrtWlNbbMBNyooJNquNCCYBDcOqaRJyyqOQb5aP5Gvoh00rcUwyUwrbUxJNWpsPHVbCB/g@nongnu.org
X-Gm-Message-State: AOJu0YztF3FSu1YQEVMd0sYxjk8w3rqoLYoXPAS7nPXAHM+tFOPRwHra
 Yx0sjdpwuQAxDHJx6Fg0QPiEpYo7xYAOkwX33jv5ylNvYskGF2oo7ubiCw9N3ld4bvvZn7wfxD+
 1+kL1dryRlvbR4VRl3l1J1z4NHLcf02g=
X-Gm-Gg: AeBDiesgEHI6Nqn6XBFTF8g97ozsTzcbNHsGX4eQRc3AJPbiFzPtLwhayLcUEQkxgxT
 EeACVxQMltKwMT1ZPwRitIVoIvz9tWDUex9j4vuZVXbmrgVywcsLOOvf5gHyvoscw3rwbWXMO5+
 EvJA3No2c11Tu00d9mkQ71GvgcI91pGtbtthz6sl+fmZty4kBlNhSOzybhuPP4kEDYnh22RO8dZ
 +hxbXNtU+DFRgB2WfyR3+Iiur7e7WEz/WaO3KDkLCjzEHKca0iIym1/hoWhKxLDXTRxZvFA4MjR
 xrC67lVvyWONO264CYLR/1sdiun7+ZpzTSqDwJjfqzKQ9MHn
X-Received: by 2002:a17:907:6d15:b0:bad:3fc8:e88a with SMTP id
 a640c23a62f3a-bbac66a2ac3mr353736366b.28.1777599197008; Thu, 30 Apr 2026
 18:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260401053853.10473-1-sebasjosue84@gmail.com>
 <db954ab0-3a2c-46c7-a0a4-161fa0df0876@tls.msk.ru>
In-Reply-To: <db954ab0-3a2c-46c7-a0a4-161fa0df0876@tls.msk.ru>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 1 May 2026 11:32:50 +1000
X-Gm-Features: AVHnY4IQpWL5BPzcx3ZSfvBikASS3fgta6xD9ulmQtVOU73MuUqStfHBxW-We3M
Message-ID: <CAKmqyKN134zPbbbwyF6MisrxXq+1fFH49iN5084sALrntsGzOg@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/riscv: fix stale ptshift and base on page walk
 restart
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?Q?Sebasti=C3=A1n_Alba_Vives?= <sebasjosue84@gmail.com>, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 palmer@dabbelt.com, berrange@redhat.com, qemu-stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x632.google.com
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

On Fri, May 1, 2026 at 4:11=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> wro=
te:
>
> On 01.04.2026 08:38, Sebasti=C3=A1n Alba Vives wrote:
> > When the atomic compare-and-swap for updating A/D bits in the page
> > table entry fails due to a concurrent PTE modification by another
> > vCPU, get_physical_address() jumps to the 'restart' label to re-walk
> > the page table from the root.
> >
> > However, neither 'ptshift' nor 'base' are re-initialized before the
> > restart. After the walk completes, ptshift has been decremented to
> > its final value and base has been overwritten with an inner PTE PPN.
> > On goto restart, the for loop resets i=3D0 but ptshift and base remain
> > stale, causing the restarted walk to compute incorrect PTE addresses.
> >
> > In an SMP guest with MTTCG and Svadu active, this can result in
> > incorrect physical address mappings or guest crashes.
> >
> > Fix by saving the root base address and re-initializing both ptshift
> > and base on each restart.
> >
> > Fixes: 0c3e702aca ("RISC-V CPU Helpers")
> > Signed-off-by: Sebasti=C3=A1n Alba Vives <sebasjosue84@gmail.com>
>
> Shouldn't this change be in stable qemu series too?

Yes, it should.

I thought the `Fixes` tags were picked up, should it also CC qemu-stable?

Alistair

