Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2087BCD343B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcwd-0006r2-E0; Wed, 06 May 2026 10:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcwX-0006W7-W8
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:09:42 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcwW-0002G9-8N
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:09:41 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so81699855e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076578; x=1778681378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0XBhuIaUCuVaYJHq6IcZfUhYnqlkL06H5sgtVF9yQks=;
 b=n4fAw0wDSsqwGMX/9LNwisgaLmLjTIOraGHrwkf8xA+kLygFocExvk74RqxPq43Vpy
 UkWx6Se1JUH3RrWitNc3fgYSoDABEcKDr1CapnftV21SE9Tod9ymYbWph0peeqTDM2kQ
 4gtFtzj1/i19oOlo+WAEWoF4/x7Mtay2Un4zSKwINasPTLCIXVMceCHONrAnxD2KLfmO
 zsquk9gNvkcnY3iCwA808leBLGn4GGUsfncEOt6kwI6MEMLg8Kv1r96s8BRWKbStsH+f
 jlazJxcYqRYFibQ1bjod2Us3/NuxwtN+yQJa3mkoDoM292c13YuLt10/a1H95ypNfLqd
 ZvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076578; x=1778681378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0XBhuIaUCuVaYJHq6IcZfUhYnqlkL06H5sgtVF9yQks=;
 b=k056kEh8PTjkcX4HPY/JdoPp8RtwicAj8FBq54j80ZYjwCu9AFYxiYuOmRhp3tn8G+
 sTsAlzuIXDWkNZku3BJ1AhqxAFBPbnaf3chlgRdTrkHufnfw4S6s0y5MxC8IesXwR+mE
 9AdnUS3lWi0m6MCF+qcg3Gmu4V/nxVeENf44sqzvVr+CJs0i7dREU2j5MuXiRg5P7+Uq
 yPLNzoYub94bnVFFOTjMud5/7fRCPmkmqUus3z4VpxqbaiK0EZsrZx1YYu5N2KlRTGV6
 wV62vfXKJWVNUc7JWgWn7OP96yDME3Xf6dLnFaEzVALgpBzcFTT44jpZ7yKrTLzdHdFL
 B3MA==
X-Gm-Message-State: AOJu0YzMN3tQ9277Vaund7N+jgY6CYRLbe/syN2K/1eps6Ygqbzaa8mM
 713E/hOjlYNn+NrcLBr46twZEgyatAhKyA99lQd5cyGP5lj3LZXP4eJ29gnltpci+Er2ec4q8Fj
 SIZtSon8=
X-Gm-Gg: AeBDietsZyRw//BJr6ceFQ0j/zigmzanOUM+pONSACdWuZysrFZvcT4NeW6UnJLrkYW
 dxmZIAwnj+nDqrqIBO+6NDT3L3IhfMzafvXtlb4Q4OCdKGahPEy/JWxeeL24TMT3Zyh1+oXYVYv
 2vGTJXDlPUm/ixr/7Ie96V4gXlXzxdmQS8EuRiAEl6T2D9puNdm2Hp95eZWJ2lOnWpUzgqu52F+
 bC7VkYW/7krV0GgiwQrM+oZEDzDUt7zB5VOOnaED8+faj7ZsXDH+U7CvzDjL2L3kzMV2euSiivV
 JrHUOOFF/SFCRaMFqt+5V6qePdrmf3vfc+y+hI7vKQr8IMC/n+D8YZNtSqbKHPu14HbCWGpwRVO
 dx5gvlUptRXOl3hsWo4A8ln3udz4nSupHAF5SZtFf2keII7NvzbD/4Pyx5jmZ1l3hn3ZaNLLGT9
 UNbdN2nLL9nAkIQG/qYqAtVbNvVmFtGBiPDP0C3FazuOdc/X/0xWMYjOp5KJO8RYO/t9xb6wz5P
 Blqf4MhACM=
X-Received: by 2002:a05:600c:3b17:b0:48a:568f:ae6d with SMTP id
 5b1f17b1804b1-48e51e15c37mr61074715e9.8.1778076577608; 
 Wed, 06 May 2026 07:09:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538d222esm62074825e9.14.2026.05.06.07.09.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:09:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 108/110] cocci: Do not initialize variable used by
 RAMBLOCK_FOREACH* macro
Date: Wed,  6 May 2026 15:55:20 +0200
Message-ID: <20260506135524.20617-109-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

The RAMBLOCK_FOREACH_MIGRATABLE() macro, defined in
migration/ram.h, ends up calling QLIST_FOREACH_RCU()
which always assigns its iterator variable when entering
the loop. Remove the pointless and possibly misleading
assignment.

Mechanical patch using the following coccinelle spatch:

  @@
  type T;
  identifier e;
  iterator FOREACH_MACRO =~ ".*_FOREACH.*";
  statement S;
  @@
  -    T *e = ...;
  +    T *e;
       ... when != e
       FOREACH_MACRO(e, ...) S

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-Id: <20260415215539.92629-6-philmd@linaro.org>
---
 migration/dirtyrate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 58f04670629..b360f49efea 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -485,7 +485,7 @@ static bool record_ramblock_hash_info(struct RamblockDirtyInfo **block_dinfo,
 {
     struct RamblockDirtyInfo *info = NULL;
     struct RamblockDirtyInfo *dinfo = NULL;
-    RAMBlock *block = NULL;
+    RAMBlock *block;
     int total_count = 0;
     int index = 0;
     bool ret = false;
@@ -568,7 +568,7 @@ static bool compare_page_hash_info(struct RamblockDirtyInfo *info,
                                   int block_count)
 {
     struct RamblockDirtyInfo *block_dinfo = NULL;
-    RAMBlock *block = NULL;
+    RAMBlock *block;
 
     RAMBLOCK_FOREACH_MIGRATABLE(block) {
         if (skip_sample_ramblock(block)) {
-- 
2.53.0


