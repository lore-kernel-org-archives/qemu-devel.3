Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06519C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 09:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8FT7-0000vQ-PL; Fri, 25 Apr 2025 05:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1u8FSw-0000jX-E8
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 05:35:30 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1u8FSu-0000Ei-GQ
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 05:35:26 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so14550655e9.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 02:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1745573721; x=1746178521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0H2QgSYyz79EZj38vANTFg+2Ba5dl9dK4LXGdq61IKw=;
 b=h5JNOve2uu4ece8O0sk7Cs3qBaiwqVaN6isA5wmjSzeLs6XmNI5LoTUr54CfXsQzqs
 m7QtWxM5bwGolyB0ORCsBHaqZp3dMNyO/TXekj58mYgWlF64ynLaxKKseEUq3ZYTytj0
 zKp2iYOFo1MajbkUJd5h5W8buRN6feYf7t8lPUaz5PUuZlfgR0DiaQ8FS+2CNedx7DIB
 Y/TCXjUYecfiPkZ+RX8vC3SNWuGaxx7Y7+zm+0QKfqoxhWYBJuJLXoJiRRf7ADE8sTyf
 RGWLo7aJxutHuwDaIT+p87rdbv46eWIk+GcgOhe1qQMMvQEfP6o0xuJ1L/Se1exP3kdW
 4VZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745573721; x=1746178521;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0H2QgSYyz79EZj38vANTFg+2Ba5dl9dK4LXGdq61IKw=;
 b=AHMDBfu49RC4/sKgUO/IyUl+NW//i0Ai72Z5uNEd2gr/ENDZQYKWHF2qap1/4d05Qw
 yxXPVROMfX4sHcy9N1b0+E5w6kpdxmIudONfHTjLM2LZ8jHq/Vw5SbF3zQQ/adJOwbFV
 MB83C7nucLDxgI2SNm9FH5xIvIcJNmTL6i1WrUjZmOuf8JPDYA3iFh6Ltntb6zx6HZfX
 LU2cu2QPwxr1FdIKHkbL2BcrFJf2IqKmv45arw6vgg5CYB9dvV5+FH4tRu55RfSBsirW
 8oVnpFeuN6wCniyqenZiyEOFwcNMhdFnuLaRZMkYY8LyMmsfm9c5RDk+UyVs7L8QewJC
 lptA==
X-Gm-Message-State: AOJu0YzgbpD88bfSYpR/x0ycHzQIUkiQAl6AM//zpIiJs8Bwvp/jcphM
 IpC9mu5ybJRtNyGA71EnlWWqZ6EJMPUIOfnUrtt5qPiIZHdQdRboMDvtZZXlU8fsUe+iQm4oAjQ
 =
X-Gm-Gg: ASbGncsE9qlv+MLBXHGqAfXcWUeFUM5cS0eyPLLH3L84QT5M3/ZMdA/jiJHpUUO6J4n
 CCsanwocxGkl2MEv9KeIxwySFEd4DH48acxX2dZb355Kpc66vk4+S/QGSmsJG/V+6uwYXpAJU5H
 Pc9EbOGNjveVCmoNKhFVTbzoevvvecmRXPUSMJQFMUSpYOEM1klCNYQq4fIYb6aVqZqzIJIrXiH
 N/A5x+pq1WH/mh4f3k0Zpr0h44Z+o0dSGZ0RobNmprewIrFywaYoItNu+8Rg5wCMl/vhJ4EI8AC
 btbsHvYojYk2JgwJXn+QjXjMnEKw86mUO3E26XE2OoQCBP1U3L/UOmcZkZCH
X-Google-Smtp-Source: AGHT+IH7eTk8LZjnmPB1dYcbDTYn2rDNcyFoRxiWSeHidlqR5V9ln/x5LH8tbR8Mehv8R5STup0m/g==
X-Received: by 2002:a05:600c:1907:b0:43d:7de:16e3 with SMTP id
 5b1f17b1804b1-440a669b4fdmr10657215e9.24.1745573720659; 
 Fri, 25 Apr 2025 02:35:20 -0700 (PDT)
Received: from chigot-Dell.home ([2a01:cb15:8100:3d00:1a71:8234:7e65:9270])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073c8d61bsm1801734f8f.7.2025.04.25.02.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 02:35:20 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: atar4qemu@gmail.com, mark.cave-ayland@ilande.co.uk,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH] target/sparc: don't set FSR_NVA when comparing unordered
 floats
Date: Fri, 25 Apr 2025 11:35:13 +0200
Message-Id: <20250425093513.863289-1-chigot@adacore.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x334.google.com
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

FSR_NVA should be set when one of the operands is a signaling NaN or
when using FCMPEx instructions. But those cases are already handled
within check_ieee_exception or floatxx_compare functions.
Otherwise, it should be left untouched.

FTR, this was detected by inf-compare-[5678] tests within gcc
testsuites.

Signed-off-by: Clément Chigot <chigot@adacore.com>
---
 target/sparc/fop_helper.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index c25097d07f..b57da7c9ea 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -446,7 +446,6 @@ static uint32_t finish_fcmp(CPUSPARCState *env, FloatRelation r, uintptr_t ra)
     case float_relation_greater:
         return 2;
     case float_relation_unordered:
-        env->fsr |= FSR_NVA;
         return 3;
     }
     g_assert_not_reached();
-- 
2.34.1


