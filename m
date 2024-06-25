Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96ED7C30659
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 05:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLz8U-0001ha-WF; Tue, 25 Jun 2024 01:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLz8U-0001hP-9N
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:54:34 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLz8S-0001d3-Pv
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:54:34 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-366edce6493so1544176f8f.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 22:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719294871; x=1719899671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ee/yL80E0AWtVNbCxQaoN9WZIZ5QGojNiR7WBNpSOHo=;
 b=XzBJdxLrNJSWQg8q1FGJcRJsNq+nwT/g8qQpaxeyOM+4Xjkplyex/5elNlXI5rjsVc
 GJxpQN4ldxDvDcttUD2RlYk2PuvmnWSe3BnEbnP8+hHeCWApT+6uWhan6t0Lw4fF+Ja5
 NA17v22c0eslrn6qTl3YE5m3o6VQdCFn1BO4dTmUuIS8/wkfpazXRBTLZWN70GfUeFXa
 feqCpq7TkSEsy58sexDd0wFyuhMfXvCPo9Af2uUbrAvblkSNjaCqy3/c3SbEDkCc818t
 vN6xGFZfasLRZZFquGSJrEAHTg2mx/+Y+zzXnEI/GDVf2KiuZ3XcxKD5h8zQdwwArwJy
 a7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719294871; x=1719899671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ee/yL80E0AWtVNbCxQaoN9WZIZ5QGojNiR7WBNpSOHo=;
 b=sJWNQNIOGmT0duw3bhGh5fcuJuabfbLCYEQnI6awpl6C2tJvg48/yns6kfLlo8GIyC
 nUdN6uR/BjVxht5vEKPzbm3buNE3+inULvksSrD6kjzYS5ii0EvVMNEJXwM4NNX3rI/T
 fCPNL+Q67cEk9SqYkd3mGvOsrUJsEUUuEq5KosU/b7565WiwhNlFHRS2yoWdmDZ4lF/v
 wyOZoOVdGApkEwZKi6rO12iQUf7W/2HkJG42P/GOdywAH2oD50dI2qvA6EoIEZFpJyfQ
 JnY+bSlbSMwrWoDzOhVaLigu4JRX9CygUbxW/k7FKOSX7OCb+5Vlr40bW+XRoa24eSVK
 H3Dg==
X-Gm-Message-State: AOJu0YxJ2yCmy0DDAU8Cp3B6/3+QTcNJ/x/8u34f1n12fno2JCIjXoos
 IKTHJOunN9NvPyKQA2PVxkV684r7rc3eve0ul0vjU296EyKkku2sDRe1sjxtb0kF3dEYJulciWr
 I
X-Google-Smtp-Source: AGHT+IHaxOnTR0qfrHvwJsYldlxw76lZ/cNtNe0hLV2cTKCz/mmcrh/siw2jO+8amfctlOBdlevAvg==
X-Received: by 2002:a05:6000:178a:b0:360:7092:728 with SMTP id
 ffacd0b85a97d-366e95ddf7cmr5466388f8f.55.1719294871034; 
 Mon, 24 Jun 2024 22:54:31 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367003b1fc8sm846275f8f.57.2024.06.24.22.54.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 22:54:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 06/12] hw/sd/sdcard: Send WRITE_PROT bits MSB first (CMD30)
Date: Tue, 25 Jun 2024 07:53:47 +0200
Message-ID: <20240625055354.23273-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240625055354.23273-1-philmd@linaro.org>
References: <20240625055354.23273-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Per sections 3.6.1 (SD Bus Protocol) and 7.3.2 (Responses):

  In the CMD line the Most Significant Bit is transmitted first.

Use the stl_be_p() helper to store the value in big-endian.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
---
RFC because I'm surprised this has been unnoticed for 17 years
(commit a1bb27b1e9 "initial SD card emulation", April 2007).

Cc: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 0f8440efcc..b604b8e71f 100644
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


