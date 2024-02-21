Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B361AC48BF6
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 08:00:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rchW7-00089n-EV; Wed, 21 Feb 2024 02:59:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rchW5-000891-KZ
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 02:59:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rchW4-0006OU-38
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 02:59:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708502382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0dA51/Uj7nTkY3BN38Fpu8JLXTELOq5Bz7b4N1rVLkE=;
 b=gXGA/HNH2OKXUuSQ1q9VEjSUObH+z2vPV/2PH4ScTmGXQJK2vX/HdLv9VyflP3hrC6eXN5
 Tg5R45YlIq49Sb6GsJUOvQSXljCX2Lngv0X5JQ9XWpV6tMD07EOLMPh2UAQCxyrMqf8/4U
 m8kHJ6G36TljyfMIZJB4G9NMSfKhFMg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-SPY6ACF_MEO3bONCMxYgcA-1; Wed, 21 Feb 2024 02:59:38 -0500
X-MC-Unique: SPY6ACF_MEO3bONCMxYgcA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 42CD283B826;
 Wed, 21 Feb 2024 07:59:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C9A6E8CE8;
 Wed, 21 Feb 2024 07:59:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ADAA421E66C8; Wed, 21 Feb 2024 08:59:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  "Michael
 S. Tsirkin"
 <mst@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Alex
 Williamson <alex.williamson@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,  Jason Wang
 <jasowang@redhat.com>,  Keith Busch <kbusch@kernel.org>,  Klaus Jensen
 <its@irrelevant.dk>,  qemu-devel@nongnu.org,  qemu-block@nongnu.org
Subject: Re: [PATCH v6 12/15] hw/pci: Use -1 as a default value for rombar
In-Reply-To: <20240220-reuse-v6-12-2e42a28b0cf2@daynix.com> (Akihiko Odaki's
 message of "Tue, 20 Feb 2024 21:24:47 +0900")
References: <20240220-reuse-v6-0-2e42a28b0cf2@daynix.com>
 <20240220-reuse-v6-12-2e42a28b0cf2@daynix.com>
Date: Wed, 21 Feb 2024 08:59:36 +0100
Message-ID: <87a5nu1c47.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> Currently there is no way to distinguish the case that rombar is
> explicitly specified as 1 and the case that rombar is not specified.
>
> Set rombar -1 by default to distinguish these cases just as it is done
> for addr and romsize. It was confirmed that changing the default value
> to -1 will not change the behavior by looking at occurences of rom_bar.
>
> $ git grep -w rom_bar
> hw/display/qxl.c:328:    QXLRom *rom = memory_region_get_ram_ptr(&d->rom_bar);
> hw/display/qxl.c:431:    qxl_set_dirty(&qxl->rom_bar, 0, qxl->rom_size);
> hw/display/qxl.c:1048:    QXLRom *rom = memory_region_get_ram_ptr(&qxl->rom_bar);
> hw/display/qxl.c:2131:    memory_region_init_rom(&qxl->rom_bar, OBJECT(qxl), "qxl.vrom",
> hw/display/qxl.c:2154: PCI_BASE_ADDRESS_SPACE_MEMORY, &qxl->rom_bar);
> hw/display/qxl.h:101:    MemoryRegion       rom_bar;
> hw/pci/pci.c:74:    DEFINE_PROP_UINT32("rombar",  PCIDevice, rom_bar, 1),
> hw/pci/pci.c:2329:    if (!pdev->rom_bar) {
> hw/vfio/pci.c:1019:    if (vdev->pdev.romfile || !vdev->pdev.rom_bar) {
> hw/xen/xen_pt_load_rom.c:29:    if (dev->romfile || !dev->rom_bar) {
> include/hw/pci/pci_device.h:150:    uint32_t rom_bar;
>
> rom_bar refers to a different variable in qxl. It is only tested if
> the value is 0 or not in the other places.

Makes me wonder why it's uint32_t.  Not this patch's problem.

> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  hw/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 54b375da2d26..909c5b3ee4ee 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -71,7 +71,7 @@ static Property pci_props[] = {
>      DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
>      DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
>      DEFINE_PROP_UINT32("romsize", PCIDevice, romsize, -1),
> -    DEFINE_PROP_UINT32("rombar",  PCIDevice, rom_bar, 1),
> +    DEFINE_PROP_UINT32("rombar",  PCIDevice, rom_bar, -1),
>      DEFINE_PROP_BIT("multifunction", PCIDevice, cap_present,
>                      QEMU_PCI_CAP_MULTIFUNCTION_BITNR, false),
>      DEFINE_PROP_BIT("x-pcie-lnksta-dllla", PCIDevice, cap_present,


