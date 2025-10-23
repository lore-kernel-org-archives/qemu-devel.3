Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93849CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBtsx-0005tl-09; Thu, 23 Oct 2025 07:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBtsv-0005pW-31
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:53:37 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBtst-0002d4-42
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:53:36 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e6a6a5e42so4044725e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 04:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761220413; x=1761825213; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TTm87lVVxROZNlFfDmq1tJ6XtWX537djOuc6Uhcrzng=;
 b=qM4eZbtnv6HoM/UA+ZUG4eOTxj8v2n3q5s5jVIOHymmONtMXQiGkP6HENkvPEqBNbX
 xy6872Wd2SpiCF0rOp6xJJM1nkIGg/wv/3Cb/sQnQSgC7HKsAy/4T4jV1K8evCiNaO1U
 VWeQP4XDJEPQBXTgxv28EWz5sTw8azxSyD8Knzm7fLrGIvxG7HoRr1DM7YHPjDxexy6c
 9jq3JZzbo3ZfW731R69kZagE6M0wOjp8Hmhzp+zJXW6IGzgghSDJhVT3lGHWEM1dIMBV
 FpaYxccPtvLeNGxzxExvThERswigecL3ZwPN0zSxIEaeoGDx7AREfDzeJgZvoqFU/0eX
 ewqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761220413; x=1761825213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TTm87lVVxROZNlFfDmq1tJ6XtWX537djOuc6Uhcrzng=;
 b=xKa8oNc1/4gwnstsm/La5WGVoEzVlcBNXEiZ6cvnVD/bkf3ZWCB8Xj1BT/L6B1b02b
 JiafQLI/TVwEKl82DooNuSjiIgvXNpAu2foH+4XHEhuvb1fVohADnridq7IqDPPnKkCR
 vjskVCCjBgRytHqbKumrJTfTG0Dv7x2h4cWnEmcPz5neGk+4iFybv9lIwlCfuriCaPh1
 lcivFWuoRkWy/PfeLWgYuBhfltZ7D/keICga1lBAekSETo4tHLRrsn3wxmz2LOHdj8Xt
 9ef1wNBVPAk/O/RZzpnGoXV9E0uz8UDosgU4Hq9JiLu1UYNgSvTSkUY95VRZSARFn84D
 Krag==
X-Gm-Message-State: AOJu0YwrXM0en2qnjdghSCeGtsvSrtZ4omf7vMlYOmQEhm1vbHl6T9tY
 +dDsJjvp6ClZKkhvn+t67kxqF750hD0uKjwnNUvvlSajWb2tylcjHpn8SBNXg+AWVdMfxmTB/g8
 /tpUx6tE=
X-Gm-Gg: ASbGncuPC/qxkezEiYZEGqbsFm8pfMwQ1OeU3lYZyX3gtSNgQPHS935aIQyQDUJy23H
 OXXTWsOobPqvq9584X8qFHgXNv/a+bbODiveEZcNrezn/Gtdk6JBC8X/lA2hRmyGJJCT9y/6OGR
 oiYaX7+rSJOqx5YXEKvgMraw5Gs74Ptj5kTS56AwRYnwZ4X6GO7Hd5La0dr43uwyP3z0bKgkY8j
 ND8oWlxYeThRAPVSWk+S9tIjnrNj7+Y+6a8SQgwVO73lDFjbZ3IbHaPFsDgyD3NHSrJckJnVmmV
 zA+SvWgq8NL+8PTVdyEvTHXW1fVr34UxMPxG8Uejm3gdd0Nrx6IBoBPOeU6/s6IUweQ4K1sG/oC
 iacMS+6XeYPMJz6FhiQZQJHkDxmIhMBQRzMVNmgx8YQyqLu2Cw8rk+0Q0D90eBWn9wxJ4NAGJDm
 g71XPuUVz2YlMQMLwcszL3rHF3kthDMomoVhgvSpIj7CcZRQZvfqkPRy1/KVs+
X-Google-Smtp-Source: AGHT+IHOxbkqRSG1vuLJQbVlCrQUtDR7pfJcRsrvZ77YgeE8tCkRscDEYZuPOexE06C8p98VkX27Qg==
X-Received: by 2002:a05:600c:3581:b0:45d:d5df:ab2d with SMTP id
 5b1f17b1804b1-4711790bf23mr164792475e9.26.1761220412775; 
 Thu, 23 Oct 2025 04:53:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c4378cbesm89767375e9.16.2025.10.23.04.53.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 04:53:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Peter Collingbourne <pcc@google.com>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 34/58] accel/hvf: Create hvf_protect_clean_range,
 hvf_unprotect_dirty_range
Date: Thu, 23 Oct 2025 13:52:45 +0200
Message-ID: <20251023115311.6944-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/hvf_int.h |  3 +++
 accel/hvf/hvf-all.c      | 25 +++++++++++++++++++++++++
 accel/hvf/trace-events   |  1 +
 3 files changed, 29 insertions(+)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index 3d2be4092ef..5a57691885f 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -89,6 +89,9 @@ int hvf_arch_get_registers(CPUState *);
 /* Must be called by the owning thread */
 void hvf_arch_update_guest_debug(CPUState *cpu);
 
+void hvf_protect_clean_range(hwaddr addr, size_t size);
+void hvf_unprotect_dirty_range(hwaddr addr, size_t size);
+
 struct hvf_sw_breakpoint {
     vaddr pc;
     vaddr saved_insn;
diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 0a4b498e836..e13abddbd9c 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -58,6 +58,31 @@ void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
     abort();
 }
 
+static void do_hv_vm_protect(hwaddr start, size_t size,
+                             hv_memory_flags_t flags)
+{
+    hv_return_t ret;
+
+    trace_hvf_vm_protect(start, size, flags,
+                         flags & HV_MEMORY_READ  ? 'R' : '-',
+                         flags & HV_MEMORY_WRITE ? 'W' : '-',
+                         flags & HV_MEMORY_EXEC  ? 'X' : '-');
+
+    ret = hv_vm_protect(start, size, flags);
+    assert_hvf_ok(ret);
+}
+
+void hvf_protect_clean_range(hwaddr addr, size_t size)
+{
+    do_hv_vm_protect(addr, size, HV_MEMORY_READ | HV_MEMORY_EXEC);
+}
+
+void hvf_unprotect_dirty_range(hwaddr addr, size_t size)
+{
+    do_hv_vm_protect(addr, size,
+                     HV_MEMORY_READ | HV_MEMORY_WRITE | HV_MEMORY_EXEC);
+}
+
 static int do_hvf_set_memory(hvf_slot *slot, hv_memory_flags_t flags)
 {
     struct mac_slot *macslot;
diff --git a/accel/hvf/trace-events b/accel/hvf/trace-events
index 2fd3e127c74..f989da59492 100644
--- a/accel/hvf/trace-events
+++ b/accel/hvf/trace-events
@@ -5,3 +5,4 @@
 # hvf-accel-ops.c
 hvf_vm_map(uint64_t paddr, uint64_t size, void *vaddr, uint8_t flags, const char r, const char w, const char e) "paddr:0x%016"PRIx64" size:0x%08"PRIx64" vaddr:%p flags:0x%02x/%c%c%c"
 hvf_vm_unmap(uint64_t paddr, uint64_t size) "paddr:0x%016"PRIx64" size:0x%08"PRIx64
+hvf_vm_protect(uint64_t paddr, size_t size, uint8_t flags, const char r, const char w, const char e) "paddr:0x%016"PRIx64" size:0x%08zx flags:0x%02x/%c%c%c"
-- 
2.51.0


