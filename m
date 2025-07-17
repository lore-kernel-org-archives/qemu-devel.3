Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14102C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 10:35:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLx9-0001hi-VI; Thu, 17 Jul 2025 06:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucLx5-0001eG-SB
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:35:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucLx2-0000ul-KT
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752748493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5dn4Se2E2+Bvcf+N3VpfJoD1AhReUcfRRTGgoj0oLa0=;
 b=ietvpHk1jLl/zY4rWFTP/gi0mG1cv8zTASrQAeVjswJgp16RyVqOsBusYIlGP5SDGBf+qy
 BUtOIuz3GGq7tfBhdwuUqxYdLpNW83PzZFPTFBBzJSRzxqzP8ElUJLFkIRbEHb3ktgAJw+
 zgoV3aUmV6+DAbb0FypYPfNiAq8yxdM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-UFqg94E0Py6nSeQVgVYOjg-1; Thu, 17 Jul 2025 06:34:52 -0400
X-MC-Unique: UFqg94E0Py6nSeQVgVYOjg-1
X-Mimecast-MFC-AGG-ID: UFqg94E0Py6nSeQVgVYOjg_1752748491
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-607c91a207dso867451a12.2
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 03:34:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752748490; x=1753353290;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5dn4Se2E2+Bvcf+N3VpfJoD1AhReUcfRRTGgoj0oLa0=;
 b=qqNYg+mcg1oqzKI6+0LnV1nkqfQ8bIlIY9FqrL6a0dIhCn6NpodhJHra0nOsgxHmt9
 OW6rhAvGkBX4MHBjc5Os4E4DAvZopnQS/Kd70TOlQSq9VH6TY262tRA02PIbGxQ7hO2N
 BMmcNW1MfODPQYDwz9tbFFyzSmfiCkhM8ej/OzEJbfO6NzGVgTMhiTJLrP5CZeXn+EaF
 7FJKunSsMHfupGMxh/y4S8ydZILggUiIcTJj5rHPt0h/AqZ6MQaA+ocphr+T3fVUg1t1
 +NnLLfBokT6BoIqek0TSVOZUsWGfmBfaPR8pS+38/Ged2vhOOKPwETYjJoSlF6XlAkHR
 3Lig==
X-Gm-Message-State: AOJu0YxIw/C1XryDJPlti85tpCIFS1wMhJb0QMEfLx8PUNbf/Y8efypi
 kirQ+pM7L4/M/JdCIOCz7jeQC/yHEoFjtuiy0JOyCZEAdMsuqZvGQDba4xXOELEpFpuISBu7l15
 prCvpQOBQULlgtdJJ9xc4ig/aSyxv4EKZpYvg8IXugz+AW2s/umyII+E+PLzMgnJUwrqXFI5Dwc
 nAfXO0nKq/cT1VughzdeZShSv0x3ugyKLTbAjttFiE
X-Gm-Gg: ASbGncueHb8fDJNCYdTC+o7TF6cpHG96EDNLfS5+BiozxV71e55v02zm9ymfWQRQzvd
 8yEk2oomSBOh4xgEvuD0h5IGLUIEKNimm6H5rQV3Z0hhPHfRzGrj3tW46xfS8/ozUEfxqYlNSoT
 Not7y3/hE5X8xOKWvII+k7CJQHThE0a29RGdza+affrsqBGpKYqjDRnQXxeZraSPpsekl7gkmgN
 9cJuF8P84V/OTW4SS5Ar+iwnSqFhS2vkJsXtLVPoltGzu88kmJCUQ6xiUkKZv84qA47bbbQb0/S
 vEHyj3YI5+N2CyviDgCCnZ2OJFHUEMLBr9Bxju7Ilb4=
X-Received: by 2002:a05:6402:234a:b0:5e6:17e6:9510 with SMTP id
 4fb4d7f45d1cf-6128590c5acmr5396140a12.6.1752748490283; 
 Thu, 17 Jul 2025 03:34:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGN6Cj6Xa4vbyrRbf5G5h+sIHR24kHctwlA4Osb8RvIk6ov503Yu0iuydNQCvMBxEoB5Aa/4g==
X-Received: by 2002:a05:6402:234a:b0:5e6:17e6:9510 with SMTP id
 4fb4d7f45d1cf-6128590c5acmr5396118a12.6.1752748489706; 
 Thu, 17 Jul 2025 03:34:49 -0700 (PDT)
Received: from [10.131.45.123] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-611c976f333sm9801103a12.64.2025.07.17.03.34.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 03:34:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] target/i386: do not expose ARCH_CAPABILITIES on AMD CPU
Date: Thu, 17 Jul 2025 12:34:48 +0200
Message-ID: <20250717103448.331037-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
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


