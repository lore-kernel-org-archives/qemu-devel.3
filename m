Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A38D148A4
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 14:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdr6B-0007D1-8V; Thu, 08 Jan 2026 09:34:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vdr5w-000729-V9
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 09:34:38 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vdr5t-0000iS-Kd
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 09:34:35 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47d493a9b96so19642295e9.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 06:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767882871; x=1768487671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NNPkfTC8hSB2O54A92j5y8SEHslcucm7cyY4HjTcIuM=;
 b=T7AxQwtwC8nruwByO5sWdmGorgWfAgoaf+r+R6vQbZt/i14b2rgNYsuwCcJYCnWRT9
 HytQzCigVx3LXpCtQK/eY+2R222cu+WAAlJxlp3Fxdr4Rfl+77RbNyUeyIqzSz+6At2D
 +AMfhC3RtGB8Rexu+YMgBaPWLHI+7Hu4cUo7eLY3vNmGpXifDVPQjIS42LlrfL5hzxoT
 K0BOgyVyfPQnD5OMXA95+AqGnzC/3VQiCV5IeVzPEuYDS7SkEA+RQYlUci1STyuXYIDT
 1ZeQTWGVxEOf0iJ2m3o63oGXdh84+S4Dv2UPIP062YRmD0ZhZuWitXjPetTbqVihjpR8
 7t+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767882871; x=1768487671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NNPkfTC8hSB2O54A92j5y8SEHslcucm7cyY4HjTcIuM=;
 b=jAReXz/qdFxXz44yTK+nOxdbPttcdVtIagvywWDNWX3IHxGtqz8dDtgZQCygWrtglL
 mecgVoN+AlMZlB8owIPTRaCrJ2XiN4NNl/xhliYPt55Hyq1KbTI5e5bizNgof2ptPDEe
 wBq2yc0MHEjfnPq4x39mV32veubDTCSLV8q9OJfA4r+L2ogerjAryO8bQ/TIcycaqdrl
 L2AE8Gs+/N9LebfErf67BHU/KJB3X+I2To2M7lY8Zz4y8XkKeAXQFlbJ3GwXwR7JDkar
 +mFhgRm7QfqT5c3pUO7GqwyS2Vy5WU5jjG7FN3PraqB9c+yVC7w+RZKkAvtKT8SyCCei
 Dibw==
X-Gm-Message-State: AOJu0YyyLMmxApCfZqHGQ0mUZaxdDk3HfBapcD0RXioqH4BP0wM57yZ0
 LAEqZ+jwcGSw196WHXs86a6PPK3/GFGcExAIgnnVEr8G1NZZHNvEu1l3Xkv+agnQp2k=
X-Gm-Gg: AY/fxX4sGqe7FU7MZzOJxdzedF6LAVI1okfT3SJrzHSKbEmbd6NOCQR1qBbEhJ/JZr2
 Ce5JfH1wDYxHJH5zdQRzNu2WseiS7eEwiaRcDNLEvBV2L7no93K3MsvebqcQ83Jr+R6sKCbknnw
 HyFo13S0J3CclhQWnb4rsE+5p8BQjbgt9BG12kgnw0H4enIZTgLwyO3nI+3P4ifywfcXF+eeleW
 fgvw4C1qhl2BoUTgCWt0fisf0Ez49duqTT8Aw7h8ioWS00q2qGiSnkR+8JYWFL7NHEXMnzoguQV
 eFDyJT9GWNTUjQKa2G77ku/j8LGGmDs3rbZUXE3p4DBHXPl1T9RPFsiW18WbDUzz2SqzaULoRW7
 nBXmZbs69m0AqAYJ+RulgcNwC+N2TB0B75vAB4UC97usoHw3o5mKwAbpanVzjrYnZnRc6sWGVR+
 WwcEYazLogPW1dNp8T1lUYVg==
X-Google-Smtp-Source: AGHT+IGCbmw18fNIwlDNBzWCAdNHDFbb56mz7vbgowQfcwqwBe7oDhevb+s+QGfjbElOCftQfjfsMA==
X-Received: by 2002:a05:600c:1385:b0:47a:94fc:d057 with SMTP id
 5b1f17b1804b1-47d84b0b0e7mr68176435e9.2.1767882871357; 
 Thu, 08 Jan 2026 06:34:31 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d8715b5f7sm40785975e9.4.2026.01.08.06.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 06:34:27 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id ECC525F8D1;
 Thu, 08 Jan 2026 14:34:23 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Yanan Wang <wangyanan55@huawei.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Thomas Huth <huth@tuxfamily.org>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 01/12] target/sh4: drop cpu_reset from realizefn
Date: Thu,  8 Jan 2026 14:34:12 +0000
Message-ID: <20260108143423.1378674-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108143423.1378674-1-alex.bennee@linaro.org>
References: <20260108143423.1378674-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/sh4/cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 21ccb86df48..1dd21ad9ed6 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -255,7 +255,6 @@ static void superh_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    cpu_reset(cs);
     qemu_init_vcpu(cs);
 
     scc->parent_realize(dev, errp);
-- 
2.47.3


