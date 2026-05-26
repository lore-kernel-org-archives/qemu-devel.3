Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C9CCD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 11:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRptI-0005xE-2L; Tue, 26 May 2026 07:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wRptG-0005wn-AK
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:24:06 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wRptB-0003zJ-H4
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:24:06 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 6D959C01EE;
 Tue, 26 May 2026 14:23:57 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:31::1:10] (unknown [2a02:6bf:8080:31::1:10])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id tNWhJY1eZGk0-YulI5t8H; Tue, 26 May 2026 14:23:56 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1779794636;
 bh=DdBzZVCw0/8eL35NA/TMpvfMCPiB0x8sdb7TzmaEZy4=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=htiz1HTxZx94ZcXa10dkrB8qy5nbf2OR4bj0z8vP928J9RiRLxVKPP/CIZxYTq6rQ
 Lxalh+TJKrF3uvum8QNWHpe3se/BuC6Q7arEheoiW6xAGiShKtlr2vPYcrLuPdkoZh
 RFspd1aSTWsSvMVjEx4HSBDqJ4HpHApantDAQmYw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <62045016-a892-43b8-87b1-869ef8d8e9d7@yandex-team.ru>
Date: Tue, 26 May 2026 14:23:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 5/8] virtio-net: support local migration of backend
To: Peter Xu <peterx@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com,
 armbru@redhat.com, farosas@suse.de, raphael.s.norwitz@gmail.com,
 bchaney@akamai.com, qemu-devel@nongnu.org, berrange@redhat.com,
 pbonzini@redhat.com, yc-core@yandex-team.ru,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260522120534.77653-1-vsementsov@yandex-team.ru>
 <20260522120534.77653-6-vsementsov@yandex-team.ru>
 <20260524050632-mutt-send-email-mst@kernel.org>
 <c34e9bba-0e98-4694-870f-5f92f34f1076@yandex-team.ru>
 <ahRgbmVKuonjprB2@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <ahRgbmVKuonjprB2@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 25.05.26 17:45, Peter Xu wrote:
> On Mon, May 25, 2026 at 04:51:55PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 24.05.26 12:09, Michael S. Tsirkin wrote:
>>> On Fri, May 22, 2026 at 03:05:30PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>> Add virtio-net option local-migration, which is true by default,
>>>> but false for older machine types, which doesn't support the feature.
>>>>
>>>> When both global migration parameter "local" and new virtio-net
>>>> parameter "local-migration" are true, virtio-net transfer the whole
>>>> net backend to the destination, including open file descriptors.
>>>> Of-course, its only for local migration and the channel must be
>>>> UNIX domain socket.
>>>>
>>>> This way management tool should not care about creating new TAP, and
>>>> should not handle switching to it. Migration downtime become shorter.
>>>>
>>>> Support for TAP will come in the next commit.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy<vsementsov@yandex-team.ru>
>>>> Reviewed-by: Ben Chaney<bchaney@akamai.com>
>>> I don't get why is this a device property?
>>> It's clearly a backend thing?
>>>
>> Hmm.
>>
>> We want to be able to disable fd-migration per device, when common "local"
>> migration parameter is on.
>>
>> That's why we have parameter for virtio-net. It's also good, that we may
>> enable it by default for newer machine types, to make fd-migration a default
>> path.
>>
>> To be honest, it seems that the only thing in this patch (except for interface),
>> which is not about backand, is that we want to do virtio_net_update_host_features()
>> after backends incoming migration finished. For this, it's comfortable to have
>> backend migration as part of device migration stream.
>>
>> --
>>
>> Imagine, we move "local-migration" parameter to TAP device. This raise a lot of questions:
> Hmm, I thought we discussed this quite some time ago..  I can't remember
> details, but I'll try to comment with what I can still remember.
> 
>> 1. We loss a possibility to set good default in machine type. Ok, we probably may add
>> a property to "migration" object, but this property will look like "TAP-local-migration",
>> and raise discussion again, that it should be property of TAP..
> If you recall I worked on the other series because of this desire of having
> tap be able to be QOMified and also support machine compat properties:
> 
> https://lore.kernel.org/all/20251209162857.857593-2-peterx@redhat.com/
> 
> I didn't get a lot of feedback supporting having TYPE_OBJECT_COMPAT, maybe
> it's an overkill only to apply object_apply_compat_props().
> 
> However, just to say we can still QOMify TAP and then add its own
> instance_post_init() to also do object_apply_compat_props(), like quite a
> few other existing users, then this (1) isn't a problem, and it doesn't
> need to depend on my series either.

Thanks for reminding and explanation. Previously, I thought that
QOMification is huge task, and your series is required. Now I see,
that it is not so difficult. All that's left for me to say is
"let's try it")


Here is an experimental diff on top on this series. If you like it,
I'll resend with proper division into commits:


diff --git a/hw/core/machine.c b/hw/core/machine.c
index 619e80c1cb3..67e873c74fe 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -36,12 +36,13 @@
  #include "hw/virtio/virtio-pci.h"
  #include "hw/virtio/virtio-net.h"
  #include "hw/virtio/virtio-iommu.h"
+#include "net/tap.h"
  #include "hw/acpi/generic_event_device.h"
  #include "qemu/audio.h"
  
  GlobalProperty hw_compat_11_0[] = {
      { "chardev-vc", "encoding", "cp437" },
-    { TYPE_VIRTIO_NET, "local-migration", "false" },
+    { TYPE_TAP_NETDEV, "local-migration", "false" },
  };
  const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
  
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 158b9247a58..bad349d3e83 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3202,24 +3202,13 @@ static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
      }
  }
  
-static bool virtio_net_update_host_features(VirtIONet *n, Error **errp)
-{
-    ERRP_GUARD();
-    VirtIODevice *vdev = VIRTIO_DEVICE(n);
-
-    peer_test_vnet_hdr(n);
-
-    virtio_net_get_features(vdev, &vdev->host_features, errp);
-
-    return !*errp;
-}
-
  static int virtio_net_post_load_device(void *opaque, int version_id)
  {
      VirtIONet *n = opaque;
      VirtIODevice *vdev = VIRTIO_DEVICE(n);
      int i, link_down;
      bool has_tunnel_hdr = virtio_has_tunnel_hdr(vdev->guest_features_ex);
+    Error *local_err = NULL;
  
      trace_virtio_net_post_load_device();
      virtio_net_set_mrg_rx_bufs(n, n->mergeable_rx_bufs,
@@ -3277,6 +3266,19 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
      }
  
      virtio_net_commit_rss_config(n);
+
+    /*
+     * The TAP backend has already been migrated at higher priority
+     * (MIG_PRI_TAP) and virtio_net_vnet_post_load() has already called
+     * peer_test_vnet_hdr().  Recompute host_features so that virtio-net
+     * reflects the capabilities of the restored backend.
+     */
+    virtio_net_get_features(vdev, &vdev->host_features, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        return -EINVAL;
+    }
+
      return 0;
  }
  
@@ -3430,6 +3432,13 @@ static int virtio_net_vnet_post_load(void *opaque, int version_id)
  {
      struct VirtIONetMigTmp *tmp = opaque;
  
+    /*
+     * The TAP backend has already been migrated at higher priority
+     * (MIG_PRI_TAP), so n->has_vnet_hdr can be refreshed from the live
+     * backend right here.
+     */
+    peer_test_vnet_hdr(tmp->parent);
+
      if (tmp->has_vnet_hdr && !peer_has_vnet_hdr(tmp->parent)) {
          error_report("virtio-net: saved image requires vnet_hdr=on");
          return -EINVAL;
@@ -3607,57 +3616,6 @@ static const VMStateDescription vhost_user_net_backend_state = {
      }
  };
  
-static bool virtio_net_migrate_local(void *opaque, int version_id)
-{
-    VirtIONet *n = opaque;
-
-    return migrate_local() && n->local_migration;
-}
-
-static int virtio_net_nic_pre_save(void *opaque)
-{
-    struct VirtIONetMigTmp *tmp = opaque;
-
-    tmp->ncs = tmp->parent->nic->ncs;
-    tmp->max_queue_pairs = tmp->parent->max_queue_pairs;
-
-    return 0;
-}
-
-static int virtio_net_nic_pre_load(void *opaque)
-{
-    /* Reuse the pointer setup from save */
-    virtio_net_nic_pre_save(opaque);
-
-    return 0;
-}
-
-static int virtio_net_nic_post_load(void *opaque, int version_id)
-{
-    struct VirtIONetMigTmp *tmp = opaque;
-    Error *local_err = NULL;
-
-    if (!virtio_net_update_host_features(tmp->parent, &local_err)) {
-        error_report_err(local_err);
-        return -EINVAL;
-    }
-
-    return 0;
-}
-
-static const VMStateDescription vmstate_virtio_net_nic = {
-    .name      = "virtio-net-nic",
-    .pre_load  = virtio_net_nic_pre_load,
-    .pre_save  = virtio_net_nic_pre_save,
-    .post_load  = virtio_net_nic_post_load,
-    .fields    = (const VMStateField[]) {
-        VMSTATE_VARRAY_UINT32(ncs, struct VirtIONetMigTmp,
-                              max_queue_pairs, 0, vmstate_net_peer_backend,
-                              NetClientState),
-        VMSTATE_END_OF_LIST()
-    },
-};
-
  static const VMStateDescription vmstate_virtio_net_device = {
      .name = "virtio-net-device",
      .version_id = VIRTIO_NET_VM_VERSION,
@@ -3689,9 +3647,6 @@ static const VMStateDescription vmstate_virtio_net_device = {
           * but based on the uint.
           */
          VMSTATE_BUFFER_POINTER_UNSAFE(vlans, VirtIONet, 0, MAX_VLAN >> 3),
-        VMSTATE_WITH_TMP_TEST(VirtIONet, virtio_net_migrate_local,
-                              struct VirtIONetMigTmp,
-                              vmstate_virtio_net_nic),
          VMSTATE_WITH_TMP(VirtIONet, struct VirtIONetMigTmp,
                           vmstate_virtio_net_has_vnet),
          VMSTATE_UINT8(mac_table.multi_overflow, VirtIONet),
@@ -4444,7 +4399,6 @@ static const Property virtio_net_properties[] = {
                                 host_features_ex,
                                 VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM,
                                 true),
-    DEFINE_PROP_BOOL("local-migration", VirtIONet, local_migration, true),
  };
  
  static void virtio_net_class_init(ObjectClass *klass, const void *data)
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 0c14e314409..8c967760c2a 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -231,7 +231,6 @@ struct VirtIONet {
      uint32_t nr_ebpf_rss_fds;
      char **ebpf_rss_fds;
      bool peers_wait_incoming;
-    bool local_migration;
  };
  
  size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 0a8a2e85a63..e7b3cd7db01 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -178,6 +178,7 @@ typedef enum {
  
      MIG_PRI_LOW,                /* Must happen after default */
      MIG_PRI_DEFAULT,
+    MIG_PRI_TAP,                /* Must happen before virtio-net device */
      MIG_PRI_IOMMU,              /* Must happen before PCI devices */
      MIG_PRI_PCI_BUS,            /* Must happen before IOMMU */
      MIG_PRI_VIRTIO_MEM,         /* Must happen before IOMMU */
diff --git a/include/net/net.h b/include/net/net.h
index d4cf399d4a8..be7ca0ce845 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -113,7 +113,6 @@ typedef struct NetClientInfo {
      NetCheckPeerType *check_peer_type;
      IsWaitIncoming *is_wait_incoming;
      GetVHostNet *get_vhost_net;
-    const VMStateDescription *backend_vmsd;
  } NetClientInfo;
  
  struct NetClientState {
@@ -164,6 +163,13 @@ char *qemu_mac_strdup_printf(const uint8_t *macaddr);
  NetClientState *qemu_find_netdev(const char *id);
  int qemu_find_net_clients_except(const char *id, NetClientState **ncs,
                                   NetClientDriver type, int max);
+void qemu_net_client_setup(NetClientState *nc,
+                           NetClientInfo *info,
+                           NetClientState *peer,
+                           const char *model,
+                           const char *name,
+                           NetClientDestructor *destructor,
+                           bool is_datapath);
  NetClientState *qemu_new_net_client(NetClientInfo *info,
                                      NetClientState *peer,
                                      const char *model,
@@ -358,6 +364,4 @@ static inline bool net_peer_needs_padding(NetClientState *nc)
    return nc->peer && !nc->peer->do_not_pad;
  }
  
-extern const VMStateInfo vmstate_net_peer_backend;
-
  #endif
diff --git a/include/net/tap.h b/include/net/tap.h
index 6f34f13eae4..325de81f03b 100644
--- a/include/net/tap.h
+++ b/include/net/tap.h
@@ -28,9 +28,12 @@
  
  #include "standard-headers/linux/virtio_net.h"
  
+#define TYPE_TAP_NETDEV "tap-netdev"
+
  int tap_enable(NetClientState *nc);
  int tap_disable(NetClientState *nc);
  
  int tap_get_fd(NetClientState *nc);
+bool tap_get_local_migration(NetClientState *nc);
  
  #endif /* QEMU_NET_TAP_H */
diff --git a/net/net.c b/net/net.c
index 8bccb1880a1..34766763ae5 100644
--- a/net/net.c
+++ b/net/net.c
@@ -58,7 +58,6 @@
  #include "qapi/string-output-visitor.h"
  #include "qapi/qobject-input-visitor.h"
  #include "standard-headers/linux/virtio_net.h"
-#include "migration/vmstate.h"
  
  /* Net bridge is currently not supported for W32. */
  #if !defined(_WIN32)
@@ -262,13 +261,13 @@ static ssize_t qemu_deliver_packet_iov(NetClientState *sender,
                                         int iovcnt,
                                         void *opaque);
  
-static void qemu_net_client_setup(NetClientState *nc,
-                                  NetClientInfo *info,
-                                  NetClientState *peer,
-                                  const char *model,
-                                  const char *name,
-                                  NetClientDestructor *destructor,
-                                  bool is_datapath)
+void qemu_net_client_setup(NetClientState *nc,
+                           NetClientInfo *info,
+                           NetClientState *peer,
+                           const char *model,
+                           const char *name,
+                           NetClientDestructor *destructor,
+                           bool is_datapath)
  {
      nc->info = info;
      nc->model = g_strdup(model);
@@ -2175,48 +2174,3 @@ int net_fill_rstate(SocketReadState *rs, const uint8_t *buf, int size)
      return 0;
  }
  
-static int get_peer_backend(QEMUFile *f, void *pv, size_t size,
-                            const VMStateField *field)
-{
-    NetClientState *nc = pv;
-    Error *local_err = NULL;
-    int ret;
-
-    if (!nc->peer) {
-        return -EINVAL;
-    }
-    nc = nc->peer;
-
-    ret = vmstate_load_state(f, nc->info->backend_vmsd, nc, 0, &local_err);
-    if (ret < 0) {
-        error_report_err(local_err);
-    }
-
-    return ret;
-}
-
-static int put_peer_backend(QEMUFile *f, void *pv, size_t size,
-                            const VMStateField *field, JSONWriter *vmdesc)
-{
-    NetClientState *nc = pv;
-    Error *local_err = NULL;
-    int ret;
-
-    if (!nc->peer) {
-        return -EINVAL;
-    }
-    nc = nc->peer;
-
-    ret = vmstate_save_state(f, nc->info->backend_vmsd, nc, 0, &local_err);
-    if (ret < 0) {
-        error_report_err(local_err);
-    }
-
-    return ret;
-}
-
-const VMStateInfo vmstate_net_peer_backend = {
-    .name = "virtio-net-nic-nc-backend",
-    .get = get_peer_backend,
-    .put = put_peer_backend,
-};
diff --git a/net/tap.c b/net/tap.c
index 9b1d4613a0b..e3aeb99d249 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -38,12 +38,17 @@
  #include "monitor/monitor.h"
  #include "system/runstate.h"
  #include "system/system.h"
+#include "migration/misc.h"
  #include "qapi/error.h"
  #include "qemu/cutils.h"
  #include "qemu/error-report.h"
  #include "qemu/main-loop.h"
  #include "qemu/sockets.h"
  #include "hw/virtio/vhost.h"
+#include "hw/core/vmstate-if.h"
+#include "migration/vmstate.h"
+#include "qom/object.h"
+#include "qom/compat-properties.h"
  
  #include "net/tap.h"
  #include "net/util.h"
@@ -69,7 +74,13 @@ static const int kernel_feature_bits[] = {
      VHOST_INVALID_FEATURE_BIT
  };
  
-typedef struct TAPState {
+OBJECT_DECLARE_SIMPLE_TYPE(TAPState, TAP_NETDEV)
+
+static const VMStateDescription vmstate_tap;
+
+struct TAPState {
+    Object parent_obj;
+
      NetClientState nc;
      int fd;
      int vhostfd;
@@ -90,7 +101,9 @@ typedef struct TAPState {
  
      bool read_poll_detached;
      VMChangeStateEntry *vmstate;
-} TAPState;
+    bool local_migration;
+    int queue_index;
+};
  
  static void launch_script(const char *setup_script, const char *ifname,
                            int fd, Error **errp);
@@ -182,7 +195,7 @@ static ssize_t tap_write_packet(TAPState *s, const struct iovec *iov, int iovcnt
  static ssize_t tap_receive_iov(NetClientState *nc, const struct iovec *iov,
                                 int iovcnt)
  {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
      const struct iovec *iovp = iov;
      g_autofree struct iovec *iov_copy = NULL;
      struct virtio_net_hdr hdr = { };
@@ -218,7 +231,7 @@ ssize_t tap_read_packet(int tapfd, uint8_t *buf, int maxlen)
  
  static void tap_send_completed(NetClientState *nc, ssize_t len)
  {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
      tap_read_poll(s, true);
  }
  
@@ -278,7 +291,7 @@ static void tap_send(void *opaque)
  
  static bool tap_has_ufo(NetClientState *nc)
  {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
  
      assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
  
@@ -287,7 +300,7 @@ static bool tap_has_ufo(NetClientState *nc)
  
  static bool tap_has_uso(NetClientState *nc)
  {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
  
      assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
  
@@ -296,7 +309,7 @@ static bool tap_has_uso(NetClientState *nc)
  
  static bool tap_has_tunnel(NetClientState *nc)
  {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
  
      assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
      return s->has_tunnel;
@@ -304,7 +317,7 @@ static bool tap_has_tunnel(NetClientState *nc)
  
  static bool tap_has_vnet_hdr(NetClientState *nc)
  {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
  
      assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
  
@@ -318,7 +331,7 @@ static bool tap_has_vnet_hdr_len(NetClientState *nc, int len)
  
  static void tap_set_vnet_hdr_len(NetClientState *nc, int len)
  {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
  
      assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
  
@@ -329,21 +342,21 @@ static void tap_set_vnet_hdr_len(NetClientState *nc, int len)
  
  static int tap_set_vnet_le(NetClientState *nc, bool is_le)
  {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
  
      return tap_fd_set_vnet_le(s->fd, is_le);
  }
  
  static int tap_set_vnet_be(NetClientState *nc, bool is_be)
  {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
  
      return tap_fd_set_vnet_be(s->fd, is_be);
  }
  
  static void tap_set_offload(NetClientState *nc, const NetOffloads *ol)
  {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
      if (s->fd < 0) {
          return;
      }
@@ -364,7 +377,7 @@ static void tap_exit_notify(Notifier *notifier, void *data)
  
  static void tap_cleanup(NetClientState *nc)
  {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
  
      if (s->vhost_net) {
          vhost_net_cleanup(s->vhost_net);
@@ -389,18 +402,20 @@ static void tap_cleanup(NetClientState *nc)
      tap_write_poll(s, false);
      close(s->fd);
      s->fd = -1;
+
+    vmstate_unregister(VMSTATE_IF(s), &vmstate_tap, s);
  }
  
  static void tap_poll(NetClientState *nc, bool enable)
  {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
      tap_read_poll(s, enable);
      tap_write_poll(s, enable);
  }
  
  static bool tap_set_steering_ebpf(NetClientState *nc, int prog_fd)
  {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
      assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
  
      return tap_fd_set_steering_ebpf(s->fd, prog_fd) == 0;
@@ -408,7 +423,7 @@ static bool tap_set_steering_ebpf(NetClientState *nc, int prog_fd)
  
  int tap_get_fd(NetClientState *nc)
  {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
      assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
      return s->fd;
  }
@@ -420,14 +435,14 @@ int tap_get_fd(NetClientState *nc)
   */
  static VHostNetState *tap_get_vhost_net(NetClientState *nc)
  {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
      assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
      return s->vhost_net;
  }
  
  static bool tap_is_wait_incoming(NetClientState *nc)
  {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
      assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
      return s->fd == -1;
  }
@@ -468,10 +483,19 @@ static int tap_post_load(void *opaque, int version_id)
      return 0;
  }
  
+static bool tap_needed(void *opaque)
+{
+    TAPState *s = opaque;
+
+    return s->local_migration && migrate_local();
+}
+
  static const VMStateDescription vmstate_tap = {
      .name = "net-tap",
+    .priority = MIG_PRI_TAP,
      .pre_load = tap_pre_load,
      .post_load = tap_post_load,
+    .needed = tap_needed,
      .fields = (const VMStateField[]) {
          VMSTATE_FD(fd, TAPState),
          VMSTATE_BOOL(using_vnet_hdr, TAPState),
@@ -484,6 +508,63 @@ static const VMStateDescription vmstate_tap = {
      }
  };
  
+static char *tap_vmstate_if_get_id(VMStateIf *obj)
+{
+    TAPState *s = TAP_NETDEV(obj);
+    char *res = g_strdup_printf("%s/%d", s->nc.name, s->queue_index);
+    return res;
+}
+
+static bool tap_get_local_migration_prop(Object *obj, Error **errp)
+{
+    TAPState *s = TAP_NETDEV(obj);
+    return s->local_migration;
+}
+
+static void tap_set_local_migration_prop(Object *obj, bool value, Error **errp)
+{
+    TAPState *s = TAP_NETDEV(obj);
+    s->local_migration = value;
+}
+
+static void tap_instance_init(Object *obj)
+{
+    TAPState *s = TAP_NETDEV(obj);
+    s->local_migration = true;
+}
+
+static void tap_class_init(ObjectClass *klass, const void *data)
+{
+    VMStateIfClass *vc = VMSTATE_IF_CLASS(klass);
+
+    vc->get_id = tap_vmstate_if_get_id;
+
+    object_class_property_add_bool(klass, "local-migration",
+                                   tap_get_local_migration_prop,
+                                   tap_set_local_migration_prop);
+    object_class_property_set_description(klass, "local-migration",
+        "Migrate the TAP file descriptor to the target (local migration)");
+}
+
+static const TypeInfo tap_netdev_info = {
+    .name = TYPE_TAP_NETDEV,
+    .parent = TYPE_OBJECT,
+    .instance_size = sizeof(TAPState),
+    .instance_init = tap_instance_init,
+    .instance_post_init = object_apply_compat_props,
+    .class_init = tap_class_init,
+    .interfaces = (const InterfaceInfo[]) {
+        { TYPE_VMSTATE_IF },
+        { }
+    },
+};
+
+static void tap_net_client_destructor(NetClientState *nc)
+{
+    TAPState *s = container_of(nc, TAPState, nc);
+    object_unref(OBJECT(s));
+}
+
  /* fd support */
  
  static NetClientInfo net_tap_info = {
@@ -505,22 +586,43 @@ static NetClientInfo net_tap_info = {
      .set_steering_ebpf = tap_set_steering_ebpf,
      .is_wait_incoming = tap_is_wait_incoming,
      .get_vhost_net = tap_get_vhost_net,
-    .backend_vmsd = &vmstate_tap,
  };
  
+static TAPState *new_tap(NetClientState *peer,
+                         const char *model,
+                         const char *name,
+                         int queue_index,
+                         bool has_local_migration,
+                         bool local_migration)
+{
+    TAPState *s = TAP_NETDEV(object_new(TYPE_TAP_NETDEV));
+
+    qemu_net_client_setup(&s->nc, &net_tap_info, peer, model, name,
+                          tap_net_client_destructor, true);
+
+    s->queue_index = queue_index;
+
+    if (has_local_migration) {
+        s->local_migration = local_migration;
+    }
+
+    vmstate_register(VMSTATE_IF(s), VMSTATE_INSTANCE_ID_ANY, &vmstate_tap, s);
+
+    return s;
+}
+
  static TAPState *net_tap_fd_init(NetClientState *peer,
                                   const char *model,
                                   const char *name,
                                   int fd,
-                                 int vnet_hdr)
+                                 int vnet_hdr,
+                                 int queue_index,
+                                 bool has_local_migration,
+                                 bool local_migration)
  {
      NetOffloads ol = {};
-    NetClientState *nc;
-    TAPState *s;
-
-    nc = qemu_new_net_client(&net_tap_info, peer, model, name);
-
-    s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = new_tap(peer, model, name, queue_index,
+                          has_local_migration, local_migration);
  
      s->fd = fd;
      s->host_vnet_hdr_len = vnet_hdr ? sizeof(struct virtio_net_hdr) : 0;
@@ -757,7 +859,7 @@ int net_init_bridge(const Netdev *netdev, const char *name,
          close(fd);
          return -1;
      }
-    s = net_tap_fd_init(peer, "bridge", name, fd, vnet_hdr);
+    s = net_tap_fd_init(peer, "bridge", name, fd, vnet_hdr, 0, true, false);
  
      qemu_set_info_str(&s->nc, "helper=%s,br=%s", helper, br);
  
@@ -833,10 +935,13 @@ static bool net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
                               const char *name,
                               const char *ifname, const char *script,
                               const char *downscript, int vhostfd,
-                             int vnet_hdr, int fd, Error **errp)
+                             int vnet_hdr, int fd, int queue_index,
+                             Error **errp)
  {
      TAPState *s = net_tap_fd_init(peer, tap->helper ? "bridge" : "tap",
-                                  name, fd, vnet_hdr);
+                                  name, fd, vnet_hdr, queue_index,
+                                  tap->has_local_migration,
+                                  tap->local_migration);
      bool sndbuf_required = tap->has_sndbuf;
      int sndbuf =
          (tap->has_sndbuf && tap->sndbuf) ? MIN(tap->sndbuf, INT_MAX) : INT_MAX;
@@ -1048,13 +1153,11 @@ int net_init_tap(const Netdev *netdev, const char *name,
  
      if (tap->incoming_fds) {
          for (i = 0; i < queues; i++) {
-            NetClientState *nc;
-            TAPState *s;
+            TAPState *s = new_tap(peer, "tap", name, i,
+                                  tap->has_local_migration, tap->local_migration);
  
-            nc = qemu_new_net_client(&net_tap_info, peer, "tap", name);
-            qemu_set_info_str(nc, "incoming");
+            qemu_set_info_str(&s->nc, "incoming");
  
-            s = DO_UPCAST(TAPState, nc, nc);
              s->fd = -1;
              if (vhost_fds) {
                  s->vhostfd = vhost_fds[i];
@@ -1079,7 +1182,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
              if (!net_init_tap_one(tap, peer, name, ifname,
                                    NULL, NULL,
                                    vhost_fds ? vhost_fds[i] : -1,
-                                  vnet_hdr, fds[i], errp)) {
+                                  vnet_hdr, fds[i], i, errp)) {
                  goto fail;
              }
          }
@@ -1113,7 +1216,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
                                    i >= 1 ? NULL : script,
                                    i >= 1 ? NULL : downscript,
                                    vhost_fds ? vhost_fds[i] : -1,
-                                  vnet_hdr, fd, errp)) {
+                                  vnet_hdr, fd, i, errp)) {
                  goto fail;
              }
          }
@@ -1130,7 +1233,7 @@ fail:
  
  int tap_enable(NetClientState *nc)
  {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
      int ret;
  
      if (s->enabled) {
@@ -1147,7 +1250,7 @@ int tap_enable(NetClientState *nc)
  
  int tap_disable(NetClientState *nc)
  {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
      int ret;
  
      if (s->enabled == 0) {
@@ -1162,3 +1265,10 @@ int tap_disable(NetClientState *nc)
          return ret;
      }
  }
+
+static void tap_register_types(void)
+{
+    type_register_static(&tap_netdev_info);
+}
+
+type_init(tap_register_types)
diff --git a/qapi/net.json b/qapi/net.json
index 82ddbb51cd7..029f5a4532c 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -429,9 +429,18 @@
  #     getting TAP file descriptors from incoming migration stream.
  #     The option is incompatible with any of @fd, @fds, @helper, @br,
  #     @ifname, @sndbuf and @vnet_hdr options, and requires @script and
-#     @downscript be explicitly set to nothing (empty string or "no")
+#     @downscript be explicitly set to nothing (empty string or "no"),
+#     and requires also @local-migration to be set an "local"
+#     migration parameter be set as well.
  #     (Since 11.1)
  #
+# @local-migration: enable local migration for this TAP backend.
+#     When set, local migration is enabled/disabled by "local"
+#     migration parameter for this TAP backend.  When unset, "local"
+#     migration parameter is ignored for this TAP backend.
+#     (Since 11.1.  Defaults to true for MT >= 11.1,
+#     and to false for MT < 11.1)
+#
  # Since: 1.2
  ##
  { 'struct': 'NetdevTapOptions',
@@ -451,7 +460,8 @@
      '*vhostforce': 'bool',
      '*queues':     'uint32',
      '*poll-us':    'uint32',
-    '*incoming-fds': 'bool' } }
+    '*incoming-fds': 'bool',
+    '*local-migration': 'bool' } }
  
  ##
  # @NetdevSocketOptions:
diff --git a/tests/functional/x86_64/test_tap_migration.py b/tests/functional/x86_64/test_tap_migration.py
index 7708facc153..b220969f9ad 100755
--- a/tests/functional/x86_64/test_tap_migration.py
+++ b/tests/functional/x86_64/test_tap_migration.py
@@ -332,6 +332,7 @@ def add_virtio_net(
              "incoming-fds": incoming_fds,
              "script": "no",
              "downscript": "no",
+            "local-migration": local,
          }
  
          if not incoming_fds:
@@ -351,7 +352,6 @@ def add_virtio_net(
              bus="pci.1",
              mac=GUEST_MAC,
              disable_legacy="off",
-            local_migration=local,
          )
  
      def set_migration_capabilities(self, vm, local=True):


-- 
Best regards,
Vladimir

