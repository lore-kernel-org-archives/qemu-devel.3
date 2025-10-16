Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A77AFCCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9N0o-0000aX-1w; Thu, 16 Oct 2025 08:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MzE-00064I-HE
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:21:42 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mz0-0000VW-Pi
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:21:40 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46b303f755aso7652075e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617278; x=1761222078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7bg6VWveOkqdvX0PhyhPz5dDkWduYJFbJQ4SStUSs3g=;
 b=jxQN3WWN2uX4icXSIkxNFPfIpSCn2AJRvFOvw45UwtCuXsg+30pkiBPuCNEigjn2dL
 SaVBSbEfzamUfWQK8Q9l/zBbIKyhf5x/YjF+DmPY9hTeSDzwun6r8/fNC8t/PBzM5FpM
 71TJmXF7wMw8b5QazK6Qsr9bb4H/LqHYtTiSfkSG4ni0zm6HV/0SKpMpuQf/gc7uzm/Y
 8AaetVXYd/n+jD5ItexpJ4TGPFQVC69JbEbeElmCELHaxSlpn8wa2/+6Z6l66z/b9z7i
 Kk5fXfkJ7rJmHgCGDLfQ4fMPpbsQCR844yZCnAMLenfIpWdhLM2faZBQpRUlTl8NwjSM
 od3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617278; x=1761222078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7bg6VWveOkqdvX0PhyhPz5dDkWduYJFbJQ4SStUSs3g=;
 b=lz/iD56idaIfVOwTB1fIz+kmU4xejxsKutAd7qFtLg1Dr5YLhwFytcN2gopJUCu3q1
 BKSxUcz6SRU1Hbh2NOVG9Ad2r2avvw1ifmal9/Jk+Q5CJAfrARaMxRFNqDV1FuWgzDSY
 PvFzK88PfI8E/glbRSXlK/UKs1NbZIb4+VJcG0y0WrzSVWHXyYoGuLk+YarMmCttCGR9
 6+Mk+z3f507xPlNCB5LmopQVYgqfWe1WWRxDlqI2F3yTfOtRO4urYen/bnfEmtCofTPW
 OlVOVTcsk+9+Ga0NkAaBOMPgFQm5SrggS46NYMvXkCEwV+2iYZiEZwlxAYs8zsusrXoe
 s/kg==
X-Gm-Message-State: AOJu0Yy5eKnYKn4yhLeIp2fXItVk6oaOmNbqH5DYDaRRSCmXstky1ufl
 LX1E8yNtRN0oZGZIR5tRdicRgmJCSZ2u9e1B2ticg1gscqnubeYPdNJX7IjZ8sbpwYDIGegW3ub
 5XAoztac=
X-Gm-Gg: ASbGnctMysy7ZUnALFVucedBmkgPJ9nn3rfOx6YIOQQ0SSTE17g8pXgXtcBf1yQERSV
 lHEydDUDGlO/YObyJ3JwO/dtJltp53qaz7mLF/3X/dOgGoMOBpQfdFJZBIgBohKt7gqVmpXjVC3
 mwSmt4cFrQ9MfOHATz206s/rX1np6SI5gK++xRudfYFfRLtZOcf2PGWzsv0Dygh2bZw+zG9CNZJ
 IGvAyAwC3ztxxHr9RmlIOUKCXJOMJKITlQK9ApuqhOFQ4cEg093SpczcexZzzUHwwF8rUtG7GWc
 p70B75npJdEp6chB4IT1wNRMJdSgNc7xMvsr1/DmB93WJdDKzE05Y/dhlcOiYGeBjiUCQZmm/aw
 /qz+4ZfSu4ToJMRVal+3g2twimlWULqEWe0hA6+Wj26EvHoI7H8EucP1XTINqIz7Wz3wgensDK2
 ioZkNbmPb+7QPyj7HvZpkqlJVAgeCS9h1XHoRQrGaBwVK1SpRRsTsnmhoKySmTVPxI+Dv5B1AjY
 1U=
X-Google-Smtp-Source: AGHT+IG+2kFRuTr5sKTtf3swBtauTDzmN2d//WTOlJiQrfAW8N/68XsazMuDhQnbyfImCJJv+MLBOg==
X-Received: by 2002:a05:600c:8206:b0:46c:d476:52f3 with SMTP id
 5b1f17b1804b1-46fa9b021abmr209347735e9.26.1760617277585; 
 Thu, 16 Oct 2025 05:21:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144c900asm23266525e9.16.2025.10.16.05.21.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:21:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 74/75] linux-user/microblaze: Fix little-endianness binary
Date: Thu, 16 Oct 2025 14:15:30 +0200
Message-ID: <20251016121532.14042-75-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-Id: <20251006173350.17455-1-philmd@linaro.org>
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


