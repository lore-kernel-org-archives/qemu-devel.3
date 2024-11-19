Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07076D44163
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 14:25:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDP8c-0005tO-O4; Tue, 19 Nov 2024 09:23:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDP8Z-0005pT-L0
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 09:23:27 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDP8X-0006CV-Ur
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 09:23:27 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4314fa33a35so46381325e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 06:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732026204; x=1732631004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iAX2ZgBrM6JHivHnb791/gNLlFdNQx34cY3TYAYpz00=;
 b=ODM2t56t8W5rAD2qnandcjmRU3Y+KJWKIzKziXruDWnja3zgmysdl3XObYPA1AMAG3
 ZIZ6WiYHnZcSjw0Q+wUmlJBdYLexQXCe0wlCNBN7bT+iynkKtlHqOMA6tGxaPqf2GPLh
 f6eYJ7O71qkujzBNogbiqOLORrSqy5P5/GGosioWlPbk9ZrUxpnAFPx8xmrtjNRSspRj
 1ZwJKNsx04X8hgWLkAcABXbhsaxiZX61kAkzc2LKVnPr43alKXxjSrMvFUoYSiXX+si0
 4NNOjgm3YdJDqX442ou0TQOk9EfE8CLmzBNQMuBnWPD21C1pgBOVYXwk37xxUzpGlgxT
 4lbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732026204; x=1732631004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iAX2ZgBrM6JHivHnb791/gNLlFdNQx34cY3TYAYpz00=;
 b=HDkwTzPgGMgiaz6GiXZdAM8xKAY1j6VMdTTHSPy8dpwSp65zZEPNt41LCJRMiZ3kOK
 /LM1/FPLnwPpZmmboJScfGKtldmPBtGbjEUaxz7vn1Fn40UlJp8mojnd+VMCWk26ex/V
 azTnDTvXQ+uIHr1pYW6bNJI+4KI5ZMnFp++VHII7RkYqmhx8X06zqdEX/DeWX5/tkMzu
 FdnaSeh0mZJtyvN7nrBeXVHZpstKMZ5jRwHqJnn2qnbGsQC6cL/6xsjs4CQrtgM9FMpJ
 QMeBdpQBlvqK37LZ8sIJP4LbFt1z2u7pxWmGrVuTavnCZlHwQR2oRoKfujCv7dDGeueH
 Ak1g==
X-Gm-Message-State: AOJu0Yy/5sdk3WzvxcU971NdtFycqXLlLN+TeZoZr7vCLMHR9iH5ib/D
 ULAjQ1N7CajXMEhgc/Utpyo2CspGYu9hJIeL+KiJLaz1nKhMmiiK7OeC6StBxSh4drvwZelVAGM
 O
X-Google-Smtp-Source: AGHT+IG39YeLMAUDJLekD6viGZHHOScJrG02lOOpx9WX2fDbjYV3RX5idPOYlwnO0kGJWC0THbtAog==
X-Received: by 2002:a05:600c:1d92:b0:431:2b66:44f7 with SMTP id
 5b1f17b1804b1-432df798fbcmr144701975e9.31.1732026204395; 
 Tue, 19 Nov 2024 06:23:24 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dac21a15sm193049985e9.38.2024.11.19.06.23.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 06:23:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/15] hw/intc/openpic: Avoid taking address of out-of-bounds
 array index
Date: Tue, 19 Nov 2024 14:23:09 +0000
Message-Id: <20241119142321.1853732-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119142321.1853732-1-peter.maydell@linaro.org>
References: <20241119142321.1853732-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

The clang sanitizer complains about the code in the EOI handling
of openpic_cpu_write_internal():

UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1 ./build/clang/qemu-system-ppc -M mac99,graphics=off -display none -kernel day15/invaders.elf
../../hw/intc/openpic.c:1034:16: runtime error: index -1 out of bounds for type 'IRQSource[264]' (aka 'struct IRQSource[264]')
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../../hw/intc/openpic.c:1034:16 in

This is because we do
  src = &opp->src[n_IRQ];
when n_IRQ may be -1.  This is in practice harmless because if n_IRQ
is -1 then we don't do anything with the src pointer, but it is
undefined behaviour. (This has been present since this device
was first added to QEMU.)

Rearrange the code so we only do the array index when n_IRQ is not -1.

Cc: qemu-stable@nongnu.org
Fixes: e9df014c0b ("Implement embedded IRQ controller for PowerPC 6xx/740 & 75")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-id: 20241105180205.3074071-1-peter.maydell@linaro.org
---
 hw/intc/openpic.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index cd3d87768e0..2ead4b9ba00 100644
--- a/hw/intc/openpic.c
+++ b/hw/intc/openpic.c
@@ -1031,13 +1031,14 @@ static void openpic_cpu_write_internal(void *opaque, hwaddr addr,
         s_IRQ = IRQ_get_next(opp, &dst->servicing);
         /* Check queued interrupts. */
         n_IRQ = IRQ_get_next(opp, &dst->raised);
-        src = &opp->src[n_IRQ];
-        if (n_IRQ != -1 &&
-            (s_IRQ == -1 ||
-             IVPR_PRIORITY(src->ivpr) > dst->servicing.priority)) {
-            DPRINTF("Raise OpenPIC INT output cpu %d irq %d",
-                    idx, n_IRQ);
-            qemu_irq_raise(opp->dst[idx].irqs[OPENPIC_OUTPUT_INT]);
+        if (n_IRQ != -1) {
+            src = &opp->src[n_IRQ];
+            if (s_IRQ == -1 ||
+                IVPR_PRIORITY(src->ivpr) > dst->servicing.priority) {
+                DPRINTF("Raise OpenPIC INT output cpu %d irq %d",
+                        idx, n_IRQ);
+                qemu_irq_raise(opp->dst[idx].irqs[OPENPIC_OUTPUT_INT]);
+            }
         }
         break;
     default:
-- 
2.34.1


