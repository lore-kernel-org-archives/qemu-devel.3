Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2931E8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:49:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQus-0003Ae-S6; Sat, 27 Dec 2025 04:48:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQun-0002W6-RV
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQul-0006vy-K2
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xtYUxkEggFbHj5Y/79Ax3d/pR31qDvGvynv0eJHHmV4=;
 b=UlQFbRuHS/ZY8UR44+yhzzJy0tzDk/Se2xE1ZvLBks6VMWuWStXpW/Vo0AzI5V52/EUP/V
 m/8m4aWU3D8Iw7IK94EcF3rv7wUpTQZfMmpbOficC03279YUc1HsBoZVphv6g1G8/zAuYa
 x/wn37qDnz2vQkBnZ+LKY2gvW8hPHcE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-mVH7fOMvP6u-1icGR42qQA-1; Sat, 27 Dec 2025 04:48:44 -0500
X-MC-Unique: mVH7fOMvP6u-1icGR42qQA-1
X-Mimecast-MFC-AGG-ID: mVH7fOMvP6u-1icGR42qQA_1766828924
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43101a351c7so6166618f8f.2
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828923; x=1767433723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xtYUxkEggFbHj5Y/79Ax3d/pR31qDvGvynv0eJHHmV4=;
 b=TN7Gf+YQJuNxJMfsXI7rcePDNtB3xlPluqJLIf9/BbddWBtMiVmymnEYlUYjAs4hR6
 53UNOIXr8BeUcCuw21mNQicqyTgNKmMf7NVK4ydEFBW9OxF+zTA9s9tng+kLSADMRdHs
 74D2N0tPl8DgdRHl2+CXtr7wXz6yPaDDHKf16Xu+5wDf6UjzZ0cK4D1Pc3VRPTgI4wa0
 3o48NjuA21wWG6gnQ7QK+35WfxcU8e6LpWLMbYKHfsZRNQuhOmIYJY8q/8gK9Es3bWJc
 HfgC4R53O0KkXpeeXQAtIlM/ZoDvC3nTvW1kDrK5UXV7bKaTTbkTIjWVilrEIdNrsyPQ
 Z9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828923; x=1767433723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xtYUxkEggFbHj5Y/79Ax3d/pR31qDvGvynv0eJHHmV4=;
 b=Zmb27DcPB4HmmGlunKusAu805ARkZxNGUtg6/7URy4v7AKcMkdEAtBu8FwDExyoFPL
 v2A5GObpVagwGEqRSUnwk75OTlMWDe1rQ+ws0MaqhVpqNEDuAt/mesb7s1LQFtgnSBIW
 hI0fbnElR0g4LBqdQbmeTu6BbE62Wvhs1NymWMn3qiCJ7DOH/5pyxWOkI2DzJo9R42m0
 VjYrFJsSOtaKYGZ1RPf6ln00yv6XQ+co54BmJl84V3QETODmEgIFrIlb9tHv4rzHhh7o
 AQEynY/cMbvI0KHi5K1+CcNjrDz80ND2/jd2fp0OvdDL/pL20P47wwwpxcJxwm5fiIMN
 K+DQ==
X-Gm-Message-State: AOJu0YzZKSageLwf2EkV2flZ/gxCbT1OnV99J6GzBc8qzRwoYKIKp5i+
 IRxgzcJDFtYGV2XPyVMAQkr4MJqZFuopXvS1zN/+HfJV9QSLkNstlZ8AUTyypP+A6JMkaI2NWVa
 YWSCDS7cqLFapWvfIX9sN1qDRKGQSTN6iYLAJ0dBDPmt+JXqC6L6D9gNQpPvRfYCmkPPsjpmiDk
 nlIPERINcf6K2eAZjjtKHMcwVVxbvvmfBy0iv1hBh7
X-Gm-Gg: AY/fxX4r1oQaOCiRF6Oie0wCHWgm5hhSRgs2+y0EIULKPmNGtrHxAZpcNje49d9EO48
 P/exxMku78P6iGUxl0AWtoUlf1wAaYF1Y41UIf3ajsXspRvMNksOdOmFyDiOWVYRuJHLyLBzRWW
 I97x1N+bXyoIL9fWTlCD2/lO7RNvHjIQuvtqUknVeZkocVidaDvOVkiNGFGWBaLQJX6Fbsowtqb
 U/+aiWAXOQvahx1AgVgSqUp/RudcUneWKQuMqdvCReLUUaKxhkcHwPKUp+0f30CQQprB7idb50K
 CXR23280y9yybtkW6dtjvcDaOHLLMB9lZIRsM8h6ysgPHCQm3sSD0LHL0eyHA3zEchSsTpdrXLI
 8HuVkPDZxIAsHtZN7VscSnMH415/3qn6USkz+Av5VmvzcjqEbv/0KgAuAb5WLlh3Gmua6sQBMcs
 8PwdQELQ4U8gSPauQ=
X-Received: by 2002:a5d:58e5:0:b0:431:771:a51f with SMTP id
 ffacd0b85a97d-4324e50ada8mr24088188f8f.49.1766828922827; 
 Sat, 27 Dec 2025 01:48:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECn7mIIMG7uvcp+0t9ppY/rvMthGSWFtHmi0Rp+hHxsiXiYBom11/zROU1DFq/AZgg5UiWxQ==
X-Received: by 2002:a5d:58e5:0:b0:431:771:a51f with SMTP id
 ffacd0b85a97d-4324e50ada8mr24088167f8f.49.1766828922351; 
 Sat, 27 Dec 2025 01:48:42 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa4749sm50761655f8f.37.2025.12.27.01.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:48:41 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 093/153] i386/tdx: Fix missing spaces in tdx_xfam_deps[]
Date: Sat, 27 Dec 2025 10:46:58 +0100
Message-ID: <20251227094759.35658-19-pbonzini@redhat.com>
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

The checkpatch.pl always complains: "ERROR: space required after that
close brace '}'".

Fix this issue.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251211060801.3600039-22-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index dbf0fa2c918..a3444623657 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -520,15 +520,15 @@ typedef struct TdxXFAMDep {
  * supported.
  */
 TdxXFAMDep tdx_xfam_deps[] = {
-    { XSTATE_YMM_BIT,       { FEAT_1_ECX, CPUID_EXT_FMA }},
-    { XSTATE_YMM_BIT,       { FEAT_7_0_EBX, CPUID_7_0_EBX_AVX2 }},
-    { XSTATE_OPMASK_BIT,    { FEAT_7_0_ECX, CPUID_7_0_ECX_AVX512_VBMI}},
-    { XSTATE_OPMASK_BIT,    { FEAT_7_0_EDX, CPUID_7_0_EDX_AVX512_FP16}},
-    { XSTATE_PT_BIT,        { FEAT_7_0_EBX, CPUID_7_0_EBX_INTEL_PT}},
-    { XSTATE_PKRU_BIT,      { FEAT_7_0_ECX, CPUID_7_0_ECX_PKU}},
-    { XSTATE_XTILE_CFG_BIT, { FEAT_7_0_EDX, CPUID_7_0_EDX_AMX_BF16 }},
-    { XSTATE_XTILE_CFG_BIT, { FEAT_7_0_EDX, CPUID_7_0_EDX_AMX_TILE }},
-    { XSTATE_XTILE_CFG_BIT, { FEAT_7_0_EDX, CPUID_7_0_EDX_AMX_INT8 }},
+    { XSTATE_YMM_BIT,       { FEAT_1_ECX, CPUID_EXT_FMA } },
+    { XSTATE_YMM_BIT,       { FEAT_7_0_EBX, CPUID_7_0_EBX_AVX2 } },
+    { XSTATE_OPMASK_BIT,    { FEAT_7_0_ECX, CPUID_7_0_ECX_AVX512_VBMI } },
+    { XSTATE_OPMASK_BIT,    { FEAT_7_0_EDX, CPUID_7_0_EDX_AVX512_FP16 } },
+    { XSTATE_PT_BIT,        { FEAT_7_0_EBX, CPUID_7_0_EBX_INTEL_PT } },
+    { XSTATE_PKRU_BIT,      { FEAT_7_0_ECX, CPUID_7_0_ECX_PKU } },
+    { XSTATE_XTILE_CFG_BIT, { FEAT_7_0_EDX, CPUID_7_0_EDX_AMX_BF16 } },
+    { XSTATE_XTILE_CFG_BIT, { FEAT_7_0_EDX, CPUID_7_0_EDX_AMX_TILE } },
+    { XSTATE_XTILE_CFG_BIT, { FEAT_7_0_EDX, CPUID_7_0_EDX_AMX_INT8 } },
 };
 
 static struct kvm_cpuid_entry2 *find_in_supported_entry(uint32_t function,
-- 
2.52.0


