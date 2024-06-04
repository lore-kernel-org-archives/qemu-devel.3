Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C69C27C53
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENw5-0004jw-CD; Tue, 04 Jun 2024 02:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENvL-0004Ej-Sg
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:45:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENvK-0007Zz-Br
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0FtFMf2zANvlKiTEbIODyYK7bqgLhlm5mAbr7EpnP2A=;
 b=Pstwc3t9lNnCltjTd4OonCrjSKvGry2sc1N4KLAlH8V2krNKF8UgUfjL1BWMbpGwW5Qe+W
 ADrCRxnRrjFMga8prUx4ir0Gp7ZguCsW8c1/gvQzt5E2n9tgJM8YzVzdNP9DEy4X+9ItC5
 7lr7Kh/sAjzQgqEBWWrzw6rWBU5Uk8M=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-K7ukP_CROt2LP7PMTRJSmQ-1; Tue, 04 Jun 2024 02:45:32 -0400
X-MC-Unique: K7ukP_CROt2LP7PMTRJSmQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-57a52cb6d86so322250a12.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483530; x=1718088330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0FtFMf2zANvlKiTEbIODyYK7bqgLhlm5mAbr7EpnP2A=;
 b=q3O3XeP3W/HtfaAP7KNxHlXCscnqOeAXjUmYGfvsT8A8Yd3fwXkr09NwG5+VZaJsMP
 WlLaopGFqq0pdf3goc9iXyD1JaKcUvt/mioF202vtuzozGku1gtJq8bsThAW5DZxtec4
 jU7c5DjvrCK+AaoxYYgHt3Qo5YZLOMW/s/5FHYtQmZwXYvl2LcfgsjoKfPN7DlnR46tK
 ycnErNzrgE3vfUWyAratWILMKb/unw0uBXcpA+ZjnueIK6MEN41eZJgCbp5p6fQYFi9k
 qfWBqKHYJCjMuZ4QfIeVt7xYXFOqsy49zzjsJy2Xt5Wl+ERIWMy89pBSpd8EDMf+Z3Xj
 wo0g==
X-Gm-Message-State: AOJu0Yx3nR+1vPjCePjYUzUQfm5fpbfNvOT2b7vwQgc4ef6YFW6lLI3M
 cFFhNmiw56CGxYYSgKtHiNcpbQFE2hZeGnjorRhScsoVZPq21okkoeFdOtGA9zvtMDiQZ3XToGC
 WSGWqJ9Yp6n1WdfLLt/K/j097vnW61SH/OqO0PTJhnKa6vbAkvubtEyv+ity4ussNIq+vXxRJbd
 qfvXJvMFlnfXCa09ko6ocZypNLDupAy8TlVXMl
X-Received: by 2002:a50:9518:0:b0:57a:2e93:fe80 with SMTP id
 4fb4d7f45d1cf-57a3638e699mr7020937a12.18.1717483530586; 
 Mon, 03 Jun 2024 23:45:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/5eN0Z+DGTyDA5aNfx90+JeVLPhJxYdd7KlNFaCh06wnI+vLaZaRs/ET5eaU009pBeBEIQQ==
X-Received: by 2002:a50:9518:0:b0:57a:2e93:fe80 with SMTP id
 4fb4d7f45d1cf-57a3638e699mr7020927a12.18.1717483530293; 
 Mon, 03 Jun 2024 23:45:30 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a52f5cbd3sm4484351a12.12.2024.06.03.23.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:45:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pankaj Gupta <pankaj.gupta@amd.com>
Subject: [PULL 27/45] i386/sev: Add a class method to determine KVM VM type
 for SNP guests
Date: Tue,  4 Jun 2024 08:43:51 +0200
Message-ID: <20240604064409.957105-28-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604064409.957105-1-pbonzini@redhat.com>
References: <20240604064409.957105-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SEV guests can use either KVM_X86_DEFAULT_VM, KVM_X86_SEV_VM,
or KVM_X86_SEV_ES_VM depending on the configuration and what
the host kernel supports. SNP guests on the other hand can only
ever use KVM_X86_SNP_VM, so split determination of VM type out
into a separate class method that can be set accordingly for
sev-guest vs. sev-snp-guest objects and add handling for SNP.

Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
Message-ID: <20240530111643.1091816-14-pankaj.gupta@amd.com>
[Remove unnecessary function pointer declaration. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c |  1 +
 target/i386/sev.c     | 15 ++++++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 6c864e4611f..23a003aaa7e 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -167,6 +167,7 @@ static const char *vm_type_name[] = {
     [KVM_X86_DEFAULT_VM] = "default",
     [KVM_X86_SEV_VM] = "SEV",
     [KVM_X86_SEV_ES_VM] = "SEV-ES",
+    [KVM_X86_SNP_VM] = "SEV-SNP",
 };
 
 bool kvm_is_vm_type_supported(int type)
diff --git a/target/i386/sev.c b/target/i386/sev.c
index c3daaf1ad50..072cc4f8530 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -885,6 +885,11 @@ out:
     return sev_common->kvm_type;
 }
 
+static int sev_snp_kvm_type(X86ConfidentialGuest *cg)
+{
+    return KVM_X86_SNP_VM;
+}
+
 static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 {
     char *devname;
@@ -894,6 +899,8 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     struct sev_user_data_status status = {};
     SevCommonState *sev_common = SEV_COMMON(cgs);
     SevCommonStateClass *klass = SEV_COMMON_GET_CLASS(cgs);
+    X86ConfidentialGuestClass *x86_klass =
+                               X86_CONFIDENTIAL_GUEST_GET_CLASS(cgs);
 
     sev_common->state = SEV_STATE_UNINIT;
 
@@ -964,7 +971,7 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     }
 
     trace_kvm_sev_init();
-    if (sev_kvm_type(X86_CONFIDENTIAL_GUEST(sev_common)) == KVM_X86_DEFAULT_VM) {
+    if (x86_klass->kvm_type(X86_CONFIDENTIAL_GUEST(sev_common)) == KVM_X86_DEFAULT_VM) {
         cmd = sev_es_enabled() ? KVM_SEV_ES_INIT : KVM_SEV_INIT;
 
         ret = sev_ioctl(sev_common->sev_fd, cmd, NULL, &fw_error);
@@ -1441,10 +1448,8 @@ static void
 sev_common_class_init(ObjectClass *oc, void *data)
 {
     ConfidentialGuestSupportClass *klass = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
-    X86ConfidentialGuestClass *x86_klass = X86_CONFIDENTIAL_GUEST_CLASS(oc);
 
     klass->kvm_init = sev_common_kvm_init;
-    x86_klass->kvm_type = sev_kvm_type;
 
     object_class_property_add_str(oc, "sev-device",
                                   sev_common_get_sev_device,
@@ -1529,10 +1534,12 @@ static void
 sev_guest_class_init(ObjectClass *oc, void *data)
 {
     SevCommonStateClass *klass = SEV_COMMON_CLASS(oc);
+    X86ConfidentialGuestClass *x86_klass = X86_CONFIDENTIAL_GUEST_CLASS(oc);
 
     klass->launch_start = sev_launch_start;
     klass->launch_finish = sev_launch_finish;
     klass->kvm_init = sev_kvm_init;
+    x86_klass->kvm_type = sev_kvm_type;
 
     object_class_property_add_str(oc, "dh-cert-file",
                                   sev_guest_get_dh_cert_file,
@@ -1770,8 +1777,10 @@ static void
 sev_snp_guest_class_init(ObjectClass *oc, void *data)
 {
     SevCommonStateClass *klass = SEV_COMMON_CLASS(oc);
+    X86ConfidentialGuestClass *x86_klass = X86_CONFIDENTIAL_GUEST_CLASS(oc);
 
     klass->kvm_init = sev_snp_kvm_init;
+    x86_klass->kvm_type = sev_snp_kvm_type;
 
     object_class_property_add(oc, "policy", "uint64",
                               sev_snp_guest_get_policy,
-- 
2.45.1


