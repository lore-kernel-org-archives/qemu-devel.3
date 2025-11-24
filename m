Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08283CFA466
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 14:31:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNXaa-0007rs-LJ; Mon, 24 Nov 2025 09:30:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNXaY-0007r2-HW
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 09:30:46 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNXaW-00034K-Nr
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 09:30:46 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-42b566859ecso3933291f8f.2
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 06:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763994643; x=1764599443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8L4MDm0H12rm6yYjOjzi8dIkctKRo1jyzug5SgRPaRM=;
 b=POlMl8RX6jKIshmK0A1b9q5UKbq5QtWtY2VX0x32s2hX7jRrogb9iuqT2gGMkFrwpo
 Cz67pLWZ7MwIGhxX7MhaNSZ6ygmgf3MNfiFhRxc9xRmRmqvYzzHPMaVIFBzIIOtltoxu
 eCbHaW+Av8AkW3cDRv0TrnKwZW0gRMJrbmeGv/w8dUREQunfebDnBYQKPiDXw9fRs8C5
 oIOuOCTrwJQTrNV7a9PZUlTGIGCwEs+59QMqtZ4ehSR1vj1YUkLMGhfPjwamkxKKmbRT
 AbuAO4fwyXBK/cXo4wRAjwWpz+DlI4EQ6JXvRdh0PbJId8C6WfQI3Dc+Y12NCNHvBqFx
 sZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763994643; x=1764599443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8L4MDm0H12rm6yYjOjzi8dIkctKRo1jyzug5SgRPaRM=;
 b=HFjXDeCReSisrKaonwK+4s1LFKjSJ6MWeo15ZJjIXFbokDps5O4JFyDXIdE9OrfHB6
 OpZQ9yIuqIzzy2saiVpaar3uLqNAOk+xSal2ldhO2rcExOfaz8k5ddyaZ7sIGlEuG53g
 AM1EAV4jBFX34DtIRYoh6un7pXhvCvn+OIDIShQuBOj1jHECcVUKIhvfFlVOlq7EJmwY
 w6dPS7wEN/zicoB61qcAZ6YHLMdH63r+VAYUvUz8UuGj10oB407OSPQTtr8ZhiA6Dbwi
 AGNqX/e4cMY38w2AUWT4ShsArldpcvg1joTGPrd37GLqilYvUYUt79HjYw82u7qUQRbb
 Arog==
X-Gm-Message-State: AOJu0YwUBH422FlFQ4jznRxIjvCxPn5m8mZDoG2JQ45pTeZSxSjziaIm
 LlKC8v121E/CSXUo5rd5bd9ObfyGbql/tUVzkM983MvdXm120PYA2/zmWi+ARYhcKnjtqGJtx+O
 VLtzj
X-Gm-Gg: ASbGncukh2rJMPIJ80kNAkw3rn1Y13KpTtcRIOTpl8eVXulaAra4plrPOxUFl6y8pfg
 bmyxjQICerekA4NYbLSxbrehO9huOrl0zYS8zMddGo50yFVTHD38Nnd6d5zO3RR3rCg9ovQyM+m
 VWUUjt3oFSBTfGymb7r6ekTOf6MPikOT5T6lE26E1K7x1v7gW/gt4EIHGwC/Apl2WZgGA2MChJN
 rSZrX0JMdDLN8+CWQdEQKbicpBwT4G5JqQiho/g6UJ5O8tnDtK3QN3ZeIe8cTilZ5TpCSrBYjRY
 kx2v9fZYKP3I8TKQYGrT00VHb85Fq0T1C7nCzOW2bhXuyp9VCc3vjsO38UvhhgINrmVYhRIb868
 hRGE2ZgO7OGlirK8L32FNUGNWuiMHEq0hLIgypmGVazzOq49hhILafnkgPqQgN+AJOk0nldxG8l
 v8SeBaWKuUtw60Zklz
X-Google-Smtp-Source: AGHT+IGsxnTfY6TRMnfHoBlCNKD+1NmF5oIkTScFmmayT2K7Won/WsSMbXPQbMDiRZ6xeeuoluiKpA==
X-Received: by 2002:a05:6000:1448:b0:429:d3e9:65b with SMTP id
 ffacd0b85a97d-42cc1d23c3emr12260115f8f.59.1763994642364; 
 Mon, 24 Nov 2025 06:30:42 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f34ff3sm29408930f8f.16.2025.11.24.06.30.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 06:30:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/4] hw/display/exynos4210_fimd: Account for zero length in
 fimd_update_memory_section()
Date: Mon, 24 Nov 2025 14:30:36 +0000
Message-ID: <20251124143036.4113886-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251124143036.4113886-1-peter.maydell@linaro.org>
References: <20251124143036.4113886-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20251107143913.1341358-1-peter.maydell@linaro.org
---
 hw/display/exynos4210_fimd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index 6b1eb43987c..49c180fec0c 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -1146,6 +1146,13 @@ static void fimd_update_memory_section(Exynos4210fimdState *s, unsigned win)
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


