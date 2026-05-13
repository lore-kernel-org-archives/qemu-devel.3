Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAF3CD343F
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 01:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMykD-0002QH-4c; Tue, 12 May 2026 21:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wMyk5-0002On-AY
 for qemu-devel@nongnu.org; Tue, 12 May 2026 21:50:33 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wMyjy-0000KF-2v
 for qemu-devel@nongnu.org; Tue, 12 May 2026 21:50:32 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-bd124546379so370917166b.3
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 18:50:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778637024; cv=none;
 d=google.com; s=arc-20240605;
 b=Kh+sPsvutXqM3xbyz+Kxjzjom0YS5MzaJuTN2cYZqFUe9ABCzgN0yTxj/eZzsMtmyO
 aIZPyWDmd54jkCMMDzYuAWRJJfFke3DYF4gljZQTiv3pa/O4fvuuljStC4YgTYN4se+c
 tBViBAisQjI+x1NPREt0xlUaf7otFuhvkRgXpw98nH9R5Mij/LXIGHVLfgWe+fqagSZj
 c2MNVGbdD0Z5SkbMffNiyORNYxxG27xjOoyi7GTPgveRhPmVzUE5v9BKeBIvB0zBD4KC
 iVhFhVhKfdIFa59z4IzVRuEbXc+3V2ji0Pqfm4iZ/3MZ9lBe8JdNqx9ks5/JpBEvd74b
 T6MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HTobnGDTCLerh/4EEGdpEu3Tl8Bz12FJp/tuNBkWdCU=;
 fh=gY4nlb9dkynTS9LwMFfEa74jQ/TBGTtTDJoTpAKFJQo=;
 b=lj+PYVrB0yKxeLN/Ms3feyt3cbGAKCvlHwN0Lfl3EDZFCdH5oI/vr63AoiElr2dELL
 wbdWYxx5/oxpZVexvByaltThPMNBXgqu8fxQlcGIHJeUOhwPODZwEJtMEKJYE11ICt0u
 h2B+OIsuKns1l/nb5bYRv7CZcavbBoB90rmP1Qaxc+VJlkqJ/R900VBlprk7GRt/8CU7
 a/D2Avi0p8J5D3SSMZo8Okdn7lRp0+ORACdvdN0mdZDnfYZ1Buw/LJc9g+f3gh27YsGh
 FBBnc9vMGDwfEESkd3j9i71HScvWFjHQSlmE513MRVqSEt+PliN6y+J7KmEpwLo8D00E
 O/dw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778637024; x=1779241824; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HTobnGDTCLerh/4EEGdpEu3Tl8Bz12FJp/tuNBkWdCU=;
 b=GIhmEl3DapyO+eoGS+Mhyt4jPOG69oUQDUJH4y7cGX1kzXuKsbH54y88wK43cpsqUZ
 fy11WfpekeNfYv6VhBuiUhRixUAxXYbo99ITo1iR59xaQTGI9roNJn6hA1rlbi4YDFmU
 LMeZEq+Phsg0sFWKqEC5PX122T/9CvG6yA5+2meqqsZxNsbqFQWzE8WolKm0Zm8k5hfs
 6BHDhzSksNAVUeLAkeAGpjeOK4G1cf3FDHH9OVp/NBZKxU/2wn+KpZck0QnP7DN05Jkp
 pShYplMYsOVxTuuWR5zxxABkD1OtRClf7y9b7lV8VvwmS/XBJ2HkK48QPqKwJ2S3s6Zk
 2vtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778637024; x=1779241824;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HTobnGDTCLerh/4EEGdpEu3Tl8Bz12FJp/tuNBkWdCU=;
 b=WBGmdRHYd1VTQm77z/vFMZsUssUVyt3f1BCbuDFyi5CU24I/DhGi8CJx1aQ8h/jkGM
 DLan/zbvIzTipmNNu56Fg/RcQLstyUvwtCxi3ZW0tMvIj1Srbp1g4WlDE03D7KqmmnWd
 Y5zZy1LvYMMGftOdvItLsTpzcIz5yDjshGV6W4VWwHimYeB46DrB22IwGeFuy5cDHajC
 63vq6thLbB69J8arQ2b0p+tKd1DrkgryOC/IVhz+gEsDTJHUyILP5YaaDARiNTXfDusJ
 MEV7vb3a36yJ4ncFVFawdgi72+Fchh2NKCewbb7HU3IDE9ivxh2tkGBxZnU46rToJuom
 gShA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9LKmO44w5ueov/GZjRbFyfNq+xsdwDfRloJ+6TbRaUWAeWh/9FTIENuzsDmwlk/ao4fCeh4AXHfqq0@nongnu.org
X-Gm-Message-State: AOJu0YxPN+AZW7odHm4XOfbVo7Aq9s5hEoAV3ksj1q1su3R1WZ49Y4O9
 /lfdMCBbzbcgCaaF+a5qW9DmiiK96vmvEaUWmjHRL8zYHdQOxQSquKnX8JrGDJw/n70i/gvyxU0
 zjDxeeSgOC3bGQQ/57DDtFpuv1f+P6H0fTI0F
X-Gm-Gg: Acq92OHtF/cU6D2CKTUtWij0HVz5bAysa1VRyDuXG+116CnzgpsYUuC+Tm8F5AEXgP6
 +LtUQPb8a1w4v9vewTrgB1GgOLzV8hUwB0HbG4DERMuijAUIgY5ep7yLS9cb3z2YN4oTFnD2ixO
 XjCawZb6vhyuGiWpcSpvGNKLD5sfb2F4DLTbLvhmJ+OLvcTFDlFcnWf7qJEjxNtAzST9m/Y7Xdq
 qsMCUHYAOSGjVLHicFGEirnEQjIg2g0wCLAnErk4c8yXN9C9vpfr9cV6qRag9ADUogJKV/v7BBB
 wSdQRg158709JEqTi7xLd6Jzi/e9Cq5/Fbn+/lt8DxtOuPfi
X-Received: by 2002:a17:906:dc8a:b0:bd3:1ef3:232c with SMTP id
 a640c23a62f3a-bd3e30b66ddmr44964166b.42.1778637024195; Tue, 12 May 2026
 18:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAA4bVAFS4aRjW7On7C0Y5MQH94TmLfXMwcD+8dWzKBD4JZL3Fg@mail.gmail.com>
 <9a6f4a8a-9917-4384-b36e-9eafe2461725@linaro.org>
In-Reply-To: <9a6f4a8a-9917-4384-b36e-9eafe2461725@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 13 May 2026 11:49:57 +1000
X-Gm-Features: AVHnY4KKw9r8bA-L_TLgMp9o03n30O96P0qz6bWx8Gx1gV-FFmroor0g6L0oNos
Message-ID: <CAKmqyKMTnn_oVUhKDCBkCDSwivgnf3U0hcyvUEkfEOcMy53m9A@mail.gmail.com>
Subject: Re: target/riscv: rdcycleh problem
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Antony Pavlov <antonynpavlov@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 QEMU Developers <qemu-devel@nongnu.org>, qemu-riscv <qemu-riscv@nongnu.org>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x633.google.com
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

On Tue, May 12, 2026 at 1:43=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Cc'ing qemu-riscv@ list
>
> On 12/5/26 02:50, Antony Pavlov wrote:
> > Hi!
> >
> > I use qemu-system-riscv32 v11.0.0 for running this code:
> >
> >      15258:    c80025f3    rdcycleh a1
> >      1525c:    c0002573    rdcycle  a0
> >      15260:    c80027f3    rdcycleh a5
> >      15264:    fef59ae3    bne      a1,a5,15258
> >
> > The code is recommended by riscv specification for reading 64-bit
> > cycle counter on 32-bit system (see
> > https://docs.riscv.org/reference/isa/unpriv/counters.html#7-1-1-zicntr-=
extension-for-base-counters-and-timers
> > for details).
> >
> > When running on qemu-system-riscv32 both the rdcycle and the rdcycleh
> > instructions read low 32-bit of the cycle counter so the branch
> > instruction always go to 15258.
>
> Interestingly I'm having similar 32/64 bit conversion issue with
> the set of CSR functions in my single binary prototype due to this
> target_ulong use.
>
> >
> > This quick and dirty patch fixes my problem:
> >
> > --- a/target/riscv/csr.c
> > +++ b/target/riscv/csr.c
> > @@ -1389,8 +1389,11 @@ RISCVException riscv_pmu_read_ctr(CPURISCVState
> > *env, target_ulong *val,
> >        */
> >       if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
> >           riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
> > -        *val =3D riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx) -
> > +        uint64_t t;
> > +
> > +        t =3D riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx) -
> >                                                       ctr_prev + ctr_va=
l;
> > +        *val =3D extract64(t, start, length);
> >       } else {
> >           *val =3D ctr_val;
> >       }
> >
> > Have you any suggestion?

Yeah, it looks like a bug using the `target_ulong` (which is only
32-bits on RV32). This is something that should be fixed, if you can
send a patch that would be great

Alistair

