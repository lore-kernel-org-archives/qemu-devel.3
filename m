Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5BBBD25937
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 05:19:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkbSl-0008B1-FN; Tue, 27 Jan 2026 00:18:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbSf-0007jS-RI
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:17:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbSe-0000Ea-B4
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:17:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769491075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lc7U1GbS1JHxjc6G1Vv9nRCpYH775c/aB7pSkgG/wFs=;
 b=OBdsiD2dgxJ2fSI7pct5bGF79ZKLhUmZB1RAJhbkoaOwFeTT6Avv8GUjdbgywa34WQRSqZ
 I0cbwRyB/+30/3ClEj2tc+cMXMrCoY6IvXWGd9Tg8SQi8YjsqA/0q00rYC/L3wl9ftDa8c
 STzD8BOT7BKb6T4cgB7Bfbe8k8lvAMk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-x9q18ft6Md2afHkON6kzHQ-1; Tue, 27 Jan 2026 00:17:54 -0500
X-MC-Unique: x9q18ft6Md2afHkON6kzHQ-1
X-Mimecast-MFC-AGG-ID: x9q18ft6Md2afHkON6kzHQ_1769491073
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-34c704d5d15so9695569a91.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 21:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769491073; x=1770095873; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lc7U1GbS1JHxjc6G1Vv9nRCpYH775c/aB7pSkgG/wFs=;
 b=nQ37MzL66njkc4JO6PEyndBuA/9tfuQoVyMTVQZDXSJ65PfnzHXOSxEhbeCjt2a3Qs
 4qAoZlhfOzVcvJoVxS4gS8RRZsudoTDoviF/5jat9SqVBx8q6qKtUGj+BspTeMTRfvfj
 aiwg/Z2FtpMp1h2V1VH8t3PVVnmXKZJ2H3x89AMpSaS7T/bbZzs8iq/y6UlR5jup+MP4
 vCiO/TlaUTlw4NzuGktr+esbiA8sfYc3imk/GCqHPJMANsdAB3nlhGrnIkXYb8sPosEu
 t3Hfo2i8wv5ZjgA0S9RGZSpFfctxyOlMV2DfHLfcf7g0hT9Vu8ek6wJyQ3bovBWNf7PC
 UxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769491073; x=1770095873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Lc7U1GbS1JHxjc6G1Vv9nRCpYH775c/aB7pSkgG/wFs=;
 b=YsjisGFCp3IuYdHtNG0qLWBjLsParEH39tRhvQcM2vjLiFW2YqybGADvNtziKXvA18
 649tuC9V/h6MBUD7rI5eHh0xTcvk0TFPoepB9YYhO7W5SLyMY5S4DGYhRJT7Pn2IxPfu
 d/D5DsVqGQWItFarhF8sbOWoihFQCinoesAU++2ETqQtvLVzBnqK46OideMj0Aq5d1sY
 /UippwDKCqMkWyKzkyCb91Y8M47824qGcnyr/MSnD55fWcWvIpqBRRuWxiBGKCXOd7nA
 polmCSUB8Unh4+ll0wuW+etAvpcByU4Q9cXgHigS+Qdc3UpFTL8k9LstX48Ny33GzYCn
 Kt1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMfa/EQw4w7Df49fq8ieTh3ZhG5g2PZaKjvZFlNfPkUq43WfeBIi33iW98b6FGnppAuQqt/3DnidWd@nongnu.org
X-Gm-Message-State: AOJu0YyMf+UQw6e1vAPox24zwOVrkGLRNKFvLTBSLb3Q61jziLsht6a9
 nl4yTej6/BIDySFLThwyBo7lO+p1uT3KMxWIulGTSFkTjRP/ktuyB0ygwR4oaVQSVanaEx45c/c
 oAhVLQj+OQxDR9kmYhB6sSlZ50xq8xVZh+6kljb1pQQJqZwpljg0gEYv8
X-Gm-Gg: AZuq6aLJocv+WsJXxoxgfRuOvCF4V+wp7CO/JsrQz+9TtwqzgSA9ConUOq95EsDLI0E
 mPI4KIncTm/Wemg1Sa2KdDVaJJuc9esawLhM4xURiP56bUhkf9xe+UV4G7vA21CJRokR/pt6L5G
 fKAOZqE5ahgOLGq6Ro5/oYxGOJ7rApWV3oAoTE+884DIp9No0KSzSlzDZEQDGexDeEOr/jcL3Cz
 /Pm7I6AePyZ1fhMr8gIn0792fqqNH0U6Q5XPapzxSQCG/AE8M7cSuyT9jzvnZfKdz+M9XnnHjq5
 3h8yJHdcQN2sm1OTYbH31dN/4aSVSu1vReUKH+vbaLymLpeUmzTVXXuHieV07MOhD+JnMTOBRm3
 o5/jFduldWVxg4pQKHyG2xYK5VpGy04CEa0WLY5hHQQ==
X-Received: by 2002:a17:90b:1a86:b0:340:776d:f4ca with SMTP id
 98e67ed59e1d1-353fed9c9f9mr708731a91.26.1769491072932; 
 Mon, 26 Jan 2026 21:17:52 -0800 (PST)
X-Received: by 2002:a17:90b:1a86:b0:340:776d:f4ca with SMTP id
 98e67ed59e1d1-353fed9c9f9mr708718a91.26.1769491072587; 
 Mon, 26 Jan 2026 21:17:52 -0800 (PST)
Received: from rhel9-box.lan ([122.163.48.79])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-353f6230d5dsm1110925a91.17.2026.01.26.21.17.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 21:17:52 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v3 26/33] kvm/xen-emu: re-initialize capabilities during
 confidential guest reset
Date: Tue, 27 Jan 2026 10:45:54 +0530
Message-ID: <20260127051612.219475-27-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260127051612.219475-1-anisinha@redhat.com>
References: <20260127051612.219475-1-anisinha@redhat.com>
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

On confidential guests KVM virtual machine file descriptor changes as a
part of the guest reset process. Xen capabilities needs to be re-initialized in
KVM against the new file descriptor.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/xen-emu.c | 50 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm/xen-emu.c b/target/i386/kvm/xen-emu.c
index 52de019834..69527145eb 100644
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
@@ -54,6 +57,30 @@ static int vcpuop_stop_singleshot_timer(CPUState *cs);
 #define hypercall_compat32(longmode) (false)
 #endif
 
+static int xen_handle_vmfd_change(NotifierWithReturn *n,
+                                  void *data, Error** errp)
+{
+    int ret;
+
+    /* we are not interested in pre vmfd change notification */
+    if (((VmfdChangeNotifier *)data)->pre) {
+        return 0;
+    }
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
@@ -111,15 +138,16 @@ static inline int kvm_copy_to_gva(CPUState *cs, uint64_t gva, void *buf,
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
@@ -143,6 +171,21 @@ int kvm_xen_init(KVMState *s, uint32_t hypercall_msr)
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
@@ -185,6 +228,9 @@ int kvm_xen_init(KVMState *s, uint32_t hypercall_msr)
     xen_primary_console_reset();
     xen_xenstore_reset();
 
+    xen_vmfd_change_notifier.notify = xen_handle_vmfd_change;
+    kvm_vmfd_add_change_notifier(&xen_vmfd_change_notifier);
+
     return 0;
 }
 
-- 
2.42.0


