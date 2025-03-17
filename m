Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96F0C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 18:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuFJK-0004qC-CY; Mon, 17 Mar 2025 14:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuFJ4-0004gv-9M
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 14:35:24 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuFIU-0006By-4U
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 14:35:16 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-225d66a4839so58052445ad.1
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 11:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742236477; x=1742841277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PABH8iZPN9WF+wJr72ZMp6Lm7i1C+9jWBJAvssLik90=;
 b=LyrkipDVKnFVG8gmAPmA6kE0IUfpMrbKOfXTPtpyUVaGx+Xmd8iNQzSF71IxI29zYA
 nmXuG5THH2A8/fmHsGTpHfIt8l9DMCV4u5rZbBG6fSLmQ395aEv45giJ8+qYiSlFnLHz
 4tlOdPh1WsS0Iyg2DkikTBNEPUKLr/KR8N+GOpEicqpz1FiGUk//vKQnhhFRHusJVftC
 UkXGhywPPMnhcQ3iXdMWESSx51ho5W+LnrUDPWEN7CF/bWKzzEcVEWwY8VExCnFHvYnQ
 90qQiSCqXu3c7rsOfBKJxGjToniO04GL+8EIvM6/buyzup4o3MDH1xvcx75hMN4GHOEC
 MgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742236477; x=1742841277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PABH8iZPN9WF+wJr72ZMp6Lm7i1C+9jWBJAvssLik90=;
 b=jkT1fjT5QGX7TpU/e7QEj8LMJ1OlWm+fBuE58m5cJFpuKUvIFmizWoIyRMYLR3tNPu
 1eiR/OI8a3EIRqMMMAROfTP4k90S20hlzuwxFG7rRDOJoE+GJvIV9XAIXjnKNMWuLFxg
 vQJ7YNE6bYvCxtfPFDrH83kSYmolrf/8JVWKl7Z9cFXfCdwwEmFIM5kgvCIFYo8hqbIB
 LhPqONCfR0LxHZi/Lr0oSin8Wrm6A0J6LFDAWXgcU8caZmCjzBo6pQYfP0bnhwJ/5olb
 /C3T+1me4Hu9/r2cfCTZK5vfczPyAIDwLYvSLFgF/ITLd9nJXquA6BsTIFgS+jYz8Egi
 SgDg==
X-Gm-Message-State: AOJu0YyZiEj8YVmJtIIlJm8do+iUwifpX5JwyIBbBSLLaV1AaEsOmwoN
 +clcAG6nSyukWbb3CzrYUv1CsGXAtauKZMRWWjxRWnRH4CxFcJitVkuAKG7JpWXLAlNffWVnYLM
 I
X-Gm-Gg: ASbGncsSJjPntTiflJa/NsEBLNwPJ66WQMWyTrAiYcTugTlTYCHaZQPMYwFDXDyEi1U
 CH+sY0S0ywaJr55Ow8ZbJMNuFAwp9I28MiWlKg/BUTcCaG0z4BLTcCUCLzh5Md7yWi9lPao3r18
 X9EwAfIrfVlMcVRkAirJfFUZZeQ4lyaJOG2n3p+Fv5caVtQ5G62luKRrhS5wNihFervjYOYlV1f
 ZogzkdLU6v744koMEQSSWDcyyX36gnEv4IlkUxQqp9om5Abv/jx4MQoPYAeJDghmCjcdsA7Gnrp
 Ik7cHeXcsdjH2xsfY0Ec0F2N6umg2scH3Wb0Apx1mL+T
X-Google-Smtp-Source: AGHT+IG3g1g1/S4GhLMViIQmdttYJlPvvQDr2HFvFncsoI+sX7+pFPl4do/KG0rupNOCudw5OLu0nA==
X-Received: by 2002:a05:6a00:2d8a:b0:732:5875:eb95 with SMTP id
 d2e1a72fcca58-7375778c1femr704383b3a.4.1742236477316; 
 Mon, 17 Mar 2025 11:34:37 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711695a2esm8188770b3a.144.2025.03.17.11.34.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 11:34:36 -0700 (PDT)
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
Subject: [PATCH v6 11/18] exec/ram_addr: call xen_hvm_modified_memory only if
 xen is enabled
Date: Mon, 17 Mar 2025 11:34:10 -0700
Message-Id: <20250317183417.285700-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250317183417.285700-1-pierrick.bouvier@linaro.org>
References: <20250317183417.285700-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/ram_addr.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index f5d574261a3..92e8708af76 100644
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
2.39.5


