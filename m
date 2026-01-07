Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 074D7CFD626
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 13:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdTI4-0002hX-1m; Wed, 07 Jan 2026 08:09:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdTI2-0002SX-DX
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:09:30 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdTI0-0008UY-AB
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:09:30 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-477a219dbcaso17219025e9.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 05:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767791366; x=1768396166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MCaTjNyAElQFuFaR8j3JF4/CT8EzoT5R+7ooDRWgoUg=;
 b=zV+Gwa5/0KqySKpL2x95VaM6PtKSS9EzlUhqruwF7WDHQFaF6Y8ND5X0fY+GC1qqog
 lxkCfwlIo2tedF4plivJq6WWt9efKJSbZOowvpZSIVINhvlZiHvVNaO0AXg+2ynwTB8p
 XdOVtt7/K3mymi+MT9rcqJtwnrFdjQnNmOD4SUwDLV2W84PmZZ6wZV9yv4G7mQppbhmi
 GNutqPp5ivIP6bGIyGxzBKHPyUaS6xxI60XzFbWa+slgpyZ4qq1XZcIRiuqIS2c7ulIV
 gfjtr1tnPMV8vzTXAs7KV9RdHzqKIfEG6uvqrJDFig04ZM7Imn/1Hke6YxMlIxNuA3GZ
 qkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767791366; x=1768396166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MCaTjNyAElQFuFaR8j3JF4/CT8EzoT5R+7ooDRWgoUg=;
 b=f5pGbex8yMWGMtSgP+60Ui9TgOIHduzviIDQVosFKNhCBlvBa8MolSVQ33rHrMcLuE
 DdRHeCd4RYH8XaU3zNuSC9lRa+m4Rs8MbK0eAOcAT8T6wFF/r+juAT5ILpxF0iZe+uRc
 VlPh3RQG68E4fndvAUrVH8bmp8meZZFrtSWvc8k7+0JXHbp0S1KB4gKnx/ZH2Ugv2B03
 SBoycfhLEGHo4eNIU4wZDY1Nqn5OyAJQKgURsRtX8GvhpGcQGE7L+BnunFdlogXomywq
 d2KiVk7jSOl5JgtUa4kc3DR7ljuO/f3HUjjmJE/Chra1oV+w9/585amUyaYBvbhptde9
 12GA==
X-Gm-Message-State: AOJu0YwaMzUz157MlQYk1PKe7s+RA/YSs/cbTYyiYBiMsrMLFMLzvAas
 uQ1q42XgoKh8Viuts4gAS9cyuvMMHOc4dDDfzDFOU/T9+tY91TWm0Riq4IsCd1xzYYAtlomSkav
 k5ftFwek=
X-Gm-Gg: AY/fxX6ypnqsXZg9NH4JwcEnRJHYYaxszAhB+hSkcQAyDspISwfnDyfAKoYes25Dz+J
 qezm+d8UUHVmpHa5M4bpkKyPx+Ioc8NKrN5JAc5vqzfQbhNVnmc4dEAIb5yd9gsdW2nv6PyfDWI
 OvBcf6bBShwwktCz1gBTTUlVdUwXsnMGQXjH55Sxnic/18oMVDOs0/m5W17KWboJKY2X5DG+DkG
 wtFX3AEk6CcmUMFN7jI/dC6o2M+22vnQATYSdg3RLfT6dCCLGqwERDR3NSsa3vxoJR8/cjexcPI
 YJQfOSHF1S76pXHoSagwvNrNneK0CCtPLI0gFkp6rhCTqzjaHTJR12xLTFj5JHenH3k+75hqy3M
 F2s7tbCAd6riTo4Os9h10bttujDHqBgoK10QuYqJ6t44huf5HU6v8ePRTNydEK070jETdVMB8Sw
 bc1UuH+WpFilkTGjyBnvFwxksKJk4+X/6kF7nJraO3KtNxdk2niVFH9xiPpj4N
X-Google-Smtp-Source: AGHT+IGstuoxk93f01RZYxKuCOEX0adEmlTV3HCkPoAnZ51DRU8HM7FJmp0RtPZo2emeBonYGlOYxA==
X-Received: by 2002:a05:600c:5490:b0:471:1717:411 with SMTP id
 5b1f17b1804b1-47d84b33bc0mr31711575e9.24.1767791366401; 
 Wed, 07 Jan 2026 05:09:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f69e802sm98419495e9.8.2026.01.07.05.09.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 05:09:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>
Subject: [PATCH 11/18] target/s390x: Use hwaddr in translate_pages()
Date: Wed,  7 Jan 2026 14:07:59 +0100
Message-ID: <20260107130807.69870-12-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107130807.69870-1-philmd@linaro.org>
References: <20260107130807.69870-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

translate_pages() returns absolute addresses, which are physcal ones.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/mmu_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 5a613b33150..abf8da28ea5 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -472,7 +472,7 @@ nodat:
  * the MEMOP interface.
  */
 static int translate_pages(S390CPU *cpu, vaddr addr, int nr_pages,
-                           target_ulong *pages, bool is_write, uint64_t *tec)
+                           hwaddr *pages, bool is_write, uint64_t *tec)
 {
     uint64_t asc = cpu->env.psw.mask & PSW_MASK_ASC;
     CPUS390XState *env = &cpu->env;
@@ -523,7 +523,7 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
 {
     const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     int currlen, nr_pages, i;
-    target_ulong *pages;
+    hwaddr *pages;
     uint64_t tec;
     int ret;
 
-- 
2.52.0


