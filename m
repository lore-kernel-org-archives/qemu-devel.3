Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11248C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:36:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JIY-0002XN-Vm; Tue, 22 Apr 2025 15:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JII-0002St-QE
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:34 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIG-0006BU-O1
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:34 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-af28bc68846so4772653a12.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350111; x=1745954911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I6MDZmD8wHi337leE/VPRqxkP9hRcv8+ycuZ+hH6Uq0=;
 b=NrD1VnDp844ED4uF21HdG7bwQY3sQqHBsHeeNt1RgbjwJ5cuYFwv6lXnS5DHtHoPmL
 nFePIGgTLBt7VhAJ4uBEPeLHwhO3xk4PI/XM08At4r/VTw3D3WcCKE2hNQZD7vXYNd25
 Urw9s2HTOdi4cihwDk00PQzsXowuqVd2jVyFabaJt1zTLamhRJQu5bEcKjHabcN+ZYND
 4mxIsF6AVcEUskhYCOVWcf02gG9/8RNNjkjIO89kW3m3mQgbeU7Cxc8OoIeVYoLN9J0K
 2VaC7Xm8tRN1hTEA/9Nl3rY2E1o+Vtu6Vx0ofQzcbw/fNzzqYkxqkv1bbnYY0JEt1/Lo
 wnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350111; x=1745954911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I6MDZmD8wHi337leE/VPRqxkP9hRcv8+ycuZ+hH6Uq0=;
 b=sELbvNVrdBFypm8pJ9X0I3IdorrH2VznETiy1wlNJH82/ortNMFlTwdZ0EYDr2A/To
 t2OEPXMQDf6qG5FTsizfgvsME+tkHlYlUCjayA7dE8SwhLCCOf5IxCJow+05NTWY1Rug
 7GSTlFO+7MjUPQsqWu+TBWndfqaVQwBRpF/NEHYbnyk3aBFQGk4d4/lKEHmSu0Wy0BHt
 LMMYw/A83WNIk9aq0ws5DSuI/JgDTZZ3fZwj9GVS/iDdJxLeGRZWtLc4fEnPWj+OC2Ae
 F/moH7D7RQshZBmBsknOhXtSjAb+Sbz+QwYwbCDFsi0qYMd9zL97Qjn0+vuCEIJC/v9U
 dQ7g==
X-Gm-Message-State: AOJu0Yz0GvlRJu8Hn+RpHFiCKIyW9m0McXTWYX8i72VtlC6k0TsR+s/o
 3rWyp2uzeCtbcDCkelizFDe5A24+LgJBnGGKuPoUpiI2C59lSfNd1Ib7BxMcpQfgzdDrK5/Iy/Y
 l
X-Gm-Gg: ASbGncs5pp0I/qMYlnPCFlu3wj0EI4qMyRdj/Mn34BJ21wyPeD3H8HnhAJs9+FBbY1Z
 jb5Knf7d/ULtbGFgQ8TeJuowAEbr0mg2gPVsI1x+SIkHa29rhKLSppGHwN3VdkTmU+eFpYyWFZe
 Y+x2tKYYsSb/YX6yScx6zGUTzSKA9sNhg9U0CpYJs4oh7am6ZmGDtDV6ZuGaMs/2cXc3C9lYJMW
 OrSEUgdSahNTU9ZthGkL7uxIkEB26+gYbnXHDage8uPnvQmWOIVkFwzZPOAhPrzktI4MZjkmfsF
 7yeRjlgA/zlYeA9a2i/abhC8GIAkA9QSA5hWGPmAk5tiFfnwMNhjxbYu+YCKgTAoDSaah43U2QE
 =
X-Google-Smtp-Source: AGHT+IGi0E0YpGEHYfPPMJp1dAZFtZuE8xAbdOe0QMG8BuUgiTtDzyogLI5eVo8/N7+/V6z6ouVjGg==
X-Received: by 2002:a17:90b:4ecf:b0:2ff:62f3:5b31 with SMTP id
 98e67ed59e1d1-3087bcc8b16mr22972171a91.29.1745350111082; 
 Tue, 22 Apr 2025 12:28:31 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087df21278sm9146865a91.29.2025.04.22.12.28.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:28:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 016/147] include/exec/memory: move devend functions to
 memory-internal.h
Date: Tue, 22 Apr 2025 12:26:05 -0700
Message-ID: <20250422192819.302784-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

Only system/physmem.c and system/memory.c use those functions, so we can
move then to internal header.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250317183417.285700-17-pierrick.bouvier@linaro.org>
---
 include/exec/memory-internal.h | 19 +++++++++++++++++++
 include/exec/memory.h          | 18 ------------------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/include/exec/memory-internal.h b/include/exec/memory-internal.h
index b729f3b25a..c75178a3d6 100644
--- a/include/exec/memory-internal.h
+++ b/include/exec/memory-internal.h
@@ -43,5 +43,24 @@ void address_space_dispatch_free(AddressSpaceDispatch *d);
 
 void mtree_print_dispatch(struct AddressSpaceDispatch *d,
                           MemoryRegion *root);
+
+/* returns true if end is big endian. */
+static inline bool devend_big_endian(enum device_endian end)
+{
+    QEMU_BUILD_BUG_ON(DEVICE_HOST_ENDIAN != DEVICE_LITTLE_ENDIAN &&
+                      DEVICE_HOST_ENDIAN != DEVICE_BIG_ENDIAN);
+
+    if (end == DEVICE_NATIVE_ENDIAN) {
+        return target_words_bigendian();
+    }
+    return end == DEVICE_BIG_ENDIAN;
+}
+
+/* enum device_endian to MemOp.  */
+static inline MemOp devend_memop(enum device_endian end)
+{
+    return devend_big_endian(end) ? MO_BE : MO_LE;
+}
+
 #endif
 #endif
diff --git a/include/exec/memory.h b/include/exec/memory.h
index fc07f69916..2f84a7cfed 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -3138,24 +3138,6 @@ address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
 MemTxResult address_space_set(AddressSpace *as, hwaddr addr,
                               uint8_t c, hwaddr len, MemTxAttrs attrs);
 
-/* returns true if end is big endian. */
-static inline bool devend_big_endian(enum device_endian end)
-{
-    QEMU_BUILD_BUG_ON(DEVICE_HOST_ENDIAN != DEVICE_LITTLE_ENDIAN &&
-                      DEVICE_HOST_ENDIAN != DEVICE_BIG_ENDIAN);
-
-    if (end == DEVICE_NATIVE_ENDIAN) {
-        return target_words_bigendian();
-    }
-    return end == DEVICE_BIG_ENDIAN;
-}
-
-/* enum device_endian to MemOp.  */
-static inline MemOp devend_memop(enum device_endian end)
-{
-    return devend_big_endian(end) ? MO_BE : MO_LE;
-}
-
 /*
  * Inhibit technologies that require discarding of pages in RAM blocks, e.g.,
  * to manage the actual amount of memory consumed by the VM (then, the memory
-- 
2.43.0


