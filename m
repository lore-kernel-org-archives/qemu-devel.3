Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B420CCAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 02:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4VAC-0006JP-U5; Thu, 02 Oct 2025 22:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4VAA-0006In-2z
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 22:04:50 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4V9w-0001Ti-F6
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 22:04:49 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b3e25a4bfd5so340080966b.2
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 19:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759457069; x=1760061869; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V4oKwqxfaEilkxgKpZbJ1y81v5W0TQbg3JMnLHp4CxM=;
 b=Hb9+1JujXUDb7TWj4ESOvd585w9ngNCdPXaM1qhO3lRz08Pi5KvhOZXn4fkavKMrbw
 TS2LgURcuJI6iLdP/XiS71KOurm/KRL9UTYSp7Xhxl4InuoR0wchLSrsTqPDowBLMeNi
 YtsPWC18K3E/CpzXqpigY607lfLrUnWCRI1a/+iwEfgh/zA/OLK0v51M4XJ3mY8a+w+r
 ekgDzpcU5rpkWj40CJj8cR0KGXYxasaNxASjuVD4VN0o3vS+WJx16iH8BBJ8C5T4+cKk
 m4NdMaI7O32VrcULSxR5s2MQyYit725GtE/u32z24XdWO4WPAMhwu3g0TTR5cKUZax7i
 uVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759457069; x=1760061869;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V4oKwqxfaEilkxgKpZbJ1y81v5W0TQbg3JMnLHp4CxM=;
 b=m3Bvsp5vuichAjsd0ZO3mcoPFBJDQviwL0NqdasUqDSD11lmHAsuetCCpGEAZ3J7J+
 H6hz0k40KfUXrTra93eMerFE2XvPQYAePmnSRs8b5ZqMjY2oiLcXeHsCcxX6VvO0xoku
 cnS+fZr2C/6xKI5BRzti24oW00pFuNu+BCszk0f2UDiyVXClcozoYmZaDpCl2a0g3fLk
 7S5kGevCbKkaG01ofT6aUkcyKHEjvVbrPSJY4Mm/ivlOB2pBAlQIaLM/CwRXnZRHsBem
 wJDta8ifwJDe8L8z4G0+Ja4YssWjYu/nAOmN7wdDwnWSg/NXp+4mqYUtWR9bd5hJ97pi
 StrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSqadA+HG5hWVBX634VO7AmvPb5Yv7+M/5lVSE3tP5yn7B4syXdKz7yB9qRKqe4sLGWnBj+S7DQVx/@nongnu.org
X-Gm-Message-State: AOJu0Yw4TIsk5fBlukWMKXHHvx1YkxIfxpIXbWAC+IMVf56zjQ7dYaiv
 IC39VPicdbntNxf+Uy5We0jAICEGFsBitud+oS/HylER6DOZn6WwPyxRa3eeqpFH4eMX8CtrnsI
 htK149exL3XubEymaeiqoBwakdmXJX4I=
X-Gm-Gg: ASbGncuJywVjZx1gDJS8FIDvfK8tlsgyth8YJ11EOxGX4iDJzSf5zLRUFbXfqlNbruA
 mwbr71H8N1vCehkoRSk3OZPkiJh7c9TD0J6Ktme6ZlP4ZqrBjYqSsR4088b8WcUdqth1GkT8MgJ
 L5bYBYihDbInlt7QwJtFz60apGR2JuX05sFy0I6nlO+d75rA4LfreT0ofYETHurosXHdDznWbPi
 TVd/XzMwbD0SLJ+mKx9DuhD98N1oXAwkDATBHewY3GEvOIgP2AWLWBUEQaIUurQWZ5qpTzl
X-Google-Smtp-Source: AGHT+IHthrXtDGcIlr31Iu49tAghIP2+6wYKPflpZIWPwmVkygEaZqrpoSl8C6GATGa0r8jbe4rxh5PpBCtMjWgi9O4=
X-Received: by 2002:a17:907:9692:b0:b45:a84e:8b88 with SMTP id
 a640c23a62f3a-b49c4498b98mr141408266b.58.1759457069049; Thu, 02 Oct 2025
 19:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250912021152.46556-1-wilfred.opensource@gmail.com>
 <20250912021152.46556-6-wilfred.opensource@gmail.com>
In-Reply-To: <20250912021152.46556-6-wilfred.opensource@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 3 Oct 2025 12:04:02 +1000
X-Gm-Features: AS18NWD6xQaLW1HTRGmR9taUyGlIW23TB0qXDjD5EuiMIcbToeFI5F4vrVveyG0
Message-ID: <CAKmqyKOBjWT984RPJFnyDKHLnPgtmQ6WZfoT8tt=ZHfbo-wodA@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] hw/nvme: connect SPDM over NVMe Security Send/Recv
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org, 
 qemu-block@nongnu.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Wilfred Mallawa <wilfred.mallawa@wdc.com>, Klaus Jensen <k.jensen@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Fri, Sep 12, 2025 at 12:13=E2=80=AFPM Wilfred Mallawa
<wilfred.opensource@gmail.com> wrote:
>
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
>
> This patch extends the existing support we have for NVMe with only DoE
> to also add support to SPDM over the NVMe Security Send/Recv commands.
>
> With the new definition of the `spdm-trans` argument, users can specify
> `spdm_trans=3Dnvme` or `spdm_trans=3Ddoe`. This allows us to select the S=
PDM
> transport respectively. SPDM over the NVMe Security Send/Recv commands
> are defined in the DMTF DSP0286.
>
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  docs/specs/spdm.rst         | 10 +++++++--
>  hw/nvme/ctrl.c              | 45 ++++++++++++++++++++++++++++---------
>  include/hw/pci/pci_device.h |  2 ++
>  3 files changed, 44 insertions(+), 13 deletions(-)
>
> diff --git a/docs/specs/spdm.rst b/docs/specs/spdm.rst
> index f7de080ff0..dd6cfbbd68 100644
> --- a/docs/specs/spdm.rst
> +++ b/docs/specs/spdm.rst
> @@ -98,7 +98,7 @@ Then you can add this to your QEMU command line:
>  .. code-block:: shell
>
>      -drive file=3Dblknvme,if=3Dnone,id=3Dmynvme,format=3Draw \
> -        -device nvme,drive=3Dmynvme,serial=3Ddeadbeef,spdm_port=3D2323
> +        -device nvme,drive=3Dmynvme,serial=3Ddeadbeef,spdm_port=3D2323,s=
pdm_trans=3Ddoe
>
>  At which point QEMU will try to connect to the SPDM server.
>
> @@ -113,7 +113,13 @@ of the default. So the entire QEMU command might loo=
k like this
>          -append "root=3D/dev/vda console=3DttyS0" \
>          -net none -nographic \
>          -drive file=3Dblknvme,if=3Dnone,id=3Dmynvme,format=3Draw \
> -        -device nvme,drive=3Dmynvme,serial=3Ddeadbeef,spdm_port=3D2323
> +        -device nvme,drive=3Dmynvme,serial=3Ddeadbeef,spdm_port=3D2323,s=
pdm_trans=3Ddoe
> +
> +The `spdm_trans` argument defines the underlying transport type that is =
emulated
> +by QEMU. For an PCIe NVMe controller, both "doe" and "nvme" are supporte=
d. Where,
> +"doe" does SPDM transport over the PCIe extended capability Data Object =
Exchange
> +(DOE), and "nvme" uses the NVMe Admin Security Send/Receive commands to
> +implement the SPDM transport.
>
>  .. _DMTF:
>     https://www.dmtf.org/standards/SPDM
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index ad52e8f569..7928e9b0a9 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -8947,19 +8947,31 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice =
*pci_dev, Error **errp)
>
>      pcie_cap_deverr_init(pci_dev);
>
> -    /* DOE Initialisation */
> +    /* SPDM Initialisation */
>      if (pci_dev->spdm_port) {
> -        uint16_t doe_offset =3D n->params.sriov_max_vfs ?
> -                                  PCI_CONFIG_SPACE_SIZE + PCI_ARI_SIZEOF
> -                                  : PCI_CONFIG_SPACE_SIZE;
> +        switch  (pci_dev->spdm_trans) {
> +        case SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE:
> +            uint16_t doe_offset =3D n->params.sriov_max_vfs ?
> +                                    PCI_CONFIG_SPACE_SIZE + PCI_ARI_SIZE=
OF
> +                                    : PCI_CONFIG_SPACE_SIZE;
>
> -        pcie_doe_init(pci_dev, &pci_dev->doe_spdm, doe_offset,
> -                      doe_spdm_prot, true, 0);
> +            pcie_doe_init(pci_dev, &pci_dev->doe_spdm, doe_offset,
> +                          doe_spdm_prot, true, 0);
>
> -        pci_dev->doe_spdm.spdm_socket =3D spdm_socket_connect(pci_dev->s=
pdm_port,
> -                                                            errp);
> +            pci_dev->doe_spdm.spdm_socket =3D
> +                spdm_socket_connect(pci_dev->spdm_port, errp);
>
> -        if (pci_dev->doe_spdm.spdm_socket < 0) {
> +            if (pci_dev->doe_spdm.spdm_socket < 0) {
> +                return false;
> +            }
> +            break;
> +        case SPDM_SOCKET_TRANSPORT_TYPE_NVME:
> +            n->spdm_socket =3D spdm_socket_connect(pci_dev->spdm_port, e=
rrp);
> +            if (n->spdm_socket < 0) {
> +                return false;
> +            }
> +            break;
> +        default:
>              return false;
>          }
>      }
> @@ -9250,9 +9262,14 @@ static void nvme_exit(PCIDevice *pci_dev)
>          g_free(n->cmb.buf);
>      }
>
> +    /* Only one of the `spdm_socket`s below should have been setup */
> +    assert(!(pci_dev->doe_spdm.spdm_socket > 0 && n->spdm_socket >=3D 0)=
);
>      if (pci_dev->doe_spdm.spdm_socket > 0) {
>          spdm_socket_close(pci_dev->doe_spdm.spdm_socket,
>                            SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE);
> +    } else if (n->spdm_socket >=3D 0) {
> +        spdm_socket_close(pci_dev->doe_spdm.spdm_socket,
> +                          SPDM_SOCKET_TRANSPORT_TYPE_NVME);
>      }
>
>      if (n->pmr.dev) {
> @@ -9307,6 +9324,8 @@ static const Property nvme_props[] =3D {
>                       false),
>      DEFINE_PROP_UINT16("mqes", NvmeCtrl, params.mqes, 0x7ff),
>      DEFINE_PROP_UINT16("spdm_port", PCIDevice, spdm_port, 0),
> +    DEFINE_PROP_SPDM_TRANS("spdm_trans", PCIDevice, spdm_trans,
> +                           SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE),
>      DEFINE_PROP_BOOL("ctratt.mem", NvmeCtrl, params.ctratt.mem, false),
>      DEFINE_PROP_BOOL("atomic.dn", NvmeCtrl, params.atomic_dn, 0),
>      DEFINE_PROP_UINT16("atomic.awun", NvmeCtrl, params.atomic_awun, 0),
> @@ -9382,7 +9401,9 @@ static void nvme_pci_write_config(PCIDevice *dev, u=
int32_t address,
>  {
>      uint16_t old_num_vfs =3D pcie_sriov_num_vfs(dev);
>
> -    if (pcie_find_capability(dev, PCI_EXT_CAP_ID_DOE)) {
> +    /* DOE is only initialised if SPDM over DOE is used */
> +    if (pcie_find_capability(dev, PCI_EXT_CAP_ID_DOE) &&
> +        dev->spdm_trans =3D=3D SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE) {
>          pcie_doe_write_config(&dev->doe_spdm, address, val, len);
>      }
>      pci_default_write_config(dev, address, val, len);
> @@ -9393,7 +9414,9 @@ static void nvme_pci_write_config(PCIDevice *dev, u=
int32_t address,
>  static uint32_t nvme_pci_read_config(PCIDevice *dev, uint32_t address, i=
nt len)
>  {
>      uint32_t val;
> -    if (dev->spdm_port && pcie_find_capability(dev, PCI_EXT_CAP_ID_DOE))=
 {
> +
> +    if (dev->spdm_port && pcie_find_capability(dev, PCI_EXT_CAP_ID_DOE) =
&&
> +        (dev->spdm_trans =3D=3D SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE)) {
>          if (pcie_doe_read_config(&dev->doe_spdm, address, len, &val)) {
>              return val;
>          }
> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
> index eee0338568..88ccea5011 100644
> --- a/include/hw/pci/pci_device.h
> +++ b/include/hw/pci/pci_device.h
> @@ -4,6 +4,7 @@
>  #include "hw/pci/pci.h"
>  #include "hw/pci/pcie.h"
>  #include "hw/pci/pcie_doe.h"
> +#include "system/spdm-socket.h"
>
>  #define TYPE_PCI_DEVICE "pci-device"
>  typedef struct PCIDeviceClass PCIDeviceClass;
> @@ -166,6 +167,7 @@ struct PCIDevice {
>
>      /* SPDM */
>      uint16_t spdm_port;
> +    SpdmTransportType spdm_trans;
>
>      /* DOE */
>      DOECap doe_spdm;
> --
> 2.51.0
>
>

