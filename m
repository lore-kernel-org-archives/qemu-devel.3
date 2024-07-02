Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE8FC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZi7-0001Bf-5H; Tue, 02 Jul 2024 05:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZi3-0001B8-4e
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:21:59 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZhs-0006Rv-Qv
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:21:58 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3626c29d3f0so2001288f8f.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912106; x=1720516906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VFi1L5rHZo7v36UetRUIEpZ+be6zBjT18RH5cfq/7Gg=;
 b=c04R2OBLwAdRAp7Nu2BSr46oWCvvpqAK+LMr4dgjMbXGFmj6UtsqdokCA+h12EP8Ft
 5p7x0iMAhjaFe3WJpdVqI3cC7pFi8s3YcrLsDkEIqK61ok12yGMxZZcfphc/EYyUopSa
 cvLrORWx/5t01x2wzfWAM9t++wNUllM76BA6gI3jjai98HbP81XQKwehe35ddLc/Fmdy
 YkOOkL+7rNPkU6MLIW7KRlDKq4wRBS8Ub6lefVXKpXE+7SqdWKkV+Mqv7HmQ8REQexHK
 GO2u32lY3/DkDebEPAs+Vp268Knadj7CsXfIjxMWEH+CQTrvwlvm5QcKZxIEixGGzRwi
 9EkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912106; x=1720516906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VFi1L5rHZo7v36UetRUIEpZ+be6zBjT18RH5cfq/7Gg=;
 b=q2Q00cghyY9VgcV914DBMtIHUyjG3Sx2CiFguSl+txirczVkMa//rj87oXR36bQBI3
 azu0xyM0j4cCyAXpVRD4SI8+ihr1BeHl2kSL8YN3TVeJGcd3e437CNwYNmQhbvZSgzly
 xwx2HixS3AMd8eVg3oaHs35qeYZ7c3oLjC7jHTlMt6BwuGPrw9WxiV8KMWGHF4ACg5N5
 4UJQWSKC4Zfak5j/UnwGceOHt8IIVCCr360knPXuQS/SnpPQVytPo0qeOLNk9b1i9GGE
 cZY1trTSAybLwz3i6IrbSOP35pyMB7LizhC9JvvjWpUjUEgbC7h1XL+ooA5K8TW18Hqu
 3PZQ==
X-Gm-Message-State: AOJu0YxZyD6GV9wrtGaQAuqzB8pqkBapv5xH8lgSa2NgiPq8JDm4khPW
 oMMnsBl5KmhSdcDOx8REuCr0a9o7ZQzD/bc7SfxiIKB9Lv/I9bhOrfK2SQHPnIOnme9IFl7LSr2
 E
X-Google-Smtp-Source: AGHT+IEjxuGo1JugIYNt9Bdp0vjfFoKrw5zuqh/q78SNC2KYw6irvDg96k7GUTKIOea8ekxX2syeBQ==
X-Received: by 2002:a5d:4043:0:b0:366:f8c3:ddcb with SMTP id
 ffacd0b85a97d-36775725c6emr5347764f8f.52.1719912106566; 
 Tue, 02 Jul 2024 02:21:46 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0fba2dsm12653980f8f.73.2024.07.02.02.21.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:21:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 09/67] hw/sd/sdcard: Assign SDCardStates enum values
Date: Tue,  2 Jul 2024 11:19:52 +0200
Message-ID: <20240702092051.45754-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

SDCardStates enum values are specified, so assign them
correspondingly. It will be useful later when we add
states from later specs, which might not be continuous.

See CURRENT_STATE bits in section 4.10.1 "Card Status".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-11-philmd@linaro.org>
---
 hw/sd/sd.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 04ca895645..824cb47856 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -75,16 +75,16 @@ enum SDCardModes {
 };
 
 enum SDCardStates {
-    sd_inactive_state = -1,
-    sd_idle_state = 0,
-    sd_ready_state,
-    sd_identification_state,
-    sd_standby_state,
-    sd_transfer_state,
-    sd_sendingdata_state,
-    sd_receivingdata_state,
-    sd_programming_state,
-    sd_disconnect_state,
+    sd_inactive_state       = -1,
+    sd_idle_state           = 0,
+    sd_ready_state          = 1,
+    sd_identification_state = 2,
+    sd_standby_state        = 3,
+    sd_transfer_state       = 4,
+    sd_sendingdata_state    = 5,
+    sd_receivingdata_state  = 6,
+    sd_programming_state    = 7,
+    sd_disconnect_state     = 8,
 };
 
 typedef sd_rsp_type_t (*sd_cmd_handler)(SDState *sd, SDRequest req);
-- 
2.41.0


