Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D356C282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdWG-0004vm-Np; Tue, 04 Mar 2025 20:25:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdUS-0002Fa-ON
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:24:11 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdUR-0007BE-6f
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:24:04 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43bcad638efso10145755e9.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741137841; x=1741742641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GWCkeTUZ1Bwoa+5rt2QUs52v09pE2by6BJ43I/9OHfA=;
 b=GCfUfAtIrzHLlH/2PKgYp41BYSS/VC+sMlt2aBoOgsv5WWw96+LLCa7e9Ey5oolEMG
 s0aUcNBFNw8pSGl9wJFFx1keMLTIcGuLEf6ENh6PPWkB3dNlru6cgfbMI1dyLzZUM238
 07DAOX6RJfb7B8+YXeKIxuO1VpRsCn66njZ2S0++aBqLh8ShV3LbTlMOb/6VWcrCWFNq
 bAoapJgQND1xUoWCuubtXc6bTcvLD7Ks74v5MIQ/J1ABryAxKk/hp4xVNuMfwPITICYS
 wmPqS+LBmsYqie7HrzzfDhDFv2UPzeuSBNuibXq7NZM3/U3mG59F5S/307ewz+68Ye5G
 nVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741137841; x=1741742641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GWCkeTUZ1Bwoa+5rt2QUs52v09pE2by6BJ43I/9OHfA=;
 b=TCVDQI1a+T8X8laRZ8RvMShF6DVwZSjU4O7YRxyQv55o+wuBq4McljzZVCekcBVJOA
 d0AquUTBJVrpg+wt6DTZDnafFQNfXqzjjXwGPIqhDoaxPyXNBgbNzrIk+vpSGQ25RGRK
 7g2nCgfWG9LxOB5n/2+ppQIm53362DP0Iz0bu5Kgav+3krwvbakQ3hwOkKBwT2NkxvCv
 Wugesf7IFGJ0dC8ylqTBpQ/DHBWJ9fMmPKT/pm16I2AJ07FfZALoeJHk6ENQyoNo3Pel
 a1MXuyNTTOv8Mlev4lbXC3QWMhDlaFWokSEguKPe3TMJTv9MX2/ZLLIDQ+RVo0ibCJHY
 5/gw==
X-Gm-Message-State: AOJu0YxzrrbPjijQUBZZThhAMoqf0HRqRI3G68uEVh/sgZTNBl4JrBuO
 KRgddAKO3WQPssOZt5t0i6r6AhoQDHaIq4Nkmm/ziJHu1RmneKo45CuyJ8foyOhd/3sZFsGRJVD
 cC50=
X-Gm-Gg: ASbGncveFHx2qsJfrJDinjwwFaQyOfd+o4CaBlWbEZL7Lf3xbTfWizCVoa/EdTCKdFn
 ek7yM2bsdoX+2eIfOSSB4BlMb/PAhbp4rvItfJhSZK9SMa83Nrh0lx3o01TwGoaFgy+XeQDi+IF
 qI7gB5B/drA0qLNikaB0MSA3AfpJZu3Zc763x8AI+7wQ6FGPzPU/swD4P+JsZbwY32KdUtWDXTf
 t9k6GErlSgvEWRmLAD4ktqAWad6Z9fDNpEzSyXE5BjOPn0R2ofBlrWLTXBhX8OJV38WJ/TWwxAQ
 rtmMEfuphrp8M26i9J6Xhcf2OjdgB9M6BbQGKNksTGTWqB/Yb+o5cVj6H3x91poKYWjExflaEfH
 ZIDjcHdfMzPWTJ54I71E=
X-Google-Smtp-Source: AGHT+IEDnbjMa1qZO+TqVDNEIcP6ZL46N87m9w0qmJfAaCjm2r5QnBMcwlcnE+z00mQf2jHlHbIhzA==
X-Received: by 2002:a05:600c:4ed2:b0:439:a5e6:73ff with SMTP id
 5b1f17b1804b1-43bd29d8441mr6558595e9.17.1741137840978; 
 Tue, 04 Mar 2025 17:24:00 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd42e6bcfsm1952175e9.32.2025.03.04.17.23.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 17:24:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Luc Michel <luc.michel@amd.com>, Thomas Huth <huth@tuxfamily.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 25/41] hw/char/mcf_uart: Use FIFO_DEPTH definition instead of
 magic values
Date: Wed,  5 Mar 2025 02:21:40 +0100
Message-ID: <20250305012157.96463-26-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305012157.96463-1-philmd@linaro.org>
References: <20250305012157.96463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Defines FIFO_DEPTH and use it, fixing coding style.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250220092903.3726-8-philmd@linaro.org>
---
 hw/char/mcf_uart.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
index 980a12fcb7d..95f269ee9b7 100644
--- a/hw/char/mcf_uart.c
+++ b/hw/char/mcf_uart.c
@@ -17,6 +17,8 @@
 #include "chardev/char-fe.h"
 #include "qom/object.h"
 
+#define FIFO_DEPTH 4
+
 struct mcf_uart_state {
     SysBusDevice parent_obj;
 
@@ -27,7 +29,7 @@ struct mcf_uart_state {
     uint8_t imr;
     uint8_t bg1;
     uint8_t bg2;
-    uint8_t fifo[4];
+    uint8_t fifo[FIFO_DEPTH];
     uint8_t tb;
     int current_mr;
     int fifo_len;
@@ -247,14 +249,16 @@ static void mcf_uart_reset(DeviceState *dev)
 static void mcf_uart_push_byte(mcf_uart_state *s, uint8_t data)
 {
     /* Break events overwrite the last byte if the fifo is full.  */
-    if (s->fifo_len == 4)
+    if (s->fifo_len == FIFO_DEPTH) {
         s->fifo_len--;
+    }
 
     s->fifo[s->fifo_len] = data;
     s->fifo_len++;
     s->sr |= MCF_UART_RxRDY;
-    if (s->fifo_len == 4)
+    if (s->fifo_len == FIFO_DEPTH) {
         s->sr |= MCF_UART_FFULL;
+    }
 
     mcf_uart_update(s);
 }
-- 
2.47.1


