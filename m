Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92ABDC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 09:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfGCw-0006CR-94; Wed, 28 Feb 2024 04:26:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfGCe-00065Q-PR
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 04:26:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfGCW-0005xL-8A
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 04:26:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709112366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IIECEyI60wZLWC+zhQKX//gW0v5fTDvBLI2RKuw4zd4=;
 b=P0o4bw6NFLWfHcntcTUTHutWQ01zPFTbvEjPhKxG6hVmrUIR+gI1/S5GUXBHOBetdELnhk
 JiHjeduwreVuScB2rwBwBH3ZADEip8SXkokzOe4wEqXN6mzHfu9UDsAHga6xeGxArsh1Fe
 hYuDeKGAE4R1ITwwJ7JmRGtSYn8eA0I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-SvgTrbOqOQ-Jf5aTRBBz6g-1; Wed, 28 Feb 2024 04:26:04 -0500
X-MC-Unique: SvgTrbOqOQ-Jf5aTRBBz6g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D84B086F131;
 Wed, 28 Feb 2024 09:26:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B3CB3EBBA7;
 Wed, 28 Feb 2024 09:26:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 957FC21E66F4; Wed, 28 Feb 2024 10:25:59 +0100 (CET)
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
Subject: Re: [PATCH v7 15/16] vfio: Avoid inspecting option QDict for rombar
In-Reply-To: <20240224-reuse-v7-15-29c14bcb952e@daynix.com> (Akihiko Odaki's
 message of "Sat, 24 Feb 2024 18:24:47 +0900")
References: <20240224-reuse-v7-0-29c14bcb952e@daynix.com>
 <20240224-reuse-v7-15-29c14bcb952e@daynix.com>
Date: Wed, 28 Feb 2024 10:25:59 +0100
Message-ID: <87v8690wk8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> Use pci_rom_bar_explicitly_enabled() to determine if rombar is explicitly
> enabled.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  hw/vfio/pci.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 4fa387f0430d..647f15b2a060 100644
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
> @@ -1046,7 +1045,7 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
>      }
>  
>      if (vfio_opt_rom_in_denylist(vdev)) {
> -        if (dev->opts && qdict_haskey(dev->opts, "rombar")) {
> +        if (pci_rom_bar_explicitly_enabled(&vdev->pdev)) {
>              warn_report("Device at %s is known to cause system instability"
>                          " issues during option rom execution",
>                          vdev->vbasedev.name);

I'd squash the previous patch and this one together.


