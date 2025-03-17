Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC50C28B28
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 18:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuFJU-00050y-Od; Mon, 17 Mar 2025 14:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuFJ2-0004f3-JG
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 14:35:23 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuFIU-0006Ca-QM
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 14:35:15 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22349bb8605so102852155ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 11:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742236479; x=1742841279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RL1NPApLGPlk4f7q724/4D7b3IECBRPwWShMeYRIDxA=;
 b=VX45PaRBKrM5bPwLpkies1jMXFghyrgBtIsEnV27lD49ME4rjhBYaCSMYb9yfOS0RC
 atESC1ErR6X2WWeIa1grC5c4q5hNjeS7RPvrJ0cIz5crpnmnkt35EwuvmWcEMqKbkfnu
 0j+iQQZ8jm0NjK34nMQQ03gukXQWJnvFVBMYZC0Rsn5WD0ekv+ULNNP5dyOeIKt8wHIm
 50UwO3eCoyXm7H+Z1ybjwjIegowMg8KZMpXlqHPKc2ereTYVU3/wYEAeb7v/pS+MwrFS
 Tk0jCm4gSAS7MWTjwYxXeHRI8VC9Q7h0SJP20SJOUCfsuSmftAkML7A/2h9H9m6rXYry
 in2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742236479; x=1742841279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RL1NPApLGPlk4f7q724/4D7b3IECBRPwWShMeYRIDxA=;
 b=LZwuO0s0u37CEIKtzOesj4Lny95oUfE49a7JOhZgDlr5MrEypO6q6EOQlLoEWTTiz0
 caCzv2s/J110XlNl/ruM/yDvdDBdFR+ZnfLidbWBwSGzqjbimgY7fwPAM8HFrTJORPMv
 Mo6q4J+NHnA+UMk7XjnzY9i7b/KO3ub9jw2u8thOeG50usXhkUEgNU/v3qOrrKA8hVdN
 0pReYUeRnr/VJZ0Wr1roV/+0DnXEt8b/f+QDI5SIXGevnK5N6QnV8bsXjutwY5So2Lzj
 jR3WIp25TUQfLCAce4Lj9+AsESlkJTLMyWcUS5+irm950hy7rIR78V5XJdv5inWbmMAa
 D/GA==
X-Gm-Message-State: AOJu0YxUAZyUjM1yYZumyn/1ypfM8tme7DjoK3YHBc0C7gO19BmGByW8
 H/Ld0F4XWO/95aIi8sVml1uH7vy+QQq6/TVhq9ivoj5mDPz8ythLx+ai5HhlMHWTHKb4nRviojT
 f
X-Gm-Gg: ASbGncsNiunnBAcFfDEkd9kkcbhQiXjkKW/Wy9uGxFCh5Y/0Mk08donoBUgcnS8kW4n
 kknHGmWXy5swteSXdvUMMZGxotWYs2Ou2kD/Ph+w/eELKVOYUBSmu84nkgmseebWZ7clCFAGA8U
 qt6J6B1avF6WCEfUwwsc6sO0Ib6HvNXulYMg8491SNMaWP3DRc4q6yxp/HepQ6qB1MNiXb90l8n
 VF+xXruphx+hmZRLPtNue8SdPK4cEZv8c4yXGQYknLeNa0urQ11okL5I76iOt24z5cacNHxsudZ
 uyI8Bf+zkXc0g/SMOASBZqsAetDr6D2bE/6zh7kjJ2hd
X-Google-Smtp-Source: AGHT+IFOOeyV31jwF+pNrENhCRDzbP+OAMMjvkw2JiLIZfPvEZk2AdzmBDyPiAzaxdBUCsyNl+0UJg==
X-Received: by 2002:a05:6a00:1c83:b0:736:54c9:df2c with SMTP id
 d2e1a72fcca58-7372240f41dmr13708249b3a.15.1742236479639; 
 Mon, 17 Mar 2025 11:34:39 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711695a2esm8188770b3a.144.2025.03.17.11.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 11:34:39 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>, xen-devel@lists.xenproject.org,
 David Hildenbrand <david@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-riscv@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 manos.pitsidianakis@linaro.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, kvm@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Peter Xu <peterx@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Anthony PERARD <anthony@xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 13/18] system/xen: remove inline stubs
Date: Mon, 17 Mar 2025 11:34:12 -0700
Message-Id: <20250317183417.285700-14-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250317183417.285700-1-pierrick.bouvier@linaro.org>
References: <20250317183417.285700-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/system/xen-mapcache.h | 41 -----------------------------------
 include/system/xen.h          | 21 +++---------------
 2 files changed, 3 insertions(+), 59 deletions(-)

diff --git a/include/system/xen-mapcache.h b/include/system/xen-mapcache.h
index b68f196ddd5..bb454a7c96c 100644
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
index 990c19a8ef0..5f41915732b 100644
--- a/include/system/xen.h
+++ b/include/system/xen.h
@@ -25,30 +25,15 @@
 #endif /* COMPILING_PER_TARGET */
 
 #ifdef CONFIG_XEN_IS_POSSIBLE
-
 extern bool xen_allowed;
-
 #define xen_enabled()           (xen_allowed)
-
-void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length);
-void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
-                   struct MemoryRegion *mr, Error **errp);
-
 #else /* !CONFIG_XEN_IS_POSSIBLE */
-
 #define xen_enabled() 0
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
 #endif /* CONFIG_XEN_IS_POSSIBLE */
 
+void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length);
+void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
+                   struct MemoryRegion *mr, Error **errp);
 bool xen_mr_is_memory(MemoryRegion *mr);
 bool xen_mr_is_grants(MemoryRegion *mr);
 #endif
-- 
2.39.5


