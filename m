Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50937D65C6C
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 11:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBXiZ-0006Gd-EQ; Thu, 14 Nov 2024 06:08:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zuoboqun@baidu.com>)
 id 1tBXiX-0006GN-3s
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 06:08:53 -0500
Received: from mx24.baidu.com ([111.206.215.185] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zuoboqun@baidu.com>)
 id 1tBXiT-0000ix-EU
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 06:08:51 -0500
To: Stefano Garzarella <sgarzare@redhat.com>
CC: qemu-devel <qemu-devel@nongnu.org>, "Michael S . Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, "Gao,Shiyuan"
 <gaoshiyuan@baidu.com>
Subject: Re: [PATCH] vhost_net: fix assertion triggered by batch of host
 notifiers processing
Thread-Topic: [PATCH] vhost_net: fix assertion triggered by batch of host
 notifiers processing
Thread-Index: Ads2g8sjNkcTH3Y0QzSQijDfLzrZpA==
Date: Thu, 14 Nov 2024 11:08:35 +0000
Message-ID: <6e6f624c7a2a489b88dba0a44e6013d1@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.18.84.203]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.51.11
X-FE-Last-Public-Client-IP: 100.100.100.49
X-FE-Policy-ID: 52:10:53:SYSTEM
Received-SPF: pass client-ip=111.206.215.185; envelope-from=zuoboqun@baidu.com;
 helo=baidu.com
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
Reply-to:  "Zuo,Boqun" <zuoboqun@baidu.com>
From:  "Zuo,Boqun" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thursday, November 14, 2024 6:54 PM, Stefano Garzarella wrote:
> >
> >When the backend of vhost_net restarts during the vm is running,
> >vhost_net is stopped and started. The virtio_device_grab_ioeventfd()
> >fucntion in
> >vhost_net_enable_notifiers() will result in a call to
> >virtio_bus_set_host_notifier()(assign=3Dfalse).
> >
> >And now virtio_device_grab_ioeventfd() is batched in a single
> >transaction with virtio_bus_set_host_notifier()(assign=3Dtrue).
> >
> >This triggers the following assertion:
> >
> >kvm_mem_ioeventfd_del: error deleting ioeventfd: Bad file descriptor
> >
> >This patch moves virtio_device_grab_ioeventfd() out of the batch to fix
> >this problem.
> >
> >Fixes: 6166799f6 ("vhost_net: configure all host notifiers in a single
> >MR transaction")
> >Reported-by: Gao Shiyuan <gaoshiyuan@baidu.com>
> >Signed-off-by: Zuo Boqun <zuoboqun@baidu.com>
> >---
> > hw/net/vhost_net.c | 31 ++++++++++++++++++++-----------
> > 1 file changed, 20 insertions(+), 11 deletions(-)
> >
> >diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c index
> >997aab0557..eb3e92ca0d 100644
> >--- a/hw/net/vhost_net.c
> >+++ b/hw/net/vhost_net.c
> >@@ -229,9 +229,24 @@ static int vhost_net_enable_notifiers(VirtIODevice
> *dev,
> >     int nvhosts =3D data_queue_pairs + cvq;
> >     struct vhost_net *net;
> >     struct vhost_dev *hdev;
> >-    int r, i, j;
> >+    int r, i, j, k;
> >     NetClientState *peer;
> >
> >+    /*
> >+     * We will pass the notifiers to the kernel, make sure that QEMU
> >+     * doesn't interfere.
> >+     */
> >+    for (i =3D 0; i < nvhosts; i++) {
> >+        r =3D virtio_device_grab_ioeventfd(dev);
> >+        if (r < 0) {
> >+            error_report("vhost %d binding does not support host notifi=
ers", i);
> >+            for (k =3D 0; k < i; k++) {
> >+                virtio_device_release_ioeventfd(dev);
> >+            }
> >+            return r;
> >+        }
> >+    }
> >+
> >     /*
> >      * Batch all the host notifiers in a single transaction to avoid
> >      * quadratic time complexity in address_space_update_ioeventfds().
> >@@ -247,16 +262,6 @@ static int vhost_net_enable_notifiers(VirtIODevice
> >*dev,
> >
> >         net =3D get_vhost_net(peer);
> >         hdev =3D &net->dev;
> >-        /*
> >-         * We will pass the notifiers to the kernel, make sure that QEM=
U
> >-         * doesn't interfere.
> >-         */
> >-        r =3D virtio_device_grab_ioeventfd(dev);
> >-        if (r < 0) {
> >-            error_report("binding does not support host notifiers");
> >-            memory_region_transaction_commit();
> >-            goto fail_nvhosts;
> >-        }
> >
> >         for (j =3D 0; j < hdev->nvqs; j++) {
> >             r =3D virtio_bus_set_host_notifier(VIRTIO_BUS(qbus),
> >@@ -277,6 +282,10 @@ static int vhost_net_enable_notifiers(VirtIODevice
> *dev,
> >     return 0;
> > fail_nvhosts:
> >     vhost_net_disable_notifiers_nvhosts(dev, ncs, data_queue_pairs,
> >i);
>=20
> IIUC this call is disabling notifiers from 0 to `i - 1` ...
>=20
> >+    for (k =3D i + 1; k < nvhosts; k++) {
>=20
> ... so, should we start from `i`, instead of `i + 1`?
>=20
> Thanks,
> Stefano

The notifier `i` has been released when vhost_net_enable_notifiers() call v=
host_dev_disable_notifiers_nvqs():

        for (j =3D 0; j < hdev->nvqs; j++) {
            r =3D virtio_bus_set_host_notifier(VIRTIO_BUS(qbus),
                                             hdev->vq_index + j,
                                             true);
            if (r < 0) {
                error_report("vhost %d VQ %d notifier binding failed: %d",
                              i, j, -r);
                memory_region_transaction_commit();
=3D>            vhost_dev_disable_notifiers_nvqs(hdev, dev, j);
                goto fail_nvhosts;
            }
        }

So we should start from `i+1`...

>=20
> >+        virtio_device_release_ioeventfd(dev);
> >+    }
> >+
> >     return r;
> > }
> >
> >--
> >2.42.0.windows.2
> >


