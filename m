Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C898D4922D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 15:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU4iO-00042e-Ae; Fri, 12 Dec 2025 10:05:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4iM-00041A-F8
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:05:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4iK-0006Dc-Of
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:05:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765551948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wH2S5VuWnDK8CB8klAkG6rsUPibcz9poRIKukfvIXkw=;
 b=XTQzfuIZ2fUx6mESRSy0ALSxERX+5mQjX9bdi30hQYh5UFY0NW4rFfJ487cPjXBGef5gYo
 CbRzvzcBZglJgKrp5aI2F5nXeoDqB1CK6vE0xq+X/SXayZiVv4J3q5F4R/XWKpxZTmzvkS
 MsmFG9DWwSouEK5ve6BSIkobZKSRWBg=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-ls_VKe9qNVyjAYQsXQuIag-1; Fri, 12 Dec 2025 10:05:47 -0500
X-MC-Unique: ls_VKe9qNVyjAYQsXQuIag-1
X-Mimecast-MFC-AGG-ID: ls_VKe9qNVyjAYQsXQuIag_1765551946
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-29be4d2ef78so24297685ad.2
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 07:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765551946; x=1766156746; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wH2S5VuWnDK8CB8klAkG6rsUPibcz9poRIKukfvIXkw=;
 b=lLlMr0Pb5aMCnfRQjP8QPQpIPezO7pQ2Pw+KS1Sb56ncDc8omEYpei61Rg1Iz7ecv+
 Q4l6NMhqgVCLf/7r3bk7KRSS4n6HB+C7d/RZFlz4TjZb1ZaMg1F3kewzPrFhXCPYccNp
 r19/YPJQm4a9xAIv+jQpVtiohUp9nHJlqv/VE6bsyz6evbP8Fw9j4Mff0AKBiSEVHg2F
 16YB0jRvvchQsK7XEDdEcb9vomksr6f+S4BPi1FKQoNvtVr1gMF+DR4wY1WRVvdmz2R+
 l4N5VlTdz9kXY6O4SeuqAnMFaHdtMr10tjZlM6gUwoh823q+vT8JRrOh3ucvujyJpKxv
 aYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765551946; x=1766156746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wH2S5VuWnDK8CB8klAkG6rsUPibcz9poRIKukfvIXkw=;
 b=j7wEdfbdE+ExNIM1U2mVqkhlX9hh8CR551axomN3FMx1w06vuMb47ns38ffYy8C4jL
 dAb526cwbPpD8kflVASw7RiRp3/dhlwj2UeBCgPRDRQbxSRk1bvVTXkQ80Gc8cBG0FfK
 AODLIxrvSau4eingSBB1Ohstj7guxFG3kL2RhT9LQLGPkqNiAewIqmTiML0m/FeQmmMz
 PToXbFypLrlM+AtdCp6xMoC+Xe2htIete4JIwiq3x6Rd2vBrFElga7G5K1QxUHlY7szr
 Ba1p2bGc+naM/bBzshTndfgLBi7+pdEBpBWLgZushxx0ctp/3DpWB8O1IWY42UXHkR1k
 1s/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOaMMgueQQC2LgYQYHta83QO3NHPFGNlpQ5Fdx5YW5KuhYOFJv52lde+xQ3aqNcXNqGNNLc+mCWM5h@nongnu.org
X-Gm-Message-State: AOJu0YwDWm0auFOXcnotep8FVZwrghouwo1yMFlKVgmYj87T2ihaw9Re
 btKQr6B6muISO6LpBRL47OlHMSxpAYUjfxCpHiZRtPgfm21KkO/uDD1XD9suaIvc1c2CTwO0a4L
 MiE5iu47uW3m1fDVQqae9uwkpT5YgDsWqygH0P/z2DHN/uDaHJ40U+jVk
X-Gm-Gg: AY/fxX5ColXDeo2GxTyPn8IwZ5Hca5bKfSTiEFc8AG6a0BtwAtsteObjwoLpLxK6VgT
 Os5fu0v8oxYcYyZ2HMNaM9Im+PvfhYDFRkjxaJ+3y7hnf0kRMaP+eZ+ZWOL/6Hwu8oUscJSgokn
 yw3uU2mtuAZyQN11LD32hmAkpb9zxEtEwnwJB8YMthAv0gPPYxRD+cD7dA7SCv/Xxbq8acjCiIw
 CDsky9IMgODvX5wPdYz0MKiIizhHbZ+voCterf4RTOmk0sDTPcZdfbWlPSIUEzuXZX1VdahICk0
 8VDOh9VAX0aMEQIa1wbXyiZZZUJU4Uf1Y7B5d9xhQCmKIULLTKk0966xQ8TqxfUWfPeH2O6sYUR
 uuikvVN879yVP38L3gYxArQxtbv6g52FxkltUulnlXBM=
X-Received: by 2002:a17:903:2f82:b0:24e:3cf2:2453 with SMTP id
 d9443c01a7336-29f244d3b40mr22416065ad.61.1765551945603; 
 Fri, 12 Dec 2025 07:05:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwQTlmTKf6GwCiZWdOxB8VVvz+2nCUW9OqKI7syxsRTHJrEXd1eetjt2ZbHS/ZpCh3A+Y8eA==
X-Received: by 2002:a17:903:2f82:b0:24e:3cf2:2453 with SMTP id
 d9443c01a7336-29f244d3b40mr22413215ad.61.1765551941344; 
 Fri, 12 Dec 2025 07:05:41 -0800 (PST)
Received: from rhel9-box.lan ([122.172.173.62])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-29ee9d38ad1sm57046655ad.29.2025.12.12.07.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 07:05:40 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: vkuznets@redhat.com, kraxel@redhat.com, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v1 24/28] kvm/xen_evtchn: add support for confidential guest
 reset
Date: Fri, 12 Dec 2025 20:33:52 +0530
Message-ID: <20251212150359.548787-25-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20251212150359.548787-1-anisinha@redhat.com>
References: <20251212150359.548787-1-anisinha@redhat.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

As a part of the confidential guest reset, when the KVM VM file handle is
changed, Xen event ports and kernel ports that were associated with the
previous KVM file handle needs to be reassociated with the new handle. This is
performed with the help of a callback handler that gets invoked during the
confidential guest reset process when the KVM VM file fd changes.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/kvm/xen_evtchn.c | 100 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 97 insertions(+), 3 deletions(-)

diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index dd566c4967..ddacb26c44 100644
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


