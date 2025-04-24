Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 565BCC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:54:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kmo-0005FL-79; Wed, 23 Apr 2025 20:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmk-0005Cj-KZ
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:50 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmh-0004Kd-Sv
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:50 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7370a2d1981so306131b3a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455786; x=1746060586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Sl3ykiXNh537Gb60LwyKbiNxYZ045w+WbZ93YXcawE=;
 b=I38CMoRRbDQfl2cqpgpiDxDznNibwzViN/yinOOHsca0CqvljPecSP+5iZ4wdCmgLE
 mYPxju5jcGWJSUIqhEiLithVVA4GUCiQe0Wp+3WdHi8tc2KPi4vXz+dMtz5mxK/gtR3v
 qF7F0gpmguRwlR1RPXpKP8iMAId574W6aCGwhEmugDAQnG3cpgllgS39CH/59Pe6t6OE
 /Z8dyYksIrnC3rKo53seJzSNh0lCiWN9Xr0gIX6rUL1T6+8+WQP+TYuUILohvmeEv6HH
 atw10CxA0BQf+zWDlc64Y7/vUM9C8zIVXbiZFMBW6pX9k381j9Xi3TXwKr5U/YTLoANb
 xQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455786; x=1746060586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Sl3ykiXNh537Gb60LwyKbiNxYZ045w+WbZ93YXcawE=;
 b=mpQfRLCRdGs+L4Rx3fSS9ziYBFGcMydVFDGEeb3Ss5/E6DMmiD5YVlQZQM1N8AGNqa
 mQ9JZ9hmQf9R/rYbiGNI72r8Fqw7rmsZdDun6YSKyptbxkCuT3LPoKWeE7CExE53Mpcu
 F+Kf6TP4WeY6vffu4CnKcbB7K+PPEWPl0pH5gOLhXB2TvlhGff4Bm/7/uhaYFDrI9Tts
 kUFy3f45/Rxwl3+79sDbtuLeYma1OqTfdHUMclRSzrIH5Q3GoJHMSq5H6NtZ7VVYLYe1
 2SsCHhvJoTM9iz2co8uIIyJhde6RSIiEVrZPgMEEq0E8Yux4wkDvnffUfwuJ1IIikq4P
 5/wQ==
X-Gm-Message-State: AOJu0YxrnbzYQVkxyIav1pjMSNrUYqcXxipCRUh+cGdFpeTdzyPXXsnN
 Mh04pwbqT5g62ESXnQtiKK54+Gv66kjUs+63zzYoHOFM1qbPq7quYZ1VeS3mYCAwVWeCh/4pBJr
 t
X-Gm-Gg: ASbGncvmnyZRtaW3XUsZ2KxNh+OeeBmW6Pyhkhnivj/eeuho2IoCaAOcCwBFWMGKADV
 2ZDqteQ+e0KeyGvdhRU5dhcKMmEojylEiFZnFq137/lclG/j+tAt12ScBjYeRBqHC73suUQMRxb
 CM1ja0GHDyrpUEg+Ph8IWijtK8pIJSVg1m/GuEBMNlFlGMQf+2/LYAV89f1PDcjSVzQwvM5RAFu
 v5Syj3Re8YFCZFSz2AjoqIFJmdh0t1N7ORPC2JsXm9jtv28zy1MvcP0nUR/N4Mgc72VgZSbEcz8
 aD91dw3zcfJfGtsGA8gh+Mk6h5ES1UknHE1pWeL2bvnNkxHOcAWxbvHF832YzCl5SY29p60JQwQ
 =
X-Google-Smtp-Source: AGHT+IFB98kyK4ET7bVHGn0ML9HaIrOcT1NZ1bNIQz11E2a1ddnj0xML8aMcTr8LOov9P0IpZaKG0A==
X-Received: by 2002:a05:6a00:2a08:b0:736:7960:981f with SMTP id
 d2e1a72fcca58-73e24609490mr1276187b3a.8.1745455786528; 
 Wed, 23 Apr 2025 17:49:46 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9a0f1sm207344b3a.137.2025.04.23.17.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:49:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 015/148] include/exec/memory: extract devend_big_endian from
 devend_memop
Date: Wed, 23 Apr 2025 17:47:20 -0700
Message-ID: <20250424004934.598783-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

we'll use it in system/memory.c.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250317183417.285700-16-pierrick.bouvier@linaro.org>
---
 include/exec/memory.h | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 577f473446..fc07f69916 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -3138,16 +3138,22 @@ address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
 MemTxResult address_space_set(AddressSpace *as, hwaddr addr,
                               uint8_t c, hwaddr len, MemTxAttrs attrs);
 
-/* enum device_endian to MemOp.  */
-static inline MemOp devend_memop(enum device_endian end)
+/* returns true if end is big endian. */
+static inline bool devend_big_endian(enum device_endian end)
 {
     QEMU_BUILD_BUG_ON(DEVICE_HOST_ENDIAN != DEVICE_LITTLE_ENDIAN &&
                       DEVICE_HOST_ENDIAN != DEVICE_BIG_ENDIAN);
 
-    bool big_endian = (end == DEVICE_NATIVE_ENDIAN
-                       ? target_words_bigendian()
-                       : end == DEVICE_BIG_ENDIAN);
-    return big_endian ? MO_BE : MO_LE;
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
 }
 
 /*
-- 
2.43.0


