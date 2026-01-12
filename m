Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74791CF45D5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQnk-0003D5-ET; Mon, 12 Jan 2026 17:54:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQnc-0001wZ-5b
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:54:12 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQna-0003gV-HP
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:54:11 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47d3ffb0f44so48141345e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258449; x=1768863249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PVOxqKe7m5GyEtl7twW69S76IsK+WydF2jTWuzF0bHQ=;
 b=LoA99oNV+ahd74X0V5pTXSiHZBwAIFyzgcFtGbciGmd+xbqiF8EDskWF3C554yXmrj
 3Pxypxz20OTHunCHwqbM41SlSehUIs8nurrf3Po+dqjmTipVdO5OtQAYqKQeauesgnP3
 tyLA2z72hC1NN4BxU+LkMh/yHKP8CqAS0QftCUkel5DvQo6/SvjUNuj+zc6bwCmDz+Fv
 /Jz0L96c9pkYeckYmlmkUbBs5ufWMTaM2TMx79VfcV+owQigsV3irFycJWBIsPSzYZWL
 BPnvvSmE2WCt23WLfJ/Ok0zev6vvYtp28pmcPAF6gd4w/iuNvOhRmfmd0qVXyBwQMUHD
 29jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258449; x=1768863249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PVOxqKe7m5GyEtl7twW69S76IsK+WydF2jTWuzF0bHQ=;
 b=HhaTp7L3UDcX6oRm4wKXY096+ZYi63dhzN83j08BmYGx2UJ31rAEHrysq+uX8Zahvw
 spuh6gjNGxthxjIXtrHCj/9FyEAz7qQ2jW2E3MnGL1w93bcOKVRQaxJOYBIM1AO1TZMC
 fIf/164ht8T4f4OdYzXmiCfrIh1URrY5e7mvYr6xqDWGOUXLYA8pWIcpBUF1vpY3nXGS
 0ARlT5JmFjIE+0HnraPqfc3oNcKUBOvzHrrb5K1gx9vkVlrXmxEiFCjDPglX4o8w4PKy
 W50WEwYvZ1YmVH2auuYaXQdD8YCcuxY+N3MnK/hmPTlmgxVXn9zQ0v1XDAQ5IOIkAnmV
 3lEQ==
X-Gm-Message-State: AOJu0Yx0Og8tbMe+2LlBJ7FCdgSm2u311y0wijWpKXGlt/qJIt7lppiq
 +uXyGLboYybC6LlJg6STQQBJdurreNvaeuQVZo9VQbH5M9JXuZTgv/wgSqE3CUnrGBCZtzmqvAE
 afu60tEQ=
X-Gm-Gg: AY/fxX6cpeopdMl01O/EKi8g9ON/wCGzJGPcibYYDvvONyBZRbWEbJfq1xmtDB+8Ml+
 SmWsDpqqbixcZ8ahdh9g/dBYwzp056VpPntg706knSzzarOYFM1f//qoW/xq1+EyDdRwu/zY3iI
 TMDiX36SxNf+brd+eruCKUZcK+9WIBNIrXOnBJciGI/1urWclfvN+deaf3vrkCXFyvUDjolxMl/
 yThkDdZyG8DxJu16YS3H5ouUrLKaGaKnQYuWWj4so6D0N9cKWC11alcEexZrU+i9gy5JXMmjrnk
 toglluf64TqXTLhWLvEHhxXFZ8wi5VWc/vR8l3Z9NP8Q1Gj1f5HToKxbdOickKr8bzouZrQU62Z
 DMEnXgOH0djtZaJnHD/bftqgx7R74Stgnhhl2NeIDx00hm3BPN/AdVsYxtJJ5KulRTEq2UcSdDG
 8GZFtIV5UP/VGsD496KP2eWVZVIBuk72A9v/vzmGYhq3tfYWm4FElw5vCWGu5i
X-Google-Smtp-Source: AGHT+IFerl6XOTnhunaAQTE6+5cb6XuiJP06hS4J5h5M8v+40yTiLDuW0LBXL7YzC0HpAl3MlaUDfQ==
X-Received: by 2002:a05:600c:a47:b0:477:54cd:200e with SMTP id
 5b1f17b1804b1-47d8e56624emr178847135e9.1.1768258448766; 
 Mon, 12 Jan 2026 14:54:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5fe83bsm40785338f8f.38.2026.01.12.14.54.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:54:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 45/61] target/rx: Use explicit little-endian LD/ST API
Date: Mon, 12 Jan 2026 23:48:40 +0100
Message-ID: <20260112224857.42068-46-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
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

The RX architecture uses little endianness. Directly use
the little-endian LD/ST API.

Mechanical change using:

  $ end=le; \
    for acc in uw w l q tul; do \
      sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
             -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
        $(git grep -wlE '(ld|st)t?u?[wlq]_p' target/rx/); \
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251224163304.91384-3-philmd@linaro.org>
---
 target/rx/cpu.c     |  2 +-
 target/rx/gdbstub.c | 24 ++++++++++++------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index f5f4f3ba4ab..0437edca1ba 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -99,7 +99,7 @@ static void rx_cpu_reset_hold(Object *obj, ResetType type)
     resetvec = rom_ptr(0xfffffffc, 4);
     if (resetvec) {
         /* In the case of kernel, it is ignored because it is not set. */
-        env->pc = ldl_p(resetvec);
+        env->pc = ldl_le_p(resetvec);
     }
     rx_cpu_unpack_psw(env, 0, 1);
     env->regs[0] = env->isp = env->usp = 0;
diff --git a/target/rx/gdbstub.c b/target/rx/gdbstub.c
index f222bf003be..30074c9da7b 100644
--- a/target/rx/gdbstub.c
+++ b/target/rx/gdbstub.c
@@ -56,7 +56,7 @@ int rx_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     uint32_t psw;
     switch (n) {
     case 0 ... 15:
-        env->regs[n] = ldl_p(mem_buf);
+        env->regs[n] = ldl_le_p(mem_buf);
         if (n == 0) {
             if (env->psw_u) {
                 env->usp = env->regs[0];
@@ -66,38 +66,38 @@ int rx_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         }
         break;
     case 16:
-        env->usp = ldl_p(mem_buf);
+        env->usp = ldl_le_p(mem_buf);
         if (env->psw_u) {
-            env->regs[0] = ldl_p(mem_buf);
+            env->regs[0] = ldl_le_p(mem_buf);
         }
         break;
     case 17:
-        env->isp = ldl_p(mem_buf);
+        env->isp = ldl_le_p(mem_buf);
         if (!env->psw_u) {
-            env->regs[0] = ldl_p(mem_buf);
+            env->regs[0] = ldl_le_p(mem_buf);
         }
         break;
     case 18:
-        psw = ldl_p(mem_buf);
+        psw = ldl_le_p(mem_buf);
         rx_cpu_unpack_psw(env, psw, 1);
         break;
     case 19:
-        env->pc = ldl_p(mem_buf);
+        env->pc = ldl_le_p(mem_buf);
         break;
     case 20:
-        env->intb = ldl_p(mem_buf);
+        env->intb = ldl_le_p(mem_buf);
         break;
     case 21:
-        env->bpsw = ldl_p(mem_buf);
+        env->bpsw = ldl_le_p(mem_buf);
         break;
     case 22:
-        env->bpc = ldl_p(mem_buf);
+        env->bpc = ldl_le_p(mem_buf);
         break;
     case 23:
-        env->fintv = ldl_p(mem_buf);
+        env->fintv = ldl_le_p(mem_buf);
         break;
     case 24:
-        env->fpsw = ldl_p(mem_buf);
+        env->fpsw = ldl_le_p(mem_buf);
         break;
     case 25:
         return 8;
-- 
2.52.0


