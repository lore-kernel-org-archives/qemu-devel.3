Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CBEEA7942
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:07:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniCG-0004Ee-Mi; Wed, 04 Feb 2026 14:05:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniB8-0002xs-Jc
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniB6-0008Ca-MU
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wGXvf5fY+VkV3ljpaQjbHmq0FJ5IzXTjQ9EoEMpxP6A=;
 b=D3KmPdBNg1x8+Vfmcu/DW1uoOQO3P8vc+S2j8lZh47Tcgws/0QA8HmE99jj7Yh7Z+n0EKT
 jSEoXQf44p5vWQRaE/ERgXJ4YQql5kt1Wqru22irrQxmuduTJkhdWGL9cy7JJ+Q8YWz+uR
 MrPxgb/H5P0R2BLnl/yv8s53ILEu7wU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592--6PE_Z1sP4K2yFkN8ymoFQ-1; Wed, 04 Feb 2026 14:04:38 -0500
X-MC-Unique: -6PE_Z1sP4K2yFkN8ymoFQ-1
X-Mimecast-MFC-AGG-ID: -6PE_Z1sP4K2yFkN8ymoFQ_1770231877
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4361765dc85so26585f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231877; x=1770836677; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wGXvf5fY+VkV3ljpaQjbHmq0FJ5IzXTjQ9EoEMpxP6A=;
 b=ZxNbjnrf5TyV+lDrwegVU+IrWR97nCChStYYZHKXsvd9G8yeG7t0Vls0w1C4yYkNRH
 K3q8UU6CwsS1P+luhiT7YydS5tahpDGhZn2WUnwCIZqQFhPk334uAIpLcMXZ5GfsH2sY
 R04hJo2cjQ+5mZa5FacgzTH9DHlGMUGdd2NASwiaMifNAGTX4da+1HpIdvIRZAHBIE1/
 FMBIzvjEudomqBN76nKLbRk4hYuwctTrS7ajHzAUogFv0JCT7FzbP9QB+jts8LNucEc4
 S7CGjcTABXoHuep/b0ndQR6FSwNvf+BO4y+Zx6+PIvaMvgUKyOX90BCUeMMB31//aLvx
 deJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231877; x=1770836677;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wGXvf5fY+VkV3ljpaQjbHmq0FJ5IzXTjQ9EoEMpxP6A=;
 b=ol+E+yLXRpgRctPxB8pF6oqgspPPzjWNXNyLBnvxk1vXFgW9UFkAx+1aAQFfhHdUJQ
 Q/FVohGvCMHkhxNaRvrzwdymQAaEg9EGmmTZq5ZCRaegbpv0KjotCn/ui8Bu2pJJfiyR
 3UqvRNC86K6a0Yly4a6NFhoWrbUQPP8jXK1rMoDXkuXPv9Wa7Wd28UXdu0a9lBRda5jn
 wgANiJTidpiWxpK+pgu5fngt1AeaqWHRMH43rdQifJY8es1OsqFPd8t93NegwFUn89m4
 9ziN2GQSHUxAynn06/ZoOEve9FD/aR4/wzdMe+aC/waR49ycUQVmjKoutB90Iuus63V7
 KR/g==
X-Gm-Message-State: AOJu0Yy7Pl5R3r83xuAtTlEMpK/wHqpnR+Wqec7YTB99HUkygyOk2eSh
 wSz3ROsWsWzLi8MrFWQX2Q/Eawqf0uLIApnZBPOo7X04qRMGcQx8gPP0FyrCnlgRJcuLNyoexsL
 /nL+2rXrSsbP1S1pVuqqrUxt1DjEfNClqpH8WVOdqBaHgaPQMc6PAaAbQ1rtt0paZ+5on0qHQIz
 e8UPR8dIOAUCicFmztDFfPUYm7IUpJKRsVOA==
X-Gm-Gg: AZuq6aJzk926KvPuw/oLTidfZPqexp29BOX24m4NFrfJbcqwdmEWiwSADCXZmjtnSv7
 9y9Zetqjk+CoqA0HIZQkSweb7rtVOp8YVOXGzKUzr7sFZjnCnUop09Hz2VUko+Q00gyiYy3UWgf
 M9dyMC3/ngrYCdbHvDyUYdBPL1BZ6rmg406YKGFYbvZNGHVbTE1LQkoAHyoQpGJhDXHddm/CO6r
 uwjYU3iD1fbH/KJb8uWs0hGLvOzUc4grq+mFukxf/rwPLi8bCUxgeUVhjZzWdrdIvIUBIOpixPM
 Z+nbkXOz1FIJ/6mJYvtteWdz9IkyBDOxjla9txxod5akcyenIiCdXXaWZXNgx7Db2Ibb6AA4lOK
 BXNw9Zy5MLo24tlRL8uIAm2XH7FPng1Ztaw==
X-Received: by 2002:a05:6000:230a:b0:436:684:b94a with SMTP id
 ffacd0b85a97d-43617e346demr5598179f8f.4.1770231876761; 
 Wed, 04 Feb 2026 11:04:36 -0800 (PST)
X-Received: by 2002:a05:6000:230a:b0:436:684:b94a with SMTP id
 ffacd0b85a97d-43617e346demr5598128f8f.4.1770231876282; 
 Wed, 04 Feb 2026 11:04:36 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43617e38e38sm8599989f8f.11.2026.02.04.11.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:04:35 -0800 (PST)
Date: Wed, 4 Feb 2026 14:04:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 46/51] vhost-user: introduce protocol feature for skip drain
 on GET_VRING_BASE
Message-ID: <891e89735f87ebcf80f0e939a0d4005e7f1bf935.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Add vhost-user protocol feature
VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT

Now on GET_VRING_BASE this feature can control whether to wait for
in-flight requests to complete or not.
Also we have to validate that this feature will be enabled only when
qemu and back-end supports in-flight buffer and in-flight migration

It will be helpfull in future for in-flight requests migration in
vhost-user devices.

Update docs, add ref to label for inflight-io-tracking

Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260115081103.655749-3-dtalexundeer@yandex-team.ru>
---
 docs/interop/vhost-user.rst    | 59 +++++++++++++++++++++-------------
 hw/virtio/vhost-user.c         |  7 ++++
 include/hw/virtio/vhost-user.h |  2 ++
 3 files changed, 46 insertions(+), 22 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 505f8d3a33..137c9f3669 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -743,6 +743,8 @@ negotiated, back-end can send file descriptors (at most 8 descriptors in
 each message) to front-end via ancillary data using this fd communication
 channel.
 
+.. _inflight_io_tracking:
+
 Inflight I/O tracking
 ---------------------
 
@@ -1040,26 +1042,27 @@ Protocol features
 
 .. code:: c
 
-  #define VHOST_USER_PROTOCOL_F_MQ                    0
-  #define VHOST_USER_PROTOCOL_F_LOG_SHMFD             1
-  #define VHOST_USER_PROTOCOL_F_RARP                  2
-  #define VHOST_USER_PROTOCOL_F_REPLY_ACK             3
-  #define VHOST_USER_PROTOCOL_F_MTU                   4
-  #define VHOST_USER_PROTOCOL_F_BACKEND_REQ           5
-  #define VHOST_USER_PROTOCOL_F_CROSS_ENDIAN          6
-  #define VHOST_USER_PROTOCOL_F_CRYPTO_SESSION        7
-  #define VHOST_USER_PROTOCOL_F_PAGEFAULT             8
-  #define VHOST_USER_PROTOCOL_F_CONFIG                9
-  #define VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD      10
-  #define VHOST_USER_PROTOCOL_F_HOST_NOTIFIER        11
-  #define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD       12
-  #define VHOST_USER_PROTOCOL_F_RESET_DEVICE         13
-  #define VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS 14
-  #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
-  #define VHOST_USER_PROTOCOL_F_STATUS               16
-  #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
-  #define VHOST_USER_PROTOCOL_F_SHARED_OBJECT        18
-  #define VHOST_USER_PROTOCOL_F_DEVICE_STATE         19
+  #define VHOST_USER_PROTOCOL_F_MQ                       0
+  #define VHOST_USER_PROTOCOL_F_LOG_SHMFD                1
+  #define VHOST_USER_PROTOCOL_F_RARP                     2
+  #define VHOST_USER_PROTOCOL_F_REPLY_ACK                3
+  #define VHOST_USER_PROTOCOL_F_MTU                      4
+  #define VHOST_USER_PROTOCOL_F_BACKEND_REQ              5
+  #define VHOST_USER_PROTOCOL_F_CROSS_ENDIAN             6
+  #define VHOST_USER_PROTOCOL_F_CRYPTO_SESSION           7
+  #define VHOST_USER_PROTOCOL_F_PAGEFAULT                8
+  #define VHOST_USER_PROTOCOL_F_CONFIG                   9
+  #define VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD         10
+  #define VHOST_USER_PROTOCOL_F_HOST_NOTIFIER           11
+  #define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD          12
+  #define VHOST_USER_PROTOCOL_F_RESET_DEVICE            13
+  #define VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS    14
+  #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS     15
+  #define VHOST_USER_PROTOCOL_F_STATUS                  16
+  #define VHOST_USER_PROTOCOL_F_XEN_MMAP                17
+  #define VHOST_USER_PROTOCOL_F_SHARED_OBJECT           18
+  #define VHOST_USER_PROTOCOL_F_DEVICE_STATE            19
+  #define VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT 20
 
 Front-end message types
 -----------------------
@@ -1250,12 +1253,24 @@ Front-end message types
 
   When and as long as all of a device's vrings are stopped, it is
   *suspended*, see :ref:`Suspended device state
-  <suspended_device_state>`. The back-end must complete all inflight I/O
-  requests for the specified vring before stopping it.
+  <suspended_device_state>`.
 
   The request payload's *num* field is currently reserved and must be
   set to 0.
 
+  By default, the back-end must complete all inflight I/O requests for the
+  specified vring before stopping it.
+
+  If the ``VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT`` protocol
+  feature has been negotiated, the back-end may suspend in-flight I/O
+  requests and record them as described in :ref:`Inflight I/O tracking
+  <inflight_io_tracking>` instead of completing them before stopping the vring.
+  How to suspend an in-flight request depends on the implementation of the back-end
+  but it typically can be done by aborting or cancelling the underlying I/O
+  request. The ``VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT``
+  protocol feature must only be neogotiated if
+  ``VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD`` is also negotiated.
+
 ``VHOST_USER_SET_VRING_KICK``
   :id: 12
   :equivalent ioctl: ``VHOST_SET_VRING_KICK``
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 63fa9a1b4b..bb8f8eab77 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -2225,6 +2225,13 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
             }
         }
 
+        if (!u->user->supports_inflight_migration ||
+            !virtio_has_feature(protocol_features,
+                                VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
+            protocol_features &= ~(1ULL <<
+                               VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT);
+        }
+
         /* final set of protocol features */
         dev->protocol_features = protocol_features;
         err = vhost_user_set_protocol_features(dev, dev->protocol_features);
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index 55d5725ef8..53fe996686 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -32,6 +32,7 @@ enum VhostUserProtocolFeature {
     /* Feature 17 reserved for VHOST_USER_PROTOCOL_F_XEN_MMAP. */
     VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 18,
     VHOST_USER_PROTOCOL_F_DEVICE_STATE = 19,
+    VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT = 20,
     VHOST_USER_PROTOCOL_F_MAX
 };
 
@@ -68,6 +69,7 @@ typedef struct VhostUserState {
     GPtrArray *notifiers;
     int memory_slots;
     bool supports_config;
+    bool supports_inflight_migration;
 } VhostUserState;
 
 /**
-- 
MST


