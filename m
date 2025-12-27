Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C10E8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQRt-0001El-Bn; Sat, 27 Dec 2025 04:18:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQRr-0000yc-L1
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQRp-0004Uh-My
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J25vunL87AyvdpBRg+pj1dyV40vixOMAuev4scCnlOg=;
 b=PEzA2HOv6iKesB2FX5/RSxsoUxDKQv3gBLiksKgotiCbOsVq0UeFA3uPxqh0VALEEaZznV
 sJD4aVuL5STbegouqHUy8bN/9yc7AA4HYrhS8AsJtm8Dcgc3gX9ddeYUfKvTesarkNG0CP
 ya2e4GWS7HTLprFH2sSf4czZV0W9cJc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-oPmPdGV1PUC30CwWxUpt5A-1; Sat, 27 Dec 2025 04:18:51 -0500
X-MC-Unique: oPmPdGV1PUC30CwWxUpt5A-1
X-Mimecast-MFC-AGG-ID: oPmPdGV1PUC30CwWxUpt5A_1766827130
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47777158a85so88673625e9.3
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827130; x=1767431930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J25vunL87AyvdpBRg+pj1dyV40vixOMAuev4scCnlOg=;
 b=idrQTWWdNbNhKWWOz6eDx5vvzcLn7moN2FT7OpxHc8hkbQCPHZLK76DrmuqcxLLqXc
 f/fwQ1sYsBUAx0wP/HB5XUiZzplvNKAkT5//GHAKbBAuDJ4HTR9YG45df0LYGdztpu9Y
 okq8GbOf/j4t7NO64czS/vDKqAyyKVQ8zumVmZvrNQ9/pwHiHlZsRSLRpXR44S0AL1Dl
 XeT8y3IdAKSG5iZXg5ukgBcI8cDd13zpJDdKu9/qOnJdvmXWEi5gmnrV4AhIjtJTAUGh
 doKKDalgs6lX8cnZ7Rj7tByUptXrZ8u+SUcMMFl3uJkFwkqRoMWYfxqp3ZUi/YmrDDDx
 z7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827130; x=1767431930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J25vunL87AyvdpBRg+pj1dyV40vixOMAuev4scCnlOg=;
 b=Yzbr5zmZsUa0u9gJQc7EC6r4sNs1vThoh2hAI07k8YARwgXkVUtJyr/9Is3JiJRWiG
 zsCbiH39hLe2mHbKzWGCtw+We0Oju/Wy7ev0Fmcj+8konci5RaB6fRRFje8nStUaB61k
 2qrxVEg+SjAAJwymQE8NRM8kk6TOx4f7Bvmzq/3/LAOBBZH6dlu4hZRdagMn1rP9r07m
 F23FnpKoMNUNR8VZDISxScs9qkV5sEuSE3XfUiLtWdZSm+oU2w4sP5lwDZowpurQrWAY
 0dGzN3V32yeY/DcEghL43bFD5Ev/eslsVhEVTGU41R7Pqw873HFXZxtIAFPrfEzE+uOQ
 jFfw==
X-Gm-Message-State: AOJu0YwmFRsBpAw8IoaFOnIgH/UNIc7UhVehabRTvskTzRxSqg62O27m
 Cfj+hvMWjnTAx8swMJcQFriyHg3BLJqLkzQQUmbUbK7pKCm+hWf+Q5sRYshn2tdq3l+dRk6l6MD
 AI0Uxe0ZdWNnauWoDUR38uFMhKlG4TsRHvOIiGehTrSaf7cNeLGkTTKuzPJDrkH0EBw28ugIltH
 YtvcitQ7aacIfAQI3KrRbNgi1cfWvPwxepHVZBQtng
X-Gm-Gg: AY/fxX7y9UXJcAah8LwPdyaHcIyaC7o7GL0hcRXFicnyELeKo+IZ1AgXIR0hIFTlONA
 3GtxI0GnGKBMau9mAILH9FFhn/a9eaoierelESTrk1BwYI6FyElb8NVGl0TvIM2I3OLBnSN9L0v
 PeTQcGytzHUDbYcuL7G0lVt5WNHq+gMHZf/siDTIb1RR3soN30hige479nmwG9w6KfE0OMjIN6l
 gLcRdo3Y1lxzeFlK7Q/aM6IwSMbd8GPJh8E+fibqnCcyCYFwF1X+KZdZwBr2AoTNM/CtxuBdfqA
 c7sLBABvdN1YD06f3Z2vQk2pdN2/CrGWmETMgVerEE2Iqq+xa6xFbYKdrj29ByAK6om0TTJmsmd
 kjUkbwXZPaPzQOXhLUYRn9soR7UzRrgdmMhtN8yKir3Q0dZC8CnOblC7ZV+SMh340Xgv+GxlzfZ
 +rmKtSTr2EWZB50G4=
X-Received: by 2002:a05:600c:4711:b0:47a:9560:5944 with SMTP id
 5b1f17b1804b1-47d195c1a71mr305956875e9.34.1766827129928; 
 Sat, 27 Dec 2025 01:18:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpIjSCRhI6ULWCTlHJ+qzoMyWijns64sX3ZDzLys//wvgq1UHbFifCoz0s3IstI+AdWVOYVA==
X-Received: by 2002:a05:600c:4711:b0:47a:9560:5944 with SMTP id
 5b1f17b1804b1-47d195c1a71mr305956615e9.34.1766827129503; 
 Sat, 27 Dec 2025 01:18:49 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3aea77bsm188468025e9.17.2025.12.27.01.18.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:18:47 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 074/153] i386/cpu: Clean up arch lbr xsave struct and comment
Date: Sat, 27 Dec 2025 10:15:01 +0100
Message-ID: <20251227091622.20725-75-pbonzini@redhat.com>
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

Arch LBR state is area 15, not 19. Fix this comment. And considerring
other areas don't mention user or supervisor state, for consistent
style, remove "Supervisor mode" from its comment.

Moreover, rename XSavesArchLBR to XSaveArchLBR since there's no need to
emphasize XSAVES in naming; the XSAVE related structure is mainly
used to represent memory layout.

In addition, arch lbr specifies its offset of xsave component as 0. But
this cannot help on anything. The offset of ExtSaveArea is initialized
by accelerators (e.g., hvf_cpu_xsave_init(), kvm_cpu_xsave_init() and
x86_tcg_cpu_xsave_init()), so explicitly setting the offset doesn't
work and CPUID 0xD encoding has already ensure supervisor states won't
have non-zero offsets. Drop the offset initialization and its comment
from the xsave area of arch lbr.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Reviewed-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251211060801.3600039-3-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h | 8 ++++----
 target/i386/cpu.c | 3 +--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index cee1f692a1c..c95b772719c 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1747,15 +1747,15 @@ typedef struct {
 
 #define ARCH_LBR_NR_ENTRIES            32
 
-/* Ext. save area 19: Supervisor mode Arch LBR state */
-typedef struct XSavesArchLBR {
+/* Ext. save area 15: Arch LBR state */
+typedef struct XSaveArchLBR {
     uint64_t lbr_ctl;
     uint64_t lbr_depth;
     uint64_t ler_from;
     uint64_t ler_to;
     uint64_t ler_info;
     LBREntry lbr_records[ARCH_LBR_NR_ENTRIES];
-} XSavesArchLBR;
+} XSaveArchLBR;
 
 QEMU_BUILD_BUG_ON(sizeof(XSaveAVX) != 0x100);
 QEMU_BUILD_BUG_ON(sizeof(XSaveBNDREG) != 0x40);
@@ -1766,7 +1766,7 @@ QEMU_BUILD_BUG_ON(sizeof(XSaveHi16_ZMM) != 0x400);
 QEMU_BUILD_BUG_ON(sizeof(XSavePKRU) != 0x8);
 QEMU_BUILD_BUG_ON(sizeof(XSaveXTILECFG) != 0x40);
 QEMU_BUILD_BUG_ON(sizeof(XSaveXTILEDATA) != 0x2000);
-QEMU_BUILD_BUG_ON(sizeof(XSavesArchLBR) != 0x328);
+QEMU_BUILD_BUG_ON(sizeof(XSaveArchLBR) != 0x328);
 
 typedef struct ExtSaveArea {
     uint32_t feature, bits;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a1de82b92c7..de4e5c57746 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2058,8 +2058,7 @@ ExtSaveArea x86_ext_save_areas[XSAVE_STATE_AREA_COUNT] = {
     },
     [XSTATE_ARCH_LBR_BIT] = {
         .feature = FEAT_7_0_EDX, .bits = CPUID_7_0_EDX_ARCH_LBR,
-        .offset = 0 /*supervisor mode component, offset = 0 */,
-        .size = sizeof(XSavesArchLBR),
+        .size = sizeof(XSaveArchLBR),
     },
     [XSTATE_XTILE_CFG_BIT] = {
         .feature = FEAT_7_0_EDX, .bits = CPUID_7_0_EDX_AMX_TILE,
-- 
2.52.0


