Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F74DC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubH2Y-0003Pv-58; Mon, 14 Jul 2025 07:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGzN-0000gu-Dz
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:04:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGzL-0001bH-KO
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YCAKi1gu8K2x7TdZzfJVxBa70394u00QgrgkAAGqfzs=;
 b=UDpb9cecbJzLG5jSWIcOunWLpYWd6b/z+Q6VBE77roDU0xZy4bRr+K8cQCKfHykuf2T0Ld
 bB3YRbKnMp+w9tea/r0n2plPOArKgUa9ryYFLywgb/sXVzOWM364cKZVdNEuP7G+RoRtP8
 jnr2KCSax3ZQZUu+oxvbTiYT432NmLA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-O_huOJh-MqaCndDdABbtbQ-1; Mon, 14 Jul 2025 07:04:49 -0400
X-MC-Unique: O_huOJh-MqaCndDdABbtbQ-1
X-Mimecast-MFC-AGG-ID: O_huOJh-MqaCndDdABbtbQ_1752491088
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4532ff43376so38559965e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491088; x=1753095888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YCAKi1gu8K2x7TdZzfJVxBa70394u00QgrgkAAGqfzs=;
 b=iq8qgAb8y/l7CEJplySDin46nJHbUk27L7ZwqOVZG4z0EQM2Wxy4UfyzAeQ7Y5cXD0
 opjkKFr/hIe8mb3M3mbA1YxWhYsTrazGPWjgIrC+gfbQziAHtk0tpMCm2wkOMFEGMVUn
 aOdpF8QvkNneM91v7hnxRKytrdUi7+tCaRQu196Ks+FfVqbcPnWuFm/WQywXIkV7macj
 xs4zcXQd5JuvIA+1Vx6cialVTu11/+8CxQB26cGW40YsI14i1ustOvvQF262fPSpx1CG
 VW9VTED9VtokL4Rg8riA2SYWO/MThXNzo5VPmV5jHPjV3cpLXXjFcaOdsbRY/S0doUSm
 KQlg==
X-Gm-Message-State: AOJu0YzmGmXdU/9Xbe9PtcrUBZAt9rehR9TB7sgMisPjPK+Wbn/OBpYK
 UCN7PLoaN1ufLa6a2Xs9exdH5yR5lI/WSC7dzF/iV9B3Uu/mLqp8kfaSE2IgFXMpEKYv1KC4pH+
 fO7WRiOmrMnL5fiCCDKqLTiCanZZ5I0pziTi1Ni2h5hosKnbv2cxlJwpUJ3JHNVh9BUANREVO9N
 x/nRz2zwo50UxagicgvkfexFq39ZSQPW+Gj2GUR4nG
X-Gm-Gg: ASbGnctJbMAD2yiWTgDuV/iBiAeTivA4Y/kPFRmOXUs6oxw2AtJNdcYbZHVHOprXJak
 izboPwrCQ/VzH8L64GVXBupx4fZ+pW+vj3Obmkc/bG2I/Z4HRCrHLMiWZJXPHy1pPvzFTSQAUcP
 LhY3F1ERYy8EFjdUx6KOeYlW6P5u5xXqe7mY2EFjwqg2+t4sai8t0lfLpE/kY6ETQcHIEaqfqFQ
 ssFKwi162mLnzklVMALGSX9b+GlwoO6S57t+Gn0IurQM1QaGiQyhz/Z7T1GmarKvnul7SUMzCZZ
 gJ+UR15Q9155xXwj/pbVJHGDREgerb/+yBQkgtqsBHA=
X-Received: by 2002:a05:600c:8483:b0:440:6a1a:d89f with SMTP id
 5b1f17b1804b1-455bd87a4a2mr101755095e9.4.1752491087729; 
 Mon, 14 Jul 2025 04:04:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIXNlYoJFMrTFvFTc1DWR87cxRqD+30d5HiNNz+93Iy1RAyoIXbfG0hnp9s3ZR08YIouSYZw==
X-Received: by 2002:a05:600c:8483:b0:440:6a1a:d89f with SMTP id
 5b1f17b1804b1-455bd87a4a2mr101754575e9.4.1752491087039; 
 Mon, 14 Jul 2025 04:04:47 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45621ec53d5sm4117005e9.2.2025.07.14.04.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:04:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 14/77] i386/tdx: Set value of <GetTdVmCallInfo> based on
 capabilities of both KVM and QEMU
Date: Mon, 14 Jul 2025 13:03:03 +0200
Message-ID: <20250714110406.117772-15-pbonzini@redhat.com>
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

KVM reports the supported TDVMCALL sub leafs in TDX capabilities.

one for kernel-supported
    TDVMCALLs (userspace can set those blindly) and one for user-supported
    TDVMCALLs (userspace can set those if it knows how to handle them)

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250703024021.3559286-4-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 8c661c3ecfd..10dfb80d22e 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -1256,14 +1256,21 @@ out_free:
     g_free(task);
 }
 
+#define SUPPORTED_TDVMCALLINFO_1_R11    (0)
+#define SUPPORTED_TDVMCALLINFO_1_R12    (0)
+
 void tdx_handle_get_tdvmcall_info(X86CPU *cpu, struct kvm_run *run)
 {
     if (run->tdx.get_tdvmcall_info.leaf != 1) {
         return;
     }
 
-    run->tdx.get_tdvmcall_info.r11 = 0;
-    run->tdx.get_tdvmcall_info.r12 = 0;
+    run->tdx.get_tdvmcall_info.r11 = (tdx_caps->user_tdvmcallinfo_1_r11 &
+                                      SUPPORTED_TDVMCALLINFO_1_R11) |
+                                      tdx_caps->kernel_tdvmcallinfo_1_r11;
+    run->tdx.get_tdvmcall_info.r12 = (tdx_caps->user_tdvmcallinfo_1_r12 &
+                                      SUPPORTED_TDVMCALLINFO_1_R12) |
+                                      tdx_caps->kernel_tdvmcallinfo_1_r12;
     run->tdx.get_tdvmcall_info.r13 = 0;
     run->tdx.get_tdvmcall_info.r14 = 0;
 
-- 
2.50.0


