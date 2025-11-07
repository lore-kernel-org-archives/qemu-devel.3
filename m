Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746DCCCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 14:40:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHNcZ-0000Yq-W1; Fri, 07 Nov 2025 09:39:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vHNcX-0000Y5-4i
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 09:39:21 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vHNcU-0001vT-3W
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 09:39:20 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4710683a644so5393965e9.0
 for <qemu-devel@nongnu.org>; Fri, 07 Nov 2025 06:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762526355; x=1763131155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VnOoY3GS9fZhgYAsHIoSmdYJhCdMuYARnS13WjC3+QA=;
 b=u9s9fCN+UCjFoOB6enH9HTaD1lCwHdzYN8uvVfn17i7MxhPl161mci33a+pvxc/AAm
 kmo7mOHI+9YkrdqdSHW4zklVCpHkYXz34H9lOdzbmlApJhGS1FYhwLDfD00oEZZHy5yK
 cvCdK4JYqDJmh7MNsjdMC5Li4F/H9hRi4ykp8XF+s2e00lInLvZo3aUL9s0OPFL5KE9N
 TiElRySV2P+7V3gqFTFX0dwBwuhhFzq2j8C3bggFPz6+cdgXmKmYAOwbIm+JfxxLRZXa
 Q5A0nvyFArb3++4hWUnAjblg2wckvga7AC/Nc/OrCKGJ/3xi/AXArYxWlgq6zy0E+IcW
 RBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762526355; x=1763131155;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VnOoY3GS9fZhgYAsHIoSmdYJhCdMuYARnS13WjC3+QA=;
 b=lRtTD5i8c/3dBQok2HiMV2eC5QRDM5Sk5+V2TZlC10p5cqpgUtsWsn6UlXWFn9iKk4
 b3bIxdESdIcd404h9r+FNt8ckVfRo/Pu1b2ZwF2BsW2Vfgjb4LsVFL3D/vNZ4BDOGrjF
 OoZIInVNhUixPc0nFo4imKP2hc+7JRSumN2KG6WIFFr+179lE4Kbcfos7ZvnJOHWMJ1n
 v4LslbWLyR+y6tzhp4RyjyoL7QCkAYWhgtYbmJOZtOXXkNPHJJqQVF3gOTcKk5YLgRp3
 Rrg5u1rovlydVQXBu8f1zXVjwed0xD1rAdowvDVCZdTHqrMMfYsYn9jEF9YBzqkZ+qyN
 P7tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKkxEsW1ZPRD2Yw223muEaSnwimHDiL2f935YwTWbueVgt0+Y8ygrBo6vMS2/3jui+NR0TM671WJ3q@nongnu.org
X-Gm-Message-State: AOJu0YxUNkQ4YAJwZ9k6C07X+JJiHGfb9ckoi0p9f/y92khikhcdgpFK
 Kt7atsyLFTYyi03ytYM3X0Bhfe4pZh9NpRtypRdzRETvwcY1inMpnbqFYON5y3aNRmuZM905RoB
 70Z2Z
X-Gm-Gg: ASbGncvJUjhq4qQETR2IWqqRtDlcaQ4eiOkYXhOYVeuO3KK+l2eZvswDymduwJdSpc+
 rw61Tc+tx3fSvs73PAJ8x3C4pFuRskWhIh75PZbJx3LeygCpbJ0o3OXn9OWFgh/GakQomEILTU9
 JB3N4n+lHH0wX7I1kKSPOCSJLBSDApqMpevO6RTMqBko7CGz61GWgHRi/vMqoZRc6mkyVk0iWHv
 n3Bu20SxbkXNjqJmy8rmpH+Q+PvYExK+xvsC2CZZa6QDJ/4H6mRPnKOyRrPFtjvBybrGNFFmtxO
 +8Yif/mmc7UTxLvsoR1csL82AM5agD7G+y/+uxgT92fyRUDLY6TTHoJG3XDkGIgTqHyXMPXeT1/
 Fp74LEy9M8Um6fa/hiYRR+9SICDv5snHjrQvbGyVUCdVviOcsQXyi3D6+8S+1xtlOHLDKcvUfOf
 LWVn52kw==
X-Google-Smtp-Source: AGHT+IHQpcK4t2r//EVnveuBQ0T3b2j+yA0t8l53Gs3DqQItfFdHqRX36K7vH1e6ExvfySCAL7FAww==
X-Received: by 2002:a05:600c:154b:b0:46e:3b58:1b40 with SMTP id
 5b1f17b1804b1-4776dc117a4mr21847005e9.4.1762526355397; 
 Fri, 07 Nov 2025 06:39:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4776bcfd2e5sm52744815e9.13.2025.11.07.06.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 06:39:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>
Subject: [PATCH] hw/display/exynos4210_fimd: Account for zero length in
 fimd_update_memory_section()
Date: Fri,  7 Nov 2025 14:39:13 +0000
Message-ID: <20251107143913.1341358-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

In fimd_update_memory_section() we attempt ot find and map part of
the RAM MR which backs the framebuffer, based on guest-configurable
size and start address.

If the guest configures framebuffer settings which result in a
zero-sized framebuffer, we hit an assertion(), because
memory_region_find() will return a NULL mem_section.mr.

Explicitly check for the zero-size case and treat this as a
guest error.

Because we now have a code path which can reach error_return without
calling memory_region_find to set w->mem_section, we must NULL out
w->mem_section.mr after the unref of the old MR, so that error_return
does not incorrectly double-unref the old MR.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1407
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/display/exynos4210_fimd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index c61e0280a7c..eec874d0b1d 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -1147,6 +1147,13 @@ static void fimd_update_memory_section(Exynos4210fimdState *s, unsigned win)
     if (w->mem_section.mr) {
         memory_region_set_log(w->mem_section.mr, false, DIRTY_MEMORY_VGA);
         memory_region_unref(w->mem_section.mr);
+        w->mem_section.mr = NULL;
+    }
+
+    if (w->fb_len == 0) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "FIMD: Guest config means framebuffer is zero length\n");
+        goto error_return;
     }
 
     w->mem_section = memory_region_find(s->fbmem, fb_start_addr, w->fb_len);
-- 
2.43.0


