Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846E7C369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:32:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JIU-0002Vi-Nr; Tue, 22 Apr 2025 15:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIH-0002Oo-06
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:33 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JID-0006Af-EJ
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:31 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7fd581c2bf4so4589823a12.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350108; x=1745954908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XogLtFAmQTWKnFni/PyMhKIavN2RURu41I1WKUUy13M=;
 b=dxpWQe6195jWjNtaFyP7o7z400mevzgs8aLKukgXpwFo6dn0E9oqe+7y6iFztSRnMa
 lZJudOS8ihIg6BzmXwTNWqiWmDpyYJsRSiz5/NVSrnRp+HyfM6fcHDWBx1WfBJQloQwv
 KvWS9x6ilB25MliBnjAeBMMA+RmX/uH4siEpw7oBif1iatToK/kzZl4ov6e8TJnY6hjk
 OoLvrFeeqRRWBN+/H7eYSebwQ1mIz69u0SC+CjWZ85iOk9hXxtSXCG8U/cWeBSdvd2mW
 fIomr2THMHw7yyCpFXhDn9fuZtVf+Bjch4vwRWG9H3wchllh8XmoOIIpl362fT5neIEH
 9rcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350108; x=1745954908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XogLtFAmQTWKnFni/PyMhKIavN2RURu41I1WKUUy13M=;
 b=WhxB5OedG2f63fLVF38UN/lBdUmuddTKZISEujtEWc2U5e/B2j9dPDW5CCx0vJM2gV
 Cv44ZWvHqMO9OM051PBfkKjOaPSJ1gUauuHXR14d4Tu0/4Lv3+ZmHm96nrW6fu6h0oMk
 2EL3ZfOKYlJpAzn0QiykBurPizp+EFM8b8GNsYaa2i5P36M6JWqbVz7KV8ccQ0e10HPI
 T+5EQQ665rIYUSdncIJRnJ5fRFqrKnGIp4S30a//qUDTNEoz2KVfTPOwN1lVojfm3Acy
 Dv64vupOzRb7JwFZLjpKVt/FPtKKZ7rEHZ8fVEHE9/FGdMHsSOfymauQk0E8NX+fedW/
 W1OQ==
X-Gm-Message-State: AOJu0YyWMPHTqWzQQ3ett4308WxNxy2e1Ey8u2jUH51kamikNZOrozoY
 HcwxxO4hrxr6t+tAJUd7D4sCqIFqjyQQrcBtmjLg5wNeK9IX8TxS+djmpOdKdIlltk7bOD0sHGK
 M
X-Gm-Gg: ASbGncuGzvbeH9bxaCt7n9E+MNvZhh5b7t5fcsEWQauust6xb8OZWltFcLCV3WGl1y5
 p7nTspy8i+Hm6op+0hsiZ0znqWE6ZNA21fNSZ5t8DGOtxChrA39y2Zt7DNqCMSCI/uoX167QLRG
 YU/YWSpJlWbD4z5zwVjV8QvE6rAoqvVyVOecEYV87yiXaLG7JnTRl2TfGIKldGczJhMBdcp1B9q
 RSV4XkLFwy1AOto3oKxSME5AGa9An0m5/xc5/nWEYsVKaTdgJMrkljhfunYEy6JYFc+IHDCxb4u
 M/C3uzPZ/ChWfceLIIuImE8WjFmH/2dPijfNYERm8tbelMT7YiKbBB+JsOuEQKkNch95/rLt4nI
 =
X-Google-Smtp-Source: AGHT+IEBsSRsqRW434BS2sAKuw/r6pJZgwoBkDa+7+fJLMYdI4Bi2CnVZIdih0ilysTPHCjeUz7gGQ==
X-Received: by 2002:a17:90b:5884:b0:2fe:a545:4c84 with SMTP id
 98e67ed59e1d1-3087bcc72c1mr19369438a91.34.1745350108000; 
 Tue, 22 Apr 2025 12:28:28 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087df21278sm9146865a91.29.2025.04.22.12.28.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:28:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 011/147] exec/ram_addr: call xen_hvm_modified_memory only if
 xen is enabled
Date: Tue, 22 Apr 2025 12:26:00 -0700
Message-ID: <20250422192819.302784-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250317183417.285700-12-pierrick.bouvier@linaro.org>
---
 include/exec/ram_addr.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index f5d574261a..92e8708af7 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -339,7 +339,9 @@ static inline void cpu_physical_memory_set_dirty_range(ram_addr_t start,
         }
     }
 
-    xen_hvm_modified_memory(start, length);
+    if (xen_enabled()) {
+        xen_hvm_modified_memory(start, length);
+    }
 }
 
 #if !defined(_WIN32)
@@ -415,7 +417,9 @@ uint64_t cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
             }
         }
 
-        xen_hvm_modified_memory(start, pages << TARGET_PAGE_BITS);
+        if (xen_enabled()) {
+            xen_hvm_modified_memory(start, pages << TARGET_PAGE_BITS);
+        }
     } else {
         uint8_t clients = tcg_enabled() ? DIRTY_CLIENTS_ALL : DIRTY_CLIENTS_NOCODE;
 
-- 
2.43.0


