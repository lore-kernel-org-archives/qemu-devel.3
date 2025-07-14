Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DF3C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHMh-0007pP-Ak; Mon, 14 Jul 2025 07:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH0G-0001LB-UO
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH0F-0001xH-0e
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CQzDH1V4w6eVY3mbdjPDXzkRBHvX/RGaS5hAPHtGK8A=;
 b=dTrOgc5dZqijAE9M4wv1F2+5JoKaoweqk9cejiMuD4gLPT1ZinzvYbduLQhu48pnLFFunH
 SQnSSc+V7XqDjAXOnfWdqQA2rUXudYw5avbFVh8bm8LWEXdYyxx1xpKFy/XkGeV3GvNlrW
 HZgVEyLuzZ9mwjGG2Z29NSQ7D1CXFJE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-TncvK3AeNsqFMSrVHtOYGg-1; Mon, 14 Jul 2025 07:05:44 -0400
X-MC-Unique: TncvK3AeNsqFMSrVHtOYGg-1
X-Mimecast-MFC-AGG-ID: TncvK3AeNsqFMSrVHtOYGg_1752491143
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4561c67daebso2042295e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491143; x=1753095943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CQzDH1V4w6eVY3mbdjPDXzkRBHvX/RGaS5hAPHtGK8A=;
 b=MCLCYdY/Bbh0fmLuB76YYceOgIch4C+/ExO3csjbvoykfkgAz+xvPI0hVPVzbznVGT
 9+HoslWncZmN0TwIOGYiOfpY9+Jhxm+fM7SCxE/7UOV1+k6Fo+H+K8+4SjpAHXN5Uh8w
 I4yGuOHtBMBQpqsz6TVSROJE1pTlz3WdGejCyFRcmlT3t7/qJt7e5hB6xpKs/J2qJbaO
 Ec/12wym+rHZ+GXXtC0bIuHaDpkMvpZ+YfYNra9kC7+UDm2Q2f7WBvPXkIhe2NwwlJW2
 MViOfVO0ZE/eiRejrqgmeY/qyKoxD3eK9647hcRTU4bXwNFUrD7Zou8IBEmw0lYIK8eF
 k2fw==
X-Gm-Message-State: AOJu0Yyc2VWcoYVW+KeYlZcsARwcu5KYpx2HZjZjpFCyKsvOhTcM5G4k
 C6LOuZYM3CDBcA2PAWMdU8r2PfcHaTdAoQPS8rpE+sXj0oLM0lN0f/wNmwDHQ7Nzg/4FhhRIPiL
 YgYMnzOFvgmGan43XZNFldtBOQSR3luud3AC6UqnGiyWaPa5rJI/UCTSczWxEV+uZb+hAR/E2iy
 nNiHrF12NSBY6zjQ+spkeu8zUsFRfT7U8oYxyt2rk3
X-Gm-Gg: ASbGnctpxysYMyIlpqVc2eRpoNpI6R0HyH5GoR7Ep2XksiwrFAQeWTsHJZtGLfwk4Pe
 ExAMj2SjZ5p/8+XRapcCSLV+06xdciTIR0Z8w9CTpOrkiVHYrVzb4/+HUJVs03gq5FLo0zkKZMU
 grPsUvnqmLRnDHKdcyC7/g8zt3TtNtNV5YcdXtZQP4OgYjVi1Ui8b4AW4kZk48t0GCLgNSy+94C
 3tNq+MJvvFCic+oabm9PVuAGeb6O6QrSugVPj+Dx8s9xPOH6MQNSQXd7Shk236CsvIgcJurg5L2
 jS9pQs47wnZtdUSNbQrHNOmIR1Wic4s1C6ruGvCr2y8=
X-Received: by 2002:a05:600c:5022:b0:456:1281:f8dd with SMTP id
 5b1f17b1804b1-4561281fc0dmr46043795e9.12.1752491142634; 
 Mon, 14 Jul 2025 04:05:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/i1joJjKHQdVeA51bGJrmR0fd4lmxgJshWvIulSYTWabOLmt+EDoNoFh6zLwZt4g99z0Chg==
X-Received: by 2002:a05:600c:5022:b0:456:1281:f8dd with SMTP id
 5b1f17b1804b1-4561281fc0dmr46043405e9.12.1752491142069; 
 Mon, 14 Jul 2025 04:05:42 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e1e285sm11945093f8f.76.2025.07.14.04.05.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:05:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 35/77] i386: Cleanup the usage of CPUID_VENDOR_INTEL_1
Date: Mon, 14 Jul 2025 13:03:24 +0200
Message-ID: <20250714110406.117772-36-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

There are code using "env->cpuid_vendor1 == CPUID_VENDOR_INTEL_1" to
check if it is Intel vcpu. Cleanup them to just use IS_INTEL_CPU()

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250630080610.3151956-3-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c                | 2 +-
 target/i386/tcg/decode-new.c.inc | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 70b742fcdeb..d3d13b14726 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7761,7 +7761,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         *ecx = env->features[FEAT_8000_0001_ECX];
         *edx = env->features[FEAT_8000_0001_EDX];
 
-        if (tcg_enabled() && env->cpuid_vendor1 == CPUID_VENDOR_INTEL_1 &&
+        if (tcg_enabled() && IS_INTEL_CPU(env) &&
             !(env->hflags & HF_LMA_MASK)) {
             *edx &= ~CPUID_EXT2_SYSCALL;
         }
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 55216e0d249..853b1c8bf95 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2722,14 +2722,14 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
             if (decode.e.check & X86_CHECK_i64) {
                 goto illegal_op;
             }
-            if ((decode.e.check & X86_CHECK_i64_amd) && env->cpuid_vendor1 != CPUID_VENDOR_INTEL_1) {
+            if ((decode.e.check & X86_CHECK_i64_amd) && !IS_INTEL_CPU(env)) {
                 goto illegal_op;
             }
         } else {
             if (decode.e.check & X86_CHECK_o64) {
                 goto illegal_op;
             }
-            if ((decode.e.check & X86_CHECK_o64_intel) && env->cpuid_vendor1 == CPUID_VENDOR_INTEL_1) {
+            if ((decode.e.check & X86_CHECK_o64_intel) && IS_INTEL_CPU(env)) {
                 goto illegal_op;
             }
         }
-- 
2.50.0


