Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D94C5DF7E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 05:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwC7y-0005EK-75; Tue, 18 Aug 2026 01:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wwC7w-0005DY-4D
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 01:12:44 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wwC7u-0003nN-BP
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 01:12:43 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-84a2dcede83so5727344b3a.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 22:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787029961; x=1787634761; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IHrCv6J+A3qCWiBl5PFq1mBDnBGg+HWYNp3CHH4h1QI=;
 b=KyBzCnhXhP0vaA230LVV//JOL05KXDfek8kSK/oNNQSFQaZLeP40vgAvoq98BuVMVp
 av7cVklpnBV+yhK6ZhPn1OXdhEu37e9Z5ET3sIdMDB2pYSt+lzn9xHqXPmEtyBW0PpLR
 hfrGsjJrLMacAfRccUHXaizikYhZG7cxy7xdQqHqsw+KX2uzTqqaSQ+YNLgKPnQpDN99
 DBQukNmFvRMN4uLQCqUmqxH9bm6cRa0t1WB7X7Wg5Z3HXEV9wTh0OdjyE7s/D5G5aD2v
 F31TEpxiMNuwEMJtGnqlXntD4gYIhOvWIPVOF6i7CzuiGAP2K4yY/Kiic9SrM3qqlpls
 V7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787029961; x=1787634761;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IHrCv6J+A3qCWiBl5PFq1mBDnBGg+HWYNp3CHH4h1QI=;
 b=LO6XQH3TY5jZu3gZ0T3aWh07Rr6KokfPgctc2FYmGrJDf2iuwORhMXz8T0LJ8r3UZW
 j7uJ02FhCGN7ADhmCiMVHtpfj1bC/uL8WlKpsXbMh/R0dsgSMy77ZwNJlmzHC2cPiA4f
 oEajLaG7P6tIuChv11MTQPhiAhOZLPJgqIg+iT/z7kWGOgjQLyK5lAyMi0QYxrw4xusk
 5Ido/EgrBrMlK3xpzuraVBXXhCLOgxyjsovlauaVMJ1rSK4fOCsu/QSktosq5phVoa3B
 E5V4FMSdWvPFUne3oeTBwtSGdl+bYa8WJyvClFQN/VJM81IfyjqRGdfPqX92Fdz3bVUX
 Vc7w==
X-Gm-Message-State: AOJu0YwGtVuJil4dB4EWJ2MXv3jZoihUR5xqlYHaIvk5NLPQxnMj2yNE
 KF5gHGpZvAv3mJomDo7TLFu5XP06jBAaVAmnxK/sb7tiZF6oqpR9TFbc
X-Gm-Gg: AR+sD10cTXuYPgJ2QyOac0UMdeF2Xu/GTVvUcLcEDVO7NB8WnNKVHnbsV35PvEEu5D2
 qLDREjFDuSu2jKXyRGJLDSHiRscpgtBH3UZeera9xyJONK9irTkTyVLAr6fV7fo7XMvZaf6nnCP
 Q8zDYSnnPDoC7FW4IUz9BFZr3Rze374zeb5BiN6nWqx8ojNgdWOYV5MF6rUrFpBPjbdLTny+ATl
 8Dgc6+DNr1RP+cs9OnUuKY2oVpIxqzUX7Kc7z+3DOIhf61g4CD4ecLWSKb4bt8b4Q1SoPJtMta8
 NCE5HlUMEXic8upGAU1Z08L6w61WknZ8Ia5snmfpYro1H3BxKG5g1uXdRkJuj9h221GLdeY2ZTY
 X3lfnjdn8jj5lDlR1K/aYsi4txRfRspS1OwL32Xk9CTOKOjWK7+owqFHNXBZs9QLFGNrpncbHmg
 4bhhCUbZcBhmVoC91j9EEU9DWANgC0qF1jGtW7u79mizCCyAHzz0KzJWROmqG4wwdY1A==
X-Received: by 2002:a05:6a00:3016:b0:848:5540:2377 with SMTP id
 d2e1a72fcca58-84fde13600amr30938208b3a.17.1787029960971; 
 Mon, 17 Aug 2026 22:12:40 -0700 (PDT)
Received: from [127.0.1.1] ([2600:1700:e140:14d0:d043:a40d:25c1:432c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b6fc0e84sm1031160b3a.43.2026.08.17.22.12.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 22:12:40 -0700 (PDT)
From: Connor Kite <connorkite@gmail.com>
Date: Mon, 17 Aug 2026 22:12:23 -0700
Subject: [PATCH RFC v2 08/13] hw/virtio/vhost-user: send isolation regions
 to device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-vhost-user-isolated-memory-v2-8-948aae960abb@gmail.com>
References: <20260817-vhost-user-isolated-memory-v2-0-948aae960abb@gmail.com>
In-Reply-To: <20260817-vhost-user-isolated-memory-v2-0-948aae960abb@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Raphael Norwitz <rnorwitz@nvidia.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org, 
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>, 
 Connor Kite <connorkite@gmail.com>, 
 20260817233147.2867623-1-connorkite@gmail.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787029936; l=6051;
 i=connorkite@gmail.com; s=20260723; h=from:subject:message-id;
 bh=isjwTQ10NMEWzyrtg5QOC8oSS6P/XZ9Z7iPYIanOq+I=;
 b=FNRuemiXMG2dTKu828vACrnegRFejgIQS9WFd9Yooo1U9kbAgnOpgFkvJOc+vSQs5v6xxBexJ
 LzmC+iqgmKdBj2XM/hPHzFU/R9ir4emBc58pmw0V2fRnezwj1Iw1iA8
X-Developer-Key: i=connorkite@gmail.com; a=ed25519;
 pk=xg/3N8AntFCYogaIgN5NC/KkT7UlZB6ktPIRliJ3hv4=
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=connorkite@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Adds features to fill a vhost_user_set_mem_table message with the
addresses of isolation memory regions corresponding to bounce buffers
and vrings.

Signed-off-by: Connor Kite <connorkite@gmail.com>
---
 hw/virtio/vhost-user.c | 118 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 117 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 7e9233e174..e1e5cba53d 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1140,7 +1140,77 @@ static void cleanup_isolation_regions(struct vhost_dev *dev)
     }
 }
 
-__attribute__((unused))
+typedef struct {
+    VhostUserMsg *msg;
+    struct vhost_user *u;
+    int *fds;
+    size_t fds_size;
+    uint64_t vring_iova;
+    size_t vring_size;
+    bool vring_node_visited;
+    size_t *idx;
+} IOVATreeTraversalArgs;
+
+static gboolean vhost_user_fill_msg_reg_from_tree(gpointer key,
+                                                  gpointer value,
+                                                  gpointer data)
+{
+    IOVATreeTraversalArgs *args = data;
+    struct vhost_user *u;
+    VhostUserMsg *msg = args->msg;
+    DMAMap *map = key;
+    uint64_t offset;
+
+    assert(args && key && value);
+    if (!args->vring_node_visited) {
+        args->vring_node_visited = true;
+        return false;
+    }
+
+    u = args->u;
+    assert(*args->idx < args->fds_size);
+
+    args->fds[*args->idx] = args->u->iso_mem_ctx.fd;
+
+    /*
+     * If the number of regions is fixed, it would be wasteful to use one for
+     * only the vrings. The first vhost_iova_tree element is always
+     * reserved for the vrings, so we can simply combine the first and second
+     * elements, which are contiguous in IOVA space, when sending regions to
+     * the backend.
+     */
+    if (*args->idx == 0) {
+        offset = u->iso_mem_ctx.vring_hva_addr - u->iso_mem_ctx.shared_mem_addr;
+        msg->payload.memory.regions[*args->idx].userspace_addr =
+            args->vring_iova;
+        /*
+         * The size from the iova tree is inclusive, so 1 is added to it.
+         * args->vring_size is exclusive, so no addition is required.
+         */
+        msg->payload.memory.regions[*args->idx].memory_size =
+            args->vring_size + map->size + 1;
+        msg->payload.memory.regions[*args->idx].guest_phys_addr =
+            args->vring_iova;
+        msg->payload.memory.regions[*args->idx].mmap_offset = offset;
+    } else {
+        /* Use 128 bit operation in unlikely case of negative iso_iova_offset */
+        offset = int128_get64(int128_add(int128_make64(map->iova),
+                                        u->iso_mem_ctx.iso_iova_offset)) -
+                (uint64_t)u->iso_mem_ctx.shared_mem_addr;
+
+        msg->payload.memory.regions[*args->idx].userspace_addr = map->iova;
+        msg->payload.memory.regions[*args->idx].memory_size = map->size + 1;
+        msg->payload.memory.regions[*args->idx].guest_phys_addr = map->iova;
+        msg->payload.memory.regions[*args->idx].mmap_offset = offset;
+    }
+
+    assert(offset + msg->payload.memory.regions[*args->idx].memory_size <=
+        u->iso_mem_ctx.size);
+    (*args->idx)++;
+
+    return false;
+}
+
 static int init_isolation_regions(struct vhost_dev *dev,
                                   VhostUserMsg *msg,
                                   int *fds, size_t *fd_num)
@@ -1159,6 +1229,7 @@ static int init_isolation_regions(struct vhost_dev *dev,
     DMAMap *map;
     DMAMap vring_map;
     int r;
+    IOVATreeTraversalArgs trav_args;
 
     msg->hdr.request = VHOST_USER_SET_MEM_TABLE;
 
@@ -1244,6 +1315,27 @@ static int init_isolation_regions(struct vhost_dev *dev,
         }
     }
 
+    *fd_num = 0;
+    trav_args.idx = fd_num;
+    trav_args.fds = fds;
+    trav_args.msg = msg;
+    trav_args.u = u;
+    trav_args.vring_iova = vring_map.iova;
+    trav_args.vring_size = total_vring_size;
+    trav_args.fds_size = nregions;
+    trav_args.vring_node_visited = false;
+
+    vhost_iova_tree_foreach(u->iso_mem_ctx.tree,
+                            vhost_user_fill_msg_reg_from_tree, &trav_args);
+
+    msg->payload.memory.nregions = *fd_num;
+
+    assert(*fd_num == nregions);
+
+    msg->hdr.size = sizeof(msg->payload.memory.nregions);
+    msg->hdr.size += sizeof(msg->payload.memory.padding);
+    msg->hdr.size += *fd_num * sizeof(VhostUserMemoryRegion);
+
     return 0;
 }
 
@@ -1251,6 +1343,7 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
                                     struct vhost_memory *mem)
 {
     struct vhost_user *u = dev->opaque;
+    bool memory_isolation = u->user->memory_isolation;
     int fds[VHOST_MEMORY_BASELINE_NREGIONS];
     size_t fd_num = 0;
     bool do_postcopy = u->postcopy_listen && u->postcopy_fd.handler;
@@ -1262,6 +1355,11 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
     int ret;
 
     if (do_postcopy) {
+        /* Postcopy is not supported with memory isolation yet */
+        if (memory_isolation) {
+            return -1;
+        }
+
         /*
          * Postcopy has enough differences that it's best done in it's own
          * version
@@ -1278,6 +1376,24 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
         msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
     }
 
+    if (memory_isolation) {
+        ret = init_isolation_regions(dev, &msg, fds, &fd_num);
+        if (ret < 0) {
+            return ret;
+        }
+
+        ret = vhost_user_write(dev, &msg, fds, fd_num);
+        if (ret < 0) {
+            return ret;
+        }
+
+        if (reply_supported) {
+            return process_message_reply(dev, &msg);
+        }
+
+        return 0;
+    }
+
     if (config_mem_slots) {
         ret = vhost_user_add_remove_regions(dev, &msg, reply_supported, false);
         if (ret < 0) {

-- 
2.43.0


