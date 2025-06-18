Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776A9C7115B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 21:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uS0SH-0007DH-2Z; Wed, 18 Jun 2025 17:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vliaskovitis@suse.com>)
 id 1uS0SF-0007Cq-MN
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 17:36:23 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vliaskovitis@suse.com>)
 id 1uS0SE-0002MV-4J
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 17:36:23 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-553b544e7b4so63816e87.3
 for <qemu-devel@nongnu.org>; Wed, 18 Jun 2025 14:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1750282580; x=1750887380; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=My41l7o4NOrBRz0pujfqnxBCQaM/IGE7udFD8s5KHAg=;
 b=O5fZ7Fo6psW8958sw9u2LCwsB5owhxerbCSqEddBsynGtypX8bYhfa1iBUDZrKsw2S
 hXbqTx1qN1JXKuIqWWSeJkYqrdZb7J5owepuuYwV1xretbFQM/5XlcnkNRRxOdLEk30y
 vJ66Db1/7QPi3Tz2bOpqJOR9Baf+D+OczhkUpdqYZY97lhF0BZK4keetF3TJmaOX9n2C
 ixYKfjwbc3g2cVMhk4BGy2RCeih+8W6LlUJhVzQv8N5RwrzPnWKQ1qUVCnh9S5d5ctcx
 hYeILLoaIDySsgQwILjjGqANGn9nDsEWaepZoAjyvK+vo8hHAMvWZgobgwYpzEQRjFcR
 Bu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750282580; x=1750887380;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=My41l7o4NOrBRz0pujfqnxBCQaM/IGE7udFD8s5KHAg=;
 b=IcljItsQQ74LfI8g3TNxhCbYGOQU+0lOYlu97mOHc5O4/+Nm7048KSTbkBpyDGEc/B
 EJOSVVcsrZvO/OsDnkiyawyshMGA3OIXKzCup2squy1vV8uy3pIC5ehwVgL4AcU/wJLK
 AlO5LLxQskUmyP+Tj1Uqw+mVTF592D+dXvXB2tENiC8vncpa8TjM1JhueBb9mgIr6pmA
 526EKYIP04EBVKcepmWa+5UeO8Hg2OaVv7VuV097MYCiMJAijjJ/XoCUzbGLbPphX+H6
 zZ7x9N9g2N5igeUQI7fCIxYjXAfHbtVGjJ2h5VxTqxAv1DK8lmNYmfUQXQTeW4KtNGv0
 LuUw==
X-Gm-Message-State: AOJu0Yxk2wQw7f87RkSdQt9euZQ4asEtmONPjFChxNr1pn1u4rhyPmZY
 qxu2kJPLqLfXp6fgVMZGmHX7iCsqq7RP8dEBaTM3y4vUEWVRJou509wPBi5ZAiW2g5hDEINXxCm
 UHDuw48F2dhLeUgsBM4bIxOFJ/Kf6zD671if5vJkHMA==
X-Gm-Gg: ASbGnctoRK5oThe8qoz3W4Ut74bROH3XzmLtabBdbpB8pCpsh8slfMePkAdZhgRpmHO
 kFKv+fLOWtSO1GeVFFq8g5rB9u6z5UvKLxfnPlnY/g2kucso/tdpqo9xWkpksRJZd2UumoQZyzc
 M5YSlT63Bz25JVWoQYmeCiHGa95RWxsJ0GeniTHFzxGb8lG8BhBiFkutd3yM6xROcN4pFCzEslV
 ZsS
X-Google-Smtp-Source: AGHT+IEvoOLvwUbZmK6mevQDEM0XnvNqlFSOT0INoPMZz+IBbkWEM4zX4utvBdH3Kdb7S6KS4usdf5+HBzcegvOD1TY=
X-Received: by 2002:a05:6512:3194:b0:553:3322:49a6 with SMTP id
 2adb3069b0e04-553b6ecf5e8mr5033675e87.25.1750282580323; Wed, 18 Jun 2025
 14:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250618072500.8469-1-vliaskovitis@suse.com>
 <9812c3c3-c9e4-4b29-968b-9da99891489a@ventanamicro.com>
In-Reply-To: <9812c3c3-c9e4-4b29-968b-9da99891489a@ventanamicro.com>
From: Vasilis Liaskovitis <vliaskovitis@suse.com>
Date: Wed, 18 Jun 2025 23:36:07 +0200
X-Gm-Features: AX0GCFuA-8xc9rKZtZX1cICMRFsGxYcCGwdu1yxDYZV3e1wobHHP8F4KmhQMp-M
Message-ID: <CAPnFoxfp1B4nBCLyFjf1RnEH5memnWoW5X-4xN3PpG4Ss_n0xQ@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Add a property to set vill bit on reserved
 usage of vsetvli instruction
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, ajones@ventanamicro.com, 
 alistair.francis@wdc.com, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=vliaskovitis@suse.com; helo=mail-lf1-x12d.google.com
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

Hi,

On Wed, Jun 18, 2025 at 4:22=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
> > +    if ((sew > cpu->cfg.elen) || vill || (ediv !=3D 0) || (reserved !=
=3D 0) ||
> > +        (cpu->cfg.rvv_vsetvl_x0_vill && x0 && (env->vl !=3D vl))) {
>
> In this particular case I don't mind replicating code. The first existing=
 check can be
> left untouched, exiting early before spending time calculating vlmax and =
vl.
>
> We can then add the new check that depends on vl here, even if we end up =
copying those
> few "env->something =3D" lines again. If you really want to avoid code du=
plication I
> wouldn't oppose adding a 'vill' label and using 'goto' as an alternative =
of duplicating
> those 6 lines.

thank you for the review. I sent a v2 simply duplicating the code.

thanks,

- Vasilis

>
>
> Patch LGTM otherwise. Thanks,
>
>
> Daniel
>
> > +        /* only set vill bit. */
> > +        env->vill =3D 1;
> > +        env->vtype =3D 0;
> > +        env->vl =3D 0;
> > +        env->vstart =3D 0;
> > +        return 0;
> > +    }
> > +
> >       env->vl =3D vl;
> >       env->vtype =3D s2;
> >       env->vstart =3D 0;
>

