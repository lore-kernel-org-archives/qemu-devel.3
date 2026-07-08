Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BECFC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 14:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whTjk-0003RU-0G; Wed, 08 Jul 2026 10:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whTjf-0003Ep-RU
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:58:51 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whTjb-0002ya-Jj
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:58:51 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-493e497643fso4297215e9.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 07:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783522724; x=1784127524; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2SgQi+SyDWBKaYIdvei/39yWmxtcCRPqGOS+LJ8AMqc=;
 b=SkyddEcVO7ixL80Vlx8xyDVyNTM1Vrl2MwXollwWvB70Wuqs7/a63O+o3o81Jgc0m2
 U/jca2JTB+el8IeEQl4PEvO0W83gdLUGKBYSJv/y3VtUpxVUz401XCXhG3MMd1DZ1jq9
 ph7CRLq3YpPGlgtYFwaQZCWxJ/sckDSQl+35+tp4JtcB0AI2GSz7wyheMzijwcv1HrJF
 4W1LIMrwtuHQdJbVWHK+DRgK34bJRkGG5C73MFA7YLnRIFusJ1soRgsguvdyjoKj1GtY
 B0YvBxu+/FC7Ieh5dOS39SKgGaAsx+Q9O/zBCo2aqPzUgbZmobeirlHp2zIV5uLhipRl
 5wlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783522724; x=1784127524;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2SgQi+SyDWBKaYIdvei/39yWmxtcCRPqGOS+LJ8AMqc=;
 b=jBP6P9MV32UdV4IovpzF5vzZJF8w9Sq29CnmnSusjPT7ChVgTtxH9AgDb1SwNBzRA9
 +f1EmFkTwvTbwDx9HIz+pakxf0t9lWrZtFa+NE60gGtJd+BDPHJCZ/WeNT73OeZ/y0y1
 Exvx/vsD+jpvjSZDljHFzbLkIzaAj/ZBRQY/H+FreKoYeeAMfP9SWUvVLFfEyxSmUtV/
 1ozfKb2c3Uxgsjdw7qjqDsvACxSw+rCekw9d4mO1ZcUs+LwyI03E94k1Jt1U2Ui89GF1
 CuF0Xnc0ZwdTQ17lnJYTg9cAvputKWHNs5n9SVvVpkstz4rBKaFi1qbuYBpaja1Pa/qd
 h83g==
X-Gm-Message-State: AOJu0YwN0vOw4CxxK4siNNpT5Fse84sXWkhV/x+mLOArhZZaFPdrwCks
 GQPOIPnc48v/Sk2201KiqtOBEySE08P+FF0dwTQI2RYL8efZexR0AXndrHs2+KQIvx4=
X-Gm-Gg: AfdE7clozDbfEeKyaUK1lXaWBgdHwuENQFpqyM0SRY/rgjx3HSE6xMzR7gFXCHom6GE
 x2iCXXh7M4NTUE4BbztocEp4zuc93wO2jg3ngsD87hnTbUQFAWIPj9e/A3356ZU6OsuqImdZBx7
 Lh3jEuqYkcH8cwktCvOf5DFtJ5YP9xIVr8/Ty4HrjIAu9yNbS54BmFPBWTYURngHG21kgjje1cZ
 GE3+b40vRdb5IpnHBnFzn09JEimImCFXY3boCty+3dnoDZN6yxGKgl97lYeAo92Arg/1gvRzIWr
 vXoNY5H903+Dm1Lyg0qnIIUcmx1mWgjCAZcfwhxYmrbCG3uIpErlMHcfJsKOEMVB0FXOZ7m6aAE
 p99NWp/ElZLhk4RHjQX+/oXOmUKgm8DpnY51bue9EbJHxAVcBH5q0B8x8FcDKQBC1Qj+v3PUMAd
 puHZVPINZ+Yicp
X-Received: by 2002:a05:600c:3492:b0:493:bc4a:c6b4 with SMTP id
 5b1f17b1804b1-493e68dcf20mr28089455e9.38.1783522724464; 
 Wed, 08 Jul 2026 07:58:44 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e10af392sm151962415e9.2.2026.07.08.07.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 07:58:42 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 053E46003E;
 Wed, 08 Jul 2026 15:58:42 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 2/8] docs/system: add big and little endian features names
Date: Wed,  8 Jul 2026 15:58:35 +0100
Message-ID: <20260708145841.3032079-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708145841.3032079-1-alex.bennee@linaro.org>
References: <20260708145841.3032079-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

We've always supported these features but they have official feature
names in the Arm ARM now so we should declare them for completeness.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/system/arm/emulation.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index fb8d263db49..d19b6c04429 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -31,6 +31,8 @@ the following architecture extensions:
 - FEAT_BBML1 (Translation table break-before-make level 1)
 - FEAT_BBML2 (Translation table break-before-make level 2)
 - FEAT_BF16 (AArch64 BFloat16 instructions)
+- FEAT_BigEnd (Support for big-endian at EL1 and above)
+- FEAT_BigEndEL0 (Support for big-endian at EL0)
 - FEAT_BTI (Branch Target Identification)
 - FEAT_CCIDX (Extended cache index)
 - FEAT_CHK (Check Feature Status)
@@ -103,6 +105,8 @@ the following architecture extensions:
 - FEAT_IDST (ID space trap handling)
 - FEAT_IESB (Implicit error synchronization event)
 - FEAT_JSCVT (JavaScript conversion instructions)
+- FEAT_LittleEnd (Support for little-endian at EL1 and above)
+- FEAT_LittleEndEL0 (Support for little-endian at EL0)
 - FEAT_LOR (Limited ordering regions)
 - FEAT_LPA (Large Physical Address space)
 - FEAT_LPA2 (Large Physical and virtual Address space v2)
-- 
2.47.3


