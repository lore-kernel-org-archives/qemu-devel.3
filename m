Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA9BC8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 12:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urbVF-00075u-9V; Thu, 28 Aug 2025 08:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRK-0002Ku-3P
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:16 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRI-0007Bf-De
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:13 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7720c9e2900so1073437b3a.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756382949; x=1756987749; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=78SsRWgNmcpJ5cOXVIqKRji/G9cgJaA+IY6oItuUXU8=;
 b=alQqZ+0l6h030LM+kCf9Nt/wU6/m6E76j9q74xoqdOqV2DQaORCTuUdXGPoHfrGvZh
 CEhDiMpbu8ZcP1vQuNOEsKYzx3C/N2wDCVP3X6m7klm+hy92lzh0VdM7TS05WiwMWaKG
 Lq20tjqN0/OsDMJbwAJLq6UuqnsOqHCpink6NI8J57aRxX94etAPCCLt8w8AXjyc9qhZ
 09zSUYrFy2vB7WuqEH1TQg4XYB+R+3XUPDZRaXLNpgNmOkEELcwAzoIUjaZib/EK07Sy
 Hk2VfSSxthY7h73YsQMlUUniEE6dNT4juYfyjEAC0WrNPpMGwRxOxPCGpMSsGYwr08Hg
 wuaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756382949; x=1756987749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=78SsRWgNmcpJ5cOXVIqKRji/G9cgJaA+IY6oItuUXU8=;
 b=Py/dSSu+Re+8dQweqPqKZKDC/m0W/BqOLy7BXxblU89tbIZzXXZyXWyu1Gxe1ec/BO
 cas6PTBZjs4CLBSII6jL8VKIx7AyC3tgt3kwcGdJVRr9Nkq62InEmxFJEhI1IU4Xokgl
 BT8B8FcrCH1wnSf1zMb6hL4yAuh8KzQsEEDJWVRiVXIaKoW1Dw7L63nLPGGHj3SwZYWy
 UjF0SJD/GeTVRwo9zBNWtR/W2QrJ8LElxjsA7XI5hn3w7Ss03TNjBNfQRoSvsd9hZN5a
 rVJyLZlWLfQk+mLqMdxHAcG5SdW6jH8HOwL5zag432vBCtnRuDW2YIAd7Ps5zLZkjwvL
 +m+g==
X-Gm-Message-State: AOJu0Yz0N0eas6BGRmdOr1YZ0qhv8ldYInLuXWhp0QiCRrhp9mGU1ENK
 ka869BDI64577d4R3/4GvC0UNBFNnrNX7bbLPDOEoqHxfBCA1Doi4blrgGMaP/ffp51zg3N5cyJ
 sH0zDKjY=
X-Gm-Gg: ASbGnct5OU/pErq3iLfNRlIlKLY3qtRGYaO+jIdMhZIg6quSTvBhsrkpSTlV7WmubvR
 Z6zUyGqgwTBPCW1ujZRbNzBfrerqgydeeBPWawIOFFAKARsav5QOOFlWw9ldBOskpxDAZfhcGpj
 XiPsrlYoNRFE/m54budjmVOVE6f0DzLzlER3g9wifORRFQTn5HNRfxje2iZjs42Z+YYV5XQb1Q6
 6hQtYIo6JHqGWt/OCpddbYDpgp7mWWyQncqwxsvnKhGwjiP1oxqD/uue+vDvy84mTPu0YFL66/j
 a/LN10mgMwQu0QJErAIDzMIZMgr6GDtzdPqeWU6QtEYn2F72U63Jg275X1XJzcz26k2sFI6qgMo
 VZNkYZrAJhRSYzuIEPQeffgwvoVmEnoae87RH
X-Google-Smtp-Source: AGHT+IFUZWnsFH1NkCdqZJWtKxJzg0GW4jnvwsFHgS4EJLX8I0lJQI5kWGHa/Jnhz2KiXdZq/iXO4A==
X-Received: by 2002:a05:6a20:9187:b0:243:b3e2:c9f6 with SMTP id
 adf61e73a8af0-243b3e2cc2dmr1509566637.50.1756382949428; 
 Thu, 28 Aug 2025 05:09:09 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8b4b98sm13933222a12.19.2025.08.28.05.09.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:09:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 11/87] linux-user/m68k: Convert target_elf_gregset_t to a
 struct
Date: Thu, 28 Aug 2025 22:07:20 +1000
Message-ID: <20250828120836.195358-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 46 +++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index cc9140bf32..63376fa1d6 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -720,30 +720,32 @@ static void elf_core_copy_regs(target_elf_gregset_t *r, const CPUSH4State *env)
 
 /* See linux kernel: arch/m68k/include/asm/elf.h.  */
 #define ELF_NREG 20
-typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
-static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUM68KState *env)
+static void elf_core_copy_regs(target_elf_gregset_t *r, const CPUM68KState *env)
 {
-    (*regs)[0] = tswapreg(env->dregs[1]);
-    (*regs)[1] = tswapreg(env->dregs[2]);
-    (*regs)[2] = tswapreg(env->dregs[3]);
-    (*regs)[3] = tswapreg(env->dregs[4]);
-    (*regs)[4] = tswapreg(env->dregs[5]);
-    (*regs)[5] = tswapreg(env->dregs[6]);
-    (*regs)[6] = tswapreg(env->dregs[7]);
-    (*regs)[7] = tswapreg(env->aregs[0]);
-    (*regs)[8] = tswapreg(env->aregs[1]);
-    (*regs)[9] = tswapreg(env->aregs[2]);
-    (*regs)[10] = tswapreg(env->aregs[3]);
-    (*regs)[11] = tswapreg(env->aregs[4]);
-    (*regs)[12] = tswapreg(env->aregs[5]);
-    (*regs)[13] = tswapreg(env->aregs[6]);
-    (*regs)[14] = tswapreg(env->dregs[0]);
-    (*regs)[15] = tswapreg(env->aregs[7]);
-    (*regs)[16] = tswapreg(env->dregs[0]); /* FIXME: orig_d0 */
-    (*regs)[17] = tswapreg(env->sr);
-    (*regs)[18] = tswapreg(env->pc);
-    (*regs)[19] = 0;  /* FIXME: regs->format | regs->vector */
+    r->regs[0] = tswapreg(env->dregs[1]);
+    r->regs[1] = tswapreg(env->dregs[2]);
+    r->regs[2] = tswapreg(env->dregs[3]);
+    r->regs[3] = tswapreg(env->dregs[4]);
+    r->regs[4] = tswapreg(env->dregs[5]);
+    r->regs[5] = tswapreg(env->dregs[6]);
+    r->regs[6] = tswapreg(env->dregs[7]);
+    r->regs[7] = tswapreg(env->aregs[0]);
+    r->regs[8] = tswapreg(env->aregs[1]);
+    r->regs[9] = tswapreg(env->aregs[2]);
+    r->regs[10] = tswapreg(env->aregs[3]);
+    r->regs[11] = tswapreg(env->aregs[4]);
+    r->regs[12] = tswapreg(env->aregs[5]);
+    r->regs[13] = tswapreg(env->aregs[6]);
+    r->regs[14] = tswapreg(env->dregs[0]);
+    r->regs[15] = tswapreg(env->aregs[7]);
+    r->regs[16] = tswapreg(env->dregs[0]); /* FIXME: orig_d0 */
+    r->regs[17] = tswapreg(env->sr);
+    r->regs[18] = tswapreg(env->pc);
+    r->regs[19] = 0;  /* FIXME: regs->format | regs->vector */
 }
 
 #define USE_ELF_CORE_DUMP
-- 
2.43.0


