Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44C9FD5301
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 07:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvs7r-0003af-IP; Fri, 27 Feb 2026 02:19:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vvs7p-0003Zv-BF
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 02:19:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vvs7n-0003AV-Fy
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 02:19:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772176737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3UgH+JOnN2M8WHuMSMR4uqDP2YjLtYKqK18FCdha8ns=;
 b=BBaEdxIPfHsKe9Q1EOwNbazHQIfD5dLyrimtzoA96U3Z5jp14aV16v776qR0Dlkoee14GM
 xo+LdZqjwZT8yP6pvg8zljn6HxHEzqVgz2wLggu364JmbV/5umbgXJl4q8rpKFicbxZpKd
 C9fsHtEe8a7OTtkERDKZF/ed0GQmaw0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-Xv41ExysPzG3hP7PlJ7Cuw-1; Fri, 27 Feb 2026 02:18:55 -0500
X-MC-Unique: Xv41ExysPzG3hP7PlJ7Cuw-1
X-Mimecast-MFC-AGG-ID: Xv41ExysPzG3hP7PlJ7Cuw_1772176734
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43992a50893so1209309f8f.3
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 23:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772176734; x=1772781534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3UgH+JOnN2M8WHuMSMR4uqDP2YjLtYKqK18FCdha8ns=;
 b=m/BqpagOFNHbICWJqNPhIjS208GAoJR0xygZJ85z2SVSEwPrbtPlOU8jvxTwpegQpk
 zIfKoKiWpbvlLhi4UqlMsGzp9IOwtJJCqW3PXqSJUHXtjI82YR92SIjIHF8wR1+8SigM
 yMwGlvMFMFBcuhvOpWmtGRezN1o/Wjme+X/ilivPxDIZ3bRMcXTSoyw5uJMaSN/CrHs+
 gcePWZKeNbL2H3H/jG5XjtNyRau3L/6yX+LRHdkAQZ02Pg9eDudHqVIl0pKwim1c55rJ
 eBcaIrZi73xJQZog3lNKH34bA1o53mNq0OGegceC2uND5XFAaG8Lew7JqekGcK8b8Whb
 KyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772176734; x=1772781534;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3UgH+JOnN2M8WHuMSMR4uqDP2YjLtYKqK18FCdha8ns=;
 b=wZgEeFZOVqXqvvjOBBoE+oTqHCvXx26qPidvhRNmW4wTODOWrAgqc+Ai6M3qoVRjuk
 Ip/dS5SJnZt1YtSRQk8cShW16GrMSTHy/6KdQ8mWyYjfOiBb3NQrvUSt8ITnvXpXHZYf
 Uwm15rkQlgACs7W+dy3O0xUicnX1/ZuiLQfXknW+D9NkJFx/osEu8yO0ivPGfol+LHXf
 raOdfGRgC3Z6mmaF3h2tHxNhvWPwLOsmh4jvJD86DhczPtznaAIRyo9c29wl28BHxt1L
 vLJ0C0bSrPtwfufPhXnh4xxnfCrtK8VBVK43dId52bzlwrv/YpdrfSAvGIGcAnHKWoog
 DEzw==
X-Gm-Message-State: AOJu0YwpD5DEp/RIw8sYgSQjbaOIVUPEP2pCyngitGSRnlJIu33aWH/e
 g9fZwR3WMMXVrw3ZSBZGxlpkgsJCk2Mr3wQDYLxDk6AkXytOMdL1FmJC2lAMM6DTNYCrU3/fK6c
 2qhW8yUwd+LXPGfmNg8dHvjQvyZPKTe9blEa5F+RhDw4XLrvinPmZavnXf5Xe+BjFoCaZKVY/IX
 ivLiwIOzdiI5OxH8yAqUusLnduouWuO+SuzlxneKgS
X-Gm-Gg: ATEYQzyNT6SyFp6mA8UqyM2KjBO7xCR+C9s+0GFBQte1hfAghK5ErnUjSPROCKkDbdh
 ZoL5X1/Xx/n20J2Pc0nk4kNlcEKTtsbsjxgqDG95xqgLozbqQ6O65xiX2a4aXu+3lsupqN+zKbl
 7Eq0sYHmWs+cyLsLT0jogaQIpBNEQH+9u10+0MLrWVEQXPP14O7T8CvSpQTRhlz5bcQO05cq4K1
 SZsqntRG9lneM7WLn4B2+aWi3NdOWRvniTczc6PLLbh6FVD68KbwkbS0aftWxb0zQqjn7M34Ltp
 xc768GayrBwDA77tA1eQHZB3Gy8Z5zD7a2lQ3Z5v5u5/if4r+Hefzmu1hZ4Yra8tNxV7qOKxavF
 qNERE8Mf3AAR+E/WGw0ztf6HmSoPIwaMlR9ijWsBexWfV/1chLPvVhKXuULpmNfCEwr/vB8s6qt
 RrKvocjaqUFxuQvwVmIav0RWdeRO0=
X-Received: by 2002:a05:6000:26c7:b0:439:8bee:b985 with SMTP id
 ffacd0b85a97d-4399de3dd78mr2547249f8f.54.1772176733785; 
 Thu, 26 Feb 2026 23:18:53 -0800 (PST)
X-Received: by 2002:a05:6000:26c7:b0:439:8bee:b985 with SMTP id
 ffacd0b85a97d-4399de3dd78mr2547198f8f.54.1772176733197; 
 Thu, 26 Feb 2026 23:18:53 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c70f8casm8586321f8f.14.2026.02.26.23.18.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 23:18:52 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: myrslint <qemu.haziness801@passinbox.com>
Subject: [PATCH] KVM: i386: Default disable ignore guest PAT quirk
Date: Fri, 27 Feb 2026 08:18:52 +0100
Message-ID: <20260227071852.86283-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
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


