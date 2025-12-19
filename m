Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36543D7879C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdEk-0000uk-Th; Fri, 19 Dec 2025 11:21:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdEc-0000er-Dz
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:21:42 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdEZ-00069Y-V0
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:21:42 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42e2e3c0dccso1224935f8f.2
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 08:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766161297; x=1766766097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iFEGCZtzOscJWwxvEWIUNx2AGQ/JK9CrfOIEXq9Elt4=;
 b=pJhVK45RqwhgOrSx7JsAEjxD1Wza3Eg/ZqMsMYNBavuVDkmZ/3ufy1xA7KxlRM1yeY
 flxswDFMwkkEWctBsm+oUeNUAls4380RU6vQ+rmKAoE5KMCoR3nhTvj9T3jkpNl/0+B6
 UJgIAO7XZz3aPo9CzGOPTJ1ZUCiBYL/UdjMVw2rAlGse2c7ypauPOjnoPSbcu8gX+pgs
 bdWe9d0V3j8MB1JvlkO01Pw5zhuYU2++Z30ZMNWgb+NEbhCyCpf8KfYnQiKWqrAaDUga
 VEjHoW2ixUjdfmAampgcwL90itXztcYZ83xyM1FV9dv5cxrxjxFhXsMxmlkmd9GGN0TU
 H/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766161297; x=1766766097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iFEGCZtzOscJWwxvEWIUNx2AGQ/JK9CrfOIEXq9Elt4=;
 b=H8VxMdwcLZl4VQoFzjnOOXw8GoDqqicjk9bwqQnWrGamjhvFj21trkyHbFvE8mJe7z
 Oxx58lSv0k4BkkmG9bayqiMmWLZuFBaB5rpIGZxOo5OCJ3nnB/w3+k8IIM0aODUrWnry
 dAyKd8HWXtBnoA1LIDctLTETMNyCRLAxoF+bSGtI1Z9sZpxvyLIofLvPTtyHv6NeRSUt
 KdvUXhJ+RAKqKG2cF5n9y0iDIehs8VXoj7r6nN+5j/hsNg1HpF5UdKdwSQI6NaWafuYC
 YryF69Gpf4dwgoiq2ccufDCazck1t9iT0VijdGWAtGVEwQLCyViWdTOrTacQGV0S9Ldi
 lp3Q==
X-Gm-Message-State: AOJu0YwWXOV1Jd2+wb7vRMCpS8xWqVQAWH/Rh5R50do8PP1EpoooOgnH
 AnVpQCIieTlnfqN1HZKKTQYwnoLPd0/mdOSby31T5Qvw+4CeOBEuFeNoDiZBI9ce4VTnm1w+ywP
 6cDG9A9Q=
X-Gm-Gg: AY/fxX6LOlnZ35Q2Qa6ndlymWh4KonezFaCB10hfVN+DUk+2OE+RUnTXhuRnyFN0KY7
 c9GvCC1++3mv+ht14iW2MuUShcF2Os45NRo3YhHNpkbio1hI5F+DCtUugMQ/Tnky3Zcw5O2Ufqu
 aAeL1amxrJ7J6yYA8kyI5WPfwIlUaM5V08cMvPqTy6OStbtqRckL2aTiFWafaEd9BkmmyEK0YJw
 Kny5sm2CfBS60H0H7lyJ0S0QKBA4jYhXy6lebIrkP614pQHPI0Ro6mm9lpq3jDrnyzowbC3244q
 M9yoGPuC955N0PkyKUAwrDI+G+CFkBe+2XMj7FzApT98vs857taJsAaxNV+oLHWuyz1eoqabwvp
 ljiOqaNreBSvCHCVicQUGBXGDvGBTNPvirTD6BS3L+Xr4DG1Ei92F+LtILVTiFMqWhPeEJWqhmZ
 sRAi/XAe90mK2Is3Lf842DcKxAPhu5N7FOMts/M5zJPyPdUlN1+L/kom3+CFuP
X-Google-Smtp-Source: AGHT+IEFlcSD8N8MtPEev7k4tYzWGEyjxYs/GjRCd6fVHm3DRgObRQ0aQmVmygLM/V/3tvnmjDtR+w==
X-Received: by 2002:a05:6000:2886:b0:42f:dbbc:5103 with SMTP id
 ffacd0b85a97d-4324e4fda18mr4030083f8f.35.1766161296620; 
 Fri, 19 Dec 2025 08:21:36 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab2721sm5752327f8f.39.2025.12.19.08.21.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 08:21:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 14/24] system/memory: Introduce LD/ST helpers with @n
 suffix (variable size)
Date: Fri, 19 Dec 2025 17:19:41 +0100
Message-ID: <20251219161953.72724-15-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219161953.72724-1-philmd@linaro.org>
References: <20251219161953.72724-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Introduce load/store helpers taking an unsigned size argument.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/devel/loads-stores.rst             | 10 ++++++----
 include/system/memory_ldst_endian.h.inc |  4 ++++
 system/memory_ldst_endian.c.inc         | 14 ++++++++++++++
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
index c906c6509ee..8db6285538e 100644
--- a/docs/devel/loads-stores.rst
+++ b/docs/devel/loads-stores.rst
@@ -375,6 +375,7 @@ succeeded using a MemTxResult return code.
  - ``w`` : 16 bits
  - ``l`` : 32 bits
  - ``q`` : 64 bits
+ - ``n`` : size in bytes
 
 ``endian``
  - ``le`` : little endian
@@ -384,8 +385,8 @@ The ``_{endian}`` suffix is omitted for byte accesses.
 
 Regexes for git grep:
  - ``\<address_space_\(read\|write\|rw\)\>``
- - ``\<address_space_ldu\?[bwql]\(_[lb]e\)\?\>``
- - ``\<address_space_st[bwql]\(_[lb]e\)\?\>``
+ - ``\<address_space_ldu\?[bwlqn]\(_[lb]e\)\?\>``
+ - ``\<address_space_st[bwlqn]\(_[lb]e\)\?\>``
 
 ``address_space_write_rom``
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -431,6 +432,7 @@ device doing the access has no way to report such an error.
  - ``w`` : 16 bits
  - ``l`` : 32 bits
  - ``q`` : 64 bits
+ - ``n`` : size in bytes
 
 ``endian``
  - ``le`` : little endian
@@ -439,8 +441,8 @@ device doing the access has no way to report such an error.
 The ``_{endian}_`` infix is omitted for byte accesses.
 
 Regexes for git grep:
- - ``\<ldu\?[bwlq]\(_[bl]e\)\?_phys\>``
- - ``\<st[bwlq]\(_[bl]e\)\?_phys\>``
+ - ``\<ldu\?[bwlqn]\(_[bl]e\)\?_phys\>``
+ - ``\<st[bwlqn]\(_[bl]e\)\?_phys\>``
 
 ``cpu_physical_memory_*``
 ~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/include/system/memory_ldst_endian.h.inc b/include/system/memory_ldst_endian.h.inc
index ec86e42afbc..cf3b23bb5aa 100644
--- a/include/system/memory_ldst_endian.h.inc
+++ b/include/system/memory_ldst_endian.h.inc
@@ -20,12 +20,16 @@ uint32_t ADDRESS_SPACE_LD(l)(ARG1_DECL, hwaddr addr,
                              MemTxAttrs attrs, MemTxResult *result);
 uint64_t ADDRESS_SPACE_LD(q)(ARG1_DECL, hwaddr addr,
                              MemTxAttrs attrs, MemTxResult *result);
+uint64_t ADDRESS_SPACE_LD(n)(ARG1_DECL, unsigned size, hwaddr addr,
+                             MemTxAttrs attrs, MemTxResult *result);
 void ADDRESS_SPACE_ST(w)(ARG1_DECL, hwaddr addr, uint16_t val,
                          MemTxAttrs attrs, MemTxResult *result);
 void ADDRESS_SPACE_ST(l)(ARG1_DECL, hwaddr addr, uint32_t val,
                          MemTxAttrs attrs, MemTxResult *result);
 void ADDRESS_SPACE_ST(q)(ARG1_DECL, hwaddr addr, uint64_t val,
                          MemTxAttrs attrs, MemTxResult *result);
+void ADDRESS_SPACE_ST(n)(ARG1_DECL, unsigned size, hwaddr addr, uint64_t val,
+                         MemTxAttrs attrs, MemTxResult *result);
 
 #undef ADDRESS_SPACE_LD
 #undef ADDRESS_SPACE_ST
diff --git a/system/memory_ldst_endian.c.inc b/system/memory_ldst_endian.c.inc
index 7078666dcfc..2eb95951c10 100644
--- a/system/memory_ldst_endian.c.inc
+++ b/system/memory_ldst_endian.c.inc
@@ -40,6 +40,13 @@ uint64_t ADDRESS_SPACE_LD(q)(ARG1_DECL, hwaddr addr,
                                         addr, attrs, result);
 }
 
+uint64_t ADDRESS_SPACE_LD(n)(ARG1_DECL, unsigned size, hwaddr addr,
+                             MemTxAttrs attrs, MemTxResult *result)
+{
+    return ADDRESS_SPACE_LD_INTERNAL(m)(ARG1, MO_ENDIAN | size_memop(size),
+                                        addr, attrs, result);
+}
+
 void ADDRESS_SPACE_ST(w)(ARG1_DECL, hwaddr addr, uint16_t val,
                          MemTxAttrs attrs, MemTxResult *result)
 {
@@ -61,6 +68,13 @@ void ADDRESS_SPACE_ST(q)(ARG1_DECL, hwaddr addr, uint64_t val,
                                  addr, val, attrs, result);
 }
 
+void ADDRESS_SPACE_ST(n)(ARG1_DECL, unsigned size, hwaddr addr, uint64_t val,
+                         MemTxAttrs attrs, MemTxResult *result)
+{
+    ADDRESS_SPACE_ST_INTERNAL(m)(ARG1, MO_ENDIAN | size_memop(size),
+                                 addr, val, attrs, result);
+}
+
 #undef ADDRESS_SPACE_LD
 #undef ADDRESS_SPACE_LD_INTERNAL
 #undef ADDRESS_SPACE_ST
-- 
2.52.0


