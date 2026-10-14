Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C21BFCC6B19
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:21:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGpXJ-0000rf-5L; Tue, 13 Oct 2026 23:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGpXH-0000rO-5R
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:20:11 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGpXF-0008Lp-EI
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:20:10 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6b1cc392d8bso710241a12.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:20:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791948008; cv=none;
 d=google.com; s=arc-20260327;
 b=aKAXFUQ6F1TjmjNNpsnOJMtSbV3Ll4q6gBRTjv3FiPxfg0CfyYxBcrGKrywTQc5Lmg
 ON5CQRgCaruI5JSp4P0wL1Xqv/rdV2LdXml98gAJ6KEpVyjqslnqIUSusRaRxWxx3qh+
 IO9xQVahKf7hkW4elJkV/91Y8nRlZ7YQh8k36RwnD0bBuVhUC1BDN1OLUqJ5lpFUAuzV
 QEWL/t9NOY9w/fx2BlcdTedrC2f3FVMTiFurJyT43d28+bzpp8X7hP98s5RRMIx22Top
 OomEgnBq2FjpNrhfWfOzUfj/NVxGpbg4wjxjInfFk7urTf99f7rMId/nNjlOBjYdWDLr
 e5Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=mxY9S8D9jN+dNB3gZtht2Bt+DGTBuSwd5icwmsVKJT8=;
 fh=aUz2Be7HQDY/LfYaa8dIrF0guArmdPFWafRBpwi1Qpk=;
 b=aBz0FVCUlmi7N6qb/Wdtte4XKuywHJfe2FIdaBi4tfnJpudQKpA0eIsuLyuTUNitdE
 5S6q1oFFv8XY2V8w3q5fNoE/ME3wTLSBE7lg/x6zYiV/BlP32oNne5fd6sQaCQMmoE2I
 3r+fDGwHuqMn0uLxrCFHEWy+KEL+MFm1hPIgTXgTjAj3KSm3j3jhlhg84EKgofd60dBt
 rvWvNItcvNcA5Y0Von/KTMC8yvZlRyZFpnoJOKlNQCyHAk+xzDGGjxfudg8pYqERdY+S
 7FpkIrQ4MSKdOckrzC1rhHJuTUE+4cBsmjKIpX83P8SE3IPBC+HT3sdLXpjvD7IZPmJ5
 UeYA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791948008; x=1792552808; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mxY9S8D9jN+dNB3gZtht2Bt+DGTBuSwd5icwmsVKJT8=;
 b=Q8Veav1JbmuwENPiigL2uoscA8xUfE4odiK+0zBpn95J87nooWT7In50NQN84JvZLD
 LiscKh6Q+cqzF4RfJtZu8o5/VlGLB4epfPZZv4Imt07ubGExUhOl9sHNA8WL7lm+oMty
 gcZRkz8Vj6U1yvmZ+aUTCCgGalGv1k4w+hkmLYohbnp31Bt1PYO2S4/NApGDIq2bNI8e
 PRMCRcGcyAevbxS6t0gUPEQ89xsbBxwxIulOtwPgy6moB+x9YuITP1Hd2hEpmKe9+ltK
 cwfQ/iUL73+i3i89vds6dapvlou1Qk6fVq1xB1JlQweqxThjCMf0GWGI72Ei2jWM3sFq
 Zq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791948008; x=1792552808;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mxY9S8D9jN+dNB3gZtht2Bt+DGTBuSwd5icwmsVKJT8=;
 b=iBw5EKQDDjXmgmQUVccQkFcntUy0cLjFDm3H11zdYJ2jyHjxYYPKrp9OqpF02QrRoI
 IwrA7Jy1FMtnf2K9v0HowF/g/83YkYDF3/xto8LX+R+bm0G8+VnnReID/4Oc+GqeBosf
 oVvseyMS7VYDtPXZ9ML7N5evc1yyewgoGBIiPFISdHxoxUjhRQ9pOlolVzTHeQcPgpPn
 oq5+zN+2t+flBK+qMDC+5ynf9Y2Qtcfrpw9GpWYJNhsP+nhPmDATcb4d+OXRlhMFFA6t
 mJxpZWHTJ7p3s66gsKviqSAhzeYbYqgB3ylbYzp5SsBMo0lw+qLVzBi4GGxc70DVxKA0
 O91g==
X-Gm-Message-State: AFq9FYLKXpEKAlfsDJ+0DFGtfq8Ve9K/uXW5U3venPk6MPOj4ODd1yuA
 mPG2Yi8Q684ilD6tGoETBitdkfONE+uXOVmIR6WKteDbCptxzzAJBeCzpKU6xMCahEFuuqNTCYN
 jCiD0IZ8srPzuqGvrNzhOwB8gfR2HjZA=
X-Gm-Gg: AYBFou2TzBcMYMJ/MHy01TwTcLuezA0dB8pjVdDjqN10MGI7XjeSotHO2Jdo/djNf/A
 vTCDjfUnt5G5ea/ZQYfYRIX2fEe/l0PcRRE41+LnoEIE3fgI0Trni7equyC7544uMAyMuFHmvua
 eNtaAGR6f+NfnlUVnpR1pj6310aYcLAZFqJc/Zh4kentVRlDAOmYRa7DisuX3/Hdv/9UJFJBuRr
 zUUkUi5vLa89i1XMj8MV3VqikQvwCX6/USdVGwbNE3ogJaVhhnR24Pz1mR5crycz+PhHuZqXKTL
 RMmOAjrrMhH5BCJPhzb/QBfbyN793pPek5l0PXHDIUcIFQz+m8xYrSU=
X-Received: by 2002:a05:6402:c522:20b0:6b1:b97b:750 with SMTP id
 4fb4d7f45d1cf-6b1b97b0a16mr4778031a12.16.1791948007730; Tue, 13 Oct 2026
 20:20:07 -0700 (PDT)
MIME-Version: 1.0
References: <20261013195929.1648-1-luoyonggang@gmail.com>
 <ceb0694a-3ca7-4112-bf23-48c0e117ebbc@oss.qualcomm.com>
In-Reply-To: <ceb0694a-3ca7-4112-bf23-48c0e117ebbc@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Wed, 14 Oct 2026 11:19:52 +0800
X-Gm-Features: AclHuK8TAkUFhWiz7iUjbP-0FQfC8koUlaRCWqvOTf-NWNVKr9-O7XeEjZrEMmo
Message-ID: <CAE2XoE9aYjYCAbWam1NkUdoLgXMo8a3AKC_-njnYybqn7eKYQw@mail.gmail.com>
Subject: Re: [PATCH] hw/microblaze: defer PetaLogix endianness default until
 init
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Philippe Mathieu-Daude <philmd@mailo.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x52d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Oct 14, 2026 at 11:10=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 13/10/26 21:59, Yonggang Luo wrote:
> > This is for avoid call target_info() in class_init
>
> Why? What is the use case you are you trying to fix?
>
> https://cbea.ms/git-commit/#why-not-how
>
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >   hw/microblaze/petalogix_s3adsp1800_mmu.c | 11 ++++++++---
> >   1 file changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/p=
etalogix_s3adsp1800_mmu.c
> > index c5f64319009..43140ad7bda 100644
> > --- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
> > +++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
> > @@ -83,7 +83,13 @@ petalogix_s3adsp1800_init(MachineState *machine)
> >       MemoryRegion *phys_ram =3D g_new(MemoryRegion, 1);
> >       qemu_irq irq[32];
> >       MemoryRegion *sysmem =3D get_system_memory();
> > -    EndianMode endianness =3D psms->endianness;
> > +    EndianMode endianness;
> > +
> > +    if (psms->endianness =3D=3D ENDIAN_MODE_UNSPECIFIED) {
> > +        psms->endianness =3D target_big_endian() ? ENDIAN_MODE_BIG :
> > +                                           ENDIAN_MODE_LITTLE;
> > +    }
> > +    endianness =3D psms->endianness;
> >
> >       cpu =3D MICROBLAZE_CPU(object_new(TYPE_MICROBLAZE_CPU));
> >       object_property_set_str(OBJECT(cpu), "version", "7.10.d", &error_=
abort);
> > @@ -178,8 +184,7 @@ static void petalogix_s3adsp1800_machine_class_init=
(ObjectClass *oc,
> >                                             &EndianMode_lookup,
> >                                             machine_get_endianness,
> >                                             machine_set_endianness);
> > -    object_property_set_default_str(prop, target_big_endian() ? "big"
> > -                                                              : "littl=
e");
> > +    object_property_set_default_str(prop, "unspecified");
> >       object_class_property_set_description(oc, "endianness",
> >               "Defines whether the machine runs in big or little endian=
 mode");
> >   }
>

https://lore.kernel.org/qemu-devel/60494b19-420f-4d0f-966c-b70c4c51104b@oss=
.qualcomm.com/

Avoid calling target_info() in class_init, as for the combined
qemu-system, target_info() is not available(NULL)
till the machine is selected.


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

