Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D27FD2F036
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 14:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkjh8-00083I-4O; Tue, 27 Jan 2026 09:05:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vkjgz-0007xx-3Q
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:05:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vkjgv-0007Nd-Nv
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:05:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769522713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dvZDmWiQHNZKmPxm+TJ9daDwZa26WXuC/MX6WVOUAyc=;
 b=WL6ZF20FVn/M6tu45LSK/Ol24Kb9W6mnGLm/8JL9K6hWpBAa9hMaetoKwG3nHGu6w7YoCz
 8z6EODZZQbmYgmNrLeLh67q0q83BfJLfEaHvMq8ghwi6TTjd7caLq9BxerN6JoetTY2GQ7
 HuiTGFDqY8DgxP2opI9nyzKGA4s1TPU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-fZiy8HUEN0-P2Naxu5Rpsw-1; Tue,
 27 Jan 2026 09:03:58 -0500
X-MC-Unique: fZiy8HUEN0-P2Naxu5Rpsw-1
X-Mimecast-MFC-AGG-ID: fZiy8HUEN0-P2Naxu5Rpsw_1769522638
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E390C1955D9A; Tue, 27 Jan 2026 14:03:57 +0000 (UTC)
Received: from fedora (unknown [10.43.3.182])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CE5ED18007D2; Tue, 27 Jan 2026 14:03:55 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 4/4] migration: Pass network packets received during
 switchover to dest VM
Date: Tue, 27 Jan 2026 15:03:10 +0100
Message-ID: <20260127140316.4187221-5-jmarcin@redhat.com>
In-Reply-To: <20260127140316.4187221-1-jmarcin@redhat.com>
References: <20260127140316.4187221-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Juraj Marcin <jmarcin@redhat.com>

During migration switchover both the source and the destination machines
are paused (compute downtime). During this period network still routes
network packets to the source machine, as this is the last place where
the recipient MAC address has been seen. Once the destination side
starts and sends network announcement, all subsequent frames are routed
correctly. However, frames delivered to the source machine are never
processed and lost. This causes also a network downtime with roughly the
same duration as compute downtime.

This can cause problems not only for protocols that cannot handle packet
loss, but can also introduce delays in protocols that can handle them.

To resolve this, this feature instantiates a network filter for each
network backend present during migration setup on both migration sides.
On the source side, this filter caches all packets received from the
backend during switchover. Once the destination machine starts, all
cached packets are sent through the migration channel and the respective
filter object on the destination side injects them to the NIC attached
to the backend.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
---
 include/migration/vmstate.h |   6 +
 include/net/net.h           |   5 +
 migration/meson.build       |   1 +
 migration/migration.c       |  49 ++++++-
 migration/migration.h       |   2 +
 migration/netpass.c         | 246 ++++++++++++++++++++++++++++++++++++
 migration/netpass.h         |  14 ++
 migration/options.c         |  21 +++
 migration/options.h         |   1 +
 migration/savevm.c          |  37 ++++++
 migration/savevm.h          |   2 +
 migration/trace-events      |   9 ++
 net/net.c                   |  11 ++
 net/tap.c                   |  11 +-
 qapi/migration.json         |   7 +-
 15 files changed, 418 insertions(+), 4 deletions(-)
 create mode 100644 migration/netpass.c
 create mode 100644 migration/netpass.h

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 62d7e9fe38..7987e6c85a 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -200,6 +200,12 @@ typedef enum {
      * save_setup() in VMSD structures.
      */
     VMS_PHASE_EARLY_SETUP,
+    /*
+     * Specifies a netpass VMSD, these devices are copied right after the
+     * destination is started regardless of precopy/postcopy. Failure in this
+     * phase does not fail the migration in case of precopy.
+     */
+    VMS_PHASE_NETPASS,
 } VMStateSavePhase;
 
 struct VMStateDescription {
diff --git a/include/net/net.h b/include/net/net.h
index 45bc86fc86..510908845b 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -82,6 +82,7 @@ typedef void (NetAnnounce)(NetClientState *);
 typedef bool (SetSteeringEBPF)(NetClientState *, int);
 typedef bool (NetCheckPeerType)(NetClientState *, ObjectClass *, Error **);
 typedef struct vhost_net *(GetVHostNet)(NetClientState *nc);
+typedef void (NetpassEnabledNotify)(NetClientState *nc, void *opaque);
 
 typedef struct NetClientInfo {
     NetClientDriver type;
@@ -130,6 +131,9 @@ struct NetClientState {
     bool is_netdev;
     bool do_not_pad; /* do not pad to the minimum ethernet frame length */
     bool is_datapath;
+    bool netpass_enabled;
+    NetpassEnabledNotify *netpass_enabled_notify;
+    void *netpass_enabled_notify_opaque;
     QTAILQ_HEAD(, NetFilterState) filters;
 };
 
@@ -198,6 +202,7 @@ void qemu_flush_queued_packets(NetClientState *nc);
 void qemu_flush_or_purge_queued_packets(NetClientState *nc, bool purge);
 void qemu_set_info_str(NetClientState *nc,
                        const char *fmt, ...) G_GNUC_PRINTF(2, 3);
+void qemu_set_netpass_enabled(NetClientState *nc, bool enabled);
 void qemu_format_nic_info_str(NetClientState *nc, uint8_t macaddr[6]);
 bool qemu_has_ufo(NetClientState *nc);
 bool qemu_has_uso(NetClientState *nc);
diff --git a/migration/meson.build b/migration/meson.build
index c7f39bdb55..a501256979 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -30,6 +30,7 @@ system_ss.add(files(
   'multifd-nocomp.c',
   'multifd-zlib.c',
   'multifd-zero-page.c',
+  'netpass.c',
   'options.c',
   'postcopy-ram.c',
   'ram.c',
diff --git a/migration/migration.c b/migration/migration.c
index 4871db2365..959719dd61 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -63,6 +63,7 @@
 #include "system/dirtylimit.h"
 #include "qemu/sockets.h"
 #include "system/kvm.h"
+#include "netpass.h"
 
 #define NOTIFIER_ELEM_INIT(array, elem)    \
     [elem] = NOTIFIER_WITH_RETURN_LIST_INITIALIZER((array)[elem])
@@ -488,6 +489,10 @@ void migration_incoming_state_destroy(void)
         mis->postcopy_qemufile_dst = NULL;
     }
 
+    if (migrate_netpass()) {
+        migration_netpass_cleanup();
+    }
+
     cpr_set_incoming_mode(MIG_MODE_NONE);
     yank_unregister_instance(MIGRATION_YANK_INSTANCE);
 }
@@ -755,6 +760,10 @@ static void process_incoming_migration_bh(void *opaque)
         migrate_send_rp_vm_started(mis);
     }
 
+    if (migrate_netpass()) {
+        qemu_loadvm_state_netpass(mis->from_src_file, mis);
+    }
+
     /*
      * This must happen after any state changes since as soon as an external
      * observer sees this event they might start to prod at the VM assuming
@@ -775,6 +784,13 @@ process_incoming_migration_co(void *opaque)
 
     assert(mis->from_src_file);
 
+    if (migrate_netpass()) {
+        ret = migration_netpass_setup(&local_err);
+        if (ret < 0) {
+            goto fail;
+        }
+    }
+
     mis->largest_page_size = qemu_ram_pagesize_largest();
     postcopy_state_set(POSTCOPY_INCOMING_NONE);
     migrate_set_state(&mis->state, MIGRATION_STATUS_SETUP,
@@ -811,8 +827,7 @@ process_incoming_migration_co(void *opaque)
     goto out;
 
 fail:
-    migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
-                      MIGRATION_STATUS_FAILED);
+    migrate_set_state(&mis->state, mis->state, MIGRATION_STATUS_FAILED);
     migrate_error_propagate(s, local_err);
     migration_incoming_state_destroy();
 
@@ -1336,6 +1351,10 @@ static void migration_cleanup(MigrationState *s)
         qemu_fclose(tmp);
     }
 
+    if (migrate_netpass()) {
+        migration_netpass_cleanup();
+    }
+
     assert(!migration_is_active());
 
     if (s->state == MIGRATION_STATUS_CANCELLING) {
@@ -1673,6 +1692,8 @@ int migrate_init(MigrationState *s, Error **errp)
     s->dest_vm_started = false;
     qemu_event_reset(&s->dest_vm_started_event);
 
+    s->netpass_state_sent = false;
+
     return 0;
 }
 
@@ -2729,6 +2750,10 @@ static bool migration_switchover_start(MigrationState *s, Error **errp)
 {
     ERRP_GUARD();
 
+    if (migrate_netpass()) {
+        migration_netpass_activate();
+    }
+
     if (!migration_switchover_prepare(s)) {
         error_setg(errp, "Switchover is interrupted");
         return false;
@@ -2821,6 +2846,14 @@ static void migration_completion(MigrationState *s)
         goto fail;
     }
 
+    if (migrate_netpass() && !s->netpass_state_sent) {
+        qemu_event_wait(&s->dest_vm_started_event);
+        qemu_savevm_state_netpass(s->to_dst_file);
+        s->netpass_state_sent = true;
+        qemu_put_byte(s->to_dst_file, QEMU_VM_EOF);
+        qemu_fflush(s->to_dst_file);
+    }
+
     if (close_return_path_on_source(s)) {
         goto fail;
     }
@@ -3251,6 +3284,11 @@ static MigIterateState migration_iteration_run(MigrationState *s)
             migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_DEVICE,
                               MIGRATION_STATUS_POSTCOPY_ACTIVE);
         }
+
+        if (s->dest_vm_started && migrate_netpass() && !s->netpass_state_sent) {
+            qemu_savevm_state_netpass(s->to_dst_file);
+            s->netpass_state_sent = true;
+        }
     } else {
         /*
          * Exact pending reporting is only needed for precopy.  Taking RAM
@@ -3774,6 +3812,13 @@ void migration_start_outgoing(MigrationState *s)
 
     s->expected_downtime = migrate_downtime_limit();
 
+    if (migrate_netpass()) {
+        ret = migration_netpass_setup(&local_err);
+        if (ret < 0) {
+            goto fail;
+        }
+    }
+
     if (resume) {
         /* This is a resumed migration */
         rate_limit = migrate_max_postcopy_bandwidth();
diff --git a/migration/migration.h b/migration/migration.h
index a3fab4f27e..a0d9560254 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -530,6 +530,8 @@ struct MigrationState {
     bool send_vm_started;
     bool dest_vm_started;
     QemuEvent dest_vm_started_event;
+
+    bool netpass_state_sent;
 };
 
 void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
diff --git a/migration/netpass.c b/migration/netpass.c
new file mode 100644
index 0000000000..92b2522c83
--- /dev/null
+++ b/migration/netpass.c
@@ -0,0 +1,246 @@
+#include "qemu/osdep.h"
+#include "netpass.h"
+
+#include "migration/migration.h"
+#include "migration/vmstate.h"
+#include "net/queue.h"
+#include "net/filter.h"
+#include "net/net.h"
+#include "net/vhost_net.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/iov.h"
+#include "qemu/typedefs.h"
+#include "qom/object.h"
+#include "trace.h"
+
+struct NetPassState {
+    NetFilterState parent_obj;
+    bool active;
+    size_t packet_count;
+    uint32_t qlength;
+    uint32_t qcapacity;
+    uint8_t *qbuffer;
+    SocketReadState rs;
+    QTAILQ_ENTRY(NetPassState) next;
+};
+
+static void netpass_queue_clear(NetPassState *s)
+{
+    g_free(s->qbuffer);
+    s->qbuffer = NULL;
+    s->qcapacity = 0;
+    s->qlength = 0;
+    s->packet_count = 0;
+}
+
+OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(NetPassState, filter_netpass,
+                                          FILTER_NETPASS, NETFILTER,
+                                          { TYPE_VMSTATE_IF }, { } )
+
+static bool netpass_vmstate_pre_save(void *opaque, Error **errp)
+{
+    NetPassState *s = opaque;
+    s->active = false;
+    return true;
+}
+
+static int netpass_vmstate_post_save(void *opaque)
+{
+    NetPassState *s = opaque;
+    trace_migration_netpass_passed_packet_count(NETFILTER(s)->netdev_id, s->packet_count);
+    netpass_queue_clear(s);
+    return 0;
+}
+
+static void netpass_vmstate_post_load_bh(void *opaque)
+{
+    NetPassState *s = opaque;
+
+    int ret = net_fill_rstate(&s->rs, s->qbuffer, s->qlength);
+    if (ret == -1) {
+        warn_report("migration: Failed to fill netpass rstate during load");
+    }
+    trace_migration_netpass_received_packet_count(NETFILTER(s)->netdev_id, s->packet_count);
+    netpass_queue_clear(s);
+}
+
+static bool netpass_vmstate_post_load(void *opaque, int version_id, Error **errp)
+{
+    /*
+     * Schedule on the main thread in case this function is running on the
+     * postcopy listen thread and there is a fault during packet injection.
+     */
+    migration_bh_schedule(netpass_vmstate_post_load_bh, opaque);
+    return true;
+}
+
+static char *filter_netpass_vmstate_if_get_id(VMStateIf *obj)
+{
+    NetFilterState *nf = NETFILTER(obj);
+    return g_strconcat("filter-netpass/", nf->netdev_id,  NULL);
+}
+
+static const VMStateDescription vmstate_netpass = {
+    .name = "filter-netpass",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .phase = VMS_PHASE_NETPASS,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(qlength, NetPassState),
+        VMSTATE_UINT32(qcapacity, NetPassState),
+        VMSTATE_VBUFFER_ALLOC_UINT32(qbuffer, NetPassState, 0, NULL, qcapacity),
+        VMSTATE_END_OF_LIST(),
+    },
+    .pre_save_errp = netpass_vmstate_pre_save,
+    .post_save = netpass_vmstate_post_save,
+    .post_load_errp = netpass_vmstate_post_load,
+};
+
+QTAILQ_HEAD(, NetPassState) filters = QTAILQ_HEAD_INITIALIZER(filters);
+
+static void netpass_rs_finalize(SocketReadState *rs)
+{
+    NetPassState *s = container_of(rs, NetPassState, rs);
+    NetFilterState *nf = NETFILTER(s);
+
+    struct iovec iov = {
+        .iov_len = rs->packet_len,
+        .iov_base = rs->buf,
+    };
+    qemu_netfilter_pass_to_next(nf->netdev, 0, &iov, 1, nf);
+    s->packet_count++;
+}
+
+static void filter_netpass_setup(NetFilterState *nf, Error **errp)
+{
+    NetPassState *s = FILTER_NETPASS(nf);
+
+    s->active = false;
+    s->qbuffer = NULL;
+    s->qcapacity = 0;
+    s->qlength = 0;
+    s->packet_count = 0;
+    net_socket_rs_init(&s->rs, netpass_rs_finalize, true);
+}
+
+static void filter_netpass_cleanup(NetFilterState *nf)
+{
+    NetPassState *s = FILTER_NETPASS(nf);
+
+    s->active = false;
+    netpass_queue_clear(s);
+    if (nf->netdev) {
+        qemu_set_netpass_enabled(nf->netdev, false);
+    }
+}
+
+static ssize_t filter_netpass_receive_iov(NetFilterState *nf,
+                                          NetClientState *sender,
+                                          unsigned flags,
+                                          const struct iovec *iov,
+                                          int iovcnt,
+                                          NetPacketSent *sent_cb)
+{
+    NetPassState *s = FILTER_NETPASS(nf);
+
+    if (!s->active) {
+        return 0;
+    }
+
+    uint32_t total_size = iov_size(iov, iovcnt);
+    size_t req_cap = sizeof(uint32_t) + sizeof(uint32_t) + total_size;
+    if (s->qcapacity - s->qlength < req_cap) {
+        size_t new_capacity = s->qcapacity;
+        while (new_capacity - s->qlength < req_cap) {
+            new_capacity += 4096;
+        }
+        s->qbuffer = g_realloc(s->qbuffer, new_capacity);
+        s->qcapacity = new_capacity;
+    }
+    uint32_t total_size_be = htonl(total_size);
+    memcpy(&s->qbuffer[s->qlength], &total_size_be, sizeof(uint32_t));
+    s->qlength += sizeof(uint32_t);
+    uint32_t vnet_hdr_len_be = htonl(sender->vnet_hdr_len);
+    memcpy(&s->qbuffer[s->qlength], &vnet_hdr_len_be, sizeof(uint32_t));
+    s->qlength += sizeof(uint32_t);
+    iov_to_buf_full(iov, iovcnt, 0, &s->qbuffer[s->qlength], total_size);
+    s->qlength += total_size;
+    s->packet_count++;
+
+    return 0;
+}
+
+static void filter_netpass_class_init(ObjectClass *oc, const void *data)
+{
+    NetFilterClass *nfc = NETFILTER_CLASS(oc);
+    VMStateIfClass *vc = VMSTATE_IF_CLASS(oc);
+
+    nfc->setup = filter_netpass_setup;
+    nfc->cleanup = filter_netpass_cleanup;
+    nfc->receive_iov = filter_netpass_receive_iov;
+
+    vc->get_id = filter_netpass_vmstate_if_get_id;
+}
+
+static void filter_netpass_init(Object *obj)
+{
+}
+
+static void filter_netpass_finalize(Object *obj)
+{
+    NetPassState *s = FILTER_NETPASS(obj);
+    (void)s;
+}
+
+int migration_netpass_setup(Error **errp)
+{
+    NetClientState *nc;
+
+    QTAILQ_FOREACH(nc, &net_clients, next) {
+        if (!nc->is_netdev) {
+            continue;
+        }
+        if (get_vhost_net(nc)) {
+            warn_report("migration: netpass is not supported with vhost=on");
+            continue;
+        }
+        g_autofree char *filter_id = g_strconcat("netpass-", nc->name, NULL);
+        Object *obj = object_new_with_props(TYPE_FILTER_NETPASS,
+                                            object_get_objects_root(),
+                                            filter_id, errp,
+                                            "netdev", nc->name,
+                                            "queue", "tx",
+                                            NULL);
+        if (!obj) {
+            error_prepend(errp, "Failed to setup migration netpass");
+            return -1;
+        }
+        trace_migration_netpass_setup_created_filter(nc->name);
+        object_ref(obj);
+        QTAILQ_INSERT_TAIL(&filters, FILTER_NETPASS(obj), next);
+        vmstate_register(VMSTATE_IF(obj), VMSTATE_INSTANCE_ID_ANY,
+                         &vmstate_netpass, obj);
+    }
+    return 0;
+}
+
+void migration_netpass_activate(void)
+{
+    NetPassState *s;
+    QTAILQ_FOREACH(s, &filters, next) {
+        s->packet_count = 0;
+        s->active = true;
+        qemu_set_netpass_enabled(NETFILTER(s)->netdev, true);
+    }
+}
+
+void migration_netpass_cleanup(void)
+{
+    NetPassState *s, *ns;
+    QTAILQ_FOREACH_SAFE(s, &filters, next, ns) {
+        QTAILQ_REMOVE(&filters, s, next);
+        vmstate_unregister(VMSTATE_IF(s), &vmstate_netpass, s);
+        object_unref(s);
+    }
+}
diff --git a/migration/netpass.h b/migration/netpass.h
new file mode 100644
index 0000000000..8618cf4c73
--- /dev/null
+++ b/migration/netpass.h
@@ -0,0 +1,14 @@
+#ifndef QEMU_MIGRATION_NETPASS_H
+#define QEMU_MIGRATION_NETPASS_H
+
+#include "qemu/typedefs.h"
+#include "qom/object.h"
+
+#define TYPE_FILTER_NETPASS "filter-netpass"
+OBJECT_DECLARE_SIMPLE_TYPE(NetPassState, FILTER_NETPASS)
+
+int migration_netpass_setup(Error **errp);
+void migration_netpass_activate(void);
+void migration_netpass_cleanup(void);
+
+#endif
diff --git a/migration/options.c b/migration/options.c
index a5a233183b..e6e2d441b0 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -211,6 +211,7 @@ const Property migration_properties[] = {
     DEFINE_PROP_MIG_CAP("mapped-ram", MIGRATION_CAPABILITY_MAPPED_RAM),
     DEFINE_PROP_MIG_CAP("x-ignore-shared",
                         MIGRATION_CAPABILITY_X_IGNORE_SHARED),
+    DEFINE_PROP_MIG_CAP("netpass", MIGRATION_CAPABILITY_NETPASS),
 };
 const size_t migration_properties_count = ARRAY_SIZE(migration_properties);
 
@@ -442,6 +443,13 @@ bool migrate_send_vm_started(void)
     return s->send_vm_started;
 }
 
+bool migrate_netpass(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->capabilities[MIGRATION_CAPABILITY_NETPASS];
+}
+
 /* pseudo capabilities */
 
 bool migrate_multifd_flush_after_each_section(void)
@@ -723,6 +731,19 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
         }
     }
 
+    if (new_caps[MIGRATION_CAPABILITY_NETPASS]) {
+        if (!new_caps[MIGRATION_CAPABILITY_RETURN_PATH]) {
+            error_setg(errp, "Capability 'netpass' requires capability "
+                             "'return-path'");
+            return false;
+        }
+        if (!migrate_send_vm_started()) {
+            error_setg(errp, "Capability 'netpass' requires support for VM_STARTED "
+                             "return-path message");
+            return false;
+        }
+    }
+
     /*
      * On destination side, check the cases that capability is being set
      * after incoming thread has started.
diff --git a/migration/options.h b/migration/options.h
index 5fdc8fc6fe..151eaef86c 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -43,6 +43,7 @@ bool migrate_validate_uuid(void);
 bool migrate_xbzrle(void);
 bool migrate_zero_copy_send(void);
 bool migrate_send_vm_started(void);
+bool migrate_netpass(void);
 
 /*
  * pseudo capabilities
diff --git a/migration/savevm.c b/migration/savevm.c
index 78eb1d6165..b930f27fa9 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -279,6 +279,7 @@ static bool should_validate_capability(int capability)
     switch (capability) {
     case MIGRATION_CAPABILITY_X_IGNORE_SHARED:
     case MIGRATION_CAPABILITY_MAPPED_RAM:
+    case MIGRATION_CAPABILITY_NETPASS:
         return true;
     default:
         return false;
@@ -1731,6 +1732,29 @@ int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only)
     return qemu_fflush(f);
 }
 
+void qemu_savevm_state_netpass(QEMUFile *f)
+{
+    MigrationState *ms = migrate_get_current();
+    JSONWriter *vmdesc = ms->vmdesc;
+    SaveStateEntry *se;
+    Error *local_err = NULL;
+    int ret;
+
+    trace_savevm_state_netpass_begin();
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+        if (!se->vmsd || se->vmsd->phase != VMS_PHASE_NETPASS) {
+            continue;
+        }
+        ret = vmstate_save(f, se, vmdesc, &local_err);
+        if (ret) {
+            warn_report_err(local_err);
+            qemu_file_clear_error(f);
+            break;
+        }
+    }
+    trace_savevm_state_netpass_end(ret);
+}
+
 /* Give an estimate of the amount left to be transferred,
  * the result is split into the amount for units that can and
  * for units that can't do postcopy.
@@ -3148,6 +3172,19 @@ int qemu_load_device_state(QEMUFile *f, Error **errp)
     return 0;
 }
 
+void qemu_loadvm_state_netpass(QEMUFile *f, MigrationIncomingState *mis)
+{
+    Error *local_errp;
+    trace_loadvm_state_netpass_begin();
+    int ret = qemu_loadvm_state_main(mis->from_src_file, mis, &local_errp);
+    trace_loadvm_state_netpass_end(ret);
+    if (ret < 0) {
+        warn_reportf_err(local_errp,
+                         "Error while loading netpass data, this error will be ignored");
+        qemu_file_clear_error(f);
+    }
+}
+
 int qemu_loadvm_approve_switchover(void)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
diff --git a/migration/savevm.h b/migration/savevm.h
index 125a2507b7..53220c40cf 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -42,6 +42,7 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
 void qemu_savevm_state_cleanup(void);
 void qemu_savevm_state_complete_postcopy(QEMUFile *f);
 int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only);
+void qemu_savevm_state_netpass(QEMUFile *f);
 void qemu_savevm_state_pending_exact(uint64_t *must_precopy,
                                      uint64_t *can_postcopy);
 void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
@@ -71,6 +72,7 @@ void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
 int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
                            Error **errp);
 int qemu_load_device_state(QEMUFile *f, Error **errp);
+void qemu_loadvm_state_netpass(QEMUFile *f, MigrationIncomingState *mis);
 int qemu_loadvm_approve_switchover(void);
 int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
         bool in_postcopy);
diff --git a/migration/trace-events b/migration/trace-events
index 91d7506634..eb25944d1b 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -10,6 +10,8 @@ qemu_savevm_send_packaged(void) ""
 loadvm_state_switchover_ack_needed(unsigned int switchover_ack_pending_num) "Switchover ack pending num=%u"
 loadvm_state_setup(void) ""
 loadvm_state_cleanup(void) ""
+loadvm_state_netpass_begin(void) ""
+loadvm_state_netpass_end(int ret) "ret=%d"
 loadvm_handle_cmd_packaged(unsigned int length) "%u"
 loadvm_handle_cmd_packaged_main(int ret) "%d"
 loadvm_handle_cmd_packaged_received(int ret) "%d"
@@ -45,6 +47,8 @@ savevm_state_resume_prepare(void) ""
 savevm_state_header(void) ""
 savevm_state_iterate(void) ""
 savevm_state_cleanup(void) ""
+savevm_state_netpass_begin(void) ""
+savevm_state_netpass_end(int ret) "ret=%d"
 vmstate_save(const char *idstr, const char *vmsd_name) "%s, %s"
 vmstate_load(const char *idstr, const char *vmsd_name) "%s, %s"
 vmstate_downtime_save(const char *type, const char *idstr, uint32_t instance_id, int64_t downtime) "type=%s idstr=%s instance_id=%d downtime=%"PRIi64
@@ -401,3 +405,8 @@ cpu_throttle_dirty_sync(void) ""
 
 # block-active.c
 migration_block_activation(const char *name) "%s"
+
+# netpass.c
+migration_netpass_setup_created_filter(const char *netdev) "netdev=%s"
+migration_netpass_passed_packet_count(const char *netdev, size_t count) "netdev=%s count=%zu"
+migration_netpass_received_packet_count(const char *netdev, size_t count) "netdev=%s count=%zu"
diff --git a/net/net.c b/net/net.c
index a176936f9b..81540fefc1 100644
--- a/net/net.c
+++ b/net/net.c
@@ -158,6 +158,14 @@ void qemu_set_info_str(NetClientState *nc, const char *fmt, ...)
     va_end(ap);
 }
 
+void qemu_set_netpass_enabled(NetClientState *nc, bool enabled)
+{
+    nc->netpass_enabled = enabled;
+    if (nc->netpass_enabled_notify)  {
+        nc->netpass_enabled_notify(nc, nc->netpass_enabled_notify_opaque);
+    }
+}
+
 void qemu_format_nic_info_str(NetClientState *nc, uint8_t macaddr[6])
 {
     qemu_set_info_str(nc, "model=%s,macaddr=%02x:%02x:%02x:%02x:%02x:%02x",
@@ -287,6 +295,9 @@ static void qemu_net_client_setup(NetClientState *nc,
     nc->incoming_queue = qemu_new_net_queue(qemu_deliver_packet_iov, nc);
     nc->destructor = destructor;
     nc->is_datapath = is_datapath;
+    nc->netpass_enabled = false;
+    nc->netpass_enabled_notify = NULL;
+    nc->netpass_enabled_notify_opaque = NULL;
     QTAILQ_INIT(&nc->filters);
 }
 
diff --git a/net/tap.c b/net/tap.c
index 8d7ab6ba6f..dcc03a3f03 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -109,7 +109,8 @@ static char *tap_parse_script(const char *script_arg, const char *default_path)
 static void tap_update_fd_handler(TAPState *s)
 {
     qemu_set_fd_handler(s->fd,
-                        s->read_poll && s->enabled ? tap_send : NULL,
+                        (s->read_poll || s->nc.netpass_enabled) && s->enabled ?
+                            tap_send : NULL,
                         s->write_poll && s->enabled ? tap_writable : NULL,
                         s);
 }
@@ -412,6 +413,11 @@ static NetClientInfo net_tap_info = {
     .get_vhost_net = tap_get_vhost_net,
 };
 
+static void tap_netpass_enabled_nofity(NetClientState *nc, void *opaque)
+{
+    tap_update_fd_handler(opaque);
+}
+
 static TAPState *net_tap_fd_init(NetClientState *peer,
                                  const char *model,
                                  const char *name,
@@ -444,6 +450,9 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
     tap_read_poll(s, true);
     s->vhost_net = NULL;
 
+    nc->netpass_enabled_notify = &tap_netpass_enabled_nofity;
+    nc->netpass_enabled_notify_opaque = s;
+
     return s;
 }
 
diff --git a/qapi/migration.json b/qapi/migration.json
index f925e5541b..d637b22c80 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -520,6 +520,11 @@
 #     each RAM page.  Requires a migration URI that supports seeking,
 #     such as a file.  (since 9.0)
 #
+# @netpass: Collect packets received by network backedns after source
+#     VM is paused and send them to the destination once it resumes.
+#     This (almost) completely eliminates packet loss caused by
+#     switchover.  (since 11.0)
+#
 # Features:
 #
 # @unstable: Members @x-colo and @x-ignore-shared are experimental.
@@ -536,7 +541,7 @@
            { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
            'validate-uuid', 'background-snapshot',
            'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
-           'dirty-limit', 'mapped-ram'] }
+           'dirty-limit', 'mapped-ram', 'netpass'] }
 
 ##
 # @MigrationCapabilityStatus:
-- 
2.52.0


