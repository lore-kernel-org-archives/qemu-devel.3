Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 134D1D6A22F
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 21:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBgz1-0003g1-Td; Thu, 14 Nov 2024 16:02:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBgyo-0003Ua-F5
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 16:02:20 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBgym-0008AQ-Ri
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 16:02:18 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2fb5740a03bso12069641fa.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 13:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731618131; x=1732222931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MF3SHGsIbIScsd8jKkxhhWNAqHynObedVS2I49WJ1Qw=;
 b=YTyS8V87ArGz807cKXlKjjpSQA9ChBj0Esk0ihUk4uaMZAMH8SrZfjbQo+HLClPZnD
 yg75mAQqwv1dBJi5dw/GLNR2rBiYAHtwmVGePMcU1bBwv0rBot8ZxvE0cJUtrul03u9r
 ldOnXNQcVbtuqJwvAyaM6kpr4NodT0QqlzE9GjhkJZQlOWW6SUuPsehaidXPBjL/bslZ
 q1yKYtawWpFrx7+SKPYwmCI5VyLcsTliDAUXf+DV0d5CAxHAiOrp2GwolzqrveMj3NsV
 za5kDuCuAP1+fk+s8u7wCZEErJvK3QvVX1AkfryP4CRcNnlaZkcFPNYFcD2CK/fyDdHZ
 VOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731618131; x=1732222931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MF3SHGsIbIScsd8jKkxhhWNAqHynObedVS2I49WJ1Qw=;
 b=EuW6VbAOQB4xe6aS8edaZTtbvxBNByRRZL1+iBndGF/JXAEt7MghWNqZHqZe6+8XMK
 yMbQzdd9iZNPnsUOxFzaLVOfrwkeuNzfK5RqxTQgC7zDcRDI4rfQn7lDJhjoMeQL5rWK
 J7V0LZBdypmJljZ22Bdu2y3bahn0JYR/6K2Y8Wy3Ha4jwHeQWHROmtZ96uM46+Z6/lRA
 5b6eyQFlFhmKyo2xlzuaINL7ZCTFd+Or1SWxHi8zN7WVjyiX7VCeihR8X9qCH6dHQxrG
 xcwILBrifxK2W2/+kbsmlsUr+qCfdKsUgJ2YIsskB/66rx7JNW7DyyYNhGl104Ne1Q2k
 mPdA==
X-Gm-Message-State: AOJu0Yxko3xJ/fMTS5c1LNJ9NyzvdEjrscGw4dtsp744DDJOfQfVraxX
 rXmcwdXcSDQqLxmtnqDtLUzq1O2/+32NluFAibTRfcGJiMn/jJnJ951jj1u2AzFZta/WvaTun6E
 t
X-Google-Smtp-Source: AGHT+IGIACFpfDDtDOm/YL+B4Vhdmgg8ynUumpS/4cbfbqcHOaWTDPEEroc/40jI798GNz2Jmy5Y/g==
X-Received: by 2002:a2e:9fc9:0:b0:2fb:556c:fe0b with SMTP id
 38308e7fff4ca-2ff606deabdmr2503881fa.26.1731618131571; 
 Thu, 14 Nov 2024 13:02:11 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.228])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dab80869sm32110865e9.22.2024.11.14.13.02.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Nov 2024 13:02:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Bernhard Beschow <shentey@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH RESEND v2 15/19] hw/net/xilinx_ethlite: Map TX_GIE as MMIO
Date: Thu, 14 Nov 2024 22:00:06 +0100
Message-ID: <20241114210010.34502-16-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114210010.34502-1-philmd@linaro.org>
References: <20241114210010.34502-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
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

Add TX_GIE to the TX registers MMIO region.

Before TX_GIE1 was accessed as RAM, with no effect.
Now it is accessed as MMIO, also without any effect.

The memory flat view becomes:

  (qemu) info mtree -f
  FlatView #0
   Root memory region: system
    0000000081000000-00000000810007e3 (prio 0, i/o): xlnx.xps-ethernetlite
    00000000810007e4-00000000810007f3 (prio 0, i/o): ethlite.mdio
    00000000810007f4-00000000810007fb (prio 0, i/o): ethlite.tx[0]io
    00000000810007fc-0000000081000ff3 (prio 0, i/o): xlnx.xps-ethernetlite @00000000000007fc
    0000000081000ff4-0000000081000ffb (prio 0, i/o): ethlite.tx[1]io
    0000000081000ffc-00000000810017fb (prio 0, i/o): xlnx.xps-ethernetlite @0000000000000ffc
    00000000810017fc-00000000810017ff (prio 0, i/o): ethlite.rx[0]io
    0000000081001800-0000000081001ffb (prio 0, i/o): xlnx.xps-ethernetlite @0000000000001800
    0000000081001ffc-0000000081001fff (prio 0, i/o): ethlite.rx[1]io

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/net/xilinx_ethlite.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index b105fb7524..038e81dcae 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -42,7 +42,6 @@
 #define BUFSZ_MAX      0x07e4
 #define A_MDIO_BASE    0x07e4
 #define A_TX_BASE0     0x07f4
-#define R_TX_GIE0     (0x07f8 / 4)
 #define R_TX_CTRL0    (0x07fc / 4)
 #define R_TX_BUF1     (0x0800 / 4)
 #define A_TX_BASE1     0x0ff4
@@ -56,6 +55,7 @@
 
 enum {
     TX_LEN =  0,
+    TX_GIE =  1,
     TX_MAX
 };
 
@@ -142,6 +142,9 @@ static uint64_t port_tx_read(void *opaque, hwaddr addr, unsigned int size)
         case TX_LEN:
             r = s->port[port_index].reg.tx_len;
             break;
+        case TX_GIE:
+            r = s->port[port_index].reg.tx_gie;
+            break;
         default:
             g_assert_not_reached();
     }
@@ -159,6 +162,9 @@ static void port_tx_write(void *opaque, hwaddr addr, uint64_t value,
         case TX_LEN:
             s->port[port_index].reg.tx_len = value;
             break;
+        case TX_GIE:
+            s->port[port_index].reg.tx_gie = value;
+            break;
         default:
             g_assert_not_reached();
     }
@@ -238,10 +244,6 @@ eth_read(void *opaque, hwaddr addr, unsigned int size)
 
     switch (addr)
     {
-        case R_TX_GIE0:
-            r = s->port[port_index].reg.tx_gie;
-            break;
-
         case R_TX_CTRL1:
         case R_TX_CTRL0:
             r = s->port[port_index].reg.tx_ctrl;
@@ -286,11 +288,6 @@ eth_write(void *opaque, hwaddr addr,
             s->port[port_index].reg.tx_ctrl = value & ~(CTRL_P | CTRL_S);
             break;
 
-        /* Keep these native.  */
-        case R_TX_GIE0:
-            s->port[port_index].reg.tx_gie = value;
-            break;
-
         default:
             s->regs[addr] = tswap32(value);
             break;
-- 
2.45.2


