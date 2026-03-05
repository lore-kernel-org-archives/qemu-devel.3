Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3212F513E1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 22:11:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyGsv-000124-9b; Thu, 05 Mar 2026 17:09:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vyGsn-0000zK-DR
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:09:25 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vyGsk-0002D5-KX
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:09:24 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso71410635e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 14:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772748560; x=1773353360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UyEy/g1PEDGl9OT2R7W8yjv5uTeT+1EIBQ0lv6lijmM=;
 b=fdim6hrI3t17YZ2DdIjHL5Hml9aWGFOBGmgjkRXdiGOBc+ANX73CqjMjQudUPoX2Ue
 fh3RWgEP5HNOGLxlhAM7xR2HVc5K1SfhKB/kLOqWUm0agDRUqlMB0aJ2lTfr/yzpS+7r
 CY7J3W7cdlZMR6oD8oxVjhY/GhItYgu2UIifom1vb6oxm7lOk/jt+xUJ6eElvNv1TH1M
 bM+4DRGWZ2Gh8yxT/K4edZPtxSPwXJ6k+5N3ELvmBvrqdMulkiAuiwQgtjzEREko1mt5
 Qkr+4BoVS3h8cZR0oe8WHZuTdICXdz2ZfNOQFa78Qe2tdt8Htjfi2B+RmwbTdRCUY8df
 U+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772748560; x=1773353360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UyEy/g1PEDGl9OT2R7W8yjv5uTeT+1EIBQ0lv6lijmM=;
 b=LUNyXIPoG7BKEc7912KUeLEXEqV8SwVjK508xClnAOCyG4h7FN5dHWWMAmIpozaKOl
 ys0PMQ8bAe9X8I5vk0N4V0++T9a/2zsTlSI1hTBGUdt/xEX8cjXmiFZB/OYIPUbQGeAn
 Xzka0X+cqZeqitTAIExPLgCWsxbJUVKBrbvYF5p49qCNy2/V57zKUEjYhrlNjdtPVK6Q
 OgqAHev9SDOhpYj2pPTINpaBcXIKiqEA/6n+MZU8UJaF06dWsX4VZxRz0nzZKnpYrrnw
 Ppi8dWDOvVWJZXFw1+ij4PXBX4dHNWV32wb+zhhkBGh2Mbr+1nFA5HnEPk+C6JXWDUMy
 9jkQ==
X-Gm-Message-State: AOJu0Yz4rn0V2svEew1B5UsB0L9N5szL7eJL0EY/q9L3hy/cCihRPcRp
 N67hmODdIjZutJQ5eAywcg2Wy2cVI49PSZHbdaH+gs+3KBCtv0JTKLl1/x7QGA==
X-Gm-Gg: ATEYQzxH7HRxaHNCrb4Vki4/7+2IY5+GCgaF8G6hORKJlFDc2MyvpkXFELhwyJ7OFbE
 FHScsvE/n6m531eDHAFBWFzdBSotcLh+B8QXH0S+C6B39SvGx3hYu9uYY3rQuzc+Ls0N2mggo72
 A+diRUSxNtm8iCwJ6zlse0Wvj++CAzQM+VcwfcanyTE9auMYz7WTabCtMkTPQA++hnyBw+lCrrZ
 876PKL5ZmQO2dTTcZhX7P5mmLq9jK7wcBFoPWL/erktAEr17p7S+3siqqhmHkk0K8W6gB529GGg
 rdcFY3Xw7+Jr+v0R3ib3P+2sNI++InHUNmY9yD23/KY4R/1oit8CyWr98GFAzHhaROZ7bSS8uQC
 /3WJWzN9maDqqb1/qMKACds2I6lzOhw8QpsWHJqJbr6j20krz4iWNXSfiRTZZch2eCGwTF1G+nh
 CWGbtjULArhtKUHDzkT4TGFZUNQ/AEIBiP666Gh6QAo9Qn/JevVK8a5AmRzIqbfo4/FMbi3I5ca
 00tXsVHv1ISbSB0Y6vVjriX/iBFp6rg+qC75r4dWAChYdE=
X-Received: by 2002:a05:600c:34c8:b0:47d:8479:78d5 with SMTP id
 5b1f17b1804b1-48523592d6amr17649355e9.7.1772748560440; 
 Thu, 05 Mar 2026 14:09:20 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-2a02-3100-2989-c400-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2989:c400:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fa87e56sm67419615e9.0.2026.03.05.14.09.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 14:09:20 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Troy Lee <leetroy@gmail.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org,
 Helge Deller <deller@gmx.de>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 01/14] hw/arm/Kconfig: Fix serial selection for NPCM8XX
Date: Thu,  5 Mar 2026 23:08:58 +0100
Message-ID: <20260305220911.131508-2-shentey@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305220911.131508-1-shentey@gmail.com>
References: <20260305220911.131508-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

CONFIG_SERIAL selects the internal TYPE_SERIAL device which is akin to
an "IP block" that needs to be integrated with glue logic. In case of
NPCM8XX this glue logic is TYPE_SERIAL_MM which the code uses already.
Fix Kconfig to select CONFIG_SERIAL_MM which matches TYPE_SERIAL_MM.

Fixes: ae0c4d1a1290 ("hw/arm: Add NPCM8XX SoC")
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index c66c452737..20e99e52b1 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -493,7 +493,7 @@ config NPCM8XX
     select SMBUS
     select PL310  # cache controller
     select NPCM7XX
-    select SERIAL
+    select SERIAL_MM
     select SSI
     select UNIMP
 
-- 
2.53.0


