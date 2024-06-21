Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5597DC2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 08:10:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKZIm-00078k-JN; Fri, 21 Jun 2024 04:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZIl-00073p-B1
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:07:19 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZIj-0008T0-9F
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:07:19 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-421cd1e5f93so12978345e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 01:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718957235; x=1719562035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RPBvU4uriaq93lgSEpi40j13P7YTd0f6Hz6KWjEoVBs=;
 b=io9rc+hsFIpk3MIVkYySyNTbnru7F1uJ61uNaeR8Cs003Wnpul4Jdfgwpa0xi1vbDg
 wX94P7452MtDTMr4XttxNHZzehyI72aSGJ5ffuzHwASPLS3dK9ThgWtnbQVv2SoWhYzy
 uT7IEYuAGjV4vxtmJ0wdYggae7XYXI+iX8QG963nxCHfze6Je11EozjWh6/hjMYaqEtX
 8YmnM1KXGqoFm42NIKwm5fwyJ6xsr0Rz3HV4sA8Sfmz6JBZEmM3s+Cr9ltDSYEL6bkR/
 MVU9G2Bsg3oJq5v10cTb9BdILaH2BpsBCc7eQf8Tzv35pJpcKiixglJJ/1jvgot1zYOf
 QqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718957235; x=1719562035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RPBvU4uriaq93lgSEpi40j13P7YTd0f6Hz6KWjEoVBs=;
 b=uKyw15ig9rOD3p8IRQPZMNBLpBtLHKi/W/gK2GWJDM+frJmgnBt8S2kApaOM1SvfGq
 6YlpB/zHL6kbtR0ykfVaw/Tckg+1z9Crs6IqY6I/4vxe8MmLU5I1Khb95HxrOtLZF1ew
 FIA5oAnO2SlbVpMrM3nIk3/xC26A/ZHXKlzHmc9nS+HaT88MFoW0I4P9yRLdI1N37egt
 mOI90nZvgRmVBK8zhI4dzz4gcpzBlXU5d8Ae/JANagNWUNgCHJu4zRevqV62rikhAn+a
 nP8cnEU18aXBHR5kxZGAbDmOiZVESpJuNwuRJ4Qq/xzXB9ZkVZPoSWSVByjJ3DvqIA2D
 pt/A==
X-Gm-Message-State: AOJu0YzEj8pdAE4CvjqjqTC5TDVFezpKoH5v4at0orKS2htLO9137mUX
 WnM+nD3CRpcQDMTUK44jtH9VfmIqPelvxAoIi5BoagI6WaeFYVaQa7Htu65hqeodJ2ummdKiHIM
 2
X-Google-Smtp-Source: AGHT+IHLBSHzLICc5EqZWmuIRKUfUq213U/Ldad1rze3v+cTvRX4eCN3pTHD4FNdwb2pP+8+ETSVOQ==
X-Received: by 2002:a05:600c:4aa9:b0:421:f88f:4ec3 with SMTP id
 5b1f17b1804b1-42475178817mr55522395e9.14.1718957235533; 
 Fri, 21 Jun 2024 01:07:15 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.128.209])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4248179d3basm17504175e9.4.2024.06.21.01.07.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Jun 2024 01:07:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org
Subject: [PATCH 13/23] hw/sd/sdcard: Have cmd_valid_while_locked() return a
 boolean value
Date: Fri, 21 Jun 2024 10:05:44 +0200
Message-ID: <20240621080554.18986-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240621080554.18986-1-philmd@linaro.org>
References: <20240621080554.18986-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index c6cc1bab11..510784fc82 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1716,7 +1716,7 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     return sd_illegal;
 }
 
-static int cmd_valid_while_locked(SDState *sd, const uint8_t cmd)
+static bool cmd_valid_while_locked(SDState *sd, unsigned cmd)
 {
     /* Valid commands in locked state:
      * basic class (0)
@@ -1730,7 +1730,7 @@ static int cmd_valid_while_locked(SDState *sd, const uint8_t cmd)
         return cmd == 41 || cmd == 42;
     }
     if (cmd == 16 || cmd == 55) {
-        return 1;
+        return true;
     }
     return sd_cmd_class[cmd] == 0 || sd_cmd_class[cmd] == 7;
 }
-- 
2.41.0


