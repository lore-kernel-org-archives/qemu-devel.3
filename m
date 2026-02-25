Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 071A7FD45F1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvO5W-0004hy-LN; Wed, 25 Feb 2026 18:14:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO5V-0004hm-Dt
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:14:37 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO5T-0002ZN-Si
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:14:37 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-436e87589e8so194799f8f.3
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061274; x=1772666074; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=72MRBAv6Zx8+rZkBnJ5ANfwGHRs2IvhvjHTGTLXrFcY=;
 b=Yq0hvVkWJmWViP6raUSrK2b6V9EiHQtcbMADDLENkaA5DeY8mp3fRS3eJb7e2RIlFN
 YRRJE0Q1avn4EaallfCFng8xjhhL2eFNMzGqcUEpQLIZfMkc9L16H2eParTOlYbl5qab
 Ar9CMFDi+ZvsUZCtqGi7ZPH3O6I4qCOGd1F+AszTgtRrnByK5kbcask+8oMQpx+vSZtL
 EuzA5vFAFYbwu1EJEfXOimO7SCXxL52nyzLj5qIzKuy2gZn5KT4CVY3/hi6YsZiIybxb
 jDXsTbAvhPHjgktxuWMoOd77ppW0tiUim+DvBOae89uLFq1EXO8CJGx6IBpQmyIU7S5a
 /gbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061274; x=1772666074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=72MRBAv6Zx8+rZkBnJ5ANfwGHRs2IvhvjHTGTLXrFcY=;
 b=SjOCKb1relREfyYHPbaXDhQa12P7d9CH66PS1nwqVn7qJsAHv5cZqystgNGmotYGnG
 +9AC7NBu+DTrDmU/GbNOaZS8BcUM8TyccVZiKKX+QeUTT38SKGmA7zBSyEjudRvu166J
 udEYpKbDRJ69I831Lfs0yusxuRBiTIa67ZUHabzNSfPNPRBl/YLRintk9e1juzp/5zHU
 ptmVCoKjiboIufuwQLviVMyvy33kzjCkiLOKA2YCVvujkBo1N1G7nelSZ+k9Q0N058Ie
 vWi7J4B7OTCBXbDv4bKpsoCv26o8JjigbjOGV3IXu6mZ8Pc/QvrelcqzvG0h4YruNoQr
 s6bA==
X-Gm-Message-State: AOJu0YyBSES1t5IHGj72lExc8n0Ei0N35NjnqAjjJx0IqnOAagdxmP0Q
 L9pf7piJOe7nWnu8qak/D6dSwHfTXIJYi17baWvSQhrEr6whNxwzN4PPo6MAyGmMdt+Iw6v/eM3
 K5vpERuY=
X-Gm-Gg: ATEYQzzXS8Ls8FK0e10i0WpHvxxZmNff4H5e82fGgF4d1++ID9607goo07Cr2GPaAUC
 K6sAThGUw4CZwlOkhfHF7GdGPLikB8IhGnFYzNFyOJEPIvm4M+rwLBdmPG0tlBu9uvQTkgCfOsq
 XS51ycoWZIdMm9OSMvWZlpzeFwmiFJL9ykZ9ISLtoss8uS2xSE/ZRfLbaeveFwdsSJwzDZYLLWW
 1HBKZloVziDpKaNGnz7fs0L1oMtEljVy/Af57OhBcg167r/9TLuJbF3li+0ZkrjdouyhfkQyOmY
 H9SLZ41+Y5WtBfgH9Wfk287Fc/Fy8Rx0MDOj6Lv40v/AF2TKXRb93u9wK3diOGnun+l1ghweRj3
 UgRLctuv/carBDEI1kHJ9awzxI6oVCyDRx3GY+l9zBGPrv2muKITO8WsngeTAl+roPlduCzw/G7
 bwChtsZuxxpbz3ELwEKyM8otHsMlO3cWKeQRr63w2e6w5RupuB8gwqGEQFB6hnTNOmoUx5tCcV
X-Received: by 2002:a05:6000:40c9:b0:439:953c:2d77 with SMTP id
 ffacd0b85a97d-439953c2f90mr3159432f8f.43.1772061273733; 
 Wed, 25 Feb 2026 15:14:33 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d4cc81sm36348225f8f.26.2026.02.25.15.14.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:14:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/70] target/i386: Drop physical address range checks
Date: Thu, 26 Feb 2026 00:13:03 +0100
Message-ID: <20260225231411.96482-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Anton Johansson <anjo@rev.ng>

Since TARGET_PHYS_ADDR_SPACE_BITS is now fixed to 64 bits for all
targets we can remove range checks on cpu->phys_bits and
TCG_PHYS_ADDR_BITS.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Anton Johansson <anjo@rev.ng>
Message-ID: <20260218-phys_addr-v6-3-a603bf363218@rev.ng>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/tcg/helper-tcg.h | 2 --
 target/i386/cpu.c            | 9 +++------
 target/i386/kvm/kvm.c        | 3 +--
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index e41cbda407a..f4b2ff740d5 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -31,8 +31,6 @@
 # define TCG_PHYS_ADDR_BITS 36
 #endif
 
-QEMU_BUILD_BUG_ON(TCG_PHYS_ADDR_BITS > TARGET_PHYS_ADDR_SPACE_BITS);
-
 /**
  * x86_cpu_do_interrupt:
  * @cpu: vCPU the interrupt is to be handled by.
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index eaa01438c1b..9b9ed2d1e38 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9941,12 +9941,9 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
      * accel-specific code in cpu_exec_realizefn.
      */
     if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
-        if (cpu->phys_bits &&
-            (cpu->phys_bits > TARGET_PHYS_ADDR_SPACE_BITS ||
-            cpu->phys_bits < 32)) {
-            error_setg(errp, "phys-bits should be between 32 and %u "
-                             " (but is %u)",
-                             TARGET_PHYS_ADDR_SPACE_BITS, cpu->phys_bits);
+        if (cpu->phys_bits && cpu->phys_bits < 32) {
+            error_setg(errp, "phys-bits should be at least 32"
+                             " (but is %u)", cpu->phys_bits);
             return;
         }
         /*
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 9f1a4d4cbb2..3b66ec8c42b 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -4983,8 +4983,7 @@ static int kvm_get_msrs(X86CPU *cpu)
      */
 
     if (cpu->fill_mtrr_mask) {
-        QEMU_BUILD_BUG_ON(TARGET_PHYS_ADDR_SPACE_BITS > 52);
-        assert(cpu->phys_bits <= TARGET_PHYS_ADDR_SPACE_BITS);
+        assert(cpu->phys_bits <= 52);
         mtrr_top_bits = MAKE_64BIT_MASK(cpu->phys_bits, 52 - cpu->phys_bits);
     } else {
         mtrr_top_bits = 0;
-- 
2.52.0


