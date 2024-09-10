Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B461AECE582
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 09:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snx4F-0006qv-0n; Tue, 10 Sep 2024 05:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1snx4C-0006pA-KK
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 05:21:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1snx4A-0005hn-DA
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 05:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725960101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jh5TuUK6o2ZfpBiWkyCKrrTXMKkoyqJnabDAZ7Q8ILI=;
 b=IjcXv+9fxL/RgiwZAJI2S2eRcTbAOFCeVocPXs9VhmSOkQXe2K1vOoi8PPiol98dt0lhE0
 CMefgArOwDXfbZhNIDXOMhSGs3BU0By5n8FlA6qNQbeVPkvgHI3LGeqQGavdRCPn/VZ0AF
 NcuBiq+uORU7XQUPX4E7yhv9ef/phJA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-_fLFV1hENkm8Ns34hswYoQ-1; Tue, 10 Sep 2024 05:21:39 -0400
X-MC-Unique: _fLFV1hENkm8Ns34hswYoQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3789c3541e9so779726f8f.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 02:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725960098; x=1726564898;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jh5TuUK6o2ZfpBiWkyCKrrTXMKkoyqJnabDAZ7Q8ILI=;
 b=MKxrE0VIjuO4Pv/A1CDpcJsbx/UXBBb6BV0S4Z3+9AQ4P0BmppRi5aeR59JfHEsIX7
 e7s0gOC8fg5RJDAuuAd5Q9f1C1JBGRI2hJ9u8h7D8DjjGxL0781XIEL1LwTg7vZQYKhC
 4Ka/PBjrrlZbsrMywFldphr2EHp8YkBPGhpCsaFoj6ZUDqe3qKlQs/JhrjnhQIQC3llc
 w+rtrUt2NxUabj/7X8uQncbUxbcHiScJ2w0mfGgieTFVH1HMkmsd41wGN1FTUoqI3DKy
 WWLYLnLY1O/58sRIyPn8QZNwKN5vu/LdPlPBG0P7K1YpeEsHDvusbft7fwOr8Mv8yqX4
 NP/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUH8Y0xWjzjX2CYJBEbjn7TDf+CZkRIOzow/evDhT58lBKi0ROB8WAaRsl0uvAM6mly18mgE4rIbdBs@nongnu.org
X-Gm-Message-State: AOJu0Yz9CPy7fjzyOi2gbf1HbGfk3R4M9vjGCuRjPbWsRDN2Gx3h8nDk
 Q918m2f07JtA7QFEvatfv03x1xcD+gWlo/7mwXJ2Aqki3ODVE7R8RwsYeG+6srG8LhPJ4bySmtR
 Dm1kOEOLkvMnC7cV13yoJzEcJLzhs78rERY2PrWOvc+KzMgGY8Xb1
X-Received: by 2002:a5d:5046:0:b0:374:c16d:6282 with SMTP id
 ffacd0b85a97d-3788968858dmr7138617f8f.55.1725960097823; 
 Tue, 10 Sep 2024 02:21:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJtI/diRm1yKhWeUdaQuuC5lnLcvlO3JXeswxeEstjsE0MuBNeLsHvpIt2+d7zMNMUIdi0fA==
X-Received: by 2002:a5d:5046:0:b0:374:c16d:6282 with SMTP id
 ffacd0b85a97d-3788968858dmr7138588f8f.55.1725960097108; 
 Tue, 10 Sep 2024 02:21:37 -0700 (PDT)
Received: from redhat.com ([31.187.78.173]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb449aesm104242205e9.25.2024.09.10.02.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 02:21:36 -0700 (PDT)
Date: Tue, 10 Sep 2024 05:21:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH for-9.2 v15 00/11] hw/pci: SR-IOV related fixes and
 improvements
Message-ID: <20240910052046-mutt-send-email-mst@kernel.org>
References: <20240823-reuse-v15-0-eddcb960e289@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240823-reuse-v15-0-eddcb960e289@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Aug 23, 2024 at 02:00:37PM +0900, Akihiko Odaki wrote:
> Supersedes: <20240714-rombar-v2-0-af1504ef55de@daynix.com>
> ("[PATCH v2 0/4] hw/pci: Convert rom_bar into OnOffAuto")
> 
> I submitted a RFC series[1] to add support for SR-IOV emulation to
> virtio-net-pci. During the development of the series, I fixed some
> trivial bugs and made improvements that I think are independently
> useful. This series extracts those fixes and improvements from the RFC
> series.
> 
> [1]: https://patchew.org/QEMU/20231210-sriov-v2-0-b959e8a6dfaf@daynix.com/
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

I don't think Cédric's issues have been addressed, am I wrong?
Cédric, what is your take?



> ---
> Changes in v15:
> - Fixed variable shadowing in patch
>   "pcie_sriov: Remove num_vfs from PCIESriovPF"
> - Link to v14: https://lore.kernel.org/r/20240813-reuse-v14-0-4c15bc6ee0e6@daynix.com
> 
> Changes in v14:
> - Dropped patch "pcie_sriov: Ensure VF function number does not
>   overflow" as I found the restriction it imposes is unnecessary.
> - Link to v13: https://lore.kernel.org/r/20240805-reuse-v13-0-aaeaa4d7dfd2@daynix.com
> 
> Changes in v13:
> - Added patch "s390x/pci: Check for multifunction after device
>   realization". I found SR-IOV devices, which are multifunction devices,
>   are not supposed to work at all with s390x on QEMU.
> - Link to v12: https://lore.kernel.org/r/20240804-reuse-v12-0-d3930c4111b2@daynix.com
> 
> Changes in v12:
> - Changed to ignore invalid PCI_SRIOV_NUM_VF writes as done for
>   PCI_SRIOV_CTRL_VFE.
> - Updated the message for patch "hw/pci: Use -1 as the default value for
>   rombar". (Markus Armbruster)
> - Link to v11: https://lore.kernel.org/r/20240802-reuse-v11-0-fb83bb8c19fb@daynix.com
> 
> Changes in v11:
> - Rebased.
> - Dropped patch "hw/pci: Convert rom_bar into OnOffAuto".
> - Added patch "hw/pci: Use -1 as the default value for rombar".
> - Added for-9.2 to give a testing period for possible breakage with
>   libvirt/s390x.
> - Link to v10: https://lore.kernel.org/r/20240627-reuse-v10-0-7ca0b8ed3d9f@daynix.com
> 
> Changes in v10:
> - Added patch "hw/ppc/spapr_pci: Do not reject VFs created after a PF".
> - Added patch "hw/ppc/spapr_pci: Do not create DT for disabled PCI device".
> - Added patch "hw/pci: Convert rom_bar into OnOffAuto".
> - Dropped patch "hw/pci: Determine if rombar is explicitly enabled".
> - Dropped patch "hw/qdev: Remove opts member".
> - Link to v9: https://lore.kernel.org/r/20240315-reuse-v9-0-67aa69af4d53@daynix.com
> 
> Changes in v9:
> - Rebased.
> - Restored '#include "qapi/error.h"' (Michael S. Tsirkin)
> - Added patch "pcie_sriov: Ensure VF function number does not overflow"
>   to fix abortion with wrong PF addr.
> - Link to v8: https://lore.kernel.org/r/20240228-reuse-v8-0-282660281e60@daynix.com
> 
> Changes in v8:
> - Clarified that "hw/pci: Replace -1 with UINT32_MAX for romsize" is
>   not a bug fix. (Markus Armbruster)
> - Squashed patch "vfio: Avoid inspecting option QDict for rombar" into
>   "hw/pci: Determine if rombar is explicitly enabled".
>   (Markus Armbruster)
> - Noted the minor semantics change for patch "hw/pci: Determine if
>   rombar is explicitly enabled". (Markus Armbruster)
> - Link to v7: https://lore.kernel.org/r/20240224-reuse-v7-0-29c14bcb952e@daynix.com
> 
> Changes in v7:
> - Replaced -1 with UINT32_MAX when expressing uint32_t.
>   (Markus Armbruster)
> - Added patch "hw/pci: Replace -1 with UINT32_MAX for romsize".
> - Link to v6: https://lore.kernel.org/r/20240220-reuse-v6-0-2e42a28b0cf2@daynix.com
> 
> Changes in v6:
> - Fixed migration.
> - Added patch "pcie_sriov: Do not manually unrealize".
> - Restored patch "pcie_sriov: Release VFs failed to realize" that was
>   missed in v5.
> - Link to v5: https://lore.kernel.org/r/20240218-reuse-v5-0-e4fc1c19b5a9@daynix.com
> 
> Changes in v5:
> - Added patch "hw/pci: Always call pcie_sriov_pf_reset()".
> - Added patch "pcie_sriov: Reset SR-IOV extended capability".
> - Removed a reference to PCI_SRIOV_CTRL_VFE in hw/nvme.
>   (Michael S. Tsirkin)
> - Noted the impact on the guest of patch "pcie_sriov: Do not reset
>   NumVFs after unregistering VFs". (Michael S. Tsirkin)
> - Changed to use pcie_sriov_num_vfs().
> - Restored pci_set_power() and changed it to call pci_set_enabled() only
>   for PFs with an expalanation. (Michael S. Tsirkin)
> - Reordered patches.
> - Link to v4: https://lore.kernel.org/r/20240214-reuse-v4-0-89ad093a07f4@daynix.com
> 
> Changes in v4:
> - Reverted the change to pci_rom_bar_explicitly_enabled().
>   (Michael S. Tsirkin)
> - Added patch "pcie_sriov: Do not reset NumVFs after unregistering VFs".
> - Added patch "hw/nvme: Refer to dev->exp.sriov_pf.num_vfs".
> - Link to v3: https://lore.kernel.org/r/20240212-reuse-v3-0-8017b689ce7f@daynix.com
> 
> Changes in v3:
> - Extracted patch "hw/pci: Use -1 as a default value for rombar" from
>   patch "hw/pci: Determine if rombar is explicitly enabled"
>   (Philippe Mathieu-Daudé)
> - Added an audit result of PCIDevice::rom_bar to the message of patch
>   "hw/pci: Use -1 as a default value for rombar"
>   (Philippe Mathieu-Daudé)
> - Link to v2: https://lore.kernel.org/r/20240210-reuse-v2-0-24ba2a502692@daynix.com
> 
> Changes in v2:
> - Reset after enabling a function so that NVMe VF state gets updated.
> - Link to v1: https://lore.kernel.org/r/20240203-reuse-v1-0-5be8c5ce6338@daynix.com
> 
> ---
> Akihiko Odaki (11):
>       hw/pci: Rename has_power to enabled
>       hw/ppc/spapr_pci: Do not create DT for disabled PCI device
>       hw/ppc/spapr_pci: Do not reject VFs created after a PF
>       s390x/pci: Check for multifunction after device realization
>       pcie_sriov: Do not manually unrealize
>       pcie_sriov: Reuse SR-IOV VF device instances
>       pcie_sriov: Release VFs failed to realize
>       pcie_sriov: Remove num_vfs from PCIESriovPF
>       pcie_sriov: Register VFs after migration
>       hw/pci: Use -1 as the default value for rombar
>       hw/qdev: Remove opts member
> 
>  docs/pcie_sriov.txt         |   8 ++-
>  include/hw/pci/pci.h        |   2 +-
>  include/hw/pci/pci_device.h |  19 +++++-
>  include/hw/pci/pcie_sriov.h |   9 +--
>  include/hw/qdev-core.h      |   4 --
>  hw/core/qdev.c              |   1 -
>  hw/net/igb.c                |  13 +++-
>  hw/nvme/ctrl.c              |  24 ++++---
>  hw/pci/pci.c                |  23 ++++---
>  hw/pci/pci_host.c           |   4 +-
>  hw/pci/pcie_sriov.c         | 153 +++++++++++++++++++++++---------------------
>  hw/ppc/spapr_pci.c          |   8 ++-
>  hw/s390x/s390-pci-bus.c     |  14 ++--
>  hw/vfio/pci.c               |   5 +-
>  system/qdev-monitor.c       |  12 ++--
>  hw/pci/trace-events         |   2 +-
>  16 files changed, 175 insertions(+), 126 deletions(-)
> ---
> base-commit: 31669121a01a14732f57c49400bc239cf9fd505f
> change-id: 20240129-reuse-faae22b11934
> 
> Best regards,
> -- 
> Akihiko Odaki <akihiko.odaki@daynix.com>


