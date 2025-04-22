Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5282DC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:49:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JIW-0002WB-TQ; Tue, 22 Apr 2025 15:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIP-0002UP-GZ
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:41 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIG-0006BA-Pw
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:39 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7370a2d1981so4558193b3a.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350109; x=1745954909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tJ+EfqFiptMAQIqFH9MrlUuf9tOxdmhxubkBN2YjdQI=;
 b=CYGxF+aTAzvJqgkXo5etquzBhrqcCHxDoclgjtncgVFZVtu3eAYffSaiqkTJErZGj9
 39YUyR0ktvURsQ8sK3VmlyOihJqxGh5eYanNKfamscS7Vqi3M43f7QRoliUemBkfq3Zb
 Bg4QGi4UZ7ke7JaXqLPFBAEGcO+J4zfMfYeBHE4r8iwHYtytb4Igb+QKIGqWsAspBrPD
 pPqYBBSgb7HJJ5wV4GFUYPiIE7C9FEhds3nZMUHhmOEC3UnzLxQlXVOwhfoJU7VABaPg
 Jaw24y80+FK8o09bNPT0i8Icv2H7MSRhXP8YgR3stK0JFI9BUEvdL1KI0xTCPqc26aTg
 o02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350109; x=1745954909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tJ+EfqFiptMAQIqFH9MrlUuf9tOxdmhxubkBN2YjdQI=;
 b=ula21vBLSr50qx9Ch1ebyj/shjot2+xmQ9ONyvDGSJn1CQqH+4JhQ2TOAR6TJwhN6b
 Q/wWfZ9dNbUkyfblRPUpYrY9uLgehHRRvlNsyKqVDxJ9OCUqa/pT25r+6r2csSxgwgXI
 rwGKPnSsqNS1ihgb03oBHrsJBRJCUUzc2HPvPpyJK39TXlXzcXtFf6BicTEH8T09Xx0M
 MIsqUBSoVeu9+H3eo1zU4og2DOzYmx+BOzWX474IwRrmJ3DU+bN2EB/D3W6Dr4nfYtgM
 afViidwgs+31ykPbemCIAwUsb6fGjnJOOax+4abQTDZyfJuogKbmU96RyU8WT8gJSiKn
 igZA==
X-Gm-Message-State: AOJu0YxNbKByANfkD3oMIlwoWrPlE4I1n7urZ/in2Z41lIyoZkxPojcG
 plBh9/eiQ9RWTvq2ekTHBJGzMg9gK7pMLv9jQNu+5BMIfgv+x5y2nxs3AA187zWBVd04I0GsM1A
 S
X-Gm-Gg: ASbGncvlKWQXkXs93M7maA2Xuk4Ee6wDRQaeMcQK2lHIOsFa0Qw2Ca5NvuPMpt4Z1kc
 UZv1XrGXkUvrmxJq8DzyaxqIlPqy2svtcDm63QzHjS3DVMlk4OT4Ds/445b6aHOLOLilOPjk8az
 OBSF4INTobdLxAWK+hgyP9z/AiNHv4FCOYmRdKuZMZ8MZIpN4HyaYCqWLRdp18mDJnDGRbF+JDZ
 WY/nEwAMMf3Uwd7zSO0OpmWaRxJxPox/UOB3HWbjNsP8ZldZ51TVdUVz60Vq8F1FB43SJoqJG94
 S4WRTuYwCvLbIO1qKDjktxN77NwUmQQOx2Pq5JiHx7sRIt0AopPGrnWhYouGNNWprqt4GM8MU/I
 =
X-Google-Smtp-Source: AGHT+IFpZQxFAFQSLnCeD07HJP++FdqO/oh4nUEli8s6QbDt4mqM1ejGWnu2VYWs/CC3kMUrDf2M1w==
X-Received: by 2002:a17:90b:254d:b0:2ff:7331:18bc with SMTP id
 98e67ed59e1d1-3087bbc22dbmr19855838a91.26.1745350109241; 
 Tue, 22 Apr 2025 12:28:29 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087df21278sm9146865a91.29.2025.04.22.12.28.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:28:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 013/147] system/xen: remove inline stubs
Date: Tue, 22 Apr 2025 12:26:02 -0700
Message-ID: <20250422192819.302784-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250317183417.285700-14-pierrick.bouvier@linaro.org>
---
 include/system/xen-mapcache.h | 41 -----------------------------------
 include/system/xen.h          | 21 +++---------------
 2 files changed, 3 insertions(+), 59 deletions(-)

diff --git a/include/system/xen-mapcache.h b/include/system/xen-mapcache.h
index b68f196ddd..bb454a7c96 100644
--- a/include/system/xen-mapcache.h
+++ b/include/system/xen-mapcache.h
@@ -14,8 +14,6 @@
 
 typedef hwaddr (*phys_offset_to_gaddr_t)(hwaddr phys_offset,
                                          ram_addr_t size);
-#ifdef CONFIG_XEN_IS_POSSIBLE
-
 void xen_map_cache_init(phys_offset_to_gaddr_t f,
                         void *opaque);
 uint8_t *xen_map_cache(MemoryRegion *mr, hwaddr phys_addr, hwaddr size,
@@ -28,44 +26,5 @@ void xen_invalidate_map_cache(void);
 uint8_t *xen_replace_cache_entry(hwaddr old_phys_addr,
                                  hwaddr new_phys_addr,
                                  hwaddr size);
-#else
-
-static inline void xen_map_cache_init(phys_offset_to_gaddr_t f,
-                                      void *opaque)
-{
-}
-
-static inline uint8_t *xen_map_cache(MemoryRegion *mr,
-                                     hwaddr phys_addr,
-                                     hwaddr size,
-                                     ram_addr_t ram_addr_offset,
-                                     uint8_t lock,
-                                     bool dma,
-                                     bool is_write)
-{
-    abort();
-}
-
-static inline ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
-{
-    abort();
-}
-
-static inline void xen_invalidate_map_cache_entry(uint8_t *buffer)
-{
-}
-
-static inline void xen_invalidate_map_cache(void)
-{
-}
-
-static inline uint8_t *xen_replace_cache_entry(hwaddr old_phys_addr,
-                                               hwaddr new_phys_addr,
-                                               hwaddr size)
-{
-    abort();
-}
-
-#endif
 
 #endif /* XEN_MAPCACHE_H */
diff --git a/include/system/xen.h b/include/system/xen.h
index 990c19a8ef..5f41915732 100644
--- a/include/system/xen.h
+++ b/include/system/xen.h
@@ -25,30 +25,15 @@
 #endif /* COMPILING_PER_TARGET */
 
 #ifdef CONFIG_XEN_IS_POSSIBLE
-
 extern bool xen_allowed;
-
 #define xen_enabled()           (xen_allowed)
+#else /* !CONFIG_XEN_IS_POSSIBLE */
+#define xen_enabled() 0
+#endif /* CONFIG_XEN_IS_POSSIBLE */
 
 void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length);
 void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
                    struct MemoryRegion *mr, Error **errp);
-
-#else /* !CONFIG_XEN_IS_POSSIBLE */
-
-#define xen_enabled() 0
-static inline void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
-{
-    /* nothing */
-}
-static inline void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
-                                 MemoryRegion *mr, Error **errp)
-{
-    g_assert_not_reached();
-}
-
-#endif /* CONFIG_XEN_IS_POSSIBLE */
-
 bool xen_mr_is_memory(MemoryRegion *mr);
 bool xen_mr_is_grants(MemoryRegion *mr);
 #endif
-- 
2.43.0


