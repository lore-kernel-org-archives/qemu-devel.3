Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52999C3600C
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 17:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twPGe-0005uk-GR; Sun, 23 Mar 2025 13:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPGc-0005ta-Qx
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:37:46 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPGb-0002w3-7r
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:37:46 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22409077c06so60882545ad.1
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 10:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742751464; x=1743356264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rl2kD2O4NtHjGm3/OP8N2dKmDeEtJGe1Kf/Hel8K6aw=;
 b=DSiA1fHFe2m32Or6pjagtGcC0Z8NJBTef6QxcqMFGIvYOdOXRmhd9P++30KP72TE5e
 I79/5mLO0dKp+hEPuhVG/VAGY4eY7eRfBTmDB81G00cH/06ZcOoJeYSG89x4otEM5c7s
 wvQp1Aj0WgTw+xau4VmsXVwdqxIfg0kufX6vJCYD36iulPXd/kXv1mM+0+JadcLf0ZdT
 k0vl3wJp3mqtGEk2UPKrvxM9/yWaUYugpvAmw3492Iq8v4K+u+o5Zcrgf/b8I9l2qoBw
 Gm/47pJt9C6y2CMBZXpsfL9c85isp5BxclhpkEDKTw/FW/87zKTKu/TcsYJjJI5zFo0u
 1cJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742751464; x=1743356264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rl2kD2O4NtHjGm3/OP8N2dKmDeEtJGe1Kf/Hel8K6aw=;
 b=UIxhruPe45LRZdERchK/YIqJh4HO7KoP3fr3HMMVXa3VLQZGj3f0V+0cdVDtX1+OW+
 si92wA5sREqDezf33KSPSylMqErq/Y+l1AwZsiWuNYA/BlkveWKiUoVjmyUiH8ZdJ58f
 nCkEiJWntD7nqEOMntITD4NhqaOX5xvErmtI8I2SAV/7BPkvut6XO6J8eeqAlyqWspfh
 pi3DxWl6n8UC7HG+heg5T4ebd6vnijeC+5BtrSRa5v7KsixFQxJmn6iJ1zLiZT3LmhlY
 6nTee2viGiYAbj3heZRpv5kxNisc25KsGyD/WheAPHXkzW40GlFQnvCyLGJbpg1RmQRn
 28IA==
X-Gm-Message-State: AOJu0YyeZUon9X560zUd7qy7u81Wx0ZtcB+gP4gkUea8dMW5cmC92z28
 KRRVGEfJ2yGXfKtVyEKiv0D3MUei9sULxQ339gK3YXtLv/upvSjlpFbwfHAg5RLX9GcEISDS/p6
 j
X-Gm-Gg: ASbGncvPo3qNYi5VizWpbE5E3H/lehHG2ESf3fLzS0qzj2RaKFJhZRcpWHMu+GvSIZf
 pjThHXg+V12yxuG3qM+mXCXcaRtivjDpYo6es2rXtCgvEwTWPcdi8bqbCOKrO4vlVZkV9EyAuVe
 OdDK5XptfFFZRQa2SbfFUtf4DKmrNBcE6f0G8wgDWAPLlzAdmIRhK6Cs79a5QKKxKCx4LsaWQRz
 GGn1Z1VQIGQWHhem0qyTOH31NLjPZeP6tuuOGDGq7cRIc8njx4Ne4sndOXTYg36vK5S7boevKlW
 oll0OklW59CW4ugw2kumwEIlD14Jxrzh3ieewLQ1/3+Mr/XZOfu/OtO9ahMnokfhrZzwwkUyyxY
 k
X-Google-Smtp-Source: AGHT+IFeRguYbLILc3ysomuYg5SndYOwzWvk2ZNfuBJA6KGRZSqYrpgfITlld42jb9zF4iKtyH1u9Q==
X-Received: by 2002:a17:902:d549:b0:224:a96:e39 with SMTP id
 d9443c01a7336-22780c55343mr171016455ad.9.1742751463887; 
 Sun, 23 Mar 2025 10:37:43 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22781209ff3sm54075165ad.257.2025.03.23.10.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Mar 2025 10:37:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mrolnik@gmail.com,
	philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH 17/17] target/avr: Enable TARGET_PAGE_BITS_VARY
Date: Sun, 23 Mar 2025 10:37:29 -0700
Message-ID: <20250323173730.3213964-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250323173730.3213964-1-richard.henderson@linaro.org>
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Increase TARGET_PHYS_ADDR_SPACE_BITS to allow flexibility in the page
size without triggering an assert.  Select the page size based on the
size of sram.  This leaves sram on exactly one page and minimizes the
number of pages required to span the flash.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/cpu-param.h | 11 +++++++++--
 hw/avr/arduino.c       | 15 +++++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h
index f5248ce9e7..a18bf39bb9 100644
--- a/target/avr/cpu-param.h
+++ b/target/avr/cpu-param.h
@@ -21,8 +21,15 @@
 #ifndef AVR_CPU_PARAM_H
 #define AVR_CPU_PARAM_H
 
-#define TARGET_PAGE_BITS 10
-#define TARGET_PHYS_ADDR_SPACE_BITS 24
+#define TARGET_PAGE_BITS_VARY
+#define TARGET_PAGE_BITS_MIN 10
+
+/*
+ * The real value for TARGET_PHYS_ADDR_SPACE_BITS is 24, but selecting
+ * an overly small value will assert in tb-maint.c when selecting the
+ * shape of the page_table tree.  This allows an 8k page size.
+ */
+#define TARGET_PHYS_ADDR_SPACE_BITS 28
 #define TARGET_VIRT_ADDR_SPACE_BITS 24
 
 #define TCG_GUEST_DEFAULT_MO 0
diff --git a/hw/avr/arduino.c b/hw/avr/arduino.c
index 29cb776848..f309aa5597 100644
--- a/hw/avr/arduino.c
+++ b/hw/avr/arduino.c
@@ -71,9 +71,24 @@ static void arduino_machine_class_init(ObjectClass *oc, void *data)
 
 static void arduino_machine_class_base_init(ObjectClass *oc, void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
     ArduinoMachineClass *amc = ARDUINO_MACHINE_CLASS(oc);
+    AtmegaMcuClass *acc;
+    int page_bits;
 
     amc->mcu_type = data;
+
+    /* Find the mcu class that we will instantiate. */
+    acc = ATMEGA_MCU_CLASS(object_class_by_name(amc->mcu_type));
+
+    /*
+     * Select a page size based on the size of sram.
+     * This will result in a page size between 1k and 8k
+     * and minimize the number of pages to span flash.
+     */
+    page_bits = ctz32(acc->sram_size);
+    assert(page_bits >= TARGET_PAGE_BITS_MIN && page_bits <= 13);
+    mc->minimum_page_bits = page_bits;
 }
 
 static void arduino_duemilanove_class_init(ObjectClass *oc, void *data)
-- 
2.43.0


