Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7428CECE57B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 08:45:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sna0l-0002KQ-5N; Mon, 09 Sep 2024 04:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sna0j-0002Gl-4h
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 04:44:37 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sna0g-000116-7X
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 04:44:36 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a8d4093722bso222309566b.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 01:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1725871471; x=1726476271; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jdnT95hf29ZLJ3Xi01T0ew1eGfqTVPDY0JBoqAuLLIk=;
 b=mAq+yQe9MMbPheFh+TeJR/C6CxATnesioRXAR5gZrJyR4ZlnNWyYqXDgI5gbSm6LgB
 gF6T7/2jlL+lrfnUbz16mCgZ7lwsAlrh1ccUni7D905uwIl+QtJsXDNCSKb3evHi3Kjw
 x4WbBtXTJfCA2DenggUvAv5Y4dB8i+wlnM/pGuJtR+RVQLi3SdalULUt6RKtYxHGu3+9
 a9wylkOi3iEDELokX3c/r34rGyw35TZIYLvnZ3yMFIe0hFCxgTJDIo7084C7XYH4chOj
 xndGw4K/ofiVFqzwJ2OjQLWsOOGiOv4erSpY3d7UcUU/n531XfE4zLs1FR3ze3rj+v5e
 H2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725871471; x=1726476271;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jdnT95hf29ZLJ3Xi01T0ew1eGfqTVPDY0JBoqAuLLIk=;
 b=WkD9YCrHYaNAOnnTokSxkBSGP+tC0/M3019EU44Fjgpup9OmHh5+YMAsIhhF+gmZAK
 Lf72Sm2hIMCWFilALIwKHEEzChNIBuiPY+/veVyhTNxn1oj67zDVeGLHhhr1+14jxN3C
 emElU3oFHmbSwbtawU6HT3fEkkq2MaiyF6tA8A1mBxf4nl079NZXV3c2QOKDh9J47GUT
 ql7WL5YGtoNFE7ubiAilt7MsGKM91RDLsqItNvcaRl2OfqtvRDmc6+6eFL6D7CxAXQFj
 Niu2LdOvofNt6GaIjQzyToP4Khvrk8oyn7nbTkUV/ikHOpJ7okE5V/GmXxey2kDqEf0Z
 61lQ==
X-Gm-Message-State: AOJu0YyJASVfWvFx1j12fdk26FHDxO/FYE/11gQ3Hp58G4bQOu7yIaYY
 6CvNC6tqp85ci0B0OxziXcBsA8GSVGHLsft5OnSzyRuXRFr8i902fhxGUkjh7is=
X-Google-Smtp-Source: AGHT+IEZINGOISGOwE+YOHaPJ075wIuDVvTRFaLPFL4ts20i9fZGf4fmLgVQC1LAYU9od5lbuNhCLQ==
X-Received: by 2002:a17:907:9484:b0:a8a:78bb:1e2 with SMTP id
 a640c23a62f3a-a8d1bf76023mr901029266b.6.1725871471123; 
 Mon, 09 Sep 2024 01:44:31 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d258339dasm311036266b.38.2024.09.09.01.44.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 01:44:30 -0700 (PDT)
Date: Mon, 9 Sep 2024 10:44:29 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bmeng.cn@gmail.com, dbarboza@ventanamicro.com, 
 Anup Patel <apatel@ventanamicro.com>
Subject: Re: [PATCH 2/2] hw/riscv/virt: Introduce strict-dt
Message-ID: <20240909-6f10c3eaac4f8e1494dbdebf@orel>
References: <20240816160743.220374-4-ajones@ventanamicro.com>
 <20240816160743.220374-6-ajones@ventanamicro.com>
 <CAKmqyKOXS+Fmb1Jxzwh3fAkeKi5eXQZ+JKkc3H77XjKrrKXe-Q@mail.gmail.com>
 <20240819-2773526929f81da7a462d10a@orel>
 <CAKmqyKNKY3VmnQfwLcshFpDnnaw+1VwwWBSkpUWKiwDsaUM43w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKNKY3VmnQfwLcshFpDnnaw+1VwwWBSkpUWKiwDsaUM43w@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, Sep 09, 2024 at 12:41:24PM GMT, Alistair Francis wrote:
> On Mon, Aug 19, 2024 at 5:50 PM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > On Mon, Aug 19, 2024 at 11:19:18AM GMT, Alistair Francis wrote:
> > > On Sat, Aug 17, 2024 at 2:08 AM Andrew Jones <ajones@ventanamicro.com> wrote:
> > > >
> > > > Older firmwares and OS kernels which use deprecated device tree
> > > > properties or are missing support for new properties may not be
> > > > tolerant of fully compliant device trees. When divergence to the
> > > > bindings specifications is harmless for new firmwares and OS kernels
> > > > which are compliant, then it's probably better to also continue
> > > > supporting the old firmwares and OS kernels by generating
> > > > non-compliant device trees. The '#msi-cells=<0>' property of the
> > > > imsic is one such property. Generating that property doesn't provide
> > > > anything necessary (no '#msi-cells' property or an '#msi-cells'
> > > > property with a value of zero mean the same thing) but it does
> > > > cause PCI devices to fail to find the MSI controller on Linux and,
> > > > for that reason, riscv virt doesn't currently generate it despite
> > > > that putting the DT out of compliance. For users that want a
> > > > compliant DT and know their software supports it, introduce a machine
> > > > property 'strict-dt' to do so. We also drop the one redundant
> > > > property that uses a deprecated name when strict-dt is enabled.
> > > >
> > > > Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> > > > ---
> > > >  docs/system/riscv/virt.rst | 11 ++++++++++
> > > >  hw/riscv/virt.c            | 43 ++++++++++++++++++++++++++++++--------
> > > >  include/hw/riscv/virt.h    |  1 +
> > > >  3 files changed, 46 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
> > > > index 9a06f95a3444..f08d0a053051 100644
> > > > --- a/docs/system/riscv/virt.rst
> > > > +++ b/docs/system/riscv/virt.rst
> > > > @@ -116,6 +116,17 @@ The following machine-specific options are supported:
> > > >    having AIA IMSIC (i.e. "aia=aplic-imsic" selected). When not specified,
> > > >    the default number of per-HART VS-level AIA IMSIC pages is 0.
> > > >
> > > > +- strict-dt=[on|off]
> > >
> > > Hmm... I don't love the idea of having yet another command line option.
> > >
> > > Does this really buy us a lot? Eventually we should deprecate the
> > > invalid DT bindings anyway
> >
> > I agree we should deprecate the invalid DT usage, with the goal of only
> > generating DTs that make the validator happy. I'm not sure how long that
> > deprecation period should be, though. It may need to be a while since
> > we'll need to decide when we've waited long enough to no longer care
> > about older kernels. In the meantime, we won't be making the validator
> > happy and may get bug reports due to that. With strct-dt we can just
> > direct people in that direction. Also, I wouldn't be surprised if
> > something else like this comes along some day, which is why I tried to
> > make the option as generic as possible. Finally, the 'if (strict_dt)'
> > self-documents to some extent. Otherwise we'll need to add comments
> > around explaining why we're diverging from the specs. Although we should
> > probably do that anyway, i.e. I should have put a comment on the
> > 'if (strict-dt) then #msi-cells' explaining why it's under strict-dt.
> > If we want strict-dt, then I'll send a v2 doing that. If we don't want
> > strict-dt then I'll send a v2 with just a comment explaining why
> > #msi-cells was left out.
> 
> I think go without strict-dt and add a comment.
> 
> In the future if we decide we really want to keep the validator happy
> then we can version the virt machine and use the older machine for
> backwards compatible kernels

OK, I'll post a patch with a comment as soon as I have an upstream
Linux commit to reference for the fix. So far the fix is only in
linux-next.

Thanks,
drew

