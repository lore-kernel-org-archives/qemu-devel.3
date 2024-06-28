Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B076CC3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:03:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5cw-0008QU-BQ; Fri, 28 Jun 2024 03:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5cu-0008QC-PY
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:02:32 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5ct-0006ba-7D
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:02:32 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4255fc43f1cso1816605e9.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558149; x=1720162949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q0dLi7LJeAuLomgAe/dqexun4vtTcne+GTOKHsnzMSk=;
 b=tttvOkKkM0YNKxITtkKYISKHX3E3Pi2s6ZpEMes4nr6WsuEDNHAmcXZY41JRAEk/d8
 JhM9g+JGdV0ULkGnR/+doLG5/ab8uwrdHeNkCfA0r+9hg1NP2FANSn1lPmSmk94edSaG
 3OkzHlD24wkWNL+CGb1LMcq4xqkc6PsjzM8A2MoL48XYgbSZbYQnynduGIk8sCsrkSbJ
 pFR+R9ARKUyjOJUKw1BRa4moWfkJQ4V597TwdsjO8FFRLr1OvN8H7+DalUbyuc8YR1SZ
 FrLLHYfo9ycr6q/mdPK+U8X8hMYdFvcVn6ayGjP+dt1KyxSwgbMhUSokvYUK8TvfKTot
 5U9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558149; x=1720162949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q0dLi7LJeAuLomgAe/dqexun4vtTcne+GTOKHsnzMSk=;
 b=A7lJuPUf9cTcEIlsi6s1xbG9HSHitVtyRhS9hXrYVwNleBEIU0wkVE69uVObBSsl9u
 Blzzdf8M1bwOibuvBzxzjfr1+Kr7lp5k1tqVvWQN44s8Smv1UkZF3Ke5SFBumCqB9rx5
 R+qIEnTv4BiMQ14M71GHdrWYo1Hr49wRWwLnLL094ThWGxP988EowrcjMycMOWHCBxDk
 FhcLYChRCsRrrTe7wXLMIcP01FSm3clXX43ut0mt0tKqLaTEO5qWv1DZ6jgUSdF+IV6u
 jUZ/oh6Udtkj//EHtwP3Xh40Js0++0azoUsWMqYdSHuIRwGH2fcYmmh0nqwasGet2dXN
 ta/w==
X-Gm-Message-State: AOJu0YwJiEreABIAjxGa/ed8762yBKHh/SjVEfSKLvcKC7jFyhDqBWBX
 e03FLoyQjKe4v9WcLIQll0Y22QaICvXl9OtWiykX/e952bMJUjgDWwXeoEXM75GZGyq8isG/cFV
 XROc=
X-Google-Smtp-Source: AGHT+IGXD9OZuz5w3RKMFasHKcwLJb01Q46GuqbG/ClsnEsogeNt9Dsc6powhrgUxoxW9tn5owf5gQ==
X-Received: by 2002:a05:600c:470d:b0:422:7eca:db41 with SMTP id
 5b1f17b1804b1-4248cc18101mr123481815e9.2.1719558149429; 
 Fri, 28 Jun 2024 00:02:29 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424a2abc2desm95968775e9.1.2024.06.28.00.02.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:02:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 02/98] hw/sd/sdcard: Use spec v3.01 by default
Date: Fri, 28 Jun 2024 09:00:38 +0200
Message-ID: <20240628070216.92609-3-philmd@linaro.org>
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

Recent SDHCI expect cards to support the v3.01 spec
to negociate lower I/O voltage. Select it by default.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/sd/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index a48010cfc1..d0a1d5db18 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2280,7 +2280,7 @@ static void sd_realize(DeviceState *dev, Error **errp)
 
 static Property sd_properties[] = {
     DEFINE_PROP_UINT8("spec_version", SDState,
-                      spec_version, SD_PHY_SPECv2_00_VERS),
+                      spec_version, SD_PHY_SPECv3_01_VERS),
     DEFINE_PROP_DRIVE("drive", SDState, blk),
     /* We do not model the chip select pin, so allow the board to select
      * whether card should be in SSI or MMC/SD mode.  It is also up to the
-- 
2.41.0


