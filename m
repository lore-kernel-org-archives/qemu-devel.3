Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68128E8FDDB
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQPr-0002Nr-Fq; Sat, 27 Dec 2025 04:16:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQPf-0002Ke-IQ
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:16:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQPe-0002J3-4K
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:16:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766826997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yHi0OhiUBJaRSmRmnVJ4fshCFpycq4d1vaapmTx7gfE=;
 b=asuZ9iX9utP1X9451u/e2pO74AYNvKMho6h+EwFd1iYjuRkpeYomx9+reXSgbMaMGXfuCW
 sDeMKf1XErcqbrEiQsnGDu/9UMWEQdvZ8RulGtAeIueKIaJV41E7DZyPOLtjSE/3lM9M+R
 3TeAPRQMUYATZ5+xQxCXA6JDRNeFwV4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-DWE2GoqqNt2nsQJ2MFoJ5A-1; Sat, 27 Dec 2025 04:16:35 -0500
X-MC-Unique: DWE2GoqqNt2nsQJ2MFoJ5A-1
X-Mimecast-MFC-AGG-ID: DWE2GoqqNt2nsQJ2MFoJ5A_1766826994
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-430fc153d50so6248280f8f.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766826993; x=1767431793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yHi0OhiUBJaRSmRmnVJ4fshCFpycq4d1vaapmTx7gfE=;
 b=C0sDESaLtA+THW4rgJnkXeDq1gSDbypDYZ43nkjtk9GrNsEfdY8NFWrUsMzSt5Hn0T
 ChSX/V0Jg2g+CZTjheEdww/OHgp/qUrhAMD7moJGgna3t57ncvMjN2n9Y03yLcR4Nl46
 BdZl27yH/3N9+PJk9AlKn+UDAfqyAI2uFkEgJPfaNBt6WmBAUwkkDTDNElDb61o9+bdD
 mzZfdOf8+AlY0PPWUbWkBkDCfsptMtBQErekXPTYK5oGQXvbbIdeOXk+dmRsqWZ/HKf1
 KFZTR6YezxBSlNR/m4Zv9zWIWuervGqvrkPdVCCZGL73uvEN0D4kidw6W77dF4cHwWgl
 EbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766826993; x=1767431793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yHi0OhiUBJaRSmRmnVJ4fshCFpycq4d1vaapmTx7gfE=;
 b=PrM0z+uQm3RIAm7ARoHkDKIP7MkuL/IUuHDYCPTY3tMouI+DTcqAuy4EQF6vxyUsMS
 azW2e5WAp1e9LHxrSsTxj+07zT49ctPyeWqiENeqJEd0wtjmYs5shRTLJ9G+1s6Uv4PN
 aRHyJM8aehNDmMrHcbHcuHX0Nm7FJrbfEaYHBwsyjHER36j2ljwATU/uWFmw5dh19Toa
 +kO91ndc2fHl+0vpgqKAFRGdzPm86s0cVC9mPlDxxFzk+DRRexo3Ble17evzLDDVLTKG
 3K/z90HMOuUhFcU6AQzZ6j9pR0ZXRbEu7sCwQ5t5BkQiXtsIP0kggsaWzXooOT1qcsOF
 w1kw==
X-Gm-Message-State: AOJu0YzrzrMfSACYTZree+I/gJOhO1ODdWHkICUN/2V1/Izq9+Mlmyqa
 5D9kzN9YPKZYEJhjnzQTq1xrDtzjTkRoWp0d3FFgjtFJomEFXhGwBid9G5GNBTbF6cpFLdQer3I
 9QLrF+9AQueF+kuwXf9ZKUcFRnhMEEqWdTowZCoNZf8ecSeMdAaIWfMzeVv7hU9Ksu47y6roivM
 CqdDg72fQX/0QvAF+GHiHY5jCpDez6X0VyTYlE3Jpq
X-Gm-Gg: AY/fxX5wAJWUY+shhad96mAYYh09zw9EL05a4zFjEybxm6kwyvKO2exKLknU6yy/anO
 ZvC0krD1s2DTotHupoVCTpCAp1/na6/hVg5E0++bNtdMHlqxYXtgOeXaHeeRRMHmXIe9BW+fIDV
 Mkcg1XVZQqW+YfmHWP4xqKU/5qfFXRJl4i5mMirmAo+qqGDsGBDpuGRBNtCmL7+T5jwQ7OUDL0t
 0Tt0zH4rElOq/RB8knq2Oex9Jp9V4WUUXMCw96AVcas3k+bNF36IeBxedtarMoBF+5jhiWT+YU2
 dkOnwO8W5HDEPUMG0ctKKIbQmZ/HpJH0LjRTPQhn1Xl3RfrRZ02uH2byq0cTahd5ekhFkwcrt9s
 fAiHyxPagp2RJG21QNvtBM3TriJRZDxPc5dl4OuPJpl2qyG+MBzSrbXJM584LapajMHp1cSiIZC
 u87MJC6Q8WAZpwy50=
X-Received: by 2002:a05:6000:2586:b0:430:fcda:452d with SMTP id
 ffacd0b85a97d-4324e4cbd79mr31571175f8f.22.1766826993133; 
 Sat, 27 Dec 2025 01:16:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRnlY9U6HFAYkfBTwMQvspwksuT27hclGnpMo5umHHfmzqJfaOO+TXLW2PBybXoCnFNzBgGA==
X-Received: by 2002:a05:6000:2586:b0:430:fcda:452d with SMTP id
 ffacd0b85a97d-4324e4cbd79mr31571146f8f.22.1766826992622; 
 Sat, 27 Dec 2025 01:16:32 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1b1bdsm49077492f8f.8.2025.12.27.01.16.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:16:31 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 004/153] include: move memory_ldst* to include/system
Date: Sat, 27 Dec 2025 10:13:51 +0100
Message-ID: <20251227091622.20725-5-pbonzini@redhat.com>
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
2.52.0


