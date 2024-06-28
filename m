Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E672C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5dz-0000cp-G0; Fri, 28 Jun 2024 03:03:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5do-0000WZ-Bc
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:03:28 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5dk-0006jj-95
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:03:28 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4256aee6d4fso2160365e9.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558202; x=1720163002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hpSfmrc8id/iTbpDVauIfBux1xBlvB+2LTLQjc6fyJc=;
 b=umBIWf2q3tgEATs1LnzunEnL0/wpkT8aeFxGBI5LEMthZG7qHnmjIBNYraGlqQRVg4
 dCGESMzQfw36wQT7ktIbEfiiOoRzcPob2NkUHRXWKTmhcgVMl3Cx577n5Ae0CBMmGDum
 e6wmI2qckNFTsiZFiVtI1gvHFI9ik33e9moXouYZJ9vIxRp/qOcAJ+LjpnCsqfJlQ55o
 pVha9VAt/Nm5fpMGOpVO2HOaFAYKQWRn1hnEhtjQT7/v2ywOu1qonM1bIhhQle4bEWyD
 vBlseFjt95efKdBPjQbehfK7knYN6j2+Go0E+KoL77NwB7TdQdhSaKoSszinl6Y0vyZQ
 3SQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558202; x=1720163002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hpSfmrc8id/iTbpDVauIfBux1xBlvB+2LTLQjc6fyJc=;
 b=OnN0akbeJXiUemdG/8vFggUM11tVGYbqhucgQuHwFb4SRb1l8BmONra/fyHUhnPkJy
 0phLO6erA/neNVCkw8eUsSHl7GzmYeWGvkwsguTrLHD58VvnmxZRt2gKP4zJWUrax9oN
 WBMEbmUu3E58fQOJX0M0CVqKcIIn7KX4ilYflIG0rNhpnJjzPemLNp0EkemIPbKjQmRE
 guPubyqDldL9XUKsIgnOVXnybGyUTcW3TDn7+YQJmU9IZc19uqQBHuT3ipAhExWB5AYS
 Kf9ddvZPq4wwWzNZ46UP1db6Mm9qZFZ1lfHJTRx+2QFp931+z2hvOLPCwnoD3/FulZAR
 ztzA==
X-Gm-Message-State: AOJu0Yw9uzddKwre3C2emGESSNxy0PP773EwkvKG6EX+VXYuGyz6AVI0
 +85w88YWaxmlEYmapz4LJocpw5w6s34VuBJUKJvyAVlr00+bG8fM5jxHR1+WwmlIrbjBRYdcRBr
 X3rA=
X-Google-Smtp-Source: AGHT+IFoWWmS78Hm8t6hoZuy+QIGB5HGYibZQrDFx5AVs0oqBPffLkMO79admTqqXUduOp0o+OysNg==
X-Received: by 2002:a05:600c:5816:b0:41a:c86e:a4db with SMTP id
 5b1f17b1804b1-4248cc2b729mr98474885e9.9.1719558202491; 
 Fri, 28 Jun 2024 00:03:22 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b061006sm21174525e9.22.2024.06.28.00.03.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:03:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 12/98] hw/sd/sdcard: Restrict SWITCH_FUNCTION to
 sd_transfer_state (CMD6)
Date: Fri, 28 Jun 2024 09:00:48 +0200
Message-ID: <20240628070216.92609-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

SWITCH_FUNCTION is only allowed in TRANSFER state
(See 4.8 "Card State Transition Table).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
---
 hw/sd/sd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 7533a78cf6..8f441e418c 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1205,6 +1205,10 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         if (sd->mode != sd_data_transfer_mode) {
             return sd_invalid_mode_for_cmd(sd, req);
         }
+        if (sd->state != sd_transfer_state) {
+            return sd_invalid_state_for_cmd(sd, req);
+        }
+
         sd_function_switch(sd, req.arg);
         sd->state = sd_sendingdata_state;
         sd->data_start = 0;
-- 
2.41.0


