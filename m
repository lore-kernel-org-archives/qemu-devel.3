Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9688AC9EC8B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHuw-0004vS-FR; Mon, 12 Jan 2026 08:25:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHuP-0004BM-D9
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHuM-0003s9-JE
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768224273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RpRJ5BfFh6w1tZPB1hD41jTrZGWAAbYwgmsxDiyQj2w=;
 b=FVaEK20SJ5yC+lKjpRmDum1PFAwSvD0/obYLtc6OmPF/63XhGYO2jna5AwcdLHbKtB0Cnh
 N7iX7FaSzBcNhCp9QMWtUEpORKHmjOz20Ip8Y4n7mDxjYj/O1FNV83fwiYpPhjfiNjvD1Y
 ulH9N++ZTMxNeZqbO6TCfIL/WFoLPXo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-PotVeBxQN2K-GOr-QqtDJw-1; Mon, 12 Jan 2026 08:24:32 -0500
X-MC-Unique: PotVeBxQN2K-GOr-QqtDJw-1
X-Mimecast-MFC-AGG-ID: PotVeBxQN2K-GOr-QqtDJw_1768224271
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-34c64cd48a8so7309918a91.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768224271; x=1768829071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RpRJ5BfFh6w1tZPB1hD41jTrZGWAAbYwgmsxDiyQj2w=;
 b=W+Obo0jv693YLSV7mWygKHk8n6ZFYG3pbKpwJ0i+vE8gdd+nRTLdE3sxyIBNtr0SuW
 /u5Tnp5und9TT4JV25NQ41lj/PHJvINa2qQUtLuu0iz26WPU9Ann6/mwVDfgLS7ElY46
 F+Y3DE5M1nkYfmPpWS1rbKIho/egJ12EAEPUDArYmV72N+U0D9GkD9QoRFdyMbaIrPEm
 +ew2T8TKlvJjVfFwaPX+iA5oE02C9YuB5j4kY4S9HF/CGdQZQ6VBqTSh4UJaFoKZje6R
 awXFtMfPnzNedqbULsY6HjcVaPoPgQG6BYjLYS/yCYxWIMmeX58sS3iYzgnKcu3yjAls
 ZQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768224271; x=1768829071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RpRJ5BfFh6w1tZPB1hD41jTrZGWAAbYwgmsxDiyQj2w=;
 b=M8hm3i9xV5SMMpdBu0igIKnb5KnLdNa6TMYEheTrfWpddDzvONapRccnSkAx8yuoDS
 6TqpKBvWsrKE/y/CV+mkK/h+iJFH410ehTdlYNGPcn0wgWevDB4Z/U7wyWMNsn1opP7I
 zHV7iIZ0Lm96Ir7c5f7vCUW69iMdbpQZ+WTLyf/Yv7q/79YKakFcEARSO6caARUMx9PN
 BEujGcrbae3psnQdf4H/t+nT83JJegQMAyRuCNx8KtLj43PcTCB7WiH8nBJCGH0RtoQI
 8uv4hlpDouZVgGDhLUu9NYuQAnWP4UU6RN4jYBt3lhAVku3flxJMbxtxw2ag1ZSuWDYK
 ZmGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSEpH462U/ixfCg7JcMoiqQqTbAEEnZn+IJspom2ller53X2qRMBxzCxtKRnT3ARh73MlqIGx/AC0t@nongnu.org
X-Gm-Message-State: AOJu0YyLEK+KEp26Cvjgxh0EeSR0KusCt5BDpdQ6IVcdeuAlXD6hHr58
 ODGZQbQP/1myVSs/bRhnDeHg6UqE0PBHQWueIFY+QHlqLXEEdqhjuWEdcn4d6HL81lkZx5DL7z9
 StX2U6FwbM5KD4duizR4tfT2HUBIf0BDU850H39KYwBRIJWFukhEamJfh
X-Gm-Gg: AY/fxX4PNO0uRNQqPWqGKAv/OOjGmaTAGtkk6N0ckA+ERzqOTZBosj6VavdC5/Jyjt/
 EMjoC1t1y1KfnPKCEjHeb0umZd4niQzROzMKJTGmce5i7wUtq2FX2aOG849XANM1eJmC9HbG+E9
 TY6ekjbYrNsJjJ5gOEIhkKD2X1ORYNbhDBDqqCo7ku37kwH9pJ0+ZVte31BtTc2A32vMywVe3G3
 A9hoI/KKSzLMGdFPmLQf1PmAjXPWv6/ZxmPLQykNHfUIztqt1Y67vKQg9X+8TIf60mdZdVwgzVG
 O1HY/lm3u21OqERIQTEFcIy3425I84FRIZTXNE3MnZKjHcHNkgJeUhZCMVSw5ciEcF5cqVNLeZu
 tVAlUlrzl51p1nG64Pv7ScZ9uFr+Kiq7Q6z+/QOegFXc=
X-Received: by 2002:a17:90a:ec8b:b0:34a:4a8d:2e2e with SMTP id
 98e67ed59e1d1-34f68c912a3mr18358607a91.17.1768224271322; 
 Mon, 12 Jan 2026 05:24:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKfMO1nNe9YkfbS9kvxYn3RL7QyyACZ9YBAdaWIhk2qR1dryaLY76HSePS1Am5ohAQYe5qyw==
X-Received: by 2002:a17:90a:ec8b:b0:34a:4a8d:2e2e with SMTP id
 98e67ed59e1d1-34f68c912a3mr18358589a91.17.1768224270927; 
 Mon, 12 Jan 2026 05:24:30 -0800 (PST)
Received: from rhel9-box.lan ([110.227.88.119])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd87asm17544771a12.15.2026.01.12.05.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 05:24:30 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v2 25/32] kvm/xen-emu: re-initialize capabilities during
 confidential guest reset
Date: Mon, 12 Jan 2026 18:52:38 +0530
Message-ID: <20260112132259.76855-26-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260112132259.76855-1-anisinha@redhat.com>
References: <20260112132259.76855-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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

On confidential guests KVM virtual machine file descriptor changes as a
part of the guest reset process. Xen capabilities needs to be re-initialized in
KVM against the new file descriptor.

This patch is untested on confidential guests and exists only for completeness.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/xen-emu.c | 45 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm/xen-emu.c b/target/i386/kvm/xen-emu.c
index 52de019834..4f4cde7c58 100644
--- a/target/i386/kvm/xen-emu.c
+++ b/target/i386/kvm/xen-emu.c
@@ -44,9 +44,12 @@
 
 #include "xen-compat.h"
 
+NotifierWithReturn xen_vmfd_change_notifier;
+static bool hyperv_enabled;
 static void xen_vcpu_singleshot_timer_event(void *opaque);
 static void xen_vcpu_periodic_timer_event(void *opaque);
 static int vcpuop_stop_singleshot_timer(CPUState *cs);
+static int do_initialize_xen_caps(KVMState *s, uint32_t hypercall_msr);
 
 #ifdef TARGET_X86_64
 #define hypercall_compat32(longmode) (!(longmode))
@@ -54,6 +57,25 @@ static int vcpuop_stop_singleshot_timer(CPUState *cs);
 #define hypercall_compat32(longmode) (false)
 #endif
 
+static int xen_handle_vmfd_change(NotifierWithReturn *n,
+                                  void *data, Error** errp)
+{
+    int ret;
+
+    ret = do_initialize_xen_caps(kvm_state, XEN_HYPERCALL_MSR);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (hyperv_enabled) {
+        ret = do_initialize_xen_caps(kvm_state, XEN_HYPERCALL_MSR_HYPERV);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+    return 0;
+}
+
 static bool kvm_gva_to_gpa(CPUState *cs, uint64_t gva, uint64_t *gpa,
                            size_t *len, bool is_write)
 {
@@ -111,15 +133,16 @@ static inline int kvm_copy_to_gva(CPUState *cs, uint64_t gva, void *buf,
     return kvm_gva_rw(cs, gva, buf, sz, true);
 }
 
-int kvm_xen_init(KVMState *s, uint32_t hypercall_msr)
+static int do_initialize_xen_caps(KVMState *s, uint32_t hypercall_msr)
 {
+    int xen_caps, ret;
     const int required_caps = KVM_XEN_HVM_CONFIG_HYPERCALL_MSR |
         KVM_XEN_HVM_CONFIG_INTERCEPT_HCALL | KVM_XEN_HVM_CONFIG_SHARED_INFO;
+
     struct kvm_xen_hvm_config cfg = {
         .msr = hypercall_msr,
         .flags = KVM_XEN_HVM_CONFIG_INTERCEPT_HCALL,
     };
-    int xen_caps, ret;
 
     xen_caps = kvm_check_extension(s, KVM_CAP_XEN_HVM);
     if (required_caps & ~xen_caps) {
@@ -143,6 +166,21 @@ int kvm_xen_init(KVMState *s, uint32_t hypercall_msr)
                      strerror(-ret));
         return ret;
     }
+    return xen_caps;
+}
+
+int kvm_xen_init(KVMState *s, uint32_t hypercall_msr)
+{
+    int xen_caps;
+
+    xen_caps = do_initialize_xen_caps(s, hypercall_msr);
+    if (xen_caps < 0) {
+        return xen_caps;
+    }
+
+    if (!hyperv_enabled && (hypercall_msr == XEN_HYPERCALL_MSR_HYPERV)) {
+        hyperv_enabled = true;
+    }
 
     /* If called a second time, don't repeat the rest of the setup. */
     if (s->xen_caps) {
@@ -185,6 +223,9 @@ int kvm_xen_init(KVMState *s, uint32_t hypercall_msr)
     xen_primary_console_reset();
     xen_xenstore_reset();
 
+    xen_vmfd_change_notifier.notify = xen_handle_vmfd_change;
+    kvm_vmfd_add_change_notifier(&xen_vmfd_change_notifier);
+
     return 0;
 }
 
-- 
2.42.0


