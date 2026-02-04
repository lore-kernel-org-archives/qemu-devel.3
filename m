Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB718EA7944
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 20:41:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnjgc-0006R3-3G; Wed, 04 Feb 2026 15:41:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnjga-0006Qg-2v
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 15:41:16 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnjgY-000378-9z
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 15:41:15 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-4359a316d89so228852f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 12:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770237672; x=1770842472; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OBZUhK4NBIfVwwKndj7XLGMI5lFYBXqizdp8CnNTnt0=;
 b=BFt4gSwJ/324hOx7XNcOnuyst7bWkZScLiY49x5iBD/NP0R8cTt+C/cOkzISFd8ydg
 /KGKWjNlAzI7jhW61AXz6aWwOvd7IxIggaFzXSK8RsYGKo6Cl1W7J4E+xRwpYqJgE9Dk
 VVNOtJV48U0asO6Xim7XFwzDo9FtaUBS4KpdOKtLBjkvM5rekSrDCU/IVxKud2b+wWnV
 EV/F8DnegFWWdFqbwsUR4Kw/V5s2ynTKgQGib5w8AMyKKwZ/wIUp8v7P8JsomC72uM5K
 +ro2EbwZJNFhnmZErN3rToW6ACEBk02aSUsupZFZPAMCTD6FFpwj/UVzDpl+ml6YfgJC
 omZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770237672; x=1770842472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OBZUhK4NBIfVwwKndj7XLGMI5lFYBXqizdp8CnNTnt0=;
 b=r/SZJnQIvePqlkBc+Qg0Ca4z+VAg46+6C3JRbcmTW5lclPqly2TUToHy7oxYlnFVXG
 CBV8OJyJs1kK+uS4Dae3Bpl4Je/cMsZBFV9NDo7D6rrAUsFG5ssj8sUyeCU1TGbUIokH
 t0waxijyPtAEB2M26WedO7JazPBuLOdT3iZG8PZWECH/QWwVIIsYp3QUZVDLIQT+Gc/s
 8OTQF5YXP3fIfekpKBnCP0pjKAzdsSdROW7KR5szguwu6mOWVDVSJxIRNdqfTRrWMLro
 /rV0TXJU774BIMhcEFwAXipdAp2yvwFJ4FmoKIh6xjBQJ2YuIV0nUg7BgeOrv1cLTmSO
 0QwA==
X-Gm-Message-State: AOJu0YxkSRNVetckgtExSPJkyuGBmB5WaM8KKlShGeY+MhavLyO1bjaT
 qO9EUzpClAy/IR+sDoOI/Rjt+X5xunji1oNvEQxRM0T+lAFgoH/wU7XMz9s5QdQ3plw7pDRCMYX
 0pVlIO2c=
X-Gm-Gg: AZuq6aIXTwqAh5cWr7mPRrqsxc3EYylvn++EnDb2NgDA2TUjrbZix4oJMGHE8z5Tyj4
 f1VpPCqDQrE7F28zBP+LTJSEduBvIfaOsvfHQEhYQyvwO4DTzPS6dH0J2uYMBIoBEm8aTgnzpab
 dCupxIYgr+nfJhQaD7qOCvZMS18R3PtVDI9UOhIyN8nvn3S5fGe99rk7CdhKARPf+FZLT3Gtqtf
 WmDEWlksx18RqNCApWLJSRSpdsvxph3Ix89puES3Gz0ohmZgID4zGYN6Ps2Xc8K7ppDpEjyNezt
 ca1/cDBTSyCCgNhqoaLbfjnjNLkB9rHbXWLx3dtAMXzaNKTlNlc4B7fXw06TN4ttOHpI8TkBhbH
 oB+2vBFYBZoX4p6p8wEXODYD+GpnZsr2+v5UAjZi7JVKPrwnMAWM8uMAMb2jfqpQzZY051Zafga
 DbQLenalDUPkCsDDEso+EWixpp6+b+OyigiBNb7XiPngYwVQBlsGvOK/lvJKMf
X-Received: by 2002:a05:6000:2207:b0:431:3a5:d9c1 with SMTP id
 ffacd0b85a97d-4361805500amr5849739f8f.30.1770237672332; 
 Wed, 04 Feb 2026 12:41:12 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4361805f8c1sm7300776f8f.37.2026.02.04.12.41.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Feb 2026 12:41:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/4] target/i386: Use explicit little-endian LD/ST API
Date: Wed,  4 Feb 2026 21:41:00 +0100
Message-ID: <20260204204103.46343-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204204103.46343-1-philmd@linaro.org>
References: <20260204204103.46343-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The x86 architecture uses little endianness. Directly use
the little-endian LD/ST API.

Mechanical change running:

  $ for a in uw w l q; do \
      sed -i -e "s/ld${a}_p(/ld${a}_le_p(/" \
        $(git grep -wlE '(ld|st)u?[wlq]_p' target/i386/);
    done

Coding style adapted manually.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/helper.c                 | 12 ++++++------
 target/i386/tcg/system/misc_helper.c | 16 ++++++++--------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/target/i386/helper.c b/target/i386/helper.c
index f9f9488eb4d..c397a6fde5a 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -669,7 +669,7 @@ uint32_t x86_lduw_phys(CPUState *cs, hwaddr addr)
     MemTxAttrs attrs = cpu_get_mem_attrs(env);
     AddressSpace *as = cpu_addressspace(cs, attrs);
 
-    return address_space_lduw(as, addr, attrs, NULL);
+    return address_space_lduw_le(as, addr, attrs, NULL);
 }
 
 uint32_t x86_ldl_phys(CPUState *cs, hwaddr addr)
@@ -679,7 +679,7 @@ uint32_t x86_ldl_phys(CPUState *cs, hwaddr addr)
     MemTxAttrs attrs = cpu_get_mem_attrs(env);
     AddressSpace *as = cpu_addressspace(cs, attrs);
 
-    return address_space_ldl(as, addr, attrs, NULL);
+    return address_space_ldl_le(as, addr, attrs, NULL);
 }
 
 uint64_t x86_ldq_phys(CPUState *cs, hwaddr addr)
@@ -689,7 +689,7 @@ uint64_t x86_ldq_phys(CPUState *cs, hwaddr addr)
     MemTxAttrs attrs = cpu_get_mem_attrs(env);
     AddressSpace *as = cpu_addressspace(cs, attrs);
 
-    return address_space_ldq(as, addr, attrs, NULL);
+    return address_space_ldq_le(as, addr, attrs, NULL);
 }
 
 void x86_stb_phys(CPUState *cs, hwaddr addr, uint8_t val)
@@ -709,7 +709,7 @@ void x86_stw_phys(CPUState *cs, hwaddr addr, uint32_t val)
     MemTxAttrs attrs = cpu_get_mem_attrs(env);
     AddressSpace *as = cpu_addressspace(cs, attrs);
 
-    address_space_stw(as, addr, val, attrs, NULL);
+    address_space_stw_le(as, addr, val, attrs, NULL);
 }
 
 void x86_stl_phys(CPUState *cs, hwaddr addr, uint32_t val)
@@ -719,7 +719,7 @@ void x86_stl_phys(CPUState *cs, hwaddr addr, uint32_t val)
     MemTxAttrs attrs = cpu_get_mem_attrs(env);
     AddressSpace *as = cpu_addressspace(cs, attrs);
 
-    address_space_stl(as, addr, val, attrs, NULL);
+    address_space_stl_le(as, addr, val, attrs, NULL);
 }
 
 void x86_stq_phys(CPUState *cs, hwaddr addr, uint64_t val)
@@ -729,6 +729,6 @@ void x86_stq_phys(CPUState *cs, hwaddr addr, uint64_t val)
     MemTxAttrs attrs = cpu_get_mem_attrs(env);
     AddressSpace *as = cpu_addressspace(cs, attrs);
 
-    address_space_stq(as, addr, val, attrs, NULL);
+    address_space_stq_le(as, addr, val, attrs, NULL);
 }
 #endif
diff --git a/target/i386/tcg/system/misc_helper.c b/target/i386/tcg/system/misc_helper.c
index 0c32424d36a..bb79d4e470e 100644
--- a/target/i386/tcg/system/misc_helper.c
+++ b/target/i386/tcg/system/misc_helper.c
@@ -42,26 +42,26 @@ target_ulong helper_inb(CPUX86State *env, uint32_t port)
 
 void helper_outw(CPUX86State *env, uint32_t port, uint32_t data)
 {
-    address_space_stw(&address_space_io, port, data,
-                      cpu_get_mem_attrs(env), NULL);
+    address_space_stw_le(&address_space_io, port, data,
+                         cpu_get_mem_attrs(env), NULL);
 }
 
 target_ulong helper_inw(CPUX86State *env, uint32_t port)
 {
-    return address_space_lduw(&address_space_io, port,
-                              cpu_get_mem_attrs(env), NULL);
+    return address_space_lduw_le(&address_space_io, port,
+                                 cpu_get_mem_attrs(env), NULL);
 }
 
 void helper_outl(CPUX86State *env, uint32_t port, uint32_t data)
 {
-    address_space_stl(&address_space_io, port, data,
-                      cpu_get_mem_attrs(env), NULL);
+    address_space_stl_le(&address_space_io, port, data,
+                         cpu_get_mem_attrs(env), NULL);
 }
 
 target_ulong helper_inl(CPUX86State *env, uint32_t port)
 {
-    return address_space_ldl(&address_space_io, port,
-                             cpu_get_mem_attrs(env), NULL);
+    return address_space_ldl_le(&address_space_io, port,
+                                cpu_get_mem_attrs(env), NULL);
 }
 
 target_ulong helper_read_cr8(CPUX86State *env)
-- 
2.52.0


