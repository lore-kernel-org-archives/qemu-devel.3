Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDFAC25B4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 17:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4lNT-0001xe-IK; Wed, 08 May 2024 13:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lNN-0001TV-HD
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:46:46 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lNE-000876-Gk
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:46:44 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a59a934ad50so113566b.1
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 10:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715190394; x=1715795194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UguGimYqXuNIuHMxRKx653I2XHRjMEXQECfBmO+9eUw=;
 b=q8efY3QMXs25FXLKsppBbPa2djKXFG5ByUiMOaQXT/ESMULOflOeP+WR8911QbBznO
 FOsZegF4DRhiHK7KeoAP+QJU81IT4UOmz0KRZX/IopgQ9VOG0Qy1hg3vrLNYOaM7eJEc
 7olBm5iU1rcchtlCF73SUJuY5uP/tORlsepElrdAgn+Dsyy2DIBydQ5AHUzVZ8K2pWwx
 o5JuzMm3CK68n/Hjy64vExAciJ881otBY6sD3Mk5V8M4Hoi2wLH0/St5tCVhfWwStMl6
 Nz1yHfQx36CQ5WmfD4E6RTRRgYVJlX16YwVvpLAsXqkP0sxnc4gWYJuG11/bdWzShKo1
 W9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715190394; x=1715795194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UguGimYqXuNIuHMxRKx653I2XHRjMEXQECfBmO+9eUw=;
 b=IlpbIO0NOT07pG+DZBIY0yEdNbY6yDR4FwiZx8N7KBt7hVwLYoQ6WxI0hbzJY1ZTGb
 BTcxS8Rjz/kvAzdAMDJEBisVO6Dk2WRtvhX13x805xRp09k2VEa7bNFkPnr9QcaN/QsW
 bzG3mWbzrpISKunx0loT5Ouzf93WpsoudRnUNIMZB1u+0vo3P8E7JkUkWWWqKcMUiUps
 cC8uDqEcbzJylVFKxTwLUkEkCI5s1MC6IPfEZgK69zxzNVmKu96PqnnSiuxCDjTY2P+j
 BBMor46T6mckPwWIw2EEgK+02jyL9R/WB8MzjFj0kPKpleiAo+5gNPGyYUr9tMfftVue
 8xXw==
X-Gm-Message-State: AOJu0Yy8XP6k+w/NmvArtOZkUngU/ANYtL9xC91kYqECvcq+PKLI2X+F
 2bjEvL3f0dv9ou6VBpFyAlqmyqD02y683go/ogB1xPMkgp4Nk1bjLyQHaEaf4O3dpMaHAQSZxX7
 R
X-Google-Smtp-Source: AGHT+IEX6zS0qic8kWg5idSPUkKP4U54IrN4JAowE1MbNU7WvOdTbl8WPNceJXBC3JETVObmoKt1Ag==
X-Received: by 2002:a17:906:509:b0:a59:c23d:85d8 with SMTP id
 a640c23a62f3a-a59fb9cf5admr212341566b.51.1715190394578; 
 Wed, 08 May 2024 10:46:34 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 q21-20020a170906a09500b00a59f9ecfc36sm1473501ejy.114.2024.05.08.10.46.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 May 2024 10:46:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 15/26] hw/usb/dev-network: Remove unused struct
 'rndis_config_parameter'
Date: Wed,  8 May 2024 19:44:59 +0200
Message-ID: <20240508174510.60470-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240508174510.60470-1-philmd@linaro.org>
References: <20240508174510.60470-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

As far as I can tell it was never used.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240505171444.333302-5-dave@treblig.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/usb/dev-network.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/hw/usb/dev-network.c b/hw/usb/dev-network.c
index 2c33e36cad..d00d68b21d 100644
--- a/hw/usb/dev-network.c
+++ b/hw/usb/dev-network.c
@@ -475,14 +475,6 @@ struct rndis_packet_msg_type {
     le32 Reserved;
 };
 
-struct rndis_config_parameter {
-    le32 ParameterNameOffset;
-    le32 ParameterNameLength;
-    le32 ParameterType;
-    le32 ParameterValueOffset;
-    le32 ParameterValueLength;
-};
-
 /* implementation specific */
 enum rndis_state
 {
-- 
2.41.0


