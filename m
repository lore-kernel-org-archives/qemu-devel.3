Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBCE606D827
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 18:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BCN17gWO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOg6D-000798-Tv; Wed, 04 Nov 2026 13:52:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xOg5z-000781-PS; Wed, 04 Nov 2026 13:52:29 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xOg5x-0005s0-Pz; Wed, 04 Nov 2026 13:52:27 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7D7A0417BD;
 Wed,  4 Nov 2026 18:52:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025521F000C1;
 Wed,  4 Nov 2026 18:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793818342;
 bh=AsA9asnk5jKOwPfyG0vG3EnPK+LvPTClRNvLFFJgLuA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=BCN17gWOddA7OzJZJlvuJny4pFClmWzdc6HkM8k+hMRnHvWS5Hq3RHmXAmTbTRGUu
 Ty2NYALV42snIFuLq8zoHjuTJs3AJIfAXxe+Cer73y2wzC54MLR0q+fsYb89dFjzm2
 tfFw3CTqDFsIuVRUOPyDc+FSj0mpW0oupPE4sDymgUrWABnT3C6lqqagp/iOvCBuPv
 HHarYoA0wYdYPHRozzZ7WxfM24uW4RgHmnlAfn8z9W1tH4HnfKp1iNlfAf+veg66ji
 Akzq1dH2RPXZqjyCx9v3hDAqEk4ER6z6obUl9T3QsB3/Ozs1XF8eEMRSnsImVBtpl8
 4+q8eRBrBNpBg==
Date: Wed, 4 Nov 2026 18:52:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, John Snow
 <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 qemu-block@nongnu.org
Subject: Re: [PATCH 1/2] hw/pci: IDE, TEE support functions
Message-ID: <20261104185210.62ad2741@jic23-hlaptop>
In-Reply-To: <20261104-ich-driver-spdm-v1-1-60d361bc0417@linaro.org>
References: <20261104-ich-driver-spdm-v1-0-60d361bc0417@linaro.org>
 <20261104-ich-driver-spdm-v1-1-60d361bc0417@linaro.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=jic23@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 04 Nov 2026 16:34:35 +0000
Jim MacArthur <jim.macarthur@linaro.org> wrote:

> These were introduced in the PCIe Root registers patch series, but need t=
o be
> duplicated for the ICH9 driver patch.
>=20
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
>  hw/pci/pcie.c              | 15 +++++++++++++++
>  include/hw/pci/pcie.h      |  2 ++
>  include/hw/pci/pcie_regs.h |  4 ++++
>  3 files changed, 21 insertions(+)
>=20
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index bd00305ecc..7dfb0af801 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -1389,6 +1389,21 @@ uint32_t pcie_pri_get_req_alloc(const PCIDevice *d=
ev)
>      return pci_get_long(dev->config + dev->exp.pri_cap + PCI_PRI_ALLOC_R=
EQ);
>  }
> =20
> +/* IDE (Integrity & Data Encryption) */
> +void pcie_ide_init(PCIDevice *dev, uint16_t offset)
> +{
> +    pcie_add_capability(dev, PCI_EXT_CAP_ID_IDE, PCI_IDE_VER,
> +                        offset, PCI_IDE_SIZEOF);
> +    uint32_t cap =3D PCI_IDE_CAP_SELECTIVE;
I'd add a blank line here. Also that local variable for cap isn't adding any
value to my eyes.

   pci_set_byte(dev->config + offset + PCI_IDE_CAP, PCI_IDE_CAP_SELECTIVE);

This is very minimalist but seems otherwise valid - 1 stream =3Dm bi address
association register blocks etc given zeros in the various other capabiliti=
es.

I sort of feel like it would make sense to set those zeros explicitly here
just act as documentation but I guess that's not strictly required.


> +    pci_set_byte(dev->config + offset + PCI_IDE_CAP, cap);
> +}
> +
> +void pcie_cap_tee_init(PCIDevice *dev)
> +{
> +    pci_long_test_and_set_mask(dev->config + dev->exp.exp_cap + PCI_EXP_=
DEVCAP,
> +                               PCI_EXP_DEVCAP_TEE);
> +}
> +
>  bool pcie_pri_enabled(const PCIDevice *dev)
>  {
>      if (!pci_is_express(dev) || !dev->exp.pri_cap) {
> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> index ec25e7a7de..bdebbfffe9 100644
> --- a/include/hw/pci/pcie.h
> +++ b/include/hw/pci/pcie.h
> @@ -161,6 +161,8 @@ void pcie_pasid_init(PCIDevice *dev, uint16_t offset,=
 uint8_t pasid_width,
>                       bool exec_perm, bool priv_mod);
>  void pcie_pri_init(PCIDevice *dev, uint16_t offset, uint32_t outstanding=
_pr_cap,
>                     bool prg_response_pasid_req);
> +void pcie_ide_init(PCIDevice *dev, uint16_t offset);
> +void pcie_cap_tee_init(PCIDevice *dev);
> =20
>  uint32_t pcie_pri_get_req_alloc(const PCIDevice *dev);
>  bool pcie_pri_enabled(const PCIDevice *dev);
> diff --git a/include/hw/pci/pcie_regs.h b/include/hw/pci/pcie_regs.h
> index 33a22229fe..5f527abf35 100644
> --- a/include/hw/pci/pcie_regs.h
> +++ b/include/hw/pci/pcie_regs.h
> @@ -182,4 +182,8 @@ typedef enum PCIExpLinkWidth {
>  #define PCI_DOE_VER                     0x1
>  #define PCI_DOE_SIZEOF                  24
> =20
> +/* IDE Fields */
> +#define PCI_IDE_VER                     0x1
> +#define PCI_IDE_SIZEOF                  12

I'd add something on what options you are enabling for that
size given variable length nature of that structure.
=46rom a quick look at the spec this seems short given
CAP_SELECTIVE is set but maybe I can't count.
The spec is a little confusing wrt to the count field
being 0 means 1 is available vs the need for the
Selective IDE Stream Register block but I'm fairly sure
you need one of those after the fixed header chunk.



> +
>  #endif /* QEMU_PCIE_REGS_H */
>=20


