Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12F3C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtVu-0002RP-PV; Mon, 21 Jul 2025 12:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1udtTd-00088r-4B
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:35:02 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1udtTb-0003HD-Ab
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:34:56 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-60867565fb5so7113997a12.3
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 09:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753115693; x=1753720493; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GJjI1uBwnFot2zXK72x/50ovaZkLjy6+dEtF14g3oLA=;
 b=fWKyIZ+uojc9KL1qqF1ZLvLBGI2QDrF8XDXZdpMM8ftVwGSkchgfU6oKB6glyVwE/X
 s/ABEwudUCZ5HAhhQi/N/R2sKbgfTmvY+QVY0/wNVIfXg7/UDFEf5QUu+3kRNyGK8xUo
 ICnISVqjBWGJWljs1Wv4luCW1lh+V9N04A5ArZIaVIdGOWJ237pb5oJBFFjTVDotI5Rz
 FKFSBik8I6/H+/xYct+ck2L5kEfz8/rvflXGaTeYEJzsdQ5LRj3ekDvxrvHIJ7uSySnV
 myw4p75tqDV4mnBGWjQCMWe89OS7QRzk7Zgb6If9JJbYcfvR+rYelISjM/ZPuWE/rLMa
 vSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753115693; x=1753720493;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GJjI1uBwnFot2zXK72x/50ovaZkLjy6+dEtF14g3oLA=;
 b=WDQ2amEMFeCE+kEx5VBfCw5zE3S58J6+S3YKeJpOwvHNNHO7DQrFwjip8TO03rQDlY
 qVctQ0/A+yriR4/M8PYry9WCRVLgi1WX6r2ihk/Dw5UWx5Bu/Xlu7s7ew4XRYKWBF8/X
 tfYEj4tGdmDj3fuiaFJ0oK9xMRM8GEBFFHHr04l2K7xZPlOj+rs29VJcH6V63gWsHFEI
 9V+RdawjVYXIho/G/MXVo+Ec/Y+QSqEJ6P0jUkuTFBhK6vPzuPjjWHI5x8JdsJKPu6HL
 sJZQqGRa/fNsmiy2clGC6L7xpYnbKJXfkleXJmvkVDNnMUqW3eK7SmlPhfyp4E3mVwdx
 EBKA==
X-Gm-Message-State: AOJu0YzAfgKLGs/jHemcl6qWaQdGplH8gb7S70sceLp/vptTiXcQp/9w
 e1wqN7Oq8LL29O6e8krSlIY7SYPj9H6oGCcNlKY+axKxyn/GRYcW2A6B52v7P/PXf0985QjYSyB
 /G/CxAMs2HpOsj+kaxcZWLdpWpU84bXNISW388BDBNg==
X-Gm-Gg: ASbGncup1waBFMoZOkb99Y+hhKVhSxIWjtTQxEaMEdtBNbn7uPzlA3OKuV9hnUmipVj
 1SVQ+BpfVMnfhyM8JOL1Mx5EGTZZaEISs3UMWGtkvDm57uP74RFDqT8UqzmytWy+yZfw3KiHY6c
 WDo3vV9K0zeOFDdcVEpFF98igOVR2eE/wkVyhKqoHi5Wqc1cBLabiXAEIe1N8Z8C2Qt1GieEYCX
 vD6Wg==
X-Google-Smtp-Source: AGHT+IEnwRPpS9M4AzIcGjbW2N0Dan1/lIrOXSdCiJXeHHe5NTfRCiRrgZMRGdnRErCBGgLrOHr9KlVObbLstQvT1e8=
X-Received: by 2002:a05:6402:2685:b0:611:d497:e8a8 with SMTP id
 4fb4d7f45d1cf-612823da4c1mr20483485a12.27.1753115693462; Mon, 21 Jul 2025
 09:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250710174312.1313177-1-peter.maydell@linaro.org>
 <CAFEAcA_T2wgp+5Sp-mEdr-RBBAW-Q3DYg_==EJW7s07_gCb2Xw@mail.gmail.com>
In-Reply-To: <CAFEAcA_T2wgp+5Sp-mEdr-RBBAW-Q3DYg_==EJW7s07_gCb2Xw@mail.gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 21 Jul 2025 19:34:27 +0300
X-Gm-Features: Ac12FXy9DfivSgwqxVXRen3bT-AEmClhp437JT8zxB647p7bFPaSD-gSsjJDvEA
Message-ID: <CAAjaMXZRnRYF_frncb-frrbxJEUGnP6aLgNWq2EKrinq31k7UA@mail.gmail.com>
Subject: Re: [PATCH] hw/display/framebuffer: Add cast to force 64x64 multiply
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x535.google.com
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

On Mon, Jul 21, 2025 at 4:58=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> Ping -- any opinions/review about this one?
>
> -- PMM
>
> On Thu, 10 Jul 2025 at 18:43, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> >
> > In framebuffer_update_display(), Coverity complains because we
> > multiply two values of type 'int' (which will be done as a 32x32
> > multiply and so in theory might overflow) and then add the result to
> > a ram_addr_t, which can be 64 bits.
> >
> > 4GB framebuffers are not plausible anyway, but keep Coverity happy
> > by adding casts which force these multiplies to be done as 64x64.
> >
> > Coverity: CID 1487248
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > This is one of those ones where I'm on the fence about sticking
> > in the cast vs just marking it a false-positive.
> > ---
> >  hw/display/framebuffer.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/display/framebuffer.c b/hw/display/framebuffer.c
> > index 4485aa335bb..b4296e8a33e 100644
> > --- a/hw/display/framebuffer.c
> > +++ b/hw/display/framebuffer.c
> > @@ -95,9 +95,9 @@ void framebuffer_update_display(
> >      }
> >      first =3D -1;
> >
> > -    addr +=3D i * src_width;
> > -    src +=3D i * src_width;
> > -    dest +=3D i * dest_row_pitch;
> > +    addr +=3D (uint64_t)i * src_width;
> > +    src +=3D (uint64_t)i * src_width;
> > +    dest +=3D (uint64_t)i * dest_row_pitch;
> >
> >      snap =3D memory_region_snapshot_and_clear_dirty(mem, addr, src_wid=
th * rows,
> >                                                    DIRTY_MEMORY_VGA);
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

