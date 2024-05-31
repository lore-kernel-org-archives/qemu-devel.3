Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F6ABC25B7E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:10:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD0zl-0004Pp-BV; Fri, 31 May 2024 08:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0za-0004Jq-2j
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:18 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zU-0003PF-92
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:17 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-421208c97a2so18830145e9.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 05:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717157047; x=1717761847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s1KF1phiJhFDe0oGBJkmkCzxz1jQ8QxxTLgSJBNbF0Y=;
 b=ndkMRV1hRUDEeC4rcRW2mn7i1ryMTq5R6zNVilKKu7p7yWmZiu/Do6BSRWjKUc/3EY
 hPGDy0NAGaWTrE5aYp10VJlih8z1HLi0/CgZn/Q8I4h1i0bONGblGbzF8fi+MKN53gXH
 3ATEt6j1swRMu8YfDZvCxyhB3BYv+CxnrS7APihCR1Ru0bGjqFX4QPlBE3QeW1QhJoOi
 MX7haCEZipimJ0NLrKDo5PaMiyFaRn78P0UcU+IyvggY7PjwgBnLh6NKOzff0Y/srthF
 2k0AryZulxGtYxLux1zQk6GBbrkjfaOdNCUNz/3eIdZqp4sO0PH74e1nJMpnhuVdQf2a
 wrnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717157047; x=1717761847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s1KF1phiJhFDe0oGBJkmkCzxz1jQ8QxxTLgSJBNbF0Y=;
 b=wM2j9IjF9vfEvkkNmZrDcb64Kf5aPSQmi+ItreOWBvAVZsLPrIHOrqRuifYhEyWFKz
 QUh31EDipwRe0MQYtKe9HhUD+IS4aC2JG4l+nqfXIvREo+VD0H6j43M0QGMsWb5PCdhP
 KK6R/AyAM0V6caOMH/aIlGLr0KVR84qtF95+F5dcxGH+pSBT2IuOWPnf45r1aa5We5PY
 eXVg77c1neuv8q57XhQCGtq2UQ8qqFt9itOWapA9oKegubr3kw99mWe5SD3L41XuVGlL
 eArDr2gPXlZWM1zGySXRnTePzehx6rs5it5TYlU8PPbbnEa0ebh7E15GNFWtHkGIt7D9
 NCJA==
X-Gm-Message-State: AOJu0YwDafKMIRC+1U0Vrq7w0l+6JeYeI7cl0vrgXLOFuIKTFS6xUGHa
 xs3wTb32zkoxN9gwH+DNhGAwvSlYevuISuwNdrhfRTBheyEp8sDlAxrQ36Bex+kxgyzLdZY+9l3
 u
X-Google-Smtp-Source: AGHT+IGWBrCDCsPsXYUXi9DPg6RD8S7Qz3jhmRrLoMDTGN8VmbbPrCZCO97B8k4nEFsRcpAA3nVizg==
X-Received: by 2002:a05:600c:1550:b0:420:1fd2:e611 with SMTP id
 5b1f17b1804b1-4212e0adf98mr13844945e9.27.1717157047589; 
 Fri, 31 May 2024 05:04:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42129de0cf9sm37027685e9.13.2024.05.31.05.04.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 05:04:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/43] arm/sbsa-ref: move to Neoverse-N2 as default
Date: Fri, 31 May 2024 13:03:24 +0100
Message-Id: <20240531120401.394550-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531120401.394550-1-peter.maydell@linaro.org>
References: <20240531120401.394550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

Moving to Neoverse-N2 gives us several cpu features to use for expanding
our platform:

- branch target identification
- pointer authentication
- RME for confidential computing
- RNG for EFI_PROTOCOL_RNG
- SVE being enabled by default

We do not go for "max" as default to have stable set of features enabled
by default. It is still supported and can be selected with "--cpu"
argument.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Reviewed-by: Leif Lindholm <quic_llindhol@quicinc.com>
Message-id: 20240523165353.6547-1-marcin.juszkiewicz@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/sbsa-ref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 57c337fd92a..e884692f07f 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -891,7 +891,7 @@ static void sbsa_ref_class_init(ObjectClass *oc, void *data)
 
     mc->init = sbsa_ref_init;
     mc->desc = "QEMU 'SBSA Reference' ARM Virtual Machine";
-    mc->default_cpu_type = ARM_CPU_TYPE_NAME("neoverse-n1");
+    mc->default_cpu_type = ARM_CPU_TYPE_NAME("neoverse-n2");
     mc->valid_cpu_types = valid_cpu_types;
     mc->max_cpus = 512;
     mc->pci_allow_0_address = true;
-- 
2.34.1


