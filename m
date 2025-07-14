Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC20C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHGR-0001nO-HI; Mon, 14 Jul 2025 07:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH1b-0001zY-Ms
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:07:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH1Z-0002Dv-N7
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:07:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eoimDhc5l0wVHOgJ1eysYl454HfMabPmsqsHxip4lQg=;
 b=LTekUaOpwkNhFCHsiFvfo+bd83UhDBmrCFqMARIhLZonVD243LQCmJPjvVpwi9zMWDp1JU
 9MWr5qhyX8gZTLXTB+yp1kXvo2GzHmwjNGPU624+dZ2Qr5qHZXlQ+ExGXg1IhHY7I6qtgG
 u12mVmqWp1LdqKDM7QoVYzrchCrhLDw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-b7P0X1cUMnuxNfR21EL4-A-1; Mon, 14 Jul 2025 07:07:06 -0400
X-MC-Unique: b7P0X1cUMnuxNfR21EL4-A-1
X-Mimecast-MFC-AGG-ID: b7P0X1cUMnuxNfR21EL4-A_1752491225
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-456175dba68so8249865e9.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491224; x=1753096024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eoimDhc5l0wVHOgJ1eysYl454HfMabPmsqsHxip4lQg=;
 b=XiSNay2p2td08OWXekB22OMMn3TPjSuYUIz70qSve/tADv5Y5U42T7l3beuI9AACqd
 RZavRyQrGPzutrfu1zPMwGnXGZbCGBycK1/WSBzrjN05eJsSgkhwIiGVdhzjG6Ijn4eG
 48m7o7EPr8cr2QcDvQpGSpg3mQhxt16whUW7dqIp6h8SjtaT8fQya7p3vC4MvIN4Pamr
 v+oSWYuLqg3X7BTZTM1+MZ/ONo7M/F8RKK/eW4AYy1bjQK6y1hOaNjN+ph06uQr/s0Wv
 rdod5+EyedRqUhGrdTFn0TJLyXm856t4K6PCL1xaIkM/+O79KXt5g4mu9X84e7eROSuW
 6Hww==
X-Gm-Message-State: AOJu0Yyoh3PaKO+OXoNiNHv+jOBZigwxyKowcuA2lWiIaBSRXAM9t8ou
 Tp1mJcODKIarA4OGshkRJSAWHKSsRab8nf1Rt1vZMrB9MxpdZQY23CWkoJv0On62oMSI9HiYO5D
 btClZxRC01ej7YbYIdcRLq3pS91+XzTnq+4HoNnIPZ03IsVQS4MyL2YIMb0KAZVxT/vUlbtzDFi
 DDmwTIwvm5TOUoKmBU2421NgFHQcneRsXTtWYWUROz
X-Gm-Gg: ASbGnctvXeqU/QnIxLgN1FSUl72tEZQn79ZcxfzvPiS28x2TUjY+QuR6RY0P1PTWwRH
 iVo0PRG+Lj0i5iANCULWlAfgA0A+RmfKB61sfNGEbCc6i03ESzLzajkcJnRi+4i/QNIifpcoSTI
 kGQDJq1zzPfPPC2MDonIemSsRbky2LD2icDzXYlqtg/U0vel58RerMdqPWuKjJWOgAlsZkZm5nk
 oayKUHCCoYIPL29xOuo2E3+8hLD+b0JLnO33pl+bNToQZtXif/z1rJfxP18tCq3JE6LyKBDaWMl
 0vTiW7EKbtyg+boSKYYB77wgWxUdWUxhWaxETmUM4Fw=
X-Received: by 2002:a05:600c:4e51:b0:455:eda0:8a8e with SMTP id
 5b1f17b1804b1-455eda08c8dmr89470205e9.27.1752491224243; 
 Mon, 14 Jul 2025 04:07:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZbyNgVFefir52iWnM2DErV6Xh7OJJ9HWLIGYkGB98qDWZHSRYPuBTJmZLre/jKF1S91GeMQ==
X-Received: by 2002:a05:600c:4e51:b0:455:eda0:8a8e with SMTP id
 5b1f17b1804b1-455eda08c8dmr89469925e9.27.1752491223816; 
 Mon, 14 Jul 2025 04:07:03 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4560ddf5e0esm63678815e9.18.2025.07.14.04.07.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:07:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
	Tao Su <tao1.su@linux.intel.com>
Subject: [PULL 68/77] i386/cpu: Mark EBX/ECX/EDX in CPUID 0x80000000 leaf as
 reserved for Intel
Date: Mon, 14 Jul 2025 13:03:57 +0200
Message-ID: <20250714110406.117772-69-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

Per SDM,

80000000H EAX Maximum Input Value for Extended Function CPUID Information.
          EBX Reserved.
          ECX Reserved.
          EDX Reserved.

EBX/ECX/EDX in CPUID 0x80000000 leaf are reserved. Intel is using 0x0
leaf to encode vendor.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Tao Su <tao1.su@linux.intel.com>
Link: https://lore.kernel.org/r/20250627035129.2755537-2-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4f0c9734461..ae508fa962d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8280,9 +8280,15 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         break;
     case 0x80000000:
         *eax = env->cpuid_xlevel;
-        *ebx = env->cpuid_vendor1;
-        *edx = env->cpuid_vendor2;
-        *ecx = env->cpuid_vendor3;
+
+        if (cpu->vendor_cpuid_only_v2 &&
+            (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env))) {
+            *ebx = *ecx = *edx = 0;
+        } else {
+            *ebx = env->cpuid_vendor1;
+            *edx = env->cpuid_vendor2;
+            *ecx = env->cpuid_vendor3;
+        }
         break;
     case 0x80000001:
         *eax = env->cpuid_version;
-- 
2.50.0


