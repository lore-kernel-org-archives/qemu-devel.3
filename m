Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE86C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENuI-0001vt-Tj; Tue, 04 Jun 2024 02:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENuD-0001vN-9u
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:44:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENuB-0007DW-Cq
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:44:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iKT6IARhOSF18hfyR8oDplmJ8TdlS5OJky1bfHLBpe8=;
 b=AvXrPEvDyWE58VTmDWNl02R6ORevXqcpJvBHUczoQUosLz4xEyLGZBhLMKTXVDzR1Q5JQh
 n5JkZUYBY79EGXOmWXOXZ9s6sfW8GqyLrLRZXl1tuRAtKmB5Mc9W/tmw7YdPp6nPLCxJ4E
 N68FEi9+jtWjlY32oAsqOfzIluUfJ2E=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-2tHstuVDMKaTewRlsNSNqw-1; Tue, 04 Jun 2024 02:44:18 -0400
X-MC-Unique: 2tHstuVDMKaTewRlsNSNqw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a68eb60d73cso16095266b.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:44:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483456; x=1718088256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iKT6IARhOSF18hfyR8oDplmJ8TdlS5OJky1bfHLBpe8=;
 b=aiSrYuhjznulTkbTfAAduPWWru/pR3nCrXNeFNznXEaNCR0oV+m48+3OxEOe6T+3vF
 o+puOUFgRmq8jTXDWldazJ2zS6Oynhq+7/ALwAimLMaHbh6Dzuss46DK5yqbjWjD/D8e
 45jyvpjq1UG69uqu5ctYtrOG8XN7+BOSfbMfA2mafev8eaE0R4NuTF8HKYBFVz9dgplC
 w4U5Wlx5HC3F3iq4cahEZFbl5PP9o/364o6m+SHpyP8S7UFcBn84sIHXzwiK9bSxvxPl
 fRhZdLuV5EhT+J0fyxJbpcr8vdh6iEs6L7O1hrmouqvhq4LqTdEYGNuGRAiLxGl0Q9I7
 YagA==
X-Gm-Message-State: AOJu0YyZXSj74TnqEzWO9eaNpi6SY9f1I4/Ex1e1ATdksyLuVS6TPw2l
 fRFNiV3PitpW6Ua18wyqv2D5kaY5d0TP+PCPvOC0e+Shdmf4n+VOlj4HtjJICZzxfJS/ZupoyjI
 07VWGIYlxrpQ1f/TCu8G9JeA7BSNbSMcFbVnhKmRO/Qi04qBaZSB2fs+fndqF4nemIHFnfxsR8h
 xCEvaOvPzHBKDBOWK2Jxh62BBMTu6PCv8bbpfd
X-Received: by 2002:a17:906:dfc1:b0:a68:bdab:48e4 with SMTP id
 a640c23a62f3a-a68bdab4adcmr487512066b.1.1717483456421; 
 Mon, 03 Jun 2024 23:44:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWNDABUKVfnf4FRvg8m/OJxoGDEaFsZiCwYDzgItLe5ZtqQxkAe27FYwRMhjA3O2gFdNe4zg==
X-Received: by 2002:a17:906:dfc1:b0:a68:bdab:48e4 with SMTP id
 a640c23a62f3a-a68bdab4adcmr487510666b.1.1717483455699; 
 Mon, 03 Jun 2024 23:44:15 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a67e6f02e45sm587182366b.29.2024.06.03.23.44.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:44:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/45] virtio-blk: remove SCSI passthrough functionality
Date: Tue,  4 Jun 2024 08:43:25 +0200
Message-ID: <20240604064409.957105-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604064409.957105-1-pbonzini@redhat.com>
References: <20240604064409.957105-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The legacy SCSI passthrough functionality has never been enabled for
VIRTIO 1.0 and was deprecated more than four years ago.

Get rid of it---almost, because QEMU is advertising it unconditionally
for legacy virtio-blk devices.  Just parse the header and return a
nonzero status.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/about/deprecated.rst       |  10 --
 docs/about/removed-features.rst |   8 ++
 hw/block/virtio-blk.c           | 166 +++-----------------------------
 hw/core/machine.c               |   2 -
 4 files changed, 19 insertions(+), 167 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 40585ca7d55..4980d721cf4 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -296,16 +296,6 @@ Device options
 Emulated device options
 '''''''''''''''''''''''
 
-``-device virtio-blk,scsi=on|off`` (since 5.0)
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-
-The virtio-blk SCSI passthrough feature is a legacy VIRTIO feature.  VIRTIO 1.0
-and later do not support it because the virtio-scsi device was introduced for
-full SCSI support.  Use virtio-scsi instead when SCSI passthrough is required.
-
-Note this also applies to ``-device virtio-blk-pci,scsi=on|off``, which is an
-alias.
-
 ``-device nvme-ns,eui64-default=on|off`` (since 7.1)
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index fba0cfb0b02..ae6269eb562 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -510,6 +510,14 @@ than zero.
 
 Removed along with the ``compression`` migration capability.
 
+``-device virtio-blk,scsi=on|off`` (since 9.1)
+''''''''''''''''''''''''''''''''''''''''''''''
+
+The virtio-blk SCSI passthrough feature is a legacy VIRTIO feature.  VIRTIO 1.0
+and later do not support it because the virtio-scsi device was introduced for
+full SCSI support.  Use virtio-scsi instead when SCSI passthrough is required.
+
+
 User-mode emulator command line arguments
 -----------------------------------------
 
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index bb86e65f652..73bdfd6122a 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -172,57 +172,6 @@ static void virtio_blk_discard_write_zeroes_complete(void *opaque, int ret)
     virtio_blk_free_request(req);
 }
 
-#ifdef __linux__
-
-typedef struct {
-    VirtIOBlockReq *req;
-    struct sg_io_hdr hdr;
-} VirtIOBlockIoctlReq;
-
-static void virtio_blk_ioctl_complete(void *opaque, int status)
-{
-    VirtIOBlockIoctlReq *ioctl_req = opaque;
-    VirtIOBlockReq *req = ioctl_req->req;
-    VirtIOBlock *s = req->dev;
-    VirtIODevice *vdev = VIRTIO_DEVICE(s);
-    struct virtio_scsi_inhdr *scsi;
-    struct sg_io_hdr *hdr;
-
-    scsi = (void *)req->elem.in_sg[req->elem.in_num - 2].iov_base;
-
-    if (status) {
-        status = VIRTIO_BLK_S_UNSUPP;
-        virtio_stl_p(vdev, &scsi->errors, 255);
-        goto out;
-    }
-
-    hdr = &ioctl_req->hdr;
-    /*
-     * From SCSI-Generic-HOWTO: "Some lower level drivers (e.g. ide-scsi)
-     * clear the masked_status field [hence status gets cleared too, see
-     * block/scsi_ioctl.c] even when a CHECK_CONDITION or COMMAND_TERMINATED
-     * status has occurred.  However they do set DRIVER_SENSE in driver_status
-     * field. Also a (sb_len_wr > 0) indicates there is a sense buffer.
-     */
-    if (hdr->status == 0 && hdr->sb_len_wr > 0) {
-        hdr->status = CHECK_CONDITION;
-    }
-
-    virtio_stl_p(vdev, &scsi->errors,
-                 hdr->status | (hdr->msg_status << 8) |
-                 (hdr->host_status << 16) | (hdr->driver_status << 24));
-    virtio_stl_p(vdev, &scsi->residual, hdr->resid);
-    virtio_stl_p(vdev, &scsi->sense_len, hdr->sb_len_wr);
-    virtio_stl_p(vdev, &scsi->data_len, hdr->dxfer_len);
-
-out:
-    virtio_blk_req_complete(req, status);
-    virtio_blk_free_request(req);
-    g_free(ioctl_req);
-}
-
-#endif
-
 static VirtIOBlockReq *virtio_blk_get_request(VirtIOBlock *s, VirtQueue *vq)
 {
     VirtIOBlockReq *req = virtqueue_pop(vq, sizeof(VirtIOBlockReq));
@@ -233,20 +182,14 @@ static VirtIOBlockReq *virtio_blk_get_request(VirtIOBlock *s, VirtQueue *vq)
     return req;
 }
 
-static int virtio_blk_handle_scsi_req(VirtIOBlockReq *req)
+static void virtio_blk_handle_scsi(VirtIOBlockReq *req)
 {
-    int status = VIRTIO_BLK_S_OK;
-    struct virtio_scsi_inhdr *scsi = NULL;
+    int status;
+    struct virtio_scsi_inhdr *scsi;
     VirtIOBlock *blk = req->dev;
     VirtIODevice *vdev = VIRTIO_DEVICE(blk);
     VirtQueueElement *elem = &req->elem;
 
-#ifdef __linux__
-    int i;
-    VirtIOBlockIoctlReq *ioctl_req;
-    BlockAIOCB *acb;
-#endif
-
     /*
      * We require at least one output segment each for the virtio_blk_outhdr
      * and the SCSI command block.
@@ -262,95 +205,16 @@ static int virtio_blk_handle_scsi_req(VirtIOBlockReq *req)
     /*
      * The scsi inhdr is placed in the second-to-last input segment, just
      * before the regular inhdr.
+     *
+     * Just put anything nonzero so that the ioctl fails in the guest.
      */
     scsi = (void *)elem->in_sg[elem->in_num - 2].iov_base;
-
-    if (!virtio_has_feature(blk->host_features, VIRTIO_BLK_F_SCSI)) {
-        status = VIRTIO_BLK_S_UNSUPP;
-        goto fail;
-    }
-
-    /*
-     * No support for bidirection commands yet.
-     */
-    if (elem->out_num > 2 && elem->in_num > 3) {
-        status = VIRTIO_BLK_S_UNSUPP;
-        goto fail;
-    }
-
-#ifdef __linux__
-    ioctl_req = g_new0(VirtIOBlockIoctlReq, 1);
-    ioctl_req->req = req;
-    ioctl_req->hdr.interface_id = 'S';
-    ioctl_req->hdr.cmd_len = elem->out_sg[1].iov_len;
-    ioctl_req->hdr.cmdp = elem->out_sg[1].iov_base;
-    ioctl_req->hdr.dxfer_len = 0;
-
-    if (elem->out_num > 2) {
-        /*
-         * If there are more than the minimally required 2 output segments
-         * there is write payload starting from the third iovec.
-         */
-        ioctl_req->hdr.dxfer_direction = SG_DXFER_TO_DEV;
-        ioctl_req->hdr.iovec_count = elem->out_num - 2;
-
-        for (i = 0; i < ioctl_req->hdr.iovec_count; i++) {
-            ioctl_req->hdr.dxfer_len += elem->out_sg[i + 2].iov_len;
-        }
-
-        ioctl_req->hdr.dxferp = elem->out_sg + 2;
-
-    } else if (elem->in_num > 3) {
-        /*
-         * If we have more than 3 input segments the guest wants to actually
-         * read data.
-         */
-        ioctl_req->hdr.dxfer_direction = SG_DXFER_FROM_DEV;
-        ioctl_req->hdr.iovec_count = elem->in_num - 3;
-        for (i = 0; i < ioctl_req->hdr.iovec_count; i++) {
-            ioctl_req->hdr.dxfer_len += elem->in_sg[i].iov_len;
-        }
-
-        ioctl_req->hdr.dxferp = elem->in_sg;
-    } else {
-        /*
-         * Some SCSI commands don't actually transfer any data.
-         */
-        ioctl_req->hdr.dxfer_direction = SG_DXFER_NONE;
-    }
-
-    ioctl_req->hdr.sbp = elem->in_sg[elem->in_num - 3].iov_base;
-    ioctl_req->hdr.mx_sb_len = elem->in_sg[elem->in_num - 3].iov_len;
-
-    acb = blk_aio_ioctl(blk->blk, SG_IO, &ioctl_req->hdr,
-                        virtio_blk_ioctl_complete, ioctl_req);
-    if (!acb) {
-        g_free(ioctl_req);
-        status = VIRTIO_BLK_S_UNSUPP;
-        goto fail;
-    }
-    return -EINPROGRESS;
-#else
-    abort();
-#endif
+    virtio_stl_p(vdev, &scsi->errors, 255);
+    status = VIRTIO_BLK_S_UNSUPP;
 
 fail:
-    /* Just put anything nonzero so that the ioctl fails in the guest.  */
-    if (scsi) {
-        virtio_stl_p(vdev, &scsi->errors, 255);
-    }
-    return status;
-}
-
-static void virtio_blk_handle_scsi(VirtIOBlockReq *req)
-{
-    int status;
-
-    status = virtio_blk_handle_scsi_req(req);
-    if (status != -EINPROGRESS) {
-        virtio_blk_req_complete(req, status);
-        virtio_blk_free_request(req);
-    }
+    virtio_blk_req_complete(req, status);
+    virtio_blk_free_request(req);
 }
 
 static inline void submit_requests(VirtIOBlock *s, MultiReqBuffer *mrb,
@@ -1379,13 +1243,9 @@ static uint64_t virtio_blk_get_features(VirtIODevice *vdev, uint64_t features,
     virtio_add_feature(&features, VIRTIO_BLK_F_GEOMETRY);
     virtio_add_feature(&features, VIRTIO_BLK_F_TOPOLOGY);
     virtio_add_feature(&features, VIRTIO_BLK_F_BLK_SIZE);
-    if (virtio_has_feature(features, VIRTIO_F_VERSION_1)) {
-        if (virtio_has_feature(s->host_features, VIRTIO_BLK_F_SCSI)) {
-            error_setg(errp, "Please set scsi=off for virtio-blk devices in order to use virtio 1.0");
-            return 0;
-        }
-    } else {
+    if (!virtio_has_feature(features, VIRTIO_F_VERSION_1)) {
         virtio_clear_feature(&features, VIRTIO_F_ANY_LAYOUT);
+        /* Added for historical reasons, removing it could break migration.  */
         virtio_add_feature(&features, VIRTIO_BLK_F_SCSI);
     }
 
@@ -2132,10 +1992,6 @@ static Property virtio_blk_properties[] = {
     DEFINE_PROP_STRING("serial", VirtIOBlock, conf.serial),
     DEFINE_PROP_BIT64("config-wce", VirtIOBlock, host_features,
                       VIRTIO_BLK_F_CONFIG_WCE, true),
-#ifdef __linux__
-    DEFINE_PROP_BIT64("scsi", VirtIOBlock, host_features,
-                      VIRTIO_BLK_F_SCSI, false),
-#endif
     DEFINE_PROP_BIT("request-merging", VirtIOBlock, conf.request_merging, 0,
                     true),
     DEFINE_PROP_UINT16("num-queues", VirtIOBlock, conf.num_queues,
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 8087026b45d..17292b13e62 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -265,8 +265,6 @@ GlobalProperty hw_compat_2_5[] = {
 const size_t hw_compat_2_5_len = G_N_ELEMENTS(hw_compat_2_5);
 
 GlobalProperty hw_compat_2_4[] = {
-    /* Optional because the 'scsi' property is Linux-only */
-    { "virtio-blk-device", "scsi", "true", .optional = true },
     { "e1000", "extra_mac_registers", "off" },
     { "virtio-pci", "x-disable-pcie", "on" },
     { "virtio-pci", "migrate-extra", "off" },
-- 
2.45.1


