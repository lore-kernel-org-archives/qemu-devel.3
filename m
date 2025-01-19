Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7012C02187
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 10:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZSb0-0001RS-My; Sun, 19 Jan 2025 05:31:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tZSax-0001Qy-3T
 for qemu-devel@nongnu.org; Sun, 19 Jan 2025 05:31:55 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tZSav-00059b-0Y
 for qemu-devel@nongnu.org; Sun, 19 Jan 2025 05:31:54 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ef760a1001so6209909a91.0
 for <qemu-devel@nongnu.org>; Sun, 19 Jan 2025 02:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1737282710; x=1737887510;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5XTpaXk3VlJ+uMlaRsd48ES4kruZxPpmVaOOCy9/2g8=;
 b=0K1HYiAkkrzghHp8GkqIfAQi3qhMKd/nXEnsu5i5vO32LPEMHANDdvYH/6u9rTIRVa
 TcS7kYMsyuN+8nkSanfZRPAX31NGQFS4CDXc7yPq4I/PXkOwnCpWOLst2tETE+kMU+6G
 TjGPOhuEAc5e1P8jw04pOBxJI1HEQh9GB3qVnRmxT7RImnOG1+tX5EEAaht78D2gQQx/
 c7oZPIQlvhhKDa38bBx1Sv6KIaZsTEgIs3KB783ysZDj/WRreiwuXB+POIspUyPP0GHG
 HBfmlL226ttNR7TLTao7M5LiIy+ZEFrKi8KlKyFFpW1OLR/7Jfp/BeJDRMW+0HXN2ZZa
 DfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737282710; x=1737887510;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5XTpaXk3VlJ+uMlaRsd48ES4kruZxPpmVaOOCy9/2g8=;
 b=D9HzKZB1blg928mh41GvSB+9awwWz9/T/6ByOjLAlgtNJT5POctbjouaAwqSz0po0b
 0YOeMSFMorDsiLy8XSk2J6fgdJJI+g3xSULVHnkJLmpwv6qxX0UDUXgDjWzBqtj3V6lS
 LSEbO+sA3wwpSC3WrTWj3tisEtxFQW3KKyHQtbyg8Bxj2U43Fd2xSBZmKIt2tHOJBcq+
 VekEG1so7ElaA/Fb6mTRU2VUSzDrH0SFjKldxWc6+yxudaMY6c7pLP3IHVVcosTJ9BPt
 JvAgOcFr5+Ei3+nSQgp5Xsl9HvkFwDiSLRBneIoagf/I6fckBtVaquK6VsNnqozDwLnO
 Muig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaopZf5EOvQzQ3L9k/Z4ljlGLcMWLRrK9/lxAj6JG+xJAgVT4yz3PMQXcFRJbyq7yjqTcHpYJepncq@nongnu.org
X-Gm-Message-State: AOJu0YwqkA28E88kOkFRm7aor2HoLE0IecQUAy5PMprpzfnokXG0fRIt
 trT1SVXY1GT2Hkc0ihSwQacVE4KBquFWCx/ccPvRHH/aaVA58B8M5D7uLM2JrdySdUny84FsvhT
 hIA/W59dmanlV4j0C2MFDTxtdvunD+W9gteCt
X-Gm-Gg: ASbGncsaQug6w763UCfsfV23PcT0hFDXPUQgJfOIMZKwrJXP5Se0BwyeVX1qYCXBDqh
 5QHczX+nj0WKetAwKXISwOmXEWL2gB9VPE5T5RWQxuFzXYq74zOg=
X-Google-Smtp-Source: AGHT+IF6nZ7PaJLYBWqrOfHC+EjBxHZXTipN9ENh/Fnl8ciV3GpkNGrNAgYuPVIHVAovbEQXYZaUujrBIu0GCaJdWQs=
X-Received: by 2002:a17:90b:5201:b0:2ee:d797:40a4 with SMTP id
 98e67ed59e1d1-2f782c70204mr13301475a91.8.1737282709763; Sun, 19 Jan 2025
 02:31:49 -0800 (PST)
MIME-Version: 1.0
References: <20250117172842.406338-1-npiggin@gmail.com>
 <20250117172842.406338-2-npiggin@gmail.com>
In-Reply-To: <20250117172842.406338-2-npiggin@gmail.com>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Sun, 19 Jan 2025 11:31:38 +0100
X-Gm-Features: AbW1kvaoBwtzRKFKaL_mpUCsoKKo8TuJh3glDWVfGAh9cPRix32R2mWWsBXOpu8
Message-ID: <CAGCz3vvua=tX9mFAYr8ATFbRNp4BMb2fvzeh4XWs84wmANmVqg@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/pci/msix: Warn on PBA writes
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Content-Type: multipart/alternative; boundary="000000000000ca592a062c0ca622"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::1035;
 envelope-from=lists@philjordan.eu; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--000000000000ca592a062c0ca622
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Jan 2025 at 18:29, Nicholas Piggin <npiggin@gmail.com> wrote:

> Of the MSI-X PBA pending bits, the PCI Local Bus Specification says:
>
>   Software should never write, and should only read
>   Pending Bits. If software writes to Pending Bits, the
>   result is undefined.
>
> Log a GUEST_ERROR message if the PBA is written to by software.
>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>

Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>


> ---
>  hw/pci/msix.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/hw/pci/msix.c b/hw/pci/msix.c
> index 57ec7084a47..66f27b9d712 100644
> --- a/hw/pci/msix.c
> +++ b/hw/pci/msix.c
> @@ -15,6 +15,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/log.h"
>  #include "hw/pci/msi.h"
>  #include "hw/pci/msix.h"
>  #include "hw/pci/pci.h"
> @@ -260,6 +261,14 @@ static uint64_t msix_pba_mmio_read(void *opaque,
> hwaddr addr,
>  static void msix_pba_mmio_write(void *opaque, hwaddr addr,
>                                  uint64_t val, unsigned size)
>  {
> +    PCIDevice *dev = opaque;
> +
> +    qemu_log_mask(LOG_GUEST_ERROR,
> +                  "PCI [%s:%02x:%02x.%x] attempt to write to MSI-X "
> +                  "PBA at 0x%" FMT_PCIBUS ", ignoring.\n",
> +                  pci_root_bus_path(dev), pci_dev_bus_num(dev),
> +                  PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn),
> +                  addr);
>  }
>
>  static const MemoryRegionOps msix_pba_mmio_ops = {
> --
> 2.45.2
>
>
>

--000000000000ca592a062c0ca622
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 17 Jan =
2025 at 18:29, Nicholas Piggin &lt;<a href=3D"mailto:npiggin@gmail.com">npi=
ggin@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">Of the MSI-X PBA pending bits, the PCI Local Bus Specificatio=
n says:<br>
<br>
=C2=A0 Software should never write, and should only read<br>
=C2=A0 Pending Bits. If software writes to Pending Bits, the<br>
=C2=A0 result is undefined.<br>
<br>
Log a GUEST_ERROR message if the PBA is written to by software.<br>
<br>
Cc: Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com" target=3D"_bla=
nk">mst@redhat.com</a>&gt;<br>
Cc: Marcel Apfelbaum &lt;<a href=3D"mailto:marcel.apfelbaum@gmail.com" targ=
et=3D"_blank">marcel.apfelbaum@gmail.com</a>&gt;<br>
Cc: Dmitry Fleytman &lt;<a href=3D"mailto:dmitry.fleytman@gmail.com" target=
=3D"_blank">dmitry.fleytman@gmail.com</a>&gt;<br>
Cc: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com" target=3D=
"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
Cc: Sriram Yagnaraman &lt;<a href=3D"mailto:sriram.yagnaraman@ericsson.com"=
 target=3D"_blank">sriram.yagnaraman@ericsson.com</a>&gt;<br>
Signed-off-by: Nicholas Piggin &lt;<a href=3D"mailto:npiggin@gmail.com" tar=
get=3D"_blank">npiggin@gmail.com</a>&gt;<br></blockquote><div><br></div><di=
v>Reviewed-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjordan.eu"=
>phil@philjordan.eu</a>&gt;<br></div><div>=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
---<br>
=C2=A0hw/pci/msix.c | 9 +++++++++<br>
=C2=A01 file changed, 9 insertions(+)<br>
<br>
diff --git a/hw/pci/msix.c b/hw/pci/msix.c<br>
index 57ec7084a47..66f27b9d712 100644<br>
--- a/hw/pci/msix.c<br>
+++ b/hw/pci/msix.c<br>
@@ -15,6 +15,7 @@<br>
=C2=A0 */<br>
<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qemu/log.h&quot;<br>
=C2=A0#include &quot;hw/pci/msi.h&quot;<br>
=C2=A0#include &quot;hw/pci/msix.h&quot;<br>
=C2=A0#include &quot;hw/pci/pci.h&quot;<br>
@@ -260,6 +261,14 @@ static uint64_t msix_pba_mmio_read(void *opaque, hwadd=
r addr,<br>
=C2=A0static void msix_pba_mmio_write(void *opaque, hwaddr addr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t val, unsigned size)<b=
r>
=C2=A0{<br>
+=C2=A0 =C2=A0 PCIDevice *dev =3D opaque;<br>
+<br>
+=C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;PCI [=
%s:%02x:%02x.%x] attempt to write to MSI-X &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;PBA a=
t 0x%&quot; FMT_PCIBUS &quot;, ignoring.\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_root_bu=
s_path(dev), pci_dev_bus_num(dev),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PCI_SLOT(de=
v-&gt;devfn), PCI_FUNC(dev-&gt;devfn),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 addr);<br>
=C2=A0}<br>
<br>
=C2=A0static const MemoryRegionOps msix_pba_mmio_ops =3D {<br>
-- <br>
2.45.2<br>
<br>
<br>
</blockquote></div></div>

--000000000000ca592a062c0ca622--

