Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB48CCD194
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 17:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v95kk-0007cJ-PH; Wed, 15 Oct 2025 13:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95ki-0007bf-IM
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:57:32 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95ke-0005SP-NA
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:57:32 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47100eae3e5so7285145e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 10:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760551045; x=1761155845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ucmd8j+eG32g5SXQ6QBL+cAm3PPY8er77ne5+2rIckk=;
 b=IJ6rMbkkForw+AdIPRfvg5xRF9tbvggKelifmvscT7thgu7ju/KcOrr0AtnhZq2FSq
 5RZYhIHBd/efLn8aoZUbvzsmKhtFEzotyzplLNp9PFucjlDH9CisKs1fpPfktqKsnpGt
 13JtrHSy9PqlRXf49TkwEZbu2mx/EXneIkxSq3UWl/eoGQhn9F+j6On2MpED2utZjPw3
 zpg5DLvXdNHxR1LSqnlY+hSAXSYhNA1sV4IK2WxJZbcwADbRqp9mNVyM82ozmB32q0mW
 eez6duPlv1NHOGon2Qq/j3RR6uAM/AiaC9CKt5idAp6467QOEWQ6llvLHn/hSCYTH4YB
 7o7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760551045; x=1761155845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ucmd8j+eG32g5SXQ6QBL+cAm3PPY8er77ne5+2rIckk=;
 b=gZWVNuFV6AieFLf5Hnlvyxe2aM6qWB/xsHEXO/HpuxDObSm0Q9iK3djwPxVu8WFxGK
 BZVIqTTDG3d1r4i29Arvou9sZ6qKS5dDq1GuTMFTPvu5zKhruD8tfpr4OWUvkFDFyb91
 rB1iMQsRcFSeyL6J6DXbbhRCisJi+19GldE0TqiG6Nr6l/MNl2Xse6dAdXgL7YPEP4Oq
 YDJ6ITIOBlihIXFkGY7yWa9/lhIi7SuFiYqM4b0mk/+xVeR8mP8vls/iMcI38U+VpkQy
 /3ilHazWREVnxtfso5VmMYeSIv5/IykJFiIb1Uq/4vub9eJ21QEmw3c9stXadMKai9Ei
 ap0g==
X-Gm-Message-State: AOJu0YweNTopGp6nugkXD8ZR/qLA2JEKFSkIhkgPiTSdBkDpR8RWU0a4
 HETlUvq6Wujf6SdMKzWmEjLV+bOjH3EWqsgugh5WHIdwTacGKE6ebWmSc90mcwKF+j4kJoshMxU
 FZaZ/cZq7hw==
X-Gm-Gg: ASbGncvVdDODVFZSqvOKJSFiPwmJI2nEUmuW9NRB2El5PuVc9oojI0w2BTf7IXzONyh
 RC4ikQjAkiD7pMgfxFbOrG2iuC12baj88iZgVdQZwqCHJQVLRTZr/+Bx9P0JhwOc9jnKJC5V7Kq
 DdYz0sOe+/tx8iOw8G65Vr9p5HoXCj2hQ5kokAO+KqSvi0mZzXVUFMM2LURX1O+Ujgi8LYiAmn/
 lOaEkOsNh8ieUZEbp/PvDZ9lUf3YAXmsPUIkGrcR+RydryUUbjZ6/C4lGMJaKdKD3Kt1RefZ3OX
 fli2QlAw9Zc+RFL7qCzcCMU77OytH3PIabRjMGr9j25+fs0+j3h3b1R7FstG9RYH0UtCve8FYpr
 R6TRN+MC+ZRsja/IA7IcDo8qKJl9IcVM1bspSdYJVnnwXUf8EG96Z77SYGRS7FP4bDwP5AOi2jc
 +wii9cpX/wusesjWzSRPLs2EWIIottKQ==
X-Google-Smtp-Source: AGHT+IHekwfQIpIHcjeVx/rRNo5yHmBPlY2B54G0TBIeJsfVfQS0rzFMJWIbkh2nEOwcV890SStSJw==
X-Received: by 2002:a05:600c:5248:b0:45b:88d6:8ddb with SMTP id
 5b1f17b1804b1-46fa9b1968dmr220713045e9.37.1760551045287; 
 Wed, 15 Oct 2025 10:57:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb483bcf9sm316851195e9.6.2025.10.15.10.57.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 10:57:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/7] target/microblaze: Remove target_ulong use in
 cpu_handle_mmu_fault()
Date: Wed, 15 Oct 2025 19:57:11 +0200
Message-ID: <20251015175717.93945-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015175717.93945-1-philmd@linaro.org>
References: <20251015175717.93945-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

cpu_handle_mmu_fault() -- renamed in commit f429d607c71 -- expects
a vaddr type for its address argument since commit 7510454e3e7
("cpu: Turn cpu_handle_mmu_fault() into a CPUClass hook").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/microblaze/mmu.h | 2 +-
 target/microblaze/mmu.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/microblaze/mmu.h b/target/microblaze/mmu.h
index 1068bd2d52b..2aca39c923b 100644
--- a/target/microblaze/mmu.h
+++ b/target/microblaze/mmu.h
@@ -86,7 +86,7 @@ typedef struct {
 } MicroBlazeMMULookup;
 
 unsigned int mmu_translate(MicroBlazeCPU *cpu, MicroBlazeMMULookup *lu,
-                           target_ulong vaddr, MMUAccessType rw, int mmu_idx);
+                           vaddr vaddr, MMUAccessType rw, int mmu_idx);
 uint32_t mmu_read(CPUMBState *env, bool ea, uint32_t rn);
 void mmu_write(CPUMBState *env, bool ea, uint32_t rn, uint32_t v);
 void mmu_init(MicroBlazeMMU *mmu);
diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
index 8703ff5c657..db24cb399ce 100644
--- a/target/microblaze/mmu.c
+++ b/target/microblaze/mmu.c
@@ -78,7 +78,7 @@ static void mmu_change_pid(CPUMBState *env, unsigned int newpid)
 
 /* rw - 0 = read, 1 = write, 2 = fetch.  */
 unsigned int mmu_translate(MicroBlazeCPU *cpu, MicroBlazeMMULookup *lu,
-                           target_ulong vaddr, MMUAccessType rw, int mmu_idx)
+                           vaddr vaddr, MMUAccessType rw, int mmu_idx)
 {
     MicroBlazeMMU *mmu = &cpu->env.mmu;
     unsigned int i, hit = 0;
@@ -172,7 +172,7 @@ unsigned int mmu_translate(MicroBlazeCPU *cpu, MicroBlazeMMULookup *lu,
     }
 done:
     qemu_log_mask(CPU_LOG_MMU,
-                  "MMU vaddr=0x" TARGET_FMT_lx
+                  "MMU vaddr=0x%" VADDR_PRIx
                   " rw=%d tlb_wr=%d tlb_ex=%d hit=%d\n",
                   vaddr, rw, tlb_wr, tlb_ex, hit);
     return hit;
-- 
2.51.0


