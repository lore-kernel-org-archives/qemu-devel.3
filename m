Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B725EC0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyEL-0001CX-Kt; Fri, 31 Jan 2025 16:07:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyEE-0000tP-Pa
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:07:07 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyEC-0007uw-1W
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:07:05 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-436281c8a38so18009295e9.3
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738357622; x=1738962422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HmQOIAQmsmwo1mW3OC9lmlp6Q7vTxJ0LbXR7U7WGXSY=;
 b=Qa1weYwOWhcIZhaSX6JvkwQRGqNqLdGI1Uhu/foXmIHY1cNKfymivMl99AFT5TVcuV
 8iPt1Kw+9xgYHK3Ox3S4tEMzidhUu7FHYP7bjgiE0lzMbFmaZalbylxaIbnYRTtfq1wp
 erdyz2hfwDtIRWugUotlJKaI2+9fVy7DuxRBb22W7VgagpIw4Yu8/eeVCZwpaliUdM7v
 j4UhODb5joISng48p4KmjIa3ok4nNZRP+AaLdu9qa+gcKuDDmnqYElcrsqfACN6mlsep
 WyyOWE012CNVwy7mo0+7vyPA8WixWxgnzo+gJ+pfvktcNAZHv7/mpfgDBAx25epUnnel
 6buA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738357622; x=1738962422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HmQOIAQmsmwo1mW3OC9lmlp6Q7vTxJ0LbXR7U7WGXSY=;
 b=Hy939Flm6WF1JPJQAa9KMHH+mRkIYDqySZMeq2rmdCYDASn5X8FWpYjAguMvsXRUlM
 fRhNTp/1pmdNlzPau8ak7/obZaXtdRJ83Pyil89E+sVEQLkw0ucULv8AAtGs2eFHv/wK
 sdKcGwUcLMm3vwaTW8677xUDqp5bxAtvaDza3LBUFbKflBKCISfuIteVaFthVj8tJNNX
 m61WEcJPZ7vMgEhUm6t+xCiFdfTPvnW6841DsmNi+uq/myOmjuc/LOMtgPnM0s7FpSkB
 v/6NEc277AHDCLL3nHCUik60M0TTGldBXmKGiKpFvZ3GgREy9c0Gcxwy2138VT864ovv
 bAaw==
X-Gm-Message-State: AOJu0YzHrCyi9fbGzCrawGyvcfnMuRcWkRXt/1L9BKNax+u++NpnAt91
 mxkU1hHn0U6AJUPEFulo+YYvTuosYYseEkTHuBWUlSl5TuWOkRzZRnGQTBXJWhykc8LkVeIbNT0
 p/3Q=
X-Gm-Gg: ASbGncuwswr676J5SUUhZwF6lgfA9Yy/L/2EbisdazO2PHhEh5HNpCsUlZjohK/o67r
 A1znkmMCjRoz/pgBPB4l2pe00qY99cB3EvshOOvdzB5oIZ0YgpsiLvWf6Ldxo5/qK7/lflZPBqh
 uqU2NwRjmG7BJOdSmlxBJBLpXXEdnVy0f//BcCRgFWybDMwTZDKaPlE9wnlAm5eBRpuCRZE8oBd
 Md4v8o8Al0S7/zl2Op51u6YyV0HIkg9zWKQvGPX86U2+YpXuW8aO28bsq4p/79S0eokgn2lq2d1
 8tF5xXcAKzlM219a5rfcGVbIhYAj9miSsZkOChFFG//pgtT8wkRNwNIEY4z8T9SWYQ==
X-Google-Smtp-Source: AGHT+IHhc99+jiIqEkeU1Qknnux2nesawepkr0BbTUAjhmHqKrUDZ42ICh2qXdG98V2CCJ6vrNrnlA==
X-Received: by 2002:a05:600c:3155:b0:434:a5bc:70fc with SMTP id
 5b1f17b1804b1-438dc3ae116mr120786475e9.8.1738357622346; 
 Fri, 31 Jan 2025 13:07:02 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23e6b62sm66430035e9.24.2025.01.31.13.07.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Jan 2025 13:07:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 20/36] hw/avr/boot: Replace load_elf_ram_sym() -> load_elf_as()
Date: Fri, 31 Jan 2025 22:05:03 +0100
Message-ID: <20250131210520.85874-21-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131210520.85874-1-philmd@linaro.org>
References: <20250131210520.85874-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

load_elf_ram_sym() with load_rom=true, sym_cb=NULL is
equivalent to load_elf_as(). Replace by the latter to
simplify.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250127113824.50177-2-philmd@linaro.org>
---
 hw/avr/boot.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/avr/boot.c b/hw/avr/boot.c
index 617f3a144c8..6a91dcd12d0 100644
--- a/hw/avr/boot.c
+++ b/hw/avr/boot.c
@@ -71,11 +71,9 @@ bool avr_load_firmware(AVRCPU *cpu, MachineState *ms,
         return false;
     }
 
-    bytes_loaded = load_elf_ram_sym(filename,
-                                    NULL, NULL, NULL,
-                                    &entry, NULL, NULL,
-                                    &e_flags, 0, EM_AVR, 0, 0,
-                                    NULL, true, NULL);
+    bytes_loaded = load_elf_as(filename, NULL, NULL, NULL,
+                               &entry, NULL, NULL,
+                               &e_flags, 0, EM_AVR, 0, 0, NULL);
     if (bytes_loaded >= 0) {
         /* If ELF file is provided, determine CPU type reading ELF e_flags. */
         const char *elf_cpu = avr_elf_e_flags_to_cpu_type(e_flags);
-- 
2.47.1


