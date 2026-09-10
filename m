Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC9EC88E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 00:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4oo6-0008IG-R8; Thu, 10 Sep 2026 20:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lVZ-0006NE-Ke
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:36:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lVC-0004Rs-67
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PrmVKhf1ZqItkbl69E27fCItqDxIsRZDaNMDTiAOj/M=;
 b=Bi6nX/gn/LiRofArsrcIxYrH8c6DS2vaHoDRiitK7ThZCVs+ExDutd8MCxCbvPpnTRZZkS
 OVKilDpV2yuQNYyUUY7gwf+RDJtKkjACrYif2qo3aghv1C7YqLAKLSZ8UIm+KCrYHDhIqw
 IEPc6iLFzodlxa2tHuKCLkhAsva/cNo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-WjMrQXXdMj2miHKtZTaFpg-1; Thu, 10 Sep 2026 16:15:45 -0400
X-MC-Unique: WjMrQXXdMj2miHKtZTaFpg-1
X-Mimecast-MFC-AGG-ID: WjMrQXXdMj2miHKtZTaFpg_1789071344
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49545071724so2496465e9.0
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071344; x=1789676144; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PrmVKhf1ZqItkbl69E27fCItqDxIsRZDaNMDTiAOj/M=;
 b=WLWIhqSuGb/6/4NLvjCH0cX82J4qiDQhxZ3d08n9ZHD9/d2SlpCqAuQcvX8L3ss43E
 9bxllUc8hlFhqPdxlttMdGkDm3x/rXKnXTf1avMowEgKZI/elwBzChkLD0Z9/tJ30NrA
 KvamgDOUJOWH8fvXI3ik49NuQWjsUJJNhF+fI71OWuEjHUPfmIk/K7FEg/3/XJdTR8yE
 Dyhyou1u2QPNOs1pyf7ue03cmhJEwxnosxgbDhAzznxoBbHAA+kS6GZnhHAGlwkE8FIy
 SZNrWsd4U8cNNcon+qkKsCroo9YsaNkP1VuDd3eFXekoVotDyrR3TrSo36tJcqZ5ION1
 ShYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071344; x=1789676144;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PrmVKhf1ZqItkbl69E27fCItqDxIsRZDaNMDTiAOj/M=;
 b=ffujs1qW9d3gXhe2xxxxfjgJ7rERqfNZQH2AWASpUxWgXD8EIpegxPWQ8RV8aJOdV9
 tBjpIQE5/qv2cxeRAdTkplir/dL2mTkAZuKWROBOKoB/pof5zuWy6+OMMoOdt/vXO0ge
 Pd5eaANbv1Vkt2m1BMVl+hSSntcKm+uPzUqu10Mn+lQDs7g61GSwfoU0rKt+g57fdrh2
 hfdd5gICwxi2xIUjVObEHSwjny3HWUUQVG+RgzD25733srNxy1p6F93ioZaejJPM5x+M
 d/msVH+Ag9zv2Dn5XANz8nH8rJw1+Jjb3KLs5gIxRTh72Z3PXRGgUeE93NhUGqlWaT1h
 l2jA==
X-Gm-Message-State: AFuF++lsxaGchsov6oNb3AZFVNUEom6kD53q1tbuXranTir5NysnRDe1
 Yz/N17KDEZGOd5wiDFc+wmNckl9//JuslPNRpDZJ41zvEwizDCi9RrOjldPzayG3L5K40yFPda4
 BI16D+KPwub5XAB8BRHyrTVzz9YBWAV1doKsRXt5vGN5wHbRS7e+BzHlV9pb5ARltLcy0pfEPem
 442xHvO3rJyPIdmCMPTeqUgEJYZ4476Mh2dg==
X-Gm-Gg: AYBFou3Wyt6dg6yYto1OKbmjDiwlhVsOIs8wgwsEH2rMmHnJXlTUTIpgFOsMzOoIeMp
 EzRedaX4eIJereEvFCeIuiC0oGcqQDnsQ0vGFK3KQA+0+0ahh63UH03r9OFd9nRW4JudLmUyqx0
 2Xhgi1D/pIxcXuBieWdfw8TqKpIVlPVX/e+e0g9kT46dPKtAYFkCmcLUPnCSZ8InGisyfZ8CCc3
 Vu/CmKPm/TDQDA1Z1pWR/kGMvXGjvWhhclES8NhP5iLuGgdoymZwAxy3MouNQ31fIziEm/ZeenA
 YLCmgyTvhAo+0tv0S9dByLKnyMjhwXTKBRQBn8gI6uuEqassDD91xbx8/8wT67BnD3YAG34iXY0
 wrhyM7RzgXdAE5P3N+sF1xdg=
X-Received: by 2002:a05:600c:4fc8:b0:49c:cedc:3c36 with SMTP id
 5b1f17b1804b1-49e619bd0femr8042605e9.16.1789071343294; 
 Thu, 10 Sep 2026 13:15:43 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc8:b0:49c:cedc:3c36 with SMTP id
 5b1f17b1804b1-49e619bd0femr8042115e9.16.1789071342731; 
 Thu, 10 Sep 2026 13:15:42 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26be3e0asm101087005e9.1.2026.09.10.13.15.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:15:42 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:15:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 85/90] vhost-user: add GET_VRING_BASE_SKIP_DRAIN message
Message-ID: <6a9a8d689a6f1681dfba47ffeb05a3691d4c4037.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>

VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT was introduced to allow
the back-end to suspend in-flight I/O during GET_VRING_BASE instead of
draining it, enabling live migration of in-flight requests. However,
this behaviour is tied to the protocol feature itself - once negotiated,
there is no way for the front-end to tell the back-end to fall back to
the normal drain behaviour on a per-stop basis.

Introduce a separate message VHOST_USER_GET_VRING_BASE_SKIP_DRAIN
(id=45) guarded by a new protocol feature
VHOST_USER_PROTOCOL_F_GET_VRING_BASE_SKIP_DRAIN. The message is
identical to GET_VRING_BASE except that the back-end must immediately suspend all
in-flight I/O and record it in the inflight region. This way the
front-end has explicit per-call control: send GET_VRING_BASE for normal drain,
send GET_VRING_BASE_SKIP_DRAIN when immediate suspend is needed.

The new feature requires both
VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT
and VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD to be negotiated.

Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260803072853.2920007-3-dtalexundeer@yandex-team.ru>
---
 docs/interop/vhost-user.rst       | 42 ++++++++++++++++++++---------
 include/hw/virtio/vhost-backend.h |  1 +
 include/hw/virtio/vhost-user.h    |  1 +
 hw/virtio/vhost-user.c            | 44 +++++++++++++++++++++++++++----
 hw/virtio/vhost.c                 |  2 +-
 5 files changed, 72 insertions(+), 18 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index fbfb9d01c6..c1e02ff7e9 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -457,6 +457,7 @@ replies, except for the following requests:
 * ``VHOST_USER_GET_FEATURES``
 * ``VHOST_USER_GET_PROTOCOL_FEATURES``
 * ``VHOST_USER_GET_VRING_BASE``
+* ``VHOST_USER_GET_VRING_BASE_SKIP_DRAIN``
 * ``VHOST_USER_SET_LOG_BASE`` (if ``VHOST_USER_PROTOCOL_F_LOG_SHMFD``)
 * ``VHOST_USER_GET_INFLIGHT_FD`` (if ``VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD``)
 
@@ -533,7 +534,7 @@ Rings have two independent states: started/stopped, and enabled/disabled.
 Each ring is initialized in a stopped and disabled state.  Rings are started
 with ``VHOST_USER_SET_VRING_KICK`` (or ``VHOST_USER_VRING_KICK`` if
 ``VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS`` is negotiated) and stopped with
-``VHOST_USER_GET_VRING_BASE``.  A stopped ring enters the started state again
+``VHOST_USER_GET_VRING_BASE`` or ``VHOST_USER_GET_VRING_BASE_SKIP_DRAIN``.  A stopped ring enters the started state again
 with ``VHOST_USER_SET_VRING_KICK`` (or ``VHOST_USER_VRING_KICK`` if
 ``VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS`` is negotiated) and the back-end
 resumes processing requests.
@@ -1159,6 +1160,7 @@ Protocol features
   #define VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT 20
   #define VHOST_USER_PROTOCOL_F_GPA_ADDRESSES           21
   #define VHOST_USER_PROTOCOL_F_SHMEM                   22
+  #define VHOST_USER_PROTOCOL_F_GET_VRING_BASE_SKIP_DRAIN 23
 
 Front-end message types
 -----------------------
@@ -1355,17 +1357,11 @@ Front-end message types
   set to 0.
 
   By default, the back-end must complete all inflight I/O requests for the
-  specified vring before stopping it.
-
-  If the ``VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT`` protocol
-  feature has been negotiated, the back-end may suspend in-flight I/O
-  requests and record them as described in :ref:`Inflight I/O tracking
-  <inflight_io_tracking>` instead of completing them before stopping the vring.
-  How to suspend an in-flight request depends on the implementation of the back-end
-  but it typically can be done by aborting or cancelling the underlying I/O
-  request. The ``VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT``
-  protocol feature must only be negotiated if
-  ``VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD`` is also negotiated.
+  specified vring before stopping it. If the
+  ``VHOST_USER_PROTOCOL_F_GET_VRING_BASE_SKIP_DRAIN`` protocol feature has
+  been negotiated, the front-end may instead use
+  ``VHOST_USER_GET_VRING_BASE_SKIP_DRAIN`` to request the back-end to
+  suspend in-flight I/O immediately.
 
 ``VHOST_USER_SET_VRING_KICK``
   :id: 12
@@ -1868,6 +1864,28 @@ Front-end message types
 
   * The size may be 0 if the region is unused.
 
+``VHOST_USER_GET_VRING_BASE_SKIP_DRAIN``
+  :id: 45
+  :equivalent ioctl: N/A
+  :request payload: vring state description
+  :reply payload: vring descriptor index/indices
+
+  This message requires the ``VHOST_USER_PROTOCOL_F_GET_VRING_BASE_SKIP_DRAIN``
+  protocol feature to be negotiated.
+
+  Identical to ``VHOST_USER_GET_VRING_BASE`` except that the back-end
+  must not wait for inflight I/O requests to complete before stopping
+  the vring.  Instead, the back-end must immediately suspend all
+  in-flight I/O requests and record them as described in
+  :ref:`Inflight I/O tracking <inflight_io_tracking>`. How to suspend
+  an in-flight request depends on the implementation of the back-end,
+  but it typically can be done by aborting or cancelling the underlying
+  I/O request.
+
+  The ``VHOST_USER_PROTOCOL_F_GET_VRING_BASE_SKIP_DRAIN`` protocol feature
+  must only be negotiated if both ``VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT``
+  and ``VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD`` are also negotiated.
+
 Back-end message types
 ----------------------
 
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index 6c949e6a38..2333fddacd 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -190,6 +190,7 @@ typedef struct VhostOps {
     vhost_set_vring_num_op vhost_set_vring_num;
     vhost_set_vring_base_op vhost_set_vring_base;
     vhost_get_vring_base_op vhost_get_vring_base;
+    vhost_get_vring_base_op vhost_get_vring_base_skip_drain;
     vhost_set_vring_kick_op vhost_set_vring_kick;
     vhost_set_vring_call_op vhost_set_vring_call;
     vhost_set_vring_err_op vhost_set_vring_err;
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index 06c360af18..47c13f8677 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -36,6 +36,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT = 20,
     VHOST_USER_PROTOCOL_F_GPA_ADDRESSES = 21,
     VHOST_USER_PROTOCOL_F_SHMEM = 22,
+    VHOST_USER_PROTOCOL_F_GET_VRING_BASE_SKIP_DRAIN = 23,
     VHOST_USER_PROTOCOL_F_MAX
 };
 
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index f737a05d07..faf9c8aedd 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -101,6 +101,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_SET_DEVICE_STATE_FD = 42,
     VHOST_USER_CHECK_DEVICE_STATE = 43,
     VHOST_USER_GET_SHMEM_CONFIG = 44,
+    VHOST_USER_GET_VRING_BASE_SKIP_DRAIN = 45,
     VHOST_USER_MAX
 } VhostUserRequest;
 
@@ -167,6 +168,7 @@ static const char *vhost_req_name(VhostUserRequest req)
     VHOST_USER_CASE(GET_SHARED_OBJECT)
     VHOST_USER_CASE(SET_DEVICE_STATE_FD)
     VHOST_USER_CASE(CHECK_DEVICE_STATE)
+    VHOST_USER_CASE(GET_VRING_BASE_SKIP_DRAIN)
     default:
         return "<unknown>";
     }
@@ -1409,12 +1411,18 @@ static VhostUserHostNotifier *fetch_notifier(VhostUserState *u,
     return g_ptr_array_index(u->notifiers, idx);
 }
 
-static int vhost_user_get_vring_base(struct vhost_dev *dev,
-                                     struct vhost_vring_state *ring)
+static int get_vring_base(struct vhost_dev *dev,
+                          struct vhost_vring_state *ring,
+                          bool skip_drain)
 {
     int ret;
+    int request = VHOST_USER_GET_VRING_BASE;
+    if (skip_drain) {
+        request = VHOST_USER_GET_VRING_BASE_SKIP_DRAIN;
+    }
+
     VhostUserMsg msg = {
-        .hdr.request = VHOST_USER_GET_VRING_BASE,
+        .hdr.request = request,
         .hdr.flags = VHOST_USER_VERSION,
         .payload.state = *ring,
         .hdr.size = sizeof(msg.payload.state),
@@ -1434,9 +1442,9 @@ static int vhost_user_get_vring_base(struct vhost_dev *dev,
         return ret;
     }
 
-    if (msg.hdr.request != VHOST_USER_GET_VRING_BASE) {
+    if (msg.hdr.request != request) {
         error_report("Received unexpected msg type. Expected %d received %d",
-                     VHOST_USER_GET_VRING_BASE, msg.hdr.request);
+                     request, msg.hdr.request);
         return -EPROTO;
     }
 
@@ -1450,6 +1458,25 @@ static int vhost_user_get_vring_base(struct vhost_dev *dev,
     return 0;
 }
 
+static int vhost_user_get_vring_base(struct vhost_dev *dev,
+                                     struct vhost_vring_state *ring)
+{
+    return get_vring_base(dev, ring, false);
+}
+
+static int vhost_user_get_vring_base_skip_drain(struct vhost_dev *dev,
+                                     struct vhost_vring_state *ring)
+{
+    bool skip_drain_supported = vhost_user_has_protocol_feature(dev,
+                               VHOST_USER_PROTOCOL_F_GET_VRING_BASE_SKIP_DRAIN);
+
+    if (!skip_drain_supported) {
+        return 0;
+    }
+
+    return get_vring_base(dev, ring, true);
+}
+
 static int vhost_set_vring_file(struct vhost_dev *dev,
                                 VhostUserRequest request,
                                 struct vhost_vring_file *file)
@@ -2578,6 +2605,12 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
                                VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT);
         }
 
+        if (!virtio_has_feature(protocol_features,
+                             VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT)) {
+            protocol_features &= ~(1ULL <<
+                             VHOST_USER_PROTOCOL_F_GET_VRING_BASE_SKIP_DRAIN);
+        }
+
         /* final set of protocol features */
         u->protocol_features = protocol_features;
         err = vhost_user_set_protocol_features(dev, u->protocol_features);
@@ -3436,6 +3469,7 @@ const VhostOps user_ops = {
         .vhost_set_vring_num = vhost_user_set_vring_num,
         .vhost_set_vring_base = vhost_user_set_vring_base,
         .vhost_get_vring_base = vhost_user_get_vring_base,
+        .vhost_get_vring_base_skip_drain = vhost_user_get_vring_base_skip_drain,
         .vhost_set_vring_kick = vhost_user_set_vring_kick,
         .vhost_set_vring_call = vhost_user_set_vring_call,
         .vhost_set_vring_err = vhost_user_set_vring_err,
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 17b36366dc..27c78ffabf 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1515,7 +1515,7 @@ static int do_vhost_virtqueue_stop(struct vhost_dev *dev,
 {
     if (skip_drain) {
         assert(vhost_user_has_protocol_feature(dev,
-               VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT));
+               VHOST_USER_PROTOCOL_F_GET_VRING_BASE_SKIP_DRAIN));
     }
     int vhost_vq_index = dev->vhost_ops->vhost_get_vq_index(dev, idx);
     struct vhost_vring_state state = {
-- 
MST


