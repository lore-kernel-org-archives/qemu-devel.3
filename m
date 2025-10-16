Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5373FCCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 20:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9UYh-0004iI-Th; Thu, 16 Oct 2025 16:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9UYf-0004cf-1q
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 16:26:45 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9UYX-0001a0-B2
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 16:26:44 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:9297:0:640:61e7:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 38652808B6;
 Thu, 16 Oct 2025 23:26:32 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a8c::1:19] (unknown
 [2a02:6bf:8080:a8c::1:19])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id TQYfZM2FiGk0-hM7p52gw; Thu, 16 Oct 2025 23:26:31 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760646391;
 bh=rxUec4Lnpo5lw40QLIBIGiHDM5iAPMEcS20njVOo1r8=;
 h=In-Reply-To:Cc:Date:References:To:From:Subject:Message-ID;
 b=eljPXxQZQQ3wfAvvfrOUeMAtDw3dV0ZKqKF9D5mUCNPeiYteJ35fc93wlcZZ3F7ln
 pBZn9iEWQttKtMuYGE1Z6OHNrR2f9OiDRm7bQsV3LrpIM6LJ5qj6qazqPVyn/YyMD8
 30oM+lj+qdZkhVyMsOlOyZSLnsSGA8Ak0zR9cd74=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <a36fdf7e-b7c7-4faa-8cb3-40e2433e9d8c@yandex-team.ru>
Date: Thu, 16 Oct 2025 23:26:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 16/19] qapi: introduce backend-transfer migration
 parameter
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, mst@redhat.com, jasowang@redhat.com,
 farosas@suse.de, sw@weilnetz.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, philmd@linaro.org, qemu-devel@nongnu.org,
 michael.roth@amd.com, leiyang@redhat.com, davydov-max@yandex-team.ru,
 yc-core@yandex-team.ru, raphael.s.norwitz@gmail.com
References: <20251015132136.1083972-1-vsementsov@yandex-team.ru>
 <20251015132136.1083972-17-vsementsov@yandex-team.ru>
 <aO_ll4Lf0bq6vgdm@x1.local>
 <3b9f1da4-6264-45d4-ade1-a6273cc6fa1e@yandex-team.ru>
 <aO_--QWDJO7iOhR4@x1.local>
 <8c575b3a-7d1f-446d-8f6d-4b2e4b851731@yandex-team.ru>
 <aPCtkB-GvFNuqlHn@redhat.com>
 <29aa1d66-9fa7-4e44-b0e3-2ca26e77accf@yandex-team.ru>
Content-Language: en-US
In-Reply-To: <29aa1d66-9fa7-4e44-b0e3-2ca26e77accf@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 16.10.25 12:23, Vladimir Sementsov-Ogievskiy wrote:
> On 16.10.25 11:32, Daniel P. Berrangé wrote:
>> On Thu, Oct 16, 2025 at 12:02:45AM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>> On 15.10.25 23:07, Peter Xu wrote:
>>>> On Wed, Oct 15, 2025 at 10:02:14PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>>> On 15.10.25 21:19, Peter Xu wrote:
>>>>>> On Wed, Oct 15, 2025 at 04:21:32PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>> This parameter enables backend-transfer feature: all devices
>>>>>>> which support it will migrate their backends (for example a TAP
>>>>>>> device, by passing open file descriptor to migration channel).
>>>>>>>
>>>>>>> Currently no such devices, so the new parameter is a noop.
>>>>>>>
>>>>>>> Next commit will add support for virtio-net, to migrate its
>>>>>>> TAP backend.
>>>>>>>
>>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>>>>>> ---
>>>>>
>>>>> [..]
>>>>>
>>>>>>> --- a/qapi/migration.json
>>>>>>> +++ b/qapi/migration.json
>>>>>>> @@ -951,9 +951,16 @@
>>>>>>>     #     is @cpr-exec.  The first list element is the program's filename,
>>>>>>>     #     the remainder its arguments.  (Since 10.2)
>>>>>>>     #
>>>>>>> +# @backend-transfer: Enable backend-transfer feature for devices that
>>>>>>> +#     supports it. In general that means that backend state and its
>>>>>>> +#     file descriptors are passed to the destination in the migraton
>>>>>>> +#     channel (which must be a UNIX socket). Individual devices
>>>>>>> +#     declare the support for backend-transfer by per-device
>>>>>>> +#     backend-transfer option. (Since 10.2)
>>>>>>
>>>>>> Thanks.
>>>>>>
>>>>>> I still prefer the name "fd-passing" or anything more explicit than
>>>>>> "backend-transfer". Maybe the current name is fine for TAP, only because
>>>>>> TAP doesn't have its own VMSD to transfer?
>>>>>>
>>>>>> Consider a device that would be a backend that supports VMSDs already to be
>>>>>> migrated, then if it starts to allow fd-passing, this name will stop being
>>>>>> suitable there, because it used to "transfer backend" already, now it's
>>>>>> just started to "fd-passing".
>>>>>>
>>>>>> Meanwhile, consider another example - what if a device is not a backend at
>>>>>> all (e.g. vfio?), has its own VMSD, then want to do fd-passing?
>>>>>
>>>>> Reasonable.
>>>>>
>>>>> But consider also the discussion with Fabiano in v5, where he argues against fds
>>>>> (reasonable too):
>>>>>
>>>>> https://lore.kernel.org/qemu-devel/87y0qatqoa.fsf@suse.de/
>>>>>
>>>>> (still, they were against my "fds" name for the parameter, which is
>>>>> really too generic, fd-passing is not)
>>>>>
>>>>> and the arguments for backend-transfer (to read similar with cpr-transfer)
>>>>>
>>>>> https://lore.kernel.org/qemu-devel/87ms6qtlgf.fsf@suse.de/
>>>>>
>>>>>
>>>>>>
>>>>>> In general, I think "fd" is really a core concept of this whole thing.
>>>>>
>>>>> I think, we can call "backend" any external object, linked by the fd.
>>>>>
>>>>> Still, backend/frontend terminology is so misleading, when applied to
>>>>> complex systems (for me, at least), that I don't really like "-backend"
>>>>> word here.
>>>>>
>>>>> fd-passing is OK for me, I can resend with it, if arguments by Fabiano
>>>>> not change your mind.
>>>>
>>>> Ah, I didn't notice the name has been discussed.
>>>>
>>>> I think it means you can vote for your own preference now because we have
>>>> one vote for each. :) Let's also see whether Fabiano will come up with
>>>> something better than both.
>>>>
>>>> You mentioned explicitly the file descriptors in the qapi doc, that's what
>>>> I would strongly request for.  The other thing is the unix socket check, it
>>>> looks all good below now with it, thanks.  No strong feelings on the names.
>>>>
>>>
>>> After a bit more thinking, I leaning towards keeping backend-transfer. I think
>>> it's more meaningful for the user:
>>>
>>> If we call it "fd-passing", user may ask:
>>>
>>> Ok, what is it? Allow QEMU to pass some fds through migration stream, if it
>>> supports fds? Which fds? Why to pass them? Finally, why QEMU can't just check
>>> is it unix socket or not, and pass any fds it wants if it is?
>>>
>>> Logical question is, why not just drop the global capability, and check only
>>> is it unix socket or not? (OK, relying only on socket type is wrong anyway,
>>> as it may be some complex tunneling, which includes unix sockets, but still
>>> can't pass fds, but I think now about feature naming)
>>>
>>> But we really want an explicit switch for the feature. As qemu-update is
>>> not the only case of local migration. The another case is changing the
>>> backend. So for the user's choice is:
>>>
>>> 1. Remote migration: we can't reuse backends (files, sockets, host devices), as
>>> we are moving to another host. So, we don't enable "backend-transfer". We don't
>>> transfer the backend, we have to initialize new backend on another host.
>>>
>>> 2. Local migration to update QEMU, with minimal freeze-time and minimal
>>> extra actions: use "backend-transfer", exactly to keep the backends
>>> (vhost-user-server, TAP device in kernel, in-kernel vfio device state, etc)
>>> as is.
>>>
>>> 3. Local migration, but we want to reconfigure some backend, or switch
>>> to another backend. We disable "backend-transfer" for one device.
>>
>> This implies that you're changing 'backend-transfer' against the
>> device at time of each migration.
>>
>> This takes us back to the situation we've had historically where the
>> behaviour of migration depends on global properties the mgmt app has
>> set prior to the 'migrate' command being run. We've just tried to get
>> away from that model by passing everything as parameters to the
>> migrate command, so I'm loathe to see us invent a new way to have
>> global state properties changing migration behaviour.
>>
>> This 'backend-transfer' device property is not really a device property,
>> it is an indirect parameter to the 'migrate' command.
>>
>> Ergo, if we need the ability to selectively migrate the backend state
>> of individal devices, then instead of a property on the device, we
>> should pass a list of device IDs as a parameter to the migrate
>> command in QMP.
> 
> Understand.
> 
> So, it will look like
> 
> # @backend-transfer: List of devices IDs or QOM paths, to enable
> #     backend-transfer for. In general that means that backend
> #     states and their file descriptors are passed to the destination
> #     in the migration channel (which must be a UNIX socket), and
> #     management tool doesn't have to configure new backends for
> #     target QEMU (like vhost-user server, or TAP device in the kernel).
> #     Default is no backend-transfer migration (Since 10.2)
> 


RFC diff to these series, to switch the API to list of IDs:


diff --git a/hw/core/machine.c b/hw/core/machine.c
index a3d77f5604..681adbb7ac 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -40,7 +40,6 @@
  
  GlobalProperty hw_compat_10_1[] = {
      { TYPE_ACPI_GED, "x-has-hest-addr", "false" },
-    { TYPE_VIRTIO_NET, "backend-transfer", "false" },
  };
  const size_t hw_compat_10_1_len = G_N_ELEMENTS(hw_compat_10_1);
  
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 5f9711dee7..a895b26e5d 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3638,7 +3638,7 @@ static bool virtio_net_is_tap_mig(void *opaque, int version_id)
  
      nc = qemu_get_queue(n->nic);
  
-    return migrate_backend_transfer() && n->backend_transfer && nc->peer &&
+    return migrate_backend_transfer(DEVICE(n)) && nc->peer &&
          nc->peer->info->type == NET_CLIENT_DRIVER_TAP;
  }
  
@@ -4461,7 +4461,6 @@ static const Property virtio_net_properties[] = {
                                 host_features_ex,
                                 VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM,
                                 false),
-    DEFINE_PROP_BOOL("backend-transfer", VirtIONet, backend_transfer, true),
  };
  
  static void virtio_net_class_init(ObjectClass *klass, const void *data)
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index a7bfb10dc7..0f3b7aa55e 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -1160,4 +1160,7 @@ typedef enum MachineInitPhase {
  bool phase_check(MachineInitPhase phase);
  void phase_advance(MachineInitPhase phase);
  
+bool migrate_backend_transfer(DeviceState *dev);
+bool migrate_backend_transfer_check_list(const strList *list, Error **errp);
+
  #endif
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index bf07f8a4cb..5b8ab7bda7 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -231,7 +231,6 @@ struct VirtIONet {
      struct EBPFRSSContext ebpf_rss;
      uint32_t nr_ebpf_rss_fds;
      char **ebpf_rss_fds;
-    bool backend_transfer;
  };
  
  size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,
diff --git a/include/migration/misc.h b/include/migration/misc.h
index 592b93021e..7f931bed17 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -152,4 +152,6 @@ bool multifd_device_state_save_thread_should_exit(void);
  void multifd_abort_device_state_save_threads(void);
  bool multifd_join_device_state_save_threads(void);
  
+const strList *migrate_backend_transfer_list(void);
+
  #endif
diff --git a/migration/options.c b/migration/options.c
index a461b07b54..1644728ed7 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -13,6 +13,7 @@
  
  #include "qemu/osdep.h"
  #include "qemu/error-report.h"
+#include "qapi/util.h"
  #include "exec/target_page.h"
  #include "qapi/clone-visitor.h"
  #include "qapi/error.h"
@@ -24,6 +25,7 @@
  #include "migration/colo.h"
  #include "migration/cpr.h"
  #include "migration/misc.h"
+#include "migration/options.h"
  #include "migration.h"
  #include "migration-stats.h"
  #include "qemu-file.h"
@@ -262,7 +264,7 @@ bool migrate_mapped_ram(void)
      return s->capabilities[MIGRATION_CAPABILITY_MAPPED_RAM];
  }
  
-bool migrate_backend_transfer(void)
+const strList *migrate_backend_transfer_list(void)
  {
      MigrationState *s = migrate_get_current();
      return s->parameters.backend_transfer;
@@ -969,8 +971,11 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
      params->cpr_exec_command = QAPI_CLONE(strList,
                                            s->parameters.cpr_exec_command);
  
-    params->has_backend_transfer = true;
-    params->backend_transfer = s->parameters.backend_transfer;
+    if (s->parameters.backend_transfer) {
+        params->has_backend_transfer = true;
+        params->backend_transfer = QAPI_CLONE(strList,
+                                              s->parameters.backend_transfer);
+    }
  
      return params;
  }
@@ -1193,6 +1198,11 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
          return false;
      }
  
+    if (params->has_backend_transfer &&
+        !migrate_backend_transfer_check_list(params->backend_transfer, errp)) {
+        return false;
+    }
+
      return true;
  }
  
@@ -1459,7 +1469,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
      }
  
      if (params->has_backend_transfer) {
-        s->parameters.backend_transfer = params->backend_transfer;
+        qapi_free_strList(s->parameters.backend_transfer);
+
+        s->parameters.backend_transfer = QAPI_CLONE(strList,
+                                                    params->backend_transfer);
      }
  }
  
diff --git a/migration/options.h b/migration/options.h
index 755ba1c024..82d839709e 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -87,8 +87,6 @@ const char *migrate_tls_hostname(void);
  uint64_t migrate_xbzrle_cache_size(void);
  ZeroPageDetection migrate_zero_page_detection(void);
  
-bool migrate_backend_transfer(void);
-
  /* parameters helpers */
  
  bool migrate_params_check(MigrationParameters *params, Error **errp);
diff --git a/qapi/migration.json b/qapi/migration.json
index 35601a1f87..9478c4ddab 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -951,12 +951,11 @@
  #     is @cpr-exec.  The first list element is the program's filename,
  #     the remainder its arguments.  (Since 10.2)
  #
-# @backend-transfer: Enable backend-transfer feature for devices that
-#     supports it. In general that means that backend state and its
-#     file descriptors are passed to the destination in the migraton
-#     channel (which must be a UNIX socket). Individual devices
-#     declare the support for backend-transfer by per-device
-#     backend-transfer option. (Since 10.2)
+# @backend-transfer: List of devices (IDs or QOM paths) for
+#     backend-transfer migration.  When enabled, device backends
+#     including opened fds will be passed to the destination in the
+#     migration channel (which must be a UNIX domain socket).  Default
+#     is no backend-transfer migration. (Since 10.2)
  #
  # Features:
  #
@@ -1145,12 +1144,11 @@
  #     is @cpr-exec.  The first list element is the program's filename,
  #     the remainder its arguments.  (Since 10.2)
  #
-# @backend-transfer: Enable backend-transfer feature for devices that
-#     supports it. In general that means that backend state and its
-#     file descriptors are passed to the destination in the migraton
-#     channel (which must be a UNIX socket). Individual devices
-#     declare the support for backend-transfer by per-device
-#     backend-transfer option. (Since 10.2)
+# @backend-transfer: List of devices (IDs or QOM paths) for
+#     backend-transfer migration.  When enabled, device backends
+#     including opened fds will be passed to the destination in the
+#     migration channel (which must be a UNIX domain socket).  Default
+#     is no backend-transfer migration. (Since 10.2)
  #
  # Features:
  #
@@ -1195,7 +1193,7 @@
              '*zero-page-detection': 'ZeroPageDetection',
              '*direct-io': 'bool',
              '*cpr-exec-command': [ 'str' ],
-            '*backend-transfer': { 'type': 'bool',
+            '*backend-transfer': { 'type': [ 'str' ],
                                     'features': [ 'unstable' ] } } }
  
  ##
@@ -1369,12 +1367,11 @@
  #     is @cpr-exec.  The first list element is the program's filename,
  #     the remainder its arguments.  (Since 10.2)
  #
-# @backend-transfer: Enable backend-transfer feature for devices that
-#     supports it. In general that means that backend state and its
-#     file descriptors are passed to the destination in the migraton
-#     channel (which must be a UNIX socket). Individual devices
-#     declare the support for backend-transfer by per-device
-#     backend-transfer option. (Since 10.2)
+# @backend-transfer: List of devices (IDs or QOM paths) for
+#     backend-transfer migration.  When enabled, device backends
+#     including opened fds will be passed to the destination in the
+#     migration channel (which must be a UNIX domain socket).  Default
+#     is no backend-transfer migration. (Since 10.2)
  #
  # Features:
  #
@@ -1416,7 +1413,7 @@
              '*zero-page-detection': 'ZeroPageDetection',
              '*direct-io': 'bool',
              '*cpr-exec-command': [ 'str' ],
-            '*backend-transfer': { 'type': 'bool',
+            '*backend-transfer': { 'type': [ 'str' ],
                                     'features': [ 'unstable' ] } } }
  
  ##
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 2ac92d0a07..b4a1a88992 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -939,6 +939,32 @@ void qmp_device_del(const char *id, Error **errp)
      }
  }
  
+bool migrate_backend_transfer(DeviceState *dev)
+{
+    const strList *el = migrate_backend_transfer_list();
+
+    for ( ; el; el = el->next) {
+        if (find_device_state(el->value, false, NULL) == dev) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
+bool migrate_backend_transfer_check_list(const strList *list, Error **errp)
+{
+    const strList *el = list;
+
+    for ( ; el; el = el->next) {
+        if (!find_device_state(el->value, false, errp)) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
  int qdev_sync_config(DeviceState *dev, Error **errp)
  {
      DeviceClass *dc = DEVICE_GET_CLASS(dev);
diff --git a/tests/functional/test_x86_64_tap_migration.py b/tests/functional/test_x86_64_tap_migration.py
index 1f88ff174c..a324b0f374 100644
--- a/tests/functional/test_x86_64_tap_migration.py
+++ b/tests/functional/test_x86_64_tap_migration.py
@@ -254,17 +254,16 @@ def prepare_and_launch_vm(
          self.log.info(f"Launching {vm_s} VM")
          vm.launch()
  
-        self.set_migration_capabilities(vm, backend_transfer)
-
          if not backend_transfer:
              tap_name = TAP_ID2 if incoming else TAP_ID
          else:
              tap_name = TAP_ID
  
-        self.add_virtio_net(vm, vhost, tap_name, backend_transfer)
+        self.add_virtio_net(vm, vhost, tap_name)
+
+        self.set_migration_capabilities(vm, backend_transfer)
  
-    def add_virtio_net(self, vm, vhost: bool, tap_name: str,
-                       backend_transfer: bool):
+    def add_virtio_net(self, vm, vhost: bool, tap_name: str = "tap0"):
          netdev_params = {
              "id": "netdev.1",
              "vhost": vhost,
@@ -289,17 +288,19 @@ def add_virtio_net(self, vm, vhost: bool, tap_name: str,
              bus="pci.1",
              mac=GUEST_MAC,
              disable_legacy="off",
-            backend_transfer=backend_transfer,
          )
  
      def set_migration_capabilities(self, vm, backend_transfer=True):
-        vm.cmd("migrate-set-capabilities", { "capabilities": [
+        capabilities = [
              {"capability": "events", "state": True},
              {"capability": "x-ignore-shared", "state": True},
-        ]})
-        vm.cmd("migrate-set-parameters", {
-            "backend-transfer": backend_transfer
-        })
+        ]
+        vm.cmd("migrate-set-capabilities", {"capabilities": capabilities})
+        if backend_transfer:
+            vm.cmd(
+                "migrate-set-parameters",
+                {"backend-transfer": ["/machine/peripheral/vnet.1/virtio-backend"]},
+            )
  
      def setup_guest_network(self) -> None:
          exec_command_and_wait_for_pattern(self, "ip addr", "# ")



-- 
Best regards,
Vladimir

