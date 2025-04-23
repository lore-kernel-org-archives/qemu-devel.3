Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE0CC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Wch-0006Ss-4z; Wed, 23 Apr 2025 05:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7WcR-00060O-En
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:42:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7WcP-0008QE-F3
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745401332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WvsqYvFkf1uV7Kz7AuvKa0NZNKESNuS8KzujTvDKv10=;
 b=gjBnjVuSV2M4w2g9qtOriRDkoG6qphSbKvmhRxSvjLnR72hxHnNRzZAKvKOzRnKDfS7QbR
 TOe0NJ08p7BKyt6XScAdkhlOe8Dc7zZw+cPCrfnq8YeioJsimveQNik+OTIXO+sz5jkoFt
 DaOT/YSZHSbI5FlL1WqFIm76cDPeaCg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-UgtthlUVN6yZGzQI9jmdAQ-1; Wed, 23 Apr 2025 05:42:10 -0400
X-MC-Unique: UgtthlUVN6yZGzQI9jmdAQ-1
X-Mimecast-MFC-AGG-ID: UgtthlUVN6yZGzQI9jmdAQ_1745401330
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-acb90bccc16so124039166b.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:42:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745401328; x=1746006128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WvsqYvFkf1uV7Kz7AuvKa0NZNKESNuS8KzujTvDKv10=;
 b=sU5WPLBl3raspGNkmX4wW3iegLtN9K1BcUM2mfLsbNQ+eBks/7S1Sa2Bo8y7nh1+Dn
 yglFtbONerlc4xzpM6kOkdCNwRhhwhor/KJnili+pklanmLsTd9XoHwJEpX94sT0F/Pu
 LJFyo07HeQt6pZGw4j6oKuMIzgpFzqGJEqKIiY6Kc5E5a9UpCu8GyyVIt8ttzr/TZ5tY
 mTdQPHBYHBvf6o0+2IukvOpJA5ZzrMPYRLOfwO2nCeR74VsZVPfm+z028MPeQvpK+3z3
 U0ZlkiXpCvkSLPFsPNfrftg2gyU6rqbjx9gB578Msf6yQAbh9dL3lDxDnop98L1Hd+0i
 CqJQ==
X-Gm-Message-State: AOJu0YzJqFZFGu9AuqYlIh38u0fZZ+n+OSeg6I8mpPkwNJeGPqLy29NB
 PZBzDozl1JwAL0yrnOAPj6/kWRViEN4GRlKO09mJ4czl6DUPtis5+D0iV5exHIB11ky2OYChjPg
 i/t90RBa3D9WeQ5gucQQm1n9nvQ/usWFwDO3oa3lKeP4HDN66KkYPAy6Jf2TvQyiPlCO0LUszdA
 +/luKljwOUNLQMS0HMS+O+9T5eLr9axjFLqYyJ
X-Gm-Gg: ASbGnctxOXub7CIBoCJDoWH0XLOl4hvmN1glPOI3K8lzeA1jYZcrz4zyrv9XDshM/hF
 5SQ3tzGnJCKvpRbMDtXmzyDru9pAQe1z6KGcf35I/cLNh9n5asa+cjR8GTJb0IqTWxohvet6dAy
 QuUFmZIrGho9fTtlWAu+ekDuktepR93obSmEdc8MKjImgZ7VQSr4N5G1Z05+L2s2MhvrHFMGAmJ
 2gSgN5lP8AQcbDPwIyK+wjA+B2gB/jGXrgyVRbdvO2ktlNHxYmOQ+VvaubXgKYVqwfpXVCZxu4q
 L1wiQl3Pm99PjJdn
X-Received: by 2002:a17:907:9801:b0:ac7:9828:ea41 with SMTP id
 a640c23a62f3a-acb74d65c6bmr1576928966b.41.1745401328431; 
 Wed, 23 Apr 2025 02:42:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBsHtBRr2g+WjIcwotRV2wttXUrO3RFO1AL0RRiWUiFr/zuftJGgRlamfdPCeyY4xN5Eoa8A==
X-Received: by 2002:a17:907:9801:b0:ac7:9828:ea41 with SMTP id
 a640c23a62f3a-acb74d65c6bmr1576927166b.41.1745401328011; 
 Wed, 23 Apr 2025 02:42:08 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.233.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acb6ec0b711sm769368166b.9.2025.04.23.02.42.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 02:42:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
	Dongli Zhang <dongli.zhang@oracle.com>
Subject: [PULL 28/34] i386/cpu: Consolidate the helper to get Host's vendor
Date: Wed, 23 Apr 2025 11:40:58 +0200
Message-ID: <20250423094105.40692-29-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423094105.40692-1-pbonzini@redhat.com>
References: <20250423094105.40692-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
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

Extend host_cpu_vendor_fms() to help more cases to get Host's vendor
information.

Cc: Dongli Zhang <dongli.zhang@oracle.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250410075619.145792-1-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/host-cpu.c        | 10 ++++++----
 target/i386/kvm/vmsr_energy.c |  3 +--
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
index 3e4e85e729c..072731a4dd2 100644
--- a/target/i386/host-cpu.c
+++ b/target/i386/host-cpu.c
@@ -109,9 +109,13 @@ void host_cpu_vendor_fms(char *vendor, int *family, int *model, int *stepping)
 {
     uint32_t eax, ebx, ecx, edx;
 
-    host_cpuid(0x0, 0, &eax, &ebx, &ecx, &edx);
+    host_cpuid(0x0, 0, NULL, &ebx, &ecx, &edx);
     x86_cpu_vendor_words2str(vendor, ebx, edx, ecx);
 
+    if (!family && !model && !stepping) {
+        return;
+    }
+
     host_cpuid(0x1, 0, &eax, &ebx, &ecx, &edx);
     if (family) {
         *family = ((eax >> 8) & 0x0F) + ((eax >> 20) & 0xFF);
@@ -129,11 +133,9 @@ void host_cpu_instance_init(X86CPU *cpu)
     X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
 
     if (xcc->model) {
-        uint32_t ebx = 0, ecx = 0, edx = 0;
         char vendor[CPUID_VENDOR_SZ + 1];
 
-        host_cpuid(0, 0, NULL, &ebx, &ecx, &edx);
-        x86_cpu_vendor_words2str(vendor, ebx, edx, ecx);
+        host_cpu_vendor_fms(vendor, NULL, NULL, NULL);
         object_property_set_str(OBJECT(cpu), "vendor", vendor, &error_abort);
     }
 }
diff --git a/target/i386/kvm/vmsr_energy.c b/target/i386/kvm/vmsr_energy.c
index 31508d4e77a..f499ec6e8b0 100644
--- a/target/i386/kvm/vmsr_energy.c
+++ b/target/i386/kvm/vmsr_energy.c
@@ -29,10 +29,9 @@ char *vmsr_compute_default_paths(void)
 
 bool is_host_cpu_intel(void)
 {
-    int family, model, stepping;
     char vendor[CPUID_VENDOR_SZ + 1];
 
-    host_cpu_vendor_fms(vendor, &family, &model, &stepping);
+    host_cpu_vendor_fms(vendor, NULL, NULL, NULL);
 
     return g_str_equal(vendor, CPUID_VENDOR_INTEL);
 }
-- 
2.49.0


