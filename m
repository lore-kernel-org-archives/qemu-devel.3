Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 459AB105A583
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 11:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0dr8-0003rG-Et; Thu, 12 Mar 2026 07:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0dqk-0003gb-Ly
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 07:05:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0dqj-0000Kc-0D
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 07:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773313504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rFL3Y/cHAsDejQqnEMIB2YNmI1+eobXAdT0omesOx6E=;
 b=C2OQ/IH1dwTPLNJIwM8qiLm3eOAx8IfAlY/XH1oQnWYxkCebN87s6Kwt3SEU1JeipQL2yL
 8OxylJ/e6HlF/mz5RhFEG6idY719JB4kODiIOD85y6S2GCFS9sm3j4XXtSt0AfmmQEfG4i
 eZEhlDuaI9ITOIeeb84o0QVYG54ghd8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-UGv49UX6OHWoaHv5ZpuZFQ-1; Thu, 12 Mar 2026 07:05:02 -0400
X-MC-Unique: UGv49UX6OHWoaHv5ZpuZFQ-1
X-Mimecast-MFC-AGG-ID: UGv49UX6OHWoaHv5ZpuZFQ_1773313501
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4853ab1cae0so8262405e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 04:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773313501; x=1773918301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rFL3Y/cHAsDejQqnEMIB2YNmI1+eobXAdT0omesOx6E=;
 b=ZE3jONTiC//K0ijcnSfYh6zm5TN4jJYjW3B9QXOuLhSGBaX3DHCEEoxDAnJDvLKCZs
 NWY7A/wnFSf5YeDGC8gJQw3KC91qOHoBiNMUnvpDcVo44yuu3aok8uhaGf0LONo/pffY
 azBx0GOu6yNWROXeajOKDdSnUJY6Ztbbgb40ULMe77JEzxfJ0TDypiyY3hKF2UMw549e
 LjHwWpsHmXbz+BrcbITpHHaP4uPH0j7JWpZEkJAbY1hRrEm76AsrjV3ixW98vUbBAMJW
 y8y7hYa0qOQ5Qv4SXFp0Z8t8Jj5pldqQ9/H84MR4yNKJeqEG73sVD68Aj1mIfIk9ZSZl
 WTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773313501; x=1773918301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rFL3Y/cHAsDejQqnEMIB2YNmI1+eobXAdT0omesOx6E=;
 b=Pl6He3oqRuLCCF7Dpv1gV6fgXoC/sm8Fw/kTiSupsOvBWGknAMAx2L87g2OfmngPoJ
 UoAmFpm5GNQrOMpxBHmIcp93YJpWx0MB6DxsnTQXA/Vi/RynERuTkgDnhS6/J7CZVnpu
 RY22ni0KIMIp4EnRpezxSph6LoY744zMyapv1SbZA6vVOov0sd53diVzghO0+KF05XeD
 vTRwRYnA6P7CI6PSHQMymz+auQIuO/iORS6XI2aOMbxU6O/Feqbt04bFZ4HqdNPd4nt6
 rajlS9mILgjwxLxmKnzoiSVPnYwUXshGnr+3TRzhDT6sgkGO9FBca4CPecJh5vtds8Nq
 5WMw==
X-Gm-Message-State: AOJu0Yy/mHnLoGHGQxGoZxprD2EQ2hUzOUGA8tssQViPiUtis4DinFRc
 2F7yKVvCvAXYJuu37frk7BEcnXRlriUimAY9Q2uiAupXdJoqKpDHnezddKobd2+2M3UXuwNY8BW
 b6hGF2OZMJ4PyC9xSxx7Gv9aX+S347QifA/tOJwcPfTHPuXRLVKnAH+UEflnH/rR5Cqr3oquhS4
 YtpeCFpYGOo8xtiNMDT22S2w7gP0nlAMtWxphxm/YK
X-Gm-Gg: ATEYQzwRKKtBIeyIxTRzppZmDKFYyUmwxKXVWZw1qLQ6hZo0CF16SHywQ+DO1otoyv2
 IebxtV6fBSXBv12GjQsU3KjJWO+Jaaz4GJt8lo+ZH5oPqPvrRUg+TWx/Y0vSta7gg6tghBRz67G
 8hGe3VpAt2HzCu6ALea1b/4IoJK5JpE8HlKW1eoaO991T0IEbP7q8hEPuZ5NzS4ss9I7y1pvxAo
 uzl7DDU8KmH82hjK28yo+9ONX9NjmAC3PD/B8oAhWuVf7Cyd9L3UPHcaLcWq9293qj7fauANhtx
 ucXm5lTs9CfH23Yf3wx0/2SprO52N5RvakQOHF+KsDgJEDzQ+8tS6BRftPqSwtVs0iZG7RKboH/
 Jqsw8AFbkCdbB/nSWgbzMeU5HLTSOK7Md4CVmunMEuTUsywcskAwMmULpx8Uzsf8jWKtgpfdGXu
 5t8o/dDJT+FfV9JCNb3G+yvjJPTOE=
X-Received: by 2002:a05:600c:444d:b0:485:3b5b:eb8 with SMTP id
 5b1f17b1804b1-4854b117bf7mr97804255e9.26.1773313500583; 
 Thu, 12 Mar 2026 04:05:00 -0700 (PDT)
X-Received: by 2002:a05:600c:444d:b0:485:3b5b:eb8 with SMTP id
 5b1f17b1804b1-4854b117bf7mr97803595e9.26.1773313499974; 
 Thu, 12 Mar 2026 04:04:59 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541b7f3cdsm250260625e9.14.2026.03.12.04.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 04:04:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 02/14] i386/cpu: Rename AMX mirror cpuid macros with _ALIAS
 suffix
Date: Thu, 12 Mar 2026 12:04:34 +0100
Message-ID: <20260312110451.685161-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312110451.685161-1-pbonzini@redhat.com>
References: <20260312110451.685161-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

For the similar case - CPUID_EXT2_AMD_ALIASES, the term "alias" has
already been used. Therefore, reintroducing the new term "mirror" is
likely to cause confusion.

Rename the relevant CPUID macros of AMX with _ALIAS suffix, aligning
with KVM's naming convention.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20260310140819.1563084-2-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h | 16 ++++++++--------
 target/i386/cpu.c |  6 +++---
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 5a62aa61579..7bd38f0c039 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1098,14 +1098,14 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 /* Packets which contain IP payload have LIP values */
 #define CPUID_14_0_ECX_LIP              (1U << 31)
 
-/* AMX_INT8 instruction (mirror of CPUID_7_0_EDX_AMX_INT8) */
-#define CPUID_1E_1_EAX_AMX_INT8_MIRROR      (1U << 0)
-/* AMX_BF16 instruction (mirror of CPUID_7_0_EDX_AMX_BF16) */
-#define CPUID_1E_1_EAX_AMX_BF16_MIRROR      (1U << 1)
-/* AMX_COMPLEX instruction (mirror of CPUID_7_1_EDX_AMX_COMPLEX) */
-#define CPUID_1E_1_EAX_AMX_COMPLEX_MIRROR   (1U << 2)
-/* AMX_FP16 instruction (mirror of CPUID_7_1_EAX_AMX_FP16) */
-#define CPUID_1E_1_EAX_AMX_FP16_MIRROR      (1U << 3)
+/* AMX_INT8 instruction (alias of CPUID_7_0_EDX_AMX_INT8) */
+#define CPUID_1E_1_EAX_AMX_INT8_ALIAS      (1U << 0)
+/* AMX_BF16 instruction (alias of CPUID_7_0_EDX_AMX_BF16) */
+#define CPUID_1E_1_EAX_AMX_BF16_ALIAS      (1U << 1)
+/* AMX_COMPLEX instruction (alias of CPUID_7_1_EDX_AMX_COMPLEX) */
+#define CPUID_1E_1_EAX_AMX_COMPLEX_ALIAS   (1U << 2)
+/* AMX_FP16 instruction (alias of CPUID_7_1_EAX_AMX_FP16) */
+#define CPUID_1E_1_EAX_AMX_FP16_ALIAS      (1U << 3)
 /* AMX_FP8 instruction */
 #define CPUID_1E_1_EAX_AMX_FP8              (1U << 4)
 /* AMX_TF32 instruction */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0a29ff805fa..e35701b93ba 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5550,9 +5550,9 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
             CPUID_XSAVE_XGETBV1 | CPUID_XSAVE_XSAVES | CPUID_D_1_EAX_XFD,
         .features[FEAT_1E_1_EAX] =
-            CPUID_1E_1_EAX_AMX_INT8_MIRROR | CPUID_1E_1_EAX_AMX_BF16_MIRROR |
-            CPUID_1E_1_EAX_AMX_COMPLEX_MIRROR |
-            CPUID_1E_1_EAX_AMX_FP16_MIRROR | CPUID_1E_1_EAX_AMX_FP8 |
+            CPUID_1E_1_EAX_AMX_INT8_ALIAS | CPUID_1E_1_EAX_AMX_BF16_ALIAS |
+            CPUID_1E_1_EAX_AMX_COMPLEX_ALIAS |
+            CPUID_1E_1_EAX_AMX_FP16_ALIAS | CPUID_1E_1_EAX_AMX_FP8 |
             CPUID_1E_1_EAX_AMX_TF32 | CPUID_1E_1_EAX_AMX_AVX512 |
             CPUID_1E_1_EAX_AMX_MOVRS,
         .features[FEAT_29_0_EBX] = CPUID_29_0_EBX_APX_NCI_NDD_NF,
-- 
2.53.0


