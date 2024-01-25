Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0417EC47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 09:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSwGv-0003GN-J7; Thu, 25 Jan 2024 04:43:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rSwGt-0003Fb-T8; Thu, 25 Jan 2024 04:43:43 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rSwGq-0005FP-Uw; Thu, 25 Jan 2024 04:43:43 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id C3C6F49289;
 Thu, 25 Jan 2024 10:43:36 +0100 (CET)
Message-ID: <fb1ec577-05e3-4c96-a212-57215f8a2e94@proxmox.com>
Date: Thu, 25 Jan 2024 10:43:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] virtio-scsi: Attach event vq notifier with no_poll
Content-Language: en-US
To: Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Fam Zheng <fam@euphon.net>
References: <20240124173834.66320-1-hreitz@redhat.com>
 <20240124173834.66320-2-hreitz@redhat.com>
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20240124173834.66320-2-hreitz@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Am 24.01.24 um 18:38 schrieb Hanna Czenczek:
> As of commit 38738f7dbbda90fbc161757b7f4be35b52205552 ("virtio-scsi:
> don't waste CPU polling the event virtqueue"), we only attach an io_read
> notifier for the virtio-scsi event virtqueue instead, and no polling
> notifiers.  During operation, the event virtqueue is typically
> non-empty, but none of the buffers are intended to be used immediately.
> Instead, they only get used when certain events occur.  Therefore, it
> makes no sense to continuously poll it when non-empty, because it is
> supposed to be and stay non-empty.
> 
> We do this by using virtio_queue_aio_attach_host_notifier_no_poll()
> instead of virtio_queue_aio_attach_host_notifier() for the event
> virtqueue.
> 
> Commit 766aa2de0f29b657148e04599320d771c36fd126 ("virtio-scsi: implement
> BlockDevOps->drained_begin()") however has virtio_scsi_drained_end() use
> virtio_queue_aio_attach_host_notifier() for all virtqueues, including
> the event virtqueue.  This can lead to it being polled again, undoing
> the benefit of commit 38738f7dbbda90fbc161757b7f4be35b52205552.
> 
> Fix it by using virtio_queue_aio_attach_host_notifier_no_poll() for the
> event virtqueue.
> 
> Reported-by: Fiona Ebner <f.ebner@proxmox.com>
> Fixes: 766aa2de0f29b657148e04599320d771c36fd126
>        ("virtio-scsi: implement BlockDevOps->drained_begin()")
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>

Tested-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>


