Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD02CC88E7F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 18:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6uO2-0006AH-CD; Wed, 16 Sep 2026 14:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x6uNz-000697-Ou
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 14:29:35 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x6uNp-0008Mf-5W
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 14:29:28 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c16:1d84:0:640:ba03:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id B067781136;
 Wed, 16 Sep 2026 21:29:21 +0300 (MSK)
Received: from i115954770.. (185.215.60.179.mosline.ru [185.215.60.179])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id JTaLWK3cWGk0-xaBFq5jn; Wed, 16 Sep 2026 21:29:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1789583360;
 bh=zWOjjlSfRkOh/Yu/5K9agEL7GfVQsW1a0lLdeS95xoA=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=LrCJKC7CScYXrerSFoJGT1EwwJ8AXepKvCFbDpRFmt23rBFMZbnUkmNIRTWeA8H0c
 4+rool26X96hcWQf+Ydn7yV+DU0iDeLS5eeLUFClwpXFCmLAI6OdSodef7ZTagRgj7
 q0WedvlpMHLGuMH31aX/3NuM8F6Sf4A3fFD0xQcc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 qemu-devel@nongnu.org, vsementsov@yandex-team.ru
Subject: [PATCH 1/2] vhost-user: drop postcopy support for CONFIGURE_MEM_SLOTS
 case
Date: Wed, 16 Sep 2026 21:29:16 +0300
Message-ID: <20260916182917.820031-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916182917.820031-1-vsementsov@yandex-team.ru>
References: <20260916182917.820031-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Postcopy with CONFIGURE_MEM_SLOTS has a poorly specified handshake and
broken handling of memory table updates.

Look:

for VHOST_USER_SET_MEM_TABLE we have note in the spec:

.. Note::
    ``NEED_REPLY_MASK`` is not set in this case.  QEMU will then
    reply back to the list of mappings with an empty
    ``VHOST_USER_SET_MEM_TABLE`` as an acknowledgement; only upon
    reception of this message may the guest start accessing the memory
    and generating faults.

and in code we do in vhost_user_set_mem_table_postcopy():

         msg.hdr.size = sizeof(msg.payload.u64);
         msg.payload.u64 = 0; /* OK */
         ret = vhost_user_write(dev, &msg, NULL, 0);
         if (ret < 0) {
             return ret;
         }

Note, that msg.hdr.request is set to VHOST_USER_SET_MEM_TABLE by
vhost_user_fill_set_mem_table_msg() call.

But when CONFIGURE_MEM_SLOTS is negotiated we don't use VHOST_USER_SET_MEM_TABLE
message, instead we use VHOST_USER_REM_MEM_REG and VHOST_USER_ADD_MEM_REG.

for VHOST_USER_REM_MEM_REG we have nothing about postcopy in documentation,
and for VHOST_USER_ADD_MEM_REG we have only:

   In postcopy mode (see ``VHOST_USER_POSTCOPY_LISTEN``), the back-end
   replies with the bases of the memory mapped region to the front-end.
   For further details on postcopy, see ``VHOST_USER_SET_MEM_TABLE``.
   They apply to ``VHOST_USER_ADD_MEM_REG`` accordingly.

how should it work about "an acknowledgement"? Should QEMU send
an empty VHOST_USER_SET_MEM_TABLE ? And when?

Let's see what we have in code:

vhost_user_add_remove_regions() {

    if (nr_rem_reg) { send_remove_regions() }

    if (nr_add_reg) { send_add_regions() }

    ... and for postcopy:

    msg->hdr.size = sizeof(msg->payload.u64);
    msg->payload.u64 = 0; /* OK */

    ret = vhost_user_write(dev, msg, NULL, 0);
    if (ret < 0) {
        return ret;
    }

Note that:

1. We send only one acknowledgement, after sending several (or zero)
    ADD/REM requests.

2. We send an acknowledgement with request set to either VHOST_USER_ADD_MEM_REG,
    or VHOST_USER_REM_MEM_REG, or zero (if both nr_rem_reg and nr_add_reg are zero).

libvhost-user recognizes the final ADD_MEM_REG acknowledgement, so its
handshake agrees with QEMU when initially adding regions. However, it
rejects the short REM_MEM_REG acknowledgement, and the specification does
not describe a batch acknowledgement at all. A back-end interpreting the
specification as requiring an acknowledgement for each ADD_MEM_REG would
not interoperate with this implementation.

Drop support for this combination until its handshake and memory table
updates are properly specified and implemented. Reject it during the
postcopy probe, before sending postcopy commands or switching over, and
add the memory-table check as an additional guard.

Update the documentation accordingly.

Feature: vhost-user-blk-fd-mig
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 docs/interop/vhost-user.rst |  30 +++++--
 hw/virtio/vhost-user.c      | 161 ++++++------------------------------
 2 files changed, 50 insertions(+), 141 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index c1e02ff7e96..5e7a72be2a3 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -664,6 +664,8 @@ Once the source has finished migration, rings will be stopped by the
 source (:ref:`Suspended device state <suspended_device_state>`). No
 further update must be done before rings are restarted.
 
+.. _vhost_user_postcopy:
+
 In postcopy migration the back-end is started before all the memory has
 been received from the source host, and care must be taken to avoid
 accessing pages that have yet to be received.  The back-end opens a
@@ -674,6 +676,14 @@ it performs WAKE ioctl's on the userfaultfd to wake the stalled
 back-end.  The front-end indicates support for this via the
 ``VHOST_USER_PROTOCOL_F_PAGEFAULT`` feature.
 
+Postcopy migration is not supported when
+``VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS`` has been negotiated. In this
+case, the front-end MUST NOT send ``VHOST_USER_POSTCOPY_ADVISE``,
+``VHOST_USER_POSTCOPY_LISTEN``, or ``VHOST_USER_POSTCOPY_END``. The behavior
+of the back-end if it receives any of these messages is unspecified.
+Negotiating both ``VHOST_USER_PROTOCOL_F_PAGEFAULT`` and
+``VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS`` does not lift this restriction.
+
 .. _migrating_backend_state:
 
 Migrating back-end state
@@ -763,6 +773,9 @@ can be removed via the ``VHOST_USER_REM_MEM_REG`` message. These messages can
 only be used if the ``VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS`` protocol
 feature has been successfully negotiated.
 
+Negotiating this feature prevents the use of
+:ref:`postcopy migration <vhost_user_postcopy>`.
+
 Guest addresses are physical addresses in the guest.  User addresses are
 arbitrary opaque values, though they typically refer to userspace addresses in
 the client process.
@@ -1587,6 +1600,10 @@ Front-end message types
   the back-end must open a userfaultfd for later use.  Note that at this
   stage the migration is still in precopy mode.
 
+  This message MUST NOT be sent when
+  ``VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS`` has been negotiated; see
+  :ref:`postcopy migration <vhost_user_postcopy>`.
+
 ``VHOST_USER_POSTCOPY_LISTEN``
   :id: 29
   :request payload: N/A
@@ -1599,6 +1616,10 @@ Front-end message types
   This is always sent sometime after a ``VHOST_USER_POSTCOPY_ADVISE``,
   and thus only when ``VHOST_USER_PROTOCOL_F_PAGEFAULT`` is supported.
 
+  This message MUST NOT be sent when
+  ``VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS`` has been negotiated; see
+  :ref:`postcopy migration <vhost_user_postcopy>`.
+
 ``VHOST_USER_POSTCOPY_END``
   :id: 30
   :request payload: N/A
@@ -1614,6 +1635,10 @@ Front-end message types
 
   The value returned is an error indication; 0 is success.
 
+  This message MUST NOT be sent when
+  ``VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS`` has been negotiated; see
+  :ref:`postcopy migration <vhost_user_postcopy>`.
+
 ``VHOST_USER_GET_INFLIGHT_FD``
   :id: 31
   :equivalent ioctl: N/A
@@ -1708,11 +1733,6 @@ Front-end message types
   Exactly one file descriptor from which the memory is mapped is
   passed in the ancillary data.
 
-  In postcopy mode (see ``VHOST_USER_POSTCOPY_LISTEN``), the back-end
-  replies with the bases of the memory mapped region to the front-end.
-  For further details on postcopy, see ``VHOST_USER_SET_MEM_TABLE``.
-  They apply to ``VHOST_USER_ADD_MEM_REG`` accordingly.
-
 ``VHOST_USER_REM_MEM_REG``
   :id: 38
   :equivalent ioctl: N/A
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 65889b0776d..da7e3f149c1 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -360,7 +360,6 @@ struct vhost_user {
 struct scrub_regions {
     struct vhost_memory_region *region;
     int reg_idx;
-    int fd_idx;
 };
 
 bool vhost_user_has_protocol_feature(struct vhost_dev *dev, uint64_t feature)
@@ -682,15 +681,12 @@ static void scrub_shadow_regions(struct vhost_dev *dev,
                                  struct scrub_regions *add_reg,
                                  int *nr_add_reg,
                                  struct scrub_regions *rem_reg,
-                                 int *nr_rem_reg, uint64_t *shadow_pcb,
-                                 bool track_ramblocks)
+                                 int *nr_rem_reg)
 {
     struct vhost_user *u = dev->opaque;
     bool found[VHOST_USER_MAX_RAM_SLOTS] = {};
     struct vhost_memory_region *reg, *shadow_reg;
-    int i, j, fd, add_idx = 0, rm_idx = 0, fd_num = 0;
-    ram_addr_t offset;
-    MemoryRegion *mr;
+    int i, j, add_idx = 0, rm_idx = 0;
     bool matching;
 
     /*
@@ -706,25 +702,9 @@ static void scrub_shadow_regions(struct vhost_dev *dev,
         for (j = 0; j < dev->mem->nregions; j++) {
             reg = &dev->mem->regions[j];
 
-            mr = vhost_user_get_mr_data(reg->userspace_addr, &offset, &fd);
-
             if (reg_equal(shadow_reg, reg)) {
                 matching = true;
                 found[j] = true;
-                if (track_ramblocks) {
-                    /*
-                     * Reset postcopy client bases, region_rb, and
-                     * region_rb_offset in case regions are removed.
-                     */
-                    if (fd > 0) {
-                        u->region_rb_offset[j] = offset;
-                        u->region_rb[j] = mr->ram_block;
-                        shadow_pcb[j] = u->postcopy_client_bases[i];
-                    } else {
-                        u->region_rb_offset[j] = 0;
-                        u->region_rb[j] = NULL;
-                    }
-                }
                 break;
             }
         }
@@ -747,11 +727,6 @@ static void scrub_shadow_regions(struct vhost_dev *dev,
      */
     for (i = 0; i < dev->mem->nregions; i++) {
         reg = &dev->mem->regions[i];
-        vhost_user_get_mr_data(reg->userspace_addr, &offset, &fd);
-        if (fd > 0) {
-            ++fd_num;
-        }
-
         /*
          * If the region was in both the shadow and device state we don't
          * need to send a VHOST_USER_ADD_MEM_REG message for it.
@@ -762,7 +737,7 @@ static void scrub_shadow_regions(struct vhost_dev *dev,
 
         add_reg[add_idx].region = reg;
         add_reg[add_idx].reg_idx = i;
-        add_reg[add_idx++].fd_idx = fd_num;
+        add_idx++;
     }
     *nr_rem_reg = rm_idx;
     *nr_add_reg = add_idx;
@@ -824,34 +799,21 @@ static int send_remove_regions(struct vhost_dev *dev,
 
 static int send_add_regions(struct vhost_dev *dev,
                             struct scrub_regions *add_reg, int nr_add_reg,
-                            VhostUserMsg *msg, uint64_t *shadow_pcb,
-                            bool reply_supported, bool track_ramblocks)
+                            VhostUserMsg *msg,
+                            bool reply_supported)
 {
     struct vhost_user *u = dev->opaque;
-    int i, fd, ret, reg_idx, reg_fd_idx;
+    int i, fd, ret;
     struct vhost_memory_region *reg;
-    MemoryRegion *mr;
     ram_addr_t offset;
-    VhostUserMsg msg_reply;
     VhostUserMemoryRegion region_buffer;
 
     for (i = 0; i < nr_add_reg; i++) {
         reg = add_reg[i].region;
-        reg_idx = add_reg[i].reg_idx;
-        reg_fd_idx = add_reg[i].fd_idx;
 
-        mr = vhost_user_get_mr_data(reg->userspace_addr, &offset, &fd);
+        vhost_user_get_mr_data(reg->userspace_addr, &offset, &fd);
 
         if (fd > 0) {
-            if (track_ramblocks) {
-                trace_vhost_user_set_mem_table_withfd(reg_fd_idx, mr->name,
-                                                      reg->memory_size,
-                                                      reg->guest_phys_addr,
-                                                      reg->userspace_addr,
-                                                      offset);
-                u->region_rb_offset[reg_idx] = offset;
-                u->region_rb[reg_idx] = mr->ram_block;
-            }
             msg->hdr.request = VHOST_USER_ADD_MEM_REG;
             vhost_user_fill_msg_region(dev, &region_buffer, reg, offset);
             msg->payload.mem_reg.region = region_buffer;
@@ -861,59 +823,12 @@ static int send_add_regions(struct vhost_dev *dev,
                 return ret;
             }
 
-            if (track_ramblocks) {
-                uint64_t reply_gpa;
-
-                ret = vhost_user_read(dev, &msg_reply);
-                if (ret < 0) {
-                    return ret;
-                }
-
-                reply_gpa = msg_reply.payload.mem_reg.region.guest_phys_addr;
-
-                if (msg_reply.hdr.request != VHOST_USER_ADD_MEM_REG) {
-                    error_report("%s: Received unexpected msg type."
-                                 "Expected %d received %d", __func__,
-                                 VHOST_USER_ADD_MEM_REG,
-                                 msg_reply.hdr.request);
-                    return -EPROTO;
-                }
-
-                /*
-                 * We're using the same structure, just reusing one of the
-                 * fields, so it should be the same size.
-                 */
-                if (msg_reply.hdr.size != msg->hdr.size) {
-                    error_report("%s: Unexpected size for postcopy reply "
-                                 "%d vs %d", __func__, msg_reply.hdr.size,
-                                 msg->hdr.size);
-                    return -EPROTO;
-                }
-
-                /* Get the postcopy client base from the backend's reply. */
-                if (reply_gpa == dev->mem->regions[reg_idx].guest_phys_addr) {
-                    shadow_pcb[reg_idx] =
-                        msg_reply.payload.mem_reg.region.userspace_addr;
-                    trace_vhost_user_set_mem_table_postcopy(
-                        msg_reply.payload.mem_reg.region.userspace_addr,
-                        msg->payload.mem_reg.region.userspace_addr,
-                        reg_fd_idx, reg_idx);
-                } else {
-                    error_report("%s: invalid postcopy reply for region. "
-                                 "Got guest physical address %" PRIX64 ", expected "
-                                 "%" PRIX64, __func__, reply_gpa,
-                                 dev->mem->regions[reg_idx].guest_phys_addr);
-                    return -EPROTO;
-                }
-            } else if (reply_supported) {
+            if (reply_supported) {
                 ret = process_message_reply(dev, msg);
                 if (ret) {
                     return ret;
                 }
             }
-        } else if (track_ramblocks) {
-            u->region_rb_offset[reg_idx] = 0;
-            u->region_rb[reg_idx] = NULL;
         }
 
         /*
@@ -936,13 +851,10 @@ static int send_add_regions(struct vhost_dev *dev,
 
 static int vhost_user_add_remove_regions(struct vhost_dev *dev,
                                          VhostUserMsg *msg,
-                                         bool reply_supported,
-                                         bool track_ramblocks)
+                                         bool reply_supported)
 {
-    struct vhost_user *u = dev->opaque;
     struct scrub_regions add_reg[VHOST_USER_MAX_RAM_SLOTS];
     struct scrub_regions rem_reg[VHOST_USER_MAX_RAM_SLOTS];
-    uint64_t shadow_pcb[VHOST_USER_MAX_RAM_SLOTS] = {};
     int nr_add_reg, nr_rem_reg;
     int ret;
 
@@ -952,57 +864,29 @@ static int vhost_user_add_remove_regions(struct vhost_dev *dev,
     assert(dev->mem->nregions <= VHOST_USER_MAX_RAM_SLOTS);
 
     /* Find the regions which need to be removed or added. */
-    scrub_shadow_regions(dev, add_reg, &nr_add_reg, rem_reg, &nr_rem_reg,
-                         shadow_pcb, track_ramblocks);
+    scrub_shadow_regions(dev, add_reg, &nr_add_reg, rem_reg, &nr_rem_reg);
 
     if (nr_rem_reg) {
         ret = send_remove_regions(dev, rem_reg, nr_rem_reg, msg,
                                   reply_supported);
         if (ret < 0) {
-            goto err;
+            return ret;
         }
     }
 
     if (nr_add_reg) {
-        ret = send_add_regions(dev, add_reg, nr_add_reg, msg, shadow_pcb,
-                               reply_supported, track_ramblocks);
-        if (ret < 0) {
-            goto err;
-        }
-    }
-
-    if (track_ramblocks) {
-        memcpy(u->postcopy_client_bases, shadow_pcb,
-               sizeof(uint64_t) * VHOST_USER_MAX_RAM_SLOTS);
-        /*
-         * Now we've registered this with the postcopy code, we ack to the
-         * client, because now we're in the position to be able to deal with
-         * any faults it generates.
-         */
-        /* TODO: Use this for failure cases as well with a bad value. */
-        msg->hdr.size = sizeof(msg->payload.u64);
-        msg->payload.u64 = 0; /* OK */
-
-        ret = vhost_user_write(dev, msg, NULL, 0);
+        ret = send_add_regions(dev, add_reg, nr_add_reg, msg,
+                               reply_supported);
         if (ret < 0) {
             return ret;
         }
     }
 
     return 0;
-
-err:
-    if (track_ramblocks) {
-        memcpy(u->postcopy_client_bases, shadow_pcb,
-               sizeof(uint64_t) * VHOST_USER_MAX_RAM_SLOTS);
-    }
-
-    return ret;
 }
 
 static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,
                                              struct vhost_memory *mem,
-                                             bool reply_supported,
                                              bool config_mem_slots)
 {
     struct vhost_user *u = dev->opaque;
@@ -1028,10 +912,9 @@ static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,
     }
 
     if (config_mem_slots) {
-        ret = vhost_user_add_remove_regions(dev, &msg, reply_supported, true);
-        if (ret < 0) {
-            return ret;
-        }
+        error_report(
+            "vhost-user: postcopy is not supported with CONFIGURE_MEM_SLOTS");
+        return -ENOTSUP;
     } else {
         ret = vhost_user_fill_set_mem_table_msg(u, dev, &msg, fds, &fd_num,
                                                 true);
@@ -1133,8 +1016,7 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
          * Postcopy has enough differences that it's best done in it's own
          * version
          */
-        return vhost_user_set_mem_table_postcopy(dev, mem, reply_supported,
-                                                 config_mem_slots);
+        return vhost_user_set_mem_table_postcopy(dev, mem, config_mem_slots);
     }
 
     VhostUserMsg msg = {
@@ -1146,7 +1028,7 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
     }
 
     if (config_mem_slots) {
-        ret = vhost_user_add_remove_regions(dev, &msg, reply_supported, false);
+        ret = vhost_user_add_remove_regions(dev, &msg, reply_supported);
         if (ret < 0) {
             return ret;
         }
@@ -2513,6 +2395,13 @@ static int vhost_user_postcopy_notifier(NotifierWithReturn *notifier,
 
     switch (pnd->reason) {
     case POSTCOPY_NOTIFY_PROBE:
+        if (vhost_user_has_protocol_feature(
+                dev, VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS)) {
+            error_setg(errp,
+                       "vhost-user: postcopy is not supported with "
+                       "CONFIGURE_MEM_SLOTS");
+            return -ENOTSUP;
+        }
         if (!vhost_user_has_protocol_feature(
                 dev, VHOST_USER_PROTOCOL_F_PAGEFAULT)) {
             /* TODO: Get the device name into this error somehow */
-- 
2.43.0


