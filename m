Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B175CE77361
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 15:25:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYQjO-0004iS-AT; Wed, 24 Dec 2025 10:24:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQj7-0004Vw-MK
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:24:42 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQj3-0004mk-5g
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:24:35 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-64dfb22c7e4so485815a12.1
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 07:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766589860; x=1767194660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h2LnS2EF/L1vH6qECRnOQ+5+8ETp4HemmgUEoFWxgks=;
 b=AJ6oq5K/rACD8bB/6Ji8M4+FlU1yC0y9K906Ty7TP1805xY6fp3gUZsyk7Z7BolOpG
 WApbUR/2da3JqQhM0PfO/aoEyyp5ynLVhZ3cMsGn6oxDEgWuCivqOctRrHdP2WaDkc2i
 AkLtfby7+75usXkj+tUQXqgWc31IfACpsLBUaRB3kADvn/xvxpwWa6PiqVZjFdcTa+NI
 B79w3Cv5ljon+99i/dvEFbZPHIY78usTp49iCvrVNxzI9tAEym/BVhn9H2D0sEowHibX
 uYCESrBLmPXBi+Ew8ul4B74unq/nJr9ECzgMWffSpehuHyIWCjIy3zFSuegTNEsEtS/J
 agEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766589860; x=1767194660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h2LnS2EF/L1vH6qECRnOQ+5+8ETp4HemmgUEoFWxgks=;
 b=OQGPeuB1T3TXLTkaFdh8aUIPrer7Jk4xC/TI7DwVJvlcLDzoUOTOPNs8sOxVKGvli1
 5M4flhjlVT/nz4mSrrZGjJ1ZmLQ534vrZ/cjmtibyUyA3kuqC0/RlId+tWRReaOgXgVl
 w4xpnikWBzG566H4yspkX7UpQskhsk1Hy+d9+KpwCoImINyBn4mGQ8AhZB+dFXennNV4
 21/BLzf73QTN1U/vk94ST75T9uRGf3enHTN3vLNj5uZd0sPR/RejFx37DsRjkqfCOeb4
 NRLF+sRs2Jfc/5CpYle8pCMyLoX8Eph50YoU7AgCN7HsU31RtiINLvxhSvVHIOcKBg/b
 Tj8g==
X-Gm-Message-State: AOJu0YwHesc3ut9ffIm5Sbh0YDvDpR/ddiI65hLLBACq2w6jryho9Kd+
 gyJ6GyfBJme/BiwNjBxBhh0N7EoITisCivcpP04pmyOZqwbBsnKPgdnm23ct2KFOsR9fV1svn07
 JMc/O5qA=
X-Gm-Gg: AY/fxX5lIsNhlfT1w1neNaKQFv1raAHEhFljrbpdobU2Kir47nlXLNpNOIeovRtZa0k
 4dlPzFeZfE5vCkb6zqAQzPOLri1Flmn3UmhkgIbdsmdecr/hCKfPjNKhxbtzxgb/UtswBopnyco
 fLt9fNoRfCNgE4ZHpLv2Qasnt9ZyEWwls337++uyvduZ7fdMSd8eHIo8+iyhBHSKaAxCHR8mBXK
 LU2CTR0PtvpHPbt9NbsjA9ARkPNeXKzI9VxLpK+LhT5a7H7i76g7JMJLFfV9x3kZEFNgku8P5fa
 xbA/3bmXIKtjl3d+wC4coC6XrXcKPxbMuyTotvaz9ek1X8TPUJiALZ6Ij+9v4fGGGBJQrtmKZts
 KnyYSGH9LV3XieBuN9sIWeC7zJsxV0FYCjk0jkT5k4TClnssK1f2inhEZzok/+YxCOOGxS8Dzxw
 PTCy8Wc+wHc55fvu1kU8885aIvyIdi4h4dZPlr6c7x66ncVGMSJVixJRE=
X-Google-Smtp-Source: AGHT+IEI8eg8MI8pK6JYyCHj3z4uX+yX1iCBv97wIPioNu1mszYKQNcY+4XwW6Dshrd7JfSJNP4yGw==
X-Received: by 2002:a17:906:31c4:b0:b80:4060:8a6a with SMTP id
 a640c23a62f3a-b804060955emr1375279766b.25.1766589859887; 
 Wed, 24 Dec 2025 07:24:19 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037ab86cesm1796008866b.19.2025.12.24.07.24.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 07:24:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@kernel.org>
Subject: [PATCH v3 13/25] system/memory: Introduce LD/ST helpers with @n
 suffix (variable size)
Date: Wed, 24 Dec 2025 16:21:56 +0100
Message-ID: <20251224152210.87880-14-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224152210.87880-1-philmd@linaro.org>
References: <20251224152210.87880-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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
index f5b6b496be5..77850f1a18d 100644
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
index fb933de11f8..4ff050027f5 100644
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


