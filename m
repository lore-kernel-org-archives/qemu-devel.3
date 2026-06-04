Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262B8CD6E6B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 13:14:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV7sz-0002x6-5x; Thu, 04 Jun 2026 09:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wV7sq-0002ty-O3
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 09:13:19 -0400
Received: from msg-1.mailo.com ([213.182.54.11] helo=mailo.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wV7so-0002u1-Pp
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 09:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
 t=1780577831; bh=sWvHbZv8J1SJ9W7h0uJRayxEzWjfzj1kiPmI8Kbh0sM=;
 h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=VdJEE2kz3K6YWV36QDM/gIPcE416AXyit8MNatRmJri2bX4ao49oJeDvktwvaUd+w
 /uSQUG1FdMI+UykIIg/Szkg/Z1poogL7HkyR7BYGaSWZuKe+OUkednkwmtKL0nOBHL
 kGlZs9UDiYPMN/Jl7eGtmjWBQq21D0lKc261MQVY=
Received: by be1-6.in.mailobj.net [192.168.91.16] with ESMTP
 via ip-20.mailobj.net [213.182.54.20]
 Thu,  4 Jun 2026 14:57:00 +0200 (CEST)
X-EA-Auth: 4j1wAJKUkeEwdmdDiu6OPcPt9fm1dD2ezAGmm7rKXsdtTYJxPDy6ZumQLwIdyM490iExt0THAM95Dvx7B2+zWw/C+LB242F+
Message-ID: <5ea46e73-1d5e-430f-b2df-62d6807a60f4@mailo.com>
Date: Thu, 4 Jun 2026 14:57:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/virtio: propagate vhost_virtqueue_mask() errors from
 start path
Content-Language: en-US
To: Bin Guo <guobin@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20260604124420.82450-1-guobin@linux.alibaba.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260604124420.82450-1-guobin@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=213.182.54.11; envelope-from=philmd@mailo.com;
 helo=mailo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

On 4/6/26 14:44, Bin Guo wrote:
> vhost_virtqueue_start() unmasks the call notifier by calling
> vhost_virtqueue_mask(), whose vhost_set_vring_call ioctl can fail
> (closed vhost-user socket, kernel ENOMEM, revoked guest_notifier fd)
> but whose void signature throws the error away. vhost_dev_start()
> then reports success while the backend has no valid call eventfd for
> that vq, leaving the guest with a working kick path but no virtqueue
> interrupts -- a half-up state harder to diagnose than a clean failure.
> 
> Make vhost_virtqueue_mask() return int and handle the error in the
> start path via the existing fail_vector unwind. Other callers reach
> the function through VirtioDeviceClass.guest_notifier_mask, whose
> void signature offers no upward error channel; they invoke it as a
> statement and remain source-compatible.
> 
> Resolves a long-standing TODO at the unmask call.
> 
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>   hw/virtio/vhost.c         | 12 +++++++++---
>   include/hw/virtio/vhost.h |  4 ++--
>   2 files changed, 11 insertions(+), 5 deletions(-)


>   /* Mask/unmask events from this vq. */
> -void vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
> +int vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
>                            bool mask)
>   {
>       struct VirtQueue *vvq = virtio_get_queue(vdev, n);
> @@ -1836,7 +1839,10 @@ void vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
>       r = hdev->vhost_ops->vhost_set_vring_call(hdev, &file);
>       if (r < 0) {
>           error_report("vhost_set_vring_call failed %d", -r);

IIUC the intention behind this TODO is to convert to "a function
returning a boolean and taking Error** as last argument", replacing
this call with error_setg_errno().

See in "Error reporting system loosely patterned after Glib's GError"
rules in "qapi/error.h".

> +        return r;
>       }
> +
> +    return 0;
>   }


