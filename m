Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7798DD2CE1D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 04:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRNFa-0007F0-6b; Thu, 04 Dec 2025 23:16:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <navidem@google.com>)
 id 1vRNFY-0007Ed-Be
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 23:16:56 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <navidem@google.com>)
 id 1vRNFV-0001YR-ND
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 23:16:55 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b7277324054so244977766b.0
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 20:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1764908211; x=1765513011; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JZT/9RgqmEY6TqwJ1C2hMHmYEM/R1LMcanNR6OR1b1I=;
 b=wHfe6JGzDoG7t5KFyQQIJwC/4IAWFBNk4Wyvx1PrJBnbbIUwJ/ajz8DURSKnqbk/Nu
 OmAg3Kxprkp8EUGpmicdtJyn/6zJWz9fYvM1vLAkp479bZvVICIh7l5YwEyFbp9muiJU
 RdzoCZU5k5i3deXz9velHo1MHxOcE8Ob8mBg7PLkbNCSuFT50J68WDWseMYekUitwA+e
 HgU5ecXr0+6fytxXpv4ZapNpE6IaFjZepIekfmp1W1VBK04kgLkJbpVSkX1LWsPPv/fZ
 kpJKT7+EdGGkVD5dOcxtz5+ntUkpn4xPhbkb1H0y66wYi6HgCOyK0DUxZ3nN2vOvN+By
 DA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764908211; x=1765513011;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JZT/9RgqmEY6TqwJ1C2hMHmYEM/R1LMcanNR6OR1b1I=;
 b=ZrOGVx59/YW6ZbvROqR1xrhyMmnosjMP4Gj/EfnmysVb7lOYYbwWHe9QEm7x67wyhZ
 hIMCg8mq0ZRdEFP+yDNB8ErdbaR3NFzjBHkEEQcZhxza8cvul3W3vTFWt3ny/HK1YA5K
 TsG5SFpIDclSXoABUEZ8Trii//+ewtWyOdwrczLvBbeRa66/R3RlaaNZxqdlz2LbAg+a
 RDLwWwCetBtRdyxDbdbpEaDEwwAMttm1LiXe9K7anAfgPBBHC+oleZonB81Kya4h+0t/
 5fbFPvCFnAumKMBtIatLlAcjjHOKlfl1L1Ur9uP7clRdhr9FSrnqMLZl5uiBY0Wffsmh
 Th5A==
X-Gm-Message-State: AOJu0Yw6cHimTD4zyvtouadQt17O2fkjCyZb2M/dlEHki00py0cC59Dt
 cCFxBmcgVonHYmxq9cybq+1mf+oBzwz4zrfQp/Qq/WhIM+s8qtikjGo7eL/dJgPDIXaTcC2CV13
 WRHvWkv9f7KoJlXnc8oby3vAbDbj40etyCvK8CCpK
X-Gm-Gg: ASbGncvpA3TMwlvMXTHF+Xz8KHLqu0+fCwyll1ioHu8N+9RUpfh0SkrYVbvhfYjrJNR
 g3r4DRLTSUmjkr//H8A466fmlAABGwtcdUoNBzNXAyg3QVgXGlu1lxGWK/zb7hF3/P5VGb5g3Oq
 LG1AV/YtjBGJEqtNPfniO2tAX/hicRYlZShoxjY6nS9WzD96gfdOFqgfdx0X7vL/xowC4Y/ymxr
 xRuEMasR7reqtFvOnOEerfJGAMSFJ0eilk282YQNiyybdxUiBlp7pcE2UMo/I48n9C3egpACY5T
 IFGayIlbjguZo07Flchj5+DjDHuI3D2ick5pScY=
X-Google-Smtp-Source: AGHT+IFMeb0rgNwTBUhgAzgL3kq4YW4wZRAkAUzIAD1u6+neWSAI39iKKdErE0CYsaLIOXSfSWRscsAGlA2eHqcrNXM=
X-Received: by 2002:a17:907:97d5:b0:b73:6f8c:6127 with SMTP id
 a640c23a62f3a-b79dbe5ae11mr847344766b.12.1764908210896; Thu, 04 Dec 2025
 20:16:50 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA-hyn0B-yWE1=g4+NN9=NBjWvk-P8qrAk9L4vpAZpUYvQ@mail.gmail.com>
 <20251127001247.1672873-1-navidem@google.com>
 <20251127001247.1672873-2-navidem@google.com>
 <CAFEAcA97NhUDzVx8fePmW2HSKn5DhhaQEkc=FkmPzGf+vKFKzQ@mail.gmail.com>
In-Reply-To: <CAFEAcA97NhUDzVx8fePmW2HSKn5DhhaQEkc=FkmPzGf+vKFKzQ@mail.gmail.com>
From: Navid Emamdoost <navidem@google.com>
Date: Thu, 4 Dec 2025 20:16:38 -0800
X-Gm-Features: AQt7F2rOLEp7fLLqUGW4IUIKVat9auE1dg-9NxP5bbm1uMcv5b6SAefyss2dLUI
Message-ID: <CAGXevkgDcVLdWB7r6v8GEdGefckDzayd1cLUiQkkSU2H+zH1-w@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] libqos: pci: Handle zero-sized BARs gracefully
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, farosas@suse.de, lvivier@redhat.com, 
 pbonzini@redhat.com, zsm@google.com, alxndr@bu.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=navidem@google.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi Peter,

On Thu, Nov 27, 2025 at 5:17=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Thu, 27 Nov 2025 at 00:12, Navid Emamdoost <navidem@google.com> wrote:
> >
> > The qpci_iomap() function would previously fail with a fatal assertion
> > if it probed a PCI BAR that had a size of zero. This is, however,
> > expected behavior for some devices like the Q35 host bridge, and the
> > assertion blocked the creation of new fuzzing targets.
> >
> > Instead of asserting at map time, modify the QPCIBar struct to store
> > the BAR's size. Defer the safety check to the accessor functions
> > (qpci_io_readb, qpci_memread, etc.), which now assert that any
> > access is within the BAR's bounds.
> >
> > Signed-off-by: Navid Emamdoost navidem@google.com
> > ---
> >  tests/qtest/libqos/pci.c | 25 ++++++++++++++++++++++++-
> >  tests/qtest/libqos/pci.h |  1 +
> >  2 files changed, 25 insertions(+), 1 deletion(-)
> >
> > diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
> > index a59197b992..70caf382cc 100644
> > --- a/tests/qtest/libqos/pci.c
> > +++ b/tests/qtest/libqos/pci.c
> > @@ -396,6 +396,7 @@ void qpci_config_writel(QPCIDevice *dev, uint8_t of=
fset, uint32_t value)
> >
> >  uint8_t qpci_io_readb(QPCIDevice *dev, QPCIBar token, uint64_t off)
> >  {
> > +       g_assert(off + 1 <=3D token.size);
> >      QPCIBus *bus =3D dev->bus;
>
> The indent seems to be wrong for all your changes to these functions?
>
> Also, we need "make check" to pass for every commit in the
> patchset, not just after it has all been applied. So we need
> to make the fixes that you have in patches 2-4 before we
> can start enforcing the size limits with assertions.

Do you think it's better to squash all changes of patch1-4 into
a single commit that reworks the libqos PCI API and fixes all affected test=
s.

>
> > @@ -541,6 +550,19 @@ QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uin=
t64_t *sizeptr)
> >          addr &=3D PCI_BASE_ADDRESS_MEM_MASK;
> >      }
> >
> > +    if (!addr){
>
> Missing space before "{". (scripts/checkpatch.pl will
> probably catch this kind of style error.)
>
> > +        /*
> > +         * This is an unimplemented BAR. It is not a fatal error.
> > +         * We model it as a BAR with a size of zero. Any attempt to
> > +         * access it will be caught by assertions in the accessors.
> > +         */
> > +        if (sizeptr) {
> > +            *sizeptr =3D 0;
> > +        }
> > +        memset(&bar, 0, sizeof(bar));
> > +        return bar;
> > +    }
> > +
> >      g_assert(addr); /* Must have *some* size bits */
>
> We can drop this assert now, because we just dealt with
> the addr =3D=3D 0 case.
>
> >      size =3D 1U << ctz32(addr);
> > @@ -572,6 +594,7 @@ QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint=
64_t *sizeptr)
> >      }
> >
> >      bar.addr =3D loc;
> > +    bar.size =3D size;
> >      return bar;
> >  }
>
> thanks
> -- PMM



--=20
Thank you,
Navid.

