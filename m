Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D16CCA470
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 17:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5p62-00064v-S5; Mon, 06 Oct 2025 13:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v5p5z-000637-Qd
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 13:33:59 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v5p5w-0004Qt-Dy
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 13:33:59 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46f53f88e0bso11424235e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 10:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759772032; x=1760376832; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6xd015vb2NtsHpkL0bqNx7GuLB41R92KIUWGPeFHrY0=;
 b=FkZ4+1a9xEBCY7EoDKKxewsDCVNcxz6Vn7zPzLdqLK81Lgtr71OLpL3VOWiPWFXgAD
 riammDC5fLoMUcsu9z3tBnjchkWGKRLEp3LQDpgBbqe/flpctlQvJw2nWHz4FfjNWT0p
 4m5VZUFP6y6bVqQeS1RJT6AObr7IKdXsCSwIh4/eZ6+xCGjtkMQ+pybCnrhmVgEXDsb7
 Z0c40hy1jZLDxTWpOzJp6kcBXEFvrxM52EOeEIFUX43t81L8cswlNrhIVwdeUrOgN36V
 02SlU9WJyNvQh31wQpIuWNhjcZj1xBXfADi6gjPkcPtbPTwL9hooSPF5rCIuFEdyZ1sB
 OMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759772032; x=1760376832;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6xd015vb2NtsHpkL0bqNx7GuLB41R92KIUWGPeFHrY0=;
 b=dX0Wnokkz6yX9ll5XF/WcT/wDz2dNU++1OBCiJRlR/mFSdKw6E/N7fDPdkYVOyVv0Y
 WAWpu1//nVuEFYYNUfSyboE4m0n45qVnG7ysKROdXilFrtvE7+trvSVsCOg9WHYVs2KM
 Ug4iE7hBsLtDS8bvS6gBV8TYxPLpNt6SbhVDfmccItg7ECwLolkCPDojUXYZcKzXDqsu
 bJHkJ3s2sDokZ0FebP1CPSsyZ80CTsWV6F6vDk/MRPjn32y+kXmclQ1KQtMcCC10l3q7
 1QDjDjUK2B74+usAb+WF+AX8wM9dr06VyZ4wf3B2ZmDhgD3cH3p1J1LUYvcEHSweNtE2
 wP7A==
X-Gm-Message-State: AOJu0YwASZAKepfevj6fdGqT/isX2R387na1IhiNDimbQqRRvG3ql9eJ
 Xh94CdO8HSv/nQFPa399Ruii9LIS/mnjwrK2tnRLPzfJNXeB8NOZihB1uMFoddlEuesJRSkHb2t
 e+eZJN+Frnw==
X-Gm-Gg: ASbGnctuqcDujmUWQBs0UVSJeqIoorkCqiaMrowYje2fkVe3+SqWOKAyLOmum51xWx9
 AR8NpOwR0OO16PPC4fT5SL1huwktay5Fc7wZAiuED4YAGIdyHXaLTqrGzRxrP8cCiGAoSprBIMX
 gbOj17HvErInoQExj053UtBPpNFqsCVdcHpaeIoh/3bKPdCzhfdcD78uGUPJUUGL/EKZPZfdWQM
 lPqqcdlHp8+VgMWNXfVg7AF7Anrvthd29WLMuXmZU7slZryLbD2vnC4Il9lyHO/dtqhNCkrubX1
 elncds/ROHTi29Z/Xta3bUbWNwJp/riQGMe3pT+E9XLiJUcpDiFhrU418XN06RPOTNRl+f92fIZ
 a3M0WSvawm36N1QLBb59mF0R1fWph+t0xgGvYSyN2Z0XXEhBzSgMnxwTSHkxsqFx/VF941T0CSc
 gyNMf33l+/zA4CXd6Jh37aFGM4
X-Google-Smtp-Source: AGHT+IG7QnT5EsP0qKOd39ckebo7tsQXhpwCOgx8nrafjFk8yzeyT2PLsFIjz+xR8pafrZ1eZolfkA==
X-Received: by 2002:a05:600c:a343:b0:459:d451:3364 with SMTP id
 5b1f17b1804b1-46e71144103mr93699035e9.24.1759772031932; 
 Mon, 06 Oct 2025 10:33:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e619c3a58sm265062315e9.6.2025.10.06.10.33.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Oct 2025 10:33:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH] linux-user/microblaze: Fix little-endianness binary
Date: Mon,  6 Oct 2025 19:33:50 +0200
Message-ID: <20251006173350.17455-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

MicroBlaze CPU model has a "little-endian" property, pointing to
the @endi internal field. Commit c36ec3a9655 ("hw/microblaze:
Explicit CPU endianness") took care of having all MicroBlaze
boards with an explicit default endianness, so later commit
415aae543ed ("target/microblaze: Consider endianness while
translating code") could infer the endianness at runtime from
the @endi field, and not a compile time via the TARGET_BIG_ENDIAN
definition. Doing so, we forgot to make the endianness explicit
on user emulation, so there all CPUs are started with the default
"little-endian=off" value, leading to breaking support for little
endian binaries:

  $ readelf -h ./hello-world-mbel
  ELF Header:
    Magic:   7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00
    Class:                             ELF32
    Data:                              2's complement, little endian

  $ qemu-microblazeel ./hello-world-mbel
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped
  Segmentation fault (core dumped)

Fix by restoring the previous behavior of starting with the
builtin endianness of the binary:

  $ qemu-microblazeel ./hello-world-mbel
  Hello World

Cc: qemu-stable@nongnu.org
Fixes: 415aae543ed ("target/microblaze: Consider endianness while translating code")
Reported-by: Edgar E. Iglesias <edgar.iglesias@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 linux-user/microblaze/elfload.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/microblaze/elfload.c b/linux-user/microblaze/elfload.c
index 7eb1b26d170..bdc0a953d59 100644
--- a/linux-user/microblaze/elfload.c
+++ b/linux-user/microblaze/elfload.c
@@ -8,7 +8,8 @@
 
 const char *get_elf_cpu_model(uint32_t eflags)
 {
-    return "any";
+    return TARGET_BIG_ENDIAN ? "any,little-endian=off"
+                             : "any,little-endian=on";
 }
 
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMBState *env)
-- 
2.51.0


