Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79B6E77184
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 01:20:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNijD-0004Bd-FS; Tue, 17 Dec 2024 20:19:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tNijB-0004BS-O1
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 20:19:53 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tNij9-00039y-NA
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 20:19:53 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so2420965ad.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 17:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734484789; x=1735089589; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CTzEj1erqbAIl3Bsg9EW9dODbx2pv9PYvhzUEJKtQ1E=;
 b=Ax3WRFNPFTMCwllLPOGOwM8fiNLI7l/A3vJBGyiBji34uapfCFwrHjFT2a6bkoaR8a
 QKWeVxMgoEwB8xaqv+QUPmRN7uipgZiQvmsVzpAOSedTHmqEINUxoNj+4BKmmgDOwC9a
 6jLfJHDL2vgZEGPHz13+oUwMpj+LvLbcRHLNBK8T2W7vWJ6btVZBuCf+If7AUE8Fsh8l
 4Zh+36sWLYMVKkcUoN39hGatRpKXlHc5lOCd6sWxsE3pqU7aPllutd0Zdhq1MXqKGI+w
 j2DAer5RskVdLV0zATG5n+HCYKcUmr7AkEQlPXyFk91vQxNcS7ZQ/heDIOLq0PHRHV93
 rlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734484789; x=1735089589;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CTzEj1erqbAIl3Bsg9EW9dODbx2pv9PYvhzUEJKtQ1E=;
 b=BYg/sH/RsSxWSkx/b1e3hv6CN86dMLSLf9Fw/h/lhko/ziUHlbN2+htC9C/weT9P5U
 JvIC82xH0BOvuOdghyhEzLhfaxtr5dCHbjdUeCQfcMC1boTSI3G0IPb+1fFVozL+dyaS
 mNMxyswkyha4k2JOoDS+RQxV7VaiqzZNvBmEsAvqt0xhiDQhEkmaSwIvfZ7YItNnv6V1
 I+bfTpGXbVtwI6QTwAOZromgo/WK6S5I58RADUv47LXFTiPrKXO93qrssFdqgz0E1/ro
 O4amMb5VXJexwiIzK/XJIk2QXRXMYJJOJOqs5X3dDYhWHp0gaeYboE1Kk7D5fcekJ8d4
 G1dA==
X-Gm-Message-State: AOJu0YwBxSqhAA88qWkS//b6n7WPovLRWVTkTyEjNvmQz2QFCMF4evcC
 uydexfXbjry4Nc+u9anYIdLeL8Y4FdvGlgEWJwCWg7/tFxx3ALBJ
X-Gm-Gg: ASbGnctfEwEuvfjTewecUXkrhln/0BSg8DNsWnUsjE841T26JW3teXOyIp0dGPrtcMt
 b/1CvOPWLpuensguZqq/bskKD7cq0GHB+1X4/BessiHf2JmSGT1mKT5SX/uAlefOQYmb2VxvRHi
 BA5Hcuu9rWlw0vbSIBz20Zne2h2ornN6kdl3gVN+pmPiS3apoYhHL0LWQuZd+eZDf45c9RcElHL
 jGTTFh1U0SX/1wzfiFmQk2UUGtcHUseqvp5fUKMMk++MVxZ9WllkSza5E3szxMe8h3jSmDJMUg=
X-Google-Smtp-Source: AGHT+IFLI3SugUG33XnKq0wNXQ0BPOmQgwyLueJy1XIlRrubmtnF+580a/mF+TzG1KR0th3IIiN5PA==
X-Received: by 2002:a17:903:230e:b0:215:b1e3:c051 with SMTP id
 d9443c01a7336-218d7292478mr14658675ad.11.1734484789251; 
 Tue, 17 Dec 2024 17:19:49 -0800 (PST)
Received: from localhost (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1e72111sm64951235ad.271.2024.12.17.17.19.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 17:19:48 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Dec 2024 11:19:43 +1000
Message-Id: <D6EFJHL1PDCX.2TZC2E8DZLNU3@gmail.com>
Cc: <qemu-devel@nongnu.org>, "Akihiko Odaki" <akihiko.odaki@daynix.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 1/2] hw/usb/hcd-xhci-pci: Make PCI device more
 configurable
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Phil Dennis-Jordan" <phil@philjordan.eu>
X-Mailer: aerc 0.18.2
References: <20241212085207.1439501-1-npiggin@gmail.com>
 <20241212085207.1439501-2-npiggin@gmail.com>
 <CAAibmn3NsDewTEFdWoR=VpTRSb5C67bFMYXnf74zBQOwWCLi1Q@mail.gmail.com>
In-Reply-To: <CAAibmn3NsDewTEFdWoR=VpTRSb5C67bFMYXnf74zBQOwWCLi1Q@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
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

On Thu Dec 12, 2024 at 8:41 PM AEST, Phil Dennis-Jordan wrote:
> Hey Nicholas,
>
> I'm not an XHCI & PCI expert (yet?) so apologies if I've got some of this
> wrong, but I've asked some questions and made some comments inline:

Hey Phil,

Thanks for the review, looks like you are the expert now :)

>
> On Thu, 12 Dec 2024 at 09:52, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> > To prepare to support another USB PCI Host Controller, make some PCI
> > configuration dynamic.
> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  hw/usb/hcd-xhci-pci.h |  9 ++++++
> >  hw/usb/hcd-xhci-nec.c | 10 +++++++
> >  hw/usb/hcd-xhci-pci.c | 69 ++++++++++++++++++++++++++++++++++++-------
> >  3 files changed, 78 insertions(+), 10 deletions(-)
> >
> > diff --git a/hw/usb/hcd-xhci-pci.h b/hw/usb/hcd-xhci-pci.h
> > index 08f70ce97cc..213076aabf6 100644
> > --- a/hw/usb/hcd-xhci-pci.h
> > +++ b/hw/usb/hcd-xhci-pci.h
> > @@ -40,6 +40,15 @@ typedef struct XHCIPciState {
> >      XHCIState xhci;
> >      OnOffAuto msi;
> >      OnOffAuto msix;
> > +    uint8_t cache_line_size;
> > +    uint8_t pm_cap_off;
> > +    uint8_t pcie_cap_off;
> > +    uint8_t msi_cap_off;
> > +    uint8_t msix_cap_off;
> > +    int msix_bar_nr;
> > +    uint64_t msix_bar_size;
> > +    uint32_t msix_table_off;
> > +    uint32_t msix_pba_off;
> >  } XHCIPciState;
> >
> >  #endif
> > diff --git a/hw/usb/hcd-xhci-nec.c b/hw/usb/hcd-xhci-nec.c
> > index 0e61c6c4f06..6ac1dc7764c 100644
> > --- a/hw/usb/hcd-xhci-nec.c
> > +++ b/hw/usb/hcd-xhci-nec.c
> > @@ -52,6 +52,16 @@ static void nec_xhci_instance_init(Object *obj)
> >
> >      pci->xhci.numintrs =3D nec->intrs;
> >      pci->xhci.numslots =3D nec->slots;
> > +
> > +    pci->cache_line_size =3D 0x10;
> > +    pci->pm_cap_off =3D 0;
> > +    pci->pcie_cap_off =3D 0xa0;
> > +    pci->msi_cap_off =3D 0x70;
> > +    pci->msix_cap_off =3D 0x90;
> > +    pci->msix_bar_nr =3D 0;
> > +    pci->msix_bar_size =3D 0;
> > +    pci->msix_table_off =3D 0x3000;
> > +    pci->msix_pba_off =3D 0x3800;
> >  }
>
>
> What about the "qemu-xhci" device, does that need similar treatment? I
> suspect it does at least for a bunch of these settings. Perhaps
> xhci_instance_init() in the abstract "pci-xhci" base might be a better
> place for these "sensible defaults" and then override them only in the
> specific implementations that need to do so, such as the new TI model?
> And/or have suitably named helper init function for configuring single-BA=
R
> PCI XHCI controllers so we can get some meaning behind all these magic
> numbers?

No you're right, I missed this entirely and the qemu-xhci dev is
indeed broken after this patch. Just moving it into the parent
instance init gets it to work.

> >  static void nec_xhci_class_init(ObjectClass *klass, void *data)
> > diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
> > index a039f5778a6..948d75b7379 100644
> > --- a/hw/usb/hcd-xhci-pci.c
> > +++ b/hw/usb/hcd-xhci-pci.c
> > @@ -32,8 +32,9 @@
> >  #include "trace.h"
> >  #include "qapi/error.h"
> >
> > -#define OFF_MSIX_TABLE  0x3000
> > -#define OFF_MSIX_PBA    0x3800
> > +#define MSIX_BAR_SIZE   0x800000
> >
>
> MSIX_BAR_SIZE doesn't seem to be used anywhere, and patch 2/2 uses 0x8000=
00
> explicitly. (8 MiB also seems=E2=80=A6 huge? But I'm guessing you're matc=
hing this
> with the physical TI controller hardware - either way I don't think it
> belongs in this file.)
>
>
> > +#define OFF_MSIX_TABLE  0x0000
> > +#define OFF_MSIX_PBA    0x1000
> >
>
> Maybe instead of redefining these constants to only apply to the split BA=
R
> device variants, there should be 2 variants of them, one for single-BAR
> controllers, and one for controllers with separate BARs. That would also
> help make sense of the "magic numbers" in nec_xhci_instance_init().

You're right on both counts, I tidied these up.

> >  static void xhci_pci_intr_update(XHCIState *xhci, int n, bool enable)
> >  {
> > @@ -104,6 +105,31 @@ static int xhci_pci_vmstate_post_load(void *opaque=
,
> > int version_id)
> >     return 0;
> >  }
> >
> > +static int xhci_pci_add_pm_capability(PCIDevice *pci_dev, uint8_t offs=
et,
> > +                                      Error **errp)
> > +{
> > +    int err;
> > +
> > +    err =3D pci_add_capability(pci_dev, PCI_CAP_ID_PM, offset,
> > +                             PCI_PM_SIZEOF, errp);
> > +    if (err < 0) {
> > +        return err;
> > +    }
> > +
> > +    pci_set_word(pci_dev->config + offset + PCI_PM_PMC,
> > +                 PCI_PM_CAP_VER_1_2 |
> > +                 PCI_PM_CAP_D1 | PCI_PM_CAP_D2 |
> > +                 PCI_PM_CAP_PME_D0 | PCI_PM_CAP_PME_D1 |
> > +                 PCI_PM_CAP_PME_D2 | PCI_PM_CAP_PME_D3hot);
> > +    pci_set_word(pci_dev->wmask + offset + PCI_PM_PMC, 0);
> > +    pci_set_word(pci_dev->config + offset + PCI_PM_CTRL,
> > +                 PCI_PM_CTRL_NO_SOFT_RESET);
> > +    pci_set_word(pci_dev->wmask + offset + PCI_PM_CTRL,
> > +                 PCI_PM_CTRL_STATE_MASK);
> > +
> > +    return 0;
> > +}
> > +
> >  static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
> >  {
> >      int ret;
> > @@ -112,7 +138,7 @@ static void usb_xhci_pci_realize(struct PCIDevice
> > *dev, Error **errp)
> >
> >      dev->config[PCI_CLASS_PROG] =3D 0x30;    /* xHCI */
> >      dev->config[PCI_INTERRUPT_PIN] =3D 0x01; /* interrupt pin 1 */
> > -    dev->config[PCI_CACHE_LINE_SIZE] =3D 0x10;
> > +    dev->config[PCI_CACHE_LINE_SIZE] =3D s->cache_line_size;
> >      dev->config[0x60] =3D 0x30; /* release number */
> >
> >      object_property_set_link(OBJECT(&s->xhci), "host", OBJECT(s), NULL=
);
> > @@ -125,8 +151,16 @@ static void usb_xhci_pci_realize(struct PCIDevice
> > *dev, Error **errp)
> >          s->xhci.nec_quirks =3D true;
> >      }
> >
> > +    if (s->pm_cap_off) {
> > +        if (xhci_pci_add_pm_capability(dev, s->pm_cap_off, &err)) {
> > +            error_propagate(errp, err);
> > +            return;
> >
>
> Can't we just pass errp straight to xhci_pci_add_pm_capability and skip t=
he
> error_propagate() here?

Yes I think so.

> > +        }
> > +    }
> > +
> >      if (s->msi !=3D ON_OFF_AUTO_OFF) {
> > -        ret =3D msi_init(dev, 0x70, s->xhci.numintrs, true, false, &er=
r);
> > +        ret =3D msi_init(dev, s->msi_cap_off, s->xhci.numintrs,
> > +                       true, false, &err);
> >          /*
> >           * Any error other than -ENOTSUP(board's MSI support is broken=
)
> >           * is a programming error
> > @@ -143,22 +177,37 @@ static void usb_xhci_pci_realize(struct PCIDevice
> > *dev, Error **errp)
> >          /* With msi=3Dauto, we fall back to MSI off silently */
> >          error_free(err);
> >      }
> > +
> >      pci_register_bar(dev, 0,
> >                       PCI_BASE_ADDRESS_SPACE_MEMORY |
> >                       PCI_BASE_ADDRESS_MEM_TYPE_64,
> >                       &s->xhci.mem);
> >
> >      if (pci_bus_is_express(pci_get_bus(dev))) {
> > -        ret =3D pcie_endpoint_cap_init(dev, 0xa0);
> > +        ret =3D pcie_endpoint_cap_init(dev, s->pcie_cap_off);
> >          assert(ret > 0);
> >      }
> >
> >      if (s->msix !=3D ON_OFF_AUTO_OFF) {
> > -        /* TODO check for errors, and should fail when msix=3Don */
> > -        msix_init(dev, s->xhci.numintrs,
> > -                  &s->xhci.mem, 0, OFF_MSIX_TABLE,
> > -                  &s->xhci.mem, 0, OFF_MSIX_PBA,
> > -                  0x90, NULL);
> > +        MemoryRegion *msix_bar =3D &s->xhci.mem;
> > +        if (s->msix_bar_nr !=3D 0) {
> > +            memory_region_init(&dev->msix_exclusive_bar, OBJECT(dev),
> > +                               "xhci-msix", s->msix_bar_size);
> > +            msix_bar =3D &dev->msix_exclusive_bar;
> > +        }
> > +
> > +        ret =3D msix_init(dev, s->xhci.numintrs,
> > +                        msix_bar, s->msix_bar_nr, s->msix_table_off,
> > +                        msix_bar, s->msix_bar_nr, s->msix_pba_off,
> > +                        s->msix_cap_off, errp);
> > +        if (ret) {
> > +            return;
> > +        }
> >
>
> Surely we should only propagate the error and fail realize() iff s->msix =
is
> ON_OFF_AUTO_ON?
>
> For ON_OFF_AUTO_AUTO, msix_init returning failure isn't a critical error.

Yep you're right... you had been testing with msix disabled. I wonder if
there is a good way to force fail this in qtests?

> > +
> > +        pci_register_bar(dev, s->msix_bar_nr,
> > +                         PCI_BASE_ADDRESS_SPACE_MEMORY |
> > +                         PCI_BASE_ADDRESS_MEM_TYPE_64,
> > +                         msix_bar);
> >
>
> Is it safe to call pci_register_bar() again for the msix_bar_nr =3D 0 cas=
e?
> Even if it is safe, is it sensible? If we're calling it twice for the sam=
e
> BAR, and the arguments of either of the calls changes in future, the othe=
r
> needs to change too. Doesn't seem ideal.

Good catch. It looks like it "works" so long as the bar wasn't mapped,
but I'm sure bad practice... Interesting there is no assertion in
there though. I'll fix it though.

Thanks,
Nick

