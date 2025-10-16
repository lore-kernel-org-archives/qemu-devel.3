Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAAABCCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:19:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mvk-0000L1-8D; Thu, 16 Oct 2025 08:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mut-0007Lo-Rn
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:17:16 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mur-0008IZ-8L
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:17:11 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-42701aa714aso341990f8f.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617024; x=1761221824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=scDPVWmrhQ8Im0exkQ2f9sNF2qLU7BMfhHwn75M2Aj0=;
 b=cFeRTXeLzuTELy5yz2PxiUqzJ2vJA2NtkRjZ9vj5qbocdq7RIRjDSmj/OAhbB6iw8H
 TiEMRF3sFls/J6VOVta0k+V1xnsabBzP2xI7mJX7yE2GRgJ2L+7KRR9mDzG3MYuvgmfe
 uPh1E51XAoLOGbga36wUoACKLB2zc7cqRVZzw8e1uK6KvyV096lwlCFGna9lE2urrogE
 +sbAL8ikMY4tgllolBPJvlNFtFDMJQP+RYcERPZ+FkCrTTK00xP9TPxwOaQzltthHbES
 xtebTuYsfAZf6ZePiiGTaQ05nM6FcrViltoy1mhyLIBZOuTC2YrONUsuKGB0Z/xwco58
 0qow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617024; x=1761221824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=scDPVWmrhQ8Im0exkQ2f9sNF2qLU7BMfhHwn75M2Aj0=;
 b=UycD47OWmk0OAan6Ovj8CRcA80ED6BjZTqH0WKS+rktjgKxZcuXpMx6Yw/ECVlLbSu
 52x4MLq60yOLsYQDHWROCctUAqsZCZ0opjt3aYQ9XOBqvcLZlRzeqnd1k1QHNXZ039pG
 Dicbd3FsipA5xoW76gFYJpGiqje2cKfpRPqj2UPglQQYDjw3u6ZCWMFWJs16QZm2t+24
 JmYIwt0+81VwyP6GRYednqbsCErTtpwlXdiEBrU0AOZXHyGyDUQAUtu0at5k+mihh6AN
 T46VPKjjCzcGzjChwsCco2IZ4MXiCMOgd3B6xlNlSe1LxQ5ki0wVxwbRxSKY98lq1Znr
 w58A==
X-Gm-Message-State: AOJu0YwSELtQlrF3H5C9u41cvYnC99h2EzQoqQoxzUnqQHzOlt1sUHTi
 qL/f0L7m6O3dZmsn/9glQAxFIe4raavoUq6Jku57Dui5efYCDHdC0ejH7BvTBm76a94nmJ+VEtB
 4ovCufd0=
X-Gm-Gg: ASbGncupKixNN0pG44ATAQLrzBk5RbBt8z8BodiItTxOFVsxDp+9CO6N9Dl6JstpKgz
 9c6TLSZ3KOcG/3at6XOzszxx0p43VBxGyOSjSscIl61PfKK5ubGDUNUDuGac0vyDrrFlLVvxdZB
 6j7v+bXpl2ZEjSej21AgrfQGYFZ/gMS+9orw6XcByRD1tigaOoHtlmVOarMmdMWtFx1ESL53f6b
 jj+xHVHE0MxkWIF3A78DQuEtwbwhnHbXOcbSm22MIerRJeXRWDeMT9kwM2ei6p0xfuUmyuCyCgw
 yEa0MFBKkSHncQgcs2priEnO3lk3WrpBhg/IxcqN3vF2uhi5Ky9+Y9ihCVWjtj01cOjg6pHIbZ9
 dXBX8XbG1dmvJi4l4HtZt4o4GVKBGzYTFVOH6qPzcdiT4e3JwTwumNV9riNeSuh3d4qAV9myaLh
 h/+x6pqvuvO2+auCmpczGDo+RZCRsIZd0kYHxZvS1UD9AO58yUlGGgRw==
X-Google-Smtp-Source: AGHT+IFLNBoaw8UIwHFPbrNFpZqdCNe9kZrmxxBT9InPmnQ4VxTzV3m3ypUNqIEwW2T/AQnEjDzc1Q==
X-Received: by 2002:a5d:5c8a:0:b0:415:7a6c:6a38 with SMTP id
 ffacd0b85a97d-4266e8e6ebemr20479060f8f.59.1760617024330; 
 Thu, 16 Oct 2025 05:17:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57d404sm34771043f8f.3.2025.10.16.05.17.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:17:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/75] target/m68k: Remove pointless @cpu_halted TCGv
Date: Thu, 16 Oct 2025 14:14:35 +0200
Message-ID: <20251016121532.14042-20-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Avoid registering a TCGv to write the generic CPUState::halted
field. Access it directly via @env in both STOP / HALT opcodes.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250925012454.60602-1-philmd@linaro.org>
---
 target/m68k/translate.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 0cee54f4900..eb1ba150745 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -44,8 +44,6 @@
 #undef DEFO32
 #undef DEFO64
 
-static TCGv_i32 cpu_halted;
-
 static char cpu_reg_names[2 * 8 * 3 + 5 * 4];
 static TCGv cpu_dregs[8];
 static TCGv cpu_aregs[8];
@@ -77,9 +75,6 @@ void m68k_tcg_init(void)
 #undef DEFO32
 #undef DEFO64
 
-    cpu_halted = tcg_global_mem_new_i32(tcg_env,
-                                        -offsetof(M68kCPU, env) +
-                                        offsetof(CPUState, halted), "HALTED");
     p = cpu_reg_names;
     for (i = 0; i < 8; i++) {
         sprintf(p, "D%d", i);
@@ -4506,7 +4501,8 @@ DISAS_INSN(halt)
         gen_exception(s, s->pc, EXCP_SEMIHOSTING);
         return;
     }
-    tcg_gen_movi_i32(cpu_halted, 1);
+    tcg_gen_st_i32(tcg_constant_i32(1), tcg_env,
+                   offsetof(CPUState, halted) - offsetof(M68kCPU, env));
     gen_exception(s, s->pc, EXCP_HLT);
 }
 
@@ -4522,7 +4518,8 @@ DISAS_INSN(stop)
     ext = read_im16(env, s);
 
     gen_set_sr_im(s, ext, 0);
-    tcg_gen_movi_i32(cpu_halted, 1);
+    tcg_gen_st_i32(tcg_constant_i32(1), tcg_env,
+                   offsetof(CPUState, halted) - offsetof(M68kCPU, env));
     gen_exception(s, s->pc, EXCP_HLT);
 }
 
-- 
2.51.0


