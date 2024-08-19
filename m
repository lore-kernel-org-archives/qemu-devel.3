Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE7D9C52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 22:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgBFP-0003g3-3t; Mon, 19 Aug 2024 18:53:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgBEK-0000ko-F7
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:52:07 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgBEI-0000jR-Sd
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:52:04 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42817bee9e8so37480285e9.3
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 15:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724107920; x=1724712720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/KeoVIja/7tKrspHJMKvsDmwZQwxRpxJr8dhRzojKqI=;
 b=MfLifjU2i555wbFMdf1MFblMU9IH48g34wEGdX2EzVjPjKNXvApoufP7FDTOzfY/oN
 TUeDK1Dm7IRQGh/OVMuyvbI0ITmABytCy4nCTTEZxE29H7pgN0aQFSmVJoivQQ1865MS
 L9TmMK/t7I2zi4MUqDxSZb7Kja5eb/2xUVsl/anFijHBWDMvXnX4vS8nZ0u6o2XoM6SB
 nzEk7Enr5vmnJ7sPPgXuDyBdSIg5JRARXv8B8HuLdKrxFHBDay8GXbN92kukyQxCXIWc
 wh6euSks82YjLK7MiM0aiQfXaMlEE2BOjoFYhw+Vzmq88ZmWm7g9/SIVHy1nGfemAWXB
 5Adg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724107920; x=1724712720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/KeoVIja/7tKrspHJMKvsDmwZQwxRpxJr8dhRzojKqI=;
 b=HgyPSqSRkCkjcXDMDrMkDraZxIofOEbXbZFWCBIXuNfTdl2pjKVDdzPK768CU/2MgZ
 xgAqTUCQuWwFIbyH+iG4pv94nJWimgB+U3ttBx3abntB3wmVzCnqBQTTJ+thrf2GHbPv
 EQy6CejQzV9Fob8zaDgNiD3S67F4qQy7isQ0fN9RMpa06lE8FTC1fCnqHr/wOaS5XTqB
 sUNbul+twhU8xgqeKkyUBb45bRtscEgcMZt91sBpBffmHmX0pgs4wwt6uWwT31BxUO0g
 iOqehSBHsZO/kksMhfNAUZjtzWzDBmtloe5YD80XcVg6f3g+Z28mVVbHvhR7HIYVubAN
 56rA==
X-Gm-Message-State: AOJu0Yz+lDeTMPcgDuz/jWzFW5PIK8/8KYNfs/h7zn+H17Nb5yPd01CX
 RZGRiKhrAzxoS3dXT7ZzfbloKQW/1NXOQyoSgm6uBDeR7wlk7LeH2ag6SqYUMSoY9m36v3529uA
 GrqU=
X-Google-Smtp-Source: AGHT+IEEN29pAplJanjaz4jgjl2pcEqL13XSEHtlqMX2TMaK/f/PAzUwEtRBCOeFQTe0VBrK2vzdLw==
X-Received: by 2002:adf:f707:0:b0:368:4c38:a669 with SMTP id
 ffacd0b85a97d-3719431e865mr7125144f8f.10.1724107920329; 
 Mon, 19 Aug 2024 15:52:00 -0700 (PDT)
Received: from localhost.localdomain (88-178-97-237.subs.proxad.net.
 [88.178.97.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-371898bb588sm11561680f8f.115.2024.08.19.15.51.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Aug 2024 15:51:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 09/20] linux-user/mips: Do not try to use removed R5900 CPU
Date: Tue, 20 Aug 2024 00:51:05 +0200
Message-ID: <20240819225116.17928-10-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240819225116.17928-1-philmd@linaro.org>
References: <20240819225116.17928-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

R5900 emulation was removed in commit 823f2897bd.
Remove it from ELF parsing in order to avoid:

  $ qemu-mipsn32 ./test5900
  qemu-mipsn32: unable to find CPU model 'R5900'

This reverts commit 4d9e5a0eb7df6e98ac6cf5e16029f35dd05b9537.

Fixes: 823f2897bd ("target/mips: Disable R5900 support")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240814133928.6746-2-philmd@linaro.org>
---
 linux-user/mips/target_elf.h   | 3 ---
 linux-user/mips64/target_elf.h | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/linux-user/mips/target_elf.h b/linux-user/mips/target_elf.h
index b965e86b2b..71a32315a8 100644
--- a/linux-user/mips/target_elf.h
+++ b/linux-user/mips/target_elf.h
@@ -12,9 +12,6 @@ static inline const char *cpu_get_model(uint32_t eflags)
     if ((eflags & EF_MIPS_ARCH) == EF_MIPS_ARCH_32R6) {
         return "mips32r6-generic";
     }
-    if ((eflags & EF_MIPS_MACH) == EF_MIPS_MACH_5900) {
-        return "R5900";
-    }
     if (eflags & EF_MIPS_NAN2008) {
         return "P5600";
     }
diff --git a/linux-user/mips64/target_elf.h b/linux-user/mips64/target_elf.h
index 5f2f2df29f..ec55d8542a 100644
--- a/linux-user/mips64/target_elf.h
+++ b/linux-user/mips64/target_elf.h
@@ -12,9 +12,6 @@ static inline const char *cpu_get_model(uint32_t eflags)
     if ((eflags & EF_MIPS_ARCH) == EF_MIPS_ARCH_64R6) {
         return "I6400";
     }
-    if ((eflags & EF_MIPS_MACH) == EF_MIPS_MACH_5900) {
-        return "R5900";
-    }
     return "5KEf";
 }
 #endif
-- 
2.45.2


