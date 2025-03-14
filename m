Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F140C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 13:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt4uL-0005DP-FK; Fri, 14 Mar 2025 09:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt4uG-0005Ar-6s
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:16:56 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt4uE-00017l-DS
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:16:55 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3913d45a148so1729079f8f.3
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 06:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741958213; x=1742563013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ASyllHmufnMu1BxhqQoVFXG0Ckh8C1+NGqucyyEdqU4=;
 b=rn+qzDJPWx2MT4+yRgzWLh026gpe7/8i41g+1B7dmi+9BAF9eeWAJRmTciczdAEljA
 FdXd7g2OTyD5cswLo29MFnMP31k5djakXL8KDSFPRXt14IfYsgcMz6qUkj/LBRbfIadH
 68C8fHs5va1AyKcJx0eDbrH9MB0LG7JUT4ZrmuJMRbjWL4ko/srtL+H1DzuQPTguUjU0
 QKL4Z0WqhWq7Ka9yYFF+7veFDCykLeUlxsYcPWPYjkFGwTIbffh0l3XK5yuLLopUq6ZZ
 s2H+UMtoBSmr1S6JUarIkE0zc6N4krt5pCmxYObKwBFoV1hYs78JjLhBFHlKjVQrf/dP
 MF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741958213; x=1742563013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ASyllHmufnMu1BxhqQoVFXG0Ckh8C1+NGqucyyEdqU4=;
 b=MV99kWCHoS5a/mJns2/4T+19eWlRaF8DlEgvhaYM5WJZR1tB8YZhfqJzt2y8SrHIb1
 Byzy1MN4iZS16TNAJut5On5BoQMk6UV2vtrLcwhLA8OjJejvRZWz0L/UDum6efOow69U
 HnFdQ3A0gpbBlIJ/1RYKk4a0Sv3vRh/DvB8U+k3rw7m3kAuateizpQOeQk+XMFVKUApy
 2MdUjPzY8P34iQl/Dwkd87FUE0yw3hqtRNaHTBhTGv2jtlPf58TozTi9zI70gPdh7yoD
 +sXU44LBeyqlHFPsANQB6QR57rO5pzcbki2EmbRnicFCCl/jQJzVidBMx6Be9HFD4jGq
 FANA==
X-Gm-Message-State: AOJu0YyCJxcqRQjB0ZSZ5za53Kur1Zp7pj40/7JVTSNvie5km0eFwgmU
 VXmGlrKGeXaBORIHYtxlbq2O253ExHJxFJg/2qfYxaLeeJJIp16T+VwpLyE+yi9I6hSoaYtjKhl
 f
X-Gm-Gg: ASbGncugz+4Dnnsa3Rg6Q6ET2+qdKxn1g5VVathyO/E4bVAIzKiBq6/fgkYJeuemjsm
 S5StdDsRAQITJ6bIHbTR61o/dYAv92ipd8dQHqkOPogOKlwa/vwbppReweRx26/82onjp4dajuq
 ezxcKHtSJPKp6pjFhOuO42v+wrDqCHaGR6FquhYa4OQJxR0TwUzjl3PTzIabc324sJoQDttdUxl
 9+pqzFOiXjg2zoEw7tKTos+1hbeoPugqaVbcxvz3/tDVOZ0pFegQJ/D4tfsJT2PZ0ji8QIqXjde
 TP+SA8L2j8Er/05oO2PNVvqxR+xh0WdjVmcsyX7vZNncCbri2IY=
X-Google-Smtp-Source: AGHT+IE/PgRV4rzT5LwormUA9To6yRlHjMfOzA9WE0yglZKghf8fhYk2hQNiH/Z7bAtdkQFUygW8Wg==
X-Received: by 2002:adf:a29c:0:b0:391:a43:8bb6 with SMTP id
 ffacd0b85a97d-3971e0be0fcmr3032860f8f.33.1741958212615; 
 Fri, 14 Mar 2025 06:16:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7eb93csm5437923f8f.86.2025.03.14.06.16.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 06:16:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/17] Revert "hw/char/pl011: Warn when using disabled receiver"
Date: Fri, 14 Mar 2025 13:16:33 +0000
Message-ID: <20250314131637.371866-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314131637.371866-1-peter.maydell@linaro.org>
References: <20250314131637.371866-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Paolo Bonzini <pbonzini@redhat.com>

The guest does not control whether characters are sent on the UART.
Sending them before the guest happens to boot will now result in a
"guest error" log entry that is only because of timing, even if the
guest _would_ later setup the receiver correctly.

This reverts the bulk of commit abf2b6a028670bd2890bb3aee7e103fe53e4b0df,
and instead adds a comment about why we don't check the enable bits.

Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20250311153717.206129-1-pbonzini@redhat.com
[PMM: expanded comment]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/pl011.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 23a9db8c57c..0e9ec1301d3 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -490,16 +490,17 @@ static int pl011_can_receive(void *opaque)
     unsigned fifo_depth = pl011_get_fifo_depth(s);
     unsigned fifo_available = fifo_depth - s->read_count;
 
-    if (!(s->cr & CR_UARTEN)) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "PL011 receiving data on disabled UART\n");
-    }
-    if (!(s->cr & CR_RXE)) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "PL011 receiving data on disabled RX UART\n");
-    }
-    trace_pl011_can_receive(s->lcr, s->read_count, fifo_depth, fifo_available);
+    /*
+     * In theory we should check the UART and RX enable bits here and
+     * return 0 if they are not set (so the guest can't receive data
+     * until you have enabled the UART). In practice we suspect there
+     * is at least some guest code out there which has been tested only
+     * on QEMU and which never bothers to enable the UART because we
+     * historically never enforced that. So we effectively keep the
+     * UART continuously enabled regardless of the enable bits.
+     */
 
+    trace_pl011_can_receive(s->lcr, s->read_count, fifo_depth, fifo_available);
     return fifo_available;
 }
 
-- 
2.43.0


