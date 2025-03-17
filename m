Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78820C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 18:37:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuFJA-0004gI-Nv; Mon, 17 Mar 2025 14:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuFIc-0004Sd-Ir
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 14:34:56 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuFIK-00069Q-3r
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 14:34:53 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22435603572so76549795ad.1
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 11:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742236468; x=1742841268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fcP4MFj0H7Fu3AxOxTbJlPG2KgbdJwiBtz5sSPdKZDU=;
 b=OFQKPkd8zQFT53AvZqrYGdg4tP1hRz+tGx6FSZO37U7P9bjp3kUHL92C+DqPYwSXrj
 Iinj3zILrnUwGrpALD8FN2UuFo8yrL4g6lPiQ4QT7SzzutydY9nRUEzuBpebdz1vvSbk
 oGou+mzw3Z0XN0XbSgZq9jtYCAYkoMBiDFwbeiPIDvPeNMnozr7DMH6LPKD6uDi3aWxU
 xoSXOn9b13nUS00d/V41UK84jiFKDBcHy5noOqT3N5B7yMbeZV5pV98Yh6jmd+LuFk8l
 a62CtwMrc29NPhXu/J9LSOmduf6AqIbc9a6QBFA2EXxqgWphbv7LScX9nReSbE91/r2/
 ShMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742236468; x=1742841268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fcP4MFj0H7Fu3AxOxTbJlPG2KgbdJwiBtz5sSPdKZDU=;
 b=XgKuOyizD5GIzvpOdXkrpGIPVJ5d6b0fs5vCXszB9RoiKEIFEkwEZLj3R3J5bnMFmo
 Hw4oDF6vDWVl9hAO10ugfhwnfY0LHgW3D1Q5BjH6M+08EtIp2Vg1QFAeSe4aF2Wn1Z3J
 lwAmGxxw8WvZWbGFzMrZbZ8jHkUYAEM/WDZl8aCYhH/MbSM6nYIkmxAQkM8gok2tP+zO
 HQCGJB4qvSDqeQCBRqIGCiolvn0X3cV1+P/iHbFwSjnnmQaJyI8ofNmbEDPA0s9lCadp
 59xVWN1L9Idelay5OPzGLUs3Q/6dY21rwNsRNMLvm+SZu9WgYw8/W86gl5ew//6U1ne4
 xroA==
X-Gm-Message-State: AOJu0YxvO6NYn/FvpXgSqre5v9kyfN3rzMaQTE2C1tQxOtiz4NwUTqnp
 jQ/lXCc1uIT9tpalX/YUJ5I0cCnOHcPZ4z8aGg/SbwoGu3jvQrrTPWUpPbQ0iKOI9GUMhhiqVtU
 6
X-Gm-Gg: ASbGncu8XrHmBiUkkXwX5451za9M0YQG+FMgaMqZbsheRT7nEUwNTesh1VXgM2PNYBB
 A7fm2AQXIlWg+3CHLCsiSpEALlNr1rcdF9bRSdjfH6RZ3Kdk0Bmdw5Y1ue2TyCYcDmsYbvn4f1n
 R7Sxwrp0+eM0M20JmmyfAgVG+o0Phq9d7yJmdQMyXBDVaTiw1LBemWQQ8JzArRs24A9JGHDnMqe
 WSMla4nCL4SjvsJEUYg0EHFg6jNoE441/hN54lQShHDwKI/BAQ3LHWswXlhOJI+eZQPWjOwcgiF
 TZAH/NYNUsfN/FORHk8qZ5bS3oVnQcEljtS0pDkzTmSC
X-Google-Smtp-Source: AGHT+IHQDcKJsv+Vb17cz20O+u5FV4YlvIefcRPItg35hxavnuYTE6e3UlOmHk58oIUa6dLl2/Rvnw==
X-Received: by 2002:a05:6a00:13a6:b0:736:7175:f252 with SMTP id
 d2e1a72fcca58-7372239d970mr17183784b3a.14.1742236468325; 
 Mon, 17 Mar 2025 11:34:28 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711695a2esm8188770b3a.144.2025.03.17.11.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 11:34:27 -0700 (PDT)
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
Subject: [PATCH v6 03/18] exec/memory_ldst: extract memory_ldst declarations
 from cpu-all.h
Date: Mon, 17 Mar 2025 11:34:02 -0700
Message-Id: <20250317183417.285700-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250317183417.285700-1-pierrick.bouvier@linaro.org>
References: <20250317183417.285700-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

They are now accessible through exec/memory.h instead, and we make sure
all variants are available for common or target dependent code.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h         | 12 ------------
 include/exec/memory_ldst.h.inc |  4 ----
 2 files changed, 16 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index e56c064d46f..0e8205818a4 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -44,18 +44,6 @@
 
 #include "exec/hwaddr.h"
 
-#define SUFFIX
-#define ARG1         as
-#define ARG1_DECL    AddressSpace *as
-#define TARGET_ENDIANNESS
-#include "exec/memory_ldst.h.inc"
-
-#define SUFFIX       _cached_slow
-#define ARG1         cache
-#define ARG1_DECL    MemoryRegionCache *cache
-#define TARGET_ENDIANNESS
-#include "exec/memory_ldst.h.inc"
-
 static inline void stl_phys_notdirty(AddressSpace *as, hwaddr addr, uint32_t val)
 {
     address_space_stl_notdirty(as, addr, val,
diff --git a/include/exec/memory_ldst.h.inc b/include/exec/memory_ldst.h.inc
index 92ad74e9560..7270235c600 100644
--- a/include/exec/memory_ldst.h.inc
+++ b/include/exec/memory_ldst.h.inc
@@ -19,7 +19,6 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifdef TARGET_ENDIANNESS
 uint16_t glue(address_space_lduw, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
 uint32_t glue(address_space_ldl, SUFFIX)(ARG1_DECL,
@@ -34,7 +33,6 @@ void glue(address_space_stl, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result);
 void glue(address_space_stq, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result);
-#else
 uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
 uint16_t glue(address_space_lduw_le, SUFFIX)(ARG1_DECL,
@@ -63,9 +61,7 @@ void glue(address_space_stq_le, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result);
 void glue(address_space_stq_be, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result);
-#endif
 
 #undef ARG1_DECL
 #undef ARG1
 #undef SUFFIX
-#undef TARGET_ENDIANNESS
-- 
2.39.5


