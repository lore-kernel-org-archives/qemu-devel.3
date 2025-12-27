Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19C0E8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:24:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQRr-0000zg-RE; Sat, 27 Dec 2025 04:18:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQRp-0000i0-Lz
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQRn-0004Sm-QK
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QLDG/mu3345byp5m3TmLYz4W6m4rlJhi1efMLR5uavA=;
 b=WfWvrBKKoiRKjhqLzziS3ZxMtDVFCoPJmsCUySXDBUl4lehsaER+HXz25VaQmTLTSF6+/u
 bco3sFNVr/rqWWjEuSba/zJ9RujSIL0b48rEum68eWuV64SZhbsuAIEsQpJyHe9qetteBo
 AyGsPDbvwIWz3t8XIZDf+1JW6qjKUSI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-ZC1FiFcUN228m1Z-M_oWhA-1; Sat, 27 Dec 2025 04:18:49 -0500
X-MC-Unique: ZC1FiFcUN228m1Z-M_oWhA-1
X-Mimecast-MFC-AGG-ID: ZC1FiFcUN228m1Z-M_oWhA_1766827128
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4776079ada3so70687555e9.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827127; x=1767431927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QLDG/mu3345byp5m3TmLYz4W6m4rlJhi1efMLR5uavA=;
 b=Y4mdILSYdtLcCDEiEI7gAY6RTzNad790/492qD/FMPC8xHX3FTpGIoEf4NKX+v0Sf/
 EZoTZKsfAL+Z8aEvKYlVqWcYxrPUMxER3Se7ALwndU6deV/v9+2vofV2B6h02skAqDLc
 cK6Atebdg0fO9Mkw08KE2oVCs0IVh0Dwx6ThSvdCIJcugdh+EZ6o625BBUa1pNlThywH
 bCGI7iTgY2LVPyeNESVZf/OLzRV/+hqScztIFyXFmSu9U/jhJ/9+eyi984Qh2sLpYALD
 DN5BbqKMbZ/lW6akwoIj4q31McKbVpdBigmuTzw0Cb10Cxcm6aU4eKDvsASG5X3HiCkg
 boRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827127; x=1767431927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QLDG/mu3345byp5m3TmLYz4W6m4rlJhi1efMLR5uavA=;
 b=l0exxbPbbCnkdW1BtQY311sOxolqItQhrEq+Ayga6nyRINu9PZ6jFpb2WnqvZMBMlO
 JpAwY64HopNaxT2cAKr3i2pp6nR7qoY1BVWLopBIG1cBw7q39dU+IiXW8FMZ8jG5Mzol
 ngwuB0qKk0F385GeR1dvZNjsjuse1tcYcndfTztWkYpyeKorH3H6RdTILvw+7vFu0JNY
 NxUgKEGLhyNTAmrV9ipi2w6Yfjt5iAsx+c48+N4UkQFjj1eazW5zEboVpz3IKWNwqW1K
 MDRD/SsWkYdFz79j9VgLk4Nqii+W/oJqlKjSn7FBTTK3Bavjhzx7y32Q++bBuQVHwXo2
 LuYQ==
X-Gm-Message-State: AOJu0YzAGF7u85XY21h0KHh+wnGlvptZVAFQbbk6R1eAIP36b8Ne+Iq2
 49Vs68HtvQls14rYNOdUTjQytq0+M0TKnZdVyAWe18UjelkRcgTSYBei+gyIIw+H7BVR+8PalLf
 CINqkl8fUkEFrgkDq/a93FKNOcRrx1W1sefU2V2Xkke9QyLVRjxuXQnDXhhPxCP3TGpQy7zG6LP
 seFoNCF0YQOAn78ju2Hb0TaDxswGq7OZuSA+2geR5C
X-Gm-Gg: AY/fxX5WvfC0Ky0jx8wSicGChBlx1Wry05/IpCsSVuZdNz+NGKiSmeeGI+W3H/cTzXM
 W0F486oLKATGqXnSuipt/9BYSRcDUN9rM6E/pl1AGsqy9XKhUZz/e9gs658hBcfdhzafNGOE2MS
 najUzZ9GIY61Sl9UiaO0Mw+1ECFmUBhim8Q3+7EZpPgDJmXQIUZrJ38Qa25xmpvWrJESb/1cGs4
 UzqoyiOExKbjoKYHxquqYNzzd1TC1f5CzAWNV/315hxjrgRrJiw/CRBqH04bkp61psZR52Rl6we
 7bC5c/LFgMngTVFIHAtOqtRKEjBoLu7V+PBKYusthLc46+pIJbt6RRtzf6uwQeBaE7hNqHtEaPM
 xK4FW8PINqKCYM7gfGxeoEkN26+Gn/NLpzb6UDa2MEFFxV0Buqf9ydhJdXuWg0uiksKR5+z6Img
 d0n8+tO6YC5WaxTQQ=
X-Received: by 2002:a05:600d:4453:10b0:47d:2093:649f with SMTP id
 5b1f17b1804b1-47d2093660fmr182024115e9.8.1766827127220; 
 Sat, 27 Dec 2025 01:18:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHROktWE4utAdCy0tq+mXNPChgtU/N53C/k2gSXjy+OGJVISmWCDeT5VAAMQEhg4v8zH3O61g==
X-Received: by 2002:a05:600d:4453:10b0:47d:2093:649f with SMTP id
 5b1f17b1804b1-47d2093660fmr182023915e9.8.1766827126727; 
 Sat, 27 Dec 2025 01:18:46 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193cba81sm426762775e9.10.2025.12.27.01.18.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:18:45 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 073/153] i386/cpu: Clean up indent style of x86_ext_save_areas[]
Date: Sat, 27 Dec 2025 10:15:00 +0100
Message-ID: <20251227091622.20725-74-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

The indentation style in `x86_ext_save_areas[]` is extremely
inconsistent. Clean it up to ensure a uniform style.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251211060801.3600039-2-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 58 +++++++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index fe52538723b..a1de82b92c7 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2028,38 +2028,46 @@ ExtSaveArea x86_ext_save_areas[XSAVE_STATE_AREA_COUNT] = {
         .feature = FEAT_1_ECX, .bits = CPUID_EXT_XSAVE,
         .size = sizeof(X86LegacyXSaveArea) + sizeof(X86XSaveHeader),
     },
-    [XSTATE_YMM_BIT] =
-          { .feature = FEAT_1_ECX, .bits = CPUID_EXT_AVX,
-            .size = sizeof(XSaveAVX) },
-    [XSTATE_BNDREGS_BIT] =
-          { .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_MPX,
-            .size = sizeof(XSaveBNDREG)  },
-    [XSTATE_BNDCSR_BIT] =
-          { .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_MPX,
-            .size = sizeof(XSaveBNDCSR)  },
-    [XSTATE_OPMASK_BIT] =
-          { .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_AVX512F,
-            .size = sizeof(XSaveOpmask) },
-    [XSTATE_ZMM_Hi256_BIT] =
-          { .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_AVX512F,
-            .size = sizeof(XSaveZMM_Hi256) },
-    [XSTATE_Hi16_ZMM_BIT] =
-          { .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_AVX512F,
-            .size = sizeof(XSaveHi16_ZMM) },
-    [XSTATE_PKRU_BIT] =
-          { .feature = FEAT_7_0_ECX, .bits = CPUID_7_0_ECX_PKU,
-            .size = sizeof(XSavePKRU) },
+    [XSTATE_YMM_BIT] = {
+        .feature = FEAT_1_ECX, .bits = CPUID_EXT_AVX,
+        .size = sizeof(XSaveAVX),
+    },
+    [XSTATE_BNDREGS_BIT] = {
+        .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_MPX,
+        .size = sizeof(XSaveBNDREG),
+    },
+    [XSTATE_BNDCSR_BIT] = {
+        .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_MPX,
+        .size = sizeof(XSaveBNDCSR),
+    },
+    [XSTATE_OPMASK_BIT] = {
+        .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_AVX512F,
+        .size = sizeof(XSaveOpmask),
+    },
+    [XSTATE_ZMM_Hi256_BIT] = {
+        .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_AVX512F,
+        .size = sizeof(XSaveZMM_Hi256),
+    },
+    [XSTATE_Hi16_ZMM_BIT] = {
+        .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_AVX512F,
+        .size = sizeof(XSaveHi16_ZMM),
+    },
+    [XSTATE_PKRU_BIT] = {
+        .feature = FEAT_7_0_ECX, .bits = CPUID_7_0_ECX_PKU,
+        .size = sizeof(XSavePKRU),
+    },
     [XSTATE_ARCH_LBR_BIT] = {
-            .feature = FEAT_7_0_EDX, .bits = CPUID_7_0_EDX_ARCH_LBR,
-            .offset = 0 /*supervisor mode component, offset = 0 */,
-            .size = sizeof(XSavesArchLBR) },
+        .feature = FEAT_7_0_EDX, .bits = CPUID_7_0_EDX_ARCH_LBR,
+        .offset = 0 /*supervisor mode component, offset = 0 */,
+        .size = sizeof(XSavesArchLBR),
+    },
     [XSTATE_XTILE_CFG_BIT] = {
         .feature = FEAT_7_0_EDX, .bits = CPUID_7_0_EDX_AMX_TILE,
         .size = sizeof(XSaveXTILECFG),
     },
     [XSTATE_XTILE_DATA_BIT] = {
         .feature = FEAT_7_0_EDX, .bits = CPUID_7_0_EDX_AMX_TILE,
-        .size = sizeof(XSaveXTILEDATA)
+        .size = sizeof(XSaveXTILEDATA),
     },
 };
 
-- 
2.52.0


