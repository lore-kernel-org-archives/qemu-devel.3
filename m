Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A2DFC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 15:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRCkX-0008Kv-Mz; Tue, 09 Jul 2024 11:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRCkW-00086K-DP
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:27:24 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRCkU-0006P5-Jl
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:27:24 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-52e9c55febcso6912840e87.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 08:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720538840; x=1721143640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PiXvczI/K3L/YAxv9emlFnk584vxqItosgTLQuNQXtQ=;
 b=pH3AEk9+8CnSYWfSBZbiBgmEJcvi5aWFN8nrFWu6D86kbWrDIxBHb9lUGqp88x/aYn
 4ZlnIO2v8ZgXil08ppfuXWHcUy56j9rcznUs8JPU22BhQ0iOXZWOcwWqh48uYX3KxxmJ
 iXU95s9/UXsdIp091jewSPF/tiETWTxS52WC74Sp4xzwzqgPDJgBVjKRLsOX6TmF6Xvx
 DSW84vErpXK+DA0RfCcwz1WqnW0C4LjXOOW6JLT3Vo9Ck08mWNn8LlKSf59icCQA8Rg2
 Y0pvYt0UnEUE4LFRcAVVTtPH1rtM/41vx1RV4ei+GUA2BTWIh6ppbbwWMyfieePDncAr
 pCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720538840; x=1721143640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PiXvczI/K3L/YAxv9emlFnk584vxqItosgTLQuNQXtQ=;
 b=k/41gYokfg1aZu4n8MuRxGC1xBWBKvbnTFJeQ1UYnGJAYAj9BiE1J9N+OTnG/ReMtU
 1SDCenijNMyHhSe+As5GrXPZZfIrdUtxsHw8W0KEzPxtx4AKkcG6sjmkfSbVIy+KrQBh
 eJa+e7oI494RlqJp/CuEV7v4OnnQWlhJeUk3TGiVH9xj/xRtwztAdK9Ry5xrWOTi7juT
 C/e7Xa2SbeCcj5bp27RSBzsSypGhgwQy3eTxuWyFleRVagk0RVuLznsylfDT/j3b3S9D
 IXcGMt9VUteuwQ8NK5v//Pu6JnbI86bym8z+SVw0Ok4B/v/r04LNdn1bJvlQrN4RLMMp
 AllA==
X-Gm-Message-State: AOJu0YwTWpXSYup/j5VeHWcwREK2MwZ0KPLGXKy1Y1SePB5dZWQwJ31c
 CWjiinfWXlMahh3jdUzyzxr2NrA7ruvYOTyMO/5rbe/1mQIj/pVXjRdKN2P6AtNG5KhsspJar4n
 2
X-Google-Smtp-Source: AGHT+IGL/hxzWfwOfRUWPxdmzagBKrxxcTV8xkdMaNMx2n0tsclI/8N91+Hhzc0RRI7zlDIlJIYfng==
X-Received: by 2002:a19:f80d:0:b0:52e:97dc:f5c4 with SMTP id
 2adb3069b0e04-52eb999b36cmr1551519e87.25.1720538840211; 
 Tue, 09 Jul 2024 08:27:20 -0700 (PDT)
Received: from m1x-phil.lan (vau06-h02-176-184-43-20.dsl.sta.abo.bbox.fr.
 [176.184.43.20]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427270238a6sm12811475e9.20.2024.07.09.08.27.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Jul 2024 08:27:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Bin Meng <bmeng.cn@gmail.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>
Subject: [PATCH v47 13/19] hw/sd/sdcard: Migrate ExtCSD 'modes' register
Date: Tue,  9 Jul 2024 17:25:50 +0200
Message-ID: <20240709152556.52896-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240709152556.52896-1-philmd@linaro.org>
References: <20240709152556.52896-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
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

Spec v4.3, chapter 8.4 "Extended CSD register":

  The Extended CSD register defines the card properties
  and selected modes. It is 512 bytes long. The most
  significant 320 bytes are the Properties segment, which
  defines the card capabilities and cannot be modified by
  the host. The lower 192 bytes are the Modes segment,
  which defines the configuration the card is working in.

Only migrate the Modes segment (192 lower bytes).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 2a687977d1..a391f12b2a 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -124,7 +124,13 @@ struct SDState {
     uint16_t rca;
     uint32_t card_status;
     uint8_t sd_status[64];
-    uint8_t ext_csd[512];
+    union {
+        uint8_t ext_csd[512];
+        struct {
+            uint8_t ext_csd_rw[192]; /* Modes segment */
+            uint8_t ext_csd_ro[320]; /* Properties segment */
+        };
+    };
 
     /* Static properties */
 
@@ -881,6 +887,24 @@ static const VMStateDescription sd_ocr_vmstate = {
     },
 };
 
+static bool vmstate_needed_for_emmc(void *opaque)
+{
+    SDState *sd = opaque;
+
+    return sd_is_emmc(sd);
+}
+
+static const VMStateDescription emmc_extcsd_vmstate = {
+    .name = "sd-card/ext_csd_modes-state",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = vmstate_needed_for_emmc,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8_ARRAY(ext_csd_rw, SDState, 192),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static int sd_vmstate_pre_load(void *opaque)
 {
     SDState *sd = opaque;
@@ -928,6 +952,7 @@ static const VMStateDescription sd_vmstate = {
     },
     .subsections = (const VMStateDescription * const []) {
         &sd_ocr_vmstate,
+        &emmc_extcsd_vmstate,
         NULL
     },
 };
-- 
2.41.0


