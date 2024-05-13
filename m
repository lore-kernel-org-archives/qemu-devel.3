Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85118C25B5F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 13:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Vyv-0001Kn-Lq; Mon, 13 May 2024 09:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1s6Vyp-0001KR-KJ
 for qemu-devel@nongnu.org; Mon, 13 May 2024 09:44:39 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1s6Vyn-0000t0-RV
 for qemu-devel@nongnu.org; Mon, 13 May 2024 09:44:39 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 7F70147CB0;
 Mon, 13 May 2024 15:44:34 +0200 (CEST)
Message-ID: <bcec5365-d2ea-4f70-9442-75af067eeca2@proxmox.com>
Date: Mon, 13 May 2024 15:44:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Fix "virtio-gpu: fix scanout migration post-load"
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20240513071905.499143-1-marcandre.lureau@redhat.com>
 <fc9483ba-513d-4796-b5e3-68819125c4c7@proxmox.com>
 <CAMxuvawqFHU7EVhQAcyRq=OLB1+f9q90mdSsEZrv1C5AR_JzRg@mail.gmail.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <CAMxuvawqFHU7EVhQAcyRq=OLB1+f9q90mdSsEZrv1C5AR_JzRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 13.05.24 um 15:21 schrieb Marc-André Lureau:
> 
> Indeed, it needs:
> 
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 5de90bb62f..3a88eb5e3a 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1201,7 +1201,7 @@ static const VMStateDescription
> vmstate_virtio_gpu_scanout = {
> 
>  static const VMStateDescription vmstate_virtio_gpu_scanouts = {
>      .name = "virtio-gpu-scanouts",
> -    .version_id = 1,
> +    .version_id = 2,
> 
> 

Thanks! With that on top:

Tested-by: Fiona Ebner <f.ebner@proxmox.com>

Tested with an Ubuntu 23.10 VM:

Machine type pc-i440fx-8.2:
1. create snapshot with 8.2, load with patched 9.0
2. create snapshot with patched 9.0, load with patched 9.0 and with 8.2

Machine type pc-i440fx-9.0:
1. create snapshot with patched 9.0, load with patched 9.0

No crashes/failures and didn't notice any other issues 🙂

Best Regards,
Fiona


