Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701B0C9EC90
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHv3-0004yc-CQ; Mon, 12 Jan 2026 08:25:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHuT-0004Ho-9C
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHuP-0003sM-EE
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768224276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1LOhl43/dq76eZe6Pp1YIu3+XE/iaRx98MaQ8/pCiC0=;
 b=g6Ov7k84z7et7F+LRmIMHs+l64EGWLV+F8yj4swEfPRU00Sjt/yOH2CIZQ/ZZ1HEw911NL
 17vRfeAJXHrhNZmlMP9hPJqaSWIk8q5qCXDagxhWAqORWt4X3Lk4z9oa7Jtcn0ubSu/k6I
 PWouby0XA6L5wy+AsqCPA6qi0jxnkeE=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-2hTw6IgnMGmR5y5LOONTfA-1; Mon, 12 Jan 2026 08:24:35 -0500
X-MC-Unique: 2hTw6IgnMGmR5y5LOONTfA-1
X-Mimecast-MFC-AGG-ID: 2hTw6IgnMGmR5y5LOONTfA_1768224275
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c337375d953so4584297a12.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768224275; x=1768829075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1LOhl43/dq76eZe6Pp1YIu3+XE/iaRx98MaQ8/pCiC0=;
 b=OLoP1frEelAEUJ4qZBN8ESMY95UHcCTIWeXVcrKBFR2dzNyMkInm4C+VPtH9go6bG/
 yXY+Xo9MzM1p0OuwqJXNzMoipa/c8kD1xH46o8+htIfT+CHSNb40jAVRSFuh4ufzxsiN
 vpZxY3yFffynz4mlAysC+sU+8hiyxmLXn/DqKBKCBggmoNSDOEtoNoMxm6lbGkafqHbG
 K2Dj+DjNEnZqLlbkvL8HKDWNMhUqmFfqDesOZap3s2ha0w9ON2TFlo2G1EW8lMcdCOy/
 d1ruBjTpu6PmcdaXxfyRX7rZIu/r/6mJaZFuXT7PKujwHV/hEqQxkX2wx35LGFdIgGCB
 vSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768224275; x=1768829075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1LOhl43/dq76eZe6Pp1YIu3+XE/iaRx98MaQ8/pCiC0=;
 b=Zpfvp9tF4u93h8q8fLEcrROxQoxZwq9fMAoTX4KwgFNLn+Td7htbuK7q2FaMWz1MW1
 pD/qx8EwHxYo4Ppw1WfeqbKSKaT5KzA4cZR6yh+xmi1Gb3OmVg2uyKgHzAT29P8KFICp
 mM+EZU5Qv45h9uH1VahX0fnBvvdkhJaZX6k5WGNzQSb8ASJF24FS+yUcibH6tBSpjhpB
 uvdParrGiY5oyDJdd0tuQjqnc3CCbAWUSME17V5hFsypfHw1oKDp6nqU/YDPjwry6YB3
 9cJdBPuV98ZoLNFVjF9LEN7fS4XMOoNPO2/SmwLtlqWNiwb44AFkkZTOFpzDKBO4v7rl
 n5aQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbnyMQIopq6aWTD99F+IQRvQDUYjBjNaJsWThANPY9YkWk1Urjw8rwNbfK0x7liEZY0E3mxoXoLZDb@nongnu.org
X-Gm-Message-State: AOJu0Yw0J13qLWLSANZ3AFOrNvmqjQW+wpPt3jVmRUINLyuxlsZFans3
 lf84tvRvSxkvIUCYdsjBCe1ovBxyUjLw/3k20oyIVplVhA+JVfaJJTY+OCXkqW59u3YKVPMNsis
 DAQlBJ1Gvhyes1XH4KeYsfeqL+e5x7xVJ4cfU/JTjrganf7lKYxIXXe+o
X-Gm-Gg: AY/fxX5ffFyAxqWf4XT7msOdAcG6haw1TRmA18YGq1BLp/Y5CYmwu3fGFMIt7TXTowJ
 EWi1tOnmqcLHp1C+yJl3j0DH2x9Vh9f/RPEGyh+z/Xtt8aVJNToJzBsxOGEjZunNaGIJPg/8LGF
 ePqRaKbPyK7nPJYRz5C3l379ytLng9N+Of3pwSIjCjjFuSUhd6xmfPk8IPbuKhxNyPGAqsmVqf9
 ZvXAPUBGlar7NpaRFF4B6emd73n7cdWYADowpZbdbDicVcAwHT9k3IwaNaFfwr+biV6LDbhNiaZ
 mzjTrm9khGwuMgRH5bY1oOoyOSH2Zczc6MqTW7NEz9+t7TJkUQqpNkcr0cheHsz0DuaJzXxCm09
 SxiV1qmmHqnjutB4qBAddsklqLX8qyMlNHyffyLl78EY=
X-Received: by 2002:a05:6a20:7f95:b0:366:14ac:8c6f with SMTP id
 adf61e73a8af0-3898f9db830mr15706095637.69.1768224274681; 
 Mon, 12 Jan 2026 05:24:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5XPCBEKldwM8vUeL1siQ5N0gP8WJgL6Eev8zYF2ErEUu1bwf3lwa9SMhcx7QdNvA9I/Niow==
X-Received: by 2002:a05:6a20:7f95:b0:366:14ac:8c6f with SMTP id
 adf61e73a8af0-3898f9db830mr15706066637.69.1768224274254; 
 Mon, 12 Jan 2026 05:24:34 -0800 (PST)
Received: from rhel9-box.lan ([110.227.88.119])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd87asm17544771a12.15.2026.01.12.05.24.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 05:24:33 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: Ani Sinha <anisinha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 26/32] kvm/xen_evtchn: add support for confidential guest
 reset
Date: Mon, 12 Jan 2026 18:52:39 +0530
Message-ID: <20260112132259.76855-27-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260112132259.76855-1-anisinha@redhat.com>
References: <20260112132259.76855-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

As a part of the confidential guest reset, when the KVM VM file handle is
changed, Xen event ports and kernel ports that were associated with the
previous KVM file handle needs to be reassociated with the new handle. This is
performed with the help of a callback handler that gets invoked during the
confidential guest reset process when the KVM VM file fd changes.

This patch is untested on confidential guests and exists only for completeness.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/kvm/xen_evtchn.c | 100 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 97 insertions(+), 3 deletions(-)

diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index b65871f354..18d6aa9cd5 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -133,6 +133,26 @@ struct pirq_info {
     bool is_translated;
 };
 
+struct eventfds {
+    uint16_t type;
+    evtchn_port_t port;
+    int fd;
+    QLIST_ENTRY(eventfds) node;
+};
+
+struct kernel_ports {
+    uint16_t type;
+    evtchn_port_t port;
+    uint32_t vcpu_id;
+    QLIST_ENTRY(kernel_ports) node;
+};
+
+static QLIST_HEAD(, eventfds) eventfd_list =
+    QLIST_HEAD_INITIALIZER(eventfd_list);
+
+static QLIST_HEAD(, kernel_ports) kernel_port_list =
+    QLIST_HEAD_INITIALIZER(kernel_port_list);
+
 struct XenEvtchnState {
     /*< private >*/
     SysBusDevice busdev;
@@ -178,6 +198,7 @@ struct XenEvtchnState {
 #define pirq_inuse(s, pirq) (pirq_inuse_word(s, pirq) & pirq_inuse_bit(pirq))
 
 struct XenEvtchnState *xen_evtchn_singleton;
+static NotifierWithReturn xen_eventchn_notifier;
 
 /* Top bits of callback_param are the type (HVM_PARAM_CALLBACK_TYPE_xxx) */
 #define CALLBACK_VIA_TYPE_SHIFT 56
@@ -304,6 +325,52 @@ static void gsi_assert_bh(void *opaque)
     }
 }
 
+static int xen_eventchn_handle_vmfd_change(NotifierWithReturn *notifier,
+                                           void *data, Error **errp)
+{
+    struct eventfds *ef;
+    struct kernel_ports *kp;
+    struct kvm_xen_hvm_attr ha;
+    CPUState *cpu;
+    int ret;
+
+    QLIST_FOREACH(ef, &eventfd_list, node) {
+        ha.type = KVM_XEN_ATTR_TYPE_EVTCHN;
+        ha.u.evtchn.send_port = ef->port;
+        ha.u.evtchn.type = ef->type;
+        ha.u.evtchn.flags = 0;
+        ha.u.evtchn.deliver.eventfd.port = 0;
+        ha.u.evtchn.deliver.eventfd.fd = ef->fd;
+
+        ret = kvm_vm_ioctl(kvm_state, KVM_XEN_HVM_SET_ATTR, &ha);
+        if (ret < 0) {
+            error_setg(errp, "KVM_XEN_HVM_SET_ATTR failed with %d", ret);
+            return ret;
+        }
+    }
+
+    memset(&ha, 0, sizeof(ha));
+
+    QLIST_FOREACH(kp, &kernel_port_list, node) {
+        cpu = qemu_get_cpu(kp->vcpu_id);
+        ha.type = KVM_XEN_ATTR_TYPE_EVTCHN;
+        ha.u.evtchn.send_port = kp->port;
+        ha.u.evtchn.type = kp->type;
+        ha.u.evtchn.flags = 0;
+        ha.u.evtchn.deliver.port.port = kp->port;
+        ha.u.evtchn.deliver.port.vcpu = kvm_arch_vcpu_id(cpu);
+        ha.u.evtchn.deliver.port.priority =
+            KVM_IRQ_ROUTING_XEN_EVTCHN_PRIO_2LEVEL;
+
+        ret = kvm_vm_ioctl(kvm_state, KVM_XEN_HVM_SET_ATTR, &ha);
+        if (ret < 0) {
+            error_setg(errp, "KVM_XEN_HVM_SET_ATTR failed with %d", ret);
+            return ret;
+        }
+    }
+    return 0;
+}
+
 void xen_evtchn_create(unsigned int nr_gsis, qemu_irq *system_gsis)
 {
     XenEvtchnState *s = XEN_EVTCHN(sysbus_create_simple(TYPE_XEN_EVTCHN,
@@ -350,6 +417,9 @@ void xen_evtchn_create(unsigned int nr_gsis, qemu_irq *system_gsis)
 
     /* Set event channel functions for backend drivers to use */
     xen_evtchn_ops = &emu_evtchn_backend_ops;
+
+    xen_eventchn_notifier.notify = xen_eventchn_handle_vmfd_change;
+    kvm_vmfd_add_change_notifier(&xen_eventchn_notifier);
 }
 
 static void xen_evtchn_register_types(void)
@@ -547,6 +617,7 @@ static void inject_callback(XenEvtchnState *s, uint32_t vcpu)
 static void deassign_kernel_port(evtchn_port_t port)
 {
     struct kvm_xen_hvm_attr ha;
+    struct kernel_ports *kp;
     int ret;
 
     ha.type = KVM_XEN_ATTR_TYPE_EVTCHN;
@@ -557,6 +628,12 @@ static void deassign_kernel_port(evtchn_port_t port)
     if (ret) {
         qemu_log_mask(LOG_GUEST_ERROR, "Failed to unbind kernel port %d: %s\n",
                       port, strerror(ret));
+    } else {
+        QLIST_FOREACH(kp, &kernel_port_list, node) {
+            if (kp->port == port) {
+                QLIST_REMOVE(kp, node);
+            }
+        }
     }
 }
 
@@ -565,6 +642,8 @@ static int assign_kernel_port(uint16_t type, evtchn_port_t port,
 {
     CPUState *cpu = qemu_get_cpu(vcpu_id);
     struct kvm_xen_hvm_attr ha;
+    g_autofree struct kernel_ports *kp = g_malloc0(sizeof(*kp));
+    int ret;
 
     if (!cpu) {
         return -ENOENT;
@@ -578,12 +657,21 @@ static int assign_kernel_port(uint16_t type, evtchn_port_t port,
     ha.u.evtchn.deliver.port.vcpu = kvm_arch_vcpu_id(cpu);
     ha.u.evtchn.deliver.port.priority = KVM_IRQ_ROUTING_XEN_EVTCHN_PRIO_2LEVEL;
 
-    return kvm_vm_ioctl(kvm_state, KVM_XEN_HVM_SET_ATTR, &ha);
+    ret = kvm_vm_ioctl(kvm_state, KVM_XEN_HVM_SET_ATTR, &ha);
+    if (ret == 0) {
+        kp->type = type;
+        kp->port = port;
+        kp->vcpu_id = vcpu_id;
+        QLIST_INSERT_HEAD(&kernel_port_list, kp, node);
+    }
+    return ret;
 }
 
 static int assign_kernel_eventfd(uint16_t type, evtchn_port_t port, int fd)
 {
     struct kvm_xen_hvm_attr ha;
+    g_autofree struct eventfds *ef = g_malloc0(sizeof(*ef));
+    int ret;
 
     ha.type = KVM_XEN_ATTR_TYPE_EVTCHN;
     ha.u.evtchn.send_port = port;
@@ -592,7 +680,14 @@ static int assign_kernel_eventfd(uint16_t type, evtchn_port_t port, int fd)
     ha.u.evtchn.deliver.eventfd.port = 0;
     ha.u.evtchn.deliver.eventfd.fd = fd;
 
-    return kvm_vm_ioctl(kvm_state, KVM_XEN_HVM_SET_ATTR, &ha);
+    ret = kvm_vm_ioctl(kvm_state, KVM_XEN_HVM_SET_ATTR, &ha);
+    if (ret == 0) {
+        ef->type = type;
+        ef->port = port;
+        ef->fd = fd;
+        QLIST_INSERT_HEAD(&eventfd_list, ef, node);
+    }
+    return ret;
 }
 
 static bool valid_port(evtchn_port_t port)
@@ -2391,4 +2486,3 @@ void hmp_xen_event_inject(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "Delivered port %d\n", port);
     }
 }
-
-- 
2.42.0


