Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D24D49232
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 15:08:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU4iH-0003n7-QD; Fri, 12 Dec 2025 10:05:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4iG-0003ez-7c
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:05:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4iE-00068z-Mp
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:05:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765551941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JNcrE+4f8j63y44F5BmyHdkxQ8nR4MpXkUljLFk9KRg=;
 b=ajLE07+hUSArgnS93hzslKJy+Et9w8Lpe4f3vZHl0HrLIeS8VCawYIm4T0GMf1pOWpdn8s
 tm1IafEKoyxYPXuK3WfrNdIZXelpYeZmDtn9AmoE3+JMbTuQWMrDwJP34iq3D7hky8rBqo
 5tcQ5CBbznvHih1pQEKGWoovgpnCA28=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-kxWmUttcMzOOViwDgeUrGw-1; Fri, 12 Dec 2025 10:05:39 -0500
X-MC-Unique: kxWmUttcMzOOViwDgeUrGw-1
X-Mimecast-MFC-AGG-ID: kxWmUttcMzOOViwDgeUrGw_1765551938
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-34aa6655510so1714185a91.1
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 07:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765551938; x=1766156738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JNcrE+4f8j63y44F5BmyHdkxQ8nR4MpXkUljLFk9KRg=;
 b=gcV6K5b8vTpZgDcMvXoOEaeBre19sfCaD42ahTBMivwV0aT13gx9UOHSWRxaCuskk2
 1ygAOBgp0NNwQXUNuYqZEc6SJyfneoOSIAHvrIW1vkXzIlPP6620H9E0/7a6miJgSw57
 ko/muw06DHM1sQH9uIBa5A1uifvM3v8DO2d8ZDWecuWms/0m4SqUptFt/vx5aBtgNFrt
 jQeiVSBLLDcVVmhP9vVIhRJlsFt6DElp6T/bEzS4vLkkAwVjEG22l2H2T0oXHtdSmUTL
 6+WD1/2luBfn6AKhGNC6hBEo8b5i+el8vh1x/E7QHtMPGoRfjD2qJcYT2c279l8ywXaP
 UE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765551938; x=1766156738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JNcrE+4f8j63y44F5BmyHdkxQ8nR4MpXkUljLFk9KRg=;
 b=WX6ASXSE6XoG9fEo6Rw1YdMueF1uCqmuwNDSm3+jDfTYGexleB2MkeEiD5+wk4fkXL
 jTwTBEj27ZAzSn8603vF4pr0ETPhaJb/tztb5F8sX93EOmwAerFL5Umq+zGumL1ZVBNc
 CrL4qBkcvbRgX/WZGi2hAqHUY0iLEf/gt9M0CazAzJIYK782tC+oCXqlKOvC2RUAwhnx
 I+t4KVxkWy24ARvJjp9PaBrrd95MGvXlB63FWY20XWzHvL+S4j1QNzoNSHc/N2Qh6186
 3Hcm8p/NANVdYxC9zvCDrh2a2I62cqOHTOnc3JLtMKgsHP2L1wDVkGrKr1iK6RRRxBgH
 YWMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUllZAotnYp8FnKk24nQ07CIWlw+yVLxdcg0U5QJxLcEyjnw02GhV2PuuB/nmib/U7hg6y0NjwQAmCs@nongnu.org
X-Gm-Message-State: AOJu0YwdyUIQdaB8fKMpjTvJ67eBieEIFoqNA1csTTcvP5taLbSMhcwh
 fZIt4emj9gPoAw2gcYFEQ7bvjIsd4kHotdm5GaNmNSYIjpN6CzepM2fVYwNL0G6JJN5RCarE5CD
 lC0ZciwyqOJoAwcR62POp6wnanQ0UgoohplimAPqmKppJrl/8BIWuZE9k
X-Gm-Gg: AY/fxX7a2qPmXhqz1xXoaaq0c+r9/Ki/ZkuYAnMK3Bv8YGIQxHT82bPPYSMTup2sS3D
 ZJ76tfoExTQtLcgQTXHxMSCYu5F1JPHBe8aB0zEsW4mhne2YnO/oT6o6BSeCx1MHyH4POV9x+z9
 iiLOj+6TNDaYHXbmbjyWeDeHoVVpdEuLIF2oZ7H2TIHW0xzt6zpYSsIFb3s0jz5QgI4N1FzoStO
 v/4u0Zjh7ugKNPfDBu4LiO7yU9Q6VU35V9f7CRQ9sm/pMUJZ7L15IDJGRPdRzdiVXrh063MdF0a
 HO2xcrXu2RMrlp/KbEtD501jl1lvEQeh/1mG3cOQt4QUtmMsgF2GcmM+lPmbY6h6wy+7czPrprr
 etEwvFm1oXhMoz/q9kWPQRiZ1lCpsQUzx8KfQYxlWsm4=
X-Received: by 2002:a17:903:2cd:b0:269:82a5:f9e9 with SMTP id
 d9443c01a7336-29f2404b62emr22001815ad.29.1765551938076; 
 Fri, 12 Dec 2025 07:05:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnq9WRvTLwHHfQ5V/fKnINCsQGztH87yOnmYhTJLhbvtEkf/NeEcL0ENt723AVANrzo/wAIQ==
X-Received: by 2002:a17:903:2cd:b0:269:82a5:f9e9 with SMTP id
 d9443c01a7336-29f2404b62emr22001405ad.29.1765551937580; 
 Fri, 12 Dec 2025 07:05:37 -0800 (PST)
Received: from rhel9-box.lan ([122.172.173.62])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-29ee9d38ad1sm57046655ad.29.2025.12.12.07.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 07:05:37 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: vkuznets@redhat.com, kraxel@redhat.com, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH v1 23/28] kvm/xen-emu: re-initialize capabilities during
 confidential guest reset
Date: Fri, 12 Dec 2025 20:33:51 +0530
Message-ID: <20251212150359.548787-24-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20251212150359.548787-1-anisinha@redhat.com>
References: <20251212150359.548787-1-anisinha@redhat.com>
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

On confidential guests KVM virtual machine file descriptor changes as a
part of the guest reset process. Xen capabilities needs to be re-initialized in
KVM against the new file descriptor.

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


