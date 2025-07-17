Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C74C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 18:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucTCl-0004bw-2r; Thu, 17 Jul 2025 14:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucQSI-0004Ze-5s
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:23:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucQSD-0004Ix-BU
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752765803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PLrQp95rvm2mOaUAqrOiIgoBJpm3/ZUBPdW5pZC03uU=;
 b=PYIuIYBWUaNem7sPX4/eva6+03RURBx+cCMLLWXeLIALAYIFVirjll7yqHPES+DLWyciX4
 oCI2YznxiCz51BdBI4BFIFQ1agh9jz/drykY86hPHgLlWwEzo70fbAyPFC3honImcIoQct
 qiqjKMdqZzz4lRyQoLHXlvBHIBmuGg8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-K1fR04njPfOHjuetRlhS7w-1; Thu, 17 Jul 2025 11:23:22 -0400
X-MC-Unique: K1fR04njPfOHjuetRlhS7w-1
X-Mimecast-MFC-AGG-ID: K1fR04njPfOHjuetRlhS7w_1752765801
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a579058758so514545f8f.1
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 08:23:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752765801; x=1753370601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PLrQp95rvm2mOaUAqrOiIgoBJpm3/ZUBPdW5pZC03uU=;
 b=hpz1uJgGRhYnLOT7Oz7TAHQRUFxgh5VDnB4/qC5JGD3Z/L/P/IP+X3GFNa3ks/bopr
 6xt7LfH7EFIjHqmmLiaqOmCnn6D+EqaMks9TyhP1XfV5SNFgF2lHpJvrc5Wz0lEgW8cv
 kWkI7CB4/1OrAFf+YGABa48TNoMl+MGBKJv1qlssKMirMSC3dgWjyL7nz6c9kvDyradv
 143MHni78c9wZ59rzqWt4bm49Ot7uZM5vhbD7EdXmjPmVRJJlGcvqNTx/5IgizdnyPHZ
 oNI2xvZlhReW3h4kzyOwrAnaJK7t6oMEpxsYTIyiD38j/UIEouKT0tvnVrLXag1TPBY/
 jwmw==
X-Gm-Message-State: AOJu0YzKD3Sw3f7sJkbT9i6/qGqDefGLWm4MUmphefpbTxF0dUSEGzH5
 eb/jUO9BFSeoM8yO1zhWMfWlVlEX+AlExQjYR3ugXTydkZ/Bb48Ef86tjjtAMzqXq6qhOyyoQPy
 gm1u0aSwhyiNKMrr4ogVbrFUvwDQvR3fRi17EHVR6vHu5XiVXnrUPdjKHsKSfBYEFDucn0QLsA+
 wlO8gPBBhxI2zfJgtkhJJYBy44CsJF3BOgsLBvuP6V
X-Gm-Gg: ASbGncsPjBgdsq0kKyAJBN+JjdRuzyNCQyJfPaGKMmigYBCPsYypRslT8QQYnLQnBkx
 kAaX5HHIPvaNiTFEGkvg6uxLJq7WPfGpWIH1G6Qpcu9AFYcGwfBwWQEAwFbpHteZNrVhJmDkLMj
 W4ajfvVKJFvBlxVotldOuBJBLoj9g1eEoIaN/Yf9QyaLmAdSQ16e7Wy0DaAtowx4EFLM513nM9l
 6oHX/wLDVGp1qrz2XG9WTC3/URfBgYSSFPpL5nUKjQVT1+uCURTPjWGHF1Ybn2RC8avDNvZ0Mn7
 3doMbVJGlgmJcp62R9znnAQmUzS2GWb7k6K0oE4jJh4=
X-Received: by 2002:a05:6000:2309:b0:3b5:dc05:79b with SMTP id
 ffacd0b85a97d-3b60e4d0099mr6503458f8f.14.1752765800791; 
 Thu, 17 Jul 2025 08:23:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/U4DO+6D9826sjBAaP2oN9fAONxAYlfOKVSI3zpiTHiKBxJkhSr3Kzuulj2jB5/RdaIz39A==
X-Received: by 2002:a05:6000:2309:b0:3b5:dc05:79b with SMTP id
 ffacd0b85a97d-3b60e4d0099mr6503397f8f.14.1752765799841; 
 Thu, 17 Jul 2025 08:23:19 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc201asm20872582f8f.22.2025.07.17.08.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 08:23:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 1/6] target/i386: do not expose ARCH_CAPABILITIES on AMD CPU
Date: Thu, 17 Jul 2025 17:23:11 +0200
Message-ID: <20250717152316.353049-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717152316.353049-1-pbonzini@redhat.com>
References: <20250717152316.353049-1-pbonzini@redhat.com>
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


