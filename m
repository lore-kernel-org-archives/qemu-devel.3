Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3A0CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 01:11:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3lH0-00064v-Fw; Tue, 30 Sep 2025 21:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lGP-0005iX-Ik
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:04:15 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lFO-0008ED-DI
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:04:13 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46b303f755aso58090205e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 18:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1759280583; x=1759885383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YvbFfcp7wnei5ZfqWSO2jElDFuBlDIo3JfgLZwsSQVw=;
 b=dOxxtRihKw/NLqS/obje+pwTWj2iqhA0d7YZ/kEjLal2m+O7CWzKv82VANuDwtUNfF
 tqnrBREsCpQBw8K8ZGPpyrwGWy/dfrTlITQCwnukooQVSOB1ViX6vbBly3paqG9OtZmD
 YSSmTlqH5duPgPSPcylfBJOjBMoqMZu20bIJfP4JxdUVGhViu+dfovgSq6YNbT3GW2w4
 d6XI/pGojEgC0WfW6XWQHPDzpw94bUw8cg/ukYOf3F7uAwKCVD5M2ZQf77zzSK0h9Jcy
 GFN8hCsl9/9ka1/VXPp958yPS+COU1CEqg/mae+q5KKruwpmmyiLE4L9nwddtvAqqrpK
 rz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759280583; x=1759885383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YvbFfcp7wnei5ZfqWSO2jElDFuBlDIo3JfgLZwsSQVw=;
 b=O6vevJwL4Q7dvReEiwgw/aSwbWuMzJ/py3a2QiXOl8nhhtxKg5Zf1qUg+MINoJrfep
 qmqsMLTLkWrh+4dpmfT4VhlHhxRisg1k2RhRLrTRcjPgSfiRBocRiQsqjylpU18rKpko
 xFfBajpWz8r0cQWKRft8UQ9S4l/QBS8eKE8JiaNkl1tO+N1KbUgW4ztmBw5+oi9f3hWt
 4P/LUxr093Kvix1JGkXwv65gLutpwU8moikzTmRboKJFiQQmosLXhPzQmG1c7jrJy/2G
 qiVCPfid0E/G9gb35U3+c3FFq+eR9JMytYc9go/vAwJE86BosZDVgjFOj4GzA0A9p2sQ
 v+8A==
X-Gm-Message-State: AOJu0Yxzhj9aGou37v4/fKH141wMA/85ZPg3Fj9cj71Cbjy1FYn56j57
 XpZ7PPW/Jb6H4L0JW+NIKiK9xyIpgJ+8y8qiHXluSdQoCXfKT/dbQQ3saEqydIZycul+O9aqHfh
 ho3mTAitLqA==
X-Gm-Gg: ASbGncv8vb33kKMUj4VWFM9IZSayrQ0LHfaLUL29nV4JvR4gwbAz709LumblVDi8QfK
 Gi8fIZZFr16ad6ffU9SBLegZMUCliTT8R6RN4PfNoXv3T2NieHxx03SkT8izp5EwOGqScjRKw6H
 lYAKEaxRvoOQssX2/b3QMCJyGwSU3XdrtY4rO0aSUxtNwNBCmxwvHQ5gvWaFk7i1xw3GPNHuHTJ
 RP/Od5ad//bPIPSfFFM2bvzK8J+D5esy3o5nIsDPiejQt1mHtcJMW0l3QXnR7RTXNlf2mTdCtmh
 w1O9dnvvkZZDiM4q0mnPNQgryKebCjabLG+zKSIMU35aqqP2QO/Mcp5j2UXpG3VU5qZxvlcHS2t
 LtP12U2/OKH0TdxUNzeF8bSStf23KvCeU6ZxRX4ZN4aCB0TvMSyJZAOTZ7hdpI05EoBVTXkn7nS
 buBpQPs44q+hAqkqT1m/9BlATnuWV8PHC9s0uIbqHuT18=
X-Google-Smtp-Source: AGHT+IHz5zJvRAfTPBo9M5sp5y9ZSQpGXLUE6GRT5+Sd8Ti2k3C3x23ab/qaxyHFH3BNL5MCzuLhNQ==
X-Received: by 2002:a05:600c:c4aa:b0:45f:2cb5:ecff with SMTP id
 5b1f17b1804b1-46e612cb719mr15530685e9.31.1759280582488; 
 Tue, 30 Sep 2025 18:03:02 -0700 (PDT)
Received: from localhost.localdomain ([90.209.204.182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb985e080sm24587426f8f.24.2025.09.30.18.03.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 18:03:02 -0700 (PDT)
From: salil.mehta@opnsrc.net
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	mst@redhat.com
Cc: salil.mehta@huawei.com, maz@kernel.org, jean-philippe@linaro.org,
 jonathan.cameron@huawei.com, lpieralisi@kernel.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 imammedo@redhat.com, armbru@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com,
 will@kernel.org, ardb@kernel.org, oliver.upton@linux.dev,
 pbonzini@redhat.com, gshan@redhat.com, rafael@kernel.org,
 borntraeger@linux.ibm.com, alex.bennee@linaro.org,
 gustavo.romero@linaro.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 gankulkarni@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, wangzhou1@hisilicon.com,
 linuxarm@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn,
 lixianglai@loongson.cn, shahuang@redhat.com, zhao1.liu@intel.com
Subject: [PATCH RFC V6 22/24] monitor,
 qdev: Introduce 'device_set' to change admin state of existing devices
Date: Wed,  1 Oct 2025 01:01:25 +0000
Message-Id: <20251001010127.3092631-23-salil.mehta@opnsrc.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Salil Mehta <salil.mehta@huawei.com>

This patch adds a "device_set" interface for modifying properties of devices
that already exist in the guest topology. Unlike 'device_add'/'device_del'
(hot-plug), 'device_set' does not create or destroy devices. It is intended
for guest-visible hot-add semantics where hardware is provisioned at boot but
logically enabled/disabled later via administrative policy.

Compared to the existing 'qom-set' command, which is less intuitive and works
only with object IDs, device_set provides a more device-oriented interface.
It can be invoked at the QEMU prompt using natural device arguments, and the
new '-deviceset' CLI option allows properties to be set at boot time, similar
to how '-device' specifies device creation.

While the initial implementation focuses on "admin-state" changes (e.g.,
enable/disable a CPU already described by ACPI/DT), the interface is designed
to be generic. In future, it could be used for other per-device set/unset
style controls — beyond administrative power-states — provided the target
device explicitly allows such changes. This enables fine-grained runtime
control of device properties.

Key pieces:
  * QMP: qmp_device_set() to update an existing device. The device can be
    located by "id" or via driver+property match using a DeviceListener
    callback (qdev_find_device()).
  * HMP: "device_set" command with tab-completion. Errors are surfaced via
    hmp_handle_error().
  * CLI: "-deviceset" option for setting startup/admin properties at boot,
    including a JSON form. Options are parsed into qemu_deviceset_opts and
    applied after device creation.
  * Docs/help: HMP help text and qemu-options.hx additions explain usage and
    explicitly note that no hot-plug occurs.
  * Safety: disallowed during live migration (migration_is_idle() check).

Semantics:
  * Operates on an existing DeviceState; no enumeration/new device appears.
  * Complements device_add/device_del by providing state mutation only.
  * Backward compatible: no behavior change unless "device_set"/"-deviceset"
    is used.

Examples:
  HMP:
    (qemu) device_set host-arm-cpu,core-id=3,admin-state=enable

  CLI (at boot):
    -smp cpus=4,maxcpus=4 \
    -deviceset host-arm-cpu,core-id=2,admin-state=disable

  QMP (JSON form):
    { "execute": "device_set",
      "arguments": {
        "driver": "host-arm-cpu",
        "core-id": 1,
        "admin-state": "disable"
      }
    }

NOTE: The qdev_enable()/qdev_disable() hooks for acting on admin-state will be
added in subsequent patches. Device classes must explicitly support any
property they want to expose through device_set.

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hmp-commands.hx         |  30 +++++++++
 hw/arm/virt.c           |  86 +++++++++++++++++++++++++
 hw/core/cpu-common.c    |  12 ++++
 hw/core/qdev.c          |  21 ++++++
 include/hw/arm/virt.h   |   1 +
 include/hw/core/cpu.h   |  11 ++++
 include/hw/qdev-core.h  |  22 +++++++
 include/monitor/hmp.h   |   2 +
 include/monitor/qdev.h  |  30 +++++++++
 include/system/system.h |   1 +
 qemu-options.hx         |  51 +++++++++++++--
 system/qdev-monitor.c   | 139 +++++++++++++++++++++++++++++++++++++++-
 system/vl.c             |  39 +++++++++++
 13 files changed, 440 insertions(+), 5 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index d0e4f35a30..18056cf21d 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -707,6 +707,36 @@ SRST
   or a QOM object path.
 ERST
 
+{
+    .name       = "device_set",
+    .args_type  = "device:O",
+    .params     = "driver[,prop=value][,...]",
+    .help       = "set/unset existing device property",
+    .cmd        = hmp_device_set,
+    .command_completion = device_set_completion,
+},
+
+SRST
+``device_set`` *driver[,prop=value][,...]*
+  Change the administrative power state of an existing device.
+
+  This command enables or disables a known device (e.g., CPU) using the
+  "device_set" interface. It does not hotplug or add a new device.
+
+  Depending on platform support (e.g., PSCI or ACPI), this may trigger
+  corresponding operational changes — such as powering down a CPU or
+  transitioning it to active use.
+
+  Administrative state:
+    * *enabled*  — Allows the guest to use the device (e.g., CPU_ON)
+    * *disabled* — Prevents guest use; device is powered off (e.g., CPU_OFF)
+
+  Note: The device must already exist (be declared during machine creation).
+
+  Example:
+      (qemu) device_set host-arm-cpu,core-id=3,admin-state=disabled
+ERST
+
     {
         .name       = "cpu",
         .args_type  = "index:i",
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9a41a0682b..7bd37ffb75 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -74,6 +74,7 @@
 #include "qapi/visitor.h"
 #include "qapi/qapi-visit-common.h"
 #include "qobject/qlist.h"
+#include "qobject/qdict.h"
 #include "standard-headers/linux/input.h"
 #include "hw/arm/smmuv3.h"
 #include "hw/acpi/acpi.h"
@@ -1824,6 +1825,88 @@ void virt_machine_done(Notifier *notifier, void *data)
     virt_build_smbios(vms);
 }
 
+static DeviceState *virt_find_cpu(const QDict *opts, Error **errp)
+{
+    int64_t socket_id, cluster_id, core_id, thread_id;
+    MachineState *ms = MACHINE(qdev_get_machine());
+    int64_t T, C, K, cpu_id;
+    CPUState *cpu;
+    const char *s;
+
+    /* parse topology */
+    socket_id  = (s = qdict_get_try_str(opts, "socket-id")) ?
+                  strtoll(s, NULL, 10) : 0;
+    cluster_id = (s = qdict_get_try_str(opts, "cluster-id")) ?
+                 strtoll(s, NULL, 10) : 0;
+    core_id    = (s = qdict_get_try_str(opts, "core-id")) ?
+                 strtoll(s, NULL, 10) : 0;
+    thread_id  = (s = qdict_get_try_str(opts, "thread-id")) ?
+                 strtoll(s, NULL, 10) : 0;
+
+    /* Range checks */
+    if (thread_id < 0 || thread_id >= ms->smp.threads) {
+        error_setg(errp,
+                   "Couldn't find cpu(%ld:%ld:%ld:%ld), Invalid thread-id %ld",
+                   socket_id, cluster_id, core_id, thread_id, thread_id);
+        return NULL;
+    }
+    if (core_id < 0 || core_id >= ms->smp.cores) {
+        error_setg(errp,
+                   "Couldn't find cpu(%ld:%ld:%ld:%ld), Invalid core-id %ld",
+                   socket_id, cluster_id, core_id, thread_id, core_id);
+        return NULL;
+    }
+    if (cluster_id < 0 || cluster_id >= ms->smp.clusters) {
+        error_setg(errp,
+                   "Couldn't find cpu(%ld:%ld:%ld:%ld), Invalid cluster-id %ld",
+                   socket_id, cluster_id, core_id, thread_id, cluster_id);
+        return NULL;
+    }
+    if (socket_id < 0 || socket_id >= ms->smp.sockets) {
+        error_setg(errp,
+                   "Couldn't find cpu(%ld:%ld:%ld:%ld), Invalid socket-id %ld",
+                   socket_id, cluster_id, core_id, thread_id, socket_id);
+        return NULL;
+    }
+
+    /* Compute logical CPU index: t + T*(c + C*(k + K*s)). */
+    T = ms->smp.threads;
+    C = ms->smp.cores;
+    K = ms->smp.clusters;
+    cpu_id = thread_id + T * (core_id + C * (cluster_id + K * socket_id));
+
+    cpu = machine_get_possible_cpu((int)cpu_id);
+    if (!cpu) {
+        error_setg(errp,
+                   "Couldn't find cpu(%ld:%ld:%ld:%ld), Invalid cpu-index %ld",
+                   socket_id, cluster_id, core_id, thread_id, cpu_id);
+        return NULL;
+    }
+
+    return DEVICE(cpu);
+}
+
+static DeviceState *
+virt_find_device(DeviceListener *listener, const QDict *opts, Error **errp)
+{
+    const char *typename;
+
+    g_assert(opts);
+
+    typename = qdict_get_try_str(opts, "driver");
+    if (!typename)
+    {
+        error_setg(errp, "no driver specified");
+        return NULL;
+    }
+
+    if (cpu_typename_is_a(typename, TYPE_ARM_CPU)) {
+        return virt_find_cpu(opts, errp);
+    }
+
+    return NULL;
+}
+
 static void virt_park_cpu_in_userspace(CPUState *cs)
 {
     /* we don't want to migrate 'disabled' vCPU state(even if realized) */
@@ -2545,6 +2628,9 @@ static void machvirt_init(MachineState *machine)
 
     create_fdt(vms);
 
+    vms->device_listener.find_device = virt_find_device;
+    device_listener_register(&vms->device_listener);
+
     assert(possible_cpus->len == max_cpus);
     for (n = 0; n < possible_cpus->len; n++) {
         Object *cpuobj;
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 39e674aca2..6883dba75e 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -170,6 +170,18 @@ char *cpu_model_from_type(const char *typename)
     return g_strdup(typename);
 }
 
+bool cpu_typename_is_a(const char *typename, const char *base_typename)
+{
+    ObjectClass *oc;
+
+    if (!typename || !base_typename) {
+        return false;
+    }
+
+    oc = object_class_by_name(typename);
+    return oc && object_class_dynamic_cast(oc, base_typename);
+}
+
 static void cpu_common_parse_features(const char *typename, char *features,
                                       Error **errp)
 {
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 3aba99b912..4fa2988ca0 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -226,6 +226,27 @@ bool qdev_should_hide_device(const QDict *opts, bool from_json, Error **errp)
     return false;
 }
 
+DeviceState *
+qdev_find_device(const QDict *opts, Error **errp)
+{
+    ERRP_GUARD();
+    DeviceListener *listener;
+    DeviceState *dev;
+
+    QTAILQ_FOREACH(listener, &device_listeners, link) {
+        if (listener->find_device) {
+            dev = listener->find_device(listener, opts, errp);
+            if (*errp) {
+                return NULL;
+            } else if (dev) {
+                return dev;
+            }
+        }
+    }
+
+    return NULL;
+}
+
 void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
                                  int required_for_version)
 {
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 0898e8eed3..de4a08175e 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -182,6 +182,7 @@ struct VirtMachineState {
     char *oem_table_id;
     bool ns_el2_virt_timer_irq;
     CXLState cxl_devices_state;
+    DeviceListener device_listener;
 };
 
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index ccf5588011..c9ce9bbdaf 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -853,6 +853,17 @@ ObjectClass *cpu_class_by_name(const char *typename, const char *cpu_model);
  */
 char *cpu_model_from_type(const char *typename);
 
+/**
+ * cpu_typename_is_a:
+ * @typename: QOM type name to check (e.g. "host-arm-cpu").
+ * @base_typename: Base QOM typename to test against (e.g. TYPE_ARM_CPU).
+ *
+ * Return: true if @typename names a class that is-a @base_typename, else false.
+ *
+ * Notes: Safe for common code; depends only on QOM (no target headers).
+ */
+bool cpu_typename_is_a(const char *typename, const char *base_typename);
+
 /**
  * cpu_create:
  * @typename: The CPU type.
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 3e08cfb59f..19d1d1a144 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -371,6 +371,15 @@ struct DeviceListener {
      */
     bool (*hide_device)(DeviceListener *listener, const QDict *device_opts,
                         bool from_json, Error **errp);
+    /*
+     * Used by qdev to find any device corresponding to the device opts
+     *
+     * Returns the `DeviceState` on sucess and NULL if device was not found.
+     * On errors, it returns NULL and errp is set
+     */
+    DeviceState * (*find_device)(DeviceListener *listener,
+                                 const QDict *device_opts,
+                                 Error **errp);
     QTAILQ_ENTRY(DeviceListener) link;
 };
 
@@ -1252,6 +1261,19 @@ void device_listener_unregister(DeviceListener *listener);
  */
 bool qdev_should_hide_device(const QDict *opts, bool from_json, Error **errp);
 
+/**
+ * qdev_find_device() - find the device
+ *
+ * @opts: options QDict
+ * @errp: pointer to error object
+ *
+ * Called when device state is toggled via qdev_device_state()
+ *
+ * Return: a DeviceState on success and NULL on failure
+ */
+DeviceState *
+qdev_find_device(const QDict *opts, Error **errp);
+
 typedef enum MachineInitPhase {
     /* current_machine is NULL.  */
     PHASE_NO_MACHINE,
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index ae116d9804..3e8c492c28 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -84,6 +84,7 @@ void hmp_change_medium(Monitor *mon, const char *device, const char *target,
 void hmp_migrate(Monitor *mon, const QDict *qdict);
 void hmp_device_add(Monitor *mon, const QDict *qdict);
 void hmp_device_del(Monitor *mon, const QDict *qdict);
+void hmp_device_set(Monitor *mon, const QDict *qdict);
 void hmp_dump_guest_memory(Monitor *mon, const QDict *qdict);
 void hmp_netdev_add(Monitor *mon, const QDict *qdict);
 void hmp_netdev_del(Monitor *mon, const QDict *qdict);
@@ -117,6 +118,7 @@ void object_add_completion(ReadLineState *rs, int nb_args, const char *str);
 void object_del_completion(ReadLineState *rs, int nb_args, const char *str);
 void device_add_completion(ReadLineState *rs, int nb_args, const char *str);
 void device_del_completion(ReadLineState *rs, int nb_args, const char *str);
+void device_set_completion(ReadLineState *rs, int nb_args, const char *str);
 void sendkey_completion(ReadLineState *rs, int nb_args, const char *str);
 void chardev_remove_completion(ReadLineState *rs, int nb_args, const char *str);
 void chardev_add_completion(ReadLineState *rs, int nb_args, const char *str);
diff --git a/include/monitor/qdev.h b/include/monitor/qdev.h
index 1d57bf6577..b10040e27f 100644
--- a/include/monitor/qdev.h
+++ b/include/monitor/qdev.h
@@ -6,6 +6,36 @@
 void hmp_info_qtree(Monitor *mon, const QDict *qdict);
 void hmp_info_qdm(Monitor *mon, const QDict *qdict);
 void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp);
+/**
+ * qmp_device_set:
+ * @qdict: Boxed arguments identifying the target device and property changes.
+ *
+ *         The device can be identified in one of two ways:
+ *           1. By "id":      Device instance ID (string), or
+ *           2. By "driver":  Device type (string) plus one or more
+ *                            property=value pairs to match.
+ *
+ *         Must also include at least one property assignment to change.
+ *         Currently used for:
+ *           - "admin-state": "enable" | "disable"
+ *
+ *         Additional properties may be supported by specific devices
+ *         in future.
+ *
+ * @errp:  Pointer to error object (set on failure).
+ *
+ * Change one or more mutable properties of an existing device at runtime.
+ * Initially intended for administrative CPU power-state control via
+ * "admin-state" on CPU devices, but may be extended to support other
+ * per-device set/unset controls when allowed by the target device class.
+ *
+ * Returns: Nothing. On success, replies with `{ "return": true }` via QMP.
+ *
+ * Errors:
+ *  - DeviceNotFound:  No matching device found
+ *  - GenericError:    Parameter validation failed or operation unsupported
+ */
+void qmp_device_set(const QDict *qdict, Error **errp);
 
 int qdev_device_help(QemuOpts *opts);
 DeviceState *qdev_device_add(QemuOpts *opts, Error **errp);
diff --git a/include/system/system.h b/include/system/system.h
index a7effe7dfd..3702325cfb 100644
--- a/include/system/system.h
+++ b/include/system/system.h
@@ -116,6 +116,7 @@ extern QemuOptsList qemu_drive_opts;
 extern QemuOptsList bdrv_runtime_opts;
 extern QemuOptsList qemu_chardev_opts;
 extern QemuOptsList qemu_device_opts;
+extern QemuOptsList qemu_deviceset_opts;
 extern QemuOptsList qemu_netdev_opts;
 extern QemuOptsList qemu_nic_opts;
 extern QemuOptsList qemu_net_opts;
diff --git a/qemu-options.hx b/qemu-options.hx
index 83ccde341b..f517b91042 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -375,7 +375,10 @@ SRST
     This is different from CPU hotplug where additional CPUs are not even
     present in the system description. Administratively disabled CPUs appear in
     ACPI tables i.e. are provisioned, but cannot be used until explicitly
-    enabled via QMP/HMP or the deviceset API.
+    enabled via QMP/HMP or the deviceset API. On ACPI guests, each vCPU counted
+    by 'disabledcpus=' is provisioned with '\ ``_STA``\ ' reporting Present=1
+    and Enabled=0 (present-offline) at boot; it becomes Enabled=1 when brought
+    online via 'device_set ... admin-state=enable'.
 
     On boards supporting CPU hotplug, the optional '\ ``maxcpus``\ ' parameter
     can be set to enable further CPUs to be added at runtime. When both
@@ -455,6 +458,15 @@ SRST
 
         -smp 2
 
+    Note: The cluster topology will only be generated in ACPI and exposed
+    to guest if it's explicitly specified in -smp.
+
+    Note: Administratively disabled CPUs (specified via 'disabledcpus=' and
+    '-deviceset' at CLI during boot) are especially useful for platforms like
+    ARM that lack native CPU hotplug support. These CPUs will appear to the
+    guest as unavailable, and any attempt to bring them online must go through
+    QMP/HMP commands like 'device_set'.
+
     Examples using 'disabledcpus':
 
     For a board without CPU hotplug, enable 4 CPUs at boot and provision
@@ -472,9 +484,6 @@ SRST
     ::
 
         -smp cpus=4,disabledcpus=2,maxcpus=8
-
-    Note: The cluster topology will only be generated in ACPI and exposed
-    to guest if it's explicitly specified in -smp.
 ERST
 
 DEF("numa", HAS_ARG, QEMU_OPTION_numa,
@@ -1281,6 +1290,40 @@ SRST
 
 ERST
 
+DEF("deviceset", HAS_ARG, QEMU_OPTION_deviceset,
+    "-deviceset driver[,prop[=value]][,...]\n"
+    "                Set administrative power state of an existing device.\n"
+    "                Does not hotplug a new device. Can disable or enable\n"
+    "                devices (such as CPUs) at boot based on policy.\n"
+    "                Example:\n"
+    "                    -deviceset host-arm-cpu,core-id=2,admin-state=disabled\n"
+    "                Use '-deviceset help' for supported drivers\n"
+    "                Use '-deviceset driver,help' for driver-specific properties\n",
+    QEMU_ARCH_ALL)
+SRST
+``-deviceset driver[,prop[=value]][,...]``
+    Configure an existing device's administrative power state or properties.
+
+    Unlike ``-device``, this option does not create a new device. Instead,
+    it sets startup properties (such as administrative power state) for
+    a device already declared via -smp or other machine configuration.
+
+    Example:
+        -smp cpus=4
+        -deviceset host-arm-cpu,core-id=2,admin-state=disabled
+
+    The above disables CPU core 2 at boot using administrative offlining.
+    The guest may later re-enable the core (if permitted by platform policy).
+
+    ``state=enabled|disabled``
+        Sets the administrative state of the device:
+        - ``enabled``: device is made available at boot
+        - ``disabled``: device is administratively disabled and powered off
+
+    Use ``-deviceset help`` to view all supported drivers.
+    Use ``-deviceset driver,help`` for property-specific help.
+ERST
+
 DEF("name", HAS_ARG, QEMU_OPTION_name,
     "-name string1[,process=string2][,debug-threads=on|off]\n"
     "                set the name of the guest\n"
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 2ac92d0a07..1099b1237d 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -263,12 +263,20 @@ static DeviceClass *qdev_get_device_class(const char **driver, Error **errp)
     }
 
     dc = DEVICE_CLASS(oc);
-    if (!dc->user_creatable) {
+    if (!dc->user_creatable && !dc->admin_power_state_supported) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "driver",
                    "a pluggable device type");
         return NULL;
     }
 
+    if (phase_check(PHASE_MACHINE_READY) &&
+        (!dc->hotpluggable || !dc->admin_power_state_supported)) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "driver",
+                   "a pluggable device type or which supports changing power-"
+                   "state administratively");
+        return NULL;
+    }
+
     if (object_class_dynamic_cast(oc, TYPE_SYS_BUS_DEVICE)) {
         /* sysbus devices need to be allowed by the machine */
         MachineClass *mc = MACHINE_CLASS(object_get_class(qdev_get_machine()));
@@ -939,6 +947,76 @@ void qmp_device_del(const char *id, Error **errp)
     }
 }
 
+void qmp_device_set(const QDict *qdict, Error **errp)
+{
+    const char *state;
+    const char *driver;
+    DeviceState *dev;
+    DeviceClass *dc;
+    const char *id;
+
+    driver = qdict_get_try_str(qdict, "driver");
+    if (!driver) {
+        error_setg(errp, "Parameter 'driver' is missing");
+        return;
+    }
+
+    /* check driver exists and we are at the right phase of machine init */
+    dc = qdev_get_device_class(&driver, errp);
+    if (!dc) {
+        error_setg(errp, "driver '%s' not supported", driver);
+        return;
+    }
+
+    if (migration_is_running()) {
+        error_setg(errp, "device_set not allowed while migrating");
+        return;
+    }
+
+    id = qdict_get_try_str(qdict, "id");
+
+    if (id) {
+        /* Lookup by ID */
+        dev = find_device_state(id, false, errp);
+        if (errp && *errp) {
+            error_prepend(errp, "Device lookup failed for ID '%s': ", id);
+            return;
+        }
+    } else {
+        /* Lookup using driver and properties */
+        dev = qdev_find_device(qdict, errp);
+        if (errp && *errp) {
+            error_prepend(errp, "Device lookup for %s failed: ", driver);
+            return;
+        }
+    }
+    if (!dev) {
+        error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
+                  "No device found for driver '%s'", driver);
+        return;
+    }
+
+    state = qdict_get_try_str(qdict, "admin-state");
+    if (!state) {
+        error_setg(errp, "no device state change specified for device %s ",
+                   dev->id);
+        return;
+    } else if (!strcmp(state, "enable")) {
+
+        if (!qdev_enable(dev, qdev_get_parent_bus(DEVICE(dev)), errp)) {
+            return;
+        }
+    } else if (!strcmp(state, "disable")) {
+        if (!qdev_disable(dev, qdev_get_parent_bus(DEVICE(dev)), errp)) {
+            return;
+        }
+    } else {
+        error_setg(errp, "unrecognized specified state *%s* for device %s",
+                   state, dev->id);
+        return;
+    }
+}
+
 int qdev_sync_config(DeviceState *dev, Error **errp)
 {
     DeviceClass *dc = DEVICE_GET_CLASS(dev);
@@ -1019,6 +1097,14 @@ void hmp_device_del(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, err);
 }
 
+void hmp_device_set(Monitor *mon, const QDict *qdict)
+{
+    Error *err = NULL;
+
+    qmp_device_set(qdict, &err);
+    hmp_handle_error(mon, err);
+}
+
 void device_add_completion(ReadLineState *rs, int nb_args, const char *str)
 {
     GSList *list, *elt;
@@ -1101,6 +1187,41 @@ void device_del_completion(ReadLineState *rs, int nb_args, const char *str)
     peripheral_device_del_completion(rs, str);
 }
 
+void device_set_completion(ReadLineState *rs, int nb_args, const char *str)
+{
+    GSList *list, *elt;
+    size_t len;
+
+    if (nb_args == 2) {
+        len = strlen(str);
+        readline_set_completion_index(rs, len);
+
+        list = elt = object_class_get_list(TYPE_DEVICE, false);
+        while (elt) {
+            DeviceClass *dc = OBJECT_CLASS_CHECK(DeviceClass, elt->data,
+                                                 TYPE_DEVICE);
+            readline_add_completion_of(
+                rs, str, object_class_get_name(OBJECT_CLASS(dc)));
+            elt = elt->next;
+        }
+        g_slist_free(list);
+        return;
+    }
+
+    if (nb_args == 3) {
+        readline_set_completion_index(rs, strlen(str));
+        readline_add_completion_of(rs, str, "admin-state");
+        return;
+    }
+
+    if (nb_args == 4) {
+        readline_set_completion_index(rs, strlen(str));
+        readline_add_completion_of(rs, str, "enable");
+        readline_add_completion_of(rs, str, "disable");
+        return;
+    }
+}
+
 BlockBackend *blk_by_qdev_id(const char *id, Error **errp)
 {
     DeviceState *dev;
@@ -1134,6 +1255,22 @@ QemuOptsList qemu_device_opts = {
     },
 };
 
+QemuOptsList qemu_deviceset_opts = {
+    .name = "deviceset",
+    .implied_opt_name = "driver",
+    .head = QTAILQ_HEAD_INITIALIZER(qemu_deviceset_opts.head),
+    .desc = {
+        /*
+         * no fixed schema; parameters include:
+         * - driver=<device-name>
+         * - id=<device-id> (optional)
+         * - admin-state=enabled|disabled
+         * - other optional props for locating the device
+         */
+        { /* end of list */ }
+    },
+};
+
 QemuOptsList qemu_global_opts = {
     .name = "global",
     .head = QTAILQ_HEAD_INITIALIZER(qemu_global_opts.head),
diff --git a/system/vl.c b/system/vl.c
index 2f0fd21a1f..c1731de202 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1218,6 +1218,16 @@ static int device_init_func(void *opaque, QemuOpts *opts, Error **errp)
     return 0;
 }
 
+static int deviceset_init_func(void *opaque, QemuOpts *opts, Error **errp)
+{
+    QDict *qdict = qemu_opts_to_qdict(opts, NULL);
+
+    qmp_device_set(qdict, errp);
+    qobject_unref(qdict);
+
+    return *errp ? -1 : 0;
+}
+
 static int chardev_init_func(void *opaque, QemuOpts *opts, Error **errp)
 {
     Error *local_err = NULL;
@@ -2755,6 +2765,10 @@ static void qemu_create_cli_devices(void)
         assert(ret_data == NULL); /* error_fatal aborts */
         loc_pop(&opt->loc);
     }
+
+    /* add deferred 'deviceset' list handling - common to JSON/non-JSON path */
+    qemu_opts_foreach(qemu_find_opts("deviceset"), deviceset_init_func, NULL,
+                      &error_fatal);
 }
 
 static bool qemu_machine_creation_done(Error **errp)
@@ -2855,6 +2869,7 @@ void qemu_init(int argc, char **argv)
     qemu_add_drive_opts(&bdrv_runtime_opts);
     qemu_add_opts(&qemu_chardev_opts);
     qemu_add_opts(&qemu_device_opts);
+    qemu_add_opts(&qemu_deviceset_opts);
     qemu_add_opts(&qemu_netdev_opts);
     qemu_add_opts(&qemu_nic_opts);
     qemu_add_opts(&qemu_net_opts);
@@ -3458,6 +3473,30 @@ void qemu_init(int argc, char **argv)
                     }
                 }
                 break;
+            case QEMU_OPTION_deviceset:
+                if (optarg[0] == '{') {
+                     /* JSON input: convert to QDict and then to QemuOpts */
+                     QObject *obj = qobject_from_json(optarg, &error_fatal);
+                     QDict *qdict = qobject_to(QDict, obj);
+                     if (!qdict) {
+                         error_report("Invalid JSON object for -deviceset");
+                         exit(1);
+                     }
+
+                     opts = qemu_opts_from_qdict(qemu_find_opts("deviceset"),
+                                                 qdict, &error_fatal);
+                     qobject_unref(qdict);
+                     if (!opts) {
+                         error_report_err(error_fatal);
+                         exit(1);
+                     }
+                } else {
+                    if (!qemu_opts_parse_noisily(qemu_find_opts("deviceset"),
+                                                 optarg, true)) {
+                        exit(1);
+                    }
+                }
+                break;
             case QEMU_OPTION_smp:
                 machine_parse_property_opt(qemu_find_opts("smp-opts"),
                                            "smp", optarg);
-- 
2.34.1


