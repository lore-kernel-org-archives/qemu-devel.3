Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA718CAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 15:50:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v15Gt-0004nE-1G; Tue, 23 Sep 2025 11:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhaoxin04@baidu.com>)
 id 1v15Gr-0004my-IS
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 11:49:37 -0400
Received: from mx24.baidu.com ([111.206.215.185] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhaoxin04@baidu.com>)
 id 1v15Go-0006Il-NT
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 11:49:37 -0400
To: qemu-devel <qemu-devel@nongnu.org>
CC: "Michael S . Tsirkin" <mst@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, Cindy Lu <lulu@redhat.com>, Li Zhaoxin
 <lizhaoxin04@baidu.com>, Gao Shiyuan <gaoshiyuan@baidu.com>
Subject: Re: [PATCH] vhost: Do not actively send a config interrupt
Date: Tue, 23 Sep 2025 23:49:18 +0800
Message-ID: <19ac5fa24777515f9f0878e6874dc9f6edec45a3.1758552835.git.lizhaoxin04@baidu.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <19ac5fa24777515f9f0878e6874dc9f6edec45a3.1758552835.git.lizhaoxin04@baidu.com>
References: <19ac5fa24777515f9f0878e6874dc9f6edec45a3.1758552835.git.lizhaoxin04@baidu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.127.73.8]
X-ClientProxiedBy: bjhj-exc8.internal.baidu.com (172.31.3.18) To
 bjhj-exc18.internal.baidu.com (172.31.4.16)
X-FEAS-Client-IP: 172.31.4.16
X-FE-Policy-ID: 52:10:53:SYSTEM
Received-SPF: pass client-ip=111.206.215.185;
 envelope-from=lizhaoxin04@baidu.com; helo=baidu.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Li Zhaoxin <lizhaoxin04@baidu.com>
From:  Li Zhaoxin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Message-ID: <20250923154918.3P5pP-EivvNCqaNBM4g6kiTZiKEiTa6QFdwaDO5-wVA@z>

From: lizhaoxin <lizhaoxin04@baidu.com>

>CCing Cindy since she introduced this code with commit
>f9a09ca3ea ("vhost: add support for configure interrupt"), so she can
>help to review this, since I don't really get this change.
>
>On Mon, Sep 22, 2025 at 11:19:32PM +0800, Li Zhaoxin wrote:
>>From: lizhaoxin <lizhaoxin04@baidu.com>
>>
>>After the VM is suspended/resumed or live-migrated,
>>we do not want the guest to output information such as
>>the capacity of the block device, as this is noticeable to the tenant.
>>Also, there is no need to immediately send a config notifier
>>for the virtio device after vhost_dev_start.
>
>Can you explain more clearly what your problem is and why this patch
>solves it?
>
>Thanks,
>Stefano
>

Hi Stefano and Cindy,

In the vhost-vdpa scenario, after executing virsh suspend vm followed by virsh resume vm, or when live migrating the VM to the destination host, the guest kernel will output the following additional logs:

[Tue Sep 23 19:07:04 2025] virtio_blk virtio1: [vda] new size: 20971520 512-byte logical blocks (10.7 GB/10.0 GiB)
[Tue Sep 23 19:07:04 2025] virtio_blk virtio3: [vdb] new size: 20971520 512-byte logical blocks (10.7 GB/10.0 GiB)

This occurs because when the vhost device is started, the sequence vhost_dev_start -> vhost_start_config_intr -> event_notifier_set(&dev->vdev->config_notifier) is triggered, which sends a configuration change notification (config notification) to the guest. However, it appears that actively sending this notification is currently unnecessary, and no additional processing is performed in the event of a sending failure. So, we removed the call to event_notifier_set(&dev->vdev->config_notifier).

Thanks,
Li Zhaoxin

>>
>>Co-developed-by: Gao Shiyuan <gaoshiyuan@baidu.com>
>>Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>
>>Signed-off-by: Li Zhaoxin <lizhaoxin04@baidu.com>
>>---
>> hw/virtio/vhost.c | 7 +------
>> 1 file changed, 1 insertion(+), 6 deletions(-)
>>
>>diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>>index 6557c58d12..1f8a495ef8 100644
>>--- a/hw/virtio/vhost.c
>>+++ b/hw/virtio/vhost.c
>>@@ -1847,15 +1847,10 @@ static void vhost_stop_config_intr(struct vhost_dev *dev)
>>
>> static void vhost_start_config_intr(struct vhost_dev *dev)
>> {
>>-    int r;
>>-
>>     assert(dev->vhost_ops);
>>     int fd = event_notifier_get_fd(&dev->vdev->config_notifier);
>>     if (dev->vhost_ops->vhost_set_config_call) {
>>-        r = dev->vhost_ops->vhost_set_config_call(dev, fd);
>>-        if (!r) {
>>-            event_notifier_set(&dev->vdev->config_notifier);
>>-        }
>>+        dev->vhost_ops->vhost_set_config_call(dev, fd);
>>     }
>> }
>>
>>--
>>2.34.1
>>

