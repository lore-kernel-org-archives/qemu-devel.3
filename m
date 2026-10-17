Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A894ECCF2C7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 14:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI5WX-0001ki-8Z; Sat, 17 Oct 2026 10:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xI5WU-0001jP-Ep
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 10:36:34 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xI5WQ-0005MP-HF
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 10:36:33 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-483c607ccb4so557940fac.0
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 07:36:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792247784; cv=none;
 d=google.com; s=arc-20260327;
 b=EVoP4ROv7tstCnwXblrBVaTctalPfJFsbdWDYuCftn178doQqvu7B9pm0ifkhUH/bJ
 B8UvrYei0Fd1XZiMWDsC5nDPl9KNCyxAQVFkNHPXtKQrP1bCds5apHW6kBVq9VkpOHDZ
 8J45dWWMUxN49kn8EcMMQsZ0zoNpck60BFnlSlDcdiSMsrFrGqvPwa7xXCMzozGOHANk
 koeIGScEGqAXY2FbAEfnuYiN9YOgYp8StbJbk84KzTpTAybRxbW91iJQ749fIypywET1
 lisWA6tJgHmOLTeO331KUHywnmgbqR9bcCEUOJCEgaWAKGKhN+9dn9P1IL37W9vlrDY/
 zFqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=YFO6ezWk7P1yALE4X/Y4jAo8zNFKuEjjOKI0yWlF/Vk=;
 fh=V6IK3Cq6473wGvao6OZ85eoNutnpxZRYylx0nHL7+rQ=;
 b=d1v/whrv+n46ml873WXa0e0SmOWAD02Fm1WzZF3KHXVq6/KJIot6Ka4m/ZNYuJaMUN
 Aql/rM2PHo9EHFUWZ1c7DlxROCnO+cHWIJT/RKrSr2qIkuRjRf2Gw4CLPYL9B+sgU5Nd
 o9/zr4b4jpRyxMbNL0ef8Yaaeq4aAKlmcP8k/xZuWR5QoE5cr2leYgalZN6mWyqxtIu7
 p3TXAe1QJsyjSQyDZ0naOms8+fpDWsfHM234I7EQce08+6Gcu9+CDW0k0x+98u93GCgC
 57hRr8HxxWUstmTEdPYSa0cnLHc7zKH19RvT7nCwFUggROE0TjJsD2hCB1xSIlZVVccO
 e0kw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792247784; x=1792852584; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YFO6ezWk7P1yALE4X/Y4jAo8zNFKuEjjOKI0yWlF/Vk=;
 b=VzbvFfG62buq9RVLH6pSILOw6Gq/mpohY3xXFT5m7yPLRBasbEtp9H5b2PHV5hnCDC
 hPmuMVjqUmwlNPtmJexaRez+saL1vvyLca/+j6NSlIKKZ80LZXxtQ3wdrTkgbt05+tPY
 baYNHwI+/CxMBU0czsia5UziDeQgZVTg0nF/qMigQ4bKxT9CDXBfAo9oElDDFDzeZkeS
 HZqpk/bxoMvZMCx1UT7T/eO2QyhL63JS2IXunXAWjr81byRnf0i3MPenAcY3PH2Uugfq
 B6gEUCoroFNem2ErgZJzTF4CJbuoTK+5owbxeMbgIMOlNAuxRENTPd9lSpr0r4zgB9n9
 NLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792247784; x=1792852584;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YFO6ezWk7P1yALE4X/Y4jAo8zNFKuEjjOKI0yWlF/Vk=;
 b=Y6/slz1p2zZRjrnJvlBbzPid2uXvyVkO7sgFzkmMtIy5oGMoMFvXFVsBIbc1T1D3i+
 JFpwKLjo8Nle6pptR8fE5WUsCleprsIcw3gdTO/SWkUURmF2oSYNQTFWh/a+UooxaNAL
 A4M6yKMMmeFNuucnAl4Cg2LB1jPzshUQ8fqsDamAe/dPUtnTaxispXUH8qSCslCxPPzQ
 PDiNaPjbrduUkV/31kZcT7p7H6r/eg7qDvrnpCd95R1KAbFYOi107svPiYzp/36I5bMs
 HCa1Iv+iWSso13BBzK6lg9yCwK0SNJOr69hGq8mXwgsJZOHSOCLQKpRUm12EwmzH5KfM
 XNQQ==
X-Gm-Message-State: AFq9FYJA3iP/SIntBQKQStdPzlXF8jYD/RXumWWQokL6kHVgPT/4RoRZ
 9hDYQmdKF02XTWeD48PGVaSuxOuYi9RFsPMqhtaWYKbhBDruuTZUMVOQg0vVERdttQI1drbt3Sg
 U1kIgsVXI/cyPLKP8pWrOL1umYrpZkiM=
X-Gm-Gg: AYBFou0cQ+cbrDpDjeLui8h5P7cIGjpYknJDw/AXp1k9Hx+G3S/NKpBekFPp9wiTDLl
 xWIXfppUsxuWcB1eh9PPRu7KXujV21LT0YIugZAKoJDD0bPj02fBw2bXGgLFFt8MEPXrD9wyoHo
 MPwcsIXNIC+1oeAwN9/ljYRHCqt5+AJ6K6NgoddSOTPe8ShWg8lvSIasDmQWI+k69ykIKHo5e4H
 0gYTRi0QU54LRMsX2DKhc4H/iyx+yLCs4Y8dOA5m+f9Hsazt42b/WjWtOBPAlPMX2TMm2LKls9d
 8xoD5HVhZ4Z6J9VzqUPtE2czWLIfALsPUdzBmXCCtJ/hgafLLo0NXIC71mVt+yjLrokhdkSiytC
 HLeYOq0s34jKtbDyM2Ku09yuHgqaubvWet8/Wgq4=
X-Received: by 2002:a05:6870:ae06:b0:464:76c:297f with SMTP id
 586e51a60fabf-4a7579e447bmr2220257fac.9.1792247784532; Sat, 17 Oct 2026
 07:36:24 -0700 (PDT)
Received: from 101988054943 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 17 Oct 2026 07:36:24 -0700
Received: from 101988054943 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 17 Oct 2026 10:36:23 -0400
From: Marcelo Manzo <marcelomanzo@gmail.com>
In-Reply-To: <CAFEAcA9rc=7CYSeq1AL240WjO47=t_1OJDEnfD_FU0NkHKUM-g@mail.gmail.com>
References: <CAFEAcA9rc=7CYSeq1AL240WjO47=t_1OJDEnfD_FU0NkHKUM-g@mail.gmail.com>
MIME-Version: 1.0
Date: Sat, 17 Oct 2026 07:36:23 -0700
X-Gm-Features: AclHuK93kft5ix2Jw3EEonSlI8C-l1tHW0zL8vJnJVAk9byl9DEABkzxNWgGbUY
Message-ID: <CAGaQodKv9cwb9WaZYw14h=pQsvgrsUEAcH-4PmQXDTEkVwv46w@mail.gmail.com>
Subject: Re: Re: [PATCH v3 02/16] hw/arm/bcm2838_pcie: add BCM2838 PCIe host
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, philmd@oss.qualcomm.com, 
 eric.auger@redhat.com
Content-Type: multipart/alternative; boundary="0000000000008bf01e065e0a3460"
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=marcelomanzo@gmail.com; helo=mail-oa1-x2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000008bf01e065e0a3460
Content-Type: text/plain; charset="UTF-8"

On 17 Oct 2026, Peter Maydell wrote:
>
> I think these read and write functions have endianness issues.
> [...]
> You probably want to define that the regs[] array is bytes
> to be treated as little-endian order, and then use
> ldn_le_p()/stn_le_p() to write an arbitrary sized value into
> it

Agreed, thanks -- I'll do that in v4 (regs[] as little-endian bytes,
accessed with ldn_le_p()/stn_le_p(), and ldl_le_p() for the EXT_CFG_INDEX
value instead of the uint32_t * overlay).

> It's not clear to me if we need this -- most PCI controllers don't
> seem to call pci_bus_set_route_irq_fn(). I have a feeling this is
> only relevant for PCI passthrough. Eric, do you know ?

I had a look, and I think you're right. The only users of
pci_device_route_intx_to_irq() are VFIO, the x86 PIIX/Xen code and the
multi-process proxy. VFIO only calls it when KVM is active with irqfds
and resamplefds enabled; there is a comment in vfio_intx_enable() saying
it is conditional "to avoid generating error messages on platforms where
we won't actually use the result anyway".

raspi4b runs under TCG only, so none of those can apply. I copied this
from the original series (and gpex, which has it for VFIO under KVM)
without needing it.

I also tried it: with the hook, the irq_num[] storage and
bcm2838_pcie_host_set_irq_num() removed, a qemu-xhci with a usb-kbd on
the root port still enumerates and takes its INTx interrupts exactly as
before. So I'll drop it in v4.

Eric, shout if you know of a reason to keep it.

thanks
-- Marcelo

On Sat, Oct 17, 2026 09:07 AM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Thu, 15 Oct 2026 at 19:11, Marcelo Manzo <marcelomanzo@gmail.com>
> wrote:
> >
> > Add the BCM2838 PCIe host bridge model: config space, MMIO window,
> > and register access for the root port.
> >
> > Per Peter Maydell's review of a later follow-up series, fold in what
> > was originally a separate bugfix here, since this device isn't in
> > upstream git yet and the bug was in code this patch itself introduces.
> > Four defects fixed, all on the enumeration path (none of this was
> > exercised until a later patch actually attaches a PCI device):
> >
> > 1. bcm2838_pcie_host_read/write computed
> >    "offset - PCIE_CONFIG_SPACE_SIZE" on an unsigned hwaddr, which
> >    underflows for every offset below 4KB. The root port's own config
> >    space -- including vendor/device ID at offset 0 -- therefore always
> >    fell into the out-of-range branch and read back as all-ones, i.e.
> >    "no device present", so the guest stopped scanning immediately.
> >
> > 2. pcie_host_mmcfg_init() was never called, yet both accessors
> >    dereference pcie_hb->mmio.ops to service EXT_CFG_DATA. Once (1) was
> >    fixed and the guest actually reached that path, it touched an
> >    uninitialised MemoryRegion.
> >
> > 3. The root port overrode PCIDeviceClass::config_read/config_write with
> >    plain pci_default_*_config(). That bypasses rp_write_config() ->
> >    pci_bridge_write_config(), so programming the bridge's memory window
> >    never updated the bridge's address space and BARs behind the root
> >    port stayed unreachable. Drop the overrides and dispatch through
> >    pci_host_config_{read,write}_common() so the device's real handlers
> >    run.
> >
> > Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
>
> > +static uint64_t bcm2838_pcie_host_read(void *opaque, hwaddr offset,
> > +                                       unsigned size) {
> > +    hwaddr mmcfg_addr;
> > +    uint64_t value = ~0;
> > +    BCM2838PcieHostState *s = opaque;
> > +    PCIExpressHost *pcie_hb = PCIE_HOST_BRIDGE(s);
> > +    uint8_t *root_regs = s->root_port.regs;
> > +    uint32_t *cfg_idx = (uint32_t *)(root_regs +
> BCM2838_PCIE_EXT_CFG_INDEX
> > +                                     - PCIE_CONFIG_SPACE_SIZE);
>
> I think these read and write functions have endianness issues.
> In a read/write function the values are host-order, but we are
> updating the regs[] array by simple memcpy(), which means that
> on a big-endian host the guest will see the wrong thing if it
> writes as 32-bits and then reads back as 8-bits.
>
> You probably want to define that the regs[] array is bytes
> to be treated as little-endian order, and then use
> ldn_le_p()/stn_le_p() to write an arbitrary sized value into
> it, or lduw_le_p()/stw_le_p() for fixed-sized accesses, etc.
> (pci.h wraps the latter into pci_{set,get}_{word,long,...}
> accessors for this kind of "access config space" purpose, but
> has no equivalent wrapper of the ldn/stn fns for "N byte access".)
>
> > +
> > +    if (offset < PCIE_CONFIG_SPACE_SIZE) {
> > +        /*
> > +         * The first 4KB of the window is the root port's own PCI config
> > +         * space (vendor/device ID, BARs, capabilities). Serve it from
> the
> > +         * real PCIDevice, not from the raw regs[] shadow buffer, which
> is
> > +         * only backing store for the controller registers above 4KB.
> > +         */
> > +        value = pci_host_config_read_common(PCI_DEVICE(&s->root_port),
> > +                                            offset,
> PCIE_CONFIG_SPACE_SIZE,
> > +                                            size);
> > +    } else if (offset - PCIE_CONFIG_SPACE_SIZE + size
> > +               <= sizeof(s->root_port.regs)) {
> > +        switch (offset) {
> > +        case BCM2838_PCIE_EXT_CFG_DATA
> > +            ... BCM2838_PCIE_EXT_CFG_DATA + PCIE_CONFIG_SPACE_SIZE - 1:
> > +            mmcfg_addr = *cfg_idx
> > +                | PCIE_MMCFG_CONFOFFSET(offset -
> BCM2838_PCIE_EXT_CFG_DATA);
> > +            value = pcie_hb->mmio.ops->read(opaque, mmcfg_addr, size);
> > +            break;
> > +        default:
> > +            memcpy(&value, root_regs + offset - PCIE_CONFIG_SPACE_SIZE,
> size);
> > +        }
> > +    } else {
> > +        qemu_log_mask(
> > +            LOG_GUEST_ERROR,
> > +            "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64
> "\n",
> > +            __func__, size, offset);
> > +    }
> > +
> > +    trace_bcm2838_pcie_host_read(size, offset, value);
> > +    return value;
> > +}
>
> > +static PCIINTxRoute bcm2838_pcie_host_route_intx_pin_to_irq(void
> *opaque,
> > +                                                            int pin)
> > +{
> > +    PCIINTxRoute route;
> > +    BCM2838PcieHostState *s = opaque;
> > +
> > +    route.irq = s->irq_num[pin];
> > +    route.mode = route.irq < 0 ? PCI_INTX_DISABLED : PCI_INTX_ENABLED;
> > +
> > +    return route;
> > +}
>
> It's not clear to me if we need this -- most PCI controllers don't
> seem to call pci_bus_set_route_irq_fn(). I have a feeling this is
> only relevant for PCI passthrough. Eric, do you know ?
>
> thanks
> -- PMM
>

--0000000000008bf01e065e0a3460
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><body><div dir=3D"auto">On 17 Oct 2026, Peter Maydell wrote:<br>&gt;<=
br>&gt; I think these read and write functions have endianness issues.<br>&=
gt; [...]<br>&gt; You probably want to define that the regs[] array is byte=
s<br>&gt; to be treated as little-endian order, and then use<br>&gt; ldn_le=
_p()/stn_le_p() to write an arbitrary sized value into<br>&gt; it<br><br>Ag=
reed, thanks -- I&#39;ll do that in v4 (regs[] as little-endian bytes,<br>a=
ccessed with ldn_le_p()/stn_le_p(), and ldl_le_p() for the EXT_CFG_INDEX<br=
>value instead of the uint32_t * overlay).<br><br>&gt; It&#39;s not clear t=
o me if we need this -- most PCI controllers don&#39;t<br>&gt; seem to call=
 pci_bus_set_route_irq_fn(). I have a feeling this is<br>&gt; only relevant=
 for PCI passthrough. Eric, do you know ?<br><br>I had a look, and I think =
you&#39;re right. The only users of<br>pci_device_route_intx_to_irq() are V=
FIO, the x86 PIIX/Xen code and the<br>multi-process proxy. VFIO only calls =
it when KVM is active with irqfds<br>and resamplefds enabled; there is a co=
mment in vfio_intx_enable() saying<br>it is conditional &quot;to avoid gene=
rating error messages on platforms where<br>we won&#39;t actually use the r=
esult anyway&quot;.<br><br>raspi4b runs under TCG only, so none of those ca=
n apply. I copied this<br>from the original series (and gpex, which has it =
for VFIO under KVM)<br>without needing it.<br><br>I also tried it: with the=
 hook, the irq_num[] storage and<br>bcm2838_pcie_host_set_irq_num() removed=
, a qemu-xhci with a usb-kbd on<br>the root port still enumerates and takes=
 its INTx interrupts exactly as<br>before. So I&#39;ll drop it in v4.<br><b=
r>Eric, shout if you know of a reason to keep it.<br><br>thanks<br>-- Marce=
lo<br></div></body></html><br><div class=3D"gmail_extra"><div>On Sat, Oct 1=
7, 2026 09:07 AM, Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.=
org">peter.maydell@linaro.org</a>&gt; wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">On Thu, 15 Oct 2026 at 19:11, Marcelo Manzo &lt;<a href=3D"mailto:marce=
lomanzo@gmail.com" target=3D"_blank">marcelomanzo@gmail.com</a>&gt; wrote:<=
br>
&gt;<br>
&gt; Add the BCM2838 PCIe host bridge model: config space, MMIO window,<br>
&gt; and register access for the root port.<br>
&gt;<br>
&gt; Per Peter Maydell&#39;s review of a later follow-up series, fold in wh=
at<br>
&gt; was originally a separate bugfix here, since this device isn&#39;t in<=
br>
&gt; upstream git yet and the bug was in code this patch itself introduces.=
<br>
&gt; Four defects fixed, all on the enumeration path (none of this was<br>
&gt; exercised until a later patch actually attaches a PCI device):<br>
&gt;<br>
&gt; 1. bcm2838_pcie_host_read/write computed<br>
&gt;=C2=A0 =C2=A0 &quot;offset - PCIE_CONFIG_SPACE_SIZE&quot; on an unsigne=
d hwaddr, which<br>
&gt;=C2=A0 =C2=A0 underflows for every offset below 4KB. The root port&#39;=
s own config<br>
&gt;=C2=A0 =C2=A0 space -- including vendor/device ID at offset 0 -- theref=
ore always<br>
&gt;=C2=A0 =C2=A0 fell into the out-of-range branch and read back as all-on=
es, i.e.<br>
&gt;=C2=A0 =C2=A0 &quot;no device present&quot;, so the guest stopped scann=
ing immediately.<br>
&gt;<br>
&gt; 2. pcie_host_mmcfg_init() was never called, yet both accessors<br>
&gt;=C2=A0 =C2=A0 dereference pcie_hb-&gt;mmio.ops to service EXT_CFG_DATA.=
 Once (1) was<br>
&gt;=C2=A0 =C2=A0 fixed and the guest actually reached that path, it touche=
d an<br>
&gt;=C2=A0 =C2=A0 uninitialised MemoryRegion.<br>
&gt;<br>
&gt; 3. The root port overrode PCIDeviceClass::config_read/co<wbr>nfig_writ=
e with<br>
&gt;=C2=A0 =C2=A0 plain pci_default_*_config(). That bypasses rp_write_conf=
ig() -&gt;<br>
&gt;=C2=A0 =C2=A0 pci_bridge_write_config(), so programming the bridge&#39;=
s memory window<br>
&gt;=C2=A0 =C2=A0 never updated the bridge&#39;s address space and BARs beh=
ind the root<br>
&gt;=C2=A0 =C2=A0 port stayed unreachable. Drop the overrides and dispatch =
through<br>
&gt;=C2=A0 =C2=A0 pci_host_config_{read,write}_c<wbr>ommon() so the device&=
#39;s real handlers<br>
&gt;=C2=A0 =C2=A0 run.<br>
&gt;<br>
&gt; Signed-off-by: Marcelo Manzo &lt;<a href=3D"mailto:marcelomanzo@gmail.=
com" target=3D"_blank">marcelomanzo@gmail.com</a>&gt;<br>
<br>
&gt; +static uint64_t bcm2838_pcie_host_read(void *opaque, hwaddr offset,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsig=
ned size) {<br>
&gt; +=C2=A0 =C2=A0 hwaddr mmcfg_addr;<br>
&gt; +=C2=A0 =C2=A0 uint64_t value =3D ~0;<br>
&gt; +=C2=A0 =C2=A0 BCM2838PcieHostState *s =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 PCIExpressHost *pcie_hb =3D PCIE_HOST_BRIDGE(s);<br>
&gt; +=C2=A0 =C2=A0 uint8_t *root_regs =3D s-&gt;root_port.regs;<br>
&gt; +=C2=A0 =C2=A0 uint32_t *cfg_idx =3D (uint32_t *)(root_regs + BCM2838_=
PCIE_EXT_CFG_INDEX<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- PCIE_CONFI=
G_SPACE_SIZE);<br>
<br>
I think these read and write functions have endianness issues.<br>
In a read/write function the values are host-order, but we are<br>
updating the regs[] array by simple memcpy(), which means that<br>
on a big-endian host the guest will see the wrong thing if it<br>
writes as 32-bits and then reads back as 8-bits.<br>
<br>
You probably want to define that the regs[] array is bytes<br>
to be treated as little-endian order, and then use<br>
ldn_le_p()/stn_le_p() to write an arbitrary sized value into<br>
it, or lduw_le_p()/stw_le_p() for fixed-sized accesses, etc.<br>
(pci.h wraps the latter into pci_{set,get}_{word,long,...}<br>
accessors for this kind of &quot;access config space&quot; purpose, but<br>
has no equivalent wrapper of the ldn/stn fns for &quot;N byte access&quot;.=
)<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (offset &lt; PCIE_CONFIG_SPACE_SIZE) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* The first 4KB of the window is th=
e root port&#39;s own PCI config<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* space (vendor/device ID, BARs, ca=
pabilities). Serve it from the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* real PCIDevice, not from the raw =
regs[] shadow buffer, which is<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* only backing store for the contro=
ller registers above 4KB.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D pci_host_config_read_common(PC<=
wbr>I_DEVICE(&amp;s-&gt;root_port),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 offset, PCIE_CONFIG_SPACE_SIZE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 size);<br>
&gt; +=C2=A0 =C2=A0 } else if (offset - PCIE_CONFIG_SPACE_SIZE + size<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;=3D sizeof=
(s-&gt;root_port.regs)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (offset) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case BCM2838_PCIE_EXT_CFG_DATA<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ... BCM2838_PCIE_EXT_CFG_DA=
TA + PCIE_CONFIG_SPACE_SIZE - 1:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmcfg_addr =3D *cfg_idx<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | PCIE_MMCFG_=
CONFOFFSET(offset - BCM2838_PCIE_EXT_CFG_DATA);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D pcie_hb-&gt;mmio.=
ops-&gt;read(opaque<wbr>, mmcfg_addr, size);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(&amp;value, root_reg=
s + offset - PCIE_CONFIG_SPACE_SIZE, size);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LOG_GUEST_ERROR,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%s: out-of-range acce=
ss, %u bytes @ offset 0x%04&quot; PRIx64 &quot;\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__, size, offset);<br=
>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_bcm2838_pcie_host_read(s<wbr>ize, offset, value);=
<br>
&gt; +=C2=A0 =C2=A0 return value;<br>
&gt; +}<br>
<br>
&gt; +static PCIINTxRoute bcm2838_pcie_host_route_intx_p<wbr>in_to_irq(void=
 *opaque,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int pin)=
<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 PCIINTxRoute route;<br>
&gt; +=C2=A0 =C2=A0 BCM2838PcieHostState *s =3D opaque;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 route.irq =3D s-&gt;irq_num[pin];<br>
&gt; +=C2=A0 =C2=A0 route.mode =3D route.irq &lt; 0 ? PCI_INTX_DISABLED : P=
CI_INTX_ENABLED;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return route;<br>
&gt; +}<br>
<br>
It&#39;s not clear to me if we need this -- most PCI controllers don&#39;t<=
br>
seem to call pci_bus_set_route_irq_fn(). I have a feeling this is<br>
only relevant for PCI passthrough. Eric, do you know ?<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div></div>

--0000000000008bf01e065e0a3460--

