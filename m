Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81FE9E6ADCB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 22:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEcVe-0005oa-9f; Fri, 22 Nov 2024 17:52:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tEcVb-0005lu-IB
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 17:52:15 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tEcVa-0003kr-27
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 17:52:15 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21200c749bfso26924435ad.1
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 14:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732315933; x=1732920733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bWdFX19LP1eO2d2hfCa/1XQLyxsvMQu6F75MlNcMwzA=;
 b=MCG3M6ijnne2BfoV+bUy4V25+wchFVhPZI5RE/46493obMv9Z4ETFGqUTiXwwFyq9i
 JOIl6S02dPhhYuOwOCwyumQVfd676oqokDnbzikMHL59zdacI4Gl/DtkbvlipJy+k0Y+
 ARkx4+pFwcPgKafhkRudQ7jWuD/sZ46ggAM1zvFBXyokOnt9UELKVLYLfc7DbTy/xSKT
 6SMNvSwd/3WcI/iGMPts35N55I+LvXClWpZG+LcZtIe+FL2r/xAUryDErmp9V7b4TYBP
 55oT4wiJxyyhavNE0XcqHxT1uA4upUZQjW21qSUciQGb88ZeO0d/eOgjQaPN2gDBwVag
 Li/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732315933; x=1732920733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bWdFX19LP1eO2d2hfCa/1XQLyxsvMQu6F75MlNcMwzA=;
 b=vmlTpp3TwitL5gULa1yuhIhu/a3xogFMrTuCzpVYl9XHCP/zRyZVGCt3jgdnDmDR2u
 P3sld4w3BXMcohk0PQ8s6yNGQOt814qhV8gZDYL2p82sjnamn4c7mcSkDeppsHVf1O5B
 jMf/RjgcPvvoQRLs2mLDou7p/M08UXHaFMCHaHHWGa4BQ9R7TLLOpmQjahTMLwLKnfuQ
 lIZ3yObuc42KjJdXwB/e5QTdBsLA/LGAjWQaMFw6MMTr5KQ1iWaOeEmc8pc/gtc33wub
 Tv3EFL16U/05PicmxHHmcfyCdtkJWF8ApLl8WFKKkleMaTVAQTfIppbkVATQlBhvmpCt
 A3dg==
X-Gm-Message-State: AOJu0Yw+TcQQ8s9m2gOlAgp1oXS0Weozz0DPC3KgXn/pEM0CGHlZ54AR
 Ksh2qd9vfkBxOI59AkEYXFew9V9MGWEwAbjjc6tofcCnEFA5MI+ef135rdqvAo0fZVUcM/TnO/D
 3
X-Gm-Gg: ASbGncsMRowsVqV5NZskpxibDGztW03tSizKWBanPLLzj07VjRq9xfHpeBOqlOiv0Rc
 mq7J/gG1IpmZ0TgkxuzXGWCgyj+rDcpUuht0oO65/9Tk4BW+HhxO3vsUKrzubp3uIjSFysqh+je
 BGbBn+lFo/HJ1fnhkEejhDyMIyZyISZm2sA3nezKZzcM4NKC+F1GNd2cSBxois9uKsdAmfIGK6C
 hSw+nyi1pp5fuLmd5ehHFz5yYWg/twsGEQXnX39ojxZekEePj/aTLYDSrFkwL5wJzdE8PUxEWVj
 ZUyk8cKBxZZLEw==
X-Google-Smtp-Source: AGHT+IFHxlPkXIfpi2NECT/B2lMRj6kiopG/6qpcD/87ID64JCiOua19NjTqI6jGE68bP+p+XbwTbA==
X-Received: by 2002:a17:902:ea03:b0:20c:6bff:fcae with SMTP id
 d9443c01a7336-2129f217f69mr62632455ad.5.1732315932863; 
 Fri, 22 Nov 2024 14:52:12 -0800 (PST)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dc1539fsm21450335ad.192.2024.11.22.14.52.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 14:52:12 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, alex.bennee@linaro.org,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 09/12] docs/system/arm/fby35: document execute-in-place
 property
Date: Fri, 22 Nov 2024 14:50:46 -0800
Message-Id: <20241122225049.1617774-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
References: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/system/arm/fby35.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/docs/system/arm/fby35.rst b/docs/system/arm/fby35.rst
index bf6da6baa2a..ed9faef363c 100644
--- a/docs/system/arm/fby35.rst
+++ b/docs/system/arm/fby35.rst
@@ -45,3 +45,6 @@ process starts.
     $ screen /dev/tty0 # In a separate TMUX pane, terminal window, etc.
     $ screen /dev/tty1
     $ (qemu) c		   # Start the boot process once screen is setup.
+
+This machine model supports emulation of the boot from the CEO flash device by
+setting option ``execute-in-place``.
-- 
2.39.5


