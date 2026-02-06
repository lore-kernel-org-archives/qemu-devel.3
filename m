Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58934EE6B68
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 21:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voTh0-0001AT-77; Fri, 06 Feb 2026 16:48:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTfC-0006Yo-K4
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:46:54 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTfA-0002jQ-Ga
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:46:54 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-482f2599980so30664865e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 13:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770414411; x=1771019211; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5A6OGpssSqqoKEioGQUFiyllr2e7XdPAmCmuZAGsgrU=;
 b=ct/CMcGB3ogfnoPEt/jhBZX33BdoRXBZkQn2VnqQrwui8x7KcBOJcoD95cbdoN9krX
 NZcZw7i+I0FmDIfIaGxVix/UIK12EJvSR2vgtyDvpIa4VdqP8L6iticZlBK/XgDHL83g
 WqYeZAEC3+zfLLaW1K7AHiwomrRIBvJs/V17iJuwfsXtYemftBE/s1Ljql5tThafAChs
 MU/wmeA+bOeQl0o2rLSDDZGHXwUq+gj5HuIt17Rq+yPoqhdixu0mAsGBe5rWpRMT4Sj6
 AfGkwSjns+zeb1lEcMpcG6GQJqq03tyRh5HW0gRt2npUJOZF/kw4eSb70jluVmL1ZeZC
 eYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770414411; x=1771019211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5A6OGpssSqqoKEioGQUFiyllr2e7XdPAmCmuZAGsgrU=;
 b=Jk5GBzouN6NryVyyRmoGLLb0HQy+eUkI98CThO7y35EdfZZp5iTCuKab6Cm9OD1hsq
 hyYKka6Q0NtZb3QARJk1ZN1i/+STM92zPiqEvabGy6SpG51+0PUbf/4iAhvokCYCu4An
 uvp3WYQDVBD9cSpo5r1zpx8PSzFHLIf8NPOMOS1UaeMY4YYpBFzs6SS1+NOCcJ6xZAeR
 DY6L4QhW/YG768VRVHhGlHvkYnxRgFTQKJIEyNzHMZ6pevdccLahQMGzDqUTpmwug7Jd
 Omh3ZObAjMYsE6tbVDESV1KcFjswVLVcRkYyPHh6TXWdjuqyJgRFoPW/SNXBVck6Y5g7
 NHSA==
X-Gm-Message-State: AOJu0YxW9XsupWiqmLVNyGBu57xmQ6W0/0S+xL3s/xAfPpwPSDWgFh47
 ANIMSOts3Cjvs7ELS0i216YVfKQ2Nii97qknKlSudMmgZUPMQUMPjr4G65PmxMD5sfQGHKy5iql
 Hm4lSshs=
X-Gm-Gg: AZuq6aKY+QnjcAtUsJGJTQ0qXF0xbB8wIV53hX/da6XJGBeKT4qCLjhwzZcNd5tRuUA
 3X/tZnsWzYKObZG5GSwdAKisVXORf+Q8BvSH4gDT4DjqYqkLJ00bBxFa5/SIAu3t0V+sks3t4+m
 qxf9VjVhO2ZQgl1GEQBq5aFlz2Abnifd00og8SALVuK2GFW/PrQ6ByaLX/P58ucnV2Ci7dKE2dM
 txe8gzgqeCh+y5VqItSORJn+Hjgimg7gu0001gCJgQoe1pu8tAup2AhiVUN8wOvd62HCZ0r8ezZ
 1IZi481L8fLKbTfiekYP0vCY4sxP0Clim4bq+tAa9zhkPTL3or57tBjQUqz8BnV+BIan4b7uUGl
 j1ajbjIuU5Cwb7bx6Zck+BYZEK0wFrlGEhKiRCWY8HWaKejl0yid0BETXNtEYhyt6tEguNMz6On
 4r/PMHV/5/3ntrrWMNYgJV5D7z4mJNYXm1qz087+Ol5oL2x1zk73Eb5hfGkN9+
X-Received: by 2002:a05:600c:3509:b0:477:7a53:f493 with SMTP id
 5b1f17b1804b1-4832021b711mr53436295e9.23.1770414410683; 
 Fri, 06 Feb 2026 13:46:50 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296bdc11sm8098693f8f.14.2026.02.06.13.46.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Feb 2026 13:46:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
Subject: [PULL 18/30] target/i386: Use explicit little-endian LD/ST API
Date: Fri,  6 Feb 2026 22:44:36 +0100
Message-ID: <20260206214448.22008-19-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206214448.22008-1-philmd@linaro.org>
References: <20260206214448.22008-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260204204103.46343-2-philmd@linaro.org>
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


