Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2E5C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 10:55:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZpwP-0005Er-Gt; Fri, 02 Aug 2024 06:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZpvl-00057I-Ql
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 06:54:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZpvk-000619-4e
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 06:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722596078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kzIkPPzHSDwUbwNz2nsncBjoCzVDrlpAWtmIGqV2Z9k=;
 b=BSO2i5kz4aj7ObuQ5MuI3UTsGlKalA1epkkUFThVHbF6GC1/OrSHpFBc41gUmnVxZ4fCeT
 7l4A2H7kgfVuPVvcQ6+co7yVEZjIb8dO/UFllP+0vco8lXbVvfjsMwiARL3a+TD7cx+j0F
 FN50zOjMH6adomaRk9EWQ8wUT986nZI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-a1hc6mN_Oniu12q-KXMPIw-1; Fri,
 02 Aug 2024 06:54:35 -0400
X-MC-Unique: a1hc6mN_Oniu12q-KXMPIw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC2831955EA3; Fri,  2 Aug 2024 10:54:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 005D4195605A; Fri,  2 Aug 2024 10:54:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DEECF21E668B; Fri,  2 Aug 2024 12:54:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  "Michael
 S. Tsirkin"
 <mst@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Alex
 Williamson <alex.williamson@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,  Jason Wang
 <jasowang@redhat.com>,  Keith Busch <kbusch@kernel.org>,  Klaus Jensen
 <its@irrelevant.dk>,  qemu-devel@nongnu.org,  qemu-block@nongnu.org
Subject: Re: [PATCH for-9.2 v11 10/11] hw/pci: Use -1 as the default value
 for rombar
In-Reply-To: <20240802-reuse-v11-10-fb83bb8c19fb@daynix.com> (Akihiko Odaki's
 message of "Fri, 02 Aug 2024 14:18:00 +0900")
References: <20240802-reuse-v11-0-fb83bb8c19fb@daynix.com>
 <20240802-reuse-v11-10-fb83bb8c19fb@daynix.com>
Date: Fri, 02 Aug 2024 12:54:29 +0200
Message-ID: <875xsj42l6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.124,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> vfio_pci_size_rom() distinguishes whether rombar is explicitly set to 1
> by checking dev->opts, bypassing the QOM property infrastructure.
>
> Use -1 as the default value for rombar to tell if the user explicitly
> set it to 1. The property is also converted from unsigned to signed.
> -1 is signed so it is safe to give it a new meaning. The values in
> [2 ^ 31, 2 ^ 32) will be invalid, but nobody should have typed these
> values by chance.

s/will be/become invalid/

Should we document the change somewhere?  I'm not sure.  Opinions?

> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  include/hw/pci/pci_device.h | 2 +-
>  hw/pci/pci.c                | 2 +-
>  hw/vfio/pci.c               | 5 ++---
>  3 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
> index 1ff3ce94e25b..8fa845beee5e 100644
> --- a/include/hw/pci/pci_device.h
> +++ b/include/hw/pci/pci_device.h
> @@ -148,7 +148,7 @@ struct PCIDevice {
>      uint32_t romsize;
>      bool has_rom;
>      MemoryRegion rom;
> -    uint32_t rom_bar;
> +    int32_t rom_bar;
>  
>      /* INTx routing notifier */
>      PCIINTxRoutingNotifier intx_routing_notifier;
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 4c7be5295110..d2eaf0c51dde 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -71,7 +71,7 @@ static Property pci_props[] = {
>      DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
>      DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
>      DEFINE_PROP_UINT32("romsize", PCIDevice, romsize, UINT32_MAX),
> -    DEFINE_PROP_UINT32("rombar",  PCIDevice, rom_bar, 1),
> +    DEFINE_PROP_INT32("rombar",  PCIDevice, rom_bar, -1),
>      DEFINE_PROP_BIT("multifunction", PCIDevice, cap_present,
>                      QEMU_PCI_CAP_MULTIFUNCTION_BITNR, false),
>      DEFINE_PROP_BIT("x-pcie-lnksta-dllla", PCIDevice, cap_present,
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 2407720c3530..dc53837eac73 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1012,7 +1012,6 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
>  {
>      uint32_t orig, size = cpu_to_le32((uint32_t)PCI_ROM_ADDRESS_MASK);
>      off_t offset = vdev->config_offset + PCI_ROM_ADDRESS;
> -    DeviceState *dev = DEVICE(vdev);
>      char *name;
>      int fd = vdev->vbasedev.fd;
>  
> @@ -1046,12 +1045,12 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
>      }
>  
>      if (vfio_opt_rom_in_denylist(vdev)) {
> -        if (dev->opts && qdict_haskey(dev->opts, "rombar")) {
> +        if (vdev->pdev.rom_bar > 0) {
>              warn_report("Device at %s is known to cause system instability"
>                          " issues during option rom execution",
>                          vdev->vbasedev.name);
>              error_printf("Proceeding anyway since user specified"
> -                         " non zero value for rombar\n");
> +                         " positive value for rombar\n");
>          } else {
>              warn_report("Rom loading for device at %s has been disabled"
>                          " due to system instability issues",

Preferably with the commit message tweak:

Reviewed-by: Markus Armbruster <armbru@redhat.com>


