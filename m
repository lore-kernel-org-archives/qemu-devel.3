Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C111E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWJNY-0003fs-17; Fri, 10 Jan 2025 13:05:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWJNI-0003cz-Mu
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:04:49 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWJNH-0003sL-3e
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:04:48 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3863c36a731so1718218f8f.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736532285; x=1737137085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=q3tDYW/FZQAb+LrrJkOjtGoxqsuktWpm6SvboahZVVo=;
 b=JvUgCCptPiaSlJ8Npq04f7a/b601oKRxDduCT3GF1xOAxhTl3Cjc6sQnzB5Mn9CdUe
 CWqP/xI6mh0eAAF6Oj99NJd3rTrrsNflSd51r+hzrCMMbOwSvQLLRq1NR4rOQD3UHoz2
 K0fNGNPa+kcFdCN+rFdqtYqRqg8XOAI3gOdc8NJvkW6c8HPbdUolUfqCdieEdcV3TLIg
 QfDeVjCofjGFqyNN7FA7Q3ZTm7Ry996lvRm/ffD/Ikgt5SX7sfDv152l9/5ECW9VC7zq
 32qXAJYtlRDjRpfSLEaIZPiL1X7DoLoDvN7YtNIXFp25n3tvtOK7X8aG+XQMffMrW1IY
 deYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736532285; x=1737137085;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q3tDYW/FZQAb+LrrJkOjtGoxqsuktWpm6SvboahZVVo=;
 b=bfxGRLGRIvoC3A2DtvafoiVxI52Sac0XG2B/ungNOg5lyMd66aShH6xU2yt1pD+RYp
 Ei2uK8nj8f+nwdBnJSlweju22ql1WcVCTi772YaxhWXDEXGF0jxsoTR8wQwIUE0wBXlg
 oTotoj4p5jZv80IeyfebbK8Ahxh/hTSQYLZ0mzgpyoBrMduIbv/cSmkDQ+l7Pk+LX+rU
 F53yEX9KUWrJvaLAenBqkgYML6ClGJERA9W5ewZ+58vNJ8cTfnC9A76BWDiGZGVkODEv
 mAvGfzLUtSw485rOCUtIi8jIVD2ea/jTcINIaEWOx6q0cvGYDnZbaU0w9O3HzLFYCoK3
 PBgg==
X-Gm-Message-State: AOJu0YzbI3UcyBdmpgbDJs/oiKmvJcPjTguQi6fXzm3dtWZtEhfo4whs
 v325a5QdKor2Y0cqf2IoSRHTShgmeA+2P8hn297q44dW2PrUyYJ32niQ8hseSf0/CycrxPwys4L
 oELg=
X-Gm-Gg: ASbGncvJaVCPsHCYKhggzYeZPcM6ysjRV/5TMWpnhw1QX+d5Rc+qvAzRl/KFODWQY4/
 TEGttjlTdsclyR/3jAu90BG6geo8lRSTL/hWpTZBFP0mtYpZ7uC95fLT3eZE+ppAWbM/5UwtWwN
 c7rXknjf6HkYihm+0s2bPgDmaAEFM748EwTlqms9fQ9FN+Wpq0Lru2p393XxOY9gZnIafeq1OvA
 SxAvbpfqZzmjPI8A18NfP1udjOVfhAiCtnkEsfDdMKzMey+6r9NStcO2LDmoxJBS3V8hJHbYwEx
 zVNkW3C/62b2NQhZXgYHtEdR2Ztqmro=
X-Google-Smtp-Source: AGHT+IHREvfJbO+3EB/ltHN7W48TH4Jmq45Q3t7JjknFNFvrGoTr3w19zR22VJN359X7We3qoGGaWA==
X-Received: by 2002:a05:6000:4011:b0:386:3835:9fec with SMTP id
 ffacd0b85a97d-38a873306cemr11936213f8f.44.1736532284757; 
 Fri, 10 Jan 2025 10:04:44 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2ddcda3sm93762025e9.22.2025.01.10.10.04.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Jan 2025 10:04:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/rx/rx-gdbsim: Remove uses of &first_cpu
Date: Fri, 10 Jan 2025 19:04:42 +0100
Message-ID: <20250110180442.82687-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

rx_gdbsim_init() has access to the single CPU via:

  RxGdbSimMachineState {
    RX62NState {
      RXCPU cpu;
      ...
    } mcu;
  } s;

Directly use that instead of the &first_cpu global.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/rx/rx-gdbsim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/rx/rx-gdbsim.c b/hw/rx/rx-gdbsim.c
index 02fdbdf824b..88c8f12c101 100644
--- a/hw/rx/rx-gdbsim.c
+++ b/hw/rx/rx-gdbsim.c
@@ -127,7 +127,7 @@ static void rx_gdbsim_init(MachineState *machine)
          * the latter half of the SDRAM space.
          */
         kernel_offset = machine->ram_size / 2;
-        rx_load_image(RX_CPU(first_cpu), kernel_filename,
+        rx_load_image(&s->mcu.cpu, kernel_filename,
                       SDRAM_BASE + kernel_offset, kernel_offset);
         if (dtb_filename) {
             ram_addr_t dtb_offset;
@@ -153,7 +153,7 @@ static void rx_gdbsim_init(MachineState *machine)
             qemu_register_reset_nosnapshotload(qemu_fdt_randomize_seeds,
                                 rom_ptr(SDRAM_BASE + dtb_offset, dtb_size));
             /* Set dtb address to R1 */
-            RX_CPU(first_cpu)->env.regs[1] = SDRAM_BASE + dtb_offset;
+            s->mcu.cpu.env.regs[1] = SDRAM_BASE + dtb_offset;
         }
     }
 }
-- 
2.47.1


