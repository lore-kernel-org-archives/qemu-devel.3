Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD35C2BB85
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 08:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKZJg-0002fa-L7; Fri, 21 Jun 2024 04:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZJc-0002Uj-I8
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:08:12 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZJb-0000Dt-3y
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:08:12 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-421cd1e5f93so12982905e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 01:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718957289; x=1719562089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pelbEr2AzQbex87Y1dyscTbX85voHzWIx5qB/yXa5yg=;
 b=HoI9SVXLrXqy/wsEWAsCjfeEi8Mm6jg7UtizbH1gFOElN05aQadxmeP9MohJQ4tmUi
 2k6XyHYoM6jroj1aUmL1E65aDp/4kGKTAO6IRKTGbFddY93DSu4FF3JwlM8TeExU18EC
 RQpT/EcwlISDbyhkOUC7FOH/R67K0sxDj8S/qgYkzsKNwXVmr2xDJHNTgyCEUkw9CAHe
 /rDOoxGsFKTHGBDy4FvODt1RKj0hVf0cCORK+59EB9LcqkYe+4sK89mdUKYnoz/sCd1X
 AfKlqmG5jTO3pI8HQ6T09O9pJQcpmC1kecCMVSaVrM4EpSfbTBvvcM4nU7nsRiROHMkT
 QI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718957289; x=1719562089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pelbEr2AzQbex87Y1dyscTbX85voHzWIx5qB/yXa5yg=;
 b=WK62jEG5qVW3sgv+paGoQoQGBWyJbcuNdnCMZx24kKY0Xf8E5dMyOhQsB7iLvEbmTU
 z9skXTFTVk92kAMqX/iS7Je61LFN05pfoSOUjD6qX+38u88XhneatnTr7V6PIKr2PCt6
 BT4RrP4MJl1UMNSehm0Cu+Ge3u6d6X76MG8+nBu2S//7kZjWzyDSL1BENEGZE6X38I/x
 jpbndMZNMVqMO9I0AosV8DVLFv+CvNpIF+QUnmYn9R4jZjfdi18s8WJDPfSPfLtVesfW
 r1TI3EPUJSuRDvuus9Fj1YKD8edufCSAMPEuh8SdFauuDbI29BswTpkDBoUyUHWsGfJh
 erMw==
X-Gm-Message-State: AOJu0Ywi3h/xGTwUqLDblrZR9Nv8g5W8n3Jc4xiq+/uWsP6E2Fs1xEVd
 Z2HbxZnpfaN4gBEp79qA8XD5fXcsji3W9kLLFmBpEmlh5IN0VGT9a/KemOd+NakYiRgmB4Ygos0
 s
X-Google-Smtp-Source: AGHT+IE9NLCoFogMKxc41GruYUxJ/LnariP6TkJrVPG/jMTYiOqYH3UqAB2Qb2WyuhEtZ1ims+LMBw==
X-Received: by 2002:a05:600c:2e07:b0:421:ec3b:b7f0 with SMTP id
 5b1f17b1804b1-424751854f8mr58514115e9.17.1718957289523; 
 Fri, 21 Jun 2024 01:08:09 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.128.209])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4248191c65asm16705925e9.40.2024.06.21.01.08.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Jun 2024 01:08:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 22/23] hw/sd/sdcard: Send WRITE_PROT bits MSB first (CMD30)
Date: Fri, 21 Jun 2024 10:05:53 +0200
Message-ID: <20240621080554.18986-23-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240621080554.18986-1-philmd@linaro.org>
References: <20240621080554.18986-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Per sections 3.6.1 (SD Bus Protocol) and 7.3.2 (Responses):

  In the CMD line the Most Significant Bit is transmitted first.

Use the stl_be_p() helper to store the value in big-endian.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
RFC because I'm surprised this has been unnoticed for 17 years
(commit a1bb27b1e9 "initial SD card emulation", April 2007).

Cc: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 712fbc0926..601a6908aa 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1498,7 +1498,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             }
 
             sd->state = sd_sendingdata_state;
-            *(uint32_t *) sd->data = sd_wpbits(sd, req.arg);
+            stl_be_p(sd->data, sd_wpbits(sd, req.arg));
             sd->data_start = addr;
             sd->data_offset = 0;
             return sd_r1;
-- 
2.41.0


