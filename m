Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93669D26D6F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 16:53:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veFjz-0001By-93; Fri, 09 Jan 2026 11:53:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFjw-0000pb-Iq
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:53:32 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFju-0007ds-RR
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:53:32 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4779ce2a624so37114835e9.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 08:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767977609; x=1768582409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e3vBt+/cHvUwaWL5WGQ08yAwhNp1rybGH7qjumTtzBQ=;
 b=djh6PBhBz45sTjRU8BFDv8UsAi66hWzggJBYDTBXiFjoCUXtVJCoJ9QBUDj5AOT1jk
 S+j1pnTrBLZtQbf+owEyEQIZ/OYsGTjUeYvLgQdE0uFOfMfjMuRSRwWt/9Rubbr471ZP
 a9Z3K3i4zHuYS5ImONeUCJ6gDFuQ1NAerKa8B7+WNspgCnh2eJ5wAHixDO+f//QQz0/D
 p9zkGRINC5U3Cxj7KuoTOg0O2tOKgDRgZHsbl7ky+ejlqp31+tVvWknBNVVQEk8k29Jr
 drhXCFyH2CcFAzKqVoa+Sc0oE5HmNbVg0c+ojM2V4fczsIhqciJlR09yIZeJvCtsV0SU
 M01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767977609; x=1768582409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e3vBt+/cHvUwaWL5WGQ08yAwhNp1rybGH7qjumTtzBQ=;
 b=onzloj7UPK4Y6qd8d2zxJOK7s6e5fyZ9eQpjmPhAWqnNiqGkFU4s1Fya7sgpAW6MaJ
 3e1tzv1Agu92lYtk0gjZLG0tjuy+/ONF9A023s6swMilz97GFoNL4lFa7bqZAEa0HYY8
 /arTN8Olu4ZxpuxXS7014WdSffUIA73Sxbwx/r7QjF+sCGQzCmxZKER+ZUfZxkIXNH59
 YqmVwyNhRrtE19oTOfSNc9g5pPq3puK4NytbBpBy+CaeLCh9vTyRhWIU2mRF1gEw0DTo
 WCh3HrPs+ohZgzEMKNaEt5lASmboCKpQwwbxBLS8mwkfeh0WQWF4pYr9MmqJvLIfsgwC
 UFEw==
X-Gm-Message-State: AOJu0Yyk+hEt3Wjv/MCQUFI5GC6CSdNO4DfaWP0dCbLYXEjcERqJToZJ
 4eTFEoBR1psHsT/Ed7a1URikUnKFgqw62bjWpj1d+PdSfOZGxC7SYRnUm1k50KhS6s+R9JQvjVu
 Z2zYSKJs=
X-Gm-Gg: AY/fxX7lwfK3IlnakDyI3elBxR53gaIoLqfv7ypcxBmzVl0paBMc25XK2mNCw1esHcC
 AZOCGnAkgFmMMT0KaP08096AP7rofzgd2gpkGcHu/UhtBMUIg9+e4UVEIrB6yoSUrExGdvgfd9y
 FMyA/anaGpQVG04cbEb49OUKFKwkL+XSY/QjN7kUKL46fumLEVDrzD3IrDZIeKPr7ZBZqKZ9kuM
 5rUAbo+dlM9hHRf29lyJu0rUwS1rIErxZlkxIc/dHVIsvkcw9H15LMS0hbsEJ5cue/QW8gDD29i
 OdN95uhNDoUes7ehDgHMmqoBr1uS1wWIT+FQ0xFIqn24cqIzHSrqzJ3apNuhjzJkj0ZP1HKZmTr
 YUo0LAfA1HPZlnlGyRkuGFNjmnPOBP/mJAkPA4+g7rY3O9ht6tXDJMlOgX86lnZ0VV4UlpAPZxM
 1vbeHD3sLq+s4Ukclp0YYefkAUali9zLyTjwDzogaZZHbxx9rIldPeyb9m5BszK+VGpaiG8Cg=
X-Google-Smtp-Source: AGHT+IGCVZbMvLRIbuyJGj9IbF4psjfUtUVxpsF65dwdkbeSXvxQVCHq7Fi4VJ9xCSVcK+G7I3kogA==
X-Received: by 2002:a05:600c:a106:b0:47d:73a4:45a7 with SMTP id
 5b1f17b1804b1-47d84b3badfmr115007595e9.24.1767977609060; 
 Fri, 09 Jan 2026 08:53:29 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d8717d9e7sm64371435e9.8.2026.01.09.08.53.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jan 2026 08:53:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v5 22/22] system/ioport: Do not open-code
 address_space_ld/st_le() methods
Date: Fri,  9 Jan 2026 17:50:58 +0100
Message-ID: <20260109165058.59144-23-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109165058.59144-1-philmd@linaro.org>
References: <20260109165058.59144-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

When a variable size is known, prefer the address_space_ld/st()
API. Keep address_space_read/write() for blobs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 system/ioport.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/system/ioport.c b/system/ioport.c
index 4b94f2f8111..9209bff2eab 100644
--- a/system/ioport.c
+++ b/system/ioport.c
@@ -62,58 +62,50 @@ const MemoryRegionOps unassigned_io_ops = {
 void cpu_outb(uint32_t addr, uint8_t val)
 {
     trace_cpu_out(addr, 'b', val);
-    address_space_write(&address_space_io, addr, MEMTXATTRS_UNSPECIFIED,
-                        &val, 1);
+    address_space_stb(&address_space_io, addr, val,
+                      MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
 void cpu_outw(uint32_t addr, uint16_t val)
 {
-    uint8_t buf[2];
-
     trace_cpu_out(addr, 'w', val);
-    stw_le_p(buf, val);
-    address_space_write(&address_space_io, addr, MEMTXATTRS_UNSPECIFIED,
-                        buf, 2);
+    address_space_stw_le(&address_space_io, addr, val,
+                         MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
 void cpu_outl(uint32_t addr, uint32_t val)
 {
-    uint8_t buf[4];
-
     trace_cpu_out(addr, 'l', val);
-    stl_le_p(buf, val);
-    address_space_write(&address_space_io, addr, MEMTXATTRS_UNSPECIFIED,
-                        buf, 4);
+    address_space_stl_le(&address_space_io, addr, val,
+                         MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
 uint8_t cpu_inb(uint32_t addr)
 {
     uint8_t val;
 
-    address_space_read(&address_space_io, addr, MEMTXATTRS_UNSPECIFIED,
-                       &val, 1);
+    val = address_space_ldub(&address_space_io, addr,
+                             MEMTXATTRS_UNSPECIFIED, NULL);
     trace_cpu_in(addr, 'b', val);
     return val;
 }
 
 uint16_t cpu_inw(uint32_t addr)
 {
-    uint8_t buf[2];
     uint16_t val;
 
-    address_space_read(&address_space_io, addr, MEMTXATTRS_UNSPECIFIED, buf, 2);
-    val = lduw_le_p(buf);
+    val = address_space_lduw_le(&address_space_io, addr,
+                                MEMTXATTRS_UNSPECIFIED, NULL);
     trace_cpu_in(addr, 'w', val);
     return val;
 }
 
 uint32_t cpu_inl(uint32_t addr)
 {
-    uint8_t buf[4];
     uint32_t val;
 
-    address_space_read(&address_space_io, addr, MEMTXATTRS_UNSPECIFIED, buf, 4);
-    val = ldl_le_p(buf);
+    val = address_space_ldl_le(&address_space_io, addr,
+                               MEMTXATTRS_UNSPECIFIED, NULL);
     trace_cpu_in(addr, 'l', val);
     return val;
 }
-- 
2.52.0


