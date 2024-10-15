Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE15CD216AC
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0iMc-0005V9-1x; Tue, 15 Oct 2024 10:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iMZ-0005SQ-QT
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:17:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iMY-0003Hz-97
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:17:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729001845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cuLNoeZpyQHQpICX1qEOU2ycUwWgQEohJuDmKzB9Xtc=;
 b=ZHUhs6ZJvWKM0Csu2aL99njeGzcNqXo8VYqP+b4ZTfK04xu3Z1ofZTv5Njlr14gkIfMxRc
 IaL7yqIItNSMVI3G8A3zAaYyMDupdqDfL996cCM9uLawPvLAaDHWEd2n5McD6tNLVP1xb0
 eBe0jvTFzIEKeTDN898xinK68u9iZWk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-WY1PgjYBMnStCkLukqcupg-1; Tue, 15 Oct 2024 10:17:24 -0400
X-MC-Unique: WY1PgjYBMnStCkLukqcupg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d533a484aso1959569f8f.0
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729001842; x=1729606642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cuLNoeZpyQHQpICX1qEOU2ycUwWgQEohJuDmKzB9Xtc=;
 b=TsbaxlSmRbHOlglG49xlLbEQbYFfepjFE2niJ5TRNEfJLjWfd0FrKiAyu1zYaG2BJe
 fBdREk+cTSOAESYCxoM1ugpOAQ+hU5g85uUFUJw8Bu4MQXZ5nUbDp27jWcIaksLFi47n
 KWA0Zsnf0LQloSGE/sYi/ZL9SewdZs6+hdGcKr8pn3hemuDjyJvYE5507wycu69r527G
 MWsSuq7tsB43IB7yW84Kht2EV8FMywlcW/sH1nkEOTMPJoZYc3akXjyUvkEuXep494LI
 A8KuG0yRc3PQWlG21/nwaDzdlaUFNVIiCPQyWLL2t8bXI2YcwwGlahClMxdOsuFE3IsU
 iIYw==
X-Gm-Message-State: AOJu0Yx0owjD0pkemQpzBJKaE0DA/uUKGCNtHyL51v75cEoYIOX7V2wd
 mAMYqWqsqXzclBA3wzgLbBDxAcZe2VsnMcCibpAiwzrEGZ6O3BTG28abfDLX4jddqv67XnIGEO3
 wkL9IBFiGBQxIlzDaPcLOVokXNIpjkc/JlYGcqqjh241VtX45sj9bQzpMaF9ASdozI/dYw6xLqC
 eotDeSy3hX5q+1FCCOW4LxaWVFeCKYEmqOSHHKqfE=
X-Received: by 2002:a5d:5108:0:b0:376:dbb5:10c2 with SMTP id
 ffacd0b85a97d-37d552d4a14mr11857299f8f.29.1729001842253; 
 Tue, 15 Oct 2024 07:17:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn6Ue+uQoj56Jr6tVkV1FQ2hIeCCIV+cUqZcQeyQQwdAYXipVdjZ+MHAOTyKAHA0e8DvfRJg==
X-Received: by 2002:a5d:5108:0:b0:376:dbb5:10c2 with SMTP id
 ffacd0b85a97d-37d552d4a14mr11857234f8f.29.1729001841205; 
 Tue, 15 Oct 2024 07:17:21 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa87c70sm1701141f8f.30.2024.10.15.07.17.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 07:17:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 02/25] target/i386: Enable fdp-excptn-only and zero-fcs-fds
Date: Tue, 15 Oct 2024 16:16:48 +0200
Message-ID: <20241015141711.528342-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015141711.528342-1-pbonzini@redhat.com>
References: <20241015141711.528342-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

- CPUID.(EAX=07H,ECX=0H):EBX[bit 6]: x87 FPU Data Pointer updated only
  on x87 exceptions if 1.

- CPUID.(EAX=07H,ECX=0H):EBX[bit 13]: Deprecates FPU CS and FPU DS
  values if 1. i.e., X87 FCS and FDS are always zero.

Define names for them so that they can be exposed to guest with -cpu host.

Also define the bit field MACROs so that named cpu models can add it as
well in the future.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20240814075431.339209-3-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h | 4 ++++
 target/i386/cpu.c | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 4c63e7b0459..4c84cd41fd5 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -820,6 +820,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_7_0_EBX_HLE               (1U << 4)
 /* Intel Advanced Vector Extensions 2 */
 #define CPUID_7_0_EBX_AVX2              (1U << 5)
+/* FPU data pointer updated only on x87 exceptions */
+#define CPUID_7_0_EBX_FDP_EXCPTN_ONLY (1u << 6)
 /* Supervisor-mode Execution Prevention */
 #define CPUID_7_0_EBX_SMEP              (1U << 7)
 /* 2nd Group of Advanced Bit Manipulation Extensions */
@@ -830,6 +832,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_7_0_EBX_INVPCID           (1U << 10)
 /* Restricted Transactional Memory */
 #define CPUID_7_0_EBX_RTM               (1U << 11)
+/* Zero out FPU CS and FPU DS */
+#define CPUID_7_0_EBX_ZERO_FCS_FDS      (1U << 13)
 /* Memory Protection Extension */
 #define CPUID_7_0_EBX_MPX               (1U << 14)
 /* AVX-512 Foundation */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0d30191482e..089b651591b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1054,9 +1054,9 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
             "fsgsbase", "tsc-adjust", "sgx", "bmi1",
-            "hle", "avx2", NULL, "smep",
+            "hle", "avx2", "fdp-excptn-only", "smep",
             "bmi2", "erms", "invpcid", "rtm",
-            NULL, NULL, "mpx", NULL,
+            NULL, "zero-fcs-fds", "mpx", NULL,
             "avx512f", "avx512dq", "rdseed", "adx",
             "smap", "avx512ifma", "pcommit", "clflushopt",
             "clwb", "intel-pt", "avx512pf", "avx512er",
-- 
2.46.2


