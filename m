Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49127C48285
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 09:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSwGu-0003Fk-MP; Thu, 25 Jan 2024 04:43:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rSwGt-0003FO-20; Thu, 25 Jan 2024 04:43:43 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rSwGq-0005Ft-VH; Thu, 25 Jan 2024 04:43:42 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id B71FE49259;
 Thu, 25 Jan 2024 10:43:38 +0100 (CET)
Message-ID: <49b2548e-a9e7-47af-bc1f-6bc0c2879220@proxmox.com>
Date: Thu, 25 Jan 2024 10:43:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] virtio: Keep notifications disabled during drain
Content-Language: en-US
To: Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Fam Zheng <fam@euphon.net>
References: <20240124173834.66320-1-hreitz@redhat.com>
 <20240124173834.66320-3-hreitz@redhat.com>
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20240124173834.66320-3-hreitz@redhat.com>
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
> During drain, we do not care about virtqueue notifications, which is why
> we remove the handlers on it.  When removing those handlers, whether vq
> notifications are enabled or not depends on whether we were in polling
> mode or not; if not, they are enabled (by default); if so, they have
> been disabled by the io_poll_start callback.
> 
> Because we do not care about those notifications after removing the
> handlers, this is fine.  However, we have to explicitly ensure they are
> enabled when re-attaching the handlers, so we will resume receiving
> notifications.  We do this in virtio_queue_aio_attach_host_notifier*().
> If such a function is called while we are in a polling section,
> attaching the notifiers will then invoke the io_poll_start callback,
> re-disabling notifications.
> 
> Because we will always miss virtqueue updates in the drained section, we
> also need to poll the virtqueue once after attaching the notifiers.
> 
> Buglink: https://issues.redhat.com/browse/RHEL-3934
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>

Tested-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>


