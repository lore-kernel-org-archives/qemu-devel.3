Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C568E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6IF-0008UN-Ro; Sun, 12 Jan 2025 17:18:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6I3-0008BH-7o
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:18:39 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6I0-0006Rx-IO
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:18:38 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-385e0e224cbso1929169f8f.2
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720314; x=1737325114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mVeyTCl5h3W5QLqThsMAAyK0yBMC4OoyGuT39cU7uug=;
 b=ixAPpkFURUEnseLhNEAXrI7X4vSsLNO+3g7d+SIB1RS2g5tj5l8jRoUICjzIsmdFoA
 Sot2cQlaje4o0fode5tC6CHhPATHZezdJvf6hXb9lhzORNt0CmZ0oIS/wspLY6EKRpju
 aS0goXPVWgr4ns8WyklJeTf5hZC6mJtFdE3FF01UmXp5Pdc5jcHyInVIdvr3AN6N9Cwj
 qvdlhdSDBtSFGvltGBwDjA/RmCsOy2hcQsuACJpCDfwzsQ0dd78J0GscSxfxfXGCtEcb
 5YszwGqAsTOUOccYkOksnraeWBGoC3Gtk3dC+kfBYSdRKBA950ItAoj8Mw5ntqsH8Htt
 bxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720314; x=1737325114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mVeyTCl5h3W5QLqThsMAAyK0yBMC4OoyGuT39cU7uug=;
 b=ZczMJWOiEKWhIrgpve7PDWiMjietF6SO7D4lHqt0mYcTivFHNpMVAZ45j+vY+/ZnkK
 UpGHwFhyywdHRjbuOr2O17h3hLSeRzEs7DTNcCiRyzDiVK1Pq/DsPvgsKQOjbP8DuaWE
 WudryAowmNNCw4nqAYPx+LspBwyHo6pMvnt6VF+fxqeXsaELqiyS52/2g57zRCH5GPFB
 gyDmTXuGy6LQLFsvHwWHp3FNSEp4gdgtHRbiK8nhokX80dEoJr/K8O6LsXS02QQ0qmrq
 yQQljczXrwKkPjUsAIcrbGBXmOpQiQiTBjpQUjndG6UclNAEonDzfyjPP9ocmOaNqQRs
 HQBg==
X-Gm-Message-State: AOJu0YzHSfIDiAudcGG0weekQx0CcJxemR7Ftmq4FQ9x10j8jhNzgCdp
 fb4u94kZfW79pAZ8LdqrTU0FC7DTSX4di7dw5vTEeIUAoNoTkZCcvLNXHE2xcT2CzywbqlA808f
 vDNc=
X-Gm-Gg: ASbGncvfGwwGcjtH4LvFS5PRtRPjboS6aEayMurDVridZRle5LRNhTzFsBrtNaiB9sM
 IG0WAMl0D/TVvnjdXz968A7+Uc4ldwvqxplBH3IkcIRIXAFcTZiP1HK/JNr1DdCyB+BRlEzJMKx
 Nxgi4PZPvM0S1TOX7k9GhJF/zM7FRzFQ1atXvsF8A17ECjr8yIfjj9pcB4a0SOEkvBwh3D+SM0T
 KyWMZXX8DQxyv3OSUUXJkq2AJzuZX6fECv30BnyXqm402SjQzytCEm2FNc9RMe8YGW7wX0LP8zX
 tMz+boZ5SHxlyZiExRKG5sPqMszXPN8=
X-Google-Smtp-Source: AGHT+IFHf4dSgslizflMoWRm60TvOflmtwQpn2kOHM7wa+Pvk/sus4pvcU6+1GserpUBFOLfC5gIKA==
X-Received: by 2002:a5d:6c63:0:b0:385:e22e:288f with SMTP id
 ffacd0b85a97d-38a872ea33fmr16499846f8f.31.1736720314465; 
 Sun, 12 Jan 2025 14:18:34 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2ddca2dsm158256285e9.21.2025.01.12.14.18.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:18:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 13/49] hw/net/xilinx_ethlite: Access TX_CTRL register for each
 port
Date: Sun, 12 Jan 2025 23:16:49 +0100
Message-ID: <20250112221726.30206-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Rather than accessing the registers within the mixed RAM/MMIO
region as indexed register, declare a per-port TX_CTRL. This
will help to map the RAM as RAM (keeping MMIO as MMIO) in few
commits.

Previous s->regs[R_TX_CTRL0] and s->regs[R_TX_CTRL1] are now
unused. Not a concern, this array will soon disappear.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-Id: <20241112181044.92193-15-philmd@linaro.org>
---
 hw/net/xilinx_ethlite.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index ce9555bd1e2..f8b01fe9a62 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -64,6 +64,7 @@ typedef struct XlnxXpsEthLitePort {
     struct {
         uint32_t tx_len;
         uint32_t tx_gie;
+        uint32_t tx_ctrl;
 
         uint32_t rx_ctrl;
     } reg;
@@ -139,7 +140,7 @@ eth_read(void *opaque, hwaddr addr, unsigned int size)
 
         case R_TX_CTRL1:
         case R_TX_CTRL0:
-            r = s->regs[addr];
+            r = s->port[port_index].reg.tx_ctrl;
             break;
 
         case R_RX_CTRL1:
@@ -160,7 +161,6 @@ eth_write(void *opaque, hwaddr addr,
 {
     XlnxXpsEthLite *s = opaque;
     unsigned int port_index = addr_to_port_index(addr);
-    unsigned int base = 0;
     uint32_t value = val64;
 
     addr >>= 2;
@@ -168,24 +168,23 @@ eth_write(void *opaque, hwaddr addr,
     {
         case R_TX_CTRL0:
         case R_TX_CTRL1:
-            if (addr == R_TX_CTRL1)
-                base = 0x800 / 4;
-
             if ((value & (CTRL_P | CTRL_S)) == CTRL_S) {
                 qemu_send_packet(qemu_get_queue(s->nic),
                                  txbuf_ptr(s, port_index),
                                  s->port[port_index].reg.tx_len);
-                if (s->regs[base + R_TX_CTRL0] & CTRL_I)
+                if (s->port[port_index].reg.tx_ctrl & CTRL_I) {
                     eth_pulse_irq(s);
+                }
             } else if ((value & (CTRL_P | CTRL_S)) == (CTRL_P | CTRL_S)) {
                 memcpy(&s->conf.macaddr.a[0], txbuf_ptr(s, port_index), 6);
-                if (s->regs[base + R_TX_CTRL0] & CTRL_I)
+                if (s->port[port_index].reg.tx_ctrl & CTRL_I) {
                     eth_pulse_irq(s);
+                }
             }
 
             /* We are fast and get ready pretty much immediately so
                we actually never flip the S nor P bits to one.  */
-            s->regs[addr] = value & ~(CTRL_P | CTRL_S);
+            s->port[port_index].reg.tx_ctrl = value & ~(CTRL_P | CTRL_S);
             break;
 
         /* Keep these native.  */
-- 
2.47.1


