Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D724C83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZ3Q-0005AV-I7; Tue, 15 Jul 2025 02:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZ21-0003an-Nq
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:21:01 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZ1z-0007UU-BA
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:20:49 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a4fb9c2436so3046744f8f.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 23:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752560445; x=1753165245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BIsVxfdtLnNina7X6rS10zd6t1LjrmBkXjEYQ2rhc7I=;
 b=uU/m+cNUlLlf+0qxjUrGSdgIXWb3MttdVhqf1MvJMdV4cn4nmvkb7y4fYBztYKiLjY
 xVNTDdePZn3UD7Z9TOsi7R50iDMwwljpwtiRA/1B01XOb2jdeAFz2GxtAwCPqFOn+5sC
 1JO/vZzpO5uhOFKF/BqVZyNbLkqmnP0mg3w7CvuSRokh9Kvxwf6TIrRQ/eJFGEtv5wRC
 qwdhK8KQsxA65+dUxMGvq4L6fLVglrWX/UKGtO78r2NXkPX0Az9u/MGzuqYYHu9Y5p12
 KUgnAdsTsiHs2lhLMyYGRFB9XklMpSLl7YkX0Rcl3s93pFu5qBTTiLe9FaInrOdmIn+o
 n1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752560445; x=1753165245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BIsVxfdtLnNina7X6rS10zd6t1LjrmBkXjEYQ2rhc7I=;
 b=OIACVnx2h9P2bQGcnII9oSxvLZbttEDJh1u+tajfJrX5ytjma0OVyw9qUzdJg9dpFz
 CqO87n39XzcCzaDzSGakZZO/7tQgQFoU+zLN0hBd2ztXpy0mSwcpuYbu8zVH+KMk5Qws
 DiEmDmZSeUmuWnKnDpOHNyiF1xftgB7ZYwiOUS51pPYjxYMcTFaijhHaEJeI9ZbrK1kN
 OnQKK1R/clmr6swv5ceryKdBxCgPbhJy4r8ItalrEK0/LqqsbyP/CgFoalO76GvqXQpo
 d5z5l6/nwsGv/fTDjEB1zoaCvQ2b2GiSWWju3dB6tf4CXwJpn/XArgw3DFUNWvvfXh7T
 YR0Q==
X-Gm-Message-State: AOJu0YxjPjn25e9Nv84f79wMjh1R3pUXNbs+ANaRu2FhgJTp04s+2WkH
 YrjH4xfKYJRfUYNPM569SslEZ0mF1s9l5UqxVAaYMm0Iyl7pBCrG6EYZAKsmjMOVhG1C49nfGQJ
 dnQNj
X-Gm-Gg: ASbGncueiyLgkez/oj/u/wkPxZ6Am8K8pBBJftZ83wDZMoob2Y2JSO/7mR3t2QFizMX
 m/kUdfSSyCj1En1sLyfLh4g8LfB7kqYc3HbM33qV+K5nVxmJcRNmfg7QCV7ANjO9FaluEHRbSL5
 lnvxxyuKd1oq+b413mjF6GHhFWSdvov675zmp4cCHedybC1oaSa+zFjK++fB+z5Qs1QcwRoC99r
 6Rz6pOLWzwovBpaUgpa/cjsCF458gBLMoSn5y7ls87umIAlqD87ipX+iAjXE5butVgLgmLegDek
 B4tzJ/nXymT88v18LiT+K2ySf4KQlIYKYoonPrxV8kxB6r4BC7sQqehiX4qyM5M3P5F2WsvUooG
 pijbVNJ1eXkuAD0uCKkMtHcq+oZYkuoUE18ifNB6y4G7wCnUFtIdmnOo9MB4TSqpOqNFw3HWz
X-Google-Smtp-Source: AGHT+IEFuks1Xz6P49FNSHJAROS6iMPU36yD3aASuS6vf1g13WxY3XRgVEt2QtDDuWvNfyewRwzfEg==
X-Received: by 2002:a05:6000:42c1:b0:3a5:7991:ff6 with SMTP id
 ffacd0b85a97d-3b5f187b268mr9374758f8f.1.1752560444747; 
 Mon, 14 Jul 2025 23:20:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e1e1a5sm14004594f8f.74.2025.07.14.23.20.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 14 Jul 2025 23:20:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PULL 17/17] esp.c: only allow ESP commands permitted in the current
 asc_mode
Date: Tue, 15 Jul 2025 08:19:17 +0200
Message-ID: <20250715061918.44971-18-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715061918.44971-1-philmd@linaro.org>
References: <20250715061918.44971-1-philmd@linaro.org>
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

If an ESP command is issued in an incorrect mode then an illegal command
interrupt should be generated. Add a new esp_cmd_is_valid() function to
indicate whether the ESP command is valid for the current mode, and if not
then raise the illegal command interrupt.

This fixes WinNT MIPS which issues ICCS after a Chip Reset which is not
permitted, but will fail with an INACCESSIBLE_BOOT_DEVICE error unless an
interrupt is generated.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Fixes: 83428f7a97 ("esp.c: move write_response() non-DMA logic to esp_do_nodma()")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2464
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250711204636.542964-8-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/scsi/esp.h |  8 ++++++++
 hw/scsi/esp.c         | 37 +++++++++++++++++++++++++++++++++++++
 hw/scsi/trace-events  |  1 +
 3 files changed, 46 insertions(+)

diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
index 6327060c7c7..3526bad7464 100644
--- a/include/hw/scsi/esp.h
+++ b/include/hw/scsi/esp.h
@@ -111,6 +111,13 @@ struct SysBusESPState {
 #define CMD_DMA 0x80
 #define CMD_CMD 0x7f
 
+#define CMD_GRP_MASK 0x70
+
+#define CMD_GRP_MISC 0x00
+#define CMD_GRP_INIT 0x01
+#define CMD_GRP_TRGT 0x02
+#define CMD_GRP_DISC 0x04
+
 #define CMD_NOP      0x00
 #define CMD_FLUSH    0x01
 #define CMD_RESET    0x02
@@ -145,6 +152,7 @@ struct SysBusESPState {
 #define INTR_FC 0x08
 #define INTR_BS 0x10
 #define INTR_DC 0x20
+#define INTR_IL 0x40
 #define INTR_RST 0x80
 
 #define SEQ_0 0x0
diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 4aa58f9e485..1d264c40e57 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -1129,6 +1129,38 @@ static void parent_esp_reset(ESPState *s, int irq, int level)
     }
 }
 
+static bool esp_cmd_is_valid(ESPState *s, uint8_t cmd)
+{
+    uint8_t cmd_group = (cmd & CMD_GRP_MASK) >> 4;
+
+    /* Always allow misc commands */
+    if (cmd_group == CMD_GRP_MISC) {
+        return true;
+    }
+
+    switch (s->asc_mode) {
+    case ESP_ASC_MODE_DIS:
+        /* Disconnected mode: only allow disconnected commands */
+        if (cmd_group == CMD_GRP_DISC) {
+            return true;
+        }
+        break;
+
+    case ESP_ASC_MODE_INI:
+        /* Initiator mode: allow initiator commands */
+        if (cmd_group == CMD_GRP_INIT) {
+            return true;
+        }
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+
+    trace_esp_invalid_cmd(cmd, s->asc_mode);
+    return false;
+}
+
 static void esp_run_cmd(ESPState *s)
 {
     uint8_t cmd = s->rregs[ESP_CMD];
@@ -1285,6 +1317,11 @@ void esp_reg_write(ESPState *s, uint32_t saddr, uint64_t val)
         break;
     case ESP_CMD:
         s->rregs[saddr] = val;
+        if (!esp_cmd_is_valid(s, s->rregs[saddr])) {
+            s->rregs[ESP_RSTAT] |= INTR_IL;
+            esp_raise_irq(s);
+            break;
+        }
         esp_run_cmd(s);
         break;
     case ESP_WBUSID ... ESP_WSYNO:
diff --git a/hw/scsi/trace-events b/hw/scsi/trace-events
index f0f2a98c2ee..6c2788e2026 100644
--- a/hw/scsi/trace-events
+++ b/hw/scsi/trace-events
@@ -198,6 +198,7 @@ esp_mem_writeb_cmd_ensel(uint32_t val) "Enable selection (0x%2.2x)"
 esp_mem_writeb_cmd_dissel(uint32_t val) "Disable selection (0x%2.2x)"
 esp_mem_writeb_cmd_ti(uint32_t val) "Transfer Information (0x%2.2x)"
 esp_set_phase(const char *phase) "setting bus phase to %s"
+esp_invalid_cmd(uint8_t cmd, uint8_t asc_mode) "command 0x%x asc_mode 0x%x"
 
 # esp-pci.c
 esp_pci_error_invalid_dma_direction(void) "invalid DMA transfer direction"
-- 
2.49.0


