Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E22D25932
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 05:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkbSm-0008Fq-AQ; Tue, 27 Jan 2026 00:18:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbSk-000864-EC
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:18:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbSi-0000F9-Jl
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:18:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769491080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MJe0SvEr1kOlUoBq6W2ESJltt4iwlZL4Id0CQflQPnk=;
 b=GV7HaWAV4ciflEgfaUsYY9LWfsiTzFni3ms+TnE36Yb/emFdC+4rV6YoetugEMhLGevrpT
 1X7OWkXN8GcjPl3MLbdU456dWzJnNBRmTytxUTxTQWzbjTr29VrAqq/5pIaSUNyRVn5Qnr
 o/PTEJeNHoEyOfKbVVejZxlAD2f5cR4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-95cAAjKLM1atxaBKI_vfjQ-1; Tue, 27 Jan 2026 00:17:57 -0500
X-MC-Unique: 95cAAjKLM1atxaBKI_vfjQ-1
X-Mimecast-MFC-AGG-ID: 95cAAjKLM1atxaBKI_vfjQ_1769491077
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2a7b7f04a11so8601065ad.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 21:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769491077; x=1770095877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MJe0SvEr1kOlUoBq6W2ESJltt4iwlZL4Id0CQflQPnk=;
 b=kcvyMLOgRF9ar8ZPHoqkvkA0jiQoxG2hxWFoeL3hmOOK1uB2Ezbb6QmZRFYpjuTJkN
 HfmGwT2y+1K6bbM5AMDDdmGG5azD+v1y7ZlwHQWKyAahdykGeyJyqOLfgvxQip8clmmm
 yHEDKnH44dOcARCjRPV51vCGj/xhlfTK6KFHfzstm5heC4RNGbhy7qhMxY/wRi05Acau
 R1kAQE0DP03R2svdMNcEv6qwesZmVWjKNZF/GeANE5nr+QTkBn4vHOtLioHX47WYrpSH
 sjLUC3KuMMNhyvMISxefKAcYCMDPR//Za7VGSsudMlQLtjkOR6VCzSkYNnX3hy31ysNh
 HwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769491077; x=1770095877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MJe0SvEr1kOlUoBq6W2ESJltt4iwlZL4Id0CQflQPnk=;
 b=DK4U3dNZzZlSeapymNUxVkCzvdhrJNJSSpKlLZaAAQrYalj/gmrAjuykSha2OkY/Pa
 LM/C5+bjp+UVplgRMSa5UI5b56hh4fXh/+9I/kSBf0l1HTSxjvvu7tCF+veyAPOmjEs7
 f5vc8+44+PrYEhWI0N+7fwOPZnOc8EOnSmGkH8WN6tLvgqBsL2An0q/OILGDhEfyFubp
 rIMV59lfASffFterDZcprIPv1WCkAgkg+Fb351guDHPEOYvcP+KfJGPMlGHQep4ewFxT
 gnkTAQV8J4RkunWaOb66x1QaFDK4eEiXEldhm+90+ArFOVXQ9Q3FgbRigZgSkHRhK62h
 /i2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTNOzF59vIfxFX0Dbelp3NOGzik78R1Y3ViR5c+dsC6L+KatRwzyQ9D3MIQmCpfgcbm5u7ch12QFo+@nongnu.org
X-Gm-Message-State: AOJu0YxBjHBBewxnM0ovPtn3RPH3o/tatuTNEtXr/HrLaFj2fvl2oWxM
 /l7lwhw1yHTBt0WddKmTBqnTmRj5R64NK0D6RPs0V9mHWM8dP2thBuDpMMKKebNaEqxqH6XzHWL
 m52V0QoB2nPTHkIA+i0z66TigMvcpiOiqoC0xob0BZd6JKvzIerqSV9xA
X-Gm-Gg: AZuq6aLfOAHdSAMzvOFncy/524kBKo26bbIm6TR12wF9JHfEgxLjTBEYv30hZksSR39
 jyScfTmSx238pnM4mNxH6RKMa3+rWiENBXPZ8wgCaX4GZKrPVgYctVQrz+bxhx9nc+9LdnlyJKC
 MCQzbKX9/s5WMxu1khdpKRijN5/CjybjLyy+dd/yHDd6Y6RZChRuXL9jhmQ59D3xTh802C7n2U+
 +Fe+fULP03bvFXZWKI+S6d3vN5CLXUdKFeqPZNFWd90Zu+fYMOtdElHOAPmKgErHL2DoK8FcnUU
 vMHKTwuAvatGDmml4g/8ZMQdlC7xui+NLan5JC3nPkjPN9ToceIykTsl4hc2uOmiQMpaKTnVX75
 foc9BAJM+r94G01qVAm4GebiaUZWhV5U7bvOZjKYBtQ==
X-Received: by 2002:a17:902:f60e:b0:2a0:bb3b:4191 with SMTP id
 d9443c01a7336-2a870d7a91dmr6033425ad.12.1769491076694; 
 Mon, 26 Jan 2026 21:17:56 -0800 (PST)
X-Received: by 2002:a17:902:f60e:b0:2a0:bb3b:4191 with SMTP id
 d9443c01a7336-2a870d7a91dmr6033305ad.12.1769491076256; 
 Mon, 26 Jan 2026 21:17:56 -0800 (PST)
Received: from rhel9-box.lan ([122.163.48.79])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-353f6230d5dsm1110925a91.17.2026.01.26.21.17.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 21:17:55 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 27/33] kvm/xen_evtchn: add support for confidential guest
 reset
Date: Tue, 27 Jan 2026 10:45:55 +0530
Message-ID: <20260127051612.219475-28-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260127051612.219475-1-anisinha@redhat.com>
References: <20260127051612.219475-1-anisinha@redhat.com>
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

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/kvm/xen_evtchn.c | 113 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 110 insertions(+), 3 deletions(-)

diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index 8b243984e4..7802fa68ae 100644
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
@@ -304,6 +325,57 @@ static void gsi_assert_bh(void *opaque)
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
+    /* we are not interested in pre vmfd change notification */
+    if (((VmfdChangeNotifier *)data)->pre) {
+        return 0;
+    }
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
@@ -350,6 +422,9 @@ void xen_evtchn_create(unsigned int nr_gsis, qemu_irq *system_gsis)
 
     /* Set event channel functions for backend drivers to use */
     xen_evtchn_ops = &emu_evtchn_backend_ops;
+
+    xen_eventchn_notifier.notify = xen_eventchn_handle_vmfd_change;
+    kvm_vmfd_add_change_notifier(&xen_eventchn_notifier);
 }
 
 static void xen_evtchn_register_types(void)
@@ -547,6 +622,8 @@ static void inject_callback(XenEvtchnState *s, uint32_t vcpu)
 static void deassign_kernel_port(evtchn_port_t port)
 {
     struct kvm_xen_hvm_attr ha;
+    struct kernel_ports *kp;
+    struct eventfds *ef;
     int ret;
 
     ha.type = KVM_XEN_ATTR_TYPE_EVTCHN;
@@ -557,6 +634,19 @@ static void deassign_kernel_port(evtchn_port_t port)
     if (ret) {
         qemu_log_mask(LOG_GUEST_ERROR, "Failed to unbind kernel port %d: %s\n",
                       port, strerror(ret));
+    } else {
+        QLIST_FOREACH(kp, &kernel_port_list, node) {
+            if (kp->port == port) {
+                QLIST_REMOVE(kp, node);
+                g_free(kp);
+            }
+        }
+        QLIST_FOREACH(ef, &eventfd_list, node) {
+            if (ef->port == port) {
+                QLIST_REMOVE(ef, node);
+                g_free(ef);
+            }
+        }
     }
 }
 
@@ -565,6 +655,8 @@ static int assign_kernel_port(uint16_t type, evtchn_port_t port,
 {
     CPUState *cpu = qemu_get_cpu(vcpu_id);
     struct kvm_xen_hvm_attr ha;
+    struct kernel_ports *kp = g_malloc0(sizeof(*kp));
+    int ret;
 
     if (!cpu) {
         return -ENOENT;
@@ -578,12 +670,21 @@ static int assign_kernel_port(uint16_t type, evtchn_port_t port,
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
+    struct eventfds *ef = g_malloc0(sizeof(*ef));
+    int ret;
 
     ha.type = KVM_XEN_ATTR_TYPE_EVTCHN;
     ha.u.evtchn.send_port = port;
@@ -592,7 +693,14 @@ static int assign_kernel_eventfd(uint16_t type, evtchn_port_t port, int fd)
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
@@ -2391,4 +2499,3 @@ void hmp_xen_event_inject(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "Delivered port %d\n", port);
     }
 }
-
-- 
2.42.0


