Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F44C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 18:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucThf-00081A-AW; Thu, 17 Jul 2025 14:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucR8d-0002tk-Gr
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 12:07:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucR8b-0002Fx-P1
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 12:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752768432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PLrQp95rvm2mOaUAqrOiIgoBJpm3/ZUBPdW5pZC03uU=;
 b=NCtF0OlOIgk9N11OB97WUUIuo1MBFh529wE+NoatHbHw3w2Yc1+7ELFVZnTKSJsTycrAa2
 gyd+uH1mdij5q+kv63yrNyf+YiYA7uBW6yCS12wlHpxcqyLuXjvL5OOy0+/mwdonY/CJgT
 7cNKtEMegMKULAgLqZz3CsiAiU4rsDU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-uI2ASmdsPtiGg8u6t1k6HA-1; Thu, 17 Jul 2025 12:07:11 -0400
X-MC-Unique: uI2ASmdsPtiGg8u6t1k6HA-1
X-Mimecast-MFC-AGG-ID: uI2ASmdsPtiGg8u6t1k6HA_1752768430
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-453817323afso7991155e9.1
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 09:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752768428; x=1753373228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PLrQp95rvm2mOaUAqrOiIgoBJpm3/ZUBPdW5pZC03uU=;
 b=vRG+bh68wZfGp08CxQHKvYJ7CWnOIi40vy3chlicXDcp7p4axrJWeR6TcKoIb7nPuH
 BNZmqjW6OI5lmIqA9qveYIBWrG3khNU9RdMqex1flFIQdqG4h2qXMXodScUPE099CXUs
 mxIu/VbIDvaFZFltJtFsO9bQGmuID35iKFZR+19W8EXgdXAabu6LPNlI8uOU3JODiFJU
 7zQWddt8rZGB1BOyBeDwGvUSa+6zT82FjeYK3M8jf9+qlst5BZpAcxjJAdoTMLF61Lql
 U4BS9oBEmv8Hrb6NTi3xTLK98bgP+OvbQUhpxc+tvrqFDVMysYuLSHAkPe668gQY5F1W
 k/JA==
X-Gm-Message-State: AOJu0YzE0gDalDWKCIidQl90A8goehjKP1DXf/A0cG4foQKWA7TT/0Dl
 ZpVcPyO+Q8ps62JTIaPO+8qYdFisWPeDvjipfPf33mbB1IDsgW4TwsDoUg2md150ZPxrRcuaF1e
 ldEItI/9HsJsGnId1cqoCEANM0FRwOWYFq5I26GRFP4iYPNeVudT1hIr++F+Cooj8KG/3JpCtgy
 b6PdarBczBJvS2HEU+DvsU59qtEDcFL17EhswPKUdn
X-Gm-Gg: ASbGncsSy/Qntd1q28xJhFLY1pol3MB9ntpUzKbuIVOcBkkTLgMmph8yINh70JyrCvs
 cYixQVHohiapDe6WgMcz4F3x8VMOOISpyBt8asfzseSEIJ2W/oJ3aV7Si2BRkGWRHRRJLrBCgD4
 d/xcjlqlbJVHbA0GpbMya9tXRctlTwzcMLDdGr85H0kyPcj3Clfg4JGMT0GSDM2d4lSetmBOK5p
 JvH6c11UKcowtpTYRCN7y9VXu40HL72anWl17onIojjrXyKakwDAMezApNW5caEnaJtO6RILrOn
 6y+c7+cSU+zxYtOvfR7FkF80FH5TZWG0xZlQJ44MiCM=
X-Received: by 2002:a05:600c:3b29:b0:453:7713:546a with SMTP id
 5b1f17b1804b1-4562f164b1bmr80081325e9.14.1752768423699; 
 Thu, 17 Jul 2025 09:07:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdGQzMTN+ad5BHVXV7gltb3idOqFI05xWmY6qv2AqFAOMK/pm8K/0ir4Kl8p5iFOJ3m3KP+A==
X-Received: by 2002:a05:600c:3b29:b0:453:7713:546a with SMTP id
 5b1f17b1804b1-4562f164b1bmr80080645e9.14.1752768423116; 
 Thu, 17 Jul 2025 09:07:03 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45634f4c848sm27537025e9.4.2025.07.17.09.07.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 09:07:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 1/6] target/i386: do not expose ARCH_CAPABILITIES on AMD CPU
Date: Thu, 17 Jul 2025 18:06:55 +0200
Message-ID: <20250717160700.357384-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717160700.357384-1-pbonzini@redhat.com>
References: <20250717160700.357384-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

KVM emulates the ARCH_CAPABILITIES on x86 for both Intel and AMD
cpus, although the IA32_ARCH_CAPABILITIES MSR is an Intel-specific
MSR and it makes no sense to emulate it on AMD.

As a consequence, VMs created on AMD with qemu -cpu host and using
KVM will advertise the ARCH_CAPABILITIES feature and provide the
IA32_ARCH_CAPABILITIES MSR. This can cause issues (like Windows BSOD)
as the guest OS might not expect this MSR to exist on such cpus (the
AMD documentation specifies that ARCH_CAPABILITIES feature and MSR
are not defined on the AMD architecture).

A fix was proposed in KVM code, however KVM maintainers don't want to
change this behavior that exists for 6+ years and suggest changes to be
done in QEMU instead.  Therefore, hide the bit from "-cpu host":
migration of -cpu host guests is only possible between identical host
kernel and QEMU versions, therefore this is not a problematic breakage.

If a future AMD machine does include the MSR, that would re-expose the
Windows guest bug; but it would not be KVM/QEMU's problem at that
point, as we'd be following a genuine physical CPU impl.

Reported-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index e8c8be09bae..369626f8c8d 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -503,8 +503,12 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
          * Linux v4.17-v4.20 incorrectly return ARCH_CAPABILITIES on SVM hosts.
          * We can detect the bug by checking if MSR_IA32_ARCH_CAPABILITIES is
          * returned by KVM_GET_MSR_INDEX_LIST.
+         *
+         * But also, because Windows does not like ARCH_CAPABILITIES on AMD
+         * mcahines at all, do not show the fake ARCH_CAPABILITIES MSR that
+         * KVM sets up.
          */
-        if (!has_msr_arch_capabs) {
+        if (!has_msr_arch_capabs || !(edx & CPUID_7_0_EDX_ARCH_CAPABILITIES)) {
             ret &= ~CPUID_7_0_EDX_ARCH_CAPABILITIES;
         }
     } else if (function == 7 && index == 1 && reg == R_EAX) {
-- 
2.50.1


