Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA0CC36008
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 08:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twzmb-0007iA-Rb; Tue, 25 Mar 2025 04:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1twzmY-0007hP-5v
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 04:37:10 -0400
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1twzmV-00070C-8M
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 04:37:09 -0400
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6e8fce04655so49572166d6.3
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 01:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1742891825; x=1743496625;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SP3DjIET/stR6++mvR7CmAy+9GiFj4hrMIx/d1aW+/I=;
 b=YUT6R5Xwg+KB2waXemuNSr6exbmBt0QT20/ALkOvUW8S93OREBNFeziTAeT7LNQYUq
 gjId7Q6kGWdrWUyJnYZG4juZfXpUAA2eg4wKbFwnh36Rx4HYo6HojndvMKOvXZvep4/j
 Ye5mMUj8z+7MdCPDjA+rZPntZ31yyGnjLDOHCGrzn19To+z5CGxV1QzlONTQkiraQSUC
 00l1qEAsJEbUYcLVPPthz72Z+Z+mzEg6VHpbax0E8fww1mNSMzBurY5uWgv+sP1db0Mm
 tshEDMUyMCcCdyWoTggs6P9pse7X0X5jEfALjYLoMRhhdhMXUrqrgcb1+suf6rJuinHJ
 1frw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742891825; x=1743496625;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SP3DjIET/stR6++mvR7CmAy+9GiFj4hrMIx/d1aW+/I=;
 b=nwV9+yjwpCHZ5Ho/Yw7ZAQjNxmWmIVNZSnVt2CfYDYoPQoLs9zIquFkZbT9RySOBhK
 ZIjmm7SobC3n1BFBWWom8RX8ZqAitzH+rR4ZFqr7YMrGZtn/d2lT4bgojJSkd+a3O8Yd
 Z2tTxiORBNz//hA9jtJNQXE0+UcjDndg3kh4lNOWHmlt+qBNEQJf70Ms1miwi+BO0Y76
 Q/499j792om88hYuas5Lc2bdLN6MWu/3tW7UHN8eHTantEZUNWLqbpR2LGOMvscBfHdw
 lbwjdNn1a0tGDfHxu226rH3wNUX/b7rt0GKhT8VVo9UQU+gh1JL4PhcLuSLIGikVdH2s
 0gRA==
X-Gm-Message-State: AOJu0YwSLv7DvTgKADZEyX2JThcMfZWxK40Iz1Okfa6E7A3laERZ/VJv
 T6kdfQzuxLvZVzkSyamvde4UJa+jR8lL7ERdldMl4iWNyu9Fn8wfxk2atUtwYzpTXlz/H7d+3XM
 40XB8HqJ6vv7Gg1WRU19zaExiNYfhk9z1bTnk9w==
X-Gm-Gg: ASbGncv8nTYVeDsVkoqZppa8atHli8n1JTJkUD9nEZgrZSM1SVpctDRMwCLWPxnKQgG
 1L0eyD09d1tQSt6dQ5eL/vDIapcbSS4a2fmvxNUJsYDZwkjwT9Mb9XYkJF/FaehQ6x8Ot6H7p0K
 P/aze8LGSBszhd682EDMsJmWojZA==
X-Google-Smtp-Source: AGHT+IF7281NZEquKsibVEouI0403+oGT0fWoXmMO+kVjWQFTcmc2sMtQikzq6UgMiMx3ZahdEai6SyTb5jLAi5olW8=
X-Received: by 2002:a05:6214:529e:b0:6e4:4085:9f72 with SMTP id
 6a1803df08f44-6eb3f26e8c8mr219006596d6.7.1742891824741; Tue, 25 Mar 2025
 01:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250309090708.3928953-1-haoqian.he@smartx.com>
 <20250314101535.1059308-1-haoqian.he@smartx.com>
 <20250314101535.1059308-3-haoqian.he@smartx.com>
 <ho2s47wmeqgeh6otsx4ttqdy3zudgehkokth2ccubsoywzvqhp@mv45e5do5rj7>
 <780BAD55-0C1E-4DE6-92F8-C6203F6CC350@smartx.com>
 <y57skxgavl6g2j6syekaefkgyyfwodj2u7execoo4meky6k2x2@u4gmzfu4cth2>
In-Reply-To: <y57skxgavl6g2j6syekaefkgyyfwodj2u7execoo4meky6k2x2@u4gmzfu4cth2>
From: Haoqian He <haoqian.he@smartx.com>
Date: Tue, 25 Mar 2025 16:36:53 +0800
X-Gm-Features: AQ5f1JqBqTsfGDW0yrFHU_TJ7CK8mpJOrVpMtrMJxV-XNJYgSc695gQOXGQ-k3w
Message-ID: <CAPbyyq8+S9T2d=p5ywRYU5HWdafjTrwFcf4Mk6eiXu4oKA-QzQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] vhost: return failure if stop virtqueue failed in
 vhost_dev_stop
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Li Feng <fengli@smartx.com>, yuhua@smartx.com, 
 Raphael Norwitz <raphael@enfabrica.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "open list:Block layer core" <qemu-block@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2b;
 envelope-from=haoqian.he@smartx.com; helo=mail-qv1-xf2b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

2025=E5=B9=B43=E6=9C=8824=E6=97=A5 22:25=EF=BC=8CStefano Garzarella <sgarza=
re@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A

On Thu, Mar 20, 2025 at 08:21:25PM +0800, Haoqian He wrote:


2025=E5=B9=B43=E6=9C=8819=E6=97=A5 23:11=EF=BC=8CStefano Garzarella <sgarza=
re@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A

On Fri, Mar 14, 2025 at 06:15:33AM -0400, Haoqian He wrote:

The backend maybe crash when vhost_dev_stop and GET_VRING_BASE
would fail, we can return failure to indicate the connection
with the backend is broken.

Signed-off-by: Haoqian He <haoqian.he@smartx.com>
---
hw/virtio/vhost.c         | 27 +++++++++++++++------------
include/hw/virtio/vhost.h |  8 +++++---
2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 6aa72fd434..c82bbbe4cc 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1368,23 +1368,23 @@ fail_alloc_desc:
return r;
}

-void vhost_virtqueue_stop(struct vhost_dev *dev,
-                          struct VirtIODevice *vdev,
-                          struct vhost_virtqueue *vq,
-                          unsigned idx)
+int vhost_virtqueue_stop(struct vhost_dev *dev,
+                         struct VirtIODevice *vdev,
+                         struct vhost_virtqueue *vq,
+                         unsigned idx)
{
int vhost_vq_index =3D dev->vhost_ops->vhost_get_vq_index(dev, idx);
struct vhost_vring_state state =3D {
 .index =3D vhost_vq_index,
};
-    int r;
+    int r =3D 0;

if (virtio_queue_get_desc_addr(vdev, idx) =3D=3D 0) {
 /* Don't stop the virtqueue which might have not been started */
-        return;
+        return 0;
}

-    r =3D dev->vhost_ops->vhost_get_vring_base(dev, &state);
+    r |=3D dev->vhost_ops->vhost_get_vring_base(dev, &state);


We can avoid this and also initialize r to 0.


Here we need to do `vhost_virtqueue_stop` for each vq.


Sorry, my question is what's the point of initializing r to 0 and then
putting it in or here with the result of vhost_get_vring_base?
Can't we leave it as before and initialize it directly here?


Acked.




if (r < 0) {
 VHOST_OPS_DEBUG(r, "vhost VQ %u ring restore failed: %d", idx, r);
 /* Connection to the backend is broken, so let's sync internal
@@ -1412,6 +1412,7 @@ void vhost_virtqueue_stop(struct vhost_dev *dev,
                0, virtio_queue_get_avail_size(vdev, idx));
vhost_memory_unmap(dev, vq->desc, virtio_queue_get_desc_size(vdev, idx),
                0, virtio_queue_get_desc_size(vdev, idx));
+    return r;
}

static int vhost_virtqueue_set_busyloop_timeout(struct vhost_dev *dev,
@@ -2136,9 +2137,10 @@ fail_features:
}

/* Host notifiers must be enabled at this point. */
-void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vring=
s)
+int vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings=
)
{
int i;
+    int rc =3D 0;

/* should only be called after backend is connected */
assert(hdev->vhost_ops);
@@ -2157,10 +2159,10 @@ void vhost_dev_stop(struct vhost_dev *hdev,
VirtIODevice *vdev, bool vrings)
 vhost_dev_set_vring_enable(hdev, false);
}
for (i =3D 0; i < hdev->nvqs; ++i) {
-        vhost_virtqueue_stop(hdev,
-                             vdev,
-                             hdev->vqs + i,
-                             hdev->vq_index + i);
+        rc |=3D vhost_virtqueue_stop(hdev,
+                                   vdev,
+                                   hdev->vqs + i,
+                                   hdev->vq_index + i);


Also other function can fails, should we consider also them?
(e.g. , vhost_dev_set_vring_enable, etc.)

If not, why?


Since we only want to know the return value of callback when the stopping d=
evice
live migration, there is no need to catch the failure of `vhost_dev_start`.


Please add that in the commit message, and maybe also in a comment here.


We can also catch the failure of `vhost_dev_set_vring_enable`, because
`vhost_dev_set_vring_enable` will also fail if qemu lost connection with th=
e
the backend, but I need to test it.


Capturing failures of only some things is a little confusing to me, I
think it needs to be better explained.


Only capture vhost_virtqueue_stop's error based on the following considerat=
ions:

1. `vhost_dev_start` always return 0 when stopping, so there is no need to
capture the error.

2. For `vhost_dev_set_vring_enable`/`vhost_reset_status`, it is necessary t=
o
satisfy that virtio has set certain feature bits (e.g.
VHOST_USER_PROTOCOL_F_STATUS).
Relatively speaking, `vhost_virtqueue_stop` is more universal, if stop
virtiqueue
fails, we will abort the live migration.

3. Even if we capture the error of any function, we cannot return directly,=
 and
we still need to execute the rest of `vhost_dev_stop`.

Thanks,
Haoqian



Thanks,
Stefano



}
if (hdev->vhost_ops->vhost_reset_status) {
 hdev->vhost_ops->vhost_reset_status(hdev);
@@ -2177,6 +2179,7 @@ void vhost_dev_stop(struct vhost_dev *hdev,
VirtIODevice *vdev, bool vrings)
hdev->started =3D false;
vdev->vhost_started =3D false;
hdev->vdev =3D NULL;
+    return rc;
}

int vhost_net_set_backend(struct vhost_dev *hdev,
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index a9469d50bc..fd96ec9c39 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -232,8 +232,10 @@ int vhost_dev_start(struct vhost_dev *hdev,
VirtIODevice *vdev, bool vrings);
* Stop the vhost device. After the device is stopped the notifiers
* can be disabled (@vhost_dev_disable_notifiers) and the device can
* be torn down (@vhost_dev_cleanup).
+ *
+ * Return: 0 on success, !=3D 0 on error when stopping dev.
*/
-void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vring=
s);
+int vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings=
);

/**
* DOC: vhost device configuration handling
@@ -333,8 +335,8 @@ int vhost_device_iotlb_miss(struct vhost_dev *dev,
uint64_t iova, int write);

int vhost_virtqueue_start(struct vhost_dev *dev, struct VirtIODevice *vdev,
                   struct vhost_virtqueue *vq, unsigned idx);
-void vhost_virtqueue_stop(struct vhost_dev *dev, struct VirtIODevice *vdev=
,
-                          struct vhost_virtqueue *vq, unsigned idx);
+int vhost_virtqueue_stop(struct vhost_dev *dev, struct VirtIODevice *vdev,
+                         struct vhost_virtqueue *vq, unsigned idx);

void vhost_dev_reset_inflight(struct vhost_inflight *inflight);
void vhost_dev_free_inflight(struct vhost_inflight *inflight);
--
2.48.1

