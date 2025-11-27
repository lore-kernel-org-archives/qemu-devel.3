Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E24CBD111A8
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObqQ-0002Ye-O6; Thu, 27 Nov 2025 08:15:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqM-0002Y1-Ry
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:15:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqJ-0001B0-M1
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:15:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764249327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J6yV2ugWSQyxugBrT4c6BtU88GZrRVXnneMuP01QvJk=;
 b=ESM4wLARhFaMHprejIETos1nS1ejmmjgMV5Ty3dxrKJU+GmjMDP2ySEXUG7y0m+UmqCuvE
 INYMcv5jgTLq4suGxhokNBW+wdzUWzuPrRm6qUT5G/cNyQh8XML8tw2whu9Wu+ihbaH0AW
 pXi+4W9wdmeqB1EcfSYggDygbAwRXJ0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-A62_lV20MoGVPiepgnQnJg-1; Thu, 27 Nov 2025 08:15:25 -0500
X-MC-Unique: A62_lV20MoGVPiepgnQnJg-1
X-Mimecast-MFC-AGG-ID: A62_lV20MoGVPiepgnQnJg_1764249324
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b733b21a138so90601866b.1
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764249324; x=1764854124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=J6yV2ugWSQyxugBrT4c6BtU88GZrRVXnneMuP01QvJk=;
 b=H9ZCrGgzwDt8cI6nUBOeGr97vrT77z5EUm1oc/43Fr1yMyEEmyN+iHu6X47DRNWPY7
 yFdVi4yGLTT3IpzygkPHPKuPj3t4ajsQaR1GPIlRvJbgB/4ayQs71aG/rJEsKWcHMIpQ
 0nrn9RxNJgDFF8nztqKT1UqzttksHPYvnrvEIh+bUNcp+WeZe8PJmV/rKn5a5ye2Zam3
 PdmjeNviRQVrByx67YhXnyIcWslwd74kfqTr3+cVhRzRr4WUAL9/NCYYogta1llc6kAN
 eU5HEDLbekfh2A+Kuzp7DZmbGpbktx8O9n8YrZhZkXCdaDiSaejXthjULf5qfVYImIBE
 qkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764249324; x=1764854124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=J6yV2ugWSQyxugBrT4c6BtU88GZrRVXnneMuP01QvJk=;
 b=OO5ZGlWhtHJe6cNcWQvE/P2WeoJddHFrfzFxmwEbxG8/Lbdz0SdvpCie/83b/lcmih
 3Cj8tt7UnPwPiGkVARKsOfi12SO1V4u381QDTKdoyQkscR3io/IXaFAa8u5PV/Z+169n
 O8qxnIQiwkf+dwhL5R12fq7uTQrJfP4JSf18HIGU3IPjwx/fjNXv8BLdB4UAwCuIHPD4
 QNkNwxb1fM/mqcifi7BgFiPwP/3WCnqjPbzpcaaDIV26xs/e1UX79p3f2ttCRKTE0C0s
 iOCGSqWuYgBFfYKrHuyTkJDHO9IO5qa8CRyqBbt83WRJ8/d7orQC81qau2WVjWMHAHBx
 c99w==
X-Gm-Message-State: AOJu0YzNuaRgWsEbw+seFQTqdPfPIIzR0S3dR+pNjywpPXJQTH/4HkDL
 1LcYYiqHW3ALiwJEwMSz7LwpSf9riHuXhkQMOoasmxib/TvIW2md+q9YcjNO3vMrnBLK6DUY9PT
 rqqhddGCgsShVHir/wocSPICTsE1E8abrgH3AupGqKBzpU53B57TXQkv5YnnQeRrgZlD6y4/tdl
 wDTwqJeAs16eLUescj1vIJWck8Hc8r1zd/rrpM4WLX
X-Gm-Gg: ASbGncttMcy5LnPQ0rReqXauhAh3bjyUKelPRQjXGMUjEivXbQ5Utj0D230PlTFAAN9
 lCYIA9vNq3C7/gI6KGNDYiBFFvmN/0gUWwKs6I+gcYUCz+cmDe9zVunzdr2KCSnZ7uD3cxM4tPi
 J1GSbRDsdR2ISmXBi0wh2S/DQa/Gy52cUBjJKpe06ffTUEW8qkVub4sIgfHdAUWoW17UiIp/2dF
 JmNx8c+dUTtALy6Vzh5PXagngSAsJIzx0Y4j9ARvIEopPdkxFEfqDpXRoT6UQE8Mg/q0oYCbBw/
 ZecuQJtjbkS5JY8L4mEBBYNB0NuMV+MCS7XjO0ng5ezRLsEwHrsdlfU3Ybaj4ZKSscUjYqoCAEW
 Aby5/cxbqH6DyHhuk+9B92oPW+pp9hAHst6cchKeKDjs4ICU2AB9ik1dpDWSKps08VRufQulzgl
 EADDTXDkSUb0YiBxk=
X-Received: by 2002:a17:906:b84b:b0:b76:7b85:f630 with SMTP id
 a640c23a62f3a-b767b8643d6mr1690789566b.34.1764249323762; 
 Thu, 27 Nov 2025 05:15:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMRtlCIsA30Q3Q9nqlxVrWtGv5jSC0okVhGBo0adXnBdpvwoP7ymS6MsjuKU5ILAeWUBp3NA==
X-Received: by 2002:a17:906:b84b:b0:b76:7b85:f630 with SMTP id
 a640c23a62f3a-b767b8643d6mr1690786966b.34.1764249323311; 
 Thu, 27 Nov 2025 05:15:23 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b76f519e2f0sm161939166b.21.2025.11.27.05.15.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 05:15:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/28] include: move memory_ldst* to include/system
Date: Thu, 27 Nov 2025 14:14:50 +0100
Message-ID: <20251127131516.80807-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251127131516.80807-1-pbonzini@redhat.com>
References: <20251127131516.80807-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

These partial headers are only included via system/memory.h, so keep them in
the same directory.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/memory.h                           | 14 +++++++-------
 include/{exec => system}/memory_ldst.h.inc        |  0
 include/{exec => system}/memory_ldst_cached.h.inc |  0
 include/{exec => system}/memory_ldst_phys.h.inc   |  0
 4 files changed, 7 insertions(+), 7 deletions(-)
 rename include/{exec => system}/memory_ldst.h.inc (100%)
 rename include/{exec => system}/memory_ldst_cached.h.inc (100%)
 rename include/{exec => system}/memory_ldst_phys.h.inc (100%)

diff --git a/include/system/memory.h b/include/system/memory.h
index 3bd5ffa5e0d..1cacc117cc6 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2848,7 +2848,7 @@ MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
 #define SUFFIX
 #define ARG1         as
 #define ARG1_DECL    AddressSpace *as
-#include "exec/memory_ldst.h.inc"
+#include "system/memory_ldst.h.inc"
 
 static inline void stl_phys_notdirty(AddressSpace *as, hwaddr addr, uint32_t val)
 {
@@ -2859,7 +2859,7 @@ static inline void stl_phys_notdirty(AddressSpace *as, hwaddr addr, uint32_t val
 #define SUFFIX
 #define ARG1         as
 #define ARG1_DECL    AddressSpace *as
-#include "exec/memory_ldst_phys.h.inc"
+#include "system/memory_ldst_phys.h.inc"
 
 struct MemoryRegionCache {
     uint8_t *ptr;
@@ -2897,7 +2897,7 @@ struct MemoryRegionCache {
 #define SUFFIX       _cached_slow
 #define ARG1         cache
 #define ARG1_DECL    MemoryRegionCache *cache
-#include "exec/memory_ldst.h.inc"
+#include "system/memory_ldst.h.inc"
 
 /* Inline fast path for direct RAM access.  */
 static inline uint8_t address_space_ldub_cached(MemoryRegionCache *cache,
@@ -2923,18 +2923,18 @@ static inline void address_space_stb_cached(MemoryRegionCache *cache,
 }
 
 #define ENDIANNESS
-#include "exec/memory_ldst_cached.h.inc"
+#include "system/memory_ldst_cached.h.inc"
 
 #define ENDIANNESS   _le
-#include "exec/memory_ldst_cached.h.inc"
+#include "system/memory_ldst_cached.h.inc"
 
 #define ENDIANNESS   _be
-#include "exec/memory_ldst_cached.h.inc"
+#include "system/memory_ldst_cached.h.inc"
 
 #define SUFFIX       _cached
 #define ARG1         cache
 #define ARG1_DECL    MemoryRegionCache *cache
-#include "exec/memory_ldst_phys.h.inc"
+#include "system/memory_ldst_phys.h.inc"
 
 /* address_space_cache_init: prepare for repeated access to a physical
  * memory region
diff --git a/include/exec/memory_ldst.h.inc b/include/system/memory_ldst.h.inc
similarity index 100%
rename from include/exec/memory_ldst.h.inc
rename to include/system/memory_ldst.h.inc
diff --git a/include/exec/memory_ldst_cached.h.inc b/include/system/memory_ldst_cached.h.inc
similarity index 100%
rename from include/exec/memory_ldst_cached.h.inc
rename to include/system/memory_ldst_cached.h.inc
diff --git a/include/exec/memory_ldst_phys.h.inc b/include/system/memory_ldst_phys.h.inc
similarity index 100%
rename from include/exec/memory_ldst_phys.h.inc
rename to include/system/memory_ldst_phys.h.inc
-- 
2.51.1


