Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10DE7C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5zC-0005j3-KZ; Thu, 20 Aug 2026 12:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5z5-0005Tx-Of
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5z3-0005ep-Ko
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h7zYr8kpZYKg21q1pd5cKDA8VPO1ZSHlqsrFeP9oTww=;
 b=HPQlGQ+C8a/ScQvkNZL9APFB4j5DEYkqyPmXJpaL+HfCzsDtF4Racvp8HxrrVxLX0ax3OT
 KUiVSsZuh3MgWJBFMAx9odTuVgzQE4G/0axfLG4VNp/a6rerKfGGoWDzroCqStO/dezgw6
 T+44ZMI71kAyC4vkkydvYZbtfvGTDVc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-xLQvaybqNJyAy4xd64IQGw-1; Thu, 20 Aug 2026 12:51:14 -0400
X-MC-Unique: xLQvaybqNJyAy4xd64IQGw-1
X-Mimecast-MFC-AGG-ID: xLQvaybqNJyAy4xd64IQGw_1787244673
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490a767b782so267875e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244673; x=1787849473; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h7zYr8kpZYKg21q1pd5cKDA8VPO1ZSHlqsrFeP9oTww=;
 b=TpCNlnZZ3zaL8Vn2mn0ThrgMuAqbJrnof/OOcQyntACOYwLvKpN6yhZ5Skl9X4gZwm
 eUL2Aj/t7sfqexff1i1oOfEmI3sfC05O2GWVxMVZC7CxUa9gXlV/0ksPDPDnZ6GpnGde
 ja+U78zj0uA/lWCcq/x5gsRJ/F2md3Rck5MpZGGyQlfaOitTh61VWVytqC0OhrM7KKVR
 BikbyrE2tpopkI7BY/Q0ecHiCn9yZ6flhWqaBlN0OFctplvnKVf0bKZp9z8KJaeQqdJL
 vDEq//EbOEexd06wpm/Yr6M43twQ7CPBv2fubL1nfZZxwYOBh3q1GX065CLh1UJOTRS3
 hnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244673; x=1787849473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=h7zYr8kpZYKg21q1pd5cKDA8VPO1ZSHlqsrFeP9oTww=;
 b=UL+71jH39urWT3jtmOmpuQ6iPO1zA0DXktN7yekDjUZWc/IOiClTG+nk/OR8TC35uE
 p2ipeJStJK6lhPXxnkJs+zcEBj2DY9JStmB9wbkGLwQcRwsk7UvXe6q/++wamP6y1YBN
 BwtFlDmly9wkLPPqK+jjQJiG8+h/veTwqmQe6J4b4wF13Y7wJeFw7dfBUibDdiEbKO+k
 XpOffFQl8GtaEUDDrReomJ51k4+hqy+NDMZV0nxBbk3GBCFoIZ8Iy+GA8miJvisc6U30
 xEFNuYLxTYUnTv6GnHZY9JTyQloDancXWx5mQGjz7EM3kCRMsX0Xp//ffKtWMuV8tsz/
 395A==
X-Gm-Message-State: AOJu0YwvRQF602/oFAYk1tUwvfgJOSGTt8/toEdskeS0T4Be548ezKH8
 +ePj3aVBSSOLruGLhz1wyWkqOkc7iBPY8lMi6Um+Wsj26OhHbYcoBzkYMnsVZhjT60hsR1lYwMA
 8kA4vM0v3sOd/kJy21hwBiBcVhozPPvd8p6ffNaiIc964ROymqxJqAQRp2NhAneOJch+VPwfljq
 3tSq9krbZb60Ny/JNX5Gq51T9E1CGV8Ggk4+o4Q0H5
X-Gm-Gg: AR+sD10EvoaEbifB9suY+0Nu0tkQ5IMTScQy0JFsuMlPAa6kWDBZNx/D9dXJga56WYs
 T/RKyv+lgG1u0+dZuXWQ6hHJDc6FfC7MilrvYSZGC1pKXcz45JyPBIl+v2/p1EF6Lllvpe08p//
 CfphIEkbAoElYPl0f5K0U0oWyKmGGAG/PpoARCLMuaqC5OLCvc0pHFUV2mLFeIn2AOktHTT1phd
 MXCNezoyFOASqXVGIcCY4DGqu41qGlaCisgk/C+HVMi5xyNgGIFr9kc2RR3OQu9L7VBSnb3x3xs
 Nz3U7Fnh6V/0GBRaA31f93o0oGFY5+sbbmIWbvfjYGxV0I1Rvvg4M/Ug5obNsPErWbXTuxT4QeR
 tP6KRC0n5hxIAA9ztJTQ+T9ENzyBRGHoDJaBhW/nGm1jhdMmMtJ+O8hWIwvdAYRztl+tvVyeiAX
 ovA4M=
X-Received: by 2002:a05:600c:3492:b0:495:5890:8f6c with SMTP id
 5b1f17b1804b1-499b8339418mr4078695e9.7.1787244673425; 
 Thu, 20 Aug 2026 09:51:13 -0700 (PDT)
X-Received: by 2002:a05:600c:3492:b0:495:5890:8f6c with SMTP id
 5b1f17b1804b1-499b8339418mr4077625e9.7.1787244672989; 
 Thu, 20 Aug 2026 09:51:12 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa175d0fsm158711715e9.9.2026.08.20.09.51.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:51:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Naveen N Rao (AMD)" <naveen@kernel.org>
Subject: [PULL 25/53] target/i386: SEV: Add support for enabling debug-swap
 SEV feature
Date: Thu, 20 Aug 2026 18:49:28 +0200
Message-ID: <20260820164957.1895963-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Naveen N Rao (AMD)" <naveen@kernel.org>

Add support for enabling debug-swap VMSA SEV feature in SEV-ES and
SEV-SNP guests through a new "debug-swap" boolean property on SEV guest
objects. Though the boolean property is available for plain SEV guests,
check_sev_features() has a check that rejects attempts to enable any SEV
feature for a plain SEV guest.

Though this SEV feature is called "Debug virtualization" in the APM, KVM
calls this "debug swap" so use the same name for consistency.

Sample command-line:
  -machine q35,confidential-guest-support=sev0 \
  -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1,debug-swap=on

Restrict debug-swap to SEV-SNP guests at this time due to a
compatibility issue with SEV-ES pflash devices.

Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
Link: https://lore.kernel.org/r/416e7b156e49f95958f8c5c8549b48a88c1995fc.1779281646.git.naveen@kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qapi/qom.json     |  7 ++++++-
 target/i386/sev.h |  1 +
 target/i386/sev.c | 26 ++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index c55776af7d3..ad7e39aa756 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1017,6 +1017,10 @@
 #     designated guest firmware page for measured boot with -kernel
 #     (default: false) (since 6.2)
 #
+# @debug-swap: enable virtualization of debug registers,
+#     only supported on SEV-ES and SEV-SNP guests
+#     (default: false) (since 11.1)
+#
 # Features:
 #
 # @confidential-guest-reset: If present, the hypervisor supports
@@ -1028,7 +1032,8 @@
   'data': { '*sev-device': 'str',
             '*cbitpos': 'uint32',
             'reduced-phys-bits': 'uint32',
-            '*kernel-hashes': 'bool' },
+            '*kernel-hashes': 'bool',
+            '*debug-swap': 'bool' },
   'features': ['confidential-guest-reset']}
 
 ##
diff --git a/target/i386/sev.h b/target/i386/sev.h
index b84ca3ce0b6..d19a3966974 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -47,6 +47,7 @@ bool sev_snp_enabled(void);
 #define SEV_SNP_POLICY_DBG      0x80000
 
 #define SVM_SEV_FEAT_SNP_ACTIVE     BIT(0)
+#define SVM_SEV_FEAT_DEBUG_SWAP     BIT(5)
 
 typedef struct SevKernelLoaderContext {
     char *setup_data;
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 9cdccc872a3..2103a121aa2 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -324,6 +324,11 @@ sev_set_guest_state(SevCommonState *sev_common, SevState new_state)
     sev_common->state = new_state;
 }
 
+static bool is_sev_feature_set(SevCommonState *sev_common, uint64_t feature)
+{
+    return !!(sev_common->sev_features & feature);
+}
+
 static void sev_set_feature(SevCommonState *sev_common, uint64_t feature, bool set)
 {
     if (set) {
@@ -523,6 +528,12 @@ static int check_sev_features(SevCommonState *sev_common, uint64_t sev_features,
             __func__);
         return -1;
     }
+    if (sev_features && sev_es_enabled() && !sev_snp_enabled()) {
+        error_setg(errp,
+                   "%s: SEV features are not supported with SEV-ES at this time",
+                   __func__);
+        return -1;
+    }
     if (sev_features && !sev_es_enabled()) {
         error_setg(errp,
                    "%s: SEV features require either SEV-ES or SEV-SNP to be enabled",
@@ -2797,6 +2808,16 @@ static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
     return 0;
 }
 
+static bool sev_common_get_debug_swap(Object *obj, Error **errp)
+{
+    return is_sev_feature_set(SEV_COMMON(obj), SVM_SEV_FEAT_DEBUG_SWAP);
+}
+
+static void sev_common_set_debug_swap(Object *obj, bool value, Error **errp)
+{
+    sev_set_feature(SEV_COMMON(obj), SVM_SEV_FEAT_DEBUG_SWAP, value);
+}
+
 static void
 sev_common_class_init(ObjectClass *oc, const void *data)
 {
@@ -2822,6 +2843,11 @@ sev_common_class_init(ObjectClass *oc, const void *data)
                                    sev_common_set_kernel_hashes);
     object_class_property_set_description(oc, "kernel-hashes",
             "add kernel hashes to guest firmware for measured Linux boot");
+    object_class_property_add_bool(oc, "debug-swap",
+                                   sev_common_get_debug_swap,
+                                   sev_common_set_debug_swap);
+    object_class_property_set_description(oc, "debug-swap",
+            "enable virtualization of debug registers");
 }
 
 static void
-- 
2.55.0


