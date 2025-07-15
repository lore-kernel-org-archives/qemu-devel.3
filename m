Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD97C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:27:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZ2s-0004BL-CD; Tue, 15 Jul 2025 02:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZ21-0003aT-Gr
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:21:01 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZ1w-0007TA-GY
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:20:49 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a528243636so2737483f8f.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 23:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752560440; x=1753165240; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W2AWFB5Pyqah58zjvyeLVbkHACcax2vJ0ewRGYfkQd8=;
 b=TukdXiaMJY4RBPOxrm54+aFfT39csaxfEQnjepRKYLOjvFvlg5jURFMwQzuxg99a7V
 qPTGlPj67AsozNIKEuwnFkuPNs0XhZ3MQxA+Dc347h67yAyfC7ansWi/R9rqbOKTlCEi
 O15bHvEQ2N0hRmxD0ChTpPMbkduhy6NKRwHuXkjXUhuVtzOhntD9D4rqEQfBNIQPyAkq
 8SHbJEt4UJTOZT/rKwSzRMQ40UZ8sZZggRCBehGy+LqDnrk/9CUBCpAEBSfii/ecm/t0
 udViYdLrUZ5wIV0B8QTwVrydUkppnF7PFzFeMgSE9cYXaU8dQVS92nqeAzBvu1Eg+f7B
 0f2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752560440; x=1753165240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W2AWFB5Pyqah58zjvyeLVbkHACcax2vJ0ewRGYfkQd8=;
 b=QYEqptSlcmrZdsftXPhsPFEnsfV0TX79PhR2Litz8oe3IxDHs8rFnRNiRqYRezqjM3
 eGbtgCx0azfEDo1SiJMJUeodUtCuCuCrTacGMp6VUwUksuM0PM/yR62I6Bqnk3nbuS4k
 bnvYWGsAv8Dx8jhZGQTvJpRLk9OR240iXlFVzoilQ/uCXmLgTPLBSChhYJnJwmma6tkz
 07iA+O5ccnEJil6cXkcum3mEXSgdMoosit+mTXI8s9bplBgNThRfIWHy+X91c03VaBJE
 zceLJMRGYv49KJWgnItcDzZlHsxVvitdmj1lytLm8X1csa+6WY3Hpc//BweYT8Jnm3V3
 NLHg==
X-Gm-Message-State: AOJu0YyUoPqt6mLzTRH4YtaQTqvNfTI0afmN/XRUzMLCQY5FGERTI5j4
 +I8fvdrjIvya+67YMbWAdncTEgodRJko6L3Vppo2DK0snMcuV6A3Bryb45cGp820WnRplESUuJ6
 dIaVL
X-Gm-Gg: ASbGncvZnC9mciTnvHLKZ+FC4o1OvWchaLdHXISt7JamTw3q8CNtLRciTyeHZoxi8VM
 qgjZIRgBrkUtiJbLNAoOW4LZs6o5Qvl+On1qX17WYLfc4rVRFPZVdwJv77s/P0qgDvnJNiW5THZ
 Jq+yrgwbkasLC8iN0Od5+5CqRTtnMjYiF5NJYy3gQG/BQLIIZIDZ8d4f7AoudR6E33g5l7WCnzL
 /1LPV6ssVtCueQS5daMdeVqrdrL//u9nmQ/1hTYbpEUml2vEZhbFUDN4+oLPUUph+nvtLpphqzX
 4Om3NfZ8wYN2hR9XqG6jBft18ohVcWF6u76B5SadGFxfwozs+axm5KZDdej+z+r23JRAT2o2wta
 791MUgsHHENeINlMCs7VW5Z9ifV24FF7V/BwprKtVPxCKaJPSwLShJgYboI1U7tIB8szISTVeSr
 F5Fsvlufg=
X-Google-Smtp-Source: AGHT+IH2njBaVNZQOwFvE3Wq0RqZ+qCbBD9uRBscHqX9O9Z7FHe7Bx/nXB7qRK/pRO4kV/VqEU5b4g==
X-Received: by 2002:adf:ea45:0:b0:3a8:38b3:1aa1 with SMTP id
 ffacd0b85a97d-3b5f18cf218mr10693915f8f.27.1752560439711; 
 Mon, 14 Jul 2025 23:20:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc2025sm14502765f8f.31.2025.07.14.23.20.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 14 Jul 2025 23:20:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PULL 16/17] esp.c: add asc_mode property to indicate the current ESP
 mode
Date: Tue, 15 Jul 2025 08:19:16 +0200
Message-ID: <20250715061918.44971-17-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715061918.44971-1-philmd@linaro.org>
References: <20250715061918.44971-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Add a new asc_mode property to ESPState which indicates the current mode of
the ESP and update the ESP state machine accordingly.

Bump the vmstate version and include migration logic to ensure that asc_mode
is set to initiator mode such that any commands in progress will always
continue.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250711204636.542964-7-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/scsi/esp.h |  7 +++++++
 hw/scsi/esp.c         | 21 ++++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
index c9afcb7cac0..6327060c7c7 100644
--- a/include/hw/scsi/esp.h
+++ b/include/hw/scsi/esp.h
@@ -14,6 +14,12 @@ typedef void (*ESPDMAMemoryReadWriteFunc)(void *opaque, uint8_t *buf, int len);
 #define ESP_FIFO_SZ 16
 #define ESP_CMDFIFO_SZ 32
 
+enum ESPASCMode {
+    ESP_ASC_MODE_DIS = 0,    /* Disconnected */
+    ESP_ASC_MODE_INI = 1,    /* Initiator */
+    ESP_ASC_MODE_TGT = 2     /* Target */
+};
+
 #define TYPE_ESP "esp"
 OBJECT_DECLARE_SIMPLE_TYPE(ESPState, ESP)
 
@@ -38,6 +44,7 @@ struct ESPState {
     uint8_t cmdfifo_cdb_offset;
     uint8_t lun;
     uint32_t do_cmd;
+    uint8_t asc_mode;
 
     bool data_ready;
     int dma_enabled;
diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 1c7bad8fc02..4aa58f9e485 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -275,6 +275,7 @@ static int esp_select(ESPState *s)
     if (!s->current_dev) {
         /* No such drive */
         s->rregs[ESP_RSTAT] = 0;
+        s->asc_mode = ESP_ASC_MODE_DIS;
         s->rregs[ESP_RINTR] = INTR_DC;
         esp_raise_irq(s);
         return -1;
@@ -284,6 +285,7 @@ static int esp_select(ESPState *s)
      * Note that we deliberately don't raise the IRQ here: this will be done
      * either in esp_transfer_data() or esp_command_complete()
      */
+    s->asc_mode = ESP_ASC_MODE_INI;
     return 0;
 }
 
@@ -308,6 +310,7 @@ static void do_command_phase(ESPState *s)
     if (!current_lun) {
         /* No such drive */
         s->rregs[ESP_RSTAT] = 0;
+        s->asc_mode = ESP_ASC_MODE_DIS;
         s->rregs[ESP_RINTR] = INTR_DC;
         s->rregs[ESP_RSEQ] = SEQ_0;
         esp_raise_irq(s);
@@ -1102,6 +1105,7 @@ void esp_hard_reset(ESPState *s)
     fifo8_reset(&s->cmdfifo);
     s->dma = 0;
     s->dma_cb = NULL;
+    s->asc_mode = ESP_ASC_MODE_DIS;
 
     s->rregs[ESP_CFG1] = 7;
 }
@@ -1170,6 +1174,7 @@ static void esp_run_cmd(ESPState *s)
         break;
     case CMD_MSGACC:
         trace_esp_mem_writeb_cmd_msgacc(cmd);
+        s->asc_mode = ESP_ASC_MODE_DIS;
         s->rregs[ESP_RINTR] |= INTR_DC;
         s->rregs[ESP_RSEQ] = 0;
         s->rregs[ESP_RFLAGS] = 0;
@@ -1337,6 +1342,14 @@ static bool esp_is_between_version_5_and_6(void *opaque, int version_id)
     return version_id >= 5 && version_id <= 6;
 }
 
+static bool esp_is_version_8(void *opaque, int version_id)
+{
+    ESPState *s = ESP(opaque);
+
+    version_id = MIN(version_id, s->mig_version_id);
+    return version_id >= 8;
+}
+
 int esp_pre_save(void *opaque)
 {
     ESPState *s = ESP(object_resolve_path_component(
@@ -1368,13 +1381,18 @@ static int esp_post_load(void *opaque, int version_id)
         }
     }
 
+    if (version_id < 8) {
+        /* Assume initiator mode to allow all commands to continue */
+        s->asc_mode = ESP_ASC_MODE_INI;
+    }
+
     s->mig_version_id = vmstate_esp.version_id;
     return 0;
 }
 
 const VMStateDescription vmstate_esp = {
     .name = "esp",
-    .version_id = 7,
+    .version_id = 8,
     .minimum_version_id = 3,
     .post_load = esp_post_load,
     .fields = (const VMStateField[]) {
@@ -1406,6 +1424,7 @@ const VMStateDescription vmstate_esp = {
                            esp_is_between_version_5_and_6),
         VMSTATE_UINT8_TEST(lun, ESPState, esp_is_version_6),
         VMSTATE_BOOL(drq_state, ESPState),
+        VMSTATE_UINT8_TEST(asc_mode, ESPState, esp_is_version_8),
         VMSTATE_END_OF_LIST()
     },
 };
-- 
2.49.0


