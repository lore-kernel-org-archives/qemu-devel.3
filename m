Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CECBCD58E7A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyxd-0003Ry-Da; Mon, 02 Mar 2026 03:49:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwywZ-0002y2-JC
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwywX-0002Ay-Un
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:47:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I7MpTZ6n0X6clHs3ciAfl46T8TcqxbVY4rtmYAJd8zU=;
 b=jF86Y/xbO+Zeg8U7hTo/TuUi1YkXmxgc8kE0hONdOx393A0+KFB1RcEv1bl5yI53JAVpvV
 zAMNXDB0571zhQrmpzZV4/7q4r1pz+Bse61gQl65t0jAOO+9tY8DuJGz4F6bJ81kQXwwml
 vWbKvI+W/1A2mKiySbLUhF49Q7Oa3y0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-cbARj2anMoicMvLG2q6NLQ-1; Mon, 02 Mar 2026 03:47:56 -0500
X-MC-Unique: cbARj2anMoicMvLG2q6NLQ-1
X-Mimecast-MFC-AGG-ID: cbARj2anMoicMvLG2q6NLQ_1772441275
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-483a2db68caso34677715e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441274; x=1773046074; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I7MpTZ6n0X6clHs3ciAfl46T8TcqxbVY4rtmYAJd8zU=;
 b=qVhRbI08ir+/BM3Qnj25MePyWBhPiZRCof0nKMHI0BQSfM02sPOxfNQ/FhKm8AuuGq
 6vwrNTB3SenPKEDw1j8aCgib1ugRj9SUyX60a9rTO5uxreFJ9wLt6SfTSCsKyq3x0Znx
 SPZakCP46Hu17dqDdhiCBC6nhyYtpHnf2x9gzncc9ygjT4O7Xqlk03MUhlxCET5S/DiG
 Sje3y3tVDkZ/P3OeW2AsmQq3dTJ715vXS3wUpZYtxPeheKfmR2sK+tygpVjJIW7KerDc
 JWhsPPI15gexmgTUtSUX68x13tn6UjKau6B90Zc8ImZJbca7YMnQX2r5ngdp7wxyFHYe
 26zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441274; x=1773046074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I7MpTZ6n0X6clHs3ciAfl46T8TcqxbVY4rtmYAJd8zU=;
 b=MMoC67Frq/ZVqY8fXo47bWDhZLF/zx7Ae8RqJcbKWh04foRZ5HYRA93MOKT/5TI0us
 +PxBAFXPF3Vbh9Q+z4X4yO2ZnSmfdngW7PAUIoxAnrlIA72C72EIIaburDI96Kmo++HE
 X+07A8Dyhb0UgUVQxdIQcGpG9b90C0nTCuvAaXpqBy0PD6eNSj4FlKz9bnpgsF6upbUz
 dzEAo5rrfGavz8y2LyKQaXkFa4f0xHIraG89TaBpziRxR6Rn+qjYBJRU2rzPlR9tkfBy
 TsSLTYyRJEVZZR9g4oW10iWnNJrc0059Ajnib2ekpCUuva2ZLaCsCJkRzLigDNHx1tBS
 nSzQ==
X-Gm-Message-State: AOJu0Yx5b8I9VEmHg3wp0Q/Pd2YRLvZY3Q1fw+raNwNkHIxwI5Yf4LmQ
 9NPv5tlCa3cvLbnVSU9lDlx9Z+GBHB/2wLCaMwR98dX/MV6Ul44wlll0mDEmI1vmoN5SNgSOvbB
 642AOdCSq/Zgvtav4A1baQFzGCVArMBFZiSf751PfyfPrL4oOwy6Wbb/bYHnEOMau2/vzZg6GTN
 C4QKMM8rHXU0Qo5SpfYQdiRAjZKD0FcbglQ5Et38pG
X-Gm-Gg: ATEYQzwYcD2U5DkIvQ6vgJjQn+VBAZzagOyln7A2HEbSz3X/UcArHVxKarlwCpQmYXC
 WODsBgoVKb7P0ji0Kgv4ZE13lI9xYrUbUaMCgwQDADW6nnOuz7lgn2jvbCPaX2p7Ba251HL6vk6
 b7cT3R/3boFGwpsitaWEFI8TOZlJSun4htguAeGwD9c069u0PlHPfdojBqNKkylkXBKOc0x9PKz
 MMiV9jYb2tgCV4ktHj8UJdU7eovr1WhX/x3+Akxj85McmWv1q866qkP3/Wz2IMnfe2P3MJ+DwXx
 5D79G7W0cnd0ZKoMT+O/t/QQv8tE85aO+T7erFbueHrWYiJT0BW/V4ljcV4H1pkWDguN9mjyWSM
 fonHrOBA4KVT0FDNYHiLEmxpEaC+RKrHtHsn+MxPxQxwTvRJ83ptMfU4R9MOVHXLI8Rh5ZVOHwt
 UMgLHPBvnt47TuOuMffJI7jEPkb70=
X-Received: by 2002:a05:600c:3106:b0:483:6a8d:b2f9 with SMTP id
 5b1f17b1804b1-483c9ba6165mr211725685e9.5.1772441274350; 
 Mon, 02 Mar 2026 00:47:54 -0800 (PST)
X-Received: by 2002:a05:600c:3106:b0:483:6a8d:b2f9 with SMTP id
 5b1f17b1804b1-483c9ba6165mr211725215e9.5.1772441273866; 
 Mon, 02 Mar 2026 00:47:53 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b34b6252sm9807533f8f.10.2026.03.02.00.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:47:53 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>
Subject: [PULL 069/102] kvm/xen-emu: re-initialize capabilities during
 confidential guest reset
Date: Mon,  2 Mar 2026 09:47:15 +0100
Message-ID: <20260302084749.474955-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

From: Ani Sinha <anisinha@redhat.com>

On confidential guests KVM virtual machine file descriptor changes as a
part of the guest reset process. Xen capabilities needs to be re-initialized in
KVM against the new file descriptor.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20260225035000.385950-29-anisinha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/xen-emu.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/target/i386/kvm/xen-emu.c b/target/i386/kvm/xen-emu.c
index 52de0198343..29364a92797 100644
--- a/target/i386/kvm/xen-emu.c
+++ b/target/i386/kvm/xen-emu.c
@@ -44,9 +44,12 @@
 
 #include "xen-compat.h"
 
+NotifierWithReturn xen_vmfd_change_notifier;
+static uint32_t xen_msr;
 static void xen_vcpu_singleshot_timer_event(void *opaque);
 static void xen_vcpu_periodic_timer_event(void *opaque);
 static int vcpuop_stop_singleshot_timer(CPUState *cs);
+static int do_initialize_xen_caps(KVMState *s, uint32_t hypercall_msr);
 
 #ifdef TARGET_X86_64
 #define hypercall_compat32(longmode) (!(longmode))
@@ -54,6 +57,23 @@ static int vcpuop_stop_singleshot_timer(CPUState *cs);
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
+    ret = do_initialize_xen_caps(kvm_state, xen_msr);
+    if (ret < 0) {
+        return ret;
+    }
+    return 0;
+}
+
 static bool kvm_gva_to_gpa(CPUState *cs, uint64_t gva, uint64_t *gpa,
                            size_t *len, bool is_write)
 {
@@ -111,7 +131,7 @@ static inline int kvm_copy_to_gva(CPUState *cs, uint64_t gva, void *buf,
     return kvm_gva_rw(cs, gva, buf, sz, true);
 }
 
-int kvm_xen_init(KVMState *s, uint32_t hypercall_msr)
+static int do_initialize_xen_caps(KVMState *s, uint32_t hypercall_msr)
 {
     const int required_caps = KVM_XEN_HVM_CONFIG_HYPERCALL_MSR |
         KVM_XEN_HVM_CONFIG_INTERCEPT_HCALL | KVM_XEN_HVM_CONFIG_SHARED_INFO;
@@ -143,6 +163,19 @@ int kvm_xen_init(KVMState *s, uint32_t hypercall_msr)
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
+    xen_msr = hypercall_msr;
 
     /* If called a second time, don't repeat the rest of the setup. */
     if (s->xen_caps) {
@@ -185,6 +218,9 @@ int kvm_xen_init(KVMState *s, uint32_t hypercall_msr)
     xen_primary_console_reset();
     xen_xenstore_reset();
 
+    xen_vmfd_change_notifier.notify = xen_handle_vmfd_change;
+    kvm_vmfd_add_change_notifier(&xen_vmfd_change_notifier);
+
     return 0;
 }
 
-- 
2.53.0


