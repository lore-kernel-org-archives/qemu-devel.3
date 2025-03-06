Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F22C28B24
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDUf-0004LV-ID; Thu, 06 Mar 2025 10:50:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDTI-0000KC-B5
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:49:21 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDTG-0006Mn-Py
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:49:16 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-390cf7458f5so822025f8f.2
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276153; x=1741880953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=k+YMncU/lkdHhuSVLGblvNz32VlH9gXNcYRrUvN73h0=;
 b=roTQ5uo//Q20XozGTal8vkrIS2AAAuZK6MPExZ80y12Npy3TmeTQmvlJ92TeY6BhOW
 cHQOGsmkN2beAmvmYtsxKlmEyricazTEkZfKLfhPdUWp4mySwuoUuIqPar1180uAU3Fy
 t4FdAWZLHzcOHfpvqsDFmW74zaCg//YZxL90p5cqy61Fd4JhxyepkbdPfy5vUPPzScga
 sTiObBkhe2w50luX43zxTdxAkEwdRGcvhFRKAA7HJhbd2BSrtC+TPMbl3juKN6TE8rO8
 ySAdB2LLIMc/wXT4cRgg7wGaDexLP2fAihoPDIMNcBlGeMhHVG+/bCwKSj/tyiDgGPuy
 25kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276153; x=1741880953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k+YMncU/lkdHhuSVLGblvNz32VlH9gXNcYRrUvN73h0=;
 b=k5vOsVT/x4hkFKxFUfdEimKJ+LNjGXQSykeZ3vZ6MoYbWV8UnLnemCvXusoVoztdkB
 hvfluDl+blXzznOEm191+PE3DQjJLqc3pbdXRh7kYqW8tJuq38GrPWU/EK8i1mnxDOXU
 roXlCfdg1ehojJY2mvLrEuZlOQvm1ZVt+vGDT62eJsBTPWg3f1jZ/J71I4Hl0CaPz9lW
 XN0pEl21mfb7TNJmOC9ZLSP+A/eGRRMNz7pK1Rm6fzbaGukMnUxcrGoBikeyBZU0Loin
 dTApvYZZJE0fcDUJaWI47YZ9yR9cBiEUX+4IMP711wpDTVEDn/6gnsIntWa4Jp44Av03
 FwWA==
X-Gm-Message-State: AOJu0YyqFmttZ+HjpTZyWTOMpH//8r/lfC+b4UUu8pB4ASPSVqxg+94n
 Z3RMXtjxHiQOTKZ3u0/d7IX+M93yY+XMv1PDeYJfIk/xV1umQtyd+A6SmIcGPqZrNGJssBGMWfo
 gW/o=
X-Gm-Gg: ASbGncuGYWMGPv0CFA86EnHY+ZgRUqhib3KhBKxhWfprF6eIjEDIj5b19e7V/mY6qEz
 k8O2Xu/EYpodA7FGdqZiQeke7rtwdDSnKpw4/7o5FkuXe0YYr7SInpzpn5GsaH/DA35RFqnVu6C
 3yYlLrccwIOzCJj44GUZhnF2tfe3RIoc9maFafjsng0UWQFr78bhyD9bzfjNNGWwmW+uMaVCayu
 IFBpySDzacYsJXAdQ1n6AO9quPPqbg9QdqVbudDG32c34hfnRrDzXeWAWh2QURG7usg95agqLcJ
 dHwe4X+MG3EIYjQ7bV7rHzI2uEi5VEIQnw5sIagx2xKovHT4MXbfphmPfr9fW1LQ57a0NZkp95u
 3ksPbFq8WZ2XoAWgvgyc=
X-Google-Smtp-Source: AGHT+IGgjKQoc9J01eK6/A2n55H76jd7eWhXL6ngn6MtGAgeD3ajN1Ute5QxvCsz5b9PkMRwkMh/bQ==
X-Received: by 2002:a5d:64a2:0:b0:390:e7c1:59c4 with SMTP id
 ffacd0b85a97d-3911f740a0bmr8290839f8f.13.1741276152879; 
 Thu, 06 Mar 2025 07:49:12 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e2b8bsm2418916f8f.64.2025.03.06.07.49.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:49:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/54] cpus: Restrict cpu_common_post_load() code to TCG
Date: Thu,  6 Mar 2025 16:47:03 +0100
Message-ID: <20250306154737.70886-22-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

CPU_INTERRUPT_EXIT was removed in commit 3098dba01c7
("Use a dedicated function to request exit from execution
loop"), tlb_flush() and tb_flush() are related to TCG
accelerator.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250123234415.59850-17-philmd@linaro.org>
---
 cpu-target.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/cpu-target.c b/cpu-target.c
index b925b9391e8..48446c90212 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -46,22 +46,25 @@
 #ifndef CONFIG_USER_ONLY
 static int cpu_common_post_load(void *opaque, int version_id)
 {
-    CPUState *cpu = opaque;
+    if (tcg_enabled()) {
+        CPUState *cpu = opaque;
 
-    /*
-     * 0x01 was CPU_INTERRUPT_EXIT. This line can be removed when the
-     * version_id is increased.
-     */
-    cpu->interrupt_request &= ~0x01;
-    tlb_flush(cpu);
+        /*
+         * 0x01 was CPU_INTERRUPT_EXIT. This line can be removed when the
+         * version_id is increased.
+         */
+        cpu->interrupt_request &= ~0x01;
 
-    /*
-     * loadvm has just updated the content of RAM, bypassing the
-     * usual mechanisms that ensure we flush TBs for writes to
-     * memory we've translated code from. So we must flush all TBs,
-     * which will now be stale.
-     */
-    tb_flush(cpu);
+        tlb_flush(cpu);
+
+        /*
+         * loadvm has just updated the content of RAM, bypassing the
+         * usual mechanisms that ensure we flush TBs for writes to
+         * memory we've translated code from. So we must flush all TBs,
+         * which will now be stale.
+         */
+        tb_flush(cpu);
+    }
 
     return 0;
 }
-- 
2.47.1


