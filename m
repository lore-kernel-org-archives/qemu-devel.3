Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72942C5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 14:30:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcR7j-0000cS-Sp; Tue, 20 Feb 2024 09:29:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rcR7f-0000bj-T3
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 09:29:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rcR7c-0004fk-1a
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 09:29:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708439363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5RqHpBM+h2HguOuYYunao5yNA1SBuMoARyO0bqh0eRg=;
 b=VaGcZdnLptN+OC4E+bGHFFre+pUDrheH+ITLUpyFRW34LkqwKmlnaKU9rj7oFdTAgFBSSn
 TwiAPKR19A/Wr3jdL5R4CfDyxvyrjXdVKmG9XK6CGR6qYWPsKN5bWoJIY4JKuDIdgaNM3J
 Cu93b0hRpPwNKoXlTXTOzstpkxupBR8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-x82GJuN2OlGIlyXwEkrFlg-1; Tue,
 20 Feb 2024 09:29:17 -0500
X-MC-Unique: x82GJuN2OlGIlyXwEkrFlg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E81FD1C0DB04;
 Tue, 20 Feb 2024 14:29:16 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E99C2112A4;
 Tue, 20 Feb 2024 14:29:13 +0000 (UTC)
Date: Tue, 20 Feb 2024 15:29:12 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH v6 01/15] hw/nvme: Use pcie_sriov_num_vfs()
Message-ID: <ZdS3OI9vIu-jvJ37@redhat.com>
References: <20240220-reuse-v6-0-2e42a28b0cf2@daynix.com>
 <20240220-reuse-v6-1-2e42a28b0cf2@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220-reuse-v6-1-2e42a28b0cf2@daynix.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Am 20.02.2024 um 13:24 hat Akihiko Odaki geschrieben:
> nvme_sriov_pre_write_ctrl() used to directly inspect SR-IOV
> configurations to know the number of VFs being disabled due to SR-IOV
> configuration writes, but the logic was flawed and resulted in
> out-of-bound memory access.
> 
> It assumed PCI_SRIOV_NUM_VF always has the number of currently enabled
> VFs, but it actually doesn't in the following cases:
> - PCI_SRIOV_NUM_VF has been set but PCI_SRIOV_CTRL_VFE has never been.
> - PCI_SRIOV_NUM_VF was written after PCI_SRIOV_CTRL_VFE was set.
> - VFs were only partially enabled because of realization failure.
> 
> It is a responsibility of pcie_sriov to interpret SR-IOV configurations
> and pcie_sriov does it correctly, so use pcie_sriov_num_vfs(), which it
> provides, to get the number of enabled VFs before and after SR-IOV
> configuration writes.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: CVE-2024-26328
> Fixes: 11871f53ef8e ("hw/nvme: Add support for the Virtualization Management command")
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  hw/nvme/ctrl.c | 26 ++++++++------------------
>  1 file changed, 8 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index f026245d1e9e..7a56e7b79b4d 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -8466,36 +8466,26 @@ static void nvme_pci_reset(DeviceState *qdev)
>      nvme_ctrl_reset(n, NVME_RESET_FUNCTION);
>  }
>  
> -static void nvme_sriov_pre_write_ctrl(PCIDevice *dev, uint32_t address,
> -                                      uint32_t val, int len)
> +static void nvme_sriov_post_write_config(PCIDevice *dev, uint16_t old_num_vfs)
>  {
>      NvmeCtrl *n = NVME(dev);
>      NvmeSecCtrlEntry *sctrl;
> -    uint16_t sriov_cap = dev->exp.sriov_cap;
> -    uint32_t off = address - sriov_cap;
> -    int i, num_vfs;
> +    int i;
>  
> -    if (!sriov_cap) {
> -        return;
> -    }
> -
> -    if (range_covers_byte(off, len, PCI_SRIOV_CTRL)) {
> -        if (!(val & PCI_SRIOV_CTRL_VFE)) {
> -            num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
> -            for (i = 0; i < num_vfs; i++) {
> -                sctrl = &n->sec_ctrl_list.sec[i];
> -                nvme_virt_set_state(n, le16_to_cpu(sctrl->scid), false);
> -            }
> -        }
> +    for (i = pcie_sriov_num_vfs(dev); i < old_num_vfs; i++) {
> +        sctrl = &n->sec_ctrl_list.sec[i];
> +        nvme_virt_set_state(n, le16_to_cpu(sctrl->scid), false);
>      }
>  }

Maybe I'm missing something, but if the concern is that 'i' could run
beyond the end of the array, I don't see anything that limits
pcie_sriov_num_vfs() to the static size of 127 that n->sec_ctrl_list.sec
has. register_vfs() seems to just take whatever 16 bit value the guest
wrote without imposing additional restrictions.

If there is some mechanism that makes register_vf() fail if we exceed
the limit, maybe an assertion with a comment would be in order because
it doesn't seem obvious. I couldn't find any code that enforces it,
sriov_max_vfs only ever seems to be used as a hint for the guest.

If not, do we need another check that fails gracefully in the error
case?

Kevin


