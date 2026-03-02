Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7319D58E7F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyzc-0007Ns-2n; Mon, 02 Mar 2026 03:51:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyxC-0003K6-O6
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyxA-0002FY-Ve
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3UgH+JOnN2M8WHuMSMR4uqDP2YjLtYKqK18FCdha8ns=;
 b=gEwF3k7TYPvwHLcYXC5uOtlZhmI81mu1wUX1gfh1P8fEoQ/Ne82XpcWSiVG2/nLb21sNEC
 9WtzpG1fm19yPiE2bORQE17tEoUKCpaT1WQrRyv018mbc9GWayrUV+gJTAKpAKOMVPr12F
 7aKKca8X5utcCX97DEdL6ol6w9Fp2LY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-wRlI9wCeNI-cKEVXvBJlcQ-1; Mon, 02 Mar 2026 03:48:35 -0500
X-MC-Unique: wRlI9wCeNI-cKEVXvBJlcQ-1
X-Mimecast-MFC-AGG-ID: wRlI9wCeNI-cKEVXvBJlcQ_1772441314
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48069a43217so41073985e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441313; x=1773046113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3UgH+JOnN2M8WHuMSMR4uqDP2YjLtYKqK18FCdha8ns=;
 b=fxre8Zh1xPmzPIHH30pW4WJwEpZ11ihOoHYAkhk2P5gVqniDJPDGKb3bIBDm0ob0El
 8HpZPElA7Bd4dfnyQv9GkImHFVGlAsZQrt5krt9aInJUxpYo2VytWjSTHjBVZwP5VZFv
 USW0KahrsugIPaMNhCBwTXvJwJsYTG+ZHvVfZLbGbb5Pi8huy9U640OhURL3sAwdnYBj
 6uR1BGeSCc1F9TnP3dqBIrYdQ+7icFcRtBwixUeKv7MVHG6I1ZsBb2sEkig4qb6UgVNs
 wCQc7li7lmim8t52h4rCIdxVv/H7zkNn8HTnNqfnSc1lOMjnWuJpQQVlbqouvLMXbt7x
 7vlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441313; x=1773046113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3UgH+JOnN2M8WHuMSMR4uqDP2YjLtYKqK18FCdha8ns=;
 b=qhkbMKf70FObrCO3x+SqKAnT+R1himdGEsXF36RpIW1EWPdnkH8OlUnsG49Pm1XsfT
 2PsyfyzppUoDmgMScKCjzuILdL5NRWVS3E650lHGvUvQ90PstGqJI7mtIvOqjLNvwC7k
 6RNIed9vAQyd52PBkDsT95XM2DAlxqTTgNMRvqzOePr1Gjnb/Fi9fdI7+I8AtRnH8tjT
 p4ooWd1LW+Dy2+TmcG+GwT49jxEfK+R0sZRcuuHCxYKDfwf5UDSLIv228ORlecY+ZZ4L
 w9xxGQqoXvSzBOwgF8SAnx2uKzYn4pDGhLO82gKybv7wH6H2r/AJvArFkPZr6o3/20bO
 7WbQ==
X-Gm-Message-State: AOJu0YzYfE2Zb05lYZla9ZtLlmd7Ku6q3mwwIzH5F0++mOt4staErLqi
 esm4m1CoI3+GADc1tBQ2fUaL80WxoFYkHJkGqeLZbFO3edBCt4OurlaW/temMKcrxMbmjoikq/m
 LHbhxLjX4Unj1phZL8gUMge5okHypWE01+kZQ3Ihfjg/I1M5GGY1MUy6ZqOvbntyCMMMGZ4C9Jp
 MbIQCppOb0CrLQd4Mn+XN8nYswq6jr1zC7qeX0xcO+
X-Gm-Gg: ATEYQzxzsKs2oEctA7gvOq2iVu8gqz4grUyFSLxb/ytMCz0UL7Gho3AUL7eV1XSLfv4
 GEcSO2OPKGeHkWYU78+oy8QJfo2i1PdQL9JyFCsPleEHz4cLgOPX9o+BjLFAHIJakaehXlgVgpZ
 bCSE5dmMF8LJEwHhU5B7JbMLB+DUatQuSZHrqg7wC+J7MM+lnWzRy1+MdviRUPNqWfOVqpMrI9S
 C0ehnXt4i98yA7+D3h9GxH0BSVRkhLuG/ZkdKnbvuimf9ZgEdjVtJ+EB2V2QVRIFbO1lGCcE2/n
 uct8F/WcA2KPiCeXGQVmtcdGsiVjnT5VIvZHVgiXuyt3YFJ47bthdvjL4ftozHM/hNPoupxcGux
 1fHCDw5ClCtf/mt1OT9xzNv2d+ufSnypU0Mz0CZc+cQRXydOYa8rBNxsBvaXckUU8VsMtM3O3Zj
 rQZtu0JhyWZk77O1sTn2EExaMPeTI=
X-Received: by 2002:a05:600c:3e8e:b0:47a:8cce:2940 with SMTP id
 5b1f17b1804b1-483c9ba2922mr212828335e9.14.1772441313177; 
 Mon, 02 Mar 2026 00:48:33 -0800 (PST)
X-Received: by 2002:a05:600c:3e8e:b0:47a:8cce:2940 with SMTP id
 5b1f17b1804b1-483c9ba2922mr212828035e9.14.1772441312645; 
 Mon, 02 Mar 2026 00:48:32 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd750607sm391268695e9.10.2026.03.02.00.48.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:48:31 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, myrslint <qemu.haziness801@passinbox.com>
Subject: [PULL 083/102] KVM: i386: Default disable ignore guest PAT quirk
Date: Mon,  2 Mar 2026 09:47:29 +0100
Message-ID: <20260302084749.474955-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: myrslint <qemu.haziness801@passinbox.com>

Add a new accelerator option that allows the guest to adjust the PAT.
This is already the case for TDX guests and allows using virtio-gpu
Venus with RADV or NVIDIA drivers.

The quirk is disabled by default.  Since this caused problems with
Linux's Bochs video device driver, add a knob to leave it enabled,
and for now do ont enable it by default.

Signed-off-by: Myrsky Lintu <qemu.haziness801@passinbox.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2943
Link: https://lore.kernel.org/r/175527721636.15451.4393515241478547957-1@git.sr.ht
[Add property; for now leave it off by default. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/kvm_int.h |  1 +
 accel/kvm/kvm-all.c      |  1 +
 target/i386/kvm/kvm.c    | 50 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
index baeb166d393..0876aac938d 100644
--- a/include/system/kvm_int.h
+++ b/include/system/kvm_int.h
@@ -167,6 +167,7 @@ struct KVMState
     uint16_t xen_gnttab_max_frames;
     uint16_t xen_evtchn_max_pirq;
     char *device;
+    OnOffAuto honor_guest_pat;
 };
 
 void kvm_memory_listener_register(KVMState *s, KVMMemoryListener *kml,
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index a1f910e9dff..ebd721c3d66 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -4277,6 +4277,7 @@ static void kvm_accel_instance_init(Object *obj)
     s->xen_evtchn_max_pirq = 256;
     s->device = NULL;
     s->msr_energy.enable = false;
+    s->honor_guest_pat = ON_OFF_AUTO_OFF;
 }
 
 /**
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 7cfbc7832de..27b1b848d6a 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3595,8 +3595,30 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     if (first) {
         kvm_vmfd_add_change_notifier(&kvm_vmfd_change_notifier);
     }
-    first = false;
 
+    /*
+     * Most x86 CPUs in current use have self-snoop, so honoring guest PAT is
+     * preferable.  As well, the bochs video driver bug which motivated making
+     * this a default-enabled quirk in KVM was fixed long ago.
+     */
+    if (s->honor_guest_pat != ON_OFF_AUTO_OFF) {
+        ret = kvm_check_extension(s, KVM_CAP_DISABLE_QUIRKS2);
+        if (ret & KVM_X86_QUIRK_IGNORE_GUEST_PAT) {
+            ret = kvm_vm_enable_cap(s, KVM_CAP_DISABLE_QUIRKS2, 0,
+                                    KVM_X86_QUIRK_IGNORE_GUEST_PAT);
+            if (ret < 0) {
+                error_report("failed to disable KVM_X86_QUIRK_IGNORE_GUEST_PAT");
+                return ret;
+            }
+        } else {
+            if (s->honor_guest_pat == ON_OFF_AUTO_ON) {
+                error_report("KVM does not support disabling ignore-guest-PAT quirk");
+                return -EINVAL;
+            }
+        }
+    }
+
+    first = false;
     return 0;
 }
 
@@ -7053,6 +7075,24 @@ static void kvm_arch_set_xen_evtchn_max_pirq(Object *obj, Visitor *v,
     s->xen_evtchn_max_pirq = value;
 }
 
+static int kvm_arch_get_honor_guest_pat(Object *obj, Error **errp)
+{
+    KVMState *s = KVM_STATE(obj);
+    return s->honor_guest_pat;
+}
+
+static void kvm_arch_set_honor_guest_pat(Object *obj, int value, Error **errp)
+{
+    KVMState *s = KVM_STATE(obj);
+
+    if (s->fd != -1) {
+        error_setg(errp, "Cannot set properties after the accelerator has been initialized");
+        return;
+    }
+
+    s->honor_guest_pat = value;
+}
+
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
     object_class_property_add_enum(oc, "notify-vmexit", "NotifyVMexitOption",
@@ -7092,6 +7132,14 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
                               NULL, NULL);
     object_class_property_set_description(oc, "xen-evtchn-max-pirq",
                                           "Maximum number of Xen PIRQs");
+
+    object_class_property_add_enum(oc, "honor-guest-pat", "OnOffAuto",
+                                   &OnOffAuto_lookup,
+                                   kvm_arch_get_honor_guest_pat,
+                                   kvm_arch_set_honor_guest_pat);
+    object_class_property_set_description(oc, "honor-guest-pat",
+                                          "Disable KVM quirk that ignores guest PAT "
+                                          "memory type settings (default: auto)");
 }
 
 void kvm_set_max_apic_id(uint32_t max_apic_id)
-- 
2.53.0


