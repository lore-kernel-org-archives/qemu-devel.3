Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10ECAE8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQuD-0002AX-KE; Sat, 27 Dec 2025 04:48:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQuC-00029r-0T
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQuA-0006rP-Jd
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sL1kDqNm7nTKG73R+I3DXC1EVq/1kF29j6GdAVvDY1c=;
 b=UADdbYiGJt/3m2AwE0YsGJ/9Pbis1etQ+ObXXYrtPc42mQGjgF+iiubolzeeg6U0vGD3pM
 eLmpOjduw3HvZwIqxB2eBvdz2cy0SylbdqKtQFK5p8xO5WQOPJeS2xsACzt6Cu0RXYKY41
 ooGJLWW4xCj+7nFggtb9oVBXPIWPe/U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-MM6QTmOhN4uzwfmeCVmXSA-1; Sat, 27 Dec 2025 04:48:08 -0500
X-MC-Unique: MM6QTmOhN4uzwfmeCVmXSA-1
X-Mimecast-MFC-AGG-ID: MM6QTmOhN4uzwfmeCVmXSA_1766828887
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477bf8c1413so46215415e9.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828886; x=1767433686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sL1kDqNm7nTKG73R+I3DXC1EVq/1kF29j6GdAVvDY1c=;
 b=ooR3CEyYt7mWBfJMjVYB4e4vGR6cRY+t2SU5mHaXx4wZM+pTGIXuZ1irq5h103QAgx
 uGE2a8OB90yJUWfFRgLUaQUzss9Nb9yg7UUi+xKsl3W+CjAHH+Hu2QTaY3n3AfSj1md/
 hLmOCvlV4XNybZmg3L44XDyw6MKaUKf/2GRvBuUjfzwkrMlgldU1VcPoJOPGoI0ziJ5w
 zS3RUZwYpEy+4Ze4pC/HPcik62EazySIRPruNekI2QK2yoWmBnDpKJ74072vp5HBqUU1
 xh8f7QEmPVy4fvQ82iVqG1m8M7ZcKoLXp2SHZmRCrxbWV1WsN9nvdWvi0pu8HbhMvYU/
 Rm0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828886; x=1767433686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sL1kDqNm7nTKG73R+I3DXC1EVq/1kF29j6GdAVvDY1c=;
 b=wM4Fjt6mWza4q5xXG23zBv55kWNPmr1GlRUK3e6b9tlgzjktq8iBxbUw3XczV2osY8
 FN4VdNCuNA6fGyjGWf4vuo6rE5AYzDc5YCSY0MeFcfVGHL5hGeOp4gL+FxHxm4gAmpto
 jK36mOCJmC3m5rzeHO+DAhGbkZ4qSsTTx/vwbhDr3I1szOgFb1S+X93+NtLJc1wF60QT
 MshOLIsO98z7TIYvsqEgDc9fRpEmULWqwPYEdOYjbioFk7v5AlzfeI28jDotp12Gi/RC
 3UwYe7xt2T8VcAel1oNloLULu1eGoj7ATcq7SSCzO6SNwcBrxtTQHQNpqi81TB/XGgU2
 Ce4A==
X-Gm-Message-State: AOJu0Ywvx3IP9CNJbxoSm2RgjQeo/ZTrbytyY8tGiXtfhQ8kaWID1MN0
 OPCRRVEdDD7lQV5gaFiPSRB2tiLj3DgFp0v7CooJESQ1AOWoJx72wZ5hz2yX6PZAbsBY4XVvvxn
 JjNCaRKktXWDyQWVToxzdHKkoo55DqxXF05XBWPWxCEvmhQS1nx/9bpkyRtafA7/UeoP6tqVZXE
 khOI8aeU1x5s3NpnvQvJuY/Cx/r0DCvhf4gOEtm4NF
X-Gm-Gg: AY/fxX51hQdublrQrCAJH9weaELrabVCBIqrIbaqYspH5h+ZIm69KC+/0MoIrw51k5r
 jQmjRYmTuqGFVleWjz+FxapjGIXum2nyHBngFQVrjojy/QTviIefjhePiKLqG8RqK1ov24aPsPk
 JXmC8UgqQbZtWpvP26e0ToLbGImFAyWEGUvS/HKSBz0uEEhm/Vc3yllru7muTqbSKuuYxd048ex
 +do1+R79SUbGwQ7dynQlnRSy4n0TXoXRXk0LlH2qA2gc3tA/eQtLTcwnznbbFcgLybLAuP1xwkU
 nNHG8jd2whEdpG/ewTt6tdD9C1eE1BtpBw9psZw6OTSLIr2TdulMlL8DKMTDmR1/AIPKXCkF79u
 BK/xuzdWwxICGypsTPi6DosvAn3u596xc+qoxYsIRs32H6Iu7/CBpb+gOyn1grZOirJwXGE3WO0
 NKc78/GZu2Z2siyHE=
X-Received: by 2002:a05:600c:3ba7:b0:477:7af8:c88b with SMTP id
 5b1f17b1804b1-47d1953d798mr285422205e9.11.1766828886049; 
 Sat, 27 Dec 2025 01:48:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLwVkdvFFt2c6byVjauxGdH1RcbsBNVY4ZXcAsBv86y7oLwhIuETY/161Bp6PmyTLCdej+CQ==
X-Received: by 2002:a05:600c:3ba7:b0:477:7af8:c88b with SMTP id
 5b1f17b1804b1-47d1953d798mr285421985e9.11.1766828885688; 
 Sat, 27 Dec 2025 01:48:05 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be27b28a7sm487399005e9.12.2025.12.27.01.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:48:04 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 077/153] i386/cpu: Add avx10 dependency for
 Opmask/ZMM_Hi256/Hi16_ZMM
Date: Sat, 27 Dec 2025 10:46:42 +0100
Message-ID: <20251227094759.35658-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

With feature array in ExtSaveArea, add avx10 as the second dependency
for Opmask/ZMM_Hi256/Hi16_ZMM xsave components, and drop the special
check in cpuid_has_xsave_feature().

Tested-by: Farrah Chen <farrah.chen@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251211060801.3600039-6-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 367396a216e..812a2151471 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2054,18 +2054,21 @@ ExtSaveArea x86_ext_save_areas[XSAVE_STATE_AREA_COUNT] = {
         .size = sizeof(XSaveOpmask),
         .features = {
             { FEAT_7_0_EBX,         CPUID_7_0_EBX_AVX512F },
+            { FEAT_7_1_EDX,         CPUID_7_1_EDX_AVX10   },
         },
     },
     [XSTATE_ZMM_Hi256_BIT] = {
         .size = sizeof(XSaveZMM_Hi256),
         .features = {
             { FEAT_7_0_EBX,         CPUID_7_0_EBX_AVX512F },
+            { FEAT_7_1_EDX,         CPUID_7_1_EDX_AVX10   },
         },
     },
     [XSTATE_Hi16_ZMM_BIT] = {
         .size = sizeof(XSaveHi16_ZMM),
         .features = {
             { FEAT_7_0_EBX,         CPUID_7_0_EBX_AVX512F },
+            { FEAT_7_1_EDX,         CPUID_7_1_EDX_AVX10   },
         },
     },
     [XSTATE_PKRU_BIT] = {
@@ -8648,12 +8651,6 @@ static bool cpuid_has_xsave_feature(CPUX86State *env, const ExtSaveArea *esa)
         }
     }
 
-    if (esa->features[0].index == FEAT_7_0_EBX &&
-        esa->features[0].mask == CPUID_7_0_EBX_AVX512F &&
-        (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10)) {
-        return true;
-    }
-
     return false;
 }
 
-- 
2.52.0


