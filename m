Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 742A8C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 12:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfJBR-0005f4-Cl; Wed, 28 Feb 2024 07:37:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfJBP-0005cz-7Q
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:37:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfJBN-0001kz-LY
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:37:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709123828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TRbHu0IyoINOPUwo8bCb35ebFaUMAVVlXB12u/DtRS4=;
 b=LjYDaRSoJCY5rF8lB3mI4RYT98Bmyi/4i/SR8Rjc7yZr51p5ZCnF+WX/osjUUPM0tmoM6r
 /FGeaAGsDMWOFst6mE/x8mm+TmJJYCNcxErev9gHC86x3eufNSBZszxF9UE8P9S268yEp/
 Vl3lq6ZAY8D0X1MpMmz9zDBu5UaK/Ss=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-u6Y3QPPSPxayE00N4PbhTg-1; Wed, 28 Feb 2024 07:37:04 -0500
X-MC-Unique: u6Y3QPPSPxayE00N4PbhTg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9530285A59D;
 Wed, 28 Feb 2024 12:37:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 384B9492BE8;
 Wed, 28 Feb 2024 12:37:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1C88321E66F4; Wed, 28 Feb 2024 13:36:57 +0100 (CET)
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
Subject: Re: [PATCH v8 13/15] hw/pci: Use UINT32_MAX as a default value for
 rombar
In-Reply-To: <20240228-reuse-v8-13-282660281e60@daynix.com> (Akihiko Odaki's
 message of "Wed, 28 Feb 2024 20:33:24 +0900")
References: <20240228-reuse-v8-0-282660281e60@daynix.com>
 <20240228-reuse-v8-13-282660281e60@daynix.com>
Date: Wed, 28 Feb 2024 13:36:57 +0100
Message-ID: <87zfvkvk7q.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
> Set rombar UINT32_MAX by default to distinguish these cases just as it
> is done for addr and romsize. It was confirmed that changing the default
> value to UINT32_MAX will not change the behavior by looking at
> occurences of rom_bar.
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
>
> If a user explicitly set UINT32_MAX, we still cannot distinguish that
> from the implicit default. However, it is unlikely to be a problem as
> nobody would type literal UINT32_MAX (0xffffffff or 4294967295) by
> chance.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Not exactly elegant, but I believe we have similar "default value means
not set by user (good enough because the default value is sufficiently
odd)" logic elsewhere.

Reviewed-by: Markus Armbruster <armbru@redhat.com>


