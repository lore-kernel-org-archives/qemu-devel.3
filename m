Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E508C36013
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 19:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzL9S-0004QR-8E; Mon, 31 Mar 2025 15:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL90-0003NB-7S
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:50:03 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL8y-0003TZ-6t
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:50:01 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39141ffa9fcso4634068f8f.0
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 12:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743450598; x=1744055398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uHP3dfOw1csrD92NzXd1LjCikF/T0hdIj+cLpHi1vWc=;
 b=ihDOYyvFvBc7023UkZOcmVnuDoOixGZi15cKyogedQOlW58yvxyu2SduOPHt6XdHub
 StOZxmznlhhGFunxWX2K26T+E48TFlFADSE/RB3hytq5koh2JANRtNeqp3xuvs22rmr9
 WfcMze2fZJtGS2j6+NrFoW0cr6tVIjBq8wcgZ0goyC3EKuK9ARiQH3mOaBmfkiG1Wyqo
 bZq1a3SjST1txcMXrhe3bQpQJD8jY2VmxKTOV4W7UIE8KxOzyyM01qNk7ILBGxqfoWhu
 9Pn14kuEwvSbTfELoeyXUTLPuEfGMaw4rHF82a4PDWajltRNVlnHMFl2XMuCnRtsgEuk
 ccGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743450598; x=1744055398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uHP3dfOw1csrD92NzXd1LjCikF/T0hdIj+cLpHi1vWc=;
 b=WzUI0emp3FN7L5Tlk4etDsfpVxPyGCjFB8Ol8AWyBRuIQRmXZq2zf3tbjtUT9NNtfu
 5FipT/s5WEZ86su+plNi/JuKHNfyed4jVnhRXh9EFw17eQa9tEBsNTy7nULOok0Qd0bQ
 k0zJWhD5WeGcTp1xTmk8s/26MTUAdSxaOLSS8tXFye+Nnf1SmJmnR/uhjUlhkIYvnyKZ
 xVg2Bx/ofn7RKXN7RPUgkG3+D3OQtQNlmBerB6ejnfdPAwiOfxmC97BGEeiphyaKPjmI
 QYTGszTZdtdSE0DkoSrICo3cL2wQybPR4R/xtyvopU+tNUKGjcI6W6f64w9epWQsbCpy
 I3KA==
X-Gm-Message-State: AOJu0YwAq3JCjBNoygZMcJVtB8549NrOHlVIDgoMSEDaPj0Oi/eMqxuw
 tNdD2mzaE1g8MVQ2RkK8YmqeoCDN8aMOjx7PYAk0AcrUPHx15O8spIBjqr4OZ1dC8P5zkYTXCbf
 O
X-Gm-Gg: ASbGncsRHw1+C7jUNQ0LdLubZ2f485/Yvd5ZDB/OOCrlTaoqYs0PN8fPnDDH7wW3Ptk
 9FLRzs10hhlTU1iCSssfD0Mf0txqm0wowWviW/ITbPZkw+VUxtwx8CzbWRQahIxd8Y/8itWEaPK
 Ludb5rZRf8M70rop7bQh+QeQuO8PRMIWxSrxlbVowv7clKlXhLdwX5w1TLZxyeJmV91zWnGZjbd
 pkU+NVXwUU3byTrP+EF/0EuTCoxs2911PsUE5Q5vhlLLFbAwxfcJ0Z4x8Rs1u0N4MNLuyGqRmJz
 pvdcBHWq6IlircltuszX/pc6LCvhr15RjhAAQLF+SYe7cgz5RhL03RA0UdnI9+meRRMFGzVOTdp
 OPv0YDb0ZCudfjLW8HOE=
X-Google-Smtp-Source: AGHT+IHbWHYcSESUv3iuc4AkjfGh0xvKEzr5euY3wAA/wv/EBECiXUtqKs5rtXbmoKMko6+WkxQHzg==
X-Received: by 2002:a5d:584a:0:b0:390:fbdd:994d with SMTP id
 ffacd0b85a97d-39c120e3cd6mr8539689f8f.27.1743450598206; 
 Mon, 31 Mar 2025 12:49:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8314bbf1sm172587425e9.38.2025.03.31.12.49.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 31 Mar 2025 12:49:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/23] target/avr: Fix buffer read in avr_print_insn
Date: Mon, 31 Mar 2025 21:48:17 +0200
Message-ID: <20250331194822.77309-20-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331194822.77309-1-philmd@linaro.org>
References: <20250331194822.77309-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Do not unconditionally attempt to read 4 bytes, as there
may only be 2 bytes remaining in the translator cache.

Cc: qemu-stable@nongnu.org
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250325224403.4011975-2-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/avr/disas.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/target/avr/disas.c b/target/avr/disas.c
index b7689e8d7cd..d341030174f 100644
--- a/target/avr/disas.c
+++ b/target/avr/disas.c
@@ -68,28 +68,35 @@ static bool decode_insn(DisasContext *ctx, uint16_t insn);
 
 int avr_print_insn(bfd_vma addr, disassemble_info *info)
 {
-    DisasContext ctx;
+    DisasContext ctx = { info };
     DisasContext *pctx = &ctx;
     bfd_byte buffer[4];
     uint16_t insn;
     int status;
 
-    ctx.info = info;
-
-    status = info->read_memory_func(addr, buffer, 4, info);
+    status = info->read_memory_func(addr, buffer, 2, info);
     if (status != 0) {
         info->memory_error_func(status, addr, info);
         return -1;
     }
     insn = bfd_getl16(buffer);
-    ctx.next_word = bfd_getl16(buffer + 2);
-    ctx.next_word_used = false;
+
+    status = info->read_memory_func(addr + 2, buffer + 2, 2, info);
+    if (status == 0) {
+        ctx.next_word = bfd_getl16(buffer + 2);
+    }
 
     if (!decode_insn(&ctx, insn)) {
         output(".db", "0x%02x, 0x%02x", buffer[0], buffer[1]);
     }
 
-    return ctx.next_word_used ? 4 : 2;
+    if (!ctx.next_word_used) {
+        return 2;
+    } else if (status == 0) {
+        return 4;
+    }
+    info->memory_error_func(status, addr + 2, info);
+    return -1;
 }
 
 
-- 
2.47.1


