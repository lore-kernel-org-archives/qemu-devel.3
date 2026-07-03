Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEFFC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 10:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfb8g-0004FS-4Q; Fri, 03 Jul 2026 06:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfb8e-0004F8-9Q
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 06:28:52 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfb8c-00018w-Pp
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 06:28:52 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-664b3831a20so571729d50.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 03:28:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783074529; cv=none;
 d=google.com; s=arc-20260327;
 b=QUXQODiYzfrp8bZzmKitwMaMWp/fkXeqUpykBx9ZNnq8ZQ31a+Os+vqZ75H6ZC+fKC
 xeFyiNEF8VPAf1ff6PgOOT0HntgWNWa6C+fxCdUQfHua+T3/P3sRDMFQG2jCBcCVbx84
 WZGAHSc4w5NG/r18lO7fWLfWZke82s6mxN0tAMtP8EghXeWIptDgoPLwUevhwnfWN0Yb
 OBZuHbNpPblJGpkjVgMJWoB2S3gupEvgPL7O6nWo7CQAtC2IVyGhXz6dhbkif/P5dlKa
 4bxFfxS+54hKgAn1HEI49/3Ug5qhdKTm6UFsc4ruCRF2WU7Fmmhcz5BUxo/sJvo3epo3
 mvpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BYRftQ1EhBxVHug1SZSh5KJBSBcocp+LBwne83O/SwQ=;
 fh=FeUNyVy0JXs14mTB+gGbB94jqcY2l5K6l5EJSjhUgxs=;
 b=HBdhIZJB9TJsb3/D2BeLB3R7UM1xgVGdOks0Ihs7p7B9IeYdFYtLMBeHYl6yIPJ0my
 lwGmlETSBrlbJnFK2CgvrFRY8fEhXz3Go75Uzf2F0fmNvQ2eEJWZNrev41VzymtzsQFI
 BmJLCR3rDjBZxm1X2dhjtcAhG4VbPwmLlM7UmNCcMelV1EFhGFPGIhdDxyYB/0VCqvmS
 t6fG17BB4gLwKnPO2k46pbUhFbetfEL1KC/8z4DoPPR+Ujt0szhY5FwjQGCagqw7dCM4
 rntnIgO0Z1/RhP1uBhROXVxfYo2rLQ+SnrxqYIcVuuagd2IMz5t/hOcgzOZHW0B+HyAJ
 qt5Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783074529; x=1783679329; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BYRftQ1EhBxVHug1SZSh5KJBSBcocp+LBwne83O/SwQ=;
 b=UTcpqx4Ok8ccMTmsgz9KmRXjcVU1Ja3ea+qAryH/H9YO925BZmBa1ocpX7m3zpD0Ba
 D91i2S+StQfs0Jn3QGiudN6ObGQTAh2wtCmmbq47XdV14Gly1DRzVgS37FlFzY/5YZTx
 TGQtXbvQGspcoCn6oyASKClX2bCjXtFSChV+OiIiKiLcxQTD6Lb/zxvRPuuwNT1iALXo
 lc9kXnt6wdvO/Bf52rEBiwm7tB70PfipzOcPvmWi2Saw4M3YpfCdCRjCsZxoTNxjJU0j
 anFAvEKttpEmuoC4XOKYbdMA2/BnXhdbjTD31a49gXkiXGE6DNsZVGgUPG3c5HdHaeri
 VE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783074529; x=1783679329;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BYRftQ1EhBxVHug1SZSh5KJBSBcocp+LBwne83O/SwQ=;
 b=rWrLJad32wX089Z2GxZLd/zF3vzpPJahA22tbGtG46RYr69YAx9KB2IZC1+IzQPdwL
 VMEa5TZYXjXEKYALAjsbClGMwDexV8DicoQjOy8Prv1rROayjyKPgRFGzrkDCZOS2FI0
 IWl6kB6z3CSS3zoxOa8bFj4Le91zA8SygUWwsMcA0rSJzxsKfAn9yTTC95l7dnjMIMvw
 LMd34MWMErdU2t65J2HLq/F7TMpB1Y011ogl7GCGrgzLLunWcwVv39/W2uByNKK1ZRua
 kpWKGzqFz4iw6E073h50P3dRI46WybNui8LPr0m08IsZGXDYcNn1n6f64xctN2azsfnc
 gGoA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpRpEaugyNgGjJxUrpjd9yLXQbNi6mPn57CyoJSrCp3iKJGTBTaXyIswr3X//txmmiCdJcc9DUtE3Gt@nongnu.org
X-Gm-Message-State: AOJu0YwW7vKaNNzwfizoS59Y3wzAi/huve1aWm1+shyO/WbIpjWHAGDn
 X9DP/HWYoODfJzxEBmJvNIRWxr2ZoMNRz9DrU34BH6XBhufpR9awuMAc45ZP85fau+LmHguwhkN
 zuQJE3v8bmOaBn0g3mjrnNI6z2qkMYXbURd8J4yTGcQ==
X-Gm-Gg: AfdE7clM/4oPhB3iVOSTOYWsR1rvy4HXo1c9QrIRLCJJ/L8QRKbTgQqL9aFyaXAM3gX
 xDi5sLRwH3rYtSswj9PjltZGp2mt0Xq3ENgFaO2Nq67VGu8nJ11C2tDrtidH+TxIB/P0HoPoM+p
 XeVMw+5d+fSsrxq9WucblD0fM1tIXeATPIjwlnssyzpsClmzd+hgIHrfNSaTsG3mdY55PRmstRg
 f2q3UHNr5+pjPQ4bKISZkU6zqX+TxXedR8HoGHlzsIGkaON7RoESonUcmzajGtTswQAKL03lI0A
 lC9dzJHzl+u7UxwPQrohZLbJCzaxEoYBk2etklgMGGojnRVhPk9bXtZj
X-Received: by 2002:a05:690e:4802:b0:665:a0c:658d with SMTP id
 956f58d0204a3-66521a77dcemr7254782d50.28.1783074529194; Fri, 03 Jul 2026
 03:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260628114925.418293-1-bin.meng@processmission.com>
 <CAKmqyKMzUgs=1LMJZHoFUt1j2PSWTTKbAbg7gvzjZx83V041OQ@mail.gmail.com>
In-Reply-To: <CAKmqyKMzUgs=1LMJZHoFUt1j2PSWTTKbAbg7gvzjZx83V041OQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2026 11:28:38 +0100
X-Gm-Features: AVVi8CejQaReLRSSrngSZYEkB3cfnGJyXv5vspWiZrG1P890gvTTyxXE5lAn_1I
Message-ID: <CAFEAcA-WKMnBFks8vrp8YC-h=j8AGWGaU_nzXasdpXx9NgdLjw@mail.gmail.com>
Subject: Re: [PATCH] docs/system/arm: Document Zynq Buildroot boot
To: Alistair Francis <alistair23@gmail.com>
Cc: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>, 
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Mon, 29 Jun 2026 at 00:29, Alistair Francis <alistair23@gmail.com> wrote=
:
>
> On Sun, Jun 28, 2026 at 9:51=E2=80=AFPM Bin Meng <bin.meng@processmission=
.com> wrote:
> >
> > The Zynq board documentation only showed a generic direct kernel
> > boot command.
> >
> > Add Buildroot ZC702 commands for booting through U-Boot proper
> > with the generic loader and for direct Linux boot from the
> > generated SD image.
> >
> > Signed-off-by: Bin Meng <bin.meng@processmission.com>
>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>

> > +  $ qemu-system-arm -M xilinx-zynq-a9 -m 1G \
> > +      -machine boot-mode=3Dsd \
> > +      -display none -serial null -serial mon:stdio \
> > +      -device loader,file=3Doutput/images/u-boot.bin,addr=3D0x04000000=
,cpu-num=3D0 \
>
> I'm surprised you can't use -kernel here

I think it's better in our docs to only use '-kernel' for
booting an actual Linux kernel, and to use the generic
loader when what you want is "load some other binary blob",
even if -kernel's historic "do what I mean" handling means it
would also be able to do the job.

Applied to target-arm.next, thanks.

-- PMM

