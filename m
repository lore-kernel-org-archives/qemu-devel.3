Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7204DC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:45:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JIa-0002YF-82; Tue, 22 Apr 2025 15:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIP-0002US-Hk
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:41 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIG-0006BQ-Qb
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:35 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-30384072398so4587382a91.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350110; x=1745954910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Sl3ykiXNh537Gb60LwyKbiNxYZ045w+WbZ93YXcawE=;
 b=k6vTI3ZJw2Hw7jiGcjc7LAK24CMyVYBflYr0w0M3ZLIKyKevmn1Nw5Ttk3vDsNcZ2O
 RKpSt2VZkc+pASgYMhm9ZttUrR3wcBJ3pHtLsm/VgZ612N8hnpuwV4SA0yEhIauKoHjL
 RvdVGodBaQdTzCNre06T6kPraS8KDQPco9YSW5Zstn8VaW9GUGO6b9t/+OFMO/i/aukJ
 1HCTa3x/etv3YTA968h7PNS4CME1lBzfUmH2WPEj8lECBN2XWNdfgkZ7SA3nRd3DWZ2U
 3rQyM/CDfRLiJdw0H70Cd+9BqTW9BE1WyXzOJ0u3+gdkopSBpD/3cmKhg/vIMSyN/Pa9
 3lcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350110; x=1745954910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Sl3ykiXNh537Gb60LwyKbiNxYZ045w+WbZ93YXcawE=;
 b=ptiH4DbmRvsZp2stLSr4Et1gLZ5HiTPAtPc5kGtS9e3lQ7mbV8F0KVaFkr/QqbcSms
 B0+ytB0ZTVZZkP5QXiv/YpMJ218FK1qLSLpcHJIfEOCdQw0At28I3fEV6nRLVz71himc
 02yq2aLTJ3VMx5iYDp7iLSUFc1LeYzC+VJpO+uKDC9HXYOaqjGDyl2ofR2g8aa7SKPoz
 Cf0nDOp027ZmB2onVUCExguwdv6pEDDMvP+LMXiD1srO7xrokixH/oWJAIRsORK6NjDy
 Jng/hcpvt4hfTnJbx1/hq6BHwDk5TlD7XWRGA4VvvHzpvMPM6wecLofjrq6PIO/vN1OD
 MEcw==
X-Gm-Message-State: AOJu0Yy7+MNL2dVNZs+RpuBhIOaHR0DhprnnqvtMKGPTE4wsxJ7jRmnX
 lVwYBsEISCmJXleGUu7DFGZLeiDzY0Qcu2976AEfmVFPpT8eibVsA2lhrNgXlAc/n6hNhXg/4DP
 K
X-Gm-Gg: ASbGnctwO3ANN1SLulNOJrk8wLkyOFet6l0weR6MT09lTKoh3zc6xKQC4sUmcLWsg80
 Atsa8YuXDMzWyZDJs6rKcGJbTfz4N5VFEjwVjCOz7Pisn2vKTdCfT/zETaYI7WhOjwICrM01Ciq
 vFYvNtg47E25ZVuvL0EF0PNNOPNifqyisumi4Lf9Akr8Tf2r9gbkX8BudU+UJtlQLxtIshEsHk3
 XJjN97iZ//9gf+brpZDo7CiwNcdXJODhO6Vt9PKcaMOl27yAKCPW6ZtqTjKu5VnQcFxHuWb4Er5
 8+ayTC2l1S7quu9EYZAUWT9ANdb33sczfT5KFafNZGCr/8R8nikn4nMQRLRBX82R5cp57T1/uUs
 =
X-Google-Smtp-Source: AGHT+IEZWC+LXbS7xP6d6QIgLZk5oaHQcwTjWYFvqeArb55HkvUGhT4FPUBL2ion4ZIwNmT9L25fFQ==
X-Received: by 2002:a17:90b:5404:b0:305:2d68:8d39 with SMTP id
 98e67ed59e1d1-3087bb571a2mr29583503a91.12.1745350110457; 
 Tue, 22 Apr 2025 12:28:30 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087df21278sm9146865a91.29.2025.04.22.12.28.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:28:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 015/147] include/exec/memory: extract devend_big_endian from
 devend_memop
Date: Tue, 22 Apr 2025 12:26:04 -0700
Message-ID: <20250422192819.302784-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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


