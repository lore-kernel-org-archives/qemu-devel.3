Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 227CFC54731
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 15:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sixqN-0004mg-Bq; Tue, 27 Aug 2024 11:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sixqL-0004dJ-Hp
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 11:10:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sixqG-0000WW-3o
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 11:10:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724771443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M4c8TB2xHXASJ1uR1do61nTZjlIA4R+OAlBc+Ffu1q0=;
 b=Af6xSWlA2JPu7Ie/vNgwU5P6fXx+uS8zKiiotqvisEUf9H6XjsxMV0gSMRQ8/9YIFUjOjC
 NaRirGpAzwI0gPJa7lo11asXmgmBEVni/OFm9Toso274anmzOU2SFClDpX3ij8NcaCR9zm
 w5IktSriwXgxjVlq2WDO7GrpVq2mJMg=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-KgUyrTdONz62Mi__feg9KA-1; Tue, 27 Aug 2024 11:10:41 -0400
X-MC-Unique: KgUyrTdONz62Mi__feg9KA-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-71431f47164so5781626b3a.1
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 08:10:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724771440; x=1725376240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M4c8TB2xHXASJ1uR1do61nTZjlIA4R+OAlBc+Ffu1q0=;
 b=nzX3BXBtQEhs51IMEwugaM9yxavBhvlA9ghtxpqCRnRYIB6E8BY1Dm1E0Z4rjhNzEE
 Vo2k9Vjg13QFfVg84j1dLUi0t0ae3LKRrwmCjCJOdpaP/fEujWuRFvD98O7bfw+xhklm
 PZ2JDPVIhNAS/f9cbE2iwioF6I8/hgzDu63kY/VXWE3wguoWlYV6CpexL55KLGEUi2cz
 SkwWiJw+IujIG9nXUIC7S6yToVqoO7ecdKpurZaA31pnOtH56HT67H1+W0UB/I3D1cMj
 j7UnwhGKUyLqJruCc617s0hK2IFcqE43NwU0GfBpa/j/Md5RPlQJFoXzwfHJoBVx0mzq
 lVrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFd6AGq+XjSJJIvddCK4cYWimQxa4K5DnyYvVq8y6QwpoXd1jYQ964MOAQCl47CC/M41Vrj6WSf8lQ@nongnu.org
X-Gm-Message-State: AOJu0YxjjiqbekoZgEUpXIz0fm+pQMKd/SJPRHCJ56NDeGrlczchOOeI
 NtcsxKDtEEec2tTzA70ZYXWCJ42nmcV3/ury+AqRRAWlkT9mj3IPhIa5ily2VgIUcwX2G6J5XBa
 wF3m56HZoqFZskCIFPebPrKj1lFjDcUYoY/I+XzpQBK2c2qZkMyhU
X-Received: by 2002:a05:6a00:1805:b0:714:3325:d8e9 with SMTP id
 d2e1a72fcca58-71445e1153fmr16802146b3a.22.1724771440582; 
 Tue, 27 Aug 2024 08:10:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUEAqtApzRiyNS0JKuFBiyF3z3Asq7TBCcUFBE8fW8JjKPSqwZF7934+py5nk9lIIjydb91g==
X-Received: by 2002:a05:6a00:1805:b0:714:3325:d8e9 with SMTP id
 d2e1a72fcca58-71445e1153fmr16802090b3a.22.1724771439974; 
 Tue, 27 Aug 2024 08:10:39 -0700 (PDT)
Received: from localhost.localdomain ([115.96.30.188])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-7143430636esm8679062b3a.165.2024.08.27.08.10.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 08:10:39 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, zhao1.liu@intel.com, cfontana@suse.de,
 armbru@redhat.com, qemu-trivial@nongnu.org, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v4 2/2] kvm: refactor core virtual machine creation into its
 own function
Date: Tue, 27 Aug 2024 20:40:22 +0530
Message-ID: <20240827151022.37992-3-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240827151022.37992-1-anisinha@redhat.com>
References: <20240827151022.37992-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Refactoring the core logic around KVM_CREATE_VM into its own separate function
so that it can be called from other functions in subsequent patches. There is
no functional change in this patch.

CC: pbonzini@redhat.com
CC: zhao1.liu@intel.com
CC: cfontana@suse.de
CC: armbru@redhat.com
CC: qemu-trivial@nongnu.org
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Claudio Fontana <cfontana@suse.de>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 accel/kvm/kvm-all.c | 86 ++++++++++++++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 33 deletions(-)

changelog:
v2: s/fprintf/warn_report as suggested by zhao
v3: s/warn_report/error_report. function names adjusted to conform to
other names. fprintf -> error_report() moved to its own patch.
v4: added tags and rebased.

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index d9f477bb06..391279c995 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2385,6 +2385,57 @@ uint32_t kvm_dirty_ring_size(void)
     return kvm_state->kvm_dirty_ring_size;
 }
 
+static int kvm_create_vm(MachineState *ms, KVMState *s, int type)
+{
+    int ret;
+
+    do {
+        ret = kvm_ioctl(s, KVM_CREATE_VM, type);
+    } while (ret == -EINTR);
+
+    if (ret < 0) {
+        error_report("ioctl(KVM_CREATE_VM) failed: %d %s", -ret,
+                    strerror(-ret));
+
+#ifdef TARGET_S390X
+        if (ret == -EINVAL) {
+            error_printf("Host kernel setup problem detected. Please verify:");
+            error_printf("\n- for kernels supporting the"
+                        " switch_amode or user_mode parameters, whether");
+            error_printf(" user space is running in primary address space\n");
+            error_printf("- for kernels supporting the vm.allocate_pgste "
+                         "sysctl, whether it is enabled\n");
+        }
+#elif defined(TARGET_PPC)
+        if (ret == -EINVAL) {
+            error_printf("PPC KVM module is not loaded. Try modprobe kvm_%s.\n",
+                         (type == 2) ? "pr" : "hv");
+        }
+#endif
+    }
+
+    return ret;
+}
+
+static int kvm_machine_type(MachineState *ms)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    int type;
+
+    if (object_property_find(OBJECT(current_machine), "kvm-type")) {
+        g_autofree char *kvm_type;
+        kvm_type = object_property_get_str(OBJECT(current_machine),
+                                           "kvm-type",
+                                           &error_abort);
+        type = mc->kvm_type(ms, kvm_type);
+    } else if (mc->kvm_type) {
+        type = mc->kvm_type(ms, NULL);
+    } else {
+        type = kvm_arch_get_default_type(ms);
+    }
+    return type;
+}
+
 static int kvm_init(MachineState *ms)
 {
     MachineClass *mc = MACHINE_GET_CLASS(ms);
@@ -2467,45 +2518,14 @@ static int kvm_init(MachineState *ms)
     }
     s->as = g_new0(struct KVMAs, s->nr_as);
 
-    if (object_property_find(OBJECT(current_machine), "kvm-type")) {
-        g_autofree char *kvm_type = object_property_get_str(OBJECT(current_machine),
-                                                            "kvm-type",
-                                                            &error_abort);
-        type = mc->kvm_type(ms, kvm_type);
-    } else if (mc->kvm_type) {
-        type = mc->kvm_type(ms, NULL);
-    } else {
-        type = kvm_arch_get_default_type(ms);
-    }
-
+    type = kvm_machine_type(ms);
     if (type < 0) {
         ret = -EINVAL;
         goto err;
     }
 
-    do {
-        ret = kvm_ioctl(s, KVM_CREATE_VM, type);
-    } while (ret == -EINTR);
-
+    ret = kvm_create_vm(ms, s, type);
     if (ret < 0) {
-        error_report("ioctl(KVM_CREATE_VM) failed: %d %s", -ret,
-                    strerror(-ret));
-
-#ifdef TARGET_S390X
-        if (ret == -EINVAL) {
-            error_printf("Host kernel setup problem detected. Please verify:");
-            error_printf("\n- for kernels supporting the"
-                        " switch_amode or user_mode parameters, whether");
-            error_printf(" user space is running in primary address space\n");
-            error_printf("- for kernels supporting the vm.allocate_pgste "
-                         "sysctl, whether it is enabled\n");
-        }
-#elif defined(TARGET_PPC)
-        if (ret == -EINVAL) {
-            error_printf("PPC KVM module is not loaded. Try modprobe kvm_%s.\n",
-                        (type == 2) ? "pr" : "hv");
-        }
-#endif
         goto err;
     }
 
-- 
2.42.0


